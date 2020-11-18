import chisel3._
import chisel3.util._
class SweRV_Wrapper extends Module {
  val io = IO(new el2_swerv_bundle)
}
object SWERV_Wrp extends App {
  println((new chisel3.stage.ChiselStage).emitVerilog(new el2_swerv()))
}