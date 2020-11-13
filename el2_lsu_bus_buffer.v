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
module el2_lsu_bus_buffer(
  input         clock,
  input         reset,
  input         io_scan_mode,
  input         io_dec_tlu_external_ldfwd_disable,
  input         io_dec_tlu_wb_coalescing_disable,
  input         io_dec_tlu_sideeffect_posted_disable,
  input         io_dec_tlu_force_halt,
  input         io_lsu_c2_r_clk,
  input         io_lsu_bus_ibuf_c1_clk,
  input         io_lsu_bus_obuf_c1_clk,
  input         io_lsu_bus_buf_c1_clk,
  input         io_lsu_free_c2_clk,
  input         io_lsu_busm_clk,
  input         io_dec_lsu_valid_raw_d,
  input         io_lsu_pkt_m_fast_int,
  input         io_lsu_pkt_m_by,
  input         io_lsu_pkt_m_half,
  input         io_lsu_pkt_m_word,
  input         io_lsu_pkt_m_dword,
  input         io_lsu_pkt_m_load,
  input         io_lsu_pkt_m_store,
  input         io_lsu_pkt_m_unsign,
  input         io_lsu_pkt_m_dma,
  input         io_lsu_pkt_m_store_data_bypass_d,
  input         io_lsu_pkt_m_load_ldst_bypass_d,
  input         io_lsu_pkt_m_store_data_bypass_m,
  input         io_lsu_pkt_m_valid,
  input         io_lsu_pkt_r_fast_int,
  input         io_lsu_pkt_r_by,
  input         io_lsu_pkt_r_half,
  input         io_lsu_pkt_r_word,
  input         io_lsu_pkt_r_dword,
  input         io_lsu_pkt_r_load,
  input         io_lsu_pkt_r_store,
  input         io_lsu_pkt_r_unsign,
  input         io_lsu_pkt_r_dma,
  input         io_lsu_pkt_r_store_data_bypass_d,
  input         io_lsu_pkt_r_load_ldst_bypass_d,
  input         io_lsu_pkt_r_store_data_bypass_m,
  input         io_lsu_pkt_r_valid,
  input  [31:0] io_lsu_addr_m,
  input  [31:0] io_end_addr_m,
  input  [31:0] io_lsu_addr_r,
  input  [31:0] io_end_addr_r,
  input  [31:0] io_store_data_r,
  input         io_no_word_merge_r,
  input         io_no_dword_merge_r,
  input         io_lsu_busreq_m,
  input         io_ld_full_hit_m,
  input         io_flush_m_up,
  input         io_flush_r,
  input         io_lsu_commit_r,
  input         io_is_sideeffects_r,
  input         io_ldst_dual_d,
  input         io_ldst_dual_m,
  input         io_ldst_dual_r,
  input  [7:0]  io_ldst_byteen_ext_m,
  input         io_lsu_axi_wready,
  input         io_lsu_axi_bvalid,
  input  [1:0]  io_lsu_axi_bresp,
  input  [2:0]  io_lsu_axi_bid,
  input         io_lsu_axi_arready,
  input         io_lsu_axi_rvalid,
  input  [2:0]  io_lsu_axi_rid,
  input  [63:0] io_lsu_axi_rdata,
  input  [1:0]  io_lsu_axi_rresp,
  input         io_lsu_bus_clk_en,
  input         io_lsu_bus_clk_en_q,
  output        io_lsu_busreq_r,
  output        io_lsu_bus_buffer_pend_any,
  output        io_lsu_bus_buffer_full_any,
  output        io_lsu_bus_buffer_empty_any,
  output        io_lsu_bus_idle_any,
  output [3:0]  io_ld_byte_hit_buf_lo,
  output [3:0]  io_ld_byte_hit_buf_hi,
  output [31:0] io_ld_fwddata_buf_lo,
  output [31:0] io_ld_fwddata_buf_hi,
  output        io_lsu_imprecise_error_load_any,
  output        io_lsu_imprecise_error_store_any,
  output [31:0] io_lsu_imprecise_error_addr_any,
  output        io_lsu_nonblock_load_valid_m,
  output [1:0]  io_lsu_nonblock_load_tag_m,
  output        io_lsu_nonblock_load_inv_r,
  output [1:0]  io_lsu_nonblock_load_inv_tag_r,
  output        io_lsu_nonblock_load_data_valid,
  output        io_lsu_nonblock_load_data_error,
  output [1:0]  io_lsu_nonblock_load_data_tag,
  output [31:0] io_lsu_nonblock_load_data,
  output        io_lsu_pmu_bus_trxn,
  output        io_lsu_pmu_bus_misaligned,
  output        io_lsu_pmu_bus_error,
  output        io_lsu_pmu_bus_busy,
  output        io_lsu_axi_awvalid,
  input         io_lsu_axi_awready,
  output [2:0]  io_lsu_axi_awid,
  output [31:0] io_lsu_axi_awaddr,
  output [3:0]  io_lsu_axi_awregion,
  output [7:0]  io_lsu_axi_awlen,
  output [2:0]  io_lsu_axi_awsize,
  output [1:0]  io_lsu_axi_awburst,
  output        io_lsu_axi_awlock,
  output [3:0]  io_lsu_axi_awcache,
  output [2:0]  io_lsu_axi_awprot,
  output [3:0]  io_lsu_axi_awqos,
  output        io_lsu_axi_wvalid,
  output [63:0] io_lsu_axi_wdata,
  output [7:0]  io_lsu_axi_wstrb,
  output        io_lsu_axi_wlast,
  output        io_lsu_axi_bready,
  output        io_lsu_axi_arvalid,
  output [2:0]  io_lsu_axi_arid,
  output [31:0] io_lsu_axi_araddr,
  output [3:0]  io_lsu_axi_arregion,
  output [7:0]  io_lsu_axi_arlen,
  output [2:0]  io_lsu_axi_arsize,
  output [1:0]  io_lsu_axi_arburst,
  output        io_lsu_axi_arlock,
  output [3:0]  io_lsu_axi_arcache,
  output [2:0]  io_lsu_axi_arprot,
  output [3:0]  io_lsu_axi_arqos,
  output        io_lsu_axi_rready
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
  reg [31:0] _RAND_49;
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
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [63:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
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
  wire  rvclkhdr_10_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_10_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_10_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_10_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_11_io_scan_mode; // @[el2_lib.scala 508:23]
  wire [3:0] ldst_byteen_hi_m = io_ldst_byteen_ext_m[7:4]; // @[el2_lsu_bus_buffer.scala 127:46]
  wire [3:0] ldst_byteen_lo_m = io_ldst_byteen_ext_m[3:0]; // @[el2_lsu_bus_buffer.scala 128:46]
  reg [31:0] buf_addr_0; // @[el2_lib.scala 514:16]
  wire  _T_2 = io_lsu_addr_m[31:2] == buf_addr_0[31:2]; // @[el2_lsu_bus_buffer.scala 130:74]
  reg  _T_4383; // @[Reg.scala 27:20]
  reg  _T_4380; // @[Reg.scala 27:20]
  reg  _T_4377; // @[Reg.scala 27:20]
  reg  _T_4374; // @[Reg.scala 27:20]
  wire [3:0] buf_write = {_T_4383,_T_4380,_T_4377,_T_4374}; // @[Cat.scala 29:58]
  wire  _T_4 = _T_2 & buf_write[0]; // @[el2_lsu_bus_buffer.scala 130:98]
  reg [2:0] buf_state_0; // @[Reg.scala 27:20]
  wire  _T_5 = buf_state_0 != 3'h0; // @[el2_lsu_bus_buffer.scala 130:129]
  wire  _T_6 = _T_4 & _T_5; // @[el2_lsu_bus_buffer.scala 130:113]
  wire  ld_addr_hitvec_lo_0 = _T_6 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 130:141]
  reg [31:0] buf_addr_1; // @[el2_lib.scala 514:16]
  wire  _T_9 = io_lsu_addr_m[31:2] == buf_addr_1[31:2]; // @[el2_lsu_bus_buffer.scala 130:74]
  wire  _T_11 = _T_9 & buf_write[1]; // @[el2_lsu_bus_buffer.scala 130:98]
  reg [2:0] buf_state_1; // @[Reg.scala 27:20]
  wire  _T_12 = buf_state_1 != 3'h0; // @[el2_lsu_bus_buffer.scala 130:129]
  wire  _T_13 = _T_11 & _T_12; // @[el2_lsu_bus_buffer.scala 130:113]
  wire  ld_addr_hitvec_lo_1 = _T_13 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 130:141]
  reg [31:0] buf_addr_2; // @[el2_lib.scala 514:16]
  wire  _T_16 = io_lsu_addr_m[31:2] == buf_addr_2[31:2]; // @[el2_lsu_bus_buffer.scala 130:74]
  wire  _T_18 = _T_16 & buf_write[2]; // @[el2_lsu_bus_buffer.scala 130:98]
  reg [2:0] buf_state_2; // @[Reg.scala 27:20]
  wire  _T_19 = buf_state_2 != 3'h0; // @[el2_lsu_bus_buffer.scala 130:129]
  wire  _T_20 = _T_18 & _T_19; // @[el2_lsu_bus_buffer.scala 130:113]
  wire  ld_addr_hitvec_lo_2 = _T_20 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 130:141]
  reg [31:0] buf_addr_3; // @[el2_lib.scala 514:16]
  wire  _T_23 = io_lsu_addr_m[31:2] == buf_addr_3[31:2]; // @[el2_lsu_bus_buffer.scala 130:74]
  wire  _T_25 = _T_23 & buf_write[3]; // @[el2_lsu_bus_buffer.scala 130:98]
  reg [2:0] buf_state_3; // @[Reg.scala 27:20]
  wire  _T_26 = buf_state_3 != 3'h0; // @[el2_lsu_bus_buffer.scala 130:129]
  wire  _T_27 = _T_25 & _T_26; // @[el2_lsu_bus_buffer.scala 130:113]
  wire  ld_addr_hitvec_lo_3 = _T_27 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 130:141]
  wire  _T_30 = io_end_addr_m[31:2] == buf_addr_0[31:2]; // @[el2_lsu_bus_buffer.scala 131:74]
  wire  _T_32 = _T_30 & buf_write[0]; // @[el2_lsu_bus_buffer.scala 131:98]
  wire  _T_34 = _T_32 & _T_5; // @[el2_lsu_bus_buffer.scala 131:113]
  wire  ld_addr_hitvec_hi_0 = _T_34 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 131:141]
  wire  _T_37 = io_end_addr_m[31:2] == buf_addr_1[31:2]; // @[el2_lsu_bus_buffer.scala 131:74]
  wire  _T_39 = _T_37 & buf_write[1]; // @[el2_lsu_bus_buffer.scala 131:98]
  wire  _T_41 = _T_39 & _T_12; // @[el2_lsu_bus_buffer.scala 131:113]
  wire  ld_addr_hitvec_hi_1 = _T_41 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 131:141]
  wire  _T_44 = io_end_addr_m[31:2] == buf_addr_2[31:2]; // @[el2_lsu_bus_buffer.scala 131:74]
  wire  _T_46 = _T_44 & buf_write[2]; // @[el2_lsu_bus_buffer.scala 131:98]
  wire  _T_48 = _T_46 & _T_19; // @[el2_lsu_bus_buffer.scala 131:113]
  wire  ld_addr_hitvec_hi_2 = _T_48 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 131:141]
  wire  _T_51 = io_end_addr_m[31:2] == buf_addr_3[31:2]; // @[el2_lsu_bus_buffer.scala 131:74]
  wire  _T_53 = _T_51 & buf_write[3]; // @[el2_lsu_bus_buffer.scala 131:98]
  wire  _T_55 = _T_53 & _T_26; // @[el2_lsu_bus_buffer.scala 131:113]
  wire  ld_addr_hitvec_hi_3 = _T_55 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 131:141]
  reg [3:0] buf_byteen_3; // @[Reg.scala 27:20]
  wire  _T_99 = ld_addr_hitvec_lo_3 & buf_byteen_3[0]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_101 = _T_99 & ldst_byteen_lo_m[0]; // @[el2_lsu_bus_buffer.scala 194:114]
  reg [3:0] buf_byteen_2; // @[Reg.scala 27:20]
  wire  _T_95 = ld_addr_hitvec_lo_2 & buf_byteen_2[0]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_97 = _T_95 & ldst_byteen_lo_m[0]; // @[el2_lsu_bus_buffer.scala 194:114]
  reg [3:0] buf_byteen_1; // @[Reg.scala 27:20]
  wire  _T_91 = ld_addr_hitvec_lo_1 & buf_byteen_1[0]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_93 = _T_91 & ldst_byteen_lo_m[0]; // @[el2_lsu_bus_buffer.scala 194:114]
  reg [3:0] buf_byteen_0; // @[Reg.scala 27:20]
  wire  _T_87 = ld_addr_hitvec_lo_0 & buf_byteen_0[0]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_89 = _T_87 & ldst_byteen_lo_m[0]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire [3:0] ld_byte_hitvec_lo_0 = {_T_101,_T_97,_T_93,_T_89}; // @[Cat.scala 29:58]
  reg [3:0] buf_ageQ_3; // @[el2_lsu_bus_buffer.scala 555:60]
  wire  _T_2644 = buf_state_3 == 3'h2; // @[el2_lsu_bus_buffer.scala 467:95]
  wire  _T_4130 = 3'h0 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4153 = 3'h1 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4157 = 3'h2 == buf_state_3; // @[Conditional.scala 37:30]
  reg [2:0] obuf_tag0; // @[Reg.scala 27:20]
  wire  _T_4164 = obuf_tag0 == 3'h3; // @[el2_lsu_bus_buffer.scala 510:48]
  reg  obuf_merge; // @[Reg.scala 27:20]
  reg [2:0] obuf_tag1; // @[Reg.scala 27:20]
  wire  _T_4165 = obuf_tag1 == 3'h3; // @[el2_lsu_bus_buffer.scala 510:104]
  wire  _T_4166 = obuf_merge & _T_4165; // @[el2_lsu_bus_buffer.scala 510:91]
  wire  _T_4167 = _T_4164 | _T_4166; // @[el2_lsu_bus_buffer.scala 510:77]
  reg  obuf_valid; // @[el2_lsu_bus_buffer.scala 401:54]
  wire  _T_4168 = _T_4167 & obuf_valid; // @[el2_lsu_bus_buffer.scala 510:135]
  reg  obuf_wr_enQ; // @[el2_lsu_bus_buffer.scala 400:55]
  wire  _T_4169 = _T_4168 & obuf_wr_enQ; // @[el2_lsu_bus_buffer.scala 510:148]
  wire  _GEN_280 = _T_4157 & _T_4169; // @[Conditional.scala 39:67]
  wire  _GEN_293 = _T_4153 ? 1'h0 : _GEN_280; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_3 = _T_4130 ? 1'h0 : _GEN_293; // @[Conditional.scala 40:58]
  wire  _T_2645 = _T_2644 & buf_cmd_state_bus_en_3; // @[el2_lsu_bus_buffer.scala 467:105]
  wire  _T_2646 = ~_T_2645; // @[el2_lsu_bus_buffer.scala 467:80]
  wire  _T_2647 = buf_ageQ_3[3] & _T_2646; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2639 = buf_state_2 == 3'h2; // @[el2_lsu_bus_buffer.scala 467:95]
  wire  _T_3937 = 3'h0 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_3960 = 3'h1 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_3964 = 3'h2 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_3971 = obuf_tag0 == 3'h2; // @[el2_lsu_bus_buffer.scala 510:48]
  wire  _T_3972 = obuf_tag1 == 3'h2; // @[el2_lsu_bus_buffer.scala 510:104]
  wire  _T_3973 = obuf_merge & _T_3972; // @[el2_lsu_bus_buffer.scala 510:91]
  wire  _T_3974 = _T_3971 | _T_3973; // @[el2_lsu_bus_buffer.scala 510:77]
  wire  _T_3975 = _T_3974 & obuf_valid; // @[el2_lsu_bus_buffer.scala 510:135]
  wire  _T_3976 = _T_3975 & obuf_wr_enQ; // @[el2_lsu_bus_buffer.scala 510:148]
  wire  _GEN_204 = _T_3964 & _T_3976; // @[Conditional.scala 39:67]
  wire  _GEN_217 = _T_3960 ? 1'h0 : _GEN_204; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_2 = _T_3937 ? 1'h0 : _GEN_217; // @[Conditional.scala 40:58]
  wire  _T_2640 = _T_2639 & buf_cmd_state_bus_en_2; // @[el2_lsu_bus_buffer.scala 467:105]
  wire  _T_2641 = ~_T_2640; // @[el2_lsu_bus_buffer.scala 467:80]
  wire  _T_2642 = buf_ageQ_3[2] & _T_2641; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2634 = buf_state_1 == 3'h2; // @[el2_lsu_bus_buffer.scala 467:95]
  wire  _T_3744 = 3'h0 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3767 = 3'h1 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3771 = 3'h2 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3778 = obuf_tag0 == 3'h1; // @[el2_lsu_bus_buffer.scala 510:48]
  wire  _T_3779 = obuf_tag1 == 3'h1; // @[el2_lsu_bus_buffer.scala 510:104]
  wire  _T_3780 = obuf_merge & _T_3779; // @[el2_lsu_bus_buffer.scala 510:91]
  wire  _T_3781 = _T_3778 | _T_3780; // @[el2_lsu_bus_buffer.scala 510:77]
  wire  _T_3782 = _T_3781 & obuf_valid; // @[el2_lsu_bus_buffer.scala 510:135]
  wire  _T_3783 = _T_3782 & obuf_wr_enQ; // @[el2_lsu_bus_buffer.scala 510:148]
  wire  _GEN_128 = _T_3771 & _T_3783; // @[Conditional.scala 39:67]
  wire  _GEN_141 = _T_3767 ? 1'h0 : _GEN_128; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_1 = _T_3744 ? 1'h0 : _GEN_141; // @[Conditional.scala 40:58]
  wire  _T_2635 = _T_2634 & buf_cmd_state_bus_en_1; // @[el2_lsu_bus_buffer.scala 467:105]
  wire  _T_2636 = ~_T_2635; // @[el2_lsu_bus_buffer.scala 467:80]
  wire  _T_2637 = buf_ageQ_3[1] & _T_2636; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2629 = buf_state_0 == 3'h2; // @[el2_lsu_bus_buffer.scala 467:95]
  wire  _T_3551 = 3'h0 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _T_3574 = 3'h1 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _T_3578 = 3'h2 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _T_3585 = obuf_tag0 == 3'h0; // @[el2_lsu_bus_buffer.scala 510:48]
  wire  _T_3586 = obuf_tag1 == 3'h0; // @[el2_lsu_bus_buffer.scala 510:104]
  wire  _T_3587 = obuf_merge & _T_3586; // @[el2_lsu_bus_buffer.scala 510:91]
  wire  _T_3588 = _T_3585 | _T_3587; // @[el2_lsu_bus_buffer.scala 510:77]
  wire  _T_3589 = _T_3588 & obuf_valid; // @[el2_lsu_bus_buffer.scala 510:135]
  wire  _T_3590 = _T_3589 & obuf_wr_enQ; // @[el2_lsu_bus_buffer.scala 510:148]
  wire  _GEN_52 = _T_3578 & _T_3590; // @[Conditional.scala 39:67]
  wire  _GEN_65 = _T_3574 ? 1'h0 : _GEN_52; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_0 = _T_3551 ? 1'h0 : _GEN_65; // @[Conditional.scala 40:58]
  wire  _T_2630 = _T_2629 & buf_cmd_state_bus_en_0; // @[el2_lsu_bus_buffer.scala 467:105]
  wire  _T_2631 = ~_T_2630; // @[el2_lsu_bus_buffer.scala 467:80]
  wire  _T_2632 = buf_ageQ_3[0] & _T_2631; // @[el2_lsu_bus_buffer.scala 467:78]
  wire [3:0] buf_age_3 = {_T_2647,_T_2642,_T_2637,_T_2632}; // @[Cat.scala 29:58]
  wire  _T_2746 = ~buf_age_3[2]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2748 = _T_2746 & _T_19; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2740 = ~buf_age_3[1]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2742 = _T_2740 & _T_12; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2734 = ~buf_age_3[0]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2736 = _T_2734 & _T_5; // @[el2_lsu_bus_buffer.scala 468:106]
  wire [3:0] buf_age_younger_3 = {1'h0,_T_2748,_T_2742,_T_2736}; // @[Cat.scala 29:58]
  wire [3:0] _T_255 = ld_byte_hitvec_lo_0 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_256 = |_T_255; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_257 = ~_T_256; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_258 = ld_byte_hitvec_lo_0[3] & _T_257; // @[el2_lsu_bus_buffer.scala 199:97]
  reg [31:0] ibuf_addr; // @[el2_lib.scala 514:16]
  wire  _T_512 = io_lsu_addr_m[31:2] == ibuf_addr[31:2]; // @[el2_lsu_bus_buffer.scala 205:51]
  reg  ibuf_write; // @[Reg.scala 27:20]
  wire  _T_513 = _T_512 & ibuf_write; // @[el2_lsu_bus_buffer.scala 205:73]
  reg  ibuf_valid; // @[el2_lsu_bus_buffer.scala 292:24]
  wire  _T_514 = _T_513 & ibuf_valid; // @[el2_lsu_bus_buffer.scala 205:86]
  wire  ld_addr_ibuf_hit_lo = _T_514 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 205:99]
  wire [3:0] _T_521 = ld_addr_ibuf_hit_lo ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  reg [3:0] ibuf_byteen; // @[Reg.scala 27:20]
  wire [3:0] _T_522 = _T_521 & ibuf_byteen; // @[el2_lsu_bus_buffer.scala 210:55]
  wire [3:0] ld_byte_ibuf_hit_lo = _T_522 & ldst_byteen_lo_m; // @[el2_lsu_bus_buffer.scala 210:69]
  wire  _T_260 = ~ld_byte_ibuf_hit_lo[0]; // @[el2_lsu_bus_buffer.scala 199:150]
  wire  _T_261 = _T_258 & _T_260; // @[el2_lsu_bus_buffer.scala 199:148]
  reg [3:0] buf_ageQ_2; // @[el2_lsu_bus_buffer.scala 555:60]
  wire  _T_2624 = buf_ageQ_2[3] & _T_2646; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2619 = buf_ageQ_2[2] & _T_2641; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2614 = buf_ageQ_2[1] & _T_2636; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2609 = buf_ageQ_2[0] & _T_2631; // @[el2_lsu_bus_buffer.scala 467:78]
  wire [3:0] buf_age_2 = {_T_2624,_T_2619,_T_2614,_T_2609}; // @[Cat.scala 29:58]
  wire  _T_2725 = ~buf_age_2[3]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2727 = _T_2725 & _T_26; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2713 = ~buf_age_2[1]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2715 = _T_2713 & _T_12; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2707 = ~buf_age_2[0]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2709 = _T_2707 & _T_5; // @[el2_lsu_bus_buffer.scala 468:106]
  wire [3:0] buf_age_younger_2 = {_T_2727,1'h0,_T_2715,_T_2709}; // @[Cat.scala 29:58]
  wire [3:0] _T_247 = ld_byte_hitvec_lo_0 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_248 = |_T_247; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_249 = ~_T_248; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_250 = ld_byte_hitvec_lo_0[2] & _T_249; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_253 = _T_250 & _T_260; // @[el2_lsu_bus_buffer.scala 199:148]
  reg [3:0] buf_ageQ_1; // @[el2_lsu_bus_buffer.scala 555:60]
  wire  _T_2601 = buf_ageQ_1[3] & _T_2646; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2596 = buf_ageQ_1[2] & _T_2641; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2591 = buf_ageQ_1[1] & _T_2636; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2586 = buf_ageQ_1[0] & _T_2631; // @[el2_lsu_bus_buffer.scala 467:78]
  wire [3:0] buf_age_1 = {_T_2601,_T_2596,_T_2591,_T_2586}; // @[Cat.scala 29:58]
  wire  _T_2698 = ~buf_age_1[3]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2700 = _T_2698 & _T_26; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2692 = ~buf_age_1[2]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2694 = _T_2692 & _T_19; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2680 = ~buf_age_1[0]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2682 = _T_2680 & _T_5; // @[el2_lsu_bus_buffer.scala 468:106]
  wire [3:0] buf_age_younger_1 = {_T_2700,_T_2694,1'h0,_T_2682}; // @[Cat.scala 29:58]
  wire [3:0] _T_239 = ld_byte_hitvec_lo_0 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_240 = |_T_239; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_241 = ~_T_240; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_242 = ld_byte_hitvec_lo_0[1] & _T_241; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_245 = _T_242 & _T_260; // @[el2_lsu_bus_buffer.scala 199:148]
  reg [3:0] buf_ageQ_0; // @[el2_lsu_bus_buffer.scala 555:60]
  wire  _T_2578 = buf_ageQ_0[3] & _T_2646; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2573 = buf_ageQ_0[2] & _T_2641; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2568 = buf_ageQ_0[1] & _T_2636; // @[el2_lsu_bus_buffer.scala 467:78]
  wire  _T_2563 = buf_ageQ_0[0] & _T_2631; // @[el2_lsu_bus_buffer.scala 467:78]
  wire [3:0] buf_age_0 = {_T_2578,_T_2573,_T_2568,_T_2563}; // @[Cat.scala 29:58]
  wire  _T_2671 = ~buf_age_0[3]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2673 = _T_2671 & _T_26; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2665 = ~buf_age_0[2]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2667 = _T_2665 & _T_19; // @[el2_lsu_bus_buffer.scala 468:106]
  wire  _T_2659 = ~buf_age_0[1]; // @[el2_lsu_bus_buffer.scala 468:91]
  wire  _T_2661 = _T_2659 & _T_12; // @[el2_lsu_bus_buffer.scala 468:106]
  wire [3:0] buf_age_younger_0 = {_T_2673,_T_2667,_T_2661,1'h0}; // @[Cat.scala 29:58]
  wire [3:0] _T_231 = ld_byte_hitvec_lo_0 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_232 = |_T_231; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_233 = ~_T_232; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_234 = ld_byte_hitvec_lo_0[0] & _T_233; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_237 = _T_234 & _T_260; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] ld_byte_hitvecfn_lo_0 = {_T_261,_T_253,_T_245,_T_237}; // @[Cat.scala 29:58]
  wire  _T_56 = |ld_byte_hitvecfn_lo_0; // @[el2_lsu_bus_buffer.scala 191:73]
  wire  _T_58 = _T_56 | ld_byte_ibuf_hit_lo[0]; // @[el2_lsu_bus_buffer.scala 191:77]
  wire  _T_117 = ld_addr_hitvec_lo_3 & buf_byteen_3[1]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_119 = _T_117 & ldst_byteen_lo_m[1]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_113 = ld_addr_hitvec_lo_2 & buf_byteen_2[1]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_115 = _T_113 & ldst_byteen_lo_m[1]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_109 = ld_addr_hitvec_lo_1 & buf_byteen_1[1]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_111 = _T_109 & ldst_byteen_lo_m[1]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_105 = ld_addr_hitvec_lo_0 & buf_byteen_0[1]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_107 = _T_105 & ldst_byteen_lo_m[1]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire [3:0] ld_byte_hitvec_lo_1 = {_T_119,_T_115,_T_111,_T_107}; // @[Cat.scala 29:58]
  wire [3:0] _T_290 = ld_byte_hitvec_lo_1 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_291 = |_T_290; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_292 = ~_T_291; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_293 = ld_byte_hitvec_lo_1[3] & _T_292; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_295 = ~ld_byte_ibuf_hit_lo[1]; // @[el2_lsu_bus_buffer.scala 199:150]
  wire  _T_296 = _T_293 & _T_295; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_282 = ld_byte_hitvec_lo_1 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_283 = |_T_282; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_284 = ~_T_283; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_285 = ld_byte_hitvec_lo_1[2] & _T_284; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_288 = _T_285 & _T_295; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_274 = ld_byte_hitvec_lo_1 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_275 = |_T_274; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_276 = ~_T_275; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_277 = ld_byte_hitvec_lo_1[1] & _T_276; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_280 = _T_277 & _T_295; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_266 = ld_byte_hitvec_lo_1 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_267 = |_T_266; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_268 = ~_T_267; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_269 = ld_byte_hitvec_lo_1[0] & _T_268; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_272 = _T_269 & _T_295; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] ld_byte_hitvecfn_lo_1 = {_T_296,_T_288,_T_280,_T_272}; // @[Cat.scala 29:58]
  wire  _T_59 = |ld_byte_hitvecfn_lo_1; // @[el2_lsu_bus_buffer.scala 191:73]
  wire  _T_61 = _T_59 | ld_byte_ibuf_hit_lo[1]; // @[el2_lsu_bus_buffer.scala 191:77]
  wire  _T_135 = ld_addr_hitvec_lo_3 & buf_byteen_3[2]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_137 = _T_135 & ldst_byteen_lo_m[2]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_131 = ld_addr_hitvec_lo_2 & buf_byteen_2[2]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_133 = _T_131 & ldst_byteen_lo_m[2]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_127 = ld_addr_hitvec_lo_1 & buf_byteen_1[2]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_129 = _T_127 & ldst_byteen_lo_m[2]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_123 = ld_addr_hitvec_lo_0 & buf_byteen_0[2]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_125 = _T_123 & ldst_byteen_lo_m[2]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire [3:0] ld_byte_hitvec_lo_2 = {_T_137,_T_133,_T_129,_T_125}; // @[Cat.scala 29:58]
  wire [3:0] _T_325 = ld_byte_hitvec_lo_2 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_326 = |_T_325; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_327 = ~_T_326; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_328 = ld_byte_hitvec_lo_2[3] & _T_327; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_330 = ~ld_byte_ibuf_hit_lo[2]; // @[el2_lsu_bus_buffer.scala 199:150]
  wire  _T_331 = _T_328 & _T_330; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_317 = ld_byte_hitvec_lo_2 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_318 = |_T_317; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_319 = ~_T_318; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_320 = ld_byte_hitvec_lo_2[2] & _T_319; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_323 = _T_320 & _T_330; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_309 = ld_byte_hitvec_lo_2 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_310 = |_T_309; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_311 = ~_T_310; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_312 = ld_byte_hitvec_lo_2[1] & _T_311; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_315 = _T_312 & _T_330; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_301 = ld_byte_hitvec_lo_2 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_302 = |_T_301; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_303 = ~_T_302; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_304 = ld_byte_hitvec_lo_2[0] & _T_303; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_307 = _T_304 & _T_330; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] ld_byte_hitvecfn_lo_2 = {_T_331,_T_323,_T_315,_T_307}; // @[Cat.scala 29:58]
  wire  _T_62 = |ld_byte_hitvecfn_lo_2; // @[el2_lsu_bus_buffer.scala 191:73]
  wire  _T_64 = _T_62 | ld_byte_ibuf_hit_lo[2]; // @[el2_lsu_bus_buffer.scala 191:77]
  wire  _T_153 = ld_addr_hitvec_lo_3 & buf_byteen_3[3]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_155 = _T_153 & ldst_byteen_lo_m[3]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_149 = ld_addr_hitvec_lo_2 & buf_byteen_2[3]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_151 = _T_149 & ldst_byteen_lo_m[3]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_145 = ld_addr_hitvec_lo_1 & buf_byteen_1[3]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_147 = _T_145 & ldst_byteen_lo_m[3]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire  _T_141 = ld_addr_hitvec_lo_0 & buf_byteen_0[3]; // @[el2_lsu_bus_buffer.scala 194:95]
  wire  _T_143 = _T_141 & ldst_byteen_lo_m[3]; // @[el2_lsu_bus_buffer.scala 194:114]
  wire [3:0] ld_byte_hitvec_lo_3 = {_T_155,_T_151,_T_147,_T_143}; // @[Cat.scala 29:58]
  wire [3:0] _T_360 = ld_byte_hitvec_lo_3 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_361 = |_T_360; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_362 = ~_T_361; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_363 = ld_byte_hitvec_lo_3[3] & _T_362; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_365 = ~ld_byte_ibuf_hit_lo[3]; // @[el2_lsu_bus_buffer.scala 199:150]
  wire  _T_366 = _T_363 & _T_365; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_352 = ld_byte_hitvec_lo_3 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_353 = |_T_352; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_354 = ~_T_353; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_355 = ld_byte_hitvec_lo_3[2] & _T_354; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_358 = _T_355 & _T_365; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_344 = ld_byte_hitvec_lo_3 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_345 = |_T_344; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_346 = ~_T_345; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_347 = ld_byte_hitvec_lo_3[1] & _T_346; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_350 = _T_347 & _T_365; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] _T_336 = ld_byte_hitvec_lo_3 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 199:122]
  wire  _T_337 = |_T_336; // @[el2_lsu_bus_buffer.scala 199:144]
  wire  _T_338 = ~_T_337; // @[el2_lsu_bus_buffer.scala 199:99]
  wire  _T_339 = ld_byte_hitvec_lo_3[0] & _T_338; // @[el2_lsu_bus_buffer.scala 199:97]
  wire  _T_342 = _T_339 & _T_365; // @[el2_lsu_bus_buffer.scala 199:148]
  wire [3:0] ld_byte_hitvecfn_lo_3 = {_T_366,_T_358,_T_350,_T_342}; // @[Cat.scala 29:58]
  wire  _T_65 = |ld_byte_hitvecfn_lo_3; // @[el2_lsu_bus_buffer.scala 191:73]
  wire  _T_67 = _T_65 | ld_byte_ibuf_hit_lo[3]; // @[el2_lsu_bus_buffer.scala 191:77]
  wire [2:0] _T_69 = {_T_67,_T_64,_T_61}; // @[Cat.scala 29:58]
  wire  _T_171 = ld_addr_hitvec_hi_3 & buf_byteen_3[0]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_173 = _T_171 & ldst_byteen_hi_m[0]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_167 = ld_addr_hitvec_hi_2 & buf_byteen_2[0]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_169 = _T_167 & ldst_byteen_hi_m[0]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_163 = ld_addr_hitvec_hi_1 & buf_byteen_1[0]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_165 = _T_163 & ldst_byteen_hi_m[0]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_159 = ld_addr_hitvec_hi_0 & buf_byteen_0[0]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_161 = _T_159 & ldst_byteen_hi_m[0]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire [3:0] ld_byte_hitvec_hi_0 = {_T_173,_T_169,_T_165,_T_161}; // @[Cat.scala 29:58]
  wire [3:0] _T_395 = ld_byte_hitvec_hi_0 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_396 = |_T_395; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_397 = ~_T_396; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_398 = ld_byte_hitvec_hi_0[3] & _T_397; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_517 = io_end_addr_m[31:2] == ibuf_addr[31:2]; // @[el2_lsu_bus_buffer.scala 206:51]
  wire  _T_518 = _T_517 & ibuf_write; // @[el2_lsu_bus_buffer.scala 206:73]
  wire  _T_519 = _T_518 & ibuf_valid; // @[el2_lsu_bus_buffer.scala 206:86]
  wire  ld_addr_ibuf_hit_hi = _T_519 & io_lsu_busreq_m; // @[el2_lsu_bus_buffer.scala 206:99]
  wire [3:0] _T_525 = ld_addr_ibuf_hit_hi ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_526 = _T_525 & ibuf_byteen; // @[el2_lsu_bus_buffer.scala 211:55]
  wire [3:0] ld_byte_ibuf_hit_hi = _T_526 & ldst_byteen_hi_m; // @[el2_lsu_bus_buffer.scala 211:69]
  wire  _T_400 = ~ld_byte_ibuf_hit_hi[0]; // @[el2_lsu_bus_buffer.scala 200:150]
  wire  _T_401 = _T_398 & _T_400; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_387 = ld_byte_hitvec_hi_0 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_388 = |_T_387; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_389 = ~_T_388; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_390 = ld_byte_hitvec_hi_0[2] & _T_389; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_393 = _T_390 & _T_400; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_379 = ld_byte_hitvec_hi_0 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_380 = |_T_379; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_381 = ~_T_380; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_382 = ld_byte_hitvec_hi_0[1] & _T_381; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_385 = _T_382 & _T_400; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_371 = ld_byte_hitvec_hi_0 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_372 = |_T_371; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_373 = ~_T_372; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_374 = ld_byte_hitvec_hi_0[0] & _T_373; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_377 = _T_374 & _T_400; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] ld_byte_hitvecfn_hi_0 = {_T_401,_T_393,_T_385,_T_377}; // @[Cat.scala 29:58]
  wire  _T_71 = |ld_byte_hitvecfn_hi_0; // @[el2_lsu_bus_buffer.scala 192:73]
  wire  _T_73 = _T_71 | ld_byte_ibuf_hit_hi[0]; // @[el2_lsu_bus_buffer.scala 192:77]
  wire  _T_189 = ld_addr_hitvec_hi_3 & buf_byteen_3[1]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_191 = _T_189 & ldst_byteen_hi_m[1]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_185 = ld_addr_hitvec_hi_2 & buf_byteen_2[1]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_187 = _T_185 & ldst_byteen_hi_m[1]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_181 = ld_addr_hitvec_hi_1 & buf_byteen_1[1]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_183 = _T_181 & ldst_byteen_hi_m[1]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_177 = ld_addr_hitvec_hi_0 & buf_byteen_0[1]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_179 = _T_177 & ldst_byteen_hi_m[1]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire [3:0] ld_byte_hitvec_hi_1 = {_T_191,_T_187,_T_183,_T_179}; // @[Cat.scala 29:58]
  wire [3:0] _T_430 = ld_byte_hitvec_hi_1 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_431 = |_T_430; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_432 = ~_T_431; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_433 = ld_byte_hitvec_hi_1[3] & _T_432; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_435 = ~ld_byte_ibuf_hit_hi[1]; // @[el2_lsu_bus_buffer.scala 200:150]
  wire  _T_436 = _T_433 & _T_435; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_422 = ld_byte_hitvec_hi_1 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_423 = |_T_422; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_424 = ~_T_423; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_425 = ld_byte_hitvec_hi_1[2] & _T_424; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_428 = _T_425 & _T_435; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_414 = ld_byte_hitvec_hi_1 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_415 = |_T_414; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_416 = ~_T_415; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_417 = ld_byte_hitvec_hi_1[1] & _T_416; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_420 = _T_417 & _T_435; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_406 = ld_byte_hitvec_hi_1 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_407 = |_T_406; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_408 = ~_T_407; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_409 = ld_byte_hitvec_hi_1[0] & _T_408; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_412 = _T_409 & _T_435; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] ld_byte_hitvecfn_hi_1 = {_T_436,_T_428,_T_420,_T_412}; // @[Cat.scala 29:58]
  wire  _T_74 = |ld_byte_hitvecfn_hi_1; // @[el2_lsu_bus_buffer.scala 192:73]
  wire  _T_76 = _T_74 | ld_byte_ibuf_hit_hi[1]; // @[el2_lsu_bus_buffer.scala 192:77]
  wire  _T_207 = ld_addr_hitvec_hi_3 & buf_byteen_3[2]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_209 = _T_207 & ldst_byteen_hi_m[2]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_203 = ld_addr_hitvec_hi_2 & buf_byteen_2[2]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_205 = _T_203 & ldst_byteen_hi_m[2]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_199 = ld_addr_hitvec_hi_1 & buf_byteen_1[2]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_201 = _T_199 & ldst_byteen_hi_m[2]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_195 = ld_addr_hitvec_hi_0 & buf_byteen_0[2]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_197 = _T_195 & ldst_byteen_hi_m[2]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire [3:0] ld_byte_hitvec_hi_2 = {_T_209,_T_205,_T_201,_T_197}; // @[Cat.scala 29:58]
  wire [3:0] _T_465 = ld_byte_hitvec_hi_2 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_466 = |_T_465; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_467 = ~_T_466; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_468 = ld_byte_hitvec_hi_2[3] & _T_467; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_470 = ~ld_byte_ibuf_hit_hi[2]; // @[el2_lsu_bus_buffer.scala 200:150]
  wire  _T_471 = _T_468 & _T_470; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_457 = ld_byte_hitvec_hi_2 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_458 = |_T_457; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_459 = ~_T_458; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_460 = ld_byte_hitvec_hi_2[2] & _T_459; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_463 = _T_460 & _T_470; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_449 = ld_byte_hitvec_hi_2 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_450 = |_T_449; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_451 = ~_T_450; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_452 = ld_byte_hitvec_hi_2[1] & _T_451; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_455 = _T_452 & _T_470; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_441 = ld_byte_hitvec_hi_2 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_442 = |_T_441; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_443 = ~_T_442; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_444 = ld_byte_hitvec_hi_2[0] & _T_443; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_447 = _T_444 & _T_470; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] ld_byte_hitvecfn_hi_2 = {_T_471,_T_463,_T_455,_T_447}; // @[Cat.scala 29:58]
  wire  _T_77 = |ld_byte_hitvecfn_hi_2; // @[el2_lsu_bus_buffer.scala 192:73]
  wire  _T_79 = _T_77 | ld_byte_ibuf_hit_hi[2]; // @[el2_lsu_bus_buffer.scala 192:77]
  wire  _T_225 = ld_addr_hitvec_hi_3 & buf_byteen_3[3]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_227 = _T_225 & ldst_byteen_hi_m[3]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_221 = ld_addr_hitvec_hi_2 & buf_byteen_2[3]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_223 = _T_221 & ldst_byteen_hi_m[3]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_217 = ld_addr_hitvec_hi_1 & buf_byteen_1[3]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_219 = _T_217 & ldst_byteen_hi_m[3]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire  _T_213 = ld_addr_hitvec_hi_0 & buf_byteen_0[3]; // @[el2_lsu_bus_buffer.scala 195:95]
  wire  _T_215 = _T_213 & ldst_byteen_hi_m[3]; // @[el2_lsu_bus_buffer.scala 195:114]
  wire [3:0] ld_byte_hitvec_hi_3 = {_T_227,_T_223,_T_219,_T_215}; // @[Cat.scala 29:58]
  wire [3:0] _T_500 = ld_byte_hitvec_hi_3 & buf_age_younger_3; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_501 = |_T_500; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_502 = ~_T_501; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_503 = ld_byte_hitvec_hi_3[3] & _T_502; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_505 = ~ld_byte_ibuf_hit_hi[3]; // @[el2_lsu_bus_buffer.scala 200:150]
  wire  _T_506 = _T_503 & _T_505; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_492 = ld_byte_hitvec_hi_3 & buf_age_younger_2; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_493 = |_T_492; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_494 = ~_T_493; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_495 = ld_byte_hitvec_hi_3[2] & _T_494; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_498 = _T_495 & _T_505; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_484 = ld_byte_hitvec_hi_3 & buf_age_younger_1; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_485 = |_T_484; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_486 = ~_T_485; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_487 = ld_byte_hitvec_hi_3[1] & _T_486; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_490 = _T_487 & _T_505; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] _T_476 = ld_byte_hitvec_hi_3 & buf_age_younger_0; // @[el2_lsu_bus_buffer.scala 200:122]
  wire  _T_477 = |_T_476; // @[el2_lsu_bus_buffer.scala 200:144]
  wire  _T_478 = ~_T_477; // @[el2_lsu_bus_buffer.scala 200:99]
  wire  _T_479 = ld_byte_hitvec_hi_3[0] & _T_478; // @[el2_lsu_bus_buffer.scala 200:97]
  wire  _T_482 = _T_479 & _T_505; // @[el2_lsu_bus_buffer.scala 200:148]
  wire [3:0] ld_byte_hitvecfn_hi_3 = {_T_506,_T_498,_T_490,_T_482}; // @[Cat.scala 29:58]
  wire  _T_80 = |ld_byte_hitvecfn_hi_3; // @[el2_lsu_bus_buffer.scala 192:73]
  wire  _T_82 = _T_80 | ld_byte_ibuf_hit_hi[3]; // @[el2_lsu_bus_buffer.scala 192:77]
  wire [2:0] _T_84 = {_T_82,_T_79,_T_76}; // @[Cat.scala 29:58]
  wire [7:0] _T_530 = ld_byte_ibuf_hit_lo[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_533 = ld_byte_ibuf_hit_lo[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_536 = ld_byte_ibuf_hit_lo[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_539 = ld_byte_ibuf_hit_lo[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [31:0] ld_fwddata_buf_lo_initial = {_T_539,_T_536,_T_533,_T_530}; // @[Cat.scala 29:58]
  wire [7:0] _T_544 = ld_byte_ibuf_hit_hi[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_547 = ld_byte_ibuf_hit_hi[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_550 = ld_byte_ibuf_hit_hi[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_553 = ld_byte_ibuf_hit_hi[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [31:0] ld_fwddata_buf_hi_initial = {_T_553,_T_550,_T_547,_T_544}; // @[Cat.scala 29:58]
  wire [7:0] _T_558 = ld_byte_hitvecfn_lo_3[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_0; // @[el2_lib.scala 514:16]
  wire [7:0] _T_560 = _T_558 & buf_data_0[31:24]; // @[el2_lsu_bus_buffer.scala 218:91]
  wire [7:0] _T_563 = ld_byte_hitvecfn_lo_3[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_1; // @[el2_lib.scala 514:16]
  wire [7:0] _T_565 = _T_563 & buf_data_1[31:24]; // @[el2_lsu_bus_buffer.scala 218:91]
  wire [7:0] _T_568 = ld_byte_hitvecfn_lo_3[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_2; // @[el2_lib.scala 514:16]
  wire [7:0] _T_570 = _T_568 & buf_data_2[31:24]; // @[el2_lsu_bus_buffer.scala 218:91]
  wire [7:0] _T_573 = ld_byte_hitvecfn_lo_3[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_3; // @[el2_lib.scala 514:16]
  wire [7:0] _T_575 = _T_573 & buf_data_3[31:24]; // @[el2_lsu_bus_buffer.scala 218:91]
  wire [7:0] _T_576 = _T_560 | _T_565; // @[el2_lsu_bus_buffer.scala 218:123]
  wire [7:0] _T_577 = _T_576 | _T_570; // @[el2_lsu_bus_buffer.scala 218:123]
  wire [7:0] _T_578 = _T_577 | _T_575; // @[el2_lsu_bus_buffer.scala 218:123]
  wire [7:0] _T_581 = ld_byte_hitvecfn_lo_2[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_583 = _T_581 & buf_data_0[23:16]; // @[el2_lsu_bus_buffer.scala 219:91]
  wire [7:0] _T_586 = ld_byte_hitvecfn_lo_2[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_588 = _T_586 & buf_data_1[23:16]; // @[el2_lsu_bus_buffer.scala 219:91]
  wire [7:0] _T_591 = ld_byte_hitvecfn_lo_2[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_593 = _T_591 & buf_data_2[23:16]; // @[el2_lsu_bus_buffer.scala 219:91]
  wire [7:0] _T_596 = ld_byte_hitvecfn_lo_2[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_598 = _T_596 & buf_data_3[23:16]; // @[el2_lsu_bus_buffer.scala 219:91]
  wire [7:0] _T_599 = _T_583 | _T_588; // @[el2_lsu_bus_buffer.scala 219:123]
  wire [7:0] _T_600 = _T_599 | _T_593; // @[el2_lsu_bus_buffer.scala 219:123]
  wire [7:0] _T_601 = _T_600 | _T_598; // @[el2_lsu_bus_buffer.scala 219:123]
  wire [7:0] _T_604 = ld_byte_hitvecfn_lo_1[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_606 = _T_604 & buf_data_0[15:8]; // @[el2_lsu_bus_buffer.scala 220:91]
  wire [7:0] _T_609 = ld_byte_hitvecfn_lo_1[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_611 = _T_609 & buf_data_1[15:8]; // @[el2_lsu_bus_buffer.scala 220:91]
  wire [7:0] _T_614 = ld_byte_hitvecfn_lo_1[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_616 = _T_614 & buf_data_2[15:8]; // @[el2_lsu_bus_buffer.scala 220:91]
  wire [7:0] _T_619 = ld_byte_hitvecfn_lo_1[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_621 = _T_619 & buf_data_3[15:8]; // @[el2_lsu_bus_buffer.scala 220:91]
  wire [7:0] _T_622 = _T_606 | _T_611; // @[el2_lsu_bus_buffer.scala 220:123]
  wire [7:0] _T_623 = _T_622 | _T_616; // @[el2_lsu_bus_buffer.scala 220:123]
  wire [7:0] _T_624 = _T_623 | _T_621; // @[el2_lsu_bus_buffer.scala 220:123]
  wire [7:0] _T_627 = ld_byte_hitvecfn_lo_0[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_629 = _T_627 & buf_data_0[7:0]; // @[el2_lsu_bus_buffer.scala 221:91]
  wire [7:0] _T_632 = ld_byte_hitvecfn_lo_0[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_634 = _T_632 & buf_data_1[7:0]; // @[el2_lsu_bus_buffer.scala 221:91]
  wire [7:0] _T_637 = ld_byte_hitvecfn_lo_0[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_639 = _T_637 & buf_data_2[7:0]; // @[el2_lsu_bus_buffer.scala 221:91]
  wire [7:0] _T_642 = ld_byte_hitvecfn_lo_0[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_644 = _T_642 & buf_data_3[7:0]; // @[el2_lsu_bus_buffer.scala 221:91]
  wire [7:0] _T_645 = _T_629 | _T_634; // @[el2_lsu_bus_buffer.scala 221:123]
  wire [7:0] _T_646 = _T_645 | _T_639; // @[el2_lsu_bus_buffer.scala 221:123]
  wire [7:0] _T_647 = _T_646 | _T_644; // @[el2_lsu_bus_buffer.scala 221:123]
  wire [31:0] _T_650 = {_T_578,_T_601,_T_624,_T_647}; // @[Cat.scala 29:58]
  reg [31:0] ibuf_data; // @[el2_lib.scala 514:16]
  wire [31:0] _T_651 = ld_fwddata_buf_lo_initial & ibuf_data; // @[el2_lsu_bus_buffer.scala 222:32]
  wire [7:0] _T_655 = ld_byte_hitvecfn_hi_3[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_657 = _T_655 & buf_data_0[31:24]; // @[el2_lsu_bus_buffer.scala 224:91]
  wire [7:0] _T_660 = ld_byte_hitvecfn_hi_3[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_662 = _T_660 & buf_data_1[31:24]; // @[el2_lsu_bus_buffer.scala 224:91]
  wire [7:0] _T_665 = ld_byte_hitvecfn_hi_3[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_667 = _T_665 & buf_data_2[31:24]; // @[el2_lsu_bus_buffer.scala 224:91]
  wire [7:0] _T_670 = ld_byte_hitvecfn_hi_3[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_672 = _T_670 & buf_data_3[31:24]; // @[el2_lsu_bus_buffer.scala 224:91]
  wire [7:0] _T_673 = _T_657 | _T_662; // @[el2_lsu_bus_buffer.scala 224:123]
  wire [7:0] _T_674 = _T_673 | _T_667; // @[el2_lsu_bus_buffer.scala 224:123]
  wire [7:0] _T_675 = _T_674 | _T_672; // @[el2_lsu_bus_buffer.scala 224:123]
  wire [7:0] _T_678 = ld_byte_hitvecfn_hi_2[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_680 = _T_678 & buf_data_0[23:16]; // @[el2_lsu_bus_buffer.scala 225:91]
  wire [7:0] _T_683 = ld_byte_hitvecfn_hi_2[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_685 = _T_683 & buf_data_1[23:16]; // @[el2_lsu_bus_buffer.scala 225:91]
  wire [7:0] _T_688 = ld_byte_hitvecfn_hi_2[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_690 = _T_688 & buf_data_2[23:16]; // @[el2_lsu_bus_buffer.scala 225:91]
  wire [7:0] _T_693 = ld_byte_hitvecfn_hi_2[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_695 = _T_693 & buf_data_3[23:16]; // @[el2_lsu_bus_buffer.scala 225:91]
  wire [7:0] _T_696 = _T_680 | _T_685; // @[el2_lsu_bus_buffer.scala 225:123]
  wire [7:0] _T_697 = _T_696 | _T_690; // @[el2_lsu_bus_buffer.scala 225:123]
  wire [7:0] _T_698 = _T_697 | _T_695; // @[el2_lsu_bus_buffer.scala 225:123]
  wire [7:0] _T_701 = ld_byte_hitvecfn_hi_1[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_703 = _T_701 & buf_data_0[15:8]; // @[el2_lsu_bus_buffer.scala 226:91]
  wire [7:0] _T_706 = ld_byte_hitvecfn_hi_1[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_708 = _T_706 & buf_data_1[15:8]; // @[el2_lsu_bus_buffer.scala 226:91]
  wire [7:0] _T_711 = ld_byte_hitvecfn_hi_1[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_713 = _T_711 & buf_data_2[15:8]; // @[el2_lsu_bus_buffer.scala 226:91]
  wire [7:0] _T_716 = ld_byte_hitvecfn_hi_1[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_718 = _T_716 & buf_data_3[15:8]; // @[el2_lsu_bus_buffer.scala 226:91]
  wire [7:0] _T_719 = _T_703 | _T_708; // @[el2_lsu_bus_buffer.scala 226:123]
  wire [7:0] _T_720 = _T_719 | _T_713; // @[el2_lsu_bus_buffer.scala 226:123]
  wire [7:0] _T_721 = _T_720 | _T_718; // @[el2_lsu_bus_buffer.scala 226:123]
  wire [7:0] _T_724 = ld_byte_hitvecfn_hi_0[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_726 = _T_724 & buf_data_0[7:0]; // @[el2_lsu_bus_buffer.scala 227:91]
  wire [7:0] _T_729 = ld_byte_hitvecfn_hi_0[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_731 = _T_729 & buf_data_1[7:0]; // @[el2_lsu_bus_buffer.scala 227:91]
  wire [7:0] _T_734 = ld_byte_hitvecfn_hi_0[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_736 = _T_734 & buf_data_2[7:0]; // @[el2_lsu_bus_buffer.scala 227:91]
  wire [7:0] _T_739 = ld_byte_hitvecfn_hi_0[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_741 = _T_739 & buf_data_3[7:0]; // @[el2_lsu_bus_buffer.scala 227:91]
  wire [7:0] _T_742 = _T_726 | _T_731; // @[el2_lsu_bus_buffer.scala 227:123]
  wire [7:0] _T_743 = _T_742 | _T_736; // @[el2_lsu_bus_buffer.scala 227:123]
  wire [7:0] _T_744 = _T_743 | _T_741; // @[el2_lsu_bus_buffer.scala 227:123]
  wire [31:0] _T_747 = {_T_675,_T_698,_T_721,_T_744}; // @[Cat.scala 29:58]
  wire [31:0] _T_748 = ld_fwddata_buf_hi_initial & ibuf_data; // @[el2_lsu_bus_buffer.scala 228:32]
  wire [3:0] _T_750 = io_lsu_pkt_r_by ? 4'h1 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_751 = io_lsu_pkt_r_half ? 4'h3 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_752 = io_lsu_pkt_r_word ? 4'hf : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_753 = _T_750 | _T_751; // @[Mux.scala 27:72]
  wire [3:0] ldst_byteen_r = _T_753 | _T_752; // @[Mux.scala 27:72]
  wire  _T_756 = io_lsu_addr_r[1:0] == 2'h0; // @[el2_lsu_bus_buffer.scala 235:55]
  wire  _T_758 = io_lsu_addr_r[1:0] == 2'h1; // @[el2_lsu_bus_buffer.scala 236:55]
  wire [3:0] _T_760 = {3'h0,ldst_byteen_r[3]}; // @[Cat.scala 29:58]
  wire  _T_762 = io_lsu_addr_r[1:0] == 2'h2; // @[el2_lsu_bus_buffer.scala 237:55]
  wire [3:0] _T_764 = {2'h0,ldst_byteen_r[3:2]}; // @[Cat.scala 29:58]
  wire  _T_766 = io_lsu_addr_r[1:0] == 2'h3; // @[el2_lsu_bus_buffer.scala 238:55]
  wire [3:0] _T_768 = {1'h0,ldst_byteen_r[3:1]}; // @[Cat.scala 29:58]
  wire [3:0] _T_770 = _T_758 ? _T_760 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_771 = _T_762 ? _T_764 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_772 = _T_766 ? _T_768 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_774 = _T_770 | _T_771; // @[Mux.scala 27:72]
  wire [3:0] ldst_byteen_hi_r = _T_774 | _T_772; // @[Mux.scala 27:72]
  wire [3:0] _T_781 = {ldst_byteen_r[2:0],1'h0}; // @[Cat.scala 29:58]
  wire [3:0] _T_785 = {ldst_byteen_r[1:0],2'h0}; // @[Cat.scala 29:58]
  wire [3:0] _T_789 = {ldst_byteen_r[0],3'h0}; // @[Cat.scala 29:58]
  wire [3:0] _T_790 = _T_756 ? ldst_byteen_r : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_791 = _T_758 ? _T_781 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_792 = _T_762 ? _T_785 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_793 = _T_766 ? _T_789 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_794 = _T_790 | _T_791; // @[Mux.scala 27:72]
  wire [3:0] _T_795 = _T_794 | _T_792; // @[Mux.scala 27:72]
  wire [3:0] ldst_byteen_lo_r = _T_795 | _T_793; // @[Mux.scala 27:72]
  wire [31:0] _T_802 = {8'h0,io_store_data_r[31:8]}; // @[Cat.scala 29:58]
  wire [31:0] _T_806 = {16'h0,io_store_data_r[31:16]}; // @[Cat.scala 29:58]
  wire [31:0] _T_810 = {24'h0,io_store_data_r[31:24]}; // @[Cat.scala 29:58]
  wire [31:0] _T_812 = _T_758 ? _T_802 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_813 = _T_762 ? _T_806 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_814 = _T_766 ? _T_810 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_816 = _T_812 | _T_813; // @[Mux.scala 27:72]
  wire [31:0] store_data_hi_r = _T_816 | _T_814; // @[Mux.scala 27:72]
  wire [31:0] _T_823 = {io_store_data_r[23:0],8'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_827 = {io_store_data_r[15:0],16'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_831 = {io_store_data_r[7:0],24'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_832 = _T_756 ? io_store_data_r : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_833 = _T_758 ? _T_823 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_834 = _T_762 ? _T_827 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_835 = _T_766 ? _T_831 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_836 = _T_832 | _T_833; // @[Mux.scala 27:72]
  wire [31:0] _T_837 = _T_836 | _T_834; // @[Mux.scala 27:72]
  wire [31:0] store_data_lo_r = _T_837 | _T_835; // @[Mux.scala 27:72]
  wire  ldst_samedw_r = io_lsu_addr_r[3] == io_end_addr_r[3]; // @[el2_lsu_bus_buffer.scala 255:40]
  wire  _T_844 = ~io_lsu_addr_r[0]; // @[el2_lsu_bus_buffer.scala 257:26]
  wire  _T_845 = io_lsu_pkt_r_word & _T_756; // @[Mux.scala 27:72]
  wire  _T_846 = io_lsu_pkt_r_half & _T_844; // @[Mux.scala 27:72]
  wire  _T_848 = _T_845 | _T_846; // @[Mux.scala 27:72]
  wire  is_aligned_r = _T_848 | io_lsu_pkt_r_by; // @[Mux.scala 27:72]
  wire  _T_850 = io_lsu_pkt_r_load | io_no_word_merge_r; // @[el2_lsu_bus_buffer.scala 259:55]
  wire  _T_851 = io_lsu_busreq_r & _T_850; // @[el2_lsu_bus_buffer.scala 259:34]
  wire  _T_852 = ~ibuf_valid; // @[el2_lsu_bus_buffer.scala 259:79]
  wire  ibuf_byp = _T_851 & _T_852; // @[el2_lsu_bus_buffer.scala 259:77]
  wire  _T_853 = io_lsu_busreq_r & io_lsu_commit_r; // @[el2_lsu_bus_buffer.scala 260:36]
  wire  _T_854 = ~ibuf_byp; // @[el2_lsu_bus_buffer.scala 260:56]
  wire  ibuf_wr_en = _T_853 & _T_854; // @[el2_lsu_bus_buffer.scala 260:54]
  wire  _T_855 = ~ibuf_wr_en; // @[el2_lsu_bus_buffer.scala 262:36]
  reg [2:0] ibuf_timer; // @[el2_lsu_bus_buffer.scala 305:59]
  wire  _T_864 = ibuf_timer == 3'h7; // @[el2_lsu_bus_buffer.scala 268:62]
  wire  _T_865 = ibuf_wr_en | _T_864; // @[el2_lsu_bus_buffer.scala 268:48]
  wire  _T_929 = _T_853 & io_lsu_pkt_r_store; // @[el2_lsu_bus_buffer.scala 287:54]
  wire  _T_930 = _T_929 & ibuf_valid; // @[el2_lsu_bus_buffer.scala 287:75]
  wire  _T_931 = _T_930 & ibuf_write; // @[el2_lsu_bus_buffer.scala 287:88]
  wire  _T_934 = io_lsu_addr_r[31:2] == ibuf_addr[31:2]; // @[el2_lsu_bus_buffer.scala 287:124]
  wire  _T_935 = _T_931 & _T_934; // @[el2_lsu_bus_buffer.scala 287:101]
  wire  _T_936 = ~io_is_sideeffects_r; // @[el2_lsu_bus_buffer.scala 287:147]
  wire  _T_937 = _T_935 & _T_936; // @[el2_lsu_bus_buffer.scala 287:145]
  wire  _T_938 = ~io_dec_tlu_wb_coalescing_disable; // @[el2_lsu_bus_buffer.scala 287:170]
  wire  ibuf_merge_en = _T_937 & _T_938; // @[el2_lsu_bus_buffer.scala 287:168]
  wire  ibuf_merge_in = ~io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 288:20]
  wire  _T_866 = ibuf_merge_en & ibuf_merge_in; // @[el2_lsu_bus_buffer.scala 268:98]
  wire  _T_867 = ~_T_866; // @[el2_lsu_bus_buffer.scala 268:82]
  wire  _T_868 = _T_865 & _T_867; // @[el2_lsu_bus_buffer.scala 268:80]
  wire  _T_869 = _T_868 | ibuf_byp; // @[el2_lsu_bus_buffer.scala 269:5]
  wire  _T_857 = ~io_lsu_busreq_r; // @[el2_lsu_bus_buffer.scala 263:44]
  wire  _T_858 = io_lsu_busreq_m & _T_857; // @[el2_lsu_bus_buffer.scala 263:42]
  wire  _T_859 = _T_858 & ibuf_valid; // @[el2_lsu_bus_buffer.scala 263:61]
  wire  _T_862 = ibuf_addr[31:2] != io_lsu_addr_m[31:2]; // @[el2_lsu_bus_buffer.scala 263:115]
  wire  _T_863 = io_lsu_pkt_m_load | _T_862; // @[el2_lsu_bus_buffer.scala 263:95]
  wire  ibuf_force_drain = _T_859 & _T_863; // @[el2_lsu_bus_buffer.scala 263:74]
  wire  _T_870 = _T_869 | ibuf_force_drain; // @[el2_lsu_bus_buffer.scala 269:16]
  reg  ibuf_sideeffect; // @[Reg.scala 27:20]
  wire  _T_871 = _T_870 | ibuf_sideeffect; // @[el2_lsu_bus_buffer.scala 269:35]
  wire  _T_872 = ~ibuf_write; // @[el2_lsu_bus_buffer.scala 269:55]
  wire  _T_873 = _T_871 | _T_872; // @[el2_lsu_bus_buffer.scala 269:53]
  wire  _T_874 = _T_873 | io_dec_tlu_wb_coalescing_disable; // @[el2_lsu_bus_buffer.scala 269:67]
  wire  ibuf_drain_vld = ibuf_valid & _T_874; // @[el2_lsu_bus_buffer.scala 268:32]
  wire  _T_856 = ibuf_drain_vld & _T_855; // @[el2_lsu_bus_buffer.scala 262:34]
  wire  ibuf_rst = _T_856 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 262:49]
  reg [1:0] WrPtr1_r; // @[el2_lsu_bus_buffer.scala 671:49]
  reg [1:0] WrPtr0_r; // @[el2_lsu_bus_buffer.scala 670:49]
  reg [1:0] ibuf_tag; // @[Reg.scala 27:20]
  wire [1:0] ibuf_sz_in = {io_lsu_pkt_r_word,io_lsu_pkt_r_half}; // @[Cat.scala 29:58]
  wire [3:0] _T_881 = ibuf_byteen | ldst_byteen_lo_r; // @[el2_lsu_bus_buffer.scala 278:77]
  wire [7:0] _T_889 = ldst_byteen_lo_r[0] ? store_data_lo_r[7:0] : ibuf_data[7:0]; // @[el2_lsu_bus_buffer.scala 283:8]
  wire [7:0] _T_892 = io_ldst_dual_r ? store_data_hi_r[7:0] : store_data_lo_r[7:0]; // @[el2_lsu_bus_buffer.scala 284:8]
  wire [7:0] _T_893 = _T_866 ? _T_889 : _T_892; // @[el2_lsu_bus_buffer.scala 282:46]
  wire [7:0] _T_898 = ldst_byteen_lo_r[1] ? store_data_lo_r[15:8] : ibuf_data[15:8]; // @[el2_lsu_bus_buffer.scala 283:8]
  wire [7:0] _T_901 = io_ldst_dual_r ? store_data_hi_r[15:8] : store_data_lo_r[15:8]; // @[el2_lsu_bus_buffer.scala 284:8]
  wire [7:0] _T_902 = _T_866 ? _T_898 : _T_901; // @[el2_lsu_bus_buffer.scala 282:46]
  wire [7:0] _T_907 = ldst_byteen_lo_r[2] ? store_data_lo_r[23:16] : ibuf_data[23:16]; // @[el2_lsu_bus_buffer.scala 283:8]
  wire [7:0] _T_910 = io_ldst_dual_r ? store_data_hi_r[23:16] : store_data_lo_r[23:16]; // @[el2_lsu_bus_buffer.scala 284:8]
  wire [7:0] _T_911 = _T_866 ? _T_907 : _T_910; // @[el2_lsu_bus_buffer.scala 282:46]
  wire [7:0] _T_916 = ldst_byteen_lo_r[3] ? store_data_lo_r[31:24] : ibuf_data[31:24]; // @[el2_lsu_bus_buffer.scala 283:8]
  wire [7:0] _T_919 = io_ldst_dual_r ? store_data_hi_r[31:24] : store_data_lo_r[31:24]; // @[el2_lsu_bus_buffer.scala 284:8]
  wire [7:0] _T_920 = _T_866 ? _T_916 : _T_919; // @[el2_lsu_bus_buffer.scala 282:46]
  wire [23:0] _T_922 = {_T_920,_T_911,_T_902}; // @[Cat.scala 29:58]
  wire  _T_923 = ibuf_timer < 3'h7; // @[el2_lsu_bus_buffer.scala 285:59]
  wire [2:0] _T_926 = ibuf_timer + 3'h1; // @[el2_lsu_bus_buffer.scala 285:93]
  wire  _T_941 = ~ibuf_merge_in; // @[el2_lsu_bus_buffer.scala 289:65]
  wire  _T_942 = ibuf_merge_en & _T_941; // @[el2_lsu_bus_buffer.scala 289:63]
  wire  _T_945 = ibuf_byteen[0] | ldst_byteen_lo_r[0]; // @[el2_lsu_bus_buffer.scala 289:96]
  wire  _T_947 = _T_942 ? _T_945 : ibuf_byteen[0]; // @[el2_lsu_bus_buffer.scala 289:48]
  wire  _T_952 = ibuf_byteen[1] | ldst_byteen_lo_r[1]; // @[el2_lsu_bus_buffer.scala 289:96]
  wire  _T_954 = _T_942 ? _T_952 : ibuf_byteen[1]; // @[el2_lsu_bus_buffer.scala 289:48]
  wire  _T_959 = ibuf_byteen[2] | ldst_byteen_lo_r[2]; // @[el2_lsu_bus_buffer.scala 289:96]
  wire  _T_961 = _T_942 ? _T_959 : ibuf_byteen[2]; // @[el2_lsu_bus_buffer.scala 289:48]
  wire  _T_966 = ibuf_byteen[3] | ldst_byteen_lo_r[3]; // @[el2_lsu_bus_buffer.scala 289:96]
  wire  _T_968 = _T_942 ? _T_966 : ibuf_byteen[3]; // @[el2_lsu_bus_buffer.scala 289:48]
  wire [3:0] ibuf_byteen_out = {_T_968,_T_961,_T_954,_T_947}; // @[Cat.scala 29:58]
  wire [7:0] _T_978 = _T_942 ? _T_889 : ibuf_data[7:0]; // @[el2_lsu_bus_buffer.scala 290:45]
  wire [7:0] _T_986 = _T_942 ? _T_898 : ibuf_data[15:8]; // @[el2_lsu_bus_buffer.scala 290:45]
  wire [7:0] _T_994 = _T_942 ? _T_907 : ibuf_data[23:16]; // @[el2_lsu_bus_buffer.scala 290:45]
  wire [7:0] _T_1002 = _T_942 ? _T_916 : ibuf_data[31:24]; // @[el2_lsu_bus_buffer.scala 290:45]
  wire [31:0] ibuf_data_out = {_T_1002,_T_994,_T_986,_T_978}; // @[Cat.scala 29:58]
  wire  _T_1005 = ibuf_wr_en | ibuf_valid; // @[el2_lsu_bus_buffer.scala 292:28]
  wire  _T_1006 = ~ibuf_rst; // @[el2_lsu_bus_buffer.scala 292:63]
  wire  _T_1011 = ibuf_wr_en & io_lsu_bus_ibuf_c1_clk; // @[el2_lsu_bus_buffer.scala 293:89]
  reg [1:0] ibuf_dualtag; // @[Reg.scala 27:20]
  reg  ibuf_dual; // @[Reg.scala 27:20]
  reg  ibuf_samedw; // @[Reg.scala 27:20]
  reg  ibuf_nomerge; // @[Reg.scala 27:20]
  reg  ibuf_unsign; // @[Reg.scala 27:20]
  reg [1:0] ibuf_sz; // @[Reg.scala 27:20]
  wire  _T_4469 = buf_write[3] & _T_2644; // @[el2_lsu_bus_buffer.scala 577:64]
  wire  _T_4470 = ~buf_cmd_state_bus_en_3; // @[el2_lsu_bus_buffer.scala 577:91]
  wire  _T_4471 = _T_4469 & _T_4470; // @[el2_lsu_bus_buffer.scala 577:89]
  wire  _T_4464 = buf_write[2] & _T_2639; // @[el2_lsu_bus_buffer.scala 577:64]
  wire  _T_4465 = ~buf_cmd_state_bus_en_2; // @[el2_lsu_bus_buffer.scala 577:91]
  wire  _T_4466 = _T_4464 & _T_4465; // @[el2_lsu_bus_buffer.scala 577:89]
  wire [1:0] _T_4472 = _T_4471 + _T_4466; // @[el2_lsu_bus_buffer.scala 577:142]
  wire  _T_4459 = buf_write[1] & _T_2634; // @[el2_lsu_bus_buffer.scala 577:64]
  wire  _T_4460 = ~buf_cmd_state_bus_en_1; // @[el2_lsu_bus_buffer.scala 577:91]
  wire  _T_4461 = _T_4459 & _T_4460; // @[el2_lsu_bus_buffer.scala 577:89]
  wire [1:0] _GEN_350 = {{1'd0}, _T_4461}; // @[el2_lsu_bus_buffer.scala 577:142]
  wire [2:0] _T_4473 = _T_4472 + _GEN_350; // @[el2_lsu_bus_buffer.scala 577:142]
  wire  _T_4454 = buf_write[0] & _T_2629; // @[el2_lsu_bus_buffer.scala 577:64]
  wire  _T_4455 = ~buf_cmd_state_bus_en_0; // @[el2_lsu_bus_buffer.scala 577:91]
  wire  _T_4456 = _T_4454 & _T_4455; // @[el2_lsu_bus_buffer.scala 577:89]
  wire [2:0] _GEN_351 = {{2'd0}, _T_4456}; // @[el2_lsu_bus_buffer.scala 577:142]
  wire [3:0] buf_numvld_wrcmd_any = _T_4473 + _GEN_351; // @[el2_lsu_bus_buffer.scala 577:142]
  wire  _T_1037 = buf_numvld_wrcmd_any == 4'h1; // @[el2_lsu_bus_buffer.scala 315:43]
  wire  _T_4486 = _T_2644 & _T_4470; // @[el2_lsu_bus_buffer.scala 578:73]
  wire  _T_4483 = _T_2639 & _T_4465; // @[el2_lsu_bus_buffer.scala 578:73]
  wire [1:0] _T_4487 = _T_4486 + _T_4483; // @[el2_lsu_bus_buffer.scala 578:126]
  wire  _T_4480 = _T_2634 & _T_4460; // @[el2_lsu_bus_buffer.scala 578:73]
  wire [1:0] _GEN_352 = {{1'd0}, _T_4480}; // @[el2_lsu_bus_buffer.scala 578:126]
  wire [2:0] _T_4488 = _T_4487 + _GEN_352; // @[el2_lsu_bus_buffer.scala 578:126]
  wire  _T_4477 = _T_2629 & _T_4455; // @[el2_lsu_bus_buffer.scala 578:73]
  wire [2:0] _GEN_353 = {{2'd0}, _T_4477}; // @[el2_lsu_bus_buffer.scala 578:126]
  wire [3:0] buf_numvld_cmd_any = _T_4488 + _GEN_353; // @[el2_lsu_bus_buffer.scala 578:126]
  wire  _T_1038 = buf_numvld_cmd_any == 4'h1; // @[el2_lsu_bus_buffer.scala 315:72]
  wire  _T_1039 = _T_1037 & _T_1038; // @[el2_lsu_bus_buffer.scala 315:51]
  reg [2:0] obuf_wr_timer; // @[el2_lsu_bus_buffer.scala 416:54]
  wire  _T_1040 = obuf_wr_timer != 3'h7; // @[el2_lsu_bus_buffer.scala 315:97]
  wire  _T_1041 = _T_1039 & _T_1040; // @[el2_lsu_bus_buffer.scala 315:80]
  wire  _T_1043 = _T_1041 & _T_938; // @[el2_lsu_bus_buffer.scala 315:114]
  wire  _T_2002 = |buf_age_3; // @[el2_lsu_bus_buffer.scala 433:58]
  wire  _T_2003 = ~_T_2002; // @[el2_lsu_bus_buffer.scala 433:45]
  wire  _T_2005 = _T_2003 & _T_2644; // @[el2_lsu_bus_buffer.scala 433:63]
  wire  _T_2007 = _T_2005 & _T_4470; // @[el2_lsu_bus_buffer.scala 433:88]
  wire  _T_1996 = |buf_age_2; // @[el2_lsu_bus_buffer.scala 433:58]
  wire  _T_1997 = ~_T_1996; // @[el2_lsu_bus_buffer.scala 433:45]
  wire  _T_1999 = _T_1997 & _T_2639; // @[el2_lsu_bus_buffer.scala 433:63]
  wire  _T_2001 = _T_1999 & _T_4465; // @[el2_lsu_bus_buffer.scala 433:88]
  wire  _T_1990 = |buf_age_1; // @[el2_lsu_bus_buffer.scala 433:58]
  wire  _T_1991 = ~_T_1990; // @[el2_lsu_bus_buffer.scala 433:45]
  wire  _T_1993 = _T_1991 & _T_2634; // @[el2_lsu_bus_buffer.scala 433:63]
  wire  _T_1995 = _T_1993 & _T_4460; // @[el2_lsu_bus_buffer.scala 433:88]
  wire  _T_1984 = |buf_age_0; // @[el2_lsu_bus_buffer.scala 433:58]
  wire  _T_1985 = ~_T_1984; // @[el2_lsu_bus_buffer.scala 433:45]
  wire  _T_1987 = _T_1985 & _T_2629; // @[el2_lsu_bus_buffer.scala 433:63]
  wire  _T_1989 = _T_1987 & _T_4455; // @[el2_lsu_bus_buffer.scala 433:88]
  wire [3:0] CmdPtr0Dec = {_T_2007,_T_2001,_T_1995,_T_1989}; // @[Cat.scala 29:58]
  wire [7:0] _T_2077 = {4'h0,_T_2007,_T_2001,_T_1995,_T_1989}; // @[Cat.scala 29:58]
  wire  _T_2080 = _T_2077[4] | _T_2077[5]; // @[el2_lsu_bus_buffer.scala 441:42]
  wire  _T_2082 = _T_2080 | _T_2077[6]; // @[el2_lsu_bus_buffer.scala 441:48]
  wire  _T_2084 = _T_2082 | _T_2077[7]; // @[el2_lsu_bus_buffer.scala 441:54]
  wire  _T_2087 = _T_2077[2] | _T_2077[3]; // @[el2_lsu_bus_buffer.scala 441:67]
  wire  _T_2089 = _T_2087 | _T_2077[6]; // @[el2_lsu_bus_buffer.scala 441:73]
  wire  _T_2091 = _T_2089 | _T_2077[7]; // @[el2_lsu_bus_buffer.scala 441:79]
  wire  _T_2094 = _T_2077[1] | _T_2077[3]; // @[el2_lsu_bus_buffer.scala 441:92]
  wire  _T_2096 = _T_2094 | _T_2077[5]; // @[el2_lsu_bus_buffer.scala 441:98]
  wire  _T_2098 = _T_2096 | _T_2077[7]; // @[el2_lsu_bus_buffer.scala 441:104]
  wire [2:0] _T_2100 = {_T_2084,_T_2091,_T_2098}; // @[Cat.scala 29:58]
  wire [1:0] CmdPtr0 = _T_2100[1:0]; // @[el2_lsu_bus_buffer.scala 446:11]
  wire  _T_1044 = CmdPtr0 == 2'h0; // @[el2_lsu_bus_buffer.scala 316:114]
  wire  _T_1045 = CmdPtr0 == 2'h1; // @[el2_lsu_bus_buffer.scala 316:114]
  wire  _T_1046 = CmdPtr0 == 2'h2; // @[el2_lsu_bus_buffer.scala 316:114]
  wire  _T_1047 = CmdPtr0 == 2'h3; // @[el2_lsu_bus_buffer.scala 316:114]
  reg  buf_nomerge_0; // @[Reg.scala 27:20]
  wire  _T_1048 = _T_1044 & buf_nomerge_0; // @[Mux.scala 27:72]
  reg  buf_nomerge_1; // @[Reg.scala 27:20]
  wire  _T_1049 = _T_1045 & buf_nomerge_1; // @[Mux.scala 27:72]
  reg  buf_nomerge_2; // @[Reg.scala 27:20]
  wire  _T_1050 = _T_1046 & buf_nomerge_2; // @[Mux.scala 27:72]
  reg  buf_nomerge_3; // @[Reg.scala 27:20]
  wire  _T_1051 = _T_1047 & buf_nomerge_3; // @[Mux.scala 27:72]
  wire  _T_1052 = _T_1048 | _T_1049; // @[Mux.scala 27:72]
  wire  _T_1053 = _T_1052 | _T_1050; // @[Mux.scala 27:72]
  wire  _T_1054 = _T_1053 | _T_1051; // @[Mux.scala 27:72]
  wire  _T_1056 = ~_T_1054; // @[el2_lsu_bus_buffer.scala 316:31]
  wire  _T_1057 = _T_1043 & _T_1056; // @[el2_lsu_bus_buffer.scala 316:29]
  reg  _T_4353; // @[Reg.scala 27:20]
  reg  _T_4350; // @[Reg.scala 27:20]
  reg  _T_4347; // @[Reg.scala 27:20]
  reg  _T_4344; // @[Reg.scala 27:20]
  wire [3:0] buf_sideeffect = {_T_4353,_T_4350,_T_4347,_T_4344}; // @[Cat.scala 29:58]
  wire  _T_1066 = _T_1044 & buf_sideeffect[0]; // @[Mux.scala 27:72]
  wire  _T_1067 = _T_1045 & buf_sideeffect[1]; // @[Mux.scala 27:72]
  wire  _T_1068 = _T_1046 & buf_sideeffect[2]; // @[Mux.scala 27:72]
  wire  _T_1069 = _T_1047 & buf_sideeffect[3]; // @[Mux.scala 27:72]
  wire  _T_1070 = _T_1066 | _T_1067; // @[Mux.scala 27:72]
  wire  _T_1071 = _T_1070 | _T_1068; // @[Mux.scala 27:72]
  wire  _T_1072 = _T_1071 | _T_1069; // @[Mux.scala 27:72]
  wire  _T_1074 = ~_T_1072; // @[el2_lsu_bus_buffer.scala 317:5]
  wire  _T_1075 = _T_1057 & _T_1074; // @[el2_lsu_bus_buffer.scala 316:140]
  wire  _T_1086 = _T_858 & _T_852; // @[el2_lsu_bus_buffer.scala 319:58]
  wire  _T_1088 = _T_1086 & _T_1038; // @[el2_lsu_bus_buffer.scala 319:72]
  wire [29:0] _T_1098 = _T_1044 ? buf_addr_0[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1099 = _T_1045 ? buf_addr_1[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1102 = _T_1098 | _T_1099; // @[Mux.scala 27:72]
  wire [29:0] _T_1100 = _T_1046 ? buf_addr_2[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1103 = _T_1102 | _T_1100; // @[Mux.scala 27:72]
  wire [29:0] _T_1101 = _T_1047 ? buf_addr_3[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1104 = _T_1103 | _T_1101; // @[Mux.scala 27:72]
  wire  _T_1106 = io_lsu_addr_m[31:2] != _T_1104; // @[el2_lsu_bus_buffer.scala 319:123]
  wire  obuf_force_wr_en = _T_1088 & _T_1106; // @[el2_lsu_bus_buffer.scala 319:101]
  wire  _T_1076 = ~obuf_force_wr_en; // @[el2_lsu_bus_buffer.scala 317:119]
  wire  obuf_wr_wait = _T_1075 & _T_1076; // @[el2_lsu_bus_buffer.scala 317:117]
  wire  _T_1077 = |buf_numvld_cmd_any; // @[el2_lsu_bus_buffer.scala 318:75]
  wire  _T_1078 = obuf_wr_timer < 3'h7; // @[el2_lsu_bus_buffer.scala 318:95]
  wire  _T_1079 = _T_1077 & _T_1078; // @[el2_lsu_bus_buffer.scala 318:79]
  wire [2:0] _T_1081 = obuf_wr_timer + 3'h1; // @[el2_lsu_bus_buffer.scala 318:121]
  wire  _T_4505 = buf_state_3 == 3'h1; // @[el2_lsu_bus_buffer.scala 579:63]
  wire  _T_4509 = _T_4505 | _T_4486; // @[el2_lsu_bus_buffer.scala 579:74]
  wire  _T_4500 = buf_state_2 == 3'h1; // @[el2_lsu_bus_buffer.scala 579:63]
  wire  _T_4504 = _T_4500 | _T_4483; // @[el2_lsu_bus_buffer.scala 579:74]
  wire [1:0] _T_4510 = _T_4509 + _T_4504; // @[el2_lsu_bus_buffer.scala 579:154]
  wire  _T_4495 = buf_state_1 == 3'h1; // @[el2_lsu_bus_buffer.scala 579:63]
  wire  _T_4499 = _T_4495 | _T_4480; // @[el2_lsu_bus_buffer.scala 579:74]
  wire [1:0] _GEN_354 = {{1'd0}, _T_4499}; // @[el2_lsu_bus_buffer.scala 579:154]
  wire [2:0] _T_4511 = _T_4510 + _GEN_354; // @[el2_lsu_bus_buffer.scala 579:154]
  wire  _T_4490 = buf_state_0 == 3'h1; // @[el2_lsu_bus_buffer.scala 579:63]
  wire  _T_4494 = _T_4490 | _T_4477; // @[el2_lsu_bus_buffer.scala 579:74]
  wire [2:0] _GEN_355 = {{2'd0}, _T_4494}; // @[el2_lsu_bus_buffer.scala 579:154]
  wire [3:0] buf_numvld_pend_any = _T_4511 + _GEN_355; // @[el2_lsu_bus_buffer.scala 579:154]
  wire  _T_1108 = buf_numvld_pend_any == 4'h0; // @[el2_lsu_bus_buffer.scala 321:53]
  wire  _T_1109 = ibuf_byp & _T_1108; // @[el2_lsu_bus_buffer.scala 321:31]
  wire  _T_1110 = ~io_lsu_pkt_r_store; // @[el2_lsu_bus_buffer.scala 321:64]
  wire  _T_1111 = _T_1110 | io_no_dword_merge_r; // @[el2_lsu_bus_buffer.scala 321:84]
  wire  ibuf_buf_byp = _T_1109 & _T_1111; // @[el2_lsu_bus_buffer.scala 321:61]
  wire  _T_1112 = ibuf_buf_byp & io_lsu_commit_r; // @[el2_lsu_bus_buffer.scala 336:32]
  wire  _T_4801 = buf_state_0 == 3'h3; // @[el2_lsu_bus_buffer.scala 607:62]
  wire  _T_4803 = _T_4801 & buf_sideeffect[0]; // @[el2_lsu_bus_buffer.scala 607:73]
  wire  _T_4804 = _T_4803 & io_dec_tlu_sideeffect_posted_disable; // @[el2_lsu_bus_buffer.scala 607:93]
  wire  _T_4805 = buf_state_1 == 3'h3; // @[el2_lsu_bus_buffer.scala 607:62]
  wire  _T_4807 = _T_4805 & buf_sideeffect[1]; // @[el2_lsu_bus_buffer.scala 607:73]
  wire  _T_4808 = _T_4807 & io_dec_tlu_sideeffect_posted_disable; // @[el2_lsu_bus_buffer.scala 607:93]
  wire  _T_4817 = _T_4804 | _T_4808; // @[el2_lsu_bus_buffer.scala 607:141]
  wire  _T_4809 = buf_state_2 == 3'h3; // @[el2_lsu_bus_buffer.scala 607:62]
  wire  _T_4811 = _T_4809 & buf_sideeffect[2]; // @[el2_lsu_bus_buffer.scala 607:73]
  wire  _T_4812 = _T_4811 & io_dec_tlu_sideeffect_posted_disable; // @[el2_lsu_bus_buffer.scala 607:93]
  wire  _T_4818 = _T_4817 | _T_4812; // @[el2_lsu_bus_buffer.scala 607:141]
  wire  _T_4813 = buf_state_3 == 3'h3; // @[el2_lsu_bus_buffer.scala 607:62]
  wire  _T_4815 = _T_4813 & buf_sideeffect[3]; // @[el2_lsu_bus_buffer.scala 607:73]
  wire  _T_4816 = _T_4815 & io_dec_tlu_sideeffect_posted_disable; // @[el2_lsu_bus_buffer.scala 607:93]
  wire  bus_sideeffect_pend = _T_4818 | _T_4816; // @[el2_lsu_bus_buffer.scala 607:141]
  wire  _T_1113 = io_is_sideeffects_r & bus_sideeffect_pend; // @[el2_lsu_bus_buffer.scala 336:74]
  wire  _T_1114 = ~_T_1113; // @[el2_lsu_bus_buffer.scala 336:52]
  wire  _T_1115 = _T_1112 & _T_1114; // @[el2_lsu_bus_buffer.scala 336:50]
  wire [2:0] _T_1120 = _T_1044 ? buf_state_0 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1121 = _T_1045 ? buf_state_1 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1124 = _T_1120 | _T_1121; // @[Mux.scala 27:72]
  wire [2:0] _T_1122 = _T_1046 ? buf_state_2 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1125 = _T_1124 | _T_1122; // @[Mux.scala 27:72]
  wire [2:0] _T_1123 = _T_1047 ? buf_state_3 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1126 = _T_1125 | _T_1123; // @[Mux.scala 27:72]
  wire  _T_1128 = _T_1126 == 3'h2; // @[el2_lsu_bus_buffer.scala 337:36]
  wire  found_cmdptr0 = |CmdPtr0Dec; // @[el2_lsu_bus_buffer.scala 438:31]
  wire  _T_1129 = _T_1128 & found_cmdptr0; // @[el2_lsu_bus_buffer.scala 337:47]
  wire [3:0] _T_1132 = {buf_cmd_state_bus_en_3,buf_cmd_state_bus_en_2,buf_cmd_state_bus_en_1,buf_cmd_state_bus_en_0}; // @[Cat.scala 29:58]
  wire  _T_1141 = _T_1044 & _T_1132[0]; // @[Mux.scala 27:72]
  wire  _T_1142 = _T_1045 & _T_1132[1]; // @[Mux.scala 27:72]
  wire  _T_1145 = _T_1141 | _T_1142; // @[Mux.scala 27:72]
  wire  _T_1143 = _T_1046 & _T_1132[2]; // @[Mux.scala 27:72]
  wire  _T_1146 = _T_1145 | _T_1143; // @[Mux.scala 27:72]
  wire  _T_1144 = _T_1047 & _T_1132[3]; // @[Mux.scala 27:72]
  wire  _T_1147 = _T_1146 | _T_1144; // @[Mux.scala 27:72]
  wire  _T_1149 = ~_T_1147; // @[el2_lsu_bus_buffer.scala 338:23]
  wire  _T_1150 = _T_1129 & _T_1149; // @[el2_lsu_bus_buffer.scala 338:21]
  wire  _T_1167 = _T_1072 & bus_sideeffect_pend; // @[el2_lsu_bus_buffer.scala 338:141]
  wire  _T_1168 = ~_T_1167; // @[el2_lsu_bus_buffer.scala 338:105]
  wire  _T_1169 = _T_1150 & _T_1168; // @[el2_lsu_bus_buffer.scala 338:103]
  reg  buf_dual_3; // @[Reg.scala 27:20]
  reg  buf_dual_2; // @[Reg.scala 27:20]
  reg  buf_dual_1; // @[Reg.scala 27:20]
  reg  buf_dual_0; // @[Reg.scala 27:20]
  wire [3:0] _T_1172 = {buf_dual_3,buf_dual_2,buf_dual_1,buf_dual_0}; // @[Cat.scala 29:58]
  wire  _T_1181 = _T_1044 & _T_1172[0]; // @[Mux.scala 27:72]
  wire  _T_1182 = _T_1045 & _T_1172[1]; // @[Mux.scala 27:72]
  wire  _T_1185 = _T_1181 | _T_1182; // @[Mux.scala 27:72]
  wire  _T_1183 = _T_1046 & _T_1172[2]; // @[Mux.scala 27:72]
  wire  _T_1186 = _T_1185 | _T_1183; // @[Mux.scala 27:72]
  wire  _T_1184 = _T_1047 & _T_1172[3]; // @[Mux.scala 27:72]
  wire  _T_1187 = _T_1186 | _T_1184; // @[Mux.scala 27:72]
  reg  buf_samedw_3; // @[Reg.scala 27:20]
  reg  buf_samedw_2; // @[Reg.scala 27:20]
  reg  buf_samedw_1; // @[Reg.scala 27:20]
  reg  buf_samedw_0; // @[Reg.scala 27:20]
  wire [3:0] _T_1191 = {buf_samedw_3,buf_samedw_2,buf_samedw_1,buf_samedw_0}; // @[Cat.scala 29:58]
  wire  _T_1200 = _T_1044 & _T_1191[0]; // @[Mux.scala 27:72]
  wire  _T_1201 = _T_1045 & _T_1191[1]; // @[Mux.scala 27:72]
  wire  _T_1204 = _T_1200 | _T_1201; // @[Mux.scala 27:72]
  wire  _T_1202 = _T_1046 & _T_1191[2]; // @[Mux.scala 27:72]
  wire  _T_1205 = _T_1204 | _T_1202; // @[Mux.scala 27:72]
  wire  _T_1203 = _T_1047 & _T_1191[3]; // @[Mux.scala 27:72]
  wire  _T_1206 = _T_1205 | _T_1203; // @[Mux.scala 27:72]
  wire  _T_1208 = _T_1187 & _T_1206; // @[el2_lsu_bus_buffer.scala 339:77]
  wire  _T_1217 = _T_1044 & buf_write[0]; // @[Mux.scala 27:72]
  wire  _T_1218 = _T_1045 & buf_write[1]; // @[Mux.scala 27:72]
  wire  _T_1221 = _T_1217 | _T_1218; // @[Mux.scala 27:72]
  wire  _T_1219 = _T_1046 & buf_write[2]; // @[Mux.scala 27:72]
  wire  _T_1222 = _T_1221 | _T_1219; // @[Mux.scala 27:72]
  wire  _T_1220 = _T_1047 & buf_write[3]; // @[Mux.scala 27:72]
  wire  _T_1223 = _T_1222 | _T_1220; // @[Mux.scala 27:72]
  wire  _T_1225 = ~_T_1223; // @[el2_lsu_bus_buffer.scala 339:150]
  wire  _T_1226 = _T_1208 & _T_1225; // @[el2_lsu_bus_buffer.scala 339:148]
  wire  _T_1227 = ~_T_1226; // @[el2_lsu_bus_buffer.scala 339:8]
  wire [3:0] _T_2043 = ~CmdPtr0Dec; // @[el2_lsu_bus_buffer.scala 434:62]
  wire [3:0] _T_2044 = buf_age_3 & _T_2043; // @[el2_lsu_bus_buffer.scala 434:59]
  wire  _T_2045 = |_T_2044; // @[el2_lsu_bus_buffer.scala 434:76]
  wire  _T_2046 = ~_T_2045; // @[el2_lsu_bus_buffer.scala 434:45]
  wire  _T_2048 = ~CmdPtr0Dec[3]; // @[el2_lsu_bus_buffer.scala 434:83]
  wire  _T_2049 = _T_2046 & _T_2048; // @[el2_lsu_bus_buffer.scala 434:81]
  wire  _T_2051 = _T_2049 & _T_2644; // @[el2_lsu_bus_buffer.scala 434:98]
  wire  _T_2053 = _T_2051 & _T_4470; // @[el2_lsu_bus_buffer.scala 434:123]
  wire [3:0] _T_2033 = buf_age_2 & _T_2043; // @[el2_lsu_bus_buffer.scala 434:59]
  wire  _T_2034 = |_T_2033; // @[el2_lsu_bus_buffer.scala 434:76]
  wire  _T_2035 = ~_T_2034; // @[el2_lsu_bus_buffer.scala 434:45]
  wire  _T_2037 = ~CmdPtr0Dec[2]; // @[el2_lsu_bus_buffer.scala 434:83]
  wire  _T_2038 = _T_2035 & _T_2037; // @[el2_lsu_bus_buffer.scala 434:81]
  wire  _T_2040 = _T_2038 & _T_2639; // @[el2_lsu_bus_buffer.scala 434:98]
  wire  _T_2042 = _T_2040 & _T_4465; // @[el2_lsu_bus_buffer.scala 434:123]
  wire [3:0] _T_2022 = buf_age_1 & _T_2043; // @[el2_lsu_bus_buffer.scala 434:59]
  wire  _T_2023 = |_T_2022; // @[el2_lsu_bus_buffer.scala 434:76]
  wire  _T_2024 = ~_T_2023; // @[el2_lsu_bus_buffer.scala 434:45]
  wire  _T_2026 = ~CmdPtr0Dec[1]; // @[el2_lsu_bus_buffer.scala 434:83]
  wire  _T_2027 = _T_2024 & _T_2026; // @[el2_lsu_bus_buffer.scala 434:81]
  wire  _T_2029 = _T_2027 & _T_2634; // @[el2_lsu_bus_buffer.scala 434:98]
  wire  _T_2031 = _T_2029 & _T_4460; // @[el2_lsu_bus_buffer.scala 434:123]
  wire [3:0] _T_2011 = buf_age_0 & _T_2043; // @[el2_lsu_bus_buffer.scala 434:59]
  wire  _T_2012 = |_T_2011; // @[el2_lsu_bus_buffer.scala 434:76]
  wire  _T_2013 = ~_T_2012; // @[el2_lsu_bus_buffer.scala 434:45]
  wire  _T_2015 = ~CmdPtr0Dec[0]; // @[el2_lsu_bus_buffer.scala 434:83]
  wire  _T_2016 = _T_2013 & _T_2015; // @[el2_lsu_bus_buffer.scala 434:81]
  wire  _T_2018 = _T_2016 & _T_2629; // @[el2_lsu_bus_buffer.scala 434:98]
  wire  _T_2020 = _T_2018 & _T_4455; // @[el2_lsu_bus_buffer.scala 434:123]
  wire [3:0] CmdPtr1Dec = {_T_2053,_T_2042,_T_2031,_T_2020}; // @[Cat.scala 29:58]
  wire  found_cmdptr1 = |CmdPtr1Dec; // @[el2_lsu_bus_buffer.scala 439:31]
  wire  _T_1228 = _T_1227 | found_cmdptr1; // @[el2_lsu_bus_buffer.scala 339:181]
  wire [3:0] _T_1231 = {buf_nomerge_3,buf_nomerge_2,buf_nomerge_1,buf_nomerge_0}; // @[Cat.scala 29:58]
  wire  _T_1240 = _T_1044 & _T_1231[0]; // @[Mux.scala 27:72]
  wire  _T_1241 = _T_1045 & _T_1231[1]; // @[Mux.scala 27:72]
  wire  _T_1244 = _T_1240 | _T_1241; // @[Mux.scala 27:72]
  wire  _T_1242 = _T_1046 & _T_1231[2]; // @[Mux.scala 27:72]
  wire  _T_1245 = _T_1244 | _T_1242; // @[Mux.scala 27:72]
  wire  _T_1243 = _T_1047 & _T_1231[3]; // @[Mux.scala 27:72]
  wire  _T_1246 = _T_1245 | _T_1243; // @[Mux.scala 27:72]
  wire  _T_1248 = _T_1228 | _T_1246; // @[el2_lsu_bus_buffer.scala 339:197]
  wire  _T_1249 = _T_1248 | obuf_force_wr_en; // @[el2_lsu_bus_buffer.scala 339:269]
  wire  _T_1250 = _T_1169 & _T_1249; // @[el2_lsu_bus_buffer.scala 338:164]
  wire  _T_1251 = _T_1115 | _T_1250; // @[el2_lsu_bus_buffer.scala 336:98]
  reg  obuf_write; // @[Reg.scala 27:20]
  reg  obuf_cmd_done; // @[el2_lsu_bus_buffer.scala 403:54]
  reg  obuf_data_done; // @[el2_lsu_bus_buffer.scala 404:55]
  wire  _T_4876 = obuf_cmd_done | obuf_data_done; // @[el2_lsu_bus_buffer.scala 611:54]
  wire  _T_4877 = obuf_cmd_done ? io_lsu_axi_wready : io_lsu_axi_awready; // @[el2_lsu_bus_buffer.scala 611:75]
  wire  _T_4879 = _T_4876 ? _T_4877 : io_lsu_axi_awready; // @[el2_lsu_bus_buffer.scala 611:39]
  wire  bus_cmd_ready = obuf_write ? _T_4879 : io_lsu_axi_arready; // @[el2_lsu_bus_buffer.scala 611:23]
  wire  _T_1252 = ~obuf_valid; // @[el2_lsu_bus_buffer.scala 340:48]
  wire  _T_1253 = bus_cmd_ready | _T_1252; // @[el2_lsu_bus_buffer.scala 340:46]
  reg  obuf_nosend; // @[Reg.scala 27:20]
  wire  _T_1254 = _T_1253 | obuf_nosend; // @[el2_lsu_bus_buffer.scala 340:60]
  wire  _T_1255 = _T_1251 & _T_1254; // @[el2_lsu_bus_buffer.scala 340:29]
  wire  _T_1256 = ~obuf_wr_wait; // @[el2_lsu_bus_buffer.scala 340:77]
  wire  _T_1257 = _T_1255 & _T_1256; // @[el2_lsu_bus_buffer.scala 340:75]
  reg [31:0] obuf_addr; // @[el2_lib.scala 514:16]
  wire  _T_4824 = obuf_addr[31:3] == buf_addr_0[31:3]; // @[el2_lsu_bus_buffer.scala 609:56]
  wire  _T_4825 = obuf_valid & _T_4824; // @[el2_lsu_bus_buffer.scala 609:38]
  wire  _T_4830 = ~_T_3588; // @[el2_lsu_bus_buffer.scala 609:80]
  wire  _T_4831 = _T_4825 & _T_4830; // @[el2_lsu_bus_buffer.scala 609:78]
  wire  _T_4868 = _T_4801 & _T_4831; // @[Mux.scala 27:72]
  wire  _T_4836 = obuf_addr[31:3] == buf_addr_1[31:3]; // @[el2_lsu_bus_buffer.scala 609:56]
  wire  _T_4837 = obuf_valid & _T_4836; // @[el2_lsu_bus_buffer.scala 609:38]
  wire  _T_4842 = ~_T_3781; // @[el2_lsu_bus_buffer.scala 609:80]
  wire  _T_4843 = _T_4837 & _T_4842; // @[el2_lsu_bus_buffer.scala 609:78]
  wire  _T_4869 = _T_4805 & _T_4843; // @[Mux.scala 27:72]
  wire  _T_4872 = _T_4868 | _T_4869; // @[Mux.scala 27:72]
  wire  _T_4848 = obuf_addr[31:3] == buf_addr_2[31:3]; // @[el2_lsu_bus_buffer.scala 609:56]
  wire  _T_4849 = obuf_valid & _T_4848; // @[el2_lsu_bus_buffer.scala 609:38]
  wire  _T_4854 = ~_T_3974; // @[el2_lsu_bus_buffer.scala 609:80]
  wire  _T_4855 = _T_4849 & _T_4854; // @[el2_lsu_bus_buffer.scala 609:78]
  wire  _T_4870 = _T_4809 & _T_4855; // @[Mux.scala 27:72]
  wire  _T_4873 = _T_4872 | _T_4870; // @[Mux.scala 27:72]
  wire  _T_4860 = obuf_addr[31:3] == buf_addr_3[31:3]; // @[el2_lsu_bus_buffer.scala 609:56]
  wire  _T_4861 = obuf_valid & _T_4860; // @[el2_lsu_bus_buffer.scala 609:38]
  wire  _T_4866 = ~_T_4167; // @[el2_lsu_bus_buffer.scala 609:80]
  wire  _T_4867 = _T_4861 & _T_4866; // @[el2_lsu_bus_buffer.scala 609:78]
  wire  _T_4871 = _T_4813 & _T_4867; // @[Mux.scala 27:72]
  wire  bus_addr_match_pending = _T_4873 | _T_4871; // @[Mux.scala 27:72]
  wire  _T_1260 = ~bus_addr_match_pending; // @[el2_lsu_bus_buffer.scala 340:118]
  wire  _T_1261 = _T_1257 & _T_1260; // @[el2_lsu_bus_buffer.scala 340:116]
  wire  obuf_wr_en = _T_1261 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 340:142]
  wire  _T_1263 = obuf_valid & obuf_nosend; // @[el2_lsu_bus_buffer.scala 342:47]
  wire  bus_wcmd_sent = io_lsu_axi_awvalid & io_lsu_axi_awready; // @[el2_lsu_bus_buffer.scala 612:39]
  wire  _T_4883 = obuf_cmd_done | bus_wcmd_sent; // @[el2_lsu_bus_buffer.scala 614:35]
  wire  bus_wdata_sent = io_lsu_axi_wvalid & io_lsu_axi_wready; // @[el2_lsu_bus_buffer.scala 613:39]
  wire  _T_4884 = obuf_data_done | bus_wdata_sent; // @[el2_lsu_bus_buffer.scala 614:70]
  wire  _T_4885 = _T_4883 & _T_4884; // @[el2_lsu_bus_buffer.scala 614:52]
  wire  _T_4886 = io_lsu_axi_arvalid & io_lsu_axi_arready; // @[el2_lsu_bus_buffer.scala 614:111]
  wire  bus_cmd_sent = _T_4885 | _T_4886; // @[el2_lsu_bus_buffer.scala 614:89]
  wire  _T_1264 = bus_cmd_sent | _T_1263; // @[el2_lsu_bus_buffer.scala 342:33]
  wire  _T_1265 = ~obuf_wr_en; // @[el2_lsu_bus_buffer.scala 342:65]
  wire  _T_1266 = _T_1264 & _T_1265; // @[el2_lsu_bus_buffer.scala 342:63]
  wire  _T_1267 = _T_1266 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 342:77]
  wire  obuf_rst = _T_1267 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 342:98]
  wire  obuf_write_in = ibuf_buf_byp ? io_lsu_pkt_r_store : _T_1223; // @[el2_lsu_bus_buffer.scala 343:26]
  wire [31:0] _T_1304 = _T_1044 ? buf_addr_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1305 = _T_1045 ? buf_addr_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1306 = _T_1046 ? buf_addr_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1307 = _T_1047 ? buf_addr_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1308 = _T_1304 | _T_1305; // @[Mux.scala 27:72]
  wire [31:0] _T_1309 = _T_1308 | _T_1306; // @[Mux.scala 27:72]
  wire [31:0] _T_1310 = _T_1309 | _T_1307; // @[Mux.scala 27:72]
  wire [31:0] obuf_addr_in = ibuf_buf_byp ? io_lsu_addr_r : _T_1310; // @[el2_lsu_bus_buffer.scala 345:25]
  reg [1:0] buf_sz_0; // @[Reg.scala 27:20]
  wire [1:0] _T_1317 = _T_1044 ? buf_sz_0 : 2'h0; // @[Mux.scala 27:72]
  reg [1:0] buf_sz_1; // @[Reg.scala 27:20]
  wire [1:0] _T_1318 = _T_1045 ? buf_sz_1 : 2'h0; // @[Mux.scala 27:72]
  reg [1:0] buf_sz_2; // @[Reg.scala 27:20]
  wire [1:0] _T_1319 = _T_1046 ? buf_sz_2 : 2'h0; // @[Mux.scala 27:72]
  reg [1:0] buf_sz_3; // @[Reg.scala 27:20]
  wire [1:0] _T_1320 = _T_1047 ? buf_sz_3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_1321 = _T_1317 | _T_1318; // @[Mux.scala 27:72]
  wire [1:0] _T_1322 = _T_1321 | _T_1319; // @[Mux.scala 27:72]
  wire [1:0] _T_1323 = _T_1322 | _T_1320; // @[Mux.scala 27:72]
  wire [1:0] obuf_sz_in = ibuf_buf_byp ? ibuf_sz_in : _T_1323; // @[el2_lsu_bus_buffer.scala 348:23]
  wire [1:0] _T_1325 = ibuf_buf_byp ? WrPtr0_r : CmdPtr0; // @[el2_lsu_bus_buffer.scala 353:22]
  wire [1:0] _T_1326 = ibuf_buf_byp ? WrPtr1_r : 2'h0; // @[el2_lsu_bus_buffer.scala 356:22]
  wire  _T_1327 = obuf_wr_en | obuf_rst; // @[el2_lsu_bus_buffer.scala 359:39]
  wire  _T_1328 = ~_T_1327; // @[el2_lsu_bus_buffer.scala 359:26]
  wire  _T_1334 = obuf_sz_in == 2'h0; // @[el2_lsu_bus_buffer.scala 363:72]
  wire  _T_1337 = ~obuf_addr_in[0]; // @[el2_lsu_bus_buffer.scala 363:98]
  wire  _T_1338 = obuf_sz_in[0] & _T_1337; // @[el2_lsu_bus_buffer.scala 363:96]
  wire  _T_1339 = _T_1334 | _T_1338; // @[el2_lsu_bus_buffer.scala 363:79]
  wire  _T_1342 = |obuf_addr_in[1:0]; // @[el2_lsu_bus_buffer.scala 363:153]
  wire  _T_1343 = ~_T_1342; // @[el2_lsu_bus_buffer.scala 363:134]
  wire  _T_1344 = obuf_sz_in[1] & _T_1343; // @[el2_lsu_bus_buffer.scala 363:132]
  wire  _T_1345 = _T_1339 | _T_1344; // @[el2_lsu_bus_buffer.scala 363:116]
  wire  obuf_aligned_in = ibuf_buf_byp ? is_aligned_r : _T_1345; // @[el2_lsu_bus_buffer.scala 363:28]
  wire  _T_1362 = obuf_addr_in[31:3] == obuf_addr[31:3]; // @[el2_lsu_bus_buffer.scala 377:40]
  wire  _T_1363 = _T_1362 & obuf_aligned_in; // @[el2_lsu_bus_buffer.scala 377:60]
  reg  obuf_sideeffect; // @[Reg.scala 27:20]
  wire  _T_1364 = ~obuf_sideeffect; // @[el2_lsu_bus_buffer.scala 377:80]
  wire  _T_1365 = _T_1363 & _T_1364; // @[el2_lsu_bus_buffer.scala 377:78]
  wire  _T_1366 = ~obuf_write; // @[el2_lsu_bus_buffer.scala 377:99]
  wire  _T_1367 = _T_1365 & _T_1366; // @[el2_lsu_bus_buffer.scala 377:97]
  wire  _T_1368 = ~obuf_write_in; // @[el2_lsu_bus_buffer.scala 377:113]
  wire  _T_1369 = _T_1367 & _T_1368; // @[el2_lsu_bus_buffer.scala 377:111]
  wire  _T_1370 = ~io_dec_tlu_external_ldfwd_disable; // @[el2_lsu_bus_buffer.scala 377:130]
  wire  _T_1371 = _T_1369 & _T_1370; // @[el2_lsu_bus_buffer.scala 377:128]
  wire  _T_1372 = ~obuf_nosend; // @[el2_lsu_bus_buffer.scala 378:20]
  wire  _T_1373 = obuf_valid & _T_1372; // @[el2_lsu_bus_buffer.scala 378:18]
  reg  obuf_rdrsp_pend; // @[el2_lsu_bus_buffer.scala 405:56]
  wire  bus_rsp_read = io_lsu_axi_rvalid & io_lsu_axi_rready; // @[el2_lsu_bus_buffer.scala 615:37]
  reg [2:0] obuf_rdrsp_tag; // @[el2_lsu_bus_buffer.scala 406:55]
  wire  _T_1374 = io_lsu_axi_rid == obuf_rdrsp_tag; // @[el2_lsu_bus_buffer.scala 378:90]
  wire  _T_1375 = bus_rsp_read & _T_1374; // @[el2_lsu_bus_buffer.scala 378:70]
  wire  _T_1376 = ~_T_1375; // @[el2_lsu_bus_buffer.scala 378:55]
  wire  _T_1377 = obuf_rdrsp_pend & _T_1376; // @[el2_lsu_bus_buffer.scala 378:53]
  wire  _T_1378 = _T_1373 | _T_1377; // @[el2_lsu_bus_buffer.scala 378:34]
  wire  obuf_nosend_in = _T_1371 & _T_1378; // @[el2_lsu_bus_buffer.scala 377:165]
  wire  _T_1346 = ~obuf_nosend_in; // @[el2_lsu_bus_buffer.scala 371:44]
  wire  _T_1347 = obuf_wr_en & _T_1346; // @[el2_lsu_bus_buffer.scala 371:42]
  wire  _T_1348 = ~_T_1347; // @[el2_lsu_bus_buffer.scala 371:29]
  wire  _T_1349 = _T_1348 & obuf_rdrsp_pend; // @[el2_lsu_bus_buffer.scala 371:61]
  wire  _T_1353 = _T_1349 & _T_1376; // @[el2_lsu_bus_buffer.scala 371:79]
  wire  _T_1355 = bus_cmd_sent & _T_1366; // @[el2_lsu_bus_buffer.scala 372:20]
  wire  _T_1356 = ~io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 372:37]
  wire  _T_1357 = _T_1355 & _T_1356; // @[el2_lsu_bus_buffer.scala 372:35]
  wire  _T_1359 = bus_cmd_sent | _T_1366; // @[el2_lsu_bus_buffer.scala 374:44]
  wire [7:0] _T_1381 = {ldst_byteen_lo_r,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1382 = {4'h0,ldst_byteen_lo_r}; // @[Cat.scala 29:58]
  wire [7:0] _T_1383 = io_lsu_addr_r[2] ? _T_1381 : _T_1382; // @[el2_lsu_bus_buffer.scala 379:46]
  wire [3:0] _T_1402 = _T_1044 ? buf_byteen_0 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1403 = _T_1045 ? buf_byteen_1 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1404 = _T_1046 ? buf_byteen_2 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1405 = _T_1047 ? buf_byteen_3 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1406 = _T_1402 | _T_1403; // @[Mux.scala 27:72]
  wire [3:0] _T_1407 = _T_1406 | _T_1404; // @[Mux.scala 27:72]
  wire [3:0] _T_1408 = _T_1407 | _T_1405; // @[Mux.scala 27:72]
  wire [7:0] _T_1410 = {_T_1408,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1423 = {4'h0,_T_1408}; // @[Cat.scala 29:58]
  wire [7:0] _T_1424 = _T_1310[2] ? _T_1410 : _T_1423; // @[el2_lsu_bus_buffer.scala 380:8]
  wire [7:0] obuf_byteen0_in = ibuf_buf_byp ? _T_1383 : _T_1424; // @[el2_lsu_bus_buffer.scala 379:28]
  wire [7:0] _T_1426 = {ldst_byteen_hi_r,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1427 = {4'h0,ldst_byteen_hi_r}; // @[Cat.scala 29:58]
  wire [7:0] _T_1428 = io_end_addr_r[2] ? _T_1426 : _T_1427; // @[el2_lsu_bus_buffer.scala 381:46]
  wire [7:0] _T_1455 = {buf_byteen_0,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1468 = {4'h0,buf_byteen_0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1469 = buf_addr_0[2] ? _T_1455 : _T_1468; // @[el2_lsu_bus_buffer.scala 382:8]
  wire [7:0] obuf_byteen1_in = ibuf_buf_byp ? _T_1428 : _T_1469; // @[el2_lsu_bus_buffer.scala 381:28]
  wire [63:0] _T_1471 = {store_data_lo_r,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1472 = {32'h0,store_data_lo_r}; // @[Cat.scala 29:58]
  wire [63:0] _T_1473 = io_lsu_addr_r[2] ? _T_1471 : _T_1472; // @[el2_lsu_bus_buffer.scala 384:44]
  wire [31:0] _T_1492 = _T_1044 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1493 = _T_1045 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1494 = _T_1046 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1495 = _T_1047 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1496 = _T_1492 | _T_1493; // @[Mux.scala 27:72]
  wire [31:0] _T_1497 = _T_1496 | _T_1494; // @[Mux.scala 27:72]
  wire [31:0] _T_1498 = _T_1497 | _T_1495; // @[Mux.scala 27:72]
  wire [63:0] _T_1500 = {_T_1498,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1513 = {32'h0,_T_1498}; // @[Cat.scala 29:58]
  wire [63:0] _T_1514 = _T_1310[2] ? _T_1500 : _T_1513; // @[el2_lsu_bus_buffer.scala 385:8]
  wire [63:0] obuf_data0_in = ibuf_buf_byp ? _T_1473 : _T_1514; // @[el2_lsu_bus_buffer.scala 384:26]
  wire [63:0] _T_1516 = {store_data_hi_r,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1517 = {32'h0,store_data_hi_r}; // @[Cat.scala 29:58]
  wire [63:0] _T_1518 = io_lsu_addr_r[2] ? _T_1516 : _T_1517; // @[el2_lsu_bus_buffer.scala 386:44]
  wire [63:0] _T_1545 = {buf_data_0,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1558 = {32'h0,buf_data_0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1559 = buf_addr_0[2] ? _T_1545 : _T_1558; // @[el2_lsu_bus_buffer.scala 387:8]
  wire [63:0] obuf_data1_in = ibuf_buf_byp ? _T_1518 : _T_1559; // @[el2_lsu_bus_buffer.scala 386:26]
  wire  _T_1644 = CmdPtr0 != 2'h0; // @[el2_lsu_bus_buffer.scala 393:30]
  wire  _T_1645 = _T_1644 & found_cmdptr0; // @[el2_lsu_bus_buffer.scala 393:43]
  wire  _T_1646 = _T_1645 & found_cmdptr1; // @[el2_lsu_bus_buffer.scala 393:59]
  wire  _T_1660 = _T_1646 & _T_1128; // @[el2_lsu_bus_buffer.scala 393:75]
  wire  _T_1674 = _T_1660 & _T_2629; // @[el2_lsu_bus_buffer.scala 393:118]
  wire  _T_1695 = _T_1674 & _T_1149; // @[el2_lsu_bus_buffer.scala 393:161]
  wire  _T_1713 = _T_1695 & _T_1074; // @[el2_lsu_bus_buffer.scala 394:83]
  wire  _T_1815 = _T_1225 & _T_1187; // @[el2_lsu_bus_buffer.scala 397:36]
  reg  buf_dualhi_3; // @[Reg.scala 27:20]
  reg  buf_dualhi_2; // @[Reg.scala 27:20]
  reg  buf_dualhi_1; // @[Reg.scala 27:20]
  reg  buf_dualhi_0; // @[Reg.scala 27:20]
  wire [3:0] _T_1818 = {buf_dualhi_3,buf_dualhi_2,buf_dualhi_1,buf_dualhi_0}; // @[Cat.scala 29:58]
  wire  _T_1827 = _T_1044 & _T_1818[0]; // @[Mux.scala 27:72]
  wire  _T_1828 = _T_1045 & _T_1818[1]; // @[Mux.scala 27:72]
  wire  _T_1831 = _T_1827 | _T_1828; // @[Mux.scala 27:72]
  wire  _T_1829 = _T_1046 & _T_1818[2]; // @[Mux.scala 27:72]
  wire  _T_1832 = _T_1831 | _T_1829; // @[Mux.scala 27:72]
  wire  _T_1830 = _T_1047 & _T_1818[3]; // @[Mux.scala 27:72]
  wire  _T_1833 = _T_1832 | _T_1830; // @[Mux.scala 27:72]
  wire  _T_1835 = ~_T_1833; // @[el2_lsu_bus_buffer.scala 397:107]
  wire  _T_1836 = _T_1815 & _T_1835; // @[el2_lsu_bus_buffer.scala 397:105]
  wire  _T_1856 = _T_1836 & _T_1206; // @[el2_lsu_bus_buffer.scala 397:177]
  wire  _T_1858 = _T_1713 & _T_1856; // @[el2_lsu_bus_buffer.scala 394:120]
  wire  _T_1859 = ibuf_buf_byp & ldst_samedw_r; // @[el2_lsu_bus_buffer.scala 398:19]
  wire  _T_1860 = _T_1859 & io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 398:35]
  wire  obuf_merge_en = _T_1858 | _T_1860; // @[el2_lsu_bus_buffer.scala 397:251]
  wire  _T_1562 = obuf_merge_en & obuf_byteen1_in[0]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1563 = obuf_byteen0_in[0] | _T_1562; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1566 = obuf_merge_en & obuf_byteen1_in[1]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1567 = obuf_byteen0_in[1] | _T_1566; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1570 = obuf_merge_en & obuf_byteen1_in[2]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1571 = obuf_byteen0_in[2] | _T_1570; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1574 = obuf_merge_en & obuf_byteen1_in[3]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1575 = obuf_byteen0_in[3] | _T_1574; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1578 = obuf_merge_en & obuf_byteen1_in[4]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1579 = obuf_byteen0_in[4] | _T_1578; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1582 = obuf_merge_en & obuf_byteen1_in[5]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1583 = obuf_byteen0_in[5] | _T_1582; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1586 = obuf_merge_en & obuf_byteen1_in[6]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1587 = obuf_byteen0_in[6] | _T_1586; // @[el2_lsu_bus_buffer.scala 388:63]
  wire  _T_1590 = obuf_merge_en & obuf_byteen1_in[7]; // @[el2_lsu_bus_buffer.scala 388:80]
  wire  _T_1591 = obuf_byteen0_in[7] | _T_1590; // @[el2_lsu_bus_buffer.scala 388:63]
  wire [7:0] obuf_byteen_in = {_T_1591,_T_1587,_T_1583,_T_1579,_T_1575,_T_1571,_T_1567,_T_1563}; // @[Cat.scala 29:58]
  wire [7:0] _T_1602 = _T_1562 ? obuf_data1_in[7:0] : obuf_data0_in[7:0]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1607 = _T_1566 ? obuf_data1_in[15:8] : obuf_data0_in[15:8]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1612 = _T_1570 ? obuf_data1_in[23:16] : obuf_data0_in[23:16]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1617 = _T_1574 ? obuf_data1_in[31:24] : obuf_data0_in[31:24]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1622 = _T_1578 ? obuf_data1_in[39:32] : obuf_data0_in[39:32]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1627 = _T_1582 ? obuf_data1_in[47:40] : obuf_data0_in[47:40]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1632 = _T_1586 ? obuf_data1_in[55:48] : obuf_data0_in[55:48]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [7:0] _T_1637 = _T_1590 ? obuf_data1_in[63:56] : obuf_data0_in[63:56]; // @[el2_lsu_bus_buffer.scala 389:44]
  wire [55:0] _T_1643 = {_T_1637,_T_1632,_T_1627,_T_1622,_T_1617,_T_1612,_T_1607}; // @[Cat.scala 29:58]
  wire  _T_1862 = obuf_wr_en | obuf_valid; // @[el2_lsu_bus_buffer.scala 401:58]
  wire  _T_1863 = ~obuf_rst; // @[el2_lsu_bus_buffer.scala 401:93]
  wire [2:0] obuf_tag0_in = {{1'd0}, _T_1325}; // @[el2_lsu_bus_buffer.scala 353:16]
  wire [2:0] obuf_tag1_in = {{1'd0}, _T_1326}; // @[el2_lsu_bus_buffer.scala 356:16]
  reg [1:0] obuf_sz; // @[Reg.scala 27:20]
  reg [7:0] obuf_byteen; // @[Reg.scala 27:20]
  reg [63:0] obuf_data; // @[el2_lib.scala 514:16]
  wire  _T_1876 = buf_state_0 == 3'h0; // @[el2_lsu_bus_buffer.scala 419:65]
  wire  _T_1877 = ibuf_tag == 2'h0; // @[el2_lsu_bus_buffer.scala 420:30]
  wire  _T_1878 = ibuf_valid & _T_1877; // @[el2_lsu_bus_buffer.scala 420:19]
  wire  _T_1879 = WrPtr0_r == 2'h0; // @[el2_lsu_bus_buffer.scala 421:18]
  wire  _T_1880 = WrPtr1_r == 2'h0; // @[el2_lsu_bus_buffer.scala 421:57]
  wire  _T_1881 = io_ldst_dual_r & _T_1880; // @[el2_lsu_bus_buffer.scala 421:45]
  wire  _T_1882 = _T_1879 | _T_1881; // @[el2_lsu_bus_buffer.scala 421:27]
  wire  _T_1883 = io_lsu_busreq_r & _T_1882; // @[el2_lsu_bus_buffer.scala 420:58]
  wire  _T_1884 = _T_1878 | _T_1883; // @[el2_lsu_bus_buffer.scala 420:39]
  wire  _T_1885 = ~_T_1884; // @[el2_lsu_bus_buffer.scala 420:5]
  wire  _T_1886 = _T_1876 & _T_1885; // @[el2_lsu_bus_buffer.scala 419:76]
  wire  _T_1887 = buf_state_1 == 3'h0; // @[el2_lsu_bus_buffer.scala 419:65]
  wire  _T_1888 = ibuf_tag == 2'h1; // @[el2_lsu_bus_buffer.scala 420:30]
  wire  _T_1889 = ibuf_valid & _T_1888; // @[el2_lsu_bus_buffer.scala 420:19]
  wire  _T_1890 = WrPtr0_r == 2'h1; // @[el2_lsu_bus_buffer.scala 421:18]
  wire  _T_1891 = WrPtr1_r == 2'h1; // @[el2_lsu_bus_buffer.scala 421:57]
  wire  _T_1892 = io_ldst_dual_r & _T_1891; // @[el2_lsu_bus_buffer.scala 421:45]
  wire  _T_1893 = _T_1890 | _T_1892; // @[el2_lsu_bus_buffer.scala 421:27]
  wire  _T_1894 = io_lsu_busreq_r & _T_1893; // @[el2_lsu_bus_buffer.scala 420:58]
  wire  _T_1895 = _T_1889 | _T_1894; // @[el2_lsu_bus_buffer.scala 420:39]
  wire  _T_1896 = ~_T_1895; // @[el2_lsu_bus_buffer.scala 420:5]
  wire  _T_1897 = _T_1887 & _T_1896; // @[el2_lsu_bus_buffer.scala 419:76]
  wire  _T_1898 = buf_state_2 == 3'h0; // @[el2_lsu_bus_buffer.scala 419:65]
  wire  _T_1899 = ibuf_tag == 2'h2; // @[el2_lsu_bus_buffer.scala 420:30]
  wire  _T_1900 = ibuf_valid & _T_1899; // @[el2_lsu_bus_buffer.scala 420:19]
  wire  _T_1901 = WrPtr0_r == 2'h2; // @[el2_lsu_bus_buffer.scala 421:18]
  wire  _T_1902 = WrPtr1_r == 2'h2; // @[el2_lsu_bus_buffer.scala 421:57]
  wire  _T_1903 = io_ldst_dual_r & _T_1902; // @[el2_lsu_bus_buffer.scala 421:45]
  wire  _T_1904 = _T_1901 | _T_1903; // @[el2_lsu_bus_buffer.scala 421:27]
  wire  _T_1905 = io_lsu_busreq_r & _T_1904; // @[el2_lsu_bus_buffer.scala 420:58]
  wire  _T_1906 = _T_1900 | _T_1905; // @[el2_lsu_bus_buffer.scala 420:39]
  wire  _T_1907 = ~_T_1906; // @[el2_lsu_bus_buffer.scala 420:5]
  wire  _T_1908 = _T_1898 & _T_1907; // @[el2_lsu_bus_buffer.scala 419:76]
  wire  _T_1909 = buf_state_3 == 3'h0; // @[el2_lsu_bus_buffer.scala 419:65]
  wire  _T_1910 = ibuf_tag == 2'h3; // @[el2_lsu_bus_buffer.scala 420:30]
  wire  _T_1912 = WrPtr0_r == 2'h3; // @[el2_lsu_bus_buffer.scala 421:18]
  wire  _T_1913 = WrPtr1_r == 2'h3; // @[el2_lsu_bus_buffer.scala 421:57]
  wire [1:0] _T_1921 = _T_1908 ? 2'h2 : 2'h3; // @[Mux.scala 98:16]
  wire [1:0] _T_1922 = _T_1897 ? 2'h1 : _T_1921; // @[Mux.scala 98:16]
  wire [1:0] WrPtr0_m = _T_1886 ? 2'h0 : _T_1922; // @[Mux.scala 98:16]
  wire  _T_1927 = WrPtr0_m == 2'h0; // @[el2_lsu_bus_buffer.scala 426:33]
  wire  _T_1928 = io_lsu_busreq_m & _T_1927; // @[el2_lsu_bus_buffer.scala 426:22]
  wire  _T_1929 = _T_1878 | _T_1928; // @[el2_lsu_bus_buffer.scala 425:112]
  wire  _T_1935 = _T_1929 | _T_1883; // @[el2_lsu_bus_buffer.scala 426:42]
  wire  _T_1936 = ~_T_1935; // @[el2_lsu_bus_buffer.scala 425:78]
  wire  _T_1937 = _T_1876 & _T_1936; // @[el2_lsu_bus_buffer.scala 425:76]
  wire  _T_1941 = WrPtr0_m == 2'h1; // @[el2_lsu_bus_buffer.scala 426:33]
  wire  _T_1942 = io_lsu_busreq_m & _T_1941; // @[el2_lsu_bus_buffer.scala 426:22]
  wire  _T_1943 = _T_1889 | _T_1942; // @[el2_lsu_bus_buffer.scala 425:112]
  wire  _T_1949 = _T_1943 | _T_1894; // @[el2_lsu_bus_buffer.scala 426:42]
  wire  _T_1950 = ~_T_1949; // @[el2_lsu_bus_buffer.scala 425:78]
  wire  _T_1951 = _T_1887 & _T_1950; // @[el2_lsu_bus_buffer.scala 425:76]
  wire  _T_1955 = WrPtr0_m == 2'h2; // @[el2_lsu_bus_buffer.scala 426:33]
  wire  _T_1956 = io_lsu_busreq_m & _T_1955; // @[el2_lsu_bus_buffer.scala 426:22]
  wire  _T_1957 = _T_1900 | _T_1956; // @[el2_lsu_bus_buffer.scala 425:112]
  wire  _T_1963 = _T_1957 | _T_1905; // @[el2_lsu_bus_buffer.scala 426:42]
  wire  _T_1964 = ~_T_1963; // @[el2_lsu_bus_buffer.scala 425:78]
  wire  _T_1965 = _T_1898 & _T_1964; // @[el2_lsu_bus_buffer.scala 425:76]
  reg [3:0] buf_rspageQ_0; // @[el2_lsu_bus_buffer.scala 556:63]
  wire  _T_2769 = buf_state_3 == 3'h5; // @[el2_lsu_bus_buffer.scala 469:104]
  wire  _T_2770 = buf_rspageQ_0[3] & _T_2769; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2766 = buf_state_2 == 3'h5; // @[el2_lsu_bus_buffer.scala 469:104]
  wire  _T_2767 = buf_rspageQ_0[2] & _T_2766; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2763 = buf_state_1 == 3'h5; // @[el2_lsu_bus_buffer.scala 469:104]
  wire  _T_2764 = buf_rspageQ_0[1] & _T_2763; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2760 = buf_state_0 == 3'h5; // @[el2_lsu_bus_buffer.scala 469:104]
  wire  _T_2761 = buf_rspageQ_0[0] & _T_2760; // @[el2_lsu_bus_buffer.scala 469:89]
  wire [3:0] buf_rsp_pickage_0 = {_T_2770,_T_2767,_T_2764,_T_2761}; // @[Cat.scala 29:58]
  wire  _T_2056 = |buf_rsp_pickage_0; // @[el2_lsu_bus_buffer.scala 437:65]
  wire  _T_2057 = ~_T_2056; // @[el2_lsu_bus_buffer.scala 437:44]
  wire  _T_2059 = _T_2057 & _T_2760; // @[el2_lsu_bus_buffer.scala 437:70]
  reg [3:0] buf_rspageQ_1; // @[el2_lsu_bus_buffer.scala 556:63]
  wire  _T_2785 = buf_rspageQ_1[3] & _T_2769; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2782 = buf_rspageQ_1[2] & _T_2766; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2779 = buf_rspageQ_1[1] & _T_2763; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2776 = buf_rspageQ_1[0] & _T_2760; // @[el2_lsu_bus_buffer.scala 469:89]
  wire [3:0] buf_rsp_pickage_1 = {_T_2785,_T_2782,_T_2779,_T_2776}; // @[Cat.scala 29:58]
  wire  _T_2060 = |buf_rsp_pickage_1; // @[el2_lsu_bus_buffer.scala 437:65]
  wire  _T_2061 = ~_T_2060; // @[el2_lsu_bus_buffer.scala 437:44]
  wire  _T_2063 = _T_2061 & _T_2763; // @[el2_lsu_bus_buffer.scala 437:70]
  reg [3:0] buf_rspageQ_2; // @[el2_lsu_bus_buffer.scala 556:63]
  wire  _T_2800 = buf_rspageQ_2[3] & _T_2769; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2797 = buf_rspageQ_2[2] & _T_2766; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2794 = buf_rspageQ_2[1] & _T_2763; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2791 = buf_rspageQ_2[0] & _T_2760; // @[el2_lsu_bus_buffer.scala 469:89]
  wire [3:0] buf_rsp_pickage_2 = {_T_2800,_T_2797,_T_2794,_T_2791}; // @[Cat.scala 29:58]
  wire  _T_2064 = |buf_rsp_pickage_2; // @[el2_lsu_bus_buffer.scala 437:65]
  wire  _T_2065 = ~_T_2064; // @[el2_lsu_bus_buffer.scala 437:44]
  wire  _T_2067 = _T_2065 & _T_2766; // @[el2_lsu_bus_buffer.scala 437:70]
  reg [3:0] buf_rspageQ_3; // @[el2_lsu_bus_buffer.scala 556:63]
  wire  _T_2815 = buf_rspageQ_3[3] & _T_2769; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2812 = buf_rspageQ_3[2] & _T_2766; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2809 = buf_rspageQ_3[1] & _T_2763; // @[el2_lsu_bus_buffer.scala 469:89]
  wire  _T_2806 = buf_rspageQ_3[0] & _T_2760; // @[el2_lsu_bus_buffer.scala 469:89]
  wire [3:0] buf_rsp_pickage_3 = {_T_2815,_T_2812,_T_2809,_T_2806}; // @[Cat.scala 29:58]
  wire  _T_2068 = |buf_rsp_pickage_3; // @[el2_lsu_bus_buffer.scala 437:65]
  wire  _T_2069 = ~_T_2068; // @[el2_lsu_bus_buffer.scala 437:44]
  wire  _T_2071 = _T_2069 & _T_2769; // @[el2_lsu_bus_buffer.scala 437:70]
  wire [7:0] _T_2127 = {4'h0,_T_2071,_T_2067,_T_2063,_T_2059}; // @[Cat.scala 29:58]
  wire  _T_2130 = _T_2127[4] | _T_2127[5]; // @[el2_lsu_bus_buffer.scala 441:42]
  wire  _T_2132 = _T_2130 | _T_2127[6]; // @[el2_lsu_bus_buffer.scala 441:48]
  wire  _T_2134 = _T_2132 | _T_2127[7]; // @[el2_lsu_bus_buffer.scala 441:54]
  wire  _T_2137 = _T_2127[2] | _T_2127[3]; // @[el2_lsu_bus_buffer.scala 441:67]
  wire  _T_2139 = _T_2137 | _T_2127[6]; // @[el2_lsu_bus_buffer.scala 441:73]
  wire  _T_2141 = _T_2139 | _T_2127[7]; // @[el2_lsu_bus_buffer.scala 441:79]
  wire  _T_2144 = _T_2127[1] | _T_2127[3]; // @[el2_lsu_bus_buffer.scala 441:92]
  wire  _T_2146 = _T_2144 | _T_2127[5]; // @[el2_lsu_bus_buffer.scala 441:98]
  wire  _T_2148 = _T_2146 | _T_2127[7]; // @[el2_lsu_bus_buffer.scala 441:104]
  wire [2:0] _T_2150 = {_T_2134,_T_2141,_T_2148}; // @[Cat.scala 29:58]
  wire  _T_3555 = ibuf_byp | io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 499:77]
  wire  _T_3556 = ~ibuf_merge_en; // @[el2_lsu_bus_buffer.scala 499:97]
  wire  _T_3557 = _T_3555 & _T_3556; // @[el2_lsu_bus_buffer.scala 499:95]
  wire  _T_3558 = 2'h0 == WrPtr0_r; // @[el2_lsu_bus_buffer.scala 499:117]
  wire  _T_3559 = _T_3557 & _T_3558; // @[el2_lsu_bus_buffer.scala 499:112]
  wire  _T_3560 = ibuf_byp & io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 499:144]
  wire  _T_3561 = 2'h0 == WrPtr1_r; // @[el2_lsu_bus_buffer.scala 499:166]
  wire  _T_3562 = _T_3560 & _T_3561; // @[el2_lsu_bus_buffer.scala 499:161]
  wire  _T_3563 = _T_3559 | _T_3562; // @[el2_lsu_bus_buffer.scala 499:132]
  wire  _T_3564 = _T_853 & _T_3563; // @[el2_lsu_bus_buffer.scala 499:63]
  wire  _T_3565 = 2'h0 == ibuf_tag; // @[el2_lsu_bus_buffer.scala 499:206]
  wire  _T_3566 = ibuf_drain_vld & _T_3565; // @[el2_lsu_bus_buffer.scala 499:201]
  wire  _T_3567 = _T_3564 | _T_3566; // @[el2_lsu_bus_buffer.scala 499:183]
  wire  _T_3577 = io_lsu_bus_clk_en | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 506:46]
  wire  _T_3612 = 3'h3 == buf_state_0; // @[Conditional.scala 37:30]
  wire  bus_rsp_write = io_lsu_axi_bvalid & io_lsu_axi_bready; // @[el2_lsu_bus_buffer.scala 616:38]
  wire  _T_3657 = io_lsu_axi_bid == 3'h0; // @[el2_lsu_bus_buffer.scala 524:73]
  wire  _T_3658 = bus_rsp_write & _T_3657; // @[el2_lsu_bus_buffer.scala 524:52]
  wire  _T_3659 = io_lsu_axi_rid == 3'h0; // @[el2_lsu_bus_buffer.scala 525:46]
  reg  _T_4330; // @[Reg.scala 27:20]
  reg  _T_4328; // @[Reg.scala 27:20]
  reg  _T_4326; // @[Reg.scala 27:20]
  reg  _T_4324; // @[Reg.scala 27:20]
  wire [3:0] buf_ldfwd = {_T_4330,_T_4328,_T_4326,_T_4324}; // @[Cat.scala 29:58]
  reg [1:0] buf_ldfwdtag_0; // @[Reg.scala 27:20]
  wire [2:0] _GEN_356 = {{1'd0}, buf_ldfwdtag_0}; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_3661 = io_lsu_axi_rid == _GEN_356; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_3662 = buf_ldfwd[0] & _T_3661; // @[el2_lsu_bus_buffer.scala 526:27]
  wire  _T_3663 = _T_3659 | _T_3662; // @[el2_lsu_bus_buffer.scala 525:77]
  wire  _T_3664 = buf_dual_0 & buf_dualhi_0; // @[el2_lsu_bus_buffer.scala 527:26]
  wire  _T_3666 = ~buf_write[0]; // @[el2_lsu_bus_buffer.scala 527:44]
  wire  _T_3667 = _T_3664 & _T_3666; // @[el2_lsu_bus_buffer.scala 527:42]
  wire  _T_3668 = _T_3667 & buf_samedw_0; // @[el2_lsu_bus_buffer.scala 527:58]
  reg [1:0] buf_dualtag_0; // @[Reg.scala 27:20]
  wire [2:0] _GEN_357 = {{1'd0}, buf_dualtag_0}; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_3669 = io_lsu_axi_rid == _GEN_357; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_3670 = _T_3668 & _T_3669; // @[el2_lsu_bus_buffer.scala 527:74]
  wire  _T_3671 = _T_3663 | _T_3670; // @[el2_lsu_bus_buffer.scala 526:71]
  wire  _T_3672 = bus_rsp_read & _T_3671; // @[el2_lsu_bus_buffer.scala 525:25]
  wire  _T_3673 = _T_3658 | _T_3672; // @[el2_lsu_bus_buffer.scala 524:105]
  wire  _GEN_42 = _T_3612 & _T_3673; // @[Conditional.scala 39:67]
  wire  _GEN_61 = _T_3578 ? 1'h0 : _GEN_42; // @[Conditional.scala 39:67]
  wire  _GEN_73 = _T_3574 ? 1'h0 : _GEN_61; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_0 = _T_3551 ? 1'h0 : _GEN_73; // @[Conditional.scala 40:58]
  wire  _T_3699 = 3'h4 == buf_state_0; // @[Conditional.scala 37:30]
  wire [3:0] _T_3709 = buf_ldfwd >> buf_dualtag_0; // @[el2_lsu_bus_buffer.scala 539:21]
  reg [1:0] buf_ldfwdtag_3; // @[Reg.scala 27:20]
  reg [1:0] buf_ldfwdtag_2; // @[Reg.scala 27:20]
  reg [1:0] buf_ldfwdtag_1; // @[Reg.scala 27:20]
  wire [1:0] _GEN_23 = 2'h1 == buf_dualtag_0 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_24 = 2'h2 == buf_dualtag_0 ? buf_ldfwdtag_2 : _GEN_23; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_25 = 2'h3 == buf_dualtag_0 ? buf_ldfwdtag_3 : _GEN_24; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [2:0] _GEN_359 = {{1'd0}, _GEN_25}; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_3711 = io_lsu_axi_rid == _GEN_359; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_3712 = _T_3709[0] & _T_3711; // @[el2_lsu_bus_buffer.scala 539:38]
  wire  _T_3713 = _T_3669 | _T_3712; // @[el2_lsu_bus_buffer.scala 538:95]
  wire  _T_3714 = bus_rsp_read & _T_3713; // @[el2_lsu_bus_buffer.scala 538:45]
  wire  _GEN_36 = _T_3699 & _T_3714; // @[Conditional.scala 39:67]
  wire  _GEN_43 = _T_3612 ? buf_resp_state_bus_en_0 : _GEN_36; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_3578 ? buf_cmd_state_bus_en_0 : _GEN_43; // @[Conditional.scala 39:67]
  wire  _GEN_66 = _T_3574 ? 1'h0 : _GEN_53; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_0 = _T_3551 ? 1'h0 : _GEN_66; // @[Conditional.scala 40:58]
  wire  _T_3591 = buf_state_bus_en_0 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 512:49]
  wire  _T_3592 = _T_3591 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 512:70]
  wire  _T_3717 = 3'h5 == buf_state_0; // @[Conditional.scala 37:30]
  wire [1:0] RspPtr = _T_2150[1:0]; // @[el2_lsu_bus_buffer.scala 449:10]
  wire  _T_3720 = RspPtr == 2'h0; // @[el2_lsu_bus_buffer.scala 544:37]
  wire  _T_3721 = buf_dualtag_0 == RspPtr; // @[el2_lsu_bus_buffer.scala 544:98]
  wire  _T_3722 = buf_dual_0 & _T_3721; // @[el2_lsu_bus_buffer.scala 544:80]
  wire  _T_3723 = _T_3720 | _T_3722; // @[el2_lsu_bus_buffer.scala 544:65]
  wire  _T_3724 = _T_3723 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 544:112]
  wire  _T_3725 = 3'h6 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _GEN_31 = _T_3717 ? _T_3724 : _T_3725; // @[Conditional.scala 39:67]
  wire  _GEN_37 = _T_3699 ? _T_3592 : _GEN_31; // @[Conditional.scala 39:67]
  wire  _GEN_44 = _T_3612 ? _T_3592 : _GEN_37; // @[Conditional.scala 39:67]
  wire  _GEN_54 = _T_3578 ? _T_3592 : _GEN_44; // @[Conditional.scala 39:67]
  wire  _GEN_64 = _T_3574 ? _T_3577 : _GEN_54; // @[Conditional.scala 39:67]
  wire  buf_state_en_0 = _T_3551 ? _T_3567 : _GEN_64; // @[Conditional.scala 40:58]
  wire  _T_2152 = _T_1876 & buf_state_en_0; // @[el2_lsu_bus_buffer.scala 461:94]
  wire  _T_2158 = ibuf_drain_vld & io_lsu_busreq_r; // @[el2_lsu_bus_buffer.scala 463:23]
  wire  _T_2160 = _T_2158 & _T_3555; // @[el2_lsu_bus_buffer.scala 463:41]
  wire  _T_2162 = _T_2160 & _T_1879; // @[el2_lsu_bus_buffer.scala 463:71]
  wire  _T_2164 = _T_2162 & _T_1877; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2165 = _T_4494 | _T_2164; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2166 = ibuf_byp & io_lsu_busreq_r; // @[el2_lsu_bus_buffer.scala 464:17]
  wire  _T_2167 = _T_2166 & io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 464:35]
  wire  _T_2169 = _T_2167 & _T_1880; // @[el2_lsu_bus_buffer.scala 464:52]
  wire  _T_2171 = _T_2169 & _T_1879; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2172 = _T_2165 | _T_2171; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2173 = _T_2152 & _T_2172; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2175 = _T_2173 | buf_age_0[0]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2189 = _T_2162 & _T_1888; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2190 = _T_4499 | _T_2189; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2196 = _T_2169 & _T_1890; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2197 = _T_2190 | _T_2196; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2198 = _T_2152 & _T_2197; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2200 = _T_2198 | buf_age_0[1]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2214 = _T_2162 & _T_1899; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2215 = _T_4504 | _T_2214; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2221 = _T_2169 & _T_1901; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2222 = _T_2215 | _T_2221; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2223 = _T_2152 & _T_2222; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2225 = _T_2223 | buf_age_0[2]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2239 = _T_2162 & _T_1910; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2240 = _T_4509 | _T_2239; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2246 = _T_2169 & _T_1912; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2247 = _T_2240 | _T_2246; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2248 = _T_2152 & _T_2247; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2250 = _T_2248 | buf_age_0[3]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire [2:0] _T_2252 = {_T_2250,_T_2225,_T_2200}; // @[Cat.scala 29:58]
  wire  _T_3751 = 2'h1 == WrPtr0_r; // @[el2_lsu_bus_buffer.scala 499:117]
  wire  _T_3752 = _T_3557 & _T_3751; // @[el2_lsu_bus_buffer.scala 499:112]
  wire  _T_3754 = 2'h1 == WrPtr1_r; // @[el2_lsu_bus_buffer.scala 499:166]
  wire  _T_3755 = _T_3560 & _T_3754; // @[el2_lsu_bus_buffer.scala 499:161]
  wire  _T_3756 = _T_3752 | _T_3755; // @[el2_lsu_bus_buffer.scala 499:132]
  wire  _T_3757 = _T_853 & _T_3756; // @[el2_lsu_bus_buffer.scala 499:63]
  wire  _T_3758 = 2'h1 == ibuf_tag; // @[el2_lsu_bus_buffer.scala 499:206]
  wire  _T_3759 = ibuf_drain_vld & _T_3758; // @[el2_lsu_bus_buffer.scala 499:201]
  wire  _T_3760 = _T_3757 | _T_3759; // @[el2_lsu_bus_buffer.scala 499:183]
  wire  _T_3805 = 3'h3 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3850 = io_lsu_axi_bid == 3'h1; // @[el2_lsu_bus_buffer.scala 524:73]
  wire  _T_3851 = bus_rsp_write & _T_3850; // @[el2_lsu_bus_buffer.scala 524:52]
  wire  _T_3852 = io_lsu_axi_rid == 3'h1; // @[el2_lsu_bus_buffer.scala 525:46]
  wire [2:0] _GEN_360 = {{1'd0}, buf_ldfwdtag_1}; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_3854 = io_lsu_axi_rid == _GEN_360; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_3855 = buf_ldfwd[1] & _T_3854; // @[el2_lsu_bus_buffer.scala 526:27]
  wire  _T_3856 = _T_3852 | _T_3855; // @[el2_lsu_bus_buffer.scala 525:77]
  wire  _T_3857 = buf_dual_1 & buf_dualhi_1; // @[el2_lsu_bus_buffer.scala 527:26]
  wire  _T_3859 = ~buf_write[1]; // @[el2_lsu_bus_buffer.scala 527:44]
  wire  _T_3860 = _T_3857 & _T_3859; // @[el2_lsu_bus_buffer.scala 527:42]
  wire  _T_3861 = _T_3860 & buf_samedw_1; // @[el2_lsu_bus_buffer.scala 527:58]
  reg [1:0] buf_dualtag_1; // @[Reg.scala 27:20]
  wire [2:0] _GEN_361 = {{1'd0}, buf_dualtag_1}; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_3862 = io_lsu_axi_rid == _GEN_361; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_3863 = _T_3861 & _T_3862; // @[el2_lsu_bus_buffer.scala 527:74]
  wire  _T_3864 = _T_3856 | _T_3863; // @[el2_lsu_bus_buffer.scala 526:71]
  wire  _T_3865 = bus_rsp_read & _T_3864; // @[el2_lsu_bus_buffer.scala 525:25]
  wire  _T_3866 = _T_3851 | _T_3865; // @[el2_lsu_bus_buffer.scala 524:105]
  wire  _GEN_118 = _T_3805 & _T_3866; // @[Conditional.scala 39:67]
  wire  _GEN_137 = _T_3771 ? 1'h0 : _GEN_118; // @[Conditional.scala 39:67]
  wire  _GEN_149 = _T_3767 ? 1'h0 : _GEN_137; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_1 = _T_3744 ? 1'h0 : _GEN_149; // @[Conditional.scala 40:58]
  wire  _T_3892 = 3'h4 == buf_state_1; // @[Conditional.scala 37:30]
  wire [3:0] _T_3902 = buf_ldfwd >> buf_dualtag_1; // @[el2_lsu_bus_buffer.scala 539:21]
  wire [1:0] _GEN_99 = 2'h1 == buf_dualtag_1 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_100 = 2'h2 == buf_dualtag_1 ? buf_ldfwdtag_2 : _GEN_99; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_101 = 2'h3 == buf_dualtag_1 ? buf_ldfwdtag_3 : _GEN_100; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [2:0] _GEN_363 = {{1'd0}, _GEN_101}; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_3904 = io_lsu_axi_rid == _GEN_363; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_3905 = _T_3902[0] & _T_3904; // @[el2_lsu_bus_buffer.scala 539:38]
  wire  _T_3906 = _T_3862 | _T_3905; // @[el2_lsu_bus_buffer.scala 538:95]
  wire  _T_3907 = bus_rsp_read & _T_3906; // @[el2_lsu_bus_buffer.scala 538:45]
  wire  _GEN_112 = _T_3892 & _T_3907; // @[Conditional.scala 39:67]
  wire  _GEN_119 = _T_3805 ? buf_resp_state_bus_en_1 : _GEN_112; // @[Conditional.scala 39:67]
  wire  _GEN_129 = _T_3771 ? buf_cmd_state_bus_en_1 : _GEN_119; // @[Conditional.scala 39:67]
  wire  _GEN_142 = _T_3767 ? 1'h0 : _GEN_129; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_1 = _T_3744 ? 1'h0 : _GEN_142; // @[Conditional.scala 40:58]
  wire  _T_3784 = buf_state_bus_en_1 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 512:49]
  wire  _T_3785 = _T_3784 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 512:70]
  wire  _T_3910 = 3'h5 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3913 = RspPtr == 2'h1; // @[el2_lsu_bus_buffer.scala 544:37]
  wire  _T_3914 = buf_dualtag_1 == RspPtr; // @[el2_lsu_bus_buffer.scala 544:98]
  wire  _T_3915 = buf_dual_1 & _T_3914; // @[el2_lsu_bus_buffer.scala 544:80]
  wire  _T_3916 = _T_3913 | _T_3915; // @[el2_lsu_bus_buffer.scala 544:65]
  wire  _T_3917 = _T_3916 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 544:112]
  wire  _T_3918 = 3'h6 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _GEN_107 = _T_3910 ? _T_3917 : _T_3918; // @[Conditional.scala 39:67]
  wire  _GEN_113 = _T_3892 ? _T_3785 : _GEN_107; // @[Conditional.scala 39:67]
  wire  _GEN_120 = _T_3805 ? _T_3785 : _GEN_113; // @[Conditional.scala 39:67]
  wire  _GEN_130 = _T_3771 ? _T_3785 : _GEN_120; // @[Conditional.scala 39:67]
  wire  _GEN_140 = _T_3767 ? _T_3577 : _GEN_130; // @[Conditional.scala 39:67]
  wire  buf_state_en_1 = _T_3744 ? _T_3760 : _GEN_140; // @[Conditional.scala 40:58]
  wire  _T_2254 = _T_1887 & buf_state_en_1; // @[el2_lsu_bus_buffer.scala 461:94]
  wire  _T_2264 = _T_2160 & _T_1890; // @[el2_lsu_bus_buffer.scala 463:71]
  wire  _T_2266 = _T_2264 & _T_1877; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2267 = _T_4494 | _T_2266; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2271 = _T_2167 & _T_1891; // @[el2_lsu_bus_buffer.scala 464:52]
  wire  _T_2273 = _T_2271 & _T_1879; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2274 = _T_2267 | _T_2273; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2275 = _T_2254 & _T_2274; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2277 = _T_2275 | buf_age_1[0]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2291 = _T_2264 & _T_1888; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2292 = _T_4499 | _T_2291; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2298 = _T_2271 & _T_1890; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2299 = _T_2292 | _T_2298; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2300 = _T_2254 & _T_2299; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2302 = _T_2300 | buf_age_1[1]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2316 = _T_2264 & _T_1899; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2317 = _T_4504 | _T_2316; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2323 = _T_2271 & _T_1901; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2324 = _T_2317 | _T_2323; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2325 = _T_2254 & _T_2324; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2327 = _T_2325 | buf_age_1[2]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2341 = _T_2264 & _T_1910; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2342 = _T_4509 | _T_2341; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2348 = _T_2271 & _T_1912; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2349 = _T_2342 | _T_2348; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2350 = _T_2254 & _T_2349; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2352 = _T_2350 | buf_age_1[3]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire [2:0] _T_2354 = {_T_2352,_T_2327,_T_2302}; // @[Cat.scala 29:58]
  wire  _T_3944 = 2'h2 == WrPtr0_r; // @[el2_lsu_bus_buffer.scala 499:117]
  wire  _T_3945 = _T_3557 & _T_3944; // @[el2_lsu_bus_buffer.scala 499:112]
  wire  _T_3947 = 2'h2 == WrPtr1_r; // @[el2_lsu_bus_buffer.scala 499:166]
  wire  _T_3948 = _T_3560 & _T_3947; // @[el2_lsu_bus_buffer.scala 499:161]
  wire  _T_3949 = _T_3945 | _T_3948; // @[el2_lsu_bus_buffer.scala 499:132]
  wire  _T_3950 = _T_853 & _T_3949; // @[el2_lsu_bus_buffer.scala 499:63]
  wire  _T_3951 = 2'h2 == ibuf_tag; // @[el2_lsu_bus_buffer.scala 499:206]
  wire  _T_3952 = ibuf_drain_vld & _T_3951; // @[el2_lsu_bus_buffer.scala 499:201]
  wire  _T_3953 = _T_3950 | _T_3952; // @[el2_lsu_bus_buffer.scala 499:183]
  wire  _T_3998 = 3'h3 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_4043 = io_lsu_axi_bid == 3'h2; // @[el2_lsu_bus_buffer.scala 524:73]
  wire  _T_4044 = bus_rsp_write & _T_4043; // @[el2_lsu_bus_buffer.scala 524:52]
  wire  _T_4045 = io_lsu_axi_rid == 3'h2; // @[el2_lsu_bus_buffer.scala 525:46]
  wire [2:0] _GEN_364 = {{1'd0}, buf_ldfwdtag_2}; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_4047 = io_lsu_axi_rid == _GEN_364; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_4048 = buf_ldfwd[2] & _T_4047; // @[el2_lsu_bus_buffer.scala 526:27]
  wire  _T_4049 = _T_4045 | _T_4048; // @[el2_lsu_bus_buffer.scala 525:77]
  wire  _T_4050 = buf_dual_2 & buf_dualhi_2; // @[el2_lsu_bus_buffer.scala 527:26]
  wire  _T_4052 = ~buf_write[2]; // @[el2_lsu_bus_buffer.scala 527:44]
  wire  _T_4053 = _T_4050 & _T_4052; // @[el2_lsu_bus_buffer.scala 527:42]
  wire  _T_4054 = _T_4053 & buf_samedw_2; // @[el2_lsu_bus_buffer.scala 527:58]
  reg [1:0] buf_dualtag_2; // @[Reg.scala 27:20]
  wire [2:0] _GEN_365 = {{1'd0}, buf_dualtag_2}; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_4055 = io_lsu_axi_rid == _GEN_365; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_4056 = _T_4054 & _T_4055; // @[el2_lsu_bus_buffer.scala 527:74]
  wire  _T_4057 = _T_4049 | _T_4056; // @[el2_lsu_bus_buffer.scala 526:71]
  wire  _T_4058 = bus_rsp_read & _T_4057; // @[el2_lsu_bus_buffer.scala 525:25]
  wire  _T_4059 = _T_4044 | _T_4058; // @[el2_lsu_bus_buffer.scala 524:105]
  wire  _GEN_194 = _T_3998 & _T_4059; // @[Conditional.scala 39:67]
  wire  _GEN_213 = _T_3964 ? 1'h0 : _GEN_194; // @[Conditional.scala 39:67]
  wire  _GEN_225 = _T_3960 ? 1'h0 : _GEN_213; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_2 = _T_3937 ? 1'h0 : _GEN_225; // @[Conditional.scala 40:58]
  wire  _T_4085 = 3'h4 == buf_state_2; // @[Conditional.scala 37:30]
  wire [3:0] _T_4095 = buf_ldfwd >> buf_dualtag_2; // @[el2_lsu_bus_buffer.scala 539:21]
  wire [1:0] _GEN_175 = 2'h1 == buf_dualtag_2 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_176 = 2'h2 == buf_dualtag_2 ? buf_ldfwdtag_2 : _GEN_175; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_177 = 2'h3 == buf_dualtag_2 ? buf_ldfwdtag_3 : _GEN_176; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [2:0] _GEN_367 = {{1'd0}, _GEN_177}; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_4097 = io_lsu_axi_rid == _GEN_367; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_4098 = _T_4095[0] & _T_4097; // @[el2_lsu_bus_buffer.scala 539:38]
  wire  _T_4099 = _T_4055 | _T_4098; // @[el2_lsu_bus_buffer.scala 538:95]
  wire  _T_4100 = bus_rsp_read & _T_4099; // @[el2_lsu_bus_buffer.scala 538:45]
  wire  _GEN_188 = _T_4085 & _T_4100; // @[Conditional.scala 39:67]
  wire  _GEN_195 = _T_3998 ? buf_resp_state_bus_en_2 : _GEN_188; // @[Conditional.scala 39:67]
  wire  _GEN_205 = _T_3964 ? buf_cmd_state_bus_en_2 : _GEN_195; // @[Conditional.scala 39:67]
  wire  _GEN_218 = _T_3960 ? 1'h0 : _GEN_205; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_2 = _T_3937 ? 1'h0 : _GEN_218; // @[Conditional.scala 40:58]
  wire  _T_3977 = buf_state_bus_en_2 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 512:49]
  wire  _T_3978 = _T_3977 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 512:70]
  wire  _T_4103 = 3'h5 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_4106 = RspPtr == 2'h2; // @[el2_lsu_bus_buffer.scala 544:37]
  wire  _T_4107 = buf_dualtag_2 == RspPtr; // @[el2_lsu_bus_buffer.scala 544:98]
  wire  _T_4108 = buf_dual_2 & _T_4107; // @[el2_lsu_bus_buffer.scala 544:80]
  wire  _T_4109 = _T_4106 | _T_4108; // @[el2_lsu_bus_buffer.scala 544:65]
  wire  _T_4110 = _T_4109 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 544:112]
  wire  _T_4111 = 3'h6 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _GEN_183 = _T_4103 ? _T_4110 : _T_4111; // @[Conditional.scala 39:67]
  wire  _GEN_189 = _T_4085 ? _T_3978 : _GEN_183; // @[Conditional.scala 39:67]
  wire  _GEN_196 = _T_3998 ? _T_3978 : _GEN_189; // @[Conditional.scala 39:67]
  wire  _GEN_206 = _T_3964 ? _T_3978 : _GEN_196; // @[Conditional.scala 39:67]
  wire  _GEN_216 = _T_3960 ? _T_3577 : _GEN_206; // @[Conditional.scala 39:67]
  wire  buf_state_en_2 = _T_3937 ? _T_3953 : _GEN_216; // @[Conditional.scala 40:58]
  wire  _T_2356 = _T_1898 & buf_state_en_2; // @[el2_lsu_bus_buffer.scala 461:94]
  wire  _T_2366 = _T_2160 & _T_1901; // @[el2_lsu_bus_buffer.scala 463:71]
  wire  _T_2368 = _T_2366 & _T_1877; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2369 = _T_4494 | _T_2368; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2373 = _T_2167 & _T_1902; // @[el2_lsu_bus_buffer.scala 464:52]
  wire  _T_2375 = _T_2373 & _T_1879; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2376 = _T_2369 | _T_2375; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2377 = _T_2356 & _T_2376; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2379 = _T_2377 | buf_age_2[0]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2393 = _T_2366 & _T_1888; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2394 = _T_4499 | _T_2393; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2400 = _T_2373 & _T_1890; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2401 = _T_2394 | _T_2400; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2402 = _T_2356 & _T_2401; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2404 = _T_2402 | buf_age_2[1]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2418 = _T_2366 & _T_1899; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2419 = _T_4504 | _T_2418; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2425 = _T_2373 & _T_1901; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2426 = _T_2419 | _T_2425; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2427 = _T_2356 & _T_2426; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2429 = _T_2427 | buf_age_2[2]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2443 = _T_2366 & _T_1910; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2444 = _T_4509 | _T_2443; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2450 = _T_2373 & _T_1912; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2451 = _T_2444 | _T_2450; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2452 = _T_2356 & _T_2451; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2454 = _T_2452 | buf_age_2[3]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire [2:0] _T_2456 = {_T_2454,_T_2429,_T_2404}; // @[Cat.scala 29:58]
  wire  _T_4137 = 2'h3 == WrPtr0_r; // @[el2_lsu_bus_buffer.scala 499:117]
  wire  _T_4138 = _T_3557 & _T_4137; // @[el2_lsu_bus_buffer.scala 499:112]
  wire  _T_4140 = 2'h3 == WrPtr1_r; // @[el2_lsu_bus_buffer.scala 499:166]
  wire  _T_4141 = _T_3560 & _T_4140; // @[el2_lsu_bus_buffer.scala 499:161]
  wire  _T_4142 = _T_4138 | _T_4141; // @[el2_lsu_bus_buffer.scala 499:132]
  wire  _T_4143 = _T_853 & _T_4142; // @[el2_lsu_bus_buffer.scala 499:63]
  wire  _T_4144 = 2'h3 == ibuf_tag; // @[el2_lsu_bus_buffer.scala 499:206]
  wire  _T_4145 = ibuf_drain_vld & _T_4144; // @[el2_lsu_bus_buffer.scala 499:201]
  wire  _T_4146 = _T_4143 | _T_4145; // @[el2_lsu_bus_buffer.scala 499:183]
  wire  _T_4191 = 3'h3 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4236 = io_lsu_axi_bid == 3'h3; // @[el2_lsu_bus_buffer.scala 524:73]
  wire  _T_4237 = bus_rsp_write & _T_4236; // @[el2_lsu_bus_buffer.scala 524:52]
  wire  _T_4238 = io_lsu_axi_rid == 3'h3; // @[el2_lsu_bus_buffer.scala 525:46]
  wire [2:0] _GEN_368 = {{1'd0}, buf_ldfwdtag_3}; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_4240 = io_lsu_axi_rid == _GEN_368; // @[el2_lsu_bus_buffer.scala 526:47]
  wire  _T_4241 = buf_ldfwd[3] & _T_4240; // @[el2_lsu_bus_buffer.scala 526:27]
  wire  _T_4242 = _T_4238 | _T_4241; // @[el2_lsu_bus_buffer.scala 525:77]
  wire  _T_4243 = buf_dual_3 & buf_dualhi_3; // @[el2_lsu_bus_buffer.scala 527:26]
  wire  _T_4245 = ~buf_write[3]; // @[el2_lsu_bus_buffer.scala 527:44]
  wire  _T_4246 = _T_4243 & _T_4245; // @[el2_lsu_bus_buffer.scala 527:42]
  wire  _T_4247 = _T_4246 & buf_samedw_3; // @[el2_lsu_bus_buffer.scala 527:58]
  reg [1:0] buf_dualtag_3; // @[Reg.scala 27:20]
  wire [2:0] _GEN_369 = {{1'd0}, buf_dualtag_3}; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_4248 = io_lsu_axi_rid == _GEN_369; // @[el2_lsu_bus_buffer.scala 527:94]
  wire  _T_4249 = _T_4247 & _T_4248; // @[el2_lsu_bus_buffer.scala 527:74]
  wire  _T_4250 = _T_4242 | _T_4249; // @[el2_lsu_bus_buffer.scala 526:71]
  wire  _T_4251 = bus_rsp_read & _T_4250; // @[el2_lsu_bus_buffer.scala 525:25]
  wire  _T_4252 = _T_4237 | _T_4251; // @[el2_lsu_bus_buffer.scala 524:105]
  wire  _GEN_270 = _T_4191 & _T_4252; // @[Conditional.scala 39:67]
  wire  _GEN_289 = _T_4157 ? 1'h0 : _GEN_270; // @[Conditional.scala 39:67]
  wire  _GEN_301 = _T_4153 ? 1'h0 : _GEN_289; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_3 = _T_4130 ? 1'h0 : _GEN_301; // @[Conditional.scala 40:58]
  wire  _T_4278 = 3'h4 == buf_state_3; // @[Conditional.scala 37:30]
  wire [3:0] _T_4288 = buf_ldfwd >> buf_dualtag_3; // @[el2_lsu_bus_buffer.scala 539:21]
  wire [1:0] _GEN_251 = 2'h1 == buf_dualtag_3 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_252 = 2'h2 == buf_dualtag_3 ? buf_ldfwdtag_2 : _GEN_251; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [1:0] _GEN_253 = 2'h3 == buf_dualtag_3 ? buf_ldfwdtag_3 : _GEN_252; // @[el2_lsu_bus_buffer.scala 539:58]
  wire [2:0] _GEN_371 = {{1'd0}, _GEN_253}; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_4290 = io_lsu_axi_rid == _GEN_371; // @[el2_lsu_bus_buffer.scala 539:58]
  wire  _T_4291 = _T_4288[0] & _T_4290; // @[el2_lsu_bus_buffer.scala 539:38]
  wire  _T_4292 = _T_4248 | _T_4291; // @[el2_lsu_bus_buffer.scala 538:95]
  wire  _T_4293 = bus_rsp_read & _T_4292; // @[el2_lsu_bus_buffer.scala 538:45]
  wire  _GEN_264 = _T_4278 & _T_4293; // @[Conditional.scala 39:67]
  wire  _GEN_271 = _T_4191 ? buf_resp_state_bus_en_3 : _GEN_264; // @[Conditional.scala 39:67]
  wire  _GEN_281 = _T_4157 ? buf_cmd_state_bus_en_3 : _GEN_271; // @[Conditional.scala 39:67]
  wire  _GEN_294 = _T_4153 ? 1'h0 : _GEN_281; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_3 = _T_4130 ? 1'h0 : _GEN_294; // @[Conditional.scala 40:58]
  wire  _T_4170 = buf_state_bus_en_3 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 512:49]
  wire  _T_4171 = _T_4170 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 512:70]
  wire  _T_4296 = 3'h5 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4299 = RspPtr == 2'h3; // @[el2_lsu_bus_buffer.scala 544:37]
  wire  _T_4300 = buf_dualtag_3 == RspPtr; // @[el2_lsu_bus_buffer.scala 544:98]
  wire  _T_4301 = buf_dual_3 & _T_4300; // @[el2_lsu_bus_buffer.scala 544:80]
  wire  _T_4302 = _T_4299 | _T_4301; // @[el2_lsu_bus_buffer.scala 544:65]
  wire  _T_4303 = _T_4302 | io_dec_tlu_force_halt; // @[el2_lsu_bus_buffer.scala 544:112]
  wire  _T_4304 = 3'h6 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _GEN_259 = _T_4296 ? _T_4303 : _T_4304; // @[Conditional.scala 39:67]
  wire  _GEN_265 = _T_4278 ? _T_4171 : _GEN_259; // @[Conditional.scala 39:67]
  wire  _GEN_272 = _T_4191 ? _T_4171 : _GEN_265; // @[Conditional.scala 39:67]
  wire  _GEN_282 = _T_4157 ? _T_4171 : _GEN_272; // @[Conditional.scala 39:67]
  wire  _GEN_292 = _T_4153 ? _T_3577 : _GEN_282; // @[Conditional.scala 39:67]
  wire  buf_state_en_3 = _T_4130 ? _T_4146 : _GEN_292; // @[Conditional.scala 40:58]
  wire  _T_2458 = _T_1909 & buf_state_en_3; // @[el2_lsu_bus_buffer.scala 461:94]
  wire  _T_2468 = _T_2160 & _T_1912; // @[el2_lsu_bus_buffer.scala 463:71]
  wire  _T_2470 = _T_2468 & _T_1877; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2471 = _T_4494 | _T_2470; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2475 = _T_2167 & _T_1913; // @[el2_lsu_bus_buffer.scala 464:52]
  wire  _T_2477 = _T_2475 & _T_1879; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2478 = _T_2471 | _T_2477; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2479 = _T_2458 & _T_2478; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2481 = _T_2479 | buf_age_3[0]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2495 = _T_2468 & _T_1888; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2496 = _T_4499 | _T_2495; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2502 = _T_2475 & _T_1890; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2503 = _T_2496 | _T_2502; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2504 = _T_2458 & _T_2503; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2506 = _T_2504 | buf_age_3[1]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2520 = _T_2468 & _T_1899; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2521 = _T_4504 | _T_2520; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2527 = _T_2475 & _T_1901; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2528 = _T_2521 | _T_2527; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2529 = _T_2458 & _T_2528; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2531 = _T_2529 | buf_age_3[2]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire  _T_2545 = _T_2468 & _T_1910; // @[el2_lsu_bus_buffer.scala 463:92]
  wire  _T_2546 = _T_4509 | _T_2545; // @[el2_lsu_bus_buffer.scala 462:86]
  wire  _T_2552 = _T_2475 & _T_1912; // @[el2_lsu_bus_buffer.scala 464:73]
  wire  _T_2553 = _T_2546 | _T_2552; // @[el2_lsu_bus_buffer.scala 463:114]
  wire  _T_2554 = _T_2458 & _T_2553; // @[el2_lsu_bus_buffer.scala 461:113]
  wire  _T_2556 = _T_2554 | buf_age_3[3]; // @[el2_lsu_bus_buffer.scala 464:97]
  wire [2:0] _T_2558 = {_T_2556,_T_2531,_T_2506}; // @[Cat.scala 29:58]
  wire  _T_2822 = buf_state_0 == 3'h6; // @[el2_lsu_bus_buffer.scala 472:49]
  wire  _T_2823 = _T_1876 | _T_2822; // @[el2_lsu_bus_buffer.scala 472:34]
  wire  _T_2824 = ~_T_2823; // @[el2_lsu_bus_buffer.scala 472:8]
  wire  _T_2832 = _T_2824 | _T_2164; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2839 = _T_2832 | _T_2171; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2840 = _T_2152 & _T_2839; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_2844 = buf_state_1 == 3'h6; // @[el2_lsu_bus_buffer.scala 472:49]
  wire  _T_2845 = _T_1887 | _T_2844; // @[el2_lsu_bus_buffer.scala 472:34]
  wire  _T_2846 = ~_T_2845; // @[el2_lsu_bus_buffer.scala 472:8]
  wire  _T_2854 = _T_2846 | _T_2189; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2861 = _T_2854 | _T_2196; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2862 = _T_2152 & _T_2861; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_2866 = buf_state_2 == 3'h6; // @[el2_lsu_bus_buffer.scala 472:49]
  wire  _T_2867 = _T_1898 | _T_2866; // @[el2_lsu_bus_buffer.scala 472:34]
  wire  _T_2868 = ~_T_2867; // @[el2_lsu_bus_buffer.scala 472:8]
  wire  _T_2876 = _T_2868 | _T_2214; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2883 = _T_2876 | _T_2221; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2884 = _T_2152 & _T_2883; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_2888 = buf_state_3 == 3'h6; // @[el2_lsu_bus_buffer.scala 472:49]
  wire  _T_2889 = _T_1909 | _T_2888; // @[el2_lsu_bus_buffer.scala 472:34]
  wire  _T_2890 = ~_T_2889; // @[el2_lsu_bus_buffer.scala 472:8]
  wire  _T_2898 = _T_2890 | _T_2239; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2905 = _T_2898 | _T_2246; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2906 = _T_2152 & _T_2905; // @[el2_lsu_bus_buffer.scala 471:114]
  wire [3:0] buf_rspage_set_0 = {_T_2906,_T_2884,_T_2862,_T_2840}; // @[Cat.scala 29:58]
  wire  _T_2923 = _T_2824 | _T_2266; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2930 = _T_2923 | _T_2273; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2931 = _T_2254 & _T_2930; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_2945 = _T_2846 | _T_2291; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2952 = _T_2945 | _T_2298; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2953 = _T_2254 & _T_2952; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_2967 = _T_2868 | _T_2316; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2974 = _T_2967 | _T_2323; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2975 = _T_2254 & _T_2974; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_2989 = _T_2890 | _T_2341; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_2996 = _T_2989 | _T_2348; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_2997 = _T_2254 & _T_2996; // @[el2_lsu_bus_buffer.scala 471:114]
  wire [3:0] buf_rspage_set_1 = {_T_2997,_T_2975,_T_2953,_T_2931}; // @[Cat.scala 29:58]
  wire  _T_3014 = _T_2824 | _T_2368; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3021 = _T_3014 | _T_2375; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3022 = _T_2356 & _T_3021; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_3036 = _T_2846 | _T_2393; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3043 = _T_3036 | _T_2400; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3044 = _T_2356 & _T_3043; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_3058 = _T_2868 | _T_2418; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3065 = _T_3058 | _T_2425; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3066 = _T_2356 & _T_3065; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_3080 = _T_2890 | _T_2443; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3087 = _T_3080 | _T_2450; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3088 = _T_2356 & _T_3087; // @[el2_lsu_bus_buffer.scala 471:114]
  wire [3:0] buf_rspage_set_2 = {_T_3088,_T_3066,_T_3044,_T_3022}; // @[Cat.scala 29:58]
  wire  _T_3105 = _T_2824 | _T_2470; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3112 = _T_3105 | _T_2477; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3113 = _T_2458 & _T_3112; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_3127 = _T_2846 | _T_2495; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3134 = _T_3127 | _T_2502; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3135 = _T_2458 & _T_3134; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_3149 = _T_2868 | _T_2520; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3156 = _T_3149 | _T_2527; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3157 = _T_2458 & _T_3156; // @[el2_lsu_bus_buffer.scala 471:114]
  wire  _T_3171 = _T_2890 | _T_2545; // @[el2_lsu_bus_buffer.scala 472:61]
  wire  _T_3178 = _T_3171 | _T_2552; // @[el2_lsu_bus_buffer.scala 473:112]
  wire  _T_3179 = _T_2458 & _T_3178; // @[el2_lsu_bus_buffer.scala 471:114]
  wire [3:0] buf_rspage_set_3 = {_T_3179,_T_3157,_T_3135,_T_3113}; // @[Cat.scala 29:58]
  wire  _T_3264 = _T_2888 | _T_1909; // @[el2_lsu_bus_buffer.scala 476:112]
  wire  _T_3265 = ~_T_3264; // @[el2_lsu_bus_buffer.scala 476:86]
  wire  _T_3266 = buf_rspageQ_0[3] & _T_3265; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3258 = _T_2866 | _T_1898; // @[el2_lsu_bus_buffer.scala 476:112]
  wire  _T_3259 = ~_T_3258; // @[el2_lsu_bus_buffer.scala 476:86]
  wire  _T_3260 = buf_rspageQ_0[2] & _T_3259; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3252 = _T_2844 | _T_1887; // @[el2_lsu_bus_buffer.scala 476:112]
  wire  _T_3253 = ~_T_3252; // @[el2_lsu_bus_buffer.scala 476:86]
  wire  _T_3254 = buf_rspageQ_0[1] & _T_3253; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3246 = _T_2822 | _T_1876; // @[el2_lsu_bus_buffer.scala 476:112]
  wire  _T_3247 = ~_T_3246; // @[el2_lsu_bus_buffer.scala 476:86]
  wire  _T_3248 = buf_rspageQ_0[0] & _T_3247; // @[el2_lsu_bus_buffer.scala 476:84]
  wire [3:0] buf_rspage_0 = {_T_3266,_T_3260,_T_3254,_T_3248}; // @[Cat.scala 29:58]
  wire  _T_3185 = buf_rspage_set_0[0] | buf_rspage_0[0]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3188 = buf_rspage_set_0[1] | buf_rspage_0[1]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3191 = buf_rspage_set_0[2] | buf_rspage_0[2]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3194 = buf_rspage_set_0[3] | buf_rspage_0[3]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire [2:0] _T_3196 = {_T_3194,_T_3191,_T_3188}; // @[Cat.scala 29:58]
  wire  _T_3293 = buf_rspageQ_1[3] & _T_3265; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3287 = buf_rspageQ_1[2] & _T_3259; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3281 = buf_rspageQ_1[1] & _T_3253; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3275 = buf_rspageQ_1[0] & _T_3247; // @[el2_lsu_bus_buffer.scala 476:84]
  wire [3:0] buf_rspage_1 = {_T_3293,_T_3287,_T_3281,_T_3275}; // @[Cat.scala 29:58]
  wire  _T_3200 = buf_rspage_set_1[0] | buf_rspage_1[0]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3203 = buf_rspage_set_1[1] | buf_rspage_1[1]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3206 = buf_rspage_set_1[2] | buf_rspage_1[2]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3209 = buf_rspage_set_1[3] | buf_rspage_1[3]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire [2:0] _T_3211 = {_T_3209,_T_3206,_T_3203}; // @[Cat.scala 29:58]
  wire  _T_3320 = buf_rspageQ_2[3] & _T_3265; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3314 = buf_rspageQ_2[2] & _T_3259; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3308 = buf_rspageQ_2[1] & _T_3253; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3302 = buf_rspageQ_2[0] & _T_3247; // @[el2_lsu_bus_buffer.scala 476:84]
  wire [3:0] buf_rspage_2 = {_T_3320,_T_3314,_T_3308,_T_3302}; // @[Cat.scala 29:58]
  wire  _T_3215 = buf_rspage_set_2[0] | buf_rspage_2[0]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3218 = buf_rspage_set_2[1] | buf_rspage_2[1]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3221 = buf_rspage_set_2[2] | buf_rspage_2[2]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3224 = buf_rspage_set_2[3] | buf_rspage_2[3]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire [2:0] _T_3226 = {_T_3224,_T_3221,_T_3218}; // @[Cat.scala 29:58]
  wire  _T_3347 = buf_rspageQ_3[3] & _T_3265; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3341 = buf_rspageQ_3[2] & _T_3259; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3335 = buf_rspageQ_3[1] & _T_3253; // @[el2_lsu_bus_buffer.scala 476:84]
  wire  _T_3329 = buf_rspageQ_3[0] & _T_3247; // @[el2_lsu_bus_buffer.scala 476:84]
  wire [3:0] buf_rspage_3 = {_T_3347,_T_3341,_T_3335,_T_3329}; // @[Cat.scala 29:58]
  wire  _T_3230 = buf_rspage_set_3[0] | buf_rspage_3[0]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3233 = buf_rspage_set_3[1] | buf_rspage_3[1]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3236 = buf_rspage_set_3[2] | buf_rspage_3[2]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire  _T_3239 = buf_rspage_set_3[3] | buf_rspage_3[3]; // @[el2_lsu_bus_buffer.scala 475:90]
  wire [2:0] _T_3241 = {_T_3239,_T_3236,_T_3233}; // @[Cat.scala 29:58]
  wire  _T_3352 = ibuf_drain_vld & _T_1877; // @[el2_lsu_bus_buffer.scala 481:65]
  wire  _T_3354 = ibuf_drain_vld & _T_1888; // @[el2_lsu_bus_buffer.scala 481:65]
  wire  _T_3356 = ibuf_drain_vld & _T_1899; // @[el2_lsu_bus_buffer.scala 481:65]
  wire  _T_3358 = ibuf_drain_vld & _T_1910; // @[el2_lsu_bus_buffer.scala 481:65]
  wire [3:0] ibuf_drainvec_vld = {_T_3358,_T_3356,_T_3354,_T_3352}; // @[Cat.scala 29:58]
  wire  _T_3366 = _T_3560 & _T_1880; // @[el2_lsu_bus_buffer.scala 483:37]
  wire  _T_3375 = _T_3560 & _T_1891; // @[el2_lsu_bus_buffer.scala 483:37]
  wire  _T_3384 = _T_3560 & _T_1902; // @[el2_lsu_bus_buffer.scala 483:37]
  wire  _T_3393 = _T_3560 & _T_1913; // @[el2_lsu_bus_buffer.scala 483:37]
  wire  _T_3423 = ibuf_drainvec_vld[0] ? ibuf_dual : io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 485:47]
  wire  _T_3425 = ibuf_drainvec_vld[1] ? ibuf_dual : io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 485:47]
  wire  _T_3427 = ibuf_drainvec_vld[2] ? ibuf_dual : io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 485:47]
  wire  _T_3429 = ibuf_drainvec_vld[3] ? ibuf_dual : io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 485:47]
  wire [3:0] buf_dual_in = {_T_3429,_T_3427,_T_3425,_T_3423}; // @[Cat.scala 29:58]
  wire  _T_3434 = ibuf_drainvec_vld[0] ? ibuf_samedw : ldst_samedw_r; // @[el2_lsu_bus_buffer.scala 486:49]
  wire  _T_3436 = ibuf_drainvec_vld[1] ? ibuf_samedw : ldst_samedw_r; // @[el2_lsu_bus_buffer.scala 486:49]
  wire  _T_3438 = ibuf_drainvec_vld[2] ? ibuf_samedw : ldst_samedw_r; // @[el2_lsu_bus_buffer.scala 486:49]
  wire  _T_3440 = ibuf_drainvec_vld[3] ? ibuf_samedw : ldst_samedw_r; // @[el2_lsu_bus_buffer.scala 486:49]
  wire [3:0] buf_samedw_in = {_T_3440,_T_3438,_T_3436,_T_3434}; // @[Cat.scala 29:58]
  wire  _T_3445 = ibuf_nomerge | ibuf_force_drain; // @[el2_lsu_bus_buffer.scala 487:86]
  wire  _T_3446 = ibuf_drainvec_vld[0] ? _T_3445 : io_no_dword_merge_r; // @[el2_lsu_bus_buffer.scala 487:50]
  wire  _T_3449 = ibuf_drainvec_vld[1] ? _T_3445 : io_no_dword_merge_r; // @[el2_lsu_bus_buffer.scala 487:50]
  wire  _T_3452 = ibuf_drainvec_vld[2] ? _T_3445 : io_no_dword_merge_r; // @[el2_lsu_bus_buffer.scala 487:50]
  wire  _T_3455 = ibuf_drainvec_vld[3] ? _T_3445 : io_no_dword_merge_r; // @[el2_lsu_bus_buffer.scala 487:50]
  wire [3:0] buf_nomerge_in = {_T_3455,_T_3452,_T_3449,_T_3446}; // @[Cat.scala 29:58]
  wire  _T_3463 = ibuf_drainvec_vld[0] ? ibuf_dual : _T_3366; // @[el2_lsu_bus_buffer.scala 488:49]
  wire  _T_3468 = ibuf_drainvec_vld[1] ? ibuf_dual : _T_3375; // @[el2_lsu_bus_buffer.scala 488:49]
  wire  _T_3473 = ibuf_drainvec_vld[2] ? ibuf_dual : _T_3384; // @[el2_lsu_bus_buffer.scala 488:49]
  wire  _T_3478 = ibuf_drainvec_vld[3] ? ibuf_dual : _T_3393; // @[el2_lsu_bus_buffer.scala 488:49]
  wire [3:0] buf_dualhi_in = {_T_3478,_T_3473,_T_3468,_T_3463}; // @[Cat.scala 29:58]
  wire  _T_3507 = ibuf_drainvec_vld[0] ? ibuf_sideeffect : io_is_sideeffects_r; // @[el2_lsu_bus_buffer.scala 490:53]
  wire  _T_3509 = ibuf_drainvec_vld[1] ? ibuf_sideeffect : io_is_sideeffects_r; // @[el2_lsu_bus_buffer.scala 490:53]
  wire  _T_3511 = ibuf_drainvec_vld[2] ? ibuf_sideeffect : io_is_sideeffects_r; // @[el2_lsu_bus_buffer.scala 490:53]
  wire  _T_3513 = ibuf_drainvec_vld[3] ? ibuf_sideeffect : io_is_sideeffects_r; // @[el2_lsu_bus_buffer.scala 490:53]
  wire [3:0] buf_sideeffect_in = {_T_3513,_T_3511,_T_3509,_T_3507}; // @[Cat.scala 29:58]
  wire  _T_3518 = ibuf_drainvec_vld[0] ? ibuf_unsign : io_lsu_pkt_r_unsign; // @[el2_lsu_bus_buffer.scala 491:49]
  wire  _T_3520 = ibuf_drainvec_vld[1] ? ibuf_unsign : io_lsu_pkt_r_unsign; // @[el2_lsu_bus_buffer.scala 491:49]
  wire  _T_3522 = ibuf_drainvec_vld[2] ? ibuf_unsign : io_lsu_pkt_r_unsign; // @[el2_lsu_bus_buffer.scala 491:49]
  wire  _T_3524 = ibuf_drainvec_vld[3] ? ibuf_unsign : io_lsu_pkt_r_unsign; // @[el2_lsu_bus_buffer.scala 491:49]
  wire [3:0] buf_unsign_in = {_T_3524,_T_3522,_T_3520,_T_3518}; // @[Cat.scala 29:58]
  wire  _T_3541 = ibuf_drainvec_vld[0] ? ibuf_write : io_lsu_pkt_r_store; // @[el2_lsu_bus_buffer.scala 493:48]
  wire  _T_3543 = ibuf_drainvec_vld[1] ? ibuf_write : io_lsu_pkt_r_store; // @[el2_lsu_bus_buffer.scala 493:48]
  wire  _T_3545 = ibuf_drainvec_vld[2] ? ibuf_write : io_lsu_pkt_r_store; // @[el2_lsu_bus_buffer.scala 493:48]
  wire  _T_3547 = ibuf_drainvec_vld[3] ? ibuf_write : io_lsu_pkt_r_store; // @[el2_lsu_bus_buffer.scala 493:48]
  wire [3:0] buf_write_in = {_T_3547,_T_3545,_T_3543,_T_3541}; // @[Cat.scala 29:58]
  wire  _T_3580 = obuf_nosend & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 509:89]
  wire  _T_3582 = _T_3580 & _T_1374; // @[el2_lsu_bus_buffer.scala 509:104]
  wire  _T_3595 = buf_state_en_0 & _T_3666; // @[el2_lsu_bus_buffer.scala 514:44]
  wire  _T_3596 = _T_3595 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 514:60]
  wire  _T_3598 = _T_3596 & _T_1356; // @[el2_lsu_bus_buffer.scala 514:74]
  wire  _T_3601 = _T_3591 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 516:67]
  wire  _T_3602 = _T_3601 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 516:81]
  wire  _T_4892 = io_lsu_axi_bresp != 2'h0; // @[el2_lsu_bus_buffer.scala 620:58]
  wire  bus_rsp_read_error = bus_rsp_read & _T_4892; // @[el2_lsu_bus_buffer.scala 620:38]
  wire  _T_3605 = _T_3601 & bus_rsp_read_error; // @[el2_lsu_bus_buffer.scala 517:82]
  wire  _T_3680 = bus_rsp_read_error & _T_3659; // @[el2_lsu_bus_buffer.scala 531:91]
  wire  _T_3682 = bus_rsp_read_error & buf_ldfwd[0]; // @[el2_lsu_bus_buffer.scala 532:31]
  wire  _T_3684 = _T_3682 & _T_3661; // @[el2_lsu_bus_buffer.scala 532:46]
  wire  _T_3685 = _T_3680 | _T_3684; // @[el2_lsu_bus_buffer.scala 531:143]
  wire  bus_rsp_write_error = bus_rsp_write & _T_4892; // @[el2_lsu_bus_buffer.scala 619:40]
  wire  _T_3688 = bus_rsp_write_error & _T_3657; // @[el2_lsu_bus_buffer.scala 533:53]
  wire  _T_3689 = _T_3685 | _T_3688; // @[el2_lsu_bus_buffer.scala 532:88]
  wire  _T_3690 = _T_3591 & _T_3689; // @[el2_lsu_bus_buffer.scala 531:68]
  wire  _GEN_46 = _T_3612 & _T_3690; // @[Conditional.scala 39:67]
  wire  _GEN_59 = _T_3578 ? _T_3605 : _GEN_46; // @[Conditional.scala 39:67]
  wire  _GEN_71 = _T_3574 ? 1'h0 : _GEN_59; // @[Conditional.scala 39:67]
  wire  buf_error_en_0 = _T_3551 ? 1'h0 : _GEN_71; // @[Conditional.scala 40:58]
  wire  _T_3615 = ~bus_rsp_write_error; // @[el2_lsu_bus_buffer.scala 521:73]
  wire  _T_3616 = buf_write[0] & _T_3615; // @[el2_lsu_bus_buffer.scala 521:71]
  wire  _T_3617 = io_dec_tlu_force_halt | _T_3616; // @[el2_lsu_bus_buffer.scala 521:55]
  wire  _T_3619 = ~buf_samedw_0; // @[el2_lsu_bus_buffer.scala 522:30]
  wire  _T_3620 = buf_dual_0 & _T_3619; // @[el2_lsu_bus_buffer.scala 522:28]
  wire  _T_3623 = _T_3620 & _T_3666; // @[el2_lsu_bus_buffer.scala 522:45]
  wire [2:0] _GEN_19 = 2'h1 == buf_dualtag_0 ? buf_state_1 : buf_state_0; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_20 = 2'h2 == buf_dualtag_0 ? buf_state_2 : _GEN_19; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_21 = 2'h3 == buf_dualtag_0 ? buf_state_3 : _GEN_20; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_3624 = _GEN_21 != 3'h4; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_3625 = _T_3623 & _T_3624; // @[el2_lsu_bus_buffer.scala 522:61]
  wire  _T_4517 = _T_2769 | _T_2766; // @[el2_lsu_bus_buffer.scala 580:93]
  wire  _T_4518 = _T_4517 | _T_2763; // @[el2_lsu_bus_buffer.scala 580:93]
  wire  any_done_wait_state = _T_4518 | _T_2760; // @[el2_lsu_bus_buffer.scala 580:93]
  wire  _T_3627 = buf_ldfwd[0] | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:31]
  wire  _T_3633 = buf_dualtag_0 == 2'h0; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3635 = buf_dualtag_0 == 2'h1; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3637 = buf_dualtag_0 == 2'h2; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3639 = buf_dualtag_0 == 2'h3; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3641 = _T_3633 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_3642 = _T_3635 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_3643 = _T_3637 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_3644 = _T_3639 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_3645 = _T_3641 | _T_3642; // @[Mux.scala 27:72]
  wire  _T_3646 = _T_3645 | _T_3643; // @[Mux.scala 27:72]
  wire  _T_3647 = _T_3646 | _T_3644; // @[Mux.scala 27:72]
  wire  _T_3649 = _T_3623 & _T_3647; // @[el2_lsu_bus_buffer.scala 523:101]
  wire  _T_3650 = _GEN_21 == 3'h4; // @[el2_lsu_bus_buffer.scala 523:167]
  wire  _T_3651 = _T_3649 & _T_3650; // @[el2_lsu_bus_buffer.scala 523:138]
  wire  _T_3652 = _T_3651 & any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:187]
  wire  _T_3653 = _T_3627 | _T_3652; // @[el2_lsu_bus_buffer.scala 523:53]
  wire  _T_3676 = buf_state_bus_en_0 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 530:47]
  wire  _T_3677 = _T_3676 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 530:62]
  wire  _T_3691 = ~buf_error_en_0; // @[el2_lsu_bus_buffer.scala 534:50]
  wire  _T_3692 = buf_state_en_0 & _T_3691; // @[el2_lsu_bus_buffer.scala 534:48]
  wire  _T_3704 = buf_ldfwd[0] | _T_3709[0]; // @[el2_lsu_bus_buffer.scala 537:90]
  wire  _T_3705 = _T_3704 | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 537:118]
  wire  _GEN_29 = _T_3725 & buf_state_en_0; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_3717 ? 1'h0 : _T_3725; // @[Conditional.scala 39:67]
  wire  _GEN_34 = _T_3717 ? 1'h0 : _GEN_29; // @[Conditional.scala 39:67]
  wire  _GEN_38 = _T_3699 ? 1'h0 : _GEN_32; // @[Conditional.scala 39:67]
  wire  _GEN_40 = _T_3699 ? 1'h0 : _GEN_34; // @[Conditional.scala 39:67]
  wire  _GEN_45 = _T_3612 & _T_3677; // @[Conditional.scala 39:67]
  wire  _GEN_48 = _T_3612 ? 1'h0 : _GEN_38; // @[Conditional.scala 39:67]
  wire  _GEN_50 = _T_3612 ? 1'h0 : _GEN_40; // @[Conditional.scala 39:67]
  wire  _GEN_56 = _T_3578 ? _T_3598 : _GEN_50; // @[Conditional.scala 39:67]
  wire  _GEN_58 = _T_3578 ? _T_3602 : _GEN_45; // @[Conditional.scala 39:67]
  wire  _GEN_62 = _T_3578 ? 1'h0 : _GEN_48; // @[Conditional.scala 39:67]
  wire  _GEN_68 = _T_3574 ? 1'h0 : _GEN_56; // @[Conditional.scala 39:67]
  wire  _GEN_70 = _T_3574 ? 1'h0 : _GEN_58; // @[Conditional.scala 39:67]
  wire  _GEN_74 = _T_3574 ? 1'h0 : _GEN_62; // @[Conditional.scala 39:67]
  wire  buf_wr_en_0 = _T_3551 & buf_state_en_0; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_0 = _T_3551 ? 1'h0 : _GEN_68; // @[Conditional.scala 40:58]
  wire  buf_rst_0 = _T_3551 ? 1'h0 : _GEN_74; // @[Conditional.scala 40:58]
  wire  _T_3788 = buf_state_en_1 & _T_3859; // @[el2_lsu_bus_buffer.scala 514:44]
  wire  _T_3789 = _T_3788 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 514:60]
  wire  _T_3791 = _T_3789 & _T_1356; // @[el2_lsu_bus_buffer.scala 514:74]
  wire  _T_3794 = _T_3784 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 516:67]
  wire  _T_3795 = _T_3794 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 516:81]
  wire  _T_3798 = _T_3794 & bus_rsp_read_error; // @[el2_lsu_bus_buffer.scala 517:82]
  wire  _T_3873 = bus_rsp_read_error & _T_3852; // @[el2_lsu_bus_buffer.scala 531:91]
  wire  _T_3875 = bus_rsp_read_error & buf_ldfwd[1]; // @[el2_lsu_bus_buffer.scala 532:31]
  wire  _T_3877 = _T_3875 & _T_3854; // @[el2_lsu_bus_buffer.scala 532:46]
  wire  _T_3878 = _T_3873 | _T_3877; // @[el2_lsu_bus_buffer.scala 531:143]
  wire  _T_3881 = bus_rsp_write_error & _T_3850; // @[el2_lsu_bus_buffer.scala 533:53]
  wire  _T_3882 = _T_3878 | _T_3881; // @[el2_lsu_bus_buffer.scala 532:88]
  wire  _T_3883 = _T_3784 & _T_3882; // @[el2_lsu_bus_buffer.scala 531:68]
  wire  _GEN_122 = _T_3805 & _T_3883; // @[Conditional.scala 39:67]
  wire  _GEN_135 = _T_3771 ? _T_3798 : _GEN_122; // @[Conditional.scala 39:67]
  wire  _GEN_147 = _T_3767 ? 1'h0 : _GEN_135; // @[Conditional.scala 39:67]
  wire  buf_error_en_1 = _T_3744 ? 1'h0 : _GEN_147; // @[Conditional.scala 40:58]
  wire  _T_3809 = buf_write[1] & _T_3615; // @[el2_lsu_bus_buffer.scala 521:71]
  wire  _T_3810 = io_dec_tlu_force_halt | _T_3809; // @[el2_lsu_bus_buffer.scala 521:55]
  wire  _T_3812 = ~buf_samedw_1; // @[el2_lsu_bus_buffer.scala 522:30]
  wire  _T_3813 = buf_dual_1 & _T_3812; // @[el2_lsu_bus_buffer.scala 522:28]
  wire  _T_3816 = _T_3813 & _T_3859; // @[el2_lsu_bus_buffer.scala 522:45]
  wire [2:0] _GEN_95 = 2'h1 == buf_dualtag_1 ? buf_state_1 : buf_state_0; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_96 = 2'h2 == buf_dualtag_1 ? buf_state_2 : _GEN_95; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_97 = 2'h3 == buf_dualtag_1 ? buf_state_3 : _GEN_96; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_3817 = _GEN_97 != 3'h4; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_3818 = _T_3816 & _T_3817; // @[el2_lsu_bus_buffer.scala 522:61]
  wire  _T_3820 = buf_ldfwd[1] | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:31]
  wire  _T_3826 = buf_dualtag_1 == 2'h0; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3828 = buf_dualtag_1 == 2'h1; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3830 = buf_dualtag_1 == 2'h2; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3832 = buf_dualtag_1 == 2'h3; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_3834 = _T_3826 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_3835 = _T_3828 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_3836 = _T_3830 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_3837 = _T_3832 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_3838 = _T_3834 | _T_3835; // @[Mux.scala 27:72]
  wire  _T_3839 = _T_3838 | _T_3836; // @[Mux.scala 27:72]
  wire  _T_3840 = _T_3839 | _T_3837; // @[Mux.scala 27:72]
  wire  _T_3842 = _T_3816 & _T_3840; // @[el2_lsu_bus_buffer.scala 523:101]
  wire  _T_3843 = _GEN_97 == 3'h4; // @[el2_lsu_bus_buffer.scala 523:167]
  wire  _T_3844 = _T_3842 & _T_3843; // @[el2_lsu_bus_buffer.scala 523:138]
  wire  _T_3845 = _T_3844 & any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:187]
  wire  _T_3846 = _T_3820 | _T_3845; // @[el2_lsu_bus_buffer.scala 523:53]
  wire  _T_3869 = buf_state_bus_en_1 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 530:47]
  wire  _T_3870 = _T_3869 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 530:62]
  wire  _T_3884 = ~buf_error_en_1; // @[el2_lsu_bus_buffer.scala 534:50]
  wire  _T_3885 = buf_state_en_1 & _T_3884; // @[el2_lsu_bus_buffer.scala 534:48]
  wire  _T_3897 = buf_ldfwd[1] | _T_3902[0]; // @[el2_lsu_bus_buffer.scala 537:90]
  wire  _T_3898 = _T_3897 | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 537:118]
  wire  _GEN_105 = _T_3918 & buf_state_en_1; // @[Conditional.scala 39:67]
  wire  _GEN_108 = _T_3910 ? 1'h0 : _T_3918; // @[Conditional.scala 39:67]
  wire  _GEN_110 = _T_3910 ? 1'h0 : _GEN_105; // @[Conditional.scala 39:67]
  wire  _GEN_114 = _T_3892 ? 1'h0 : _GEN_108; // @[Conditional.scala 39:67]
  wire  _GEN_116 = _T_3892 ? 1'h0 : _GEN_110; // @[Conditional.scala 39:67]
  wire  _GEN_121 = _T_3805 & _T_3870; // @[Conditional.scala 39:67]
  wire  _GEN_124 = _T_3805 ? 1'h0 : _GEN_114; // @[Conditional.scala 39:67]
  wire  _GEN_126 = _T_3805 ? 1'h0 : _GEN_116; // @[Conditional.scala 39:67]
  wire  _GEN_132 = _T_3771 ? _T_3791 : _GEN_126; // @[Conditional.scala 39:67]
  wire  _GEN_134 = _T_3771 ? _T_3795 : _GEN_121; // @[Conditional.scala 39:67]
  wire  _GEN_138 = _T_3771 ? 1'h0 : _GEN_124; // @[Conditional.scala 39:67]
  wire  _GEN_144 = _T_3767 ? 1'h0 : _GEN_132; // @[Conditional.scala 39:67]
  wire  _GEN_146 = _T_3767 ? 1'h0 : _GEN_134; // @[Conditional.scala 39:67]
  wire  _GEN_150 = _T_3767 ? 1'h0 : _GEN_138; // @[Conditional.scala 39:67]
  wire  buf_wr_en_1 = _T_3744 & buf_state_en_1; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_1 = _T_3744 ? 1'h0 : _GEN_144; // @[Conditional.scala 40:58]
  wire  buf_rst_1 = _T_3744 ? 1'h0 : _GEN_150; // @[Conditional.scala 40:58]
  wire  _T_3981 = buf_state_en_2 & _T_4052; // @[el2_lsu_bus_buffer.scala 514:44]
  wire  _T_3982 = _T_3981 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 514:60]
  wire  _T_3984 = _T_3982 & _T_1356; // @[el2_lsu_bus_buffer.scala 514:74]
  wire  _T_3987 = _T_3977 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 516:67]
  wire  _T_3988 = _T_3987 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 516:81]
  wire  _T_3991 = _T_3987 & bus_rsp_read_error; // @[el2_lsu_bus_buffer.scala 517:82]
  wire  _T_4066 = bus_rsp_read_error & _T_4045; // @[el2_lsu_bus_buffer.scala 531:91]
  wire  _T_4068 = bus_rsp_read_error & buf_ldfwd[2]; // @[el2_lsu_bus_buffer.scala 532:31]
  wire  _T_4070 = _T_4068 & _T_4047; // @[el2_lsu_bus_buffer.scala 532:46]
  wire  _T_4071 = _T_4066 | _T_4070; // @[el2_lsu_bus_buffer.scala 531:143]
  wire  _T_4074 = bus_rsp_write_error & _T_4043; // @[el2_lsu_bus_buffer.scala 533:53]
  wire  _T_4075 = _T_4071 | _T_4074; // @[el2_lsu_bus_buffer.scala 532:88]
  wire  _T_4076 = _T_3977 & _T_4075; // @[el2_lsu_bus_buffer.scala 531:68]
  wire  _GEN_198 = _T_3998 & _T_4076; // @[Conditional.scala 39:67]
  wire  _GEN_211 = _T_3964 ? _T_3991 : _GEN_198; // @[Conditional.scala 39:67]
  wire  _GEN_223 = _T_3960 ? 1'h0 : _GEN_211; // @[Conditional.scala 39:67]
  wire  buf_error_en_2 = _T_3937 ? 1'h0 : _GEN_223; // @[Conditional.scala 40:58]
  wire  _T_4002 = buf_write[2] & _T_3615; // @[el2_lsu_bus_buffer.scala 521:71]
  wire  _T_4003 = io_dec_tlu_force_halt | _T_4002; // @[el2_lsu_bus_buffer.scala 521:55]
  wire  _T_4005 = ~buf_samedw_2; // @[el2_lsu_bus_buffer.scala 522:30]
  wire  _T_4006 = buf_dual_2 & _T_4005; // @[el2_lsu_bus_buffer.scala 522:28]
  wire  _T_4009 = _T_4006 & _T_4052; // @[el2_lsu_bus_buffer.scala 522:45]
  wire [2:0] _GEN_171 = 2'h1 == buf_dualtag_2 ? buf_state_1 : buf_state_0; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_172 = 2'h2 == buf_dualtag_2 ? buf_state_2 : _GEN_171; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_173 = 2'h3 == buf_dualtag_2 ? buf_state_3 : _GEN_172; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_4010 = _GEN_173 != 3'h4; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_4011 = _T_4009 & _T_4010; // @[el2_lsu_bus_buffer.scala 522:61]
  wire  _T_4013 = buf_ldfwd[2] | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:31]
  wire  _T_4019 = buf_dualtag_2 == 2'h0; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4021 = buf_dualtag_2 == 2'h1; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4023 = buf_dualtag_2 == 2'h2; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4025 = buf_dualtag_2 == 2'h3; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4027 = _T_4019 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_4028 = _T_4021 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_4029 = _T_4023 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_4030 = _T_4025 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_4031 = _T_4027 | _T_4028; // @[Mux.scala 27:72]
  wire  _T_4032 = _T_4031 | _T_4029; // @[Mux.scala 27:72]
  wire  _T_4033 = _T_4032 | _T_4030; // @[Mux.scala 27:72]
  wire  _T_4035 = _T_4009 & _T_4033; // @[el2_lsu_bus_buffer.scala 523:101]
  wire  _T_4036 = _GEN_173 == 3'h4; // @[el2_lsu_bus_buffer.scala 523:167]
  wire  _T_4037 = _T_4035 & _T_4036; // @[el2_lsu_bus_buffer.scala 523:138]
  wire  _T_4038 = _T_4037 & any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:187]
  wire  _T_4039 = _T_4013 | _T_4038; // @[el2_lsu_bus_buffer.scala 523:53]
  wire  _T_4062 = buf_state_bus_en_2 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 530:47]
  wire  _T_4063 = _T_4062 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 530:62]
  wire  _T_4077 = ~buf_error_en_2; // @[el2_lsu_bus_buffer.scala 534:50]
  wire  _T_4078 = buf_state_en_2 & _T_4077; // @[el2_lsu_bus_buffer.scala 534:48]
  wire  _T_4090 = buf_ldfwd[2] | _T_4095[0]; // @[el2_lsu_bus_buffer.scala 537:90]
  wire  _T_4091 = _T_4090 | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 537:118]
  wire  _GEN_181 = _T_4111 & buf_state_en_2; // @[Conditional.scala 39:67]
  wire  _GEN_184 = _T_4103 ? 1'h0 : _T_4111; // @[Conditional.scala 39:67]
  wire  _GEN_186 = _T_4103 ? 1'h0 : _GEN_181; // @[Conditional.scala 39:67]
  wire  _GEN_190 = _T_4085 ? 1'h0 : _GEN_184; // @[Conditional.scala 39:67]
  wire  _GEN_192 = _T_4085 ? 1'h0 : _GEN_186; // @[Conditional.scala 39:67]
  wire  _GEN_197 = _T_3998 & _T_4063; // @[Conditional.scala 39:67]
  wire  _GEN_200 = _T_3998 ? 1'h0 : _GEN_190; // @[Conditional.scala 39:67]
  wire  _GEN_202 = _T_3998 ? 1'h0 : _GEN_192; // @[Conditional.scala 39:67]
  wire  _GEN_208 = _T_3964 ? _T_3984 : _GEN_202; // @[Conditional.scala 39:67]
  wire  _GEN_210 = _T_3964 ? _T_3988 : _GEN_197; // @[Conditional.scala 39:67]
  wire  _GEN_214 = _T_3964 ? 1'h0 : _GEN_200; // @[Conditional.scala 39:67]
  wire  _GEN_220 = _T_3960 ? 1'h0 : _GEN_208; // @[Conditional.scala 39:67]
  wire  _GEN_222 = _T_3960 ? 1'h0 : _GEN_210; // @[Conditional.scala 39:67]
  wire  _GEN_226 = _T_3960 ? 1'h0 : _GEN_214; // @[Conditional.scala 39:67]
  wire  buf_wr_en_2 = _T_3937 & buf_state_en_2; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_2 = _T_3937 ? 1'h0 : _GEN_220; // @[Conditional.scala 40:58]
  wire  buf_rst_2 = _T_3937 ? 1'h0 : _GEN_226; // @[Conditional.scala 40:58]
  wire  _T_4174 = buf_state_en_3 & _T_4245; // @[el2_lsu_bus_buffer.scala 514:44]
  wire  _T_4175 = _T_4174 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 514:60]
  wire  _T_4177 = _T_4175 & _T_1356; // @[el2_lsu_bus_buffer.scala 514:74]
  wire  _T_4180 = _T_4170 & obuf_nosend; // @[el2_lsu_bus_buffer.scala 516:67]
  wire  _T_4181 = _T_4180 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 516:81]
  wire  _T_4184 = _T_4180 & bus_rsp_read_error; // @[el2_lsu_bus_buffer.scala 517:82]
  wire  _T_4259 = bus_rsp_read_error & _T_4238; // @[el2_lsu_bus_buffer.scala 531:91]
  wire  _T_4261 = bus_rsp_read_error & buf_ldfwd[3]; // @[el2_lsu_bus_buffer.scala 532:31]
  wire  _T_4263 = _T_4261 & _T_4240; // @[el2_lsu_bus_buffer.scala 532:46]
  wire  _T_4264 = _T_4259 | _T_4263; // @[el2_lsu_bus_buffer.scala 531:143]
  wire  _T_4267 = bus_rsp_write_error & _T_4236; // @[el2_lsu_bus_buffer.scala 533:53]
  wire  _T_4268 = _T_4264 | _T_4267; // @[el2_lsu_bus_buffer.scala 532:88]
  wire  _T_4269 = _T_4170 & _T_4268; // @[el2_lsu_bus_buffer.scala 531:68]
  wire  _GEN_274 = _T_4191 & _T_4269; // @[Conditional.scala 39:67]
  wire  _GEN_287 = _T_4157 ? _T_4184 : _GEN_274; // @[Conditional.scala 39:67]
  wire  _GEN_299 = _T_4153 ? 1'h0 : _GEN_287; // @[Conditional.scala 39:67]
  wire  buf_error_en_3 = _T_4130 ? 1'h0 : _GEN_299; // @[Conditional.scala 40:58]
  wire  _T_4195 = buf_write[3] & _T_3615; // @[el2_lsu_bus_buffer.scala 521:71]
  wire  _T_4196 = io_dec_tlu_force_halt | _T_4195; // @[el2_lsu_bus_buffer.scala 521:55]
  wire  _T_4198 = ~buf_samedw_3; // @[el2_lsu_bus_buffer.scala 522:30]
  wire  _T_4199 = buf_dual_3 & _T_4198; // @[el2_lsu_bus_buffer.scala 522:28]
  wire  _T_4202 = _T_4199 & _T_4245; // @[el2_lsu_bus_buffer.scala 522:45]
  wire [2:0] _GEN_247 = 2'h1 == buf_dualtag_3 ? buf_state_1 : buf_state_0; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_248 = 2'h2 == buf_dualtag_3 ? buf_state_2 : _GEN_247; // @[el2_lsu_bus_buffer.scala 522:90]
  wire [2:0] _GEN_249 = 2'h3 == buf_dualtag_3 ? buf_state_3 : _GEN_248; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_4203 = _GEN_249 != 3'h4; // @[el2_lsu_bus_buffer.scala 522:90]
  wire  _T_4204 = _T_4202 & _T_4203; // @[el2_lsu_bus_buffer.scala 522:61]
  wire  _T_4206 = buf_ldfwd[3] | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:31]
  wire  _T_4212 = buf_dualtag_3 == 2'h0; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4214 = buf_dualtag_3 == 2'h1; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4216 = buf_dualtag_3 == 2'h2; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4218 = buf_dualtag_3 == 2'h3; // @[el2_lsu_bus_buffer.scala 111:118]
  wire  _T_4220 = _T_4212 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_4221 = _T_4214 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_4222 = _T_4216 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_4223 = _T_4218 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_4224 = _T_4220 | _T_4221; // @[Mux.scala 27:72]
  wire  _T_4225 = _T_4224 | _T_4222; // @[Mux.scala 27:72]
  wire  _T_4226 = _T_4225 | _T_4223; // @[Mux.scala 27:72]
  wire  _T_4228 = _T_4202 & _T_4226; // @[el2_lsu_bus_buffer.scala 523:101]
  wire  _T_4229 = _GEN_249 == 3'h4; // @[el2_lsu_bus_buffer.scala 523:167]
  wire  _T_4230 = _T_4228 & _T_4229; // @[el2_lsu_bus_buffer.scala 523:138]
  wire  _T_4231 = _T_4230 & any_done_wait_state; // @[el2_lsu_bus_buffer.scala 523:187]
  wire  _T_4232 = _T_4206 | _T_4231; // @[el2_lsu_bus_buffer.scala 523:53]
  wire  _T_4255 = buf_state_bus_en_3 & bus_rsp_read; // @[el2_lsu_bus_buffer.scala 530:47]
  wire  _T_4256 = _T_4255 & io_lsu_bus_clk_en; // @[el2_lsu_bus_buffer.scala 530:62]
  wire  _T_4270 = ~buf_error_en_3; // @[el2_lsu_bus_buffer.scala 534:50]
  wire  _T_4271 = buf_state_en_3 & _T_4270; // @[el2_lsu_bus_buffer.scala 534:48]
  wire  _T_4283 = buf_ldfwd[3] | _T_4288[0]; // @[el2_lsu_bus_buffer.scala 537:90]
  wire  _T_4284 = _T_4283 | any_done_wait_state; // @[el2_lsu_bus_buffer.scala 537:118]
  wire  _GEN_257 = _T_4304 & buf_state_en_3; // @[Conditional.scala 39:67]
  wire  _GEN_260 = _T_4296 ? 1'h0 : _T_4304; // @[Conditional.scala 39:67]
  wire  _GEN_262 = _T_4296 ? 1'h0 : _GEN_257; // @[Conditional.scala 39:67]
  wire  _GEN_266 = _T_4278 ? 1'h0 : _GEN_260; // @[Conditional.scala 39:67]
  wire  _GEN_268 = _T_4278 ? 1'h0 : _GEN_262; // @[Conditional.scala 39:67]
  wire  _GEN_273 = _T_4191 & _T_4256; // @[Conditional.scala 39:67]
  wire  _GEN_276 = _T_4191 ? 1'h0 : _GEN_266; // @[Conditional.scala 39:67]
  wire  _GEN_278 = _T_4191 ? 1'h0 : _GEN_268; // @[Conditional.scala 39:67]
  wire  _GEN_284 = _T_4157 ? _T_4177 : _GEN_278; // @[Conditional.scala 39:67]
  wire  _GEN_286 = _T_4157 ? _T_4181 : _GEN_273; // @[Conditional.scala 39:67]
  wire  _GEN_290 = _T_4157 ? 1'h0 : _GEN_276; // @[Conditional.scala 39:67]
  wire  _GEN_296 = _T_4153 ? 1'h0 : _GEN_284; // @[Conditional.scala 39:67]
  wire  _GEN_298 = _T_4153 ? 1'h0 : _GEN_286; // @[Conditional.scala 39:67]
  wire  _GEN_302 = _T_4153 ? 1'h0 : _GEN_290; // @[Conditional.scala 39:67]
  wire  buf_wr_en_3 = _T_4130 & buf_state_en_3; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_3 = _T_4130 ? 1'h0 : _GEN_296; // @[Conditional.scala 40:58]
  wire  buf_rst_3 = _T_4130 ? 1'h0 : _GEN_302; // @[Conditional.scala 40:58]
  reg  _T_4359; // @[Reg.scala 27:20]
  reg  _T_4362; // @[Reg.scala 27:20]
  reg  _T_4365; // @[Reg.scala 27:20]
  reg  _T_4368; // @[Reg.scala 27:20]
  wire [3:0] buf_unsign = {_T_4368,_T_4365,_T_4362,_T_4359}; // @[Cat.scala 29:58]
  reg  _T_4434; // @[el2_lsu_bus_buffer.scala 573:82]
  reg  _T_4429; // @[el2_lsu_bus_buffer.scala 573:82]
  reg  _T_4424; // @[el2_lsu_bus_buffer.scala 573:82]
  reg  _T_4419; // @[el2_lsu_bus_buffer.scala 573:82]
  wire [3:0] buf_error = {_T_4434,_T_4429,_T_4424,_T_4419}; // @[Cat.scala 29:58]
  wire  _T_4416 = buf_error_en_0 | buf_error[0]; // @[el2_lsu_bus_buffer.scala 573:86]
  wire  _T_4417 = ~buf_rst_0; // @[el2_lsu_bus_buffer.scala 573:128]
  wire  _T_4421 = buf_error_en_1 | buf_error[1]; // @[el2_lsu_bus_buffer.scala 573:86]
  wire  _T_4422 = ~buf_rst_1; // @[el2_lsu_bus_buffer.scala 573:128]
  wire  _T_4426 = buf_error_en_2 | buf_error[2]; // @[el2_lsu_bus_buffer.scala 573:86]
  wire  _T_4427 = ~buf_rst_2; // @[el2_lsu_bus_buffer.scala 573:128]
  wire  _T_4431 = buf_error_en_3 | buf_error[3]; // @[el2_lsu_bus_buffer.scala 573:86]
  wire  _T_4432 = ~buf_rst_3; // @[el2_lsu_bus_buffer.scala 573:128]
  wire [1:0] _T_4438 = {io_lsu_busreq_m,1'h0}; // @[Cat.scala 29:58]
  wire [1:0] _T_4439 = io_ldst_dual_m ? _T_4438 : {{1'd0}, io_lsu_busreq_m}; // @[el2_lsu_bus_buffer.scala 576:28]
  wire [1:0] _T_4440 = {io_lsu_busreq_r,1'h0}; // @[Cat.scala 29:58]
  wire [1:0] _T_4441 = io_ldst_dual_r ? _T_4440 : {{1'd0}, io_lsu_busreq_r}; // @[el2_lsu_bus_buffer.scala 576:94]
  wire [2:0] _T_4442 = _T_4439 + _T_4441; // @[el2_lsu_bus_buffer.scala 576:88]
  wire [2:0] _GEN_376 = {{2'd0}, ibuf_valid}; // @[el2_lsu_bus_buffer.scala 576:154]
  wire [3:0] _T_4443 = _T_4442 + _GEN_376; // @[el2_lsu_bus_buffer.scala 576:154]
  wire [1:0] _T_4448 = _T_5 + _T_12; // @[el2_lsu_bus_buffer.scala 576:217]
  wire [1:0] _GEN_377 = {{1'd0}, _T_19}; // @[el2_lsu_bus_buffer.scala 576:217]
  wire [2:0] _T_4449 = _T_4448 + _GEN_377; // @[el2_lsu_bus_buffer.scala 576:217]
  wire [2:0] _GEN_378 = {{2'd0}, _T_26}; // @[el2_lsu_bus_buffer.scala 576:217]
  wire [3:0] _T_4450 = _T_4449 + _GEN_378; // @[el2_lsu_bus_buffer.scala 576:217]
  wire [3:0] buf_numvld_any = _T_4443 + _T_4450; // @[el2_lsu_bus_buffer.scala 576:169]
  wire  _T_4521 = io_ldst_dual_d & io_dec_lsu_valid_raw_d; // @[el2_lsu_bus_buffer.scala 582:52]
  wire  _T_4522 = buf_numvld_any >= 4'h3; // @[el2_lsu_bus_buffer.scala 582:92]
  wire  _T_4523 = buf_numvld_any == 4'h4; // @[el2_lsu_bus_buffer.scala 582:121]
  wire  _T_4525 = |buf_state_0; // @[el2_lsu_bus_buffer.scala 583:52]
  wire  _T_4526 = |buf_state_1; // @[el2_lsu_bus_buffer.scala 583:52]
  wire  _T_4527 = |buf_state_2; // @[el2_lsu_bus_buffer.scala 583:52]
  wire  _T_4528 = |buf_state_3; // @[el2_lsu_bus_buffer.scala 583:52]
  wire  _T_4529 = _T_4525 | _T_4526; // @[el2_lsu_bus_buffer.scala 583:65]
  wire  _T_4530 = _T_4529 | _T_4527; // @[el2_lsu_bus_buffer.scala 583:65]
  wire  _T_4531 = _T_4530 | _T_4528; // @[el2_lsu_bus_buffer.scala 583:65]
  wire  _T_4532 = ~_T_4531; // @[el2_lsu_bus_buffer.scala 583:34]
  wire  _T_4534 = _T_4532 & _T_852; // @[el2_lsu_bus_buffer.scala 583:70]
  wire  _T_4537 = io_lsu_busreq_m & io_lsu_pkt_m_valid; // @[el2_lsu_bus_buffer.scala 585:51]
  wire  _T_4538 = _T_4537 & io_lsu_pkt_m_load; // @[el2_lsu_bus_buffer.scala 585:72]
  wire  _T_4539 = ~io_flush_m_up; // @[el2_lsu_bus_buffer.scala 585:94]
  wire  _T_4540 = _T_4538 & _T_4539; // @[el2_lsu_bus_buffer.scala 585:92]
  wire  _T_4541 = ~io_ld_full_hit_m; // @[el2_lsu_bus_buffer.scala 585:111]
  wire  _T_4543 = ~io_lsu_commit_r; // @[el2_lsu_bus_buffer.scala 588:61]
  reg  lsu_nonblock_load_valid_r; // @[el2_lsu_bus_buffer.scala 673:66]
  wire  _T_4561 = _T_2822 & _T_3666; // @[Mux.scala 27:72]
  wire  _T_4562 = _T_2844 & _T_3859; // @[Mux.scala 27:72]
  wire  _T_4563 = _T_2866 & _T_4052; // @[Mux.scala 27:72]
  wire  _T_4564 = _T_2888 & _T_4245; // @[Mux.scala 27:72]
  wire  _T_4565 = _T_4561 | _T_4562; // @[Mux.scala 27:72]
  wire  _T_4566 = _T_4565 | _T_4563; // @[Mux.scala 27:72]
  wire  lsu_nonblock_load_data_ready = _T_4566 | _T_4564; // @[Mux.scala 27:72]
  wire  _T_4572 = buf_error[0] & _T_3666; // @[el2_lsu_bus_buffer.scala 591:108]
  wire  _T_4577 = buf_error[1] & _T_3859; // @[el2_lsu_bus_buffer.scala 591:108]
  wire  _T_4582 = buf_error[2] & _T_4052; // @[el2_lsu_bus_buffer.scala 591:108]
  wire  _T_4587 = buf_error[3] & _T_4245; // @[el2_lsu_bus_buffer.scala 591:108]
  wire  _T_4588 = _T_2822 & _T_4572; // @[Mux.scala 27:72]
  wire  _T_4589 = _T_2844 & _T_4577; // @[Mux.scala 27:72]
  wire  _T_4590 = _T_2866 & _T_4582; // @[Mux.scala 27:72]
  wire  _T_4591 = _T_2888 & _T_4587; // @[Mux.scala 27:72]
  wire  _T_4592 = _T_4588 | _T_4589; // @[Mux.scala 27:72]
  wire  _T_4593 = _T_4592 | _T_4590; // @[Mux.scala 27:72]
  wire  _T_4600 = ~buf_dual_0; // @[el2_lsu_bus_buffer.scala 592:109]
  wire  _T_4601 = ~buf_dualhi_0; // @[el2_lsu_bus_buffer.scala 592:124]
  wire  _T_4602 = _T_4600 | _T_4601; // @[el2_lsu_bus_buffer.scala 592:122]
  wire  _T_4603 = _T_4561 & _T_4602; // @[el2_lsu_bus_buffer.scala 592:106]
  wire  _T_4608 = ~buf_dual_1; // @[el2_lsu_bus_buffer.scala 592:109]
  wire  _T_4609 = ~buf_dualhi_1; // @[el2_lsu_bus_buffer.scala 592:124]
  wire  _T_4610 = _T_4608 | _T_4609; // @[el2_lsu_bus_buffer.scala 592:122]
  wire  _T_4611 = _T_4562 & _T_4610; // @[el2_lsu_bus_buffer.scala 592:106]
  wire  _T_4616 = ~buf_dual_2; // @[el2_lsu_bus_buffer.scala 592:109]
  wire  _T_4617 = ~buf_dualhi_2; // @[el2_lsu_bus_buffer.scala 592:124]
  wire  _T_4618 = _T_4616 | _T_4617; // @[el2_lsu_bus_buffer.scala 592:122]
  wire  _T_4619 = _T_4563 & _T_4618; // @[el2_lsu_bus_buffer.scala 592:106]
  wire  _T_4624 = ~buf_dual_3; // @[el2_lsu_bus_buffer.scala 592:109]
  wire  _T_4625 = ~buf_dualhi_3; // @[el2_lsu_bus_buffer.scala 592:124]
  wire  _T_4626 = _T_4624 | _T_4625; // @[el2_lsu_bus_buffer.scala 592:122]
  wire  _T_4627 = _T_4564 & _T_4626; // @[el2_lsu_bus_buffer.scala 592:106]
  wire [1:0] _T_4630 = _T_4619 ? 2'h2 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4631 = _T_4627 ? 2'h3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _GEN_379 = {{1'd0}, _T_4611}; // @[Mux.scala 27:72]
  wire [1:0] _T_4633 = _GEN_379 | _T_4630; // @[Mux.scala 27:72]
  wire [31:0] _T_4668 = _T_4603 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4669 = _T_4611 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4670 = _T_4619 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4671 = _T_4627 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4672 = _T_4668 | _T_4669; // @[Mux.scala 27:72]
  wire [31:0] _T_4673 = _T_4672 | _T_4670; // @[Mux.scala 27:72]
  wire [31:0] lsu_nonblock_load_data_lo = _T_4673 | _T_4671; // @[Mux.scala 27:72]
  wire  _T_4679 = buf_dual_0 | buf_dualhi_0; // @[el2_lsu_bus_buffer.scala 594:120]
  wire  _T_4680 = _T_4561 & _T_4679; // @[el2_lsu_bus_buffer.scala 594:105]
  wire  _T_4685 = buf_dual_1 | buf_dualhi_1; // @[el2_lsu_bus_buffer.scala 594:120]
  wire  _T_4686 = _T_4562 & _T_4685; // @[el2_lsu_bus_buffer.scala 594:105]
  wire  _T_4691 = buf_dual_2 | buf_dualhi_2; // @[el2_lsu_bus_buffer.scala 594:120]
  wire  _T_4692 = _T_4563 & _T_4691; // @[el2_lsu_bus_buffer.scala 594:105]
  wire  _T_4697 = buf_dual_3 | buf_dualhi_3; // @[el2_lsu_bus_buffer.scala 594:120]
  wire  _T_4698 = _T_4564 & _T_4697; // @[el2_lsu_bus_buffer.scala 594:105]
  wire [31:0] _T_4699 = _T_4680 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4700 = _T_4686 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4701 = _T_4692 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4702 = _T_4698 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4703 = _T_4699 | _T_4700; // @[Mux.scala 27:72]
  wire [31:0] _T_4704 = _T_4703 | _T_4701; // @[Mux.scala 27:72]
  wire [31:0] lsu_nonblock_load_data_hi = _T_4704 | _T_4702; // @[Mux.scala 27:72]
  wire  _T_4706 = io_lsu_nonblock_load_data_tag == 2'h0; // @[el2_lsu_bus_buffer.scala 112:123]
  wire  _T_4707 = io_lsu_nonblock_load_data_tag == 2'h1; // @[el2_lsu_bus_buffer.scala 112:123]
  wire  _T_4708 = io_lsu_nonblock_load_data_tag == 2'h2; // @[el2_lsu_bus_buffer.scala 112:123]
  wire  _T_4709 = io_lsu_nonblock_load_data_tag == 2'h3; // @[el2_lsu_bus_buffer.scala 112:123]
  wire [31:0] _T_4710 = _T_4706 ? buf_addr_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4711 = _T_4707 ? buf_addr_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4712 = _T_4708 ? buf_addr_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4713 = _T_4709 ? buf_addr_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4714 = _T_4710 | _T_4711; // @[Mux.scala 27:72]
  wire [31:0] _T_4715 = _T_4714 | _T_4712; // @[Mux.scala 27:72]
  wire [31:0] _T_4716 = _T_4715 | _T_4713; // @[Mux.scala 27:72]
  wire [1:0] lsu_nonblock_addr_offset = _T_4716[1:0]; // @[el2_lsu_bus_buffer.scala 595:83]
  wire [1:0] _T_4722 = _T_4706 ? buf_sz_0 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4723 = _T_4707 ? buf_sz_1 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4724 = _T_4708 ? buf_sz_2 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4725 = _T_4709 ? buf_sz_3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4726 = _T_4722 | _T_4723; // @[Mux.scala 27:72]
  wire [1:0] _T_4727 = _T_4726 | _T_4724; // @[Mux.scala 27:72]
  wire [1:0] lsu_nonblock_sz = _T_4727 | _T_4725; // @[Mux.scala 27:72]
  wire  _T_4737 = _T_4706 & buf_unsign[0]; // @[Mux.scala 27:72]
  wire  _T_4738 = _T_4707 & buf_unsign[1]; // @[Mux.scala 27:72]
  wire  _T_4739 = _T_4708 & buf_unsign[2]; // @[Mux.scala 27:72]
  wire  _T_4740 = _T_4709 & buf_unsign[3]; // @[Mux.scala 27:72]
  wire  _T_4741 = _T_4737 | _T_4738; // @[Mux.scala 27:72]
  wire  _T_4742 = _T_4741 | _T_4739; // @[Mux.scala 27:72]
  wire  lsu_nonblock_unsign = _T_4742 | _T_4740; // @[Mux.scala 27:72]
  wire [63:0] _T_4762 = {lsu_nonblock_load_data_hi,lsu_nonblock_load_data_lo}; // @[Cat.scala 29:58]
  wire [3:0] _GEN_380 = {{2'd0}, lsu_nonblock_addr_offset}; // @[el2_lsu_bus_buffer.scala 599:121]
  wire [5:0] _T_4763 = _GEN_380 * 4'h8; // @[el2_lsu_bus_buffer.scala 599:121]
  wire [63:0] lsu_nonblock_data_unalgn = _T_4762 >> _T_4763; // @[el2_lsu_bus_buffer.scala 599:92]
  wire  _T_4764 = ~io_lsu_nonblock_load_data_error; // @[el2_lsu_bus_buffer.scala 601:69]
  wire  _T_4766 = lsu_nonblock_sz == 2'h0; // @[el2_lsu_bus_buffer.scala 602:81]
  wire  _T_4767 = lsu_nonblock_unsign & _T_4766; // @[el2_lsu_bus_buffer.scala 602:63]
  wire [31:0] _T_4769 = {24'h0,lsu_nonblock_data_unalgn[7:0]}; // @[Cat.scala 29:58]
  wire  _T_4770 = lsu_nonblock_sz == 2'h1; // @[el2_lsu_bus_buffer.scala 603:45]
  wire  _T_4771 = lsu_nonblock_unsign & _T_4770; // @[el2_lsu_bus_buffer.scala 603:26]
  wire [31:0] _T_4773 = {16'h0,lsu_nonblock_data_unalgn[15:0]}; // @[Cat.scala 29:58]
  wire  _T_4774 = ~lsu_nonblock_unsign; // @[el2_lsu_bus_buffer.scala 604:6]
  wire  _T_4776 = _T_4774 & _T_4766; // @[el2_lsu_bus_buffer.scala 604:27]
  wire [23:0] _T_4779 = lsu_nonblock_data_unalgn[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_4781 = {_T_4779,lsu_nonblock_data_unalgn[7:0]}; // @[Cat.scala 29:58]
  wire  _T_4784 = _T_4774 & _T_4770; // @[el2_lsu_bus_buffer.scala 605:27]
  wire [15:0] _T_4787 = lsu_nonblock_data_unalgn[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_4789 = {_T_4787,lsu_nonblock_data_unalgn[15:0]}; // @[Cat.scala 29:58]
  wire  _T_4790 = lsu_nonblock_sz == 2'h2; // @[el2_lsu_bus_buffer.scala 606:21]
  wire [31:0] _T_4791 = _T_4767 ? _T_4769 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4792 = _T_4771 ? _T_4773 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4793 = _T_4776 ? _T_4781 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4794 = _T_4784 ? _T_4789 : 32'h0; // @[Mux.scala 27:72]
  wire [63:0] _T_4795 = _T_4790 ? lsu_nonblock_data_unalgn : 64'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4796 = _T_4791 | _T_4792; // @[Mux.scala 27:72]
  wire [31:0] _T_4797 = _T_4796 | _T_4793; // @[Mux.scala 27:72]
  wire [31:0] _T_4798 = _T_4797 | _T_4794; // @[Mux.scala 27:72]
  wire [63:0] _GEN_381 = {{32'd0}, _T_4798}; // @[Mux.scala 27:72]
  wire [63:0] _T_4799 = _GEN_381 | _T_4795; // @[Mux.scala 27:72]
  wire  _T_4894 = obuf_valid & obuf_write; // @[el2_lsu_bus_buffer.scala 624:36]
  wire  _T_4895 = ~obuf_cmd_done; // @[el2_lsu_bus_buffer.scala 624:51]
  wire  _T_4896 = _T_4894 & _T_4895; // @[el2_lsu_bus_buffer.scala 624:49]
  wire [31:0] _T_4900 = {obuf_addr[31:3],3'h0}; // @[Cat.scala 29:58]
  wire [2:0] _T_4902 = {1'h0,obuf_sz}; // @[Cat.scala 29:58]
  wire  _T_4907 = ~obuf_data_done; // @[el2_lsu_bus_buffer.scala 636:50]
  wire  _T_4908 = _T_4894 & _T_4907; // @[el2_lsu_bus_buffer.scala 636:48]
  wire [7:0] _T_4912 = obuf_write ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire  _T_4915 = obuf_valid & _T_1366; // @[el2_lsu_bus_buffer.scala 641:36]
  wire  _T_4917 = _T_4915 & _T_1372; // @[el2_lsu_bus_buffer.scala 641:50]
  wire  _T_4929 = io_lsu_bus_clk_en_q & buf_error[0]; // @[el2_lsu_bus_buffer.scala 654:114]
  wire  _T_4931 = _T_4929 & buf_write[0]; // @[el2_lsu_bus_buffer.scala 654:129]
  wire  _T_4934 = io_lsu_bus_clk_en_q & buf_error[1]; // @[el2_lsu_bus_buffer.scala 654:114]
  wire  _T_4936 = _T_4934 & buf_write[1]; // @[el2_lsu_bus_buffer.scala 654:129]
  wire  _T_4939 = io_lsu_bus_clk_en_q & buf_error[2]; // @[el2_lsu_bus_buffer.scala 654:114]
  wire  _T_4941 = _T_4939 & buf_write[2]; // @[el2_lsu_bus_buffer.scala 654:129]
  wire  _T_4944 = io_lsu_bus_clk_en_q & buf_error[3]; // @[el2_lsu_bus_buffer.scala 654:114]
  wire  _T_4946 = _T_4944 & buf_write[3]; // @[el2_lsu_bus_buffer.scala 654:129]
  wire  _T_4947 = _T_2822 & _T_4931; // @[Mux.scala 27:72]
  wire  _T_4948 = _T_2844 & _T_4936; // @[Mux.scala 27:72]
  wire  _T_4949 = _T_2866 & _T_4941; // @[Mux.scala 27:72]
  wire  _T_4950 = _T_2888 & _T_4946; // @[Mux.scala 27:72]
  wire  _T_4951 = _T_4947 | _T_4948; // @[Mux.scala 27:72]
  wire  _T_4952 = _T_4951 | _T_4949; // @[Mux.scala 27:72]
  wire  _T_4962 = _T_2844 & buf_error[1]; // @[el2_lsu_bus_buffer.scala 655:98]
  wire  lsu_imprecise_error_store_tag = _T_4962 & buf_write[1]; // @[el2_lsu_bus_buffer.scala 655:113]
  wire  _T_4968 = ~io_lsu_imprecise_error_store_any; // @[el2_lsu_bus_buffer.scala 657:72]
  wire  _T_4970 = ~lsu_imprecise_error_store_tag; // @[el2_lsu_bus_buffer.scala 112:123]
  wire [31:0] _T_4972 = _T_4970 ? buf_addr_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4973 = lsu_imprecise_error_store_tag ? buf_addr_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4974 = _T_4972 | _T_4973; // @[Mux.scala 27:72]
  wire  _T_4991 = bus_wcmd_sent | bus_wdata_sent; // @[el2_lsu_bus_buffer.scala 664:68]
  wire  _T_4994 = io_lsu_busreq_r & io_ldst_dual_r; // @[el2_lsu_bus_buffer.scala 665:48]
  wire  _T_4997 = ~io_lsu_axi_awready; // @[el2_lsu_bus_buffer.scala 668:48]
  wire  _T_4998 = io_lsu_axi_awvalid & _T_4997; // @[el2_lsu_bus_buffer.scala 668:46]
  wire  _T_4999 = ~io_lsu_axi_wready; // @[el2_lsu_bus_buffer.scala 668:92]
  wire  _T_5000 = io_lsu_axi_wvalid & _T_4999; // @[el2_lsu_bus_buffer.scala 668:90]
  wire  _T_5001 = _T_4998 | _T_5000; // @[el2_lsu_bus_buffer.scala 668:69]
  wire  _T_5002 = ~io_lsu_axi_arready; // @[el2_lsu_bus_buffer.scala 668:136]
  wire  _T_5003 = io_lsu_axi_arvalid & _T_5002; // @[el2_lsu_bus_buffer.scala 668:134]
  wire  _T_5007 = ~io_flush_r; // @[el2_lsu_bus_buffer.scala 672:75]
  wire  _T_5008 = io_lsu_busreq_m & _T_5007; // @[el2_lsu_bus_buffer.scala 672:73]
  reg  _T_5011; // @[el2_lsu_bus_buffer.scala 672:56]
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
  assign io_lsu_busreq_r = _T_5011; // @[el2_lsu_bus_buffer.scala 672:19]
  assign io_lsu_bus_buffer_pend_any = |buf_numvld_pend_any; // @[el2_lsu_bus_buffer.scala 581:30]
  assign io_lsu_bus_buffer_full_any = _T_4521 ? _T_4522 : _T_4523; // @[el2_lsu_bus_buffer.scala 582:30]
  assign io_lsu_bus_buffer_empty_any = _T_4534 & _T_1252; // @[el2_lsu_bus_buffer.scala 583:31]
  assign io_lsu_bus_idle_any = 1'h1; // @[el2_lsu_bus_buffer.scala 661:23]
  assign io_ld_byte_hit_buf_lo = {_T_69,_T_58}; // @[el2_lsu_bus_buffer.scala 191:25]
  assign io_ld_byte_hit_buf_hi = {_T_84,_T_73}; // @[el2_lsu_bus_buffer.scala 192:25]
  assign io_ld_fwddata_buf_lo = _T_650 | _T_651; // @[el2_lsu_bus_buffer.scala 218:24]
  assign io_ld_fwddata_buf_hi = _T_747 | _T_748; // @[el2_lsu_bus_buffer.scala 224:24]
  assign io_lsu_imprecise_error_load_any = io_lsu_nonblock_load_data_error & _T_4968; // @[el2_lsu_bus_buffer.scala 657:35]
  assign io_lsu_imprecise_error_store_any = _T_4952 | _T_4950; // @[el2_lsu_bus_buffer.scala 654:36]
  assign io_lsu_imprecise_error_addr_any = io_lsu_imprecise_error_store_any ? _T_4974 : _T_4716; // @[el2_lsu_bus_buffer.scala 658:35]
  assign io_lsu_nonblock_load_valid_m = _T_4540 & _T_4541; // @[el2_lsu_bus_buffer.scala 585:32]
  assign io_lsu_nonblock_load_tag_m = _T_1886 ? 2'h0 : _T_1922; // @[el2_lsu_bus_buffer.scala 586:30]
  assign io_lsu_nonblock_load_inv_r = lsu_nonblock_load_valid_r & _T_4543; // @[el2_lsu_bus_buffer.scala 588:30]
  assign io_lsu_nonblock_load_inv_tag_r = WrPtr0_r; // @[el2_lsu_bus_buffer.scala 589:34]
  assign io_lsu_nonblock_load_data_valid = lsu_nonblock_load_data_ready & _T_4764; // @[el2_lsu_bus_buffer.scala 601:35]
  assign io_lsu_nonblock_load_data_error = _T_4593 | _T_4591; // @[el2_lsu_bus_buffer.scala 591:35]
  assign io_lsu_nonblock_load_data_tag = _T_4633 | _T_4631; // @[el2_lsu_bus_buffer.scala 592:33]
  assign io_lsu_nonblock_load_data = _T_4799[31:0]; // @[el2_lsu_bus_buffer.scala 602:29]
  assign io_lsu_pmu_bus_trxn = _T_4991 | _T_4886; // @[el2_lsu_bus_buffer.scala 664:23]
  assign io_lsu_pmu_bus_misaligned = _T_4994 & io_lsu_commit_r; // @[el2_lsu_bus_buffer.scala 665:29]
  assign io_lsu_pmu_bus_error = io_lsu_imprecise_error_load_any | io_lsu_imprecise_error_store_any; // @[el2_lsu_bus_buffer.scala 666:24]
  assign io_lsu_pmu_bus_busy = _T_5001 | _T_5003; // @[el2_lsu_bus_buffer.scala 668:23]
  assign io_lsu_axi_awvalid = _T_4896 & _T_1260; // @[el2_lsu_bus_buffer.scala 624:22]
  assign io_lsu_axi_awid = obuf_tag0; // @[el2_lsu_bus_buffer.scala 625:19]
  assign io_lsu_axi_awaddr = obuf_sideeffect ? obuf_addr : _T_4900; // @[el2_lsu_bus_buffer.scala 626:21]
  assign io_lsu_axi_awregion = obuf_addr[31:28]; // @[el2_lsu_bus_buffer.scala 630:23]
  assign io_lsu_axi_awlen = 8'h0; // @[el2_lsu_bus_buffer.scala 631:20]
  assign io_lsu_axi_awsize = obuf_sideeffect ? _T_4902 : 3'h3; // @[el2_lsu_bus_buffer.scala 627:21]
  assign io_lsu_axi_awburst = 2'h1; // @[el2_lsu_bus_buffer.scala 632:22]
  assign io_lsu_axi_awlock = 1'h0; // @[el2_lsu_bus_buffer.scala 634:21]
  assign io_lsu_axi_awcache = obuf_sideeffect ? 4'h0 : 4'hf; // @[el2_lsu_bus_buffer.scala 629:22]
  assign io_lsu_axi_awprot = 3'h0; // @[el2_lsu_bus_buffer.scala 628:21]
  assign io_lsu_axi_awqos = 4'h0; // @[el2_lsu_bus_buffer.scala 633:20]
  assign io_lsu_axi_wvalid = _T_4908 & _T_1260; // @[el2_lsu_bus_buffer.scala 636:21]
  assign io_lsu_axi_wdata = obuf_data; // @[el2_lsu_bus_buffer.scala 638:20]
  assign io_lsu_axi_wstrb = obuf_byteen & _T_4912; // @[el2_lsu_bus_buffer.scala 637:20]
  assign io_lsu_axi_wlast = 1'h1; // @[el2_lsu_bus_buffer.scala 639:20]
  assign io_lsu_axi_bready = 1'h1; // @[el2_lsu_bus_buffer.scala 652:21]
  assign io_lsu_axi_arvalid = _T_4917 & _T_1260; // @[el2_lsu_bus_buffer.scala 641:22]
  assign io_lsu_axi_arid = obuf_tag0; // @[el2_lsu_bus_buffer.scala 642:19]
  assign io_lsu_axi_araddr = obuf_sideeffect ? obuf_addr : _T_4900; // @[el2_lsu_bus_buffer.scala 643:21]
  assign io_lsu_axi_arregion = obuf_addr[31:28]; // @[el2_lsu_bus_buffer.scala 647:23]
  assign io_lsu_axi_arlen = 8'h0; // @[el2_lsu_bus_buffer.scala 648:20]
  assign io_lsu_axi_arsize = obuf_sideeffect ? _T_4902 : 3'h3; // @[el2_lsu_bus_buffer.scala 644:21]
  assign io_lsu_axi_arburst = 2'h1; // @[el2_lsu_bus_buffer.scala 649:22]
  assign io_lsu_axi_arlock = 1'h0; // @[el2_lsu_bus_buffer.scala 651:21]
  assign io_lsu_axi_arcache = obuf_sideeffect ? 4'h0 : 4'hf; // @[el2_lsu_bus_buffer.scala 646:22]
  assign io_lsu_axi_arprot = 3'h0; // @[el2_lsu_bus_buffer.scala 645:21]
  assign io_lsu_axi_arqos = 4'h0; // @[el2_lsu_bus_buffer.scala 650:20]
  assign io_lsu_axi_rready = 1'h1; // @[el2_lsu_bus_buffer.scala 653:21]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_io_en = _T_853 & _T_854; // @[el2_lib.scala 511:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = _T_853 & _T_854; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_2_io_clk = io_lsu_busm_clk; // @[el2_lib.scala 510:18]
  assign rvclkhdr_2_io_en = _T_1261 & io_lsu_bus_clk_en; // @[el2_lib.scala 511:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_3_io_clk = io_lsu_busm_clk; // @[el2_lib.scala 510:18]
  assign rvclkhdr_3_io_en = _T_1261 & io_lsu_bus_clk_en; // @[el2_lib.scala 511:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_4_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_4_io_en = _T_3551 & buf_state_en_0; // @[el2_lib.scala 511:17]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_5_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_5_io_en = _T_3744 & buf_state_en_1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_6_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_6_io_en = _T_3937 & buf_state_en_2; // @[el2_lib.scala 511:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_7_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_7_io_en = _T_4130 & buf_state_en_3; // @[el2_lib.scala 511:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_8_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_8_io_en = _T_3551 ? buf_state_en_0 : _GEN_70; // @[el2_lib.scala 511:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_9_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_9_io_en = _T_3744 ? buf_state_en_1 : _GEN_146; // @[el2_lib.scala 511:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_10_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_10_io_en = _T_3937 ? buf_state_en_2 : _GEN_222; // @[el2_lib.scala 511:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_11_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_11_io_en = _T_4130 ? buf_state_en_3 : _GEN_298; // @[el2_lib.scala 511:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
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
  buf_addr_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  _T_4383 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_4380 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  _T_4377 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  _T_4374 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  buf_state_0 = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  buf_addr_1 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  buf_state_1 = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  buf_addr_2 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  buf_state_2 = _RAND_9[2:0];
  _RAND_10 = {1{`RANDOM}};
  buf_addr_3 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  buf_state_3 = _RAND_11[2:0];
  _RAND_12 = {1{`RANDOM}};
  buf_byteen_3 = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  buf_byteen_2 = _RAND_13[3:0];
  _RAND_14 = {1{`RANDOM}};
  buf_byteen_1 = _RAND_14[3:0];
  _RAND_15 = {1{`RANDOM}};
  buf_byteen_0 = _RAND_15[3:0];
  _RAND_16 = {1{`RANDOM}};
  buf_ageQ_3 = _RAND_16[3:0];
  _RAND_17 = {1{`RANDOM}};
  obuf_tag0 = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  obuf_merge = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  obuf_tag1 = _RAND_19[2:0];
  _RAND_20 = {1{`RANDOM}};
  obuf_valid = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  obuf_wr_enQ = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  ibuf_addr = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  ibuf_write = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  ibuf_valid = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  ibuf_byteen = _RAND_25[3:0];
  _RAND_26 = {1{`RANDOM}};
  buf_ageQ_2 = _RAND_26[3:0];
  _RAND_27 = {1{`RANDOM}};
  buf_ageQ_1 = _RAND_27[3:0];
  _RAND_28 = {1{`RANDOM}};
  buf_ageQ_0 = _RAND_28[3:0];
  _RAND_29 = {1{`RANDOM}};
  buf_data_0 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  buf_data_1 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  buf_data_2 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  buf_data_3 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  ibuf_data = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  ibuf_timer = _RAND_34[2:0];
  _RAND_35 = {1{`RANDOM}};
  ibuf_sideeffect = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  WrPtr1_r = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  WrPtr0_r = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  ibuf_tag = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  ibuf_dualtag = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  ibuf_dual = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  ibuf_samedw = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  ibuf_nomerge = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  ibuf_unsign = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  ibuf_sz = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  obuf_wr_timer = _RAND_45[2:0];
  _RAND_46 = {1{`RANDOM}};
  buf_nomerge_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  buf_nomerge_1 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  buf_nomerge_2 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  buf_nomerge_3 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  _T_4353 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  _T_4350 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  _T_4347 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  _T_4344 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  buf_dual_3 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  buf_dual_2 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  buf_dual_1 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  buf_dual_0 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  buf_samedw_3 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  buf_samedw_2 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  buf_samedw_1 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  buf_samedw_0 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  obuf_write = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  obuf_cmd_done = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  obuf_data_done = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  obuf_nosend = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  obuf_addr = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  buf_sz_0 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  buf_sz_1 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  buf_sz_2 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  buf_sz_3 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  obuf_sideeffect = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  obuf_rdrsp_pend = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  obuf_rdrsp_tag = _RAND_73[2:0];
  _RAND_74 = {1{`RANDOM}};
  buf_dualhi_3 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  buf_dualhi_2 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  buf_dualhi_1 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  buf_dualhi_0 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  obuf_sz = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  obuf_byteen = _RAND_79[7:0];
  _RAND_80 = {2{`RANDOM}};
  obuf_data = _RAND_80[63:0];
  _RAND_81 = {1{`RANDOM}};
  buf_rspageQ_0 = _RAND_81[3:0];
  _RAND_82 = {1{`RANDOM}};
  buf_rspageQ_1 = _RAND_82[3:0];
  _RAND_83 = {1{`RANDOM}};
  buf_rspageQ_2 = _RAND_83[3:0];
  _RAND_84 = {1{`RANDOM}};
  buf_rspageQ_3 = _RAND_84[3:0];
  _RAND_85 = {1{`RANDOM}};
  _T_4330 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  _T_4328 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  _T_4326 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  _T_4324 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  buf_ldfwdtag_0 = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  buf_dualtag_0 = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  buf_ldfwdtag_3 = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  buf_ldfwdtag_2 = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  buf_ldfwdtag_1 = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  buf_dualtag_1 = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  buf_dualtag_2 = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  buf_dualtag_3 = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  _T_4359 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  _T_4362 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  _T_4365 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  _T_4368 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  _T_4434 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  _T_4429 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  _T_4424 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  _T_4419 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  lsu_nonblock_load_valid_r = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  _T_5011 = _RAND_106[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    buf_addr_0 = 32'h0;
  end
  if (reset) begin
    _T_4383 = 1'h0;
  end
  if (reset) begin
    _T_4380 = 1'h0;
  end
  if (reset) begin
    _T_4377 = 1'h0;
  end
  if (reset) begin
    _T_4374 = 1'h0;
  end
  if (reset) begin
    buf_state_0 = 3'h0;
  end
  if (reset) begin
    buf_addr_1 = 32'h0;
  end
  if (reset) begin
    buf_state_1 = 3'h0;
  end
  if (reset) begin
    buf_addr_2 = 32'h0;
  end
  if (reset) begin
    buf_state_2 = 3'h0;
  end
  if (reset) begin
    buf_addr_3 = 32'h0;
  end
  if (reset) begin
    buf_state_3 = 3'h0;
  end
  if (reset) begin
    buf_byteen_3 = 4'h0;
  end
  if (reset) begin
    buf_byteen_2 = 4'h0;
  end
  if (reset) begin
    buf_byteen_1 = 4'h0;
  end
  if (reset) begin
    buf_byteen_0 = 4'h0;
  end
  if (reset) begin
    buf_ageQ_3 = 4'h0;
  end
  if (reset) begin
    obuf_tag0 = 3'h0;
  end
  if (reset) begin
    obuf_merge = 1'h0;
  end
  if (reset) begin
    obuf_tag1 = 3'h0;
  end
  if (reset) begin
    obuf_valid = 1'h0;
  end
  if (reset) begin
    obuf_wr_enQ = 1'h0;
  end
  if (reset) begin
    ibuf_addr = 32'h0;
  end
  if (reset) begin
    ibuf_write = 1'h0;
  end
  if (reset) begin
    ibuf_valid = 1'h0;
  end
  if (reset) begin
    ibuf_byteen = 4'h0;
  end
  if (reset) begin
    buf_ageQ_2 = 4'h0;
  end
  if (reset) begin
    buf_ageQ_1 = 4'h0;
  end
  if (reset) begin
    buf_ageQ_0 = 4'h0;
  end
  if (reset) begin
    buf_data_0 = 32'h0;
  end
  if (reset) begin
    buf_data_1 = 32'h0;
  end
  if (reset) begin
    buf_data_2 = 32'h0;
  end
  if (reset) begin
    buf_data_3 = 32'h0;
  end
  if (reset) begin
    ibuf_data = 32'h0;
  end
  if (reset) begin
    ibuf_timer = 3'h0;
  end
  if (reset) begin
    ibuf_sideeffect = 1'h0;
  end
  if (reset) begin
    WrPtr1_r = 2'h0;
  end
  if (reset) begin
    WrPtr0_r = 2'h0;
  end
  if (reset) begin
    ibuf_tag = 2'h0;
  end
  if (reset) begin
    ibuf_dualtag = 2'h0;
  end
  if (reset) begin
    ibuf_dual = 1'h0;
  end
  if (reset) begin
    ibuf_samedw = 1'h0;
  end
  if (reset) begin
    ibuf_nomerge = 1'h0;
  end
  if (reset) begin
    ibuf_unsign = 1'h0;
  end
  if (reset) begin
    ibuf_sz = 2'h0;
  end
  if (reset) begin
    obuf_wr_timer = 3'h0;
  end
  if (reset) begin
    buf_nomerge_0 = 1'h0;
  end
  if (reset) begin
    buf_nomerge_1 = 1'h0;
  end
  if (reset) begin
    buf_nomerge_2 = 1'h0;
  end
  if (reset) begin
    buf_nomerge_3 = 1'h0;
  end
  if (reset) begin
    _T_4353 = 1'h0;
  end
  if (reset) begin
    _T_4350 = 1'h0;
  end
  if (reset) begin
    _T_4347 = 1'h0;
  end
  if (reset) begin
    _T_4344 = 1'h0;
  end
  if (reset) begin
    buf_dual_3 = 1'h0;
  end
  if (reset) begin
    buf_dual_2 = 1'h0;
  end
  if (reset) begin
    buf_dual_1 = 1'h0;
  end
  if (reset) begin
    buf_dual_0 = 1'h0;
  end
  if (reset) begin
    buf_samedw_3 = 1'h0;
  end
  if (reset) begin
    buf_samedw_2 = 1'h0;
  end
  if (reset) begin
    buf_samedw_1 = 1'h0;
  end
  if (reset) begin
    buf_samedw_0 = 1'h0;
  end
  if (reset) begin
    obuf_write = 1'h0;
  end
  if (reset) begin
    obuf_cmd_done = 1'h0;
  end
  if (reset) begin
    obuf_data_done = 1'h0;
  end
  if (reset) begin
    obuf_nosend = 1'h0;
  end
  if (reset) begin
    obuf_addr = 32'h0;
  end
  if (reset) begin
    buf_sz_0 = 2'h0;
  end
  if (reset) begin
    buf_sz_1 = 2'h0;
  end
  if (reset) begin
    buf_sz_2 = 2'h0;
  end
  if (reset) begin
    buf_sz_3 = 2'h0;
  end
  if (reset) begin
    obuf_sideeffect = 1'h0;
  end
  if (reset) begin
    obuf_rdrsp_pend = 1'h0;
  end
  if (reset) begin
    obuf_rdrsp_tag = 3'h0;
  end
  if (reset) begin
    buf_dualhi_3 = 1'h0;
  end
  if (reset) begin
    buf_dualhi_2 = 1'h0;
  end
  if (reset) begin
    buf_dualhi_1 = 1'h0;
  end
  if (reset) begin
    buf_dualhi_0 = 1'h0;
  end
  if (reset) begin
    obuf_sz = 2'h0;
  end
  if (reset) begin
    obuf_byteen = 8'h0;
  end
  if (reset) begin
    obuf_data = 64'h0;
  end
  if (reset) begin
    buf_rspageQ_0 = 4'h0;
  end
  if (reset) begin
    buf_rspageQ_1 = 4'h0;
  end
  if (reset) begin
    buf_rspageQ_2 = 4'h0;
  end
  if (reset) begin
    buf_rspageQ_3 = 4'h0;
  end
  if (reset) begin
    _T_4330 = 1'h0;
  end
  if (reset) begin
    _T_4328 = 1'h0;
  end
  if (reset) begin
    _T_4326 = 1'h0;
  end
  if (reset) begin
    _T_4324 = 1'h0;
  end
  if (reset) begin
    buf_ldfwdtag_0 = 2'h0;
  end
  if (reset) begin
    buf_dualtag_0 = 2'h0;
  end
  if (reset) begin
    buf_ldfwdtag_3 = 2'h0;
  end
  if (reset) begin
    buf_ldfwdtag_2 = 2'h0;
  end
  if (reset) begin
    buf_ldfwdtag_1 = 2'h0;
  end
  if (reset) begin
    buf_dualtag_1 = 2'h0;
  end
  if (reset) begin
    buf_dualtag_2 = 2'h0;
  end
  if (reset) begin
    buf_dualtag_3 = 2'h0;
  end
  if (reset) begin
    _T_4359 = 1'h0;
  end
  if (reset) begin
    _T_4362 = 1'h0;
  end
  if (reset) begin
    _T_4365 = 1'h0;
  end
  if (reset) begin
    _T_4368 = 1'h0;
  end
  if (reset) begin
    _T_4434 = 1'h0;
  end
  if (reset) begin
    _T_4429 = 1'h0;
  end
  if (reset) begin
    _T_4424 = 1'h0;
  end
  if (reset) begin
    _T_4419 = 1'h0;
  end
  if (reset) begin
    lsu_nonblock_load_valid_r = 1'h0;
  end
  if (reset) begin
    _T_5011 = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_addr_0 <= 32'h0;
    end else if (ibuf_drainvec_vld[0]) begin
      buf_addr_0 <= ibuf_addr;
    end else if (_T_3366) begin
      buf_addr_0 <= io_end_addr_r;
    end else begin
      buf_addr_0 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4383 <= 1'h0;
    end else if (buf_wr_en_3) begin
      _T_4383 <= buf_write_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4380 <= 1'h0;
    end else if (buf_wr_en_2) begin
      _T_4380 <= buf_write_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4377 <= 1'h0;
    end else if (buf_wr_en_1) begin
      _T_4377 <= buf_write_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4374 <= 1'h0;
    end else if (buf_wr_en_0) begin
      _T_4374 <= buf_write_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_0 <= 3'h0;
    end else if (buf_state_en_0) begin
      if (_T_3551) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_0 <= 3'h2;
        end else begin
          buf_state_0 <= 3'h1;
        end
      end else if (_T_3574) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else begin
          buf_state_0 <= 3'h2;
        end
      end else if (_T_3578) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else if (_T_3582) begin
          buf_state_0 <= 3'h5;
        end else begin
          buf_state_0 <= 3'h3;
        end
      end else if (_T_3612) begin
        if (_T_3617) begin
          buf_state_0 <= 3'h0;
        end else if (_T_3625) begin
          buf_state_0 <= 3'h4;
        end else if (_T_3653) begin
          buf_state_0 <= 3'h5;
        end else begin
          buf_state_0 <= 3'h6;
        end
      end else if (_T_3699) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else if (_T_3705) begin
          buf_state_0 <= 3'h5;
        end else begin
          buf_state_0 <= 3'h6;
        end
      end else if (_T_3717) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else begin
          buf_state_0 <= 3'h6;
        end
      end else begin
        buf_state_0 <= 3'h0;
      end
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_addr_1 <= 32'h0;
    end else if (ibuf_drainvec_vld[1]) begin
      buf_addr_1 <= ibuf_addr;
    end else if (_T_3375) begin
      buf_addr_1 <= io_end_addr_r;
    end else begin
      buf_addr_1 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_1 <= 3'h0;
    end else if (buf_state_en_1) begin
      if (_T_3744) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_1 <= 3'h2;
        end else begin
          buf_state_1 <= 3'h1;
        end
      end else if (_T_3767) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else begin
          buf_state_1 <= 3'h2;
        end
      end else if (_T_3771) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else if (_T_3582) begin
          buf_state_1 <= 3'h5;
        end else begin
          buf_state_1 <= 3'h3;
        end
      end else if (_T_3805) begin
        if (_T_3810) begin
          buf_state_1 <= 3'h0;
        end else if (_T_3818) begin
          buf_state_1 <= 3'h4;
        end else if (_T_3846) begin
          buf_state_1 <= 3'h5;
        end else begin
          buf_state_1 <= 3'h6;
        end
      end else if (_T_3892) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else if (_T_3898) begin
          buf_state_1 <= 3'h5;
        end else begin
          buf_state_1 <= 3'h6;
        end
      end else if (_T_3910) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else begin
          buf_state_1 <= 3'h6;
        end
      end else begin
        buf_state_1 <= 3'h0;
      end
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_addr_2 <= 32'h0;
    end else if (ibuf_drainvec_vld[2]) begin
      buf_addr_2 <= ibuf_addr;
    end else if (_T_3384) begin
      buf_addr_2 <= io_end_addr_r;
    end else begin
      buf_addr_2 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_2 <= 3'h0;
    end else if (buf_state_en_2) begin
      if (_T_3937) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_2 <= 3'h2;
        end else begin
          buf_state_2 <= 3'h1;
        end
      end else if (_T_3960) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else begin
          buf_state_2 <= 3'h2;
        end
      end else if (_T_3964) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else if (_T_3582) begin
          buf_state_2 <= 3'h5;
        end else begin
          buf_state_2 <= 3'h3;
        end
      end else if (_T_3998) begin
        if (_T_4003) begin
          buf_state_2 <= 3'h0;
        end else if (_T_4011) begin
          buf_state_2 <= 3'h4;
        end else if (_T_4039) begin
          buf_state_2 <= 3'h5;
        end else begin
          buf_state_2 <= 3'h6;
        end
      end else if (_T_4085) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else if (_T_4091) begin
          buf_state_2 <= 3'h5;
        end else begin
          buf_state_2 <= 3'h6;
        end
      end else if (_T_4103) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else begin
          buf_state_2 <= 3'h6;
        end
      end else begin
        buf_state_2 <= 3'h0;
      end
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_addr_3 <= 32'h0;
    end else if (ibuf_drainvec_vld[3]) begin
      buf_addr_3 <= ibuf_addr;
    end else if (_T_3393) begin
      buf_addr_3 <= io_end_addr_r;
    end else begin
      buf_addr_3 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_3 <= 3'h0;
    end else if (buf_state_en_3) begin
      if (_T_4130) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_3 <= 3'h2;
        end else begin
          buf_state_3 <= 3'h1;
        end
      end else if (_T_4153) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else begin
          buf_state_3 <= 3'h2;
        end
      end else if (_T_4157) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else if (_T_3582) begin
          buf_state_3 <= 3'h5;
        end else begin
          buf_state_3 <= 3'h3;
        end
      end else if (_T_4191) begin
        if (_T_4196) begin
          buf_state_3 <= 3'h0;
        end else if (_T_4204) begin
          buf_state_3 <= 3'h4;
        end else if (_T_4232) begin
          buf_state_3 <= 3'h5;
        end else begin
          buf_state_3 <= 3'h6;
        end
      end else if (_T_4278) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else if (_T_4284) begin
          buf_state_3 <= 3'h5;
        end else begin
          buf_state_3 <= 3'h6;
        end
      end else if (_T_4296) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else begin
          buf_state_3 <= 3'h6;
        end
      end else begin
        buf_state_3 <= 3'h0;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_byteen_3 <= 4'h0;
    end else if (buf_wr_en_3) begin
      if (ibuf_drainvec_vld[3]) begin
        buf_byteen_3 <= ibuf_byteen_out;
      end else if (_T_3393) begin
        buf_byteen_3 <= ldst_byteen_hi_r;
      end else begin
        buf_byteen_3 <= ldst_byteen_lo_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_byteen_2 <= 4'h0;
    end else if (buf_wr_en_2) begin
      if (ibuf_drainvec_vld[2]) begin
        buf_byteen_2 <= ibuf_byteen_out;
      end else if (_T_3384) begin
        buf_byteen_2 <= ldst_byteen_hi_r;
      end else begin
        buf_byteen_2 <= ldst_byteen_lo_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_byteen_1 <= 4'h0;
    end else if (buf_wr_en_1) begin
      if (ibuf_drainvec_vld[1]) begin
        buf_byteen_1 <= ibuf_byteen_out;
      end else if (_T_3375) begin
        buf_byteen_1 <= ldst_byteen_hi_r;
      end else begin
        buf_byteen_1 <= ldst_byteen_lo_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_byteen_0 <= 4'h0;
    end else if (buf_wr_en_0) begin
      if (ibuf_drainvec_vld[0]) begin
        buf_byteen_0 <= ibuf_byteen_out;
      end else if (_T_3366) begin
        buf_byteen_0 <= ldst_byteen_hi_r;
      end else begin
        buf_byteen_0 <= ldst_byteen_lo_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ageQ_3 <= 4'h0;
    end else begin
      buf_ageQ_3 <= {_T_2558,_T_2481};
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_tag0 <= 3'h0;
    end else if (obuf_wr_en) begin
      obuf_tag0 <= obuf_tag0_in;
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_merge <= 1'h0;
    end else if (obuf_wr_en) begin
      obuf_merge <= obuf_merge_en;
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_tag1 <= 3'h0;
    end else if (obuf_wr_en) begin
      obuf_tag1 <= obuf_tag1_in;
    end
  end
  always @(posedge io_lsu_free_c2_clk or posedge reset) begin
    if (reset) begin
      obuf_valid <= 1'h0;
    end else begin
      obuf_valid <= _T_1862 & _T_1863;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_wr_enQ <= 1'h0;
    end else begin
      obuf_wr_enQ <= _T_1261 & io_lsu_bus_clk_en;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      ibuf_addr <= 32'h0;
    end else if (io_ldst_dual_r) begin
      ibuf_addr <= io_end_addr_r;
    end else begin
      ibuf_addr <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_write <= 1'h0;
    end else if (ibuf_wr_en) begin
      ibuf_write <= io_lsu_pkt_r_store;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ibuf_valid <= 1'h0;
    end else begin
      ibuf_valid <= _T_1005 & _T_1006;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_byteen <= 4'h0;
    end else if (ibuf_wr_en) begin
      if (_T_866) begin
        ibuf_byteen <= _T_881;
      end else if (io_ldst_dual_r) begin
        ibuf_byteen <= ldst_byteen_hi_r;
      end else begin
        ibuf_byteen <= ldst_byteen_lo_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ageQ_2 <= 4'h0;
    end else begin
      buf_ageQ_2 <= {_T_2456,_T_2379};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ageQ_1 <= 4'h0;
    end else begin
      buf_ageQ_1 <= {_T_2354,_T_2277};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ageQ_0 <= 4'h0;
    end else begin
      buf_ageQ_0 <= {_T_2252,_T_2175};
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_0 <= 32'h0;
    end else if (_T_3551) begin
      if (_T_3566) begin
        buf_data_0 <= ibuf_data_out;
      end else begin
        buf_data_0 <= store_data_lo_r;
      end
    end else if (_T_3574) begin
      buf_data_0 <= 32'h0;
    end else if (_T_3578) begin
      if (buf_error_en_0) begin
        buf_data_0 <= io_lsu_axi_rdata[31:0];
      end else if (buf_addr_0[2]) begin
        buf_data_0 <= io_lsu_axi_rdata[63:32];
      end else begin
        buf_data_0 <= io_lsu_axi_rdata[31:0];
      end
    end else if (_T_3612) begin
      if (_T_3692) begin
        if (buf_addr_0[2]) begin
          buf_data_0 <= io_lsu_axi_rdata[63:32];
        end else begin
          buf_data_0 <= io_lsu_axi_rdata[31:0];
        end
      end else begin
        buf_data_0 <= io_lsu_axi_rdata[31:0];
      end
    end else begin
      buf_data_0 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_1 <= 32'h0;
    end else if (_T_3744) begin
      if (_T_3759) begin
        buf_data_1 <= ibuf_data_out;
      end else begin
        buf_data_1 <= store_data_lo_r;
      end
    end else if (_T_3767) begin
      buf_data_1 <= 32'h0;
    end else if (_T_3771) begin
      if (buf_error_en_1) begin
        buf_data_1 <= io_lsu_axi_rdata[31:0];
      end else if (buf_addr_1[2]) begin
        buf_data_1 <= io_lsu_axi_rdata[63:32];
      end else begin
        buf_data_1 <= io_lsu_axi_rdata[31:0];
      end
    end else if (_T_3805) begin
      if (_T_3885) begin
        if (buf_addr_1[2]) begin
          buf_data_1 <= io_lsu_axi_rdata[63:32];
        end else begin
          buf_data_1 <= io_lsu_axi_rdata[31:0];
        end
      end else begin
        buf_data_1 <= io_lsu_axi_rdata[31:0];
      end
    end else begin
      buf_data_1 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_2 <= 32'h0;
    end else if (_T_3937) begin
      if (_T_3952) begin
        buf_data_2 <= ibuf_data_out;
      end else begin
        buf_data_2 <= store_data_lo_r;
      end
    end else if (_T_3960) begin
      buf_data_2 <= 32'h0;
    end else if (_T_3964) begin
      if (buf_error_en_2) begin
        buf_data_2 <= io_lsu_axi_rdata[31:0];
      end else if (buf_addr_2[2]) begin
        buf_data_2 <= io_lsu_axi_rdata[63:32];
      end else begin
        buf_data_2 <= io_lsu_axi_rdata[31:0];
      end
    end else if (_T_3998) begin
      if (_T_4078) begin
        if (buf_addr_2[2]) begin
          buf_data_2 <= io_lsu_axi_rdata[63:32];
        end else begin
          buf_data_2 <= io_lsu_axi_rdata[31:0];
        end
      end else begin
        buf_data_2 <= io_lsu_axi_rdata[31:0];
      end
    end else begin
      buf_data_2 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_3 <= 32'h0;
    end else if (_T_4130) begin
      if (_T_4145) begin
        buf_data_3 <= ibuf_data_out;
      end else begin
        buf_data_3 <= store_data_lo_r;
      end
    end else if (_T_4153) begin
      buf_data_3 <= 32'h0;
    end else if (_T_4157) begin
      if (buf_error_en_3) begin
        buf_data_3 <= io_lsu_axi_rdata[31:0];
      end else if (buf_addr_3[2]) begin
        buf_data_3 <= io_lsu_axi_rdata[63:32];
      end else begin
        buf_data_3 <= io_lsu_axi_rdata[31:0];
      end
    end else if (_T_4191) begin
      if (_T_4271) begin
        if (buf_addr_3[2]) begin
          buf_data_3 <= io_lsu_axi_rdata[63:32];
        end else begin
          buf_data_3 <= io_lsu_axi_rdata[31:0];
        end
      end else begin
        buf_data_3 <= io_lsu_axi_rdata[31:0];
      end
    end else begin
      buf_data_3 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      ibuf_data <= 32'h0;
    end else begin
      ibuf_data <= {_T_922,_T_893};
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_timer <= 3'h0;
    end else if (ibuf_wr_en) begin
      ibuf_timer <= 3'h0;
    end else if (_T_923) begin
      ibuf_timer <= _T_926;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_sideeffect <= 1'h0;
    end else if (_T_1011) begin
      ibuf_sideeffect <= io_is_sideeffects_r;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      WrPtr1_r <= 2'h0;
    end else if (_T_1937) begin
      WrPtr1_r <= 2'h0;
    end else if (_T_1951) begin
      WrPtr1_r <= 2'h1;
    end else if (_T_1965) begin
      WrPtr1_r <= 2'h2;
    end else begin
      WrPtr1_r <= 2'h3;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      WrPtr0_r <= 2'h0;
    end else if (_T_1886) begin
      WrPtr0_r <= 2'h0;
    end else if (_T_1897) begin
      WrPtr0_r <= 2'h1;
    end else if (_T_1908) begin
      WrPtr0_r <= 2'h2;
    end else begin
      WrPtr0_r <= 2'h3;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_tag <= 2'h0;
    end else if (_T_1011) begin
      if (!(_T_866)) begin
        if (io_ldst_dual_r) begin
          ibuf_tag <= WrPtr1_r;
        end else begin
          ibuf_tag <= WrPtr0_r;
        end
      end
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_dualtag <= 2'h0;
    end else if (_T_1011) begin
      ibuf_dualtag <= WrPtr0_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_dual <= 1'h0;
    end else if (_T_1011) begin
      ibuf_dual <= io_ldst_dual_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_samedw <= 1'h0;
    end else if (_T_1011) begin
      ibuf_samedw <= ldst_samedw_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_nomerge <= 1'h0;
    end else if (_T_1011) begin
      ibuf_nomerge <= io_no_dword_merge_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_unsign <= 1'h0;
    end else if (_T_1011) begin
      ibuf_unsign <= io_lsu_pkt_r_unsign;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_sz <= 2'h0;
    end else if (ibuf_wr_en) begin
      ibuf_sz <= ibuf_sz_in;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_wr_timer <= 3'h0;
    end else if (obuf_wr_en) begin
      obuf_wr_timer <= 3'h0;
    end else if (_T_1079) begin
      obuf_wr_timer <= _T_1081;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_nomerge_0 <= 1'h0;
    end else if (buf_wr_en_0) begin
      buf_nomerge_0 <= buf_nomerge_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_nomerge_1 <= 1'h0;
    end else if (buf_wr_en_1) begin
      buf_nomerge_1 <= buf_nomerge_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_nomerge_2 <= 1'h0;
    end else if (buf_wr_en_2) begin
      buf_nomerge_2 <= buf_nomerge_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_nomerge_3 <= 1'h0;
    end else if (buf_wr_en_3) begin
      buf_nomerge_3 <= buf_nomerge_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4353 <= 1'h0;
    end else if (buf_wr_en_3) begin
      _T_4353 <= buf_sideeffect_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4350 <= 1'h0;
    end else if (buf_wr_en_2) begin
      _T_4350 <= buf_sideeffect_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4347 <= 1'h0;
    end else if (buf_wr_en_1) begin
      _T_4347 <= buf_sideeffect_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4344 <= 1'h0;
    end else if (buf_wr_en_0) begin
      _T_4344 <= buf_sideeffect_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dual_3 <= 1'h0;
    end else if (buf_wr_en_3) begin
      buf_dual_3 <= buf_dual_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dual_2 <= 1'h0;
    end else if (buf_wr_en_2) begin
      buf_dual_2 <= buf_dual_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dual_1 <= 1'h0;
    end else if (buf_wr_en_1) begin
      buf_dual_1 <= buf_dual_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dual_0 <= 1'h0;
    end else if (buf_wr_en_0) begin
      buf_dual_0 <= buf_dual_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_samedw_3 <= 1'h0;
    end else if (buf_wr_en_3) begin
      buf_samedw_3 <= buf_samedw_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_samedw_2 <= 1'h0;
    end else if (buf_wr_en_2) begin
      buf_samedw_2 <= buf_samedw_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_samedw_1 <= 1'h0;
    end else if (buf_wr_en_1) begin
      buf_samedw_1 <= buf_samedw_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_samedw_0 <= 1'h0;
    end else if (buf_wr_en_0) begin
      buf_samedw_0 <= buf_samedw_in[0];
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_write <= 1'h0;
    end else if (obuf_wr_en) begin
      if (ibuf_buf_byp) begin
        obuf_write <= io_lsu_pkt_r_store;
      end else begin
        obuf_write <= _T_1223;
      end
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_cmd_done <= 1'h0;
    end else begin
      obuf_cmd_done <= _T_1328 & _T_4883;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_data_done <= 1'h0;
    end else begin
      obuf_data_done <= _T_1328 & _T_4884;
    end
  end
  always @(posedge io_lsu_free_c2_clk or posedge reset) begin
    if (reset) begin
      obuf_nosend <= 1'h0;
    end else if (obuf_wr_en) begin
      obuf_nosend <= obuf_nosend_in;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      obuf_addr <= 32'h0;
    end else if (ibuf_buf_byp) begin
      obuf_addr <= io_lsu_addr_r;
    end else begin
      obuf_addr <= _T_1310;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_sz_0 <= 2'h0;
    end else if (buf_wr_en_0) begin
      if (ibuf_drainvec_vld[0]) begin
        buf_sz_0 <= ibuf_sz;
      end else begin
        buf_sz_0 <= ibuf_sz_in;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_sz_1 <= 2'h0;
    end else if (buf_wr_en_1) begin
      if (ibuf_drainvec_vld[1]) begin
        buf_sz_1 <= ibuf_sz;
      end else begin
        buf_sz_1 <= ibuf_sz_in;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_sz_2 <= 2'h0;
    end else if (buf_wr_en_2) begin
      if (ibuf_drainvec_vld[2]) begin
        buf_sz_2 <= ibuf_sz;
      end else begin
        buf_sz_2 <= ibuf_sz_in;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_sz_3 <= 2'h0;
    end else if (buf_wr_en_3) begin
      if (ibuf_drainvec_vld[3]) begin
        buf_sz_3 <= ibuf_sz;
      end else begin
        buf_sz_3 <= ibuf_sz_in;
      end
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_sideeffect <= 1'h0;
    end else if (obuf_wr_en) begin
      if (ibuf_buf_byp) begin
        obuf_sideeffect <= io_is_sideeffects_r;
      end else begin
        obuf_sideeffect <= _T_1072;
      end
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_rdrsp_pend <= 1'h0;
    end else begin
      obuf_rdrsp_pend <= _T_1353 | _T_1357;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_rdrsp_tag <= 3'h0;
    end else if (_T_1359) begin
      obuf_rdrsp_tag <= obuf_tag0;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualhi_3 <= 1'h0;
    end else if (buf_wr_en_3) begin
      buf_dualhi_3 <= buf_dualhi_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualhi_2 <= 1'h0;
    end else if (buf_wr_en_2) begin
      buf_dualhi_2 <= buf_dualhi_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualhi_1 <= 1'h0;
    end else if (buf_wr_en_1) begin
      buf_dualhi_1 <= buf_dualhi_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualhi_0 <= 1'h0;
    end else if (buf_wr_en_0) begin
      buf_dualhi_0 <= buf_dualhi_in[0];
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_sz <= 2'h0;
    end else if (obuf_wr_en) begin
      if (ibuf_buf_byp) begin
        obuf_sz <= ibuf_sz_in;
      end else begin
        obuf_sz <= _T_1323;
      end
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_byteen <= 8'h0;
    end else if (obuf_wr_en) begin
      obuf_byteen <= obuf_byteen_in;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      obuf_data <= 64'h0;
    end else begin
      obuf_data <= {_T_1643,_T_1602};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_0 <= 4'h0;
    end else begin
      buf_rspageQ_0 <= {_T_3196,_T_3185};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_1 <= 4'h0;
    end else begin
      buf_rspageQ_1 <= {_T_3211,_T_3200};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_2 <= 4'h0;
    end else begin
      buf_rspageQ_2 <= {_T_3226,_T_3215};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_3 <= 4'h0;
    end else begin
      buf_rspageQ_3 <= {_T_3241,_T_3230};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4330 <= 1'h0;
    end else if (buf_ldfwd_en_3) begin
      if (_T_4130) begin
        _T_4330 <= 1'h0;
      end else if (_T_4153) begin
        _T_4330 <= 1'h0;
      end else begin
        _T_4330 <= _T_4157;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4328 <= 1'h0;
    end else if (buf_ldfwd_en_2) begin
      if (_T_3937) begin
        _T_4328 <= 1'h0;
      end else if (_T_3960) begin
        _T_4328 <= 1'h0;
      end else begin
        _T_4328 <= _T_3964;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4326 <= 1'h0;
    end else if (buf_ldfwd_en_1) begin
      if (_T_3744) begin
        _T_4326 <= 1'h0;
      end else if (_T_3767) begin
        _T_4326 <= 1'h0;
      end else begin
        _T_4326 <= _T_3771;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4324 <= 1'h0;
    end else if (buf_ldfwd_en_0) begin
      if (_T_3551) begin
        _T_4324 <= 1'h0;
      end else if (_T_3574) begin
        _T_4324 <= 1'h0;
      end else begin
        _T_4324 <= _T_3578;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ldfwdtag_0 <= 2'h0;
    end else if (buf_ldfwd_en_0) begin
      if (_T_3551) begin
        buf_ldfwdtag_0 <= 2'h0;
      end else if (_T_3574) begin
        buf_ldfwdtag_0 <= 2'h0;
      end else if (_T_3578) begin
        buf_ldfwdtag_0 <= obuf_rdrsp_tag[1:0];
      end else begin
        buf_ldfwdtag_0 <= 2'h0;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualtag_0 <= 2'h0;
    end else if (buf_wr_en_0) begin
      if (ibuf_drainvec_vld[0]) begin
        buf_dualtag_0 <= ibuf_dualtag;
      end else if (_T_3366) begin
        buf_dualtag_0 <= WrPtr0_r;
      end else begin
        buf_dualtag_0 <= WrPtr1_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ldfwdtag_3 <= 2'h0;
    end else if (buf_ldfwd_en_3) begin
      if (_T_4130) begin
        buf_ldfwdtag_3 <= 2'h0;
      end else if (_T_4153) begin
        buf_ldfwdtag_3 <= 2'h0;
      end else if (_T_4157) begin
        buf_ldfwdtag_3 <= obuf_rdrsp_tag[1:0];
      end else begin
        buf_ldfwdtag_3 <= 2'h0;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ldfwdtag_2 <= 2'h0;
    end else if (buf_ldfwd_en_2) begin
      if (_T_3937) begin
        buf_ldfwdtag_2 <= 2'h0;
      end else if (_T_3960) begin
        buf_ldfwdtag_2 <= 2'h0;
      end else if (_T_3964) begin
        buf_ldfwdtag_2 <= obuf_rdrsp_tag[1:0];
      end else begin
        buf_ldfwdtag_2 <= 2'h0;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ldfwdtag_1 <= 2'h0;
    end else if (buf_ldfwd_en_1) begin
      if (_T_3744) begin
        buf_ldfwdtag_1 <= 2'h0;
      end else if (_T_3767) begin
        buf_ldfwdtag_1 <= 2'h0;
      end else if (_T_3771) begin
        buf_ldfwdtag_1 <= obuf_rdrsp_tag[1:0];
      end else begin
        buf_ldfwdtag_1 <= 2'h0;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualtag_1 <= 2'h0;
    end else if (buf_wr_en_1) begin
      if (ibuf_drainvec_vld[1]) begin
        buf_dualtag_1 <= ibuf_dualtag;
      end else if (_T_3375) begin
        buf_dualtag_1 <= WrPtr0_r;
      end else begin
        buf_dualtag_1 <= WrPtr1_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualtag_2 <= 2'h0;
    end else if (buf_wr_en_2) begin
      if (ibuf_drainvec_vld[2]) begin
        buf_dualtag_2 <= ibuf_dualtag;
      end else if (_T_3384) begin
        buf_dualtag_2 <= WrPtr0_r;
      end else begin
        buf_dualtag_2 <= WrPtr1_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_dualtag_3 <= 2'h0;
    end else if (buf_wr_en_3) begin
      if (ibuf_drainvec_vld[3]) begin
        buf_dualtag_3 <= ibuf_dualtag;
      end else if (_T_3393) begin
        buf_dualtag_3 <= WrPtr0_r;
      end else begin
        buf_dualtag_3 <= WrPtr1_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4359 <= 1'h0;
    end else if (buf_wr_en_0) begin
      _T_4359 <= buf_unsign_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4362 <= 1'h0;
    end else if (buf_wr_en_1) begin
      _T_4362 <= buf_unsign_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4365 <= 1'h0;
    end else if (buf_wr_en_2) begin
      _T_4365 <= buf_unsign_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4368 <= 1'h0;
    end else if (buf_wr_en_3) begin
      _T_4368 <= buf_unsign_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4434 <= 1'h0;
    end else begin
      _T_4434 <= _T_4431 & _T_4432;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4429 <= 1'h0;
    end else begin
      _T_4429 <= _T_4426 & _T_4427;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4424 <= 1'h0;
    end else begin
      _T_4424 <= _T_4421 & _T_4422;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4419 <= 1'h0;
    end else begin
      _T_4419 <= _T_4416 & _T_4417;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      lsu_nonblock_load_valid_r <= 1'h0;
    end else begin
      lsu_nonblock_load_valid_r <= io_lsu_nonblock_load_valid_m;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_5011 <= 1'h0;
    end else begin
      _T_5011 <= _T_5008 & _T_4541;
    end
  end
endmodule
