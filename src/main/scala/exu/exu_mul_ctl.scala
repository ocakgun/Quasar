package exu

import chisel3._
import chisel3.util._
import include._
import lib._


class exu_mul_ctl extends Module with RequireAsyncReset with lib {
  val io = IO(new Bundle{
    val scan_mode          = Input(Bool())
    val mul_p              = Flipped(Valid(new mul_pkt_t ))
    val rs1_in             = Input(UInt(32.W))
    val rs2_in             = Input(UInt(32.W))
    val result_x           = Output(UInt(32.W))
  })

  val rs1_ext_in           = WireInit(SInt(33.W), 0.S)
  val rs2_ext_in           = WireInit(SInt(33.W), 0.S)
  val rs1_x                = WireInit(SInt(33.W), 0.S)
  val rs2_x                = WireInit(SInt(33.W), 0.S)
  val prod_x               = WireInit(SInt(66.W), 0.S)
  val low_x                = WireInit(0.U(1.W))

  // *** Start - BitManip ***

  val   bitmanip_sel_d = WireInit(Bool(),0.B)
  val   bitmanip_sel_x = WireInit(Bool(),0.B)
  val   bitmanip_d     = WireInit(UInt(32.W),0.U)
  val   bitmanip_x     = WireInit(UInt(32.W),0.U)



  // ZBE
  val        ap_bext = WireInit(Bool(),0.B)
  val        ap_bdep = WireInit(Bool(),0.B)

  // ZBC
  val        ap_clmul   = WireInit(Bool(),0.B)
  val        ap_clmulh  = WireInit(Bool(),0.B)
  val        ap_clmulr  = WireInit(Bool(),0.B)

  // ZBP
  val         ap_grev    = WireInit(Bool(),0.B)
  val         ap_gorc    = WireInit(Bool(),0.B)
  val         ap_shfl    = WireInit(Bool(),0.B)
  val         ap_unshfl  = WireInit(Bool(),0.B)

  // ZBR
  val         ap_crc32_b   = WireInit(Bool(),0.B)
  val         ap_crc32_h   = WireInit(Bool(),0.B)
  val         ap_crc32_w   = WireInit(Bool(),0.B)
  val         ap_crc32c_b  = WireInit(Bool(),0.B)
  val         ap_crc32c_h  = WireInit(Bool(),0.B)
  val         ap_crc32c_w  = WireInit(Bool(),0.B)

  // ZBF
  val         ap_bfp = WireInit(Bool(),0.B)


  if (BITMANIP_ZBE == 1) {
     ap_bext         :=  io.mul_p.bits.bext
     ap_bdep         :=  io.mul_p.bits.bdep

  }
  else{
     ap_bext         :=  0.U
     ap_bdep         :=  0.U
  }

  if (BITMANIP_ZBC == 1) {
     ap_clmul        :=  io.mul_p.bits.clmul
     ap_clmulh       :=  io.mul_p.bits.clmulh
     ap_clmulr       :=  io.mul_p.bits.clmulr
  }
  else{
     ap_clmul        :=  0.U
     ap_clmulh       :=  0.U
     ap_clmulr       :=  0.U
  }

  if (BITMANIP_ZBP == 1) {
     ap_grev         :=  io.mul_p.bits.grev
     ap_gorc         :=  io.mul_p.bits.gorc
     ap_shfl         :=  io.mul_p.bits.shfl
     ap_unshfl       :=  io.mul_p.bits.unshfl
  }
  else{
     ap_grev         :=  0.U
     ap_gorc         :=  0.U
     ap_shfl         :=  0.U
     ap_unshfl       :=  0.U
  }

  if (BITMANIP_ZBR == 1) {
     ap_crc32_b      :=  io.mul_p.bits.crc32_b
     ap_crc32_h      :=  io.mul_p.bits.crc32_h
     ap_crc32_w      :=  io.mul_p.bits.crc32_w
     ap_crc32c_b     :=  io.mul_p.bits.crc32c_b
     ap_crc32c_h     :=  io.mul_p.bits.crc32c_h
     ap_crc32c_w     :=  io.mul_p.bits.crc32c_w
  }
  else{
     ap_crc32_b      :=  0.U
     ap_crc32_h      :=  0.U
     ap_crc32_w      :=  0.U
     ap_crc32c_b     :=  0.U
     ap_crc32c_h     :=  0.U
     ap_crc32c_w     :=  0.U
  }

  if (BITMANIP_ZBF == 1) {
     ap_bfp          :=  io.mul_p.bits.bfp
  }
  else{
     ap_bfp          :=  0.U
  }

  // *** End   - BitManip ***

  val mul_x_enable         = io.mul_p.valid
  val bit_x_enable         = io.mul_p.valid
  rs1_ext_in := Cat(io.mul_p.bits.rs1_sign & io.rs1_in(31),io.rs1_in).asSInt
  rs2_ext_in := Cat(io.mul_p.bits.rs2_sign & io.rs2_in(31),io.rs2_in).asSInt

  low_x := rvdffe (io.mul_p.bits.low, mul_x_enable.asBool,clock,io.scan_mode)
  rs1_x := rvdffe(rs1_ext_in, mul_x_enable.asBool,clock,io.scan_mode)
  rs2_x := rvdffe (rs2_ext_in, mul_x_enable.asBool,clock,io.scan_mode)

  prod_x := rs1_x  *  rs2_x
  io.result_x := Mux1H (Seq(!low_x.asBool -> prod_x(63,32), low_x.asBool -> prod_x(31,0)))
}
