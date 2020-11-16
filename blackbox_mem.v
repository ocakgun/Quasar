module blackbox_mem(
  input         clock,
  input         reset,
  input         io_clk,
  input         io_rst_l,
  input         io_dccm_clk_override,
  input         io_icm_clk_override,
  input         io_dec_tlu_core_ecc_disable,
  input         io_dccm_wren,
  input         io_dccm_rden,
  input  [15:0] io_dccm_wr_addr_lo,
  input  [15:0] io_dccm_wr_addr_hi,
  input  [15:0] io_dccm_rd_addr_lo,
  input  [15:0] io_dccm_rd_addr_hi,
  input  [38:0] io_dccm_wr_data_lo,
  input  [38:0] io_dccm_wr_data_hi,
  input  [15:0] io_iccm_rw_addr,
  input         io_iccm_buf_correct_ecc,
  input         io_iccm_correction_state,
  input         io_iccm_wren,
  input         io_iccm_rden,
  input  [2:0]  io_iccm_wr_size,
  input  [77:0] io_iccm_wr_data,
  input  [30:0] io_ic_rw_addr,
  input  [1:0]  io_ic_tag_valid,
  input  [1:0]  io_ic_wr_en,
  input         io_ic_rd_en,
  input  [63:0] io_ic_premux_data,
  input         io_ic_sel_premux_data,
  input  [70:0] io_ic_wr_data_0,
  input  [70:0] io_ic_wr_data_1,
  input  [70:0] io_ic_debug_wr_data,
  input  [11:0] io_ic_debug_addr,
  input         io_ic_debug_rd_en,
  input         io_ic_debug_wr_en,
  input         io_ic_debug_tag_array,
  input  [1:0]  io_ic_debug_way,
  input         io_scan_mode,
  output [38:0] io_dccm_rd_data_lo,
  output [38:0] io_dccm_rd_data_hi,
  output [63:0] io_iccm_rd_data,
  output [77:0] io_iccm_rd_data_ecc,
  output [70:0] io_ic_debug_rd_data,
  output [63:0] io_ic_rd_data,
  output [25:0] io_ictag_debug_rd_data,
  output [1:0]  io_ic_eccerr,
  output [1:0]  io_ic_parerr,
  output [1:0]  io_ic_rd_hit,
  output        io_ic_tag_perr
);
  wire  it_clk; // @[el2_mem.scala 89:18]
  wire  it_rst_l; // @[el2_mem.scala 89:18]
  wire  it_dccm_clk_override; // @[el2_mem.scala 89:18]
  wire  it_icm_clk_override; // @[el2_mem.scala 89:18]
  wire  it_dec_tlu_core_ecc_disable; // @[el2_mem.scala 89:18]
  wire  it_dccm_wren; // @[el2_mem.scala 89:18]
  wire  it_dccm_rden; // @[el2_mem.scala 89:18]
  wire [15:0] it_dccm_wr_addr_lo; // @[el2_mem.scala 89:18]
  wire [15:0] it_dccm_wr_addr_hi; // @[el2_mem.scala 89:18]
  wire [15:0] it_dccm_rd_addr_lo; // @[el2_mem.scala 89:18]
  wire [15:0] it_dccm_rd_addr_hi; // @[el2_mem.scala 89:18]
  wire [38:0] it_dccm_wr_data_lo; // @[el2_mem.scala 89:18]
  wire [38:0] it_dccm_wr_data_hi; // @[el2_mem.scala 89:18]
  wire [15:0] it_iccm_rw_addr; // @[el2_mem.scala 89:18]
  wire  it_iccm_buf_correct_ecc; // @[el2_mem.scala 89:18]
  wire  it_iccm_correction_state; // @[el2_mem.scala 89:18]
  wire  it_iccm_wren; // @[el2_mem.scala 89:18]
  wire  it_iccm_rden; // @[el2_mem.scala 89:18]
  wire [2:0] it_iccm_wr_size; // @[el2_mem.scala 89:18]
  wire [77:0] it_iccm_wr_data; // @[el2_mem.scala 89:18]
  wire [30:0] it_ic_rw_addr; // @[el2_mem.scala 89:18]
  wire [1:0] it_ic_tag_valid; // @[el2_mem.scala 89:18]
  wire [1:0] it_ic_wr_en; // @[el2_mem.scala 89:18]
  wire  it_ic_rd_en; // @[el2_mem.scala 89:18]
  wire [63:0] it_ic_premux_data; // @[el2_mem.scala 89:18]
  wire  it_ic_sel_premux_data; // @[el2_mem.scala 89:18]
  wire [70:0] it_ic_wr_data_0; // @[el2_mem.scala 89:18]
  wire [70:0] it_ic_wr_data_1; // @[el2_mem.scala 89:18]
  wire [70:0] it_ic_debug_wr_data; // @[el2_mem.scala 89:18]
  wire [11:0] it_ic_debug_addr; // @[el2_mem.scala 89:18]
  wire  it_ic_debug_rd_en; // @[el2_mem.scala 89:18]
  wire  it_ic_debug_wr_en; // @[el2_mem.scala 89:18]
  wire  it_ic_debug_tag_array; // @[el2_mem.scala 89:18]
  wire [1:0] it_ic_debug_way; // @[el2_mem.scala 89:18]
  wire  it_scan_mode; // @[el2_mem.scala 89:18]
  wire [38:0] it_dccm_rd_data_lo; // @[el2_mem.scala 89:18]
  wire [38:0] it_dccm_rd_data_hi; // @[el2_mem.scala 89:18]
  wire [63:0] it_iccm_rd_data; // @[el2_mem.scala 89:18]
  wire [77:0] it_iccm_rd_data_ecc; // @[el2_mem.scala 89:18]
  wire [70:0] it_ic_debug_rd_data; // @[el2_mem.scala 89:18]
  wire [63:0] it_ic_rd_data; // @[el2_mem.scala 89:18]
  wire [25:0] it_ictag_debug_rd_data; // @[el2_mem.scala 89:18]
  wire [1:0] it_ic_eccerr; // @[el2_mem.scala 89:18]
  wire [1:0] it_ic_parerr; // @[el2_mem.scala 89:18]
  wire [1:0] it_ic_rd_hit; // @[el2_mem.scala 89:18]
  wire  it_ic_tag_perr; // @[el2_mem.scala 89:18]
  el2_mem #(.ICACHE_BEAT_BITS(3), .ICCM_BITS(16), .ICACHE_NUM_WAYS(2), .DCCM_BYTE_WIDTH(4), .ICCM_BANK_INDEX_LO(4), .ICACHE_BANK_BITS(1), .DCCM_BITS(16), .ICACHE_BEAT_ADDR_HI(5), .ICCM_INDEX_BITS(12), .ICCM_BANK_HI(3), .ICACHE_BANKS_WAYS(2), .ICACHE_INDEX_HI(12), .DCCM_NUM_BANKS(4), .ICACHE_BANK_LO(3), .DCCM_ENABLE(1), .ICACHE_TAG_LO(13), .DCCM_WIDTH_BITS(2), .ICACHE_DATA_INDEX_LO(4), .ICCM_NUM_BANKS(4), .ICACHE_ECC(1), .ICACHE_ENABLE(1), .DCCM_BANK_BITS(2), .ICCM_ENABLE(1), .ICCM_BANK_BITS(2), .ICACHE_TAG_DEPTH(128), .ICACHE_WAYPACK(0), .DCCM_SIZE(64), .DCCM_FDATA_WIDTH(39), .ICACHE_TAG_INDEX_LO(6), .ICACHE_DATA_DEPTH(512)) it ( // @[el2_mem.scala 89:18]
    .clk(it_clk),
    .rst_l(it_rst_l),
    .dccm_clk_override(it_dccm_clk_override),
    .icm_clk_override(it_icm_clk_override),
    .dec_tlu_core_ecc_disable(it_dec_tlu_core_ecc_disable),
    .dccm_wren(it_dccm_wren),
    .dccm_rden(it_dccm_rden),
    .dccm_wr_addr_lo(it_dccm_wr_addr_lo),
    .dccm_wr_addr_hi(it_dccm_wr_addr_hi),
    .dccm_rd_addr_lo(it_dccm_rd_addr_lo),
    .dccm_rd_addr_hi(it_dccm_rd_addr_hi),
    .dccm_wr_data_lo(it_dccm_wr_data_lo),
    .dccm_wr_data_hi(it_dccm_wr_data_hi),
    .iccm_rw_addr(it_iccm_rw_addr),
    .iccm_buf_correct_ecc(it_iccm_buf_correct_ecc),
    .iccm_correction_state(it_iccm_correction_state),
    .iccm_wren(it_iccm_wren),
    .iccm_rden(it_iccm_rden),
    .iccm_wr_size(it_iccm_wr_size),
    .iccm_wr_data(it_iccm_wr_data),
    .ic_rw_addr(it_ic_rw_addr),
    .ic_tag_valid(it_ic_tag_valid),
    .ic_wr_en(it_ic_wr_en),
    .ic_rd_en(it_ic_rd_en),
    .ic_premux_data(it_ic_premux_data),
    .ic_sel_premux_data(it_ic_sel_premux_data),
    .ic_wr_data_0(it_ic_wr_data_0),
    .ic_wr_data_1(it_ic_wr_data_1),
    .ic_debug_wr_data(it_ic_debug_wr_data),
    .ic_debug_addr(it_ic_debug_addr),
    .ic_debug_rd_en(it_ic_debug_rd_en),
    .ic_debug_wr_en(it_ic_debug_wr_en),
    .ic_debug_tag_array(it_ic_debug_tag_array),
    .ic_debug_way(it_ic_debug_way),
    .scan_mode(it_scan_mode),
    .dccm_rd_data_lo(it_dccm_rd_data_lo),
    .dccm_rd_data_hi(it_dccm_rd_data_hi),
    .iccm_rd_data(it_iccm_rd_data),
    .iccm_rd_data_ecc(it_iccm_rd_data_ecc),
    .ic_debug_rd_data(it_ic_debug_rd_data),
    .ic_rd_data(it_ic_rd_data),
    .ictag_debug_rd_data(it_ictag_debug_rd_data),
    .ic_eccerr(it_ic_eccerr),
    .ic_parerr(it_ic_parerr),
    .ic_rd_hit(it_ic_rd_hit),
    .ic_tag_perr(it_ic_tag_perr)
  );
  assign io_dccm_rd_data_lo = it_dccm_rd_data_lo; // @[el2_mem.scala 90:6]
  assign io_dccm_rd_data_hi = it_dccm_rd_data_hi; // @[el2_mem.scala 90:6]
  assign io_iccm_rd_data = it_iccm_rd_data; // @[el2_mem.scala 90:6]
  assign io_iccm_rd_data_ecc = it_iccm_rd_data_ecc; // @[el2_mem.scala 90:6]
  assign io_ic_debug_rd_data = it_ic_debug_rd_data; // @[el2_mem.scala 90:6]
  assign io_ic_rd_data = it_ic_rd_data; // @[el2_mem.scala 90:6]
  assign io_ictag_debug_rd_data = it_ictag_debug_rd_data; // @[el2_mem.scala 90:6]
  assign io_ic_eccerr = it_ic_eccerr; // @[el2_mem.scala 90:6]
  assign io_ic_parerr = it_ic_parerr; // @[el2_mem.scala 90:6]
  assign io_ic_rd_hit = it_ic_rd_hit; // @[el2_mem.scala 90:6]
  assign io_ic_tag_perr = it_ic_tag_perr; // @[el2_mem.scala 90:6]
  assign it_clk = io_clk; // @[el2_mem.scala 90:6]
  assign it_rst_l = io_rst_l; // @[el2_mem.scala 90:6]
  assign it_dccm_clk_override = io_dccm_clk_override; // @[el2_mem.scala 90:6]
  assign it_icm_clk_override = io_icm_clk_override; // @[el2_mem.scala 90:6]
  assign it_dec_tlu_core_ecc_disable = io_dec_tlu_core_ecc_disable; // @[el2_mem.scala 90:6]
  assign it_dccm_wren = io_dccm_wren; // @[el2_mem.scala 90:6]
  assign it_dccm_rden = io_dccm_rden; // @[el2_mem.scala 90:6]
  assign it_dccm_wr_addr_lo = io_dccm_wr_addr_lo; // @[el2_mem.scala 90:6]
  assign it_dccm_wr_addr_hi = io_dccm_wr_addr_hi; // @[el2_mem.scala 90:6]
  assign it_dccm_rd_addr_lo = io_dccm_rd_addr_lo; // @[el2_mem.scala 90:6]
  assign it_dccm_rd_addr_hi = io_dccm_rd_addr_hi; // @[el2_mem.scala 90:6]
  assign it_dccm_wr_data_lo = io_dccm_wr_data_lo; // @[el2_mem.scala 90:6]
  assign it_dccm_wr_data_hi = io_dccm_wr_data_hi; // @[el2_mem.scala 90:6]
  assign it_iccm_rw_addr = io_iccm_rw_addr; // @[el2_mem.scala 90:6]
  assign it_iccm_buf_correct_ecc = io_iccm_buf_correct_ecc; // @[el2_mem.scala 90:6]
  assign it_iccm_correction_state = io_iccm_correction_state; // @[el2_mem.scala 90:6]
  assign it_iccm_wren = io_iccm_wren; // @[el2_mem.scala 90:6]
  assign it_iccm_rden = io_iccm_rden; // @[el2_mem.scala 90:6]
  assign it_iccm_wr_size = io_iccm_wr_size; // @[el2_mem.scala 90:6]
  assign it_iccm_wr_data = io_iccm_wr_data; // @[el2_mem.scala 90:6]
  assign it_ic_rw_addr = io_ic_rw_addr; // @[el2_mem.scala 90:6]
  assign it_ic_tag_valid = io_ic_tag_valid; // @[el2_mem.scala 90:6]
  assign it_ic_wr_en = io_ic_wr_en; // @[el2_mem.scala 90:6]
  assign it_ic_rd_en = io_ic_rd_en; // @[el2_mem.scala 90:6]
  assign it_ic_premux_data = io_ic_premux_data; // @[el2_mem.scala 90:6]
  assign it_ic_sel_premux_data = io_ic_sel_premux_data; // @[el2_mem.scala 90:6]
  assign it_ic_wr_data_0 = io_ic_wr_data_0; // @[el2_mem.scala 90:6]
  assign it_ic_wr_data_1 = io_ic_wr_data_1; // @[el2_mem.scala 90:6]
  assign it_ic_debug_wr_data = io_ic_debug_wr_data; // @[el2_mem.scala 90:6]
  assign it_ic_debug_addr = io_ic_debug_addr; // @[el2_mem.scala 90:6]
  assign it_ic_debug_rd_en = io_ic_debug_rd_en; // @[el2_mem.scala 90:6]
  assign it_ic_debug_wr_en = io_ic_debug_wr_en; // @[el2_mem.scala 90:6]
  assign it_ic_debug_tag_array = io_ic_debug_tag_array; // @[el2_mem.scala 90:6]
  assign it_ic_debug_way = io_ic_debug_way; // @[el2_mem.scala 90:6]
  assign it_scan_mode = io_scan_mode; // @[el2_mem.scala 90:6]
endmodule
