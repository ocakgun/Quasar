module rvclkhdr(
  output  io_l1clk,
  input   io_clk,
  input   io_en,
  input   io_scan_mode
);
  wire  clkhdr_Q; // @[lib.scala 318:26]
  wire  clkhdr_CK; // @[lib.scala 318:26]
  wire  clkhdr_EN; // @[lib.scala 318:26]
  wire  clkhdr_SE; // @[lib.scala 318:26]
  gated_latch clkhdr ( // @[lib.scala 318:26]
    .Q(clkhdr_Q),
    .CK(clkhdr_CK),
    .EN(clkhdr_EN),
    .SE(clkhdr_SE)
  );
  assign io_l1clk = clkhdr_Q; // @[lib.scala 319:14]
  assign clkhdr_CK = io_clk; // @[lib.scala 320:18]
  assign clkhdr_EN = io_en; // @[lib.scala 321:18]
  assign clkhdr_SE = io_scan_mode; // @[lib.scala 322:18]
endmodule
module lsu_bus_buffer(
  input         clock,
  input         reset,
  input         io_scan_mode,
  output        io_tlu_busbuff_lsu_pmu_bus_trxn,
  output        io_tlu_busbuff_lsu_pmu_bus_misaligned,
  output        io_tlu_busbuff_lsu_pmu_bus_error,
  output        io_tlu_busbuff_lsu_pmu_bus_busy,
  input         io_tlu_busbuff_dec_tlu_external_ldfwd_disable,
  input         io_tlu_busbuff_dec_tlu_wb_coalescing_disable,
  input         io_tlu_busbuff_dec_tlu_sideeffect_posted_disable,
  output        io_tlu_busbuff_lsu_imprecise_error_load_any,
  output        io_tlu_busbuff_lsu_imprecise_error_store_any,
  output [31:0] io_tlu_busbuff_lsu_imprecise_error_addr_any,
  output        io_dctl_busbuff_lsu_nonblock_load_valid_m,
  output [1:0]  io_dctl_busbuff_lsu_nonblock_load_tag_m,
  output        io_dctl_busbuff_lsu_nonblock_load_inv_r,
  output [1:0]  io_dctl_busbuff_lsu_nonblock_load_inv_tag_r,
  output        io_dctl_busbuff_lsu_nonblock_load_data_valid,
  output        io_dctl_busbuff_lsu_nonblock_load_data_error,
  output [1:0]  io_dctl_busbuff_lsu_nonblock_load_data_tag,
  output [31:0] io_dctl_busbuff_lsu_nonblock_load_data,
  input         io_dec_tlu_force_halt,
  input         io_lsu_c2_r_clk,
  input         io_lsu_bus_ibuf_c1_clk,
  input         io_lsu_bus_obuf_c1_clk,
  input         io_lsu_bus_buf_c1_clk,
  input         io_lsu_free_c2_clk,
  input         io_lsu_busm_clk,
  input         io_dec_lsu_valid_raw_d,
  input         io_lsu_pkt_m_valid,
  input         io_lsu_pkt_m_bits_fast_int,
  input         io_lsu_pkt_m_bits_by,
  input         io_lsu_pkt_m_bits_half,
  input         io_lsu_pkt_m_bits_word,
  input         io_lsu_pkt_m_bits_dword,
  input         io_lsu_pkt_m_bits_load,
  input         io_lsu_pkt_m_bits_store,
  input         io_lsu_pkt_m_bits_unsign,
  input         io_lsu_pkt_m_bits_dma,
  input         io_lsu_pkt_m_bits_store_data_bypass_d,
  input         io_lsu_pkt_m_bits_load_ldst_bypass_d,
  input         io_lsu_pkt_m_bits_store_data_bypass_m,
  input         io_lsu_pkt_r_valid,
  input         io_lsu_pkt_r_bits_fast_int,
  input         io_lsu_pkt_r_bits_by,
  input         io_lsu_pkt_r_bits_half,
  input         io_lsu_pkt_r_bits_word,
  input         io_lsu_pkt_r_bits_dword,
  input         io_lsu_pkt_r_bits_load,
  input         io_lsu_pkt_r_bits_store,
  input         io_lsu_pkt_r_bits_unsign,
  input         io_lsu_pkt_r_bits_dma,
  input         io_lsu_pkt_r_bits_store_data_bypass_d,
  input         io_lsu_pkt_r_bits_load_ldst_bypass_d,
  input         io_lsu_pkt_r_bits_store_data_bypass_m,
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
  input         io_lsu_axi_aw_ready,
  output        io_lsu_axi_aw_valid,
  output [2:0]  io_lsu_axi_aw_bits_id,
  output [31:0] io_lsu_axi_aw_bits_addr,
  output [3:0]  io_lsu_axi_aw_bits_region,
  output [7:0]  io_lsu_axi_aw_bits_len,
  output [2:0]  io_lsu_axi_aw_bits_size,
  output [1:0]  io_lsu_axi_aw_bits_burst,
  output        io_lsu_axi_aw_bits_lock,
  output [3:0]  io_lsu_axi_aw_bits_cache,
  output [2:0]  io_lsu_axi_aw_bits_prot,
  output [3:0]  io_lsu_axi_aw_bits_qos,
  input         io_lsu_axi_w_ready,
  output        io_lsu_axi_w_valid,
  output [63:0] io_lsu_axi_w_bits_data,
  output [7:0]  io_lsu_axi_w_bits_strb,
  output        io_lsu_axi_w_bits_last,
  output        io_lsu_axi_b_ready,
  input         io_lsu_axi_b_valid,
  input  [1:0]  io_lsu_axi_b_bits_resp,
  input  [2:0]  io_lsu_axi_b_bits_id,
  input         io_lsu_axi_ar_ready,
  output        io_lsu_axi_ar_valid,
  output [2:0]  io_lsu_axi_ar_bits_id,
  output [31:0] io_lsu_axi_ar_bits_addr,
  output [3:0]  io_lsu_axi_ar_bits_region,
  output [7:0]  io_lsu_axi_ar_bits_len,
  output [2:0]  io_lsu_axi_ar_bits_size,
  output [1:0]  io_lsu_axi_ar_bits_burst,
  output        io_lsu_axi_ar_bits_lock,
  output [3:0]  io_lsu_axi_ar_bits_cache,
  output [2:0]  io_lsu_axi_ar_bits_prot,
  output [3:0]  io_lsu_axi_ar_bits_qos,
  output        io_lsu_axi_r_ready,
  input         io_lsu_axi_r_valid,
  input  [2:0]  io_lsu_axi_r_bits_id,
  input  [63:0] io_lsu_axi_r_bits_data,
  input  [1:0]  io_lsu_axi_r_bits_resp,
  input         io_lsu_axi_r_bits_last,
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
  output [31:0] io_ld_fwddata_buf_hi
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
  wire  rvclkhdr_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_1_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_1_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_1_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_1_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_2_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_2_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_2_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_2_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_3_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_3_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_3_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_3_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_4_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_4_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_4_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_4_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_5_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_5_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_5_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_5_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_6_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_6_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_6_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_6_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_7_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_7_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_7_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_7_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_8_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_8_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_8_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_8_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_9_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_9_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_9_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_9_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_10_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_10_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_10_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_10_io_scan_mode; // @[lib.scala 352:23]
  wire  rvclkhdr_11_io_l1clk; // @[lib.scala 352:23]
  wire  rvclkhdr_11_io_clk; // @[lib.scala 352:23]
  wire  rvclkhdr_11_io_en; // @[lib.scala 352:23]
  wire  rvclkhdr_11_io_scan_mode; // @[lib.scala 352:23]
  wire [3:0] ldst_byteen_hi_m = io_ldst_byteen_ext_m[7:4]; // @[lsu_bus_buffer.scala 72:46]
  wire [3:0] ldst_byteen_lo_m = io_ldst_byteen_ext_m[3:0]; // @[lsu_bus_buffer.scala 73:46]
  reg [31:0] buf_addr_0; // @[lib.scala 358:16]
  wire  _T_2 = io_lsu_addr_m[31:2] == buf_addr_0[31:2]; // @[lsu_bus_buffer.scala 75:74]
  reg  _T_4360; // @[Reg.scala 27:20]
  reg  _T_4357; // @[Reg.scala 27:20]
  reg  _T_4354; // @[Reg.scala 27:20]
  reg  _T_4351; // @[Reg.scala 27:20]
  wire [3:0] buf_write = {_T_4360,_T_4357,_T_4354,_T_4351}; // @[Cat.scala 29:58]
  wire  _T_4 = _T_2 & buf_write[0]; // @[lsu_bus_buffer.scala 75:98]
  reg [2:0] buf_state_0; // @[Reg.scala 27:20]
  wire  _T_5 = buf_state_0 != 3'h0; // @[lsu_bus_buffer.scala 75:129]
  wire  _T_6 = _T_4 & _T_5; // @[lsu_bus_buffer.scala 75:113]
  wire  ld_addr_hitvec_lo_0 = _T_6 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 75:141]
  reg [31:0] buf_addr_1; // @[lib.scala 358:16]
  wire  _T_9 = io_lsu_addr_m[31:2] == buf_addr_1[31:2]; // @[lsu_bus_buffer.scala 75:74]
  wire  _T_11 = _T_9 & buf_write[1]; // @[lsu_bus_buffer.scala 75:98]
  reg [2:0] buf_state_1; // @[Reg.scala 27:20]
  wire  _T_12 = buf_state_1 != 3'h0; // @[lsu_bus_buffer.scala 75:129]
  wire  _T_13 = _T_11 & _T_12; // @[lsu_bus_buffer.scala 75:113]
  wire  ld_addr_hitvec_lo_1 = _T_13 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 75:141]
  reg [31:0] buf_addr_2; // @[lib.scala 358:16]
  wire  _T_16 = io_lsu_addr_m[31:2] == buf_addr_2[31:2]; // @[lsu_bus_buffer.scala 75:74]
  wire  _T_18 = _T_16 & buf_write[2]; // @[lsu_bus_buffer.scala 75:98]
  reg [2:0] buf_state_2; // @[Reg.scala 27:20]
  wire  _T_19 = buf_state_2 != 3'h0; // @[lsu_bus_buffer.scala 75:129]
  wire  _T_20 = _T_18 & _T_19; // @[lsu_bus_buffer.scala 75:113]
  wire  ld_addr_hitvec_lo_2 = _T_20 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 75:141]
  reg [31:0] buf_addr_3; // @[lib.scala 358:16]
  wire  _T_23 = io_lsu_addr_m[31:2] == buf_addr_3[31:2]; // @[lsu_bus_buffer.scala 75:74]
  wire  _T_25 = _T_23 & buf_write[3]; // @[lsu_bus_buffer.scala 75:98]
  reg [2:0] buf_state_3; // @[Reg.scala 27:20]
  wire  _T_26 = buf_state_3 != 3'h0; // @[lsu_bus_buffer.scala 75:129]
  wire  _T_27 = _T_25 & _T_26; // @[lsu_bus_buffer.scala 75:113]
  wire  ld_addr_hitvec_lo_3 = _T_27 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 75:141]
  wire  _T_30 = io_end_addr_m[31:2] == buf_addr_0[31:2]; // @[lsu_bus_buffer.scala 76:74]
  wire  _T_32 = _T_30 & buf_write[0]; // @[lsu_bus_buffer.scala 76:98]
  wire  _T_34 = _T_32 & _T_5; // @[lsu_bus_buffer.scala 76:113]
  wire  ld_addr_hitvec_hi_0 = _T_34 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 76:141]
  wire  _T_37 = io_end_addr_m[31:2] == buf_addr_1[31:2]; // @[lsu_bus_buffer.scala 76:74]
  wire  _T_39 = _T_37 & buf_write[1]; // @[lsu_bus_buffer.scala 76:98]
  wire  _T_41 = _T_39 & _T_12; // @[lsu_bus_buffer.scala 76:113]
  wire  ld_addr_hitvec_hi_1 = _T_41 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 76:141]
  wire  _T_44 = io_end_addr_m[31:2] == buf_addr_2[31:2]; // @[lsu_bus_buffer.scala 76:74]
  wire  _T_46 = _T_44 & buf_write[2]; // @[lsu_bus_buffer.scala 76:98]
  wire  _T_48 = _T_46 & _T_19; // @[lsu_bus_buffer.scala 76:113]
  wire  ld_addr_hitvec_hi_2 = _T_48 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 76:141]
  wire  _T_51 = io_end_addr_m[31:2] == buf_addr_3[31:2]; // @[lsu_bus_buffer.scala 76:74]
  wire  _T_53 = _T_51 & buf_write[3]; // @[lsu_bus_buffer.scala 76:98]
  wire  _T_55 = _T_53 & _T_26; // @[lsu_bus_buffer.scala 76:113]
  wire  ld_addr_hitvec_hi_3 = _T_55 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 76:141]
  reg [3:0] buf_byteen_3; // @[Reg.scala 27:20]
  wire  _T_99 = ld_addr_hitvec_lo_3 & buf_byteen_3[0]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_101 = _T_99 & ldst_byteen_lo_m[0]; // @[lsu_bus_buffer.scala 140:114]
  reg [3:0] buf_byteen_2; // @[Reg.scala 27:20]
  wire  _T_95 = ld_addr_hitvec_lo_2 & buf_byteen_2[0]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_97 = _T_95 & ldst_byteen_lo_m[0]; // @[lsu_bus_buffer.scala 140:114]
  reg [3:0] buf_byteen_1; // @[Reg.scala 27:20]
  wire  _T_91 = ld_addr_hitvec_lo_1 & buf_byteen_1[0]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_93 = _T_91 & ldst_byteen_lo_m[0]; // @[lsu_bus_buffer.scala 140:114]
  reg [3:0] buf_byteen_0; // @[Reg.scala 27:20]
  wire  _T_87 = ld_addr_hitvec_lo_0 & buf_byteen_0[0]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_89 = _T_87 & ldst_byteen_lo_m[0]; // @[lsu_bus_buffer.scala 140:114]
  wire [3:0] ld_byte_hitvec_lo_0 = {_T_101,_T_97,_T_93,_T_89}; // @[Cat.scala 29:58]
  reg [3:0] buf_ageQ_3; // @[lsu_bus_buffer.scala 499:60]
  wire  _T_2621 = buf_state_3 == 3'h2; // @[lsu_bus_buffer.scala 411:93]
  wire  _T_4107 = 3'h0 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4130 = 3'h1 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4134 = 3'h2 == buf_state_3; // @[Conditional.scala 37:30]
  reg [1:0] _T_1848; // @[Reg.scala 27:20]
  wire [2:0] obuf_tag0 = {{1'd0}, _T_1848}; // @[lsu_bus_buffer.scala 351:13]
  wire  _T_4141 = obuf_tag0 == 3'h3; // @[lsu_bus_buffer.scala 454:48]
  reg  obuf_merge; // @[Reg.scala 27:20]
  reg [1:0] obuf_tag1; // @[Reg.scala 27:20]
  wire [2:0] _GEN_358 = {{1'd0}, obuf_tag1}; // @[lsu_bus_buffer.scala 454:104]
  wire  _T_4142 = _GEN_358 == 3'h3; // @[lsu_bus_buffer.scala 454:104]
  wire  _T_4143 = obuf_merge & _T_4142; // @[lsu_bus_buffer.scala 454:91]
  wire  _T_4144 = _T_4141 | _T_4143; // @[lsu_bus_buffer.scala 454:77]
  reg  obuf_valid; // @[lsu_bus_buffer.scala 345:54]
  wire  _T_4145 = _T_4144 & obuf_valid; // @[lsu_bus_buffer.scala 454:135]
  reg  obuf_wr_enQ; // @[lsu_bus_buffer.scala 344:55]
  wire  _T_4146 = _T_4145 & obuf_wr_enQ; // @[lsu_bus_buffer.scala 454:148]
  wire  _GEN_280 = _T_4134 & _T_4146; // @[Conditional.scala 39:67]
  wire  _GEN_293 = _T_4130 ? 1'h0 : _GEN_280; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_3 = _T_4107 ? 1'h0 : _GEN_293; // @[Conditional.scala 40:58]
  wire  _T_2622 = _T_2621 & buf_cmd_state_bus_en_3; // @[lsu_bus_buffer.scala 411:103]
  wire  _T_2623 = ~_T_2622; // @[lsu_bus_buffer.scala 411:78]
  wire  _T_2624 = buf_ageQ_3[3] & _T_2623; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2616 = buf_state_2 == 3'h2; // @[lsu_bus_buffer.scala 411:93]
  wire  _T_3914 = 3'h0 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_3937 = 3'h1 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_3941 = 3'h2 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_3948 = obuf_tag0 == 3'h2; // @[lsu_bus_buffer.scala 454:48]
  wire  _T_3949 = _GEN_358 == 3'h2; // @[lsu_bus_buffer.scala 454:104]
  wire  _T_3950 = obuf_merge & _T_3949; // @[lsu_bus_buffer.scala 454:91]
  wire  _T_3951 = _T_3948 | _T_3950; // @[lsu_bus_buffer.scala 454:77]
  wire  _T_3952 = _T_3951 & obuf_valid; // @[lsu_bus_buffer.scala 454:135]
  wire  _T_3953 = _T_3952 & obuf_wr_enQ; // @[lsu_bus_buffer.scala 454:148]
  wire  _GEN_204 = _T_3941 & _T_3953; // @[Conditional.scala 39:67]
  wire  _GEN_217 = _T_3937 ? 1'h0 : _GEN_204; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_2 = _T_3914 ? 1'h0 : _GEN_217; // @[Conditional.scala 40:58]
  wire  _T_2617 = _T_2616 & buf_cmd_state_bus_en_2; // @[lsu_bus_buffer.scala 411:103]
  wire  _T_2618 = ~_T_2617; // @[lsu_bus_buffer.scala 411:78]
  wire  _T_2619 = buf_ageQ_3[2] & _T_2618; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2611 = buf_state_1 == 3'h2; // @[lsu_bus_buffer.scala 411:93]
  wire  _T_3721 = 3'h0 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3744 = 3'h1 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3748 = 3'h2 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3755 = obuf_tag0 == 3'h1; // @[lsu_bus_buffer.scala 454:48]
  wire  _T_3756 = _GEN_358 == 3'h1; // @[lsu_bus_buffer.scala 454:104]
  wire  _T_3757 = obuf_merge & _T_3756; // @[lsu_bus_buffer.scala 454:91]
  wire  _T_3758 = _T_3755 | _T_3757; // @[lsu_bus_buffer.scala 454:77]
  wire  _T_3759 = _T_3758 & obuf_valid; // @[lsu_bus_buffer.scala 454:135]
  wire  _T_3760 = _T_3759 & obuf_wr_enQ; // @[lsu_bus_buffer.scala 454:148]
  wire  _GEN_128 = _T_3748 & _T_3760; // @[Conditional.scala 39:67]
  wire  _GEN_141 = _T_3744 ? 1'h0 : _GEN_128; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_1 = _T_3721 ? 1'h0 : _GEN_141; // @[Conditional.scala 40:58]
  wire  _T_2612 = _T_2611 & buf_cmd_state_bus_en_1; // @[lsu_bus_buffer.scala 411:103]
  wire  _T_2613 = ~_T_2612; // @[lsu_bus_buffer.scala 411:78]
  wire  _T_2614 = buf_ageQ_3[1] & _T_2613; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2606 = buf_state_0 == 3'h2; // @[lsu_bus_buffer.scala 411:93]
  wire  _T_3528 = 3'h0 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _T_3551 = 3'h1 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _T_3555 = 3'h2 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _T_3562 = obuf_tag0 == 3'h0; // @[lsu_bus_buffer.scala 454:48]
  wire  _T_3563 = _GEN_358 == 3'h0; // @[lsu_bus_buffer.scala 454:104]
  wire  _T_3564 = obuf_merge & _T_3563; // @[lsu_bus_buffer.scala 454:91]
  wire  _T_3565 = _T_3562 | _T_3564; // @[lsu_bus_buffer.scala 454:77]
  wire  _T_3566 = _T_3565 & obuf_valid; // @[lsu_bus_buffer.scala 454:135]
  wire  _T_3567 = _T_3566 & obuf_wr_enQ; // @[lsu_bus_buffer.scala 454:148]
  wire  _GEN_52 = _T_3555 & _T_3567; // @[Conditional.scala 39:67]
  wire  _GEN_65 = _T_3551 ? 1'h0 : _GEN_52; // @[Conditional.scala 39:67]
  wire  buf_cmd_state_bus_en_0 = _T_3528 ? 1'h0 : _GEN_65; // @[Conditional.scala 40:58]
  wire  _T_2607 = _T_2606 & buf_cmd_state_bus_en_0; // @[lsu_bus_buffer.scala 411:103]
  wire  _T_2608 = ~_T_2607; // @[lsu_bus_buffer.scala 411:78]
  wire  _T_2609 = buf_ageQ_3[0] & _T_2608; // @[lsu_bus_buffer.scala 411:76]
  wire [3:0] buf_age_3 = {_T_2624,_T_2619,_T_2614,_T_2609}; // @[Cat.scala 29:58]
  wire  _T_2723 = ~buf_age_3[2]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2725 = _T_2723 & _T_19; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2717 = ~buf_age_3[1]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2719 = _T_2717 & _T_12; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2711 = ~buf_age_3[0]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2713 = _T_2711 & _T_5; // @[lsu_bus_buffer.scala 412:104]
  wire [3:0] buf_age_younger_3 = {1'h0,_T_2725,_T_2719,_T_2713}; // @[Cat.scala 29:58]
  wire [3:0] _T_255 = ld_byte_hitvec_lo_0 & buf_age_younger_3; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_256 = |_T_255; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_257 = ~_T_256; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_258 = ld_byte_hitvec_lo_0[3] & _T_257; // @[lsu_bus_buffer.scala 145:97]
  reg [31:0] ibuf_addr; // @[lib.scala 358:16]
  wire  _T_512 = io_lsu_addr_m[31:2] == ibuf_addr[31:2]; // @[lsu_bus_buffer.scala 151:51]
  reg  ibuf_write; // @[Reg.scala 27:20]
  wire  _T_513 = _T_512 & ibuf_write; // @[lsu_bus_buffer.scala 151:73]
  reg  ibuf_valid; // @[lsu_bus_buffer.scala 238:54]
  wire  _T_514 = _T_513 & ibuf_valid; // @[lsu_bus_buffer.scala 151:86]
  wire  ld_addr_ibuf_hit_lo = _T_514 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 151:99]
  wire [3:0] _T_521 = ld_addr_ibuf_hit_lo ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  reg [3:0] ibuf_byteen; // @[Reg.scala 27:20]
  wire [3:0] _T_522 = _T_521 & ibuf_byteen; // @[lsu_bus_buffer.scala 156:55]
  wire [3:0] ld_byte_ibuf_hit_lo = _T_522 & ldst_byteen_lo_m; // @[lsu_bus_buffer.scala 156:69]
  wire  _T_260 = ~ld_byte_ibuf_hit_lo[0]; // @[lsu_bus_buffer.scala 145:150]
  wire  _T_261 = _T_258 & _T_260; // @[lsu_bus_buffer.scala 145:148]
  reg [3:0] buf_ageQ_2; // @[lsu_bus_buffer.scala 499:60]
  wire  _T_2601 = buf_ageQ_2[3] & _T_2623; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2596 = buf_ageQ_2[2] & _T_2618; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2591 = buf_ageQ_2[1] & _T_2613; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2586 = buf_ageQ_2[0] & _T_2608; // @[lsu_bus_buffer.scala 411:76]
  wire [3:0] buf_age_2 = {_T_2601,_T_2596,_T_2591,_T_2586}; // @[Cat.scala 29:58]
  wire  _T_2702 = ~buf_age_2[3]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2704 = _T_2702 & _T_26; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2690 = ~buf_age_2[1]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2692 = _T_2690 & _T_12; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2684 = ~buf_age_2[0]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2686 = _T_2684 & _T_5; // @[lsu_bus_buffer.scala 412:104]
  wire [3:0] buf_age_younger_2 = {_T_2704,1'h0,_T_2692,_T_2686}; // @[Cat.scala 29:58]
  wire [3:0] _T_247 = ld_byte_hitvec_lo_0 & buf_age_younger_2; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_248 = |_T_247; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_249 = ~_T_248; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_250 = ld_byte_hitvec_lo_0[2] & _T_249; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_253 = _T_250 & _T_260; // @[lsu_bus_buffer.scala 145:148]
  reg [3:0] buf_ageQ_1; // @[lsu_bus_buffer.scala 499:60]
  wire  _T_2578 = buf_ageQ_1[3] & _T_2623; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2573 = buf_ageQ_1[2] & _T_2618; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2568 = buf_ageQ_1[1] & _T_2613; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2563 = buf_ageQ_1[0] & _T_2608; // @[lsu_bus_buffer.scala 411:76]
  wire [3:0] buf_age_1 = {_T_2578,_T_2573,_T_2568,_T_2563}; // @[Cat.scala 29:58]
  wire  _T_2675 = ~buf_age_1[3]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2677 = _T_2675 & _T_26; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2669 = ~buf_age_1[2]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2671 = _T_2669 & _T_19; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2657 = ~buf_age_1[0]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2659 = _T_2657 & _T_5; // @[lsu_bus_buffer.scala 412:104]
  wire [3:0] buf_age_younger_1 = {_T_2677,_T_2671,1'h0,_T_2659}; // @[Cat.scala 29:58]
  wire [3:0] _T_239 = ld_byte_hitvec_lo_0 & buf_age_younger_1; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_240 = |_T_239; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_241 = ~_T_240; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_242 = ld_byte_hitvec_lo_0[1] & _T_241; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_245 = _T_242 & _T_260; // @[lsu_bus_buffer.scala 145:148]
  reg [3:0] buf_ageQ_0; // @[lsu_bus_buffer.scala 499:60]
  wire  _T_2555 = buf_ageQ_0[3] & _T_2623; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2550 = buf_ageQ_0[2] & _T_2618; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2545 = buf_ageQ_0[1] & _T_2613; // @[lsu_bus_buffer.scala 411:76]
  wire  _T_2540 = buf_ageQ_0[0] & _T_2608; // @[lsu_bus_buffer.scala 411:76]
  wire [3:0] buf_age_0 = {_T_2555,_T_2550,_T_2545,_T_2540}; // @[Cat.scala 29:58]
  wire  _T_2648 = ~buf_age_0[3]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2650 = _T_2648 & _T_26; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2642 = ~buf_age_0[2]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2644 = _T_2642 & _T_19; // @[lsu_bus_buffer.scala 412:104]
  wire  _T_2636 = ~buf_age_0[1]; // @[lsu_bus_buffer.scala 412:89]
  wire  _T_2638 = _T_2636 & _T_12; // @[lsu_bus_buffer.scala 412:104]
  wire [3:0] buf_age_younger_0 = {_T_2650,_T_2644,_T_2638,1'h0}; // @[Cat.scala 29:58]
  wire [3:0] _T_231 = ld_byte_hitvec_lo_0 & buf_age_younger_0; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_232 = |_T_231; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_233 = ~_T_232; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_234 = ld_byte_hitvec_lo_0[0] & _T_233; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_237 = _T_234 & _T_260; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] ld_byte_hitvecfn_lo_0 = {_T_261,_T_253,_T_245,_T_237}; // @[Cat.scala 29:58]
  wire  _T_56 = |ld_byte_hitvecfn_lo_0; // @[lsu_bus_buffer.scala 137:73]
  wire  _T_58 = _T_56 | ld_byte_ibuf_hit_lo[0]; // @[lsu_bus_buffer.scala 137:77]
  wire  _T_117 = ld_addr_hitvec_lo_3 & buf_byteen_3[1]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_119 = _T_117 & ldst_byteen_lo_m[1]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_113 = ld_addr_hitvec_lo_2 & buf_byteen_2[1]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_115 = _T_113 & ldst_byteen_lo_m[1]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_109 = ld_addr_hitvec_lo_1 & buf_byteen_1[1]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_111 = _T_109 & ldst_byteen_lo_m[1]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_105 = ld_addr_hitvec_lo_0 & buf_byteen_0[1]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_107 = _T_105 & ldst_byteen_lo_m[1]; // @[lsu_bus_buffer.scala 140:114]
  wire [3:0] ld_byte_hitvec_lo_1 = {_T_119,_T_115,_T_111,_T_107}; // @[Cat.scala 29:58]
  wire [3:0] _T_290 = ld_byte_hitvec_lo_1 & buf_age_younger_3; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_291 = |_T_290; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_292 = ~_T_291; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_293 = ld_byte_hitvec_lo_1[3] & _T_292; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_295 = ~ld_byte_ibuf_hit_lo[1]; // @[lsu_bus_buffer.scala 145:150]
  wire  _T_296 = _T_293 & _T_295; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_282 = ld_byte_hitvec_lo_1 & buf_age_younger_2; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_283 = |_T_282; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_284 = ~_T_283; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_285 = ld_byte_hitvec_lo_1[2] & _T_284; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_288 = _T_285 & _T_295; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_274 = ld_byte_hitvec_lo_1 & buf_age_younger_1; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_275 = |_T_274; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_276 = ~_T_275; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_277 = ld_byte_hitvec_lo_1[1] & _T_276; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_280 = _T_277 & _T_295; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_266 = ld_byte_hitvec_lo_1 & buf_age_younger_0; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_267 = |_T_266; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_268 = ~_T_267; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_269 = ld_byte_hitvec_lo_1[0] & _T_268; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_272 = _T_269 & _T_295; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] ld_byte_hitvecfn_lo_1 = {_T_296,_T_288,_T_280,_T_272}; // @[Cat.scala 29:58]
  wire  _T_59 = |ld_byte_hitvecfn_lo_1; // @[lsu_bus_buffer.scala 137:73]
  wire  _T_61 = _T_59 | ld_byte_ibuf_hit_lo[1]; // @[lsu_bus_buffer.scala 137:77]
  wire  _T_135 = ld_addr_hitvec_lo_3 & buf_byteen_3[2]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_137 = _T_135 & ldst_byteen_lo_m[2]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_131 = ld_addr_hitvec_lo_2 & buf_byteen_2[2]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_133 = _T_131 & ldst_byteen_lo_m[2]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_127 = ld_addr_hitvec_lo_1 & buf_byteen_1[2]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_129 = _T_127 & ldst_byteen_lo_m[2]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_123 = ld_addr_hitvec_lo_0 & buf_byteen_0[2]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_125 = _T_123 & ldst_byteen_lo_m[2]; // @[lsu_bus_buffer.scala 140:114]
  wire [3:0] ld_byte_hitvec_lo_2 = {_T_137,_T_133,_T_129,_T_125}; // @[Cat.scala 29:58]
  wire [3:0] _T_325 = ld_byte_hitvec_lo_2 & buf_age_younger_3; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_326 = |_T_325; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_327 = ~_T_326; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_328 = ld_byte_hitvec_lo_2[3] & _T_327; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_330 = ~ld_byte_ibuf_hit_lo[2]; // @[lsu_bus_buffer.scala 145:150]
  wire  _T_331 = _T_328 & _T_330; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_317 = ld_byte_hitvec_lo_2 & buf_age_younger_2; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_318 = |_T_317; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_319 = ~_T_318; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_320 = ld_byte_hitvec_lo_2[2] & _T_319; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_323 = _T_320 & _T_330; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_309 = ld_byte_hitvec_lo_2 & buf_age_younger_1; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_310 = |_T_309; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_311 = ~_T_310; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_312 = ld_byte_hitvec_lo_2[1] & _T_311; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_315 = _T_312 & _T_330; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_301 = ld_byte_hitvec_lo_2 & buf_age_younger_0; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_302 = |_T_301; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_303 = ~_T_302; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_304 = ld_byte_hitvec_lo_2[0] & _T_303; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_307 = _T_304 & _T_330; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] ld_byte_hitvecfn_lo_2 = {_T_331,_T_323,_T_315,_T_307}; // @[Cat.scala 29:58]
  wire  _T_62 = |ld_byte_hitvecfn_lo_2; // @[lsu_bus_buffer.scala 137:73]
  wire  _T_64 = _T_62 | ld_byte_ibuf_hit_lo[2]; // @[lsu_bus_buffer.scala 137:77]
  wire  _T_153 = ld_addr_hitvec_lo_3 & buf_byteen_3[3]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_155 = _T_153 & ldst_byteen_lo_m[3]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_149 = ld_addr_hitvec_lo_2 & buf_byteen_2[3]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_151 = _T_149 & ldst_byteen_lo_m[3]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_145 = ld_addr_hitvec_lo_1 & buf_byteen_1[3]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_147 = _T_145 & ldst_byteen_lo_m[3]; // @[lsu_bus_buffer.scala 140:114]
  wire  _T_141 = ld_addr_hitvec_lo_0 & buf_byteen_0[3]; // @[lsu_bus_buffer.scala 140:95]
  wire  _T_143 = _T_141 & ldst_byteen_lo_m[3]; // @[lsu_bus_buffer.scala 140:114]
  wire [3:0] ld_byte_hitvec_lo_3 = {_T_155,_T_151,_T_147,_T_143}; // @[Cat.scala 29:58]
  wire [3:0] _T_360 = ld_byte_hitvec_lo_3 & buf_age_younger_3; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_361 = |_T_360; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_362 = ~_T_361; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_363 = ld_byte_hitvec_lo_3[3] & _T_362; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_365 = ~ld_byte_ibuf_hit_lo[3]; // @[lsu_bus_buffer.scala 145:150]
  wire  _T_366 = _T_363 & _T_365; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_352 = ld_byte_hitvec_lo_3 & buf_age_younger_2; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_353 = |_T_352; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_354 = ~_T_353; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_355 = ld_byte_hitvec_lo_3[2] & _T_354; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_358 = _T_355 & _T_365; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_344 = ld_byte_hitvec_lo_3 & buf_age_younger_1; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_345 = |_T_344; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_346 = ~_T_345; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_347 = ld_byte_hitvec_lo_3[1] & _T_346; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_350 = _T_347 & _T_365; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] _T_336 = ld_byte_hitvec_lo_3 & buf_age_younger_0; // @[lsu_bus_buffer.scala 145:122]
  wire  _T_337 = |_T_336; // @[lsu_bus_buffer.scala 145:144]
  wire  _T_338 = ~_T_337; // @[lsu_bus_buffer.scala 145:99]
  wire  _T_339 = ld_byte_hitvec_lo_3[0] & _T_338; // @[lsu_bus_buffer.scala 145:97]
  wire  _T_342 = _T_339 & _T_365; // @[lsu_bus_buffer.scala 145:148]
  wire [3:0] ld_byte_hitvecfn_lo_3 = {_T_366,_T_358,_T_350,_T_342}; // @[Cat.scala 29:58]
  wire  _T_65 = |ld_byte_hitvecfn_lo_3; // @[lsu_bus_buffer.scala 137:73]
  wire  _T_67 = _T_65 | ld_byte_ibuf_hit_lo[3]; // @[lsu_bus_buffer.scala 137:77]
  wire [2:0] _T_69 = {_T_67,_T_64,_T_61}; // @[Cat.scala 29:58]
  wire  _T_171 = ld_addr_hitvec_hi_3 & buf_byteen_3[0]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_173 = _T_171 & ldst_byteen_hi_m[0]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_167 = ld_addr_hitvec_hi_2 & buf_byteen_2[0]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_169 = _T_167 & ldst_byteen_hi_m[0]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_163 = ld_addr_hitvec_hi_1 & buf_byteen_1[0]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_165 = _T_163 & ldst_byteen_hi_m[0]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_159 = ld_addr_hitvec_hi_0 & buf_byteen_0[0]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_161 = _T_159 & ldst_byteen_hi_m[0]; // @[lsu_bus_buffer.scala 141:114]
  wire [3:0] ld_byte_hitvec_hi_0 = {_T_173,_T_169,_T_165,_T_161}; // @[Cat.scala 29:58]
  wire [3:0] _T_395 = ld_byte_hitvec_hi_0 & buf_age_younger_3; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_396 = |_T_395; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_397 = ~_T_396; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_398 = ld_byte_hitvec_hi_0[3] & _T_397; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_517 = io_end_addr_m[31:2] == ibuf_addr[31:2]; // @[lsu_bus_buffer.scala 152:51]
  wire  _T_518 = _T_517 & ibuf_write; // @[lsu_bus_buffer.scala 152:73]
  wire  _T_519 = _T_518 & ibuf_valid; // @[lsu_bus_buffer.scala 152:86]
  wire  ld_addr_ibuf_hit_hi = _T_519 & io_lsu_busreq_m; // @[lsu_bus_buffer.scala 152:99]
  wire [3:0] _T_525 = ld_addr_ibuf_hit_hi ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_526 = _T_525 & ibuf_byteen; // @[lsu_bus_buffer.scala 157:55]
  wire [3:0] ld_byte_ibuf_hit_hi = _T_526 & ldst_byteen_hi_m; // @[lsu_bus_buffer.scala 157:69]
  wire  _T_400 = ~ld_byte_ibuf_hit_hi[0]; // @[lsu_bus_buffer.scala 146:150]
  wire  _T_401 = _T_398 & _T_400; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_387 = ld_byte_hitvec_hi_0 & buf_age_younger_2; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_388 = |_T_387; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_389 = ~_T_388; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_390 = ld_byte_hitvec_hi_0[2] & _T_389; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_393 = _T_390 & _T_400; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_379 = ld_byte_hitvec_hi_0 & buf_age_younger_1; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_380 = |_T_379; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_381 = ~_T_380; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_382 = ld_byte_hitvec_hi_0[1] & _T_381; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_385 = _T_382 & _T_400; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_371 = ld_byte_hitvec_hi_0 & buf_age_younger_0; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_372 = |_T_371; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_373 = ~_T_372; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_374 = ld_byte_hitvec_hi_0[0] & _T_373; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_377 = _T_374 & _T_400; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] ld_byte_hitvecfn_hi_0 = {_T_401,_T_393,_T_385,_T_377}; // @[Cat.scala 29:58]
  wire  _T_71 = |ld_byte_hitvecfn_hi_0; // @[lsu_bus_buffer.scala 138:73]
  wire  _T_73 = _T_71 | ld_byte_ibuf_hit_hi[0]; // @[lsu_bus_buffer.scala 138:77]
  wire  _T_189 = ld_addr_hitvec_hi_3 & buf_byteen_3[1]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_191 = _T_189 & ldst_byteen_hi_m[1]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_185 = ld_addr_hitvec_hi_2 & buf_byteen_2[1]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_187 = _T_185 & ldst_byteen_hi_m[1]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_181 = ld_addr_hitvec_hi_1 & buf_byteen_1[1]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_183 = _T_181 & ldst_byteen_hi_m[1]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_177 = ld_addr_hitvec_hi_0 & buf_byteen_0[1]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_179 = _T_177 & ldst_byteen_hi_m[1]; // @[lsu_bus_buffer.scala 141:114]
  wire [3:0] ld_byte_hitvec_hi_1 = {_T_191,_T_187,_T_183,_T_179}; // @[Cat.scala 29:58]
  wire [3:0] _T_430 = ld_byte_hitvec_hi_1 & buf_age_younger_3; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_431 = |_T_430; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_432 = ~_T_431; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_433 = ld_byte_hitvec_hi_1[3] & _T_432; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_435 = ~ld_byte_ibuf_hit_hi[1]; // @[lsu_bus_buffer.scala 146:150]
  wire  _T_436 = _T_433 & _T_435; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_422 = ld_byte_hitvec_hi_1 & buf_age_younger_2; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_423 = |_T_422; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_424 = ~_T_423; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_425 = ld_byte_hitvec_hi_1[2] & _T_424; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_428 = _T_425 & _T_435; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_414 = ld_byte_hitvec_hi_1 & buf_age_younger_1; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_415 = |_T_414; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_416 = ~_T_415; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_417 = ld_byte_hitvec_hi_1[1] & _T_416; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_420 = _T_417 & _T_435; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_406 = ld_byte_hitvec_hi_1 & buf_age_younger_0; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_407 = |_T_406; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_408 = ~_T_407; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_409 = ld_byte_hitvec_hi_1[0] & _T_408; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_412 = _T_409 & _T_435; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] ld_byte_hitvecfn_hi_1 = {_T_436,_T_428,_T_420,_T_412}; // @[Cat.scala 29:58]
  wire  _T_74 = |ld_byte_hitvecfn_hi_1; // @[lsu_bus_buffer.scala 138:73]
  wire  _T_76 = _T_74 | ld_byte_ibuf_hit_hi[1]; // @[lsu_bus_buffer.scala 138:77]
  wire  _T_207 = ld_addr_hitvec_hi_3 & buf_byteen_3[2]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_209 = _T_207 & ldst_byteen_hi_m[2]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_203 = ld_addr_hitvec_hi_2 & buf_byteen_2[2]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_205 = _T_203 & ldst_byteen_hi_m[2]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_199 = ld_addr_hitvec_hi_1 & buf_byteen_1[2]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_201 = _T_199 & ldst_byteen_hi_m[2]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_195 = ld_addr_hitvec_hi_0 & buf_byteen_0[2]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_197 = _T_195 & ldst_byteen_hi_m[2]; // @[lsu_bus_buffer.scala 141:114]
  wire [3:0] ld_byte_hitvec_hi_2 = {_T_209,_T_205,_T_201,_T_197}; // @[Cat.scala 29:58]
  wire [3:0] _T_465 = ld_byte_hitvec_hi_2 & buf_age_younger_3; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_466 = |_T_465; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_467 = ~_T_466; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_468 = ld_byte_hitvec_hi_2[3] & _T_467; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_470 = ~ld_byte_ibuf_hit_hi[2]; // @[lsu_bus_buffer.scala 146:150]
  wire  _T_471 = _T_468 & _T_470; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_457 = ld_byte_hitvec_hi_2 & buf_age_younger_2; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_458 = |_T_457; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_459 = ~_T_458; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_460 = ld_byte_hitvec_hi_2[2] & _T_459; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_463 = _T_460 & _T_470; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_449 = ld_byte_hitvec_hi_2 & buf_age_younger_1; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_450 = |_T_449; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_451 = ~_T_450; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_452 = ld_byte_hitvec_hi_2[1] & _T_451; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_455 = _T_452 & _T_470; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_441 = ld_byte_hitvec_hi_2 & buf_age_younger_0; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_442 = |_T_441; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_443 = ~_T_442; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_444 = ld_byte_hitvec_hi_2[0] & _T_443; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_447 = _T_444 & _T_470; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] ld_byte_hitvecfn_hi_2 = {_T_471,_T_463,_T_455,_T_447}; // @[Cat.scala 29:58]
  wire  _T_77 = |ld_byte_hitvecfn_hi_2; // @[lsu_bus_buffer.scala 138:73]
  wire  _T_79 = _T_77 | ld_byte_ibuf_hit_hi[2]; // @[lsu_bus_buffer.scala 138:77]
  wire  _T_225 = ld_addr_hitvec_hi_3 & buf_byteen_3[3]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_227 = _T_225 & ldst_byteen_hi_m[3]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_221 = ld_addr_hitvec_hi_2 & buf_byteen_2[3]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_223 = _T_221 & ldst_byteen_hi_m[3]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_217 = ld_addr_hitvec_hi_1 & buf_byteen_1[3]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_219 = _T_217 & ldst_byteen_hi_m[3]; // @[lsu_bus_buffer.scala 141:114]
  wire  _T_213 = ld_addr_hitvec_hi_0 & buf_byteen_0[3]; // @[lsu_bus_buffer.scala 141:95]
  wire  _T_215 = _T_213 & ldst_byteen_hi_m[3]; // @[lsu_bus_buffer.scala 141:114]
  wire [3:0] ld_byte_hitvec_hi_3 = {_T_227,_T_223,_T_219,_T_215}; // @[Cat.scala 29:58]
  wire [3:0] _T_500 = ld_byte_hitvec_hi_3 & buf_age_younger_3; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_501 = |_T_500; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_502 = ~_T_501; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_503 = ld_byte_hitvec_hi_3[3] & _T_502; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_505 = ~ld_byte_ibuf_hit_hi[3]; // @[lsu_bus_buffer.scala 146:150]
  wire  _T_506 = _T_503 & _T_505; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_492 = ld_byte_hitvec_hi_3 & buf_age_younger_2; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_493 = |_T_492; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_494 = ~_T_493; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_495 = ld_byte_hitvec_hi_3[2] & _T_494; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_498 = _T_495 & _T_505; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_484 = ld_byte_hitvec_hi_3 & buf_age_younger_1; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_485 = |_T_484; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_486 = ~_T_485; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_487 = ld_byte_hitvec_hi_3[1] & _T_486; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_490 = _T_487 & _T_505; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] _T_476 = ld_byte_hitvec_hi_3 & buf_age_younger_0; // @[lsu_bus_buffer.scala 146:122]
  wire  _T_477 = |_T_476; // @[lsu_bus_buffer.scala 146:144]
  wire  _T_478 = ~_T_477; // @[lsu_bus_buffer.scala 146:99]
  wire  _T_479 = ld_byte_hitvec_hi_3[0] & _T_478; // @[lsu_bus_buffer.scala 146:97]
  wire  _T_482 = _T_479 & _T_505; // @[lsu_bus_buffer.scala 146:148]
  wire [3:0] ld_byte_hitvecfn_hi_3 = {_T_506,_T_498,_T_490,_T_482}; // @[Cat.scala 29:58]
  wire  _T_80 = |ld_byte_hitvecfn_hi_3; // @[lsu_bus_buffer.scala 138:73]
  wire  _T_82 = _T_80 | ld_byte_ibuf_hit_hi[3]; // @[lsu_bus_buffer.scala 138:77]
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
  reg [31:0] buf_data_0; // @[lib.scala 358:16]
  wire [7:0] _T_560 = _T_558 & buf_data_0[31:24]; // @[lsu_bus_buffer.scala 164:91]
  wire [7:0] _T_563 = ld_byte_hitvecfn_lo_3[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_1; // @[lib.scala 358:16]
  wire [7:0] _T_565 = _T_563 & buf_data_1[31:24]; // @[lsu_bus_buffer.scala 164:91]
  wire [7:0] _T_568 = ld_byte_hitvecfn_lo_3[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_2; // @[lib.scala 358:16]
  wire [7:0] _T_570 = _T_568 & buf_data_2[31:24]; // @[lsu_bus_buffer.scala 164:91]
  wire [7:0] _T_573 = ld_byte_hitvecfn_lo_3[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  reg [31:0] buf_data_3; // @[lib.scala 358:16]
  wire [7:0] _T_575 = _T_573 & buf_data_3[31:24]; // @[lsu_bus_buffer.scala 164:91]
  wire [7:0] _T_576 = _T_560 | _T_565; // @[lsu_bus_buffer.scala 164:123]
  wire [7:0] _T_577 = _T_576 | _T_570; // @[lsu_bus_buffer.scala 164:123]
  wire [7:0] _T_578 = _T_577 | _T_575; // @[lsu_bus_buffer.scala 164:123]
  wire [7:0] _T_581 = ld_byte_hitvecfn_lo_2[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_583 = _T_581 & buf_data_0[23:16]; // @[lsu_bus_buffer.scala 165:65]
  wire [7:0] _T_586 = ld_byte_hitvecfn_lo_2[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_588 = _T_586 & buf_data_1[23:16]; // @[lsu_bus_buffer.scala 165:65]
  wire [7:0] _T_591 = ld_byte_hitvecfn_lo_2[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_593 = _T_591 & buf_data_2[23:16]; // @[lsu_bus_buffer.scala 165:65]
  wire [7:0] _T_596 = ld_byte_hitvecfn_lo_2[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_598 = _T_596 & buf_data_3[23:16]; // @[lsu_bus_buffer.scala 165:65]
  wire [7:0] _T_599 = _T_583 | _T_588; // @[lsu_bus_buffer.scala 165:97]
  wire [7:0] _T_600 = _T_599 | _T_593; // @[lsu_bus_buffer.scala 165:97]
  wire [7:0] _T_601 = _T_600 | _T_598; // @[lsu_bus_buffer.scala 165:97]
  wire [7:0] _T_604 = ld_byte_hitvecfn_lo_1[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_606 = _T_604 & buf_data_0[15:8]; // @[lsu_bus_buffer.scala 166:65]
  wire [7:0] _T_609 = ld_byte_hitvecfn_lo_1[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_611 = _T_609 & buf_data_1[15:8]; // @[lsu_bus_buffer.scala 166:65]
  wire [7:0] _T_614 = ld_byte_hitvecfn_lo_1[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_616 = _T_614 & buf_data_2[15:8]; // @[lsu_bus_buffer.scala 166:65]
  wire [7:0] _T_619 = ld_byte_hitvecfn_lo_1[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_621 = _T_619 & buf_data_3[15:8]; // @[lsu_bus_buffer.scala 166:65]
  wire [7:0] _T_622 = _T_606 | _T_611; // @[lsu_bus_buffer.scala 166:97]
  wire [7:0] _T_623 = _T_622 | _T_616; // @[lsu_bus_buffer.scala 166:97]
  wire [7:0] _T_624 = _T_623 | _T_621; // @[lsu_bus_buffer.scala 166:97]
  wire [7:0] _T_627 = ld_byte_hitvecfn_lo_0[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_629 = _T_627 & buf_data_0[7:0]; // @[lsu_bus_buffer.scala 167:65]
  wire [7:0] _T_632 = ld_byte_hitvecfn_lo_0[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_634 = _T_632 & buf_data_1[7:0]; // @[lsu_bus_buffer.scala 167:65]
  wire [7:0] _T_637 = ld_byte_hitvecfn_lo_0[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_639 = _T_637 & buf_data_2[7:0]; // @[lsu_bus_buffer.scala 167:65]
  wire [7:0] _T_642 = ld_byte_hitvecfn_lo_0[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_644 = _T_642 & buf_data_3[7:0]; // @[lsu_bus_buffer.scala 167:65]
  wire [7:0] _T_645 = _T_629 | _T_634; // @[lsu_bus_buffer.scala 167:97]
  wire [7:0] _T_646 = _T_645 | _T_639; // @[lsu_bus_buffer.scala 167:97]
  wire [7:0] _T_647 = _T_646 | _T_644; // @[lsu_bus_buffer.scala 167:97]
  wire [31:0] _T_650 = {_T_578,_T_601,_T_624,_T_647}; // @[Cat.scala 29:58]
  reg [31:0] ibuf_data; // @[lib.scala 358:16]
  wire [31:0] _T_651 = ld_fwddata_buf_lo_initial & ibuf_data; // @[lsu_bus_buffer.scala 168:32]
  wire [7:0] _T_655 = ld_byte_hitvecfn_hi_3[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_657 = _T_655 & buf_data_0[31:24]; // @[lsu_bus_buffer.scala 170:91]
  wire [7:0] _T_660 = ld_byte_hitvecfn_hi_3[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_662 = _T_660 & buf_data_1[31:24]; // @[lsu_bus_buffer.scala 170:91]
  wire [7:0] _T_665 = ld_byte_hitvecfn_hi_3[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_667 = _T_665 & buf_data_2[31:24]; // @[lsu_bus_buffer.scala 170:91]
  wire [7:0] _T_670 = ld_byte_hitvecfn_hi_3[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_672 = _T_670 & buf_data_3[31:24]; // @[lsu_bus_buffer.scala 170:91]
  wire [7:0] _T_673 = _T_657 | _T_662; // @[lsu_bus_buffer.scala 170:123]
  wire [7:0] _T_674 = _T_673 | _T_667; // @[lsu_bus_buffer.scala 170:123]
  wire [7:0] _T_675 = _T_674 | _T_672; // @[lsu_bus_buffer.scala 170:123]
  wire [7:0] _T_678 = ld_byte_hitvecfn_hi_2[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_680 = _T_678 & buf_data_0[23:16]; // @[lsu_bus_buffer.scala 171:65]
  wire [7:0] _T_683 = ld_byte_hitvecfn_hi_2[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_685 = _T_683 & buf_data_1[23:16]; // @[lsu_bus_buffer.scala 171:65]
  wire [7:0] _T_688 = ld_byte_hitvecfn_hi_2[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_690 = _T_688 & buf_data_2[23:16]; // @[lsu_bus_buffer.scala 171:65]
  wire [7:0] _T_693 = ld_byte_hitvecfn_hi_2[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_695 = _T_693 & buf_data_3[23:16]; // @[lsu_bus_buffer.scala 171:65]
  wire [7:0] _T_696 = _T_680 | _T_685; // @[lsu_bus_buffer.scala 171:97]
  wire [7:0] _T_697 = _T_696 | _T_690; // @[lsu_bus_buffer.scala 171:97]
  wire [7:0] _T_698 = _T_697 | _T_695; // @[lsu_bus_buffer.scala 171:97]
  wire [7:0] _T_701 = ld_byte_hitvecfn_hi_1[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_703 = _T_701 & buf_data_0[15:8]; // @[lsu_bus_buffer.scala 172:65]
  wire [7:0] _T_706 = ld_byte_hitvecfn_hi_1[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_708 = _T_706 & buf_data_1[15:8]; // @[lsu_bus_buffer.scala 172:65]
  wire [7:0] _T_711 = ld_byte_hitvecfn_hi_1[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_713 = _T_711 & buf_data_2[15:8]; // @[lsu_bus_buffer.scala 172:65]
  wire [7:0] _T_716 = ld_byte_hitvecfn_hi_1[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_718 = _T_716 & buf_data_3[15:8]; // @[lsu_bus_buffer.scala 172:65]
  wire [7:0] _T_719 = _T_703 | _T_708; // @[lsu_bus_buffer.scala 172:97]
  wire [7:0] _T_720 = _T_719 | _T_713; // @[lsu_bus_buffer.scala 172:97]
  wire [7:0] _T_721 = _T_720 | _T_718; // @[lsu_bus_buffer.scala 172:97]
  wire [7:0] _T_724 = ld_byte_hitvecfn_hi_0[0] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_726 = _T_724 & buf_data_0[7:0]; // @[lsu_bus_buffer.scala 173:65]
  wire [7:0] _T_729 = ld_byte_hitvecfn_hi_0[1] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_731 = _T_729 & buf_data_1[7:0]; // @[lsu_bus_buffer.scala 173:65]
  wire [7:0] _T_734 = ld_byte_hitvecfn_hi_0[2] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_736 = _T_734 & buf_data_2[7:0]; // @[lsu_bus_buffer.scala 173:65]
  wire [7:0] _T_739 = ld_byte_hitvecfn_hi_0[3] ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire [7:0] _T_741 = _T_739 & buf_data_3[7:0]; // @[lsu_bus_buffer.scala 173:65]
  wire [7:0] _T_742 = _T_726 | _T_731; // @[lsu_bus_buffer.scala 173:97]
  wire [7:0] _T_743 = _T_742 | _T_736; // @[lsu_bus_buffer.scala 173:97]
  wire [7:0] _T_744 = _T_743 | _T_741; // @[lsu_bus_buffer.scala 173:97]
  wire [31:0] _T_747 = {_T_675,_T_698,_T_721,_T_744}; // @[Cat.scala 29:58]
  wire [31:0] _T_748 = ld_fwddata_buf_hi_initial & ibuf_data; // @[lsu_bus_buffer.scala 174:32]
  wire [3:0] _T_750 = io_lsu_pkt_r_bits_by ? 4'h1 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_751 = io_lsu_pkt_r_bits_half ? 4'h3 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_752 = io_lsu_pkt_r_bits_word ? 4'hf : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_753 = _T_750 | _T_751; // @[Mux.scala 27:72]
  wire [3:0] ldst_byteen_r = _T_753 | _T_752; // @[Mux.scala 27:72]
  wire  _T_756 = io_lsu_addr_r[1:0] == 2'h0; // @[lsu_bus_buffer.scala 181:55]
  wire  _T_758 = io_lsu_addr_r[1:0] == 2'h1; // @[lsu_bus_buffer.scala 182:24]
  wire [3:0] _T_760 = {3'h0,ldst_byteen_r[3]}; // @[Cat.scala 29:58]
  wire  _T_762 = io_lsu_addr_r[1:0] == 2'h2; // @[lsu_bus_buffer.scala 183:24]
  wire [3:0] _T_764 = {2'h0,ldst_byteen_r[3:2]}; // @[Cat.scala 29:58]
  wire  _T_766 = io_lsu_addr_r[1:0] == 2'h3; // @[lsu_bus_buffer.scala 184:24]
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
  wire [31:0] _T_802 = {24'h0,io_store_data_r[31:24]}; // @[Cat.scala 29:58]
  wire [31:0] _T_806 = {16'h0,io_store_data_r[31:16]}; // @[Cat.scala 29:58]
  wire [31:0] _T_810 = {8'h0,io_store_data_r[31:8]}; // @[Cat.scala 29:58]
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
  wire  ldst_samedw_r = io_lsu_addr_r[3] == io_end_addr_r[3]; // @[lsu_bus_buffer.scala 201:40]
  wire  _T_844 = ~io_lsu_addr_r[0]; // @[lsu_bus_buffer.scala 203:31]
  wire  _T_845 = io_lsu_pkt_r_bits_word & _T_756; // @[Mux.scala 27:72]
  wire  _T_846 = io_lsu_pkt_r_bits_half & _T_844; // @[Mux.scala 27:72]
  wire  _T_848 = _T_845 | _T_846; // @[Mux.scala 27:72]
  wire  is_aligned_r = _T_848 | io_lsu_pkt_r_bits_by; // @[Mux.scala 27:72]
  wire  _T_850 = io_lsu_pkt_r_bits_load | io_no_word_merge_r; // @[lsu_bus_buffer.scala 205:60]
  wire  _T_851 = io_lsu_busreq_r & _T_850; // @[lsu_bus_buffer.scala 205:34]
  wire  _T_852 = ~ibuf_valid; // @[lsu_bus_buffer.scala 205:84]
  wire  ibuf_byp = _T_851 & _T_852; // @[lsu_bus_buffer.scala 205:82]
  wire  _T_853 = io_lsu_busreq_r & io_lsu_commit_r; // @[lsu_bus_buffer.scala 206:36]
  wire  _T_854 = ~ibuf_byp; // @[lsu_bus_buffer.scala 206:56]
  wire  ibuf_wr_en = _T_853 & _T_854; // @[lsu_bus_buffer.scala 206:54]
  wire  _T_855 = ~ibuf_wr_en; // @[lsu_bus_buffer.scala 208:36]
  reg [2:0] ibuf_timer; // @[lsu_bus_buffer.scala 251:55]
  wire  _T_864 = ibuf_timer == 3'h7; // @[lsu_bus_buffer.scala 214:62]
  wire  _T_865 = ibuf_wr_en | _T_864; // @[lsu_bus_buffer.scala 214:48]
  wire  _T_929 = _T_853 & io_lsu_pkt_r_bits_store; // @[lsu_bus_buffer.scala 233:54]
  wire  _T_930 = _T_929 & ibuf_valid; // @[lsu_bus_buffer.scala 233:80]
  wire  _T_931 = _T_930 & ibuf_write; // @[lsu_bus_buffer.scala 233:93]
  wire  _T_934 = io_lsu_addr_r[31:2] == ibuf_addr[31:2]; // @[lsu_bus_buffer.scala 233:129]
  wire  _T_935 = _T_931 & _T_934; // @[lsu_bus_buffer.scala 233:106]
  wire  _T_936 = ~io_is_sideeffects_r; // @[lsu_bus_buffer.scala 233:152]
  wire  _T_937 = _T_935 & _T_936; // @[lsu_bus_buffer.scala 233:150]
  wire  _T_938 = ~io_tlu_busbuff_dec_tlu_wb_coalescing_disable; // @[lsu_bus_buffer.scala 233:175]
  wire  ibuf_merge_en = _T_937 & _T_938; // @[lsu_bus_buffer.scala 233:173]
  wire  ibuf_merge_in = ~io_ldst_dual_r; // @[lsu_bus_buffer.scala 234:20]
  wire  _T_866 = ibuf_merge_en & ibuf_merge_in; // @[lsu_bus_buffer.scala 214:98]
  wire  _T_867 = ~_T_866; // @[lsu_bus_buffer.scala 214:82]
  wire  _T_868 = _T_865 & _T_867; // @[lsu_bus_buffer.scala 214:80]
  wire  _T_869 = _T_868 | ibuf_byp; // @[lsu_bus_buffer.scala 215:5]
  wire  _T_857 = ~io_lsu_busreq_r; // @[lsu_bus_buffer.scala 209:44]
  wire  _T_858 = io_lsu_busreq_m & _T_857; // @[lsu_bus_buffer.scala 209:42]
  wire  _T_859 = _T_858 & ibuf_valid; // @[lsu_bus_buffer.scala 209:61]
  wire  _T_862 = ibuf_addr[31:2] != io_lsu_addr_m[31:2]; // @[lsu_bus_buffer.scala 209:120]
  wire  _T_863 = io_lsu_pkt_m_bits_load | _T_862; // @[lsu_bus_buffer.scala 209:100]
  wire  ibuf_force_drain = _T_859 & _T_863; // @[lsu_bus_buffer.scala 209:74]
  wire  _T_870 = _T_869 | ibuf_force_drain; // @[lsu_bus_buffer.scala 215:16]
  reg  ibuf_sideeffect; // @[Reg.scala 27:20]
  wire  _T_871 = _T_870 | ibuf_sideeffect; // @[lsu_bus_buffer.scala 215:35]
  wire  _T_872 = ~ibuf_write; // @[lsu_bus_buffer.scala 215:55]
  wire  _T_873 = _T_871 | _T_872; // @[lsu_bus_buffer.scala 215:53]
  wire  _T_874 = _T_873 | io_tlu_busbuff_dec_tlu_wb_coalescing_disable; // @[lsu_bus_buffer.scala 215:67]
  wire  ibuf_drain_vld = ibuf_valid & _T_874; // @[lsu_bus_buffer.scala 214:32]
  wire  _T_856 = ibuf_drain_vld & _T_855; // @[lsu_bus_buffer.scala 208:34]
  wire  ibuf_rst = _T_856 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 208:49]
  reg [1:0] WrPtr1_r; // @[lsu_bus_buffer.scala 615:49]
  reg [1:0] WrPtr0_r; // @[lsu_bus_buffer.scala 614:49]
  reg [1:0] ibuf_tag; // @[Reg.scala 27:20]
  wire [1:0] ibuf_sz_in = {io_lsu_pkt_r_bits_word,io_lsu_pkt_r_bits_half}; // @[Cat.scala 29:58]
  wire [3:0] _T_881 = ibuf_byteen | ldst_byteen_lo_r; // @[lsu_bus_buffer.scala 224:77]
  wire [7:0] _T_889 = ldst_byteen_lo_r[0] ? store_data_lo_r[7:0] : ibuf_data[7:0]; // @[lsu_bus_buffer.scala 229:8]
  wire [7:0] _T_892 = io_ldst_dual_r ? store_data_hi_r[7:0] : store_data_lo_r[7:0]; // @[lsu_bus_buffer.scala 230:8]
  wire [7:0] _T_893 = _T_866 ? _T_889 : _T_892; // @[lsu_bus_buffer.scala 228:46]
  wire [7:0] _T_898 = ldst_byteen_lo_r[1] ? store_data_lo_r[15:8] : ibuf_data[15:8]; // @[lsu_bus_buffer.scala 229:8]
  wire [7:0] _T_901 = io_ldst_dual_r ? store_data_hi_r[15:8] : store_data_lo_r[15:8]; // @[lsu_bus_buffer.scala 230:8]
  wire [7:0] _T_902 = _T_866 ? _T_898 : _T_901; // @[lsu_bus_buffer.scala 228:46]
  wire [7:0] _T_907 = ldst_byteen_lo_r[2] ? store_data_lo_r[23:16] : ibuf_data[23:16]; // @[lsu_bus_buffer.scala 229:8]
  wire [7:0] _T_910 = io_ldst_dual_r ? store_data_hi_r[23:16] : store_data_lo_r[23:16]; // @[lsu_bus_buffer.scala 230:8]
  wire [7:0] _T_911 = _T_866 ? _T_907 : _T_910; // @[lsu_bus_buffer.scala 228:46]
  wire [7:0] _T_916 = ldst_byteen_lo_r[3] ? store_data_lo_r[31:24] : ibuf_data[31:24]; // @[lsu_bus_buffer.scala 229:8]
  wire [7:0] _T_919 = io_ldst_dual_r ? store_data_hi_r[31:24] : store_data_lo_r[31:24]; // @[lsu_bus_buffer.scala 230:8]
  wire [7:0] _T_920 = _T_866 ? _T_916 : _T_919; // @[lsu_bus_buffer.scala 228:46]
  wire [23:0] _T_922 = {_T_920,_T_911,_T_902}; // @[Cat.scala 29:58]
  wire  _T_923 = ibuf_timer < 3'h7; // @[lsu_bus_buffer.scala 231:59]
  wire [2:0] _T_926 = ibuf_timer + 3'h1; // @[lsu_bus_buffer.scala 231:93]
  wire  _T_941 = ~ibuf_merge_in; // @[lsu_bus_buffer.scala 235:65]
  wire  _T_942 = ibuf_merge_en & _T_941; // @[lsu_bus_buffer.scala 235:63]
  wire  _T_945 = ibuf_byteen[0] | ldst_byteen_lo_r[0]; // @[lsu_bus_buffer.scala 235:96]
  wire  _T_947 = _T_942 ? _T_945 : ibuf_byteen[0]; // @[lsu_bus_buffer.scala 235:48]
  wire  _T_952 = ibuf_byteen[1] | ldst_byteen_lo_r[1]; // @[lsu_bus_buffer.scala 235:96]
  wire  _T_954 = _T_942 ? _T_952 : ibuf_byteen[1]; // @[lsu_bus_buffer.scala 235:48]
  wire  _T_959 = ibuf_byteen[2] | ldst_byteen_lo_r[2]; // @[lsu_bus_buffer.scala 235:96]
  wire  _T_961 = _T_942 ? _T_959 : ibuf_byteen[2]; // @[lsu_bus_buffer.scala 235:48]
  wire  _T_966 = ibuf_byteen[3] | ldst_byteen_lo_r[3]; // @[lsu_bus_buffer.scala 235:96]
  wire  _T_968 = _T_942 ? _T_966 : ibuf_byteen[3]; // @[lsu_bus_buffer.scala 235:48]
  wire [3:0] ibuf_byteen_out = {_T_968,_T_961,_T_954,_T_947}; // @[Cat.scala 29:58]
  wire [7:0] _T_978 = _T_942 ? _T_889 : ibuf_data[7:0]; // @[lsu_bus_buffer.scala 236:45]
  wire [7:0] _T_986 = _T_942 ? _T_898 : ibuf_data[15:8]; // @[lsu_bus_buffer.scala 236:45]
  wire [7:0] _T_994 = _T_942 ? _T_907 : ibuf_data[23:16]; // @[lsu_bus_buffer.scala 236:45]
  wire [7:0] _T_1002 = _T_942 ? _T_916 : ibuf_data[31:24]; // @[lsu_bus_buffer.scala 236:45]
  wire [31:0] ibuf_data_out = {_T_1002,_T_994,_T_986,_T_978}; // @[Cat.scala 29:58]
  wire  _T_1005 = ibuf_wr_en | ibuf_valid; // @[lsu_bus_buffer.scala 238:58]
  wire  _T_1006 = ~ibuf_rst; // @[lsu_bus_buffer.scala 238:93]
  reg [1:0] ibuf_dualtag; // @[Reg.scala 27:20]
  reg  ibuf_dual; // @[Reg.scala 27:20]
  reg  ibuf_samedw; // @[Reg.scala 27:20]
  reg  ibuf_nomerge; // @[Reg.scala 27:20]
  reg  ibuf_unsign; // @[Reg.scala 27:20]
  reg [1:0] ibuf_sz; // @[Reg.scala 27:20]
  wire  _T_4446 = buf_write[3] & _T_2621; // @[lsu_bus_buffer.scala 521:64]
  wire  _T_4447 = ~buf_cmd_state_bus_en_3; // @[lsu_bus_buffer.scala 521:91]
  wire  _T_4448 = _T_4446 & _T_4447; // @[lsu_bus_buffer.scala 521:89]
  wire  _T_4441 = buf_write[2] & _T_2616; // @[lsu_bus_buffer.scala 521:64]
  wire  _T_4442 = ~buf_cmd_state_bus_en_2; // @[lsu_bus_buffer.scala 521:91]
  wire  _T_4443 = _T_4441 & _T_4442; // @[lsu_bus_buffer.scala 521:89]
  wire [1:0] _T_4449 = _T_4448 + _T_4443; // @[lsu_bus_buffer.scala 521:142]
  wire  _T_4436 = buf_write[1] & _T_2611; // @[lsu_bus_buffer.scala 521:64]
  wire  _T_4437 = ~buf_cmd_state_bus_en_1; // @[lsu_bus_buffer.scala 521:91]
  wire  _T_4438 = _T_4436 & _T_4437; // @[lsu_bus_buffer.scala 521:89]
  wire [1:0] _GEN_362 = {{1'd0}, _T_4438}; // @[lsu_bus_buffer.scala 521:142]
  wire [2:0] _T_4450 = _T_4449 + _GEN_362; // @[lsu_bus_buffer.scala 521:142]
  wire  _T_4431 = buf_write[0] & _T_2606; // @[lsu_bus_buffer.scala 521:64]
  wire  _T_4432 = ~buf_cmd_state_bus_en_0; // @[lsu_bus_buffer.scala 521:91]
  wire  _T_4433 = _T_4431 & _T_4432; // @[lsu_bus_buffer.scala 521:89]
  wire [2:0] _GEN_363 = {{2'd0}, _T_4433}; // @[lsu_bus_buffer.scala 521:142]
  wire [3:0] buf_numvld_wrcmd_any = _T_4450 + _GEN_363; // @[lsu_bus_buffer.scala 521:142]
  wire  _T_1016 = buf_numvld_wrcmd_any == 4'h1; // @[lsu_bus_buffer.scala 261:43]
  wire  _T_4463 = _T_2621 & _T_4447; // @[lsu_bus_buffer.scala 522:73]
  wire  _T_4460 = _T_2616 & _T_4442; // @[lsu_bus_buffer.scala 522:73]
  wire [1:0] _T_4464 = _T_4463 + _T_4460; // @[lsu_bus_buffer.scala 522:126]
  wire  _T_4457 = _T_2611 & _T_4437; // @[lsu_bus_buffer.scala 522:73]
  wire [1:0] _GEN_364 = {{1'd0}, _T_4457}; // @[lsu_bus_buffer.scala 522:126]
  wire [2:0] _T_4465 = _T_4464 + _GEN_364; // @[lsu_bus_buffer.scala 522:126]
  wire  _T_4454 = _T_2606 & _T_4432; // @[lsu_bus_buffer.scala 522:73]
  wire [2:0] _GEN_365 = {{2'd0}, _T_4454}; // @[lsu_bus_buffer.scala 522:126]
  wire [3:0] buf_numvld_cmd_any = _T_4465 + _GEN_365; // @[lsu_bus_buffer.scala 522:126]
  wire  _T_1017 = buf_numvld_cmd_any == 4'h1; // @[lsu_bus_buffer.scala 261:72]
  wire  _T_1018 = _T_1016 & _T_1017; // @[lsu_bus_buffer.scala 261:51]
  reg [2:0] obuf_wr_timer; // @[lsu_bus_buffer.scala 360:54]
  wire  _T_1019 = obuf_wr_timer != 3'h7; // @[lsu_bus_buffer.scala 261:97]
  wire  _T_1020 = _T_1018 & _T_1019; // @[lsu_bus_buffer.scala 261:80]
  wire  _T_1022 = _T_1020 & _T_938; // @[lsu_bus_buffer.scala 261:114]
  wire  _T_1979 = |buf_age_3; // @[lsu_bus_buffer.scala 377:58]
  wire  _T_1980 = ~_T_1979; // @[lsu_bus_buffer.scala 377:45]
  wire  _T_1982 = _T_1980 & _T_2621; // @[lsu_bus_buffer.scala 377:63]
  wire  _T_1984 = _T_1982 & _T_4447; // @[lsu_bus_buffer.scala 377:88]
  wire  _T_1973 = |buf_age_2; // @[lsu_bus_buffer.scala 377:58]
  wire  _T_1974 = ~_T_1973; // @[lsu_bus_buffer.scala 377:45]
  wire  _T_1976 = _T_1974 & _T_2616; // @[lsu_bus_buffer.scala 377:63]
  wire  _T_1978 = _T_1976 & _T_4442; // @[lsu_bus_buffer.scala 377:88]
  wire  _T_1967 = |buf_age_1; // @[lsu_bus_buffer.scala 377:58]
  wire  _T_1968 = ~_T_1967; // @[lsu_bus_buffer.scala 377:45]
  wire  _T_1970 = _T_1968 & _T_2611; // @[lsu_bus_buffer.scala 377:63]
  wire  _T_1972 = _T_1970 & _T_4437; // @[lsu_bus_buffer.scala 377:88]
  wire  _T_1961 = |buf_age_0; // @[lsu_bus_buffer.scala 377:58]
  wire  _T_1962 = ~_T_1961; // @[lsu_bus_buffer.scala 377:45]
  wire  _T_1964 = _T_1962 & _T_2606; // @[lsu_bus_buffer.scala 377:63]
  wire  _T_1966 = _T_1964 & _T_4432; // @[lsu_bus_buffer.scala 377:88]
  wire [3:0] CmdPtr0Dec = {_T_1984,_T_1978,_T_1972,_T_1966}; // @[Cat.scala 29:58]
  wire [7:0] _T_2054 = {4'h0,_T_1984,_T_1978,_T_1972,_T_1966}; // @[Cat.scala 29:58]
  wire  _T_2057 = _T_2054[4] | _T_2054[5]; // @[lsu_bus_buffer.scala 385:42]
  wire  _T_2059 = _T_2057 | _T_2054[6]; // @[lsu_bus_buffer.scala 385:48]
  wire  _T_2061 = _T_2059 | _T_2054[7]; // @[lsu_bus_buffer.scala 385:54]
  wire  _T_2064 = _T_2054[2] | _T_2054[3]; // @[lsu_bus_buffer.scala 385:67]
  wire  _T_2066 = _T_2064 | _T_2054[6]; // @[lsu_bus_buffer.scala 385:73]
  wire  _T_2068 = _T_2066 | _T_2054[7]; // @[lsu_bus_buffer.scala 385:79]
  wire  _T_2071 = _T_2054[1] | _T_2054[3]; // @[lsu_bus_buffer.scala 385:92]
  wire  _T_2073 = _T_2071 | _T_2054[5]; // @[lsu_bus_buffer.scala 385:98]
  wire  _T_2075 = _T_2073 | _T_2054[7]; // @[lsu_bus_buffer.scala 385:104]
  wire [2:0] _T_2077 = {_T_2061,_T_2068,_T_2075}; // @[Cat.scala 29:58]
  wire [1:0] CmdPtr0 = _T_2077[1:0]; // @[lsu_bus_buffer.scala 390:11]
  wire  _T_1023 = CmdPtr0 == 2'h0; // @[lsu_bus_buffer.scala 262:114]
  wire  _T_1024 = CmdPtr0 == 2'h1; // @[lsu_bus_buffer.scala 262:114]
  wire  _T_1025 = CmdPtr0 == 2'h2; // @[lsu_bus_buffer.scala 262:114]
  wire  _T_1026 = CmdPtr0 == 2'h3; // @[lsu_bus_buffer.scala 262:114]
  reg  buf_nomerge_0; // @[Reg.scala 27:20]
  wire  _T_1027 = _T_1023 & buf_nomerge_0; // @[Mux.scala 27:72]
  reg  buf_nomerge_1; // @[Reg.scala 27:20]
  wire  _T_1028 = _T_1024 & buf_nomerge_1; // @[Mux.scala 27:72]
  reg  buf_nomerge_2; // @[Reg.scala 27:20]
  wire  _T_1029 = _T_1025 & buf_nomerge_2; // @[Mux.scala 27:72]
  reg  buf_nomerge_3; // @[Reg.scala 27:20]
  wire  _T_1030 = _T_1026 & buf_nomerge_3; // @[Mux.scala 27:72]
  wire  _T_1031 = _T_1027 | _T_1028; // @[Mux.scala 27:72]
  wire  _T_1032 = _T_1031 | _T_1029; // @[Mux.scala 27:72]
  wire  _T_1033 = _T_1032 | _T_1030; // @[Mux.scala 27:72]
  wire  _T_1035 = ~_T_1033; // @[lsu_bus_buffer.scala 262:31]
  wire  _T_1036 = _T_1022 & _T_1035; // @[lsu_bus_buffer.scala 262:29]
  reg  _T_4330; // @[Reg.scala 27:20]
  reg  _T_4327; // @[Reg.scala 27:20]
  reg  _T_4324; // @[Reg.scala 27:20]
  reg  _T_4321; // @[Reg.scala 27:20]
  wire [3:0] buf_sideeffect = {_T_4330,_T_4327,_T_4324,_T_4321}; // @[Cat.scala 29:58]
  wire  _T_1045 = _T_1023 & buf_sideeffect[0]; // @[Mux.scala 27:72]
  wire  _T_1046 = _T_1024 & buf_sideeffect[1]; // @[Mux.scala 27:72]
  wire  _T_1047 = _T_1025 & buf_sideeffect[2]; // @[Mux.scala 27:72]
  wire  _T_1048 = _T_1026 & buf_sideeffect[3]; // @[Mux.scala 27:72]
  wire  _T_1049 = _T_1045 | _T_1046; // @[Mux.scala 27:72]
  wire  _T_1050 = _T_1049 | _T_1047; // @[Mux.scala 27:72]
  wire  _T_1051 = _T_1050 | _T_1048; // @[Mux.scala 27:72]
  wire  _T_1053 = ~_T_1051; // @[lsu_bus_buffer.scala 263:5]
  wire  _T_1054 = _T_1036 & _T_1053; // @[lsu_bus_buffer.scala 262:140]
  wire  _T_1065 = _T_858 & _T_852; // @[lsu_bus_buffer.scala 265:58]
  wire  _T_1067 = _T_1065 & _T_1017; // @[lsu_bus_buffer.scala 265:72]
  wire [29:0] _T_1077 = _T_1023 ? buf_addr_0[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1078 = _T_1024 ? buf_addr_1[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1081 = _T_1077 | _T_1078; // @[Mux.scala 27:72]
  wire [29:0] _T_1079 = _T_1025 ? buf_addr_2[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1082 = _T_1081 | _T_1079; // @[Mux.scala 27:72]
  wire [29:0] _T_1080 = _T_1026 ? buf_addr_3[31:2] : 30'h0; // @[Mux.scala 27:72]
  wire [29:0] _T_1083 = _T_1082 | _T_1080; // @[Mux.scala 27:72]
  wire  _T_1085 = io_lsu_addr_m[31:2] != _T_1083; // @[lsu_bus_buffer.scala 265:123]
  wire  obuf_force_wr_en = _T_1067 & _T_1085; // @[lsu_bus_buffer.scala 265:101]
  wire  _T_1055 = ~obuf_force_wr_en; // @[lsu_bus_buffer.scala 263:119]
  wire  obuf_wr_wait = _T_1054 & _T_1055; // @[lsu_bus_buffer.scala 263:117]
  wire  _T_1056 = |buf_numvld_cmd_any; // @[lsu_bus_buffer.scala 264:75]
  wire  _T_1057 = obuf_wr_timer < 3'h7; // @[lsu_bus_buffer.scala 264:95]
  wire  _T_1058 = _T_1056 & _T_1057; // @[lsu_bus_buffer.scala 264:79]
  wire [2:0] _T_1060 = obuf_wr_timer + 3'h1; // @[lsu_bus_buffer.scala 264:123]
  wire  _T_4482 = buf_state_3 == 3'h1; // @[lsu_bus_buffer.scala 523:63]
  wire  _T_4486 = _T_4482 | _T_4463; // @[lsu_bus_buffer.scala 523:74]
  wire  _T_4477 = buf_state_2 == 3'h1; // @[lsu_bus_buffer.scala 523:63]
  wire  _T_4481 = _T_4477 | _T_4460; // @[lsu_bus_buffer.scala 523:74]
  wire [1:0] _T_4487 = _T_4486 + _T_4481; // @[lsu_bus_buffer.scala 523:154]
  wire  _T_4472 = buf_state_1 == 3'h1; // @[lsu_bus_buffer.scala 523:63]
  wire  _T_4476 = _T_4472 | _T_4457; // @[lsu_bus_buffer.scala 523:74]
  wire [1:0] _GEN_366 = {{1'd0}, _T_4476}; // @[lsu_bus_buffer.scala 523:154]
  wire [2:0] _T_4488 = _T_4487 + _GEN_366; // @[lsu_bus_buffer.scala 523:154]
  wire  _T_4467 = buf_state_0 == 3'h1; // @[lsu_bus_buffer.scala 523:63]
  wire  _T_4471 = _T_4467 | _T_4454; // @[lsu_bus_buffer.scala 523:74]
  wire [2:0] _GEN_367 = {{2'd0}, _T_4471}; // @[lsu_bus_buffer.scala 523:154]
  wire [3:0] buf_numvld_pend_any = _T_4488 + _GEN_367; // @[lsu_bus_buffer.scala 523:154]
  wire  _T_1087 = buf_numvld_pend_any == 4'h0; // @[lsu_bus_buffer.scala 267:53]
  wire  _T_1088 = ibuf_byp & _T_1087; // @[lsu_bus_buffer.scala 267:31]
  wire  _T_1089 = ~io_lsu_pkt_r_bits_store; // @[lsu_bus_buffer.scala 267:64]
  wire  _T_1090 = _T_1089 | io_no_dword_merge_r; // @[lsu_bus_buffer.scala 267:89]
  wire  ibuf_buf_byp = _T_1088 & _T_1090; // @[lsu_bus_buffer.scala 267:61]
  wire  _T_1091 = ibuf_buf_byp & io_lsu_commit_r; // @[lsu_bus_buffer.scala 282:32]
  wire  _T_4778 = buf_state_0 == 3'h3; // @[lsu_bus_buffer.scala 551:62]
  wire  _T_4780 = _T_4778 & buf_sideeffect[0]; // @[lsu_bus_buffer.scala 551:73]
  wire  _T_4781 = _T_4780 & io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[lsu_bus_buffer.scala 551:93]
  wire  _T_4782 = buf_state_1 == 3'h3; // @[lsu_bus_buffer.scala 551:62]
  wire  _T_4784 = _T_4782 & buf_sideeffect[1]; // @[lsu_bus_buffer.scala 551:73]
  wire  _T_4785 = _T_4784 & io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[lsu_bus_buffer.scala 551:93]
  wire  _T_4794 = _T_4781 | _T_4785; // @[lsu_bus_buffer.scala 551:153]
  wire  _T_4786 = buf_state_2 == 3'h3; // @[lsu_bus_buffer.scala 551:62]
  wire  _T_4788 = _T_4786 & buf_sideeffect[2]; // @[lsu_bus_buffer.scala 551:73]
  wire  _T_4789 = _T_4788 & io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[lsu_bus_buffer.scala 551:93]
  wire  _T_4795 = _T_4794 | _T_4789; // @[lsu_bus_buffer.scala 551:153]
  wire  _T_4790 = buf_state_3 == 3'h3; // @[lsu_bus_buffer.scala 551:62]
  wire  _T_4792 = _T_4790 & buf_sideeffect[3]; // @[lsu_bus_buffer.scala 551:73]
  wire  _T_4793 = _T_4792 & io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[lsu_bus_buffer.scala 551:93]
  wire  _T_4796 = _T_4795 | _T_4793; // @[lsu_bus_buffer.scala 551:153]
  reg  obuf_sideeffect; // @[Reg.scala 27:20]
  wire  _T_4797 = obuf_valid & obuf_sideeffect; // @[lsu_bus_buffer.scala 551:171]
  wire  _T_4798 = _T_4797 & io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[lsu_bus_buffer.scala 551:189]
  wire  bus_sideeffect_pend = _T_4796 | _T_4798; // @[lsu_bus_buffer.scala 551:157]
  wire  _T_1092 = io_is_sideeffects_r & bus_sideeffect_pend; // @[lsu_bus_buffer.scala 282:74]
  wire  _T_1093 = ~_T_1092; // @[lsu_bus_buffer.scala 282:52]
  wire  _T_1094 = _T_1091 & _T_1093; // @[lsu_bus_buffer.scala 282:50]
  wire [2:0] _T_1099 = _T_1023 ? buf_state_0 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1100 = _T_1024 ? buf_state_1 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1103 = _T_1099 | _T_1100; // @[Mux.scala 27:72]
  wire [2:0] _T_1101 = _T_1025 ? buf_state_2 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1104 = _T_1103 | _T_1101; // @[Mux.scala 27:72]
  wire [2:0] _T_1102 = _T_1026 ? buf_state_3 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1105 = _T_1104 | _T_1102; // @[Mux.scala 27:72]
  wire  _T_1107 = _T_1105 == 3'h2; // @[lsu_bus_buffer.scala 283:36]
  wire  found_cmdptr0 = |CmdPtr0Dec; // @[lsu_bus_buffer.scala 382:31]
  wire  _T_1108 = _T_1107 & found_cmdptr0; // @[lsu_bus_buffer.scala 283:47]
  wire [3:0] _T_1111 = {buf_cmd_state_bus_en_3,buf_cmd_state_bus_en_2,buf_cmd_state_bus_en_1,buf_cmd_state_bus_en_0}; // @[Cat.scala 29:58]
  wire  _T_1120 = _T_1023 & _T_1111[0]; // @[Mux.scala 27:72]
  wire  _T_1121 = _T_1024 & _T_1111[1]; // @[Mux.scala 27:72]
  wire  _T_1124 = _T_1120 | _T_1121; // @[Mux.scala 27:72]
  wire  _T_1122 = _T_1025 & _T_1111[2]; // @[Mux.scala 27:72]
  wire  _T_1125 = _T_1124 | _T_1122; // @[Mux.scala 27:72]
  wire  _T_1123 = _T_1026 & _T_1111[3]; // @[Mux.scala 27:72]
  wire  _T_1126 = _T_1125 | _T_1123; // @[Mux.scala 27:72]
  wire  _T_1128 = ~_T_1126; // @[lsu_bus_buffer.scala 284:23]
  wire  _T_1129 = _T_1108 & _T_1128; // @[lsu_bus_buffer.scala 284:21]
  wire  _T_1146 = _T_1051 & bus_sideeffect_pend; // @[lsu_bus_buffer.scala 284:141]
  wire  _T_1147 = ~_T_1146; // @[lsu_bus_buffer.scala 284:105]
  wire  _T_1148 = _T_1129 & _T_1147; // @[lsu_bus_buffer.scala 284:103]
  reg  buf_dual_3; // @[Reg.scala 27:20]
  reg  buf_dual_2; // @[Reg.scala 27:20]
  reg  buf_dual_1; // @[Reg.scala 27:20]
  reg  buf_dual_0; // @[Reg.scala 27:20]
  wire [3:0] _T_1151 = {buf_dual_3,buf_dual_2,buf_dual_1,buf_dual_0}; // @[Cat.scala 29:58]
  wire  _T_1160 = _T_1023 & _T_1151[0]; // @[Mux.scala 27:72]
  wire  _T_1161 = _T_1024 & _T_1151[1]; // @[Mux.scala 27:72]
  wire  _T_1164 = _T_1160 | _T_1161; // @[Mux.scala 27:72]
  wire  _T_1162 = _T_1025 & _T_1151[2]; // @[Mux.scala 27:72]
  wire  _T_1165 = _T_1164 | _T_1162; // @[Mux.scala 27:72]
  wire  _T_1163 = _T_1026 & _T_1151[3]; // @[Mux.scala 27:72]
  wire  _T_1166 = _T_1165 | _T_1163; // @[Mux.scala 27:72]
  reg  buf_samedw_3; // @[Reg.scala 27:20]
  reg  buf_samedw_2; // @[Reg.scala 27:20]
  reg  buf_samedw_1; // @[Reg.scala 27:20]
  reg  buf_samedw_0; // @[Reg.scala 27:20]
  wire [3:0] _T_1170 = {buf_samedw_3,buf_samedw_2,buf_samedw_1,buf_samedw_0}; // @[Cat.scala 29:58]
  wire  _T_1179 = _T_1023 & _T_1170[0]; // @[Mux.scala 27:72]
  wire  _T_1180 = _T_1024 & _T_1170[1]; // @[Mux.scala 27:72]
  wire  _T_1183 = _T_1179 | _T_1180; // @[Mux.scala 27:72]
  wire  _T_1181 = _T_1025 & _T_1170[2]; // @[Mux.scala 27:72]
  wire  _T_1184 = _T_1183 | _T_1181; // @[Mux.scala 27:72]
  wire  _T_1182 = _T_1026 & _T_1170[3]; // @[Mux.scala 27:72]
  wire  _T_1185 = _T_1184 | _T_1182; // @[Mux.scala 27:72]
  wire  _T_1187 = _T_1166 & _T_1185; // @[lsu_bus_buffer.scala 285:77]
  wire  _T_1196 = _T_1023 & buf_write[0]; // @[Mux.scala 27:72]
  wire  _T_1197 = _T_1024 & buf_write[1]; // @[Mux.scala 27:72]
  wire  _T_1200 = _T_1196 | _T_1197; // @[Mux.scala 27:72]
  wire  _T_1198 = _T_1025 & buf_write[2]; // @[Mux.scala 27:72]
  wire  _T_1201 = _T_1200 | _T_1198; // @[Mux.scala 27:72]
  wire  _T_1199 = _T_1026 & buf_write[3]; // @[Mux.scala 27:72]
  wire  _T_1202 = _T_1201 | _T_1199; // @[Mux.scala 27:72]
  wire  _T_1204 = ~_T_1202; // @[lsu_bus_buffer.scala 285:150]
  wire  _T_1205 = _T_1187 & _T_1204; // @[lsu_bus_buffer.scala 285:148]
  wire  _T_1206 = ~_T_1205; // @[lsu_bus_buffer.scala 285:8]
  wire [3:0] _T_2020 = ~CmdPtr0Dec; // @[lsu_bus_buffer.scala 378:62]
  wire [3:0] _T_2021 = buf_age_3 & _T_2020; // @[lsu_bus_buffer.scala 378:59]
  wire  _T_2022 = |_T_2021; // @[lsu_bus_buffer.scala 378:76]
  wire  _T_2023 = ~_T_2022; // @[lsu_bus_buffer.scala 378:45]
  wire  _T_2025 = ~CmdPtr0Dec[3]; // @[lsu_bus_buffer.scala 378:83]
  wire  _T_2026 = _T_2023 & _T_2025; // @[lsu_bus_buffer.scala 378:81]
  wire  _T_2028 = _T_2026 & _T_2621; // @[lsu_bus_buffer.scala 378:98]
  wire  _T_2030 = _T_2028 & _T_4447; // @[lsu_bus_buffer.scala 378:123]
  wire [3:0] _T_2010 = buf_age_2 & _T_2020; // @[lsu_bus_buffer.scala 378:59]
  wire  _T_2011 = |_T_2010; // @[lsu_bus_buffer.scala 378:76]
  wire  _T_2012 = ~_T_2011; // @[lsu_bus_buffer.scala 378:45]
  wire  _T_2014 = ~CmdPtr0Dec[2]; // @[lsu_bus_buffer.scala 378:83]
  wire  _T_2015 = _T_2012 & _T_2014; // @[lsu_bus_buffer.scala 378:81]
  wire  _T_2017 = _T_2015 & _T_2616; // @[lsu_bus_buffer.scala 378:98]
  wire  _T_2019 = _T_2017 & _T_4442; // @[lsu_bus_buffer.scala 378:123]
  wire [3:0] _T_1999 = buf_age_1 & _T_2020; // @[lsu_bus_buffer.scala 378:59]
  wire  _T_2000 = |_T_1999; // @[lsu_bus_buffer.scala 378:76]
  wire  _T_2001 = ~_T_2000; // @[lsu_bus_buffer.scala 378:45]
  wire  _T_2003 = ~CmdPtr0Dec[1]; // @[lsu_bus_buffer.scala 378:83]
  wire  _T_2004 = _T_2001 & _T_2003; // @[lsu_bus_buffer.scala 378:81]
  wire  _T_2006 = _T_2004 & _T_2611; // @[lsu_bus_buffer.scala 378:98]
  wire  _T_2008 = _T_2006 & _T_4437; // @[lsu_bus_buffer.scala 378:123]
  wire [3:0] _T_1988 = buf_age_0 & _T_2020; // @[lsu_bus_buffer.scala 378:59]
  wire  _T_1989 = |_T_1988; // @[lsu_bus_buffer.scala 378:76]
  wire  _T_1990 = ~_T_1989; // @[lsu_bus_buffer.scala 378:45]
  wire  _T_1992 = ~CmdPtr0Dec[0]; // @[lsu_bus_buffer.scala 378:83]
  wire  _T_1993 = _T_1990 & _T_1992; // @[lsu_bus_buffer.scala 378:81]
  wire  _T_1995 = _T_1993 & _T_2606; // @[lsu_bus_buffer.scala 378:98]
  wire  _T_1997 = _T_1995 & _T_4432; // @[lsu_bus_buffer.scala 378:123]
  wire [3:0] CmdPtr1Dec = {_T_2030,_T_2019,_T_2008,_T_1997}; // @[Cat.scala 29:58]
  wire  found_cmdptr1 = |CmdPtr1Dec; // @[lsu_bus_buffer.scala 383:31]
  wire  _T_1207 = _T_1206 | found_cmdptr1; // @[lsu_bus_buffer.scala 285:181]
  wire [3:0] _T_1210 = {buf_nomerge_3,buf_nomerge_2,buf_nomerge_1,buf_nomerge_0}; // @[Cat.scala 29:58]
  wire  _T_1219 = _T_1023 & _T_1210[0]; // @[Mux.scala 27:72]
  wire  _T_1220 = _T_1024 & _T_1210[1]; // @[Mux.scala 27:72]
  wire  _T_1223 = _T_1219 | _T_1220; // @[Mux.scala 27:72]
  wire  _T_1221 = _T_1025 & _T_1210[2]; // @[Mux.scala 27:72]
  wire  _T_1224 = _T_1223 | _T_1221; // @[Mux.scala 27:72]
  wire  _T_1222 = _T_1026 & _T_1210[3]; // @[Mux.scala 27:72]
  wire  _T_1225 = _T_1224 | _T_1222; // @[Mux.scala 27:72]
  wire  _T_1227 = _T_1207 | _T_1225; // @[lsu_bus_buffer.scala 285:197]
  wire  _T_1228 = _T_1227 | obuf_force_wr_en; // @[lsu_bus_buffer.scala 285:269]
  wire  _T_1229 = _T_1148 & _T_1228; // @[lsu_bus_buffer.scala 284:164]
  wire  _T_1230 = _T_1094 | _T_1229; // @[lsu_bus_buffer.scala 282:98]
  reg  obuf_write; // @[Reg.scala 27:20]
  reg  obuf_cmd_done; // @[lsu_bus_buffer.scala 347:54]
  reg  obuf_data_done; // @[lsu_bus_buffer.scala 348:55]
  wire  _T_4856 = obuf_cmd_done | obuf_data_done; // @[lsu_bus_buffer.scala 555:54]
  wire  _T_4857 = obuf_cmd_done ? io_lsu_axi_w_ready : io_lsu_axi_aw_ready; // @[lsu_bus_buffer.scala 555:75]
  wire  _T_4858 = io_lsu_axi_aw_ready & io_lsu_axi_w_ready; // @[lsu_bus_buffer.scala 555:153]
  wire  _T_4859 = _T_4856 ? _T_4857 : _T_4858; // @[lsu_bus_buffer.scala 555:39]
  wire  bus_cmd_ready = obuf_write ? _T_4859 : io_lsu_axi_ar_ready; // @[lsu_bus_buffer.scala 555:23]
  wire  _T_1231 = ~obuf_valid; // @[lsu_bus_buffer.scala 286:48]
  wire  _T_1232 = bus_cmd_ready | _T_1231; // @[lsu_bus_buffer.scala 286:46]
  reg  obuf_nosend; // @[Reg.scala 27:20]
  wire  _T_1233 = _T_1232 | obuf_nosend; // @[lsu_bus_buffer.scala 286:60]
  wire  _T_1234 = _T_1230 & _T_1233; // @[lsu_bus_buffer.scala 286:29]
  wire  _T_1235 = ~obuf_wr_wait; // @[lsu_bus_buffer.scala 286:77]
  wire  _T_1236 = _T_1234 & _T_1235; // @[lsu_bus_buffer.scala 286:75]
  reg [31:0] obuf_addr; // @[lib.scala 358:16]
  wire  _T_4804 = obuf_addr[31:3] == buf_addr_0[31:3]; // @[lsu_bus_buffer.scala 553:56]
  wire  _T_4805 = obuf_valid & _T_4804; // @[lsu_bus_buffer.scala 553:38]
  wire  _T_4807 = obuf_tag1 == 2'h0; // @[lsu_bus_buffer.scala 553:126]
  wire  _T_4808 = obuf_merge & _T_4807; // @[lsu_bus_buffer.scala 553:114]
  wire  _T_4809 = _T_3562 | _T_4808; // @[lsu_bus_buffer.scala 553:100]
  wire  _T_4810 = ~_T_4809; // @[lsu_bus_buffer.scala 553:80]
  wire  _T_4811 = _T_4805 & _T_4810; // @[lsu_bus_buffer.scala 553:78]
  wire  _T_4848 = _T_4778 & _T_4811; // @[Mux.scala 27:72]
  wire  _T_4816 = obuf_addr[31:3] == buf_addr_1[31:3]; // @[lsu_bus_buffer.scala 553:56]
  wire  _T_4817 = obuf_valid & _T_4816; // @[lsu_bus_buffer.scala 553:38]
  wire  _T_4819 = obuf_tag1 == 2'h1; // @[lsu_bus_buffer.scala 553:126]
  wire  _T_4820 = obuf_merge & _T_4819; // @[lsu_bus_buffer.scala 553:114]
  wire  _T_4821 = _T_3755 | _T_4820; // @[lsu_bus_buffer.scala 553:100]
  wire  _T_4822 = ~_T_4821; // @[lsu_bus_buffer.scala 553:80]
  wire  _T_4823 = _T_4817 & _T_4822; // @[lsu_bus_buffer.scala 553:78]
  wire  _T_4849 = _T_4782 & _T_4823; // @[Mux.scala 27:72]
  wire  _T_4852 = _T_4848 | _T_4849; // @[Mux.scala 27:72]
  wire  _T_4828 = obuf_addr[31:3] == buf_addr_2[31:3]; // @[lsu_bus_buffer.scala 553:56]
  wire  _T_4829 = obuf_valid & _T_4828; // @[lsu_bus_buffer.scala 553:38]
  wire  _T_4831 = obuf_tag1 == 2'h2; // @[lsu_bus_buffer.scala 553:126]
  wire  _T_4832 = obuf_merge & _T_4831; // @[lsu_bus_buffer.scala 553:114]
  wire  _T_4833 = _T_3948 | _T_4832; // @[lsu_bus_buffer.scala 553:100]
  wire  _T_4834 = ~_T_4833; // @[lsu_bus_buffer.scala 553:80]
  wire  _T_4835 = _T_4829 & _T_4834; // @[lsu_bus_buffer.scala 553:78]
  wire  _T_4850 = _T_4786 & _T_4835; // @[Mux.scala 27:72]
  wire  _T_4853 = _T_4852 | _T_4850; // @[Mux.scala 27:72]
  wire  _T_4840 = obuf_addr[31:3] == buf_addr_3[31:3]; // @[lsu_bus_buffer.scala 553:56]
  wire  _T_4841 = obuf_valid & _T_4840; // @[lsu_bus_buffer.scala 553:38]
  wire  _T_4843 = obuf_tag1 == 2'h3; // @[lsu_bus_buffer.scala 553:126]
  wire  _T_4844 = obuf_merge & _T_4843; // @[lsu_bus_buffer.scala 553:114]
  wire  _T_4845 = _T_4141 | _T_4844; // @[lsu_bus_buffer.scala 553:100]
  wire  _T_4846 = ~_T_4845; // @[lsu_bus_buffer.scala 553:80]
  wire  _T_4847 = _T_4841 & _T_4846; // @[lsu_bus_buffer.scala 553:78]
  wire  _T_4851 = _T_4790 & _T_4847; // @[Mux.scala 27:72]
  wire  bus_addr_match_pending = _T_4853 | _T_4851; // @[Mux.scala 27:72]
  wire  _T_1239 = ~bus_addr_match_pending; // @[lsu_bus_buffer.scala 286:118]
  wire  _T_1240 = _T_1236 & _T_1239; // @[lsu_bus_buffer.scala 286:116]
  wire  obuf_wr_en = _T_1240 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 286:142]
  wire  _T_1242 = obuf_valid & obuf_nosend; // @[lsu_bus_buffer.scala 288:47]
  wire  bus_wcmd_sent = io_lsu_axi_aw_valid & io_lsu_axi_aw_ready; // @[lsu_bus_buffer.scala 556:40]
  wire  _T_4863 = obuf_cmd_done | bus_wcmd_sent; // @[lsu_bus_buffer.scala 558:35]
  wire  bus_wdata_sent = io_lsu_axi_w_valid & io_lsu_axi_w_ready; // @[lsu_bus_buffer.scala 557:40]
  wire  _T_4864 = obuf_data_done | bus_wdata_sent; // @[lsu_bus_buffer.scala 558:70]
  wire  _T_4865 = _T_4863 & _T_4864; // @[lsu_bus_buffer.scala 558:52]
  wire  _T_4866 = io_lsu_axi_ar_valid & io_lsu_axi_ar_ready; // @[lsu_bus_buffer.scala 558:112]
  wire  bus_cmd_sent = _T_4865 | _T_4866; // @[lsu_bus_buffer.scala 558:89]
  wire  _T_1243 = bus_cmd_sent | _T_1242; // @[lsu_bus_buffer.scala 288:33]
  wire  _T_1244 = ~obuf_wr_en; // @[lsu_bus_buffer.scala 288:65]
  wire  _T_1245 = _T_1243 & _T_1244; // @[lsu_bus_buffer.scala 288:63]
  wire  _T_1246 = _T_1245 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 288:77]
  wire  obuf_rst = _T_1246 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 288:98]
  wire  obuf_write_in = ibuf_buf_byp ? io_lsu_pkt_r_bits_store : _T_1202; // @[lsu_bus_buffer.scala 289:26]
  wire [31:0] _T_1283 = _T_1023 ? buf_addr_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1284 = _T_1024 ? buf_addr_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1285 = _T_1025 ? buf_addr_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1286 = _T_1026 ? buf_addr_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1287 = _T_1283 | _T_1284; // @[Mux.scala 27:72]
  wire [31:0] _T_1288 = _T_1287 | _T_1285; // @[Mux.scala 27:72]
  wire [31:0] _T_1289 = _T_1288 | _T_1286; // @[Mux.scala 27:72]
  wire [31:0] obuf_addr_in = ibuf_buf_byp ? io_lsu_addr_r : _T_1289; // @[lsu_bus_buffer.scala 291:25]
  reg [1:0] buf_sz_0; // @[Reg.scala 27:20]
  wire [1:0] _T_1296 = _T_1023 ? buf_sz_0 : 2'h0; // @[Mux.scala 27:72]
  reg [1:0] buf_sz_1; // @[Reg.scala 27:20]
  wire [1:0] _T_1297 = _T_1024 ? buf_sz_1 : 2'h0; // @[Mux.scala 27:72]
  reg [1:0] buf_sz_2; // @[Reg.scala 27:20]
  wire [1:0] _T_1298 = _T_1025 ? buf_sz_2 : 2'h0; // @[Mux.scala 27:72]
  reg [1:0] buf_sz_3; // @[Reg.scala 27:20]
  wire [1:0] _T_1299 = _T_1026 ? buf_sz_3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_1300 = _T_1296 | _T_1297; // @[Mux.scala 27:72]
  wire [1:0] _T_1301 = _T_1300 | _T_1298; // @[Mux.scala 27:72]
  wire [1:0] _T_1302 = _T_1301 | _T_1299; // @[Mux.scala 27:72]
  wire [1:0] obuf_sz_in = ibuf_buf_byp ? ibuf_sz_in : _T_1302; // @[lsu_bus_buffer.scala 294:23]
  wire [7:0] _T_2079 = {4'h0,_T_2030,_T_2019,_T_2008,_T_1997}; // @[Cat.scala 29:58]
  wire  _T_2082 = _T_2079[4] | _T_2079[5]; // @[lsu_bus_buffer.scala 385:42]
  wire  _T_2084 = _T_2082 | _T_2079[6]; // @[lsu_bus_buffer.scala 385:48]
  wire  _T_2086 = _T_2084 | _T_2079[7]; // @[lsu_bus_buffer.scala 385:54]
  wire  _T_2089 = _T_2079[2] | _T_2079[3]; // @[lsu_bus_buffer.scala 385:67]
  wire  _T_2091 = _T_2089 | _T_2079[6]; // @[lsu_bus_buffer.scala 385:73]
  wire  _T_2093 = _T_2091 | _T_2079[7]; // @[lsu_bus_buffer.scala 385:79]
  wire  _T_2096 = _T_2079[1] | _T_2079[3]; // @[lsu_bus_buffer.scala 385:92]
  wire  _T_2098 = _T_2096 | _T_2079[5]; // @[lsu_bus_buffer.scala 385:98]
  wire  _T_2100 = _T_2098 | _T_2079[7]; // @[lsu_bus_buffer.scala 385:104]
  wire [2:0] _T_2102 = {_T_2086,_T_2093,_T_2100}; // @[Cat.scala 29:58]
  wire [1:0] CmdPtr1 = _T_2102[1:0]; // @[lsu_bus_buffer.scala 392:11]
  wire  _T_1304 = obuf_wr_en | obuf_rst; // @[lsu_bus_buffer.scala 303:39]
  wire  _T_1305 = ~_T_1304; // @[lsu_bus_buffer.scala 303:26]
  wire  _T_1311 = obuf_sz_in == 2'h0; // @[lsu_bus_buffer.scala 307:72]
  wire  _T_1314 = ~obuf_addr_in[0]; // @[lsu_bus_buffer.scala 307:98]
  wire  _T_1315 = obuf_sz_in[0] & _T_1314; // @[lsu_bus_buffer.scala 307:96]
  wire  _T_1316 = _T_1311 | _T_1315; // @[lsu_bus_buffer.scala 307:79]
  wire  _T_1319 = |obuf_addr_in[1:0]; // @[lsu_bus_buffer.scala 307:153]
  wire  _T_1320 = ~_T_1319; // @[lsu_bus_buffer.scala 307:134]
  wire  _T_1321 = obuf_sz_in[1] & _T_1320; // @[lsu_bus_buffer.scala 307:132]
  wire  _T_1322 = _T_1316 | _T_1321; // @[lsu_bus_buffer.scala 307:116]
  wire  obuf_aligned_in = ibuf_buf_byp ? is_aligned_r : _T_1322; // @[lsu_bus_buffer.scala 307:28]
  wire  _T_1339 = obuf_addr_in[31:3] == obuf_addr[31:3]; // @[lsu_bus_buffer.scala 321:40]
  wire  _T_1340 = _T_1339 & obuf_aligned_in; // @[lsu_bus_buffer.scala 321:60]
  wire  _T_1341 = ~obuf_sideeffect; // @[lsu_bus_buffer.scala 321:80]
  wire  _T_1342 = _T_1340 & _T_1341; // @[lsu_bus_buffer.scala 321:78]
  wire  _T_1343 = ~obuf_write; // @[lsu_bus_buffer.scala 321:99]
  wire  _T_1344 = _T_1342 & _T_1343; // @[lsu_bus_buffer.scala 321:97]
  wire  _T_1345 = ~obuf_write_in; // @[lsu_bus_buffer.scala 321:113]
  wire  _T_1346 = _T_1344 & _T_1345; // @[lsu_bus_buffer.scala 321:111]
  wire  _T_1347 = ~io_tlu_busbuff_dec_tlu_external_ldfwd_disable; // @[lsu_bus_buffer.scala 321:130]
  wire  _T_1348 = _T_1346 & _T_1347; // @[lsu_bus_buffer.scala 321:128]
  wire  _T_1349 = ~obuf_nosend; // @[lsu_bus_buffer.scala 322:20]
  wire  _T_1350 = obuf_valid & _T_1349; // @[lsu_bus_buffer.scala 322:18]
  reg  obuf_rdrsp_pend; // @[lsu_bus_buffer.scala 349:56]
  wire  bus_rsp_read = io_lsu_axi_r_valid & io_lsu_axi_r_ready; // @[lsu_bus_buffer.scala 559:38]
  reg [2:0] obuf_rdrsp_tag; // @[lsu_bus_buffer.scala 350:55]
  wire  _T_1351 = io_lsu_axi_r_bits_id == obuf_rdrsp_tag; // @[lsu_bus_buffer.scala 322:90]
  wire  _T_1352 = bus_rsp_read & _T_1351; // @[lsu_bus_buffer.scala 322:70]
  wire  _T_1353 = ~_T_1352; // @[lsu_bus_buffer.scala 322:55]
  wire  _T_1354 = obuf_rdrsp_pend & _T_1353; // @[lsu_bus_buffer.scala 322:53]
  wire  _T_1355 = _T_1350 | _T_1354; // @[lsu_bus_buffer.scala 322:34]
  wire  obuf_nosend_in = _T_1348 & _T_1355; // @[lsu_bus_buffer.scala 321:177]
  wire  _T_1323 = ~obuf_nosend_in; // @[lsu_bus_buffer.scala 315:44]
  wire  _T_1324 = obuf_wr_en & _T_1323; // @[lsu_bus_buffer.scala 315:42]
  wire  _T_1325 = ~_T_1324; // @[lsu_bus_buffer.scala 315:29]
  wire  _T_1326 = _T_1325 & obuf_rdrsp_pend; // @[lsu_bus_buffer.scala 315:61]
  wire  _T_1330 = _T_1326 & _T_1353; // @[lsu_bus_buffer.scala 315:79]
  wire  _T_1332 = bus_cmd_sent & _T_1343; // @[lsu_bus_buffer.scala 316:20]
  wire  _T_1333 = ~io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 316:37]
  wire  _T_1334 = _T_1332 & _T_1333; // @[lsu_bus_buffer.scala 316:35]
  wire [7:0] _T_1358 = {ldst_byteen_lo_r,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1359 = {4'h0,ldst_byteen_lo_r}; // @[Cat.scala 29:58]
  wire [7:0] _T_1360 = io_lsu_addr_r[2] ? _T_1358 : _T_1359; // @[lsu_bus_buffer.scala 323:46]
  wire [3:0] _T_1379 = _T_1023 ? buf_byteen_0 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1380 = _T_1024 ? buf_byteen_1 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1381 = _T_1025 ? buf_byteen_2 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1382 = _T_1026 ? buf_byteen_3 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1383 = _T_1379 | _T_1380; // @[Mux.scala 27:72]
  wire [3:0] _T_1384 = _T_1383 | _T_1381; // @[Mux.scala 27:72]
  wire [3:0] _T_1385 = _T_1384 | _T_1382; // @[Mux.scala 27:72]
  wire [7:0] _T_1387 = {_T_1385,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1400 = {4'h0,_T_1385}; // @[Cat.scala 29:58]
  wire [7:0] _T_1401 = _T_1289[2] ? _T_1387 : _T_1400; // @[lsu_bus_buffer.scala 324:8]
  wire [7:0] obuf_byteen0_in = ibuf_buf_byp ? _T_1360 : _T_1401; // @[lsu_bus_buffer.scala 323:28]
  wire [7:0] _T_1403 = {ldst_byteen_hi_r,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1404 = {4'h0,ldst_byteen_hi_r}; // @[Cat.scala 29:58]
  wire [7:0] _T_1405 = io_end_addr_r[2] ? _T_1403 : _T_1404; // @[lsu_bus_buffer.scala 325:46]
  wire  _T_1406 = CmdPtr1 == 2'h0; // @[lsu_bus_buffer.scala 57:123]
  wire  _T_1407 = CmdPtr1 == 2'h1; // @[lsu_bus_buffer.scala 57:123]
  wire  _T_1408 = CmdPtr1 == 2'h2; // @[lsu_bus_buffer.scala 57:123]
  wire  _T_1409 = CmdPtr1 == 2'h3; // @[lsu_bus_buffer.scala 57:123]
  wire [31:0] _T_1410 = _T_1406 ? buf_addr_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1411 = _T_1407 ? buf_addr_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1412 = _T_1408 ? buf_addr_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1413 = _T_1409 ? buf_addr_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1414 = _T_1410 | _T_1411; // @[Mux.scala 27:72]
  wire [31:0] _T_1415 = _T_1414 | _T_1412; // @[Mux.scala 27:72]
  wire [31:0] _T_1416 = _T_1415 | _T_1413; // @[Mux.scala 27:72]
  wire [3:0] _T_1424 = _T_1406 ? buf_byteen_0 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1425 = _T_1407 ? buf_byteen_1 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1426 = _T_1408 ? buf_byteen_2 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1427 = _T_1409 ? buf_byteen_3 : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_1428 = _T_1424 | _T_1425; // @[Mux.scala 27:72]
  wire [3:0] _T_1429 = _T_1428 | _T_1426; // @[Mux.scala 27:72]
  wire [3:0] _T_1430 = _T_1429 | _T_1427; // @[Mux.scala 27:72]
  wire [7:0] _T_1432 = {_T_1430,4'h0}; // @[Cat.scala 29:58]
  wire [7:0] _T_1445 = {4'h0,_T_1430}; // @[Cat.scala 29:58]
  wire [7:0] _T_1446 = _T_1416[2] ? _T_1432 : _T_1445; // @[lsu_bus_buffer.scala 326:8]
  wire [7:0] obuf_byteen1_in = ibuf_buf_byp ? _T_1405 : _T_1446; // @[lsu_bus_buffer.scala 325:28]
  wire [63:0] _T_1448 = {store_data_lo_r,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1449 = {32'h0,store_data_lo_r}; // @[Cat.scala 29:58]
  wire [63:0] _T_1450 = io_lsu_addr_r[2] ? _T_1448 : _T_1449; // @[lsu_bus_buffer.scala 328:44]
  wire [31:0] _T_1469 = _T_1023 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1470 = _T_1024 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1471 = _T_1025 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1472 = _T_1026 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1473 = _T_1469 | _T_1470; // @[Mux.scala 27:72]
  wire [31:0] _T_1474 = _T_1473 | _T_1471; // @[Mux.scala 27:72]
  wire [31:0] _T_1475 = _T_1474 | _T_1472; // @[Mux.scala 27:72]
  wire [63:0] _T_1477 = {_T_1475,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1490 = {32'h0,_T_1475}; // @[Cat.scala 29:58]
  wire [63:0] _T_1491 = _T_1289[2] ? _T_1477 : _T_1490; // @[lsu_bus_buffer.scala 329:8]
  wire [63:0] obuf_data0_in = ibuf_buf_byp ? _T_1450 : _T_1491; // @[lsu_bus_buffer.scala 328:26]
  wire [63:0] _T_1493 = {store_data_hi_r,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1494 = {32'h0,store_data_hi_r}; // @[Cat.scala 29:58]
  wire [63:0] _T_1495 = io_lsu_addr_r[2] ? _T_1493 : _T_1494; // @[lsu_bus_buffer.scala 330:44]
  wire [31:0] _T_1514 = _T_1406 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1515 = _T_1407 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1516 = _T_1408 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1517 = _T_1409 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1518 = _T_1514 | _T_1515; // @[Mux.scala 27:72]
  wire [31:0] _T_1519 = _T_1518 | _T_1516; // @[Mux.scala 27:72]
  wire [31:0] _T_1520 = _T_1519 | _T_1517; // @[Mux.scala 27:72]
  wire [63:0] _T_1522 = {_T_1520,32'h0}; // @[Cat.scala 29:58]
  wire [63:0] _T_1535 = {32'h0,_T_1520}; // @[Cat.scala 29:58]
  wire [63:0] _T_1536 = _T_1416[2] ? _T_1522 : _T_1535; // @[lsu_bus_buffer.scala 331:8]
  wire [63:0] obuf_data1_in = ibuf_buf_byp ? _T_1495 : _T_1536; // @[lsu_bus_buffer.scala 330:26]
  wire  _T_1621 = CmdPtr0 != CmdPtr1; // @[lsu_bus_buffer.scala 337:30]
  wire  _T_1622 = _T_1621 & found_cmdptr0; // @[lsu_bus_buffer.scala 337:43]
  wire  _T_1623 = _T_1622 & found_cmdptr1; // @[lsu_bus_buffer.scala 337:59]
  wire  _T_1637 = _T_1623 & _T_1107; // @[lsu_bus_buffer.scala 337:75]
  wire [2:0] _T_1642 = _T_1406 ? buf_state_0 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1643 = _T_1407 ? buf_state_1 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1646 = _T_1642 | _T_1643; // @[Mux.scala 27:72]
  wire [2:0] _T_1644 = _T_1408 ? buf_state_2 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1647 = _T_1646 | _T_1644; // @[Mux.scala 27:72]
  wire [2:0] _T_1645 = _T_1409 ? buf_state_3 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_1648 = _T_1647 | _T_1645; // @[Mux.scala 27:72]
  wire  _T_1650 = _T_1648 == 3'h2; // @[lsu_bus_buffer.scala 337:150]
  wire  _T_1651 = _T_1637 & _T_1650; // @[lsu_bus_buffer.scala 337:118]
  wire  _T_1672 = _T_1651 & _T_1128; // @[lsu_bus_buffer.scala 337:161]
  wire  _T_1690 = _T_1672 & _T_1053; // @[lsu_bus_buffer.scala 338:85]
  wire  _T_1792 = _T_1204 & _T_1166; // @[lsu_bus_buffer.scala 341:38]
  reg  buf_dualhi_3; // @[Reg.scala 27:20]
  reg  buf_dualhi_2; // @[Reg.scala 27:20]
  reg  buf_dualhi_1; // @[Reg.scala 27:20]
  reg  buf_dualhi_0; // @[Reg.scala 27:20]
  wire [3:0] _T_1795 = {buf_dualhi_3,buf_dualhi_2,buf_dualhi_1,buf_dualhi_0}; // @[Cat.scala 29:58]
  wire  _T_1804 = _T_1023 & _T_1795[0]; // @[Mux.scala 27:72]
  wire  _T_1805 = _T_1024 & _T_1795[1]; // @[Mux.scala 27:72]
  wire  _T_1808 = _T_1804 | _T_1805; // @[Mux.scala 27:72]
  wire  _T_1806 = _T_1025 & _T_1795[2]; // @[Mux.scala 27:72]
  wire  _T_1809 = _T_1808 | _T_1806; // @[Mux.scala 27:72]
  wire  _T_1807 = _T_1026 & _T_1795[3]; // @[Mux.scala 27:72]
  wire  _T_1810 = _T_1809 | _T_1807; // @[Mux.scala 27:72]
  wire  _T_1812 = ~_T_1810; // @[lsu_bus_buffer.scala 341:109]
  wire  _T_1813 = _T_1792 & _T_1812; // @[lsu_bus_buffer.scala 341:107]
  wire  _T_1833 = _T_1813 & _T_1185; // @[lsu_bus_buffer.scala 341:179]
  wire  _T_1835 = _T_1690 & _T_1833; // @[lsu_bus_buffer.scala 338:122]
  wire  _T_1836 = ibuf_buf_byp & ldst_samedw_r; // @[lsu_bus_buffer.scala 342:19]
  wire  _T_1837 = _T_1836 & io_ldst_dual_r; // @[lsu_bus_buffer.scala 342:35]
  wire  obuf_merge_en = _T_1835 | _T_1837; // @[lsu_bus_buffer.scala 341:253]
  wire  _T_1539 = obuf_merge_en & obuf_byteen1_in[0]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1540 = obuf_byteen0_in[0] | _T_1539; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1543 = obuf_merge_en & obuf_byteen1_in[1]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1544 = obuf_byteen0_in[1] | _T_1543; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1547 = obuf_merge_en & obuf_byteen1_in[2]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1548 = obuf_byteen0_in[2] | _T_1547; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1551 = obuf_merge_en & obuf_byteen1_in[3]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1552 = obuf_byteen0_in[3] | _T_1551; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1555 = obuf_merge_en & obuf_byteen1_in[4]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1556 = obuf_byteen0_in[4] | _T_1555; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1559 = obuf_merge_en & obuf_byteen1_in[5]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1560 = obuf_byteen0_in[5] | _T_1559; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1563 = obuf_merge_en & obuf_byteen1_in[6]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1564 = obuf_byteen0_in[6] | _T_1563; // @[lsu_bus_buffer.scala 332:63]
  wire  _T_1567 = obuf_merge_en & obuf_byteen1_in[7]; // @[lsu_bus_buffer.scala 332:80]
  wire  _T_1568 = obuf_byteen0_in[7] | _T_1567; // @[lsu_bus_buffer.scala 332:63]
  wire [7:0] obuf_byteen_in = {_T_1568,_T_1564,_T_1560,_T_1556,_T_1552,_T_1548,_T_1544,_T_1540}; // @[Cat.scala 29:58]
  wire [7:0] _T_1579 = _T_1539 ? obuf_data1_in[7:0] : obuf_data0_in[7:0]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1584 = _T_1543 ? obuf_data1_in[15:8] : obuf_data0_in[15:8]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1589 = _T_1547 ? obuf_data1_in[23:16] : obuf_data0_in[23:16]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1594 = _T_1551 ? obuf_data1_in[31:24] : obuf_data0_in[31:24]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1599 = _T_1555 ? obuf_data1_in[39:32] : obuf_data0_in[39:32]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1604 = _T_1559 ? obuf_data1_in[47:40] : obuf_data0_in[47:40]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1609 = _T_1563 ? obuf_data1_in[55:48] : obuf_data0_in[55:48]; // @[lsu_bus_buffer.scala 333:44]
  wire [7:0] _T_1614 = _T_1567 ? obuf_data1_in[63:56] : obuf_data0_in[63:56]; // @[lsu_bus_buffer.scala 333:44]
  wire [55:0] _T_1620 = {_T_1614,_T_1609,_T_1604,_T_1599,_T_1594,_T_1589,_T_1584}; // @[Cat.scala 29:58]
  wire  _T_1839 = obuf_wr_en | obuf_valid; // @[lsu_bus_buffer.scala 345:58]
  wire  _T_1840 = ~obuf_rst; // @[lsu_bus_buffer.scala 345:93]
  reg [1:0] obuf_sz; // @[Reg.scala 27:20]
  reg [7:0] obuf_byteen; // @[Reg.scala 27:20]
  reg [63:0] obuf_data; // @[lib.scala 358:16]
  wire  _T_1853 = buf_state_0 == 3'h0; // @[lsu_bus_buffer.scala 363:65]
  wire  _T_1854 = ibuf_tag == 2'h0; // @[lsu_bus_buffer.scala 364:30]
  wire  _T_1855 = ibuf_valid & _T_1854; // @[lsu_bus_buffer.scala 364:19]
  wire  _T_1856 = WrPtr0_r == 2'h0; // @[lsu_bus_buffer.scala 365:18]
  wire  _T_1857 = WrPtr1_r == 2'h0; // @[lsu_bus_buffer.scala 365:57]
  wire  _T_1858 = io_ldst_dual_r & _T_1857; // @[lsu_bus_buffer.scala 365:45]
  wire  _T_1859 = _T_1856 | _T_1858; // @[lsu_bus_buffer.scala 365:27]
  wire  _T_1860 = io_lsu_busreq_r & _T_1859; // @[lsu_bus_buffer.scala 364:58]
  wire  _T_1861 = _T_1855 | _T_1860; // @[lsu_bus_buffer.scala 364:39]
  wire  _T_1862 = ~_T_1861; // @[lsu_bus_buffer.scala 364:5]
  wire  _T_1863 = _T_1853 & _T_1862; // @[lsu_bus_buffer.scala 363:76]
  wire  _T_1864 = buf_state_1 == 3'h0; // @[lsu_bus_buffer.scala 363:65]
  wire  _T_1865 = ibuf_tag == 2'h1; // @[lsu_bus_buffer.scala 364:30]
  wire  _T_1866 = ibuf_valid & _T_1865; // @[lsu_bus_buffer.scala 364:19]
  wire  _T_1867 = WrPtr0_r == 2'h1; // @[lsu_bus_buffer.scala 365:18]
  wire  _T_1868 = WrPtr1_r == 2'h1; // @[lsu_bus_buffer.scala 365:57]
  wire  _T_1869 = io_ldst_dual_r & _T_1868; // @[lsu_bus_buffer.scala 365:45]
  wire  _T_1870 = _T_1867 | _T_1869; // @[lsu_bus_buffer.scala 365:27]
  wire  _T_1871 = io_lsu_busreq_r & _T_1870; // @[lsu_bus_buffer.scala 364:58]
  wire  _T_1872 = _T_1866 | _T_1871; // @[lsu_bus_buffer.scala 364:39]
  wire  _T_1873 = ~_T_1872; // @[lsu_bus_buffer.scala 364:5]
  wire  _T_1874 = _T_1864 & _T_1873; // @[lsu_bus_buffer.scala 363:76]
  wire  _T_1875 = buf_state_2 == 3'h0; // @[lsu_bus_buffer.scala 363:65]
  wire  _T_1876 = ibuf_tag == 2'h2; // @[lsu_bus_buffer.scala 364:30]
  wire  _T_1877 = ibuf_valid & _T_1876; // @[lsu_bus_buffer.scala 364:19]
  wire  _T_1878 = WrPtr0_r == 2'h2; // @[lsu_bus_buffer.scala 365:18]
  wire  _T_1879 = WrPtr1_r == 2'h2; // @[lsu_bus_buffer.scala 365:57]
  wire  _T_1880 = io_ldst_dual_r & _T_1879; // @[lsu_bus_buffer.scala 365:45]
  wire  _T_1881 = _T_1878 | _T_1880; // @[lsu_bus_buffer.scala 365:27]
  wire  _T_1882 = io_lsu_busreq_r & _T_1881; // @[lsu_bus_buffer.scala 364:58]
  wire  _T_1883 = _T_1877 | _T_1882; // @[lsu_bus_buffer.scala 364:39]
  wire  _T_1884 = ~_T_1883; // @[lsu_bus_buffer.scala 364:5]
  wire  _T_1885 = _T_1875 & _T_1884; // @[lsu_bus_buffer.scala 363:76]
  wire  _T_1886 = buf_state_3 == 3'h0; // @[lsu_bus_buffer.scala 363:65]
  wire  _T_1887 = ibuf_tag == 2'h3; // @[lsu_bus_buffer.scala 364:30]
  wire  _T_1889 = WrPtr0_r == 2'h3; // @[lsu_bus_buffer.scala 365:18]
  wire  _T_1890 = WrPtr1_r == 2'h3; // @[lsu_bus_buffer.scala 365:57]
  wire [1:0] _T_1898 = _T_1885 ? 2'h2 : 2'h3; // @[Mux.scala 98:16]
  wire [1:0] _T_1899 = _T_1874 ? 2'h1 : _T_1898; // @[Mux.scala 98:16]
  wire [1:0] WrPtr0_m = _T_1863 ? 2'h0 : _T_1899; // @[Mux.scala 98:16]
  wire  _T_1904 = WrPtr0_m == 2'h0; // @[lsu_bus_buffer.scala 370:33]
  wire  _T_1905 = io_lsu_busreq_m & _T_1904; // @[lsu_bus_buffer.scala 370:22]
  wire  _T_1906 = _T_1855 | _T_1905; // @[lsu_bus_buffer.scala 369:112]
  wire  _T_1912 = _T_1906 | _T_1860; // @[lsu_bus_buffer.scala 370:42]
  wire  _T_1913 = ~_T_1912; // @[lsu_bus_buffer.scala 369:78]
  wire  _T_1914 = _T_1853 & _T_1913; // @[lsu_bus_buffer.scala 369:76]
  wire  _T_1918 = WrPtr0_m == 2'h1; // @[lsu_bus_buffer.scala 370:33]
  wire  _T_1919 = io_lsu_busreq_m & _T_1918; // @[lsu_bus_buffer.scala 370:22]
  wire  _T_1920 = _T_1866 | _T_1919; // @[lsu_bus_buffer.scala 369:112]
  wire  _T_1926 = _T_1920 | _T_1871; // @[lsu_bus_buffer.scala 370:42]
  wire  _T_1927 = ~_T_1926; // @[lsu_bus_buffer.scala 369:78]
  wire  _T_1928 = _T_1864 & _T_1927; // @[lsu_bus_buffer.scala 369:76]
  wire  _T_1932 = WrPtr0_m == 2'h2; // @[lsu_bus_buffer.scala 370:33]
  wire  _T_1933 = io_lsu_busreq_m & _T_1932; // @[lsu_bus_buffer.scala 370:22]
  wire  _T_1934 = _T_1877 | _T_1933; // @[lsu_bus_buffer.scala 369:112]
  wire  _T_1940 = _T_1934 | _T_1882; // @[lsu_bus_buffer.scala 370:42]
  wire  _T_1941 = ~_T_1940; // @[lsu_bus_buffer.scala 369:78]
  wire  _T_1942 = _T_1875 & _T_1941; // @[lsu_bus_buffer.scala 369:76]
  reg [3:0] buf_rspageQ_0; // @[lsu_bus_buffer.scala 500:63]
  wire  _T_2746 = buf_state_3 == 3'h5; // @[lsu_bus_buffer.scala 413:102]
  wire  _T_2747 = buf_rspageQ_0[3] & _T_2746; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2743 = buf_state_2 == 3'h5; // @[lsu_bus_buffer.scala 413:102]
  wire  _T_2744 = buf_rspageQ_0[2] & _T_2743; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2740 = buf_state_1 == 3'h5; // @[lsu_bus_buffer.scala 413:102]
  wire  _T_2741 = buf_rspageQ_0[1] & _T_2740; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2737 = buf_state_0 == 3'h5; // @[lsu_bus_buffer.scala 413:102]
  wire  _T_2738 = buf_rspageQ_0[0] & _T_2737; // @[lsu_bus_buffer.scala 413:87]
  wire [3:0] buf_rsp_pickage_0 = {_T_2747,_T_2744,_T_2741,_T_2738}; // @[Cat.scala 29:58]
  wire  _T_2033 = |buf_rsp_pickage_0; // @[lsu_bus_buffer.scala 381:65]
  wire  _T_2034 = ~_T_2033; // @[lsu_bus_buffer.scala 381:44]
  wire  _T_2036 = _T_2034 & _T_2737; // @[lsu_bus_buffer.scala 381:70]
  reg [3:0] buf_rspageQ_1; // @[lsu_bus_buffer.scala 500:63]
  wire  _T_2762 = buf_rspageQ_1[3] & _T_2746; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2759 = buf_rspageQ_1[2] & _T_2743; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2756 = buf_rspageQ_1[1] & _T_2740; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2753 = buf_rspageQ_1[0] & _T_2737; // @[lsu_bus_buffer.scala 413:87]
  wire [3:0] buf_rsp_pickage_1 = {_T_2762,_T_2759,_T_2756,_T_2753}; // @[Cat.scala 29:58]
  wire  _T_2037 = |buf_rsp_pickage_1; // @[lsu_bus_buffer.scala 381:65]
  wire  _T_2038 = ~_T_2037; // @[lsu_bus_buffer.scala 381:44]
  wire  _T_2040 = _T_2038 & _T_2740; // @[lsu_bus_buffer.scala 381:70]
  reg [3:0] buf_rspageQ_2; // @[lsu_bus_buffer.scala 500:63]
  wire  _T_2777 = buf_rspageQ_2[3] & _T_2746; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2774 = buf_rspageQ_2[2] & _T_2743; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2771 = buf_rspageQ_2[1] & _T_2740; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2768 = buf_rspageQ_2[0] & _T_2737; // @[lsu_bus_buffer.scala 413:87]
  wire [3:0] buf_rsp_pickage_2 = {_T_2777,_T_2774,_T_2771,_T_2768}; // @[Cat.scala 29:58]
  wire  _T_2041 = |buf_rsp_pickage_2; // @[lsu_bus_buffer.scala 381:65]
  wire  _T_2042 = ~_T_2041; // @[lsu_bus_buffer.scala 381:44]
  wire  _T_2044 = _T_2042 & _T_2743; // @[lsu_bus_buffer.scala 381:70]
  reg [3:0] buf_rspageQ_3; // @[lsu_bus_buffer.scala 500:63]
  wire  _T_2792 = buf_rspageQ_3[3] & _T_2746; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2789 = buf_rspageQ_3[2] & _T_2743; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2786 = buf_rspageQ_3[1] & _T_2740; // @[lsu_bus_buffer.scala 413:87]
  wire  _T_2783 = buf_rspageQ_3[0] & _T_2737; // @[lsu_bus_buffer.scala 413:87]
  wire [3:0] buf_rsp_pickage_3 = {_T_2792,_T_2789,_T_2786,_T_2783}; // @[Cat.scala 29:58]
  wire  _T_2045 = |buf_rsp_pickage_3; // @[lsu_bus_buffer.scala 381:65]
  wire  _T_2046 = ~_T_2045; // @[lsu_bus_buffer.scala 381:44]
  wire  _T_2048 = _T_2046 & _T_2746; // @[lsu_bus_buffer.scala 381:70]
  wire [7:0] _T_2104 = {4'h0,_T_2048,_T_2044,_T_2040,_T_2036}; // @[Cat.scala 29:58]
  wire  _T_2107 = _T_2104[4] | _T_2104[5]; // @[lsu_bus_buffer.scala 385:42]
  wire  _T_2109 = _T_2107 | _T_2104[6]; // @[lsu_bus_buffer.scala 385:48]
  wire  _T_2111 = _T_2109 | _T_2104[7]; // @[lsu_bus_buffer.scala 385:54]
  wire  _T_2114 = _T_2104[2] | _T_2104[3]; // @[lsu_bus_buffer.scala 385:67]
  wire  _T_2116 = _T_2114 | _T_2104[6]; // @[lsu_bus_buffer.scala 385:73]
  wire  _T_2118 = _T_2116 | _T_2104[7]; // @[lsu_bus_buffer.scala 385:79]
  wire  _T_2121 = _T_2104[1] | _T_2104[3]; // @[lsu_bus_buffer.scala 385:92]
  wire  _T_2123 = _T_2121 | _T_2104[5]; // @[lsu_bus_buffer.scala 385:98]
  wire  _T_2125 = _T_2123 | _T_2104[7]; // @[lsu_bus_buffer.scala 385:104]
  wire [2:0] _T_2127 = {_T_2111,_T_2118,_T_2125}; // @[Cat.scala 29:58]
  wire  _T_3532 = ibuf_byp | io_ldst_dual_r; // @[lsu_bus_buffer.scala 443:77]
  wire  _T_3533 = ~ibuf_merge_en; // @[lsu_bus_buffer.scala 443:97]
  wire  _T_3534 = _T_3532 & _T_3533; // @[lsu_bus_buffer.scala 443:95]
  wire  _T_3535 = 2'h0 == WrPtr0_r; // @[lsu_bus_buffer.scala 443:117]
  wire  _T_3536 = _T_3534 & _T_3535; // @[lsu_bus_buffer.scala 443:112]
  wire  _T_3537 = ibuf_byp & io_ldst_dual_r; // @[lsu_bus_buffer.scala 443:144]
  wire  _T_3538 = 2'h0 == WrPtr1_r; // @[lsu_bus_buffer.scala 443:166]
  wire  _T_3539 = _T_3537 & _T_3538; // @[lsu_bus_buffer.scala 443:161]
  wire  _T_3540 = _T_3536 | _T_3539; // @[lsu_bus_buffer.scala 443:132]
  wire  _T_3541 = _T_853 & _T_3540; // @[lsu_bus_buffer.scala 443:63]
  wire  _T_3542 = 2'h0 == ibuf_tag; // @[lsu_bus_buffer.scala 443:206]
  wire  _T_3543 = ibuf_drain_vld & _T_3542; // @[lsu_bus_buffer.scala 443:201]
  wire  _T_3544 = _T_3541 | _T_3543; // @[lsu_bus_buffer.scala 443:183]
  wire  _T_3554 = io_lsu_bus_clk_en | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 450:46]
  wire  _T_3589 = 3'h3 == buf_state_0; // @[Conditional.scala 37:30]
  wire  bus_rsp_write = io_lsu_axi_b_valid & io_lsu_axi_b_ready; // @[lsu_bus_buffer.scala 560:39]
  wire  _T_3634 = io_lsu_axi_b_bits_id == 3'h0; // @[lsu_bus_buffer.scala 468:73]
  wire  _T_3635 = bus_rsp_write & _T_3634; // @[lsu_bus_buffer.scala 468:52]
  wire  _T_3636 = io_lsu_axi_r_bits_id == 3'h0; // @[lsu_bus_buffer.scala 469:46]
  reg  _T_4307; // @[Reg.scala 27:20]
  reg  _T_4305; // @[Reg.scala 27:20]
  reg  _T_4303; // @[Reg.scala 27:20]
  reg  _T_4301; // @[Reg.scala 27:20]
  wire [3:0] buf_ldfwd = {_T_4307,_T_4305,_T_4303,_T_4301}; // @[Cat.scala 29:58]
  reg [1:0] buf_ldfwdtag_0; // @[Reg.scala 27:20]
  wire [2:0] _GEN_368 = {{1'd0}, buf_ldfwdtag_0}; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_3638 = io_lsu_axi_r_bits_id == _GEN_368; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_3639 = buf_ldfwd[0] & _T_3638; // @[lsu_bus_buffer.scala 470:27]
  wire  _T_3640 = _T_3636 | _T_3639; // @[lsu_bus_buffer.scala 469:77]
  wire  _T_3641 = buf_dual_0 & buf_dualhi_0; // @[lsu_bus_buffer.scala 471:26]
  wire  _T_3643 = ~buf_write[0]; // @[lsu_bus_buffer.scala 471:44]
  wire  _T_3644 = _T_3641 & _T_3643; // @[lsu_bus_buffer.scala 471:42]
  wire  _T_3645 = _T_3644 & buf_samedw_0; // @[lsu_bus_buffer.scala 471:58]
  reg [1:0] buf_dualtag_0; // @[Reg.scala 27:20]
  wire [2:0] _GEN_369 = {{1'd0}, buf_dualtag_0}; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_3646 = io_lsu_axi_r_bits_id == _GEN_369; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_3647 = _T_3645 & _T_3646; // @[lsu_bus_buffer.scala 471:74]
  wire  _T_3648 = _T_3640 | _T_3647; // @[lsu_bus_buffer.scala 470:71]
  wire  _T_3649 = bus_rsp_read & _T_3648; // @[lsu_bus_buffer.scala 469:25]
  wire  _T_3650 = _T_3635 | _T_3649; // @[lsu_bus_buffer.scala 468:105]
  wire  _GEN_42 = _T_3589 & _T_3650; // @[Conditional.scala 39:67]
  wire  _GEN_61 = _T_3555 ? 1'h0 : _GEN_42; // @[Conditional.scala 39:67]
  wire  _GEN_73 = _T_3551 ? 1'h0 : _GEN_61; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_0 = _T_3528 ? 1'h0 : _GEN_73; // @[Conditional.scala 40:58]
  wire  _T_3676 = 3'h4 == buf_state_0; // @[Conditional.scala 37:30]
  wire [3:0] _T_3686 = buf_ldfwd >> buf_dualtag_0; // @[lsu_bus_buffer.scala 483:21]
  reg [1:0] buf_ldfwdtag_3; // @[Reg.scala 27:20]
  reg [1:0] buf_ldfwdtag_2; // @[Reg.scala 27:20]
  reg [1:0] buf_ldfwdtag_1; // @[Reg.scala 27:20]
  wire [1:0] _GEN_23 = 2'h1 == buf_dualtag_0 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_24 = 2'h2 == buf_dualtag_0 ? buf_ldfwdtag_2 : _GEN_23; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_25 = 2'h3 == buf_dualtag_0 ? buf_ldfwdtag_3 : _GEN_24; // @[lsu_bus_buffer.scala 483:58]
  wire [2:0] _GEN_371 = {{1'd0}, _GEN_25}; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_3688 = io_lsu_axi_r_bits_id == _GEN_371; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_3689 = _T_3686[0] & _T_3688; // @[lsu_bus_buffer.scala 483:38]
  wire  _T_3690 = _T_3646 | _T_3689; // @[lsu_bus_buffer.scala 482:95]
  wire  _T_3691 = bus_rsp_read & _T_3690; // @[lsu_bus_buffer.scala 482:45]
  wire  _GEN_36 = _T_3676 & _T_3691; // @[Conditional.scala 39:67]
  wire  _GEN_43 = _T_3589 ? buf_resp_state_bus_en_0 : _GEN_36; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_3555 ? buf_cmd_state_bus_en_0 : _GEN_43; // @[Conditional.scala 39:67]
  wire  _GEN_66 = _T_3551 ? 1'h0 : _GEN_53; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_0 = _T_3528 ? 1'h0 : _GEN_66; // @[Conditional.scala 40:58]
  wire  _T_3568 = buf_state_bus_en_0 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 456:49]
  wire  _T_3569 = _T_3568 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 456:70]
  wire  _T_3694 = 3'h5 == buf_state_0; // @[Conditional.scala 37:30]
  wire [1:0] RspPtr = _T_2127[1:0]; // @[lsu_bus_buffer.scala 393:10]
  wire  _T_3697 = RspPtr == 2'h0; // @[lsu_bus_buffer.scala 488:37]
  wire  _T_3698 = buf_dualtag_0 == RspPtr; // @[lsu_bus_buffer.scala 488:98]
  wire  _T_3699 = buf_dual_0 & _T_3698; // @[lsu_bus_buffer.scala 488:80]
  wire  _T_3700 = _T_3697 | _T_3699; // @[lsu_bus_buffer.scala 488:65]
  wire  _T_3701 = _T_3700 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 488:112]
  wire  _T_3702 = 3'h6 == buf_state_0; // @[Conditional.scala 37:30]
  wire  _GEN_31 = _T_3694 ? _T_3701 : _T_3702; // @[Conditional.scala 39:67]
  wire  _GEN_37 = _T_3676 ? _T_3569 : _GEN_31; // @[Conditional.scala 39:67]
  wire  _GEN_44 = _T_3589 ? _T_3569 : _GEN_37; // @[Conditional.scala 39:67]
  wire  _GEN_54 = _T_3555 ? _T_3569 : _GEN_44; // @[Conditional.scala 39:67]
  wire  _GEN_64 = _T_3551 ? _T_3554 : _GEN_54; // @[Conditional.scala 39:67]
  wire  buf_state_en_0 = _T_3528 ? _T_3544 : _GEN_64; // @[Conditional.scala 40:58]
  wire  _T_2129 = _T_1853 & buf_state_en_0; // @[lsu_bus_buffer.scala 405:94]
  wire  _T_2135 = ibuf_drain_vld & io_lsu_busreq_r; // @[lsu_bus_buffer.scala 407:23]
  wire  _T_2137 = _T_2135 & _T_3532; // @[lsu_bus_buffer.scala 407:41]
  wire  _T_2139 = _T_2137 & _T_1856; // @[lsu_bus_buffer.scala 407:71]
  wire  _T_2141 = _T_2139 & _T_1854; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2142 = _T_4471 | _T_2141; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2143 = ibuf_byp & io_lsu_busreq_r; // @[lsu_bus_buffer.scala 408:17]
  wire  _T_2144 = _T_2143 & io_ldst_dual_r; // @[lsu_bus_buffer.scala 408:35]
  wire  _T_2146 = _T_2144 & _T_1857; // @[lsu_bus_buffer.scala 408:52]
  wire  _T_2148 = _T_2146 & _T_1856; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2149 = _T_2142 | _T_2148; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2150 = _T_2129 & _T_2149; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2152 = _T_2150 | buf_age_0[0]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2166 = _T_2139 & _T_1865; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2167 = _T_4476 | _T_2166; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2173 = _T_2146 & _T_1867; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2174 = _T_2167 | _T_2173; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2175 = _T_2129 & _T_2174; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2177 = _T_2175 | buf_age_0[1]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2191 = _T_2139 & _T_1876; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2192 = _T_4481 | _T_2191; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2198 = _T_2146 & _T_1878; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2199 = _T_2192 | _T_2198; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2200 = _T_2129 & _T_2199; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2202 = _T_2200 | buf_age_0[2]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2216 = _T_2139 & _T_1887; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2217 = _T_4486 | _T_2216; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2223 = _T_2146 & _T_1889; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2224 = _T_2217 | _T_2223; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2225 = _T_2129 & _T_2224; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2227 = _T_2225 | buf_age_0[3]; // @[lsu_bus_buffer.scala 408:97]
  wire [2:0] _T_2229 = {_T_2227,_T_2202,_T_2177}; // @[Cat.scala 29:58]
  wire  _T_3728 = 2'h1 == WrPtr0_r; // @[lsu_bus_buffer.scala 443:117]
  wire  _T_3729 = _T_3534 & _T_3728; // @[lsu_bus_buffer.scala 443:112]
  wire  _T_3731 = 2'h1 == WrPtr1_r; // @[lsu_bus_buffer.scala 443:166]
  wire  _T_3732 = _T_3537 & _T_3731; // @[lsu_bus_buffer.scala 443:161]
  wire  _T_3733 = _T_3729 | _T_3732; // @[lsu_bus_buffer.scala 443:132]
  wire  _T_3734 = _T_853 & _T_3733; // @[lsu_bus_buffer.scala 443:63]
  wire  _T_3735 = 2'h1 == ibuf_tag; // @[lsu_bus_buffer.scala 443:206]
  wire  _T_3736 = ibuf_drain_vld & _T_3735; // @[lsu_bus_buffer.scala 443:201]
  wire  _T_3737 = _T_3734 | _T_3736; // @[lsu_bus_buffer.scala 443:183]
  wire  _T_3782 = 3'h3 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3827 = io_lsu_axi_b_bits_id == 3'h1; // @[lsu_bus_buffer.scala 468:73]
  wire  _T_3828 = bus_rsp_write & _T_3827; // @[lsu_bus_buffer.scala 468:52]
  wire  _T_3829 = io_lsu_axi_r_bits_id == 3'h1; // @[lsu_bus_buffer.scala 469:46]
  wire [2:0] _GEN_372 = {{1'd0}, buf_ldfwdtag_1}; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_3831 = io_lsu_axi_r_bits_id == _GEN_372; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_3832 = buf_ldfwd[1] & _T_3831; // @[lsu_bus_buffer.scala 470:27]
  wire  _T_3833 = _T_3829 | _T_3832; // @[lsu_bus_buffer.scala 469:77]
  wire  _T_3834 = buf_dual_1 & buf_dualhi_1; // @[lsu_bus_buffer.scala 471:26]
  wire  _T_3836 = ~buf_write[1]; // @[lsu_bus_buffer.scala 471:44]
  wire  _T_3837 = _T_3834 & _T_3836; // @[lsu_bus_buffer.scala 471:42]
  wire  _T_3838 = _T_3837 & buf_samedw_1; // @[lsu_bus_buffer.scala 471:58]
  reg [1:0] buf_dualtag_1; // @[Reg.scala 27:20]
  wire [2:0] _GEN_373 = {{1'd0}, buf_dualtag_1}; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_3839 = io_lsu_axi_r_bits_id == _GEN_373; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_3840 = _T_3838 & _T_3839; // @[lsu_bus_buffer.scala 471:74]
  wire  _T_3841 = _T_3833 | _T_3840; // @[lsu_bus_buffer.scala 470:71]
  wire  _T_3842 = bus_rsp_read & _T_3841; // @[lsu_bus_buffer.scala 469:25]
  wire  _T_3843 = _T_3828 | _T_3842; // @[lsu_bus_buffer.scala 468:105]
  wire  _GEN_118 = _T_3782 & _T_3843; // @[Conditional.scala 39:67]
  wire  _GEN_137 = _T_3748 ? 1'h0 : _GEN_118; // @[Conditional.scala 39:67]
  wire  _GEN_149 = _T_3744 ? 1'h0 : _GEN_137; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_1 = _T_3721 ? 1'h0 : _GEN_149; // @[Conditional.scala 40:58]
  wire  _T_3869 = 3'h4 == buf_state_1; // @[Conditional.scala 37:30]
  wire [3:0] _T_3879 = buf_ldfwd >> buf_dualtag_1; // @[lsu_bus_buffer.scala 483:21]
  wire [1:0] _GEN_99 = 2'h1 == buf_dualtag_1 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_100 = 2'h2 == buf_dualtag_1 ? buf_ldfwdtag_2 : _GEN_99; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_101 = 2'h3 == buf_dualtag_1 ? buf_ldfwdtag_3 : _GEN_100; // @[lsu_bus_buffer.scala 483:58]
  wire [2:0] _GEN_375 = {{1'd0}, _GEN_101}; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_3881 = io_lsu_axi_r_bits_id == _GEN_375; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_3882 = _T_3879[0] & _T_3881; // @[lsu_bus_buffer.scala 483:38]
  wire  _T_3883 = _T_3839 | _T_3882; // @[lsu_bus_buffer.scala 482:95]
  wire  _T_3884 = bus_rsp_read & _T_3883; // @[lsu_bus_buffer.scala 482:45]
  wire  _GEN_112 = _T_3869 & _T_3884; // @[Conditional.scala 39:67]
  wire  _GEN_119 = _T_3782 ? buf_resp_state_bus_en_1 : _GEN_112; // @[Conditional.scala 39:67]
  wire  _GEN_129 = _T_3748 ? buf_cmd_state_bus_en_1 : _GEN_119; // @[Conditional.scala 39:67]
  wire  _GEN_142 = _T_3744 ? 1'h0 : _GEN_129; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_1 = _T_3721 ? 1'h0 : _GEN_142; // @[Conditional.scala 40:58]
  wire  _T_3761 = buf_state_bus_en_1 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 456:49]
  wire  _T_3762 = _T_3761 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 456:70]
  wire  _T_3887 = 3'h5 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _T_3890 = RspPtr == 2'h1; // @[lsu_bus_buffer.scala 488:37]
  wire  _T_3891 = buf_dualtag_1 == RspPtr; // @[lsu_bus_buffer.scala 488:98]
  wire  _T_3892 = buf_dual_1 & _T_3891; // @[lsu_bus_buffer.scala 488:80]
  wire  _T_3893 = _T_3890 | _T_3892; // @[lsu_bus_buffer.scala 488:65]
  wire  _T_3894 = _T_3893 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 488:112]
  wire  _T_3895 = 3'h6 == buf_state_1; // @[Conditional.scala 37:30]
  wire  _GEN_107 = _T_3887 ? _T_3894 : _T_3895; // @[Conditional.scala 39:67]
  wire  _GEN_113 = _T_3869 ? _T_3762 : _GEN_107; // @[Conditional.scala 39:67]
  wire  _GEN_120 = _T_3782 ? _T_3762 : _GEN_113; // @[Conditional.scala 39:67]
  wire  _GEN_130 = _T_3748 ? _T_3762 : _GEN_120; // @[Conditional.scala 39:67]
  wire  _GEN_140 = _T_3744 ? _T_3554 : _GEN_130; // @[Conditional.scala 39:67]
  wire  buf_state_en_1 = _T_3721 ? _T_3737 : _GEN_140; // @[Conditional.scala 40:58]
  wire  _T_2231 = _T_1864 & buf_state_en_1; // @[lsu_bus_buffer.scala 405:94]
  wire  _T_2241 = _T_2137 & _T_1867; // @[lsu_bus_buffer.scala 407:71]
  wire  _T_2243 = _T_2241 & _T_1854; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2244 = _T_4471 | _T_2243; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2248 = _T_2144 & _T_1868; // @[lsu_bus_buffer.scala 408:52]
  wire  _T_2250 = _T_2248 & _T_1856; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2251 = _T_2244 | _T_2250; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2252 = _T_2231 & _T_2251; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2254 = _T_2252 | buf_age_1[0]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2268 = _T_2241 & _T_1865; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2269 = _T_4476 | _T_2268; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2275 = _T_2248 & _T_1867; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2276 = _T_2269 | _T_2275; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2277 = _T_2231 & _T_2276; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2279 = _T_2277 | buf_age_1[1]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2293 = _T_2241 & _T_1876; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2294 = _T_4481 | _T_2293; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2300 = _T_2248 & _T_1878; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2301 = _T_2294 | _T_2300; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2302 = _T_2231 & _T_2301; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2304 = _T_2302 | buf_age_1[2]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2318 = _T_2241 & _T_1887; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2319 = _T_4486 | _T_2318; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2325 = _T_2248 & _T_1889; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2326 = _T_2319 | _T_2325; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2327 = _T_2231 & _T_2326; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2329 = _T_2327 | buf_age_1[3]; // @[lsu_bus_buffer.scala 408:97]
  wire [2:0] _T_2331 = {_T_2329,_T_2304,_T_2279}; // @[Cat.scala 29:58]
  wire  _T_3921 = 2'h2 == WrPtr0_r; // @[lsu_bus_buffer.scala 443:117]
  wire  _T_3922 = _T_3534 & _T_3921; // @[lsu_bus_buffer.scala 443:112]
  wire  _T_3924 = 2'h2 == WrPtr1_r; // @[lsu_bus_buffer.scala 443:166]
  wire  _T_3925 = _T_3537 & _T_3924; // @[lsu_bus_buffer.scala 443:161]
  wire  _T_3926 = _T_3922 | _T_3925; // @[lsu_bus_buffer.scala 443:132]
  wire  _T_3927 = _T_853 & _T_3926; // @[lsu_bus_buffer.scala 443:63]
  wire  _T_3928 = 2'h2 == ibuf_tag; // @[lsu_bus_buffer.scala 443:206]
  wire  _T_3929 = ibuf_drain_vld & _T_3928; // @[lsu_bus_buffer.scala 443:201]
  wire  _T_3930 = _T_3927 | _T_3929; // @[lsu_bus_buffer.scala 443:183]
  wire  _T_3975 = 3'h3 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_4020 = io_lsu_axi_b_bits_id == 3'h2; // @[lsu_bus_buffer.scala 468:73]
  wire  _T_4021 = bus_rsp_write & _T_4020; // @[lsu_bus_buffer.scala 468:52]
  wire  _T_4022 = io_lsu_axi_r_bits_id == 3'h2; // @[lsu_bus_buffer.scala 469:46]
  wire [2:0] _GEN_376 = {{1'd0}, buf_ldfwdtag_2}; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_4024 = io_lsu_axi_r_bits_id == _GEN_376; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_4025 = buf_ldfwd[2] & _T_4024; // @[lsu_bus_buffer.scala 470:27]
  wire  _T_4026 = _T_4022 | _T_4025; // @[lsu_bus_buffer.scala 469:77]
  wire  _T_4027 = buf_dual_2 & buf_dualhi_2; // @[lsu_bus_buffer.scala 471:26]
  wire  _T_4029 = ~buf_write[2]; // @[lsu_bus_buffer.scala 471:44]
  wire  _T_4030 = _T_4027 & _T_4029; // @[lsu_bus_buffer.scala 471:42]
  wire  _T_4031 = _T_4030 & buf_samedw_2; // @[lsu_bus_buffer.scala 471:58]
  reg [1:0] buf_dualtag_2; // @[Reg.scala 27:20]
  wire [2:0] _GEN_377 = {{1'd0}, buf_dualtag_2}; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_4032 = io_lsu_axi_r_bits_id == _GEN_377; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_4033 = _T_4031 & _T_4032; // @[lsu_bus_buffer.scala 471:74]
  wire  _T_4034 = _T_4026 | _T_4033; // @[lsu_bus_buffer.scala 470:71]
  wire  _T_4035 = bus_rsp_read & _T_4034; // @[lsu_bus_buffer.scala 469:25]
  wire  _T_4036 = _T_4021 | _T_4035; // @[lsu_bus_buffer.scala 468:105]
  wire  _GEN_194 = _T_3975 & _T_4036; // @[Conditional.scala 39:67]
  wire  _GEN_213 = _T_3941 ? 1'h0 : _GEN_194; // @[Conditional.scala 39:67]
  wire  _GEN_225 = _T_3937 ? 1'h0 : _GEN_213; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_2 = _T_3914 ? 1'h0 : _GEN_225; // @[Conditional.scala 40:58]
  wire  _T_4062 = 3'h4 == buf_state_2; // @[Conditional.scala 37:30]
  wire [3:0] _T_4072 = buf_ldfwd >> buf_dualtag_2; // @[lsu_bus_buffer.scala 483:21]
  wire [1:0] _GEN_175 = 2'h1 == buf_dualtag_2 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_176 = 2'h2 == buf_dualtag_2 ? buf_ldfwdtag_2 : _GEN_175; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_177 = 2'h3 == buf_dualtag_2 ? buf_ldfwdtag_3 : _GEN_176; // @[lsu_bus_buffer.scala 483:58]
  wire [2:0] _GEN_379 = {{1'd0}, _GEN_177}; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_4074 = io_lsu_axi_r_bits_id == _GEN_379; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_4075 = _T_4072[0] & _T_4074; // @[lsu_bus_buffer.scala 483:38]
  wire  _T_4076 = _T_4032 | _T_4075; // @[lsu_bus_buffer.scala 482:95]
  wire  _T_4077 = bus_rsp_read & _T_4076; // @[lsu_bus_buffer.scala 482:45]
  wire  _GEN_188 = _T_4062 & _T_4077; // @[Conditional.scala 39:67]
  wire  _GEN_195 = _T_3975 ? buf_resp_state_bus_en_2 : _GEN_188; // @[Conditional.scala 39:67]
  wire  _GEN_205 = _T_3941 ? buf_cmd_state_bus_en_2 : _GEN_195; // @[Conditional.scala 39:67]
  wire  _GEN_218 = _T_3937 ? 1'h0 : _GEN_205; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_2 = _T_3914 ? 1'h0 : _GEN_218; // @[Conditional.scala 40:58]
  wire  _T_3954 = buf_state_bus_en_2 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 456:49]
  wire  _T_3955 = _T_3954 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 456:70]
  wire  _T_4080 = 3'h5 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _T_4083 = RspPtr == 2'h2; // @[lsu_bus_buffer.scala 488:37]
  wire  _T_4084 = buf_dualtag_2 == RspPtr; // @[lsu_bus_buffer.scala 488:98]
  wire  _T_4085 = buf_dual_2 & _T_4084; // @[lsu_bus_buffer.scala 488:80]
  wire  _T_4086 = _T_4083 | _T_4085; // @[lsu_bus_buffer.scala 488:65]
  wire  _T_4087 = _T_4086 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 488:112]
  wire  _T_4088 = 3'h6 == buf_state_2; // @[Conditional.scala 37:30]
  wire  _GEN_183 = _T_4080 ? _T_4087 : _T_4088; // @[Conditional.scala 39:67]
  wire  _GEN_189 = _T_4062 ? _T_3955 : _GEN_183; // @[Conditional.scala 39:67]
  wire  _GEN_196 = _T_3975 ? _T_3955 : _GEN_189; // @[Conditional.scala 39:67]
  wire  _GEN_206 = _T_3941 ? _T_3955 : _GEN_196; // @[Conditional.scala 39:67]
  wire  _GEN_216 = _T_3937 ? _T_3554 : _GEN_206; // @[Conditional.scala 39:67]
  wire  buf_state_en_2 = _T_3914 ? _T_3930 : _GEN_216; // @[Conditional.scala 40:58]
  wire  _T_2333 = _T_1875 & buf_state_en_2; // @[lsu_bus_buffer.scala 405:94]
  wire  _T_2343 = _T_2137 & _T_1878; // @[lsu_bus_buffer.scala 407:71]
  wire  _T_2345 = _T_2343 & _T_1854; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2346 = _T_4471 | _T_2345; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2350 = _T_2144 & _T_1879; // @[lsu_bus_buffer.scala 408:52]
  wire  _T_2352 = _T_2350 & _T_1856; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2353 = _T_2346 | _T_2352; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2354 = _T_2333 & _T_2353; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2356 = _T_2354 | buf_age_2[0]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2370 = _T_2343 & _T_1865; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2371 = _T_4476 | _T_2370; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2377 = _T_2350 & _T_1867; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2378 = _T_2371 | _T_2377; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2379 = _T_2333 & _T_2378; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2381 = _T_2379 | buf_age_2[1]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2395 = _T_2343 & _T_1876; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2396 = _T_4481 | _T_2395; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2402 = _T_2350 & _T_1878; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2403 = _T_2396 | _T_2402; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2404 = _T_2333 & _T_2403; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2406 = _T_2404 | buf_age_2[2]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2420 = _T_2343 & _T_1887; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2421 = _T_4486 | _T_2420; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2427 = _T_2350 & _T_1889; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2428 = _T_2421 | _T_2427; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2429 = _T_2333 & _T_2428; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2431 = _T_2429 | buf_age_2[3]; // @[lsu_bus_buffer.scala 408:97]
  wire [2:0] _T_2433 = {_T_2431,_T_2406,_T_2381}; // @[Cat.scala 29:58]
  wire  _T_4114 = 2'h3 == WrPtr0_r; // @[lsu_bus_buffer.scala 443:117]
  wire  _T_4115 = _T_3534 & _T_4114; // @[lsu_bus_buffer.scala 443:112]
  wire  _T_4117 = 2'h3 == WrPtr1_r; // @[lsu_bus_buffer.scala 443:166]
  wire  _T_4118 = _T_3537 & _T_4117; // @[lsu_bus_buffer.scala 443:161]
  wire  _T_4119 = _T_4115 | _T_4118; // @[lsu_bus_buffer.scala 443:132]
  wire  _T_4120 = _T_853 & _T_4119; // @[lsu_bus_buffer.scala 443:63]
  wire  _T_4121 = 2'h3 == ibuf_tag; // @[lsu_bus_buffer.scala 443:206]
  wire  _T_4122 = ibuf_drain_vld & _T_4121; // @[lsu_bus_buffer.scala 443:201]
  wire  _T_4123 = _T_4120 | _T_4122; // @[lsu_bus_buffer.scala 443:183]
  wire  _T_4168 = 3'h3 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4213 = io_lsu_axi_b_bits_id == 3'h3; // @[lsu_bus_buffer.scala 468:73]
  wire  _T_4214 = bus_rsp_write & _T_4213; // @[lsu_bus_buffer.scala 468:52]
  wire  _T_4215 = io_lsu_axi_r_bits_id == 3'h3; // @[lsu_bus_buffer.scala 469:46]
  wire [2:0] _GEN_380 = {{1'd0}, buf_ldfwdtag_3}; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_4217 = io_lsu_axi_r_bits_id == _GEN_380; // @[lsu_bus_buffer.scala 470:47]
  wire  _T_4218 = buf_ldfwd[3] & _T_4217; // @[lsu_bus_buffer.scala 470:27]
  wire  _T_4219 = _T_4215 | _T_4218; // @[lsu_bus_buffer.scala 469:77]
  wire  _T_4220 = buf_dual_3 & buf_dualhi_3; // @[lsu_bus_buffer.scala 471:26]
  wire  _T_4222 = ~buf_write[3]; // @[lsu_bus_buffer.scala 471:44]
  wire  _T_4223 = _T_4220 & _T_4222; // @[lsu_bus_buffer.scala 471:42]
  wire  _T_4224 = _T_4223 & buf_samedw_3; // @[lsu_bus_buffer.scala 471:58]
  reg [1:0] buf_dualtag_3; // @[Reg.scala 27:20]
  wire [2:0] _GEN_381 = {{1'd0}, buf_dualtag_3}; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_4225 = io_lsu_axi_r_bits_id == _GEN_381; // @[lsu_bus_buffer.scala 471:94]
  wire  _T_4226 = _T_4224 & _T_4225; // @[lsu_bus_buffer.scala 471:74]
  wire  _T_4227 = _T_4219 | _T_4226; // @[lsu_bus_buffer.scala 470:71]
  wire  _T_4228 = bus_rsp_read & _T_4227; // @[lsu_bus_buffer.scala 469:25]
  wire  _T_4229 = _T_4214 | _T_4228; // @[lsu_bus_buffer.scala 468:105]
  wire  _GEN_270 = _T_4168 & _T_4229; // @[Conditional.scala 39:67]
  wire  _GEN_289 = _T_4134 ? 1'h0 : _GEN_270; // @[Conditional.scala 39:67]
  wire  _GEN_301 = _T_4130 ? 1'h0 : _GEN_289; // @[Conditional.scala 39:67]
  wire  buf_resp_state_bus_en_3 = _T_4107 ? 1'h0 : _GEN_301; // @[Conditional.scala 40:58]
  wire  _T_4255 = 3'h4 == buf_state_3; // @[Conditional.scala 37:30]
  wire [3:0] _T_4265 = buf_ldfwd >> buf_dualtag_3; // @[lsu_bus_buffer.scala 483:21]
  wire [1:0] _GEN_251 = 2'h1 == buf_dualtag_3 ? buf_ldfwdtag_1 : buf_ldfwdtag_0; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_252 = 2'h2 == buf_dualtag_3 ? buf_ldfwdtag_2 : _GEN_251; // @[lsu_bus_buffer.scala 483:58]
  wire [1:0] _GEN_253 = 2'h3 == buf_dualtag_3 ? buf_ldfwdtag_3 : _GEN_252; // @[lsu_bus_buffer.scala 483:58]
  wire [2:0] _GEN_383 = {{1'd0}, _GEN_253}; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_4267 = io_lsu_axi_r_bits_id == _GEN_383; // @[lsu_bus_buffer.scala 483:58]
  wire  _T_4268 = _T_4265[0] & _T_4267; // @[lsu_bus_buffer.scala 483:38]
  wire  _T_4269 = _T_4225 | _T_4268; // @[lsu_bus_buffer.scala 482:95]
  wire  _T_4270 = bus_rsp_read & _T_4269; // @[lsu_bus_buffer.scala 482:45]
  wire  _GEN_264 = _T_4255 & _T_4270; // @[Conditional.scala 39:67]
  wire  _GEN_271 = _T_4168 ? buf_resp_state_bus_en_3 : _GEN_264; // @[Conditional.scala 39:67]
  wire  _GEN_281 = _T_4134 ? buf_cmd_state_bus_en_3 : _GEN_271; // @[Conditional.scala 39:67]
  wire  _GEN_294 = _T_4130 ? 1'h0 : _GEN_281; // @[Conditional.scala 39:67]
  wire  buf_state_bus_en_3 = _T_4107 ? 1'h0 : _GEN_294; // @[Conditional.scala 40:58]
  wire  _T_4147 = buf_state_bus_en_3 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 456:49]
  wire  _T_4148 = _T_4147 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 456:70]
  wire  _T_4273 = 3'h5 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _T_4276 = RspPtr == 2'h3; // @[lsu_bus_buffer.scala 488:37]
  wire  _T_4277 = buf_dualtag_3 == RspPtr; // @[lsu_bus_buffer.scala 488:98]
  wire  _T_4278 = buf_dual_3 & _T_4277; // @[lsu_bus_buffer.scala 488:80]
  wire  _T_4279 = _T_4276 | _T_4278; // @[lsu_bus_buffer.scala 488:65]
  wire  _T_4280 = _T_4279 | io_dec_tlu_force_halt; // @[lsu_bus_buffer.scala 488:112]
  wire  _T_4281 = 3'h6 == buf_state_3; // @[Conditional.scala 37:30]
  wire  _GEN_259 = _T_4273 ? _T_4280 : _T_4281; // @[Conditional.scala 39:67]
  wire  _GEN_265 = _T_4255 ? _T_4148 : _GEN_259; // @[Conditional.scala 39:67]
  wire  _GEN_272 = _T_4168 ? _T_4148 : _GEN_265; // @[Conditional.scala 39:67]
  wire  _GEN_282 = _T_4134 ? _T_4148 : _GEN_272; // @[Conditional.scala 39:67]
  wire  _GEN_292 = _T_4130 ? _T_3554 : _GEN_282; // @[Conditional.scala 39:67]
  wire  buf_state_en_3 = _T_4107 ? _T_4123 : _GEN_292; // @[Conditional.scala 40:58]
  wire  _T_2435 = _T_1886 & buf_state_en_3; // @[lsu_bus_buffer.scala 405:94]
  wire  _T_2445 = _T_2137 & _T_1889; // @[lsu_bus_buffer.scala 407:71]
  wire  _T_2447 = _T_2445 & _T_1854; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2448 = _T_4471 | _T_2447; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2452 = _T_2144 & _T_1890; // @[lsu_bus_buffer.scala 408:52]
  wire  _T_2454 = _T_2452 & _T_1856; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2455 = _T_2448 | _T_2454; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2456 = _T_2435 & _T_2455; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2458 = _T_2456 | buf_age_3[0]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2472 = _T_2445 & _T_1865; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2473 = _T_4476 | _T_2472; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2479 = _T_2452 & _T_1867; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2480 = _T_2473 | _T_2479; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2481 = _T_2435 & _T_2480; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2483 = _T_2481 | buf_age_3[1]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2497 = _T_2445 & _T_1876; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2498 = _T_4481 | _T_2497; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2504 = _T_2452 & _T_1878; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2505 = _T_2498 | _T_2504; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2506 = _T_2435 & _T_2505; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2508 = _T_2506 | buf_age_3[2]; // @[lsu_bus_buffer.scala 408:97]
  wire  _T_2522 = _T_2445 & _T_1887; // @[lsu_bus_buffer.scala 407:92]
  wire  _T_2523 = _T_4486 | _T_2522; // @[lsu_bus_buffer.scala 406:86]
  wire  _T_2529 = _T_2452 & _T_1889; // @[lsu_bus_buffer.scala 408:73]
  wire  _T_2530 = _T_2523 | _T_2529; // @[lsu_bus_buffer.scala 407:114]
  wire  _T_2531 = _T_2435 & _T_2530; // @[lsu_bus_buffer.scala 405:113]
  wire  _T_2533 = _T_2531 | buf_age_3[3]; // @[lsu_bus_buffer.scala 408:97]
  wire [2:0] _T_2535 = {_T_2533,_T_2508,_T_2483}; // @[Cat.scala 29:58]
  wire  _T_2799 = buf_state_0 == 3'h6; // @[lsu_bus_buffer.scala 416:47]
  wire  _T_2800 = _T_1853 | _T_2799; // @[lsu_bus_buffer.scala 416:32]
  wire  _T_2801 = ~_T_2800; // @[lsu_bus_buffer.scala 416:6]
  wire  _T_2809 = _T_2801 | _T_2141; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2816 = _T_2809 | _T_2148; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2817 = _T_2129 & _T_2816; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_2821 = buf_state_1 == 3'h6; // @[lsu_bus_buffer.scala 416:47]
  wire  _T_2822 = _T_1864 | _T_2821; // @[lsu_bus_buffer.scala 416:32]
  wire  _T_2823 = ~_T_2822; // @[lsu_bus_buffer.scala 416:6]
  wire  _T_2831 = _T_2823 | _T_2166; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2838 = _T_2831 | _T_2173; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2839 = _T_2129 & _T_2838; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_2843 = buf_state_2 == 3'h6; // @[lsu_bus_buffer.scala 416:47]
  wire  _T_2844 = _T_1875 | _T_2843; // @[lsu_bus_buffer.scala 416:32]
  wire  _T_2845 = ~_T_2844; // @[lsu_bus_buffer.scala 416:6]
  wire  _T_2853 = _T_2845 | _T_2191; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2860 = _T_2853 | _T_2198; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2861 = _T_2129 & _T_2860; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_2865 = buf_state_3 == 3'h6; // @[lsu_bus_buffer.scala 416:47]
  wire  _T_2866 = _T_1886 | _T_2865; // @[lsu_bus_buffer.scala 416:32]
  wire  _T_2867 = ~_T_2866; // @[lsu_bus_buffer.scala 416:6]
  wire  _T_2875 = _T_2867 | _T_2216; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2882 = _T_2875 | _T_2223; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2883 = _T_2129 & _T_2882; // @[lsu_bus_buffer.scala 415:112]
  wire [3:0] buf_rspage_set_0 = {_T_2883,_T_2861,_T_2839,_T_2817}; // @[Cat.scala 29:58]
  wire  _T_2900 = _T_2801 | _T_2243; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2907 = _T_2900 | _T_2250; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2908 = _T_2231 & _T_2907; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_2922 = _T_2823 | _T_2268; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2929 = _T_2922 | _T_2275; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2930 = _T_2231 & _T_2929; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_2944 = _T_2845 | _T_2293; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2951 = _T_2944 | _T_2300; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2952 = _T_2231 & _T_2951; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_2966 = _T_2867 | _T_2318; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2973 = _T_2966 | _T_2325; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2974 = _T_2231 & _T_2973; // @[lsu_bus_buffer.scala 415:112]
  wire [3:0] buf_rspage_set_1 = {_T_2974,_T_2952,_T_2930,_T_2908}; // @[Cat.scala 29:58]
  wire  _T_2991 = _T_2801 | _T_2345; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_2998 = _T_2991 | _T_2352; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_2999 = _T_2333 & _T_2998; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_3013 = _T_2823 | _T_2370; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3020 = _T_3013 | _T_2377; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3021 = _T_2333 & _T_3020; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_3035 = _T_2845 | _T_2395; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3042 = _T_3035 | _T_2402; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3043 = _T_2333 & _T_3042; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_3057 = _T_2867 | _T_2420; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3064 = _T_3057 | _T_2427; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3065 = _T_2333 & _T_3064; // @[lsu_bus_buffer.scala 415:112]
  wire [3:0] buf_rspage_set_2 = {_T_3065,_T_3043,_T_3021,_T_2999}; // @[Cat.scala 29:58]
  wire  _T_3082 = _T_2801 | _T_2447; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3089 = _T_3082 | _T_2454; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3090 = _T_2435 & _T_3089; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_3104 = _T_2823 | _T_2472; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3111 = _T_3104 | _T_2479; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3112 = _T_2435 & _T_3111; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_3126 = _T_2845 | _T_2497; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3133 = _T_3126 | _T_2504; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3134 = _T_2435 & _T_3133; // @[lsu_bus_buffer.scala 415:112]
  wire  _T_3148 = _T_2867 | _T_2522; // @[lsu_bus_buffer.scala 416:59]
  wire  _T_3155 = _T_3148 | _T_2529; // @[lsu_bus_buffer.scala 417:110]
  wire  _T_3156 = _T_2435 & _T_3155; // @[lsu_bus_buffer.scala 415:112]
  wire [3:0] buf_rspage_set_3 = {_T_3156,_T_3134,_T_3112,_T_3090}; // @[Cat.scala 29:58]
  wire  _T_3241 = _T_2865 | _T_1886; // @[lsu_bus_buffer.scala 420:110]
  wire  _T_3242 = ~_T_3241; // @[lsu_bus_buffer.scala 420:84]
  wire  _T_3243 = buf_rspageQ_0[3] & _T_3242; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3235 = _T_2843 | _T_1875; // @[lsu_bus_buffer.scala 420:110]
  wire  _T_3236 = ~_T_3235; // @[lsu_bus_buffer.scala 420:84]
  wire  _T_3237 = buf_rspageQ_0[2] & _T_3236; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3229 = _T_2821 | _T_1864; // @[lsu_bus_buffer.scala 420:110]
  wire  _T_3230 = ~_T_3229; // @[lsu_bus_buffer.scala 420:84]
  wire  _T_3231 = buf_rspageQ_0[1] & _T_3230; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3223 = _T_2799 | _T_1853; // @[lsu_bus_buffer.scala 420:110]
  wire  _T_3224 = ~_T_3223; // @[lsu_bus_buffer.scala 420:84]
  wire  _T_3225 = buf_rspageQ_0[0] & _T_3224; // @[lsu_bus_buffer.scala 420:82]
  wire [3:0] buf_rspage_0 = {_T_3243,_T_3237,_T_3231,_T_3225}; // @[Cat.scala 29:58]
  wire  _T_3162 = buf_rspage_set_0[0] | buf_rspage_0[0]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3165 = buf_rspage_set_0[1] | buf_rspage_0[1]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3168 = buf_rspage_set_0[2] | buf_rspage_0[2]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3171 = buf_rspage_set_0[3] | buf_rspage_0[3]; // @[lsu_bus_buffer.scala 419:88]
  wire [2:0] _T_3173 = {_T_3171,_T_3168,_T_3165}; // @[Cat.scala 29:58]
  wire  _T_3270 = buf_rspageQ_1[3] & _T_3242; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3264 = buf_rspageQ_1[2] & _T_3236; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3258 = buf_rspageQ_1[1] & _T_3230; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3252 = buf_rspageQ_1[0] & _T_3224; // @[lsu_bus_buffer.scala 420:82]
  wire [3:0] buf_rspage_1 = {_T_3270,_T_3264,_T_3258,_T_3252}; // @[Cat.scala 29:58]
  wire  _T_3177 = buf_rspage_set_1[0] | buf_rspage_1[0]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3180 = buf_rspage_set_1[1] | buf_rspage_1[1]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3183 = buf_rspage_set_1[2] | buf_rspage_1[2]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3186 = buf_rspage_set_1[3] | buf_rspage_1[3]; // @[lsu_bus_buffer.scala 419:88]
  wire [2:0] _T_3188 = {_T_3186,_T_3183,_T_3180}; // @[Cat.scala 29:58]
  wire  _T_3297 = buf_rspageQ_2[3] & _T_3242; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3291 = buf_rspageQ_2[2] & _T_3236; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3285 = buf_rspageQ_2[1] & _T_3230; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3279 = buf_rspageQ_2[0] & _T_3224; // @[lsu_bus_buffer.scala 420:82]
  wire [3:0] buf_rspage_2 = {_T_3297,_T_3291,_T_3285,_T_3279}; // @[Cat.scala 29:58]
  wire  _T_3192 = buf_rspage_set_2[0] | buf_rspage_2[0]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3195 = buf_rspage_set_2[1] | buf_rspage_2[1]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3198 = buf_rspage_set_2[2] | buf_rspage_2[2]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3201 = buf_rspage_set_2[3] | buf_rspage_2[3]; // @[lsu_bus_buffer.scala 419:88]
  wire [2:0] _T_3203 = {_T_3201,_T_3198,_T_3195}; // @[Cat.scala 29:58]
  wire  _T_3324 = buf_rspageQ_3[3] & _T_3242; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3318 = buf_rspageQ_3[2] & _T_3236; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3312 = buf_rspageQ_3[1] & _T_3230; // @[lsu_bus_buffer.scala 420:82]
  wire  _T_3306 = buf_rspageQ_3[0] & _T_3224; // @[lsu_bus_buffer.scala 420:82]
  wire [3:0] buf_rspage_3 = {_T_3324,_T_3318,_T_3312,_T_3306}; // @[Cat.scala 29:58]
  wire  _T_3207 = buf_rspage_set_3[0] | buf_rspage_3[0]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3210 = buf_rspage_set_3[1] | buf_rspage_3[1]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3213 = buf_rspage_set_3[2] | buf_rspage_3[2]; // @[lsu_bus_buffer.scala 419:88]
  wire  _T_3216 = buf_rspage_set_3[3] | buf_rspage_3[3]; // @[lsu_bus_buffer.scala 419:88]
  wire [2:0] _T_3218 = {_T_3216,_T_3213,_T_3210}; // @[Cat.scala 29:58]
  wire  _T_3329 = ibuf_drain_vld & _T_1854; // @[lsu_bus_buffer.scala 425:63]
  wire  _T_3331 = ibuf_drain_vld & _T_1865; // @[lsu_bus_buffer.scala 425:63]
  wire  _T_3333 = ibuf_drain_vld & _T_1876; // @[lsu_bus_buffer.scala 425:63]
  wire  _T_3335 = ibuf_drain_vld & _T_1887; // @[lsu_bus_buffer.scala 425:63]
  wire [3:0] ibuf_drainvec_vld = {_T_3335,_T_3333,_T_3331,_T_3329}; // @[Cat.scala 29:58]
  wire  _T_3343 = _T_3537 & _T_1857; // @[lsu_bus_buffer.scala 427:35]
  wire  _T_3352 = _T_3537 & _T_1868; // @[lsu_bus_buffer.scala 427:35]
  wire  _T_3361 = _T_3537 & _T_1879; // @[lsu_bus_buffer.scala 427:35]
  wire  _T_3370 = _T_3537 & _T_1890; // @[lsu_bus_buffer.scala 427:35]
  wire  _T_3400 = ibuf_drainvec_vld[0] ? ibuf_dual : io_ldst_dual_r; // @[lsu_bus_buffer.scala 429:45]
  wire  _T_3402 = ibuf_drainvec_vld[1] ? ibuf_dual : io_ldst_dual_r; // @[lsu_bus_buffer.scala 429:45]
  wire  _T_3404 = ibuf_drainvec_vld[2] ? ibuf_dual : io_ldst_dual_r; // @[lsu_bus_buffer.scala 429:45]
  wire  _T_3406 = ibuf_drainvec_vld[3] ? ibuf_dual : io_ldst_dual_r; // @[lsu_bus_buffer.scala 429:45]
  wire [3:0] buf_dual_in = {_T_3406,_T_3404,_T_3402,_T_3400}; // @[Cat.scala 29:58]
  wire  _T_3411 = ibuf_drainvec_vld[0] ? ibuf_samedw : ldst_samedw_r; // @[lsu_bus_buffer.scala 430:47]
  wire  _T_3413 = ibuf_drainvec_vld[1] ? ibuf_samedw : ldst_samedw_r; // @[lsu_bus_buffer.scala 430:47]
  wire  _T_3415 = ibuf_drainvec_vld[2] ? ibuf_samedw : ldst_samedw_r; // @[lsu_bus_buffer.scala 430:47]
  wire  _T_3417 = ibuf_drainvec_vld[3] ? ibuf_samedw : ldst_samedw_r; // @[lsu_bus_buffer.scala 430:47]
  wire [3:0] buf_samedw_in = {_T_3417,_T_3415,_T_3413,_T_3411}; // @[Cat.scala 29:58]
  wire  _T_3422 = ibuf_nomerge | ibuf_force_drain; // @[lsu_bus_buffer.scala 431:84]
  wire  _T_3423 = ibuf_drainvec_vld[0] ? _T_3422 : io_no_dword_merge_r; // @[lsu_bus_buffer.scala 431:48]
  wire  _T_3426 = ibuf_drainvec_vld[1] ? _T_3422 : io_no_dword_merge_r; // @[lsu_bus_buffer.scala 431:48]
  wire  _T_3429 = ibuf_drainvec_vld[2] ? _T_3422 : io_no_dword_merge_r; // @[lsu_bus_buffer.scala 431:48]
  wire  _T_3432 = ibuf_drainvec_vld[3] ? _T_3422 : io_no_dword_merge_r; // @[lsu_bus_buffer.scala 431:48]
  wire [3:0] buf_nomerge_in = {_T_3432,_T_3429,_T_3426,_T_3423}; // @[Cat.scala 29:58]
  wire  _T_3440 = ibuf_drainvec_vld[0] ? ibuf_dual : _T_3343; // @[lsu_bus_buffer.scala 432:47]
  wire  _T_3445 = ibuf_drainvec_vld[1] ? ibuf_dual : _T_3352; // @[lsu_bus_buffer.scala 432:47]
  wire  _T_3450 = ibuf_drainvec_vld[2] ? ibuf_dual : _T_3361; // @[lsu_bus_buffer.scala 432:47]
  wire  _T_3455 = ibuf_drainvec_vld[3] ? ibuf_dual : _T_3370; // @[lsu_bus_buffer.scala 432:47]
  wire [3:0] buf_dualhi_in = {_T_3455,_T_3450,_T_3445,_T_3440}; // @[Cat.scala 29:58]
  wire  _T_3484 = ibuf_drainvec_vld[0] ? ibuf_sideeffect : io_is_sideeffects_r; // @[lsu_bus_buffer.scala 434:51]
  wire  _T_3486 = ibuf_drainvec_vld[1] ? ibuf_sideeffect : io_is_sideeffects_r; // @[lsu_bus_buffer.scala 434:51]
  wire  _T_3488 = ibuf_drainvec_vld[2] ? ibuf_sideeffect : io_is_sideeffects_r; // @[lsu_bus_buffer.scala 434:51]
  wire  _T_3490 = ibuf_drainvec_vld[3] ? ibuf_sideeffect : io_is_sideeffects_r; // @[lsu_bus_buffer.scala 434:51]
  wire [3:0] buf_sideeffect_in = {_T_3490,_T_3488,_T_3486,_T_3484}; // @[Cat.scala 29:58]
  wire  _T_3495 = ibuf_drainvec_vld[0] ? ibuf_unsign : io_lsu_pkt_r_bits_unsign; // @[lsu_bus_buffer.scala 435:47]
  wire  _T_3497 = ibuf_drainvec_vld[1] ? ibuf_unsign : io_lsu_pkt_r_bits_unsign; // @[lsu_bus_buffer.scala 435:47]
  wire  _T_3499 = ibuf_drainvec_vld[2] ? ibuf_unsign : io_lsu_pkt_r_bits_unsign; // @[lsu_bus_buffer.scala 435:47]
  wire  _T_3501 = ibuf_drainvec_vld[3] ? ibuf_unsign : io_lsu_pkt_r_bits_unsign; // @[lsu_bus_buffer.scala 435:47]
  wire [3:0] buf_unsign_in = {_T_3501,_T_3499,_T_3497,_T_3495}; // @[Cat.scala 29:58]
  wire  _T_3518 = ibuf_drainvec_vld[0] ? ibuf_write : io_lsu_pkt_r_bits_store; // @[lsu_bus_buffer.scala 437:46]
  wire  _T_3520 = ibuf_drainvec_vld[1] ? ibuf_write : io_lsu_pkt_r_bits_store; // @[lsu_bus_buffer.scala 437:46]
  wire  _T_3522 = ibuf_drainvec_vld[2] ? ibuf_write : io_lsu_pkt_r_bits_store; // @[lsu_bus_buffer.scala 437:46]
  wire  _T_3524 = ibuf_drainvec_vld[3] ? ibuf_write : io_lsu_pkt_r_bits_store; // @[lsu_bus_buffer.scala 437:46]
  wire [3:0] buf_write_in = {_T_3524,_T_3522,_T_3520,_T_3518}; // @[Cat.scala 29:58]
  wire  _T_3557 = obuf_nosend & bus_rsp_read; // @[lsu_bus_buffer.scala 453:89]
  wire  _T_3559 = _T_3557 & _T_1351; // @[lsu_bus_buffer.scala 453:104]
  wire  _T_3572 = buf_state_en_0 & _T_3643; // @[lsu_bus_buffer.scala 458:44]
  wire  _T_3573 = _T_3572 & obuf_nosend; // @[lsu_bus_buffer.scala 458:60]
  wire  _T_3575 = _T_3573 & _T_1333; // @[lsu_bus_buffer.scala 458:74]
  wire  _T_3578 = _T_3568 & obuf_nosend; // @[lsu_bus_buffer.scala 460:67]
  wire  _T_3579 = _T_3578 & bus_rsp_read; // @[lsu_bus_buffer.scala 460:81]
  wire  _T_4872 = io_lsu_axi_r_bits_resp != 2'h0; // @[lsu_bus_buffer.scala 564:64]
  wire  bus_rsp_read_error = bus_rsp_read & _T_4872; // @[lsu_bus_buffer.scala 564:38]
  wire  _T_3582 = _T_3578 & bus_rsp_read_error; // @[lsu_bus_buffer.scala 461:82]
  wire  _T_3657 = bus_rsp_read_error & _T_3636; // @[lsu_bus_buffer.scala 475:91]
  wire  _T_3659 = bus_rsp_read_error & buf_ldfwd[0]; // @[lsu_bus_buffer.scala 476:31]
  wire  _T_3661 = _T_3659 & _T_3638; // @[lsu_bus_buffer.scala 476:46]
  wire  _T_3662 = _T_3657 | _T_3661; // @[lsu_bus_buffer.scala 475:143]
  wire  _T_4870 = io_lsu_axi_b_bits_resp != 2'h0; // @[lsu_bus_buffer.scala 563:66]
  wire  bus_rsp_write_error = bus_rsp_write & _T_4870; // @[lsu_bus_buffer.scala 563:40]
  wire  _T_3665 = bus_rsp_write_error & _T_3634; // @[lsu_bus_buffer.scala 477:53]
  wire  _T_3666 = _T_3662 | _T_3665; // @[lsu_bus_buffer.scala 476:88]
  wire  _T_3667 = _T_3568 & _T_3666; // @[lsu_bus_buffer.scala 475:68]
  wire  _GEN_46 = _T_3589 & _T_3667; // @[Conditional.scala 39:67]
  wire  _GEN_59 = _T_3555 ? _T_3582 : _GEN_46; // @[Conditional.scala 39:67]
  wire  _GEN_71 = _T_3551 ? 1'h0 : _GEN_59; // @[Conditional.scala 39:67]
  wire  buf_error_en_0 = _T_3528 ? 1'h0 : _GEN_71; // @[Conditional.scala 40:58]
  wire  _T_3592 = ~bus_rsp_write_error; // @[lsu_bus_buffer.scala 465:73]
  wire  _T_3593 = buf_write[0] & _T_3592; // @[lsu_bus_buffer.scala 465:71]
  wire  _T_3594 = io_dec_tlu_force_halt | _T_3593; // @[lsu_bus_buffer.scala 465:55]
  wire  _T_3596 = ~buf_samedw_0; // @[lsu_bus_buffer.scala 466:30]
  wire  _T_3597 = buf_dual_0 & _T_3596; // @[lsu_bus_buffer.scala 466:28]
  wire  _T_3600 = _T_3597 & _T_3643; // @[lsu_bus_buffer.scala 466:45]
  wire [2:0] _GEN_19 = 2'h1 == buf_dualtag_0 ? buf_state_1 : buf_state_0; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_20 = 2'h2 == buf_dualtag_0 ? buf_state_2 : _GEN_19; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_21 = 2'h3 == buf_dualtag_0 ? buf_state_3 : _GEN_20; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_3601 = _GEN_21 != 3'h4; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_3602 = _T_3600 & _T_3601; // @[lsu_bus_buffer.scala 466:61]
  wire  _T_4494 = _T_2746 | _T_2743; // @[lsu_bus_buffer.scala 524:93]
  wire  _T_4495 = _T_4494 | _T_2740; // @[lsu_bus_buffer.scala 524:93]
  wire  any_done_wait_state = _T_4495 | _T_2737; // @[lsu_bus_buffer.scala 524:93]
  wire  _T_3604 = buf_ldfwd[0] | any_done_wait_state; // @[lsu_bus_buffer.scala 467:31]
  wire  _T_3610 = buf_dualtag_0 == 2'h0; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3612 = buf_dualtag_0 == 2'h1; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3614 = buf_dualtag_0 == 2'h2; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3616 = buf_dualtag_0 == 2'h3; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3618 = _T_3610 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_3619 = _T_3612 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_3620 = _T_3614 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_3621 = _T_3616 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_3622 = _T_3618 | _T_3619; // @[Mux.scala 27:72]
  wire  _T_3623 = _T_3622 | _T_3620; // @[Mux.scala 27:72]
  wire  _T_3624 = _T_3623 | _T_3621; // @[Mux.scala 27:72]
  wire  _T_3626 = _T_3600 & _T_3624; // @[lsu_bus_buffer.scala 467:101]
  wire  _T_3627 = _GEN_21 == 3'h4; // @[lsu_bus_buffer.scala 467:167]
  wire  _T_3628 = _T_3626 & _T_3627; // @[lsu_bus_buffer.scala 467:138]
  wire  _T_3629 = _T_3628 & any_done_wait_state; // @[lsu_bus_buffer.scala 467:187]
  wire  _T_3630 = _T_3604 | _T_3629; // @[lsu_bus_buffer.scala 467:53]
  wire  _T_3653 = buf_state_bus_en_0 & bus_rsp_read; // @[lsu_bus_buffer.scala 474:47]
  wire  _T_3654 = _T_3653 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 474:62]
  wire  _T_3668 = ~buf_error_en_0; // @[lsu_bus_buffer.scala 478:50]
  wire  _T_3669 = buf_state_en_0 & _T_3668; // @[lsu_bus_buffer.scala 478:48]
  wire  _T_3681 = buf_ldfwd[0] | _T_3686[0]; // @[lsu_bus_buffer.scala 481:90]
  wire  _T_3682 = _T_3681 | any_done_wait_state; // @[lsu_bus_buffer.scala 481:118]
  wire  _GEN_29 = _T_3702 & buf_state_en_0; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_3694 ? 1'h0 : _T_3702; // @[Conditional.scala 39:67]
  wire  _GEN_34 = _T_3694 ? 1'h0 : _GEN_29; // @[Conditional.scala 39:67]
  wire  _GEN_38 = _T_3676 ? 1'h0 : _GEN_32; // @[Conditional.scala 39:67]
  wire  _GEN_40 = _T_3676 ? 1'h0 : _GEN_34; // @[Conditional.scala 39:67]
  wire  _GEN_45 = _T_3589 & _T_3654; // @[Conditional.scala 39:67]
  wire  _GEN_48 = _T_3589 ? 1'h0 : _GEN_38; // @[Conditional.scala 39:67]
  wire  _GEN_50 = _T_3589 ? 1'h0 : _GEN_40; // @[Conditional.scala 39:67]
  wire  _GEN_56 = _T_3555 ? _T_3575 : _GEN_50; // @[Conditional.scala 39:67]
  wire  _GEN_58 = _T_3555 ? _T_3579 : _GEN_45; // @[Conditional.scala 39:67]
  wire  _GEN_62 = _T_3555 ? 1'h0 : _GEN_48; // @[Conditional.scala 39:67]
  wire  _GEN_68 = _T_3551 ? 1'h0 : _GEN_56; // @[Conditional.scala 39:67]
  wire  _GEN_70 = _T_3551 ? 1'h0 : _GEN_58; // @[Conditional.scala 39:67]
  wire  _GEN_74 = _T_3551 ? 1'h0 : _GEN_62; // @[Conditional.scala 39:67]
  wire  buf_wr_en_0 = _T_3528 & buf_state_en_0; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_0 = _T_3528 ? 1'h0 : _GEN_68; // @[Conditional.scala 40:58]
  wire  buf_rst_0 = _T_3528 ? 1'h0 : _GEN_74; // @[Conditional.scala 40:58]
  wire  _T_3765 = buf_state_en_1 & _T_3836; // @[lsu_bus_buffer.scala 458:44]
  wire  _T_3766 = _T_3765 & obuf_nosend; // @[lsu_bus_buffer.scala 458:60]
  wire  _T_3768 = _T_3766 & _T_1333; // @[lsu_bus_buffer.scala 458:74]
  wire  _T_3771 = _T_3761 & obuf_nosend; // @[lsu_bus_buffer.scala 460:67]
  wire  _T_3772 = _T_3771 & bus_rsp_read; // @[lsu_bus_buffer.scala 460:81]
  wire  _T_3775 = _T_3771 & bus_rsp_read_error; // @[lsu_bus_buffer.scala 461:82]
  wire  _T_3850 = bus_rsp_read_error & _T_3829; // @[lsu_bus_buffer.scala 475:91]
  wire  _T_3852 = bus_rsp_read_error & buf_ldfwd[1]; // @[lsu_bus_buffer.scala 476:31]
  wire  _T_3854 = _T_3852 & _T_3831; // @[lsu_bus_buffer.scala 476:46]
  wire  _T_3855 = _T_3850 | _T_3854; // @[lsu_bus_buffer.scala 475:143]
  wire  _T_3858 = bus_rsp_write_error & _T_3827; // @[lsu_bus_buffer.scala 477:53]
  wire  _T_3859 = _T_3855 | _T_3858; // @[lsu_bus_buffer.scala 476:88]
  wire  _T_3860 = _T_3761 & _T_3859; // @[lsu_bus_buffer.scala 475:68]
  wire  _GEN_122 = _T_3782 & _T_3860; // @[Conditional.scala 39:67]
  wire  _GEN_135 = _T_3748 ? _T_3775 : _GEN_122; // @[Conditional.scala 39:67]
  wire  _GEN_147 = _T_3744 ? 1'h0 : _GEN_135; // @[Conditional.scala 39:67]
  wire  buf_error_en_1 = _T_3721 ? 1'h0 : _GEN_147; // @[Conditional.scala 40:58]
  wire  _T_3786 = buf_write[1] & _T_3592; // @[lsu_bus_buffer.scala 465:71]
  wire  _T_3787 = io_dec_tlu_force_halt | _T_3786; // @[lsu_bus_buffer.scala 465:55]
  wire  _T_3789 = ~buf_samedw_1; // @[lsu_bus_buffer.scala 466:30]
  wire  _T_3790 = buf_dual_1 & _T_3789; // @[lsu_bus_buffer.scala 466:28]
  wire  _T_3793 = _T_3790 & _T_3836; // @[lsu_bus_buffer.scala 466:45]
  wire [2:0] _GEN_95 = 2'h1 == buf_dualtag_1 ? buf_state_1 : buf_state_0; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_96 = 2'h2 == buf_dualtag_1 ? buf_state_2 : _GEN_95; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_97 = 2'h3 == buf_dualtag_1 ? buf_state_3 : _GEN_96; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_3794 = _GEN_97 != 3'h4; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_3795 = _T_3793 & _T_3794; // @[lsu_bus_buffer.scala 466:61]
  wire  _T_3797 = buf_ldfwd[1] | any_done_wait_state; // @[lsu_bus_buffer.scala 467:31]
  wire  _T_3803 = buf_dualtag_1 == 2'h0; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3805 = buf_dualtag_1 == 2'h1; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3807 = buf_dualtag_1 == 2'h2; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3809 = buf_dualtag_1 == 2'h3; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3811 = _T_3803 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_3812 = _T_3805 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_3813 = _T_3807 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_3814 = _T_3809 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_3815 = _T_3811 | _T_3812; // @[Mux.scala 27:72]
  wire  _T_3816 = _T_3815 | _T_3813; // @[Mux.scala 27:72]
  wire  _T_3817 = _T_3816 | _T_3814; // @[Mux.scala 27:72]
  wire  _T_3819 = _T_3793 & _T_3817; // @[lsu_bus_buffer.scala 467:101]
  wire  _T_3820 = _GEN_97 == 3'h4; // @[lsu_bus_buffer.scala 467:167]
  wire  _T_3821 = _T_3819 & _T_3820; // @[lsu_bus_buffer.scala 467:138]
  wire  _T_3822 = _T_3821 & any_done_wait_state; // @[lsu_bus_buffer.scala 467:187]
  wire  _T_3823 = _T_3797 | _T_3822; // @[lsu_bus_buffer.scala 467:53]
  wire  _T_3846 = buf_state_bus_en_1 & bus_rsp_read; // @[lsu_bus_buffer.scala 474:47]
  wire  _T_3847 = _T_3846 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 474:62]
  wire  _T_3861 = ~buf_error_en_1; // @[lsu_bus_buffer.scala 478:50]
  wire  _T_3862 = buf_state_en_1 & _T_3861; // @[lsu_bus_buffer.scala 478:48]
  wire  _T_3874 = buf_ldfwd[1] | _T_3879[0]; // @[lsu_bus_buffer.scala 481:90]
  wire  _T_3875 = _T_3874 | any_done_wait_state; // @[lsu_bus_buffer.scala 481:118]
  wire  _GEN_105 = _T_3895 & buf_state_en_1; // @[Conditional.scala 39:67]
  wire  _GEN_108 = _T_3887 ? 1'h0 : _T_3895; // @[Conditional.scala 39:67]
  wire  _GEN_110 = _T_3887 ? 1'h0 : _GEN_105; // @[Conditional.scala 39:67]
  wire  _GEN_114 = _T_3869 ? 1'h0 : _GEN_108; // @[Conditional.scala 39:67]
  wire  _GEN_116 = _T_3869 ? 1'h0 : _GEN_110; // @[Conditional.scala 39:67]
  wire  _GEN_121 = _T_3782 & _T_3847; // @[Conditional.scala 39:67]
  wire  _GEN_124 = _T_3782 ? 1'h0 : _GEN_114; // @[Conditional.scala 39:67]
  wire  _GEN_126 = _T_3782 ? 1'h0 : _GEN_116; // @[Conditional.scala 39:67]
  wire  _GEN_132 = _T_3748 ? _T_3768 : _GEN_126; // @[Conditional.scala 39:67]
  wire  _GEN_134 = _T_3748 ? _T_3772 : _GEN_121; // @[Conditional.scala 39:67]
  wire  _GEN_138 = _T_3748 ? 1'h0 : _GEN_124; // @[Conditional.scala 39:67]
  wire  _GEN_144 = _T_3744 ? 1'h0 : _GEN_132; // @[Conditional.scala 39:67]
  wire  _GEN_146 = _T_3744 ? 1'h0 : _GEN_134; // @[Conditional.scala 39:67]
  wire  _GEN_150 = _T_3744 ? 1'h0 : _GEN_138; // @[Conditional.scala 39:67]
  wire  buf_wr_en_1 = _T_3721 & buf_state_en_1; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_1 = _T_3721 ? 1'h0 : _GEN_144; // @[Conditional.scala 40:58]
  wire  buf_rst_1 = _T_3721 ? 1'h0 : _GEN_150; // @[Conditional.scala 40:58]
  wire  _T_3958 = buf_state_en_2 & _T_4029; // @[lsu_bus_buffer.scala 458:44]
  wire  _T_3959 = _T_3958 & obuf_nosend; // @[lsu_bus_buffer.scala 458:60]
  wire  _T_3961 = _T_3959 & _T_1333; // @[lsu_bus_buffer.scala 458:74]
  wire  _T_3964 = _T_3954 & obuf_nosend; // @[lsu_bus_buffer.scala 460:67]
  wire  _T_3965 = _T_3964 & bus_rsp_read; // @[lsu_bus_buffer.scala 460:81]
  wire  _T_3968 = _T_3964 & bus_rsp_read_error; // @[lsu_bus_buffer.scala 461:82]
  wire  _T_4043 = bus_rsp_read_error & _T_4022; // @[lsu_bus_buffer.scala 475:91]
  wire  _T_4045 = bus_rsp_read_error & buf_ldfwd[2]; // @[lsu_bus_buffer.scala 476:31]
  wire  _T_4047 = _T_4045 & _T_4024; // @[lsu_bus_buffer.scala 476:46]
  wire  _T_4048 = _T_4043 | _T_4047; // @[lsu_bus_buffer.scala 475:143]
  wire  _T_4051 = bus_rsp_write_error & _T_4020; // @[lsu_bus_buffer.scala 477:53]
  wire  _T_4052 = _T_4048 | _T_4051; // @[lsu_bus_buffer.scala 476:88]
  wire  _T_4053 = _T_3954 & _T_4052; // @[lsu_bus_buffer.scala 475:68]
  wire  _GEN_198 = _T_3975 & _T_4053; // @[Conditional.scala 39:67]
  wire  _GEN_211 = _T_3941 ? _T_3968 : _GEN_198; // @[Conditional.scala 39:67]
  wire  _GEN_223 = _T_3937 ? 1'h0 : _GEN_211; // @[Conditional.scala 39:67]
  wire  buf_error_en_2 = _T_3914 ? 1'h0 : _GEN_223; // @[Conditional.scala 40:58]
  wire  _T_3979 = buf_write[2] & _T_3592; // @[lsu_bus_buffer.scala 465:71]
  wire  _T_3980 = io_dec_tlu_force_halt | _T_3979; // @[lsu_bus_buffer.scala 465:55]
  wire  _T_3982 = ~buf_samedw_2; // @[lsu_bus_buffer.scala 466:30]
  wire  _T_3983 = buf_dual_2 & _T_3982; // @[lsu_bus_buffer.scala 466:28]
  wire  _T_3986 = _T_3983 & _T_4029; // @[lsu_bus_buffer.scala 466:45]
  wire [2:0] _GEN_171 = 2'h1 == buf_dualtag_2 ? buf_state_1 : buf_state_0; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_172 = 2'h2 == buf_dualtag_2 ? buf_state_2 : _GEN_171; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_173 = 2'h3 == buf_dualtag_2 ? buf_state_3 : _GEN_172; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_3987 = _GEN_173 != 3'h4; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_3988 = _T_3986 & _T_3987; // @[lsu_bus_buffer.scala 466:61]
  wire  _T_3990 = buf_ldfwd[2] | any_done_wait_state; // @[lsu_bus_buffer.scala 467:31]
  wire  _T_3996 = buf_dualtag_2 == 2'h0; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_3998 = buf_dualtag_2 == 2'h1; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4000 = buf_dualtag_2 == 2'h2; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4002 = buf_dualtag_2 == 2'h3; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4004 = _T_3996 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_4005 = _T_3998 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_4006 = _T_4000 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_4007 = _T_4002 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_4008 = _T_4004 | _T_4005; // @[Mux.scala 27:72]
  wire  _T_4009 = _T_4008 | _T_4006; // @[Mux.scala 27:72]
  wire  _T_4010 = _T_4009 | _T_4007; // @[Mux.scala 27:72]
  wire  _T_4012 = _T_3986 & _T_4010; // @[lsu_bus_buffer.scala 467:101]
  wire  _T_4013 = _GEN_173 == 3'h4; // @[lsu_bus_buffer.scala 467:167]
  wire  _T_4014 = _T_4012 & _T_4013; // @[lsu_bus_buffer.scala 467:138]
  wire  _T_4015 = _T_4014 & any_done_wait_state; // @[lsu_bus_buffer.scala 467:187]
  wire  _T_4016 = _T_3990 | _T_4015; // @[lsu_bus_buffer.scala 467:53]
  wire  _T_4039 = buf_state_bus_en_2 & bus_rsp_read; // @[lsu_bus_buffer.scala 474:47]
  wire  _T_4040 = _T_4039 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 474:62]
  wire  _T_4054 = ~buf_error_en_2; // @[lsu_bus_buffer.scala 478:50]
  wire  _T_4055 = buf_state_en_2 & _T_4054; // @[lsu_bus_buffer.scala 478:48]
  wire  _T_4067 = buf_ldfwd[2] | _T_4072[0]; // @[lsu_bus_buffer.scala 481:90]
  wire  _T_4068 = _T_4067 | any_done_wait_state; // @[lsu_bus_buffer.scala 481:118]
  wire  _GEN_181 = _T_4088 & buf_state_en_2; // @[Conditional.scala 39:67]
  wire  _GEN_184 = _T_4080 ? 1'h0 : _T_4088; // @[Conditional.scala 39:67]
  wire  _GEN_186 = _T_4080 ? 1'h0 : _GEN_181; // @[Conditional.scala 39:67]
  wire  _GEN_190 = _T_4062 ? 1'h0 : _GEN_184; // @[Conditional.scala 39:67]
  wire  _GEN_192 = _T_4062 ? 1'h0 : _GEN_186; // @[Conditional.scala 39:67]
  wire  _GEN_197 = _T_3975 & _T_4040; // @[Conditional.scala 39:67]
  wire  _GEN_200 = _T_3975 ? 1'h0 : _GEN_190; // @[Conditional.scala 39:67]
  wire  _GEN_202 = _T_3975 ? 1'h0 : _GEN_192; // @[Conditional.scala 39:67]
  wire  _GEN_208 = _T_3941 ? _T_3961 : _GEN_202; // @[Conditional.scala 39:67]
  wire  _GEN_210 = _T_3941 ? _T_3965 : _GEN_197; // @[Conditional.scala 39:67]
  wire  _GEN_214 = _T_3941 ? 1'h0 : _GEN_200; // @[Conditional.scala 39:67]
  wire  _GEN_220 = _T_3937 ? 1'h0 : _GEN_208; // @[Conditional.scala 39:67]
  wire  _GEN_222 = _T_3937 ? 1'h0 : _GEN_210; // @[Conditional.scala 39:67]
  wire  _GEN_226 = _T_3937 ? 1'h0 : _GEN_214; // @[Conditional.scala 39:67]
  wire  buf_wr_en_2 = _T_3914 & buf_state_en_2; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_2 = _T_3914 ? 1'h0 : _GEN_220; // @[Conditional.scala 40:58]
  wire  buf_rst_2 = _T_3914 ? 1'h0 : _GEN_226; // @[Conditional.scala 40:58]
  wire  _T_4151 = buf_state_en_3 & _T_4222; // @[lsu_bus_buffer.scala 458:44]
  wire  _T_4152 = _T_4151 & obuf_nosend; // @[lsu_bus_buffer.scala 458:60]
  wire  _T_4154 = _T_4152 & _T_1333; // @[lsu_bus_buffer.scala 458:74]
  wire  _T_4157 = _T_4147 & obuf_nosend; // @[lsu_bus_buffer.scala 460:67]
  wire  _T_4158 = _T_4157 & bus_rsp_read; // @[lsu_bus_buffer.scala 460:81]
  wire  _T_4161 = _T_4157 & bus_rsp_read_error; // @[lsu_bus_buffer.scala 461:82]
  wire  _T_4236 = bus_rsp_read_error & _T_4215; // @[lsu_bus_buffer.scala 475:91]
  wire  _T_4238 = bus_rsp_read_error & buf_ldfwd[3]; // @[lsu_bus_buffer.scala 476:31]
  wire  _T_4240 = _T_4238 & _T_4217; // @[lsu_bus_buffer.scala 476:46]
  wire  _T_4241 = _T_4236 | _T_4240; // @[lsu_bus_buffer.scala 475:143]
  wire  _T_4244 = bus_rsp_write_error & _T_4213; // @[lsu_bus_buffer.scala 477:53]
  wire  _T_4245 = _T_4241 | _T_4244; // @[lsu_bus_buffer.scala 476:88]
  wire  _T_4246 = _T_4147 & _T_4245; // @[lsu_bus_buffer.scala 475:68]
  wire  _GEN_274 = _T_4168 & _T_4246; // @[Conditional.scala 39:67]
  wire  _GEN_287 = _T_4134 ? _T_4161 : _GEN_274; // @[Conditional.scala 39:67]
  wire  _GEN_299 = _T_4130 ? 1'h0 : _GEN_287; // @[Conditional.scala 39:67]
  wire  buf_error_en_3 = _T_4107 ? 1'h0 : _GEN_299; // @[Conditional.scala 40:58]
  wire  _T_4172 = buf_write[3] & _T_3592; // @[lsu_bus_buffer.scala 465:71]
  wire  _T_4173 = io_dec_tlu_force_halt | _T_4172; // @[lsu_bus_buffer.scala 465:55]
  wire  _T_4175 = ~buf_samedw_3; // @[lsu_bus_buffer.scala 466:30]
  wire  _T_4176 = buf_dual_3 & _T_4175; // @[lsu_bus_buffer.scala 466:28]
  wire  _T_4179 = _T_4176 & _T_4222; // @[lsu_bus_buffer.scala 466:45]
  wire [2:0] _GEN_247 = 2'h1 == buf_dualtag_3 ? buf_state_1 : buf_state_0; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_248 = 2'h2 == buf_dualtag_3 ? buf_state_2 : _GEN_247; // @[lsu_bus_buffer.scala 466:90]
  wire [2:0] _GEN_249 = 2'h3 == buf_dualtag_3 ? buf_state_3 : _GEN_248; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_4180 = _GEN_249 != 3'h4; // @[lsu_bus_buffer.scala 466:90]
  wire  _T_4181 = _T_4179 & _T_4180; // @[lsu_bus_buffer.scala 466:61]
  wire  _T_4183 = buf_ldfwd[3] | any_done_wait_state; // @[lsu_bus_buffer.scala 467:31]
  wire  _T_4189 = buf_dualtag_3 == 2'h0; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4191 = buf_dualtag_3 == 2'h1; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4193 = buf_dualtag_3 == 2'h2; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4195 = buf_dualtag_3 == 2'h3; // @[lsu_bus_buffer.scala 56:118]
  wire  _T_4197 = _T_4189 & buf_ldfwd[0]; // @[Mux.scala 27:72]
  wire  _T_4198 = _T_4191 & buf_ldfwd[1]; // @[Mux.scala 27:72]
  wire  _T_4199 = _T_4193 & buf_ldfwd[2]; // @[Mux.scala 27:72]
  wire  _T_4200 = _T_4195 & buf_ldfwd[3]; // @[Mux.scala 27:72]
  wire  _T_4201 = _T_4197 | _T_4198; // @[Mux.scala 27:72]
  wire  _T_4202 = _T_4201 | _T_4199; // @[Mux.scala 27:72]
  wire  _T_4203 = _T_4202 | _T_4200; // @[Mux.scala 27:72]
  wire  _T_4205 = _T_4179 & _T_4203; // @[lsu_bus_buffer.scala 467:101]
  wire  _T_4206 = _GEN_249 == 3'h4; // @[lsu_bus_buffer.scala 467:167]
  wire  _T_4207 = _T_4205 & _T_4206; // @[lsu_bus_buffer.scala 467:138]
  wire  _T_4208 = _T_4207 & any_done_wait_state; // @[lsu_bus_buffer.scala 467:187]
  wire  _T_4209 = _T_4183 | _T_4208; // @[lsu_bus_buffer.scala 467:53]
  wire  _T_4232 = buf_state_bus_en_3 & bus_rsp_read; // @[lsu_bus_buffer.scala 474:47]
  wire  _T_4233 = _T_4232 & io_lsu_bus_clk_en; // @[lsu_bus_buffer.scala 474:62]
  wire  _T_4247 = ~buf_error_en_3; // @[lsu_bus_buffer.scala 478:50]
  wire  _T_4248 = buf_state_en_3 & _T_4247; // @[lsu_bus_buffer.scala 478:48]
  wire  _T_4260 = buf_ldfwd[3] | _T_4265[0]; // @[lsu_bus_buffer.scala 481:90]
  wire  _T_4261 = _T_4260 | any_done_wait_state; // @[lsu_bus_buffer.scala 481:118]
  wire  _GEN_257 = _T_4281 & buf_state_en_3; // @[Conditional.scala 39:67]
  wire  _GEN_260 = _T_4273 ? 1'h0 : _T_4281; // @[Conditional.scala 39:67]
  wire  _GEN_262 = _T_4273 ? 1'h0 : _GEN_257; // @[Conditional.scala 39:67]
  wire  _GEN_266 = _T_4255 ? 1'h0 : _GEN_260; // @[Conditional.scala 39:67]
  wire  _GEN_268 = _T_4255 ? 1'h0 : _GEN_262; // @[Conditional.scala 39:67]
  wire  _GEN_273 = _T_4168 & _T_4233; // @[Conditional.scala 39:67]
  wire  _GEN_276 = _T_4168 ? 1'h0 : _GEN_266; // @[Conditional.scala 39:67]
  wire  _GEN_278 = _T_4168 ? 1'h0 : _GEN_268; // @[Conditional.scala 39:67]
  wire  _GEN_284 = _T_4134 ? _T_4154 : _GEN_278; // @[Conditional.scala 39:67]
  wire  _GEN_286 = _T_4134 ? _T_4158 : _GEN_273; // @[Conditional.scala 39:67]
  wire  _GEN_290 = _T_4134 ? 1'h0 : _GEN_276; // @[Conditional.scala 39:67]
  wire  _GEN_296 = _T_4130 ? 1'h0 : _GEN_284; // @[Conditional.scala 39:67]
  wire  _GEN_298 = _T_4130 ? 1'h0 : _GEN_286; // @[Conditional.scala 39:67]
  wire  _GEN_302 = _T_4130 ? 1'h0 : _GEN_290; // @[Conditional.scala 39:67]
  wire  buf_wr_en_3 = _T_4107 & buf_state_en_3; // @[Conditional.scala 40:58]
  wire  buf_ldfwd_en_3 = _T_4107 ? 1'h0 : _GEN_296; // @[Conditional.scala 40:58]
  wire  buf_rst_3 = _T_4107 ? 1'h0 : _GEN_302; // @[Conditional.scala 40:58]
  reg  _T_4336; // @[Reg.scala 27:20]
  reg  _T_4339; // @[Reg.scala 27:20]
  reg  _T_4342; // @[Reg.scala 27:20]
  reg  _T_4345; // @[Reg.scala 27:20]
  wire [3:0] buf_unsign = {_T_4345,_T_4342,_T_4339,_T_4336}; // @[Cat.scala 29:58]
  reg  _T_4411; // @[lsu_bus_buffer.scala 517:80]
  reg  _T_4406; // @[lsu_bus_buffer.scala 517:80]
  reg  _T_4401; // @[lsu_bus_buffer.scala 517:80]
  reg  _T_4396; // @[lsu_bus_buffer.scala 517:80]
  wire [3:0] buf_error = {_T_4411,_T_4406,_T_4401,_T_4396}; // @[Cat.scala 29:58]
  wire  _T_4393 = buf_error_en_0 | buf_error[0]; // @[lsu_bus_buffer.scala 517:84]
  wire  _T_4394 = ~buf_rst_0; // @[lsu_bus_buffer.scala 517:126]
  wire  _T_4398 = buf_error_en_1 | buf_error[1]; // @[lsu_bus_buffer.scala 517:84]
  wire  _T_4399 = ~buf_rst_1; // @[lsu_bus_buffer.scala 517:126]
  wire  _T_4403 = buf_error_en_2 | buf_error[2]; // @[lsu_bus_buffer.scala 517:84]
  wire  _T_4404 = ~buf_rst_2; // @[lsu_bus_buffer.scala 517:126]
  wire  _T_4408 = buf_error_en_3 | buf_error[3]; // @[lsu_bus_buffer.scala 517:84]
  wire  _T_4409 = ~buf_rst_3; // @[lsu_bus_buffer.scala 517:126]
  wire [1:0] _T_4415 = {io_lsu_busreq_m,1'h0}; // @[Cat.scala 29:58]
  wire [1:0] _T_4416 = io_ldst_dual_m ? _T_4415 : {{1'd0}, io_lsu_busreq_m}; // @[lsu_bus_buffer.scala 520:28]
  wire [1:0] _T_4417 = {io_lsu_busreq_r,1'h0}; // @[Cat.scala 29:58]
  wire [1:0] _T_4418 = io_ldst_dual_r ? _T_4417 : {{1'd0}, io_lsu_busreq_r}; // @[lsu_bus_buffer.scala 520:94]
  wire [2:0] _T_4419 = _T_4416 + _T_4418; // @[lsu_bus_buffer.scala 520:88]
  wire [2:0] _GEN_388 = {{2'd0}, ibuf_valid}; // @[lsu_bus_buffer.scala 520:154]
  wire [3:0] _T_4420 = _T_4419 + _GEN_388; // @[lsu_bus_buffer.scala 520:154]
  wire [1:0] _T_4425 = _T_5 + _T_12; // @[lsu_bus_buffer.scala 520:217]
  wire [1:0] _GEN_389 = {{1'd0}, _T_19}; // @[lsu_bus_buffer.scala 520:217]
  wire [2:0] _T_4426 = _T_4425 + _GEN_389; // @[lsu_bus_buffer.scala 520:217]
  wire [2:0] _GEN_390 = {{2'd0}, _T_26}; // @[lsu_bus_buffer.scala 520:217]
  wire [3:0] _T_4427 = _T_4426 + _GEN_390; // @[lsu_bus_buffer.scala 520:217]
  wire [3:0] buf_numvld_any = _T_4420 + _T_4427; // @[lsu_bus_buffer.scala 520:169]
  wire  _T_4498 = io_ldst_dual_d & io_dec_lsu_valid_raw_d; // @[lsu_bus_buffer.scala 526:52]
  wire  _T_4499 = buf_numvld_any >= 4'h3; // @[lsu_bus_buffer.scala 526:92]
  wire  _T_4500 = buf_numvld_any == 4'h4; // @[lsu_bus_buffer.scala 526:121]
  wire  _T_4502 = |buf_state_0; // @[lsu_bus_buffer.scala 527:52]
  wire  _T_4503 = |buf_state_1; // @[lsu_bus_buffer.scala 527:52]
  wire  _T_4504 = |buf_state_2; // @[lsu_bus_buffer.scala 527:52]
  wire  _T_4505 = |buf_state_3; // @[lsu_bus_buffer.scala 527:52]
  wire  _T_4506 = _T_4502 | _T_4503; // @[lsu_bus_buffer.scala 527:65]
  wire  _T_4507 = _T_4506 | _T_4504; // @[lsu_bus_buffer.scala 527:65]
  wire  _T_4508 = _T_4507 | _T_4505; // @[lsu_bus_buffer.scala 527:65]
  wire  _T_4509 = ~_T_4508; // @[lsu_bus_buffer.scala 527:34]
  wire  _T_4511 = _T_4509 & _T_852; // @[lsu_bus_buffer.scala 527:70]
  wire  _T_4514 = io_lsu_busreq_m & io_lsu_pkt_m_valid; // @[lsu_bus_buffer.scala 529:64]
  wire  _T_4515 = _T_4514 & io_lsu_pkt_m_bits_load; // @[lsu_bus_buffer.scala 529:85]
  wire  _T_4516 = ~io_flush_m_up; // @[lsu_bus_buffer.scala 529:112]
  wire  _T_4517 = _T_4515 & _T_4516; // @[lsu_bus_buffer.scala 529:110]
  wire  _T_4518 = ~io_ld_full_hit_m; // @[lsu_bus_buffer.scala 529:129]
  wire  _T_4520 = ~io_lsu_commit_r; // @[lsu_bus_buffer.scala 532:74]
  reg  lsu_nonblock_load_valid_r; // @[lsu_bus_buffer.scala 617:66]
  wire  _T_4538 = _T_2799 & _T_3643; // @[Mux.scala 27:72]
  wire  _T_4539 = _T_2821 & _T_3836; // @[Mux.scala 27:72]
  wire  _T_4540 = _T_2843 & _T_4029; // @[Mux.scala 27:72]
  wire  _T_4541 = _T_2865 & _T_4222; // @[Mux.scala 27:72]
  wire  _T_4542 = _T_4538 | _T_4539; // @[Mux.scala 27:72]
  wire  _T_4543 = _T_4542 | _T_4540; // @[Mux.scala 27:72]
  wire  lsu_nonblock_load_data_ready = _T_4543 | _T_4541; // @[Mux.scala 27:72]
  wire  _T_4549 = buf_error[0] & _T_3643; // @[lsu_bus_buffer.scala 535:121]
  wire  _T_4554 = buf_error[1] & _T_3836; // @[lsu_bus_buffer.scala 535:121]
  wire  _T_4559 = buf_error[2] & _T_4029; // @[lsu_bus_buffer.scala 535:121]
  wire  _T_4564 = buf_error[3] & _T_4222; // @[lsu_bus_buffer.scala 535:121]
  wire  _T_4565 = _T_2799 & _T_4549; // @[Mux.scala 27:72]
  wire  _T_4566 = _T_2821 & _T_4554; // @[Mux.scala 27:72]
  wire  _T_4567 = _T_2843 & _T_4559; // @[Mux.scala 27:72]
  wire  _T_4568 = _T_2865 & _T_4564; // @[Mux.scala 27:72]
  wire  _T_4569 = _T_4565 | _T_4566; // @[Mux.scala 27:72]
  wire  _T_4570 = _T_4569 | _T_4567; // @[Mux.scala 27:72]
  wire  _T_4577 = ~buf_dual_0; // @[lsu_bus_buffer.scala 536:122]
  wire  _T_4578 = ~buf_dualhi_0; // @[lsu_bus_buffer.scala 536:137]
  wire  _T_4579 = _T_4577 | _T_4578; // @[lsu_bus_buffer.scala 536:135]
  wire  _T_4580 = _T_4538 & _T_4579; // @[lsu_bus_buffer.scala 536:119]
  wire  _T_4585 = ~buf_dual_1; // @[lsu_bus_buffer.scala 536:122]
  wire  _T_4586 = ~buf_dualhi_1; // @[lsu_bus_buffer.scala 536:137]
  wire  _T_4587 = _T_4585 | _T_4586; // @[lsu_bus_buffer.scala 536:135]
  wire  _T_4588 = _T_4539 & _T_4587; // @[lsu_bus_buffer.scala 536:119]
  wire  _T_4593 = ~buf_dual_2; // @[lsu_bus_buffer.scala 536:122]
  wire  _T_4594 = ~buf_dualhi_2; // @[lsu_bus_buffer.scala 536:137]
  wire  _T_4595 = _T_4593 | _T_4594; // @[lsu_bus_buffer.scala 536:135]
  wire  _T_4596 = _T_4540 & _T_4595; // @[lsu_bus_buffer.scala 536:119]
  wire  _T_4601 = ~buf_dual_3; // @[lsu_bus_buffer.scala 536:122]
  wire  _T_4602 = ~buf_dualhi_3; // @[lsu_bus_buffer.scala 536:137]
  wire  _T_4603 = _T_4601 | _T_4602; // @[lsu_bus_buffer.scala 536:135]
  wire  _T_4604 = _T_4541 & _T_4603; // @[lsu_bus_buffer.scala 536:119]
  wire [1:0] _T_4607 = _T_4596 ? 2'h2 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4608 = _T_4604 ? 2'h3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _GEN_391 = {{1'd0}, _T_4588}; // @[Mux.scala 27:72]
  wire [1:0] _T_4610 = _GEN_391 | _T_4607; // @[Mux.scala 27:72]
  wire [31:0] _T_4645 = _T_4580 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4646 = _T_4588 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4647 = _T_4596 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4648 = _T_4604 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4649 = _T_4645 | _T_4646; // @[Mux.scala 27:72]
  wire [31:0] _T_4650 = _T_4649 | _T_4647; // @[Mux.scala 27:72]
  wire [31:0] lsu_nonblock_load_data_lo = _T_4650 | _T_4648; // @[Mux.scala 27:72]
  wire  _T_4657 = _T_4538 & _T_3641; // @[lsu_bus_buffer.scala 538:105]
  wire  _T_4663 = _T_4539 & _T_3834; // @[lsu_bus_buffer.scala 538:105]
  wire  _T_4669 = _T_4540 & _T_4027; // @[lsu_bus_buffer.scala 538:105]
  wire  _T_4675 = _T_4541 & _T_4220; // @[lsu_bus_buffer.scala 538:105]
  wire [31:0] _T_4676 = _T_4657 ? buf_data_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4677 = _T_4663 ? buf_data_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4678 = _T_4669 ? buf_data_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4679 = _T_4675 ? buf_data_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4680 = _T_4676 | _T_4677; // @[Mux.scala 27:72]
  wire [31:0] _T_4681 = _T_4680 | _T_4678; // @[Mux.scala 27:72]
  wire [31:0] lsu_nonblock_load_data_hi = _T_4681 | _T_4679; // @[Mux.scala 27:72]
  wire  _T_4683 = io_dctl_busbuff_lsu_nonblock_load_data_tag == 2'h0; // @[lsu_bus_buffer.scala 57:123]
  wire  _T_4684 = io_dctl_busbuff_lsu_nonblock_load_data_tag == 2'h1; // @[lsu_bus_buffer.scala 57:123]
  wire  _T_4685 = io_dctl_busbuff_lsu_nonblock_load_data_tag == 2'h2; // @[lsu_bus_buffer.scala 57:123]
  wire  _T_4686 = io_dctl_busbuff_lsu_nonblock_load_data_tag == 2'h3; // @[lsu_bus_buffer.scala 57:123]
  wire [31:0] _T_4687 = _T_4683 ? buf_addr_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4688 = _T_4684 ? buf_addr_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4689 = _T_4685 ? buf_addr_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4690 = _T_4686 ? buf_addr_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4691 = _T_4687 | _T_4688; // @[Mux.scala 27:72]
  wire [31:0] _T_4692 = _T_4691 | _T_4689; // @[Mux.scala 27:72]
  wire [31:0] _T_4693 = _T_4692 | _T_4690; // @[Mux.scala 27:72]
  wire [1:0] lsu_nonblock_addr_offset = _T_4693[1:0]; // @[lsu_bus_buffer.scala 539:96]
  wire [1:0] _T_4699 = _T_4683 ? buf_sz_0 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4700 = _T_4684 ? buf_sz_1 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4701 = _T_4685 ? buf_sz_2 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4702 = _T_4686 ? buf_sz_3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4703 = _T_4699 | _T_4700; // @[Mux.scala 27:72]
  wire [1:0] _T_4704 = _T_4703 | _T_4701; // @[Mux.scala 27:72]
  wire [1:0] lsu_nonblock_sz = _T_4704 | _T_4702; // @[Mux.scala 27:72]
  wire  _T_4714 = _T_4683 & buf_unsign[0]; // @[Mux.scala 27:72]
  wire  _T_4715 = _T_4684 & buf_unsign[1]; // @[Mux.scala 27:72]
  wire  _T_4716 = _T_4685 & buf_unsign[2]; // @[Mux.scala 27:72]
  wire  _T_4717 = _T_4686 & buf_unsign[3]; // @[Mux.scala 27:72]
  wire  _T_4718 = _T_4714 | _T_4715; // @[Mux.scala 27:72]
  wire  _T_4719 = _T_4718 | _T_4716; // @[Mux.scala 27:72]
  wire  lsu_nonblock_unsign = _T_4719 | _T_4717; // @[Mux.scala 27:72]
  wire [63:0] _T_4739 = {lsu_nonblock_load_data_hi,lsu_nonblock_load_data_lo}; // @[Cat.scala 29:58]
  wire [3:0] _GEN_392 = {{2'd0}, lsu_nonblock_addr_offset}; // @[lsu_bus_buffer.scala 543:121]
  wire [5:0] _T_4740 = _GEN_392 * 4'h8; // @[lsu_bus_buffer.scala 543:121]
  wire [63:0] lsu_nonblock_data_unalgn = _T_4739 >> _T_4740; // @[lsu_bus_buffer.scala 543:92]
  wire  _T_4741 = ~io_dctl_busbuff_lsu_nonblock_load_data_error; // @[lsu_bus_buffer.scala 545:82]
  wire  _T_4743 = lsu_nonblock_sz == 2'h0; // @[lsu_bus_buffer.scala 546:94]
  wire  _T_4744 = lsu_nonblock_unsign & _T_4743; // @[lsu_bus_buffer.scala 546:76]
  wire [31:0] _T_4746 = {24'h0,lsu_nonblock_data_unalgn[7:0]}; // @[Cat.scala 29:58]
  wire  _T_4747 = lsu_nonblock_sz == 2'h1; // @[lsu_bus_buffer.scala 547:45]
  wire  _T_4748 = lsu_nonblock_unsign & _T_4747; // @[lsu_bus_buffer.scala 547:26]
  wire [31:0] _T_4750 = {16'h0,lsu_nonblock_data_unalgn[15:0]}; // @[Cat.scala 29:58]
  wire  _T_4751 = ~lsu_nonblock_unsign; // @[lsu_bus_buffer.scala 548:6]
  wire  _T_4753 = _T_4751 & _T_4743; // @[lsu_bus_buffer.scala 548:27]
  wire [23:0] _T_4756 = lsu_nonblock_data_unalgn[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_4758 = {_T_4756,lsu_nonblock_data_unalgn[7:0]}; // @[Cat.scala 29:58]
  wire  _T_4761 = _T_4751 & _T_4747; // @[lsu_bus_buffer.scala 549:27]
  wire [15:0] _T_4764 = lsu_nonblock_data_unalgn[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_4766 = {_T_4764,lsu_nonblock_data_unalgn[15:0]}; // @[Cat.scala 29:58]
  wire  _T_4767 = lsu_nonblock_sz == 2'h2; // @[lsu_bus_buffer.scala 550:21]
  wire [31:0] _T_4768 = _T_4744 ? _T_4746 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4769 = _T_4748 ? _T_4750 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4770 = _T_4753 ? _T_4758 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4771 = _T_4761 ? _T_4766 : 32'h0; // @[Mux.scala 27:72]
  wire [63:0] _T_4772 = _T_4767 ? lsu_nonblock_data_unalgn : 64'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_4773 = _T_4768 | _T_4769; // @[Mux.scala 27:72]
  wire [31:0] _T_4774 = _T_4773 | _T_4770; // @[Mux.scala 27:72]
  wire [31:0] _T_4775 = _T_4774 | _T_4771; // @[Mux.scala 27:72]
  wire [63:0] _GEN_393 = {{32'd0}, _T_4775}; // @[Mux.scala 27:72]
  wire [63:0] _T_4776 = _GEN_393 | _T_4772; // @[Mux.scala 27:72]
  wire  _T_4874 = obuf_valid & obuf_write; // @[lsu_bus_buffer.scala 568:37]
  wire  _T_4875 = ~obuf_cmd_done; // @[lsu_bus_buffer.scala 568:52]
  wire  _T_4876 = _T_4874 & _T_4875; // @[lsu_bus_buffer.scala 568:50]
  wire [31:0] _T_4880 = {obuf_addr[31:3],3'h0}; // @[Cat.scala 29:58]
  wire [2:0] _T_4882 = {1'h0,obuf_sz}; // @[Cat.scala 29:58]
  wire  _T_4887 = ~obuf_data_done; // @[lsu_bus_buffer.scala 580:51]
  wire  _T_4888 = _T_4874 & _T_4887; // @[lsu_bus_buffer.scala 580:49]
  wire [7:0] _T_4892 = obuf_write ? 8'hff : 8'h0; // @[Bitwise.scala 72:12]
  wire  _T_4895 = obuf_valid & _T_1343; // @[lsu_bus_buffer.scala 585:37]
  wire  _T_4897 = _T_4895 & _T_1349; // @[lsu_bus_buffer.scala 585:51]
  wire  _T_4909 = io_lsu_bus_clk_en_q & buf_error[0]; // @[lsu_bus_buffer.scala 598:126]
  wire  _T_4911 = _T_4909 & buf_write[0]; // @[lsu_bus_buffer.scala 598:141]
  wire  _T_4914 = io_lsu_bus_clk_en_q & buf_error[1]; // @[lsu_bus_buffer.scala 598:126]
  wire  _T_4916 = _T_4914 & buf_write[1]; // @[lsu_bus_buffer.scala 598:141]
  wire  _T_4919 = io_lsu_bus_clk_en_q & buf_error[2]; // @[lsu_bus_buffer.scala 598:126]
  wire  _T_4921 = _T_4919 & buf_write[2]; // @[lsu_bus_buffer.scala 598:141]
  wire  _T_4924 = io_lsu_bus_clk_en_q & buf_error[3]; // @[lsu_bus_buffer.scala 598:126]
  wire  _T_4926 = _T_4924 & buf_write[3]; // @[lsu_bus_buffer.scala 598:141]
  wire  _T_4927 = _T_2799 & _T_4911; // @[Mux.scala 27:72]
  wire  _T_4928 = _T_2821 & _T_4916; // @[Mux.scala 27:72]
  wire  _T_4929 = _T_2843 & _T_4921; // @[Mux.scala 27:72]
  wire  _T_4930 = _T_2865 & _T_4926; // @[Mux.scala 27:72]
  wire  _T_4931 = _T_4927 | _T_4928; // @[Mux.scala 27:72]
  wire  _T_4932 = _T_4931 | _T_4929; // @[Mux.scala 27:72]
  wire  _T_4942 = _T_2821 & buf_error[1]; // @[lsu_bus_buffer.scala 599:93]
  wire  _T_4944 = _T_4942 & buf_write[1]; // @[lsu_bus_buffer.scala 599:108]
  wire  _T_4947 = _T_2843 & buf_error[2]; // @[lsu_bus_buffer.scala 599:93]
  wire  _T_4949 = _T_4947 & buf_write[2]; // @[lsu_bus_buffer.scala 599:108]
  wire  _T_4952 = _T_2865 & buf_error[3]; // @[lsu_bus_buffer.scala 599:93]
  wire  _T_4954 = _T_4952 & buf_write[3]; // @[lsu_bus_buffer.scala 599:108]
  wire [1:0] _T_4957 = _T_4949 ? 2'h2 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_4958 = _T_4954 ? 2'h3 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _GEN_394 = {{1'd0}, _T_4944}; // @[Mux.scala 27:72]
  wire [1:0] _T_4960 = _GEN_394 | _T_4957; // @[Mux.scala 27:72]
  wire [1:0] lsu_imprecise_error_store_tag = _T_4960 | _T_4958; // @[Mux.scala 27:72]
  wire  _T_4962 = ~io_tlu_busbuff_lsu_imprecise_error_store_any; // @[lsu_bus_buffer.scala 601:97]
  wire [31:0] _GEN_351 = 2'h1 == lsu_imprecise_error_store_tag ? buf_addr_1 : buf_addr_0; // @[lsu_bus_buffer.scala 602:53]
  wire [31:0] _GEN_352 = 2'h2 == lsu_imprecise_error_store_tag ? buf_addr_2 : _GEN_351; // @[lsu_bus_buffer.scala 602:53]
  wire [31:0] _GEN_353 = 2'h3 == lsu_imprecise_error_store_tag ? buf_addr_3 : _GEN_352; // @[lsu_bus_buffer.scala 602:53]
  wire [31:0] _GEN_355 = 2'h1 == io_dctl_busbuff_lsu_nonblock_load_data_tag ? buf_addr_1 : buf_addr_0; // @[lsu_bus_buffer.scala 602:53]
  wire [31:0] _GEN_356 = 2'h2 == io_dctl_busbuff_lsu_nonblock_load_data_tag ? buf_addr_2 : _GEN_355; // @[lsu_bus_buffer.scala 602:53]
  wire [31:0] _GEN_357 = 2'h3 == io_dctl_busbuff_lsu_nonblock_load_data_tag ? buf_addr_3 : _GEN_356; // @[lsu_bus_buffer.scala 602:53]
  wire  _T_4967 = bus_wcmd_sent | bus_wdata_sent; // @[lsu_bus_buffer.scala 608:82]
  wire  _T_4970 = io_lsu_busreq_r & io_ldst_dual_r; // @[lsu_bus_buffer.scala 609:60]
  wire  _T_4973 = ~io_lsu_axi_aw_ready; // @[lsu_bus_buffer.scala 612:61]
  wire  _T_4974 = io_lsu_axi_aw_valid & _T_4973; // @[lsu_bus_buffer.scala 612:59]
  wire  _T_4975 = ~io_lsu_axi_w_ready; // @[lsu_bus_buffer.scala 612:107]
  wire  _T_4976 = io_lsu_axi_w_valid & _T_4975; // @[lsu_bus_buffer.scala 612:105]
  wire  _T_4977 = _T_4974 | _T_4976; // @[lsu_bus_buffer.scala 612:83]
  wire  _T_4978 = ~io_lsu_axi_ar_ready; // @[lsu_bus_buffer.scala 612:153]
  wire  _T_4979 = io_lsu_axi_ar_valid & _T_4978; // @[lsu_bus_buffer.scala 612:151]
  wire  _T_4983 = ~io_flush_r; // @[lsu_bus_buffer.scala 616:75]
  wire  _T_4984 = io_lsu_busreq_m & _T_4983; // @[lsu_bus_buffer.scala 616:73]
  reg  _T_4987; // @[lsu_bus_buffer.scala 616:56]
  rvclkhdr rvclkhdr ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  rvclkhdr rvclkhdr_2 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_2_io_l1clk),
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en),
    .io_scan_mode(rvclkhdr_2_io_scan_mode)
  );
  rvclkhdr rvclkhdr_3 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_3_io_l1clk),
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en),
    .io_scan_mode(rvclkhdr_3_io_scan_mode)
  );
  rvclkhdr rvclkhdr_4 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_4_io_l1clk),
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en),
    .io_scan_mode(rvclkhdr_4_io_scan_mode)
  );
  rvclkhdr rvclkhdr_5 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_5_io_l1clk),
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en),
    .io_scan_mode(rvclkhdr_5_io_scan_mode)
  );
  rvclkhdr rvclkhdr_6 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_6_io_l1clk),
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en),
    .io_scan_mode(rvclkhdr_6_io_scan_mode)
  );
  rvclkhdr rvclkhdr_7 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_7_io_l1clk),
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en),
    .io_scan_mode(rvclkhdr_7_io_scan_mode)
  );
  rvclkhdr rvclkhdr_8 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_8_io_l1clk),
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en),
    .io_scan_mode(rvclkhdr_8_io_scan_mode)
  );
  rvclkhdr rvclkhdr_9 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_9_io_l1clk),
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en),
    .io_scan_mode(rvclkhdr_9_io_scan_mode)
  );
  rvclkhdr rvclkhdr_10 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_10_io_l1clk),
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en),
    .io_scan_mode(rvclkhdr_10_io_scan_mode)
  );
  rvclkhdr rvclkhdr_11 ( // @[lib.scala 352:23]
    .io_l1clk(rvclkhdr_11_io_l1clk),
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en),
    .io_scan_mode(rvclkhdr_11_io_scan_mode)
  );
  assign io_tlu_busbuff_lsu_pmu_bus_trxn = _T_4967 | _T_4866; // @[lsu_bus_buffer.scala 608:35]
  assign io_tlu_busbuff_lsu_pmu_bus_misaligned = _T_4970 & io_lsu_commit_r; // @[lsu_bus_buffer.scala 609:41]
  assign io_tlu_busbuff_lsu_pmu_bus_error = io_tlu_busbuff_lsu_imprecise_error_load_any | io_tlu_busbuff_lsu_imprecise_error_store_any; // @[lsu_bus_buffer.scala 610:36]
  assign io_tlu_busbuff_lsu_pmu_bus_busy = _T_4977 | _T_4979; // @[lsu_bus_buffer.scala 612:35]
  assign io_tlu_busbuff_lsu_imprecise_error_load_any = io_dctl_busbuff_lsu_nonblock_load_data_error & _T_4962; // @[lsu_bus_buffer.scala 601:47]
  assign io_tlu_busbuff_lsu_imprecise_error_store_any = _T_4932 | _T_4930; // @[lsu_bus_buffer.scala 598:48]
  assign io_tlu_busbuff_lsu_imprecise_error_addr_any = io_tlu_busbuff_lsu_imprecise_error_store_any ? _GEN_353 : _GEN_357; // @[lsu_bus_buffer.scala 602:47]
  assign io_dctl_busbuff_lsu_nonblock_load_valid_m = _T_4517 & _T_4518; // @[lsu_bus_buffer.scala 529:45]
  assign io_dctl_busbuff_lsu_nonblock_load_tag_m = _T_1863 ? 2'h0 : _T_1899; // @[lsu_bus_buffer.scala 530:43]
  assign io_dctl_busbuff_lsu_nonblock_load_inv_r = lsu_nonblock_load_valid_r & _T_4520; // @[lsu_bus_buffer.scala 532:43]
  assign io_dctl_busbuff_lsu_nonblock_load_inv_tag_r = WrPtr0_r; // @[lsu_bus_buffer.scala 533:47]
  assign io_dctl_busbuff_lsu_nonblock_load_data_valid = lsu_nonblock_load_data_ready & _T_4741; // @[lsu_bus_buffer.scala 545:48]
  assign io_dctl_busbuff_lsu_nonblock_load_data_error = _T_4570 | _T_4568; // @[lsu_bus_buffer.scala 535:48]
  assign io_dctl_busbuff_lsu_nonblock_load_data_tag = _T_4610 | _T_4608; // @[lsu_bus_buffer.scala 536:46]
  assign io_dctl_busbuff_lsu_nonblock_load_data = _T_4776[31:0]; // @[lsu_bus_buffer.scala 546:42]
  assign io_lsu_axi_aw_valid = _T_4876 & _T_1239; // @[lsu_bus_buffer.scala 568:23]
  assign io_lsu_axi_aw_bits_id = {{1'd0}, _T_1848}; // @[lsu_bus_buffer.scala 569:25]
  assign io_lsu_axi_aw_bits_addr = obuf_sideeffect ? obuf_addr : _T_4880; // @[lsu_bus_buffer.scala 570:27]
  assign io_lsu_axi_aw_bits_region = obuf_addr[31:28]; // @[lsu_bus_buffer.scala 574:29]
  assign io_lsu_axi_aw_bits_len = 8'h0; // @[lsu_bus_buffer.scala 575:26]
  assign io_lsu_axi_aw_bits_size = obuf_sideeffect ? _T_4882 : 3'h3; // @[lsu_bus_buffer.scala 571:27]
  assign io_lsu_axi_aw_bits_burst = 2'h1; // @[lsu_bus_buffer.scala 576:28]
  assign io_lsu_axi_aw_bits_lock = 1'h0; // @[lsu_bus_buffer.scala 578:27]
  assign io_lsu_axi_aw_bits_cache = obuf_sideeffect ? 4'h0 : 4'hf; // @[lsu_bus_buffer.scala 573:28]
  assign io_lsu_axi_aw_bits_prot = 3'h0; // @[lsu_bus_buffer.scala 572:27]
  assign io_lsu_axi_aw_bits_qos = 4'h0; // @[lsu_bus_buffer.scala 577:26]
  assign io_lsu_axi_w_valid = _T_4888 & _T_1239; // @[lsu_bus_buffer.scala 580:22]
  assign io_lsu_axi_w_bits_data = obuf_data; // @[lsu_bus_buffer.scala 582:26]
  assign io_lsu_axi_w_bits_strb = obuf_byteen & _T_4892; // @[lsu_bus_buffer.scala 581:26]
  assign io_lsu_axi_w_bits_last = 1'h1; // @[lsu_bus_buffer.scala 583:26]
  assign io_lsu_axi_b_ready = 1'h1; // @[lsu_bus_buffer.scala 596:22]
  assign io_lsu_axi_ar_valid = _T_4897 & _T_1239; // @[lsu_bus_buffer.scala 585:23]
  assign io_lsu_axi_ar_bits_id = {{1'd0}, _T_1848}; // @[lsu_bus_buffer.scala 586:25]
  assign io_lsu_axi_ar_bits_addr = obuf_sideeffect ? obuf_addr : _T_4880; // @[lsu_bus_buffer.scala 587:27]
  assign io_lsu_axi_ar_bits_region = obuf_addr[31:28]; // @[lsu_bus_buffer.scala 591:29]
  assign io_lsu_axi_ar_bits_len = 8'h0; // @[lsu_bus_buffer.scala 592:26]
  assign io_lsu_axi_ar_bits_size = obuf_sideeffect ? _T_4882 : 3'h3; // @[lsu_bus_buffer.scala 588:27]
  assign io_lsu_axi_ar_bits_burst = 2'h1; // @[lsu_bus_buffer.scala 593:28]
  assign io_lsu_axi_ar_bits_lock = 1'h0; // @[lsu_bus_buffer.scala 595:27]
  assign io_lsu_axi_ar_bits_cache = obuf_sideeffect ? 4'h0 : 4'hf; // @[lsu_bus_buffer.scala 590:28]
  assign io_lsu_axi_ar_bits_prot = 3'h0; // @[lsu_bus_buffer.scala 589:27]
  assign io_lsu_axi_ar_bits_qos = 4'h0; // @[lsu_bus_buffer.scala 594:26]
  assign io_lsu_axi_r_ready = 1'h1; // @[lsu_bus_buffer.scala 597:22]
  assign io_lsu_busreq_r = _T_4987; // @[lsu_bus_buffer.scala 616:19]
  assign io_lsu_bus_buffer_pend_any = |buf_numvld_pend_any; // @[lsu_bus_buffer.scala 525:30]
  assign io_lsu_bus_buffer_full_any = _T_4498 ? _T_4499 : _T_4500; // @[lsu_bus_buffer.scala 526:30]
  assign io_lsu_bus_buffer_empty_any = _T_4511 & _T_1231; // @[lsu_bus_buffer.scala 527:31]
  assign io_lsu_bus_idle_any = 1'h1; // @[lsu_bus_buffer.scala 605:23]
  assign io_ld_byte_hit_buf_lo = {_T_69,_T_58}; // @[lsu_bus_buffer.scala 137:25]
  assign io_ld_byte_hit_buf_hi = {_T_84,_T_73}; // @[lsu_bus_buffer.scala 138:25]
  assign io_ld_fwddata_buf_lo = _T_650 | _T_651; // @[lsu_bus_buffer.scala 164:24]
  assign io_ld_fwddata_buf_hi = _T_747 | _T_748; // @[lsu_bus_buffer.scala 170:24]
  assign rvclkhdr_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_io_en = _T_853 & _T_854; // @[lib.scala 355:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_1_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_1_io_en = _T_853 & _T_854; // @[lib.scala 355:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_2_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_2_io_en = _T_1240 & io_lsu_bus_clk_en; // @[lib.scala 355:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_3_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_3_io_en = _T_1240 & io_lsu_bus_clk_en; // @[lib.scala 355:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_4_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_4_io_en = _T_3528 & buf_state_en_0; // @[lib.scala 355:17]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_5_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_5_io_en = _T_3721 & buf_state_en_1; // @[lib.scala 355:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_6_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_6_io_en = _T_3914 & buf_state_en_2; // @[lib.scala 355:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_7_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_7_io_en = _T_4107 & buf_state_en_3; // @[lib.scala 355:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_8_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_8_io_en = _T_3528 ? buf_state_en_0 : _GEN_70; // @[lib.scala 355:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_9_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_9_io_en = _T_3721 ? buf_state_en_1 : _GEN_146; // @[lib.scala 355:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_10_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_10_io_en = _T_3914 ? buf_state_en_2 : _GEN_222; // @[lib.scala 355:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
  assign rvclkhdr_11_io_clk = clock; // @[lib.scala 354:18]
  assign rvclkhdr_11_io_en = _T_4107 ? buf_state_en_3 : _GEN_298; // @[lib.scala 355:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[lib.scala 356:24]
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
  _T_4360 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_4357 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  _T_4354 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  _T_4351 = _RAND_4[0:0];
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
  _T_1848 = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  obuf_merge = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  obuf_tag1 = _RAND_19[1:0];
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
  _T_4330 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  _T_4327 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  _T_4324 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  _T_4321 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  obuf_sideeffect = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  buf_dual_3 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  buf_dual_2 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  buf_dual_1 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  buf_dual_0 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  buf_samedw_3 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  buf_samedw_2 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  buf_samedw_1 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  buf_samedw_0 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  obuf_write = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  obuf_cmd_done = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  obuf_data_done = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  obuf_nosend = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  obuf_addr = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  buf_sz_0 = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  buf_sz_1 = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  buf_sz_2 = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  buf_sz_3 = _RAND_71[1:0];
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
  _T_4307 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  _T_4305 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  _T_4303 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  _T_4301 = _RAND_88[0:0];
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
  _T_4336 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  _T_4339 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  _T_4342 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  _T_4345 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  _T_4411 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  _T_4406 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  _T_4401 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  _T_4396 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  lsu_nonblock_load_valid_r = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  _T_4987 = _RAND_106[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    buf_addr_0 = 32'h0;
  end
  if (reset) begin
    _T_4360 = 1'h0;
  end
  if (reset) begin
    _T_4357 = 1'h0;
  end
  if (reset) begin
    _T_4354 = 1'h0;
  end
  if (reset) begin
    _T_4351 = 1'h0;
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
    _T_1848 = 2'h0;
  end
  if (reset) begin
    obuf_merge = 1'h0;
  end
  if (reset) begin
    obuf_tag1 = 2'h0;
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
    _T_4330 = 1'h0;
  end
  if (reset) begin
    _T_4327 = 1'h0;
  end
  if (reset) begin
    _T_4324 = 1'h0;
  end
  if (reset) begin
    _T_4321 = 1'h0;
  end
  if (reset) begin
    obuf_sideeffect = 1'h0;
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
    _T_4307 = 1'h0;
  end
  if (reset) begin
    _T_4305 = 1'h0;
  end
  if (reset) begin
    _T_4303 = 1'h0;
  end
  if (reset) begin
    _T_4301 = 1'h0;
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
    _T_4336 = 1'h0;
  end
  if (reset) begin
    _T_4339 = 1'h0;
  end
  if (reset) begin
    _T_4342 = 1'h0;
  end
  if (reset) begin
    _T_4345 = 1'h0;
  end
  if (reset) begin
    _T_4411 = 1'h0;
  end
  if (reset) begin
    _T_4406 = 1'h0;
  end
  if (reset) begin
    _T_4401 = 1'h0;
  end
  if (reset) begin
    _T_4396 = 1'h0;
  end
  if (reset) begin
    lsu_nonblock_load_valid_r = 1'h0;
  end
  if (reset) begin
    _T_4987 = 1'h0;
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
    end else if (_T_3343) begin
      buf_addr_0 <= io_end_addr_r;
    end else begin
      buf_addr_0 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4360 <= 1'h0;
    end else if (buf_wr_en_3) begin
      _T_4360 <= buf_write_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4357 <= 1'h0;
    end else if (buf_wr_en_2) begin
      _T_4357 <= buf_write_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4354 <= 1'h0;
    end else if (buf_wr_en_1) begin
      _T_4354 <= buf_write_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4351 <= 1'h0;
    end else if (buf_wr_en_0) begin
      _T_4351 <= buf_write_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_0 <= 3'h0;
    end else if (buf_state_en_0) begin
      if (_T_3528) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_0 <= 3'h2;
        end else begin
          buf_state_0 <= 3'h1;
        end
      end else if (_T_3551) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else begin
          buf_state_0 <= 3'h2;
        end
      end else if (_T_3555) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else if (_T_3559) begin
          buf_state_0 <= 3'h5;
        end else begin
          buf_state_0 <= 3'h3;
        end
      end else if (_T_3589) begin
        if (_T_3594) begin
          buf_state_0 <= 3'h0;
        end else if (_T_3602) begin
          buf_state_0 <= 3'h4;
        end else if (_T_3630) begin
          buf_state_0 <= 3'h5;
        end else begin
          buf_state_0 <= 3'h6;
        end
      end else if (_T_3676) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_0 <= 3'h0;
        end else if (_T_3682) begin
          buf_state_0 <= 3'h5;
        end else begin
          buf_state_0 <= 3'h6;
        end
      end else if (_T_3694) begin
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
    end else if (_T_3352) begin
      buf_addr_1 <= io_end_addr_r;
    end else begin
      buf_addr_1 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_1 <= 3'h0;
    end else if (buf_state_en_1) begin
      if (_T_3721) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_1 <= 3'h2;
        end else begin
          buf_state_1 <= 3'h1;
        end
      end else if (_T_3744) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else begin
          buf_state_1 <= 3'h2;
        end
      end else if (_T_3748) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else if (_T_3559) begin
          buf_state_1 <= 3'h5;
        end else begin
          buf_state_1 <= 3'h3;
        end
      end else if (_T_3782) begin
        if (_T_3787) begin
          buf_state_1 <= 3'h0;
        end else if (_T_3795) begin
          buf_state_1 <= 3'h4;
        end else if (_T_3823) begin
          buf_state_1 <= 3'h5;
        end else begin
          buf_state_1 <= 3'h6;
        end
      end else if (_T_3869) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_1 <= 3'h0;
        end else if (_T_3875) begin
          buf_state_1 <= 3'h5;
        end else begin
          buf_state_1 <= 3'h6;
        end
      end else if (_T_3887) begin
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
    end else if (_T_3361) begin
      buf_addr_2 <= io_end_addr_r;
    end else begin
      buf_addr_2 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_2 <= 3'h0;
    end else if (buf_state_en_2) begin
      if (_T_3914) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_2 <= 3'h2;
        end else begin
          buf_state_2 <= 3'h1;
        end
      end else if (_T_3937) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else begin
          buf_state_2 <= 3'h2;
        end
      end else if (_T_3941) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else if (_T_3559) begin
          buf_state_2 <= 3'h5;
        end else begin
          buf_state_2 <= 3'h3;
        end
      end else if (_T_3975) begin
        if (_T_3980) begin
          buf_state_2 <= 3'h0;
        end else if (_T_3988) begin
          buf_state_2 <= 3'h4;
        end else if (_T_4016) begin
          buf_state_2 <= 3'h5;
        end else begin
          buf_state_2 <= 3'h6;
        end
      end else if (_T_4062) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_2 <= 3'h0;
        end else if (_T_4068) begin
          buf_state_2 <= 3'h5;
        end else begin
          buf_state_2 <= 3'h6;
        end
      end else if (_T_4080) begin
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
    end else if (_T_3370) begin
      buf_addr_3 <= io_end_addr_r;
    end else begin
      buf_addr_3 <= io_lsu_addr_r;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_state_3 <= 3'h0;
    end else if (buf_state_en_3) begin
      if (_T_4107) begin
        if (io_lsu_bus_clk_en) begin
          buf_state_3 <= 3'h2;
        end else begin
          buf_state_3 <= 3'h1;
        end
      end else if (_T_4130) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else begin
          buf_state_3 <= 3'h2;
        end
      end else if (_T_4134) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else if (_T_3559) begin
          buf_state_3 <= 3'h5;
        end else begin
          buf_state_3 <= 3'h3;
        end
      end else if (_T_4168) begin
        if (_T_4173) begin
          buf_state_3 <= 3'h0;
        end else if (_T_4181) begin
          buf_state_3 <= 3'h4;
        end else if (_T_4209) begin
          buf_state_3 <= 3'h5;
        end else begin
          buf_state_3 <= 3'h6;
        end
      end else if (_T_4255) begin
        if (io_dec_tlu_force_halt) begin
          buf_state_3 <= 3'h0;
        end else if (_T_4261) begin
          buf_state_3 <= 3'h5;
        end else begin
          buf_state_3 <= 3'h6;
        end
      end else if (_T_4273) begin
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
      end else if (_T_3370) begin
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
      end else if (_T_3361) begin
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
      end else if (_T_3352) begin
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
      end else if (_T_3343) begin
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
      buf_ageQ_3 <= {_T_2535,_T_2458};
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_1848 <= 2'h0;
    end else if (obuf_wr_en) begin
      if (ibuf_buf_byp) begin
        _T_1848 <= WrPtr0_r;
      end else begin
        _T_1848 <= CmdPtr0;
      end
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
      obuf_tag1 <= 2'h0;
    end else if (obuf_wr_en) begin
      if (ibuf_buf_byp) begin
        obuf_tag1 <= WrPtr1_r;
      end else begin
        obuf_tag1 <= CmdPtr1;
      end
    end
  end
  always @(posedge io_lsu_free_c2_clk or posedge reset) begin
    if (reset) begin
      obuf_valid <= 1'h0;
    end else begin
      obuf_valid <= _T_1839 & _T_1840;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_wr_enQ <= 1'h0;
    end else begin
      obuf_wr_enQ <= _T_1240 & io_lsu_bus_clk_en;
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
      ibuf_write <= io_lsu_pkt_r_bits_store;
    end
  end
  always @(posedge io_lsu_free_c2_clk or posedge reset) begin
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
      buf_ageQ_2 <= {_T_2433,_T_2356};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ageQ_1 <= 4'h0;
    end else begin
      buf_ageQ_1 <= {_T_2331,_T_2254};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ageQ_0 <= 4'h0;
    end else begin
      buf_ageQ_0 <= {_T_2229,_T_2152};
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_0 <= 32'h0;
    end else if (_T_3528) begin
      if (_T_3543) begin
        buf_data_0 <= ibuf_data_out;
      end else begin
        buf_data_0 <= store_data_lo_r;
      end
    end else if (_T_3551) begin
      buf_data_0 <= 32'h0;
    end else if (_T_3555) begin
      if (buf_error_en_0) begin
        buf_data_0 <= io_lsu_axi_r_bits_data[31:0];
      end else if (buf_addr_0[2]) begin
        buf_data_0 <= io_lsu_axi_r_bits_data[63:32];
      end else begin
        buf_data_0 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else if (_T_3589) begin
      if (_T_3669) begin
        if (buf_addr_0[2]) begin
          buf_data_0 <= io_lsu_axi_r_bits_data[63:32];
        end else begin
          buf_data_0 <= io_lsu_axi_r_bits_data[31:0];
        end
      end else begin
        buf_data_0 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else begin
      buf_data_0 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_1 <= 32'h0;
    end else if (_T_3721) begin
      if (_T_3736) begin
        buf_data_1 <= ibuf_data_out;
      end else begin
        buf_data_1 <= store_data_lo_r;
      end
    end else if (_T_3744) begin
      buf_data_1 <= 32'h0;
    end else if (_T_3748) begin
      if (buf_error_en_1) begin
        buf_data_1 <= io_lsu_axi_r_bits_data[31:0];
      end else if (buf_addr_1[2]) begin
        buf_data_1 <= io_lsu_axi_r_bits_data[63:32];
      end else begin
        buf_data_1 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else if (_T_3782) begin
      if (_T_3862) begin
        if (buf_addr_1[2]) begin
          buf_data_1 <= io_lsu_axi_r_bits_data[63:32];
        end else begin
          buf_data_1 <= io_lsu_axi_r_bits_data[31:0];
        end
      end else begin
        buf_data_1 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else begin
      buf_data_1 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_2 <= 32'h0;
    end else if (_T_3914) begin
      if (_T_3929) begin
        buf_data_2 <= ibuf_data_out;
      end else begin
        buf_data_2 <= store_data_lo_r;
      end
    end else if (_T_3937) begin
      buf_data_2 <= 32'h0;
    end else if (_T_3941) begin
      if (buf_error_en_2) begin
        buf_data_2 <= io_lsu_axi_r_bits_data[31:0];
      end else if (buf_addr_2[2]) begin
        buf_data_2 <= io_lsu_axi_r_bits_data[63:32];
      end else begin
        buf_data_2 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else if (_T_3975) begin
      if (_T_4055) begin
        if (buf_addr_2[2]) begin
          buf_data_2 <= io_lsu_axi_r_bits_data[63:32];
        end else begin
          buf_data_2 <= io_lsu_axi_r_bits_data[31:0];
        end
      end else begin
        buf_data_2 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else begin
      buf_data_2 <= 32'h0;
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      buf_data_3 <= 32'h0;
    end else if (_T_4107) begin
      if (_T_4122) begin
        buf_data_3 <= ibuf_data_out;
      end else begin
        buf_data_3 <= store_data_lo_r;
      end
    end else if (_T_4130) begin
      buf_data_3 <= 32'h0;
    end else if (_T_4134) begin
      if (buf_error_en_3) begin
        buf_data_3 <= io_lsu_axi_r_bits_data[31:0];
      end else if (buf_addr_3[2]) begin
        buf_data_3 <= io_lsu_axi_r_bits_data[63:32];
      end else begin
        buf_data_3 <= io_lsu_axi_r_bits_data[31:0];
      end
    end else if (_T_4168) begin
      if (_T_4248) begin
        if (buf_addr_3[2]) begin
          buf_data_3 <= io_lsu_axi_r_bits_data[63:32];
        end else begin
          buf_data_3 <= io_lsu_axi_r_bits_data[31:0];
        end
      end else begin
        buf_data_3 <= io_lsu_axi_r_bits_data[31:0];
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
  always @(posedge io_lsu_free_c2_clk or posedge reset) begin
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
    end else if (ibuf_wr_en) begin
      ibuf_sideeffect <= io_is_sideeffects_r;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      WrPtr1_r <= 2'h0;
    end else if (_T_1914) begin
      WrPtr1_r <= 2'h0;
    end else if (_T_1928) begin
      WrPtr1_r <= 2'h1;
    end else if (_T_1942) begin
      WrPtr1_r <= 2'h2;
    end else begin
      WrPtr1_r <= 2'h3;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      WrPtr0_r <= 2'h0;
    end else if (_T_1863) begin
      WrPtr0_r <= 2'h0;
    end else if (_T_1874) begin
      WrPtr0_r <= 2'h1;
    end else if (_T_1885) begin
      WrPtr0_r <= 2'h2;
    end else begin
      WrPtr0_r <= 2'h3;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_tag <= 2'h0;
    end else if (ibuf_wr_en) begin
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
    end else if (ibuf_wr_en) begin
      ibuf_dualtag <= WrPtr0_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_dual <= 1'h0;
    end else if (ibuf_wr_en) begin
      ibuf_dual <= io_ldst_dual_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_samedw <= 1'h0;
    end else if (ibuf_wr_en) begin
      ibuf_samedw <= ldst_samedw_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_nomerge <= 1'h0;
    end else if (ibuf_wr_en) begin
      ibuf_nomerge <= io_no_dword_merge_r;
    end
  end
  always @(posedge io_lsu_bus_ibuf_c1_clk or posedge reset) begin
    if (reset) begin
      ibuf_unsign <= 1'h0;
    end else if (ibuf_wr_en) begin
      ibuf_unsign <= io_lsu_pkt_r_bits_unsign;
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
    end else if (_T_1058) begin
      obuf_wr_timer <= _T_1060;
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
      _T_4330 <= 1'h0;
    end else if (buf_wr_en_3) begin
      _T_4330 <= buf_sideeffect_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4327 <= 1'h0;
    end else if (buf_wr_en_2) begin
      _T_4327 <= buf_sideeffect_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4324 <= 1'h0;
    end else if (buf_wr_en_1) begin
      _T_4324 <= buf_sideeffect_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4321 <= 1'h0;
    end else if (buf_wr_en_0) begin
      _T_4321 <= buf_sideeffect_in[0];
    end
  end
  always @(posedge io_lsu_bus_obuf_c1_clk or posedge reset) begin
    if (reset) begin
      obuf_sideeffect <= 1'h0;
    end else if (obuf_wr_en) begin
      if (ibuf_buf_byp) begin
        obuf_sideeffect <= io_is_sideeffects_r;
      end else begin
        obuf_sideeffect <= _T_1051;
      end
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
        obuf_write <= io_lsu_pkt_r_bits_store;
      end else begin
        obuf_write <= _T_1202;
      end
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_cmd_done <= 1'h0;
    end else begin
      obuf_cmd_done <= _T_1305 & _T_4863;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_data_done <= 1'h0;
    end else begin
      obuf_data_done <= _T_1305 & _T_4864;
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
      obuf_addr <= _T_1289;
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
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_rdrsp_pend <= 1'h0;
    end else begin
      obuf_rdrsp_pend <= _T_1330 | _T_1334;
    end
  end
  always @(posedge io_lsu_busm_clk or posedge reset) begin
    if (reset) begin
      obuf_rdrsp_tag <= 3'h0;
    end else if (_T_1332) begin
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
        obuf_sz <= _T_1302;
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
      obuf_data <= {_T_1620,_T_1579};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_0 <= 4'h0;
    end else begin
      buf_rspageQ_0 <= {_T_3173,_T_3162};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_1 <= 4'h0;
    end else begin
      buf_rspageQ_1 <= {_T_3188,_T_3177};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_2 <= 4'h0;
    end else begin
      buf_rspageQ_2 <= {_T_3203,_T_3192};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_rspageQ_3 <= 4'h0;
    end else begin
      buf_rspageQ_3 <= {_T_3218,_T_3207};
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4307 <= 1'h0;
    end else if (buf_ldfwd_en_3) begin
      if (_T_4107) begin
        _T_4307 <= 1'h0;
      end else if (_T_4130) begin
        _T_4307 <= 1'h0;
      end else begin
        _T_4307 <= _T_4134;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4305 <= 1'h0;
    end else if (buf_ldfwd_en_2) begin
      if (_T_3914) begin
        _T_4305 <= 1'h0;
      end else if (_T_3937) begin
        _T_4305 <= 1'h0;
      end else begin
        _T_4305 <= _T_3941;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4303 <= 1'h0;
    end else if (buf_ldfwd_en_1) begin
      if (_T_3721) begin
        _T_4303 <= 1'h0;
      end else if (_T_3744) begin
        _T_4303 <= 1'h0;
      end else begin
        _T_4303 <= _T_3748;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4301 <= 1'h0;
    end else if (buf_ldfwd_en_0) begin
      if (_T_3528) begin
        _T_4301 <= 1'h0;
      end else if (_T_3551) begin
        _T_4301 <= 1'h0;
      end else begin
        _T_4301 <= _T_3555;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      buf_ldfwdtag_0 <= 2'h0;
    end else if (buf_ldfwd_en_0) begin
      if (_T_3528) begin
        buf_ldfwdtag_0 <= 2'h0;
      end else if (_T_3551) begin
        buf_ldfwdtag_0 <= 2'h0;
      end else if (_T_3555) begin
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
      end else if (_T_3343) begin
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
      if (_T_4107) begin
        buf_ldfwdtag_3 <= 2'h0;
      end else if (_T_4130) begin
        buf_ldfwdtag_3 <= 2'h0;
      end else if (_T_4134) begin
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
      if (_T_3914) begin
        buf_ldfwdtag_2 <= 2'h0;
      end else if (_T_3937) begin
        buf_ldfwdtag_2 <= 2'h0;
      end else if (_T_3941) begin
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
      if (_T_3721) begin
        buf_ldfwdtag_1 <= 2'h0;
      end else if (_T_3744) begin
        buf_ldfwdtag_1 <= 2'h0;
      end else if (_T_3748) begin
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
      end else if (_T_3352) begin
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
      end else if (_T_3361) begin
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
      end else if (_T_3370) begin
        buf_dualtag_3 <= WrPtr0_r;
      end else begin
        buf_dualtag_3 <= WrPtr1_r;
      end
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4336 <= 1'h0;
    end else if (buf_wr_en_0) begin
      _T_4336 <= buf_unsign_in[0];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4339 <= 1'h0;
    end else if (buf_wr_en_1) begin
      _T_4339 <= buf_unsign_in[1];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4342 <= 1'h0;
    end else if (buf_wr_en_2) begin
      _T_4342 <= buf_unsign_in[2];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4345 <= 1'h0;
    end else if (buf_wr_en_3) begin
      _T_4345 <= buf_unsign_in[3];
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4411 <= 1'h0;
    end else begin
      _T_4411 <= _T_4408 & _T_4409;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4406 <= 1'h0;
    end else begin
      _T_4406 <= _T_4403 & _T_4404;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4401 <= 1'h0;
    end else begin
      _T_4401 <= _T_4398 & _T_4399;
    end
  end
  always @(posedge io_lsu_bus_buf_c1_clk or posedge reset) begin
    if (reset) begin
      _T_4396 <= 1'h0;
    end else begin
      _T_4396 <= _T_4393 & _T_4394;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      lsu_nonblock_load_valid_r <= 1'h0;
    end else begin
      lsu_nonblock_load_valid_r <= io_dctl_busbuff_lsu_nonblock_load_valid_m;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_4987 <= 1'h0;
    end else begin
      _T_4987 <= _T_4984 & _T_4518;
    end
  end
endmodule
