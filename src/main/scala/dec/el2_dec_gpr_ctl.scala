package dec
import chisel3._
import scala.collection._
import chisel3.util._
import include._
import lib._

class el2_dec_gpr_ctl extends Module with RequireAsyncReset{
	val io		=IO(new el2_dec_gpr_ctl_IO)
	val w0v		=Wire(Vec(32,UInt(1.W)))
	val w1v		=Wire(Vec(32,UInt(1.W)))
	val w2v		=Wire(Vec(32,UInt(1.W)))
	val gpr_in	=Wire(Vec(32,UInt(32.W)))
	val gpr_out 	=Wire(Vec(32,UInt(32.W)))
	val gpr_wr_en	=Wire(UInt(32.W))	
	w0v(0):=0.U
	w1v(0):=0.U
	w2v(0):=0.U
	gpr_out(0):=0.U
	gpr_in(0):=0.U
	io.rd0:=0.U
	io.rd1:=0.U
	gpr_wr_en:= (w0v.reverse).reduceRight(Cat(_,_)) | (w1v.reverse).reduceRight(Cat(_,_)) | (w2v.reverse).reduceRight(Cat(_,_))
     // GPR Write logic 	
     for (j <-1 until 32){
         w0v(j)     := io.wen0  & (io.waddr0===j.asUInt)
         w1v(j)     := io.wen1  & (io.waddr1===j.asUInt)
         w2v(j)     := io.wen2  & (io.waddr2===j.asUInt)       
         gpr_in(j)  :=  (Fill(32,w0v(j)) & io.wd0) | (Fill(32,w1v(j)) & io.wd1) | (Fill(32,w2v(j)) & io.wd2)
		}
      // GPR Write Enables for power savings     
    for (j <-1 until 32){
 	  gpr_out(j):=rvdffe(gpr_in(j),gpr_wr_en(j),io.clk,io.scan_mode)
    }
      // GPR Read logic
	io.rd0:=Mux1H((1 until 32).map(i => (io.raddr0===i.U).asBool -> gpr_out(i)))
	io.rd1:=Mux1H((1 until 32).map(i => (io.raddr1===i.U).asBool -> gpr_out(i)))

    //val gpr_temp= for(i <-1 until 32) yield (Fill(32,io.raddr0===i.asUInt) & gpr_out(i),Fill(32,io.raddr1===i.asUInt) & gpr_out(i))	
   //	io.rd0:=gpr_temp.map(_._1).reduce(_|_) 
   //	io.rd1:=gpr_temp.map(_._2).reduce(_|_) 
}

class el2_dec_gpr_ctl_IO extends Bundle{
	val	raddr0=Input(UInt(5.W))      // logical read addresses
	val  	raddr1=Input(UInt(5.W))
	val	wen0=Input(UInt(1.W))         // write enable
	val  	waddr0=Input(UInt(5.W))       // write address
	val 	wd0=Input(UInt(32.W))          // write data
	val   	wen1=Input(UInt(1.W))         // write enable
	val  	waddr1=Input(UInt(5.W))       // write address
	val 	wd1=Input(UInt(32.W))          // write data
	val   	wen2=Input(UInt(1.W))         // write enable
	val  	waddr2=Input(UInt(5.W))       // write address
	val 	wd2=Input(UInt(32.W))          // write data
	val     clk=Input(Clock())
	val     rst_l=Input(Bool())
	val 	rd0=Output(UInt(32.W))         // read data
	val 	rd1=Output(UInt(32.W))
	val     scan_mode=Input(Bool()) 
}
object gpr_gen extends App{
println(chisel3.Driver.emitVerilog(new el2_dec_gpr_ctl))
}