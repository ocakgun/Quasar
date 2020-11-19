;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit blackbox_mem : 
  extmodule el2_mem : 
    input clock : UInt<1>
    input reset : UInt<1>
    input dccm_clk_override : UInt<1>
    input icm_clk_override : UInt<1>
    input dec_tlu_core_ecc_disable : UInt<1>
    input dccm_wren : UInt<1>
    input dccm_rden : UInt<1>
    input dccm_wr_addr_lo : UInt<16>
    input dccm_wr_addr_hi : UInt<16>
    input dccm_rd_addr_lo : UInt<16>
    input dccm_rd_addr_hi : UInt<16>
    input dccm_wr_data_lo : UInt<39>
    input dccm_wr_data_hi : UInt<39>
    output dccm_rd_data_lo : UInt<39>
    input iccm_rw_addr : UInt<15>
    input iccm_buf_correct_ecc : UInt<1>
    input iccm_correction_state : UInt<1>
    input iccm_wren : UInt<1>
    input iccm_rden : UInt<1>
    input iccm_wr_size : UInt<3>
    input iccm_wr_data : UInt<78>
    input ic_rw_addr : UInt<31>
    input ic_tag_valid : UInt<2>
    input ic_wr_en : UInt<2>
    input ic_rd_en : UInt<1>
    input ic_premux_data : UInt<64>
    input ic_sel_premux_data : UInt<1>
    input ic_wr_data : UInt<71>[2]
    input ic_debug_wr_data : UInt<71>
    input ic_debug_addr : UInt<10>
    input ic_debug_rd_en : UInt<1>
    input ic_debug_wr_en : UInt<1>
    input ic_debug_tag_array : UInt<1>
    input ic_debug_way : UInt<2>
    input scan_mode : UInt<1>
    output iccm_rd_data_ecc : UInt<78>
    output dccm_rd_data_hi : UInt<39>
    output ic_rd_data : UInt<64>
    output ictag_debug_rd_data : UInt<26>
    output ic_eccerr : UInt<2>
    output ic_parerr : UInt<2>
    output ic_rd_hit : UInt<2>
    output ic_tag_perr : UInt<1>
    output ic_debug_rd_data : UInt<71>
    output iccm_rd_data : UInt<64>
    
    defname = el2_mem
    parameter ICACHE_BEAT_BITS = 3
    parameter ICCM_BITS = 16
    parameter ICACHE_NUM_WAYS = 2
    parameter DCCM_BYTE_WIDTH = 4
    parameter ICCM_BANK_INDEX_LO = 4
    parameter ICACHE_BANK_BITS = 1
    parameter DCCM_BITS = 16
    parameter ICACHE_BEAT_ADDR_HI = 5
    parameter ICCM_INDEX_BITS = 12
    parameter ICCM_BANK_HI = 3
    parameter ICACHE_BANKS_WAYS = 2
    parameter ICACHE_INDEX_HI = 12
    parameter DCCM_NUM_BANKS = 4
    parameter ICACHE_BANK_LO = 3
    parameter DCCM_ENABLE = 1
    parameter ICACHE_TAG_LO = 13
    parameter DCCM_WIDTH_BITS = 2
    parameter ICACHE_DATA_INDEX_LO = 4
    parameter ICCM_NUM_BANKS = 4
    parameter ICACHE_ECC = 1
    parameter ICACHE_ENABLE = 1
    parameter DCCM_BANK_BITS = 2
    parameter ICCM_ENABLE = 1
    parameter ICCM_BANK_BITS = 2
    parameter ICACHE_TAG_DEPTH = 128
    parameter ICACHE_WAYPACK = 0
    parameter DCCM_SIZE = 64
    parameter DCCM_FDATA_WIDTH = 39
    parameter ICACHE_TAG_INDEX_LO = 6
    parameter ICACHE_DATA_DEPTH = 512
    
  module blackbox_mem : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip clock : UInt<1>, flip reset : UInt<1>, flip dccm_clk_override : UInt<1>, flip icm_clk_override : UInt<1>, flip dec_tlu_core_ecc_disable : UInt<1>, flip dccm_wren : UInt<1>, flip dccm_rden : UInt<1>, flip dccm_wr_addr_lo : UInt<16>, flip dccm_wr_addr_hi : UInt<16>, flip dccm_rd_addr_lo : UInt<16>, flip dccm_rd_addr_hi : UInt<16>, flip dccm_wr_data_lo : UInt<39>, flip dccm_wr_data_hi : UInt<39>, dccm_rd_data_lo : UInt<39>, flip iccm_rw_addr : UInt<15>, flip iccm_buf_correct_ecc : UInt<1>, flip iccm_correction_state : UInt<1>, flip iccm_wren : UInt<1>, flip iccm_rden : UInt<1>, flip iccm_wr_size : UInt<3>, flip iccm_wr_data : UInt<78>, flip ic_rw_addr : UInt<31>, flip ic_tag_valid : UInt<2>, flip ic_wr_en : UInt<2>, flip ic_rd_en : UInt<1>, flip ic_premux_data : UInt<64>, flip ic_sel_premux_data : UInt<1>, flip ic_wr_data : UInt<71>[2], flip ic_debug_wr_data : UInt<71>, flip ic_debug_addr : UInt<10>, flip ic_debug_rd_en : UInt<1>, flip ic_debug_wr_en : UInt<1>, flip ic_debug_tag_array : UInt<1>, flip ic_debug_way : UInt<2>, flip scan_mode : UInt<1>, iccm_rd_data_ecc : UInt<78>, dccm_rd_data_hi : UInt<39>, ic_rd_data : UInt<64>, ictag_debug_rd_data : UInt<26>, ic_eccerr : UInt<2>, ic_parerr : UInt<2>, ic_rd_hit : UInt<2>, ic_tag_perr : UInt<1>, ic_debug_rd_data : UInt<71>, iccm_rd_data : UInt<64>}
    
    inst it of el2_mem @[el2_mem.scala 95:18]
    it.iccm_rd_data is invalid
    it.ic_debug_rd_data is invalid
    it.ic_tag_perr is invalid
    it.ic_rd_hit is invalid
    it.ic_parerr is invalid
    it.ic_eccerr is invalid
    it.ictag_debug_rd_data is invalid
    it.ic_rd_data is invalid
    it.dccm_rd_data_hi is invalid
    it.iccm_rd_data_ecc is invalid
    it.scan_mode is invalid
    it.ic_debug_way is invalid
    it.ic_debug_tag_array is invalid
    it.ic_debug_wr_en is invalid
    it.ic_debug_rd_en is invalid
    it.ic_debug_addr is invalid
    it.ic_debug_wr_data is invalid
    it.ic_wr_data is invalid
    it.ic_sel_premux_data is invalid
    it.ic_premux_data is invalid
    it.ic_rd_en is invalid
    it.ic_wr_en is invalid
    it.ic_tag_valid is invalid
    it.ic_rw_addr is invalid
    it.iccm_wr_data is invalid
    it.iccm_wr_size is invalid
    it.iccm_rden is invalid
    it.iccm_wren is invalid
    it.iccm_correction_state is invalid
    it.iccm_buf_correct_ecc is invalid
    it.iccm_rw_addr is invalid
    it.dccm_rd_data_lo is invalid
    it.dccm_wr_data_hi is invalid
    it.dccm_wr_data_lo is invalid
    it.dccm_rd_addr_hi is invalid
    it.dccm_rd_addr_lo is invalid
    it.dccm_wr_addr_hi is invalid
    it.dccm_wr_addr_lo is invalid
    it.dccm_rden is invalid
    it.dccm_wren is invalid
    it.dec_tlu_core_ecc_disable is invalid
    it.icm_clk_override is invalid
    it.dccm_clk_override is invalid
    it.reset is invalid
    it.clock is invalid
    io.iccm_rd_data <= it.iccm_rd_data @[el2_mem.scala 96:6]
    io.ic_debug_rd_data <= it.ic_debug_rd_data @[el2_mem.scala 96:6]
    io.ic_tag_perr <= it.ic_tag_perr @[el2_mem.scala 96:6]
    io.ic_rd_hit <= it.ic_rd_hit @[el2_mem.scala 96:6]
    io.ic_parerr <= it.ic_parerr @[el2_mem.scala 96:6]
    io.ic_eccerr <= it.ic_eccerr @[el2_mem.scala 96:6]
    io.ictag_debug_rd_data <= it.ictag_debug_rd_data @[el2_mem.scala 96:6]
    io.ic_rd_data <= it.ic_rd_data @[el2_mem.scala 96:6]
    io.dccm_rd_data_hi <= it.dccm_rd_data_hi @[el2_mem.scala 96:6]
    io.iccm_rd_data_ecc <= it.iccm_rd_data_ecc @[el2_mem.scala 96:6]
    it.scan_mode <= io.scan_mode @[el2_mem.scala 96:6]
    it.ic_debug_way <= io.ic_debug_way @[el2_mem.scala 96:6]
    it.ic_debug_tag_array <= io.ic_debug_tag_array @[el2_mem.scala 96:6]
    it.ic_debug_wr_en <= io.ic_debug_wr_en @[el2_mem.scala 96:6]
    it.ic_debug_rd_en <= io.ic_debug_rd_en @[el2_mem.scala 96:6]
    it.ic_debug_addr <= io.ic_debug_addr @[el2_mem.scala 96:6]
    it.ic_debug_wr_data <= io.ic_debug_wr_data @[el2_mem.scala 96:6]
    it.ic_wr_data[0] <= io.ic_wr_data[0] @[el2_mem.scala 96:6]
    it.ic_wr_data[1] <= io.ic_wr_data[1] @[el2_mem.scala 96:6]
    it.ic_sel_premux_data <= io.ic_sel_premux_data @[el2_mem.scala 96:6]
    it.ic_premux_data <= io.ic_premux_data @[el2_mem.scala 96:6]
    it.ic_rd_en <= io.ic_rd_en @[el2_mem.scala 96:6]
    it.ic_wr_en <= io.ic_wr_en @[el2_mem.scala 96:6]
    it.ic_tag_valid <= io.ic_tag_valid @[el2_mem.scala 96:6]
    it.ic_rw_addr <= io.ic_rw_addr @[el2_mem.scala 96:6]
    it.iccm_wr_data <= io.iccm_wr_data @[el2_mem.scala 96:6]
    it.iccm_wr_size <= io.iccm_wr_size @[el2_mem.scala 96:6]
    it.iccm_rden <= io.iccm_rden @[el2_mem.scala 96:6]
    it.iccm_wren <= io.iccm_wren @[el2_mem.scala 96:6]
    it.iccm_correction_state <= io.iccm_correction_state @[el2_mem.scala 96:6]
    it.iccm_buf_correct_ecc <= io.iccm_buf_correct_ecc @[el2_mem.scala 96:6]
    it.iccm_rw_addr <= io.iccm_rw_addr @[el2_mem.scala 96:6]
    io.dccm_rd_data_lo <= it.dccm_rd_data_lo @[el2_mem.scala 96:6]
    it.dccm_wr_data_hi <= io.dccm_wr_data_hi @[el2_mem.scala 96:6]
    it.dccm_wr_data_lo <= io.dccm_wr_data_lo @[el2_mem.scala 96:6]
    it.dccm_rd_addr_hi <= io.dccm_rd_addr_hi @[el2_mem.scala 96:6]
    it.dccm_rd_addr_lo <= io.dccm_rd_addr_lo @[el2_mem.scala 96:6]
    it.dccm_wr_addr_hi <= io.dccm_wr_addr_hi @[el2_mem.scala 96:6]
    it.dccm_wr_addr_lo <= io.dccm_wr_addr_lo @[el2_mem.scala 96:6]
    it.dccm_rden <= io.dccm_rden @[el2_mem.scala 96:6]
    it.dccm_wren <= io.dccm_wren @[el2_mem.scala 96:6]
    it.dec_tlu_core_ecc_disable <= io.dec_tlu_core_ecc_disable @[el2_mem.scala 96:6]
    it.icm_clk_override <= io.icm_clk_override @[el2_mem.scala 96:6]
    it.dccm_clk_override <= io.dccm_clk_override @[el2_mem.scala 96:6]
    it.reset <= io.reset @[el2_mem.scala 96:6]
    it.clock <= io.clock @[el2_mem.scala 96:6]
    
