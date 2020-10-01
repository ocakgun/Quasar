package ifu
import lib._
import chisel3.{util, _}
import chisel3.util._

class el2_ifu_ic_mem extends Module with param{
  val io = IO(new Bundle{
    val clk_override = Input(Bool())
    val dec_tlu_core_ecc_disable = Input(Bool())
    val ic_rw_addr = Input(UInt(31.W))
    val ic_wr_en = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_rd_en = Input(Bool())
    val ic_debug_addr = Input(UInt((ICACHE_INDEX_HI-3).W))
    val ic_debug_rd_en = Input(Bool())
    val ic_debug_wr_en = Input(Bool())
    val ic_debug_tag_array = Input(Bool())
    val ic_debug_way = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_premux_data = Input(UInt(64.W))
    val ic_sel_premux_data = Input(Bool())
    val ic_wr_data = Vec(ICACHE_BANKS_WAY, Input(UInt(71.W)))
    val ic_rd_data = Output(UInt(64.W))
    val ic_debug_rd_data = Output(UInt(71.W))
    val ictag_debug_rd_data = Output(UInt(26.W))
    val ic_debug_wr_data = Input(UInt(71.W))
    val ic_eccerr = Output(UInt(ICACHE_BANKS_WAY.W))
    val ic_parerr = Output(UInt(ICACHE_BANKS_WAY.W))
    val ic_tag_valid = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_rd_hit = Output(UInt(ICACHE_NUM_WAYS.W))
    val ic_tag_perr = Output(Bool())
    val scan_mode = Input(Bool())
  })
  io.ic_tag_perr := 0.U
  io.ic_rd_hit := 0.U
  io.ic_parerr := 0.U
  io.ic_eccerr := 0.U
  io.ictag_debug_rd_data := 0.U
  io.ic_debug_rd_data := 0.U
  io.ic_rd_data := 0.U
  //val icache_tag = Module(new kncpa)
}

/////////// ICACHE TAG
class EL2_IC_TAG extends Module with el2_lib with param {
  val io = IO(new Bundle{
    val clk = Input(Bool())
    val rst_l = Input(Bool())
    val clk_override = Input(Bool())
    val dec_tlu_core_ecc_disable = Input(Bool())
    val ic_rw_addr = Input(UInt(32.W))  // TODO : In SV we have 31:3 what should we do here
    val ic_wr_en = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_tag_valid = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_rd_en = Input(Bool())
    val ic_debug_addr = Input(UInt((ICACHE_INDEX_HI+1).W))
    val ic_debug_rd_en = Input(Bool())
    val ic_debug_wr_en = Input(Bool())
    val ic_debug_tag_array = Input(Bool())
    val ic_debug_way = Input(UInt(ICACHE_NUM_WAYS.W))
    val ictag_debug_rd_data = Output(UInt(26.W))
    val ic_debug_wr_data = Input(UInt(71.W))
    val ic_rd_hit = Output(UInt(ICACHE_NUM_WAYS.W))
    val ic_tag_perr = Output(Bool())
    val scan_mode = Input(Bool())

  })

  val ic_tag_wren = io.ic_wr_en & repl(ICACHE_NUM_WAYS, io.ic_rw_addr(ICACHE_BEAT_ADDR_HI,4)===
    repl(ICACHE_NUM_WAYS-1, 1.U))
  val ic_debug_rd_way_en = Fill(ICACHE_NUM_WAYS, io.ic_debug_rd_en & io.ic_debug_tag_array) & io.ic_debug_way
  val ic_debug_wr_way_en = repl(ICACHE_NUM_WAYS, io.ic_debug_wr_en & io.ic_debug_tag_array) & io.ic_debug_way
  val ic_tag_clken = repl(ICACHE_NUM_WAYS,io.ic_rd_en | io.clk_override) | io.ic_wr_en | ic_debug_wr_way_en |
    ic_debug_rd_way_en
  val ic_rd_en_ff = RegNext(io.ic_rd_en, init=0.U)
  val ic_rw_addr_ff = RegNext(io.ic_rw_addr, init=0.U)
  val PAD_BITS = 21 - (32 - ICACHE_TAG_LO)
  val ic_tag_wren_q = ic_tag_wren | ic_debug_wr_way_en
  val ic_tag_ecc = Wire(UInt(7.W))
  val ic_tag_wr_data = Wire(UInt(26.W))
  val ic_tag_parity = Wire(UInt(1.W))
  ic_tag_ecc := 0.U
  ic_tag_wr_data := 0.U
  ic_tag_parity := 0.U
  when((ICACHE_TAG_LO == 11).B){
      when(ICACHE_ECC.B){
      ic_tag_ecc := rvecc_encode(Cat(repl(ICACHE_TAG_LO,0.U) , io.ic_rw_addr(31,ICACHE_TAG_LO)))
      ic_tag_wr_data := Mux(io.ic_debug_wr_en & io.ic_debug_tag_array,
        Cat(io.ic_debug_wr_data(68,64), io.ic_debug_wr_data(31,11)) ,
        Cat(ic_tag_ecc(4,0), io.ic_rw_addr(31,ICACHE_TAG_LO)))
        }
      .otherwise{
        ic_tag_parity := rveven_paritygen(io.ic_rw_addr(31,ICACHE_TAG_LO))
        ic_tag_wr_data := Mux(io.ic_debug_wr_en & io.ic_debug_tag_array,
          Cat(io.ic_debug_wr_data(68,64), io.ic_debug_wr_data(31,11)) ,
          Cat(ic_tag_ecc(4,0), io.ic_rw_addr(31,ICACHE_TAG_LO)))
        }
    }

    .otherwise{
      when(ICACHE_ECC.B){
        ic_tag_ecc := rvecc_encode(Cat(repl(ICACHE_TAG_LO,0.U) , io.ic_rw_addr(31,ICACHE_TAG_LO)))
        ic_tag_wr_data := Mux(io.ic_debug_wr_en & io.ic_debug_tag_array,
          Cat(io.ic_debug_wr_data(68,64), io.ic_debug_wr_data(31,11)) ,
          Cat(ic_tag_ecc(4,0), repl(PAD_BITS,0.U), io.ic_rw_addr(31,ICACHE_TAG_LO)))
      }
        .otherwise{
          ic_tag_parity := rveven_paritygen(io.ic_rw_addr(31,ICACHE_TAG_LO))
          ic_tag_wr_data := Mux(io.ic_debug_wr_en & io.ic_debug_tag_array,
            Cat(io.ic_debug_wr_data(68,64), io.ic_debug_wr_data(31,11)) ,
            Cat(ic_tag_ecc(4,0), repl(PAD_BITS,0.U), io.ic_rw_addr(31,ICACHE_TAG_LO)))
        }
      }

  val ic_rw_addr_q = Mux(io.ic_debug_rd_en | io.ic_debug_wr_en,
    io.ic_debug_addr(ICACHE_INDEX_HI, ICACHE_TAG_INDEX_LO),
    io.ic_rw_addr(ICACHE_INDEX_HI, ICACHE_TAG_INDEX_LO))

  val ic_debug_rd_way_en_ff = RegNext(ic_debug_rd_way_en, init = 0.U)

  val ic_way_tag = if(ICACHE_ECC) SyncReadMem(ICACHE_TAG_DEPTH, Vec(ICACHE_NUM_WAYS, UInt(26.W)))
  else SyncReadMem(ICACHE_TAG_DEPTH, Vec(ICACHE_NUM_WAYS, UInt(22.W)))
  //val ic_tag_data_raw = if(ICACHE_ECC) Vec(ICACHE_NUM_WAYS, UInt(26.W)) else Vec(ICACHE_NUM_WAYS, UInt(22.W))

  val write_data = VecInit.tabulate(ICACHE_NUM_WAYS)(i => ic_tag_wr_data)

  val mem_mask = VecInit.tabulate(ICACHE_NUM_WAYS)(i => ic_tag_wren_q(i) & ic_tag_clken(i))

  ic_way_tag.write(ic_rw_addr_q, write_data, mem_mask)

  val ic_tag_data_raw = ic_way_tag.read(ic_rw_addr_q, 1.B)
  //val w_tout = Wire(UInt(32.W))
  val w_tout = if(ICACHE_ECC)ic_tag_data_raw.map(x=>Cat(ic_tag_data_raw(x)(25,21),ic_tag_data_raw(x)(31-ICACHE_TAG_LO,0),0.U(13.W)))
  else ic_tag_data_raw.map(x=>Cat(0.U(4.W),ic_tag_data_raw(x)(32),ic_tag_data_raw(x)(31-ICACHE_TAG_LO,0),0.U(13.W)))

  val ecc_decode = new Array[rvecc_decode](ICACHE_NUM_WAYS)
  val parcheck = new Array[UInt](ICACHE_NUM_WAYS)
  val ic_tag_corrected_data_unc = Wire(Vec(ICACHE_NUM_WAYS, UInt(32.W)))
  val ic_tag_corrected_ecc_unc = Wire(Vec(ICACHE_NUM_WAYS, UInt(7.W)))
  val ic_tag_single_ecc_error = Wire(Vec(ICACHE_NUM_WAYS, UInt(1.W)))
  val ic_tag_double_ecc_error = Wire(Vec(ICACHE_NUM_WAYS, UInt(1.W)))

  val ic_tag_way_perr = VecInit.tabulate(ICACHE_NUM_WAYS)(i => rveven_paritycheck(w_tout(i)(31,ICACHE_TAG_LO),w_tout(i)(31)))
  for(i <- 0 until ICACHE_NUM_WAYS) {
    ecc_decode(i) = Module(new rvecc_decode())
    ecc_decode(i).io.en := ~io.dec_tlu_core_ecc_disable & ic_rd_en_ff
    ecc_decode(i).io.sed_ded := 1.U
    ecc_decode(i).io.din := Cat(0.U(11.W),ic_tag_data_raw(i)(20,0))
    ecc_decode(i).io.ecc_in := Cat(0.U(2.W),ic_tag_data_raw(i)(25,21))


    ic_tag_way_perr(i) := ic_tag_single_ecc_error(i) | ic_tag_double_ecc_error(i)
  }
  val temp = if(ICACHE_ECC)
    VecInit.tabulate(ICACHE_NUM_WAYS)(i=>repl(26,ic_debug_rd_way_en_ff(i))&ic_tag_data_raw(i)).reduce(_|_)
  else
    VecInit.tabulate(ICACHE_NUM_WAYS)(i=>Cat(0.U(4.W),repl(22,ic_debug_rd_way_en_ff(i))&ic_tag_data_raw(i))).reduce(_|_)

    for(i <- 0 until ICACHE_NUM_WAYS){
      repl(26,ic_debug_rd_way_en_ff(i))&ic_tag_data_raw(i)
    }
  io.ictag_debug_rd_data := temp
  io.ic_tag_perr := (ic_tag_way_perr.reverse.reduce(Cat(_,_)) & io.ic_tag_valid).orR
  val w_tout_Vec = VecInit.tabulate(ICACHE_NUM_WAYS)(i=> w_tout(i))
  io.ic_rd_hit := VecInit.tabulate(ICACHE_NUM_WAYS)(i=>(w_tout_Vec(i)(31,ICACHE_TAG_LO)===ic_rw_addr_ff(31,ICACHE_TAG_LO)).asUInt() & io.ic_tag_valid).reverse.reduce(Cat(_,_))
}


////////////////////////////////////////////////

class EL2_IC_DATA extends Module with el2_lib {
  val io = IO (new Bundle{
    val clk_override        = Input(Bool())
    val ic_rw_addr          = Input(UInt(ICACHE_INDEX_HI.W))
    val ic_wr_en            = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_rd_en            = Input(Bool())
    val ic_wr_data          = Input(Vec(ICACHE_NUM_WAYS, UInt(71.W)))
    val ic_rd_data          = Output(UInt(64.W))
    val ic_debug_wr_data    = Input(UInt(71.W))
    val ic_debug_rd_data    = Output(UInt(71.W))
    val ic_parerr           = Output(UInt(ICACHE_NUM_WAYS.W))
    val ic_eccerr           = Output(UInt(ICACHE_BANKS_WAY.W))
    val ic_debug_addr       = Input(UInt((ICACHE_INDEX_HI-3).W))
    val ic_debug_rd_en      = Input(Bool())
    val ic_debug_wr_en      = Input(Bool())
    val ic_debug_tag_array  = Input(Bool())
    val ic_debug_way        = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_premux_data      = Input(UInt(64.W))
    val ic_sel_premux_data  = Input(Bool())
    val ic_rd_hit           = Input(UInt(ICACHE_NUM_WAYS.W))
    val scan_mode           = Input(UInt(1.W))
    val test_in             = Input(UInt(71.W))
    val test                = Output(UInt())
    val test_port           = Output(Vec(ICACHE_BANKS_WAY, Vec(ICACHE_NUM_WAYS, UInt(71.W))))
  })

  io.ic_rd_data := 0.U
  io.ic_debug_rd_data := 0.U
  io.ic_parerr := 0.U
  io.ic_eccerr := 0.U
  io.test := 0.U

  val ic_debug_rd_way_en = Fill(ICACHE_NUM_WAYS, io.ic_debug_rd_en & !io.ic_debug_tag_array) & io.ic_debug_way
  val ic_debug_wr_way_en = repl(ICACHE_NUM_WAYS, io.ic_debug_wr_en & !io.ic_debug_tag_array) & io.ic_debug_way

  val ic_bank_wr_data = Wire(Vec(ICACHE_BANKS_WAY,UInt(71.W)))
  val ic_rd_en_with_debug = WireInit(Bool(), 0.U)

  val ic_rw_addr_q = Mux((io.ic_debug_rd_en | io.ic_debug_wr_en).asBool, Cat(io.ic_debug_addr,0.U(2.W)), io.ic_rw_addr)

  val ic_rw_addr_q_inc = ic_rw_addr_q(ICACHE_TAG_LO-2,ICACHE_DATA_INDEX_LO-1) + 1.U
  val ic_b_sb_wren = (0 until ICACHE_NUM_WAYS).map(i=>
    io.ic_wr_en | ic_debug_wr_way_en & Fill(ICACHE_NUM_WAYS, io.ic_debug_addr(ICACHE_BANK_HI-3,ICACHE_BANK_LO-3)===i.U))
  val ic_debug_sel_sb = (0 until ICACHE_NUM_WAYS).map(i=> (io.ic_debug_addr(ICACHE_BANK_HI-3,ICACHE_BANK_LO-3)===i.U).asUInt).reverse.reduce(Cat(_,_))
  val ic_sb_wr_data = (0 until ICACHE_NUM_WAYS).map(i=> Mux((ic_debug_sel_sb(i)&io.ic_debug_wr_en).asBool, io.ic_debug_wr_data, ic_bank_wr_data(i)))
  val ic_b_rden = (0 until ICACHE_NUM_WAYS).map(i=>
    (Mux1H(Seq(!ic_rw_addr_q(ICACHE_BANK_HI-1).asBool -> (i.U === 0.U),
                            (ic_rw_addr_q(ICACHE_BANK_HI-1)).asBool -> ((ic_rw_addr_q(1,0)===3.U)&(i.U===0.U)),
                             ic_rw_addr_q(ICACHE_BANK_HI-1).asBool -> (i.U === 1.U),
                            (!ic_rw_addr_q(ICACHE_BANK_HI-1)).asBool -> ((ic_rw_addr_q(1,0)===3.U)&(i.U === 1.U)))) & ic_rd_en_with_debug).asUInt).reverse.reduce(Cat(_,_))
  val ic_b_sb_rden = (0 until ic_b_rden.getWidth).map(i=>Fill(ICACHE_NUM_WAYS, ic_b_rden(i)))
  val ic_bank_way_clken = (0 until ICACHE_BANKS_WAY).map(i=>(0 until ICACHE_NUM_WAYS).map(j=>
    (ic_b_sb_rden(i)(j) | io.clk_override | ic_b_sb_wren(i)(j)).asUInt).reduce(Cat(_,_)))

  ic_rd_en_with_debug := io.ic_rd_en | io.ic_debug_rd_en & (!io.ic_wr_en.orR)

  val ic_rw_addr_wrap = ic_rw_addr_q(ICACHE_BANK_HI-1) & (ic_rw_addr_q(1,0) === 3.U) & ic_rd_en_with_debug & !(io.ic_wr_en.orR)

  val ic_rw_addr_bank_q = VecInit(Mux((!ic_rw_addr_wrap).asBool,ic_rw_addr_q(ICACHE_INDEX_HI-1,ICACHE_DATA_INDEX_LO-1),
    Cat(ic_rw_addr_q(ICACHE_INDEX_HI-1, ICACHE_TAG_INDEX_LO-1) , ic_rw_addr_q_inc(ICACHE_TAG_INDEX_LO-2,ICACHE_DATA_INDEX_LO-1))),
    ic_rw_addr_q(ICACHE_INDEX_HI-1,ICACHE_DATA_INDEX_LO-1)
  )



  val ic_b_rden_ff = RegNext(ic_b_rden, 0.U)
  val ic_rw_addr_ff = RegNext(ic_rw_addr_q(ICACHE_TAG_INDEX_LO-2,0), 0.U)
  val ic_debug_rd_way_en_ff = RegNext(ic_debug_rd_way_en, 0.U)
  val ic_debug_rd_en_ff = RegNext(io.ic_debug_rd_en, 0.U)

  val ic_cacheline_wrap_ff = ic_rw_addr_ff(ICACHE_TAG_INDEX_LO-2,ICACHE_BANK_LO-1) === Fill(ICACHE_TAG_INDEX_LO-ICACHE_BANK_LO, 1.U)

//////////////////////////////////////////// Memory stated
  val (data_mem_word, tag_mem_word, ecc_offset) = DATA_MEM_LINE
  val wb_dout = Wire(Vec(ICACHE_BANKS_WAY,Vec(ICACHE_NUM_WAYS, UInt(data_mem_word.W))))
  val data_mem = Mem(ICACHE_DATA_DEPTH, Vec(ICACHE_BANKS_WAY,Vec(ICACHE_NUM_WAYS, UInt(data_mem_word.W))))
  for(i<-0 until ICACHE_NUM_WAYS; k<-0 until ICACHE_BANKS_WAY){
    wb_dout(i)(k) := 0.U
    val WE = if(ICACHE_WAYPACK) ic_b_sb_wren(k).orR else ic_b_sb_wren(k)(i)
    val ME = if(ICACHE_WAYPACK) ic_bank_way_clken(k).orR else ic_bank_way_clken(k)(i)
    when((ic_b_sb_wren(k)(i) & ic_bank_way_clken(k)(i)).asBool){
      data_mem(ic_rw_addr_bank_q(k))(k)(i) := io.test_in
    }.elsewhen((!ic_b_sb_wren(k)(i)&ic_bank_way_clken(k)(i)).asBool){
      wb_dout(i)(k) := data_mem(ic_rw_addr_bank_q(k))(k)(i)
    }
  }
  io.test_port := wb_dout
  val ic_rd_hit_q = Mux(ic_debug_rd_en_ff.asBool, ic_debug_rd_way_en_ff, io.ic_rd_hit)
  ic_bank_wr_data := (0 until ICACHE_BANKS_WAY).map(io.ic_wr_data(_))

  val wb_dout_way_pre = (0 until ICACHE_BANKS_WAY).map(i=>Cat(
    Mux1H((0 until ICACHE_BANKS_WAY).map(j=>(ic_rw_addr_ff(ICACHE_BANK_HI-1, ICACHE_BANK_LO-1)===j.U).asBool->wb_dout(i)(j))),
    Mux1H((0 until ICACHE_BANKS_WAY).map(j=>(ic_rw_addr_ff(ICACHE_BANK_HI-1, ICACHE_BANK_LO-1)===(j.U-1.U)).asBool->wb_dout(i)(j)))))

  val wb_dout_way = (0 until ICACHE_NUM_WAYS).map(i=>Mux1H(Seq((ic_rw_addr_ff(1,0)===0.U).asBool->wb_dout_way_pre(i)(63,0),
                              (ic_rw_addr_ff(1,0)===1.U).asBool->Cat(wb_dout_way_pre(i)(86,71),wb_dout_way_pre(i)(63,16)),
                              (ic_rw_addr_ff(1,0)===2.U).asBool->Cat(wb_dout_way_pre(i)(102,71),wb_dout_way_pre(i)(63,32)),
                              (ic_rw_addr_ff(1,0)===3.U).asBool->Cat(wb_dout_way_pre(i)(119,71),wb_dout_way_pre(i)(63,48)))))

  val wb_dout_way_with_premux = (0 until ICACHE_NUM_WAYS).map(i=>Mux(io.ic_sel_premux_data.asBool,io.ic_premux_data, wb_dout_way(i)))

  val ic_rd_data = Mux1H((0 until ICACHE_NUM_WAYS).map(i=>(ic_rd_hit_q(i) | io.ic_sel_premux_data).asBool->wb_dout_way_with_premux(i)))
  val ic_debug_rd_data = Mux1H((0 until ICACHE_NUM_WAYS).map(i=>ic_rd_hit_q(i).asBool->wb_dout_way_pre(i)(70,0)))
  val wb_dout_ecc = Mux1H((0 until ICACHE_NUM_WAYS).map(i=>ic_rd_hit_q(i).asBool->wb_dout_way_pre(i)))

  val bank_check_en = for(i<-0 until ICACHE_BANKS_WAY) yield(io.ic_rd_hit.orR & ((i.U==0.U).asBool | (!ic_cacheline_wrap_ff & (ic_b_rden_ff(ICACHE_BANKS_WAY-1,0) === Fill(ICACHE_BANKS_WAY,1.U)))))
//  val wb_dout_ecc_bank = (0 until ICACHE_BANKS_WAY).map(i=> wb_dout_ecc((71*i)+70,71*i)))
}

object ifu_ic extends App {
  println((new chisel3.stage.ChiselStage).emitVerilog(new EL2_IC_DATA()))
}