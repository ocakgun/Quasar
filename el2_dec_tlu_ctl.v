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
module el2_dec_timer_ctl(
  input         clock,
  input         reset,
  input         io_free_clk,
  input         io_scan_mode,
  input         io_dec_csr_wen_r_mod,
  input  [11:0] io_dec_csr_wraddr_r,
  input  [31:0] io_dec_csr_wrdata_r,
  input         io_csr_mitctl0,
  input         io_csr_mitctl1,
  input         io_csr_mitb0,
  input         io_csr_mitb1,
  input         io_csr_mitcnt0,
  input         io_csr_mitcnt1,
  input         io_dec_pause_state,
  input         io_dec_tlu_pmu_fw_halted,
  input         io_internal_dbg_halt_timers,
  output [31:0] io_dec_timer_rddata_d,
  output        io_dec_timer_read_d,
  output        io_dec_timer_t0_pulse,
  output        io_dec_timer_t1_pulse
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
  reg [31:0] mitcnt0; // @[el2_lib.scala 514:16]
  reg [31:0] mitb0_b; // @[el2_lib.scala 514:16]
  wire [31:0] mitb0 = ~mitb0_b; // @[el2_dec_tlu_ctl.scala 2792:22]
  wire  mit0_match_ns = mitcnt0 >= mitb0; // @[el2_dec_tlu_ctl.scala 2753:36]
  reg [31:0] mitcnt1; // @[el2_lib.scala 514:16]
  reg [31:0] mitb1_b; // @[el2_lib.scala 514:16]
  wire [31:0] mitb1 = ~mitb1_b; // @[el2_dec_tlu_ctl.scala 2801:18]
  wire  mit1_match_ns = mitcnt1 >= mitb1; // @[el2_dec_tlu_ctl.scala 2754:36]
  wire  _T = io_dec_csr_wraddr_r == 12'h7d2; // @[el2_dec_tlu_ctl.scala 2764:72]
  wire  wr_mitcnt0_r = io_dec_csr_wen_r_mod & _T; // @[el2_dec_tlu_ctl.scala 2764:49]
  reg [1:0] _T_57; // @[el2_dec_tlu_ctl.scala 2817:67]
  reg  mitctl0_0_b; // @[el2_dec_tlu_ctl.scala 2816:60]
  wire  _T_58 = ~mitctl0_0_b; // @[el2_dec_tlu_ctl.scala 2817:90]
  wire [2:0] mitctl0 = {_T_57,_T_58}; // @[Cat.scala 29:58]
  wire  _T_2 = ~io_dec_pause_state; // @[el2_dec_tlu_ctl.scala 2766:56]
  wire  _T_4 = _T_2 | mitctl0[2]; // @[el2_dec_tlu_ctl.scala 2766:76]
  wire  _T_5 = mitctl0[0] & _T_4; // @[el2_dec_tlu_ctl.scala 2766:53]
  wire  _T_6 = ~io_dec_tlu_pmu_fw_halted; // @[el2_dec_tlu_ctl.scala 2766:112]
  wire  _T_8 = _T_6 | mitctl0[1]; // @[el2_dec_tlu_ctl.scala 2766:138]
  wire  _T_9 = _T_5 & _T_8; // @[el2_dec_tlu_ctl.scala 2766:109]
  wire  _T_10 = ~io_internal_dbg_halt_timers; // @[el2_dec_tlu_ctl.scala 2766:173]
  wire  mitcnt0_inc_ok = _T_9 & _T_10; // @[el2_dec_tlu_ctl.scala 2766:171]
  wire [31:0] mitcnt0_inc = mitcnt0 + 32'h1; // @[el2_dec_tlu_ctl.scala 2767:35]
  wire  _T_15 = wr_mitcnt0_r | mitcnt0_inc_ok; // @[el2_dec_tlu_ctl.scala 2769:59]
  wire  _T_19 = io_dec_csr_wraddr_r == 12'h7d5; // @[el2_dec_tlu_ctl.scala 2776:72]
  wire  wr_mitcnt1_r = io_dec_csr_wen_r_mod & _T_19; // @[el2_dec_tlu_ctl.scala 2776:49]
  reg [2:0] _T_66; // @[el2_dec_tlu_ctl.scala 2831:52]
  reg  mitctl1_0_b; // @[el2_dec_tlu_ctl.scala 2830:55]
  wire  _T_67 = ~mitctl1_0_b; // @[el2_dec_tlu_ctl.scala 2831:75]
  wire [3:0] mitctl1 = {_T_66,_T_67}; // @[Cat.scala 29:58]
  wire  _T_23 = _T_2 | mitctl1[2]; // @[el2_dec_tlu_ctl.scala 2778:76]
  wire  _T_24 = mitctl1[0] & _T_23; // @[el2_dec_tlu_ctl.scala 2778:53]
  wire  _T_27 = _T_6 | mitctl1[1]; // @[el2_dec_tlu_ctl.scala 2778:138]
  wire  _T_28 = _T_24 & _T_27; // @[el2_dec_tlu_ctl.scala 2778:109]
  wire  mitcnt1_inc_ok = _T_28 & _T_10; // @[el2_dec_tlu_ctl.scala 2778:171]
  wire  _T_32 = ~mitctl1[3]; // @[el2_dec_tlu_ctl.scala 2781:60]
  wire  _T_33 = _T_32 | mit0_match_ns; // @[el2_dec_tlu_ctl.scala 2781:72]
  wire [31:0] _T_34 = {31'h0,_T_33}; // @[Cat.scala 29:58]
  wire [31:0] mitcnt1_inc = mitcnt1 + _T_34; // @[el2_dec_tlu_ctl.scala 2781:35]
  wire  _T_39 = wr_mitcnt1_r | mitcnt1_inc_ok; // @[el2_dec_tlu_ctl.scala 2783:60]
  wire  _T_43 = io_dec_csr_wraddr_r == 12'h7d3; // @[el2_dec_tlu_ctl.scala 2790:70]
  wire  _T_47 = io_dec_csr_wraddr_r == 12'h7d6; // @[el2_dec_tlu_ctl.scala 2799:69]
  wire  _T_51 = io_dec_csr_wraddr_r == 12'h7d4; // @[el2_dec_tlu_ctl.scala 2812:72]
  wire  wr_mitctl0_r = io_dec_csr_wen_r_mod & _T_51; // @[el2_dec_tlu_ctl.scala 2812:49]
  wire [2:0] mitctl0_ns = wr_mitctl0_r ? io_dec_csr_wrdata_r[2:0] : mitctl0; // @[el2_dec_tlu_ctl.scala 2813:31]
  wire  _T_60 = io_dec_csr_wraddr_r == 12'h7d7; // @[el2_dec_tlu_ctl.scala 2827:71]
  wire  wr_mitctl1_r = io_dec_csr_wen_r_mod & _T_60; // @[el2_dec_tlu_ctl.scala 2827:49]
  wire [3:0] mitctl1_ns = wr_mitctl1_r ? io_dec_csr_wrdata_r[3:0] : mitctl1; // @[el2_dec_tlu_ctl.scala 2828:31]
  wire  _T_69 = io_csr_mitcnt1 | io_csr_mitcnt0; // @[el2_dec_tlu_ctl.scala 2833:51]
  wire  _T_70 = _T_69 | io_csr_mitb1; // @[el2_dec_tlu_ctl.scala 2833:68]
  wire  _T_71 = _T_70 | io_csr_mitb0; // @[el2_dec_tlu_ctl.scala 2833:83]
  wire  _T_72 = _T_71 | io_csr_mitctl0; // @[el2_dec_tlu_ctl.scala 2833:98]
  wire [31:0] _T_81 = {29'h0,_T_57,_T_58}; // @[Cat.scala 29:58]
  wire [31:0] _T_84 = {28'h0,_T_66,_T_67}; // @[Cat.scala 29:58]
  wire [31:0] _T_85 = io_csr_mitcnt0 ? mitcnt0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_86 = io_csr_mitcnt1 ? mitcnt1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_87 = io_csr_mitb0 ? mitb0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_88 = io_csr_mitb1 ? mitb1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_89 = io_csr_mitctl0 ? _T_81 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_90 = io_csr_mitctl1 ? _T_84 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_91 = _T_85 | _T_86; // @[Mux.scala 27:72]
  wire [31:0] _T_92 = _T_91 | _T_87; // @[Mux.scala 27:72]
  wire [31:0] _T_93 = _T_92 | _T_88; // @[Mux.scala 27:72]
  wire [31:0] _T_94 = _T_93 | _T_89; // @[Mux.scala 27:72]
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
  assign io_dec_timer_rddata_d = _T_94 | _T_90; // @[el2_dec_tlu_ctl.scala 2834:33]
  assign io_dec_timer_read_d = _T_72 | io_csr_mitctl1; // @[el2_dec_tlu_ctl.scala 2833:33]
  assign io_dec_timer_t0_pulse = mitcnt0 >= mitb0; // @[el2_dec_tlu_ctl.scala 2756:31]
  assign io_dec_timer_t1_pulse = mitcnt1 >= mitb1; // @[el2_dec_tlu_ctl.scala 2757:31]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_io_en = _T_15 | mit0_match_ns; // @[el2_lib.scala 511:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = _T_39 | mit1_match_ns; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_2_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_2_io_en = io_dec_csr_wen_r_mod & _T_43; // @[el2_lib.scala 511:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_3_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_3_io_en = io_dec_csr_wen_r_mod & _T_47; // @[el2_lib.scala 511:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
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
  mitcnt0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mitb0_b = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mitcnt1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mitb1_b = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  _T_57 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  mitctl0_0_b = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  _T_66 = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  mitctl1_0_b = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    mitcnt0 = 32'h0;
  end
  if (reset) begin
    mitb0_b = 32'h0;
  end
  if (reset) begin
    mitcnt1 = 32'h0;
  end
  if (reset) begin
    mitb1_b = 32'h0;
  end
  if (reset) begin
    _T_57 = 2'h0;
  end
  if (reset) begin
    mitctl0_0_b = 1'h0;
  end
  if (reset) begin
    _T_66 = 3'h0;
  end
  if (reset) begin
    mitctl1_0_b = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      mitcnt0 <= 32'h0;
    end else if (mit0_match_ns) begin
      mitcnt0 <= 32'h0;
    end else if (wr_mitcnt0_r) begin
      mitcnt0 <= io_dec_csr_wrdata_r;
    end else begin
      mitcnt0 <= mitcnt0_inc;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      mitb0_b <= 32'h0;
    end else begin
      mitb0_b <= ~io_dec_csr_wrdata_r;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      mitcnt1 <= 32'h0;
    end else if (mit1_match_ns) begin
      mitcnt1 <= 32'h0;
    end else if (wr_mitcnt1_r) begin
      mitcnt1 <= io_dec_csr_wrdata_r;
    end else begin
      mitcnt1 <= mitcnt1_inc;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      mitb1_b <= 32'h0;
    end else begin
      mitb1_b <= ~io_dec_csr_wrdata_r;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_57 <= 2'h0;
    end else begin
      _T_57 <= mitctl0_ns[2:1];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mitctl0_0_b <= 1'h0;
    end else begin
      mitctl0_0_b <= ~mitctl0_ns[0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_66 <= 3'h0;
    end else begin
      _T_66 <= mitctl1_ns[3:1];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mitctl1_0_b <= 1'h0;
    end else begin
      mitctl1_0_b <= ~mitctl1_ns[0];
    end
  end
endmodule
module csr_tlu(
  input         clock,
  input         reset,
  input         io_free_clk,
  input         io_active_clk,
  input         io_scan_mode,
  input  [31:0] io_dec_csr_wrdata_r,
  input  [11:0] io_dec_csr_wraddr_r,
  input  [11:0] io_dec_csr_rdaddr_d,
  input         io_dec_csr_wen_unq_d,
  input         io_dec_i0_decode_d,
  output [70:0] io_dec_tlu_ic_diag_pkt_icache_wrdata,
  output [16:0] io_dec_tlu_ic_diag_pkt_icache_dicawics,
  output        io_dec_tlu_ic_diag_pkt_icache_rd_valid,
  output        io_dec_tlu_ic_diag_pkt_icache_wr_valid,
  input         io_ifu_ic_debug_rd_data_valid,
  output        io_trigger_pkt_any_0_select,
  output        io_trigger_pkt_any_0_match_,
  output        io_trigger_pkt_any_0_store,
  output        io_trigger_pkt_any_0_load,
  output        io_trigger_pkt_any_0_execute,
  output        io_trigger_pkt_any_0_m,
  output [31:0] io_trigger_pkt_any_0_tdata2,
  output        io_trigger_pkt_any_1_select,
  output        io_trigger_pkt_any_1_match_,
  output        io_trigger_pkt_any_1_store,
  output        io_trigger_pkt_any_1_load,
  output        io_trigger_pkt_any_1_execute,
  output        io_trigger_pkt_any_1_m,
  output [31:0] io_trigger_pkt_any_1_tdata2,
  output        io_trigger_pkt_any_2_select,
  output        io_trigger_pkt_any_2_match_,
  output        io_trigger_pkt_any_2_store,
  output        io_trigger_pkt_any_2_load,
  output        io_trigger_pkt_any_2_execute,
  output        io_trigger_pkt_any_2_m,
  output [31:0] io_trigger_pkt_any_2_tdata2,
  output        io_trigger_pkt_any_3_select,
  output        io_trigger_pkt_any_3_match_,
  output        io_trigger_pkt_any_3_store,
  output        io_trigger_pkt_any_3_load,
  output        io_trigger_pkt_any_3_execute,
  output        io_trigger_pkt_any_3_m,
  output [31:0] io_trigger_pkt_any_3_tdata2,
  input         io_ifu_pmu_bus_trxn,
  input         io_dma_iccm_stall_any,
  input         io_dma_dccm_stall_any,
  input         io_lsu_store_stall_any,
  input         io_dec_pmu_presync_stall,
  input         io_dec_pmu_postsync_stall,
  input         io_dec_pmu_decode_stall,
  input         io_ifu_pmu_fetch_stall,
  input  [1:0]  io_dec_tlu_packet_r_icaf_type,
  input  [3:0]  io_dec_tlu_packet_r_pmu_i0_itype,
  input         io_dec_tlu_packet_r_pmu_i0_br_unpred,
  input         io_dec_tlu_packet_r_pmu_divide,
  input         io_dec_tlu_packet_r_pmu_lsu_misaligned,
  input         io_exu_pmu_i0_br_ataken,
  input         io_exu_pmu_i0_br_misp,
  input         io_dec_pmu_instr_decoded,
  input         io_ifu_pmu_instr_aligned,
  input         io_exu_pmu_i0_pc4,
  input         io_ifu_pmu_ic_miss,
  input         io_ifu_pmu_ic_hit,
  output        io_dec_tlu_int_valid_wb1,
  output        io_dec_tlu_i0_exc_valid_wb1,
  output        io_dec_tlu_i0_valid_wb1,
  input         io_dec_csr_wen_r,
  output [31:0] io_dec_tlu_mtval_wb1,
  output [4:0]  io_dec_tlu_exc_cause_wb1,
  output        io_dec_tlu_perfcnt0,
  output        io_dec_tlu_perfcnt1,
  output        io_dec_tlu_perfcnt2,
  output        io_dec_tlu_perfcnt3,
  input         io_dec_tlu_dbg_halted,
  input         io_dma_pmu_dccm_write,
  input         io_dma_pmu_dccm_read,
  input         io_dma_pmu_any_write,
  input         io_dma_pmu_any_read,
  input         io_lsu_pmu_bus_busy,
  input  [30:0] io_dec_tlu_i0_pc_r,
  input         io_dec_tlu_i0_valid_r,
  input         io_dec_csr_any_unq_d,
  output        io_dec_tlu_misc_clk_override,
  output        io_dec_tlu_dec_clk_override,
  output        io_dec_tlu_ifu_clk_override,
  output        io_dec_tlu_lsu_clk_override,
  output        io_dec_tlu_bus_clk_override,
  output        io_dec_tlu_pic_clk_override,
  output        io_dec_tlu_dccm_clk_override,
  output        io_dec_tlu_icm_clk_override,
  output [31:0] io_dec_csr_rddata_d,
  output        io_dec_tlu_pipelining_disable,
  output        io_dec_tlu_wr_pause_r,
  input         io_ifu_pmu_bus_busy,
  input         io_lsu_pmu_bus_error,
  input         io_ifu_pmu_bus_error,
  input         io_lsu_pmu_bus_misaligned,
  input         io_lsu_pmu_bus_trxn,
  input  [70:0] io_ifu_ic_debug_rd_data,
  output [3:0]  io_dec_tlu_meipt,
  input  [3:0]  io_pic_pl,
  output [3:0]  io_dec_tlu_meicurpl,
  output [29:0] io_dec_tlu_meihap,
  input  [7:0]  io_pic_claimid,
  input         io_iccm_dma_sb_error,
  input  [31:0] io_lsu_imprecise_error_addr_any,
  input         io_lsu_imprecise_error_load_any,
  input         io_lsu_imprecise_error_store_any,
  output [31:0] io_dec_tlu_mrac_ff,
  output        io_dec_tlu_wb_coalescing_disable,
  output        io_dec_tlu_bpred_disable,
  output        io_dec_tlu_sideeffect_posted_disable,
  output        io_dec_tlu_core_ecc_disable,
  output        io_dec_tlu_external_ldfwd_disable,
  output [2:0]  io_dec_tlu_dma_qos_prty,
  input  [31:0] io_dec_illegal_inst,
  input  [3:0]  io_lsu_error_pkt_r_mscause,
  input         io_mexintpend,
  input  [30:0] io_exu_npc_r,
  input         io_mpc_reset_run_req,
  input  [30:0] io_rst_vec,
  input  [27:0] io_core_id,
  input  [31:0] io_dec_timer_rddata_d,
  input         io_dec_timer_read_d,
  output        io_dec_csr_wen_r_mod,
  input         io_rfpc_i0_r,
  input         io_i0_trigger_hit_r,
  output        io_fw_halt_req,
  output [1:0]  io_mstatus,
  input         io_exc_or_int_valid_r,
  input         io_mret_r,
  output        io_mstatus_mie_ns,
  input         io_dcsr_single_step_running_f,
  output [15:0] io_dcsr,
  output [30:0] io_mtvec,
  output [5:0]  io_mip,
  input         io_dec_timer_t0_pulse,
  input         io_dec_timer_t1_pulse,
  input         io_timer_int_sync,
  input         io_soft_int_sync,
  output [5:0]  io_mie_ns,
  input         io_csr_wr_clk,
  input         io_ebreak_to_debug_mode_r,
  input         io_dec_tlu_pmu_fw_halted,
  input  [1:0]  io_lsu_fir_error,
  output [30:0] io_npc_r,
  input         io_tlu_flush_lower_r_d1,
  input         io_dec_tlu_flush_noredir_r_d1,
  input  [30:0] io_tlu_flush_path_r_d1,
  output [30:0] io_npc_r_d1,
  input         io_reset_delayed,
  output [30:0] io_mepc,
  input         io_interrupt_valid_r,
  input         io_i0_exception_valid_r,
  input         io_lsu_exc_valid_r,
  input         io_mepc_trigger_hit_sel_pc_r,
  input         io_e4e5_int_clk,
  input         io_lsu_i0_exc_r,
  input         io_inst_acc_r,
  input         io_inst_acc_second_r,
  input         io_take_nmi,
  input  [31:0] io_lsu_error_pkt_addr_r,
  input  [4:0]  io_exc_cause_r,
  input         io_i0_valid_wb,
  input         io_exc_or_int_valid_r_d1,
  input         io_interrupt_valid_r_d1,
  input         io_clk_override,
  input         io_i0_exception_valid_r_d1,
  input         io_lsu_i0_exc_r_d1,
  input  [4:0]  io_exc_cause_wb,
  input         io_nmi_lsu_store_type,
  input         io_nmi_lsu_load_type,
  input         io_tlu_i0_commit_cmt,
  input         io_ebreak_r,
  input         io_ecall_r,
  input         io_illegal_r,
  output        io_mdseac_locked_ns,
  input         io_mdseac_locked_f,
  input         io_nmi_int_detected_f,
  input         io_internal_dbg_halt_mode_f2,
  input         io_ext_int_freeze_d1,
  input         io_ic_perr_r_d1,
  input         io_iccm_sbecc_r_d1,
  input         io_lsu_single_ecc_error_r_d1,
  input         io_ifu_miss_state_idle_f,
  input         io_lsu_idle_any_f,
  input         io_dbg_tlu_halted_f,
  input         io_dbg_tlu_halted,
  input         io_debug_halt_req_f,
  output        io_force_halt,
  input         io_take_ext_int_start,
  input         io_trigger_hit_dmode_r_d1,
  input         io_trigger_hit_r_d1,
  input         io_dcsr_single_step_done_f,
  input         io_ebreak_to_debug_mode_r_d1,
  input         io_debug_halt_req,
  input         io_allow_dbg_halt_csr_write,
  input         io_internal_dbg_halt_mode_f,
  input         io_enter_debug_halt_req,
  input         io_internal_dbg_halt_mode,
  input         io_request_debug_mode_done,
  input         io_request_debug_mode_r,
  output [30:0] io_dpc,
  input  [3:0]  io_update_hit_bit_r,
  input         io_take_timer_int,
  input         io_take_int_timer0_int,
  input         io_take_int_timer1_int,
  input         io_take_ext_int,
  input         io_tlu_flush_lower_r,
  input         io_dec_tlu_br0_error_r,
  input         io_dec_tlu_br0_start_error_r,
  input         io_lsu_pmu_load_external_r,
  input         io_lsu_pmu_store_external_r,
  input         io_csr_pkt_csr_misa,
  input         io_csr_pkt_csr_mvendorid,
  input         io_csr_pkt_csr_marchid,
  input         io_csr_pkt_csr_mimpid,
  input         io_csr_pkt_csr_mhartid,
  input         io_csr_pkt_csr_mstatus,
  input         io_csr_pkt_csr_mtvec,
  input         io_csr_pkt_csr_mip,
  input         io_csr_pkt_csr_mie,
  input         io_csr_pkt_csr_mcyclel,
  input         io_csr_pkt_csr_mcycleh,
  input         io_csr_pkt_csr_minstretl,
  input         io_csr_pkt_csr_minstreth,
  input         io_csr_pkt_csr_mscratch,
  input         io_csr_pkt_csr_mepc,
  input         io_csr_pkt_csr_mcause,
  input         io_csr_pkt_csr_mscause,
  input         io_csr_pkt_csr_mtval,
  input         io_csr_pkt_csr_mrac,
  input         io_csr_pkt_csr_mdseac,
  input         io_csr_pkt_csr_meihap,
  input         io_csr_pkt_csr_meivt,
  input         io_csr_pkt_csr_meipt,
  input         io_csr_pkt_csr_meicurpl,
  input         io_csr_pkt_csr_meicidpl,
  input         io_csr_pkt_csr_dcsr,
  input         io_csr_pkt_csr_mcgc,
  input         io_csr_pkt_csr_mfdc,
  input         io_csr_pkt_csr_dpc,
  input         io_csr_pkt_csr_mtsel,
  input         io_csr_pkt_csr_mtdata1,
  input         io_csr_pkt_csr_mtdata2,
  input         io_csr_pkt_csr_mhpmc3,
  input         io_csr_pkt_csr_mhpmc4,
  input         io_csr_pkt_csr_mhpmc5,
  input         io_csr_pkt_csr_mhpmc6,
  input         io_csr_pkt_csr_mhpmc3h,
  input         io_csr_pkt_csr_mhpmc4h,
  input         io_csr_pkt_csr_mhpmc5h,
  input         io_csr_pkt_csr_mhpmc6h,
  input         io_csr_pkt_csr_mhpme3,
  input         io_csr_pkt_csr_mhpme4,
  input         io_csr_pkt_csr_mhpme5,
  input         io_csr_pkt_csr_mhpme6,
  input         io_csr_pkt_csr_mcountinhibit,
  input         io_csr_pkt_csr_mpmc,
  input         io_csr_pkt_csr_micect,
  input         io_csr_pkt_csr_miccmect,
  input         io_csr_pkt_csr_mdccmect,
  input         io_csr_pkt_csr_mfdht,
  input         io_csr_pkt_csr_mfdhs,
  input         io_csr_pkt_csr_dicawics,
  input         io_csr_pkt_csr_dicad0h,
  input         io_csr_pkt_csr_dicad0,
  input         io_csr_pkt_csr_dicad1,
  output [9:0]  io_mtdata1_t_0,
  output [9:0]  io_mtdata1_t_1,
  output [9:0]  io_mtdata1_t_2,
  output [9:0]  io_mtdata1_t_3
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
  reg [95:0] _RAND_39;
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
  wire  rvclkhdr_12_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_12_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_13_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_13_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_13_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_13_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_14_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_14_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_14_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_14_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_15_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_15_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_15_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_15_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_16_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_16_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_16_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_16_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_17_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_17_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_17_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_17_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_18_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_18_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_18_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_18_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_19_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_19_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_19_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_19_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_20_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_20_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_20_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_20_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_21_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_21_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_21_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_21_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_22_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_22_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_22_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_22_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_23_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_23_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_23_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_23_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_24_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_24_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_24_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_24_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_25_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_25_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_25_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_25_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_26_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_26_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_26_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_26_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_27_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_27_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_27_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_27_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_28_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_28_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_28_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_28_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_29_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_29_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_29_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_29_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_30_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_30_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_30_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_30_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_31_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_31_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_31_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_31_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_32_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_32_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_32_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_32_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_33_io_l1clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_33_io_clk; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_33_io_en; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_33_io_scan_mode; // @[el2_lib.scala 508:23]
  wire  rvclkhdr_34_io_l1clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_34_io_clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_34_io_en; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_34_io_scan_mode; // @[el2_lib.scala 483:22]
  wire  _T = ~io_i0_trigger_hit_r; // @[el2_dec_tlu_ctl.scala 1530:45]
  wire  _T_1 = io_dec_csr_wen_r & _T; // @[el2_dec_tlu_ctl.scala 1530:43]
  wire  _T_2 = ~io_rfpc_i0_r; // @[el2_dec_tlu_ctl.scala 1530:68]
  wire  _T_5 = io_dec_csr_wraddr_r == 12'h300; // @[el2_dec_tlu_ctl.scala 1531:71]
  wire  wr_mstatus_r = io_dec_csr_wen_r_mod & _T_5; // @[el2_dec_tlu_ctl.scala 1531:42]
  wire  _T_500 = io_dec_csr_wraddr_r == 12'h7c6; // @[el2_dec_tlu_ctl.scala 1917:68]
  wire  wr_mpmc_r = io_dec_csr_wen_r_mod & _T_500; // @[el2_dec_tlu_ctl.scala 1917:39]
  wire  _T_512 = ~io_dec_csr_wrdata_r[1]; // @[el2_dec_tlu_ctl.scala 1925:37]
  reg  mpmc_b; // @[el2_dec_tlu_ctl.scala 1927:44]
  wire  mpmc = ~mpmc_b; // @[el2_dec_tlu_ctl.scala 1930:10]
  wire  _T_513 = ~mpmc; // @[el2_dec_tlu_ctl.scala 1925:62]
  wire  mpmc_b_ns = wr_mpmc_r ? _T_512 : _T_513; // @[el2_dec_tlu_ctl.scala 1925:18]
  wire  _T_6 = ~mpmc_b_ns; // @[el2_dec_tlu_ctl.scala 1534:28]
  wire  set_mie_pmu_fw_halt = _T_6 & io_fw_halt_req; // @[el2_dec_tlu_ctl.scala 1534:39]
  wire  _T_7 = ~wr_mstatus_r; // @[el2_dec_tlu_ctl.scala 1537:5]
  wire  _T_8 = _T_7 & io_exc_or_int_valid_r; // @[el2_dec_tlu_ctl.scala 1537:19]
  wire [1:0] _T_12 = {io_mstatus[0],1'h0}; // @[Cat.scala 29:58]
  wire  _T_13 = wr_mstatus_r & io_exc_or_int_valid_r; // @[el2_dec_tlu_ctl.scala 1538:18]
  wire [1:0] _T_16 = {io_dec_csr_wrdata_r[3],1'h0}; // @[Cat.scala 29:58]
  wire  _T_17 = ~io_exc_or_int_valid_r; // @[el2_dec_tlu_ctl.scala 1539:17]
  wire  _T_18 = io_mret_r & _T_17; // @[el2_dec_tlu_ctl.scala 1539:15]
  wire [1:0] _T_21 = {1'h1,io_mstatus[1]}; // @[Cat.scala 29:58]
  wire [1:0] _T_24 = {io_mstatus[1],1'h1}; // @[Cat.scala 29:58]
  wire  _T_26 = wr_mstatus_r & _T_17; // @[el2_dec_tlu_ctl.scala 1541:18]
  wire [1:0] _T_30 = {io_dec_csr_wrdata_r[7],io_dec_csr_wrdata_r[3]}; // @[Cat.scala 29:58]
  wire  _T_33 = _T_7 & _T_17; // @[el2_dec_tlu_ctl.scala 1542:19]
  wire  _T_34 = ~io_mret_r; // @[el2_dec_tlu_ctl.scala 1542:46]
  wire  _T_35 = _T_33 & _T_34; // @[el2_dec_tlu_ctl.scala 1542:44]
  wire  _T_36 = ~set_mie_pmu_fw_halt; // @[el2_dec_tlu_ctl.scala 1542:59]
  wire  _T_37 = _T_35 & _T_36; // @[el2_dec_tlu_ctl.scala 1542:57]
  wire [1:0] _T_39 = _T_8 ? _T_12 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_40 = _T_13 ? _T_16 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_41 = _T_18 ? _T_21 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_42 = set_mie_pmu_fw_halt ? _T_24 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_43 = _T_26 ? _T_30 : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_44 = _T_37 ? io_mstatus : 2'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_45 = _T_39 | _T_40; // @[Mux.scala 27:72]
  wire [1:0] _T_46 = _T_45 | _T_41; // @[Mux.scala 27:72]
  wire [1:0] _T_47 = _T_46 | _T_42; // @[Mux.scala 27:72]
  wire [1:0] _T_48 = _T_47 | _T_43; // @[Mux.scala 27:72]
  wire  _T_52 = ~io_dcsr_single_step_running_f; // @[el2_dec_tlu_ctl.scala 1545:50]
  wire  _T_54 = _T_52 | io_dcsr[11]; // @[el2_dec_tlu_ctl.scala 1545:81]
  reg [1:0] _T_56; // @[el2_dec_tlu_ctl.scala 1547:11]
  wire  _T_58 = io_dec_csr_wraddr_r == 12'h305; // @[el2_dec_tlu_ctl.scala 1556:69]
  reg [30:0] _T_62; // @[el2_lib.scala 514:16]
  reg [31:0] mdccmect; // @[el2_lib.scala 514:16]
  wire [62:0] _T_576 = 63'hffffffff << mdccmect[31:27]; // @[el2_dec_tlu_ctl.scala 1976:41]
  wire [31:0] _T_578 = {5'h0,mdccmect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_9 = {{31'd0}, _T_578}; // @[el2_dec_tlu_ctl.scala 1976:61]
  wire [62:0] _T_579 = _T_576 & _GEN_9; // @[el2_dec_tlu_ctl.scala 1976:61]
  wire  mdccme_ce_req = |_T_579; // @[el2_dec_tlu_ctl.scala 1976:94]
  reg [31:0] miccmect; // @[el2_lib.scala 514:16]
  wire [62:0] _T_556 = 63'hffffffff << miccmect[31:27]; // @[el2_dec_tlu_ctl.scala 1961:41]
  wire [31:0] _T_558 = {5'h0,miccmect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_10 = {{31'd0}, _T_558}; // @[el2_dec_tlu_ctl.scala 1961:61]
  wire [62:0] _T_559 = _T_556 & _GEN_10; // @[el2_dec_tlu_ctl.scala 1961:61]
  wire  miccme_ce_req = |_T_559; // @[el2_dec_tlu_ctl.scala 1961:94]
  wire  _T_63 = mdccme_ce_req | miccme_ce_req; // @[el2_dec_tlu_ctl.scala 1570:30]
  reg [31:0] micect; // @[el2_lib.scala 514:16]
  wire [62:0] _T_534 = 63'hffffffff << micect[31:27]; // @[el2_dec_tlu_ctl.scala 1947:38]
  wire  _T_535 = |_T_534; // @[el2_dec_tlu_ctl.scala 1947:56]
  wire [31:0] _T_537 = {5'h0,micect[26:0]}; // @[Cat.scala 29:58]
  wire [31:0] _GEN_11 = {{31'd0}, _T_535}; // @[el2_dec_tlu_ctl.scala 1947:60]
  wire [31:0] _T_538 = _GEN_11 & _T_537; // @[el2_dec_tlu_ctl.scala 1947:60]
  wire  mice_ce_req = _T_538[0]; // @[el2_dec_tlu_ctl.scala 1947:14]
  wire  ce_int = _T_63 | mice_ce_req; // @[el2_dec_tlu_ctl.scala 1570:46]
  wire [2:0] _T_65 = {io_mexintpend,io_timer_int_sync,io_soft_int_sync}; // @[Cat.scala 29:58]
  wire [2:0] _T_67 = {ce_int,io_dec_timer_t0_pulse,io_dec_timer_t1_pulse}; // @[Cat.scala 29:58]
  reg [5:0] _T_68; // @[el2_dec_tlu_ctl.scala 1574:11]
  wire  _T_70 = io_dec_csr_wraddr_r == 12'h304; // @[el2_dec_tlu_ctl.scala 1586:67]
  wire  wr_mie_r = io_dec_csr_wen_r_mod & _T_70; // @[el2_dec_tlu_ctl.scala 1586:38]
  wire [5:0] _T_78 = {io_dec_csr_wrdata_r[30:28],io_dec_csr_wrdata_r[11],io_dec_csr_wrdata_r[7],io_dec_csr_wrdata_r[3]}; // @[Cat.scala 29:58]
  reg [5:0] mie; // @[el2_dec_tlu_ctl.scala 1589:11]
  wire  kill_ebreak_count_r = io_ebreak_to_debug_mode_r & io_dcsr[10]; // @[el2_dec_tlu_ctl.scala 1596:54]
  wire  _T_83 = io_dec_csr_wraddr_r == 12'hb00; // @[el2_dec_tlu_ctl.scala 1598:71]
  wire  wr_mcyclel_r = io_dec_csr_wen_r_mod & _T_83; // @[el2_dec_tlu_ctl.scala 1598:42]
  wire  _T_85 = io_dec_tlu_dbg_halted & io_dcsr[10]; // @[el2_dec_tlu_ctl.scala 1600:71]
  wire  _T_86 = kill_ebreak_count_r | _T_85; // @[el2_dec_tlu_ctl.scala 1600:46]
  wire  _T_87 = _T_86 | io_dec_tlu_pmu_fw_halted; // @[el2_dec_tlu_ctl.scala 1600:94]
  reg [4:0] temp_ncount6_2; // @[Reg.scala 27:20]
  reg  temp_ncount0; // @[Reg.scala 27:20]
  wire [6:0] mcountinhibit = {temp_ncount6_2,1'h0,temp_ncount0}; // @[Cat.scala 29:58]
  wire  _T_89 = _T_87 | mcountinhibit[0]; // @[el2_dec_tlu_ctl.scala 1600:121]
  wire  mcyclel_cout_in = ~_T_89; // @[el2_dec_tlu_ctl.scala 1600:24]
  wire [31:0] _T_90 = {31'h0,mcyclel_cout_in}; // @[Cat.scala 29:58]
  reg [31:0] mcyclel; // @[el2_lib.scala 514:16]
  wire [31:0] _T_92 = mcyclel + _T_90; // @[el2_dec_tlu_ctl.scala 1604:25]
  wire [32:0] mcyclel_inc = {{1'd0}, _T_92}; // @[el2_dec_tlu_ctl.scala 1604:14]
  wire  mcyclel_cout = mcyclel_inc[32]; // @[el2_dec_tlu_ctl.scala 1606:32]
  wire  _T_102 = io_dec_csr_wraddr_r == 12'hb80; // @[el2_dec_tlu_ctl.scala 1614:68]
  wire  wr_mcycleh_r = io_dec_csr_wen_r_mod & _T_102; // @[el2_dec_tlu_ctl.scala 1614:39]
  wire  _T_99 = ~wr_mcycleh_r; // @[el2_dec_tlu_ctl.scala 1608:71]
  reg  mcyclel_cout_f; // @[el2_dec_tlu_ctl.scala 1608:54]
  wire [31:0] _T_104 = {31'h0,mcyclel_cout_f}; // @[Cat.scala 29:58]
  reg [31:0] mcycleh; // @[el2_lib.scala 514:16]
  wire [31:0] mcycleh_inc = mcycleh + _T_104; // @[el2_dec_tlu_ctl.scala 1616:28]
  wire  _T_110 = io_ebreak_r | io_ecall_r; // @[el2_dec_tlu_ctl.scala 1633:72]
  wire  _T_111 = _T_110 | io_ebreak_to_debug_mode_r; // @[el2_dec_tlu_ctl.scala 1633:85]
  wire  _T_112 = _T_111 | io_illegal_r; // @[el2_dec_tlu_ctl.scala 1633:113]
  wire  _T_114 = _T_112 | mcountinhibit[2]; // @[el2_dec_tlu_ctl.scala 1633:128]
  wire  _T_116 = ~_T_114; // @[el2_dec_tlu_ctl.scala 1633:58]
  wire  i0_valid_no_ebreak_ecall_r = io_tlu_i0_commit_cmt & _T_116; // @[el2_dec_tlu_ctl.scala 1633:56]
  wire  _T_118 = io_dec_csr_wraddr_r == 12'hb02; // @[el2_dec_tlu_ctl.scala 1635:73]
  wire  wr_minstretl_r = io_dec_csr_wen_r_mod & _T_118; // @[el2_dec_tlu_ctl.scala 1635:44]
  wire [31:0] _T_119 = {31'h0,i0_valid_no_ebreak_ecall_r}; // @[Cat.scala 29:58]
  reg [31:0] minstretl; // @[el2_lib.scala 514:16]
  wire [31:0] _T_121 = minstretl + _T_119; // @[el2_dec_tlu_ctl.scala 1637:29]
  wire [32:0] minstretl_inc = {{1'd0}, _T_121}; // @[el2_dec_tlu_ctl.scala 1637:16]
  wire  minstretl_cout = minstretl_inc[32]; // @[el2_dec_tlu_ctl.scala 1638:36]
  reg  minstret_enable_f; // @[el2_dec_tlu_ctl.scala 1643:56]
  wire  _T_130 = io_dec_csr_wraddr_r == 12'hb82; // @[el2_dec_tlu_ctl.scala 1652:71]
  wire  wr_minstreth_r = io_dec_csr_wen_r_mod & _T_130; // @[el2_dec_tlu_ctl.scala 1652:42]
  wire  _T_127 = ~wr_minstreth_r; // @[el2_dec_tlu_ctl.scala 1644:75]
  reg  minstretl_cout_f; // @[el2_dec_tlu_ctl.scala 1644:56]
  wire [31:0] _T_133 = {31'h0,minstretl_cout_f}; // @[Cat.scala 29:58]
  reg [31:0] minstreth; // @[el2_lib.scala 514:16]
  wire [31:0] minstreth_inc = minstreth + _T_133; // @[el2_dec_tlu_ctl.scala 1655:29]
  wire  _T_141 = io_dec_csr_wraddr_r == 12'h340; // @[el2_dec_tlu_ctl.scala 1666:72]
  reg [31:0] mscratch; // @[el2_lib.scala 514:16]
  wire  _T_144 = ~io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 1677:22]
  wire  _T_145 = ~io_tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 1677:47]
  wire  _T_146 = _T_144 & _T_145; // @[el2_dec_tlu_ctl.scala 1677:45]
  wire  sel_exu_npc_r = _T_146 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 1677:72]
  wire  _T_148 = _T_144 & io_tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 1678:47]
  wire  _T_149 = ~io_dec_tlu_flush_noredir_r_d1; // @[el2_dec_tlu_ctl.scala 1678:75]
  wire  sel_flush_npc_r = _T_148 & _T_149; // @[el2_dec_tlu_ctl.scala 1678:73]
  wire  _T_150 = ~sel_exu_npc_r; // @[el2_dec_tlu_ctl.scala 1679:23]
  wire  _T_151 = ~sel_flush_npc_r; // @[el2_dec_tlu_ctl.scala 1679:40]
  wire  sel_hold_npc_r = _T_150 & _T_151; // @[el2_dec_tlu_ctl.scala 1679:38]
  wire  _T_153 = ~io_mpc_reset_run_req; // @[el2_dec_tlu_ctl.scala 1683:13]
  wire  _T_154 = _T_153 & io_reset_delayed; // @[el2_dec_tlu_ctl.scala 1683:35]
  wire [30:0] _T_158 = sel_exu_npc_r ? io_exu_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_159 = _T_154 ? io_rst_vec : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_160 = sel_flush_npc_r ? io_tlu_flush_path_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_161 = sel_hold_npc_r ? io_npc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_162 = _T_158 | _T_159; // @[Mux.scala 27:72]
  wire [30:0] _T_163 = _T_162 | _T_160; // @[Mux.scala 27:72]
  wire  _T_166 = sel_exu_npc_r | sel_flush_npc_r; // @[el2_dec_tlu_ctl.scala 1687:48]
  reg [30:0] _T_169; // @[el2_lib.scala 514:16]
  wire  pc0_valid_r = _T_144 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 1690:44]
  wire  _T_172 = ~pc0_valid_r; // @[el2_dec_tlu_ctl.scala 1694:22]
  wire [30:0] _T_173 = pc0_valid_r ? io_dec_tlu_i0_pc_r : 31'h0; // @[Mux.scala 27:72]
  reg [30:0] pc_r_d1; // @[el2_lib.scala 514:16]
  wire [30:0] _T_174 = _T_172 ? pc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] pc_r = _T_173 | _T_174; // @[Mux.scala 27:72]
  wire  _T_178 = io_dec_csr_wraddr_r == 12'h341; // @[el2_dec_tlu_ctl.scala 1698:68]
  wire  wr_mepc_r = io_dec_csr_wen_r_mod & _T_178; // @[el2_dec_tlu_ctl.scala 1698:39]
  wire  _T_179 = io_i0_exception_valid_r | io_lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 1701:27]
  wire  _T_180 = _T_179 | io_mepc_trigger_hit_sel_pc_r; // @[el2_dec_tlu_ctl.scala 1701:48]
  wire  _T_184 = wr_mepc_r & _T_17; // @[el2_dec_tlu_ctl.scala 1703:13]
  wire  _T_187 = ~wr_mepc_r; // @[el2_dec_tlu_ctl.scala 1704:3]
  wire  _T_189 = _T_187 & _T_17; // @[el2_dec_tlu_ctl.scala 1704:14]
  wire [30:0] _T_191 = _T_180 ? pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_192 = io_interrupt_valid_r ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_193 = _T_184 ? io_dec_csr_wrdata_r[31:1] : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_194 = _T_189 ? io_mepc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_195 = _T_191 | _T_192; // @[Mux.scala 27:72]
  wire [30:0] _T_196 = _T_195 | _T_193; // @[Mux.scala 27:72]
  reg [30:0] _T_198; // @[el2_dec_tlu_ctl.scala 1706:47]
  wire  _T_200 = io_dec_csr_wraddr_r == 12'h342; // @[el2_dec_tlu_ctl.scala 1713:72]
  wire  wr_mcause_r = io_dec_csr_wen_r_mod & _T_200; // @[el2_dec_tlu_ctl.scala 1713:43]
  wire  _T_201 = io_exc_or_int_valid_r & io_take_nmi; // @[el2_dec_tlu_ctl.scala 1714:53]
  wire  mcause_sel_nmi_store = _T_201 & io_nmi_lsu_store_type; // @[el2_dec_tlu_ctl.scala 1714:67]
  wire  mcause_sel_nmi_load = _T_201 & io_nmi_lsu_load_type; // @[el2_dec_tlu_ctl.scala 1715:66]
  wire  _T_204 = |io_lsu_fir_error; // @[el2_dec_tlu_ctl.scala 1716:84]
  wire  mcause_sel_nmi_ext = _T_201 & _T_204; // @[el2_dec_tlu_ctl.scala 1716:65]
  wire  _T_205 = &io_lsu_fir_error; // @[el2_dec_tlu_ctl.scala 1722:53]
  wire  _T_208 = ~io_lsu_fir_error[0]; // @[el2_dec_tlu_ctl.scala 1722:82]
  wire  _T_209 = io_lsu_fir_error[1] & _T_208; // @[el2_dec_tlu_ctl.scala 1722:80]
  wire [31:0] _T_214 = {30'h3c000400,_T_205,_T_209}; // @[Cat.scala 29:58]
  wire  _T_215 = ~io_take_nmi; // @[el2_dec_tlu_ctl.scala 1728:56]
  wire  _T_216 = io_exc_or_int_valid_r & _T_215; // @[el2_dec_tlu_ctl.scala 1728:54]
  wire [31:0] _T_219 = {io_interrupt_valid_r,26'h0,io_exc_cause_r}; // @[Cat.scala 29:58]
  wire  _T_221 = wr_mcause_r & _T_17; // @[el2_dec_tlu_ctl.scala 1729:44]
  wire  _T_223 = ~wr_mcause_r; // @[el2_dec_tlu_ctl.scala 1730:32]
  wire  _T_225 = _T_223 & _T_17; // @[el2_dec_tlu_ctl.scala 1730:45]
  wire [31:0] _T_227 = mcause_sel_nmi_store ? 32'hf0000000 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_228 = mcause_sel_nmi_load ? 32'hf0000001 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_229 = mcause_sel_nmi_ext ? _T_214 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_230 = _T_216 ? _T_219 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_231 = _T_221 ? io_dec_csr_wrdata_r : 32'h0; // @[Mux.scala 27:72]
  reg [31:0] mcause; // @[el2_dec_tlu_ctl.scala 1732:49]
  wire [31:0] _T_232 = _T_225 ? mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_233 = _T_227 | _T_228; // @[Mux.scala 27:72]
  wire [31:0] _T_234 = _T_233 | _T_229; // @[Mux.scala 27:72]
  wire [31:0] _T_235 = _T_234 | _T_230; // @[Mux.scala 27:72]
  wire [31:0] _T_236 = _T_235 | _T_231; // @[Mux.scala 27:72]
  wire  _T_240 = io_dec_csr_wraddr_r == 12'h7ff; // @[el2_dec_tlu_ctl.scala 1739:71]
  wire  wr_mscause_r = io_dec_csr_wen_r_mod & _T_240; // @[el2_dec_tlu_ctl.scala 1739:42]
  wire  _T_241 = io_dec_tlu_packet_r_icaf_type == 2'h0; // @[el2_dec_tlu_ctl.scala 1741:56]
  wire [3:0] _T_242 = {2'h0,io_dec_tlu_packet_r_icaf_type}; // @[Cat.scala 29:58]
  wire [3:0] ifu_mscause = _T_241 ? 4'h9 : _T_242; // @[el2_dec_tlu_ctl.scala 1741:24]
  wire [3:0] _T_247 = io_lsu_i0_exc_r ? io_lsu_error_pkt_r_mscause : 4'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_249 = io_ebreak_r ? 2'h2 : 2'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_250 = io_inst_acc_r ? ifu_mscause : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _GEN_12 = {{3'd0}, io_i0_trigger_hit_r}; // @[Mux.scala 27:72]
  wire [3:0] _T_251 = _T_247 | _GEN_12; // @[Mux.scala 27:72]
  wire [3:0] _GEN_13 = {{2'd0}, _T_249}; // @[Mux.scala 27:72]
  wire [3:0] _T_252 = _T_251 | _GEN_13; // @[Mux.scala 27:72]
  wire [3:0] mscause_type = _T_252 | _T_250; // @[Mux.scala 27:72]
  wire  _T_256 = wr_mscause_r & _T_17; // @[el2_dec_tlu_ctl.scala 1752:38]
  wire  _T_259 = ~wr_mscause_r; // @[el2_dec_tlu_ctl.scala 1753:25]
  wire  _T_261 = _T_259 & _T_17; // @[el2_dec_tlu_ctl.scala 1753:39]
  wire [3:0] _T_263 = io_exc_or_int_valid_r ? mscause_type : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_264 = _T_256 ? io_dec_csr_wrdata_r[3:0] : 4'h0; // @[Mux.scala 27:72]
  reg [3:0] mscause; // @[el2_dec_tlu_ctl.scala 1755:47]
  wire [3:0] _T_265 = _T_261 ? mscause : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_266 = _T_263 | _T_264; // @[Mux.scala 27:72]
  wire  _T_270 = io_dec_csr_wraddr_r == 12'h343; // @[el2_dec_tlu_ctl.scala 1762:69]
  wire  wr_mtval_r = io_dec_csr_wen_r_mod & _T_270; // @[el2_dec_tlu_ctl.scala 1762:40]
  wire  _T_271 = ~io_inst_acc_second_r; // @[el2_dec_tlu_ctl.scala 1763:83]
  wire  _T_272 = io_inst_acc_r & _T_271; // @[el2_dec_tlu_ctl.scala 1763:81]
  wire  _T_273 = io_ebreak_r | _T_272; // @[el2_dec_tlu_ctl.scala 1763:64]
  wire  _T_274 = _T_273 | io_mepc_trigger_hit_sel_pc_r; // @[el2_dec_tlu_ctl.scala 1763:106]
  wire  _T_275 = io_exc_or_int_valid_r & _T_274; // @[el2_dec_tlu_ctl.scala 1763:49]
  wire  mtval_capture_pc_r = _T_275 & _T_215; // @[el2_dec_tlu_ctl.scala 1763:138]
  wire  _T_277 = io_inst_acc_r & io_inst_acc_second_r; // @[el2_dec_tlu_ctl.scala 1764:72]
  wire  _T_278 = io_exc_or_int_valid_r & _T_277; // @[el2_dec_tlu_ctl.scala 1764:55]
  wire  mtval_capture_pc_plus2_r = _T_278 & _T_215; // @[el2_dec_tlu_ctl.scala 1764:96]
  wire  _T_280 = io_exc_or_int_valid_r & io_illegal_r; // @[el2_dec_tlu_ctl.scala 1765:51]
  wire  mtval_capture_inst_r = _T_280 & _T_215; // @[el2_dec_tlu_ctl.scala 1765:66]
  wire  _T_282 = io_exc_or_int_valid_r & io_lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 1766:50]
  wire  mtval_capture_lsu_r = _T_282 & _T_215; // @[el2_dec_tlu_ctl.scala 1766:71]
  wire  _T_284 = ~mtval_capture_pc_r; // @[el2_dec_tlu_ctl.scala 1767:46]
  wire  _T_285 = io_exc_or_int_valid_r & _T_284; // @[el2_dec_tlu_ctl.scala 1767:44]
  wire  _T_286 = ~mtval_capture_inst_r; // @[el2_dec_tlu_ctl.scala 1767:68]
  wire  _T_287 = _T_285 & _T_286; // @[el2_dec_tlu_ctl.scala 1767:66]
  wire  _T_288 = ~mtval_capture_lsu_r; // @[el2_dec_tlu_ctl.scala 1767:92]
  wire  _T_289 = _T_287 & _T_288; // @[el2_dec_tlu_ctl.scala 1767:90]
  wire  _T_290 = ~io_mepc_trigger_hit_sel_pc_r; // @[el2_dec_tlu_ctl.scala 1767:115]
  wire  mtval_clear_r = _T_289 & _T_290; // @[el2_dec_tlu_ctl.scala 1767:113]
  wire [31:0] _T_292 = {pc_r,1'h0}; // @[Cat.scala 29:58]
  wire [30:0] _T_295 = pc_r + 31'h1; // @[el2_dec_tlu_ctl.scala 1772:83]
  wire [31:0] _T_296 = {_T_295,1'h0}; // @[Cat.scala 29:58]
  wire  _T_299 = ~io_interrupt_valid_r; // @[el2_dec_tlu_ctl.scala 1775:18]
  wire  _T_300 = wr_mtval_r & _T_299; // @[el2_dec_tlu_ctl.scala 1775:16]
  wire  _T_303 = ~wr_mtval_r; // @[el2_dec_tlu_ctl.scala 1776:20]
  wire  _T_304 = _T_215 & _T_303; // @[el2_dec_tlu_ctl.scala 1776:18]
  wire  _T_306 = _T_304 & _T_284; // @[el2_dec_tlu_ctl.scala 1776:32]
  wire  _T_308 = _T_306 & _T_286; // @[el2_dec_tlu_ctl.scala 1776:54]
  wire  _T_309 = ~mtval_clear_r; // @[el2_dec_tlu_ctl.scala 1776:80]
  wire  _T_310 = _T_308 & _T_309; // @[el2_dec_tlu_ctl.scala 1776:78]
  wire  _T_312 = _T_310 & _T_288; // @[el2_dec_tlu_ctl.scala 1776:95]
  wire [31:0] _T_314 = mtval_capture_pc_r ? _T_292 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_315 = mtval_capture_pc_plus2_r ? _T_296 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_316 = mtval_capture_inst_r ? io_dec_illegal_inst : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_317 = mtval_capture_lsu_r ? io_lsu_error_pkt_addr_r : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_318 = _T_300 ? io_dec_csr_wrdata_r : 32'h0; // @[Mux.scala 27:72]
  reg [31:0] mtval; // @[el2_dec_tlu_ctl.scala 1778:46]
  wire [31:0] _T_319 = _T_312 ? mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_320 = _T_314 | _T_315; // @[Mux.scala 27:72]
  wire [31:0] _T_321 = _T_320 | _T_316; // @[Mux.scala 27:72]
  wire [31:0] _T_322 = _T_321 | _T_317; // @[Mux.scala 27:72]
  wire [31:0] _T_323 = _T_322 | _T_318; // @[Mux.scala 27:72]
  wire  _T_327 = io_dec_csr_wraddr_r == 12'h7f8; // @[el2_dec_tlu_ctl.scala 1793:68]
  reg [8:0] mcgc; // @[el2_lib.scala 514:16]
  wire  _T_339 = io_dec_csr_wraddr_r == 12'h7f9; // @[el2_dec_tlu_ctl.scala 1823:68]
  reg [14:0] mfdc_int; // @[el2_lib.scala 514:16]
  wire [2:0] _T_343 = ~io_dec_csr_wrdata_r[18:16]; // @[el2_dec_tlu_ctl.scala 1832:20]
  wire  _T_346 = ~io_dec_csr_wrdata_r[6]; // @[el2_dec_tlu_ctl.scala 1832:75]
  wire [6:0] _T_348 = {_T_346,io_dec_csr_wrdata_r[5:0]}; // @[Cat.scala 29:58]
  wire [7:0] _T_349 = {_T_343,io_dec_csr_wrdata_r[11:7]}; // @[Cat.scala 29:58]
  wire [2:0] _T_352 = ~mfdc_int[14:12]; // @[el2_dec_tlu_ctl.scala 1833:20]
  wire  _T_355 = ~mfdc_int[6]; // @[el2_dec_tlu_ctl.scala 1833:63]
  wire [18:0] mfdc = {_T_352,4'h0,mfdc_int[11:7],_T_355,mfdc_int[5:0]}; // @[Cat.scala 29:58]
  wire  _T_369 = io_dec_csr_wraddr_r == 12'h7c2; // @[el2_dec_tlu_ctl.scala 1856:77]
  wire  _T_370 = io_dec_csr_wen_r_mod & _T_369; // @[el2_dec_tlu_ctl.scala 1856:48]
  wire  _T_372 = _T_370 & _T_299; // @[el2_dec_tlu_ctl.scala 1856:87]
  wire  _T_373 = ~io_take_ext_int_start; // @[el2_dec_tlu_ctl.scala 1856:113]
  wire  _T_376 = io_dec_csr_wraddr_r == 12'h7c0; // @[el2_dec_tlu_ctl.scala 1863:68]
  wire  _T_380 = ~io_dec_csr_wrdata_r[31]; // @[el2_dec_tlu_ctl.scala 1866:71]
  wire  _T_381 = io_dec_csr_wrdata_r[30] & _T_380; // @[el2_dec_tlu_ctl.scala 1866:69]
  wire  _T_385 = ~io_dec_csr_wrdata_r[29]; // @[el2_dec_tlu_ctl.scala 1867:73]
  wire  _T_386 = io_dec_csr_wrdata_r[28] & _T_385; // @[el2_dec_tlu_ctl.scala 1867:71]
  wire  _T_390 = ~io_dec_csr_wrdata_r[27]; // @[el2_dec_tlu_ctl.scala 1868:73]
  wire  _T_391 = io_dec_csr_wrdata_r[26] & _T_390; // @[el2_dec_tlu_ctl.scala 1868:71]
  wire  _T_395 = ~io_dec_csr_wrdata_r[25]; // @[el2_dec_tlu_ctl.scala 1869:73]
  wire  _T_396 = io_dec_csr_wrdata_r[24] & _T_395; // @[el2_dec_tlu_ctl.scala 1869:71]
  wire  _T_400 = ~io_dec_csr_wrdata_r[23]; // @[el2_dec_tlu_ctl.scala 1870:73]
  wire  _T_401 = io_dec_csr_wrdata_r[22] & _T_400; // @[el2_dec_tlu_ctl.scala 1870:71]
  wire  _T_405 = ~io_dec_csr_wrdata_r[21]; // @[el2_dec_tlu_ctl.scala 1871:73]
  wire  _T_406 = io_dec_csr_wrdata_r[20] & _T_405; // @[el2_dec_tlu_ctl.scala 1871:71]
  wire  _T_410 = ~io_dec_csr_wrdata_r[19]; // @[el2_dec_tlu_ctl.scala 1872:73]
  wire  _T_411 = io_dec_csr_wrdata_r[18] & _T_410; // @[el2_dec_tlu_ctl.scala 1872:71]
  wire  _T_415 = ~io_dec_csr_wrdata_r[17]; // @[el2_dec_tlu_ctl.scala 1873:73]
  wire  _T_416 = io_dec_csr_wrdata_r[16] & _T_415; // @[el2_dec_tlu_ctl.scala 1873:71]
  wire  _T_420 = ~io_dec_csr_wrdata_r[15]; // @[el2_dec_tlu_ctl.scala 1874:73]
  wire  _T_421 = io_dec_csr_wrdata_r[14] & _T_420; // @[el2_dec_tlu_ctl.scala 1874:71]
  wire  _T_425 = ~io_dec_csr_wrdata_r[13]; // @[el2_dec_tlu_ctl.scala 1875:73]
  wire  _T_426 = io_dec_csr_wrdata_r[12] & _T_425; // @[el2_dec_tlu_ctl.scala 1875:71]
  wire  _T_430 = ~io_dec_csr_wrdata_r[11]; // @[el2_dec_tlu_ctl.scala 1876:73]
  wire  _T_431 = io_dec_csr_wrdata_r[10] & _T_430; // @[el2_dec_tlu_ctl.scala 1876:71]
  wire  _T_435 = ~io_dec_csr_wrdata_r[9]; // @[el2_dec_tlu_ctl.scala 1877:73]
  wire  _T_436 = io_dec_csr_wrdata_r[8] & _T_435; // @[el2_dec_tlu_ctl.scala 1877:70]
  wire  _T_440 = ~io_dec_csr_wrdata_r[7]; // @[el2_dec_tlu_ctl.scala 1878:73]
  wire  _T_441 = io_dec_csr_wrdata_r[6] & _T_440; // @[el2_dec_tlu_ctl.scala 1878:70]
  wire  _T_445 = ~io_dec_csr_wrdata_r[5]; // @[el2_dec_tlu_ctl.scala 1879:73]
  wire  _T_446 = io_dec_csr_wrdata_r[4] & _T_445; // @[el2_dec_tlu_ctl.scala 1879:70]
  wire  _T_450 = ~io_dec_csr_wrdata_r[3]; // @[el2_dec_tlu_ctl.scala 1880:73]
  wire  _T_451 = io_dec_csr_wrdata_r[2] & _T_450; // @[el2_dec_tlu_ctl.scala 1880:70]
  wire  _T_456 = io_dec_csr_wrdata_r[0] & _T_512; // @[el2_dec_tlu_ctl.scala 1881:70]
  wire [7:0] _T_463 = {io_dec_csr_wrdata_r[7],_T_441,io_dec_csr_wrdata_r[5],_T_446,io_dec_csr_wrdata_r[3],_T_451,io_dec_csr_wrdata_r[1],_T_456}; // @[Cat.scala 29:58]
  wire [15:0] _T_471 = {io_dec_csr_wrdata_r[15],_T_421,io_dec_csr_wrdata_r[13],_T_426,io_dec_csr_wrdata_r[11],_T_431,io_dec_csr_wrdata_r[9],_T_436,_T_463}; // @[Cat.scala 29:58]
  wire [7:0] _T_478 = {io_dec_csr_wrdata_r[23],_T_401,io_dec_csr_wrdata_r[21],_T_406,io_dec_csr_wrdata_r[19],_T_411,io_dec_csr_wrdata_r[17],_T_416}; // @[Cat.scala 29:58]
  wire [15:0] _T_486 = {io_dec_csr_wrdata_r[31],_T_381,io_dec_csr_wrdata_r[29],_T_386,io_dec_csr_wrdata_r[27],_T_391,io_dec_csr_wrdata_r[25],_T_396,_T_478}; // @[Cat.scala 29:58]
  reg [31:0] mrac; // @[el2_lib.scala 514:16]
  wire  _T_489 = io_dec_csr_wraddr_r == 12'hbc0; // @[el2_dec_tlu_ctl.scala 1894:69]
  wire  wr_mdeau_r = io_dec_csr_wen_r_mod & _T_489; // @[el2_dec_tlu_ctl.scala 1894:40]
  wire  _T_490 = ~wr_mdeau_r; // @[el2_dec_tlu_ctl.scala 1904:59]
  wire  _T_491 = io_mdseac_locked_f & _T_490; // @[el2_dec_tlu_ctl.scala 1904:57]
  wire  _T_493 = io_lsu_imprecise_error_store_any | io_lsu_imprecise_error_load_any; // @[el2_dec_tlu_ctl.scala 1906:49]
  wire  _T_494 = ~io_nmi_int_detected_f; // @[el2_dec_tlu_ctl.scala 1906:86]
  wire  _T_495 = _T_493 & _T_494; // @[el2_dec_tlu_ctl.scala 1906:84]
  wire  _T_496 = ~io_mdseac_locked_f; // @[el2_dec_tlu_ctl.scala 1906:111]
  wire  mdseac_en = _T_495 & _T_496; // @[el2_dec_tlu_ctl.scala 1906:109]
  reg [31:0] mdseac; // @[el2_lib.scala 514:16]
  wire  _T_502 = wr_mpmc_r & io_dec_csr_wrdata_r[0]; // @[el2_dec_tlu_ctl.scala 1921:30]
  wire  _T_503 = ~io_internal_dbg_halt_mode_f2; // @[el2_dec_tlu_ctl.scala 1921:57]
  wire  _T_504 = _T_502 & _T_503; // @[el2_dec_tlu_ctl.scala 1921:55]
  wire  _T_505 = ~io_ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 1921:89]
  wire  _T_518 = io_dec_csr_wrdata_r[31:27] > 5'h1a; // @[el2_dec_tlu_ctl.scala 1939:48]
  wire [4:0] csr_sat = _T_518 ? 5'h1a : io_dec_csr_wrdata_r[31:27]; // @[el2_dec_tlu_ctl.scala 1939:19]
  wire  _T_521 = io_dec_csr_wraddr_r == 12'h7f0; // @[el2_dec_tlu_ctl.scala 1941:70]
  wire  wr_micect_r = io_dec_csr_wen_r_mod & _T_521; // @[el2_dec_tlu_ctl.scala 1941:41]
  wire [26:0] _T_522 = {26'h0,io_ic_perr_r_d1}; // @[Cat.scala 29:58]
  wire [31:0] _GEN_14 = {{5'd0}, _T_522}; // @[el2_dec_tlu_ctl.scala 1942:23]
  wire [31:0] _T_524 = micect + _GEN_14; // @[el2_dec_tlu_ctl.scala 1942:23]
  wire [31:0] _T_527 = {csr_sat,io_dec_csr_wrdata_r[26:0]}; // @[Cat.scala 29:58]
  wire [26:0] micect_inc = _T_524[26:0]; // @[el2_dec_tlu_ctl.scala 1942:13]
  wire [31:0] _T_529 = {micect[31:27],micect_inc}; // @[Cat.scala 29:58]
  wire  _T_540 = io_dec_csr_wraddr_r == 12'h7f1; // @[el2_dec_tlu_ctl.scala 1956:76]
  wire  wr_miccmect_r = io_dec_csr_wen_r_mod & _T_540; // @[el2_dec_tlu_ctl.scala 1956:47]
  wire  _T_542 = io_iccm_sbecc_r_d1 | io_iccm_dma_sb_error; // @[el2_dec_tlu_ctl.scala 1957:70]
  wire [26:0] _T_543 = {26'h0,_T_542}; // @[Cat.scala 29:58]
  wire [26:0] miccmect_inc = miccmect[26:0] + _T_543; // @[el2_dec_tlu_ctl.scala 1957:33]
  wire [31:0] _T_550 = {miccmect[31:27],miccmect_inc}; // @[Cat.scala 29:58]
  wire  _T_551 = wr_miccmect_r | io_iccm_sbecc_r_d1; // @[el2_dec_tlu_ctl.scala 1960:48]
  wire  _T_562 = io_dec_csr_wraddr_r == 12'h7f2; // @[el2_dec_tlu_ctl.scala 1970:76]
  wire  wr_mdccmect_r = io_dec_csr_wen_r_mod & _T_562; // @[el2_dec_tlu_ctl.scala 1970:47]
  wire [26:0] _T_564 = {26'h0,io_lsu_single_ecc_error_r_d1}; // @[Cat.scala 29:58]
  wire [26:0] mdccmect_inc = mdccmect[26:0] + _T_564; // @[el2_dec_tlu_ctl.scala 1971:33]
  wire [31:0] _T_571 = {mdccmect[31:27],mdccmect_inc}; // @[Cat.scala 29:58]
  wire  _T_582 = io_dec_csr_wraddr_r == 12'h7ce; // @[el2_dec_tlu_ctl.scala 1986:69]
  wire  wr_mfdht_r = io_dec_csr_wen_r_mod & _T_582; // @[el2_dec_tlu_ctl.scala 1986:40]
  reg [5:0] mfdht; // @[el2_dec_tlu_ctl.scala 1990:43]
  wire  _T_587 = io_dec_csr_wraddr_r == 12'h7cf; // @[el2_dec_tlu_ctl.scala 1999:69]
  wire  wr_mfdhs_r = io_dec_csr_wen_r_mod & _T_587; // @[el2_dec_tlu_ctl.scala 1999:40]
  wire  _T_590 = ~io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 2002:43]
  wire  _T_591 = io_dbg_tlu_halted & _T_590; // @[el2_dec_tlu_ctl.scala 2002:41]
  wire  _T_593 = ~io_lsu_idle_any_f; // @[el2_dec_tlu_ctl.scala 2002:78]
  wire  _T_594 = ~io_ifu_miss_state_idle_f; // @[el2_dec_tlu_ctl.scala 2002:98]
  wire [1:0] _T_595 = {_T_593,_T_594}; // @[Cat.scala 29:58]
  reg [1:0] mfdhs; // @[Reg.scala 27:20]
  wire  _T_597 = wr_mfdhs_r | io_dbg_tlu_halted; // @[el2_dec_tlu_ctl.scala 2004:71]
  reg [31:0] force_halt_ctr_f; // @[Reg.scala 27:20]
  wire [31:0] _T_602 = force_halt_ctr_f + 32'h1; // @[el2_dec_tlu_ctl.scala 2006:74]
  wire [62:0] _T_609 = 63'hffffffff << mfdht[5:1]; // @[el2_dec_tlu_ctl.scala 2011:71]
  wire [62:0] _GEN_15 = {{31'd0}, force_halt_ctr_f}; // @[el2_dec_tlu_ctl.scala 2011:48]
  wire [62:0] _T_610 = _GEN_15 & _T_609; // @[el2_dec_tlu_ctl.scala 2011:48]
  wire  _T_611 = |_T_610; // @[el2_dec_tlu_ctl.scala 2011:87]
  wire  _T_614 = io_dec_csr_wraddr_r == 12'hbc8; // @[el2_dec_tlu_ctl.scala 2019:69]
  reg [21:0] meivt; // @[el2_lib.scala 514:16]
  wire  _T_634 = io_dec_csr_wraddr_r == 12'hbca; // @[el2_dec_tlu_ctl.scala 2070:69]
  wire  _T_635 = io_dec_csr_wen_r_mod & _T_634; // @[el2_dec_tlu_ctl.scala 2070:40]
  wire  wr_meicpct_r = _T_635 | io_take_ext_int_start; // @[el2_dec_tlu_ctl.scala 2070:83]
  reg [7:0] meihap; // @[el2_lib.scala 514:16]
  wire [31:0] _T_619 = {meivt,meihap,2'h0}; // @[Cat.scala 29:58]
  wire  _T_621 = io_dec_csr_wraddr_r == 12'hbcc; // @[el2_dec_tlu_ctl.scala 2043:72]
  wire  wr_meicurpl_r = io_dec_csr_wen_r_mod & _T_621; // @[el2_dec_tlu_ctl.scala 2043:43]
  reg [3:0] meicurpl; // @[el2_dec_tlu_ctl.scala 2046:46]
  wire  _T_626 = io_dec_csr_wraddr_r == 12'hbcb; // @[el2_dec_tlu_ctl.scala 2058:73]
  wire  _T_627 = io_dec_csr_wen_r_mod & _T_626; // @[el2_dec_tlu_ctl.scala 2058:44]
  wire  wr_meicidpl_r = _T_627 | io_take_ext_int_start; // @[el2_dec_tlu_ctl.scala 2058:88]
  reg [3:0] meicidpl; // @[el2_dec_tlu_ctl.scala 2063:44]
  wire  _T_638 = io_dec_csr_wraddr_r == 12'hbc9; // @[el2_dec_tlu_ctl.scala 2079:69]
  wire  wr_meipt_r = io_dec_csr_wen_r_mod & _T_638; // @[el2_dec_tlu_ctl.scala 2079:40]
  reg [3:0] meipt; // @[el2_dec_tlu_ctl.scala 2082:43]
  wire  _T_642 = io_trigger_hit_r_d1 & io_dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 2110:89]
  wire  trigger_hit_for_dscr_cause_r_d1 = io_trigger_hit_dmode_r_d1 | _T_642; // @[el2_dec_tlu_ctl.scala 2110:66]
  wire  _T_643 = ~io_ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 2113:31]
  wire  _T_644 = io_dcsr_single_step_done_f & _T_643; // @[el2_dec_tlu_ctl.scala 2113:29]
  wire  _T_645 = ~trigger_hit_for_dscr_cause_r_d1; // @[el2_dec_tlu_ctl.scala 2113:63]
  wire  _T_646 = _T_644 & _T_645; // @[el2_dec_tlu_ctl.scala 2113:61]
  wire  _T_647 = ~io_debug_halt_req; // @[el2_dec_tlu_ctl.scala 2113:98]
  wire  _T_648 = _T_646 & _T_647; // @[el2_dec_tlu_ctl.scala 2113:96]
  wire  _T_651 = io_debug_halt_req & _T_643; // @[el2_dec_tlu_ctl.scala 2114:46]
  wire  _T_653 = _T_651 & _T_645; // @[el2_dec_tlu_ctl.scala 2114:78]
  wire  _T_656 = io_ebreak_to_debug_mode_r_d1 & _T_645; // @[el2_dec_tlu_ctl.scala 2115:75]
  wire [2:0] _T_659 = _T_648 ? 3'h4 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_660 = _T_653 ? 3'h3 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_661 = _T_656 ? 3'h1 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_662 = trigger_hit_for_dscr_cause_r_d1 ? 3'h2 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_663 = _T_659 | _T_660; // @[Mux.scala 27:72]
  wire [2:0] _T_664 = _T_663 | _T_661; // @[Mux.scala 27:72]
  wire [2:0] dcsr_cause = _T_664 | _T_662; // @[Mux.scala 27:72]
  wire  _T_666 = io_allow_dbg_halt_csr_write & io_dec_csr_wen_r_mod; // @[el2_dec_tlu_ctl.scala 2118:46]
  wire  _T_668 = io_dec_csr_wraddr_r == 12'h7b0; // @[el2_dec_tlu_ctl.scala 2118:98]
  wire  wr_dcsr_r = _T_666 & _T_668; // @[el2_dec_tlu_ctl.scala 2118:69]
  wire  _T_670 = io_dcsr[8:6] == 3'h3; // @[el2_dec_tlu_ctl.scala 2124:75]
  wire  dcsr_cause_upgradeable = io_internal_dbg_halt_mode_f & _T_670; // @[el2_dec_tlu_ctl.scala 2124:59]
  wire  _T_671 = ~io_dbg_tlu_halted; // @[el2_dec_tlu_ctl.scala 2125:59]
  wire  _T_672 = _T_671 | dcsr_cause_upgradeable; // @[el2_dec_tlu_ctl.scala 2125:78]
  wire  enter_debug_halt_req_le = io_enter_debug_halt_req & _T_672; // @[el2_dec_tlu_ctl.scala 2125:56]
  wire  nmi_in_debug_mode = io_nmi_int_detected_f & io_internal_dbg_halt_mode_f; // @[el2_dec_tlu_ctl.scala 2127:48]
  wire [15:0] _T_678 = {io_dcsr[15:9],dcsr_cause,io_dcsr[5:2],2'h3}; // @[Cat.scala 29:58]
  wire  _T_684 = nmi_in_debug_mode | io_dcsr[3]; // @[el2_dec_tlu_ctl.scala 2129:145]
  wire [15:0] _T_693 = {io_dec_csr_wrdata_r[15],3'h0,io_dec_csr_wrdata_r[11:10],1'h0,io_dcsr[8:6],2'h0,_T_684,io_dec_csr_wrdata_r[2],2'h3}; // @[Cat.scala 29:58]
  wire [15:0] _T_698 = {io_dcsr[15:4],nmi_in_debug_mode,io_dcsr[2],2'h3}; // @[Cat.scala 29:58]
  wire  _T_700 = enter_debug_halt_req_le | wr_dcsr_r; // @[el2_dec_tlu_ctl.scala 2131:54]
  wire  _T_701 = _T_700 | io_internal_dbg_halt_mode; // @[el2_dec_tlu_ctl.scala 2131:66]
  reg [15:0] _T_704; // @[el2_lib.scala 514:16]
  wire  _T_707 = io_dec_csr_wraddr_r == 12'h7b1; // @[el2_dec_tlu_ctl.scala 2139:97]
  wire  wr_dpc_r = _T_666 & _T_707; // @[el2_dec_tlu_ctl.scala 2139:68]
  wire  _T_710 = ~io_request_debug_mode_done; // @[el2_dec_tlu_ctl.scala 2140:67]
  wire  dpc_capture_npc = _T_591 & _T_710; // @[el2_dec_tlu_ctl.scala 2140:65]
  wire  _T_711 = ~io_request_debug_mode_r; // @[el2_dec_tlu_ctl.scala 2144:21]
  wire  _T_712 = ~dpc_capture_npc; // @[el2_dec_tlu_ctl.scala 2144:39]
  wire  _T_713 = _T_711 & _T_712; // @[el2_dec_tlu_ctl.scala 2144:37]
  wire  _T_714 = _T_713 & wr_dpc_r; // @[el2_dec_tlu_ctl.scala 2144:56]
  wire  _T_719 = _T_711 & dpc_capture_npc; // @[el2_dec_tlu_ctl.scala 2146:49]
  wire [30:0] _T_721 = _T_714 ? io_dec_csr_wrdata_r[31:1] : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_722 = io_request_debug_mode_r ? pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_723 = _T_719 ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_724 = _T_721 | _T_722; // @[Mux.scala 27:72]
  wire  _T_726 = wr_dpc_r | io_request_debug_mode_r; // @[el2_dec_tlu_ctl.scala 2148:36]
  reg [30:0] _T_729; // @[el2_lib.scala 514:16]
  wire [2:0] _T_733 = {io_dec_csr_wrdata_r[24],io_dec_csr_wrdata_r[21:20]}; // @[Cat.scala 29:58]
  wire  _T_736 = io_dec_csr_wraddr_r == 12'h7c8; // @[el2_dec_tlu_ctl.scala 2163:102]
  reg [16:0] dicawics; // @[el2_lib.scala 514:16]
  wire  _T_740 = io_dec_csr_wraddr_r == 12'h7c9; // @[el2_dec_tlu_ctl.scala 2181:100]
  wire  wr_dicad0_r = _T_666 & _T_740; // @[el2_dec_tlu_ctl.scala 2181:71]
  reg [70:0] dicad0; // @[el2_lib.scala 514:16]
  wire  _T_746 = io_dec_csr_wraddr_r == 12'h7cc; // @[el2_dec_tlu_ctl.scala 2194:101]
  wire  wr_dicad0h_r = _T_666 & _T_746; // @[el2_dec_tlu_ctl.scala 2194:72]
  reg [31:0] dicad0h; // @[el2_lib.scala 514:16]
  wire  _T_754 = io_dec_csr_wraddr_r == 12'h7ca; // @[el2_dec_tlu_ctl.scala 2206:100]
  wire  _T_755 = _T_666 & _T_754; // @[el2_dec_tlu_ctl.scala 2206:71]
  wire  _T_759 = _T_755 | io_ifu_ic_debug_rd_data_valid; // @[el2_dec_tlu_ctl.scala 2210:78]
  reg [31:0] _T_761; // @[Reg.scala 27:20]
  wire [31:0] dicad1 = {25'h0,_T_761[6:0]}; // @[Cat.scala 29:58]
  wire [38:0] _T_766 = {dicad1[6:0],dicad0h}; // @[Cat.scala 29:58]
  wire  _T_768 = io_allow_dbg_halt_csr_write & io_dec_csr_any_unq_d; // @[el2_dec_tlu_ctl.scala 2238:52]
  wire  _T_769 = _T_768 & io_dec_i0_decode_d; // @[el2_dec_tlu_ctl.scala 2238:75]
  wire  _T_770 = ~io_dec_csr_wen_unq_d; // @[el2_dec_tlu_ctl.scala 2238:98]
  wire  _T_771 = _T_769 & _T_770; // @[el2_dec_tlu_ctl.scala 2238:96]
  wire  _T_773 = io_dec_csr_rdaddr_d == 12'h7cb; // @[el2_dec_tlu_ctl.scala 2238:149]
  wire  _T_776 = io_dec_csr_wraddr_r == 12'h7cb; // @[el2_dec_tlu_ctl.scala 2239:104]
  reg  icache_rd_valid_f; // @[el2_dec_tlu_ctl.scala 2241:58]
  reg  icache_wr_valid_f; // @[el2_dec_tlu_ctl.scala 2242:58]
  wire  _T_778 = io_dec_csr_wraddr_r == 12'h7a0; // @[el2_dec_tlu_ctl.scala 2253:69]
  wire  wr_mtsel_r = io_dec_csr_wen_r_mod & _T_778; // @[el2_dec_tlu_ctl.scala 2253:40]
  reg [1:0] mtsel; // @[el2_dec_tlu_ctl.scala 2256:43]
  wire  tdata_load = io_dec_csr_wrdata_r[0] & _T_410; // @[el2_dec_tlu_ctl.scala 2291:42]
  wire  tdata_opcode = io_dec_csr_wrdata_r[2] & _T_410; // @[el2_dec_tlu_ctl.scala 2293:44]
  wire  _T_789 = io_dec_csr_wrdata_r[27] & io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 2295:46]
  wire  tdata_action = _T_789 & io_dec_csr_wrdata_r[12]; // @[el2_dec_tlu_ctl.scala 2295:69]
  wire [9:0] tdata_wrdata_r = {_T_789,io_dec_csr_wrdata_r[20:19],tdata_action,io_dec_csr_wrdata_r[11],io_dec_csr_wrdata_r[7:6],tdata_opcode,io_dec_csr_wrdata_r[1],tdata_load}; // @[Cat.scala 29:58]
  wire  _T_804 = io_dec_csr_wraddr_r == 12'h7a1; // @[el2_dec_tlu_ctl.scala 2301:99]
  wire  _T_805 = io_dec_csr_wen_r_mod & _T_804; // @[el2_dec_tlu_ctl.scala 2301:70]
  wire  _T_806 = mtsel == 2'h0; // @[el2_dec_tlu_ctl.scala 2301:121]
  wire  _T_807 = _T_805 & _T_806; // @[el2_dec_tlu_ctl.scala 2301:112]
  wire  _T_809 = ~io_mtdata1_t_0[9]; // @[el2_dec_tlu_ctl.scala 2301:138]
  wire  _T_810 = _T_809 | io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 2301:170]
  wire  wr_mtdata1_t_r_0 = _T_807 & _T_810; // @[el2_dec_tlu_ctl.scala 2301:135]
  wire  _T_818 = ~io_mtdata1_t_1[9]; // @[el2_dec_tlu_ctl.scala 2301:138]
  wire  _T_819 = _T_818 | io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 2301:170]
  wire  wr_mtdata1_t_r_1 = _T_807 & _T_819; // @[el2_dec_tlu_ctl.scala 2301:135]
  wire  _T_827 = ~io_mtdata1_t_2[9]; // @[el2_dec_tlu_ctl.scala 2301:138]
  wire  _T_828 = _T_827 | io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 2301:170]
  wire  wr_mtdata1_t_r_2 = _T_807 & _T_828; // @[el2_dec_tlu_ctl.scala 2301:135]
  wire  _T_836 = ~io_mtdata1_t_3[9]; // @[el2_dec_tlu_ctl.scala 2301:138]
  wire  _T_837 = _T_836 | io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 2301:170]
  wire  wr_mtdata1_t_r_3 = _T_807 & _T_837; // @[el2_dec_tlu_ctl.scala 2301:135]
  wire  _T_843 = io_update_hit_bit_r[0] | io_mtdata1_t_0[8]; // @[el2_dec_tlu_ctl.scala 2302:139]
  wire [9:0] _T_846 = {io_mtdata1_t_0[9],_T_843,io_mtdata1_t_0[7:0]}; // @[Cat.scala 29:58]
  wire  _T_852 = io_update_hit_bit_r[1] | io_mtdata1_t_1[8]; // @[el2_dec_tlu_ctl.scala 2302:139]
  wire [9:0] _T_855 = {io_mtdata1_t_1[9],_T_852,io_mtdata1_t_1[7:0]}; // @[Cat.scala 29:58]
  wire  _T_861 = io_update_hit_bit_r[2] | io_mtdata1_t_2[8]; // @[el2_dec_tlu_ctl.scala 2302:139]
  wire [9:0] _T_864 = {io_mtdata1_t_2[9],_T_861,io_mtdata1_t_2[7:0]}; // @[Cat.scala 29:58]
  wire  _T_870 = io_update_hit_bit_r[3] | io_mtdata1_t_3[8]; // @[el2_dec_tlu_ctl.scala 2302:139]
  wire [9:0] _T_873 = {io_mtdata1_t_3[9],_T_870,io_mtdata1_t_3[7:0]}; // @[Cat.scala 29:58]
  reg [9:0] _T_875; // @[el2_dec_tlu_ctl.scala 2304:74]
  reg [9:0] _T_876; // @[el2_dec_tlu_ctl.scala 2304:74]
  reg [9:0] _T_877; // @[el2_dec_tlu_ctl.scala 2304:74]
  reg [9:0] _T_878; // @[el2_dec_tlu_ctl.scala 2304:74]
  wire [31:0] _T_893 = {4'h2,io_mtdata1_t_0[9],6'h1f,io_mtdata1_t_0[8:7],6'h0,io_mtdata1_t_0[6:5],3'h0,io_mtdata1_t_0[4:3],3'h0,io_mtdata1_t_0[2:0]}; // @[Cat.scala 29:58]
  wire  _T_894 = mtsel == 2'h1; // @[el2_dec_tlu_ctl.scala 2307:58]
  wire [31:0] _T_908 = {4'h2,io_mtdata1_t_1[9],6'h1f,io_mtdata1_t_1[8:7],6'h0,io_mtdata1_t_1[6:5],3'h0,io_mtdata1_t_1[4:3],3'h0,io_mtdata1_t_1[2:0]}; // @[Cat.scala 29:58]
  wire  _T_909 = mtsel == 2'h2; // @[el2_dec_tlu_ctl.scala 2307:58]
  wire [31:0] _T_923 = {4'h2,io_mtdata1_t_2[9],6'h1f,io_mtdata1_t_2[8:7],6'h0,io_mtdata1_t_2[6:5],3'h0,io_mtdata1_t_2[4:3],3'h0,io_mtdata1_t_2[2:0]}; // @[Cat.scala 29:58]
  wire  _T_924 = mtsel == 2'h3; // @[el2_dec_tlu_ctl.scala 2307:58]
  wire [31:0] _T_938 = {4'h2,io_mtdata1_t_3[9],6'h1f,io_mtdata1_t_3[8:7],6'h0,io_mtdata1_t_3[6:5],3'h0,io_mtdata1_t_3[4:3],3'h0,io_mtdata1_t_3[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_939 = _T_806 ? _T_893 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_940 = _T_894 ? _T_908 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_941 = _T_909 ? _T_923 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_942 = _T_924 ? _T_938 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_943 = _T_939 | _T_940; // @[Mux.scala 27:72]
  wire [31:0] _T_944 = _T_943 | _T_941; // @[Mux.scala 27:72]
  wire [31:0] mtdata1_tsel_out = _T_944 | _T_942; // @[Mux.scala 27:72]
  wire  _T_971 = io_dec_csr_wraddr_r == 12'h7a2; // @[el2_dec_tlu_ctl.scala 2321:98]
  wire  _T_972 = io_dec_csr_wen_r_mod & _T_971; // @[el2_dec_tlu_ctl.scala 2321:69]
  wire  _T_974 = _T_972 & _T_806; // @[el2_dec_tlu_ctl.scala 2321:111]
  wire  _T_983 = _T_972 & _T_894; // @[el2_dec_tlu_ctl.scala 2321:111]
  wire  _T_992 = _T_972 & _T_909; // @[el2_dec_tlu_ctl.scala 2321:111]
  wire  _T_1001 = _T_972 & _T_924; // @[el2_dec_tlu_ctl.scala 2321:111]
  reg [31:0] mtdata2_t_0; // @[el2_lib.scala 514:16]
  reg [31:0] mtdata2_t_1; // @[el2_lib.scala 514:16]
  reg [31:0] mtdata2_t_2; // @[el2_lib.scala 514:16]
  reg [31:0] mtdata2_t_3; // @[el2_lib.scala 514:16]
  wire [31:0] _T_1018 = _T_806 ? mtdata2_t_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1019 = _T_894 ? mtdata2_t_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1020 = _T_909 ? mtdata2_t_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1021 = _T_924 ? mtdata2_t_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1022 = _T_1018 | _T_1019; // @[Mux.scala 27:72]
  wire [31:0] _T_1023 = _T_1022 | _T_1020; // @[Mux.scala 27:72]
  wire [31:0] mtdata2_tsel_out = _T_1023 | _T_1021; // @[Mux.scala 27:72]
  wire [3:0] _T_1026 = io_tlu_i0_commit_cmt ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] pmu_i0_itype_qual = io_dec_tlu_packet_r_pmu_i0_itype & _T_1026; // @[el2_dec_tlu_ctl.scala 2346:59]
  wire  _T_1028 = ~mcountinhibit[3]; // @[el2_dec_tlu_ctl.scala 2352:24]
  reg [9:0] mhpme3; // @[Reg.scala 27:20]
  wire  _T_1029 = mhpme3 == 10'h1; // @[el2_dec_tlu_ctl.scala 2353:34]
  wire  _T_1031 = mhpme3 == 10'h2; // @[el2_dec_tlu_ctl.scala 2354:34]
  wire  _T_1033 = mhpme3 == 10'h3; // @[el2_dec_tlu_ctl.scala 2355:34]
  wire  _T_1035 = mhpme3 == 10'h4; // @[el2_dec_tlu_ctl.scala 2356:34]
  wire  _T_1037 = ~io_illegal_r; // @[el2_dec_tlu_ctl.scala 2356:96]
  wire  _T_1038 = io_tlu_i0_commit_cmt & _T_1037; // @[el2_dec_tlu_ctl.scala 2356:94]
  wire  _T_1039 = mhpme3 == 10'h5; // @[el2_dec_tlu_ctl.scala 2357:34]
  wire  _T_1041 = ~io_exu_pmu_i0_pc4; // @[el2_dec_tlu_ctl.scala 2357:96]
  wire  _T_1042 = io_tlu_i0_commit_cmt & _T_1041; // @[el2_dec_tlu_ctl.scala 2357:94]
  wire  _T_1044 = _T_1042 & _T_1037; // @[el2_dec_tlu_ctl.scala 2357:115]
  wire  _T_1045 = mhpme3 == 10'h6; // @[el2_dec_tlu_ctl.scala 2358:34]
  wire  _T_1047 = io_tlu_i0_commit_cmt & io_exu_pmu_i0_pc4; // @[el2_dec_tlu_ctl.scala 2358:94]
  wire  _T_1049 = _T_1047 & _T_1037; // @[el2_dec_tlu_ctl.scala 2358:115]
  wire  _T_1050 = mhpme3 == 10'h7; // @[el2_dec_tlu_ctl.scala 2359:34]
  wire  _T_1052 = mhpme3 == 10'h8; // @[el2_dec_tlu_ctl.scala 2360:34]
  wire  _T_1054 = mhpme3 == 10'h1e; // @[el2_dec_tlu_ctl.scala 2361:34]
  wire  _T_1056 = mhpme3 == 10'h9; // @[el2_dec_tlu_ctl.scala 2362:34]
  wire  _T_1058 = pmu_i0_itype_qual == 4'h1; // @[el2_dec_tlu_ctl.scala 2362:91]
  wire  _T_1059 = mhpme3 == 10'ha; // @[el2_dec_tlu_ctl.scala 2363:34]
  wire  _T_1061 = io_dec_tlu_packet_r_pmu_divide & io_tlu_i0_commit_cmt; // @[el2_dec_tlu_ctl.scala 2363:105]
  wire  _T_1062 = mhpme3 == 10'hb; // @[el2_dec_tlu_ctl.scala 2364:34]
  wire  _T_1064 = pmu_i0_itype_qual == 4'h2; // @[el2_dec_tlu_ctl.scala 2364:91]
  wire  _T_1065 = mhpme3 == 10'hc; // @[el2_dec_tlu_ctl.scala 2365:34]
  wire  _T_1067 = pmu_i0_itype_qual == 4'h3; // @[el2_dec_tlu_ctl.scala 2365:91]
  wire  _T_1068 = mhpme3 == 10'hd; // @[el2_dec_tlu_ctl.scala 2366:34]
  wire  _T_1071 = mhpme3 == 10'he; // @[el2_dec_tlu_ctl.scala 2367:79]
  wire  _T_1072 = io_dec_tlu_packet_r_pmu_lsu_misaligned >> _T_1071; // @[el2_dec_tlu_ctl.scala 2367:65]
  wire  _T_1074 = _T_1064 & _T_1072; // @[el2_dec_tlu_ctl.scala 2366:102]
  wire  _T_1076 = _T_1074 & _T_1067; // @[el2_dec_tlu_ctl.scala 2367:103]
  wire  _T_1078 = _T_1076 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[el2_dec_tlu_ctl.scala 2367:135]
  wire  _T_1079 = mhpme3 == 10'hf; // @[el2_dec_tlu_ctl.scala 2369:34]
  wire  _T_1081 = pmu_i0_itype_qual == 4'h4; // @[el2_dec_tlu_ctl.scala 2369:89]
  wire  _T_1082 = mhpme3 == 10'h10; // @[el2_dec_tlu_ctl.scala 2370:34]
  wire  _T_1084 = pmu_i0_itype_qual == 4'h5; // @[el2_dec_tlu_ctl.scala 2370:89]
  wire  _T_1085 = mhpme3 == 10'h12; // @[el2_dec_tlu_ctl.scala 2371:34]
  wire  _T_1087 = pmu_i0_itype_qual == 4'h6; // @[el2_dec_tlu_ctl.scala 2371:89]
  wire  _T_1088 = mhpme3 == 10'h11; // @[el2_dec_tlu_ctl.scala 2372:34]
  wire  _T_1090 = pmu_i0_itype_qual == 4'h7; // @[el2_dec_tlu_ctl.scala 2372:89]
  wire  _T_1091 = mhpme3 == 10'h13; // @[el2_dec_tlu_ctl.scala 2373:34]
  wire  _T_1093 = pmu_i0_itype_qual == 4'h8; // @[el2_dec_tlu_ctl.scala 2373:89]
  wire  _T_1094 = mhpme3 == 10'h14; // @[el2_dec_tlu_ctl.scala 2374:34]
  wire  _T_1096 = pmu_i0_itype_qual == 4'h9; // @[el2_dec_tlu_ctl.scala 2374:89]
  wire  _T_1097 = mhpme3 == 10'h15; // @[el2_dec_tlu_ctl.scala 2375:34]
  wire  _T_1099 = pmu_i0_itype_qual == 4'ha; // @[el2_dec_tlu_ctl.scala 2375:89]
  wire  _T_1100 = mhpme3 == 10'h16; // @[el2_dec_tlu_ctl.scala 2376:34]
  wire  _T_1102 = pmu_i0_itype_qual == 4'hb; // @[el2_dec_tlu_ctl.scala 2376:89]
  wire  _T_1103 = mhpme3 == 10'h17; // @[el2_dec_tlu_ctl.scala 2377:34]
  wire  _T_1105 = pmu_i0_itype_qual == 4'hc; // @[el2_dec_tlu_ctl.scala 2377:89]
  wire  _T_1106 = mhpme3 == 10'h18; // @[el2_dec_tlu_ctl.scala 2378:34]
  wire  _T_1108 = pmu_i0_itype_qual == 4'hd; // @[el2_dec_tlu_ctl.scala 2378:89]
  wire  _T_1109 = pmu_i0_itype_qual == 4'he; // @[el2_dec_tlu_ctl.scala 2378:122]
  wire  _T_1110 = _T_1108 | _T_1109; // @[el2_dec_tlu_ctl.scala 2378:101]
  wire  _T_1111 = mhpme3 == 10'h19; // @[el2_dec_tlu_ctl.scala 2379:34]
  wire  _T_1113 = io_exu_pmu_i0_br_misp & io_tlu_i0_commit_cmt; // @[el2_dec_tlu_ctl.scala 2379:95]
  wire  _T_1114 = mhpme3 == 10'h1a; // @[el2_dec_tlu_ctl.scala 2380:34]
  wire  _T_1116 = io_exu_pmu_i0_br_ataken & io_tlu_i0_commit_cmt; // @[el2_dec_tlu_ctl.scala 2380:97]
  wire  _T_1117 = mhpme3 == 10'h1b; // @[el2_dec_tlu_ctl.scala 2381:34]
  wire  _T_1119 = io_dec_tlu_packet_r_pmu_i0_br_unpred & io_tlu_i0_commit_cmt; // @[el2_dec_tlu_ctl.scala 2381:110]
  wire  _T_1120 = mhpme3 == 10'h1c; // @[el2_dec_tlu_ctl.scala 2382:34]
  wire  _T_1124 = mhpme3 == 10'h1f; // @[el2_dec_tlu_ctl.scala 2384:34]
  wire  _T_1126 = mhpme3 == 10'h20; // @[el2_dec_tlu_ctl.scala 2385:34]
  wire  _T_1128 = mhpme3 == 10'h22; // @[el2_dec_tlu_ctl.scala 2386:34]
  wire  _T_1130 = mhpme3 == 10'h23; // @[el2_dec_tlu_ctl.scala 2387:34]
  wire  _T_1132 = mhpme3 == 10'h24; // @[el2_dec_tlu_ctl.scala 2388:34]
  wire  _T_1134 = mhpme3 == 10'h25; // @[el2_dec_tlu_ctl.scala 2389:34]
  wire  _T_1136 = io_i0_exception_valid_r | io_i0_trigger_hit_r; // @[el2_dec_tlu_ctl.scala 2389:98]
  wire  _T_1137 = _T_1136 | io_lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 2389:120]
  wire  _T_1138 = mhpme3 == 10'h26; // @[el2_dec_tlu_ctl.scala 2390:34]
  wire  _T_1140 = io_take_timer_int | io_take_int_timer0_int; // @[el2_dec_tlu_ctl.scala 2390:92]
  wire  _T_1141 = _T_1140 | io_take_int_timer1_int; // @[el2_dec_tlu_ctl.scala 2390:117]
  wire  _T_1142 = mhpme3 == 10'h27; // @[el2_dec_tlu_ctl.scala 2391:34]
  wire  _T_1144 = mhpme3 == 10'h28; // @[el2_dec_tlu_ctl.scala 2392:34]
  wire  _T_1146 = mhpme3 == 10'h29; // @[el2_dec_tlu_ctl.scala 2393:34]
  wire  _T_1148 = io_dec_tlu_br0_error_r | io_dec_tlu_br0_start_error_r; // @[el2_dec_tlu_ctl.scala 2393:97]
  wire  _T_1149 = _T_1148 & io_rfpc_i0_r; // @[el2_dec_tlu_ctl.scala 2393:129]
  wire  _T_1150 = mhpme3 == 10'h2a; // @[el2_dec_tlu_ctl.scala 2394:34]
  wire  _T_1152 = mhpme3 == 10'h2b; // @[el2_dec_tlu_ctl.scala 2395:34]
  wire  _T_1154 = mhpme3 == 10'h2c; // @[el2_dec_tlu_ctl.scala 2396:34]
  wire  _T_1156 = mhpme3 == 10'h2d; // @[el2_dec_tlu_ctl.scala 2397:34]
  wire  _T_1158 = mhpme3 == 10'h2e; // @[el2_dec_tlu_ctl.scala 2398:34]
  wire  _T_1160 = mhpme3 == 10'h2f; // @[el2_dec_tlu_ctl.scala 2399:34]
  wire  _T_1162 = mhpme3 == 10'h30; // @[el2_dec_tlu_ctl.scala 2400:34]
  wire  _T_1164 = mhpme3 == 10'h31; // @[el2_dec_tlu_ctl.scala 2401:34]
  wire  _T_1168 = ~io_mstatus[0]; // @[el2_dec_tlu_ctl.scala 2401:73]
  wire  _T_1169 = mhpme3 == 10'h32; // @[el2_dec_tlu_ctl.scala 2402:34]
  wire [5:0] _T_1176 = io_mip & mie; // @[el2_dec_tlu_ctl.scala 2402:113]
  wire [5:0] _GEN_16 = {{5'd0}, _T_1168}; // @[el2_dec_tlu_ctl.scala 2402:98]
  wire [5:0] _T_1177 = _GEN_16 & _T_1176; // @[el2_dec_tlu_ctl.scala 2402:98]
  wire  _T_1178 = mhpme3 == 10'h36; // @[el2_dec_tlu_ctl.scala 2403:34]
  wire  _T_1180 = pmu_i0_itype_qual == 4'hf; // @[el2_dec_tlu_ctl.scala 2403:91]
  wire  _T_1181 = mhpme3 == 10'h37; // @[el2_dec_tlu_ctl.scala 2404:34]
  wire  _T_1183 = io_tlu_i0_commit_cmt & io_lsu_pmu_load_external_r; // @[el2_dec_tlu_ctl.scala 2404:94]
  wire  _T_1184 = mhpme3 == 10'h38; // @[el2_dec_tlu_ctl.scala 2405:34]
  wire  _T_1186 = io_tlu_i0_commit_cmt & io_lsu_pmu_store_external_r; // @[el2_dec_tlu_ctl.scala 2405:94]
  wire  _T_1187 = mhpme3 == 10'h200; // @[el2_dec_tlu_ctl.scala 2407:34]
  wire  _T_1189 = mhpme3 == 10'h201; // @[el2_dec_tlu_ctl.scala 2408:34]
  wire  _T_1191 = mhpme3 == 10'h202; // @[el2_dec_tlu_ctl.scala 2409:34]
  wire  _T_1193 = mhpme3 == 10'h203; // @[el2_dec_tlu_ctl.scala 2410:34]
  wire  _T_1195 = mhpme3 == 10'h204; // @[el2_dec_tlu_ctl.scala 2411:34]
  wire  _T_1198 = _T_1031 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1199 = _T_1033 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1200 = _T_1035 & _T_1038; // @[Mux.scala 27:72]
  wire  _T_1201 = _T_1039 & _T_1044; // @[Mux.scala 27:72]
  wire  _T_1202 = _T_1045 & _T_1049; // @[Mux.scala 27:72]
  wire  _T_1203 = _T_1050 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1204 = _T_1052 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1205 = _T_1054 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1206 = _T_1056 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_1207 = _T_1059 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_1208 = _T_1062 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_1209 = _T_1065 & _T_1067; // @[Mux.scala 27:72]
  wire  _T_1210 = _T_1068 & _T_1078; // @[Mux.scala 27:72]
  wire  _T_1211 = _T_1079 & _T_1081; // @[Mux.scala 27:72]
  wire  _T_1212 = _T_1082 & _T_1084; // @[Mux.scala 27:72]
  wire  _T_1213 = _T_1085 & _T_1087; // @[Mux.scala 27:72]
  wire  _T_1214 = _T_1088 & _T_1090; // @[Mux.scala 27:72]
  wire  _T_1215 = _T_1091 & _T_1093; // @[Mux.scala 27:72]
  wire  _T_1216 = _T_1094 & _T_1096; // @[Mux.scala 27:72]
  wire  _T_1217 = _T_1097 & _T_1099; // @[Mux.scala 27:72]
  wire  _T_1218 = _T_1100 & _T_1102; // @[Mux.scala 27:72]
  wire  _T_1219 = _T_1103 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_1220 = _T_1106 & _T_1110; // @[Mux.scala 27:72]
  wire  _T_1221 = _T_1111 & _T_1113; // @[Mux.scala 27:72]
  wire  _T_1222 = _T_1114 & _T_1116; // @[Mux.scala 27:72]
  wire  _T_1223 = _T_1117 & _T_1119; // @[Mux.scala 27:72]
  wire  _T_1224 = _T_1120 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1226 = _T_1124 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1227 = _T_1126 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1228 = _T_1128 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1229 = _T_1130 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1230 = _T_1132 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1231 = _T_1134 & _T_1137; // @[Mux.scala 27:72]
  wire  _T_1232 = _T_1138 & _T_1141; // @[Mux.scala 27:72]
  wire  _T_1233 = _T_1142 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1234 = _T_1144 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1235 = _T_1146 & _T_1149; // @[Mux.scala 27:72]
  wire  _T_1236 = _T_1150 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1237 = _T_1152 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1238 = _T_1154 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1239 = _T_1156 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1240 = _T_1158 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1241 = _T_1160 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1242 = _T_1162 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1243 = _T_1164 & _T_1168; // @[Mux.scala 27:72]
  wire [5:0] _T_1244 = _T_1169 ? _T_1177 : 6'h0; // @[Mux.scala 27:72]
  wire  _T_1245 = _T_1178 & _T_1180; // @[Mux.scala 27:72]
  wire  _T_1246 = _T_1181 & _T_1183; // @[Mux.scala 27:72]
  wire  _T_1247 = _T_1184 & _T_1186; // @[Mux.scala 27:72]
  wire  _T_1248 = _T_1187 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1249 = _T_1189 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1250 = _T_1191 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1251 = _T_1193 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1252 = _T_1195 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1253 = _T_1029 | _T_1198; // @[Mux.scala 27:72]
  wire  _T_1254 = _T_1253 | _T_1199; // @[Mux.scala 27:72]
  wire  _T_1255 = _T_1254 | _T_1200; // @[Mux.scala 27:72]
  wire  _T_1256 = _T_1255 | _T_1201; // @[Mux.scala 27:72]
  wire  _T_1257 = _T_1256 | _T_1202; // @[Mux.scala 27:72]
  wire  _T_1258 = _T_1257 | _T_1203; // @[Mux.scala 27:72]
  wire  _T_1259 = _T_1258 | _T_1204; // @[Mux.scala 27:72]
  wire  _T_1260 = _T_1259 | _T_1205; // @[Mux.scala 27:72]
  wire  _T_1261 = _T_1260 | _T_1206; // @[Mux.scala 27:72]
  wire  _T_1262 = _T_1261 | _T_1207; // @[Mux.scala 27:72]
  wire  _T_1263 = _T_1262 | _T_1208; // @[Mux.scala 27:72]
  wire  _T_1264 = _T_1263 | _T_1209; // @[Mux.scala 27:72]
  wire  _T_1265 = _T_1264 | _T_1210; // @[Mux.scala 27:72]
  wire  _T_1266 = _T_1265 | _T_1211; // @[Mux.scala 27:72]
  wire  _T_1267 = _T_1266 | _T_1212; // @[Mux.scala 27:72]
  wire  _T_1268 = _T_1267 | _T_1213; // @[Mux.scala 27:72]
  wire  _T_1269 = _T_1268 | _T_1214; // @[Mux.scala 27:72]
  wire  _T_1270 = _T_1269 | _T_1215; // @[Mux.scala 27:72]
  wire  _T_1271 = _T_1270 | _T_1216; // @[Mux.scala 27:72]
  wire  _T_1272 = _T_1271 | _T_1217; // @[Mux.scala 27:72]
  wire  _T_1273 = _T_1272 | _T_1218; // @[Mux.scala 27:72]
  wire  _T_1274 = _T_1273 | _T_1219; // @[Mux.scala 27:72]
  wire  _T_1275 = _T_1274 | _T_1220; // @[Mux.scala 27:72]
  wire  _T_1276 = _T_1275 | _T_1221; // @[Mux.scala 27:72]
  wire  _T_1277 = _T_1276 | _T_1222; // @[Mux.scala 27:72]
  wire  _T_1278 = _T_1277 | _T_1223; // @[Mux.scala 27:72]
  wire  _T_1279 = _T_1278 | _T_1224; // @[Mux.scala 27:72]
  wire  _T_1280 = _T_1279 | _T_1205; // @[Mux.scala 27:72]
  wire  _T_1281 = _T_1280 | _T_1226; // @[Mux.scala 27:72]
  wire  _T_1282 = _T_1281 | _T_1227; // @[Mux.scala 27:72]
  wire  _T_1283 = _T_1282 | _T_1228; // @[Mux.scala 27:72]
  wire  _T_1284 = _T_1283 | _T_1229; // @[Mux.scala 27:72]
  wire  _T_1285 = _T_1284 | _T_1230; // @[Mux.scala 27:72]
  wire  _T_1286 = _T_1285 | _T_1231; // @[Mux.scala 27:72]
  wire  _T_1287 = _T_1286 | _T_1232; // @[Mux.scala 27:72]
  wire  _T_1288 = _T_1287 | _T_1233; // @[Mux.scala 27:72]
  wire  _T_1289 = _T_1288 | _T_1234; // @[Mux.scala 27:72]
  wire  _T_1290 = _T_1289 | _T_1235; // @[Mux.scala 27:72]
  wire  _T_1291 = _T_1290 | _T_1236; // @[Mux.scala 27:72]
  wire  _T_1292 = _T_1291 | _T_1237; // @[Mux.scala 27:72]
  wire  _T_1293 = _T_1292 | _T_1238; // @[Mux.scala 27:72]
  wire  _T_1294 = _T_1293 | _T_1239; // @[Mux.scala 27:72]
  wire  _T_1295 = _T_1294 | _T_1240; // @[Mux.scala 27:72]
  wire  _T_1296 = _T_1295 | _T_1241; // @[Mux.scala 27:72]
  wire  _T_1297 = _T_1296 | _T_1242; // @[Mux.scala 27:72]
  wire  _T_1298 = _T_1297 | _T_1243; // @[Mux.scala 27:72]
  wire [5:0] _GEN_17 = {{5'd0}, _T_1298}; // @[Mux.scala 27:72]
  wire [5:0] _T_1299 = _GEN_17 | _T_1244; // @[Mux.scala 27:72]
  wire [5:0] _GEN_18 = {{5'd0}, _T_1245}; // @[Mux.scala 27:72]
  wire [5:0] _T_1300 = _T_1299 | _GEN_18; // @[Mux.scala 27:72]
  wire [5:0] _GEN_19 = {{5'd0}, _T_1246}; // @[Mux.scala 27:72]
  wire [5:0] _T_1301 = _T_1300 | _GEN_19; // @[Mux.scala 27:72]
  wire [5:0] _GEN_20 = {{5'd0}, _T_1247}; // @[Mux.scala 27:72]
  wire [5:0] _T_1302 = _T_1301 | _GEN_20; // @[Mux.scala 27:72]
  wire [5:0] _GEN_21 = {{5'd0}, _T_1248}; // @[Mux.scala 27:72]
  wire [5:0] _T_1303 = _T_1302 | _GEN_21; // @[Mux.scala 27:72]
  wire [5:0] _GEN_22 = {{5'd0}, _T_1249}; // @[Mux.scala 27:72]
  wire [5:0] _T_1304 = _T_1303 | _GEN_22; // @[Mux.scala 27:72]
  wire [5:0] _GEN_23 = {{5'd0}, _T_1250}; // @[Mux.scala 27:72]
  wire [5:0] _T_1305 = _T_1304 | _GEN_23; // @[Mux.scala 27:72]
  wire [5:0] _GEN_24 = {{5'd0}, _T_1251}; // @[Mux.scala 27:72]
  wire [5:0] _T_1306 = _T_1305 | _GEN_24; // @[Mux.scala 27:72]
  wire [5:0] _GEN_25 = {{5'd0}, _T_1252}; // @[Mux.scala 27:72]
  wire [5:0] _T_1307 = _T_1306 | _GEN_25; // @[Mux.scala 27:72]
  wire [5:0] _GEN_26 = {{5'd0}, _T_1028}; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire [5:0] _T_1309 = _GEN_26 & _T_1307; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire  _T_1311 = ~mcountinhibit[4]; // @[el2_dec_tlu_ctl.scala 2352:24]
  reg [9:0] mhpme4; // @[Reg.scala 27:20]
  wire  _T_1312 = mhpme4 == 10'h1; // @[el2_dec_tlu_ctl.scala 2353:34]
  wire  _T_1314 = mhpme4 == 10'h2; // @[el2_dec_tlu_ctl.scala 2354:34]
  wire  _T_1316 = mhpme4 == 10'h3; // @[el2_dec_tlu_ctl.scala 2355:34]
  wire  _T_1318 = mhpme4 == 10'h4; // @[el2_dec_tlu_ctl.scala 2356:34]
  wire  _T_1322 = mhpme4 == 10'h5; // @[el2_dec_tlu_ctl.scala 2357:34]
  wire  _T_1328 = mhpme4 == 10'h6; // @[el2_dec_tlu_ctl.scala 2358:34]
  wire  _T_1333 = mhpme4 == 10'h7; // @[el2_dec_tlu_ctl.scala 2359:34]
  wire  _T_1335 = mhpme4 == 10'h8; // @[el2_dec_tlu_ctl.scala 2360:34]
  wire  _T_1337 = mhpme4 == 10'h1e; // @[el2_dec_tlu_ctl.scala 2361:34]
  wire  _T_1339 = mhpme4 == 10'h9; // @[el2_dec_tlu_ctl.scala 2362:34]
  wire  _T_1342 = mhpme4 == 10'ha; // @[el2_dec_tlu_ctl.scala 2363:34]
  wire  _T_1345 = mhpme4 == 10'hb; // @[el2_dec_tlu_ctl.scala 2364:34]
  wire  _T_1348 = mhpme4 == 10'hc; // @[el2_dec_tlu_ctl.scala 2365:34]
  wire  _T_1351 = mhpme4 == 10'hd; // @[el2_dec_tlu_ctl.scala 2366:34]
  wire  _T_1354 = mhpme4 == 10'he; // @[el2_dec_tlu_ctl.scala 2367:79]
  wire  _T_1355 = io_dec_tlu_packet_r_pmu_lsu_misaligned >> _T_1354; // @[el2_dec_tlu_ctl.scala 2367:65]
  wire  _T_1357 = _T_1064 & _T_1355; // @[el2_dec_tlu_ctl.scala 2366:102]
  wire  _T_1359 = _T_1357 & _T_1067; // @[el2_dec_tlu_ctl.scala 2367:103]
  wire  _T_1361 = _T_1359 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[el2_dec_tlu_ctl.scala 2367:135]
  wire  _T_1362 = mhpme4 == 10'hf; // @[el2_dec_tlu_ctl.scala 2369:34]
  wire  _T_1365 = mhpme4 == 10'h10; // @[el2_dec_tlu_ctl.scala 2370:34]
  wire  _T_1368 = mhpme4 == 10'h12; // @[el2_dec_tlu_ctl.scala 2371:34]
  wire  _T_1371 = mhpme4 == 10'h11; // @[el2_dec_tlu_ctl.scala 2372:34]
  wire  _T_1374 = mhpme4 == 10'h13; // @[el2_dec_tlu_ctl.scala 2373:34]
  wire  _T_1377 = mhpme4 == 10'h14; // @[el2_dec_tlu_ctl.scala 2374:34]
  wire  _T_1380 = mhpme4 == 10'h15; // @[el2_dec_tlu_ctl.scala 2375:34]
  wire  _T_1383 = mhpme4 == 10'h16; // @[el2_dec_tlu_ctl.scala 2376:34]
  wire  _T_1386 = mhpme4 == 10'h17; // @[el2_dec_tlu_ctl.scala 2377:34]
  wire  _T_1389 = mhpme4 == 10'h18; // @[el2_dec_tlu_ctl.scala 2378:34]
  wire  _T_1394 = mhpme4 == 10'h19; // @[el2_dec_tlu_ctl.scala 2379:34]
  wire  _T_1397 = mhpme4 == 10'h1a; // @[el2_dec_tlu_ctl.scala 2380:34]
  wire  _T_1400 = mhpme4 == 10'h1b; // @[el2_dec_tlu_ctl.scala 2381:34]
  wire  _T_1403 = mhpme4 == 10'h1c; // @[el2_dec_tlu_ctl.scala 2382:34]
  wire  _T_1407 = mhpme4 == 10'h1f; // @[el2_dec_tlu_ctl.scala 2384:34]
  wire  _T_1409 = mhpme4 == 10'h20; // @[el2_dec_tlu_ctl.scala 2385:34]
  wire  _T_1411 = mhpme4 == 10'h22; // @[el2_dec_tlu_ctl.scala 2386:34]
  wire  _T_1413 = mhpme4 == 10'h23; // @[el2_dec_tlu_ctl.scala 2387:34]
  wire  _T_1415 = mhpme4 == 10'h24; // @[el2_dec_tlu_ctl.scala 2388:34]
  wire  _T_1417 = mhpme4 == 10'h25; // @[el2_dec_tlu_ctl.scala 2389:34]
  wire  _T_1421 = mhpme4 == 10'h26; // @[el2_dec_tlu_ctl.scala 2390:34]
  wire  _T_1425 = mhpme4 == 10'h27; // @[el2_dec_tlu_ctl.scala 2391:34]
  wire  _T_1427 = mhpme4 == 10'h28; // @[el2_dec_tlu_ctl.scala 2392:34]
  wire  _T_1429 = mhpme4 == 10'h29; // @[el2_dec_tlu_ctl.scala 2393:34]
  wire  _T_1433 = mhpme4 == 10'h2a; // @[el2_dec_tlu_ctl.scala 2394:34]
  wire  _T_1435 = mhpme4 == 10'h2b; // @[el2_dec_tlu_ctl.scala 2395:34]
  wire  _T_1437 = mhpme4 == 10'h2c; // @[el2_dec_tlu_ctl.scala 2396:34]
  wire  _T_1439 = mhpme4 == 10'h2d; // @[el2_dec_tlu_ctl.scala 2397:34]
  wire  _T_1441 = mhpme4 == 10'h2e; // @[el2_dec_tlu_ctl.scala 2398:34]
  wire  _T_1443 = mhpme4 == 10'h2f; // @[el2_dec_tlu_ctl.scala 2399:34]
  wire  _T_1445 = mhpme4 == 10'h30; // @[el2_dec_tlu_ctl.scala 2400:34]
  wire  _T_1447 = mhpme4 == 10'h31; // @[el2_dec_tlu_ctl.scala 2401:34]
  wire  _T_1452 = mhpme4 == 10'h32; // @[el2_dec_tlu_ctl.scala 2402:34]
  wire  _T_1461 = mhpme4 == 10'h36; // @[el2_dec_tlu_ctl.scala 2403:34]
  wire  _T_1464 = mhpme4 == 10'h37; // @[el2_dec_tlu_ctl.scala 2404:34]
  wire  _T_1467 = mhpme4 == 10'h38; // @[el2_dec_tlu_ctl.scala 2405:34]
  wire  _T_1470 = mhpme4 == 10'h200; // @[el2_dec_tlu_ctl.scala 2407:34]
  wire  _T_1472 = mhpme4 == 10'h201; // @[el2_dec_tlu_ctl.scala 2408:34]
  wire  _T_1474 = mhpme4 == 10'h202; // @[el2_dec_tlu_ctl.scala 2409:34]
  wire  _T_1476 = mhpme4 == 10'h203; // @[el2_dec_tlu_ctl.scala 2410:34]
  wire  _T_1478 = mhpme4 == 10'h204; // @[el2_dec_tlu_ctl.scala 2411:34]
  wire  _T_1481 = _T_1314 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1482 = _T_1316 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1483 = _T_1318 & _T_1038; // @[Mux.scala 27:72]
  wire  _T_1484 = _T_1322 & _T_1044; // @[Mux.scala 27:72]
  wire  _T_1485 = _T_1328 & _T_1049; // @[Mux.scala 27:72]
  wire  _T_1486 = _T_1333 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1487 = _T_1335 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1488 = _T_1337 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1489 = _T_1339 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_1490 = _T_1342 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_1491 = _T_1345 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_1492 = _T_1348 & _T_1067; // @[Mux.scala 27:72]
  wire  _T_1493 = _T_1351 & _T_1361; // @[Mux.scala 27:72]
  wire  _T_1494 = _T_1362 & _T_1081; // @[Mux.scala 27:72]
  wire  _T_1495 = _T_1365 & _T_1084; // @[Mux.scala 27:72]
  wire  _T_1496 = _T_1368 & _T_1087; // @[Mux.scala 27:72]
  wire  _T_1497 = _T_1371 & _T_1090; // @[Mux.scala 27:72]
  wire  _T_1498 = _T_1374 & _T_1093; // @[Mux.scala 27:72]
  wire  _T_1499 = _T_1377 & _T_1096; // @[Mux.scala 27:72]
  wire  _T_1500 = _T_1380 & _T_1099; // @[Mux.scala 27:72]
  wire  _T_1501 = _T_1383 & _T_1102; // @[Mux.scala 27:72]
  wire  _T_1502 = _T_1386 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_1503 = _T_1389 & _T_1110; // @[Mux.scala 27:72]
  wire  _T_1504 = _T_1394 & _T_1113; // @[Mux.scala 27:72]
  wire  _T_1505 = _T_1397 & _T_1116; // @[Mux.scala 27:72]
  wire  _T_1506 = _T_1400 & _T_1119; // @[Mux.scala 27:72]
  wire  _T_1507 = _T_1403 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1509 = _T_1407 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1510 = _T_1409 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1511 = _T_1411 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1512 = _T_1413 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1513 = _T_1415 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1514 = _T_1417 & _T_1137; // @[Mux.scala 27:72]
  wire  _T_1515 = _T_1421 & _T_1141; // @[Mux.scala 27:72]
  wire  _T_1516 = _T_1425 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1517 = _T_1427 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1518 = _T_1429 & _T_1149; // @[Mux.scala 27:72]
  wire  _T_1519 = _T_1433 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1520 = _T_1435 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1521 = _T_1437 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1522 = _T_1439 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1523 = _T_1441 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1524 = _T_1443 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1525 = _T_1445 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1526 = _T_1447 & _T_1168; // @[Mux.scala 27:72]
  wire [5:0] _T_1527 = _T_1452 ? _T_1177 : 6'h0; // @[Mux.scala 27:72]
  wire  _T_1528 = _T_1461 & _T_1180; // @[Mux.scala 27:72]
  wire  _T_1529 = _T_1464 & _T_1183; // @[Mux.scala 27:72]
  wire  _T_1530 = _T_1467 & _T_1186; // @[Mux.scala 27:72]
  wire  _T_1531 = _T_1470 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1532 = _T_1472 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1533 = _T_1474 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1534 = _T_1476 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1535 = _T_1478 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1536 = _T_1312 | _T_1481; // @[Mux.scala 27:72]
  wire  _T_1537 = _T_1536 | _T_1482; // @[Mux.scala 27:72]
  wire  _T_1538 = _T_1537 | _T_1483; // @[Mux.scala 27:72]
  wire  _T_1539 = _T_1538 | _T_1484; // @[Mux.scala 27:72]
  wire  _T_1540 = _T_1539 | _T_1485; // @[Mux.scala 27:72]
  wire  _T_1541 = _T_1540 | _T_1486; // @[Mux.scala 27:72]
  wire  _T_1542 = _T_1541 | _T_1487; // @[Mux.scala 27:72]
  wire  _T_1543 = _T_1542 | _T_1488; // @[Mux.scala 27:72]
  wire  _T_1544 = _T_1543 | _T_1489; // @[Mux.scala 27:72]
  wire  _T_1545 = _T_1544 | _T_1490; // @[Mux.scala 27:72]
  wire  _T_1546 = _T_1545 | _T_1491; // @[Mux.scala 27:72]
  wire  _T_1547 = _T_1546 | _T_1492; // @[Mux.scala 27:72]
  wire  _T_1548 = _T_1547 | _T_1493; // @[Mux.scala 27:72]
  wire  _T_1549 = _T_1548 | _T_1494; // @[Mux.scala 27:72]
  wire  _T_1550 = _T_1549 | _T_1495; // @[Mux.scala 27:72]
  wire  _T_1551 = _T_1550 | _T_1496; // @[Mux.scala 27:72]
  wire  _T_1552 = _T_1551 | _T_1497; // @[Mux.scala 27:72]
  wire  _T_1553 = _T_1552 | _T_1498; // @[Mux.scala 27:72]
  wire  _T_1554 = _T_1553 | _T_1499; // @[Mux.scala 27:72]
  wire  _T_1555 = _T_1554 | _T_1500; // @[Mux.scala 27:72]
  wire  _T_1556 = _T_1555 | _T_1501; // @[Mux.scala 27:72]
  wire  _T_1557 = _T_1556 | _T_1502; // @[Mux.scala 27:72]
  wire  _T_1558 = _T_1557 | _T_1503; // @[Mux.scala 27:72]
  wire  _T_1559 = _T_1558 | _T_1504; // @[Mux.scala 27:72]
  wire  _T_1560 = _T_1559 | _T_1505; // @[Mux.scala 27:72]
  wire  _T_1561 = _T_1560 | _T_1506; // @[Mux.scala 27:72]
  wire  _T_1562 = _T_1561 | _T_1507; // @[Mux.scala 27:72]
  wire  _T_1563 = _T_1562 | _T_1488; // @[Mux.scala 27:72]
  wire  _T_1564 = _T_1563 | _T_1509; // @[Mux.scala 27:72]
  wire  _T_1565 = _T_1564 | _T_1510; // @[Mux.scala 27:72]
  wire  _T_1566 = _T_1565 | _T_1511; // @[Mux.scala 27:72]
  wire  _T_1567 = _T_1566 | _T_1512; // @[Mux.scala 27:72]
  wire  _T_1568 = _T_1567 | _T_1513; // @[Mux.scala 27:72]
  wire  _T_1569 = _T_1568 | _T_1514; // @[Mux.scala 27:72]
  wire  _T_1570 = _T_1569 | _T_1515; // @[Mux.scala 27:72]
  wire  _T_1571 = _T_1570 | _T_1516; // @[Mux.scala 27:72]
  wire  _T_1572 = _T_1571 | _T_1517; // @[Mux.scala 27:72]
  wire  _T_1573 = _T_1572 | _T_1518; // @[Mux.scala 27:72]
  wire  _T_1574 = _T_1573 | _T_1519; // @[Mux.scala 27:72]
  wire  _T_1575 = _T_1574 | _T_1520; // @[Mux.scala 27:72]
  wire  _T_1576 = _T_1575 | _T_1521; // @[Mux.scala 27:72]
  wire  _T_1577 = _T_1576 | _T_1522; // @[Mux.scala 27:72]
  wire  _T_1578 = _T_1577 | _T_1523; // @[Mux.scala 27:72]
  wire  _T_1579 = _T_1578 | _T_1524; // @[Mux.scala 27:72]
  wire  _T_1580 = _T_1579 | _T_1525; // @[Mux.scala 27:72]
  wire  _T_1581 = _T_1580 | _T_1526; // @[Mux.scala 27:72]
  wire [5:0] _GEN_28 = {{5'd0}, _T_1581}; // @[Mux.scala 27:72]
  wire [5:0] _T_1582 = _GEN_28 | _T_1527; // @[Mux.scala 27:72]
  wire [5:0] _GEN_29 = {{5'd0}, _T_1528}; // @[Mux.scala 27:72]
  wire [5:0] _T_1583 = _T_1582 | _GEN_29; // @[Mux.scala 27:72]
  wire [5:0] _GEN_30 = {{5'd0}, _T_1529}; // @[Mux.scala 27:72]
  wire [5:0] _T_1584 = _T_1583 | _GEN_30; // @[Mux.scala 27:72]
  wire [5:0] _GEN_31 = {{5'd0}, _T_1530}; // @[Mux.scala 27:72]
  wire [5:0] _T_1585 = _T_1584 | _GEN_31; // @[Mux.scala 27:72]
  wire [5:0] _GEN_32 = {{5'd0}, _T_1531}; // @[Mux.scala 27:72]
  wire [5:0] _T_1586 = _T_1585 | _GEN_32; // @[Mux.scala 27:72]
  wire [5:0] _GEN_33 = {{5'd0}, _T_1532}; // @[Mux.scala 27:72]
  wire [5:0] _T_1587 = _T_1586 | _GEN_33; // @[Mux.scala 27:72]
  wire [5:0] _GEN_34 = {{5'd0}, _T_1533}; // @[Mux.scala 27:72]
  wire [5:0] _T_1588 = _T_1587 | _GEN_34; // @[Mux.scala 27:72]
  wire [5:0] _GEN_35 = {{5'd0}, _T_1534}; // @[Mux.scala 27:72]
  wire [5:0] _T_1589 = _T_1588 | _GEN_35; // @[Mux.scala 27:72]
  wire [5:0] _GEN_36 = {{5'd0}, _T_1535}; // @[Mux.scala 27:72]
  wire [5:0] _T_1590 = _T_1589 | _GEN_36; // @[Mux.scala 27:72]
  wire [5:0] _GEN_37 = {{5'd0}, _T_1311}; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire [5:0] _T_1592 = _GEN_37 & _T_1590; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire  _T_1594 = ~mcountinhibit[5]; // @[el2_dec_tlu_ctl.scala 2352:24]
  reg [9:0] mhpme5; // @[Reg.scala 27:20]
  wire  _T_1595 = mhpme5 == 10'h1; // @[el2_dec_tlu_ctl.scala 2353:34]
  wire  _T_1597 = mhpme5 == 10'h2; // @[el2_dec_tlu_ctl.scala 2354:34]
  wire  _T_1599 = mhpme5 == 10'h3; // @[el2_dec_tlu_ctl.scala 2355:34]
  wire  _T_1601 = mhpme5 == 10'h4; // @[el2_dec_tlu_ctl.scala 2356:34]
  wire  _T_1605 = mhpme5 == 10'h5; // @[el2_dec_tlu_ctl.scala 2357:34]
  wire  _T_1611 = mhpme5 == 10'h6; // @[el2_dec_tlu_ctl.scala 2358:34]
  wire  _T_1616 = mhpme5 == 10'h7; // @[el2_dec_tlu_ctl.scala 2359:34]
  wire  _T_1618 = mhpme5 == 10'h8; // @[el2_dec_tlu_ctl.scala 2360:34]
  wire  _T_1620 = mhpme5 == 10'h1e; // @[el2_dec_tlu_ctl.scala 2361:34]
  wire  _T_1622 = mhpme5 == 10'h9; // @[el2_dec_tlu_ctl.scala 2362:34]
  wire  _T_1625 = mhpme5 == 10'ha; // @[el2_dec_tlu_ctl.scala 2363:34]
  wire  _T_1628 = mhpme5 == 10'hb; // @[el2_dec_tlu_ctl.scala 2364:34]
  wire  _T_1631 = mhpme5 == 10'hc; // @[el2_dec_tlu_ctl.scala 2365:34]
  wire  _T_1634 = mhpme5 == 10'hd; // @[el2_dec_tlu_ctl.scala 2366:34]
  wire  _T_1637 = mhpme5 == 10'he; // @[el2_dec_tlu_ctl.scala 2367:79]
  wire  _T_1638 = io_dec_tlu_packet_r_pmu_lsu_misaligned >> _T_1637; // @[el2_dec_tlu_ctl.scala 2367:65]
  wire  _T_1640 = _T_1064 & _T_1638; // @[el2_dec_tlu_ctl.scala 2366:102]
  wire  _T_1642 = _T_1640 & _T_1067; // @[el2_dec_tlu_ctl.scala 2367:103]
  wire  _T_1644 = _T_1642 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[el2_dec_tlu_ctl.scala 2367:135]
  wire  _T_1645 = mhpme5 == 10'hf; // @[el2_dec_tlu_ctl.scala 2369:34]
  wire  _T_1648 = mhpme5 == 10'h10; // @[el2_dec_tlu_ctl.scala 2370:34]
  wire  _T_1651 = mhpme5 == 10'h12; // @[el2_dec_tlu_ctl.scala 2371:34]
  wire  _T_1654 = mhpme5 == 10'h11; // @[el2_dec_tlu_ctl.scala 2372:34]
  wire  _T_1657 = mhpme5 == 10'h13; // @[el2_dec_tlu_ctl.scala 2373:34]
  wire  _T_1660 = mhpme5 == 10'h14; // @[el2_dec_tlu_ctl.scala 2374:34]
  wire  _T_1663 = mhpme5 == 10'h15; // @[el2_dec_tlu_ctl.scala 2375:34]
  wire  _T_1666 = mhpme5 == 10'h16; // @[el2_dec_tlu_ctl.scala 2376:34]
  wire  _T_1669 = mhpme5 == 10'h17; // @[el2_dec_tlu_ctl.scala 2377:34]
  wire  _T_1672 = mhpme5 == 10'h18; // @[el2_dec_tlu_ctl.scala 2378:34]
  wire  _T_1677 = mhpme5 == 10'h19; // @[el2_dec_tlu_ctl.scala 2379:34]
  wire  _T_1680 = mhpme5 == 10'h1a; // @[el2_dec_tlu_ctl.scala 2380:34]
  wire  _T_1683 = mhpme5 == 10'h1b; // @[el2_dec_tlu_ctl.scala 2381:34]
  wire  _T_1686 = mhpme5 == 10'h1c; // @[el2_dec_tlu_ctl.scala 2382:34]
  wire  _T_1690 = mhpme5 == 10'h1f; // @[el2_dec_tlu_ctl.scala 2384:34]
  wire  _T_1692 = mhpme5 == 10'h20; // @[el2_dec_tlu_ctl.scala 2385:34]
  wire  _T_1694 = mhpme5 == 10'h22; // @[el2_dec_tlu_ctl.scala 2386:34]
  wire  _T_1696 = mhpme5 == 10'h23; // @[el2_dec_tlu_ctl.scala 2387:34]
  wire  _T_1698 = mhpme5 == 10'h24; // @[el2_dec_tlu_ctl.scala 2388:34]
  wire  _T_1700 = mhpme5 == 10'h25; // @[el2_dec_tlu_ctl.scala 2389:34]
  wire  _T_1704 = mhpme5 == 10'h26; // @[el2_dec_tlu_ctl.scala 2390:34]
  wire  _T_1708 = mhpme5 == 10'h27; // @[el2_dec_tlu_ctl.scala 2391:34]
  wire  _T_1710 = mhpme5 == 10'h28; // @[el2_dec_tlu_ctl.scala 2392:34]
  wire  _T_1712 = mhpme5 == 10'h29; // @[el2_dec_tlu_ctl.scala 2393:34]
  wire  _T_1716 = mhpme5 == 10'h2a; // @[el2_dec_tlu_ctl.scala 2394:34]
  wire  _T_1718 = mhpme5 == 10'h2b; // @[el2_dec_tlu_ctl.scala 2395:34]
  wire  _T_1720 = mhpme5 == 10'h2c; // @[el2_dec_tlu_ctl.scala 2396:34]
  wire  _T_1722 = mhpme5 == 10'h2d; // @[el2_dec_tlu_ctl.scala 2397:34]
  wire  _T_1724 = mhpme5 == 10'h2e; // @[el2_dec_tlu_ctl.scala 2398:34]
  wire  _T_1726 = mhpme5 == 10'h2f; // @[el2_dec_tlu_ctl.scala 2399:34]
  wire  _T_1728 = mhpme5 == 10'h30; // @[el2_dec_tlu_ctl.scala 2400:34]
  wire  _T_1730 = mhpme5 == 10'h31; // @[el2_dec_tlu_ctl.scala 2401:34]
  wire  _T_1735 = mhpme5 == 10'h32; // @[el2_dec_tlu_ctl.scala 2402:34]
  wire  _T_1744 = mhpme5 == 10'h36; // @[el2_dec_tlu_ctl.scala 2403:34]
  wire  _T_1747 = mhpme5 == 10'h37; // @[el2_dec_tlu_ctl.scala 2404:34]
  wire  _T_1750 = mhpme5 == 10'h38; // @[el2_dec_tlu_ctl.scala 2405:34]
  wire  _T_1753 = mhpme5 == 10'h200; // @[el2_dec_tlu_ctl.scala 2407:34]
  wire  _T_1755 = mhpme5 == 10'h201; // @[el2_dec_tlu_ctl.scala 2408:34]
  wire  _T_1757 = mhpme5 == 10'h202; // @[el2_dec_tlu_ctl.scala 2409:34]
  wire  _T_1759 = mhpme5 == 10'h203; // @[el2_dec_tlu_ctl.scala 2410:34]
  wire  _T_1761 = mhpme5 == 10'h204; // @[el2_dec_tlu_ctl.scala 2411:34]
  wire  _T_1764 = _T_1597 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1765 = _T_1599 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1766 = _T_1601 & _T_1038; // @[Mux.scala 27:72]
  wire  _T_1767 = _T_1605 & _T_1044; // @[Mux.scala 27:72]
  wire  _T_1768 = _T_1611 & _T_1049; // @[Mux.scala 27:72]
  wire  _T_1769 = _T_1616 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1770 = _T_1618 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1771 = _T_1620 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1772 = _T_1622 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_1773 = _T_1625 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_1774 = _T_1628 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_1775 = _T_1631 & _T_1067; // @[Mux.scala 27:72]
  wire  _T_1776 = _T_1634 & _T_1644; // @[Mux.scala 27:72]
  wire  _T_1777 = _T_1645 & _T_1081; // @[Mux.scala 27:72]
  wire  _T_1778 = _T_1648 & _T_1084; // @[Mux.scala 27:72]
  wire  _T_1779 = _T_1651 & _T_1087; // @[Mux.scala 27:72]
  wire  _T_1780 = _T_1654 & _T_1090; // @[Mux.scala 27:72]
  wire  _T_1781 = _T_1657 & _T_1093; // @[Mux.scala 27:72]
  wire  _T_1782 = _T_1660 & _T_1096; // @[Mux.scala 27:72]
  wire  _T_1783 = _T_1663 & _T_1099; // @[Mux.scala 27:72]
  wire  _T_1784 = _T_1666 & _T_1102; // @[Mux.scala 27:72]
  wire  _T_1785 = _T_1669 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_1786 = _T_1672 & _T_1110; // @[Mux.scala 27:72]
  wire  _T_1787 = _T_1677 & _T_1113; // @[Mux.scala 27:72]
  wire  _T_1788 = _T_1680 & _T_1116; // @[Mux.scala 27:72]
  wire  _T_1789 = _T_1683 & _T_1119; // @[Mux.scala 27:72]
  wire  _T_1790 = _T_1686 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1792 = _T_1690 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1793 = _T_1692 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1794 = _T_1694 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1795 = _T_1696 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1796 = _T_1698 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1797 = _T_1700 & _T_1137; // @[Mux.scala 27:72]
  wire  _T_1798 = _T_1704 & _T_1141; // @[Mux.scala 27:72]
  wire  _T_1799 = _T_1708 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1800 = _T_1710 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1801 = _T_1712 & _T_1149; // @[Mux.scala 27:72]
  wire  _T_1802 = _T_1716 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1803 = _T_1718 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1804 = _T_1720 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1805 = _T_1722 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1806 = _T_1724 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1807 = _T_1726 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1808 = _T_1728 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1809 = _T_1730 & _T_1168; // @[Mux.scala 27:72]
  wire [5:0] _T_1810 = _T_1735 ? _T_1177 : 6'h0; // @[Mux.scala 27:72]
  wire  _T_1811 = _T_1744 & _T_1180; // @[Mux.scala 27:72]
  wire  _T_1812 = _T_1747 & _T_1183; // @[Mux.scala 27:72]
  wire  _T_1813 = _T_1750 & _T_1186; // @[Mux.scala 27:72]
  wire  _T_1814 = _T_1753 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1815 = _T_1755 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1816 = _T_1757 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1817 = _T_1759 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1818 = _T_1761 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1819 = _T_1595 | _T_1764; // @[Mux.scala 27:72]
  wire  _T_1820 = _T_1819 | _T_1765; // @[Mux.scala 27:72]
  wire  _T_1821 = _T_1820 | _T_1766; // @[Mux.scala 27:72]
  wire  _T_1822 = _T_1821 | _T_1767; // @[Mux.scala 27:72]
  wire  _T_1823 = _T_1822 | _T_1768; // @[Mux.scala 27:72]
  wire  _T_1824 = _T_1823 | _T_1769; // @[Mux.scala 27:72]
  wire  _T_1825 = _T_1824 | _T_1770; // @[Mux.scala 27:72]
  wire  _T_1826 = _T_1825 | _T_1771; // @[Mux.scala 27:72]
  wire  _T_1827 = _T_1826 | _T_1772; // @[Mux.scala 27:72]
  wire  _T_1828 = _T_1827 | _T_1773; // @[Mux.scala 27:72]
  wire  _T_1829 = _T_1828 | _T_1774; // @[Mux.scala 27:72]
  wire  _T_1830 = _T_1829 | _T_1775; // @[Mux.scala 27:72]
  wire  _T_1831 = _T_1830 | _T_1776; // @[Mux.scala 27:72]
  wire  _T_1832 = _T_1831 | _T_1777; // @[Mux.scala 27:72]
  wire  _T_1833 = _T_1832 | _T_1778; // @[Mux.scala 27:72]
  wire  _T_1834 = _T_1833 | _T_1779; // @[Mux.scala 27:72]
  wire  _T_1835 = _T_1834 | _T_1780; // @[Mux.scala 27:72]
  wire  _T_1836 = _T_1835 | _T_1781; // @[Mux.scala 27:72]
  wire  _T_1837 = _T_1836 | _T_1782; // @[Mux.scala 27:72]
  wire  _T_1838 = _T_1837 | _T_1783; // @[Mux.scala 27:72]
  wire  _T_1839 = _T_1838 | _T_1784; // @[Mux.scala 27:72]
  wire  _T_1840 = _T_1839 | _T_1785; // @[Mux.scala 27:72]
  wire  _T_1841 = _T_1840 | _T_1786; // @[Mux.scala 27:72]
  wire  _T_1842 = _T_1841 | _T_1787; // @[Mux.scala 27:72]
  wire  _T_1843 = _T_1842 | _T_1788; // @[Mux.scala 27:72]
  wire  _T_1844 = _T_1843 | _T_1789; // @[Mux.scala 27:72]
  wire  _T_1845 = _T_1844 | _T_1790; // @[Mux.scala 27:72]
  wire  _T_1846 = _T_1845 | _T_1771; // @[Mux.scala 27:72]
  wire  _T_1847 = _T_1846 | _T_1792; // @[Mux.scala 27:72]
  wire  _T_1848 = _T_1847 | _T_1793; // @[Mux.scala 27:72]
  wire  _T_1849 = _T_1848 | _T_1794; // @[Mux.scala 27:72]
  wire  _T_1850 = _T_1849 | _T_1795; // @[Mux.scala 27:72]
  wire  _T_1851 = _T_1850 | _T_1796; // @[Mux.scala 27:72]
  wire  _T_1852 = _T_1851 | _T_1797; // @[Mux.scala 27:72]
  wire  _T_1853 = _T_1852 | _T_1798; // @[Mux.scala 27:72]
  wire  _T_1854 = _T_1853 | _T_1799; // @[Mux.scala 27:72]
  wire  _T_1855 = _T_1854 | _T_1800; // @[Mux.scala 27:72]
  wire  _T_1856 = _T_1855 | _T_1801; // @[Mux.scala 27:72]
  wire  _T_1857 = _T_1856 | _T_1802; // @[Mux.scala 27:72]
  wire  _T_1858 = _T_1857 | _T_1803; // @[Mux.scala 27:72]
  wire  _T_1859 = _T_1858 | _T_1804; // @[Mux.scala 27:72]
  wire  _T_1860 = _T_1859 | _T_1805; // @[Mux.scala 27:72]
  wire  _T_1861 = _T_1860 | _T_1806; // @[Mux.scala 27:72]
  wire  _T_1862 = _T_1861 | _T_1807; // @[Mux.scala 27:72]
  wire  _T_1863 = _T_1862 | _T_1808; // @[Mux.scala 27:72]
  wire  _T_1864 = _T_1863 | _T_1809; // @[Mux.scala 27:72]
  wire [5:0] _GEN_39 = {{5'd0}, _T_1864}; // @[Mux.scala 27:72]
  wire [5:0] _T_1865 = _GEN_39 | _T_1810; // @[Mux.scala 27:72]
  wire [5:0] _GEN_40 = {{5'd0}, _T_1811}; // @[Mux.scala 27:72]
  wire [5:0] _T_1866 = _T_1865 | _GEN_40; // @[Mux.scala 27:72]
  wire [5:0] _GEN_41 = {{5'd0}, _T_1812}; // @[Mux.scala 27:72]
  wire [5:0] _T_1867 = _T_1866 | _GEN_41; // @[Mux.scala 27:72]
  wire [5:0] _GEN_42 = {{5'd0}, _T_1813}; // @[Mux.scala 27:72]
  wire [5:0] _T_1868 = _T_1867 | _GEN_42; // @[Mux.scala 27:72]
  wire [5:0] _GEN_43 = {{5'd0}, _T_1814}; // @[Mux.scala 27:72]
  wire [5:0] _T_1869 = _T_1868 | _GEN_43; // @[Mux.scala 27:72]
  wire [5:0] _GEN_44 = {{5'd0}, _T_1815}; // @[Mux.scala 27:72]
  wire [5:0] _T_1870 = _T_1869 | _GEN_44; // @[Mux.scala 27:72]
  wire [5:0] _GEN_45 = {{5'd0}, _T_1816}; // @[Mux.scala 27:72]
  wire [5:0] _T_1871 = _T_1870 | _GEN_45; // @[Mux.scala 27:72]
  wire [5:0] _GEN_46 = {{5'd0}, _T_1817}; // @[Mux.scala 27:72]
  wire [5:0] _T_1872 = _T_1871 | _GEN_46; // @[Mux.scala 27:72]
  wire [5:0] _GEN_47 = {{5'd0}, _T_1818}; // @[Mux.scala 27:72]
  wire [5:0] _T_1873 = _T_1872 | _GEN_47; // @[Mux.scala 27:72]
  wire [5:0] _GEN_48 = {{5'd0}, _T_1594}; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire [5:0] _T_1875 = _GEN_48 & _T_1873; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire  _T_1877 = ~mcountinhibit[6]; // @[el2_dec_tlu_ctl.scala 2352:24]
  reg [9:0] mhpme6; // @[Reg.scala 27:20]
  wire  _T_1878 = mhpme6 == 10'h1; // @[el2_dec_tlu_ctl.scala 2353:34]
  wire  _T_1880 = mhpme6 == 10'h2; // @[el2_dec_tlu_ctl.scala 2354:34]
  wire  _T_1882 = mhpme6 == 10'h3; // @[el2_dec_tlu_ctl.scala 2355:34]
  wire  _T_1884 = mhpme6 == 10'h4; // @[el2_dec_tlu_ctl.scala 2356:34]
  wire  _T_1888 = mhpme6 == 10'h5; // @[el2_dec_tlu_ctl.scala 2357:34]
  wire  _T_1894 = mhpme6 == 10'h6; // @[el2_dec_tlu_ctl.scala 2358:34]
  wire  _T_1899 = mhpme6 == 10'h7; // @[el2_dec_tlu_ctl.scala 2359:34]
  wire  _T_1901 = mhpme6 == 10'h8; // @[el2_dec_tlu_ctl.scala 2360:34]
  wire  _T_1903 = mhpme6 == 10'h1e; // @[el2_dec_tlu_ctl.scala 2361:34]
  wire  _T_1905 = mhpme6 == 10'h9; // @[el2_dec_tlu_ctl.scala 2362:34]
  wire  _T_1908 = mhpme6 == 10'ha; // @[el2_dec_tlu_ctl.scala 2363:34]
  wire  _T_1911 = mhpme6 == 10'hb; // @[el2_dec_tlu_ctl.scala 2364:34]
  wire  _T_1914 = mhpme6 == 10'hc; // @[el2_dec_tlu_ctl.scala 2365:34]
  wire  _T_1917 = mhpme6 == 10'hd; // @[el2_dec_tlu_ctl.scala 2366:34]
  wire  _T_1920 = mhpme6 == 10'he; // @[el2_dec_tlu_ctl.scala 2367:79]
  wire  _T_1921 = io_dec_tlu_packet_r_pmu_lsu_misaligned >> _T_1920; // @[el2_dec_tlu_ctl.scala 2367:65]
  wire  _T_1923 = _T_1064 & _T_1921; // @[el2_dec_tlu_ctl.scala 2366:102]
  wire  _T_1925 = _T_1923 & _T_1067; // @[el2_dec_tlu_ctl.scala 2367:103]
  wire  _T_1927 = _T_1925 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[el2_dec_tlu_ctl.scala 2367:135]
  wire  _T_1928 = mhpme6 == 10'hf; // @[el2_dec_tlu_ctl.scala 2369:34]
  wire  _T_1931 = mhpme6 == 10'h10; // @[el2_dec_tlu_ctl.scala 2370:34]
  wire  _T_1934 = mhpme6 == 10'h12; // @[el2_dec_tlu_ctl.scala 2371:34]
  wire  _T_1937 = mhpme6 == 10'h11; // @[el2_dec_tlu_ctl.scala 2372:34]
  wire  _T_1940 = mhpme6 == 10'h13; // @[el2_dec_tlu_ctl.scala 2373:34]
  wire  _T_1943 = mhpme6 == 10'h14; // @[el2_dec_tlu_ctl.scala 2374:34]
  wire  _T_1946 = mhpme6 == 10'h15; // @[el2_dec_tlu_ctl.scala 2375:34]
  wire  _T_1949 = mhpme6 == 10'h16; // @[el2_dec_tlu_ctl.scala 2376:34]
  wire  _T_1952 = mhpme6 == 10'h17; // @[el2_dec_tlu_ctl.scala 2377:34]
  wire  _T_1955 = mhpme6 == 10'h18; // @[el2_dec_tlu_ctl.scala 2378:34]
  wire  _T_1960 = mhpme6 == 10'h19; // @[el2_dec_tlu_ctl.scala 2379:34]
  wire  _T_1963 = mhpme6 == 10'h1a; // @[el2_dec_tlu_ctl.scala 2380:34]
  wire  _T_1966 = mhpme6 == 10'h1b; // @[el2_dec_tlu_ctl.scala 2381:34]
  wire  _T_1969 = mhpme6 == 10'h1c; // @[el2_dec_tlu_ctl.scala 2382:34]
  wire  _T_1973 = mhpme6 == 10'h1f; // @[el2_dec_tlu_ctl.scala 2384:34]
  wire  _T_1975 = mhpme6 == 10'h20; // @[el2_dec_tlu_ctl.scala 2385:34]
  wire  _T_1977 = mhpme6 == 10'h22; // @[el2_dec_tlu_ctl.scala 2386:34]
  wire  _T_1979 = mhpme6 == 10'h23; // @[el2_dec_tlu_ctl.scala 2387:34]
  wire  _T_1981 = mhpme6 == 10'h24; // @[el2_dec_tlu_ctl.scala 2388:34]
  wire  _T_1983 = mhpme6 == 10'h25; // @[el2_dec_tlu_ctl.scala 2389:34]
  wire  _T_1987 = mhpme6 == 10'h26; // @[el2_dec_tlu_ctl.scala 2390:34]
  wire  _T_1991 = mhpme6 == 10'h27; // @[el2_dec_tlu_ctl.scala 2391:34]
  wire  _T_1993 = mhpme6 == 10'h28; // @[el2_dec_tlu_ctl.scala 2392:34]
  wire  _T_1995 = mhpme6 == 10'h29; // @[el2_dec_tlu_ctl.scala 2393:34]
  wire  _T_1999 = mhpme6 == 10'h2a; // @[el2_dec_tlu_ctl.scala 2394:34]
  wire  _T_2001 = mhpme6 == 10'h2b; // @[el2_dec_tlu_ctl.scala 2395:34]
  wire  _T_2003 = mhpme6 == 10'h2c; // @[el2_dec_tlu_ctl.scala 2396:34]
  wire  _T_2005 = mhpme6 == 10'h2d; // @[el2_dec_tlu_ctl.scala 2397:34]
  wire  _T_2007 = mhpme6 == 10'h2e; // @[el2_dec_tlu_ctl.scala 2398:34]
  wire  _T_2009 = mhpme6 == 10'h2f; // @[el2_dec_tlu_ctl.scala 2399:34]
  wire  _T_2011 = mhpme6 == 10'h30; // @[el2_dec_tlu_ctl.scala 2400:34]
  wire  _T_2013 = mhpme6 == 10'h31; // @[el2_dec_tlu_ctl.scala 2401:34]
  wire  _T_2018 = mhpme6 == 10'h32; // @[el2_dec_tlu_ctl.scala 2402:34]
  wire  _T_2027 = mhpme6 == 10'h36; // @[el2_dec_tlu_ctl.scala 2403:34]
  wire  _T_2030 = mhpme6 == 10'h37; // @[el2_dec_tlu_ctl.scala 2404:34]
  wire  _T_2033 = mhpme6 == 10'h38; // @[el2_dec_tlu_ctl.scala 2405:34]
  wire  _T_2036 = mhpme6 == 10'h200; // @[el2_dec_tlu_ctl.scala 2407:34]
  wire  _T_2038 = mhpme6 == 10'h201; // @[el2_dec_tlu_ctl.scala 2408:34]
  wire  _T_2040 = mhpme6 == 10'h202; // @[el2_dec_tlu_ctl.scala 2409:34]
  wire  _T_2042 = mhpme6 == 10'h203; // @[el2_dec_tlu_ctl.scala 2410:34]
  wire  _T_2044 = mhpme6 == 10'h204; // @[el2_dec_tlu_ctl.scala 2411:34]
  wire  _T_2047 = _T_1880 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_2048 = _T_1882 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_2049 = _T_1884 & _T_1038; // @[Mux.scala 27:72]
  wire  _T_2050 = _T_1888 & _T_1044; // @[Mux.scala 27:72]
  wire  _T_2051 = _T_1894 & _T_1049; // @[Mux.scala 27:72]
  wire  _T_2052 = _T_1899 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_2053 = _T_1901 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_2054 = _T_1903 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_2055 = _T_1905 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_2056 = _T_1908 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_2057 = _T_1911 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_2058 = _T_1914 & _T_1067; // @[Mux.scala 27:72]
  wire  _T_2059 = _T_1917 & _T_1927; // @[Mux.scala 27:72]
  wire  _T_2060 = _T_1928 & _T_1081; // @[Mux.scala 27:72]
  wire  _T_2061 = _T_1931 & _T_1084; // @[Mux.scala 27:72]
  wire  _T_2062 = _T_1934 & _T_1087; // @[Mux.scala 27:72]
  wire  _T_2063 = _T_1937 & _T_1090; // @[Mux.scala 27:72]
  wire  _T_2064 = _T_1940 & _T_1093; // @[Mux.scala 27:72]
  wire  _T_2065 = _T_1943 & _T_1096; // @[Mux.scala 27:72]
  wire  _T_2066 = _T_1946 & _T_1099; // @[Mux.scala 27:72]
  wire  _T_2067 = _T_1949 & _T_1102; // @[Mux.scala 27:72]
  wire  _T_2068 = _T_1952 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_2069 = _T_1955 & _T_1110; // @[Mux.scala 27:72]
  wire  _T_2070 = _T_1960 & _T_1113; // @[Mux.scala 27:72]
  wire  _T_2071 = _T_1963 & _T_1116; // @[Mux.scala 27:72]
  wire  _T_2072 = _T_1966 & _T_1119; // @[Mux.scala 27:72]
  wire  _T_2073 = _T_1969 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_2075 = _T_1973 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_2076 = _T_1975 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_2077 = _T_1977 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_2078 = _T_1979 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_2079 = _T_1981 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_2080 = _T_1983 & _T_1137; // @[Mux.scala 27:72]
  wire  _T_2081 = _T_1987 & _T_1141; // @[Mux.scala 27:72]
  wire  _T_2082 = _T_1991 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_2083 = _T_1993 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_2084 = _T_1995 & _T_1149; // @[Mux.scala 27:72]
  wire  _T_2085 = _T_1999 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_2086 = _T_2001 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_2087 = _T_2003 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_2088 = _T_2005 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_2089 = _T_2007 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_2090 = _T_2009 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_2091 = _T_2011 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_2092 = _T_2013 & _T_1168; // @[Mux.scala 27:72]
  wire [5:0] _T_2093 = _T_2018 ? _T_1177 : 6'h0; // @[Mux.scala 27:72]
  wire  _T_2094 = _T_2027 & _T_1180; // @[Mux.scala 27:72]
  wire  _T_2095 = _T_2030 & _T_1183; // @[Mux.scala 27:72]
  wire  _T_2096 = _T_2033 & _T_1186; // @[Mux.scala 27:72]
  wire  _T_2097 = _T_2036 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_2098 = _T_2038 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_2099 = _T_2040 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_2100 = _T_2042 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_2101 = _T_2044 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_2102 = _T_1878 | _T_2047; // @[Mux.scala 27:72]
  wire  _T_2103 = _T_2102 | _T_2048; // @[Mux.scala 27:72]
  wire  _T_2104 = _T_2103 | _T_2049; // @[Mux.scala 27:72]
  wire  _T_2105 = _T_2104 | _T_2050; // @[Mux.scala 27:72]
  wire  _T_2106 = _T_2105 | _T_2051; // @[Mux.scala 27:72]
  wire  _T_2107 = _T_2106 | _T_2052; // @[Mux.scala 27:72]
  wire  _T_2108 = _T_2107 | _T_2053; // @[Mux.scala 27:72]
  wire  _T_2109 = _T_2108 | _T_2054; // @[Mux.scala 27:72]
  wire  _T_2110 = _T_2109 | _T_2055; // @[Mux.scala 27:72]
  wire  _T_2111 = _T_2110 | _T_2056; // @[Mux.scala 27:72]
  wire  _T_2112 = _T_2111 | _T_2057; // @[Mux.scala 27:72]
  wire  _T_2113 = _T_2112 | _T_2058; // @[Mux.scala 27:72]
  wire  _T_2114 = _T_2113 | _T_2059; // @[Mux.scala 27:72]
  wire  _T_2115 = _T_2114 | _T_2060; // @[Mux.scala 27:72]
  wire  _T_2116 = _T_2115 | _T_2061; // @[Mux.scala 27:72]
  wire  _T_2117 = _T_2116 | _T_2062; // @[Mux.scala 27:72]
  wire  _T_2118 = _T_2117 | _T_2063; // @[Mux.scala 27:72]
  wire  _T_2119 = _T_2118 | _T_2064; // @[Mux.scala 27:72]
  wire  _T_2120 = _T_2119 | _T_2065; // @[Mux.scala 27:72]
  wire  _T_2121 = _T_2120 | _T_2066; // @[Mux.scala 27:72]
  wire  _T_2122 = _T_2121 | _T_2067; // @[Mux.scala 27:72]
  wire  _T_2123 = _T_2122 | _T_2068; // @[Mux.scala 27:72]
  wire  _T_2124 = _T_2123 | _T_2069; // @[Mux.scala 27:72]
  wire  _T_2125 = _T_2124 | _T_2070; // @[Mux.scala 27:72]
  wire  _T_2126 = _T_2125 | _T_2071; // @[Mux.scala 27:72]
  wire  _T_2127 = _T_2126 | _T_2072; // @[Mux.scala 27:72]
  wire  _T_2128 = _T_2127 | _T_2073; // @[Mux.scala 27:72]
  wire  _T_2129 = _T_2128 | _T_2054; // @[Mux.scala 27:72]
  wire  _T_2130 = _T_2129 | _T_2075; // @[Mux.scala 27:72]
  wire  _T_2131 = _T_2130 | _T_2076; // @[Mux.scala 27:72]
  wire  _T_2132 = _T_2131 | _T_2077; // @[Mux.scala 27:72]
  wire  _T_2133 = _T_2132 | _T_2078; // @[Mux.scala 27:72]
  wire  _T_2134 = _T_2133 | _T_2079; // @[Mux.scala 27:72]
  wire  _T_2135 = _T_2134 | _T_2080; // @[Mux.scala 27:72]
  wire  _T_2136 = _T_2135 | _T_2081; // @[Mux.scala 27:72]
  wire  _T_2137 = _T_2136 | _T_2082; // @[Mux.scala 27:72]
  wire  _T_2138 = _T_2137 | _T_2083; // @[Mux.scala 27:72]
  wire  _T_2139 = _T_2138 | _T_2084; // @[Mux.scala 27:72]
  wire  _T_2140 = _T_2139 | _T_2085; // @[Mux.scala 27:72]
  wire  _T_2141 = _T_2140 | _T_2086; // @[Mux.scala 27:72]
  wire  _T_2142 = _T_2141 | _T_2087; // @[Mux.scala 27:72]
  wire  _T_2143 = _T_2142 | _T_2088; // @[Mux.scala 27:72]
  wire  _T_2144 = _T_2143 | _T_2089; // @[Mux.scala 27:72]
  wire  _T_2145 = _T_2144 | _T_2090; // @[Mux.scala 27:72]
  wire  _T_2146 = _T_2145 | _T_2091; // @[Mux.scala 27:72]
  wire  _T_2147 = _T_2146 | _T_2092; // @[Mux.scala 27:72]
  wire [5:0] _GEN_50 = {{5'd0}, _T_2147}; // @[Mux.scala 27:72]
  wire [5:0] _T_2148 = _GEN_50 | _T_2093; // @[Mux.scala 27:72]
  wire [5:0] _GEN_51 = {{5'd0}, _T_2094}; // @[Mux.scala 27:72]
  wire [5:0] _T_2149 = _T_2148 | _GEN_51; // @[Mux.scala 27:72]
  wire [5:0] _GEN_52 = {{5'd0}, _T_2095}; // @[Mux.scala 27:72]
  wire [5:0] _T_2150 = _T_2149 | _GEN_52; // @[Mux.scala 27:72]
  wire [5:0] _GEN_53 = {{5'd0}, _T_2096}; // @[Mux.scala 27:72]
  wire [5:0] _T_2151 = _T_2150 | _GEN_53; // @[Mux.scala 27:72]
  wire [5:0] _GEN_54 = {{5'd0}, _T_2097}; // @[Mux.scala 27:72]
  wire [5:0] _T_2152 = _T_2151 | _GEN_54; // @[Mux.scala 27:72]
  wire [5:0] _GEN_55 = {{5'd0}, _T_2098}; // @[Mux.scala 27:72]
  wire [5:0] _T_2153 = _T_2152 | _GEN_55; // @[Mux.scala 27:72]
  wire [5:0] _GEN_56 = {{5'd0}, _T_2099}; // @[Mux.scala 27:72]
  wire [5:0] _T_2154 = _T_2153 | _GEN_56; // @[Mux.scala 27:72]
  wire [5:0] _GEN_57 = {{5'd0}, _T_2100}; // @[Mux.scala 27:72]
  wire [5:0] _T_2155 = _T_2154 | _GEN_57; // @[Mux.scala 27:72]
  wire [5:0] _GEN_58 = {{5'd0}, _T_2101}; // @[Mux.scala 27:72]
  wire [5:0] _T_2156 = _T_2155 | _GEN_58; // @[Mux.scala 27:72]
  wire [5:0] _GEN_59 = {{5'd0}, _T_1877}; // @[el2_dec_tlu_ctl.scala 2352:44]
  wire [5:0] _T_2158 = _GEN_59 & _T_2156; // @[el2_dec_tlu_ctl.scala 2352:44]
  reg  mhpmc_inc_r_d1_0; // @[el2_dec_tlu_ctl.scala 2414:53]
  reg  mhpmc_inc_r_d1_1; // @[el2_dec_tlu_ctl.scala 2415:53]
  reg  mhpmc_inc_r_d1_2; // @[el2_dec_tlu_ctl.scala 2416:53]
  reg  mhpmc_inc_r_d1_3; // @[el2_dec_tlu_ctl.scala 2417:53]
  reg  perfcnt_halted_d1; // @[el2_dec_tlu_ctl.scala 2418:56]
  wire  perfcnt_halted = _T_85 | io_dec_tlu_pmu_fw_halted; // @[el2_dec_tlu_ctl.scala 2421:67]
  wire  _T_2168 = ~_T_85; // @[el2_dec_tlu_ctl.scala 2422:37]
  wire [3:0] _T_2170 = _T_2168 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_2177 = {mhpme6[9],mhpme5[9],mhpme4[9],mhpme3[9]}; // @[Cat.scala 29:58]
  wire [3:0] perfcnt_during_sleep = _T_2170 & _T_2177; // @[el2_dec_tlu_ctl.scala 2422:86]
  wire  _T_2179 = ~perfcnt_during_sleep[0]; // @[el2_dec_tlu_ctl.scala 2424:67]
  wire  _T_2180 = perfcnt_halted_d1 & _T_2179; // @[el2_dec_tlu_ctl.scala 2424:65]
  wire  _T_2181 = ~_T_2180; // @[el2_dec_tlu_ctl.scala 2424:45]
  wire  _T_2184 = ~perfcnt_during_sleep[1]; // @[el2_dec_tlu_ctl.scala 2425:67]
  wire  _T_2185 = perfcnt_halted_d1 & _T_2184; // @[el2_dec_tlu_ctl.scala 2425:65]
  wire  _T_2186 = ~_T_2185; // @[el2_dec_tlu_ctl.scala 2425:45]
  wire  _T_2189 = ~perfcnt_during_sleep[2]; // @[el2_dec_tlu_ctl.scala 2426:67]
  wire  _T_2190 = perfcnt_halted_d1 & _T_2189; // @[el2_dec_tlu_ctl.scala 2426:65]
  wire  _T_2191 = ~_T_2190; // @[el2_dec_tlu_ctl.scala 2426:45]
  wire  _T_2194 = ~perfcnt_during_sleep[3]; // @[el2_dec_tlu_ctl.scala 2427:67]
  wire  _T_2195 = perfcnt_halted_d1 & _T_2194; // @[el2_dec_tlu_ctl.scala 2427:65]
  wire  _T_2196 = ~_T_2195; // @[el2_dec_tlu_ctl.scala 2427:45]
  wire  _T_2199 = io_dec_csr_wraddr_r == 12'hb03; // @[el2_dec_tlu_ctl.scala 2433:72]
  wire  mhpmc3_wr_en0 = io_dec_csr_wen_r_mod & _T_2199; // @[el2_dec_tlu_ctl.scala 2433:43]
  wire  _T_2200 = ~perfcnt_halted; // @[el2_dec_tlu_ctl.scala 2434:23]
  wire  _T_2202 = _T_2200 | perfcnt_during_sleep[0]; // @[el2_dec_tlu_ctl.scala 2434:39]
  wire  mhpmc_inc_r_0 = _T_1309[0]; // @[el2_dec_tlu_ctl.scala 2347:24 el2_dec_tlu_ctl.scala 2352:19]
  wire  _T_2203 = |mhpmc_inc_r_0; // @[el2_dec_tlu_ctl.scala 2434:86]
  wire  mhpmc3_wr_en1 = _T_2202 & _T_2203; // @[el2_dec_tlu_ctl.scala 2434:66]
  reg [31:0] mhpmc3h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc3; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2206 = {mhpmc3h,mhpmc3}; // @[Cat.scala 29:58]
  wire [63:0] _T_2207 = {63'h0,mhpmc_inc_r_0}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc3_incr = _T_2206 + _T_2207; // @[el2_dec_tlu_ctl.scala 2438:49]
  wire  _T_2215 = io_dec_csr_wraddr_r == 12'hb83; // @[el2_dec_tlu_ctl.scala 2443:73]
  wire  mhpmc3h_wr_en0 = io_dec_csr_wen_r_mod & _T_2215; // @[el2_dec_tlu_ctl.scala 2443:44]
  wire  _T_2221 = io_dec_csr_wraddr_r == 12'hb04; // @[el2_dec_tlu_ctl.scala 2452:72]
  wire  mhpmc4_wr_en0 = io_dec_csr_wen_r_mod & _T_2221; // @[el2_dec_tlu_ctl.scala 2452:43]
  wire  _T_2224 = _T_2200 | perfcnt_during_sleep[1]; // @[el2_dec_tlu_ctl.scala 2453:39]
  wire  mhpmc_inc_r_1 = _T_1592[0]; // @[el2_dec_tlu_ctl.scala 2347:24 el2_dec_tlu_ctl.scala 2352:19]
  wire  _T_2225 = |mhpmc_inc_r_1; // @[el2_dec_tlu_ctl.scala 2453:86]
  wire  mhpmc4_wr_en1 = _T_2224 & _T_2225; // @[el2_dec_tlu_ctl.scala 2453:66]
  reg [31:0] mhpmc4h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc4; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2228 = {mhpmc4h,mhpmc4}; // @[Cat.scala 29:58]
  wire [63:0] _T_2229 = {63'h0,mhpmc_inc_r_1}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc4_incr = _T_2228 + _T_2229; // @[el2_dec_tlu_ctl.scala 2458:49]
  wire  _T_2238 = io_dec_csr_wraddr_r == 12'hb84; // @[el2_dec_tlu_ctl.scala 2462:73]
  wire  mhpmc4h_wr_en0 = io_dec_csr_wen_r_mod & _T_2238; // @[el2_dec_tlu_ctl.scala 2462:44]
  wire  _T_2244 = io_dec_csr_wraddr_r == 12'hb05; // @[el2_dec_tlu_ctl.scala 2471:72]
  wire  mhpmc5_wr_en0 = io_dec_csr_wen_r_mod & _T_2244; // @[el2_dec_tlu_ctl.scala 2471:43]
  wire  _T_2247 = _T_2200 | perfcnt_during_sleep[2]; // @[el2_dec_tlu_ctl.scala 2472:39]
  wire  mhpmc_inc_r_2 = _T_1875[0]; // @[el2_dec_tlu_ctl.scala 2347:24 el2_dec_tlu_ctl.scala 2352:19]
  wire  _T_2248 = |mhpmc_inc_r_2; // @[el2_dec_tlu_ctl.scala 2472:86]
  wire  mhpmc5_wr_en1 = _T_2247 & _T_2248; // @[el2_dec_tlu_ctl.scala 2472:66]
  reg [31:0] mhpmc5h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc5; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2251 = {mhpmc5h,mhpmc5}; // @[Cat.scala 29:58]
  wire [63:0] _T_2252 = {63'h0,mhpmc_inc_r_2}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc5_incr = _T_2251 + _T_2252; // @[el2_dec_tlu_ctl.scala 2475:49]
  wire  _T_2260 = io_dec_csr_wraddr_r == 12'hb85; // @[el2_dec_tlu_ctl.scala 2480:73]
  wire  mhpmc5h_wr_en0 = io_dec_csr_wen_r_mod & _T_2260; // @[el2_dec_tlu_ctl.scala 2480:44]
  wire  _T_2266 = io_dec_csr_wraddr_r == 12'hb06; // @[el2_dec_tlu_ctl.scala 2489:72]
  wire  mhpmc6_wr_en0 = io_dec_csr_wen_r_mod & _T_2266; // @[el2_dec_tlu_ctl.scala 2489:43]
  wire  _T_2269 = _T_2200 | perfcnt_during_sleep[3]; // @[el2_dec_tlu_ctl.scala 2490:39]
  wire  mhpmc_inc_r_3 = _T_2158[0]; // @[el2_dec_tlu_ctl.scala 2347:24 el2_dec_tlu_ctl.scala 2352:19]
  wire  _T_2270 = |mhpmc_inc_r_3; // @[el2_dec_tlu_ctl.scala 2490:86]
  wire  mhpmc6_wr_en1 = _T_2269 & _T_2270; // @[el2_dec_tlu_ctl.scala 2490:66]
  reg [31:0] mhpmc6h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc6; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2273 = {mhpmc6h,mhpmc6}; // @[Cat.scala 29:58]
  wire [63:0] _T_2274 = {63'h0,mhpmc_inc_r_3}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc6_incr = _T_2273 + _T_2274; // @[el2_dec_tlu_ctl.scala 2493:49]
  wire  _T_2282 = io_dec_csr_wraddr_r == 12'hb86; // @[el2_dec_tlu_ctl.scala 2498:73]
  wire  mhpmc6h_wr_en0 = io_dec_csr_wen_r_mod & _T_2282; // @[el2_dec_tlu_ctl.scala 2498:44]
  wire  _T_2288 = io_dec_csr_wrdata_r[9:0] > 10'h204; // @[el2_dec_tlu_ctl.scala 2509:56]
  wire  _T_2290 = |io_dec_csr_wrdata_r[31:10]; // @[el2_dec_tlu_ctl.scala 2509:102]
  wire  _T_2291 = _T_2288 | _T_2290; // @[el2_dec_tlu_ctl.scala 2509:71]
  wire  _T_2294 = io_dec_csr_wraddr_r == 12'h323; // @[el2_dec_tlu_ctl.scala 2511:70]
  wire  wr_mhpme3_r = io_dec_csr_wen_r_mod & _T_2294; // @[el2_dec_tlu_ctl.scala 2511:41]
  wire  _T_2298 = io_dec_csr_wraddr_r == 12'h324; // @[el2_dec_tlu_ctl.scala 2518:70]
  wire  wr_mhpme4_r = io_dec_csr_wen_r_mod & _T_2298; // @[el2_dec_tlu_ctl.scala 2518:41]
  wire  _T_2302 = io_dec_csr_wraddr_r == 12'h325; // @[el2_dec_tlu_ctl.scala 2525:70]
  wire  wr_mhpme5_r = io_dec_csr_wen_r_mod & _T_2302; // @[el2_dec_tlu_ctl.scala 2525:41]
  wire  _T_2306 = io_dec_csr_wraddr_r == 12'h326; // @[el2_dec_tlu_ctl.scala 2532:70]
  wire  wr_mhpme6_r = io_dec_csr_wen_r_mod & _T_2306; // @[el2_dec_tlu_ctl.scala 2532:41]
  wire  _T_2310 = io_dec_csr_wraddr_r == 12'h320; // @[el2_dec_tlu_ctl.scala 2549:77]
  wire  wr_mcountinhibit_r = io_dec_csr_wen_r_mod & _T_2310; // @[el2_dec_tlu_ctl.scala 2549:48]
  wire  _T_2322 = io_i0_valid_wb | io_exc_or_int_valid_r_d1; // @[el2_dec_tlu_ctl.scala 2564:51]
  wire  _T_2323 = _T_2322 | io_interrupt_valid_r_d1; // @[el2_dec_tlu_ctl.scala 2564:78]
  wire  _T_2324 = _T_2323 | io_dec_tlu_i0_valid_wb1; // @[el2_dec_tlu_ctl.scala 2564:104]
  wire  _T_2325 = _T_2324 | io_dec_tlu_i0_exc_valid_wb1; // @[el2_dec_tlu_ctl.scala 2564:130]
  wire  _T_2326 = _T_2325 | io_dec_tlu_int_valid_wb1; // @[el2_dec_tlu_ctl.scala 2565:32]
  reg  _T_2329; // @[el2_dec_tlu_ctl.scala 2567:62]
  wire  _T_2330 = io_i0_exception_valid_r_d1 | io_lsu_i0_exc_r_d1; // @[el2_dec_tlu_ctl.scala 2568:91]
  wire  _T_2331 = ~io_trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 2568:137]
  wire  _T_2332 = io_trigger_hit_r_d1 & _T_2331; // @[el2_dec_tlu_ctl.scala 2568:135]
  reg  _T_2334; // @[el2_dec_tlu_ctl.scala 2568:62]
  reg [4:0] _T_2335; // @[el2_dec_tlu_ctl.scala 2569:62]
  reg  _T_2336; // @[el2_dec_tlu_ctl.scala 2570:62]
  wire [31:0] _T_2342 = {io_core_id,4'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2351 = {21'h3,3'h0,io_mstatus[1],3'h0,io_mstatus[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2356 = {io_mtvec[30:1],1'h0,io_mtvec[0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_2369 = {1'h0,io_mip[5:3],16'h0,io_mip[2],3'h0,io_mip[1],3'h0,io_mip[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2382 = {1'h0,mie[5:3],16'h0,mie[2],3'h0,mie[1],3'h0,mie[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2394 = {io_mepc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2399 = {28'h0,mscause}; // @[Cat.scala 29:58]
  wire [31:0] _T_2407 = {meivt,10'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2413 = {28'h0,meicurpl}; // @[Cat.scala 29:58]
  wire [31:0] _T_2416 = {28'h0,meicidpl}; // @[Cat.scala 29:58]
  wire [31:0] _T_2419 = {28'h0,meipt}; // @[Cat.scala 29:58]
  wire [31:0] _T_2422 = {23'h0,mcgc}; // @[Cat.scala 29:58]
  wire [31:0] _T_2425 = {13'h0,_T_352,4'h0,mfdc_int[11:7],_T_355,mfdc_int[5:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_2429 = {16'h4000,io_dcsr[15:2],2'h3}; // @[Cat.scala 29:58]
  wire [31:0] _T_2431 = {io_dpc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2447 = {7'h0,dicawics[16],2'h0,dicawics[15:14],3'h0,dicawics[13:0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2450 = {30'h0,mtsel}; // @[Cat.scala 29:58]
  wire [31:0] _T_2479 = {26'h0,mfdht}; // @[Cat.scala 29:58]
  wire [31:0] _T_2482 = {30'h0,mfdhs}; // @[Cat.scala 29:58]
  wire [31:0] _T_2485 = {22'h0,mhpme3}; // @[Cat.scala 29:58]
  wire [31:0] _T_2488 = {22'h0,mhpme4}; // @[Cat.scala 29:58]
  wire [31:0] _T_2491 = {22'h0,mhpme5}; // @[Cat.scala 29:58]
  wire [31:0] _T_2494 = {22'h0,mhpme6}; // @[Cat.scala 29:58]
  wire [31:0] _T_2497 = {25'h0,temp_ncount6_2,1'h0,temp_ncount0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2500 = {30'h0,mpmc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2503 = io_csr_pkt_csr_misa ? 32'h40001104 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2504 = io_csr_pkt_csr_mvendorid ? 32'h45 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2505 = io_csr_pkt_csr_marchid ? 32'h10 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2506 = io_csr_pkt_csr_mimpid ? 32'h2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2507 = io_csr_pkt_csr_mhartid ? _T_2342 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2508 = io_csr_pkt_csr_mstatus ? _T_2351 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2509 = io_csr_pkt_csr_mtvec ? _T_2356 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2510 = io_csr_pkt_csr_mip ? _T_2369 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2511 = io_csr_pkt_csr_mie ? _T_2382 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2512 = io_csr_pkt_csr_mcyclel ? mcyclel : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2513 = io_csr_pkt_csr_mcycleh ? mcycleh_inc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2514 = io_csr_pkt_csr_minstretl ? minstretl : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2515 = io_csr_pkt_csr_minstreth ? minstreth_inc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2516 = io_csr_pkt_csr_mscratch ? mscratch : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2517 = io_csr_pkt_csr_mepc ? _T_2394 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2518 = io_csr_pkt_csr_mcause ? mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2519 = io_csr_pkt_csr_mscause ? _T_2399 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2520 = io_csr_pkt_csr_mtval ? mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2521 = io_csr_pkt_csr_mrac ? mrac : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2522 = io_csr_pkt_csr_mdseac ? mdseac : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2523 = io_csr_pkt_csr_meivt ? _T_2407 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2524 = io_csr_pkt_csr_meihap ? _T_619 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2525 = io_csr_pkt_csr_meicurpl ? _T_2413 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2526 = io_csr_pkt_csr_meicidpl ? _T_2416 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2527 = io_csr_pkt_csr_meipt ? _T_2419 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2528 = io_csr_pkt_csr_mcgc ? _T_2422 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2529 = io_csr_pkt_csr_mfdc ? _T_2425 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2530 = io_csr_pkt_csr_dcsr ? _T_2429 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2531 = io_csr_pkt_csr_dpc ? _T_2431 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2532 = io_csr_pkt_csr_dicad0 ? dicad0[31:0] : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2533 = io_csr_pkt_csr_dicad0h ? dicad0h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2534 = io_csr_pkt_csr_dicad1 ? dicad1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2535 = io_csr_pkt_csr_dicawics ? _T_2447 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2536 = io_csr_pkt_csr_mtsel ? _T_2450 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2537 = io_csr_pkt_csr_mtdata1 ? mtdata1_tsel_out : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2538 = io_csr_pkt_csr_mtdata2 ? mtdata2_tsel_out : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2539 = io_csr_pkt_csr_micect ? micect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2540 = io_csr_pkt_csr_miccmect ? miccmect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2541 = io_csr_pkt_csr_mdccmect ? mdccmect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2542 = io_csr_pkt_csr_mhpmc3 ? mhpmc3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2543 = io_csr_pkt_csr_mhpmc4 ? mhpmc4 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2544 = io_csr_pkt_csr_mhpmc5 ? mhpmc5 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2545 = io_csr_pkt_csr_mhpmc6 ? mhpmc6 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2546 = io_csr_pkt_csr_mhpmc3h ? mhpmc3h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2547 = io_csr_pkt_csr_mhpmc4h ? mhpmc4h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2548 = io_csr_pkt_csr_mhpmc5h ? mhpmc5h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2549 = io_csr_pkt_csr_mhpmc6h ? mhpmc6h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2550 = io_csr_pkt_csr_mfdht ? _T_2479 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2551 = io_csr_pkt_csr_mfdhs ? _T_2482 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2552 = io_csr_pkt_csr_mhpme3 ? _T_2485 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2553 = io_csr_pkt_csr_mhpme4 ? _T_2488 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2554 = io_csr_pkt_csr_mhpme5 ? _T_2491 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2555 = io_csr_pkt_csr_mhpme6 ? _T_2494 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2556 = io_csr_pkt_csr_mcountinhibit ? _T_2497 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2557 = io_csr_pkt_csr_mpmc ? _T_2500 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2558 = io_dec_timer_read_d ? io_dec_timer_rddata_d : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2559 = _T_2503 | _T_2504; // @[Mux.scala 27:72]
  wire [31:0] _T_2560 = _T_2559 | _T_2505; // @[Mux.scala 27:72]
  wire [31:0] _T_2561 = _T_2560 | _T_2506; // @[Mux.scala 27:72]
  wire [31:0] _T_2562 = _T_2561 | _T_2507; // @[Mux.scala 27:72]
  wire [31:0] _T_2563 = _T_2562 | _T_2508; // @[Mux.scala 27:72]
  wire [31:0] _T_2564 = _T_2563 | _T_2509; // @[Mux.scala 27:72]
  wire [31:0] _T_2565 = _T_2564 | _T_2510; // @[Mux.scala 27:72]
  wire [31:0] _T_2566 = _T_2565 | _T_2511; // @[Mux.scala 27:72]
  wire [31:0] _T_2567 = _T_2566 | _T_2512; // @[Mux.scala 27:72]
  wire [31:0] _T_2568 = _T_2567 | _T_2513; // @[Mux.scala 27:72]
  wire [31:0] _T_2569 = _T_2568 | _T_2514; // @[Mux.scala 27:72]
  wire [31:0] _T_2570 = _T_2569 | _T_2515; // @[Mux.scala 27:72]
  wire [31:0] _T_2571 = _T_2570 | _T_2516; // @[Mux.scala 27:72]
  wire [31:0] _T_2572 = _T_2571 | _T_2517; // @[Mux.scala 27:72]
  wire [31:0] _T_2573 = _T_2572 | _T_2518; // @[Mux.scala 27:72]
  wire [31:0] _T_2574 = _T_2573 | _T_2519; // @[Mux.scala 27:72]
  wire [31:0] _T_2575 = _T_2574 | _T_2520; // @[Mux.scala 27:72]
  wire [31:0] _T_2576 = _T_2575 | _T_2521; // @[Mux.scala 27:72]
  wire [31:0] _T_2577 = _T_2576 | _T_2522; // @[Mux.scala 27:72]
  wire [31:0] _T_2578 = _T_2577 | _T_2523; // @[Mux.scala 27:72]
  wire [31:0] _T_2579 = _T_2578 | _T_2524; // @[Mux.scala 27:72]
  wire [31:0] _T_2580 = _T_2579 | _T_2525; // @[Mux.scala 27:72]
  wire [31:0] _T_2581 = _T_2580 | _T_2526; // @[Mux.scala 27:72]
  wire [31:0] _T_2582 = _T_2581 | _T_2527; // @[Mux.scala 27:72]
  wire [31:0] _T_2583 = _T_2582 | _T_2528; // @[Mux.scala 27:72]
  wire [31:0] _T_2584 = _T_2583 | _T_2529; // @[Mux.scala 27:72]
  wire [31:0] _T_2585 = _T_2584 | _T_2530; // @[Mux.scala 27:72]
  wire [31:0] _T_2586 = _T_2585 | _T_2531; // @[Mux.scala 27:72]
  wire [31:0] _T_2587 = _T_2586 | _T_2532; // @[Mux.scala 27:72]
  wire [31:0] _T_2588 = _T_2587 | _T_2533; // @[Mux.scala 27:72]
  wire [31:0] _T_2589 = _T_2588 | _T_2534; // @[Mux.scala 27:72]
  wire [31:0] _T_2590 = _T_2589 | _T_2535; // @[Mux.scala 27:72]
  wire [31:0] _T_2591 = _T_2590 | _T_2536; // @[Mux.scala 27:72]
  wire [31:0] _T_2592 = _T_2591 | _T_2537; // @[Mux.scala 27:72]
  wire [31:0] _T_2593 = _T_2592 | _T_2538; // @[Mux.scala 27:72]
  wire [31:0] _T_2594 = _T_2593 | _T_2539; // @[Mux.scala 27:72]
  wire [31:0] _T_2595 = _T_2594 | _T_2540; // @[Mux.scala 27:72]
  wire [31:0] _T_2596 = _T_2595 | _T_2541; // @[Mux.scala 27:72]
  wire [31:0] _T_2597 = _T_2596 | _T_2542; // @[Mux.scala 27:72]
  wire [31:0] _T_2598 = _T_2597 | _T_2543; // @[Mux.scala 27:72]
  wire [31:0] _T_2599 = _T_2598 | _T_2544; // @[Mux.scala 27:72]
  wire [31:0] _T_2600 = _T_2599 | _T_2545; // @[Mux.scala 27:72]
  wire [31:0] _T_2601 = _T_2600 | _T_2546; // @[Mux.scala 27:72]
  wire [31:0] _T_2602 = _T_2601 | _T_2547; // @[Mux.scala 27:72]
  wire [31:0] _T_2603 = _T_2602 | _T_2548; // @[Mux.scala 27:72]
  wire [31:0] _T_2604 = _T_2603 | _T_2549; // @[Mux.scala 27:72]
  wire [31:0] _T_2605 = _T_2604 | _T_2550; // @[Mux.scala 27:72]
  wire [31:0] _T_2606 = _T_2605 | _T_2551; // @[Mux.scala 27:72]
  wire [31:0] _T_2607 = _T_2606 | _T_2552; // @[Mux.scala 27:72]
  wire [31:0] _T_2608 = _T_2607 | _T_2553; // @[Mux.scala 27:72]
  wire [31:0] _T_2609 = _T_2608 | _T_2554; // @[Mux.scala 27:72]
  wire [31:0] _T_2610 = _T_2609 | _T_2555; // @[Mux.scala 27:72]
  wire [31:0] _T_2611 = _T_2610 | _T_2556; // @[Mux.scala 27:72]
  wire [31:0] _T_2612 = _T_2611 | _T_2557; // @[Mux.scala 27:72]
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
  rvclkhdr rvclkhdr_12 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_12_io_l1clk),
    .io_clk(rvclkhdr_12_io_clk),
    .io_en(rvclkhdr_12_io_en),
    .io_scan_mode(rvclkhdr_12_io_scan_mode)
  );
  rvclkhdr rvclkhdr_13 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_13_io_l1clk),
    .io_clk(rvclkhdr_13_io_clk),
    .io_en(rvclkhdr_13_io_en),
    .io_scan_mode(rvclkhdr_13_io_scan_mode)
  );
  rvclkhdr rvclkhdr_14 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_14_io_l1clk),
    .io_clk(rvclkhdr_14_io_clk),
    .io_en(rvclkhdr_14_io_en),
    .io_scan_mode(rvclkhdr_14_io_scan_mode)
  );
  rvclkhdr rvclkhdr_15 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_15_io_l1clk),
    .io_clk(rvclkhdr_15_io_clk),
    .io_en(rvclkhdr_15_io_en),
    .io_scan_mode(rvclkhdr_15_io_scan_mode)
  );
  rvclkhdr rvclkhdr_16 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_16_io_l1clk),
    .io_clk(rvclkhdr_16_io_clk),
    .io_en(rvclkhdr_16_io_en),
    .io_scan_mode(rvclkhdr_16_io_scan_mode)
  );
  rvclkhdr rvclkhdr_17 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_17_io_l1clk),
    .io_clk(rvclkhdr_17_io_clk),
    .io_en(rvclkhdr_17_io_en),
    .io_scan_mode(rvclkhdr_17_io_scan_mode)
  );
  rvclkhdr rvclkhdr_18 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_18_io_l1clk),
    .io_clk(rvclkhdr_18_io_clk),
    .io_en(rvclkhdr_18_io_en),
    .io_scan_mode(rvclkhdr_18_io_scan_mode)
  );
  rvclkhdr rvclkhdr_19 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_19_io_l1clk),
    .io_clk(rvclkhdr_19_io_clk),
    .io_en(rvclkhdr_19_io_en),
    .io_scan_mode(rvclkhdr_19_io_scan_mode)
  );
  rvclkhdr rvclkhdr_20 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_20_io_l1clk),
    .io_clk(rvclkhdr_20_io_clk),
    .io_en(rvclkhdr_20_io_en),
    .io_scan_mode(rvclkhdr_20_io_scan_mode)
  );
  rvclkhdr rvclkhdr_21 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_21_io_l1clk),
    .io_clk(rvclkhdr_21_io_clk),
    .io_en(rvclkhdr_21_io_en),
    .io_scan_mode(rvclkhdr_21_io_scan_mode)
  );
  rvclkhdr rvclkhdr_22 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_22_io_l1clk),
    .io_clk(rvclkhdr_22_io_clk),
    .io_en(rvclkhdr_22_io_en),
    .io_scan_mode(rvclkhdr_22_io_scan_mode)
  );
  rvclkhdr rvclkhdr_23 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_23_io_l1clk),
    .io_clk(rvclkhdr_23_io_clk),
    .io_en(rvclkhdr_23_io_en),
    .io_scan_mode(rvclkhdr_23_io_scan_mode)
  );
  rvclkhdr rvclkhdr_24 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_24_io_l1clk),
    .io_clk(rvclkhdr_24_io_clk),
    .io_en(rvclkhdr_24_io_en),
    .io_scan_mode(rvclkhdr_24_io_scan_mode)
  );
  rvclkhdr rvclkhdr_25 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_25_io_l1clk),
    .io_clk(rvclkhdr_25_io_clk),
    .io_en(rvclkhdr_25_io_en),
    .io_scan_mode(rvclkhdr_25_io_scan_mode)
  );
  rvclkhdr rvclkhdr_26 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_26_io_l1clk),
    .io_clk(rvclkhdr_26_io_clk),
    .io_en(rvclkhdr_26_io_en),
    .io_scan_mode(rvclkhdr_26_io_scan_mode)
  );
  rvclkhdr rvclkhdr_27 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_27_io_l1clk),
    .io_clk(rvclkhdr_27_io_clk),
    .io_en(rvclkhdr_27_io_en),
    .io_scan_mode(rvclkhdr_27_io_scan_mode)
  );
  rvclkhdr rvclkhdr_28 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_28_io_l1clk),
    .io_clk(rvclkhdr_28_io_clk),
    .io_en(rvclkhdr_28_io_en),
    .io_scan_mode(rvclkhdr_28_io_scan_mode)
  );
  rvclkhdr rvclkhdr_29 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_29_io_l1clk),
    .io_clk(rvclkhdr_29_io_clk),
    .io_en(rvclkhdr_29_io_en),
    .io_scan_mode(rvclkhdr_29_io_scan_mode)
  );
  rvclkhdr rvclkhdr_30 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_30_io_l1clk),
    .io_clk(rvclkhdr_30_io_clk),
    .io_en(rvclkhdr_30_io_en),
    .io_scan_mode(rvclkhdr_30_io_scan_mode)
  );
  rvclkhdr rvclkhdr_31 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_31_io_l1clk),
    .io_clk(rvclkhdr_31_io_clk),
    .io_en(rvclkhdr_31_io_en),
    .io_scan_mode(rvclkhdr_31_io_scan_mode)
  );
  rvclkhdr rvclkhdr_32 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_32_io_l1clk),
    .io_clk(rvclkhdr_32_io_clk),
    .io_en(rvclkhdr_32_io_en),
    .io_scan_mode(rvclkhdr_32_io_scan_mode)
  );
  rvclkhdr rvclkhdr_33 ( // @[el2_lib.scala 508:23]
    .io_l1clk(rvclkhdr_33_io_l1clk),
    .io_clk(rvclkhdr_33_io_clk),
    .io_en(rvclkhdr_33_io_en),
    .io_scan_mode(rvclkhdr_33_io_scan_mode)
  );
  rvclkhdr rvclkhdr_34 ( // @[el2_lib.scala 483:22]
    .io_l1clk(rvclkhdr_34_io_l1clk),
    .io_clk(rvclkhdr_34_io_clk),
    .io_en(rvclkhdr_34_io_en),
    .io_scan_mode(rvclkhdr_34_io_scan_mode)
  );
  assign io_dec_tlu_ic_diag_pkt_icache_wrdata = {_T_766,dicad0[31:0]}; // @[el2_dec_tlu_ctl.scala 2233:64]
  assign io_dec_tlu_ic_diag_pkt_icache_dicawics = dicawics; // @[el2_dec_tlu_ctl.scala 2236:41]
  assign io_dec_tlu_ic_diag_pkt_icache_rd_valid = icache_rd_valid_f; // @[el2_dec_tlu_ctl.scala 2244:41]
  assign io_dec_tlu_ic_diag_pkt_icache_wr_valid = icache_wr_valid_f; // @[el2_dec_tlu_ctl.scala 2245:41]
  assign io_trigger_pkt_any_0_select = io_mtdata1_t_0[7]; // @[el2_dec_tlu_ctl.scala 2309:40]
  assign io_trigger_pkt_any_0_match_ = io_mtdata1_t_0[4]; // @[el2_dec_tlu_ctl.scala 2310:40]
  assign io_trigger_pkt_any_0_store = io_mtdata1_t_0[1]; // @[el2_dec_tlu_ctl.scala 2311:40]
  assign io_trigger_pkt_any_0_load = io_mtdata1_t_0[0]; // @[el2_dec_tlu_ctl.scala 2312:40]
  assign io_trigger_pkt_any_0_execute = io_mtdata1_t_0[2]; // @[el2_dec_tlu_ctl.scala 2313:40]
  assign io_trigger_pkt_any_0_m = io_mtdata1_t_0[3]; // @[el2_dec_tlu_ctl.scala 2314:40]
  assign io_trigger_pkt_any_0_tdata2 = mtdata2_t_0; // @[el2_dec_tlu_ctl.scala 2327:51]
  assign io_trigger_pkt_any_1_select = io_mtdata1_t_1[7]; // @[el2_dec_tlu_ctl.scala 2309:40]
  assign io_trigger_pkt_any_1_match_ = io_mtdata1_t_1[4]; // @[el2_dec_tlu_ctl.scala 2310:40]
  assign io_trigger_pkt_any_1_store = io_mtdata1_t_1[1]; // @[el2_dec_tlu_ctl.scala 2311:40]
  assign io_trigger_pkt_any_1_load = io_mtdata1_t_1[0]; // @[el2_dec_tlu_ctl.scala 2312:40]
  assign io_trigger_pkt_any_1_execute = io_mtdata1_t_1[2]; // @[el2_dec_tlu_ctl.scala 2313:40]
  assign io_trigger_pkt_any_1_m = io_mtdata1_t_1[3]; // @[el2_dec_tlu_ctl.scala 2314:40]
  assign io_trigger_pkt_any_1_tdata2 = mtdata2_t_1; // @[el2_dec_tlu_ctl.scala 2327:51]
  assign io_trigger_pkt_any_2_select = io_mtdata1_t_2[7]; // @[el2_dec_tlu_ctl.scala 2309:40]
  assign io_trigger_pkt_any_2_match_ = io_mtdata1_t_2[4]; // @[el2_dec_tlu_ctl.scala 2310:40]
  assign io_trigger_pkt_any_2_store = io_mtdata1_t_2[1]; // @[el2_dec_tlu_ctl.scala 2311:40]
  assign io_trigger_pkt_any_2_load = io_mtdata1_t_2[0]; // @[el2_dec_tlu_ctl.scala 2312:40]
  assign io_trigger_pkt_any_2_execute = io_mtdata1_t_2[2]; // @[el2_dec_tlu_ctl.scala 2313:40]
  assign io_trigger_pkt_any_2_m = io_mtdata1_t_2[3]; // @[el2_dec_tlu_ctl.scala 2314:40]
  assign io_trigger_pkt_any_2_tdata2 = mtdata2_t_2; // @[el2_dec_tlu_ctl.scala 2327:51]
  assign io_trigger_pkt_any_3_select = io_mtdata1_t_3[7]; // @[el2_dec_tlu_ctl.scala 2309:40]
  assign io_trigger_pkt_any_3_match_ = io_mtdata1_t_3[4]; // @[el2_dec_tlu_ctl.scala 2310:40]
  assign io_trigger_pkt_any_3_store = io_mtdata1_t_3[1]; // @[el2_dec_tlu_ctl.scala 2311:40]
  assign io_trigger_pkt_any_3_load = io_mtdata1_t_3[0]; // @[el2_dec_tlu_ctl.scala 2312:40]
  assign io_trigger_pkt_any_3_execute = io_mtdata1_t_3[2]; // @[el2_dec_tlu_ctl.scala 2313:40]
  assign io_trigger_pkt_any_3_m = io_mtdata1_t_3[3]; // @[el2_dec_tlu_ctl.scala 2314:40]
  assign io_trigger_pkt_any_3_tdata2 = mtdata2_t_3; // @[el2_dec_tlu_ctl.scala 2327:51]
  assign io_dec_tlu_int_valid_wb1 = _T_2336; // @[el2_dec_tlu_ctl.scala 2570:30]
  assign io_dec_tlu_i0_exc_valid_wb1 = _T_2334; // @[el2_dec_tlu_ctl.scala 2568:30]
  assign io_dec_tlu_i0_valid_wb1 = _T_2329; // @[el2_dec_tlu_ctl.scala 2567:30]
  assign io_dec_tlu_mtval_wb1 = mtval; // @[el2_dec_tlu_ctl.scala 2572:24]
  assign io_dec_tlu_exc_cause_wb1 = _T_2335; // @[el2_dec_tlu_ctl.scala 2569:30]
  assign io_dec_tlu_perfcnt0 = mhpmc_inc_r_d1_0 & _T_2181; // @[el2_dec_tlu_ctl.scala 2424:22]
  assign io_dec_tlu_perfcnt1 = mhpmc_inc_r_d1_1 & _T_2186; // @[el2_dec_tlu_ctl.scala 2425:22]
  assign io_dec_tlu_perfcnt2 = mhpmc_inc_r_d1_2 & _T_2191; // @[el2_dec_tlu_ctl.scala 2426:22]
  assign io_dec_tlu_perfcnt3 = mhpmc_inc_r_d1_3 & _T_2196; // @[el2_dec_tlu_ctl.scala 2427:22]
  assign io_dec_tlu_misc_clk_override = mcgc[8]; // @[el2_dec_tlu_ctl.scala 1797:31]
  assign io_dec_tlu_dec_clk_override = mcgc[7]; // @[el2_dec_tlu_ctl.scala 1798:31]
  assign io_dec_tlu_ifu_clk_override = mcgc[5]; // @[el2_dec_tlu_ctl.scala 1799:31]
  assign io_dec_tlu_lsu_clk_override = mcgc[4]; // @[el2_dec_tlu_ctl.scala 1800:31]
  assign io_dec_tlu_bus_clk_override = mcgc[3]; // @[el2_dec_tlu_ctl.scala 1801:31]
  assign io_dec_tlu_pic_clk_override = mcgc[2]; // @[el2_dec_tlu_ctl.scala 1802:31]
  assign io_dec_tlu_dccm_clk_override = mcgc[1]; // @[el2_dec_tlu_ctl.scala 1803:31]
  assign io_dec_tlu_icm_clk_override = mcgc[0]; // @[el2_dec_tlu_ctl.scala 1804:31]
  assign io_dec_csr_rddata_d = _T_2612 | _T_2558; // @[el2_dec_tlu_ctl.scala 2577:21]
  assign io_dec_tlu_pipelining_disable = mfdc[0]; // @[el2_dec_tlu_ctl.scala 1847:39]
  assign io_dec_tlu_wr_pause_r = _T_372 & _T_373; // @[el2_dec_tlu_ctl.scala 1856:24]
  assign io_dec_tlu_meipt = meipt; // @[el2_dec_tlu_ctl.scala 2084:19]
  assign io_dec_tlu_meicurpl = meicurpl; // @[el2_dec_tlu_ctl.scala 2048:22]
  assign io_dec_tlu_meihap = _T_619[29:0]; // @[el2_dec_tlu_ctl.scala 2034:20]
  assign io_dec_tlu_mrac_ff = mrac; // @[el2_dec_tlu_ctl.scala 1886:21]
  assign io_dec_tlu_wb_coalescing_disable = mfdc[2]; // @[el2_dec_tlu_ctl.scala 1846:39]
  assign io_dec_tlu_bpred_disable = mfdc[3]; // @[el2_dec_tlu_ctl.scala 1845:39]
  assign io_dec_tlu_sideeffect_posted_disable = mfdc[6]; // @[el2_dec_tlu_ctl.scala 1844:39]
  assign io_dec_tlu_core_ecc_disable = mfdc[8]; // @[el2_dec_tlu_ctl.scala 1843:39]
  assign io_dec_tlu_external_ldfwd_disable = mfdc[11]; // @[el2_dec_tlu_ctl.scala 1842:39]
  assign io_dec_tlu_dma_qos_prty = mfdc[18:16]; // @[el2_dec_tlu_ctl.scala 1841:39]
  assign io_dec_csr_wen_r_mod = _T_1 & _T_2; // @[el2_dec_tlu_ctl.scala 1530:23]
  assign io_fw_halt_req = _T_504 & _T_505; // @[el2_dec_tlu_ctl.scala 1921:17]
  assign io_mstatus = _T_56; // @[el2_dec_tlu_ctl.scala 1546:13]
  assign io_mstatus_mie_ns = io_mstatus[0] & _T_54; // @[el2_dec_tlu_ctl.scala 1545:20]
  assign io_dcsr = _T_704; // @[el2_dec_tlu_ctl.scala 2131:10]
  assign io_mtvec = _T_62; // @[el2_dec_tlu_ctl.scala 1558:11]
  assign io_mip = _T_68; // @[el2_dec_tlu_ctl.scala 1573:9]
  assign io_mie_ns = wr_mie_r ? _T_78 : mie; // @[el2_dec_tlu_ctl.scala 1587:12]
  assign io_npc_r = _T_163 | _T_161; // @[el2_dec_tlu_ctl.scala 1681:11]
  assign io_npc_r_d1 = _T_169; // @[el2_dec_tlu_ctl.scala 1687:14]
  assign io_mepc = _T_198; // @[el2_dec_tlu_ctl.scala 1706:10]
  assign io_mdseac_locked_ns = mdseac_en | _T_491; // @[el2_dec_tlu_ctl.scala 1904:22]
  assign io_force_halt = mfdht[0] & _T_611; // @[el2_dec_tlu_ctl.scala 2011:16]
  assign io_dpc = _T_729; // @[el2_dec_tlu_ctl.scala 2148:9]
  assign io_mtdata1_t_0 = _T_875; // @[el2_dec_tlu_ctl.scala 2304:39]
  assign io_mtdata1_t_1 = _T_876; // @[el2_dec_tlu_ctl.scala 2304:39]
  assign io_mtdata1_t_2 = _T_877; // @[el2_dec_tlu_ctl.scala 2304:39]
  assign io_mtdata1_t_3 = _T_878; // @[el2_dec_tlu_ctl.scala 2304:39]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_io_en = io_dec_csr_wen_r_mod & _T_58; // @[el2_lib.scala 511:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = wr_mcyclel_r | mcyclel_cout_in; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_2_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_2_io_en = wr_mcycleh_r | mcyclel_cout_f; // @[el2_lib.scala 511:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_3_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_3_io_en = i0_valid_no_ebreak_ecall_r | wr_minstretl_r; // @[el2_lib.scala 511:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_4_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_4_io_en = minstret_enable_f | wr_minstreth_r; // @[el2_lib.scala 511:17]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_5_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_5_io_en = io_dec_csr_wen_r_mod & _T_141; // @[el2_lib.scala 511:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_6_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_6_io_en = _T_166 | io_reset_delayed; // @[el2_lib.scala 511:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_7_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_7_io_en = _T_144 & io_dec_tlu_i0_valid_r; // @[el2_lib.scala 511:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_8_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_8_io_en = io_dec_csr_wen_r_mod & _T_327; // @[el2_lib.scala 511:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_9_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_9_io_en = io_dec_csr_wen_r_mod & _T_339; // @[el2_lib.scala 511:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_10_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_10_io_en = io_dec_csr_wen_r_mod & _T_376; // @[el2_lib.scala 511:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_11_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_11_io_en = _T_495 & _T_496; // @[el2_lib.scala 511:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_12_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_12_io_en = wr_micect_r | io_ic_perr_r_d1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_13_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_13_io_en = _T_551 | io_iccm_dma_sb_error; // @[el2_lib.scala 511:17]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_14_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_14_io_en = wr_mdccmect_r | io_lsu_single_ecc_error_r_d1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_15_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_15_io_en = io_dec_csr_wen_r_mod & _T_614; // @[el2_lib.scala 511:17]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_16_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_16_io_en = _T_635 | io_take_ext_int_start; // @[el2_lib.scala 511:17]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_17_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_17_io_en = _T_701 | io_take_nmi; // @[el2_lib.scala 511:17]
  assign rvclkhdr_17_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_18_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_18_io_en = _T_726 | dpc_capture_npc; // @[el2_lib.scala 511:17]
  assign rvclkhdr_18_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_19_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_19_io_en = _T_666 & _T_736; // @[el2_lib.scala 511:17]
  assign rvclkhdr_19_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_20_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_20_io_en = wr_dicad0_r | io_ifu_ic_debug_rd_data_valid; // @[el2_lib.scala 511:17]
  assign rvclkhdr_20_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_21_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_21_io_en = wr_dicad0h_r | io_ifu_ic_debug_rd_data_valid; // @[el2_lib.scala 511:17]
  assign rvclkhdr_21_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_22_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_22_io_en = _T_974 & _T_810; // @[el2_lib.scala 511:17]
  assign rvclkhdr_22_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_23_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_23_io_en = _T_983 & _T_819; // @[el2_lib.scala 511:17]
  assign rvclkhdr_23_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_24_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_24_io_en = _T_992 & _T_828; // @[el2_lib.scala 511:17]
  assign rvclkhdr_24_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_25_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_25_io_en = _T_1001 & _T_837; // @[el2_lib.scala 511:17]
  assign rvclkhdr_25_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_26_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_26_io_en = mhpmc3_wr_en0 | mhpmc3_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_26_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_27_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_27_io_en = mhpmc3h_wr_en0 | mhpmc3_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_27_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_28_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_28_io_en = mhpmc4_wr_en0 | mhpmc4_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_28_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_29_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_29_io_en = mhpmc4h_wr_en0 | mhpmc4_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_29_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_30_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_30_io_en = mhpmc5_wr_en0 | mhpmc5_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_30_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_31_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_31_io_en = mhpmc5h_wr_en0 | mhpmc5_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_31_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_32_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_32_io_en = mhpmc6_wr_en0 | mhpmc6_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_32_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_33_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_33_io_en = mhpmc6h_wr_en0 | mhpmc6_wr_en1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_33_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_34_io_clk = clock; // @[el2_lib.scala 484:17]
  assign rvclkhdr_34_io_en = _T_2326 | io_clk_override; // @[el2_lib.scala 485:16]
  assign rvclkhdr_34_io_scan_mode = io_scan_mode; // @[el2_lib.scala 486:23]
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
  mpmc_b = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  _T_56 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  _T_62 = _RAND_2[30:0];
  _RAND_3 = {1{`RANDOM}};
  mdccmect = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  miccmect = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  micect = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  _T_68 = _RAND_6[5:0];
  _RAND_7 = {1{`RANDOM}};
  mie = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  temp_ncount6_2 = _RAND_8[4:0];
  _RAND_9 = {1{`RANDOM}};
  temp_ncount0 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  mcyclel = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  mcyclel_cout_f = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  mcycleh = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  minstretl = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  minstret_enable_f = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  minstretl_cout_f = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  minstreth = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mscratch = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  _T_169 = _RAND_18[30:0];
  _RAND_19 = {1{`RANDOM}};
  pc_r_d1 = _RAND_19[30:0];
  _RAND_20 = {1{`RANDOM}};
  _T_198 = _RAND_20[30:0];
  _RAND_21 = {1{`RANDOM}};
  mcause = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  mscause = _RAND_22[3:0];
  _RAND_23 = {1{`RANDOM}};
  mtval = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  mcgc = _RAND_24[8:0];
  _RAND_25 = {1{`RANDOM}};
  mfdc_int = _RAND_25[14:0];
  _RAND_26 = {1{`RANDOM}};
  mrac = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  mdseac = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mfdht = _RAND_28[5:0];
  _RAND_29 = {1{`RANDOM}};
  mfdhs = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  force_halt_ctr_f = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  meivt = _RAND_31[21:0];
  _RAND_32 = {1{`RANDOM}};
  meihap = _RAND_32[7:0];
  _RAND_33 = {1{`RANDOM}};
  meicurpl = _RAND_33[3:0];
  _RAND_34 = {1{`RANDOM}};
  meicidpl = _RAND_34[3:0];
  _RAND_35 = {1{`RANDOM}};
  meipt = _RAND_35[3:0];
  _RAND_36 = {1{`RANDOM}};
  _T_704 = _RAND_36[15:0];
  _RAND_37 = {1{`RANDOM}};
  _T_729 = _RAND_37[30:0];
  _RAND_38 = {1{`RANDOM}};
  dicawics = _RAND_38[16:0];
  _RAND_39 = {3{`RANDOM}};
  dicad0 = _RAND_39[70:0];
  _RAND_40 = {1{`RANDOM}};
  dicad0h = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  _T_761 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  icache_rd_valid_f = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  icache_wr_valid_f = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  mtsel = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  _T_875 = _RAND_45[9:0];
  _RAND_46 = {1{`RANDOM}};
  _T_876 = _RAND_46[9:0];
  _RAND_47 = {1{`RANDOM}};
  _T_877 = _RAND_47[9:0];
  _RAND_48 = {1{`RANDOM}};
  _T_878 = _RAND_48[9:0];
  _RAND_49 = {1{`RANDOM}};
  mtdata2_t_0 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  mtdata2_t_1 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  mtdata2_t_2 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  mtdata2_t_3 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  mhpme3 = _RAND_53[9:0];
  _RAND_54 = {1{`RANDOM}};
  mhpme4 = _RAND_54[9:0];
  _RAND_55 = {1{`RANDOM}};
  mhpme5 = _RAND_55[9:0];
  _RAND_56 = {1{`RANDOM}};
  mhpme6 = _RAND_56[9:0];
  _RAND_57 = {1{`RANDOM}};
  mhpmc_inc_r_d1_0 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  mhpmc_inc_r_d1_1 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  mhpmc_inc_r_d1_2 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  mhpmc_inc_r_d1_3 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  perfcnt_halted_d1 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  mhpmc3h = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  mhpmc3 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  mhpmc4h = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  mhpmc4 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  mhpmc5h = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  mhpmc5 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  mhpmc6h = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  mhpmc6 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  _T_2329 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  _T_2334 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  _T_2335 = _RAND_72[4:0];
  _RAND_73 = {1{`RANDOM}};
  _T_2336 = _RAND_73[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    mpmc_b = 1'h0;
  end
  if (reset) begin
    _T_56 = 2'h0;
  end
  if (reset) begin
    _T_62 = 31'h0;
  end
  if (reset) begin
    mdccmect = 32'h0;
  end
  if (reset) begin
    miccmect = 32'h0;
  end
  if (reset) begin
    micect = 32'h0;
  end
  if (reset) begin
    _T_68 = 6'h0;
  end
  if (reset) begin
    mie = 6'h0;
  end
  if (reset) begin
    temp_ncount6_2 = 5'h0;
  end
  if (reset) begin
    temp_ncount0 = 1'h0;
  end
  if (reset) begin
    mcyclel = 32'h0;
  end
  if (reset) begin
    mcyclel_cout_f = 1'h0;
  end
  if (reset) begin
    mcycleh = 32'h0;
  end
  if (reset) begin
    minstretl = 32'h0;
  end
  if (reset) begin
    minstret_enable_f = 1'h0;
  end
  if (reset) begin
    minstretl_cout_f = 1'h0;
  end
  if (reset) begin
    minstreth = 32'h0;
  end
  if (reset) begin
    mscratch = 32'h0;
  end
  if (reset) begin
    _T_169 = 31'h0;
  end
  if (reset) begin
    pc_r_d1 = 31'h0;
  end
  if (reset) begin
    _T_198 = 31'h0;
  end
  if (reset) begin
    mcause = 32'h0;
  end
  if (reset) begin
    mscause = 4'h0;
  end
  if (reset) begin
    mtval = 32'h0;
  end
  if (reset) begin
    mcgc = 9'h0;
  end
  if (reset) begin
    mfdc_int = 15'h0;
  end
  if (reset) begin
    mrac = 32'h0;
  end
  if (reset) begin
    mdseac = 32'h0;
  end
  if (reset) begin
    mfdht = 6'h0;
  end
  if (reset) begin
    mfdhs = 2'h0;
  end
  if (reset) begin
    force_halt_ctr_f = 32'h0;
  end
  if (reset) begin
    meivt = 22'h0;
  end
  if (reset) begin
    meihap = 8'h0;
  end
  if (reset) begin
    meicurpl = 4'h0;
  end
  if (reset) begin
    meicidpl = 4'h0;
  end
  if (reset) begin
    meipt = 4'h0;
  end
  if (reset) begin
    _T_704 = 16'h0;
  end
  if (reset) begin
    _T_729 = 31'h0;
  end
  if (reset) begin
    dicawics = 17'h0;
  end
  if (reset) begin
    dicad0 = 71'h0;
  end
  if (reset) begin
    dicad0h = 32'h0;
  end
  if (reset) begin
    _T_761 = 32'h0;
  end
  if (reset) begin
    icache_rd_valid_f = 1'h0;
  end
  if (reset) begin
    icache_wr_valid_f = 1'h0;
  end
  if (reset) begin
    mtsel = 2'h0;
  end
  if (reset) begin
    _T_875 = 10'h0;
  end
  if (reset) begin
    _T_876 = 10'h0;
  end
  if (reset) begin
    _T_877 = 10'h0;
  end
  if (reset) begin
    _T_878 = 10'h0;
  end
  if (reset) begin
    mtdata2_t_0 = 32'h0;
  end
  if (reset) begin
    mtdata2_t_1 = 32'h0;
  end
  if (reset) begin
    mtdata2_t_2 = 32'h0;
  end
  if (reset) begin
    mtdata2_t_3 = 32'h0;
  end
  if (reset) begin
    mhpme3 = 10'h0;
  end
  if (reset) begin
    mhpme4 = 10'h0;
  end
  if (reset) begin
    mhpme5 = 10'h0;
  end
  if (reset) begin
    mhpme6 = 10'h0;
  end
  if (reset) begin
    mhpmc_inc_r_d1_0 = 1'h0;
  end
  if (reset) begin
    mhpmc_inc_r_d1_1 = 1'h0;
  end
  if (reset) begin
    mhpmc_inc_r_d1_2 = 1'h0;
  end
  if (reset) begin
    mhpmc_inc_r_d1_3 = 1'h0;
  end
  if (reset) begin
    perfcnt_halted_d1 = 1'h0;
  end
  if (reset) begin
    mhpmc3h = 32'h0;
  end
  if (reset) begin
    mhpmc3 = 32'h0;
  end
  if (reset) begin
    mhpmc4h = 32'h0;
  end
  if (reset) begin
    mhpmc4 = 32'h0;
  end
  if (reset) begin
    mhpmc5h = 32'h0;
  end
  if (reset) begin
    mhpmc5 = 32'h0;
  end
  if (reset) begin
    mhpmc6h = 32'h0;
  end
  if (reset) begin
    mhpmc6 = 32'h0;
  end
  if (reset) begin
    _T_2329 = 1'h0;
  end
  if (reset) begin
    _T_2334 = 1'h0;
  end
  if (reset) begin
    _T_2335 = 5'h0;
  end
  if (reset) begin
    _T_2336 = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mpmc_b <= 1'h0;
    end else if (wr_mpmc_r) begin
      mpmc_b <= _T_512;
    end else begin
      mpmc_b <= _T_513;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_56 <= 2'h0;
    end else begin
      _T_56 <= _T_48 | _T_44;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_62 <= 31'h0;
    end else begin
      _T_62 <= {io_dec_csr_wrdata_r[31:2],io_dec_csr_wrdata_r[0]};
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      mdccmect <= 32'h0;
    end else if (wr_mdccmect_r) begin
      mdccmect <= _T_527;
    end else begin
      mdccmect <= _T_571;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      miccmect <= 32'h0;
    end else if (wr_miccmect_r) begin
      miccmect <= _T_527;
    end else begin
      miccmect <= _T_550;
    end
  end
  always @(posedge rvclkhdr_12_io_l1clk or posedge reset) begin
    if (reset) begin
      micect <= 32'h0;
    end else if (wr_micect_r) begin
      micect <= _T_527;
    end else begin
      micect <= _T_529;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_68 <= 6'h0;
    end else begin
      _T_68 <= {_T_67,_T_65};
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mie <= 6'h0;
    end else begin
      mie <= io_mie_ns;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      temp_ncount6_2 <= 5'h0;
    end else if (wr_mcountinhibit_r) begin
      temp_ncount6_2 <= io_dec_csr_wrdata_r[6:2];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      temp_ncount0 <= 1'h0;
    end else if (wr_mcountinhibit_r) begin
      temp_ncount0 <= io_dec_csr_wrdata_r[0];
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      mcyclel <= 32'h0;
    end else if (wr_mcyclel_r) begin
      mcyclel <= io_dec_csr_wrdata_r;
    end else begin
      mcyclel <= mcyclel_inc[31:0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mcyclel_cout_f <= 1'h0;
    end else begin
      mcyclel_cout_f <= mcyclel_cout & _T_99;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      mcycleh <= 32'h0;
    end else if (wr_mcycleh_r) begin
      mcycleh <= io_dec_csr_wrdata_r;
    end else begin
      mcycleh <= mcycleh_inc;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      minstretl <= 32'h0;
    end else if (wr_minstretl_r) begin
      minstretl <= io_dec_csr_wrdata_r;
    end else begin
      minstretl <= minstretl_inc[31:0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      minstret_enable_f <= 1'h0;
    end else begin
      minstret_enable_f <= i0_valid_no_ebreak_ecall_r | wr_minstretl_r;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      minstretl_cout_f <= 1'h0;
    end else begin
      minstretl_cout_f <= minstretl_cout & _T_127;
    end
  end
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      minstreth <= 32'h0;
    end else if (wr_minstreth_r) begin
      minstreth <= io_dec_csr_wrdata_r;
    end else begin
      minstreth <= minstreth_inc;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      mscratch <= 32'h0;
    end else begin
      mscratch <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_169 <= 31'h0;
    end else begin
      _T_169 <= io_npc_r;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      pc_r_d1 <= 31'h0;
    end else begin
      pc_r_d1 <= _T_173 | _T_174;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      _T_198 <= 31'h0;
    end else begin
      _T_198 <= _T_196 | _T_194;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mcause <= 32'h0;
    end else begin
      mcause <= _T_236 | _T_232;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mscause <= 4'h0;
    end else begin
      mscause <= _T_266 | _T_265;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mtval <= 32'h0;
    end else begin
      mtval <= _T_323 | _T_319;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      mcgc <= 9'h0;
    end else begin
      mcgc <= io_dec_csr_wrdata_r[8:0];
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      mfdc_int <= 15'h0;
    end else begin
      mfdc_int <= {_T_349,_T_348};
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      mrac <= 32'h0;
    end else begin
      mrac <= {_T_486,_T_471};
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      mdseac <= 32'h0;
    end else begin
      mdseac <= io_lsu_imprecise_error_addr_any;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      mfdht <= 6'h0;
    end else if (wr_mfdht_r) begin
      mfdht <= io_dec_csr_wrdata_r[5:0];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      mfdhs <= 2'h0;
    end else if (_T_597) begin
      if (wr_mfdhs_r) begin
        mfdhs <= io_dec_csr_wrdata_r[1:0];
      end else if (_T_591) begin
        mfdhs <= _T_595;
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      force_halt_ctr_f <= 32'h0;
    end else if (mfdht[0]) begin
      if (io_debug_halt_req_f) begin
        force_halt_ctr_f <= _T_602;
      end else if (io_dbg_tlu_halted_f) begin
        force_halt_ctr_f <= 32'h0;
      end
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      meivt <= 22'h0;
    end else begin
      meivt <= io_dec_csr_wrdata_r[31:10];
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      meihap <= 8'h0;
    end else begin
      meihap <= io_pic_claimid;
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      meicurpl <= 4'h0;
    end else if (wr_meicurpl_r) begin
      meicurpl <= io_dec_csr_wrdata_r[3:0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      meicidpl <= 4'h0;
    end else if (wr_meicpct_r) begin
      meicidpl <= io_pic_pl;
    end else if (wr_meicidpl_r) begin
      meicidpl <= io_dec_csr_wrdata_r[3:0];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      meipt <= 4'h0;
    end else if (wr_meipt_r) begin
      meipt <= io_dec_csr_wrdata_r[3:0];
    end
  end
  always @(posedge rvclkhdr_17_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_704 <= 16'h0;
    end else if (enter_debug_halt_req_le) begin
      _T_704 <= _T_678;
    end else if (wr_dcsr_r) begin
      _T_704 <= _T_693;
    end else begin
      _T_704 <= _T_698;
    end
  end
  always @(posedge rvclkhdr_18_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_729 <= 31'h0;
    end else begin
      _T_729 <= _T_724 | _T_723;
    end
  end
  always @(posedge rvclkhdr_19_io_l1clk or posedge reset) begin
    if (reset) begin
      dicawics <= 17'h0;
    end else begin
      dicawics <= {_T_733,io_dec_csr_wrdata_r[16:3]};
    end
  end
  always @(posedge rvclkhdr_20_io_l1clk or posedge reset) begin
    if (reset) begin
      dicad0 <= 71'h0;
    end else if (wr_dicad0_r) begin
      dicad0 <= {{39'd0}, io_dec_csr_wrdata_r};
    end else begin
      dicad0 <= io_ifu_ic_debug_rd_data;
    end
  end
  always @(posedge rvclkhdr_21_io_l1clk or posedge reset) begin
    if (reset) begin
      dicad0h <= 32'h0;
    end else if (wr_dicad0h_r) begin
      dicad0h <= io_dec_csr_wrdata_r;
    end else begin
      dicad0h <= io_ifu_ic_debug_rd_data[63:32];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_761 <= 32'h0;
    end else if (_T_759) begin
      if (_T_755) begin
        _T_761 <= io_dec_csr_wrdata_r;
      end else begin
        _T_761 <= {{25'd0}, io_ifu_ic_debug_rd_data[70:64]};
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      icache_rd_valid_f <= 1'h0;
    end else begin
      icache_rd_valid_f <= _T_771 & _T_773;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      icache_wr_valid_f <= 1'h0;
    end else begin
      icache_wr_valid_f <= _T_666 & _T_776;
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mtsel <= 2'h0;
    end else if (wr_mtsel_r) begin
      mtsel <= io_dec_csr_wrdata_r[1:0];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_875 <= 10'h0;
    end else if (wr_mtdata1_t_r_0) begin
      _T_875 <= tdata_wrdata_r;
    end else begin
      _T_875 <= _T_846;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_876 <= 10'h0;
    end else if (wr_mtdata1_t_r_1) begin
      _T_876 <= tdata_wrdata_r;
    end else begin
      _T_876 <= _T_855;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_877 <= 10'h0;
    end else if (wr_mtdata1_t_r_2) begin
      _T_877 <= tdata_wrdata_r;
    end else begin
      _T_877 <= _T_864;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_878 <= 10'h0;
    end else if (wr_mtdata1_t_r_3) begin
      _T_878 <= tdata_wrdata_r;
    end else begin
      _T_878 <= _T_873;
    end
  end
  always @(posedge rvclkhdr_22_io_l1clk or posedge reset) begin
    if (reset) begin
      mtdata2_t_0 <= 32'h0;
    end else begin
      mtdata2_t_0 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge rvclkhdr_23_io_l1clk or posedge reset) begin
    if (reset) begin
      mtdata2_t_1 <= 32'h0;
    end else begin
      mtdata2_t_1 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge rvclkhdr_24_io_l1clk or posedge reset) begin
    if (reset) begin
      mtdata2_t_2 <= 32'h0;
    end else begin
      mtdata2_t_2 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge rvclkhdr_25_io_l1clk or posedge reset) begin
    if (reset) begin
      mtdata2_t_3 <= 32'h0;
    end else begin
      mtdata2_t_3 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      mhpme3 <= 10'h0;
    end else if (wr_mhpme3_r) begin
      if (_T_2291) begin
        mhpme3 <= 10'h204;
      end else begin
        mhpme3 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      mhpme4 <= 10'h0;
    end else if (wr_mhpme4_r) begin
      if (_T_2291) begin
        mhpme4 <= 10'h204;
      end else begin
        mhpme4 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      mhpme5 <= 10'h0;
    end else if (wr_mhpme5_r) begin
      if (_T_2291) begin
        mhpme5 <= 10'h204;
      end else begin
        mhpme5 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      mhpme6 <= 10'h0;
    end else if (wr_mhpme6_r) begin
      if (_T_2291) begin
        mhpme6 <= 10'h204;
      end else begin
        mhpme6 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_0 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_0 <= _T_1309[0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_1 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_1 <= _T_1592[0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_2 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_2 <= _T_1875[0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_3 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_3 <= _T_2158[0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      perfcnt_halted_d1 <= 1'h0;
    end else begin
      perfcnt_halted_d1 <= _T_85 | io_dec_tlu_pmu_fw_halted;
    end
  end
  always @(posedge rvclkhdr_27_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc3h <= 32'h0;
    end else if (mhpmc3h_wr_en0) begin
      mhpmc3h <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc3h <= mhpmc3_incr[63:32];
    end
  end
  always @(posedge rvclkhdr_26_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc3 <= 32'h0;
    end else if (mhpmc3_wr_en0) begin
      mhpmc3 <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc3 <= mhpmc3_incr[31:0];
    end
  end
  always @(posedge rvclkhdr_29_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc4h <= 32'h0;
    end else if (mhpmc4h_wr_en0) begin
      mhpmc4h <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc4h <= mhpmc4_incr[63:32];
    end
  end
  always @(posedge rvclkhdr_28_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc4 <= 32'h0;
    end else if (mhpmc4_wr_en0) begin
      mhpmc4 <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc4 <= mhpmc4_incr[31:0];
    end
  end
  always @(posedge rvclkhdr_31_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc5h <= 32'h0;
    end else if (mhpmc5h_wr_en0) begin
      mhpmc5h <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc5h <= mhpmc5_incr[63:32];
    end
  end
  always @(posedge rvclkhdr_30_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc5 <= 32'h0;
    end else if (mhpmc5_wr_en0) begin
      mhpmc5 <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc5 <= mhpmc5_incr[31:0];
    end
  end
  always @(posedge rvclkhdr_33_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc6h <= 32'h0;
    end else if (mhpmc6h_wr_en0) begin
      mhpmc6h <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc6h <= mhpmc6_incr[63:32];
    end
  end
  always @(posedge rvclkhdr_32_io_l1clk or posedge reset) begin
    if (reset) begin
      mhpmc6 <= 32'h0;
    end else if (mhpmc6_wr_en0) begin
      mhpmc6 <= io_dec_csr_wrdata_r;
    end else begin
      mhpmc6 <= mhpmc6_incr[31:0];
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2329 <= 1'h0;
    end else begin
      _T_2329 <= io_i0_valid_wb;
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2334 <= 1'h0;
    end else begin
      _T_2334 <= _T_2330 | _T_2332;
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2335 <= 5'h0;
    end else begin
      _T_2335 <= io_exc_cause_wb;
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2336 <= 1'h0;
    end else begin
      _T_2336 <= io_interrupt_valid_r_d1;
    end
  end
endmodule
module el2_dec_decode_csr_read(
  input  [11:0] io_dec_csr_rdaddr_d,
  output        io_csr_pkt_csr_misa,
  output        io_csr_pkt_csr_mvendorid,
  output        io_csr_pkt_csr_marchid,
  output        io_csr_pkt_csr_mimpid,
  output        io_csr_pkt_csr_mhartid,
  output        io_csr_pkt_csr_mstatus,
  output        io_csr_pkt_csr_mtvec,
  output        io_csr_pkt_csr_mip,
  output        io_csr_pkt_csr_mie,
  output        io_csr_pkt_csr_mcyclel,
  output        io_csr_pkt_csr_mcycleh,
  output        io_csr_pkt_csr_minstretl,
  output        io_csr_pkt_csr_minstreth,
  output        io_csr_pkt_csr_mscratch,
  output        io_csr_pkt_csr_mepc,
  output        io_csr_pkt_csr_mcause,
  output        io_csr_pkt_csr_mscause,
  output        io_csr_pkt_csr_mtval,
  output        io_csr_pkt_csr_mrac,
  output        io_csr_pkt_csr_dmst,
  output        io_csr_pkt_csr_mdseac,
  output        io_csr_pkt_csr_meihap,
  output        io_csr_pkt_csr_meivt,
  output        io_csr_pkt_csr_meipt,
  output        io_csr_pkt_csr_meicurpl,
  output        io_csr_pkt_csr_meicidpl,
  output        io_csr_pkt_csr_dcsr,
  output        io_csr_pkt_csr_mcgc,
  output        io_csr_pkt_csr_mfdc,
  output        io_csr_pkt_csr_dpc,
  output        io_csr_pkt_csr_mtsel,
  output        io_csr_pkt_csr_mtdata1,
  output        io_csr_pkt_csr_mtdata2,
  output        io_csr_pkt_csr_mhpmc3,
  output        io_csr_pkt_csr_mhpmc4,
  output        io_csr_pkt_csr_mhpmc5,
  output        io_csr_pkt_csr_mhpmc6,
  output        io_csr_pkt_csr_mhpmc3h,
  output        io_csr_pkt_csr_mhpmc4h,
  output        io_csr_pkt_csr_mhpmc5h,
  output        io_csr_pkt_csr_mhpmc6h,
  output        io_csr_pkt_csr_mhpme3,
  output        io_csr_pkt_csr_mhpme4,
  output        io_csr_pkt_csr_mhpme5,
  output        io_csr_pkt_csr_mhpme6,
  output        io_csr_pkt_csr_mcountinhibit,
  output        io_csr_pkt_csr_mitctl0,
  output        io_csr_pkt_csr_mitctl1,
  output        io_csr_pkt_csr_mitb0,
  output        io_csr_pkt_csr_mitb1,
  output        io_csr_pkt_csr_mitcnt0,
  output        io_csr_pkt_csr_mitcnt1,
  output        io_csr_pkt_csr_mpmc,
  output        io_csr_pkt_csr_meicpct,
  output        io_csr_pkt_csr_micect,
  output        io_csr_pkt_csr_miccmect,
  output        io_csr_pkt_csr_mdccmect,
  output        io_csr_pkt_csr_mfdht,
  output        io_csr_pkt_csr_mfdhs,
  output        io_csr_pkt_csr_dicawics,
  output        io_csr_pkt_csr_dicad0h,
  output        io_csr_pkt_csr_dicad0,
  output        io_csr_pkt_csr_dicad1,
  output        io_csr_pkt_csr_dicago,
  output        io_csr_pkt_presync,
  output        io_csr_pkt_postsync,
  output        io_csr_pkt_legal
);
  wire  _T_1 = ~io_dec_csr_rdaddr_d[11]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_3 = ~io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_5 = ~io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_7 = ~io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_9 = _T_1 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_10 = _T_9 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_11 = _T_10 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_15 = ~io_dec_csr_rdaddr_d[7]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_17 = ~io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_19 = io_dec_csr_rdaddr_d[10] & _T_15; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_20 = _T_19 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_27 = ~io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:165]
  wire  _T_29 = _T_19 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_36 = io_dec_csr_rdaddr_d[10] & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_37 = _T_36 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_69 = _T_10 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_70 = _T_69 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_75 = _T_15 & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_94 = ~io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_96 = ~io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_101 = io_dec_csr_rdaddr_d[11] & _T_15; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_102 = _T_101 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_103 = _T_102 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_104 = _T_103 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_119 = io_dec_csr_rdaddr_d[7] & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_120 = _T_119 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_121 = _T_120 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_122 = _T_121 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_123 = _T_122 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_138 = _T_15 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_139 = _T_138 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_140 = _T_139 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_141 = _T_140 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_142 = _T_141 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_145 = ~io_dec_csr_rdaddr_d[10]; // @[el2_dec_tlu_ctl.scala 2649:129]
  wire  _T_156 = _T_145 & io_dec_csr_rdaddr_d[7]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_157 = _T_156 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_158 = _T_157 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_159 = _T_158 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_160 = _T_159 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_172 = _T_75 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_173 = _T_172 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_182 = _T_75 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_183 = _T_182 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_191 = _T_75 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_196 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_217 = _T_1 & io_dec_csr_rdaddr_d[7]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_218 = _T_217 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_219 = _T_218 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_220 = _T_219 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_230 = io_dec_csr_rdaddr_d[10] & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_231 = _T_230 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_232 = _T_231 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_240 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[10]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_241 = _T_240 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_258 = _T_145 & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_259 = _T_258 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_260 = _T_259 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_261 = _T_260 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_268 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_269 = _T_268 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_281 = _T_268 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_291 = _T_36 & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_292 = _T_291 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_299 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_300 = _T_299 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_310 = _T_300 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_311 = _T_310 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_330 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_331 = _T_330 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_332 = _T_331 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_342 = _T_231 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_381 = _T_103 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_382 = _T_381 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_397 = _T_103 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_411 = _T_15 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_412 = _T_411 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_413 = _T_412 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_414 = _T_413 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_415 = _T_414 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_426 = io_dec_csr_rdaddr_d[7] & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_427 = _T_426 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_428 = _T_427 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_429 = _T_428 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_444 = _T_119 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_445 = _T_444 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_446 = _T_445 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_447 = _T_446 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_460 = _T_427 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_461 = _T_460 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_478 = _T_446 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_490 = _T_15 & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_491 = _T_490 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_492 = _T_491 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_493 = _T_492 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_505 = io_dec_csr_rdaddr_d[5] & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_506 = _T_505 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_507 = _T_506 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_508 = _T_507 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_536 = _T_507 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_553 = _T_493 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_562 = io_dec_csr_rdaddr_d[6] & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_563 = _T_562 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_564 = _T_563 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_572 = io_dec_csr_rdaddr_d[6] & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_573 = _T_572 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_574 = _T_573 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_585 = _T_563 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_593 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_594 = _T_593 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_595 = _T_594 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_614 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_615 = _T_614 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_624 = io_dec_csr_rdaddr_d[6] & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_625 = _T_624 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_626 = _T_625 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_668 = _T_196 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_669 = _T_668 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_685 = _T_196 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_693 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_694 = _T_693 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_695 = _T_694 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_703 = _T_624 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_716 = _T_1 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_717 = _T_716 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_718 = _T_717 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_719 = _T_718 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_726 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_727 = _T_726 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_737 = _T_230 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_738 = _T_737 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_748 = _T_726 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_749 = _T_748 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_787 = _T_311 | _T_553; // @[el2_dec_tlu_ctl.scala 2717:81]
  wire  _T_799 = _T_3 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_800 = _T_799 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_801 = _T_800 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_802 = _T_801 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_803 = _T_802 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_804 = _T_787 | _T_803; // @[el2_dec_tlu_ctl.scala 2717:121]
  wire  _T_813 = io_dec_csr_rdaddr_d[11] & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_814 = _T_813 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_815 = _T_814 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_816 = _T_815 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_817 = _T_804 | _T_816; // @[el2_dec_tlu_ctl.scala 2717:155]
  wire  _T_828 = _T_814 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_829 = _T_828 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_830 = _T_817 | _T_829; // @[el2_dec_tlu_ctl.scala 2718:97]
  wire  _T_841 = io_dec_csr_rdaddr_d[7] & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_842 = _T_841 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_843 = _T_842 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_844 = _T_843 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_845 = _T_844 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_869 = _T_311 | _T_70; // @[el2_dec_tlu_ctl.scala 2719:81]
  wire  _T_879 = _T_869 | _T_183; // @[el2_dec_tlu_ctl.scala 2719:121]
  wire  _T_889 = _T_879 | _T_342; // @[el2_dec_tlu_ctl.scala 2719:162]
  wire  _T_904 = _T_1 & _T_15; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_905 = _T_904 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_906 = _T_905 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_907 = _T_906 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_908 = _T_907 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_909 = _T_908 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_910 = _T_889 | _T_909; // @[el2_dec_tlu_ctl.scala 2720:105]
  wire  _T_922 = _T_217 & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_923 = _T_922 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_924 = _T_923 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_925 = _T_924 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_926 = _T_910 | _T_925; // @[el2_dec_tlu_ctl.scala 2720:145]
  wire  _T_937 = _T_231 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_938 = _T_937 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_955 = _T_1 & io_dec_csr_rdaddr_d[10]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_956 = _T_955 & io_dec_csr_rdaddr_d[9]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_957 = _T_956 & io_dec_csr_rdaddr_d[8]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_958 = _T_957 & io_dec_csr_rdaddr_d[7]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_959 = _T_958 & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_960 = _T_959 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_961 = _T_960 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_962 = _T_961 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_963 = _T_962 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_964 = _T_963 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_983 = _T_1 & _T_145; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_984 = _T_983 & io_dec_csr_rdaddr_d[9]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_985 = _T_984 & io_dec_csr_rdaddr_d[8]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_986 = _T_985 & _T_15; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_987 = _T_986 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_988 = _T_987 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_989 = _T_988 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_990 = _T_989 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_991 = _T_990 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_992 = _T_964 | _T_991; // @[el2_dec_tlu_ctl.scala 2722:81]
  wire  _T_1013 = _T_987 & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1014 = _T_1013 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1015 = _T_1014 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1016 = _T_992 | _T_1015; // @[el2_dec_tlu_ctl.scala 2722:129]
  wire  _T_1032 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[9]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1033 = _T_1032 & io_dec_csr_rdaddr_d[8]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1034 = _T_1033 & io_dec_csr_rdaddr_d[7]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1035 = _T_1034 & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1036 = _T_1035 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1037 = _T_1036 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1038 = _T_1037 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1039 = _T_1038 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1040 = _T_1039 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1041 = _T_1016 | _T_1040; // @[el2_dec_tlu_ctl.scala 2723:105]
  wire  _T_1053 = io_dec_csr_rdaddr_d[11] & _T_145; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1054 = _T_1053 & io_dec_csr_rdaddr_d[9]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1055 = _T_1054 & io_dec_csr_rdaddr_d[8]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1056 = _T_1055 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1057 = _T_1056 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1058 = _T_1057 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1059 = _T_1041 | _T_1058; // @[el2_dec_tlu_ctl.scala 2723:153]
  wire  _T_1078 = _T_959 & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1079 = _T_1078 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1080 = _T_1079 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1081 = _T_1080 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1082 = _T_1081 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1083 = _T_1082 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1084 = _T_1059 | _T_1083; // @[el2_dec_tlu_ctl.scala 2724:105]
  wire  _T_1105 = _T_1079 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1106 = _T_1105 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1107 = _T_1084 | _T_1106; // @[el2_dec_tlu_ctl.scala 2724:153]
  wire  _T_1125 = _T_1033 & _T_15; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1126 = _T_1125 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1127 = _T_1126 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1128 = _T_1127 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1129 = _T_1128 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1130 = _T_1129 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1131 = _T_1130 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1132 = _T_1107 | _T_1131; // @[el2_dec_tlu_ctl.scala 2725:105]
  wire  _T_1152 = _T_958 & _T_3; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1153 = _T_1152 & io_dec_csr_rdaddr_d[5]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1154 = _T_1153 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1155 = _T_1154 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1156 = _T_1155 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1157 = _T_1132 | _T_1156; // @[el2_dec_tlu_ctl.scala 2725:161]
  wire  _T_1176 = _T_1013 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1177 = _T_1157 | _T_1176; // @[el2_dec_tlu_ctl.scala 2726:105]
  wire  _T_1202 = _T_1129 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1203 = _T_1202 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1204 = _T_1203 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1205 = _T_1177 | _T_1204; // @[el2_dec_tlu_ctl.scala 2726:161]
  wire  _T_1224 = _T_959 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1225 = _T_1224 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1226 = _T_1225 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1227 = _T_1226 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1228 = _T_1205 | _T_1227; // @[el2_dec_tlu_ctl.scala 2727:97]
  wire  _T_1248 = _T_1224 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1249 = _T_1248 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1250 = _T_1249 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1251 = _T_1228 | _T_1250; // @[el2_dec_tlu_ctl.scala 2727:153]
  wire  _T_1275 = _T_1130 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1276 = _T_1251 | _T_1275; // @[el2_dec_tlu_ctl.scala 2728:105]
  wire  _T_1296 = _T_1013 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1297 = _T_1296 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1298 = _T_1276 | _T_1297; // @[el2_dec_tlu_ctl.scala 2728:161]
  wire  _T_1315 = _T_1055 & io_dec_csr_rdaddr_d[7]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1316 = _T_1315 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1317 = _T_1316 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1318 = _T_1317 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1319 = _T_1318 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1320 = _T_1298 | _T_1319; // @[el2_dec_tlu_ctl.scala 2729:105]
  wire  _T_1343 = _T_1318 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1344 = _T_1343 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1345 = _T_1320 | _T_1344; // @[el2_dec_tlu_ctl.scala 2729:161]
  wire  _T_1361 = _T_1057 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1362 = _T_1345 | _T_1361; // @[el2_dec_tlu_ctl.scala 2730:105]
  wire  _T_1384 = _T_1249 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1385 = _T_1362 | _T_1384; // @[el2_dec_tlu_ctl.scala 2730:161]
  wire  _T_1406 = _T_1225 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1407 = _T_1385 | _T_1406; // @[el2_dec_tlu_ctl.scala 2731:105]
  wire  _T_1430 = _T_1226 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1431 = _T_1407 | _T_1430; // @[el2_dec_tlu_ctl.scala 2731:161]
  wire  _T_1455 = _T_1153 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1456 = _T_1455 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1457 = _T_1456 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1458 = _T_1457 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1459 = _T_1431 | _T_1458; // @[el2_dec_tlu_ctl.scala 2732:105]
  wire  _T_1475 = _T_1057 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1476 = _T_1459 | _T_1475; // @[el2_dec_tlu_ctl.scala 2732:153]
  wire  _T_1498 = _T_986 & io_dec_csr_rdaddr_d[6]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1499 = _T_1498 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1500 = _T_1499 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1501 = _T_1500 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1502 = _T_1501 & _T_7; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1503 = _T_1476 | _T_1502; // @[el2_dec_tlu_ctl.scala 2733:113]
  wire  _T_1526 = _T_986 & _T_5; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1527 = _T_1526 & _T_94; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1528 = _T_1527 & _T_96; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1529 = _T_1528 & _T_17; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1530 = _T_1529 & _T_27; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1531 = _T_1503 | _T_1530; // @[el2_dec_tlu_ctl.scala 2733:161]
  wire  _T_1550 = _T_1013 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1551 = _T_1531 | _T_1550; // @[el2_dec_tlu_ctl.scala 2734:97]
  wire  _T_1567 = _T_1057 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1568 = _T_1551 | _T_1567; // @[el2_dec_tlu_ctl.scala 2734:153]
  wire  _T_1587 = _T_1013 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  wire  _T_1588 = _T_1568 | _T_1587; // @[el2_dec_tlu_ctl.scala 2735:113]
  wire  _T_1604 = _T_1057 & io_dec_csr_rdaddr_d[4]; // @[el2_dec_tlu_ctl.scala 2649:198]
  assign io_csr_pkt_csr_misa = _T_11 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2651:57]
  assign io_csr_pkt_csr_mvendorid = _T_20 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2652:57]
  assign io_csr_pkt_csr_marchid = _T_29 & _T_27; // @[el2_dec_tlu_ctl.scala 2653:57]
  assign io_csr_pkt_csr_mimpid = _T_37 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2654:57]
  assign io_csr_pkt_csr_mhartid = _T_19 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2655:57]
  assign io_csr_pkt_csr_mstatus = _T_11 & _T_27; // @[el2_dec_tlu_ctl.scala 2656:57]
  assign io_csr_pkt_csr_mtvec = _T_69 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2657:57]
  assign io_csr_pkt_csr_mip = _T_75 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2658:65]
  assign io_csr_pkt_csr_mie = _T_69 & _T_27; // @[el2_dec_tlu_ctl.scala 2659:65]
  assign io_csr_pkt_csr_mcyclel = _T_104 & _T_17; // @[el2_dec_tlu_ctl.scala 2660:57]
  assign io_csr_pkt_csr_mcycleh = _T_123 & _T_17; // @[el2_dec_tlu_ctl.scala 2661:57]
  assign io_csr_pkt_csr_minstretl = _T_142 & _T_27; // @[el2_dec_tlu_ctl.scala 2662:57]
  assign io_csr_pkt_csr_minstreth = _T_160 & _T_27; // @[el2_dec_tlu_ctl.scala 2663:57]
  assign io_csr_pkt_csr_mscratch = _T_173 & _T_27; // @[el2_dec_tlu_ctl.scala 2664:57]
  assign io_csr_pkt_csr_mepc = _T_182 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2665:57]
  assign io_csr_pkt_csr_mcause = _T_191 & _T_27; // @[el2_dec_tlu_ctl.scala 2666:57]
  assign io_csr_pkt_csr_mscause = _T_196 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2667:57]
  assign io_csr_pkt_csr_mtval = _T_191 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2668:57]
  assign io_csr_pkt_csr_mrac = _T_220 & _T_17; // @[el2_dec_tlu_ctl.scala 2669:57]
  assign io_csr_pkt_csr_dmst = _T_232 & _T_17; // @[el2_dec_tlu_ctl.scala 2670:57]
  assign io_csr_pkt_csr_mdseac = _T_241 & _T_96; // @[el2_dec_tlu_ctl.scala 2671:57]
  assign io_csr_pkt_csr_meihap = _T_240 & io_dec_csr_rdaddr_d[3]; // @[el2_dec_tlu_ctl.scala 2672:57]
  assign io_csr_pkt_csr_meivt = _T_261 & _T_27; // @[el2_dec_tlu_ctl.scala 2673:57]
  assign io_csr_pkt_csr_meipt = _T_269 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2674:57]
  assign io_csr_pkt_csr_meicurpl = _T_268 & io_dec_csr_rdaddr_d[2]; // @[el2_dec_tlu_ctl.scala 2675:57]
  assign io_csr_pkt_csr_meicidpl = _T_281 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2676:57]
  assign io_csr_pkt_csr_dcsr = _T_292 & _T_27; // @[el2_dec_tlu_ctl.scala 2677:57]
  assign io_csr_pkt_csr_mcgc = _T_300 & _T_27; // @[el2_dec_tlu_ctl.scala 2678:57]
  assign io_csr_pkt_csr_mfdc = _T_310 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2679:57]
  assign io_csr_pkt_csr_dpc = _T_292 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2680:65]
  assign io_csr_pkt_csr_mtsel = _T_332 & _T_27; // @[el2_dec_tlu_ctl.scala 2681:57]
  assign io_csr_pkt_csr_mtdata1 = _T_231 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2682:57]
  assign io_csr_pkt_csr_mtdata2 = _T_331 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2683:57]
  assign io_csr_pkt_csr_mhpmc3 = _T_104 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2684:57]
  assign io_csr_pkt_csr_mhpmc4 = _T_382 & _T_27; // @[el2_dec_tlu_ctl.scala 2685:57]
  assign io_csr_pkt_csr_mhpmc5 = _T_397 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2686:57]
  assign io_csr_pkt_csr_mhpmc6 = _T_415 & _T_27; // @[el2_dec_tlu_ctl.scala 2687:57]
  assign io_csr_pkt_csr_mhpmc3h = _T_429 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2688:57]
  assign io_csr_pkt_csr_mhpmc4h = _T_447 & _T_27; // @[el2_dec_tlu_ctl.scala 2689:57]
  assign io_csr_pkt_csr_mhpmc5h = _T_461 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2690:57]
  assign io_csr_pkt_csr_mhpmc6h = _T_478 & _T_27; // @[el2_dec_tlu_ctl.scala 2691:57]
  assign io_csr_pkt_csr_mhpme3 = _T_493 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2692:57]
  assign io_csr_pkt_csr_mhpme4 = _T_508 & _T_27; // @[el2_dec_tlu_ctl.scala 2693:57]
  assign io_csr_pkt_csr_mhpme5 = _T_508 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2694:57]
  assign io_csr_pkt_csr_mhpme6 = _T_536 & _T_27; // @[el2_dec_tlu_ctl.scala 2695:57]
  assign io_csr_pkt_csr_mcountinhibit = _T_493 & _T_27; // @[el2_dec_tlu_ctl.scala 2696:49]
  assign io_csr_pkt_csr_mitctl0 = _T_564 & _T_27; // @[el2_dec_tlu_ctl.scala 2697:57]
  assign io_csr_pkt_csr_mitctl1 = _T_574 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2698:57]
  assign io_csr_pkt_csr_mitb0 = _T_585 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2699:57]
  assign io_csr_pkt_csr_mitb1 = _T_595 & _T_27; // @[el2_dec_tlu_ctl.scala 2700:57]
  assign io_csr_pkt_csr_mitcnt0 = _T_585 & _T_27; // @[el2_dec_tlu_ctl.scala 2701:57]
  assign io_csr_pkt_csr_mitcnt1 = _T_615 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2702:57]
  assign io_csr_pkt_csr_mpmc = _T_626 & io_dec_csr_rdaddr_d[1]; // @[el2_dec_tlu_ctl.scala 2703:57]
  assign io_csr_pkt_csr_meicpct = _T_281 & _T_27; // @[el2_dec_tlu_ctl.scala 2705:57]
  assign io_csr_pkt_csr_micect = _T_669 & _T_27; // @[el2_dec_tlu_ctl.scala 2707:57]
  assign io_csr_pkt_csr_miccmect = _T_668 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2708:57]
  assign io_csr_pkt_csr_mdccmect = _T_685 & _T_27; // @[el2_dec_tlu_ctl.scala 2709:57]
  assign io_csr_pkt_csr_mfdht = _T_695 & _T_27; // @[el2_dec_tlu_ctl.scala 2710:57]
  assign io_csr_pkt_csr_mfdhs = _T_703 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2711:57]
  assign io_csr_pkt_csr_dicawics = _T_719 & _T_27; // @[el2_dec_tlu_ctl.scala 2712:57]
  assign io_csr_pkt_csr_dicad0h = _T_727 & _T_17; // @[el2_dec_tlu_ctl.scala 2713:57]
  assign io_csr_pkt_csr_dicad0 = _T_738 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2714:57]
  assign io_csr_pkt_csr_dicad1 = _T_749 & _T_27; // @[el2_dec_tlu_ctl.scala 2715:57]
  assign io_csr_pkt_csr_dicago = _T_749 & io_dec_csr_rdaddr_d[0]; // @[el2_dec_tlu_ctl.scala 2716:57]
  assign io_csr_pkt_presync = _T_830 | _T_845; // @[el2_dec_tlu_ctl.scala 2717:34]
  assign io_csr_pkt_postsync = _T_926 | _T_938; // @[el2_dec_tlu_ctl.scala 2719:30]
  assign io_csr_pkt_legal = _T_1588 | _T_1604; // @[el2_dec_tlu_ctl.scala 2722:26]
endmodule
module el2_dec_tlu_ctl(
  input         clock,
  input         reset,
  input         io_active_clk,
  input         io_free_clk,
  input         io_scan_mode,
  input  [30:0] io_rst_vec,
  input         io_nmi_int,
  input  [30:0] io_nmi_vec,
  input         io_i_cpu_halt_req,
  input         io_i_cpu_run_req,
  input         io_lsu_fastint_stall_any,
  input         io_ifu_pmu_instr_aligned,
  input         io_ifu_pmu_fetch_stall,
  input         io_ifu_pmu_ic_miss,
  input         io_ifu_pmu_ic_hit,
  input         io_ifu_pmu_bus_error,
  input         io_ifu_pmu_bus_busy,
  input         io_ifu_pmu_bus_trxn,
  input         io_dec_pmu_instr_decoded,
  input         io_dec_pmu_decode_stall,
  input         io_dec_pmu_presync_stall,
  input         io_dec_pmu_postsync_stall,
  input         io_lsu_store_stall_any,
  input         io_dma_dccm_stall_any,
  input         io_dma_iccm_stall_any,
  input         io_exu_pmu_i0_br_misp,
  input         io_exu_pmu_i0_br_ataken,
  input         io_exu_pmu_i0_pc4,
  input         io_lsu_pmu_bus_trxn,
  input         io_lsu_pmu_bus_misaligned,
  input         io_lsu_pmu_bus_error,
  input         io_lsu_pmu_bus_busy,
  input         io_lsu_pmu_load_external_m,
  input         io_lsu_pmu_store_external_m,
  input         io_dma_pmu_dccm_read,
  input         io_dma_pmu_dccm_write,
  input         io_dma_pmu_any_read,
  input         io_dma_pmu_any_write,
  input  [30:0] io_lsu_fir_addr,
  input  [1:0]  io_lsu_fir_error,
  input         io_iccm_dma_sb_error,
  input         io_lsu_error_pkt_r_exc_valid,
  input         io_lsu_error_pkt_r_single_ecc_error,
  input         io_lsu_error_pkt_r_inst_type,
  input         io_lsu_error_pkt_r_exc_type,
  input  [3:0]  io_lsu_error_pkt_r_mscause,
  input  [31:0] io_lsu_error_pkt_r_addr,
  input         io_lsu_single_ecc_error_incr,
  input         io_dec_pause_state,
  input         io_lsu_imprecise_error_store_any,
  input         io_lsu_imprecise_error_load_any,
  input  [31:0] io_lsu_imprecise_error_addr_any,
  input         io_dec_csr_wen_unq_d,
  input         io_dec_csr_any_unq_d,
  input  [11:0] io_dec_csr_rdaddr_d,
  input         io_dec_csr_wen_r,
  input  [11:0] io_dec_csr_wraddr_r,
  input  [31:0] io_dec_csr_wrdata_r,
  input         io_dec_csr_stall_int_ff,
  input         io_dec_tlu_i0_valid_r,
  input  [30:0] io_exu_npc_r,
  input  [30:0] io_dec_tlu_i0_pc_r,
  input         io_dec_tlu_packet_r_legal,
  input         io_dec_tlu_packet_r_icaf,
  input         io_dec_tlu_packet_r_icaf_f1,
  input  [1:0]  io_dec_tlu_packet_r_icaf_type,
  input         io_dec_tlu_packet_r_fence_i,
  input  [3:0]  io_dec_tlu_packet_r_i0trigger,
  input  [3:0]  io_dec_tlu_packet_r_pmu_i0_itype,
  input         io_dec_tlu_packet_r_pmu_i0_br_unpred,
  input         io_dec_tlu_packet_r_pmu_divide,
  input         io_dec_tlu_packet_r_pmu_lsu_misaligned,
  input  [31:0] io_dec_illegal_inst,
  input         io_dec_i0_decode_d,
  input  [1:0]  io_exu_i0_br_hist_r,
  input         io_exu_i0_br_error_r,
  input         io_exu_i0_br_start_error_r,
  input         io_exu_i0_br_valid_r,
  input         io_exu_i0_br_mp_r,
  input         io_exu_i0_br_middle_r,
  input         io_exu_i0_br_way_r,
  output        io_dec_dbg_cmd_done,
  output        io_dec_dbg_cmd_fail,
  output        io_dec_tlu_dbg_halted,
  output        io_dec_tlu_debug_mode,
  output        io_dec_tlu_resume_ack,
  output        io_dec_tlu_debug_stall,
  output        io_dec_tlu_flush_noredir_r,
  output        io_dec_tlu_mpc_halted_only,
  output        io_dec_tlu_flush_leak_one_r,
  output        io_dec_tlu_flush_err_r,
  output        io_dec_tlu_flush_extint,
  output [29:0] io_dec_tlu_meihap,
  input         io_dbg_halt_req,
  input         io_dbg_resume_req,
  input         io_ifu_miss_state_idle,
  input         io_lsu_idle_any,
  input         io_dec_div_active,
  output        io_trigger_pkt_any_0_select,
  output        io_trigger_pkt_any_0_match_,
  output        io_trigger_pkt_any_0_store,
  output        io_trigger_pkt_any_0_load,
  output        io_trigger_pkt_any_0_execute,
  output        io_trigger_pkt_any_0_m,
  output [31:0] io_trigger_pkt_any_0_tdata2,
  output        io_trigger_pkt_any_1_select,
  output        io_trigger_pkt_any_1_match_,
  output        io_trigger_pkt_any_1_store,
  output        io_trigger_pkt_any_1_load,
  output        io_trigger_pkt_any_1_execute,
  output        io_trigger_pkt_any_1_m,
  output [31:0] io_trigger_pkt_any_1_tdata2,
  output        io_trigger_pkt_any_2_select,
  output        io_trigger_pkt_any_2_match_,
  output        io_trigger_pkt_any_2_store,
  output        io_trigger_pkt_any_2_load,
  output        io_trigger_pkt_any_2_execute,
  output        io_trigger_pkt_any_2_m,
  output [31:0] io_trigger_pkt_any_2_tdata2,
  output        io_trigger_pkt_any_3_select,
  output        io_trigger_pkt_any_3_match_,
  output        io_trigger_pkt_any_3_store,
  output        io_trigger_pkt_any_3_load,
  output        io_trigger_pkt_any_3_execute,
  output        io_trigger_pkt_any_3_m,
  output [31:0] io_trigger_pkt_any_3_tdata2,
  input         io_ifu_ic_error_start,
  input         io_ifu_iccm_rd_ecc_single_err,
  input  [70:0] io_ifu_ic_debug_rd_data,
  input         io_ifu_ic_debug_rd_data_valid,
  output [70:0] io_dec_tlu_ic_diag_pkt_icache_wrdata,
  output [16:0] io_dec_tlu_ic_diag_pkt_icache_dicawics,
  output        io_dec_tlu_ic_diag_pkt_icache_rd_valid,
  output        io_dec_tlu_ic_diag_pkt_icache_wr_valid,
  input  [7:0]  io_pic_claimid,
  input  [3:0]  io_pic_pl,
  input         io_mhwakeup,
  input         io_mexintpend,
  input         io_timer_int,
  input         io_soft_int,
  output        io_o_cpu_halt_status,
  output        io_o_cpu_halt_ack,
  output        io_o_cpu_run_ack,
  output        io_o_debug_mode_status,
  input  [27:0] io_core_id,
  input         io_mpc_debug_halt_req,
  input         io_mpc_debug_run_req,
  input         io_mpc_reset_run_req,
  output        io_mpc_debug_halt_ack,
  output        io_mpc_debug_run_ack,
  output        io_debug_brkpt_status,
  output [3:0]  io_dec_tlu_meicurpl,
  output [3:0]  io_dec_tlu_meipt,
  output [31:0] io_dec_csr_rddata_d,
  output        io_dec_csr_legal_d,
  output        io_dec_tlu_br0_r_pkt_valid,
  output [1:0]  io_dec_tlu_br0_r_pkt_hist,
  output        io_dec_tlu_br0_r_pkt_br_error,
  output        io_dec_tlu_br0_r_pkt_br_start_error,
  output        io_dec_tlu_br0_r_pkt_way,
  output        io_dec_tlu_br0_r_pkt_middle,
  output        io_dec_tlu_i0_kill_writeb_wb,
  output        io_dec_tlu_flush_lower_wb,
  output        io_dec_tlu_i0_commit_cmt,
  output        io_dec_tlu_i0_kill_writeb_r,
  output        io_dec_tlu_flush_lower_r,
  output [30:0] io_dec_tlu_flush_path_r,
  output        io_dec_tlu_fence_i_r,
  output        io_dec_tlu_wr_pause_r,
  output        io_dec_tlu_flush_pause_r,
  output        io_dec_tlu_presync_d,
  output        io_dec_tlu_postsync_d,
  output [31:0] io_dec_tlu_mrac_ff,
  output        io_dec_tlu_force_halt,
  output        io_dec_tlu_perfcnt0,
  output        io_dec_tlu_perfcnt1,
  output        io_dec_tlu_perfcnt2,
  output        io_dec_tlu_perfcnt3,
  output        io_dec_tlu_i0_exc_valid_wb1,
  output        io_dec_tlu_i0_valid_wb1,
  output        io_dec_tlu_int_valid_wb1,
  output [4:0]  io_dec_tlu_exc_cause_wb1,
  output [31:0] io_dec_tlu_mtval_wb1,
  output        io_dec_tlu_external_ldfwd_disable,
  output        io_dec_tlu_sideeffect_posted_disable,
  output        io_dec_tlu_core_ecc_disable,
  output        io_dec_tlu_bpred_disable,
  output        io_dec_tlu_wb_coalescing_disable,
  output        io_dec_tlu_pipelining_disable,
  output [2:0]  io_dec_tlu_dma_qos_prty,
  output        io_dec_tlu_misc_clk_override,
  output        io_dec_tlu_dec_clk_override,
  output        io_dec_tlu_ifu_clk_override,
  output        io_dec_tlu_lsu_clk_override,
  output        io_dec_tlu_bus_clk_override,
  output        io_dec_tlu_pic_clk_override,
  output        io_dec_tlu_dccm_clk_override,
  output        io_dec_tlu_icm_clk_override
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
`endif // RANDOMIZE_REG_INIT
  wire  int_timers_clock; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_reset; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_free_clk; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_scan_mode; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_dec_csr_wen_r_mod; // @[el2_dec_tlu_ctl.scala 355:30]
  wire [11:0] int_timers_io_dec_csr_wraddr_r; // @[el2_dec_tlu_ctl.scala 355:30]
  wire [31:0] int_timers_io_dec_csr_wrdata_r; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_csr_mitctl0; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_csr_mitctl1; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_csr_mitb0; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_csr_mitb1; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_csr_mitcnt0; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_csr_mitcnt1; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_dec_pause_state; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_dec_tlu_pmu_fw_halted; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_internal_dbg_halt_timers; // @[el2_dec_tlu_ctl.scala 355:30]
  wire [31:0] int_timers_io_dec_timer_rddata_d; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_dec_timer_read_d; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_dec_timer_t0_pulse; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  int_timers_io_dec_timer_t1_pulse; // @[el2_dec_tlu_ctl.scala 355:30]
  wire  rvclkhdr_io_l1clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_io_clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_io_en; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_io_scan_mode; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_1_io_l1clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_1_io_clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_1_io_en; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_1_io_scan_mode; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_2_io_l1clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_2_io_clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_2_io_en; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_2_io_scan_mode; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_3_io_l1clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_3_io_clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_3_io_en; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_3_io_scan_mode; // @[el2_lib.scala 483:22]
  wire  csr_clock; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_reset; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_free_clk; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_active_clk; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_scan_mode; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_dec_csr_wrdata_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [11:0] csr_io_dec_csr_wraddr_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [11:0] csr_io_dec_csr_rdaddr_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_csr_wen_unq_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_i0_decode_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [70:0] csr_io_dec_tlu_ic_diag_pkt_icache_wrdata; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [16:0] csr_io_dec_tlu_ic_diag_pkt_icache_dicawics; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_ic_debug_rd_data_valid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_0_select; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_0_match_; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_0_store; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_0_load; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_0_execute; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_0_m; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_trigger_pkt_any_0_tdata2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_1_select; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_1_match_; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_1_store; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_1_load; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_1_execute; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_1_m; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_trigger_pkt_any_1_tdata2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_2_select; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_2_match_; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_2_store; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_2_load; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_2_execute; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_2_m; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_trigger_pkt_any_2_tdata2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_3_select; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_3_match_; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_3_store; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_3_load; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_3_execute; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_pkt_any_3_m; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_trigger_pkt_any_3_tdata2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_bus_trxn; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dma_iccm_stall_any; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dma_dccm_stall_any; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_store_stall_any; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_pmu_presync_stall; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_pmu_postsync_stall; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_pmu_decode_stall; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_fetch_stall; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [1:0] csr_io_dec_tlu_packet_r_icaf_type; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [3:0] csr_io_dec_tlu_packet_r_pmu_i0_itype; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_packet_r_pmu_divide; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_exu_pmu_i0_br_ataken; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_exu_pmu_i0_br_misp; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_pmu_instr_decoded; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_instr_aligned; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_exu_pmu_i0_pc4; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_ic_miss; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_ic_hit; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_int_valid_wb1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_i0_exc_valid_wb1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_i0_valid_wb1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_csr_wen_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_dec_tlu_mtval_wb1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [4:0] csr_io_dec_tlu_exc_cause_wb1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_perfcnt0; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_perfcnt1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_perfcnt2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_perfcnt3; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dma_pmu_dccm_write; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dma_pmu_dccm_read; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dma_pmu_any_write; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dma_pmu_any_read; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_pmu_bus_busy; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_dec_tlu_i0_pc_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_csr_any_unq_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_misc_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_dec_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_ifu_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_lsu_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_bus_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_pic_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_dccm_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_icm_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_dec_csr_rddata_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_pipelining_disable; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_wr_pause_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_bus_busy; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_pmu_bus_error; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_pmu_bus_error; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_pmu_bus_misaligned; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_pmu_bus_trxn; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [70:0] csr_io_ifu_ic_debug_rd_data; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [3:0] csr_io_dec_tlu_meipt; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [3:0] csr_io_pic_pl; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [3:0] csr_io_dec_tlu_meicurpl; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [29:0] csr_io_dec_tlu_meihap; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [7:0] csr_io_pic_claimid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_iccm_dma_sb_error; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_lsu_imprecise_error_addr_any; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_imprecise_error_load_any; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_imprecise_error_store_any; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_dec_tlu_mrac_ff; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_wb_coalescing_disable; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_bpred_disable; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_sideeffect_posted_disable; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_core_ecc_disable; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_external_ldfwd_disable; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [2:0] csr_io_dec_tlu_dma_qos_prty; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_dec_illegal_inst; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [3:0] csr_io_lsu_error_pkt_r_mscause; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mexintpend; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_exu_npc_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mpc_reset_run_req; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_rst_vec; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [27:0] csr_io_core_id; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_dec_timer_rddata_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_timer_read_d; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_csr_wen_r_mod; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_rfpc_i0_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_i0_trigger_hit_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_fw_halt_req; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [1:0] csr_io_mstatus; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_exc_or_int_valid_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mret_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mstatus_mie_ns; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dcsr_single_step_running_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [15:0] csr_io_dcsr; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_mtvec; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [5:0] csr_io_mip; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_timer_t0_pulse; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_timer_t1_pulse; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_timer_int_sync; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_soft_int_sync; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [5:0] csr_io_mie_ns; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_wr_clk; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ebreak_to_debug_mode_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_pmu_fw_halted; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [1:0] csr_io_lsu_fir_error; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_npc_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_flush_noredir_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_tlu_flush_path_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_npc_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_reset_delayed; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_mepc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_interrupt_valid_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_i0_exception_valid_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mepc_trigger_hit_sel_pc_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_e4e5_int_clk; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_i0_exc_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_inst_acc_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_inst_acc_second_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_take_nmi; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [31:0] csr_io_lsu_error_pkt_addr_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [4:0] csr_io_exc_cause_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_i0_valid_wb; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_exc_or_int_valid_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_interrupt_valid_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_clk_override; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_i0_exception_valid_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_i0_exc_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [4:0] csr_io_exc_cause_wb; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_nmi_lsu_store_type; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_nmi_lsu_load_type; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_tlu_i0_commit_cmt; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ebreak_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ecall_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_illegal_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mdseac_locked_ns; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_mdseac_locked_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_nmi_int_detected_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_internal_dbg_halt_mode_f2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ic_perr_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_iccm_sbecc_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_single_ecc_error_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ifu_miss_state_idle_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_idle_any_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dbg_tlu_halted; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_debug_halt_req_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_force_halt; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_take_ext_int_start; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_trigger_hit_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_debug_halt_req; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_allow_dbg_halt_csr_write; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_internal_dbg_halt_mode_f; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_enter_debug_halt_req; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_internal_dbg_halt_mode; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_request_debug_mode_done; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_request_debug_mode_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [30:0] csr_io_dpc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [3:0] csr_io_update_hit_bit_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_take_timer_int; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_take_int_timer0_int; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_take_int_timer1_int; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_take_ext_int; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_tlu_flush_lower_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_br0_error_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_dec_tlu_br0_start_error_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_pmu_load_external_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_lsu_pmu_store_external_r; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_misa; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mvendorid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_marchid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mimpid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhartid; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mstatus; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mtvec; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mip; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mie; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mcyclel; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mcycleh; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_minstretl; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_minstreth; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mscratch; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mepc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mcause; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mscause; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mtval; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mrac; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mdseac; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_meihap; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_meivt; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_meipt; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_meicurpl; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_meicidpl; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_dcsr; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mcgc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mfdc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_dpc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mtsel; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mtdata1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mtdata2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc3; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc4; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc5; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc6; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc3h; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc4h; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc5h; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpmc6h; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpme3; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpme4; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpme5; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mhpme6; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mcountinhibit; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mpmc; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_micect; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_miccmect; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mdccmect; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mfdht; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_mfdhs; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_dicawics; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_dicad0h; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_dicad0; // @[el2_dec_tlu_ctl.scala 897:15]
  wire  csr_io_csr_pkt_csr_dicad1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [9:0] csr_io_mtdata1_t_0; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [9:0] csr_io_mtdata1_t_1; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [9:0] csr_io_mtdata1_t_2; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [9:0] csr_io_mtdata1_t_3; // @[el2_dec_tlu_ctl.scala 897:15]
  wire [11:0] csr_read_io_dec_csr_rdaddr_d; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_misa; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mvendorid; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_marchid; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mimpid; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhartid; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mstatus; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mtvec; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mip; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mie; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mcyclel; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mcycleh; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_minstretl; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_minstreth; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mscratch; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mepc; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mcause; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mscause; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mtval; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mrac; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dmst; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mdseac; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_meihap; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_meivt; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_meipt; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_meicurpl; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_meicidpl; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dcsr; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mcgc; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mfdc; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dpc; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mtsel; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mtdata1; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mtdata2; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc3; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc4; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc5; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc6; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc3h; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc4h; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc5h; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc6h; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpme3; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpme4; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpme5; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mhpme6; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mcountinhibit; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mitctl0; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mitctl1; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mitb0; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mitb1; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mitcnt0; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mitcnt1; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mpmc; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_meicpct; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_micect; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_miccmect; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mdccmect; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mfdht; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_mfdhs; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dicawics; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dicad0h; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dicad0; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dicad1; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_csr_dicago; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_presync; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_postsync; // @[el2_dec_tlu_ctl.scala 1090:22]
  wire  csr_read_io_csr_pkt_legal; // @[el2_dec_tlu_ctl.scala 1090:22]
  reg  dbg_halt_state_f; // @[el2_dec_tlu_ctl.scala 447:89]
  wire  _T = ~dbg_halt_state_f; // @[el2_dec_tlu_ctl.scala 354:39]
  reg  mpc_halt_state_f; // @[el2_dec_tlu_ctl.scala 442:89]
  wire [2:0] _T_3 = {io_i_cpu_run_req,io_mpc_debug_halt_req,io_mpc_debug_run_req}; // @[Cat.scala 29:58]
  wire [3:0] _T_6 = {io_nmi_int,io_timer_int,io_soft_int,io_i_cpu_halt_req}; // @[Cat.scala 29:58]
  reg [6:0] _T_8; // @[el2_lib.scala 176:81]
  reg [6:0] syncro_ff; // @[el2_lib.scala 176:58]
  wire  nmi_int_sync = syncro_ff[6]; // @[el2_dec_tlu_ctl.scala 382:67]
  wire  i_cpu_halt_req_sync = syncro_ff[3]; // @[el2_dec_tlu_ctl.scala 385:59]
  wire  i_cpu_run_req_sync = syncro_ff[2]; // @[el2_dec_tlu_ctl.scala 386:59]
  wire  mpc_debug_halt_req_sync_raw = syncro_ff[1]; // @[el2_dec_tlu_ctl.scala 387:51]
  wire  mpc_debug_run_req_sync = syncro_ff[0]; // @[el2_dec_tlu_ctl.scala 388:51]
  wire  dec_csr_wen_r_mod = csr_io_dec_csr_wen_r_mod; // @[el2_dec_tlu_ctl.scala 1083:31]
  reg  lsu_exc_valid_r_d1; // @[el2_dec_tlu_ctl.scala 693:74]
  wire  _T_11 = io_lsu_error_pkt_r_exc_valid | lsu_exc_valid_r_d1; // @[el2_dec_tlu_ctl.scala 392:71]
  reg  e5_valid; // @[el2_dec_tlu_ctl.scala 404:97]
  wire  e4e5_valid = io_dec_tlu_i0_valid_r | e5_valid; // @[el2_dec_tlu_ctl.scala 395:30]
  reg  debug_mode_status; // @[el2_dec_tlu_ctl.scala 405:81]
  reg  i_cpu_run_req_d1_raw; // @[el2_dec_tlu_ctl.scala 653:80]
  reg  nmi_int_delayed; // @[el2_dec_tlu_ctl.scala 420:72]
  wire  _T_37 = ~nmi_int_delayed; // @[el2_dec_tlu_ctl.scala 429:45]
  wire  _T_38 = nmi_int_sync & _T_37; // @[el2_dec_tlu_ctl.scala 429:43]
  reg  mdseac_locked_f; // @[el2_dec_tlu_ctl.scala 686:89]
  wire  _T_35 = ~mdseac_locked_f; // @[el2_dec_tlu_ctl.scala 427:32]
  wire  _T_36 = io_lsu_imprecise_error_load_any | io_lsu_imprecise_error_store_any; // @[el2_dec_tlu_ctl.scala 427:84]
  wire  nmi_lsu_detected = _T_35 & _T_36; // @[el2_dec_tlu_ctl.scala 427:49]
  wire  _T_39 = _T_38 | nmi_lsu_detected; // @[el2_dec_tlu_ctl.scala 429:63]
  reg  nmi_int_detected_f; // @[el2_dec_tlu_ctl.scala 421:72]
  reg  take_nmi_r_d1; // @[el2_dec_tlu_ctl.scala 894:98]
  wire  _T_40 = ~take_nmi_r_d1; // @[el2_dec_tlu_ctl.scala 429:106]
  wire  _T_41 = nmi_int_detected_f & _T_40; // @[el2_dec_tlu_ctl.scala 429:104]
  wire  _T_42 = _T_39 | _T_41; // @[el2_dec_tlu_ctl.scala 429:82]
  reg  take_ext_int_start_d3; // @[el2_dec_tlu_ctl.scala 826:62]
  wire  _T_43 = |io_lsu_fir_error; // @[el2_dec_tlu_ctl.scala 429:165]
  wire  _T_44 = take_ext_int_start_d3 & _T_43; // @[el2_dec_tlu_ctl.scala 429:146]
  wire  nmi_int_detected = _T_42 | _T_44; // @[el2_dec_tlu_ctl.scala 429:122]
  wire  _T_631 = ~io_dec_csr_stall_int_ff; // @[el2_dec_tlu_ctl.scala 803:23]
  wire  mstatus_mie_ns = csr_io_mstatus_mie_ns; // @[el2_dec_tlu_ctl.scala 1082:31]
  wire  _T_632 = _T_631 & mstatus_mie_ns; // @[el2_dec_tlu_ctl.scala 803:48]
  wire [5:0] mip = csr_io_mip; // @[el2_dec_tlu_ctl.scala 1088:31]
  wire  _T_634 = _T_632 & mip[1]; // @[el2_dec_tlu_ctl.scala 803:65]
  wire [5:0] mie_ns = csr_io_mie_ns; // @[el2_dec_tlu_ctl.scala 1077:31]
  wire  timer_int_ready = _T_634 & mie_ns[1]; // @[el2_dec_tlu_ctl.scala 803:83]
  wire  _T_391 = nmi_int_detected | timer_int_ready; // @[el2_dec_tlu_ctl.scala 680:66]
  wire  _T_628 = _T_632 & mip[0]; // @[el2_dec_tlu_ctl.scala 802:65]
  wire  soft_int_ready = _T_628 & mie_ns[0]; // @[el2_dec_tlu_ctl.scala 802:83]
  wire  _T_392 = _T_391 | soft_int_ready; // @[el2_dec_tlu_ctl.scala 680:84]
  reg  int_timer0_int_hold_f; // @[el2_dec_tlu_ctl.scala 660:73]
  wire  _T_393 = _T_392 | int_timer0_int_hold_f; // @[el2_dec_tlu_ctl.scala 680:101]
  reg  int_timer1_int_hold_f; // @[el2_dec_tlu_ctl.scala 661:73]
  wire  _T_394 = _T_393 | int_timer1_int_hold_f; // @[el2_dec_tlu_ctl.scala 680:125]
  wire  _T_608 = _T_632 & mip[2]; // @[el2_dec_tlu_ctl.scala 799:66]
  wire  mhwakeup_ready = _T_608 & mie_ns[2]; // @[el2_dec_tlu_ctl.scala 799:84]
  wire  _T_395 = io_mhwakeup & mhwakeup_ready; // @[el2_dec_tlu_ctl.scala 680:164]
  wire  _T_396 = _T_394 | _T_395; // @[el2_dec_tlu_ctl.scala 680:149]
  wire  _T_397 = _T_396 & io_o_cpu_halt_status; // @[el2_dec_tlu_ctl.scala 680:183]
  reg  i_cpu_halt_req_d1; // @[el2_dec_tlu_ctl.scala 652:80]
  wire  _T_398 = ~i_cpu_halt_req_d1; // @[el2_dec_tlu_ctl.scala 680:208]
  wire  _T_399 = _T_397 & _T_398; // @[el2_dec_tlu_ctl.scala 680:206]
  wire  i_cpu_run_req_d1 = i_cpu_run_req_d1_raw | _T_399; // @[el2_dec_tlu_ctl.scala 680:45]
  wire  _T_14 = debug_mode_status | i_cpu_run_req_d1; // @[el2_dec_tlu_ctl.scala 396:50]
  wire  _T_685 = ~_T_43; // @[el2_dec_tlu_ctl.scala 831:49]
  wire  take_ext_int = take_ext_int_start_d3 & _T_685; // @[el2_dec_tlu_ctl.scala 831:47]
  wire  _T_698 = ~soft_int_ready; // @[el2_dec_tlu_ctl.scala 848:40]
  wire  _T_699 = timer_int_ready & _T_698; // @[el2_dec_tlu_ctl.scala 848:38]
  wire  _T_617 = ~io_lsu_fastint_stall_any; // @[el2_dec_tlu_ctl.scala 800:104]
  wire  ext_int_ready = mhwakeup_ready & _T_617; // @[el2_dec_tlu_ctl.scala 800:102]
  wire  _T_700 = ~ext_int_ready; // @[el2_dec_tlu_ctl.scala 848:58]
  wire  _T_701 = _T_699 & _T_700; // @[el2_dec_tlu_ctl.scala 848:56]
  wire  _T_622 = _T_632 & mip[5]; // @[el2_dec_tlu_ctl.scala 801:65]
  wire  ce_int_ready = _T_622 & mie_ns[5]; // @[el2_dec_tlu_ctl.scala 801:83]
  wire  _T_702 = ~ce_int_ready; // @[el2_dec_tlu_ctl.scala 848:75]
  wire  _T_703 = _T_701 & _T_702; // @[el2_dec_tlu_ctl.scala 848:73]
  wire  _T_152 = ~debug_mode_status; // @[el2_dec_tlu_ctl.scala 503:37]
  reg  dbg_halt_req_held; // @[el2_dec_tlu_ctl.scala 546:81]
  wire  _T_106 = io_dbg_halt_req | dbg_halt_req_held; // @[el2_dec_tlu_ctl.scala 480:48]
  reg  ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 827:66]
  wire  _T_107 = ~ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 480:71]
  wire  dbg_halt_req_final = _T_106 & _T_107; // @[el2_dec_tlu_ctl.scala 480:69]
  wire  mpc_debug_halt_req_sync = mpc_debug_halt_req_sync_raw & _T_107; // @[el2_dec_tlu_ctl.scala 439:67]
  wire  _T_109 = dbg_halt_req_final | mpc_debug_halt_req_sync; // @[el2_dec_tlu_ctl.scala 483:50]
  reg  reset_detect; // @[el2_dec_tlu_ctl.scala 416:88]
  reg  reset_detected; // @[el2_dec_tlu_ctl.scala 417:88]
  wire  reset_delayed = reset_detect ^ reset_detected; // @[el2_dec_tlu_ctl.scala 418:64]
  wire  _T_110 = ~io_mpc_reset_run_req; // @[el2_dec_tlu_ctl.scala 483:95]
  wire  _T_111 = reset_delayed & _T_110; // @[el2_dec_tlu_ctl.scala 483:93]
  wire  _T_112 = _T_109 | _T_111; // @[el2_dec_tlu_ctl.scala 483:76]
  wire  _T_114 = _T_112 & _T_152; // @[el2_dec_tlu_ctl.scala 483:119]
  wire  debug_halt_req = _T_114 & _T_107; // @[el2_dec_tlu_ctl.scala 483:147]
  wire  _T_153 = _T_152 & debug_halt_req; // @[el2_dec_tlu_ctl.scala 503:63]
  reg  dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 538:81]
  wire  _T_154 = _T_153 | dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 503:81]
  reg  trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 537:81]
  wire  _T_155 = _T_154 | trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 503:107]
  reg  ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 752:64]
  wire  enter_debug_halt_req = _T_155 | ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 503:132]
  reg  debug_halt_req_f; // @[el2_dec_tlu_ctl.scala 535:89]
  wire  force_halt = csr_io_force_halt; // @[el2_dec_tlu_ctl.scala 1080:31]
  reg  lsu_idle_any_f; // @[el2_dec_tlu_ctl.scala 531:89]
  wire  _T_142 = io_lsu_idle_any & lsu_idle_any_f; // @[el2_dec_tlu_ctl.scala 497:53]
  wire  _T_143 = _T_142 & io_ifu_miss_state_idle; // @[el2_dec_tlu_ctl.scala 497:70]
  reg  ifu_miss_state_idle_f; // @[el2_dec_tlu_ctl.scala 532:81]
  wire  _T_144 = _T_143 & ifu_miss_state_idle_f; // @[el2_dec_tlu_ctl.scala 497:95]
  wire  _T_145 = ~debug_halt_req; // @[el2_dec_tlu_ctl.scala 497:121]
  wire  _T_146 = _T_144 & _T_145; // @[el2_dec_tlu_ctl.scala 497:119]
  reg  debug_halt_req_d1; // @[el2_dec_tlu_ctl.scala 539:89]
  wire  _T_147 = ~debug_halt_req_d1; // @[el2_dec_tlu_ctl.scala 497:139]
  wire  _T_148 = _T_146 & _T_147; // @[el2_dec_tlu_ctl.scala 497:137]
  wire  _T_149 = ~io_dec_div_active; // @[el2_dec_tlu_ctl.scala 497:160]
  wire  _T_150 = _T_148 & _T_149; // @[el2_dec_tlu_ctl.scala 497:158]
  wire  core_empty = force_halt | _T_150; // @[el2_dec_tlu_ctl.scala 497:34]
  wire  _T_163 = debug_halt_req_f & core_empty; // @[el2_dec_tlu_ctl.scala 513:48]
  reg  dec_tlu_flush_noredir_r_d1; // @[el2_dec_tlu_ctl.scala 529:81]
  reg  dec_tlu_flush_pause_r_d1; // @[el2_dec_tlu_ctl.scala 545:73]
  wire  _T_132 = ~dec_tlu_flush_pause_r_d1; // @[el2_dec_tlu_ctl.scala 493:56]
  wire  _T_133 = dec_tlu_flush_noredir_r_d1 & _T_132; // @[el2_dec_tlu_ctl.scala 493:54]
  reg  take_ext_int_start_d1; // @[el2_dec_tlu_ctl.scala 824:62]
  wire  _T_134 = ~take_ext_int_start_d1; // @[el2_dec_tlu_ctl.scala 493:84]
  wire  _T_135 = _T_133 & _T_134; // @[el2_dec_tlu_ctl.scala 493:82]
  reg  halt_taken_f; // @[el2_dec_tlu_ctl.scala 530:89]
  reg  dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 533:89]
  wire  _T_136 = ~dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 493:126]
  wire  _T_137 = halt_taken_f & _T_136; // @[el2_dec_tlu_ctl.scala 493:124]
  reg  pmu_fw_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 659:73]
  wire  _T_138 = ~pmu_fw_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 493:146]
  wire  _T_139 = _T_137 & _T_138; // @[el2_dec_tlu_ctl.scala 493:144]
  reg  interrupt_valid_r_d1; // @[el2_dec_tlu_ctl.scala 888:90]
  wire  _T_140 = ~interrupt_valid_r_d1; // @[el2_dec_tlu_ctl.scala 493:169]
  wire  _T_141 = _T_139 & _T_140; // @[el2_dec_tlu_ctl.scala 493:167]
  wire  halt_taken = _T_135 | _T_141; // @[el2_dec_tlu_ctl.scala 493:108]
  wire  _T_164 = _T_163 & halt_taken; // @[el2_dec_tlu_ctl.scala 513:61]
  reg  debug_resume_req_f; // @[el2_dec_tlu_ctl.scala 536:89]
  wire  _T_165 = ~debug_resume_req_f; // @[el2_dec_tlu_ctl.scala 513:97]
  wire  _T_166 = dbg_tlu_halted_f & _T_165; // @[el2_dec_tlu_ctl.scala 513:95]
  wire  dbg_tlu_halted = _T_164 | _T_166; // @[el2_dec_tlu_ctl.scala 513:75]
  wire  _T_167 = ~dbg_tlu_halted; // @[el2_dec_tlu_ctl.scala 514:73]
  wire  _T_168 = debug_halt_req_f & _T_167; // @[el2_dec_tlu_ctl.scala 514:71]
  wire  debug_halt_req_ns = enter_debug_halt_req | _T_168; // @[el2_dec_tlu_ctl.scala 514:51]
  wire [15:0] dcsr = csr_io_dcsr; // @[el2_dec_tlu_ctl.scala 1086:31]
  wire  _T_157 = ~dcsr[2]; // @[el2_dec_tlu_ctl.scala 506:106]
  wire  _T_158 = debug_resume_req_f & _T_157; // @[el2_dec_tlu_ctl.scala 506:104]
  wire  _T_159 = ~_T_158; // @[el2_dec_tlu_ctl.scala 506:83]
  wire  _T_160 = debug_mode_status & _T_159; // @[el2_dec_tlu_ctl.scala 506:81]
  wire  internal_dbg_halt_mode = debug_halt_req_ns | _T_160; // @[el2_dec_tlu_ctl.scala 506:53]
  wire  _T_177 = debug_resume_req_f & dcsr[2]; // @[el2_dec_tlu_ctl.scala 519:60]
  reg  dcsr_single_step_running_f; // @[el2_dec_tlu_ctl.scala 544:73]
  wire  _T_178 = ~dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 519:111]
  wire  _T_179 = dcsr_single_step_running_f & _T_178; // @[el2_dec_tlu_ctl.scala 519:109]
  wire  dcsr_single_step_running = _T_177 | _T_179; // @[el2_dec_tlu_ctl.scala 519:79]
  wire  _T_665 = ~dcsr_single_step_running; // @[el2_dec_tlu_ctl.scala 820:55]
  wire  _T_666 = _T_665 | io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 820:81]
  wire  _T_667 = internal_dbg_halt_mode & _T_666; // @[el2_dec_tlu_ctl.scala 820:52]
  wire  _T_346 = ~io_dec_tlu_debug_mode; // @[el2_dec_tlu_ctl.scala 649:62]
  wire  _T_347 = i_cpu_halt_req_sync & _T_346; // @[el2_dec_tlu_ctl.scala 649:60]
  wire  i_cpu_halt_req_sync_qual = _T_347 & _T_107; // @[el2_dec_tlu_ctl.scala 649:85]
  wire  ext_halt_pulse = i_cpu_halt_req_sync_qual & _T_398; // @[el2_dec_tlu_ctl.scala 665:50]
  wire  fw_halt_req = csr_io_fw_halt_req; // @[el2_dec_tlu_ctl.scala 1084:31]
  wire  enter_pmu_fw_halt_req = ext_halt_pulse | fw_halt_req; // @[el2_dec_tlu_ctl.scala 666:48]
  reg  pmu_fw_halt_req_f; // @[el2_dec_tlu_ctl.scala 658:73]
  wire  _T_371 = pmu_fw_halt_req_f & core_empty; // @[el2_dec_tlu_ctl.scala 671:45]
  wire  _T_372 = _T_371 & halt_taken; // @[el2_dec_tlu_ctl.scala 671:58]
  wire  _T_373 = ~enter_debug_halt_req; // @[el2_dec_tlu_ctl.scala 671:73]
  wire  _T_374 = _T_372 & _T_373; // @[el2_dec_tlu_ctl.scala 671:71]
  wire  _T_375 = ~i_cpu_run_req_d1; // @[el2_dec_tlu_ctl.scala 671:121]
  wire  _T_376 = pmu_fw_tlu_halted_f & _T_375; // @[el2_dec_tlu_ctl.scala 671:119]
  wire  _T_377 = _T_374 | _T_376; // @[el2_dec_tlu_ctl.scala 671:96]
  wire  _T_378 = ~debug_halt_req_f; // @[el2_dec_tlu_ctl.scala 671:143]
  wire  pmu_fw_tlu_halted = _T_377 & _T_378; // @[el2_dec_tlu_ctl.scala 671:141]
  wire  _T_361 = ~pmu_fw_tlu_halted; // @[el2_dec_tlu_ctl.scala 667:72]
  wire  _T_362 = pmu_fw_halt_req_f & _T_361; // @[el2_dec_tlu_ctl.scala 667:70]
  wire  _T_363 = enter_pmu_fw_halt_req | _T_362; // @[el2_dec_tlu_ctl.scala 667:49]
  wire  pmu_fw_halt_req_ns = _T_363 & _T_378; // @[el2_dec_tlu_ctl.scala 667:93]
  reg  internal_pmu_fw_halt_mode_f; // @[el2_dec_tlu_ctl.scala 657:68]
  wire  _T_367 = internal_pmu_fw_halt_mode_f & _T_375; // @[el2_dec_tlu_ctl.scala 668:83]
  wire  _T_369 = _T_367 & _T_378; // @[el2_dec_tlu_ctl.scala 668:103]
  wire  internal_pmu_fw_halt_mode = pmu_fw_halt_req_ns | _T_369; // @[el2_dec_tlu_ctl.scala 668:52]
  wire  _T_668 = _T_667 | internal_pmu_fw_halt_mode; // @[el2_dec_tlu_ctl.scala 820:107]
  wire  _T_669 = _T_668 | i_cpu_halt_req_d1; // @[el2_dec_tlu_ctl.scala 820:135]
  wire  _T_738 = ~internal_pmu_fw_halt_mode; // @[el2_dec_tlu_ctl.scala 852:35]
  wire  _T_739 = nmi_int_detected & _T_738; // @[el2_dec_tlu_ctl.scala 852:33]
  wire  _T_740 = ~internal_dbg_halt_mode; // @[el2_dec_tlu_ctl.scala 852:65]
  wire  _T_742 = dcsr_single_step_running_f & dcsr[11]; // @[el2_dec_tlu_ctl.scala 852:119]
  wire  _T_743 = ~io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 852:141]
  wire  _T_744 = _T_742 & _T_743; // @[el2_dec_tlu_ctl.scala 852:139]
  wire  _T_746 = _T_744 & _T_178; // @[el2_dec_tlu_ctl.scala 852:164]
  wire  _T_747 = _T_740 | _T_746; // @[el2_dec_tlu_ctl.scala 852:89]
  wire  _T_748 = _T_739 & _T_747; // @[el2_dec_tlu_ctl.scala 852:62]
  wire  _T_463 = io_dec_tlu_packet_r_pmu_i0_itype == 4'h8; // @[el2_dec_tlu_ctl.scala 738:51]
  wire  _T_464 = _T_463 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 738:64]
  wire  _T_297 = io_dec_tlu_flush_lower_wb | io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 600:58]
  wire [3:0] _T_299 = _T_297 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_300 = ~_T_299; // @[el2_dec_tlu_ctl.scala 600:23]
  wire [3:0] _T_292 = io_dec_tlu_i0_valid_r ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_294 = _T_292 & io_dec_tlu_packet_r_i0trigger; // @[el2_dec_tlu_ctl.scala 598:53]
  wire [9:0] mtdata1_t_3 = csr_io_mtdata1_t_3; // @[el2_dec_tlu_ctl.scala 236:67 el2_dec_tlu_ctl.scala 1089:33]
  wire [9:0] mtdata1_t_2 = csr_io_mtdata1_t_2; // @[el2_dec_tlu_ctl.scala 236:67 el2_dec_tlu_ctl.scala 1089:33]
  wire [9:0] mtdata1_t_1 = csr_io_mtdata1_t_1; // @[el2_dec_tlu_ctl.scala 236:67 el2_dec_tlu_ctl.scala 1089:33]
  wire [9:0] mtdata1_t_0 = csr_io_mtdata1_t_0; // @[el2_dec_tlu_ctl.scala 236:67 el2_dec_tlu_ctl.scala 1089:33]
  wire [3:0] trigger_execute = {mtdata1_t_3[2],mtdata1_t_2[2],mtdata1_t_1[2],mtdata1_t_0[2]}; // @[Cat.scala 29:58]
  wire [3:0] trigger_data = {mtdata1_t_3[7],mtdata1_t_2[7],mtdata1_t_1[7],mtdata1_t_0[7]}; // @[Cat.scala 29:58]
  wire [3:0] _T_279 = trigger_execute & trigger_data; // @[el2_dec_tlu_ctl.scala 590:57]
  wire  inst_acc_r_raw = io_dec_tlu_packet_r_icaf & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 746:49]
  wire [3:0] _T_281 = inst_acc_r_raw ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_282 = _T_279 & _T_281; // @[el2_dec_tlu_ctl.scala 590:72]
  wire  _T_283 = io_exu_i0_br_error_r | io_exu_i0_br_start_error_r; // @[el2_dec_tlu_ctl.scala 590:129]
  wire [3:0] _T_285 = _T_283 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_286 = _T_282 | _T_285; // @[el2_dec_tlu_ctl.scala 590:98]
  wire [3:0] i0_iside_trigger_has_pri_r = ~_T_286; // @[el2_dec_tlu_ctl.scala 590:38]
  wire [3:0] _T_295 = _T_294 & i0_iside_trigger_has_pri_r; // @[el2_dec_tlu_ctl.scala 598:90]
  wire [3:0] trigger_store = {mtdata1_t_3[1],mtdata1_t_2[1],mtdata1_t_1[1],mtdata1_t_0[1]}; // @[Cat.scala 29:58]
  wire [3:0] _T_287 = trigger_store & trigger_data; // @[el2_dec_tlu_ctl.scala 593:51]
  wire [3:0] _T_289 = io_lsu_error_pkt_r_exc_valid ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_290 = _T_287 & _T_289; // @[el2_dec_tlu_ctl.scala 593:66]
  wire [3:0] i0_lsu_trigger_has_pri_r = ~_T_290; // @[el2_dec_tlu_ctl.scala 593:35]
  wire [3:0] _T_296 = _T_295 & i0_lsu_trigger_has_pri_r; // @[el2_dec_tlu_ctl.scala 598:119]
  wire [1:0] mstatus = csr_io_mstatus; // @[el2_dec_tlu_ctl.scala 1085:31]
  wire  _T_259 = mtdata1_t_3[6] | mstatus[0]; // @[el2_dec_tlu_ctl.scala 587:62]
  wire  _T_261 = _T_259 & mtdata1_t_3[3]; // @[el2_dec_tlu_ctl.scala 587:86]
  wire  _T_264 = mtdata1_t_2[6] | mstatus[0]; // @[el2_dec_tlu_ctl.scala 587:150]
  wire  _T_266 = _T_264 & mtdata1_t_2[3]; // @[el2_dec_tlu_ctl.scala 587:174]
  wire  _T_269 = mtdata1_t_1[6] | mstatus[0]; // @[el2_dec_tlu_ctl.scala 587:239]
  wire  _T_271 = _T_269 & mtdata1_t_1[3]; // @[el2_dec_tlu_ctl.scala 587:263]
  wire  _T_274 = mtdata1_t_0[6] | mstatus[0]; // @[el2_dec_tlu_ctl.scala 587:328]
  wire  _T_276 = _T_274 & mtdata1_t_0[3]; // @[el2_dec_tlu_ctl.scala 587:352]
  wire [3:0] trigger_enabled = {_T_261,_T_266,_T_271,_T_276}; // @[Cat.scala 29:58]
  wire [3:0] i0trigger_qual_r = _T_296 & trigger_enabled; // @[el2_dec_tlu_ctl.scala 598:146]
  wire [3:0] i0_trigger_r = _T_300 & i0trigger_qual_r; // @[el2_dec_tlu_ctl.scala 600:84]
  wire  _T_303 = ~mtdata1_t_2[5]; // @[el2_dec_tlu_ctl.scala 603:60]
  wire  _T_305 = _T_303 | i0_trigger_r[2]; // @[el2_dec_tlu_ctl.scala 603:89]
  wire  _T_306 = i0_trigger_r[3] & _T_305; // @[el2_dec_tlu_ctl.scala 603:57]
  wire  _T_311 = _T_303 | i0_trigger_r[3]; // @[el2_dec_tlu_ctl.scala 603:157]
  wire  _T_312 = i0_trigger_r[2] & _T_311; // @[el2_dec_tlu_ctl.scala 603:125]
  wire  _T_315 = ~mtdata1_t_0[5]; // @[el2_dec_tlu_ctl.scala 603:196]
  wire  _T_317 = _T_315 | i0_trigger_r[0]; // @[el2_dec_tlu_ctl.scala 603:225]
  wire  _T_318 = i0_trigger_r[1] & _T_317; // @[el2_dec_tlu_ctl.scala 603:193]
  wire  _T_323 = _T_315 | i0_trigger_r[1]; // @[el2_dec_tlu_ctl.scala 603:293]
  wire  _T_324 = i0_trigger_r[0] & _T_323; // @[el2_dec_tlu_ctl.scala 603:261]
  wire [3:0] i0_trigger_chain_masked_r = {_T_306,_T_312,_T_318,_T_324}; // @[Cat.scala 29:58]
  wire  i0_trigger_hit_raw_r = |i0_trigger_chain_masked_r; // @[el2_dec_tlu_ctl.scala 606:57]
  wire  _T_465 = ~i0_trigger_hit_raw_r; // @[el2_dec_tlu_ctl.scala 738:90]
  wire  _T_466 = _T_464 & _T_465; // @[el2_dec_tlu_ctl.scala 738:88]
  wire  _T_468 = ~dcsr[15]; // @[el2_dec_tlu_ctl.scala 738:110]
  wire  _T_469 = _T_466 & _T_468; // @[el2_dec_tlu_ctl.scala 738:108]
  reg  tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 408:80]
  wire  _T_429 = ~tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 713:44]
  wire  _T_430 = io_dec_tlu_i0_valid_r & _T_429; // @[el2_dec_tlu_ctl.scala 713:42]
  wire  _T_432 = _T_430 & _T_283; // @[el2_dec_tlu_ctl.scala 713:66]
  reg  ic_perr_r_d1; // @[el2_dec_tlu_ctl.scala 402:89]
  reg  iccm_sbecc_r_d1; // @[el2_dec_tlu_ctl.scala 403:89]
  wire  _T_433 = ic_perr_r_d1 | iccm_sbecc_r_d1; // @[el2_dec_tlu_ctl.scala 713:138]
  wire  _T_435 = _T_433 & _T_107; // @[el2_dec_tlu_ctl.scala 713:157]
  wire  _T_436 = _T_432 | _T_435; // @[el2_dec_tlu_ctl.scala 713:121]
  wire  _T_438 = _T_436 & _T_465; // @[el2_dec_tlu_ctl.scala 713:180]
  wire  _T_410 = io_dec_tlu_i0_valid_r & _T_465; // @[el2_dec_tlu_ctl.scala 701:47]
  wire  _T_411 = ~io_lsu_error_pkt_r_inst_type; // @[el2_dec_tlu_ctl.scala 701:70]
  wire  _T_412 = _T_411 & io_lsu_error_pkt_r_single_ecc_error; // @[el2_dec_tlu_ctl.scala 701:100]
  wire  lsu_i0_rfnpc_r = _T_410 & _T_412; // @[el2_dec_tlu_ctl.scala 701:67]
  wire  _T_439 = ~lsu_i0_rfnpc_r; // @[el2_dec_tlu_ctl.scala 713:204]
  wire  rfpc_i0_r = _T_438 & _T_439; // @[el2_dec_tlu_ctl.scala 713:201]
  wire  _T_470 = ~rfpc_i0_r; // @[el2_dec_tlu_ctl.scala 738:132]
  wire  ebreak_r = _T_469 & _T_470; // @[el2_dec_tlu_ctl.scala 738:130]
  wire  _T_472 = io_dec_tlu_packet_r_pmu_i0_itype == 4'h9; // @[el2_dec_tlu_ctl.scala 739:51]
  wire  _T_473 = _T_472 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 739:64]
  wire  _T_475 = _T_473 & _T_465; // @[el2_dec_tlu_ctl.scala 739:88]
  wire  ecall_r = _T_475 & _T_470; // @[el2_dec_tlu_ctl.scala 739:108]
  wire  _T_523 = ebreak_r | ecall_r; // @[el2_dec_tlu_ctl.scala 766:41]
  wire  _T_478 = ~io_dec_tlu_packet_r_legal; // @[el2_dec_tlu_ctl.scala 740:17]
  wire  _T_479 = _T_478 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 740:46]
  wire  _T_481 = _T_479 & _T_465; // @[el2_dec_tlu_ctl.scala 740:70]
  wire  illegal_r = _T_481 & _T_470; // @[el2_dec_tlu_ctl.scala 740:90]
  wire  _T_524 = _T_523 | illegal_r; // @[el2_dec_tlu_ctl.scala 766:51]
  wire  _T_511 = inst_acc_r_raw & _T_470; // @[el2_dec_tlu_ctl.scala 747:33]
  wire  inst_acc_r = _T_511 & _T_465; // @[el2_dec_tlu_ctl.scala 747:46]
  wire  _T_525 = _T_524 | inst_acc_r; // @[el2_dec_tlu_ctl.scala 766:63]
  wire  _T_527 = _T_525 & _T_470; // @[el2_dec_tlu_ctl.scala 766:77]
  wire  _T_528 = ~io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 766:92]
  wire  i0_exception_valid_r = _T_527 & _T_528; // @[el2_dec_tlu_ctl.scala 766:90]
  wire  _T_789 = i0_exception_valid_r | rfpc_i0_r; // @[el2_dec_tlu_ctl.scala 865:49]
  wire  _T_402 = ~io_dec_tlu_flush_lower_wb; // @[el2_dec_tlu_ctl.scala 689:61]
  wire  lsu_exc_valid_r_raw = io_lsu_error_pkt_r_exc_valid & _T_402; // @[el2_dec_tlu_ctl.scala 689:59]
  wire  _T_403 = io_lsu_error_pkt_r_exc_valid & lsu_exc_valid_r_raw; // @[el2_dec_tlu_ctl.scala 691:40]
  wire  _T_405 = _T_403 & _T_465; // @[el2_dec_tlu_ctl.scala 691:62]
  wire  lsu_exc_valid_r = _T_405 & _T_470; // @[el2_dec_tlu_ctl.scala 691:82]
  wire  _T_790 = _T_789 | lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 865:61]
  wire  _T_490 = io_dec_tlu_packet_r_fence_i & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 743:50]
  wire  _T_492 = _T_490 & _T_465; // @[el2_dec_tlu_ctl.scala 743:74]
  wire  fence_i_r = _T_492 & _T_470; // @[el2_dec_tlu_ctl.scala 743:95]
  wire  _T_791 = _T_790 | fence_i_r; // @[el2_dec_tlu_ctl.scala 865:79]
  wire  _T_792 = _T_791 | lsu_i0_rfnpc_r; // @[el2_dec_tlu_ctl.scala 865:91]
  wire  _T_414 = io_dec_tlu_i0_valid_r & _T_470; // @[el2_dec_tlu_ctl.scala 704:50]
  wire  _T_415 = ~lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 704:65]
  wire  _T_416 = _T_414 & _T_415; // @[el2_dec_tlu_ctl.scala 704:63]
  wire  _T_417 = ~inst_acc_r; // @[el2_dec_tlu_ctl.scala 704:82]
  wire  _T_418 = _T_416 & _T_417; // @[el2_dec_tlu_ctl.scala 704:79]
  wire  _T_420 = _T_418 & _T_528; // @[el2_dec_tlu_ctl.scala 704:94]
  reg  request_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 542:81]
  wire  _T_421 = ~request_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 704:121]
  wire  _T_422 = _T_420 & _T_421; // @[el2_dec_tlu_ctl.scala 704:119]
  wire  tlu_i0_commit_cmt = _T_422 & _T_465; // @[el2_dec_tlu_ctl.scala 704:146]
  reg  iccm_repair_state_d1; // @[el2_dec_tlu_ctl.scala 401:80]
  wire  _T_444 = tlu_i0_commit_cmt & iccm_repair_state_d1; // @[el2_dec_tlu_ctl.scala 722:52]
  wire  _T_484 = io_dec_tlu_packet_r_pmu_i0_itype == 4'hc; // @[el2_dec_tlu_ctl.scala 741:51]
  wire  _T_485 = _T_484 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 741:64]
  wire  _T_487 = _T_485 & _T_465; // @[el2_dec_tlu_ctl.scala 741:88]
  wire  mret_r = _T_487 & _T_470; // @[el2_dec_tlu_ctl.scala 741:108]
  wire  _T_446 = _T_523 | mret_r; // @[el2_dec_tlu_ctl.scala 722:98]
  wire  take_reset = reset_delayed & io_mpc_reset_run_req; // @[el2_dec_tlu_ctl.scala 851:32]
  wire  _T_447 = _T_446 | take_reset; // @[el2_dec_tlu_ctl.scala 722:107]
  wire  _T_448 = _T_447 | illegal_r; // @[el2_dec_tlu_ctl.scala 722:120]
  wire  _T_449 = io_dec_csr_wraddr_r == 12'h7c2; // @[el2_dec_tlu_ctl.scala 722:176]
  wire  _T_450 = dec_csr_wen_r_mod & _T_449; // @[el2_dec_tlu_ctl.scala 722:153]
  wire  _T_451 = _T_448 | _T_450; // @[el2_dec_tlu_ctl.scala 722:132]
  wire  _T_452 = ~_T_451; // @[el2_dec_tlu_ctl.scala 722:77]
  wire  iccm_repair_state_rfnpc = _T_444 & _T_452; // @[el2_dec_tlu_ctl.scala 722:75]
  wire  _T_793 = _T_792 | iccm_repair_state_rfnpc; // @[el2_dec_tlu_ctl.scala 865:108]
  wire  _T_794 = _T_793 | debug_resume_req_f; // @[el2_dec_tlu_ctl.scala 865:135]
  wire  _T_786 = i_cpu_run_req_d1 & pmu_fw_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 863:43]
  wire  _T_211 = ~io_dec_pause_state; // @[el2_dec_tlu_ctl.scala 562:28]
  reg  dec_pause_state_f; // @[el2_dec_tlu_ctl.scala 541:81]
  wire  _T_212 = _T_211 & dec_pause_state_f; // @[el2_dec_tlu_ctl.scala 562:48]
  wire  _T_213 = ext_int_ready | ce_int_ready; // @[el2_dec_tlu_ctl.scala 562:86]
  wire  _T_214 = _T_213 | timer_int_ready; // @[el2_dec_tlu_ctl.scala 562:101]
  wire  _T_215 = _T_214 | soft_int_ready; // @[el2_dec_tlu_ctl.scala 562:119]
  wire  _T_216 = _T_215 | int_timer0_int_hold_f; // @[el2_dec_tlu_ctl.scala 562:136]
  wire  _T_217 = _T_216 | int_timer1_int_hold_f; // @[el2_dec_tlu_ctl.scala 562:160]
  wire  _T_218 = _T_217 | nmi_int_detected; // @[el2_dec_tlu_ctl.scala 562:184]
  wire  _T_219 = _T_218 | ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 562:203]
  wire  _T_220 = ~_T_219; // @[el2_dec_tlu_ctl.scala 562:70]
  wire  _T_221 = _T_212 & _T_220; // @[el2_dec_tlu_ctl.scala 562:68]
  wire  _T_223 = _T_221 & _T_140; // @[el2_dec_tlu_ctl.scala 562:224]
  wire  _T_225 = _T_223 & _T_378; // @[el2_dec_tlu_ctl.scala 562:248]
  wire  _T_226 = ~pmu_fw_halt_req_f; // @[el2_dec_tlu_ctl.scala 562:270]
  wire  _T_227 = _T_225 & _T_226; // @[el2_dec_tlu_ctl.scala 562:268]
  wire  _T_228 = ~halt_taken_f; // @[el2_dec_tlu_ctl.scala 562:291]
  wire  pause_expired_r = _T_227 & _T_228; // @[el2_dec_tlu_ctl.scala 562:289]
  wire  sel_npc_resume = _T_786 | pause_expired_r; // @[el2_dec_tlu_ctl.scala 863:66]
  wire  _T_795 = _T_794 | sel_npc_resume; // @[el2_dec_tlu_ctl.scala 865:157]
  reg  dec_tlu_wr_pause_r_d1; // @[el2_dec_tlu_ctl.scala 540:81]
  wire  _T_796 = _T_795 | dec_tlu_wr_pause_r_d1; // @[el2_dec_tlu_ctl.scala 865:175]
  wire  synchronous_flush_r = _T_796 | i0_trigger_hit_raw_r; // @[el2_dec_tlu_ctl.scala 865:201]
  wire  _T_749 = ~synchronous_flush_r; // @[el2_dec_tlu_ctl.scala 852:195]
  wire  _T_750 = _T_748 & _T_749; // @[el2_dec_tlu_ctl.scala 852:193]
  wire  _T_751 = ~mret_r; // @[el2_dec_tlu_ctl.scala 852:218]
  wire  _T_752 = _T_750 & _T_751; // @[el2_dec_tlu_ctl.scala 852:216]
  wire  _T_753 = ~take_reset; // @[el2_dec_tlu_ctl.scala 852:228]
  wire  _T_754 = _T_752 & _T_753; // @[el2_dec_tlu_ctl.scala 852:226]
  wire  _T_519 = _T_466 & dcsr[15]; // @[el2_dec_tlu_ctl.scala 750:121]
  wire  ebreak_to_debug_mode_r = _T_519 & _T_470; // @[el2_dec_tlu_ctl.scala 750:142]
  wire  _T_755 = ~ebreak_to_debug_mode_r; // @[el2_dec_tlu_ctl.scala 852:242]
  wire  _T_756 = _T_754 & _T_755; // @[el2_dec_tlu_ctl.scala 852:240]
  wire  _T_760 = _T_107 | _T_44; // @[el2_dec_tlu_ctl.scala 852:288]
  wire  take_nmi = _T_756 & _T_760; // @[el2_dec_tlu_ctl.scala 852:266]
  wire  _T_670 = _T_669 | take_nmi; // @[el2_dec_tlu_ctl.scala 820:155]
  wire  _T_671 = _T_670 | ebreak_to_debug_mode_r; // @[el2_dec_tlu_ctl.scala 820:166]
  wire  _T_672 = _T_671 | synchronous_flush_r; // @[el2_dec_tlu_ctl.scala 820:191]
  reg  exc_or_int_valid_r_d1; // @[el2_dec_tlu_ctl.scala 890:90]
  wire  _T_673 = _T_672 | exc_or_int_valid_r_d1; // @[el2_dec_tlu_ctl.scala 820:214]
  wire  _T_674 = _T_673 | mret_r; // @[el2_dec_tlu_ctl.scala 820:238]
  wire  block_interrupts = _T_674 | ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 820:247]
  wire  _T_704 = ~block_interrupts; // @[el2_dec_tlu_ctl.scala 848:91]
  wire  take_timer_int = _T_703 & _T_704; // @[el2_dec_tlu_ctl.scala 848:89]
  wire  _T_762 = take_ext_int | take_timer_int; // @[el2_dec_tlu_ctl.scala 855:38]
  wire  _T_693 = soft_int_ready & _T_700; // @[el2_dec_tlu_ctl.scala 847:36]
  wire  _T_695 = _T_693 & _T_702; // @[el2_dec_tlu_ctl.scala 847:53]
  wire  take_soft_int = _T_695 & _T_704; // @[el2_dec_tlu_ctl.scala 847:69]
  wire  _T_763 = _T_762 | take_soft_int; // @[el2_dec_tlu_ctl.scala 855:55]
  wire  _T_764 = _T_763 | take_nmi; // @[el2_dec_tlu_ctl.scala 855:71]
  wire  _T_689 = ce_int_ready & _T_700; // @[el2_dec_tlu_ctl.scala 846:33]
  wire  take_ce_int = _T_689 & _T_704; // @[el2_dec_tlu_ctl.scala 846:50]
  wire  _T_765 = _T_764 | take_ce_int; // @[el2_dec_tlu_ctl.scala 855:82]
  wire  int_timer0_int_possible = mstatus_mie_ns & mie_ns[4]; // @[el2_dec_tlu_ctl.scala 806:49]
  wire  int_timer0_int_ready = mip[4] & int_timer0_int_possible; // @[el2_dec_tlu_ctl.scala 807:47]
  wire  _T_706 = int_timer0_int_ready | int_timer0_int_hold_f; // @[el2_dec_tlu_ctl.scala 849:49]
  wire  _T_707 = _T_706 & int_timer0_int_possible; // @[el2_dec_tlu_ctl.scala 849:74]
  wire  _T_709 = _T_707 & _T_631; // @[el2_dec_tlu_ctl.scala 849:100]
  wire  _T_710 = ~timer_int_ready; // @[el2_dec_tlu_ctl.scala 849:129]
  wire  _T_711 = _T_709 & _T_710; // @[el2_dec_tlu_ctl.scala 849:127]
  wire  _T_713 = _T_711 & _T_698; // @[el2_dec_tlu_ctl.scala 849:146]
  wire  _T_715 = _T_713 & _T_700; // @[el2_dec_tlu_ctl.scala 849:164]
  wire  _T_717 = _T_715 & _T_702; // @[el2_dec_tlu_ctl.scala 849:181]
  wire  take_int_timer0_int = _T_717 & _T_704; // @[el2_dec_tlu_ctl.scala 849:197]
  wire  _T_766 = _T_765 | take_int_timer0_int; // @[el2_dec_tlu_ctl.scala 855:96]
  wire  int_timer1_int_possible = mstatus_mie_ns & mie_ns[3]; // @[el2_dec_tlu_ctl.scala 808:49]
  wire  int_timer1_int_ready = mip[3] & int_timer1_int_possible; // @[el2_dec_tlu_ctl.scala 809:47]
  wire  _T_720 = int_timer1_int_ready | int_timer1_int_hold_f; // @[el2_dec_tlu_ctl.scala 850:49]
  wire  _T_721 = _T_720 & int_timer1_int_possible; // @[el2_dec_tlu_ctl.scala 850:74]
  wire  _T_723 = _T_721 & _T_631; // @[el2_dec_tlu_ctl.scala 850:100]
  wire  _T_725 = ~_T_706; // @[el2_dec_tlu_ctl.scala 850:129]
  wire  _T_726 = _T_723 & _T_725; // @[el2_dec_tlu_ctl.scala 850:127]
  wire  _T_728 = _T_726 & _T_710; // @[el2_dec_tlu_ctl.scala 850:177]
  wire  _T_730 = _T_728 & _T_698; // @[el2_dec_tlu_ctl.scala 850:196]
  wire  _T_732 = _T_730 & _T_700; // @[el2_dec_tlu_ctl.scala 850:214]
  wire  _T_734 = _T_732 & _T_702; // @[el2_dec_tlu_ctl.scala 850:231]
  wire  take_int_timer1_int = _T_734 & _T_704; // @[el2_dec_tlu_ctl.scala 850:247]
  wire  interrupt_valid_r = _T_766 | take_int_timer1_int; // @[el2_dec_tlu_ctl.scala 855:118]
  wire  _T_15 = _T_14 | interrupt_valid_r; // @[el2_dec_tlu_ctl.scala 396:69]
  wire  _T_16 = _T_15 | interrupt_valid_r_d1; // @[el2_dec_tlu_ctl.scala 396:89]
  wire  _T_17 = _T_16 | reset_delayed; // @[el2_dec_tlu_ctl.scala 396:112]
  wire  _T_18 = _T_17 | pause_expired_r; // @[el2_dec_tlu_ctl.scala 396:128]
  reg  pause_expired_wb; // @[el2_dec_tlu_ctl.scala 895:90]
  wire  _T_19 = _T_18 | pause_expired_wb; // @[el2_dec_tlu_ctl.scala 396:146]
  wire  _T_496 = io_ifu_ic_error_start & _T_107; // @[el2_dec_tlu_ctl.scala 744:43]
  wire  _T_498 = _T_152 | dcsr_single_step_running; // @[el2_dec_tlu_ctl.scala 744:93]
  wire  _T_499 = _T_496 & _T_498; // @[el2_dec_tlu_ctl.scala 744:64]
  wire  _T_500 = ~internal_pmu_fw_halt_mode_f; // @[el2_dec_tlu_ctl.scala 744:123]
  wire  ic_perr_r = _T_499 & _T_500; // @[el2_dec_tlu_ctl.scala 744:121]
  wire  _T_20 = _T_19 | ic_perr_r; // @[el2_dec_tlu_ctl.scala 396:165]
  wire  _T_21 = _T_20 | ic_perr_r_d1; // @[el2_dec_tlu_ctl.scala 396:177]
  wire  _T_503 = io_ifu_iccm_rd_ecc_single_err & _T_107; // @[el2_dec_tlu_ctl.scala 745:51]
  wire  _T_506 = _T_503 & _T_498; // @[el2_dec_tlu_ctl.scala 745:72]
  wire  iccm_sbecc_r = _T_506 & _T_500; // @[el2_dec_tlu_ctl.scala 745:129]
  wire  _T_22 = _T_21 | iccm_sbecc_r; // @[el2_dec_tlu_ctl.scala 396:192]
  wire  _T_23 = _T_22 | iccm_sbecc_r_d1; // @[el2_dec_tlu_ctl.scala 396:207]
  wire  flush_clkvalid = _T_23 | io_dec_tlu_dec_clk_override; // @[el2_dec_tlu_ctl.scala 396:225]
  reg  lsu_pmu_load_external_r; // @[el2_dec_tlu_ctl.scala 406:80]
  reg  lsu_pmu_store_external_r; // @[el2_dec_tlu_ctl.scala 407:72]
  reg  _T_32; // @[el2_dec_tlu_ctl.scala 409:73]
  reg  internal_dbg_halt_mode_f2; // @[el2_dec_tlu_ctl.scala 410:72]
  reg  _T_33; // @[el2_dec_tlu_ctl.scala 411:81]
  reg  nmi_lsu_load_type_f; // @[el2_dec_tlu_ctl.scala 422:72]
  reg  nmi_lsu_store_type_f; // @[el2_dec_tlu_ctl.scala 423:72]
  wire  _T_46 = nmi_lsu_detected & io_lsu_imprecise_error_load_any; // @[el2_dec_tlu_ctl.scala 431:48]
  wire  _T_49 = ~_T_41; // @[el2_dec_tlu_ctl.scala 431:84]
  wire  _T_50 = _T_46 & _T_49; // @[el2_dec_tlu_ctl.scala 431:82]
  wire  _T_52 = nmi_lsu_load_type_f & _T_40; // @[el2_dec_tlu_ctl.scala 431:147]
  wire  _T_54 = nmi_lsu_detected & io_lsu_imprecise_error_store_any; // @[el2_dec_tlu_ctl.scala 432:49]
  wire  _T_58 = _T_54 & _T_49; // @[el2_dec_tlu_ctl.scala 432:84]
  wire  _T_60 = nmi_lsu_store_type_f & _T_40; // @[el2_dec_tlu_ctl.scala 432:150]
  reg  mpc_debug_halt_req_sync_f; // @[el2_dec_tlu_ctl.scala 440:72]
  reg  mpc_debug_run_req_sync_f; // @[el2_dec_tlu_ctl.scala 441:72]
  reg  mpc_run_state_f; // @[el2_dec_tlu_ctl.scala 443:88]
  reg  debug_brkpt_status_f; // @[el2_dec_tlu_ctl.scala 444:80]
  reg  mpc_debug_halt_ack_f; // @[el2_dec_tlu_ctl.scala 445:80]
  reg  mpc_debug_run_ack_f; // @[el2_dec_tlu_ctl.scala 446:80]
  reg  dbg_run_state_f; // @[el2_dec_tlu_ctl.scala 448:88]
  reg  _T_65; // @[el2_dec_tlu_ctl.scala 449:81]
  wire  _T_66 = ~mpc_debug_halt_req_sync_f; // @[el2_dec_tlu_ctl.scala 453:71]
  wire  mpc_debug_halt_req_sync_pulse = mpc_debug_halt_req_sync & _T_66; // @[el2_dec_tlu_ctl.scala 453:69]
  wire  _T_67 = ~mpc_debug_run_req_sync_f; // @[el2_dec_tlu_ctl.scala 454:70]
  wire  mpc_debug_run_req_sync_pulse = mpc_debug_run_req_sync & _T_67; // @[el2_dec_tlu_ctl.scala 454:68]
  wire  _T_68 = mpc_halt_state_f | mpc_debug_halt_req_sync_pulse; // @[el2_dec_tlu_ctl.scala 456:48]
  wire  _T_71 = _T_68 | _T_111; // @[el2_dec_tlu_ctl.scala 456:80]
  wire  _T_72 = ~mpc_debug_run_req_sync; // @[el2_dec_tlu_ctl.scala 456:125]
  wire  mpc_halt_state_ns = _T_71 & _T_72; // @[el2_dec_tlu_ctl.scala 456:123]
  wire  _T_74 = ~mpc_debug_run_ack_f; // @[el2_dec_tlu_ctl.scala 457:80]
  wire  _T_75 = mpc_debug_run_req_sync_pulse & _T_74; // @[el2_dec_tlu_ctl.scala 457:78]
  wire  _T_76 = mpc_run_state_f | _T_75; // @[el2_dec_tlu_ctl.scala 457:46]
  wire  _T_77 = ~dcsr_single_step_running_f; // @[el2_dec_tlu_ctl.scala 457:133]
  wire  _T_78 = debug_mode_status & _T_77; // @[el2_dec_tlu_ctl.scala 457:131]
  wire  mpc_run_state_ns = _T_76 & _T_78; // @[el2_dec_tlu_ctl.scala 457:103]
  wire  _T_80 = dbg_halt_req_final | dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 459:70]
  wire  _T_81 = _T_80 | trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 459:96]
  wire  _T_82 = _T_81 | ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 459:121]
  wire  _T_83 = dbg_halt_state_f | _T_82; // @[el2_dec_tlu_ctl.scala 459:48]
  wire  _T_84 = ~io_dbg_resume_req; // @[el2_dec_tlu_ctl.scala 459:153]
  wire  dbg_halt_state_ns = _T_83 & _T_84; // @[el2_dec_tlu_ctl.scala 459:151]
  wire  _T_86 = dbg_run_state_f | io_dbg_resume_req; // @[el2_dec_tlu_ctl.scala 460:46]
  wire  dbg_run_state_ns = _T_86 & _T_78; // @[el2_dec_tlu_ctl.scala 460:67]
  wire  debug_brkpt_valid = ebreak_to_debug_mode_r_d1 | trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 466:59]
  wire  _T_92 = debug_brkpt_valid | debug_brkpt_status_f; // @[el2_dec_tlu_ctl.scala 467:53]
  wire  _T_94 = internal_dbg_halt_mode & _T_77; // @[el2_dec_tlu_ctl.scala 467:103]
  wire  _T_96 = mpc_halt_state_f & debug_mode_status; // @[el2_dec_tlu_ctl.scala 470:51]
  wire  _T_97 = _T_96 & mpc_debug_halt_req_sync; // @[el2_dec_tlu_ctl.scala 470:78]
  wire  _T_99 = ~dbg_halt_state_ns; // @[el2_dec_tlu_ctl.scala 471:59]
  wire  _T_100 = mpc_debug_run_req_sync & _T_99; // @[el2_dec_tlu_ctl.scala 471:57]
  wire  _T_101 = ~mpc_debug_halt_req_sync; // @[el2_dec_tlu_ctl.scala 471:80]
  wire  _T_102 = _T_100 & _T_101; // @[el2_dec_tlu_ctl.scala 471:78]
  wire  _T_103 = mpc_debug_run_ack_f & mpc_debug_run_req_sync; // @[el2_dec_tlu_ctl.scala 471:129]
  wire  _T_118 = mpc_run_state_ns & _T_99; // @[el2_dec_tlu_ctl.scala 485:73]
  wire  _T_119 = ~mpc_halt_state_ns; // @[el2_dec_tlu_ctl.scala 485:117]
  wire  _T_120 = dbg_run_state_ns & _T_119; // @[el2_dec_tlu_ctl.scala 485:115]
  wire  _T_121 = _T_118 | _T_120; // @[el2_dec_tlu_ctl.scala 485:95]
  wire  _T_122 = debug_halt_req_f | pmu_fw_halt_req_f; // @[el2_dec_tlu_ctl.scala 490:43]
  wire  _T_124 = _T_122 & _T_749; // @[el2_dec_tlu_ctl.scala 490:64]
  wire  _T_126 = _T_124 & _T_751; // @[el2_dec_tlu_ctl.scala 490:87]
  wire  _T_128 = _T_126 & _T_228; // @[el2_dec_tlu_ctl.scala 490:97]
  wire  _T_129 = ~dec_tlu_flush_noredir_r_d1; // @[el2_dec_tlu_ctl.scala 490:115]
  wire  _T_130 = _T_128 & _T_129; // @[el2_dec_tlu_ctl.scala 490:113]
  wire  take_halt = _T_130 & _T_753; // @[el2_dec_tlu_ctl.scala 490:143]
  wire  _T_170 = debug_resume_req_f & dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 515:49]
  wire  _T_172 = io_dec_tlu_i0_valid_r & _T_528; // @[el2_dec_tlu_ctl.scala 517:59]
  wire  _T_174 = _T_172 & dcsr[2]; // @[el2_dec_tlu_ctl.scala 517:84]
  wire  _T_329 = mtdata1_t_3[6] & mtdata1_t_3[9]; // @[el2_dec_tlu_ctl.scala 612:61]
  wire  _T_332 = mtdata1_t_2[6] & mtdata1_t_2[9]; // @[el2_dec_tlu_ctl.scala 612:121]
  wire  _T_335 = mtdata1_t_1[6] & mtdata1_t_1[9]; // @[el2_dec_tlu_ctl.scala 612:181]
  wire  _T_338 = mtdata1_t_0[6] & mtdata1_t_0[9]; // @[el2_dec_tlu_ctl.scala 612:241]
  wire [3:0] trigger_action = {_T_329,_T_332,_T_335,_T_338}; // @[Cat.scala 29:58]
  wire [3:0] _T_343 = i0_trigger_chain_masked_r & trigger_action; // @[el2_dec_tlu_ctl.scala 618:57]
  wire  i0_trigger_action_r = |_T_343; // @[el2_dec_tlu_ctl.scala 618:75]
  wire  trigger_hit_dmode_r = i0_trigger_hit_raw_r & i0_trigger_action_r; // @[el2_dec_tlu_ctl.scala 620:45]
  wire  _T_180 = trigger_hit_dmode_r | ebreak_to_debug_mode_r; // @[el2_dec_tlu_ctl.scala 524:57]
  wire  _T_182 = request_debug_mode_r_d1 & _T_402; // @[el2_dec_tlu_ctl.scala 524:110]
  reg  request_debug_mode_done_f; // @[el2_dec_tlu_ctl.scala 543:73]
  wire  _T_183 = request_debug_mode_r_d1 | request_debug_mode_done_f; // @[el2_dec_tlu_ctl.scala 526:64]
  reg  _T_190; // @[el2_dec_tlu_ctl.scala 534:81]
  wire  _T_201 = fence_i_r & internal_dbg_halt_mode; // @[el2_dec_tlu_ctl.scala 555:62]
  wire  _T_202 = take_halt | _T_201; // @[el2_dec_tlu_ctl.scala 555:49]
  wire  _T_203 = _T_202 | io_dec_tlu_flush_pause_r; // @[el2_dec_tlu_ctl.scala 555:88]
  wire  _T_204 = i0_trigger_hit_raw_r & trigger_hit_dmode_r; // @[el2_dec_tlu_ctl.scala 555:135]
  wire  _T_205 = _T_203 | _T_204; // @[el2_dec_tlu_ctl.scala 555:115]
  wire  take_ext_int_start = ext_int_ready & _T_704; // @[el2_dec_tlu_ctl.scala 828:45]
  wire  _T_207 = ~interrupt_valid_r; // @[el2_dec_tlu_ctl.scala 560:61]
  wire  _T_208 = dec_tlu_wr_pause_r_d1 & _T_207; // @[el2_dec_tlu_ctl.scala 560:59]
  wire  _T_209 = ~take_ext_int_start; // @[el2_dec_tlu_ctl.scala 560:82]
  wire  _T_231 = io_dec_tlu_flush_lower_r & dcsr[2]; // @[el2_dec_tlu_ctl.scala 564:66]
  wire  _T_232 = io_dec_tlu_resume_ack | dcsr_single_step_running; // @[el2_dec_tlu_ctl.scala 564:109]
  wire  _T_233 = _T_231 & _T_232; // @[el2_dec_tlu_ctl.scala 564:84]
  wire  _T_234 = ~io_dec_tlu_flush_noredir_r; // @[el2_dec_tlu_ctl.scala 564:139]
  wire [3:0] _T_342 = i0_trigger_hit_raw_r ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire  _T_345 = ~trigger_hit_dmode_r; // @[el2_dec_tlu_ctl.scala 622:55]
  wire  mepc_trigger_hit_sel_pc_r = i0_trigger_hit_raw_r & _T_345; // @[el2_dec_tlu_ctl.scala 622:53]
  wire  _T_350 = i_cpu_run_req_sync & _T_346; // @[el2_dec_tlu_ctl.scala 650:58]
  wire  _T_351 = _T_350 & pmu_fw_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 650:83]
  wire  i_cpu_run_req_sync_qual = _T_351 & _T_107; // @[el2_dec_tlu_ctl.scala 650:105]
  reg  _T_353; // @[el2_dec_tlu_ctl.scala 654:81]
  reg  _T_354; // @[el2_dec_tlu_ctl.scala 655:81]
  reg  _T_355; // @[el2_dec_tlu_ctl.scala 656:81]
  wire  _T_384 = io_o_cpu_halt_status & _T_375; // @[el2_dec_tlu_ctl.scala 674:89]
  wire  _T_386 = _T_384 & _T_152; // @[el2_dec_tlu_ctl.scala 674:109]
  wire  _T_388 = io_o_cpu_halt_status & i_cpu_run_req_sync_qual; // @[el2_dec_tlu_ctl.scala 675:41]
  wire  _T_389 = io_o_cpu_run_ack & i_cpu_run_req_sync_qual; // @[el2_dec_tlu_ctl.scala 675:88]
  reg  lsu_single_ecc_error_r_d1; // @[el2_dec_tlu_ctl.scala 687:72]
  reg  lsu_i0_exc_r_d1; // @[el2_dec_tlu_ctl.scala 694:73]
  wire  _T_408 = ~io_lsu_error_pkt_r_exc_type; // @[el2_dec_tlu_ctl.scala 695:40]
  wire  lsu_exc_ma_r = lsu_exc_valid_r & _T_408; // @[el2_dec_tlu_ctl.scala 695:38]
  wire  lsu_exc_acc_r = lsu_exc_valid_r & io_lsu_error_pkt_r_exc_type; // @[el2_dec_tlu_ctl.scala 696:38]
  wire  lsu_exc_st_r = lsu_exc_valid_r & io_lsu_error_pkt_r_inst_type; // @[el2_dec_tlu_ctl.scala 697:38]
  wire  _T_424 = rfpc_i0_r | lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 707:38]
  wire  _T_425 = _T_424 | inst_acc_r; // @[el2_dec_tlu_ctl.scala 707:53]
  wire  _T_426 = illegal_r & io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 707:79]
  wire  _T_427 = _T_425 | _T_426; // @[el2_dec_tlu_ctl.scala 707:66]
  wire  _T_441 = ~io_dec_tlu_flush_lower_r; // @[el2_dec_tlu_ctl.scala 716:70]
  wire  _T_442 = iccm_repair_state_d1 & _T_441; // @[el2_dec_tlu_ctl.scala 716:68]
  wire  _T_453 = io_exu_i0_br_error_r & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 725:51]
  wire  _T_455 = io_exu_i0_br_start_error_r & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 726:63]
  wire  _T_457 = io_exu_i0_br_valid_r & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 727:47]
  wire  _T_459 = _T_457 & _T_429; // @[el2_dec_tlu_ctl.scala 727:71]
  wire  _T_460 = ~io_exu_i0_br_mp_r; // @[el2_dec_tlu_ctl.scala 727:98]
  wire  _T_461 = ~io_exu_pmu_i0_br_ataken; // @[el2_dec_tlu_ctl.scala 727:119]
  wire  _T_462 = _T_460 | _T_461; // @[el2_dec_tlu_ctl.scala 727:117]
  wire  _T_529 = ~take_nmi; // @[el2_dec_tlu_ctl.scala 775:33]
  wire  _T_530 = take_ext_int & _T_529; // @[el2_dec_tlu_ctl.scala 775:31]
  wire  _T_533 = take_timer_int & _T_529; // @[el2_dec_tlu_ctl.scala 776:25]
  wire  _T_536 = take_soft_int & _T_529; // @[el2_dec_tlu_ctl.scala 777:24]
  wire  _T_539 = take_int_timer0_int & _T_529; // @[el2_dec_tlu_ctl.scala 778:30]
  wire  _T_542 = take_int_timer1_int & _T_529; // @[el2_dec_tlu_ctl.scala 779:30]
  wire  _T_545 = take_ce_int & _T_529; // @[el2_dec_tlu_ctl.scala 780:22]
  wire  _T_548 = illegal_r & _T_529; // @[el2_dec_tlu_ctl.scala 781:20]
  wire  _T_551 = ecall_r & _T_529; // @[el2_dec_tlu_ctl.scala 782:19]
  wire  _T_554 = inst_acc_r & _T_529; // @[el2_dec_tlu_ctl.scala 783:22]
  wire  _T_556 = ebreak_r | i0_trigger_hit_raw_r; // @[el2_dec_tlu_ctl.scala 784:20]
  wire  _T_558 = _T_556 & _T_529; // @[el2_dec_tlu_ctl.scala 784:40]
  wire  _T_560 = ~lsu_exc_st_r; // @[el2_dec_tlu_ctl.scala 785:25]
  wire  _T_561 = lsu_exc_ma_r & _T_560; // @[el2_dec_tlu_ctl.scala 785:23]
  wire  _T_563 = _T_561 & _T_529; // @[el2_dec_tlu_ctl.scala 785:39]
  wire  _T_566 = lsu_exc_acc_r & _T_560; // @[el2_dec_tlu_ctl.scala 786:24]
  wire  _T_568 = _T_566 & _T_529; // @[el2_dec_tlu_ctl.scala 786:40]
  wire  _T_570 = lsu_exc_ma_r & lsu_exc_st_r; // @[el2_dec_tlu_ctl.scala 787:23]
  wire  _T_572 = _T_570 & _T_529; // @[el2_dec_tlu_ctl.scala 787:38]
  wire  _T_574 = lsu_exc_acc_r & lsu_exc_st_r; // @[el2_dec_tlu_ctl.scala 788:24]
  wire  _T_576 = _T_574 & _T_529; // @[el2_dec_tlu_ctl.scala 788:39]
  wire [4:0] _T_578 = _T_530 ? 5'hb : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_579 = _T_533 ? 5'h7 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_580 = _T_536 ? 5'h3 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_581 = _T_539 ? 5'h1d : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_582 = _T_542 ? 5'h1c : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_583 = _T_545 ? 5'h1e : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_584 = _T_548 ? 5'h2 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_585 = _T_551 ? 5'hb : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_586 = _T_554 ? 5'h1 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_587 = _T_558 ? 5'h3 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_588 = _T_563 ? 5'h4 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_589 = _T_568 ? 5'h5 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_590 = _T_572 ? 5'h6 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_591 = _T_576 ? 5'h7 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_592 = _T_578 | _T_579; // @[Mux.scala 27:72]
  wire [4:0] _T_593 = _T_592 | _T_580; // @[Mux.scala 27:72]
  wire [4:0] _T_594 = _T_593 | _T_581; // @[Mux.scala 27:72]
  wire [4:0] _T_595 = _T_594 | _T_582; // @[Mux.scala 27:72]
  wire [4:0] _T_596 = _T_595 | _T_583; // @[Mux.scala 27:72]
  wire [4:0] _T_597 = _T_596 | _T_584; // @[Mux.scala 27:72]
  wire [4:0] _T_598 = _T_597 | _T_585; // @[Mux.scala 27:72]
  wire [4:0] _T_599 = _T_598 | _T_586; // @[Mux.scala 27:72]
  wire [4:0] _T_600 = _T_599 | _T_587; // @[Mux.scala 27:72]
  wire [4:0] _T_601 = _T_600 | _T_588; // @[Mux.scala 27:72]
  wire [4:0] _T_602 = _T_601 | _T_589; // @[Mux.scala 27:72]
  wire [4:0] _T_603 = _T_602 | _T_590; // @[Mux.scala 27:72]
  wire [4:0] exc_cause_r = _T_603 | _T_591; // @[Mux.scala 27:72]
  wire  _T_641 = io_dec_csr_stall_int_ff | synchronous_flush_r; // @[el2_dec_tlu_ctl.scala 813:52]
  wire  _T_642 = _T_641 | exc_or_int_valid_r_d1; // @[el2_dec_tlu_ctl.scala 813:74]
  wire  int_timer_stalled = _T_642 | mret_r; // @[el2_dec_tlu_ctl.scala 813:98]
  wire  _T_643 = pmu_fw_tlu_halted_f | int_timer_stalled; // @[el2_dec_tlu_ctl.scala 815:72]
  wire  _T_644 = int_timer0_int_ready & _T_643; // @[el2_dec_tlu_ctl.scala 815:49]
  wire  _T_645 = int_timer0_int_possible & int_timer0_int_hold_f; // @[el2_dec_tlu_ctl.scala 815:121]
  wire  _T_647 = _T_645 & _T_207; // @[el2_dec_tlu_ctl.scala 815:145]
  wire  _T_649 = _T_647 & _T_209; // @[el2_dec_tlu_ctl.scala 815:166]
  wire  _T_651 = _T_649 & _T_152; // @[el2_dec_tlu_ctl.scala 815:188]
  wire  _T_654 = int_timer1_int_ready & _T_643; // @[el2_dec_tlu_ctl.scala 816:49]
  wire  _T_655 = int_timer1_int_possible & int_timer1_int_hold_f; // @[el2_dec_tlu_ctl.scala 816:121]
  wire  _T_657 = _T_655 & _T_207; // @[el2_dec_tlu_ctl.scala 816:145]
  wire  _T_659 = _T_657 & _T_209; // @[el2_dec_tlu_ctl.scala 816:166]
  wire  _T_661 = _T_659 & _T_152; // @[el2_dec_tlu_ctl.scala 816:188]
  reg  take_ext_int_start_d2; // @[el2_dec_tlu_ctl.scala 825:62]
  wire  _T_681 = take_ext_int_start | take_ext_int_start_d1; // @[el2_dec_tlu_ctl.scala 830:46]
  wire  _T_682 = _T_681 | take_ext_int_start_d2; // @[el2_dec_tlu_ctl.scala 830:70]
  wire  csr_pkt_csr_meicpct = csr_read_io_csr_pkt_csr_meicpct; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  fast_int_meicpct = csr_pkt_csr_meicpct & io_dec_csr_any_unq_d; // @[el2_dec_tlu_ctl.scala 832:49]
  wire [30:0] mtvec = csr_io_mtvec; // @[el2_dec_tlu_ctl.scala 1087:31]
  wire [30:0] _T_769 = {mtvec[30:1],1'h0}; // @[Cat.scala 29:58]
  wire [30:0] _T_771 = {25'h0,exc_cause_r,1'h0}; // @[Cat.scala 29:58]
  wire [30:0] vectored_path = _T_769 + _T_771; // @[el2_dec_tlu_ctl.scala 860:51]
  wire [30:0] _T_778 = mtvec[0] ? vectored_path : _T_769; // @[el2_dec_tlu_ctl.scala 861:61]
  wire [30:0] interrupt_path = take_nmi ? io_nmi_vec : _T_778; // @[el2_dec_tlu_ctl.scala 861:28]
  wire  _T_779 = lsu_i0_rfnpc_r | fence_i_r; // @[el2_dec_tlu_ctl.scala 862:36]
  wire  _T_780 = _T_779 | iccm_repair_state_rfnpc; // @[el2_dec_tlu_ctl.scala 862:48]
  wire  _T_782 = i_cpu_run_req_d1 & _T_207; // @[el2_dec_tlu_ctl.scala 862:94]
  wire  _T_783 = _T_780 | _T_782; // @[el2_dec_tlu_ctl.scala 862:74]
  wire  _T_785 = rfpc_i0_r & _T_743; // @[el2_dec_tlu_ctl.scala 862:129]
  wire  sel_npc_r = _T_783 | _T_785; // @[el2_dec_tlu_ctl.scala 862:116]
  wire  _T_798 = interrupt_valid_r | mret_r; // @[el2_dec_tlu_ctl.scala 866:43]
  wire  _T_799 = _T_798 | synchronous_flush_r; // @[el2_dec_tlu_ctl.scala 866:52]
  wire  _T_800 = _T_799 | take_halt; // @[el2_dec_tlu_ctl.scala 866:74]
  wire  _T_801 = _T_800 | take_reset; // @[el2_dec_tlu_ctl.scala 866:86]
  wire  _T_807 = _T_529 & sel_npc_r; // @[el2_dec_tlu_ctl.scala 870:73]
  wire  _T_810 = _T_529 & rfpc_i0_r; // @[el2_dec_tlu_ctl.scala 871:73]
  wire  _T_812 = _T_810 & io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 871:91]
  wire  _T_813 = ~sel_npc_r; // @[el2_dec_tlu_ctl.scala 871:132]
  wire  _T_814 = _T_812 & _T_813; // @[el2_dec_tlu_ctl.scala 871:121]
  wire  _T_816 = ~take_ext_int; // @[el2_dec_tlu_ctl.scala 872:96]
  wire  _T_817 = interrupt_valid_r & _T_816; // @[el2_dec_tlu_ctl.scala 872:82]
  wire  _T_818 = i0_exception_valid_r | lsu_exc_valid_r; // @[el2_dec_tlu_ctl.scala 873:80]
  wire  _T_821 = _T_818 | mepc_trigger_hit_sel_pc_r; // @[el2_dec_tlu_ctl.scala 873:98]
  wire  _T_823 = _T_821 & _T_207; // @[el2_dec_tlu_ctl.scala 873:143]
  wire  _T_825 = _T_823 & _T_816; // @[el2_dec_tlu_ctl.scala 873:164]
  wire  _T_830 = _T_529 & mret_r; // @[el2_dec_tlu_ctl.scala 874:68]
  wire  _T_833 = _T_529 & debug_resume_req_f; // @[el2_dec_tlu_ctl.scala 875:68]
  wire  _T_836 = _T_529 & sel_npc_resume; // @[el2_dec_tlu_ctl.scala 876:68]
  wire [30:0] _T_838 = take_ext_int ? io_lsu_fir_addr : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] npc_r = csr_io_npc_r; // @[el2_dec_tlu_ctl.scala 1075:31]
  wire [30:0] _T_839 = _T_807 ? npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_840 = _T_814 ? io_dec_tlu_i0_pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_841 = _T_817 ? interrupt_path : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_842 = _T_825 ? _T_769 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] mepc = csr_io_mepc; // @[el2_dec_tlu_ctl.scala 1078:31]
  wire [30:0] _T_843 = _T_830 ? mepc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] dpc = csr_io_dpc; // @[el2_dec_tlu_ctl.scala 1081:31]
  wire [30:0] _T_844 = _T_833 ? dpc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] npc_r_d1 = csr_io_npc_r_d1; // @[el2_dec_tlu_ctl.scala 1076:31]
  wire [30:0] _T_845 = _T_836 ? npc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_846 = _T_838 | _T_839; // @[Mux.scala 27:72]
  wire [30:0] _T_847 = _T_846 | _T_840; // @[Mux.scala 27:72]
  wire [30:0] _T_848 = _T_847 | _T_841; // @[Mux.scala 27:72]
  wire [30:0] _T_849 = _T_848 | _T_842; // @[Mux.scala 27:72]
  wire [30:0] _T_850 = _T_849 | _T_843; // @[Mux.scala 27:72]
  wire [30:0] _T_851 = _T_850 | _T_844; // @[Mux.scala 27:72]
  wire [30:0] _T_852 = _T_851 | _T_845; // @[Mux.scala 27:72]
  reg [30:0] tlu_flush_path_r_d1; // @[el2_dec_tlu_ctl.scala 879:64]
  wire  _T_854 = lsu_exc_valid_r | i0_exception_valid_r; // @[el2_dec_tlu_ctl.scala 886:45]
  wire  _T_855 = _T_854 | interrupt_valid_r; // @[el2_dec_tlu_ctl.scala 886:68]
  reg  i0_exception_valid_r_d1; // @[el2_dec_tlu_ctl.scala 889:89]
  reg [4:0] exc_cause_wb; // @[el2_dec_tlu_ctl.scala 891:89]
  wire  _T_860 = ~illegal_r; // @[el2_dec_tlu_ctl.scala 892:119]
  reg  i0_valid_wb; // @[el2_dec_tlu_ctl.scala 892:97]
  reg  trigger_hit_r_d1; // @[el2_dec_tlu_ctl.scala 893:89]
  wire  csr_pkt_presync = csr_read_io_csr_pkt_presync; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_864 = csr_pkt_presync & io_dec_csr_any_unq_d; // @[el2_dec_tlu_ctl.scala 1094:42]
  wire  _T_865 = ~io_dec_csr_wen_unq_d; // @[el2_dec_tlu_ctl.scala 1094:67]
  wire  csr_pkt_postsync = csr_read_io_csr_pkt_postsync; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  csr_pkt_csr_dcsr = csr_read_io_csr_pkt_csr_dcsr; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  csr_pkt_csr_dpc = csr_read_io_csr_pkt_csr_dpc; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_874 = csr_pkt_csr_dcsr | csr_pkt_csr_dpc; // @[el2_dec_tlu_ctl.scala 1099:55]
  wire  csr_pkt_csr_dmst = csr_read_io_csr_pkt_csr_dmst; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_875 = _T_874 | csr_pkt_csr_dmst; // @[el2_dec_tlu_ctl.scala 1099:73]
  wire  csr_pkt_csr_dicawics = csr_read_io_csr_pkt_csr_dicawics; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_876 = _T_875 | csr_pkt_csr_dicawics; // @[el2_dec_tlu_ctl.scala 1099:92]
  wire  csr_pkt_csr_dicad0 = csr_read_io_csr_pkt_csr_dicad0; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_877 = _T_876 | csr_pkt_csr_dicad0; // @[el2_dec_tlu_ctl.scala 1099:115]
  wire  csr_pkt_csr_dicad0h = csr_read_io_csr_pkt_csr_dicad0h; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_878 = _T_877 | csr_pkt_csr_dicad0h; // @[el2_dec_tlu_ctl.scala 1099:136]
  wire  csr_pkt_csr_dicad1 = csr_read_io_csr_pkt_csr_dicad1; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_879 = _T_878 | csr_pkt_csr_dicad1; // @[el2_dec_tlu_ctl.scala 1099:158]
  wire  csr_pkt_csr_dicago = csr_read_io_csr_pkt_csr_dicago; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_880 = _T_879 | csr_pkt_csr_dicago; // @[el2_dec_tlu_ctl.scala 1099:179]
  wire  _T_881 = ~_T_880; // @[el2_dec_tlu_ctl.scala 1099:36]
  wire  _T_882 = _T_881 | dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 1099:201]
  wire  csr_pkt_legal = csr_read_io_csr_pkt_legal; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_883 = csr_pkt_legal & _T_882; // @[el2_dec_tlu_ctl.scala 1099:33]
  wire  _T_884 = ~fast_int_meicpct; // @[el2_dec_tlu_ctl.scala 1099:223]
  wire  valid_csr = _T_883 & _T_884; // @[el2_dec_tlu_ctl.scala 1099:221]
  wire  _T_887 = io_dec_csr_any_unq_d & valid_csr; // @[el2_dec_tlu_ctl.scala 1101:46]
  wire  csr_pkt_csr_mvendorid = csr_read_io_csr_pkt_csr_mvendorid; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  csr_pkt_csr_marchid = csr_read_io_csr_pkt_csr_marchid; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_888 = csr_pkt_csr_mvendorid | csr_pkt_csr_marchid; // @[el2_dec_tlu_ctl.scala 1101:107]
  wire  csr_pkt_csr_mimpid = csr_read_io_csr_pkt_csr_mimpid; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_889 = _T_888 | csr_pkt_csr_mimpid; // @[el2_dec_tlu_ctl.scala 1101:129]
  wire  csr_pkt_csr_mhartid = csr_read_io_csr_pkt_csr_mhartid; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_890 = _T_889 | csr_pkt_csr_mhartid; // @[el2_dec_tlu_ctl.scala 1101:150]
  wire  csr_pkt_csr_mdseac = csr_read_io_csr_pkt_csr_mdseac; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_891 = _T_890 | csr_pkt_csr_mdseac; // @[el2_dec_tlu_ctl.scala 1101:172]
  wire  csr_pkt_csr_meihap = csr_read_io_csr_pkt_csr_meihap; // @[el2_dec_tlu_ctl.scala 351:41 el2_dec_tlu_ctl.scala 1092:16]
  wire  _T_892 = _T_891 | csr_pkt_csr_meihap; // @[el2_dec_tlu_ctl.scala 1101:193]
  wire  _T_893 = io_dec_csr_wen_unq_d & _T_892; // @[el2_dec_tlu_ctl.scala 1101:82]
  wire  _T_894 = ~_T_893; // @[el2_dec_tlu_ctl.scala 1101:59]
  el2_dec_timer_ctl int_timers ( // @[el2_dec_tlu_ctl.scala 355:30]
    .clock(int_timers_clock),
    .reset(int_timers_reset),
    .io_free_clk(int_timers_io_free_clk),
    .io_scan_mode(int_timers_io_scan_mode),
    .io_dec_csr_wen_r_mod(int_timers_io_dec_csr_wen_r_mod),
    .io_dec_csr_wraddr_r(int_timers_io_dec_csr_wraddr_r),
    .io_dec_csr_wrdata_r(int_timers_io_dec_csr_wrdata_r),
    .io_csr_mitctl0(int_timers_io_csr_mitctl0),
    .io_csr_mitctl1(int_timers_io_csr_mitctl1),
    .io_csr_mitb0(int_timers_io_csr_mitb0),
    .io_csr_mitb1(int_timers_io_csr_mitb1),
    .io_csr_mitcnt0(int_timers_io_csr_mitcnt0),
    .io_csr_mitcnt1(int_timers_io_csr_mitcnt1),
    .io_dec_pause_state(int_timers_io_dec_pause_state),
    .io_dec_tlu_pmu_fw_halted(int_timers_io_dec_tlu_pmu_fw_halted),
    .io_internal_dbg_halt_timers(int_timers_io_internal_dbg_halt_timers),
    .io_dec_timer_rddata_d(int_timers_io_dec_timer_rddata_d),
    .io_dec_timer_read_d(int_timers_io_dec_timer_read_d),
    .io_dec_timer_t0_pulse(int_timers_io_dec_timer_t0_pulse),
    .io_dec_timer_t1_pulse(int_timers_io_dec_timer_t1_pulse)
  );
  rvclkhdr rvclkhdr ( // @[el2_lib.scala 483:22]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[el2_lib.scala 483:22]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  rvclkhdr rvclkhdr_2 ( // @[el2_lib.scala 483:22]
    .io_l1clk(rvclkhdr_2_io_l1clk),
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en),
    .io_scan_mode(rvclkhdr_2_io_scan_mode)
  );
  rvclkhdr rvclkhdr_3 ( // @[el2_lib.scala 483:22]
    .io_l1clk(rvclkhdr_3_io_l1clk),
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en),
    .io_scan_mode(rvclkhdr_3_io_scan_mode)
  );
  csr_tlu csr ( // @[el2_dec_tlu_ctl.scala 897:15]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_free_clk(csr_io_free_clk),
    .io_active_clk(csr_io_active_clk),
    .io_scan_mode(csr_io_scan_mode),
    .io_dec_csr_wrdata_r(csr_io_dec_csr_wrdata_r),
    .io_dec_csr_wraddr_r(csr_io_dec_csr_wraddr_r),
    .io_dec_csr_rdaddr_d(csr_io_dec_csr_rdaddr_d),
    .io_dec_csr_wen_unq_d(csr_io_dec_csr_wen_unq_d),
    .io_dec_i0_decode_d(csr_io_dec_i0_decode_d),
    .io_dec_tlu_ic_diag_pkt_icache_wrdata(csr_io_dec_tlu_ic_diag_pkt_icache_wrdata),
    .io_dec_tlu_ic_diag_pkt_icache_dicawics(csr_io_dec_tlu_ic_diag_pkt_icache_dicawics),
    .io_dec_tlu_ic_diag_pkt_icache_rd_valid(csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid),
    .io_dec_tlu_ic_diag_pkt_icache_wr_valid(csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid),
    .io_ifu_ic_debug_rd_data_valid(csr_io_ifu_ic_debug_rd_data_valid),
    .io_trigger_pkt_any_0_select(csr_io_trigger_pkt_any_0_select),
    .io_trigger_pkt_any_0_match_(csr_io_trigger_pkt_any_0_match_),
    .io_trigger_pkt_any_0_store(csr_io_trigger_pkt_any_0_store),
    .io_trigger_pkt_any_0_load(csr_io_trigger_pkt_any_0_load),
    .io_trigger_pkt_any_0_execute(csr_io_trigger_pkt_any_0_execute),
    .io_trigger_pkt_any_0_m(csr_io_trigger_pkt_any_0_m),
    .io_trigger_pkt_any_0_tdata2(csr_io_trigger_pkt_any_0_tdata2),
    .io_trigger_pkt_any_1_select(csr_io_trigger_pkt_any_1_select),
    .io_trigger_pkt_any_1_match_(csr_io_trigger_pkt_any_1_match_),
    .io_trigger_pkt_any_1_store(csr_io_trigger_pkt_any_1_store),
    .io_trigger_pkt_any_1_load(csr_io_trigger_pkt_any_1_load),
    .io_trigger_pkt_any_1_execute(csr_io_trigger_pkt_any_1_execute),
    .io_trigger_pkt_any_1_m(csr_io_trigger_pkt_any_1_m),
    .io_trigger_pkt_any_1_tdata2(csr_io_trigger_pkt_any_1_tdata2),
    .io_trigger_pkt_any_2_select(csr_io_trigger_pkt_any_2_select),
    .io_trigger_pkt_any_2_match_(csr_io_trigger_pkt_any_2_match_),
    .io_trigger_pkt_any_2_store(csr_io_trigger_pkt_any_2_store),
    .io_trigger_pkt_any_2_load(csr_io_trigger_pkt_any_2_load),
    .io_trigger_pkt_any_2_execute(csr_io_trigger_pkt_any_2_execute),
    .io_trigger_pkt_any_2_m(csr_io_trigger_pkt_any_2_m),
    .io_trigger_pkt_any_2_tdata2(csr_io_trigger_pkt_any_2_tdata2),
    .io_trigger_pkt_any_3_select(csr_io_trigger_pkt_any_3_select),
    .io_trigger_pkt_any_3_match_(csr_io_trigger_pkt_any_3_match_),
    .io_trigger_pkt_any_3_store(csr_io_trigger_pkt_any_3_store),
    .io_trigger_pkt_any_3_load(csr_io_trigger_pkt_any_3_load),
    .io_trigger_pkt_any_3_execute(csr_io_trigger_pkt_any_3_execute),
    .io_trigger_pkt_any_3_m(csr_io_trigger_pkt_any_3_m),
    .io_trigger_pkt_any_3_tdata2(csr_io_trigger_pkt_any_3_tdata2),
    .io_ifu_pmu_bus_trxn(csr_io_ifu_pmu_bus_trxn),
    .io_dma_iccm_stall_any(csr_io_dma_iccm_stall_any),
    .io_dma_dccm_stall_any(csr_io_dma_dccm_stall_any),
    .io_lsu_store_stall_any(csr_io_lsu_store_stall_any),
    .io_dec_pmu_presync_stall(csr_io_dec_pmu_presync_stall),
    .io_dec_pmu_postsync_stall(csr_io_dec_pmu_postsync_stall),
    .io_dec_pmu_decode_stall(csr_io_dec_pmu_decode_stall),
    .io_ifu_pmu_fetch_stall(csr_io_ifu_pmu_fetch_stall),
    .io_dec_tlu_packet_r_icaf_type(csr_io_dec_tlu_packet_r_icaf_type),
    .io_dec_tlu_packet_r_pmu_i0_itype(csr_io_dec_tlu_packet_r_pmu_i0_itype),
    .io_dec_tlu_packet_r_pmu_i0_br_unpred(csr_io_dec_tlu_packet_r_pmu_i0_br_unpred),
    .io_dec_tlu_packet_r_pmu_divide(csr_io_dec_tlu_packet_r_pmu_divide),
    .io_dec_tlu_packet_r_pmu_lsu_misaligned(csr_io_dec_tlu_packet_r_pmu_lsu_misaligned),
    .io_exu_pmu_i0_br_ataken(csr_io_exu_pmu_i0_br_ataken),
    .io_exu_pmu_i0_br_misp(csr_io_exu_pmu_i0_br_misp),
    .io_dec_pmu_instr_decoded(csr_io_dec_pmu_instr_decoded),
    .io_ifu_pmu_instr_aligned(csr_io_ifu_pmu_instr_aligned),
    .io_exu_pmu_i0_pc4(csr_io_exu_pmu_i0_pc4),
    .io_ifu_pmu_ic_miss(csr_io_ifu_pmu_ic_miss),
    .io_ifu_pmu_ic_hit(csr_io_ifu_pmu_ic_hit),
    .io_dec_tlu_int_valid_wb1(csr_io_dec_tlu_int_valid_wb1),
    .io_dec_tlu_i0_exc_valid_wb1(csr_io_dec_tlu_i0_exc_valid_wb1),
    .io_dec_tlu_i0_valid_wb1(csr_io_dec_tlu_i0_valid_wb1),
    .io_dec_csr_wen_r(csr_io_dec_csr_wen_r),
    .io_dec_tlu_mtval_wb1(csr_io_dec_tlu_mtval_wb1),
    .io_dec_tlu_exc_cause_wb1(csr_io_dec_tlu_exc_cause_wb1),
    .io_dec_tlu_perfcnt0(csr_io_dec_tlu_perfcnt0),
    .io_dec_tlu_perfcnt1(csr_io_dec_tlu_perfcnt1),
    .io_dec_tlu_perfcnt2(csr_io_dec_tlu_perfcnt2),
    .io_dec_tlu_perfcnt3(csr_io_dec_tlu_perfcnt3),
    .io_dec_tlu_dbg_halted(csr_io_dec_tlu_dbg_halted),
    .io_dma_pmu_dccm_write(csr_io_dma_pmu_dccm_write),
    .io_dma_pmu_dccm_read(csr_io_dma_pmu_dccm_read),
    .io_dma_pmu_any_write(csr_io_dma_pmu_any_write),
    .io_dma_pmu_any_read(csr_io_dma_pmu_any_read),
    .io_lsu_pmu_bus_busy(csr_io_lsu_pmu_bus_busy),
    .io_dec_tlu_i0_pc_r(csr_io_dec_tlu_i0_pc_r),
    .io_dec_tlu_i0_valid_r(csr_io_dec_tlu_i0_valid_r),
    .io_dec_csr_any_unq_d(csr_io_dec_csr_any_unq_d),
    .io_dec_tlu_misc_clk_override(csr_io_dec_tlu_misc_clk_override),
    .io_dec_tlu_dec_clk_override(csr_io_dec_tlu_dec_clk_override),
    .io_dec_tlu_ifu_clk_override(csr_io_dec_tlu_ifu_clk_override),
    .io_dec_tlu_lsu_clk_override(csr_io_dec_tlu_lsu_clk_override),
    .io_dec_tlu_bus_clk_override(csr_io_dec_tlu_bus_clk_override),
    .io_dec_tlu_pic_clk_override(csr_io_dec_tlu_pic_clk_override),
    .io_dec_tlu_dccm_clk_override(csr_io_dec_tlu_dccm_clk_override),
    .io_dec_tlu_icm_clk_override(csr_io_dec_tlu_icm_clk_override),
    .io_dec_csr_rddata_d(csr_io_dec_csr_rddata_d),
    .io_dec_tlu_pipelining_disable(csr_io_dec_tlu_pipelining_disable),
    .io_dec_tlu_wr_pause_r(csr_io_dec_tlu_wr_pause_r),
    .io_ifu_pmu_bus_busy(csr_io_ifu_pmu_bus_busy),
    .io_lsu_pmu_bus_error(csr_io_lsu_pmu_bus_error),
    .io_ifu_pmu_bus_error(csr_io_ifu_pmu_bus_error),
    .io_lsu_pmu_bus_misaligned(csr_io_lsu_pmu_bus_misaligned),
    .io_lsu_pmu_bus_trxn(csr_io_lsu_pmu_bus_trxn),
    .io_ifu_ic_debug_rd_data(csr_io_ifu_ic_debug_rd_data),
    .io_dec_tlu_meipt(csr_io_dec_tlu_meipt),
    .io_pic_pl(csr_io_pic_pl),
    .io_dec_tlu_meicurpl(csr_io_dec_tlu_meicurpl),
    .io_dec_tlu_meihap(csr_io_dec_tlu_meihap),
    .io_pic_claimid(csr_io_pic_claimid),
    .io_iccm_dma_sb_error(csr_io_iccm_dma_sb_error),
    .io_lsu_imprecise_error_addr_any(csr_io_lsu_imprecise_error_addr_any),
    .io_lsu_imprecise_error_load_any(csr_io_lsu_imprecise_error_load_any),
    .io_lsu_imprecise_error_store_any(csr_io_lsu_imprecise_error_store_any),
    .io_dec_tlu_mrac_ff(csr_io_dec_tlu_mrac_ff),
    .io_dec_tlu_wb_coalescing_disable(csr_io_dec_tlu_wb_coalescing_disable),
    .io_dec_tlu_bpred_disable(csr_io_dec_tlu_bpred_disable),
    .io_dec_tlu_sideeffect_posted_disable(csr_io_dec_tlu_sideeffect_posted_disable),
    .io_dec_tlu_core_ecc_disable(csr_io_dec_tlu_core_ecc_disable),
    .io_dec_tlu_external_ldfwd_disable(csr_io_dec_tlu_external_ldfwd_disable),
    .io_dec_tlu_dma_qos_prty(csr_io_dec_tlu_dma_qos_prty),
    .io_dec_illegal_inst(csr_io_dec_illegal_inst),
    .io_lsu_error_pkt_r_mscause(csr_io_lsu_error_pkt_r_mscause),
    .io_mexintpend(csr_io_mexintpend),
    .io_exu_npc_r(csr_io_exu_npc_r),
    .io_mpc_reset_run_req(csr_io_mpc_reset_run_req),
    .io_rst_vec(csr_io_rst_vec),
    .io_core_id(csr_io_core_id),
    .io_dec_timer_rddata_d(csr_io_dec_timer_rddata_d),
    .io_dec_timer_read_d(csr_io_dec_timer_read_d),
    .io_dec_csr_wen_r_mod(csr_io_dec_csr_wen_r_mod),
    .io_rfpc_i0_r(csr_io_rfpc_i0_r),
    .io_i0_trigger_hit_r(csr_io_i0_trigger_hit_r),
    .io_fw_halt_req(csr_io_fw_halt_req),
    .io_mstatus(csr_io_mstatus),
    .io_exc_or_int_valid_r(csr_io_exc_or_int_valid_r),
    .io_mret_r(csr_io_mret_r),
    .io_mstatus_mie_ns(csr_io_mstatus_mie_ns),
    .io_dcsr_single_step_running_f(csr_io_dcsr_single_step_running_f),
    .io_dcsr(csr_io_dcsr),
    .io_mtvec(csr_io_mtvec),
    .io_mip(csr_io_mip),
    .io_dec_timer_t0_pulse(csr_io_dec_timer_t0_pulse),
    .io_dec_timer_t1_pulse(csr_io_dec_timer_t1_pulse),
    .io_timer_int_sync(csr_io_timer_int_sync),
    .io_soft_int_sync(csr_io_soft_int_sync),
    .io_mie_ns(csr_io_mie_ns),
    .io_csr_wr_clk(csr_io_csr_wr_clk),
    .io_ebreak_to_debug_mode_r(csr_io_ebreak_to_debug_mode_r),
    .io_dec_tlu_pmu_fw_halted(csr_io_dec_tlu_pmu_fw_halted),
    .io_lsu_fir_error(csr_io_lsu_fir_error),
    .io_npc_r(csr_io_npc_r),
    .io_tlu_flush_lower_r_d1(csr_io_tlu_flush_lower_r_d1),
    .io_dec_tlu_flush_noredir_r_d1(csr_io_dec_tlu_flush_noredir_r_d1),
    .io_tlu_flush_path_r_d1(csr_io_tlu_flush_path_r_d1),
    .io_npc_r_d1(csr_io_npc_r_d1),
    .io_reset_delayed(csr_io_reset_delayed),
    .io_mepc(csr_io_mepc),
    .io_interrupt_valid_r(csr_io_interrupt_valid_r),
    .io_i0_exception_valid_r(csr_io_i0_exception_valid_r),
    .io_lsu_exc_valid_r(csr_io_lsu_exc_valid_r),
    .io_mepc_trigger_hit_sel_pc_r(csr_io_mepc_trigger_hit_sel_pc_r),
    .io_e4e5_int_clk(csr_io_e4e5_int_clk),
    .io_lsu_i0_exc_r(csr_io_lsu_i0_exc_r),
    .io_inst_acc_r(csr_io_inst_acc_r),
    .io_inst_acc_second_r(csr_io_inst_acc_second_r),
    .io_take_nmi(csr_io_take_nmi),
    .io_lsu_error_pkt_addr_r(csr_io_lsu_error_pkt_addr_r),
    .io_exc_cause_r(csr_io_exc_cause_r),
    .io_i0_valid_wb(csr_io_i0_valid_wb),
    .io_exc_or_int_valid_r_d1(csr_io_exc_or_int_valid_r_d1),
    .io_interrupt_valid_r_d1(csr_io_interrupt_valid_r_d1),
    .io_clk_override(csr_io_clk_override),
    .io_i0_exception_valid_r_d1(csr_io_i0_exception_valid_r_d1),
    .io_lsu_i0_exc_r_d1(csr_io_lsu_i0_exc_r_d1),
    .io_exc_cause_wb(csr_io_exc_cause_wb),
    .io_nmi_lsu_store_type(csr_io_nmi_lsu_store_type),
    .io_nmi_lsu_load_type(csr_io_nmi_lsu_load_type),
    .io_tlu_i0_commit_cmt(csr_io_tlu_i0_commit_cmt),
    .io_ebreak_r(csr_io_ebreak_r),
    .io_ecall_r(csr_io_ecall_r),
    .io_illegal_r(csr_io_illegal_r),
    .io_mdseac_locked_ns(csr_io_mdseac_locked_ns),
    .io_mdseac_locked_f(csr_io_mdseac_locked_f),
    .io_nmi_int_detected_f(csr_io_nmi_int_detected_f),
    .io_internal_dbg_halt_mode_f2(csr_io_internal_dbg_halt_mode_f2),
    .io_ext_int_freeze_d1(csr_io_ext_int_freeze_d1),
    .io_ic_perr_r_d1(csr_io_ic_perr_r_d1),
    .io_iccm_sbecc_r_d1(csr_io_iccm_sbecc_r_d1),
    .io_lsu_single_ecc_error_r_d1(csr_io_lsu_single_ecc_error_r_d1),
    .io_ifu_miss_state_idle_f(csr_io_ifu_miss_state_idle_f),
    .io_lsu_idle_any_f(csr_io_lsu_idle_any_f),
    .io_dbg_tlu_halted_f(csr_io_dbg_tlu_halted_f),
    .io_dbg_tlu_halted(csr_io_dbg_tlu_halted),
    .io_debug_halt_req_f(csr_io_debug_halt_req_f),
    .io_force_halt(csr_io_force_halt),
    .io_take_ext_int_start(csr_io_take_ext_int_start),
    .io_trigger_hit_dmode_r_d1(csr_io_trigger_hit_dmode_r_d1),
    .io_trigger_hit_r_d1(csr_io_trigger_hit_r_d1),
    .io_dcsr_single_step_done_f(csr_io_dcsr_single_step_done_f),
    .io_ebreak_to_debug_mode_r_d1(csr_io_ebreak_to_debug_mode_r_d1),
    .io_debug_halt_req(csr_io_debug_halt_req),
    .io_allow_dbg_halt_csr_write(csr_io_allow_dbg_halt_csr_write),
    .io_internal_dbg_halt_mode_f(csr_io_internal_dbg_halt_mode_f),
    .io_enter_debug_halt_req(csr_io_enter_debug_halt_req),
    .io_internal_dbg_halt_mode(csr_io_internal_dbg_halt_mode),
    .io_request_debug_mode_done(csr_io_request_debug_mode_done),
    .io_request_debug_mode_r(csr_io_request_debug_mode_r),
    .io_dpc(csr_io_dpc),
    .io_update_hit_bit_r(csr_io_update_hit_bit_r),
    .io_take_timer_int(csr_io_take_timer_int),
    .io_take_int_timer0_int(csr_io_take_int_timer0_int),
    .io_take_int_timer1_int(csr_io_take_int_timer1_int),
    .io_take_ext_int(csr_io_take_ext_int),
    .io_tlu_flush_lower_r(csr_io_tlu_flush_lower_r),
    .io_dec_tlu_br0_error_r(csr_io_dec_tlu_br0_error_r),
    .io_dec_tlu_br0_start_error_r(csr_io_dec_tlu_br0_start_error_r),
    .io_lsu_pmu_load_external_r(csr_io_lsu_pmu_load_external_r),
    .io_lsu_pmu_store_external_r(csr_io_lsu_pmu_store_external_r),
    .io_csr_pkt_csr_misa(csr_io_csr_pkt_csr_misa),
    .io_csr_pkt_csr_mvendorid(csr_io_csr_pkt_csr_mvendorid),
    .io_csr_pkt_csr_marchid(csr_io_csr_pkt_csr_marchid),
    .io_csr_pkt_csr_mimpid(csr_io_csr_pkt_csr_mimpid),
    .io_csr_pkt_csr_mhartid(csr_io_csr_pkt_csr_mhartid),
    .io_csr_pkt_csr_mstatus(csr_io_csr_pkt_csr_mstatus),
    .io_csr_pkt_csr_mtvec(csr_io_csr_pkt_csr_mtvec),
    .io_csr_pkt_csr_mip(csr_io_csr_pkt_csr_mip),
    .io_csr_pkt_csr_mie(csr_io_csr_pkt_csr_mie),
    .io_csr_pkt_csr_mcyclel(csr_io_csr_pkt_csr_mcyclel),
    .io_csr_pkt_csr_mcycleh(csr_io_csr_pkt_csr_mcycleh),
    .io_csr_pkt_csr_minstretl(csr_io_csr_pkt_csr_minstretl),
    .io_csr_pkt_csr_minstreth(csr_io_csr_pkt_csr_minstreth),
    .io_csr_pkt_csr_mscratch(csr_io_csr_pkt_csr_mscratch),
    .io_csr_pkt_csr_mepc(csr_io_csr_pkt_csr_mepc),
    .io_csr_pkt_csr_mcause(csr_io_csr_pkt_csr_mcause),
    .io_csr_pkt_csr_mscause(csr_io_csr_pkt_csr_mscause),
    .io_csr_pkt_csr_mtval(csr_io_csr_pkt_csr_mtval),
    .io_csr_pkt_csr_mrac(csr_io_csr_pkt_csr_mrac),
    .io_csr_pkt_csr_mdseac(csr_io_csr_pkt_csr_mdseac),
    .io_csr_pkt_csr_meihap(csr_io_csr_pkt_csr_meihap),
    .io_csr_pkt_csr_meivt(csr_io_csr_pkt_csr_meivt),
    .io_csr_pkt_csr_meipt(csr_io_csr_pkt_csr_meipt),
    .io_csr_pkt_csr_meicurpl(csr_io_csr_pkt_csr_meicurpl),
    .io_csr_pkt_csr_meicidpl(csr_io_csr_pkt_csr_meicidpl),
    .io_csr_pkt_csr_dcsr(csr_io_csr_pkt_csr_dcsr),
    .io_csr_pkt_csr_mcgc(csr_io_csr_pkt_csr_mcgc),
    .io_csr_pkt_csr_mfdc(csr_io_csr_pkt_csr_mfdc),
    .io_csr_pkt_csr_dpc(csr_io_csr_pkt_csr_dpc),
    .io_csr_pkt_csr_mtsel(csr_io_csr_pkt_csr_mtsel),
    .io_csr_pkt_csr_mtdata1(csr_io_csr_pkt_csr_mtdata1),
    .io_csr_pkt_csr_mtdata2(csr_io_csr_pkt_csr_mtdata2),
    .io_csr_pkt_csr_mhpmc3(csr_io_csr_pkt_csr_mhpmc3),
    .io_csr_pkt_csr_mhpmc4(csr_io_csr_pkt_csr_mhpmc4),
    .io_csr_pkt_csr_mhpmc5(csr_io_csr_pkt_csr_mhpmc5),
    .io_csr_pkt_csr_mhpmc6(csr_io_csr_pkt_csr_mhpmc6),
    .io_csr_pkt_csr_mhpmc3h(csr_io_csr_pkt_csr_mhpmc3h),
    .io_csr_pkt_csr_mhpmc4h(csr_io_csr_pkt_csr_mhpmc4h),
    .io_csr_pkt_csr_mhpmc5h(csr_io_csr_pkt_csr_mhpmc5h),
    .io_csr_pkt_csr_mhpmc6h(csr_io_csr_pkt_csr_mhpmc6h),
    .io_csr_pkt_csr_mhpme3(csr_io_csr_pkt_csr_mhpme3),
    .io_csr_pkt_csr_mhpme4(csr_io_csr_pkt_csr_mhpme4),
    .io_csr_pkt_csr_mhpme5(csr_io_csr_pkt_csr_mhpme5),
    .io_csr_pkt_csr_mhpme6(csr_io_csr_pkt_csr_mhpme6),
    .io_csr_pkt_csr_mcountinhibit(csr_io_csr_pkt_csr_mcountinhibit),
    .io_csr_pkt_csr_mpmc(csr_io_csr_pkt_csr_mpmc),
    .io_csr_pkt_csr_micect(csr_io_csr_pkt_csr_micect),
    .io_csr_pkt_csr_miccmect(csr_io_csr_pkt_csr_miccmect),
    .io_csr_pkt_csr_mdccmect(csr_io_csr_pkt_csr_mdccmect),
    .io_csr_pkt_csr_mfdht(csr_io_csr_pkt_csr_mfdht),
    .io_csr_pkt_csr_mfdhs(csr_io_csr_pkt_csr_mfdhs),
    .io_csr_pkt_csr_dicawics(csr_io_csr_pkt_csr_dicawics),
    .io_csr_pkt_csr_dicad0h(csr_io_csr_pkt_csr_dicad0h),
    .io_csr_pkt_csr_dicad0(csr_io_csr_pkt_csr_dicad0),
    .io_csr_pkt_csr_dicad1(csr_io_csr_pkt_csr_dicad1),
    .io_mtdata1_t_0(csr_io_mtdata1_t_0),
    .io_mtdata1_t_1(csr_io_mtdata1_t_1),
    .io_mtdata1_t_2(csr_io_mtdata1_t_2),
    .io_mtdata1_t_3(csr_io_mtdata1_t_3)
  );
  el2_dec_decode_csr_read csr_read ( // @[el2_dec_tlu_ctl.scala 1090:22]
    .io_dec_csr_rdaddr_d(csr_read_io_dec_csr_rdaddr_d),
    .io_csr_pkt_csr_misa(csr_read_io_csr_pkt_csr_misa),
    .io_csr_pkt_csr_mvendorid(csr_read_io_csr_pkt_csr_mvendorid),
    .io_csr_pkt_csr_marchid(csr_read_io_csr_pkt_csr_marchid),
    .io_csr_pkt_csr_mimpid(csr_read_io_csr_pkt_csr_mimpid),
    .io_csr_pkt_csr_mhartid(csr_read_io_csr_pkt_csr_mhartid),
    .io_csr_pkt_csr_mstatus(csr_read_io_csr_pkt_csr_mstatus),
    .io_csr_pkt_csr_mtvec(csr_read_io_csr_pkt_csr_mtvec),
    .io_csr_pkt_csr_mip(csr_read_io_csr_pkt_csr_mip),
    .io_csr_pkt_csr_mie(csr_read_io_csr_pkt_csr_mie),
    .io_csr_pkt_csr_mcyclel(csr_read_io_csr_pkt_csr_mcyclel),
    .io_csr_pkt_csr_mcycleh(csr_read_io_csr_pkt_csr_mcycleh),
    .io_csr_pkt_csr_minstretl(csr_read_io_csr_pkt_csr_minstretl),
    .io_csr_pkt_csr_minstreth(csr_read_io_csr_pkt_csr_minstreth),
    .io_csr_pkt_csr_mscratch(csr_read_io_csr_pkt_csr_mscratch),
    .io_csr_pkt_csr_mepc(csr_read_io_csr_pkt_csr_mepc),
    .io_csr_pkt_csr_mcause(csr_read_io_csr_pkt_csr_mcause),
    .io_csr_pkt_csr_mscause(csr_read_io_csr_pkt_csr_mscause),
    .io_csr_pkt_csr_mtval(csr_read_io_csr_pkt_csr_mtval),
    .io_csr_pkt_csr_mrac(csr_read_io_csr_pkt_csr_mrac),
    .io_csr_pkt_csr_dmst(csr_read_io_csr_pkt_csr_dmst),
    .io_csr_pkt_csr_mdseac(csr_read_io_csr_pkt_csr_mdseac),
    .io_csr_pkt_csr_meihap(csr_read_io_csr_pkt_csr_meihap),
    .io_csr_pkt_csr_meivt(csr_read_io_csr_pkt_csr_meivt),
    .io_csr_pkt_csr_meipt(csr_read_io_csr_pkt_csr_meipt),
    .io_csr_pkt_csr_meicurpl(csr_read_io_csr_pkt_csr_meicurpl),
    .io_csr_pkt_csr_meicidpl(csr_read_io_csr_pkt_csr_meicidpl),
    .io_csr_pkt_csr_dcsr(csr_read_io_csr_pkt_csr_dcsr),
    .io_csr_pkt_csr_mcgc(csr_read_io_csr_pkt_csr_mcgc),
    .io_csr_pkt_csr_mfdc(csr_read_io_csr_pkt_csr_mfdc),
    .io_csr_pkt_csr_dpc(csr_read_io_csr_pkt_csr_dpc),
    .io_csr_pkt_csr_mtsel(csr_read_io_csr_pkt_csr_mtsel),
    .io_csr_pkt_csr_mtdata1(csr_read_io_csr_pkt_csr_mtdata1),
    .io_csr_pkt_csr_mtdata2(csr_read_io_csr_pkt_csr_mtdata2),
    .io_csr_pkt_csr_mhpmc3(csr_read_io_csr_pkt_csr_mhpmc3),
    .io_csr_pkt_csr_mhpmc4(csr_read_io_csr_pkt_csr_mhpmc4),
    .io_csr_pkt_csr_mhpmc5(csr_read_io_csr_pkt_csr_mhpmc5),
    .io_csr_pkt_csr_mhpmc6(csr_read_io_csr_pkt_csr_mhpmc6),
    .io_csr_pkt_csr_mhpmc3h(csr_read_io_csr_pkt_csr_mhpmc3h),
    .io_csr_pkt_csr_mhpmc4h(csr_read_io_csr_pkt_csr_mhpmc4h),
    .io_csr_pkt_csr_mhpmc5h(csr_read_io_csr_pkt_csr_mhpmc5h),
    .io_csr_pkt_csr_mhpmc6h(csr_read_io_csr_pkt_csr_mhpmc6h),
    .io_csr_pkt_csr_mhpme3(csr_read_io_csr_pkt_csr_mhpme3),
    .io_csr_pkt_csr_mhpme4(csr_read_io_csr_pkt_csr_mhpme4),
    .io_csr_pkt_csr_mhpme5(csr_read_io_csr_pkt_csr_mhpme5),
    .io_csr_pkt_csr_mhpme6(csr_read_io_csr_pkt_csr_mhpme6),
    .io_csr_pkt_csr_mcountinhibit(csr_read_io_csr_pkt_csr_mcountinhibit),
    .io_csr_pkt_csr_mitctl0(csr_read_io_csr_pkt_csr_mitctl0),
    .io_csr_pkt_csr_mitctl1(csr_read_io_csr_pkt_csr_mitctl1),
    .io_csr_pkt_csr_mitb0(csr_read_io_csr_pkt_csr_mitb0),
    .io_csr_pkt_csr_mitb1(csr_read_io_csr_pkt_csr_mitb1),
    .io_csr_pkt_csr_mitcnt0(csr_read_io_csr_pkt_csr_mitcnt0),
    .io_csr_pkt_csr_mitcnt1(csr_read_io_csr_pkt_csr_mitcnt1),
    .io_csr_pkt_csr_mpmc(csr_read_io_csr_pkt_csr_mpmc),
    .io_csr_pkt_csr_meicpct(csr_read_io_csr_pkt_csr_meicpct),
    .io_csr_pkt_csr_micect(csr_read_io_csr_pkt_csr_micect),
    .io_csr_pkt_csr_miccmect(csr_read_io_csr_pkt_csr_miccmect),
    .io_csr_pkt_csr_mdccmect(csr_read_io_csr_pkt_csr_mdccmect),
    .io_csr_pkt_csr_mfdht(csr_read_io_csr_pkt_csr_mfdht),
    .io_csr_pkt_csr_mfdhs(csr_read_io_csr_pkt_csr_mfdhs),
    .io_csr_pkt_csr_dicawics(csr_read_io_csr_pkt_csr_dicawics),
    .io_csr_pkt_csr_dicad0h(csr_read_io_csr_pkt_csr_dicad0h),
    .io_csr_pkt_csr_dicad0(csr_read_io_csr_pkt_csr_dicad0),
    .io_csr_pkt_csr_dicad1(csr_read_io_csr_pkt_csr_dicad1),
    .io_csr_pkt_csr_dicago(csr_read_io_csr_pkt_csr_dicago),
    .io_csr_pkt_presync(csr_read_io_csr_pkt_presync),
    .io_csr_pkt_postsync(csr_read_io_csr_pkt_postsync),
    .io_csr_pkt_legal(csr_read_io_csr_pkt_legal)
  );
  assign io_dec_dbg_cmd_done = io_dec_tlu_i0_valid_r & io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 568:29]
  assign io_dec_dbg_cmd_fail = illegal_r & io_dec_dbg_cmd_done; // @[el2_dec_tlu_ctl.scala 569:29]
  assign io_dec_tlu_dbg_halted = dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 550:41]
  assign io_dec_tlu_debug_mode = debug_mode_status; // @[el2_dec_tlu_ctl.scala 551:41]
  assign io_dec_tlu_resume_ack = _T_190; // @[el2_dec_tlu_ctl.scala 534:49]
  assign io_dec_tlu_debug_stall = debug_halt_req_f; // @[el2_dec_tlu_ctl.scala 549:41]
  assign io_dec_tlu_flush_noredir_r = _T_205 | take_ext_int_start; // @[el2_dec_tlu_ctl.scala 555:36]
  assign io_dec_tlu_mpc_halted_only = _T_65; // @[el2_dec_tlu_ctl.scala 449:49]
  assign io_dec_tlu_flush_leak_one_r = _T_233 & _T_234; // @[el2_dec_tlu_ctl.scala 564:37]
  assign io_dec_tlu_flush_err_r = io_dec_tlu_flush_lower_r & _T_433; // @[el2_dec_tlu_ctl.scala 565:32]
  assign io_dec_tlu_flush_extint = ext_int_ready & _T_704; // @[el2_dec_tlu_ctl.scala 557:33]
  assign io_dec_tlu_meihap = csr_io_dec_tlu_meihap; // @[el2_dec_tlu_ctl.scala 956:44]
  assign io_trigger_pkt_any_0_select = csr_io_trigger_pkt_any_0_select; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_0_match_ = csr_io_trigger_pkt_any_0_match_; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_0_store = csr_io_trigger_pkt_any_0_store; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_0_load = csr_io_trigger_pkt_any_0_load; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_0_execute = csr_io_trigger_pkt_any_0_execute; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_0_m = csr_io_trigger_pkt_any_0_m; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_0_tdata2 = csr_io_trigger_pkt_any_0_tdata2; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_select = csr_io_trigger_pkt_any_1_select; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_match_ = csr_io_trigger_pkt_any_1_match_; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_store = csr_io_trigger_pkt_any_1_store; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_load = csr_io_trigger_pkt_any_1_load; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_execute = csr_io_trigger_pkt_any_1_execute; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_m = csr_io_trigger_pkt_any_1_m; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_1_tdata2 = csr_io_trigger_pkt_any_1_tdata2; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_select = csr_io_trigger_pkt_any_2_select; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_match_ = csr_io_trigger_pkt_any_2_match_; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_store = csr_io_trigger_pkt_any_2_store; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_load = csr_io_trigger_pkt_any_2_load; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_execute = csr_io_trigger_pkt_any_2_execute; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_m = csr_io_trigger_pkt_any_2_m; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_2_tdata2 = csr_io_trigger_pkt_any_2_tdata2; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_select = csr_io_trigger_pkt_any_3_select; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_match_ = csr_io_trigger_pkt_any_3_match_; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_store = csr_io_trigger_pkt_any_3_store; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_load = csr_io_trigger_pkt_any_3_load; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_execute = csr_io_trigger_pkt_any_3_execute; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_m = csr_io_trigger_pkt_any_3_m; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_trigger_pkt_any_3_tdata2 = csr_io_trigger_pkt_any_3_tdata2; // @[el2_dec_tlu_ctl.scala 962:40]
  assign io_dec_tlu_ic_diag_pkt_icache_wrdata = csr_io_dec_tlu_ic_diag_pkt_icache_wrdata; // @[el2_dec_tlu_ctl.scala 961:44]
  assign io_dec_tlu_ic_diag_pkt_icache_dicawics = csr_io_dec_tlu_ic_diag_pkt_icache_dicawics; // @[el2_dec_tlu_ctl.scala 961:44]
  assign io_dec_tlu_ic_diag_pkt_icache_rd_valid = csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[el2_dec_tlu_ctl.scala 961:44]
  assign io_dec_tlu_ic_diag_pkt_icache_wr_valid = csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[el2_dec_tlu_ctl.scala 961:44]
  assign io_o_cpu_halt_status = _T_353; // @[el2_dec_tlu_ctl.scala 654:49]
  assign io_o_cpu_halt_ack = _T_354; // @[el2_dec_tlu_ctl.scala 655:49]
  assign io_o_cpu_run_ack = _T_355; // @[el2_dec_tlu_ctl.scala 656:49]
  assign io_o_debug_mode_status = debug_mode_status; // @[el2_dec_tlu_ctl.scala 677:27]
  assign io_mpc_debug_halt_ack = mpc_debug_halt_ack_f; // @[el2_dec_tlu_ctl.scala 474:31]
  assign io_mpc_debug_run_ack = mpc_debug_run_ack_f; // @[el2_dec_tlu_ctl.scala 475:31]
  assign io_debug_brkpt_status = debug_brkpt_status_f; // @[el2_dec_tlu_ctl.scala 476:31]
  assign io_dec_tlu_meicurpl = csr_io_dec_tlu_meicurpl; // @[el2_dec_tlu_ctl.scala 955:44]
  assign io_dec_tlu_meipt = csr_io_dec_tlu_meipt; // @[el2_dec_tlu_ctl.scala 957:44]
  assign io_dec_csr_rddata_d = csr_io_dec_csr_rddata_d; // @[el2_dec_tlu_ctl.scala 977:40]
  assign io_dec_csr_legal_d = _T_887 & _T_894; // @[el2_dec_tlu_ctl.scala 1101:20]
  assign io_dec_tlu_br0_r_pkt_valid = _T_459 & _T_462; // @[el2_dec_tlu_ctl.scala 733:49]
  assign io_dec_tlu_br0_r_pkt_hist = io_exu_i0_br_hist_r; // @[el2_dec_tlu_ctl.scala 730:49]
  assign io_dec_tlu_br0_r_pkt_br_error = _T_453 & _T_429; // @[el2_dec_tlu_ctl.scala 731:49]
  assign io_dec_tlu_br0_r_pkt_br_start_error = _T_455 & _T_429; // @[el2_dec_tlu_ctl.scala 732:41]
  assign io_dec_tlu_br0_r_pkt_way = io_exu_i0_br_way_r; // @[el2_dec_tlu_ctl.scala 734:49]
  assign io_dec_tlu_br0_r_pkt_middle = io_exu_i0_br_middle_r; // @[el2_dec_tlu_ctl.scala 735:49]
  assign io_dec_tlu_i0_kill_writeb_wb = _T_32; // @[el2_dec_tlu_ctl.scala 409:41]
  assign io_dec_tlu_flush_lower_wb = tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 881:41]
  assign io_dec_tlu_i0_commit_cmt = _T_422 & _T_465; // @[el2_dec_tlu_ctl.scala 708:29]
  assign io_dec_tlu_i0_kill_writeb_r = _T_427 | i0_trigger_hit_raw_r; // @[el2_dec_tlu_ctl.scala 415:41]
  assign io_dec_tlu_flush_lower_r = _T_801 | take_ext_int_start; // @[el2_dec_tlu_ctl.scala 882:41]
  assign io_dec_tlu_flush_path_r = take_reset ? io_rst_vec : _T_852; // @[el2_dec_tlu_ctl.scala 883:41]
  assign io_dec_tlu_fence_i_r = _T_492 & _T_470; // @[el2_dec_tlu_ctl.scala 753:30]
  assign io_dec_tlu_wr_pause_r = csr_io_dec_tlu_wr_pause_r; // @[el2_dec_tlu_ctl.scala 979:40]
  assign io_dec_tlu_flush_pause_r = _T_208 & _T_209; // @[el2_dec_tlu_ctl.scala 560:34]
  assign io_dec_tlu_presync_d = _T_864 & _T_865; // @[el2_dec_tlu_ctl.scala 1094:23]
  assign io_dec_tlu_postsync_d = csr_pkt_postsync & io_dec_csr_any_unq_d; // @[el2_dec_tlu_ctl.scala 1095:23]
  assign io_dec_tlu_mrac_ff = csr_io_dec_tlu_mrac_ff; // @[el2_dec_tlu_ctl.scala 980:40]
  assign io_dec_tlu_force_halt = _T_33; // @[el2_dec_tlu_ctl.scala 411:49]
  assign io_dec_tlu_perfcnt0 = csr_io_dec_tlu_perfcnt0; // @[el2_dec_tlu_ctl.scala 965:40]
  assign io_dec_tlu_perfcnt1 = csr_io_dec_tlu_perfcnt1; // @[el2_dec_tlu_ctl.scala 966:40]
  assign io_dec_tlu_perfcnt2 = csr_io_dec_tlu_perfcnt2; // @[el2_dec_tlu_ctl.scala 967:40]
  assign io_dec_tlu_perfcnt3 = csr_io_dec_tlu_perfcnt3; // @[el2_dec_tlu_ctl.scala 968:40]
  assign io_dec_tlu_i0_exc_valid_wb1 = csr_io_dec_tlu_i0_exc_valid_wb1; // @[el2_dec_tlu_ctl.scala 959:44]
  assign io_dec_tlu_i0_valid_wb1 = csr_io_dec_tlu_i0_valid_wb1; // @[el2_dec_tlu_ctl.scala 960:44]
  assign io_dec_tlu_int_valid_wb1 = csr_io_dec_tlu_int_valid_wb1; // @[el2_dec_tlu_ctl.scala 958:44]
  assign io_dec_tlu_exc_cause_wb1 = csr_io_dec_tlu_exc_cause_wb1; // @[el2_dec_tlu_ctl.scala 964:40]
  assign io_dec_tlu_mtval_wb1 = csr_io_dec_tlu_mtval_wb1; // @[el2_dec_tlu_ctl.scala 963:40]
  assign io_dec_tlu_external_ldfwd_disable = csr_io_dec_tlu_external_ldfwd_disable; // @[el2_dec_tlu_ctl.scala 985:40]
  assign io_dec_tlu_sideeffect_posted_disable = csr_io_dec_tlu_sideeffect_posted_disable; // @[el2_dec_tlu_ctl.scala 983:40]
  assign io_dec_tlu_core_ecc_disable = csr_io_dec_tlu_core_ecc_disable; // @[el2_dec_tlu_ctl.scala 984:40]
  assign io_dec_tlu_bpred_disable = csr_io_dec_tlu_bpred_disable; // @[el2_dec_tlu_ctl.scala 982:40]
  assign io_dec_tlu_wb_coalescing_disable = csr_io_dec_tlu_wb_coalescing_disable; // @[el2_dec_tlu_ctl.scala 981:40]
  assign io_dec_tlu_pipelining_disable = csr_io_dec_tlu_pipelining_disable; // @[el2_dec_tlu_ctl.scala 978:40]
  assign io_dec_tlu_dma_qos_prty = csr_io_dec_tlu_dma_qos_prty; // @[el2_dec_tlu_ctl.scala 986:40]
  assign io_dec_tlu_misc_clk_override = csr_io_dec_tlu_misc_clk_override; // @[el2_dec_tlu_ctl.scala 969:40]
  assign io_dec_tlu_dec_clk_override = csr_io_dec_tlu_dec_clk_override; // @[el2_dec_tlu_ctl.scala 970:40]
  assign io_dec_tlu_ifu_clk_override = csr_io_dec_tlu_ifu_clk_override; // @[el2_dec_tlu_ctl.scala 971:40]
  assign io_dec_tlu_lsu_clk_override = csr_io_dec_tlu_lsu_clk_override; // @[el2_dec_tlu_ctl.scala 972:40]
  assign io_dec_tlu_bus_clk_override = csr_io_dec_tlu_bus_clk_override; // @[el2_dec_tlu_ctl.scala 973:40]
  assign io_dec_tlu_pic_clk_override = csr_io_dec_tlu_pic_clk_override; // @[el2_dec_tlu_ctl.scala 974:40]
  assign io_dec_tlu_dccm_clk_override = csr_io_dec_tlu_dccm_clk_override; // @[el2_dec_tlu_ctl.scala 975:40]
  assign io_dec_tlu_icm_clk_override = csr_io_dec_tlu_icm_clk_override; // @[el2_dec_tlu_ctl.scala 976:40]
  assign int_timers_clock = clock;
  assign int_timers_reset = reset;
  assign int_timers_io_free_clk = io_free_clk; // @[el2_dec_tlu_ctl.scala 356:57]
  assign int_timers_io_scan_mode = io_scan_mode; // @[el2_dec_tlu_ctl.scala 357:57]
  assign int_timers_io_dec_csr_wen_r_mod = csr_io_dec_csr_wen_r_mod; // @[el2_dec_tlu_ctl.scala 358:49]
  assign int_timers_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[el2_dec_tlu_ctl.scala 360:49]
  assign int_timers_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[el2_dec_tlu_ctl.scala 361:49]
  assign int_timers_io_csr_mitctl0 = csr_read_io_csr_pkt_csr_mitctl0; // @[el2_dec_tlu_ctl.scala 362:57]
  assign int_timers_io_csr_mitctl1 = csr_read_io_csr_pkt_csr_mitctl1; // @[el2_dec_tlu_ctl.scala 363:57]
  assign int_timers_io_csr_mitb0 = csr_read_io_csr_pkt_csr_mitb0; // @[el2_dec_tlu_ctl.scala 364:57]
  assign int_timers_io_csr_mitb1 = csr_read_io_csr_pkt_csr_mitb1; // @[el2_dec_tlu_ctl.scala 365:57]
  assign int_timers_io_csr_mitcnt0 = csr_read_io_csr_pkt_csr_mitcnt0; // @[el2_dec_tlu_ctl.scala 366:57]
  assign int_timers_io_csr_mitcnt1 = csr_read_io_csr_pkt_csr_mitcnt1; // @[el2_dec_tlu_ctl.scala 367:57]
  assign int_timers_io_dec_pause_state = io_dec_pause_state; // @[el2_dec_tlu_ctl.scala 368:49]
  assign int_timers_io_dec_tlu_pmu_fw_halted = pmu_fw_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 369:49]
  assign int_timers_io_internal_dbg_halt_timers = debug_mode_status & _T_665; // @[el2_dec_tlu_ctl.scala 370:47]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 484:17]
  assign rvclkhdr_io_en = dec_csr_wen_r_mod | io_dec_tlu_dec_clk_override; // @[el2_lib.scala 485:16]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 486:23]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 484:17]
  assign rvclkhdr_1_io_en = _T_11 | io_dec_tlu_dec_clk_override; // @[el2_lib.scala 485:16]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 486:23]
  assign rvclkhdr_2_io_clk = clock; // @[el2_lib.scala 484:17]
  assign rvclkhdr_2_io_en = e4e5_valid | io_dec_tlu_dec_clk_override; // @[el2_lib.scala 485:16]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 486:23]
  assign rvclkhdr_3_io_clk = clock; // @[el2_lib.scala 484:17]
  assign rvclkhdr_3_io_en = e4e5_valid | flush_clkvalid; // @[el2_lib.scala 485:16]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 486:23]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_free_clk = io_free_clk; // @[el2_dec_tlu_ctl.scala 898:44]
  assign csr_io_active_clk = io_active_clk; // @[el2_dec_tlu_ctl.scala 899:44]
  assign csr_io_scan_mode = io_scan_mode; // @[el2_dec_tlu_ctl.scala 900:44]
  assign csr_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[el2_dec_tlu_ctl.scala 901:44]
  assign csr_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[el2_dec_tlu_ctl.scala 902:44]
  assign csr_io_dec_csr_rdaddr_d = io_dec_csr_rdaddr_d; // @[el2_dec_tlu_ctl.scala 903:44]
  assign csr_io_dec_csr_wen_unq_d = io_dec_csr_wen_unq_d; // @[el2_dec_tlu_ctl.scala 904:44]
  assign csr_io_dec_i0_decode_d = io_dec_i0_decode_d; // @[el2_dec_tlu_ctl.scala 905:44]
  assign csr_io_ifu_ic_debug_rd_data_valid = io_ifu_ic_debug_rd_data_valid; // @[el2_dec_tlu_ctl.scala 906:44]
  assign csr_io_ifu_pmu_bus_trxn = io_ifu_pmu_bus_trxn; // @[el2_dec_tlu_ctl.scala 907:44]
  assign csr_io_dma_iccm_stall_any = io_dma_iccm_stall_any; // @[el2_dec_tlu_ctl.scala 908:44]
  assign csr_io_dma_dccm_stall_any = io_dma_dccm_stall_any; // @[el2_dec_tlu_ctl.scala 909:44]
  assign csr_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[el2_dec_tlu_ctl.scala 910:44]
  assign csr_io_dec_pmu_presync_stall = io_dec_pmu_presync_stall; // @[el2_dec_tlu_ctl.scala 911:44]
  assign csr_io_dec_pmu_postsync_stall = io_dec_pmu_postsync_stall; // @[el2_dec_tlu_ctl.scala 912:44]
  assign csr_io_dec_pmu_decode_stall = io_dec_pmu_decode_stall; // @[el2_dec_tlu_ctl.scala 913:44]
  assign csr_io_ifu_pmu_fetch_stall = io_ifu_pmu_fetch_stall; // @[el2_dec_tlu_ctl.scala 914:44]
  assign csr_io_dec_tlu_packet_r_icaf_type = io_dec_tlu_packet_r_icaf_type; // @[el2_dec_tlu_ctl.scala 915:44]
  assign csr_io_dec_tlu_packet_r_pmu_i0_itype = io_dec_tlu_packet_r_pmu_i0_itype; // @[el2_dec_tlu_ctl.scala 915:44]
  assign csr_io_dec_tlu_packet_r_pmu_i0_br_unpred = io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[el2_dec_tlu_ctl.scala 915:44]
  assign csr_io_dec_tlu_packet_r_pmu_divide = io_dec_tlu_packet_r_pmu_divide; // @[el2_dec_tlu_ctl.scala 915:44]
  assign csr_io_dec_tlu_packet_r_pmu_lsu_misaligned = io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[el2_dec_tlu_ctl.scala 915:44]
  assign csr_io_exu_pmu_i0_br_ataken = io_exu_pmu_i0_br_ataken; // @[el2_dec_tlu_ctl.scala 916:44]
  assign csr_io_exu_pmu_i0_br_misp = io_exu_pmu_i0_br_misp; // @[el2_dec_tlu_ctl.scala 917:44]
  assign csr_io_dec_pmu_instr_decoded = io_dec_pmu_instr_decoded; // @[el2_dec_tlu_ctl.scala 918:44]
  assign csr_io_ifu_pmu_instr_aligned = io_ifu_pmu_instr_aligned; // @[el2_dec_tlu_ctl.scala 919:44]
  assign csr_io_exu_pmu_i0_pc4 = io_exu_pmu_i0_pc4; // @[el2_dec_tlu_ctl.scala 920:44]
  assign csr_io_ifu_pmu_ic_miss = io_ifu_pmu_ic_miss; // @[el2_dec_tlu_ctl.scala 921:44]
  assign csr_io_ifu_pmu_ic_hit = io_ifu_pmu_ic_hit; // @[el2_dec_tlu_ctl.scala 922:44]
  assign csr_io_dec_csr_wen_r = io_dec_csr_wen_r; // @[el2_dec_tlu_ctl.scala 923:44]
  assign csr_io_dec_tlu_dbg_halted = io_dec_tlu_dbg_halted; // @[el2_dec_tlu_ctl.scala 924:44]
  assign csr_io_dma_pmu_dccm_write = io_dma_pmu_dccm_write; // @[el2_dec_tlu_ctl.scala 925:44]
  assign csr_io_dma_pmu_dccm_read = io_dma_pmu_dccm_read; // @[el2_dec_tlu_ctl.scala 926:44]
  assign csr_io_dma_pmu_any_write = io_dma_pmu_any_write; // @[el2_dec_tlu_ctl.scala 927:44]
  assign csr_io_dma_pmu_any_read = io_dma_pmu_any_read; // @[el2_dec_tlu_ctl.scala 928:44]
  assign csr_io_lsu_pmu_bus_busy = io_lsu_pmu_bus_busy; // @[el2_dec_tlu_ctl.scala 929:44]
  assign csr_io_dec_tlu_i0_pc_r = io_dec_tlu_i0_pc_r; // @[el2_dec_tlu_ctl.scala 930:44]
  assign csr_io_dec_tlu_i0_valid_r = io_dec_tlu_i0_valid_r; // @[el2_dec_tlu_ctl.scala 931:44]
  assign csr_io_dec_csr_any_unq_d = io_dec_csr_any_unq_d; // @[el2_dec_tlu_ctl.scala 933:44]
  assign csr_io_ifu_pmu_bus_busy = io_ifu_pmu_bus_busy; // @[el2_dec_tlu_ctl.scala 934:44]
  assign csr_io_lsu_pmu_bus_error = io_lsu_pmu_bus_error; // @[el2_dec_tlu_ctl.scala 935:44]
  assign csr_io_ifu_pmu_bus_error = io_ifu_pmu_bus_error; // @[el2_dec_tlu_ctl.scala 936:44]
  assign csr_io_lsu_pmu_bus_misaligned = io_lsu_pmu_bus_misaligned; // @[el2_dec_tlu_ctl.scala 937:44]
  assign csr_io_lsu_pmu_bus_trxn = io_lsu_pmu_bus_trxn; // @[el2_dec_tlu_ctl.scala 938:44]
  assign csr_io_ifu_ic_debug_rd_data = io_ifu_ic_debug_rd_data; // @[el2_dec_tlu_ctl.scala 939:44]
  assign csr_io_pic_pl = io_pic_pl; // @[el2_dec_tlu_ctl.scala 940:44]
  assign csr_io_pic_claimid = io_pic_claimid; // @[el2_dec_tlu_ctl.scala 941:44]
  assign csr_io_iccm_dma_sb_error = io_iccm_dma_sb_error; // @[el2_dec_tlu_ctl.scala 942:44]
  assign csr_io_lsu_imprecise_error_addr_any = io_lsu_imprecise_error_addr_any; // @[el2_dec_tlu_ctl.scala 943:44]
  assign csr_io_lsu_imprecise_error_load_any = io_lsu_imprecise_error_load_any; // @[el2_dec_tlu_ctl.scala 944:44]
  assign csr_io_lsu_imprecise_error_store_any = io_lsu_imprecise_error_store_any; // @[el2_dec_tlu_ctl.scala 945:44]
  assign csr_io_dec_illegal_inst = io_dec_illegal_inst; // @[el2_dec_tlu_ctl.scala 946:44 el2_dec_tlu_ctl.scala 987:44]
  assign csr_io_lsu_error_pkt_r_mscause = io_lsu_error_pkt_r_mscause; // @[el2_dec_tlu_ctl.scala 947:44 el2_dec_tlu_ctl.scala 988:44]
  assign csr_io_mexintpend = io_mexintpend; // @[el2_dec_tlu_ctl.scala 948:44 el2_dec_tlu_ctl.scala 989:44]
  assign csr_io_exu_npc_r = io_exu_npc_r; // @[el2_dec_tlu_ctl.scala 949:44 el2_dec_tlu_ctl.scala 990:44]
  assign csr_io_mpc_reset_run_req = io_mpc_reset_run_req; // @[el2_dec_tlu_ctl.scala 950:44 el2_dec_tlu_ctl.scala 991:44]
  assign csr_io_rst_vec = io_rst_vec; // @[el2_dec_tlu_ctl.scala 951:44 el2_dec_tlu_ctl.scala 992:44]
  assign csr_io_core_id = io_core_id; // @[el2_dec_tlu_ctl.scala 952:44 el2_dec_tlu_ctl.scala 993:44]
  assign csr_io_dec_timer_rddata_d = int_timers_io_dec_timer_rddata_d; // @[el2_dec_tlu_ctl.scala 953:44 el2_dec_tlu_ctl.scala 994:44]
  assign csr_io_dec_timer_read_d = int_timers_io_dec_timer_read_d; // @[el2_dec_tlu_ctl.scala 954:44 el2_dec_tlu_ctl.scala 995:44]
  assign csr_io_rfpc_i0_r = _T_438 & _T_439; // @[el2_dec_tlu_ctl.scala 998:39]
  assign csr_io_i0_trigger_hit_r = |i0_trigger_chain_masked_r; // @[el2_dec_tlu_ctl.scala 999:39]
  assign csr_io_exc_or_int_valid_r = _T_855 | mepc_trigger_hit_sel_pc_r; // @[el2_dec_tlu_ctl.scala 1000:39]
  assign csr_io_mret_r = _T_487 & _T_470; // @[el2_dec_tlu_ctl.scala 1001:39]
  assign csr_io_dcsr_single_step_running_f = dcsr_single_step_running_f; // @[el2_dec_tlu_ctl.scala 1002:39]
  assign csr_io_dec_timer_t0_pulse = int_timers_io_dec_timer_t0_pulse; // @[el2_dec_tlu_ctl.scala 1003:39]
  assign csr_io_dec_timer_t1_pulse = int_timers_io_dec_timer_t1_pulse; // @[el2_dec_tlu_ctl.scala 1004:39]
  assign csr_io_timer_int_sync = syncro_ff[5]; // @[el2_dec_tlu_ctl.scala 1005:39]
  assign csr_io_soft_int_sync = syncro_ff[4]; // @[el2_dec_tlu_ctl.scala 1006:39]
  assign csr_io_csr_wr_clk = rvclkhdr_io_l1clk; // @[el2_dec_tlu_ctl.scala 1007:39]
  assign csr_io_ebreak_to_debug_mode_r = _T_519 & _T_470; // @[el2_dec_tlu_ctl.scala 1008:39]
  assign csr_io_dec_tlu_pmu_fw_halted = pmu_fw_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 1009:39]
  assign csr_io_lsu_fir_error = io_lsu_fir_error; // @[el2_dec_tlu_ctl.scala 1010:39]
  assign csr_io_tlu_flush_lower_r_d1 = tlu_flush_lower_r_d1; // @[el2_dec_tlu_ctl.scala 1011:39]
  assign csr_io_dec_tlu_flush_noredir_r_d1 = dec_tlu_flush_noredir_r_d1; // @[el2_dec_tlu_ctl.scala 1012:39]
  assign csr_io_tlu_flush_path_r_d1 = tlu_flush_path_r_d1; // @[el2_dec_tlu_ctl.scala 1013:39]
  assign csr_io_reset_delayed = reset_detect ^ reset_detected; // @[el2_dec_tlu_ctl.scala 1014:39]
  assign csr_io_interrupt_valid_r = _T_766 | take_int_timer1_int; // @[el2_dec_tlu_ctl.scala 1015:39]
  assign csr_io_i0_exception_valid_r = _T_527 & _T_528; // @[el2_dec_tlu_ctl.scala 1016:39]
  assign csr_io_lsu_exc_valid_r = _T_405 & _T_470; // @[el2_dec_tlu_ctl.scala 1017:39]
  assign csr_io_mepc_trigger_hit_sel_pc_r = i0_trigger_hit_raw_r & _T_345; // @[el2_dec_tlu_ctl.scala 1018:39]
  assign csr_io_e4e5_int_clk = rvclkhdr_3_io_l1clk; // @[el2_dec_tlu_ctl.scala 1019:39]
  assign csr_io_lsu_i0_exc_r = _T_405 & _T_470; // @[el2_dec_tlu_ctl.scala 1020:39]
  assign csr_io_inst_acc_r = _T_511 & _T_465; // @[el2_dec_tlu_ctl.scala 1021:39]
  assign csr_io_inst_acc_second_r = io_dec_tlu_packet_r_icaf_f1; // @[el2_dec_tlu_ctl.scala 1022:39]
  assign csr_io_take_nmi = _T_756 & _T_760; // @[el2_dec_tlu_ctl.scala 1023:39]
  assign csr_io_lsu_error_pkt_addr_r = io_lsu_error_pkt_r_addr; // @[el2_dec_tlu_ctl.scala 1024:39]
  assign csr_io_exc_cause_r = _T_603 | _T_591; // @[el2_dec_tlu_ctl.scala 1025:39]
  assign csr_io_i0_valid_wb = i0_valid_wb; // @[el2_dec_tlu_ctl.scala 1026:39]
  assign csr_io_exc_or_int_valid_r_d1 = exc_or_int_valid_r_d1; // @[el2_dec_tlu_ctl.scala 1027:39]
  assign csr_io_interrupt_valid_r_d1 = interrupt_valid_r_d1; // @[el2_dec_tlu_ctl.scala 1028:39]
  assign csr_io_clk_override = io_dec_tlu_dec_clk_override; // @[el2_dec_tlu_ctl.scala 1029:39]
  assign csr_io_i0_exception_valid_r_d1 = i0_exception_valid_r_d1; // @[el2_dec_tlu_ctl.scala 1030:39]
  assign csr_io_lsu_i0_exc_r_d1 = lsu_i0_exc_r_d1; // @[el2_dec_tlu_ctl.scala 1031:39]
  assign csr_io_exc_cause_wb = exc_cause_wb; // @[el2_dec_tlu_ctl.scala 1032:39]
  assign csr_io_nmi_lsu_store_type = _T_58 | _T_60; // @[el2_dec_tlu_ctl.scala 1033:39]
  assign csr_io_nmi_lsu_load_type = _T_50 | _T_52; // @[el2_dec_tlu_ctl.scala 1034:39]
  assign csr_io_tlu_i0_commit_cmt = _T_422 & _T_465; // @[el2_dec_tlu_ctl.scala 1035:39]
  assign csr_io_ebreak_r = _T_469 & _T_470; // @[el2_dec_tlu_ctl.scala 1036:39]
  assign csr_io_ecall_r = _T_475 & _T_470; // @[el2_dec_tlu_ctl.scala 1037:39]
  assign csr_io_illegal_r = _T_481 & _T_470; // @[el2_dec_tlu_ctl.scala 1038:39]
  assign csr_io_mdseac_locked_f = mdseac_locked_f; // @[el2_dec_tlu_ctl.scala 1039:39]
  assign csr_io_nmi_int_detected_f = nmi_int_detected_f; // @[el2_dec_tlu_ctl.scala 1040:39]
  assign csr_io_internal_dbg_halt_mode_f2 = internal_dbg_halt_mode_f2; // @[el2_dec_tlu_ctl.scala 1041:39]
  assign csr_io_ext_int_freeze_d1 = ext_int_freeze_d1; // @[el2_dec_tlu_ctl.scala 1042:39]
  assign csr_io_ic_perr_r_d1 = ic_perr_r_d1; // @[el2_dec_tlu_ctl.scala 1043:39]
  assign csr_io_iccm_sbecc_r_d1 = iccm_sbecc_r_d1; // @[el2_dec_tlu_ctl.scala 1044:39]
  assign csr_io_lsu_single_ecc_error_r_d1 = lsu_single_ecc_error_r_d1; // @[el2_dec_tlu_ctl.scala 1045:39]
  assign csr_io_ifu_miss_state_idle_f = ifu_miss_state_idle_f; // @[el2_dec_tlu_ctl.scala 1046:39]
  assign csr_io_lsu_idle_any_f = lsu_idle_any_f; // @[el2_dec_tlu_ctl.scala 1047:39]
  assign csr_io_dbg_tlu_halted_f = dbg_tlu_halted_f; // @[el2_dec_tlu_ctl.scala 1048:39]
  assign csr_io_dbg_tlu_halted = _T_164 | _T_166; // @[el2_dec_tlu_ctl.scala 1049:39]
  assign csr_io_debug_halt_req_f = debug_halt_req_f; // @[el2_dec_tlu_ctl.scala 1050:51]
  assign csr_io_take_ext_int_start = ext_int_ready & _T_704; // @[el2_dec_tlu_ctl.scala 1051:47]
  assign csr_io_trigger_hit_dmode_r_d1 = trigger_hit_dmode_r_d1; // @[el2_dec_tlu_ctl.scala 1052:43]
  assign csr_io_trigger_hit_r_d1 = trigger_hit_r_d1; // @[el2_dec_tlu_ctl.scala 1053:43]
  assign csr_io_dcsr_single_step_done_f = dcsr_single_step_done_f; // @[el2_dec_tlu_ctl.scala 1054:43]
  assign csr_io_ebreak_to_debug_mode_r_d1 = ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 1055:39]
  assign csr_io_debug_halt_req = _T_114 & _T_107; // @[el2_dec_tlu_ctl.scala 1056:51]
  assign csr_io_allow_dbg_halt_csr_write = debug_mode_status & _T_77; // @[el2_dec_tlu_ctl.scala 1057:39]
  assign csr_io_internal_dbg_halt_mode_f = debug_mode_status; // @[el2_dec_tlu_ctl.scala 1058:39]
  assign csr_io_enter_debug_halt_req = _T_155 | ebreak_to_debug_mode_r_d1; // @[el2_dec_tlu_ctl.scala 1059:39]
  assign csr_io_internal_dbg_halt_mode = debug_halt_req_ns | _T_160; // @[el2_dec_tlu_ctl.scala 1060:39]
  assign csr_io_request_debug_mode_done = _T_183 & _T_136; // @[el2_dec_tlu_ctl.scala 1061:39]
  assign csr_io_request_debug_mode_r = _T_180 | _T_182; // @[el2_dec_tlu_ctl.scala 1062:39]
  assign csr_io_update_hit_bit_r = _T_342 & i0_trigger_chain_masked_r; // @[el2_dec_tlu_ctl.scala 1063:39]
  assign csr_io_take_timer_int = _T_703 & _T_704; // @[el2_dec_tlu_ctl.scala 1064:39]
  assign csr_io_take_int_timer0_int = _T_717 & _T_704; // @[el2_dec_tlu_ctl.scala 1065:39]
  assign csr_io_take_int_timer1_int = _T_734 & _T_704; // @[el2_dec_tlu_ctl.scala 1066:39]
  assign csr_io_take_ext_int = take_ext_int_start_d3 & _T_685; // @[el2_dec_tlu_ctl.scala 1067:39]
  assign csr_io_tlu_flush_lower_r = _T_801 | take_ext_int_start; // @[el2_dec_tlu_ctl.scala 1068:39]
  assign csr_io_dec_tlu_br0_error_r = _T_453 & _T_429; // @[el2_dec_tlu_ctl.scala 1069:39]
  assign csr_io_dec_tlu_br0_start_error_r = _T_455 & _T_429; // @[el2_dec_tlu_ctl.scala 1070:39]
  assign csr_io_lsu_pmu_load_external_r = lsu_pmu_load_external_r; // @[el2_dec_tlu_ctl.scala 1071:39]
  assign csr_io_lsu_pmu_store_external_r = lsu_pmu_store_external_r; // @[el2_dec_tlu_ctl.scala 1072:39]
  assign csr_io_csr_pkt_csr_misa = csr_read_io_csr_pkt_csr_misa; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mvendorid = csr_read_io_csr_pkt_csr_mvendorid; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_marchid = csr_read_io_csr_pkt_csr_marchid; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mimpid = csr_read_io_csr_pkt_csr_mimpid; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhartid = csr_read_io_csr_pkt_csr_mhartid; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mstatus = csr_read_io_csr_pkt_csr_mstatus; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mtvec = csr_read_io_csr_pkt_csr_mtvec; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mip = csr_read_io_csr_pkt_csr_mip; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mie = csr_read_io_csr_pkt_csr_mie; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mcyclel = csr_read_io_csr_pkt_csr_mcyclel; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mcycleh = csr_read_io_csr_pkt_csr_mcycleh; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_minstretl = csr_read_io_csr_pkt_csr_minstretl; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_minstreth = csr_read_io_csr_pkt_csr_minstreth; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mscratch = csr_read_io_csr_pkt_csr_mscratch; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mepc = csr_read_io_csr_pkt_csr_mepc; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mcause = csr_read_io_csr_pkt_csr_mcause; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mscause = csr_read_io_csr_pkt_csr_mscause; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mtval = csr_read_io_csr_pkt_csr_mtval; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mrac = csr_read_io_csr_pkt_csr_mrac; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mdseac = csr_read_io_csr_pkt_csr_mdseac; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_meihap = csr_read_io_csr_pkt_csr_meihap; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_meivt = csr_read_io_csr_pkt_csr_meivt; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_meipt = csr_read_io_csr_pkt_csr_meipt; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_meicurpl = csr_read_io_csr_pkt_csr_meicurpl; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_meicidpl = csr_read_io_csr_pkt_csr_meicidpl; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_dcsr = csr_read_io_csr_pkt_csr_dcsr; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mcgc = csr_read_io_csr_pkt_csr_mcgc; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mfdc = csr_read_io_csr_pkt_csr_mfdc; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_dpc = csr_read_io_csr_pkt_csr_dpc; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mtsel = csr_read_io_csr_pkt_csr_mtsel; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mtdata1 = csr_read_io_csr_pkt_csr_mtdata1; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mtdata2 = csr_read_io_csr_pkt_csr_mtdata2; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc3 = csr_read_io_csr_pkt_csr_mhpmc3; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc4 = csr_read_io_csr_pkt_csr_mhpmc4; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc5 = csr_read_io_csr_pkt_csr_mhpmc5; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc6 = csr_read_io_csr_pkt_csr_mhpmc6; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc3h = csr_read_io_csr_pkt_csr_mhpmc3h; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc4h = csr_read_io_csr_pkt_csr_mhpmc4h; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc5h = csr_read_io_csr_pkt_csr_mhpmc5h; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpmc6h = csr_read_io_csr_pkt_csr_mhpmc6h; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpme3 = csr_read_io_csr_pkt_csr_mhpme3; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpme4 = csr_read_io_csr_pkt_csr_mhpme4; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpme5 = csr_read_io_csr_pkt_csr_mhpme5; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mhpme6 = csr_read_io_csr_pkt_csr_mhpme6; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mcountinhibit = csr_read_io_csr_pkt_csr_mcountinhibit; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mpmc = csr_read_io_csr_pkt_csr_mpmc; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_micect = csr_read_io_csr_pkt_csr_micect; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_miccmect = csr_read_io_csr_pkt_csr_miccmect; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mdccmect = csr_read_io_csr_pkt_csr_mdccmect; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mfdht = csr_read_io_csr_pkt_csr_mfdht; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_mfdhs = csr_read_io_csr_pkt_csr_mfdhs; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_dicawics = csr_read_io_csr_pkt_csr_dicawics; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_dicad0h = csr_read_io_csr_pkt_csr_dicad0h; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_dicad0 = csr_read_io_csr_pkt_csr_dicad0; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_io_csr_pkt_csr_dicad1 = csr_read_io_csr_pkt_csr_dicad1; // @[el2_dec_tlu_ctl.scala 1073:39]
  assign csr_read_io_dec_csr_rdaddr_d = io_dec_csr_rdaddr_d; // @[el2_dec_tlu_ctl.scala 1091:37]
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
  dbg_halt_state_f = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mpc_halt_state_f = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_8 = _RAND_2[6:0];
  _RAND_3 = {1{`RANDOM}};
  syncro_ff = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  lsu_exc_valid_r_d1 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  e5_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  debug_mode_status = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  i_cpu_run_req_d1_raw = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  nmi_int_delayed = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  mdseac_locked_f = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  nmi_int_detected_f = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  take_nmi_r_d1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  take_ext_int_start_d3 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  int_timer0_int_hold_f = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  int_timer1_int_hold_f = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  i_cpu_halt_req_d1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  dbg_halt_req_held = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  ext_int_freeze_d1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  reset_detect = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  reset_detected = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dcsr_single_step_done_f = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  trigger_hit_dmode_r_d1 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  ebreak_to_debug_mode_r_d1 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  debug_halt_req_f = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  lsu_idle_any_f = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  ifu_miss_state_idle_f = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  debug_halt_req_d1 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  dec_tlu_flush_noredir_r_d1 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  dec_tlu_flush_pause_r_d1 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  take_ext_int_start_d1 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  halt_taken_f = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  dbg_tlu_halted_f = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  pmu_fw_tlu_halted_f = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  interrupt_valid_r_d1 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  debug_resume_req_f = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  dcsr_single_step_running_f = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  pmu_fw_halt_req_f = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  internal_pmu_fw_halt_mode_f = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  tlu_flush_lower_r_d1 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  ic_perr_r_d1 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  iccm_sbecc_r_d1 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  request_debug_mode_r_d1 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  iccm_repair_state_d1 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  dec_pause_state_f = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  dec_tlu_wr_pause_r_d1 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  exc_or_int_valid_r_d1 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  pause_expired_wb = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  lsu_pmu_load_external_r = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  lsu_pmu_store_external_r = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  _T_32 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  internal_dbg_halt_mode_f2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  _T_33 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  nmi_lsu_load_type_f = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  nmi_lsu_store_type_f = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  mpc_debug_halt_req_sync_f = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  mpc_debug_run_req_sync_f = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  mpc_run_state_f = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  debug_brkpt_status_f = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  mpc_debug_halt_ack_f = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  mpc_debug_run_ack_f = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  dbg_run_state_f = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  _T_65 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  request_debug_mode_done_f = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  _T_190 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  _T_353 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  _T_354 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  _T_355 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  lsu_single_ecc_error_r_d1 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  lsu_i0_exc_r_d1 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  take_ext_int_start_d2 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  tlu_flush_path_r_d1 = _RAND_70[30:0];
  _RAND_71 = {1{`RANDOM}};
  i0_exception_valid_r_d1 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  exc_cause_wb = _RAND_72[4:0];
  _RAND_73 = {1{`RANDOM}};
  i0_valid_wb = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  trigger_hit_r_d1 = _RAND_74[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    dbg_halt_state_f = 1'h0;
  end
  if (reset) begin
    mpc_halt_state_f = 1'h0;
  end
  if (reset) begin
    _T_8 = 7'h0;
  end
  if (reset) begin
    syncro_ff = 7'h0;
  end
  if (reset) begin
    lsu_exc_valid_r_d1 = 1'h0;
  end
  if (reset) begin
    e5_valid = 1'h0;
  end
  if (reset) begin
    debug_mode_status = 1'h0;
  end
  if (reset) begin
    i_cpu_run_req_d1_raw = 1'h0;
  end
  if (reset) begin
    nmi_int_delayed = 1'h0;
  end
  if (reset) begin
    mdseac_locked_f = 1'h0;
  end
  if (reset) begin
    nmi_int_detected_f = 1'h0;
  end
  if (reset) begin
    take_nmi_r_d1 = 1'h0;
  end
  if (reset) begin
    take_ext_int_start_d3 = 1'h0;
  end
  if (reset) begin
    int_timer0_int_hold_f = 1'h0;
  end
  if (reset) begin
    int_timer1_int_hold_f = 1'h0;
  end
  if (reset) begin
    i_cpu_halt_req_d1 = 1'h0;
  end
  if (reset) begin
    dbg_halt_req_held = 1'h0;
  end
  if (reset) begin
    ext_int_freeze_d1 = 1'h0;
  end
  if (reset) begin
    reset_detect = 1'h0;
  end
  if (reset) begin
    reset_detected = 1'h0;
  end
  if (reset) begin
    dcsr_single_step_done_f = 1'h0;
  end
  if (reset) begin
    trigger_hit_dmode_r_d1 = 1'h0;
  end
  if (reset) begin
    ebreak_to_debug_mode_r_d1 = 1'h0;
  end
  if (reset) begin
    debug_halt_req_f = 1'h0;
  end
  if (reset) begin
    lsu_idle_any_f = 1'h0;
  end
  if (reset) begin
    ifu_miss_state_idle_f = 1'h0;
  end
  if (reset) begin
    debug_halt_req_d1 = 1'h0;
  end
  if (reset) begin
    dec_tlu_flush_noredir_r_d1 = 1'h0;
  end
  if (reset) begin
    dec_tlu_flush_pause_r_d1 = 1'h0;
  end
  if (reset) begin
    take_ext_int_start_d1 = 1'h0;
  end
  if (reset) begin
    halt_taken_f = 1'h0;
  end
  if (reset) begin
    dbg_tlu_halted_f = 1'h0;
  end
  if (reset) begin
    pmu_fw_tlu_halted_f = 1'h0;
  end
  if (reset) begin
    interrupt_valid_r_d1 = 1'h0;
  end
  if (reset) begin
    debug_resume_req_f = 1'h0;
  end
  if (reset) begin
    dcsr_single_step_running_f = 1'h0;
  end
  if (reset) begin
    pmu_fw_halt_req_f = 1'h0;
  end
  if (reset) begin
    internal_pmu_fw_halt_mode_f = 1'h0;
  end
  if (reset) begin
    tlu_flush_lower_r_d1 = 1'h0;
  end
  if (reset) begin
    ic_perr_r_d1 = 1'h0;
  end
  if (reset) begin
    iccm_sbecc_r_d1 = 1'h0;
  end
  if (reset) begin
    request_debug_mode_r_d1 = 1'h0;
  end
  if (reset) begin
    iccm_repair_state_d1 = 1'h0;
  end
  if (reset) begin
    dec_pause_state_f = 1'h0;
  end
  if (reset) begin
    dec_tlu_wr_pause_r_d1 = 1'h0;
  end
  if (reset) begin
    exc_or_int_valid_r_d1 = 1'h0;
  end
  if (reset) begin
    pause_expired_wb = 1'h0;
  end
  if (reset) begin
    lsu_pmu_load_external_r = 1'h0;
  end
  if (reset) begin
    lsu_pmu_store_external_r = 1'h0;
  end
  if (reset) begin
    _T_32 = 1'h0;
  end
  if (reset) begin
    internal_dbg_halt_mode_f2 = 1'h0;
  end
  if (reset) begin
    _T_33 = 1'h0;
  end
  if (reset) begin
    nmi_lsu_load_type_f = 1'h0;
  end
  if (reset) begin
    nmi_lsu_store_type_f = 1'h0;
  end
  if (reset) begin
    mpc_debug_halt_req_sync_f = 1'h0;
  end
  if (reset) begin
    mpc_debug_run_req_sync_f = 1'h0;
  end
  if (reset) begin
    mpc_run_state_f = 1'h0;
  end
  if (reset) begin
    debug_brkpt_status_f = 1'h0;
  end
  if (reset) begin
    mpc_debug_halt_ack_f = 1'h0;
  end
  if (reset) begin
    mpc_debug_run_ack_f = 1'h0;
  end
  if (reset) begin
    dbg_run_state_f = 1'h0;
  end
  if (reset) begin
    _T_65 = 1'h0;
  end
  if (reset) begin
    request_debug_mode_done_f = 1'h0;
  end
  if (reset) begin
    _T_190 = 1'h0;
  end
  if (reset) begin
    _T_353 = 1'h0;
  end
  if (reset) begin
    _T_354 = 1'h0;
  end
  if (reset) begin
    _T_355 = 1'h0;
  end
  if (reset) begin
    lsu_single_ecc_error_r_d1 = 1'h0;
  end
  if (reset) begin
    lsu_i0_exc_r_d1 = 1'h0;
  end
  if (reset) begin
    take_ext_int_start_d2 = 1'h0;
  end
  if (reset) begin
    tlu_flush_path_r_d1 = 31'h0;
  end
  if (reset) begin
    i0_exception_valid_r_d1 = 1'h0;
  end
  if (reset) begin
    exc_cause_wb = 5'h0;
  end
  if (reset) begin
    i0_valid_wb = 1'h0;
  end
  if (reset) begin
    trigger_hit_r_d1 = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dbg_halt_state_f <= 1'h0;
    end else begin
      dbg_halt_state_f <= _T_83 & _T_84;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mpc_halt_state_f <= 1'h0;
    end else begin
      mpc_halt_state_f <= _T_71 & _T_72;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_8 <= 7'h0;
    end else begin
      _T_8 <= {_T_6,_T_3};
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      syncro_ff <= 7'h0;
    end else begin
      syncro_ff <= _T_8;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      lsu_exc_valid_r_d1 <= 1'h0;
    end else begin
      lsu_exc_valid_r_d1 <= _T_405 & _T_470;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      e5_valid <= 1'h0;
    end else begin
      e5_valid <= io_dec_tlu_i0_valid_r;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      debug_mode_status <= 1'h0;
    end else begin
      debug_mode_status <= debug_halt_req_ns | _T_160;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      i_cpu_run_req_d1_raw <= 1'h0;
    end else begin
      i_cpu_run_req_d1_raw <= _T_351 & _T_107;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      nmi_int_delayed <= 1'h0;
    end else begin
      nmi_int_delayed <= syncro_ff[6];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mdseac_locked_f <= 1'h0;
    end else begin
      mdseac_locked_f <= csr_io_mdseac_locked_ns;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      nmi_int_detected_f <= 1'h0;
    end else begin
      nmi_int_detected_f <= _T_42 | _T_44;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      take_nmi_r_d1 <= 1'h0;
    end else begin
      take_nmi_r_d1 <= _T_756 & _T_760;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      take_ext_int_start_d3 <= 1'h0;
    end else begin
      take_ext_int_start_d3 <= take_ext_int_start_d2;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      int_timer0_int_hold_f <= 1'h0;
    end else begin
      int_timer0_int_hold_f <= _T_644 | _T_651;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      int_timer1_int_hold_f <= 1'h0;
    end else begin
      int_timer1_int_hold_f <= _T_654 | _T_661;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      i_cpu_halt_req_d1 <= 1'h0;
    end else begin
      i_cpu_halt_req_d1 <= _T_347 & _T_107;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dbg_halt_req_held <= 1'h0;
    end else begin
      dbg_halt_req_held <= _T_106 & ext_int_freeze_d1;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      ext_int_freeze_d1 <= 1'h0;
    end else begin
      ext_int_freeze_d1 <= _T_682 | take_ext_int_start_d3;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      reset_detect <= 1'h0;
    end else begin
      reset_detect <= 1'h1;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      reset_detected <= 1'h0;
    end else begin
      reset_detected <= reset_detect;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dcsr_single_step_done_f <= 1'h0;
    end else begin
      dcsr_single_step_done_f <= _T_174 & _T_470;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      trigger_hit_dmode_r_d1 <= 1'h0;
    end else begin
      trigger_hit_dmode_r_d1 <= i0_trigger_hit_raw_r & i0_trigger_action_r;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      ebreak_to_debug_mode_r_d1 <= 1'h0;
    end else begin
      ebreak_to_debug_mode_r_d1 <= _T_519 & _T_470;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      debug_halt_req_f <= 1'h0;
    end else begin
      debug_halt_req_f <= enter_debug_halt_req | _T_168;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      lsu_idle_any_f <= 1'h0;
    end else begin
      lsu_idle_any_f <= io_lsu_idle_any;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      ifu_miss_state_idle_f <= 1'h0;
    end else begin
      ifu_miss_state_idle_f <= io_ifu_miss_state_idle;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      debug_halt_req_d1 <= 1'h0;
    end else begin
      debug_halt_req_d1 <= _T_114 & _T_107;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dec_tlu_flush_noredir_r_d1 <= 1'h0;
    end else begin
      dec_tlu_flush_noredir_r_d1 <= io_dec_tlu_flush_noredir_r;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dec_tlu_flush_pause_r_d1 <= 1'h0;
    end else begin
      dec_tlu_flush_pause_r_d1 <= io_dec_tlu_flush_pause_r;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      take_ext_int_start_d1 <= 1'h0;
    end else begin
      take_ext_int_start_d1 <= ext_int_ready & _T_704;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      halt_taken_f <= 1'h0;
    end else begin
      halt_taken_f <= _T_135 | _T_141;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dbg_tlu_halted_f <= 1'h0;
    end else begin
      dbg_tlu_halted_f <= _T_164 | _T_166;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      pmu_fw_tlu_halted_f <= 1'h0;
    end else begin
      pmu_fw_tlu_halted_f <= _T_377 & _T_378;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      interrupt_valid_r_d1 <= 1'h0;
    end else begin
      interrupt_valid_r_d1 <= _T_766 | take_int_timer1_int;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      debug_resume_req_f <= 1'h0;
    end else begin
      debug_resume_req_f <= _T_165 & _T_121;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dcsr_single_step_running_f <= 1'h0;
    end else begin
      dcsr_single_step_running_f <= _T_177 | _T_179;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      pmu_fw_halt_req_f <= 1'h0;
    end else begin
      pmu_fw_halt_req_f <= _T_363 & _T_378;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      internal_pmu_fw_halt_mode_f <= 1'h0;
    end else begin
      internal_pmu_fw_halt_mode_f <= pmu_fw_halt_req_ns | _T_369;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      tlu_flush_lower_r_d1 <= 1'h0;
    end else begin
      tlu_flush_lower_r_d1 <= _T_801 | take_ext_int_start;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      ic_perr_r_d1 <= 1'h0;
    end else begin
      ic_perr_r_d1 <= _T_499 & _T_500;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      iccm_sbecc_r_d1 <= 1'h0;
    end else begin
      iccm_sbecc_r_d1 <= _T_506 & _T_500;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      request_debug_mode_r_d1 <= 1'h0;
    end else begin
      request_debug_mode_r_d1 <= _T_180 | _T_182;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      iccm_repair_state_d1 <= 1'h0;
    end else begin
      iccm_repair_state_d1 <= iccm_sbecc_r_d1 | _T_442;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dec_pause_state_f <= 1'h0;
    end else begin
      dec_pause_state_f <= io_dec_pause_state;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dec_tlu_wr_pause_r_d1 <= 1'h0;
    end else begin
      dec_tlu_wr_pause_r_d1 <= io_dec_tlu_wr_pause_r;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      exc_or_int_valid_r_d1 <= 1'h0;
    end else begin
      exc_or_int_valid_r_d1 <= _T_855 | mepc_trigger_hit_sel_pc_r;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      pause_expired_wb <= 1'h0;
    end else begin
      pause_expired_wb <= _T_227 & _T_228;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      lsu_pmu_load_external_r <= 1'h0;
    end else begin
      lsu_pmu_load_external_r <= io_lsu_pmu_load_external_m;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      lsu_pmu_store_external_r <= 1'h0;
    end else begin
      lsu_pmu_store_external_r <= io_lsu_pmu_store_external_m;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_32 <= 1'h0;
    end else begin
      _T_32 <= _T_427 | i0_trigger_hit_raw_r;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      internal_dbg_halt_mode_f2 <= 1'h0;
    end else begin
      internal_dbg_halt_mode_f2 <= debug_mode_status;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_33 <= 1'h0;
    end else begin
      _T_33 <= csr_io_force_halt;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      nmi_lsu_load_type_f <= 1'h0;
    end else begin
      nmi_lsu_load_type_f <= _T_50 | _T_52;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      nmi_lsu_store_type_f <= 1'h0;
    end else begin
      nmi_lsu_store_type_f <= _T_58 | _T_60;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mpc_debug_halt_req_sync_f <= 1'h0;
    end else begin
      mpc_debug_halt_req_sync_f <= mpc_debug_halt_req_sync_raw & _T_107;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mpc_debug_run_req_sync_f <= 1'h0;
    end else begin
      mpc_debug_run_req_sync_f <= syncro_ff[0];
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mpc_run_state_f <= 1'h0;
    end else begin
      mpc_run_state_f <= _T_76 & _T_78;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      debug_brkpt_status_f <= 1'h0;
    end else begin
      debug_brkpt_status_f <= _T_92 & _T_94;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mpc_debug_halt_ack_f <= 1'h0;
    end else begin
      mpc_debug_halt_ack_f <= _T_97 & core_empty;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mpc_debug_run_ack_f <= 1'h0;
    end else begin
      mpc_debug_run_ack_f <= _T_102 | _T_103;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      dbg_run_state_f <= 1'h0;
    end else begin
      dbg_run_state_f <= _T_86 & _T_78;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_65 <= 1'h0;
    end else begin
      _T_65 <= _T & mpc_halt_state_f;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      request_debug_mode_done_f <= 1'h0;
    end else begin
      request_debug_mode_done_f <= _T_183 & _T_136;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_190 <= 1'h0;
    end else begin
      _T_190 <= _T_170 & dbg_run_state_ns;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_353 <= 1'h0;
    end else begin
      _T_353 <= _T_376 | _T_386;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_354 <= 1'h0;
    end else begin
      _T_354 <= i_cpu_halt_req_d1 & pmu_fw_tlu_halted_f;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_355 <= 1'h0;
    end else begin
      _T_355 <= _T_388 | _T_389;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      lsu_single_ecc_error_r_d1 <= 1'h0;
    end else begin
      lsu_single_ecc_error_r_d1 <= io_lsu_single_ecc_error_incr;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      lsu_i0_exc_r_d1 <= 1'h0;
    end else begin
      lsu_i0_exc_r_d1 <= _T_405 & _T_470;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      take_ext_int_start_d2 <= 1'h0;
    end else begin
      take_ext_int_start_d2 <= take_ext_int_start_d1;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      tlu_flush_path_r_d1 <= 31'h0;
    end else if (take_reset) begin
      tlu_flush_path_r_d1 <= io_rst_vec;
    end else begin
      tlu_flush_path_r_d1 <= _T_852;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_exception_valid_r_d1 <= 1'h0;
    end else begin
      i0_exception_valid_r_d1 <= _T_527 & _T_528;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      exc_cause_wb <= 5'h0;
    end else begin
      exc_cause_wb <= _T_603 | _T_591;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_valid_wb <= 1'h0;
    end else begin
      i0_valid_wb <= tlu_i0_commit_cmt & _T_860;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      trigger_hit_r_d1 <= 1'h0;
    end else begin
      trigger_hit_r_d1 <= |i0_trigger_chain_masked_r;
    end
  end
endmodule
