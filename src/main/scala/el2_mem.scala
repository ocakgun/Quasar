package blackbox
import chisel3._
import lib._

class el2_mem extends Module with el2_lib {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst_l = Input(Bool())
    val dccm_clk_override = Input(Bool())
    val icm_clk_override = Input(Bool())
    val dec_tlu_core_ecc_disable = Input(Bool())
    val dccm_wren = Input(Bool())
    val dccm_rden = Input(Bool())
    val dccm_wr_addr_lo = Input(UInt(DCCM_BITS.W))
    val dccm_wr_addr_hi = Input(UInt(DCCM_BITS.W))
    val dccm_rd_addr_lo = Input(UInt(DCCM_BITS.W))
    val dccm_rd_addr_hi = Input(UInt(DCCM_BITS.W))
    val dccm_wr_data_lo = Input(UInt(DCCM_FDATA_WIDTH.W))
    val dccm_wr_data_hi = Input(UInt(DCCM_FDATA_WIDTH.W))
    val iccm_rw_addr = Input(UInt(ICCM_BITS.W))
    val iccm_buf_correct_ecc = Input(Bool())
    val iccm_correction_state = Input(Bool())
    val iccm_wren = Input(Bool())
    val iccm_rden = Input(Bool())
    val iccm_wr_size = Input(UInt(3.W))
    val iccm_wr_data = Input(UInt(78.W))
    val ic_rw_addr = Input(UInt(31.W))
    val ic_tag_valid = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_wr_en = Input(UInt(ICACHE_NUM_WAYS.W))
    val ic_rd_en = Input(Bool())
    val ic_premux_data = Input(UInt(64.W))
    val ic_sel_premux_data = Input(Bool())
    val ic_wr_data = Input(Vec(ICACHE_BANKS_WAY, UInt(71.W)))
    val ic_debug_wr_data = Input(UInt(71.W))
    val ic_debug_addr = Input(UInt(ICACHE_INDEX_HI.W))
    val ic_debug_rd_en = Input(Bool())
    val ic_debug_wr_en = Input(Bool())
    val ic_debug_tag_array = Input(Bool())
    val ic_debug_way = Input(UInt(ICACHE_NUM_WAYS.W))
    val scan_mode = Input(Bool())
    val dccm_rd_data_lo = Output(UInt(DCCM_FDATA_WIDTH.W))
    val dccm_rd_data_hi = Output(UInt(DCCM_FDATA_WIDTH.W))
    val iccm_rd_data = Output(UInt(64.W))
    val iccm_rd_data_ecc = Output(UInt(78.W))
    val ic_debug_rd_data = Output(UInt(71.W))
    val ic_rd_data = Output(UInt(64.W))
    val ictag_debug_rd_data = Output(UInt(26.W))
    val ic_eccerr = Output(UInt(ICACHE_BANKS_WAY.W))
    val ic_parerr = Output(UInt(ICACHE_BANKS_WAY.W))
    val ic_rd_hit = Output(UInt(ICACHE_NUM_WAYS.W))
    val ic_tag_perr = Output(Bool())
  })
  val it = Module(new el2_mem)
  it.io.clk := io.clk
  it.io.rst_l := io.rst_l
  it.io.dccm_clk_override := io.dccm_clk_override
  it.io.icm_clk_override := io.icm_clk_override
  it.io.dec_tlu_core_ecc_disable := io.dec_tlu_core_ecc_disable
  it.io.dccm_wren := io.dccm_wren
  it.io.dccm_rden := io.dccm_rden
  it.io.dccm_wr_addr_lo := io.dccm_wr_addr_lo
  it.io.dccm_wr_addr_hi := io.dccm_wr_addr_hi
  it.io.dccm_rd_addr_lo := io.dccm_rd_addr_lo
  it.io.dccm_rd_addr_hi := io.dccm_rd_addr_hi
  it.io.dccm_wr_data_lo := io.dccm_wr_data_lo
  it.io.dccm_wr_data_hi := io.dccm_wr_data_hi
  it.io.iccm_rw_addr := io.iccm_rw_addr
  it.io.iccm_buf_correct_ecc := io.iccm_buf_correct_ecc
  it.io.iccm_correction_state := io.iccm_correction_state
  it.io.iccm_wren := io.iccm_wren
  it.io.iccm_rden := io.iccm_rden
  it.io.iccm_wr_size := io.iccm_wr_size
  it.io.iccm_wr_data := io.iccm_wr_data
  it.io.ic_rw_addr := io.ic_rw_addr
  it.io.ic_tag_valid := io.ic_tag_valid
  it.io.ic_wr_en := io.ic_wr_en
  it.io.ic_rd_en := io.ic_rd_en
  it.io.ic_premux_data := io.ic_premux_data
  it.io.ic_sel_premux_data := io.ic_sel_premux_data
  it.io.ic_wr_data := io.ic_wr_data
  it.io.ic_debug_wr_data := io.ic_debug_wr_data
  it.io.ic_debug_addr := io.ic_debug_addr
  it.io.ic_debug_rd_en := io.ic_debug_rd_en
  it.io.ic_debug_wr_en := io.ic_debug_wr_en
  it.io.ic_debug_tag_array := io.ic_debug_tag_array
  it.io.ic_debug_way := io.ic_debug_way
  it.io.scan_mode := io.scan_mode
  io.dccm_rd_data_lo := it.io.dccm_rd_data_lo
  io.dccm_rd_data_hi := it.io.dccm_rd_data_hi
  io.iccm_rd_data := it.io.iccm_rd_data
  io.iccm_rd_data_ecc := it.io.iccm_rd_data_ecc
  io.ic_debug_rd_data := it.io.ic_debug_rd_data
  io.ic_rd_data := it.io.ic_rd_data
  io.ictag_debug_rd_data := it.io.ictag_debug_rd_data
  io.ic_eccerr := it.io.ic_eccerr
  io.ic_parerr := it.io.ic_parerr
  io.ic_rd_hit := it.io.ic_rd_hit
  io.ic_tag_perr := it.io.ic_tag_perr
}

object mem extends App {
  println((new chisel3.stage.ChiselStage).emitVerilog(new el2_mem))
}