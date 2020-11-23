package exu

import chisel3._
import chisel3.util._
import include._
import lib._

class el2_exu_alu_ctl extends Module with el2_lib with RequireAsyncReset{
  val io = IO(new Bundle{
    //////////  Inputs  /////////
    // val                  clk               = Input(Clock())  // Top level clock
    // val                  rst_l             = Input(UInt(1.W))  // Reset
    val                  scan_mode         = Input(UInt(1.W))  // Scan control
    val                  flush_upper_x     = Input(UInt(1.W))  // Branch flush from previous cycle
    val                  flush_lower_r     = Input(UInt(1.W))  // Master flush of entire pipeline
    val                  enable            = Input(Bool())  // Clock enable
    val                  valid_in          = Input(UInt(1.W))  // Valid
    val                  ap                = Input( new el2_alu_pkt_t )                // predecodes
    val                  csr_ren_in        = Input(UInt(1.W))           // extra decode
    val                  a_in              = Input(SInt(32.W))               // A operand
    val                  b_in              = Input(UInt(32.W))               // B operand
    val                  pc_in             = Input(UInt(31.W))              // for pc=pc+2,4 calculations
    val                  pp_in             = Input(new el2_predict_pkt_t)              // Predicted branch structure
    val                  brimm_in          = Input(UInt(12.W))           // Branch offset
    //////////  Outputs  /////////
    val                  result_ff         = Output(UInt(32.W))          // final result
    val                  flush_upper_out   = Output(UInt(1.W)) // Branch flush
    val                  flush_final_out   = Output(UInt(1.W)) // Branch flush or flush entire pipeline
    val                  flush_path_out    = Output(UInt(31.W)) // Branch flush PC
    val                  pc_ff             = Output(UInt(31.W)) // flopped PC
    val                  pred_correct_out  = Output(UInt(1.W)) // NPC control
    val                  predict_p_out     = Output(new el2_predict_pkt_t)     // Predicted branch structure
  })

  io.pc_ff := rvdffe(io.pc_in,io.enable,clock,io.scan_mode.asBool) // any PC is run through here - doesn't have to be alu
  val result = WireInit(UInt(32.W),0.U)
  io.result_ff := rvdffe(result,io.enable,clock,io.scan_mode.asBool)

  val   bm = Mux( io.ap.sub.asBool, ~io.b_in, io.b_in) //H:b modified

  val aout = WireInit(UInt(33.W),0.U)
  aout := Mux(io.ap.sub.asBool,(Cat(0.U(1.W),io.a_in) + Cat(0.U(1.W),~io.b_in) + Cat(0.U(32.W),io.ap.sub)), (Cat(0.U(1.W),io.a_in) + Cat(0.U(1.W), io.b_in) + Cat(0.U(32.W),io.ap.sub)))
  val cout = aout(32)

  val ov  = (~io.a_in(31) & ~bm(31) &  aout(31)) | ( io.a_in(31) &  bm(31) & ~aout(31) ) //overflow check from last bits

  val eq                  = (io.a_in === io.b_in.asSInt)
  val ne                  = ~eq
  val neg                 =  aout(31)// check for the last signed bit (for neg)
  val lt                  = (~io.ap.unsign & (neg ^ ov)) |  ( io.ap.unsign & ~cout)  //if alu packet sends unsigned and there is no cout(i.e no overflow and unsigned pkt)
  val ge                  = ~lt // if not less then


  val lout                =  Mux1H(Seq(
    io.csr_ren_in.asBool ->              io.b_in.asSInt,  //read enable read rs2
    io.ap.land.asBool    ->  (io.a_in &  io.b_in.asSInt),  //and rs1 and 2
    io.ap.lor.asBool     ->  (io.a_in |  io.b_in.asSInt),
    io.ap.lxor.asBool    ->  (io.a_in ^  io.b_in.asSInt)))

  val shift_amount   = Mux1H(Seq (
    io.ap.sll.asBool   -> (32.U(6.W) - Cat(0.U(1.W),io.b_in(4,0))),    // [5] unused
    io.ap.srl.asBool   ->              Cat(0.U(1.W),io.b_in(4,0)) ,
    io.ap.sra.asBool   ->              Cat(0.U(1.W),io.b_in(4,0)) ))

  val shift_mask = WireInit(UInt(32.W),0.U)
  shift_mask := ( "hffffffff".U(32.W) << (repl(5,io.ap.sll) & io.b_in(4,0)) )

  val shift_extend = WireInit(UInt(63.W),0.U)
  shift_extend :=  Cat((repl(31,io.ap.sra) & repl(31,io.a_in(31))) | (repl(31,io.ap.sll) & io.a_in(30,0)),io.a_in)

  val shift_long = WireInit(UInt(63.W),0.U)
  shift_long := ( shift_extend >> shift_amount(4,0) );   // 62-32 unused

  val sout  = ( shift_long(31,0) & shift_mask(31,0) ); //incase of sra shift_mask is 1


  val sel_shift           =  io.ap.sll  | io.ap.srl | io.ap.sra
  val sel_adder           = (io.ap.add  | io.ap.sub) & ~io.ap.slt
  val sel_pc              =  io.ap.jal  | io.pp_in.pcall | io.pp_in.pja | io.pp_in.pret
  val csr_write_data      = Mux(io.ap.csr_imm.asBool, io.b_in.asSInt, io.a_in)

  val slt_one             =  io.ap.slt & lt

  // for a conditional br pcout[] will be the opposite of the branch prediction
  // for jal or pcall, it will be the link address pc+2 or pc+4
  val pcout =  rvbradder(Cat(io.pc_in,0.U),Cat(io.brimm_in,0.U))

  result       :=  lout(31,0) | Cat(0.U(31.W),slt_one) | (Mux1H(Seq(
    sel_shift.asBool       ->       sout(31,0),
    sel_adder.asBool       ->       aout(31,0),
    sel_pc.asBool          ->       pcout,
    io.ap.csr_write.asBool ->       csr_write_data(31,0))))

  // *** branch handling ***

  val any_jal             =  io.ap.jal      | //jal
    io.pp_in.pcall | //branch is a call inst
    io.pp_in.pja   | //branch is a jump always
    io.pp_in.pret //return inst

  val actual_taken        = (io.ap.beq & eq) | (io.ap.bne & ne.asUInt) | (io.ap.blt & lt) | (io.ap.bge & ge) | any_jal

  // pred_correct is for the npc logic
  // pred_correct indicates not to use the flush_path
  // for any_jal pred_correct==0
  io.pred_correct_out    := (io.valid_in & io.ap.predict_nt & !actual_taken & !any_jal) | (io.valid_in & io.ap.predict_t  &  actual_taken & !any_jal)
  // for any_jal adder output is the flush path
  io.flush_path_out  := Mux(any_jal.asBool, aout(31,1), pcout(31,1))

  // pcall and pret are included here
  val cond_mispredict   = (io.ap.predict_t  & !actual_taken) | (io.ap.predict_nt &  actual_taken.asUInt)

  // target mispredicts on ret's
  val target_mispredict   =  io.pp_in.pret & (io.pp_in.prett =/= aout(31,1)) //predicted return target != aout

  io.flush_upper_out     :=   (io.ap.jal | cond_mispredict | target_mispredict) & io.valid_in & !io.flush_upper_x   & !io.flush_lower_r
  //there was no entire pipe flush (& previous cycle flush ofc(why check?)) therfore signAL 1 to flush instruction before X stage
  io.flush_final_out     := ( (io.ap.jal | cond_mispredict | target_mispredict) & io.valid_in & !io.flush_upper_x ) |  io.flush_lower_r
  //there was entire pipe flush or (there is mispred or a jal) therfore signAL 1 to flush entire pipe

  val  newhist = WireInit(UInt(2.W),0.U)
  newhist    := Cat((io.pp_in.hist(1) &  io.pp_in.hist(0)) | (~io.pp_in.hist(0) & actual_taken),//newhist[1]
    (~io.pp_in.hist(1) & ~actual_taken)  | (io.pp_in.hist(1) & actual_taken))   //newhist[0]

  io.predict_p_out           :=  io.pp_in
  io.predict_p_out.misp      := ~io.flush_upper_x & ~io.flush_lower_r & (cond_mispredict | target_mispredict);// if 1 tells that it was a	misprediction becauseprevious cycle was not a flush and these was no master flush(lower pipe flush) and ifu predicted taken but actually its nt
  io.predict_p_out.ataken    :=  actual_taken; // send a control signal telling it branch taken or not
  io.predict_p_out.hist      :=  newhist
}
