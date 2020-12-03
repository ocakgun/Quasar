module rvclkhdr(
  output  io_l1clk,
  input   io_clk,
  input   io_en,
  input   io_scan_mode
);
  wire  clkhdr_Q; // @[el2_lib.scala 474:26]
  wire  clkhdr_CK; // @[el2_lib.scala 474:26]
  wire  clkhdr_EN; // @[el2_lib.scala 474:26]
  wire  clkhdr_SE; // @[el2_lib.scala 474:26]
  gated_latch clkhdr ( // @[el2_lib.scala 474:26]
    .Q(clkhdr_Q),
    .CK(clkhdr_CK),
    .EN(clkhdr_EN),
    .SE(clkhdr_SE)
  );
  assign io_l1clk = clkhdr_Q; // @[el2_lib.scala 475:14]
  assign clkhdr_CK = io_clk; // @[el2_lib.scala 476:18]
  assign clkhdr_EN = io_en; // @[el2_lib.scala 477:18]
  assign clkhdr_SE = io_scan_mode; // @[el2_lib.scala 478:18]
endmodule
module el2_dma_ctrl(
  input         clock,
  input         reset,
  input         io_free_clk,
  input         io_dma_bus_clk_en,
  input         io_clk_override,
  input         io_scan_mode,
  input  [31:0] io_dbg_cmd_addr,
  input  [31:0] io_dbg_cmd_wrdata,
  input         io_dbg_cmd_valid,
  input         io_dbg_cmd_write,
  input  [1:0]  io_dbg_cmd_type,
  input  [1:0]  io_dbg_cmd_size,
  input         io_dbg_dma_bubble,
  output        io_dma_dbg_ready,
  output        io_dma_dbg_cmd_done,
  output        io_dma_dbg_cmd_fail,
  output [31:0] io_dma_dbg_rddata,
  output        io_dma_dccm_req,
  output        io_dma_iccm_req,
  output [2:0]  io_dma_mem_tag,
  output [31:0] io_dma_mem_addr,
  output [2:0]  io_dma_mem_sz,
  output        io_dma_mem_write,
  output [63:0] io_dma_mem_wdata,
  input         io_dccm_dma_rvalid,
  input         io_dccm_dma_ecc_error,
  input  [2:0]  io_dccm_dma_rtag,
  input  [63:0] io_dccm_dma_rdata,
  input         io_iccm_dma_rvalid,
  input         io_iccm_dma_ecc_error,
  input  [2:0]  io_iccm_dma_rtag,
  input  [63:0] io_iccm_dma_rdata,
  output        io_dma_dccm_stall_any,
  output        io_dma_iccm_stall_any,
  input         io_dccm_ready,
  input         io_iccm_ready,
  input  [2:0]  io_dec_tlu_dma_qos_prty,
  output        io_dma_pmu_dccm_read,
  output        io_dma_pmu_dccm_write,
  output        io_dma_pmu_any_read,
  output        io_dma_pmu_any_write,
  input         io_dma_axi_awvalid,
  output        io_dma_axi_awready,
  input         io_dma_axi_awid,
  input  [31:0] io_dma_axi_awaddr,
  input  [2:0]  io_dma_axi_awsize,
  input         io_dma_axi_wvalid,
  output        io_dma_axi_wready,
  input  [63:0] io_dma_axi_wdata,
  input  [7:0]  io_dma_axi_wstrb,
  output        io_dma_axi_bvalid,
  input         io_dma_axi_bready,
  output [1:0]  io_dma_axi_bresp,
  output        io_dma_axi_bid,
  input         io_dma_axi_arvalid,
  output        io_dma_axi_arready,
  input         io_dma_axi_arid,
  input  [31:0] io_dma_axi_araddr,
  input  [2:0]  io_dma_axi_arsize,
  output        io_dma_axi_rvalid,
  input         io_dma_axi_rready,
  output        io_dma_axi_rid,
  output [63:0] io_dma_axi_rdata,
  output [1:0]  io_dma_axi_rresp,
  output        io_dma_axi_rlast
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [63:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [63:0] _RAND_65;
  reg [63:0] _RAND_66;
  reg [63:0] _RAND_67;
  reg [63:0] _RAND_68;
  reg [63:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
`endif // RANDOMIZE_REG_INIT
  wire  rvclkhdr_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_1_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_1_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_1_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_1_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_2_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_2_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_2_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_2_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_3_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_3_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_3_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_3_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_4_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_4_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_4_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_4_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_5_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_5_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_5_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_5_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_6_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_6_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_6_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_6_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_7_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_7_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_7_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_7_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_8_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_8_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_8_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_8_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_9_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_9_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_9_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_9_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  dma_buffer_c1cgc_io_l1clk; // @[el2_dma_ctrl.scala 449:32]
  wire  dma_buffer_c1cgc_io_clk; // @[el2_dma_ctrl.scala 449:32]
  wire  dma_buffer_c1cgc_io_en; // @[el2_dma_ctrl.scala 449:32]
  wire  dma_buffer_c1cgc_io_scan_mode; // @[el2_dma_ctrl.scala 449:32]
  wire  dma_free_cgc_io_l1clk; // @[el2_dma_ctrl.scala 455:28]
  wire  dma_free_cgc_io_clk; // @[el2_dma_ctrl.scala 455:28]
  wire  dma_free_cgc_io_en; // @[el2_dma_ctrl.scala 455:28]
  wire  dma_free_cgc_io_scan_mode; // @[el2_dma_ctrl.scala 455:28]
  wire  dma_bus_cgc_io_l1clk; // @[el2_dma_ctrl.scala 461:27]
  wire  dma_bus_cgc_io_clk; // @[el2_dma_ctrl.scala 461:27]
  wire  dma_bus_cgc_io_en; // @[el2_dma_ctrl.scala 461:27]
  wire  dma_bus_cgc_io_scan_mode; // @[el2_dma_ctrl.scala 461:27]
  wire  rvclkhdr_10_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_10_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_10_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_10_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  dma_free_clk = dma_free_cgc_io_l1clk; // @[el2_dma_ctrl.scala 230:26 el2_dma_ctrl.scala 459:29]
  reg [2:0] RdPtr; // @[Reg.scala 27:20]
  reg [31:0] fifo_addr_4; // @[el2_lib.scala 514:16]
  reg [31:0] fifo_addr_3; // @[el2_lib.scala 514:16]
  reg [31:0] fifo_addr_2; // @[el2_lib.scala 514:16]
  reg [31:0] fifo_addr_1; // @[el2_lib.scala 514:16]
  reg [31:0] fifo_addr_0; // @[el2_lib.scala 514:16]
  wire [31:0] _GEN_60 = 3'h1 == RdPtr ? fifo_addr_1 : fifo_addr_0; // @[el2_dma_ctrl.scala 415:20]
  wire [31:0] _GEN_61 = 3'h2 == RdPtr ? fifo_addr_2 : _GEN_60; // @[el2_dma_ctrl.scala 415:20]
  wire [31:0] _GEN_62 = 3'h3 == RdPtr ? fifo_addr_3 : _GEN_61; // @[el2_dma_ctrl.scala 415:20]
  wire [31:0] dma_mem_addr_int = 3'h4 == RdPtr ? fifo_addr_4 : _GEN_62; // @[el2_dma_ctrl.scala 415:20]
  wire  dma_mem_addr_in_dccm = dma_mem_addr_int[31:16] == 16'hf004; // @[el2_lib.scala 501:39]
  wire  dma_mem_addr_in_pic = dma_mem_addr_int[31:15] == 17'h1e018; // @[el2_lib.scala 501:39]
  wire  dma_mem_addr_in_iccm = dma_mem_addr_int[31:16] == 16'hee00; // @[el2_lib.scala 501:39]
  wire  dma_bus_clk = dma_bus_cgc_io_l1clk; // @[el2_dma_ctrl.scala 232:25 el2_dma_ctrl.scala 465:28]
  reg  wrbuf_vld; // @[el2_dma_ctrl.scala 475:59]
  reg  wrbuf_data_vld; // @[el2_dma_ctrl.scala 477:59]
  wire  _T_1261 = wrbuf_vld & wrbuf_data_vld; // @[el2_dma_ctrl.scala 533:43]
  reg  rdbuf_vld; // @[el2_dma_ctrl.scala 501:47]
  wire  _T_1262 = _T_1261 & rdbuf_vld; // @[el2_dma_ctrl.scala 533:60]
  reg  axi_mstr_priority; // @[Reg.scala 27:20]
  wire  axi_mstr_sel = _T_1262 ? axi_mstr_priority : _T_1261; // @[el2_dma_ctrl.scala 533:31]
  reg [31:0] wrbuf_addr; // @[el2_lib.scala 514:16]
  reg [31:0] rdbuf_addr; // @[el2_lib.scala 514:16]
  wire [31:0] bus_cmd_addr = axi_mstr_sel ? wrbuf_addr : rdbuf_addr; // @[el2_dma_ctrl.scala 523:43]
  wire [2:0] _GEN_90 = {{2'd0}, io_dbg_cmd_addr[2]}; // @[el2_dma_ctrl.scala 257:76]
  wire [3:0] _T_17 = 3'h4 * _GEN_90; // @[el2_dma_ctrl.scala 257:76]
  wire [18:0] _T_18 = 19'hf << _T_17; // @[el2_dma_ctrl.scala 257:68]
  reg [7:0] wrbuf_byteen; // @[Reg.scala 27:20]
  wire [18:0] _T_20 = io_dbg_cmd_valid ? _T_18 : {{11'd0}, wrbuf_byteen}; // @[el2_dma_ctrl.scala 257:34]
  wire [2:0] _T_23 = {1'h0,io_dbg_cmd_size}; // @[Cat.scala 29:58]
  reg [2:0] wrbuf_sz; // @[Reg.scala 27:20]
  reg [2:0] rdbuf_sz; // @[Reg.scala 27:20]
  wire [2:0] bus_cmd_sz = axi_mstr_sel ? wrbuf_sz : rdbuf_sz; // @[el2_dma_ctrl.scala 524:45]
  wire [2:0] fifo_sz_in = io_dbg_cmd_valid ? _T_23 : bus_cmd_sz; // @[el2_dma_ctrl.scala 259:33]
  wire  fifo_write_in = io_dbg_cmd_valid ? io_dbg_cmd_write : axi_mstr_sel; // @[el2_dma_ctrl.scala 261:33]
  wire  bus_cmd_valid = _T_1261 | rdbuf_vld; // @[el2_dma_ctrl.scala 519:69]
  reg  fifo_full; // @[el2_dma_ctrl.scala 433:12]
  reg  dbg_dma_bubble_bus; // @[el2_dma_ctrl.scala 437:12]
  wire  _T_990 = fifo_full | dbg_dma_bubble_bus; // @[el2_dma_ctrl.scala 361:39]
  wire  dma_fifo_ready = ~_T_990; // @[el2_dma_ctrl.scala 361:27]
  wire  bus_cmd_sent = bus_cmd_valid & dma_fifo_ready; // @[el2_dma_ctrl.scala 520:54]
  wire  _T_29 = bus_cmd_sent & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 268:80]
  wire  _T_32 = io_dbg_cmd_valid & io_dbg_cmd_type[1]; // @[el2_dma_ctrl.scala 268:121]
  wire  _T_33 = _T_29 | _T_32; // @[el2_dma_ctrl.scala 268:101]
  reg [2:0] WrPtr; // @[Reg.scala 27:20]
  wire  _T_34 = 3'h0 == WrPtr; // @[el2_dma_ctrl.scala 268:158]
  wire  _T_35 = _T_33 & _T_34; // @[el2_dma_ctrl.scala 268:151]
  wire  _T_42 = 3'h1 == WrPtr; // @[el2_dma_ctrl.scala 268:158]
  wire  _T_43 = _T_33 & _T_42; // @[el2_dma_ctrl.scala 268:151]
  wire  _T_50 = 3'h2 == WrPtr; // @[el2_dma_ctrl.scala 268:158]
  wire  _T_51 = _T_33 & _T_50; // @[el2_dma_ctrl.scala 268:151]
  wire  _T_58 = 3'h3 == WrPtr; // @[el2_dma_ctrl.scala 268:158]
  wire  _T_59 = _T_33 & _T_58; // @[el2_dma_ctrl.scala 268:151]
  wire  _T_66 = 3'h4 == WrPtr; // @[el2_dma_ctrl.scala 268:158]
  wire  _T_67 = _T_33 & _T_66; // @[el2_dma_ctrl.scala 268:151]
  wire [4:0] fifo_cmd_en = {_T_67,_T_59,_T_51,_T_43,_T_35}; // @[Cat.scala 29:58]
  wire  _T_72 = bus_cmd_sent & fifo_write_in; // @[el2_dma_ctrl.scala 270:73]
  wire  _T_73 = _T_72 & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 270:89]
  wire  _T_76 = _T_32 & io_dbg_cmd_write; // @[el2_dma_ctrl.scala 270:151]
  wire  _T_77 = _T_73 | _T_76; // @[el2_dma_ctrl.scala 270:110]
  wire  _T_79 = _T_77 & _T_34; // @[el2_dma_ctrl.scala 270:172]
  reg  _T_599; // @[el2_dma_ctrl.scala 288:82]
  reg  _T_592; // @[el2_dma_ctrl.scala 288:82]
  reg  _T_585; // @[el2_dma_ctrl.scala 288:82]
  reg  _T_578; // @[el2_dma_ctrl.scala 288:82]
  reg  _T_571; // @[el2_dma_ctrl.scala 288:82]
  wire [4:0] fifo_valid = {_T_599,_T_592,_T_585,_T_578,_T_571}; // @[Cat.scala 29:58]
  wire [4:0] _T_991 = fifo_valid >> RdPtr; // @[el2_dma_ctrl.scala 365:38]
  reg  _T_761; // @[el2_dma_ctrl.scala 296:89]
  reg  _T_754; // @[el2_dma_ctrl.scala 296:89]
  reg  _T_747; // @[el2_dma_ctrl.scala 296:89]
  reg  _T_740; // @[el2_dma_ctrl.scala 296:89]
  reg  _T_733; // @[el2_dma_ctrl.scala 296:89]
  wire [4:0] fifo_done = {_T_761,_T_754,_T_747,_T_740,_T_733}; // @[Cat.scala 29:58]
  wire [4:0] _T_993 = fifo_done >> RdPtr; // @[el2_dma_ctrl.scala 365:58]
  wire  _T_995 = ~_T_993[0]; // @[el2_dma_ctrl.scala 365:48]
  wire  _T_996 = _T_991[0] & _T_995; // @[el2_dma_ctrl.scala 365:46]
  wire  dma_buffer_c1_clk = dma_buffer_c1cgc_io_l1clk; // @[el2_dma_ctrl.scala 234:31 el2_dma_ctrl.scala 453:33]
  reg  _T_887; // @[Reg.scala 27:20]
  reg  _T_885; // @[Reg.scala 27:20]
  reg  _T_883; // @[Reg.scala 27:20]
  reg  _T_881; // @[Reg.scala 27:20]
  reg  _T_879; // @[Reg.scala 27:20]
  wire [4:0] fifo_dbg = {_T_887,_T_885,_T_883,_T_881,_T_879}; // @[Cat.scala 29:58]
  wire [4:0] _T_997 = fifo_dbg >> RdPtr; // @[el2_dma_ctrl.scala 365:77]
  wire  _T_999 = ~_T_997[0]; // @[el2_dma_ctrl.scala 365:68]
  wire  _T_1000 = _T_996 & _T_999; // @[el2_dma_ctrl.scala 365:66]
  wire  _T_1001 = dma_mem_addr_in_dccm | dma_mem_addr_in_iccm; // @[el2_dma_ctrl.scala 365:111]
  wire  _T_1002 = ~_T_1001; // @[el2_dma_ctrl.scala 365:88]
  wire  dma_address_error = _T_1000 & _T_1002; // @[el2_dma_ctrl.scala 365:85]
  wire  _T_1010 = ~dma_address_error; // @[el2_dma_ctrl.scala 366:68]
  wire  _T_1011 = _T_996 & _T_1010; // @[el2_dma_ctrl.scala 366:66]
  reg [2:0] fifo_sz_4; // @[Reg.scala 27:20]
  reg [2:0] fifo_sz_3; // @[Reg.scala 27:20]
  reg [2:0] fifo_sz_2; // @[Reg.scala 27:20]
  reg [2:0] fifo_sz_1; // @[Reg.scala 27:20]
  reg [2:0] fifo_sz_0; // @[Reg.scala 27:20]
  wire [2:0] _GEN_65 = 3'h1 == RdPtr ? fifo_sz_1 : fifo_sz_0; // @[el2_dma_ctrl.scala 416:20]
  wire [2:0] _GEN_66 = 3'h2 == RdPtr ? fifo_sz_2 : _GEN_65; // @[el2_dma_ctrl.scala 416:20]
  wire [2:0] _GEN_67 = 3'h3 == RdPtr ? fifo_sz_3 : _GEN_66; // @[el2_dma_ctrl.scala 416:20]
  wire [2:0] dma_mem_sz_int = 3'h4 == RdPtr ? fifo_sz_4 : _GEN_67; // @[el2_dma_ctrl.scala 416:20]
  wire  _T_1013 = dma_mem_sz_int == 3'h1; // @[el2_dma_ctrl.scala 367:28]
  wire  _T_1015 = _T_1013 & dma_mem_addr_int[0]; // @[el2_dma_ctrl.scala 367:37]
  wire  _T_1017 = dma_mem_sz_int == 3'h2; // @[el2_dma_ctrl.scala 368:29]
  wire  _T_1019 = |dma_mem_addr_int[1:0]; // @[el2_dma_ctrl.scala 368:64]
  wire  _T_1020 = _T_1017 & _T_1019; // @[el2_dma_ctrl.scala 368:38]
  wire  _T_1021 = _T_1015 | _T_1020; // @[el2_dma_ctrl.scala 367:60]
  wire  _T_1023 = dma_mem_sz_int == 3'h3; // @[el2_dma_ctrl.scala 369:29]
  wire  _T_1025 = |dma_mem_addr_int[2:0]; // @[el2_dma_ctrl.scala 369:64]
  wire  _T_1026 = _T_1023 & _T_1025; // @[el2_dma_ctrl.scala 369:38]
  wire  _T_1027 = _T_1021 | _T_1026; // @[el2_dma_ctrl.scala 368:70]
  wire  _T_1029 = dma_mem_sz_int[1:0] == 2'h2; // @[el2_dma_ctrl.scala 370:55]
  wire  _T_1031 = dma_mem_sz_int[1:0] == 2'h3; // @[el2_dma_ctrl.scala 370:88]
  wire  _T_1032 = _T_1029 | _T_1031; // @[el2_dma_ctrl.scala 370:64]
  wire  _T_1033 = ~_T_1032; // @[el2_dma_ctrl.scala 370:31]
  wire  _T_1034 = dma_mem_addr_in_iccm & _T_1033; // @[el2_dma_ctrl.scala 370:29]
  wire  _T_1035 = _T_1027 | _T_1034; // @[el2_dma_ctrl.scala 369:70]
  wire  _T_1036 = dma_mem_addr_in_dccm & io_dma_mem_write; // @[el2_dma_ctrl.scala 371:29]
  wire  _T_1043 = _T_1036 & _T_1033; // @[el2_dma_ctrl.scala 371:48]
  wire  _T_1044 = _T_1035 | _T_1043; // @[el2_dma_ctrl.scala 370:108]
  wire  _T_1047 = io_dma_mem_write & _T_1017; // @[el2_dma_ctrl.scala 372:25]
  wire  _T_1049 = dma_mem_addr_int[2:0] == 3'h0; // @[el2_dma_ctrl.scala 372:94]
  reg [7:0] fifo_byteen_4; // @[Reg.scala 27:20]
  reg [7:0] fifo_byteen_3; // @[Reg.scala 27:20]
  reg [7:0] fifo_byteen_2; // @[Reg.scala 27:20]
  reg [7:0] fifo_byteen_1; // @[Reg.scala 27:20]
  reg [7:0] fifo_byteen_0; // @[Reg.scala 27:20]
  wire [7:0] _GEN_70 = 3'h1 == RdPtr ? fifo_byteen_1 : fifo_byteen_0; // @[el2_dma_ctrl.scala 419:20]
  wire [7:0] _GEN_71 = 3'h2 == RdPtr ? fifo_byteen_2 : _GEN_70; // @[el2_dma_ctrl.scala 419:20]
  wire [7:0] _GEN_72 = 3'h3 == RdPtr ? fifo_byteen_3 : _GEN_71; // @[el2_dma_ctrl.scala 419:20]
  wire [7:0] dma_mem_byteen = 3'h4 == RdPtr ? fifo_byteen_4 : _GEN_72; // @[el2_dma_ctrl.scala 419:20]
  wire [3:0] _T_1072 = _T_1049 ? dma_mem_byteen[3:0] : 4'h0; // @[Mux.scala 27:72]
  wire  _T_1052 = dma_mem_addr_int[2:0] == 3'h1; // @[el2_dma_ctrl.scala 373:32]
  wire [3:0] _T_1073 = _T_1052 ? dma_mem_byteen[4:1] : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1080 = _T_1072 | _T_1073; // @[Mux.scala 27:72]
  wire  _T_1055 = dma_mem_addr_int[2:0] == 3'h2; // @[el2_dma_ctrl.scala 374:32]
  wire [3:0] _T_1074 = _T_1055 ? dma_mem_byteen[5:2] : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1081 = _T_1080 | _T_1074; // @[Mux.scala 27:72]
  wire  _T_1058 = dma_mem_addr_int[2:0] == 3'h3; // @[el2_dma_ctrl.scala 375:32]
  wire [3:0] _T_1075 = _T_1058 ? dma_mem_byteen[6:3] : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1082 = _T_1081 | _T_1075; // @[Mux.scala 27:72]
  wire  _T_1061 = dma_mem_addr_int[2:0] == 3'h4; // @[el2_dma_ctrl.scala 376:32]
  wire [3:0] _T_1076 = _T_1061 ? dma_mem_byteen[7:4] : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1083 = _T_1082 | _T_1076; // @[Mux.scala 27:72]
  wire  _T_1064 = dma_mem_addr_int[2:0] == 3'h5; // @[el2_dma_ctrl.scala 377:32]
  wire [2:0] _T_1077 = _T_1064 ? dma_mem_byteen[7:5] : 3'h0; // @[Mux.scala 27:72]
  wire [3:0] _GEN_91 = {{1'd0}, _T_1077}; // @[Mux.scala 27:72]
  wire [3:0] _T_1084 = _T_1083 | _GEN_91; // @[Mux.scala 27:72]
  wire  _T_1067 = dma_mem_addr_int[2:0] == 3'h6; // @[el2_dma_ctrl.scala 378:32]
  wire [1:0] _T_1078 = _T_1067 ? dma_mem_byteen[7:6] : 2'h0; // @[Mux.scala 27:72]
  wire [3:0] _GEN_92 = {{2'd0}, _T_1078}; // @[Mux.scala 27:72]
  wire [3:0] _T_1085 = _T_1084 | _GEN_92; // @[Mux.scala 27:72]
  wire  _T_1070 = dma_mem_addr_int[2:0] == 3'h7; // @[el2_dma_ctrl.scala 379:32]
  wire  _T_1079 = _T_1070 & dma_mem_byteen[7]; // @[Mux.scala 27:72]
  wire [3:0] _GEN_93 = {{3'd0}, _T_1079}; // @[Mux.scala 27:72]
  wire [3:0] _T_1086 = _T_1085 | _GEN_93; // @[Mux.scala 27:72]
  wire  _T_1088 = _T_1086 != 4'hf; // @[el2_dma_ctrl.scala 379:66]
  wire  _T_1089 = _T_1047 & _T_1088; // @[el2_dma_ctrl.scala 372:58]
  wire  _T_1090 = _T_1044 | _T_1089; // @[el2_dma_ctrl.scala 371:125]
  wire  _T_1093 = io_dma_mem_write & _T_1023; // @[el2_dma_ctrl.scala 380:25]
  wire  _T_1095 = dma_mem_byteen == 8'hf; // @[el2_dma_ctrl.scala 380:83]
  wire  _T_1097 = dma_mem_byteen == 8'hf0; // @[el2_dma_ctrl.scala 380:119]
  wire  _T_1098 = _T_1095 | _T_1097; // @[el2_dma_ctrl.scala 380:96]
  wire  _T_1100 = dma_mem_byteen == 8'hff; // @[el2_dma_ctrl.scala 380:155]
  wire  _T_1101 = _T_1098 | _T_1100; // @[el2_dma_ctrl.scala 380:132]
  wire  _T_1102 = ~_T_1101; // @[el2_dma_ctrl.scala 380:60]
  wire  _T_1103 = _T_1093 & _T_1102; // @[el2_dma_ctrl.scala 380:58]
  wire  _T_1104 = _T_1090 | _T_1103; // @[el2_dma_ctrl.scala 379:79]
  wire  dma_alignment_error = _T_1011 & _T_1104; // @[el2_dma_ctrl.scala 366:87]
  wire  _T_80 = dma_address_error | dma_alignment_error; // @[el2_dma_ctrl.scala 270:213]
  wire  _T_81 = 3'h0 == RdPtr; // @[el2_dma_ctrl.scala 270:243]
  wire  _T_82 = _T_80 & _T_81; // @[el2_dma_ctrl.scala 270:236]
  wire  _T_83 = _T_79 | _T_82; // @[el2_dma_ctrl.scala 270:191]
  wire  _T_84 = 3'h0 == io_dccm_dma_rtag; // @[el2_dma_ctrl.scala 270:284]
  wire  _T_85 = io_dccm_dma_rvalid & _T_84; // @[el2_dma_ctrl.scala 270:277]
  wire  _T_86 = _T_83 | _T_85; // @[el2_dma_ctrl.scala 270:255]
  wire  _T_87 = 3'h0 == io_iccm_dma_rtag; // @[el2_dma_ctrl.scala 270:336]
  wire  _T_88 = io_iccm_dma_rvalid & _T_87; // @[el2_dma_ctrl.scala 270:329]
  wire  _T_89 = _T_86 | _T_88; // @[el2_dma_ctrl.scala 270:307]
  wire  _T_97 = _T_77 & _T_42; // @[el2_dma_ctrl.scala 270:172]
  wire  _T_99 = 3'h1 == RdPtr; // @[el2_dma_ctrl.scala 270:243]
  wire  _T_100 = _T_80 & _T_99; // @[el2_dma_ctrl.scala 270:236]
  wire  _T_101 = _T_97 | _T_100; // @[el2_dma_ctrl.scala 270:191]
  wire  _T_102 = 3'h1 == io_dccm_dma_rtag; // @[el2_dma_ctrl.scala 270:284]
  wire  _T_103 = io_dccm_dma_rvalid & _T_102; // @[el2_dma_ctrl.scala 270:277]
  wire  _T_104 = _T_101 | _T_103; // @[el2_dma_ctrl.scala 270:255]
  wire  _T_105 = 3'h1 == io_iccm_dma_rtag; // @[el2_dma_ctrl.scala 270:336]
  wire  _T_106 = io_iccm_dma_rvalid & _T_105; // @[el2_dma_ctrl.scala 270:329]
  wire  _T_107 = _T_104 | _T_106; // @[el2_dma_ctrl.scala 270:307]
  wire  _T_115 = _T_77 & _T_50; // @[el2_dma_ctrl.scala 270:172]
  wire  _T_117 = 3'h2 == RdPtr; // @[el2_dma_ctrl.scala 270:243]
  wire  _T_118 = _T_80 & _T_117; // @[el2_dma_ctrl.scala 270:236]
  wire  _T_119 = _T_115 | _T_118; // @[el2_dma_ctrl.scala 270:191]
  wire  _T_120 = 3'h2 == io_dccm_dma_rtag; // @[el2_dma_ctrl.scala 270:284]
  wire  _T_121 = io_dccm_dma_rvalid & _T_120; // @[el2_dma_ctrl.scala 270:277]
  wire  _T_122 = _T_119 | _T_121; // @[el2_dma_ctrl.scala 270:255]
  wire  _T_123 = 3'h2 == io_iccm_dma_rtag; // @[el2_dma_ctrl.scala 270:336]
  wire  _T_124 = io_iccm_dma_rvalid & _T_123; // @[el2_dma_ctrl.scala 270:329]
  wire  _T_125 = _T_122 | _T_124; // @[el2_dma_ctrl.scala 270:307]
  wire  _T_133 = _T_77 & _T_58; // @[el2_dma_ctrl.scala 270:172]
  wire  _T_135 = 3'h3 == RdPtr; // @[el2_dma_ctrl.scala 270:243]
  wire  _T_136 = _T_80 & _T_135; // @[el2_dma_ctrl.scala 270:236]
  wire  _T_137 = _T_133 | _T_136; // @[el2_dma_ctrl.scala 270:191]
  wire  _T_138 = 3'h3 == io_dccm_dma_rtag; // @[el2_dma_ctrl.scala 270:284]
  wire  _T_139 = io_dccm_dma_rvalid & _T_138; // @[el2_dma_ctrl.scala 270:277]
  wire  _T_140 = _T_137 | _T_139; // @[el2_dma_ctrl.scala 270:255]
  wire  _T_141 = 3'h3 == io_iccm_dma_rtag; // @[el2_dma_ctrl.scala 270:336]
  wire  _T_142 = io_iccm_dma_rvalid & _T_141; // @[el2_dma_ctrl.scala 270:329]
  wire  _T_143 = _T_140 | _T_142; // @[el2_dma_ctrl.scala 270:307]
  wire  _T_151 = _T_77 & _T_66; // @[el2_dma_ctrl.scala 270:172]
  wire  _T_153 = 3'h4 == RdPtr; // @[el2_dma_ctrl.scala 270:243]
  wire  _T_154 = _T_80 & _T_153; // @[el2_dma_ctrl.scala 270:236]
  wire  _T_155 = _T_151 | _T_154; // @[el2_dma_ctrl.scala 270:191]
  wire  _T_156 = 3'h4 == io_dccm_dma_rtag; // @[el2_dma_ctrl.scala 270:284]
  wire  _T_157 = io_dccm_dma_rvalid & _T_156; // @[el2_dma_ctrl.scala 270:277]
  wire  _T_158 = _T_155 | _T_157; // @[el2_dma_ctrl.scala 270:255]
  wire  _T_159 = 3'h4 == io_iccm_dma_rtag; // @[el2_dma_ctrl.scala 270:336]
  wire  _T_160 = io_iccm_dma_rvalid & _T_159; // @[el2_dma_ctrl.scala 270:329]
  wire  _T_161 = _T_158 | _T_160; // @[el2_dma_ctrl.scala 270:307]
  wire [4:0] fifo_data_en = {_T_161,_T_143,_T_125,_T_107,_T_89}; // @[Cat.scala 29:58]
  wire  _T_166 = io_dma_dccm_req | io_dma_iccm_req; // @[el2_dma_ctrl.scala 272:75]
  wire  _T_167 = ~io_dma_mem_write; // @[el2_dma_ctrl.scala 272:96]
  wire  _T_168 = _T_166 & _T_167; // @[el2_dma_ctrl.scala 272:94]
  wire  _T_170 = _T_168 & _T_81; // @[el2_dma_ctrl.scala 272:114]
  wire  _T_175 = _T_168 & _T_99; // @[el2_dma_ctrl.scala 272:114]
  wire  _T_180 = _T_168 & _T_117; // @[el2_dma_ctrl.scala 272:114]
  wire  _T_185 = _T_168 & _T_135; // @[el2_dma_ctrl.scala 272:114]
  wire  _T_190 = _T_168 & _T_153; // @[el2_dma_ctrl.scala 272:114]
  wire [4:0] fifo_pend_en = {_T_190,_T_185,_T_180,_T_175,_T_170}; // @[Cat.scala 29:58]
  wire  _T_1128 = _T_996 & _T_997[0]; // @[el2_dma_ctrl.scala 389:66]
  wire  _T_1130 = _T_1001 | dma_mem_addr_in_pic; // @[el2_dma_ctrl.scala 389:134]
  wire  _T_1131 = ~_T_1130; // @[el2_dma_ctrl.scala 389:88]
  wire  _T_1134 = dma_mem_sz_int[1:0] != 2'h2; // @[el2_dma_ctrl.scala 389:191]
  wire  _T_1135 = _T_1131 | _T_1134; // @[el2_dma_ctrl.scala 389:167]
  wire  dma_dbg_cmd_error = _T_1128 & _T_1135; // @[el2_dma_ctrl.scala 389:84]
  wire  _T_198 = _T_80 | dma_dbg_cmd_error; // @[el2_dma_ctrl.scala 274:114]
  wire  _T_200 = _T_198 & _T_81; // @[el2_dma_ctrl.scala 274:135]
  wire  _T_201 = io_dccm_dma_rvalid & io_dccm_dma_ecc_error; // @[el2_dma_ctrl.scala 274:177]
  wire  _T_203 = _T_201 & _T_84; // @[el2_dma_ctrl.scala 274:202]
  wire  _T_204 = _T_200 | _T_203; // @[el2_dma_ctrl.scala 274:154]
  wire  _T_205 = io_iccm_dma_rvalid & io_iccm_dma_ecc_error; // @[el2_dma_ctrl.scala 274:255]
  wire  _T_207 = _T_205 & _T_87; // @[el2_dma_ctrl.scala 274:280]
  wire  _T_208 = _T_204 | _T_207; // @[el2_dma_ctrl.scala 274:232]
  wire  _T_214 = _T_198 & _T_99; // @[el2_dma_ctrl.scala 274:135]
  wire  _T_217 = _T_201 & _T_102; // @[el2_dma_ctrl.scala 274:202]
  wire  _T_218 = _T_214 | _T_217; // @[el2_dma_ctrl.scala 274:154]
  wire  _T_221 = _T_205 & _T_105; // @[el2_dma_ctrl.scala 274:280]
  wire  _T_222 = _T_218 | _T_221; // @[el2_dma_ctrl.scala 274:232]
  wire  _T_228 = _T_198 & _T_117; // @[el2_dma_ctrl.scala 274:135]
  wire  _T_231 = _T_201 & _T_120; // @[el2_dma_ctrl.scala 274:202]
  wire  _T_232 = _T_228 | _T_231; // @[el2_dma_ctrl.scala 274:154]
  wire  _T_235 = _T_205 & _T_123; // @[el2_dma_ctrl.scala 274:280]
  wire  _T_236 = _T_232 | _T_235; // @[el2_dma_ctrl.scala 274:232]
  wire  _T_242 = _T_198 & _T_135; // @[el2_dma_ctrl.scala 274:135]
  wire  _T_245 = _T_201 & _T_138; // @[el2_dma_ctrl.scala 274:202]
  wire  _T_246 = _T_242 | _T_245; // @[el2_dma_ctrl.scala 274:154]
  wire  _T_249 = _T_205 & _T_141; // @[el2_dma_ctrl.scala 274:280]
  wire  _T_250 = _T_246 | _T_249; // @[el2_dma_ctrl.scala 274:232]
  wire  _T_256 = _T_198 & _T_153; // @[el2_dma_ctrl.scala 274:135]
  wire  _T_259 = _T_201 & _T_156; // @[el2_dma_ctrl.scala 274:202]
  wire  _T_260 = _T_256 | _T_259; // @[el2_dma_ctrl.scala 274:154]
  wire  _T_263 = _T_205 & _T_159; // @[el2_dma_ctrl.scala 274:280]
  wire  _T_264 = _T_260 | _T_263; // @[el2_dma_ctrl.scala 274:232]
  wire [4:0] fifo_error_en = {_T_264,_T_250,_T_236,_T_222,_T_208}; // @[Cat.scala 29:58]
  wire [1:0] _T_437 = {1'h0,io_dccm_dma_ecc_error}; // @[Cat.scala 29:58]
  wire [1:0] _T_440 = {1'h0,io_iccm_dma_ecc_error}; // @[Cat.scala 29:58]
  wire [1:0] _T_443 = {_T_198,dma_alignment_error}; // @[Cat.scala 29:58]
  wire [1:0] _T_444 = _T_88 ? _T_440 : _T_443; // @[el2_dma_ctrl.scala 284:146]
  wire [1:0] fifo_error_in_0 = _T_85 ? _T_437 : _T_444; // @[el2_dma_ctrl.scala 284:60]
  wire  _T_270 = |fifo_error_in_0; // @[el2_dma_ctrl.scala 276:83]
  reg [1:0] fifo_error_0; // @[el2_dma_ctrl.scala 290:85]
  wire  _T_273 = |fifo_error_0; // @[el2_dma_ctrl.scala 276:125]
  wire [1:0] _T_455 = _T_106 ? _T_440 : _T_443; // @[el2_dma_ctrl.scala 284:146]
  wire [1:0] fifo_error_in_1 = _T_103 ? _T_437 : _T_455; // @[el2_dma_ctrl.scala 284:60]
  wire  _T_277 = |fifo_error_in_1; // @[el2_dma_ctrl.scala 276:83]
  reg [1:0] fifo_error_1; // @[el2_dma_ctrl.scala 290:85]
  wire  _T_280 = |fifo_error_1; // @[el2_dma_ctrl.scala 276:125]
  wire [1:0] _T_466 = _T_124 ? _T_440 : _T_443; // @[el2_dma_ctrl.scala 284:146]
  wire [1:0] fifo_error_in_2 = _T_121 ? _T_437 : _T_466; // @[el2_dma_ctrl.scala 284:60]
  wire  _T_284 = |fifo_error_in_2; // @[el2_dma_ctrl.scala 276:83]
  reg [1:0] fifo_error_2; // @[el2_dma_ctrl.scala 290:85]
  wire  _T_287 = |fifo_error_2; // @[el2_dma_ctrl.scala 276:125]
  wire [1:0] _T_477 = _T_142 ? _T_440 : _T_443; // @[el2_dma_ctrl.scala 284:146]
  wire [1:0] fifo_error_in_3 = _T_139 ? _T_437 : _T_477; // @[el2_dma_ctrl.scala 284:60]
  wire  _T_291 = |fifo_error_in_3; // @[el2_dma_ctrl.scala 276:83]
  reg [1:0] fifo_error_3; // @[el2_dma_ctrl.scala 290:85]
  wire  _T_294 = |fifo_error_3; // @[el2_dma_ctrl.scala 276:125]
  wire [1:0] _T_488 = _T_160 ? _T_440 : _T_443; // @[el2_dma_ctrl.scala 284:146]
  wire [1:0] fifo_error_in_4 = _T_157 ? _T_437 : _T_488; // @[el2_dma_ctrl.scala 284:60]
  wire  _T_298 = |fifo_error_in_4; // @[el2_dma_ctrl.scala 276:83]
  reg [1:0] fifo_error_4; // @[el2_dma_ctrl.scala 290:85]
  wire  _T_301 = |fifo_error_4; // @[el2_dma_ctrl.scala 276:125]
  wire  _T_310 = _T_273 | fifo_error_en[0]; // @[el2_dma_ctrl.scala 278:78]
  wire  _T_312 = _T_166 & io_dma_mem_write; // @[el2_dma_ctrl.scala 278:136]
  wire  _T_313 = _T_310 | _T_312; // @[el2_dma_ctrl.scala 278:97]
  wire  _T_315 = _T_313 & _T_81; // @[el2_dma_ctrl.scala 278:157]
  wire  _T_318 = _T_315 | _T_85; // @[el2_dma_ctrl.scala 278:176]
  wire  _T_321 = _T_318 | _T_88; // @[el2_dma_ctrl.scala 278:228]
  wire  _T_324 = _T_280 | fifo_error_en[1]; // @[el2_dma_ctrl.scala 278:78]
  wire  _T_327 = _T_324 | _T_312; // @[el2_dma_ctrl.scala 278:97]
  wire  _T_329 = _T_327 & _T_99; // @[el2_dma_ctrl.scala 278:157]
  wire  _T_332 = _T_329 | _T_103; // @[el2_dma_ctrl.scala 278:176]
  wire  _T_335 = _T_332 | _T_106; // @[el2_dma_ctrl.scala 278:228]
  wire  _T_338 = _T_287 | fifo_error_en[2]; // @[el2_dma_ctrl.scala 278:78]
  wire  _T_341 = _T_338 | _T_312; // @[el2_dma_ctrl.scala 278:97]
  wire  _T_343 = _T_341 & _T_117; // @[el2_dma_ctrl.scala 278:157]
  wire  _T_346 = _T_343 | _T_121; // @[el2_dma_ctrl.scala 278:176]
  wire  _T_349 = _T_346 | _T_124; // @[el2_dma_ctrl.scala 278:228]
  wire  _T_352 = _T_294 | fifo_error_en[3]; // @[el2_dma_ctrl.scala 278:78]
  wire  _T_355 = _T_352 | _T_312; // @[el2_dma_ctrl.scala 278:97]
  wire  _T_357 = _T_355 & _T_135; // @[el2_dma_ctrl.scala 278:157]
  wire  _T_360 = _T_357 | _T_139; // @[el2_dma_ctrl.scala 278:176]
  wire  _T_363 = _T_360 | _T_142; // @[el2_dma_ctrl.scala 278:228]
  wire  _T_366 = _T_301 | fifo_error_en[4]; // @[el2_dma_ctrl.scala 278:78]
  wire  _T_369 = _T_366 | _T_312; // @[el2_dma_ctrl.scala 278:97]
  wire  _T_371 = _T_369 & _T_153; // @[el2_dma_ctrl.scala 278:157]
  wire  _T_374 = _T_371 | _T_157; // @[el2_dma_ctrl.scala 278:176]
  wire  _T_377 = _T_374 | _T_160; // @[el2_dma_ctrl.scala 278:228]
  wire [4:0] fifo_done_en = {_T_377,_T_363,_T_349,_T_335,_T_321}; // @[Cat.scala 29:58]
  wire  _T_384 = fifo_done_en[0] | fifo_done[0]; // @[el2_dma_ctrl.scala 280:75]
  wire  _T_385 = _T_384 & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 280:91]
  wire  _T_388 = fifo_done_en[1] | fifo_done[1]; // @[el2_dma_ctrl.scala 280:75]
  wire  _T_389 = _T_388 & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 280:91]
  wire  _T_392 = fifo_done_en[2] | fifo_done[2]; // @[el2_dma_ctrl.scala 280:75]
  wire  _T_393 = _T_392 & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 280:91]
  wire  _T_396 = fifo_done_en[3] | fifo_done[3]; // @[el2_dma_ctrl.scala 280:75]
  wire  _T_397 = _T_396 & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 280:91]
  wire  _T_400 = fifo_done_en[4] | fifo_done[4]; // @[el2_dma_ctrl.scala 280:75]
  wire  _T_401 = _T_400 & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 280:91]
  wire [4:0] fifo_done_bus_en = {_T_401,_T_397,_T_393,_T_389,_T_385}; // @[Cat.scala 29:58]
  wire  _T_1286 = io_dma_axi_bvalid & io_dma_axi_bready; // @[el2_dma_ctrl.scala 562:60]
  wire  _T_1287 = io_dma_axi_rvalid & io_dma_axi_rready; // @[el2_dma_ctrl.scala 562:102]
  wire  bus_rsp_sent = _T_1286 | _T_1287; // @[el2_dma_ctrl.scala 562:81]
  wire  _T_407 = bus_rsp_sent & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 282:99]
  wire  _T_408 = _T_407 | io_dma_dbg_cmd_done; // @[el2_dma_ctrl.scala 282:120]
  reg [2:0] RspPtr; // @[Reg.scala 27:20]
  wire  _T_409 = 3'h0 == RspPtr; // @[el2_dma_ctrl.scala 282:150]
  wire  _T_410 = _T_408 & _T_409; // @[el2_dma_ctrl.scala 282:143]
  wire  _T_414 = 3'h1 == RspPtr; // @[el2_dma_ctrl.scala 282:150]
  wire  _T_415 = _T_408 & _T_414; // @[el2_dma_ctrl.scala 282:143]
  wire  _T_419 = 3'h2 == RspPtr; // @[el2_dma_ctrl.scala 282:150]
  wire  _T_420 = _T_408 & _T_419; // @[el2_dma_ctrl.scala 282:143]
  wire  _T_424 = 3'h3 == RspPtr; // @[el2_dma_ctrl.scala 282:150]
  wire  _T_425 = _T_408 & _T_424; // @[el2_dma_ctrl.scala 282:143]
  wire  _T_429 = 3'h4 == RspPtr; // @[el2_dma_ctrl.scala 282:150]
  wire  _T_430 = _T_408 & _T_429; // @[el2_dma_ctrl.scala 282:143]
  wire [4:0] fifo_reset = {_T_430,_T_425,_T_420,_T_415,_T_410}; // @[Cat.scala 29:58]
  wire  _T_492 = fifo_error_en[0] & _T_270; // @[el2_dma_ctrl.scala 286:77]
  wire [63:0] _T_494 = {32'h0,fifo_addr_0}; // @[Cat.scala 29:58]
  wire [63:0] _T_499 = {io_dbg_cmd_wrdata,io_dbg_cmd_wrdata}; // @[Cat.scala 29:58]
  reg [63:0] wrbuf_data; // @[el2_lib.scala 514:16]
  wire [63:0] _T_501 = io_dbg_cmd_valid ? _T_499 : wrbuf_data; // @[el2_dma_ctrl.scala 286:284]
  wire  _T_507 = fifo_error_en[1] & _T_277; // @[el2_dma_ctrl.scala 286:77]
  wire [63:0] _T_509 = {32'h0,fifo_addr_1}; // @[Cat.scala 29:58]
  wire  _T_522 = fifo_error_en[2] & _T_284; // @[el2_dma_ctrl.scala 286:77]
  wire [63:0] _T_524 = {32'h0,fifo_addr_2}; // @[Cat.scala 29:58]
  wire  _T_537 = fifo_error_en[3] & _T_291; // @[el2_dma_ctrl.scala 286:77]
  wire [63:0] _T_539 = {32'h0,fifo_addr_3}; // @[Cat.scala 29:58]
  wire  _T_552 = fifo_error_en[4] & _T_298; // @[el2_dma_ctrl.scala 286:77]
  wire [63:0] _T_554 = {32'h0,fifo_addr_4}; // @[Cat.scala 29:58]
  wire  _T_567 = fifo_cmd_en[0] | fifo_valid[0]; // @[el2_dma_ctrl.scala 288:86]
  wire  _T_569 = ~fifo_reset[0]; // @[el2_dma_ctrl.scala 288:125]
  wire  _T_574 = fifo_cmd_en[1] | fifo_valid[1]; // @[el2_dma_ctrl.scala 288:86]
  wire  _T_576 = ~fifo_reset[1]; // @[el2_dma_ctrl.scala 288:125]
  wire  _T_581 = fifo_cmd_en[2] | fifo_valid[2]; // @[el2_dma_ctrl.scala 288:86]
  wire  _T_583 = ~fifo_reset[2]; // @[el2_dma_ctrl.scala 288:125]
  wire  _T_588 = fifo_cmd_en[3] | fifo_valid[3]; // @[el2_dma_ctrl.scala 288:86]
  wire  _T_590 = ~fifo_reset[3]; // @[el2_dma_ctrl.scala 288:125]
  wire  _T_595 = fifo_cmd_en[4] | fifo_valid[4]; // @[el2_dma_ctrl.scala 288:86]
  wire  _T_597 = ~fifo_reset[4]; // @[el2_dma_ctrl.scala 288:125]
  wire [1:0] _T_606 = fifo_error_en[0] ? fifo_error_in_0 : fifo_error_0; // @[el2_dma_ctrl.scala 290:89]
  wire [1:0] _T_610 = _T_569 ? 2'h3 : 2'h0; // @[Bitwise.scala 72:12]
  wire [1:0] _T_615 = fifo_error_en[1] ? fifo_error_in_1 : fifo_error_1; // @[el2_dma_ctrl.scala 290:89]
  wire [1:0] _T_619 = _T_576 ? 2'h3 : 2'h0; // @[Bitwise.scala 72:12]
  wire [1:0] _T_624 = fifo_error_en[2] ? fifo_error_in_2 : fifo_error_2; // @[el2_dma_ctrl.scala 290:89]
  wire [1:0] _T_628 = _T_583 ? 2'h3 : 2'h0; // @[Bitwise.scala 72:12]
  wire [1:0] _T_633 = fifo_error_en[3] ? fifo_error_in_3 : fifo_error_3; // @[el2_dma_ctrl.scala 290:89]
  wire [1:0] _T_637 = _T_590 ? 2'h3 : 2'h0; // @[Bitwise.scala 72:12]
  wire [1:0] _T_642 = fifo_error_en[4] ? fifo_error_in_4 : fifo_error_4; // @[el2_dma_ctrl.scala 290:89]
  wire [1:0] _T_646 = _T_597 ? 2'h3 : 2'h0; // @[Bitwise.scala 72:12]
  reg  _T_722; // @[el2_dma_ctrl.scala 294:89]
  reg  _T_715; // @[el2_dma_ctrl.scala 294:89]
  reg  _T_708; // @[el2_dma_ctrl.scala 294:89]
  reg  _T_701; // @[el2_dma_ctrl.scala 294:89]
  reg  _T_694; // @[el2_dma_ctrl.scala 294:89]
  wire [4:0] fifo_rpend = {_T_722,_T_715,_T_708,_T_701,_T_694}; // @[Cat.scala 29:58]
  wire  _T_690 = fifo_pend_en[0] | fifo_rpend[0]; // @[el2_dma_ctrl.scala 294:93]
  wire  _T_697 = fifo_pend_en[1] | fifo_rpend[1]; // @[el2_dma_ctrl.scala 294:93]
  wire  _T_704 = fifo_pend_en[2] | fifo_rpend[2]; // @[el2_dma_ctrl.scala 294:93]
  wire  _T_711 = fifo_pend_en[3] | fifo_rpend[3]; // @[el2_dma_ctrl.scala 294:93]
  wire  _T_718 = fifo_pend_en[4] | fifo_rpend[4]; // @[el2_dma_ctrl.scala 294:93]
  reg  _T_800; // @[el2_dma_ctrl.scala 298:89]
  reg  _T_793; // @[el2_dma_ctrl.scala 298:89]
  reg  _T_786; // @[el2_dma_ctrl.scala 298:89]
  reg  _T_779; // @[el2_dma_ctrl.scala 298:89]
  reg  _T_772; // @[el2_dma_ctrl.scala 298:89]
  wire [4:0] fifo_done_bus = {_T_800,_T_793,_T_786,_T_779,_T_772}; // @[Cat.scala 29:58]
  wire  _T_768 = fifo_done_bus_en[0] | fifo_done_bus[0]; // @[el2_dma_ctrl.scala 298:93]
  wire  _T_775 = fifo_done_bus_en[1] | fifo_done_bus[1]; // @[el2_dma_ctrl.scala 298:93]
  wire  _T_782 = fifo_done_bus_en[2] | fifo_done_bus[2]; // @[el2_dma_ctrl.scala 298:93]
  wire  _T_789 = fifo_done_bus_en[3] | fifo_done_bus[3]; // @[el2_dma_ctrl.scala 298:93]
  wire  _T_796 = fifo_done_bus_en[4] | fifo_done_bus[4]; // @[el2_dma_ctrl.scala 298:93]
  wire [7:0] fifo_byteen_in = _T_20[7:0]; // @[el2_dma_ctrl.scala 257:28]
  reg  _T_851; // @[Reg.scala 27:20]
  reg  _T_853; // @[Reg.scala 27:20]
  reg  _T_855; // @[Reg.scala 27:20]
  reg  _T_857; // @[Reg.scala 27:20]
  reg  _T_859; // @[Reg.scala 27:20]
  wire [4:0] fifo_write = {_T_859,_T_857,_T_855,_T_853,_T_851}; // @[Cat.scala 29:58]
  reg [63:0] fifo_data_0; // @[el2_lib.scala 514:16]
  reg [63:0] fifo_data_1; // @[el2_lib.scala 514:16]
  reg [63:0] fifo_data_2; // @[el2_lib.scala 514:16]
  reg [63:0] fifo_data_3; // @[el2_lib.scala 514:16]
  reg [63:0] fifo_data_4; // @[el2_lib.scala 514:16]
  reg  fifo_tag_0; // @[Reg.scala 27:20]
  reg  wrbuf_tag; // @[Reg.scala 27:20]
  reg  rdbuf_tag; // @[Reg.scala 27:20]
  wire  bus_cmd_tag = axi_mstr_sel ? wrbuf_tag : rdbuf_tag; // @[el2_dma_ctrl.scala 527:43]
  reg  fifo_tag_1; // @[Reg.scala 27:20]
  reg  fifo_tag_2; // @[Reg.scala 27:20]
  reg  fifo_tag_3; // @[Reg.scala 27:20]
  reg  fifo_tag_4; // @[Reg.scala 27:20]
  wire  _T_932 = WrPtr == 3'h4; // @[el2_dma_ctrl.scala 322:30]
  wire [2:0] _T_935 = WrPtr + 3'h1; // @[el2_dma_ctrl.scala 322:76]
  wire  _T_937 = RdPtr == 3'h4; // @[el2_dma_ctrl.scala 324:30]
  wire [2:0] _T_940 = RdPtr + 3'h1; // @[el2_dma_ctrl.scala 324:76]
  wire  _T_942 = RspPtr == 3'h4; // @[el2_dma_ctrl.scala 326:31]
  wire [2:0] _T_945 = RspPtr + 3'h1; // @[el2_dma_ctrl.scala 326:78]
  wire  WrPtrEn = |fifo_cmd_en; // @[el2_dma_ctrl.scala 328:30]
  wire  RdPtrEn = _T_166 | _T_198; // @[el2_dma_ctrl.scala 330:53]
  wire  RspPtrEn = io_dma_dbg_cmd_done | _T_407; // @[el2_dma_ctrl.scala 332:39]
  wire [3:0] _T_960 = {3'h0,bus_cmd_sent}; // @[Cat.scala 29:58]
  wire [3:0] _T_962 = {3'h0,bus_rsp_sent}; // @[Cat.scala 29:58]
  wire [3:0] num_fifo_vld_tmp = _T_960 - _T_962; // @[el2_dma_ctrl.scala 353:62]
  wire [3:0] _T_967 = {3'h0,fifo_valid[0]}; // @[Cat.scala 29:58]
  wire [3:0] _T_970 = {3'h0,fifo_valid[1]}; // @[Cat.scala 29:58]
  wire [3:0] _T_973 = {3'h0,fifo_valid[2]}; // @[Cat.scala 29:58]
  wire [3:0] _T_976 = {3'h0,fifo_valid[3]}; // @[Cat.scala 29:58]
  wire [3:0] _T_979 = {3'h0,fifo_valid[4]}; // @[Cat.scala 29:58]
  wire [3:0] _T_981 = _T_967 + _T_970; // @[el2_dma_ctrl.scala 355:102]
  wire [3:0] _T_983 = _T_981 + _T_973; // @[el2_dma_ctrl.scala 355:102]
  wire [3:0] _T_985 = _T_983 + _T_976; // @[el2_dma_ctrl.scala 355:102]
  wire [3:0] num_fifo_vld_tmp2 = _T_985 + _T_979; // @[el2_dma_ctrl.scala 355:102]
  wire [3:0] num_fifo_vld = num_fifo_vld_tmp + num_fifo_vld_tmp2; // @[el2_dma_ctrl.scala 357:45]
  wire  _T_1144 = |fifo_valid; // @[el2_dma_ctrl.scala 398:30]
  wire  fifo_empty = ~_T_1144; // @[el2_dma_ctrl.scala 398:17]
  wire [4:0] _T_1107 = fifo_valid >> RspPtr; // @[el2_dma_ctrl.scala 385:39]
  wire [4:0] _T_1109 = fifo_dbg >> RspPtr; // @[el2_dma_ctrl.scala 385:58]
  wire  _T_1111 = _T_1107[0] & _T_1109[0]; // @[el2_dma_ctrl.scala 385:48]
  wire [4:0] _T_1112 = fifo_done >> RspPtr; // @[el2_dma_ctrl.scala 385:78]
  wire [31:0] _GEN_44 = 3'h1 == RspPtr ? fifo_addr_1 : fifo_addr_0; // @[el2_dma_ctrl.scala 386:49]
  wire [31:0] _GEN_45 = 3'h2 == RspPtr ? fifo_addr_2 : _GEN_44; // @[el2_dma_ctrl.scala 386:49]
  wire [31:0] _GEN_46 = 3'h3 == RspPtr ? fifo_addr_3 : _GEN_45; // @[el2_dma_ctrl.scala 386:49]
  wire [31:0] _GEN_47 = 3'h4 == RspPtr ? fifo_addr_4 : _GEN_46; // @[el2_dma_ctrl.scala 386:49]
  wire [63:0] _GEN_49 = 3'h1 == RspPtr ? fifo_data_1 : fifo_data_0; // @[el2_dma_ctrl.scala 386:71]
  wire [63:0] _GEN_50 = 3'h2 == RspPtr ? fifo_data_2 : _GEN_49; // @[el2_dma_ctrl.scala 386:71]
  wire [63:0] _GEN_51 = 3'h3 == RspPtr ? fifo_data_3 : _GEN_50; // @[el2_dma_ctrl.scala 386:71]
  wire [63:0] _GEN_52 = 3'h4 == RspPtr ? fifo_data_4 : _GEN_51; // @[el2_dma_ctrl.scala 386:71]
  wire [1:0] _GEN_54 = 3'h1 == RspPtr ? fifo_error_1 : fifo_error_0; // @[el2_dma_ctrl.scala 387:47]
  wire [1:0] _GEN_55 = 3'h2 == RspPtr ? fifo_error_2 : _GEN_54; // @[el2_dma_ctrl.scala 387:47]
  wire [1:0] _GEN_56 = 3'h3 == RspPtr ? fifo_error_3 : _GEN_55; // @[el2_dma_ctrl.scala 387:47]
  wire [1:0] _GEN_57 = 3'h4 == RspPtr ? fifo_error_4 : _GEN_56; // @[el2_dma_ctrl.scala 387:47]
  wire  _T_1137 = dma_mem_addr_in_dccm | dma_mem_addr_in_pic; // @[el2_dma_ctrl.scala 393:64]
  wire [4:0] _T_1166 = fifo_rpend >> RdPtr; // @[el2_dma_ctrl.scala 411:54]
  wire  _T_1168 = ~_T_1166[0]; // @[el2_dma_ctrl.scala 411:43]
  wire  _T_1169 = _T_991[0] & _T_1168; // @[el2_dma_ctrl.scala 411:41]
  wire  _T_1173 = _T_1169 & _T_995; // @[el2_dma_ctrl.scala 411:62]
  wire  _T_1176 = ~_T_198; // @[el2_dma_ctrl.scala 411:84]
  wire  dma_mem_req = _T_1173 & _T_1176; // @[el2_dma_ctrl.scala 411:82]
  wire  _T_1138 = dma_mem_req & _T_1137; // @[el2_dma_ctrl.scala 393:40]
  reg [2:0] dma_nack_count; // @[Reg.scala 27:20]
  wire  _T_1139 = dma_nack_count >= io_dec_tlu_dma_qos_prty; // @[el2_dma_ctrl.scala 393:105]
  wire  _T_1141 = dma_mem_req & dma_mem_addr_in_iccm; // @[el2_dma_ctrl.scala 394:40]
  wire  _T_1148 = ~_T_166; // @[el2_dma_ctrl.scala 403:77]
  wire [2:0] _T_1150 = _T_1148 ? 3'h7 : 3'h0; // @[Bitwise.scala 72:12]
  wire [2:0] _T_1152 = _T_1150 & dma_nack_count; // @[el2_dma_ctrl.scala 403:115]
  wire  _T_1156 = dma_mem_req & _T_1148; // @[el2_dma_ctrl.scala 403:163]
  wire [2:0] _T_1159 = dma_nack_count + 3'h1; // @[el2_dma_ctrl.scala 403:224]
  wire  _T_1185 = io_dma_mem_write & _T_1097; // @[el2_dma_ctrl.scala 417:44]
  wire [31:0] _T_1189 = {dma_mem_addr_int[31:3],1'h1,dma_mem_addr_int[1:0]}; // @[Cat.scala 29:58]
  wire  _T_1197 = io_dma_mem_write & _T_1098; // @[el2_dma_ctrl.scala 418:44]
  wire [4:0] _T_1200 = fifo_write >> RdPtr; // @[el2_dma_ctrl.scala 420:33]
  wire [63:0] _GEN_75 = 3'h1 == RdPtr ? fifo_data_1 : fifo_data_0; // @[el2_dma_ctrl.scala 421:20]
  wire [63:0] _GEN_76 = 3'h2 == RdPtr ? fifo_data_2 : _GEN_75; // @[el2_dma_ctrl.scala 421:20]
  wire [63:0] _GEN_77 = 3'h3 == RdPtr ? fifo_data_3 : _GEN_76; // @[el2_dma_ctrl.scala 421:20]
  reg  dma_dbg_cmd_done_q; // @[el2_dma_ctrl.scala 441:12]
  wire  _T_1213 = bus_cmd_valid & io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 446:44]
  wire  _T_1214 = _T_1213 | io_dbg_cmd_valid; // @[el2_dma_ctrl.scala 446:65]
  wire  bus_rsp_valid = io_dma_axi_bvalid | io_dma_axi_rvalid; // @[el2_dma_ctrl.scala 561:59]
  wire  _T_1215 = bus_cmd_valid | bus_rsp_valid; // @[el2_dma_ctrl.scala 447:44]
  wire  _T_1216 = _T_1215 | io_dbg_cmd_valid; // @[el2_dma_ctrl.scala 447:60]
  wire  _T_1217 = _T_1216 | io_dma_dbg_cmd_done; // @[el2_dma_ctrl.scala 447:79]
  wire  _T_1218 = _T_1217 | dma_dbg_cmd_done_q; // @[el2_dma_ctrl.scala 447:101]
  wire  _T_1220 = _T_1218 | _T_1144; // @[el2_dma_ctrl.scala 447:122]
  wire  wrbuf_en = io_dma_axi_awvalid & io_dma_axi_awready; // @[el2_dma_ctrl.scala 469:46]
  wire  wrbuf_data_en = io_dma_axi_wvalid & io_dma_axi_wready; // @[el2_dma_ctrl.scala 470:45]
  wire  wrbuf_cmd_sent = bus_cmd_sent & axi_mstr_sel; // @[el2_dma_ctrl.scala 471:40]
  wire  _T_1222 = ~wrbuf_en; // @[el2_dma_ctrl.scala 472:51]
  wire  wrbuf_rst = wrbuf_cmd_sent & _T_1222; // @[el2_dma_ctrl.scala 472:49]
  wire  _T_1224 = ~wrbuf_data_en; // @[el2_dma_ctrl.scala 473:51]
  wire  wrbuf_data_rst = wrbuf_cmd_sent & _T_1224; // @[el2_dma_ctrl.scala 473:49]
  wire  _T_1225 = wrbuf_en | wrbuf_vld; // @[el2_dma_ctrl.scala 475:63]
  wire  _T_1226 = ~wrbuf_rst; // @[el2_dma_ctrl.scala 475:92]
  wire  _T_1229 = wrbuf_data_en | wrbuf_data_vld; // @[el2_dma_ctrl.scala 477:63]
  wire  _T_1230 = ~wrbuf_data_rst; // @[el2_dma_ctrl.scala 477:102]
  wire  rdbuf_en = io_dma_axi_arvalid & io_dma_axi_arready; // @[el2_dma_ctrl.scala 497:58]
  wire  _T_1235 = ~axi_mstr_sel; // @[el2_dma_ctrl.scala 498:44]
  wire  rdbuf_cmd_sent = bus_cmd_sent & _T_1235; // @[el2_dma_ctrl.scala 498:42]
  wire  _T_1237 = ~rdbuf_en; // @[el2_dma_ctrl.scala 499:63]
  wire  rdbuf_rst = rdbuf_cmd_sent & _T_1237; // @[el2_dma_ctrl.scala 499:61]
  wire  _T_1238 = rdbuf_en | rdbuf_vld; // @[el2_dma_ctrl.scala 501:51]
  wire  _T_1239 = ~rdbuf_rst; // @[el2_dma_ctrl.scala 501:80]
  wire  _T_1243 = ~wrbuf_cmd_sent; // @[el2_dma_ctrl.scala 513:44]
  wire  _T_1244 = wrbuf_vld & _T_1243; // @[el2_dma_ctrl.scala 513:42]
  wire  _T_1247 = wrbuf_data_vld & _T_1243; // @[el2_dma_ctrl.scala 514:47]
  wire  _T_1249 = ~rdbuf_cmd_sent; // @[el2_dma_ctrl.scala 515:44]
  wire  _T_1250 = rdbuf_vld & _T_1249; // @[el2_dma_ctrl.scala 515:42]
  wire  axi_mstr_prty_in = ~axi_mstr_priority; // @[el2_dma_ctrl.scala 534:27]
  wire  _T_1272 = ~_T_1109[0]; // @[el2_dma_ctrl.scala 541:50]
  wire  _T_1273 = _T_1107[0] & _T_1272; // @[el2_dma_ctrl.scala 541:48]
  wire [4:0] _T_1274 = fifo_done_bus >> RspPtr; // @[el2_dma_ctrl.scala 541:83]
  wire  axi_rsp_valid = _T_1273 & _T_1274[0]; // @[el2_dma_ctrl.scala 541:68]
  wire [4:0] _T_1276 = fifo_write >> RspPtr; // @[el2_dma_ctrl.scala 543:39]
  wire  axi_rsp_write = _T_1276[0]; // @[el2_dma_ctrl.scala 543:39]
  wire [1:0] _T_1279 = _GEN_57[1] ? 2'h3 : 2'h0; // @[el2_dma_ctrl.scala 544:64]
  wire  _GEN_86 = 3'h1 == RspPtr ? fifo_tag_1 : fifo_tag_0; // @[el2_dma_ctrl.scala 552:33]
  wire  _GEN_87 = 3'h2 == RspPtr ? fifo_tag_2 : _GEN_86; // @[el2_dma_ctrl.scala 552:33]
  wire  _GEN_88 = 3'h3 == RspPtr ? fifo_tag_3 : _GEN_87; // @[el2_dma_ctrl.scala 552:33]
  wire  _T_1282 = ~axi_rsp_write; // @[el2_dma_ctrl.scala 554:46]
  rvclkhdr rvclkhdr ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  rvclkhdr rvclkhdr_2 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_2_io_l1clk),
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en),
    .io_scan_mode(rvclkhdr_2_io_scan_mode)
  );
  rvclkhdr rvclkhdr_3 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_3_io_l1clk),
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en),
    .io_scan_mode(rvclkhdr_3_io_scan_mode)
  );
  rvclkhdr rvclkhdr_4 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_4_io_l1clk),
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en),
    .io_scan_mode(rvclkhdr_4_io_scan_mode)
  );
  rvclkhdr rvclkhdr_5 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_5_io_l1clk),
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en),
    .io_scan_mode(rvclkhdr_5_io_scan_mode)
  );
  rvclkhdr rvclkhdr_6 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_6_io_l1clk),
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en),
    .io_scan_mode(rvclkhdr_6_io_scan_mode)
  );
  rvclkhdr rvclkhdr_7 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_7_io_l1clk),
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en),
    .io_scan_mode(rvclkhdr_7_io_scan_mode)
  );
  rvclkhdr rvclkhdr_8 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_8_io_l1clk),
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en),
    .io_scan_mode(rvclkhdr_8_io_scan_mode)
  );
  rvclkhdr rvclkhdr_9 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_9_io_l1clk),
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en),
    .io_scan_mode(rvclkhdr_9_io_scan_mode)
  );
  rvclkhdr dma_buffer_c1cgc ( // @[el2_dma_ctrl.scala 449:32]
    .io_l1clk(dma_buffer_c1cgc_io_l1clk),
    .io_clk(dma_buffer_c1cgc_io_clk),
    .io_en(dma_buffer_c1cgc_io_en),
    .io_scan_mode(dma_buffer_c1cgc_io_scan_mode)
  );
  rvclkhdr dma_free_cgc ( // @[el2_dma_ctrl.scala 455:28]
    .io_l1clk(dma_free_cgc_io_l1clk),
    .io_clk(dma_free_cgc_io_clk),
    .io_en(dma_free_cgc_io_en),
    .io_scan_mode(dma_free_cgc_io_scan_mode)
  );
  rvclkhdr dma_bus_cgc ( // @[el2_dma_ctrl.scala 461:27]
    .io_l1clk(dma_bus_cgc_io_l1clk),
    .io_clk(dma_bus_cgc_io_clk),
    .io_en(dma_bus_cgc_io_en),
    .io_scan_mode(dma_bus_cgc_io_scan_mode)
  );
  rvclkhdr rvclkhdr_10 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_10_io_l1clk),
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en),
    .io_scan_mode(rvclkhdr_10_io_scan_mode)
  );
  rvclkhdr rvclkhdr_11 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_11_io_l1clk),
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en),
    .io_scan_mode(rvclkhdr_11_io_scan_mode)
  );
  rvclkhdr rvclkhdr_12 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_12_io_l1clk),
    .io_clk(rvclkhdr_12_io_clk),
    .io_en(rvclkhdr_12_io_en),
    .io_scan_mode(rvclkhdr_12_io_scan_mode)
  );
  assign io_dma_dbg_ready = fifo_empty & dbg_dma_bubble_bus; // @[el2_dma_ctrl.scala 384:25]
  assign io_dma_dbg_cmd_done = _T_1111 & _T_1112[0]; // @[el2_dma_ctrl.scala 385:25]
  assign io_dma_dbg_cmd_fail = |_GEN_57; // @[el2_dma_ctrl.scala 387:25]
  assign io_dma_dbg_rddata = _GEN_47[2] ? _GEN_52[63:32] : _GEN_52[31:0]; // @[el2_dma_ctrl.scala 386:25]
  assign io_dma_dccm_req = _T_1138 & io_dccm_ready; // @[el2_dma_ctrl.scala 412:20]
  assign io_dma_iccm_req = _T_1141 & io_iccm_ready; // @[el2_dma_ctrl.scala 413:20]
  assign io_dma_mem_tag = RdPtr; // @[el2_dma_ctrl.scala 414:20]
  assign io_dma_mem_addr = _T_1185 ? _T_1189 : dma_mem_addr_int; // @[el2_dma_ctrl.scala 417:20]
  assign io_dma_mem_sz = _T_1197 ? 3'h2 : dma_mem_sz_int; // @[el2_dma_ctrl.scala 418:20]
  assign io_dma_mem_write = _T_1200[0]; // @[el2_dma_ctrl.scala 420:20]
  assign io_dma_mem_wdata = 3'h4 == RdPtr ? fifo_data_4 : _GEN_77; // @[el2_dma_ctrl.scala 421:20]
  assign io_dma_dccm_stall_any = _T_1138 & _T_1139; // @[el2_dma_ctrl.scala 393:25]
  assign io_dma_iccm_stall_any = _T_1141 & _T_1139; // @[el2_dma_ctrl.scala 394:25]
  assign io_dma_pmu_dccm_read = io_dma_dccm_req & _T_167; // @[el2_dma_ctrl.scala 425:26]
  assign io_dma_pmu_dccm_write = io_dma_dccm_req & io_dma_mem_write; // @[el2_dma_ctrl.scala 426:26]
  assign io_dma_pmu_any_read = _T_166 & _T_167; // @[el2_dma_ctrl.scala 427:26]
  assign io_dma_pmu_any_write = _T_166 & io_dma_mem_write; // @[el2_dma_ctrl.scala 428:26]
  assign io_dma_axi_awready = ~_T_1244; // @[el2_dma_ctrl.scala 513:27]
  assign io_dma_axi_wready = ~_T_1247; // @[el2_dma_ctrl.scala 514:27]
  assign io_dma_axi_bvalid = axi_rsp_valid & axi_rsp_write; // @[el2_dma_ctrl.scala 550:27]
  assign io_dma_axi_bresp = _GEN_57[0] ? 2'h2 : _T_1279; // @[el2_dma_ctrl.scala 551:33]
  assign io_dma_axi_bid = 3'h4 == RspPtr ? fifo_tag_4 : _GEN_88; // @[el2_dma_ctrl.scala 552:33]
  assign io_dma_axi_arready = ~_T_1250; // @[el2_dma_ctrl.scala 515:27]
  assign io_dma_axi_rvalid = axi_rsp_valid & _T_1282; // @[el2_dma_ctrl.scala 554:27]
  assign io_dma_axi_rid = 3'h4 == RspPtr ? fifo_tag_4 : _GEN_88; // @[el2_dma_ctrl.scala 558:37]
  assign io_dma_axi_rdata = 3'h4 == RspPtr ? fifo_data_4 : _GEN_51; // @[el2_dma_ctrl.scala 556:35]
  assign io_dma_axi_rresp = _GEN_57[0] ? 2'h2 : _T_1279; // @[el2_dma_ctrl.scala 555:33]
  assign io_dma_axi_rlast = 1'h1; // @[el2_dma_ctrl.scala 557:33]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_io_en = fifo_cmd_en[0]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = fifo_cmd_en[1]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_2_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_2_io_en = fifo_cmd_en[2]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_3_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_3_io_en = fifo_cmd_en[3]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_4_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_4_io_en = fifo_cmd_en[4]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_5_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_5_io_en = fifo_data_en[0]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_6_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_6_io_en = fifo_data_en[1]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_7_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_7_io_en = fifo_data_en[2]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_8_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_8_io_en = fifo_data_en[3]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_9_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_9_io_en = fifo_data_en[4]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign dma_buffer_c1cgc_io_clk = clock; // @[el2_dma_ctrl.scala 452:33]
  assign dma_buffer_c1cgc_io_en = _T_1214 | io_clk_override; // @[el2_dma_ctrl.scala 450:33]
  assign dma_buffer_c1cgc_io_scan_mode = io_scan_mode; // @[el2_dma_ctrl.scala 451:33]
  assign dma_free_cgc_io_clk = clock; // @[el2_dma_ctrl.scala 458:29]
  assign dma_free_cgc_io_en = _T_1220 | io_clk_override; // @[el2_dma_ctrl.scala 456:29]
  assign dma_free_cgc_io_scan_mode = io_scan_mode; // @[el2_dma_ctrl.scala 457:29]
  assign dma_bus_cgc_io_clk = clock; // @[el2_dma_ctrl.scala 464:28]
  assign dma_bus_cgc_io_en = io_dma_bus_clk_en; // @[el2_dma_ctrl.scala 462:28]
  assign dma_bus_cgc_io_scan_mode = io_scan_mode; // @[el2_dma_ctrl.scala 463:28]
  assign rvclkhdr_10_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_10_io_en = wrbuf_en & io_dma_bus_clk_en; // @[el2_lib.scala 511:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_11_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_11_io_en = wrbuf_data_en & io_dma_bus_clk_en; // @[el2_lib.scala 511:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_12_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_12_io_en = rdbuf_en & io_dma_bus_clk_en; // @[el2_lib.scala 511:17]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RdPtr = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  fifo_addr_4 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  fifo_addr_3 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  fifo_addr_2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  fifo_addr_1 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  fifo_addr_0 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  wrbuf_vld = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  wrbuf_data_vld = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rdbuf_vld = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  axi_mstr_priority = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  wrbuf_addr = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  rdbuf_addr = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  wrbuf_byteen = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  wrbuf_sz = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  rdbuf_sz = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  fifo_full = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  dbg_dma_bubble_bus = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  WrPtr = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  _T_599 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  _T_592 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  _T_585 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  _T_578 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  _T_571 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  _T_761 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  _T_754 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  _T_747 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  _T_740 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  _T_733 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  _T_887 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  _T_885 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  _T_883 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  _T_881 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  _T_879 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  fifo_sz_4 = _RAND_33[2:0];
  _RAND_34 = {1{`RANDOM}};
  fifo_sz_3 = _RAND_34[2:0];
  _RAND_35 = {1{`RANDOM}};
  fifo_sz_2 = _RAND_35[2:0];
  _RAND_36 = {1{`RANDOM}};
  fifo_sz_1 = _RAND_36[2:0];
  _RAND_37 = {1{`RANDOM}};
  fifo_sz_0 = _RAND_37[2:0];
  _RAND_38 = {1{`RANDOM}};
  fifo_byteen_4 = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  fifo_byteen_3 = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  fifo_byteen_2 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  fifo_byteen_1 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  fifo_byteen_0 = _RAND_42[7:0];
  _RAND_43 = {1{`RANDOM}};
  fifo_error_0 = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  fifo_error_1 = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  fifo_error_2 = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  fifo_error_3 = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  fifo_error_4 = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  RspPtr = _RAND_48[2:0];
  _RAND_49 = {2{`RANDOM}};
  wrbuf_data = _RAND_49[63:0];
  _RAND_50 = {1{`RANDOM}};
  _T_722 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  _T_715 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  _T_708 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  _T_701 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  _T_694 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  _T_800 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  _T_793 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  _T_786 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  _T_779 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  _T_772 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  _T_851 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  _T_853 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  _T_855 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  _T_857 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  _T_859 = _RAND_64[0:0];
  _RAND_65 = {2{`RANDOM}};
  fifo_data_0 = _RAND_65[63:0];
  _RAND_66 = {2{`RANDOM}};
  fifo_data_1 = _RAND_66[63:0];
  _RAND_67 = {2{`RANDOM}};
  fifo_data_2 = _RAND_67[63:0];
  _RAND_68 = {2{`RANDOM}};
  fifo_data_3 = _RAND_68[63:0];
  _RAND_69 = {2{`RANDOM}};
  fifo_data_4 = _RAND_69[63:0];
  _RAND_70 = {1{`RANDOM}};
  fifo_tag_0 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  wrbuf_tag = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  rdbuf_tag = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  fifo_tag_1 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  fifo_tag_2 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  fifo_tag_3 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  fifo_tag_4 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  dma_nack_count = _RAND_77[2:0];
  _RAND_78 = {1{`RANDOM}};
  dma_dbg_cmd_done_q = _RAND_78[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    RdPtr = 3'h0;
  end
  if (reset) begin
    fifo_addr_4 = 32'h0;
  end
  if (reset) begin
    fifo_addr_3 = 32'h0;
  end
  if (reset) begin
    fifo_addr_2 = 32'h0;
  end
  if (reset) begin
    fifo_addr_1 = 32'h0;
  end
  if (reset) begin
    fifo_addr_0 = 32'h0;
  end
  if (reset) begin
    wrbuf_vld = 1'h0;
  end
  if (reset) begin
    wrbuf_data_vld = 1'h0;
  end
  if (reset) begin
    rdbuf_vld = 1'h0;
  end
  if (reset) begin
    axi_mstr_priority = 1'h0;
  end
  if (reset) begin
    wrbuf_addr = 32'h0;
  end
  if (reset) begin
    rdbuf_addr = 32'h0;
  end
  if (reset) begin
    wrbuf_byteen = 8'h0;
  end
  if (reset) begin
    wrbuf_sz = 3'h0;
  end
  if (reset) begin
    rdbuf_sz = 3'h0;
  end
  if (reset) begin
    fifo_full = 1'h0;
  end
  if (reset) begin
    dbg_dma_bubble_bus = 1'h0;
  end
  if (reset) begin
    WrPtr = 3'h0;
  end
  if (reset) begin
    _T_599 = 1'h0;
  end
  if (reset) begin
    _T_592 = 1'h0;
  end
  if (reset) begin
    _T_585 = 1'h0;
  end
  if (reset) begin
    _T_578 = 1'h0;
  end
  if (reset) begin
    _T_571 = 1'h0;
  end
  if (reset) begin
    _T_761 = 1'h0;
  end
  if (reset) begin
    _T_754 = 1'h0;
  end
  if (reset) begin
    _T_747 = 1'h0;
  end
  if (reset) begin
    _T_740 = 1'h0;
  end
  if (reset) begin
    _T_733 = 1'h0;
  end
  if (reset) begin
    _T_887 = 1'h0;
  end
  if (reset) begin
    _T_885 = 1'h0;
  end
  if (reset) begin
    _T_883 = 1'h0;
  end
  if (reset) begin
    _T_881 = 1'h0;
  end
  if (reset) begin
    _T_879 = 1'h0;
  end
  if (reset) begin
    fifo_sz_4 = 3'h0;
  end
  if (reset) begin
    fifo_sz_3 = 3'h0;
  end
  if (reset) begin
    fifo_sz_2 = 3'h0;
  end
  if (reset) begin
    fifo_sz_1 = 3'h0;
  end
  if (reset) begin
    fifo_sz_0 = 3'h0;
  end
  if (reset) begin
    fifo_byteen_4 = 8'h0;
  end
  if (reset) begin
    fifo_byteen_3 = 8'h0;
  end
  if (reset) begin
    fifo_byteen_2 = 8'h0;
  end
  if (reset) begin
    fifo_byteen_1 = 8'h0;
  end
  if (reset) begin
    fifo_byteen_0 = 8'h0;
  end
  if (reset) begin
    fifo_error_0 = 2'h0;
  end
  if (reset) begin
    fifo_error_1 = 2'h0;
  end
  if (reset) begin
    fifo_error_2 = 2'h0;
  end
  if (reset) begin
    fifo_error_3 = 2'h0;
  end
  if (reset) begin
    fifo_error_4 = 2'h0;
  end
  if (reset) begin
    RspPtr = 3'h0;
  end
  if (reset) begin
    wrbuf_data = 64'h0;
  end
  if (reset) begin
    _T_722 = 1'h0;
  end
  if (reset) begin
    _T_715 = 1'h0;
  end
  if (reset) begin
    _T_708 = 1'h0;
  end
  if (reset) begin
    _T_701 = 1'h0;
  end
  if (reset) begin
    _T_694 = 1'h0;
  end
  if (reset) begin
    _T_800 = 1'h0;
  end
  if (reset) begin
    _T_793 = 1'h0;
  end
  if (reset) begin
    _T_786 = 1'h0;
  end
  if (reset) begin
    _T_779 = 1'h0;
  end
  if (reset) begin
    _T_772 = 1'h0;
  end
  if (reset) begin
    _T_851 = 1'h0;
  end
  if (reset) begin
    _T_853 = 1'h0;
  end
  if (reset) begin
    _T_855 = 1'h0;
  end
  if (reset) begin
    _T_857 = 1'h0;
  end
  if (reset) begin
    _T_859 = 1'h0;
  end
  if (reset) begin
    fifo_data_0 = 64'h0;
  end
  if (reset) begin
    fifo_data_1 = 64'h0;
  end
  if (reset) begin
    fifo_data_2 = 64'h0;
  end
  if (reset) begin
    fifo_data_3 = 64'h0;
  end
  if (reset) begin
    fifo_data_4 = 64'h0;
  end
  if (reset) begin
    fifo_tag_0 = 1'h0;
  end
  if (reset) begin
    wrbuf_tag = 1'h0;
  end
  if (reset) begin
    rdbuf_tag = 1'h0;
  end
  if (reset) begin
    fifo_tag_1 = 1'h0;
  end
  if (reset) begin
    fifo_tag_2 = 1'h0;
  end
  if (reset) begin
    fifo_tag_3 = 1'h0;
  end
  if (reset) begin
    fifo_tag_4 = 1'h0;
  end
  if (reset) begin
    dma_nack_count = 3'h0;
  end
  if (reset) begin
    dma_dbg_cmd_done_q = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      RdPtr <= 3'h0;
    end else if (RdPtrEn) begin
      if (_T_937) begin
        RdPtr <= 3'h0;
      end else begin
        RdPtr <= _T_940;
      end
    end
  end
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_addr_4 <= 32'h0;
    end else if (io_dbg_cmd_valid) begin
      fifo_addr_4 <= io_dbg_cmd_addr;
    end else if (axi_mstr_sel) begin
      fifo_addr_4 <= wrbuf_addr;
    end else begin
      fifo_addr_4 <= rdbuf_addr;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_addr_3 <= 32'h0;
    end else if (io_dbg_cmd_valid) begin
      fifo_addr_3 <= io_dbg_cmd_addr;
    end else if (axi_mstr_sel) begin
      fifo_addr_3 <= wrbuf_addr;
    end else begin
      fifo_addr_3 <= rdbuf_addr;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_addr_2 <= 32'h0;
    end else if (io_dbg_cmd_valid) begin
      fifo_addr_2 <= io_dbg_cmd_addr;
    end else if (axi_mstr_sel) begin
      fifo_addr_2 <= wrbuf_addr;
    end else begin
      fifo_addr_2 <= rdbuf_addr;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_addr_1 <= 32'h0;
    end else if (io_dbg_cmd_valid) begin
      fifo_addr_1 <= io_dbg_cmd_addr;
    end else if (axi_mstr_sel) begin
      fifo_addr_1 <= wrbuf_addr;
    end else begin
      fifo_addr_1 <= rdbuf_addr;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_addr_0 <= 32'h0;
    end else if (io_dbg_cmd_valid) begin
      fifo_addr_0 <= io_dbg_cmd_addr;
    end else begin
      fifo_addr_0 <= bus_cmd_addr;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      wrbuf_vld <= 1'h0;
    end else begin
      wrbuf_vld <= _T_1225 & _T_1226;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      wrbuf_data_vld <= 1'h0;
    end else begin
      wrbuf_data_vld <= _T_1229 & _T_1230;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      rdbuf_vld <= 1'h0;
    end else begin
      rdbuf_vld <= _T_1238 & _T_1239;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      axi_mstr_priority <= 1'h0;
    end else if (bus_cmd_sent) begin
      axi_mstr_priority <= axi_mstr_prty_in;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      wrbuf_addr <= 32'h0;
    end else begin
      wrbuf_addr <= io_dma_axi_awaddr;
    end
  end
  always @(posedge rvclkhdr_12_io_l1clk or posedge reset) begin
    if (reset) begin
      rdbuf_addr <= 32'h0;
    end else begin
      rdbuf_addr <= io_dma_axi_araddr;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      wrbuf_byteen <= 8'h0;
    end else if (wrbuf_data_en) begin
      wrbuf_byteen <= io_dma_axi_wstrb;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      wrbuf_sz <= 3'h0;
    end else if (wrbuf_en) begin
      wrbuf_sz <= io_dma_axi_awsize;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      rdbuf_sz <= 3'h0;
    end else if (rdbuf_en) begin
      rdbuf_sz <= io_dma_axi_arsize;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      fifo_full <= 1'h0;
    end else begin
      fifo_full <= num_fifo_vld >= 4'h5;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      dbg_dma_bubble_bus <= 1'h0;
    end else begin
      dbg_dma_bubble_bus <= io_dbg_dma_bubble;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      WrPtr <= 3'h0;
    end else if (WrPtrEn) begin
      if (_T_932) begin
        WrPtr <= 3'h0;
      end else begin
        WrPtr <= _T_935;
      end
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_599 <= 1'h0;
    end else begin
      _T_599 <= _T_595 & _T_597;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_592 <= 1'h0;
    end else begin
      _T_592 <= _T_588 & _T_590;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_585 <= 1'h0;
    end else begin
      _T_585 <= _T_581 & _T_583;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_578 <= 1'h0;
    end else begin
      _T_578 <= _T_574 & _T_576;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_571 <= 1'h0;
    end else begin
      _T_571 <= _T_567 & _T_569;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_761 <= 1'h0;
    end else begin
      _T_761 <= _T_400 & _T_597;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_754 <= 1'h0;
    end else begin
      _T_754 <= _T_396 & _T_590;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_747 <= 1'h0;
    end else begin
      _T_747 <= _T_392 & _T_583;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_740 <= 1'h0;
    end else begin
      _T_740 <= _T_388 & _T_576;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_733 <= 1'h0;
    end else begin
      _T_733 <= _T_384 & _T_569;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_887 <= 1'h0;
    end else if (fifo_cmd_en[4]) begin
      _T_887 <= io_dbg_cmd_valid;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_885 <= 1'h0;
    end else if (fifo_cmd_en[3]) begin
      _T_885 <= io_dbg_cmd_valid;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_883 <= 1'h0;
    end else if (fifo_cmd_en[2]) begin
      _T_883 <= io_dbg_cmd_valid;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_881 <= 1'h0;
    end else if (fifo_cmd_en[1]) begin
      _T_881 <= io_dbg_cmd_valid;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_879 <= 1'h0;
    end else if (fifo_cmd_en[0]) begin
      _T_879 <= io_dbg_cmd_valid;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_sz_4 <= 3'h0;
    end else if (fifo_cmd_en[4]) begin
      if (io_dbg_cmd_valid) begin
        fifo_sz_4 <= _T_23;
      end else if (axi_mstr_sel) begin
        fifo_sz_4 <= wrbuf_sz;
      end else begin
        fifo_sz_4 <= rdbuf_sz;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_sz_3 <= 3'h0;
    end else if (fifo_cmd_en[3]) begin
      if (io_dbg_cmd_valid) begin
        fifo_sz_3 <= _T_23;
      end else if (axi_mstr_sel) begin
        fifo_sz_3 <= wrbuf_sz;
      end else begin
        fifo_sz_3 <= rdbuf_sz;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_sz_2 <= 3'h0;
    end else if (fifo_cmd_en[2]) begin
      if (io_dbg_cmd_valid) begin
        fifo_sz_2 <= _T_23;
      end else if (axi_mstr_sel) begin
        fifo_sz_2 <= wrbuf_sz;
      end else begin
        fifo_sz_2 <= rdbuf_sz;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_sz_1 <= 3'h0;
    end else if (fifo_cmd_en[1]) begin
      if (io_dbg_cmd_valid) begin
        fifo_sz_1 <= _T_23;
      end else if (axi_mstr_sel) begin
        fifo_sz_1 <= wrbuf_sz;
      end else begin
        fifo_sz_1 <= rdbuf_sz;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_sz_0 <= 3'h0;
    end else if (fifo_cmd_en[0]) begin
      fifo_sz_0 <= fifo_sz_in;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_byteen_4 <= 8'h0;
    end else if (fifo_cmd_en[4]) begin
      fifo_byteen_4 <= fifo_byteen_in;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_byteen_3 <= 8'h0;
    end else if (fifo_cmd_en[3]) begin
      fifo_byteen_3 <= fifo_byteen_in;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_byteen_2 <= 8'h0;
    end else if (fifo_cmd_en[2]) begin
      fifo_byteen_2 <= fifo_byteen_in;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_byteen_1 <= 8'h0;
    end else if (fifo_cmd_en[1]) begin
      fifo_byteen_1 <= fifo_byteen_in;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_byteen_0 <= 8'h0;
    end else if (fifo_cmd_en[0]) begin
      fifo_byteen_0 <= fifo_byteen_in;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      fifo_error_0 <= 2'h0;
    end else begin
      fifo_error_0 <= _T_606 & _T_610;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      fifo_error_1 <= 2'h0;
    end else begin
      fifo_error_1 <= _T_615 & _T_619;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      fifo_error_2 <= 2'h0;
    end else begin
      fifo_error_2 <= _T_624 & _T_628;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      fifo_error_3 <= 2'h0;
    end else begin
      fifo_error_3 <= _T_633 & _T_637;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      fifo_error_4 <= 2'h0;
    end else begin
      fifo_error_4 <= _T_642 & _T_646;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      RspPtr <= 3'h0;
    end else if (RspPtrEn) begin
      if (_T_942) begin
        RspPtr <= 3'h0;
      end else begin
        RspPtr <= _T_945;
      end
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      wrbuf_data <= 64'h0;
    end else begin
      wrbuf_data <= io_dma_axi_wdata;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_722 <= 1'h0;
    end else begin
      _T_722 <= _T_718 & _T_597;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_715 <= 1'h0;
    end else begin
      _T_715 <= _T_711 & _T_590;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_708 <= 1'h0;
    end else begin
      _T_708 <= _T_704 & _T_583;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_701 <= 1'h0;
    end else begin
      _T_701 <= _T_697 & _T_576;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_694 <= 1'h0;
    end else begin
      _T_694 <= _T_690 & _T_569;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_800 <= 1'h0;
    end else begin
      _T_800 <= _T_796 & _T_597;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_793 <= 1'h0;
    end else begin
      _T_793 <= _T_789 & _T_590;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_786 <= 1'h0;
    end else begin
      _T_786 <= _T_782 & _T_583;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_779 <= 1'h0;
    end else begin
      _T_779 <= _T_775 & _T_576;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      _T_772 <= 1'h0;
    end else begin
      _T_772 <= _T_768 & _T_569;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_851 <= 1'h0;
    end else if (fifo_cmd_en[0]) begin
      if (io_dbg_cmd_valid) begin
        _T_851 <= io_dbg_cmd_write;
      end else if (_T_1262) begin
        _T_851 <= axi_mstr_priority;
      end else begin
        _T_851 <= _T_1261;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_853 <= 1'h0;
    end else if (fifo_cmd_en[1]) begin
      if (io_dbg_cmd_valid) begin
        _T_853 <= io_dbg_cmd_write;
      end else if (_T_1262) begin
        _T_853 <= axi_mstr_priority;
      end else begin
        _T_853 <= _T_1261;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_855 <= 1'h0;
    end else if (fifo_cmd_en[2]) begin
      if (io_dbg_cmd_valid) begin
        _T_855 <= io_dbg_cmd_write;
      end else if (_T_1262) begin
        _T_855 <= axi_mstr_priority;
      end else begin
        _T_855 <= _T_1261;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_857 <= 1'h0;
    end else if (fifo_cmd_en[3]) begin
      if (io_dbg_cmd_valid) begin
        _T_857 <= io_dbg_cmd_write;
      end else if (_T_1262) begin
        _T_857 <= axi_mstr_priority;
      end else begin
        _T_857 <= _T_1261;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      _T_859 <= 1'h0;
    end else if (fifo_cmd_en[4]) begin
      _T_859 <= fifo_write_in;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_data_0 <= 64'h0;
    end else if (_T_492) begin
      fifo_data_0 <= _T_494;
    end else if (_T_85) begin
      fifo_data_0 <= io_dccm_dma_rdata;
    end else if (_T_88) begin
      fifo_data_0 <= io_iccm_dma_rdata;
    end else if (io_dbg_cmd_valid) begin
      fifo_data_0 <= _T_499;
    end else begin
      fifo_data_0 <= wrbuf_data;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_data_1 <= 64'h0;
    end else if (_T_507) begin
      fifo_data_1 <= _T_509;
    end else if (_T_103) begin
      fifo_data_1 <= io_dccm_dma_rdata;
    end else if (_T_106) begin
      fifo_data_1 <= io_iccm_dma_rdata;
    end else if (io_dbg_cmd_valid) begin
      fifo_data_1 <= _T_499;
    end else begin
      fifo_data_1 <= wrbuf_data;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_data_2 <= 64'h0;
    end else if (_T_522) begin
      fifo_data_2 <= _T_524;
    end else if (_T_121) begin
      fifo_data_2 <= io_dccm_dma_rdata;
    end else if (_T_124) begin
      fifo_data_2 <= io_iccm_dma_rdata;
    end else if (io_dbg_cmd_valid) begin
      fifo_data_2 <= _T_499;
    end else begin
      fifo_data_2 <= wrbuf_data;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_data_3 <= 64'h0;
    end else if (_T_537) begin
      fifo_data_3 <= _T_539;
    end else if (_T_139) begin
      fifo_data_3 <= io_dccm_dma_rdata;
    end else if (_T_142) begin
      fifo_data_3 <= io_iccm_dma_rdata;
    end else if (io_dbg_cmd_valid) begin
      fifo_data_3 <= _T_499;
    end else begin
      fifo_data_3 <= wrbuf_data;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      fifo_data_4 <= 64'h0;
    end else if (_T_552) begin
      fifo_data_4 <= _T_554;
    end else if (_T_157) begin
      fifo_data_4 <= io_dccm_dma_rdata;
    end else if (_T_160) begin
      fifo_data_4 <= io_iccm_dma_rdata;
    end else begin
      fifo_data_4 <= _T_501;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_tag_0 <= 1'h0;
    end else if (fifo_cmd_en[0]) begin
      if (axi_mstr_sel) begin
        fifo_tag_0 <= wrbuf_tag;
      end else begin
        fifo_tag_0 <= rdbuf_tag;
      end
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      wrbuf_tag <= 1'h0;
    end else if (wrbuf_en) begin
      wrbuf_tag <= io_dma_axi_awid;
    end
  end
  always @(posedge dma_bus_clk or posedge reset) begin
    if (reset) begin
      rdbuf_tag <= 1'h0;
    end else if (rdbuf_en) begin
      rdbuf_tag <= io_dma_axi_arid;
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_tag_1 <= 1'h0;
    end else if (fifo_cmd_en[1]) begin
      if (axi_mstr_sel) begin
        fifo_tag_1 <= wrbuf_tag;
      end else begin
        fifo_tag_1 <= rdbuf_tag;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_tag_2 <= 1'h0;
    end else if (fifo_cmd_en[2]) begin
      if (axi_mstr_sel) begin
        fifo_tag_2 <= wrbuf_tag;
      end else begin
        fifo_tag_2 <= rdbuf_tag;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_tag_3 <= 1'h0;
    end else if (fifo_cmd_en[3]) begin
      if (axi_mstr_sel) begin
        fifo_tag_3 <= wrbuf_tag;
      end else begin
        fifo_tag_3 <= rdbuf_tag;
      end
    end
  end
  always @(posedge dma_buffer_c1_clk or posedge reset) begin
    if (reset) begin
      fifo_tag_4 <= 1'h0;
    end else if (fifo_cmd_en[4]) begin
      fifo_tag_4 <= bus_cmd_tag;
    end
  end
  always @(posedge dma_free_clk or posedge reset) begin
    if (reset) begin
      dma_nack_count <= 3'h0;
    end else if (dma_mem_req) begin
      if (_T_1139) begin
        dma_nack_count <= _T_1152;
      end else if (_T_1156) begin
        dma_nack_count <= _T_1159;
      end else begin
        dma_nack_count <= 3'h0;
      end
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dma_dbg_cmd_done_q <= 1'h0;
    end else begin
      dma_dbg_cmd_done_q <= io_dma_dbg_cmd_done;
    end
  end
endmodule
