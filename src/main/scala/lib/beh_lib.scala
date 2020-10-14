package lib
import chisel3._
import chisel3.util._
//import firrtl.ir.BundleType
import include._
//import org.graalvm.compiler.code.DataSection.Data
//import lib.beh_ib_func._

class rvdff(WIDTH:Int=1,SHORT:Int=0) extends Module{
  val io = IO(new Bundle{
    val din  = Input(UInt(WIDTH.W))
    val dout = Output(UInt(WIDTH.W))
  })

  val flop = RegNext(io.din,0.U)

  if(SHORT == 1)
  {io.dout := io.din}
  else
  {io.dout := flop}
}
//println(getVerilog(new rvdff))
//rvdff => use regnext. with Asynchronous


class rvsyncss(WIDTH:Int = 251,SHORT:Int = 0) extends Module{  //Done for verification and testing
  val io = IO(new Bundle{
    val din   = Input(UInt(WIDTH.W))
    val dout  = Output(UInt(WIDTH.W))
    val clk   = Input(Clock())
  })
  val sync_ff1 = withClock(io.clk){RegNext(io.din,0.U)}    //RegNext(io.in,init)
  val sync_ff2 = withClock(io.clk){RegNext(sync_ff1,0.U)}
  if(SHORT == 1)
  {io.dout := io.din   }
  else
  {io.dout := sync_ff2 }
}






class rvlsadder extends Module{  //Done for verification and testing
  val io = IO(new Bundle{
    val rs1     = Input(UInt(32.W))
    val offset  = Input(UInt(12.W))
    val dout    = Output(UInt(32.W))
  })
  val w1 =  Cat(0.U(1.W),io.rs1(11,0)) + Cat(0.U(1.W),io.offset(11,0))  //w1[12] =cout  offset[11]=sign

  val dout_upper = ((Fill(20, ~(io.offset(11) ^ w1(12)))) & io.rs1(31,12)) |
    ((Fill(20, ~io.offset(11) & w1(12))) & (io.rs1(31,12)+1.U)) |
    ((Fill(20, io.offset(11) & ~w1(12))) & (io.rs1(31,12)-1.U))

  io.dout := Cat(dout_upper,w1(11,0))
}

class rvbradder extends Module{   //Done for verification and testing
  val io = IO(new Bundle{
    val pc     = Input(UInt(31.W))  // 31:1 => 30:0
    val offset = Input(UInt(12.W))  // 12:1 => 11:0
    val dout   = Output(UInt(31.W)) // 31:1 => 30:0
  })
  val w1 =  Cat(0.U(1.W),io.pc(11,0)) + Cat(0.U(1.W),io.offset(11,0))  //w1[12] =cout  offset[12]=sign
  val dout_upper = ((Fill(19, ~(io.offset(11) ^ w1(12))))&  io.pc(30,12))       |
    ((Fill(19, ~io.offset(11) &   w1(12))) & (io.pc(30,12)+1.U)) |
    ((Fill(19, io.offset(11)  &  ~w1(12))) & (io.pc(30,12)-1.U))
  io.dout := Cat(dout_upper,w1(11,0))
}


class rvtwoscomp(WIDTH:Int=32) extends Module{   //Done for verification and testing
  val io = IO(new Bundle{
    val din   = Input(UInt(WIDTH.W))
    val dout  = Output(UInt(WIDTH.W))
  })
  val temp = Wire(Vec(WIDTH-1,UInt(1.W)))
  for(i <- 1 to WIDTH-1){
    temp(i-1) := Mux(io.din(i-1,0).orR ,~io.din(i),io.din(i))}
  io.dout := Cat(temp.asUInt,io.din(0))
}

class rvmaskandmatch(WIDTH:Int=32) extends Module{     //Done for verification and testing
  val io = IO(new Bundle{
    val mask       = Input(UInt(WIDTH.W))
    val data       = Input(UInt(WIDTH.W))
    val masken     = Input(UInt(1.W))
    val match_out  = Output(UInt(1.W))
  })

  val matchvec = Wire(Vec(WIDTH,UInt(1.W)))
  val masken_or_fullmask = io.masken.asBool & (~(io.mask(WIDTH-1,0).andR))

  matchvec(0)  :=  masken_or_fullmask | (io.mask(0) === io.data(0)).asUInt

  for(i <- 1 to WIDTH-1)
  {matchvec(i) := Mux(io.mask(i-1,0).andR & masken_or_fullmask,"b1".U,(io.mask(i) === io.data(i)).asUInt)}
  io.match_out := matchvec.asUInt.andR
}//ewrfdxgh

class rvrangecheck(CCM_SADR:UInt, CCM_SIZE:Int=128) extends Module{
  val io = IO(new Bundle{
    val addr       =  Input(UInt(32.W))
    val in_range   =  Output(UInt(1.W))
    val in_region  =  Output(UInt(1.W))
  })
  val REGION_BITS = 4
  val MASK_BITS   = 10 + log2Ceil(CCM_SIZE)
  val start_addr  = CCM_SADR
  val region  = start_addr(31,(32-REGION_BITS))

  io.in_region  := (io.addr(31,(32-REGION_BITS)) === region(REGION_BITS-1,0)).asUInt
  if(CCM_SIZE == 48)
    io.in_range := (io.addr(31,MASK_BITS) === start_addr(31,MASK_BITS)).asUInt & ~(io.addr(MASK_BITS-1,MASK_BITS-2).andR.asUInt)
  else
    io.in_range := (io.addr(31,MASK_BITS) === start_addr(31,MASK_BITS)).asUInt
}

class rveven_paritygen(WIDTH:Int= 16) extends Module{    //Done for verification and testing
  val io = IO(new Bundle{
    val data_in        =  Input (UInt(WIDTH.W))
    val parity_out     =  Output(UInt(1.W))
  })
  io.parity_out := io.data_in.xorR.asUInt
}

class rveven_paritycheck(WIDTH:Int= 16) extends Module{    //Done for verification and testing
  val io = IO(new Bundle{
    val data_in        =  Input (UInt(WIDTH.W))
    val parity_in      =  Input (UInt(1.W))
    val parity_err     =  Output(UInt(1.W))
  })
  io.parity_err := (io.data_in.xorR.asUInt) ^ io.parity_in
}

class rvecc_encode extends Module{   //Done for verification and testing
  val io      =  IO(new Bundle{
    val din     =  Input(UInt(32.W))
    val ecc_out =  Output(UInt(7.W))
  })
  val mask0 = Array(1,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0)
  val mask1 = Array(1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1)
  val mask2 = Array(0,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1)
  val mask3 = Array(0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0)
  val mask4 = Array(0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0)
  val mask5 = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1)

  val w0 = Wire(Vec(18,UInt(1.W)))
  val w1 = Wire(Vec(18,UInt(1.W)))
  val w2 = Wire(Vec(18,UInt(1.W)))
  val w3 = Wire(Vec(15,UInt(1.W)))
  val w4 = Wire(Vec(15,UInt(1.W)))
  val w5 = Wire(Vec(6, UInt(1.W)))
  var j = 0;var k = 0;var m = 0;
  var x = 0;var y = 0;var z = 0;

  for(i <- 0 to 31)
  {
    if(mask0(i)==1) {w0(j) := io.din(i); j = j +1 }
    if(mask1(i)==1) {w1(k) := io.din(i); k = k +1 }
    if(mask2(i)==1) {w2(m) := io.din(i); m = m +1 }
    if(mask3(i)==1) {w3(x) := io.din(i); x = x +1 }
    if(mask4(i)==1) {w4(y) := io.din(i); y = y +1 }
    if(mask5(i)==1) {w5(z) := io.din(i); z = z +1 }
  }
  val w6 = Cat((w5.asUInt.xorR),(w4.asUInt.xorR),(w3.asUInt.xorR),(w2.asUInt.xorR),(w1.asUInt.xorR),(w0.asUInt.xorR))
  io.ecc_out := Cat(io.din.xorR ^ w6.xorR, w6)
}



class rvecc_decode extends Module{  //Done for verification and testing
  val io      =  IO(new Bundle{
    val en      =  Input(UInt(1.W))
    val din     =  Input(UInt(32.W))
    val ecc_in  =  Input(UInt(7.W))
    val sed_ded =  Input(UInt(1.W))
    val ecc_out =  Output(UInt(7.W))
    val dout    =  Output(UInt(32.W))
    val single_ecc_error = Output(UInt(1.W))
    val double_ecc_error = Output(UInt(1.W))
  })

  val mask0 = Array(1,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0)
  val mask1 = Array(1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1)
  val mask2 = Array(0,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1)
  val mask3 = Array(0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0)
  val mask4 = Array(0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0)
  val mask5 = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1)

  val w0 = Wire(Vec(18,UInt(1.W)))
  val w1 = Wire(Vec(18,UInt(1.W)))
  val w2 = Wire(Vec(18,UInt(1.W)))
  val w3 = Wire(Vec(15,UInt(1.W)))
  val w4 = Wire(Vec(15,UInt(1.W)))
  val w5 = Wire(Vec(6,UInt(1.W)))

  var j = 0;var k = 0;var m = 0;  var n =0;
  var x = 0;var y = 0;

  for(i <- 0 to 31)
  {
    if(mask0(i)==1) {w0(j) := io.din(i); j = j +1 }
    if(mask1(i)==1) {w1(k) := io.din(i); k = k +1 }
    if(mask2(i)==1) {w2(m) := io.din(i); m = m +1 }
    if(mask3(i)==1) {w3(n) := io.din(i); n = n +1 }
    if(mask4(i)==1) {w4(x) := io.din(i); x = x +1 }
    if(mask5(i)==1) {w5(y) := io.din(i); y = y +1 }
  }

  val ecc_check = Cat((io.din.xorR ^ io.ecc_in.xorR) & ~io.sed_ded ,io.ecc_in(5)^(w5.asUInt.xorR),io.ecc_in(4)^(w4.asUInt.xorR),io.ecc_in(3)^(w3.asUInt.xorR),io.ecc_in(2)^(w2.asUInt.xorR),io.ecc_in(1)^(w1.asUInt.xorR),io.ecc_in(0)^(w0.asUInt.xorR))


  io.single_ecc_error :=  io.en & (ecc_check =/= 0.U(7.W)) & ecc_check(6)
  io.double_ecc_error :=  io.en & (ecc_check =/= 0.U(7.W)) & ~ecc_check(6)
  val error_mask = Wire(Vec(39,UInt(1.W)))

  for(i <- 1 until 40){
    error_mask(i-1) := ecc_check(5,0) === i.asUInt
  }
  val din_plus_parity = Cat(io.ecc_in(6), io.din(31,26), io.ecc_in(5), io.din(25,11), io.ecc_in(4), io.din(10,4), io.ecc_in(3), io.din(3,1), io.ecc_in(2), io.din(0), io.ecc_in(1,0))
  val dout_plus_parity = Mux(io.single_ecc_error.asBool, (error_mask.asUInt ^ din_plus_parity), din_plus_parity)

  io.dout :=  Cat(dout_plus_parity(37,32),dout_plus_parity(30,16), dout_plus_parity(14,8), dout_plus_parity(6,4), dout_plus_parity(2))
  io.ecc_out := Cat(dout_plus_parity(38) ^ (ecc_check(6,0) === "b1000000".U(7.W)), dout_plus_parity(31), dout_plus_parity(15), dout_plus_parity(7), dout_plus_parity(3), dout_plus_parity(1,0))
}



class rvecc_encode_64 extends Module{    //Done for verification and testing
  val io      =  IO(new Bundle{
    val din     =  Input(UInt(64.W))
    val ecc_out =  Output(UInt(7.W))
  })
  val mask0 = Array(1,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1)
  val mask1 = Array(1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1)
  val mask2 = Array(0,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1)
  val mask3 = Array(0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)
  val mask4 = Array(0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)
  val mask5 = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)
  val mask6 = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1)

  val w0 = Wire(Vec(35,UInt(1.W)))
  val w1 = Wire(Vec(35,UInt(1.W)))
  val w2 = Wire(Vec(35,UInt(1.W)))
  val w3 = Wire(Vec(31,UInt(1.W)))
  val w4 = Wire(Vec(31,UInt(1.W)))
  val w5 = Wire(Vec(31,UInt(1.W)))
  val w6 = Wire(Vec(7, UInt(1.W)))

  var j = 0;var k = 0;var m = 0; var n =0;
  var x = 0;var y = 0;var z = 0

  for(i <- 0 to 63)
  {
    if(mask0(i)==1) {w0(j) := io.din(i); j = j +1 }
    if(mask1(i)==1) {w1(k) := io.din(i); k = k +1 }
    if(mask2(i)==1) {w2(m) := io.din(i); m = m +1 }
    if(mask3(i)==1) {w3(n) := io.din(i); n = n +1 }
    if(mask4(i)==1) {w4(x) := io.din(i); x = x +1 }
    if(mask5(i)==1) {w5(y) := io.din(i); y = y +1 }
    if(mask6(i)==1) {w6(z) := io.din(i); z = z +1 }
  }
  io.ecc_out := Cat((w6.asUInt.xorR),(w5.asUInt.xorR),(w4.asUInt.xorR),(w3.asUInt.xorR),(w2.asUInt.xorR),(w1.asUInt.xorR),(w0.asUInt.xorR))
}

class rvecc_decode_64 extends Module{     //Done for verification and testing
  val io        =  IO(new Bundle{
    val en        =  Input(UInt(1.W))
    val din       =  Input(UInt(64.W))
    val ecc_in    =  Input(UInt(7.W))
    val ecc_error =  Output(UInt(1.W))
  })
  val mask0 = Array(1,1,0,1,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1)
  val mask1 = Array(1,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1)
  val mask2 = Array(0,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1)
  val mask3 = Array(0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)
  val mask4 = Array(0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)
  val mask5 = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0)
  val mask6 = Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1)

  val w0 = Wire(Vec(35,UInt(1.W)))
  val w1 = Wire(Vec(35,UInt(1.W)))
  val w2 = Wire(Vec(35,UInt(1.W)))
  val w3 = Wire(Vec(31,UInt(1.W)))
  val w4 = Wire(Vec(31,UInt(1.W)))
  val w5 = Wire(Vec(31,UInt(1.W)))
  val w6 = Wire(Vec(7, UInt(1.W)))

  var j = 0;var k = 0;var m = 0;  var n =0;
  var x = 0;var y = 0;var z = 0;

  for(i <- 0 to 63)
  {
    if(mask0(i)==1) {w0(j) := io.din(i); j = j +1 }
    if(mask1(i)==1) {w1(k) := io.din(i); k = k +1 }
    if(mask2(i)==1) {w2(m) := io.din(i); m = m +1 }
    if(mask3(i)==1) {w3(n) := io.din(i); n = n +1 }
    if(mask4(i)==1) {w4(x) := io.din(i); x = x +1 }
    if(mask5(i)==1) {w5(y) := io.din(i); y = y +1 }
    if(mask6(i)==1) {w6(z) := io.din(i); z = z +1 }
  }

  val ecc_check = Cat((io.ecc_in(6) ^ w6.asUInt.xorR) ,io.ecc_in(5)^(w5.asUInt.xorR),io.ecc_in(4)^(w4.asUInt.xorR),io.ecc_in(3)^(w3.asUInt.xorR),io.ecc_in(2)^(w2.asUInt.xorR),io.ecc_in(1)^(w1.asUInt.xorR),io.ecc_in(0)^(w0.asUInt.xorR))
  io.ecc_error := io.en & (ecc_check(6,0) =/= 0.U(7.W))
}




////////////////////////////TEC_RV_ICG////////////////////////
class TEC_RV_ICG extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle {
    val Q = Output(Clock())
    val CK  = Input(Clock())
    val EN  = Input(Bool())
    val SE = Input(Bool())
  })
  addResource("/vsrc/TEC_RV_ICG.v")
}

class rvclkhdr extends Module {
  val io = IO(new Bundle {
    val l1clk = Output(Clock())
    val clk  = Input(Clock())
    val en  = Input(Bool())
    val scan_mode = Input(Bool())
  })
  val clkhdr = { Module(new TEC_RV_ICG) }
  io.l1clk := clkhdr.io.Q
  clkhdr.io.CK := io.clk
  clkhdr.io.EN := io.en
  clkhdr.io.SE := io.scan_mode
}

object rvclkhdr {
  def apply(clk: Clock, en: Bool, scan_mode: Bool): Clock = {
    val cg = Module(new rvclkhdr)
    cg.io.clk := clk
    cg.io.en := en
    cg.io.scan_mode := scan_mode
    cg.io.l1clk
  }
}

////rvdffe ///////////////////////////////////////////////////////////////////////
object rvdffe {
  def apply(din: UInt, en: Bool, clk: Clock, scan_mode: Bool): UInt = {
    val obj = Module(new rvclkhdr())
    val l1clk = obj.io.l1clk
    obj.io.clk := clk
    obj.io.en := en
    obj.io.scan_mode := scan_mode
    withClock(l1clk) {
      RegNext(din, 0.U)
    }
  }
  def apply(din: Bundle, en: Bool, clk: Clock, scan_mode: Bool) = {
    val obj = Module(new rvclkhdr())
    val l1clk = obj.io.l1clk
    obj.io.clk := clk
    obj.io.en := en
    obj.io.scan_mode := scan_mode
    withClock(l1clk) {
      RegNext(din,0.U.asTypeOf(din.cloneType))
    }
  }
}

object rvsyncss {
 def apply(din:UInt,clk:Clock) =withClock(clk){RegNext(withClock(clk){RegNext(din,0.U)},0.U)}
}

/////////////rvdffe //////////////////////////
/*
class class_rvdffe extends Module with RequireAsyncReset{
  val io = IO(new Bundle {
    val lsu_pkt_d = Input(new el2_load_cam_pkt_t)
    val lsu_pkt_m = Output(new el2_load_cam_pkt_t)
    val clk  = Input(Clock())
    val en  = Input(Bool())
    val scan_mode = Input(Bool())
  })
  io.lsu_pkt_m := rvdffe(io.lsu_pkt_d,io.en.asBool,io.clk,io.scan_mode.asBool)
}
object main extends App{
  println("Generate Verilog")
  chisel3.Driver.execute(args, ()=> new class_rvdffe)
}*/
