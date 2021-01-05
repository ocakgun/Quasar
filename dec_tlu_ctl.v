module int_exc(
  input         clock,
  input         reset,
  output        io_mhwakeup_ready,
  output        io_ext_int_ready,
  output        io_ce_int_ready,
  output        io_soft_int_ready,
  output        io_timer_int_ready,
  output        io_int_timer0_int_hold,
  output        io_int_timer1_int_hold,
  output        io_internal_dbg_halt_timers,
  output        io_take_ext_int_start,
  input         io_ext_int_freeze_d1,
  input         io_take_ext_int_start_d1,
  input         io_take_ext_int_start_d2,
  input         io_take_ext_int_start_d3,
  output        io_ext_int_freeze,
  output        io_take_ext_int,
  output        io_fast_int_meicpct,
  output        io_ignore_ext_int_due_to_lsu_stall,
  output        io_take_ce_int,
  output        io_take_soft_int,
  output        io_take_timer_int,
  output        io_take_int_timer0_int,
  output        io_take_int_timer1_int,
  output        io_take_reset,
  output        io_take_nmi,
  output        io_synchronous_flush_r,
  output        io_tlu_flush_lower_r,
  output        io_dec_tlu_flush_lower_wb,
  output        io_dec_tlu_flush_lower_r,
  output [30:0] io_dec_tlu_flush_path_r,
  output        io_interrupt_valid_r_d1,
  output        io_i0_exception_valid_r_d1,
  output        io_exc_or_int_valid_r_d1,
  output [4:0]  io_exc_cause_wb,
  output        io_i0_valid_wb,
  output        io_trigger_hit_r_d1,
  output        io_take_nmi_r_d1,
  output        io_interrupt_valid_r,
  output [4:0]  io_exc_cause_r,
  output        io_i0_exception_valid_r,
  output [30:0] io_tlu_flush_path_r_d1,
  output        io_exc_or_int_valid_r,
  input         io_dec_csr_stall_int_ff,
  input         io_mstatus_mie_ns,
  input  [5:0]  io_mip,
  input  [5:0]  io_mie_ns,
  input         io_mret_r,
  input         io_pmu_fw_tlu_halted_f,
  input         io_int_timer0_int_hold_f,
  input         io_int_timer1_int_hold_f,
  input         io_internal_dbg_halt_mode_f,
  input         io_dcsr_single_step_running,
  input         io_internal_dbg_halt_mode,
  input         io_dec_tlu_i0_valid_r,
  input         io_internal_pmu_fw_halt_mode,
  input         io_i_cpu_halt_req_d1,
  input         io_ebreak_to_debug_mode_r,
  input  [1:0]  io_lsu_fir_error,
  input         io_csr_pkt_csr_meicpct,
  input         io_dec_csr_any_unq_d,
  input         io_lsu_fastint_stall_any,
  input         io_reset_delayed,
  input         io_mpc_reset_run_req,
  input         io_nmi_int_detected,
  input         io_dcsr_single_step_running_f,
  input         io_dcsr_single_step_done_f,
  input  [15:0] io_dcsr,
  input  [30:0] io_mtvec,
  input         io_tlu_i0_commit_cmt,
  input         io_i0_trigger_hit_r,
  input         io_pause_expired_r,
  input  [30:0] io_nmi_vec,
  input         io_lsu_i0_rfnpc_r,
  input         io_fence_i_r,
  input         io_iccm_repair_state_rfnpc,
  input         io_i_cpu_run_req_d1,
  input         io_rfpc_i0_r,
  input         io_lsu_exc_valid_r,
  input         io_trigger_hit_dmode_r,
  input         io_take_halt,
  input  [30:0] io_rst_vec,
  input  [30:0] io_lsu_fir_addr,
  input  [30:0] io_dec_tlu_i0_pc_r,
  input  [30:0] io_npc_r,
  input  [30:0] io_mepc,
  input         io_debug_resume_req_f,
  input  [30:0] io_dpc,
  input  [30:0] io_npc_r_d1,
  input         io_tlu_flush_lower_r_d1,
  input         io_dec_tlu_dbg_halted,
  input         io_ebreak_r,
  input         io_ecall_r,
  input         io_illegal_r,
  input         io_inst_acc_r,
  input         io_lsu_i0_exc_r,
  input         io_lsu_error_pkt_r_bits_inst_type,
  input         io_lsu_error_pkt_r_bits_exc_type,
  input         io_dec_tlu_wr_pause_r_d1
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
  wire  _T = ~io_lsu_error_pkt_r_bits_exc_type; // @[dec_tlu_ctl.scala 2987:48]
  wire  lsu_exc_ma_r = io_lsu_i0_exc_r & _T; // @[dec_tlu_ctl.scala 2987:46]
  wire  lsu_exc_acc_r = io_lsu_i0_exc_r & io_lsu_error_pkt_r_bits_exc_type; // @[dec_tlu_ctl.scala 2988:46]
  wire  lsu_exc_st_r = io_lsu_i0_exc_r & io_lsu_error_pkt_r_bits_inst_type; // @[dec_tlu_ctl.scala 2989:46]
  wire  _T_1 = io_ebreak_r | io_ecall_r; // @[dec_tlu_ctl.scala 3001:49]
  wire  _T_2 = _T_1 | io_illegal_r; // @[dec_tlu_ctl.scala 3001:62]
  wire  _T_3 = _T_2 | io_inst_acc_r; // @[dec_tlu_ctl.scala 3001:77]
  wire  _T_4 = ~io_rfpc_i0_r; // @[dec_tlu_ctl.scala 3001:96]
  wire  _T_5 = _T_3 & _T_4; // @[dec_tlu_ctl.scala 3001:94]
  wire  _T_6 = ~io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 3001:112]
  wire  _T_8 = ~io_take_nmi; // @[dec_tlu_ctl.scala 3010:36]
  wire  _T_9 = io_take_ext_int & _T_8; // @[dec_tlu_ctl.scala 3010:34]
  wire  _T_12 = io_take_timer_int & _T_8; // @[dec_tlu_ctl.scala 3011:36]
  wire  _T_15 = io_take_soft_int & _T_8; // @[dec_tlu_ctl.scala 3012:35]
  wire  _T_18 = io_take_int_timer0_int & _T_8; // @[dec_tlu_ctl.scala 3013:41]
  wire  _T_21 = io_take_int_timer1_int & _T_8; // @[dec_tlu_ctl.scala 3014:41]
  wire  _T_24 = io_take_ce_int & _T_8; // @[dec_tlu_ctl.scala 3015:33]
  wire  _T_27 = io_illegal_r & _T_8; // @[dec_tlu_ctl.scala 3016:31]
  wire  _T_30 = io_ecall_r & _T_8; // @[dec_tlu_ctl.scala 3017:30]
  wire  _T_33 = io_inst_acc_r & _T_8; // @[dec_tlu_ctl.scala 3018:33]
  wire  _T_35 = io_ebreak_r | io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 3019:31]
  wire  _T_37 = _T_35 & _T_8; // @[dec_tlu_ctl.scala 3019:54]
  wire  _T_39 = ~lsu_exc_st_r; // @[dec_tlu_ctl.scala 3020:33]
  wire  _T_40 = lsu_exc_ma_r & _T_39; // @[dec_tlu_ctl.scala 3020:31]
  wire  _T_42 = _T_40 & _T_8; // @[dec_tlu_ctl.scala 3020:47]
  wire  _T_45 = lsu_exc_acc_r & _T_39; // @[dec_tlu_ctl.scala 3021:32]
  wire  _T_47 = _T_45 & _T_8; // @[dec_tlu_ctl.scala 3021:48]
  wire  _T_49 = lsu_exc_ma_r & lsu_exc_st_r; // @[dec_tlu_ctl.scala 3022:31]
  wire  _T_51 = _T_49 & _T_8; // @[dec_tlu_ctl.scala 3022:46]
  wire  _T_53 = lsu_exc_acc_r & lsu_exc_st_r; // @[dec_tlu_ctl.scala 3023:32]
  wire  _T_55 = _T_53 & _T_8; // @[dec_tlu_ctl.scala 3023:47]
  wire [4:0] _T_57 = _T_9 ? 5'hb : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_58 = _T_12 ? 5'h7 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_59 = _T_15 ? 5'h3 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_60 = _T_18 ? 5'h1d : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_61 = _T_21 ? 5'h1c : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_62 = _T_24 ? 5'h1e : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_63 = _T_27 ? 5'h2 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_64 = _T_30 ? 5'hb : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_65 = _T_33 ? 5'h1 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_66 = _T_37 ? 5'h3 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_67 = _T_42 ? 5'h4 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_68 = _T_47 ? 5'h5 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_69 = _T_51 ? 5'h6 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_70 = _T_55 ? 5'h7 : 5'h0; // @[Mux.scala 27:72]
  wire [4:0] _T_71 = _T_57 | _T_58; // @[Mux.scala 27:72]
  wire [4:0] _T_72 = _T_71 | _T_59; // @[Mux.scala 27:72]
  wire [4:0] _T_73 = _T_72 | _T_60; // @[Mux.scala 27:72]
  wire [4:0] _T_74 = _T_73 | _T_61; // @[Mux.scala 27:72]
  wire [4:0] _T_75 = _T_74 | _T_62; // @[Mux.scala 27:72]
  wire [4:0] _T_76 = _T_75 | _T_63; // @[Mux.scala 27:72]
  wire [4:0] _T_77 = _T_76 | _T_64; // @[Mux.scala 27:72]
  wire [4:0] _T_78 = _T_77 | _T_65; // @[Mux.scala 27:72]
  wire [4:0] _T_79 = _T_78 | _T_66; // @[Mux.scala 27:72]
  wire [4:0] _T_80 = _T_79 | _T_67; // @[Mux.scala 27:72]
  wire [4:0] _T_81 = _T_80 | _T_68; // @[Mux.scala 27:72]
  wire [4:0] _T_82 = _T_81 | _T_69; // @[Mux.scala 27:72]
  wire  _T_85 = ~io_dec_csr_stall_int_ff; // @[dec_tlu_ctl.scala 3034:31]
  wire  _T_86 = _T_85 & io_mstatus_mie_ns; // @[dec_tlu_ctl.scala 3034:56]
  wire  _T_88 = _T_86 & io_mip[2]; // @[dec_tlu_ctl.scala 3034:76]
  wire  _T_90 = _T_88 & io_mie_ns[2]; // @[dec_tlu_ctl.scala 3034:97]
  wire  _T_97 = ~io_ignore_ext_int_due_to_lsu_stall; // @[dec_tlu_ctl.scala 3035:121]
  wire [5:0] _T_101 = {{5'd0}, io_mip[5]}; // @[dec_tlu_ctl.scala 3036:84]
  wire  _T_103 = _T_86 & _T_101[0]; // @[dec_tlu_ctl.scala 3036:76]
  wire  _T_109 = _T_86 & io_mip[0]; // @[dec_tlu_ctl.scala 3037:76]
  wire  _T_115 = _T_86 & io_mip[1]; // @[dec_tlu_ctl.scala 3038:76]
  wire  int_timer0_int_possible = io_mstatus_mie_ns & io_mie_ns[4]; // @[dec_tlu_ctl.scala 3041:57]
  wire [5:0] _T_119 = {{4'd0}, io_mip[5:4]}; // @[dec_tlu_ctl.scala 3042:42]
  wire  int_timer0_int_ready = _T_119[0] & int_timer0_int_possible; // @[dec_tlu_ctl.scala 3042:55]
  wire  int_timer1_int_possible = io_mstatus_mie_ns & io_mie_ns[3]; // @[dec_tlu_ctl.scala 3043:57]
  wire [5:0] _T_122 = {{3'd0}, io_mip[5:3]}; // @[dec_tlu_ctl.scala 3044:42]
  wire  int_timer1_int_ready = _T_122[0] & int_timer1_int_possible; // @[dec_tlu_ctl.scala 3044:55]
  wire  _T_124 = io_dec_csr_stall_int_ff | io_synchronous_flush_r; // @[dec_tlu_ctl.scala 3048:57]
  wire  _T_125 = _T_124 | io_exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 3048:82]
  wire  int_timer_stalled = _T_125 | io_mret_r; // @[dec_tlu_ctl.scala 3048:109]
  wire  _T_126 = io_pmu_fw_tlu_halted_f | int_timer_stalled; // @[dec_tlu_ctl.scala 3050:83]
  wire  _T_127 = int_timer0_int_ready & _T_126; // @[dec_tlu_ctl.scala 3050:57]
  wire  _T_128 = int_timer0_int_possible & io_int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 3050:132]
  wire  _T_129 = ~io_interrupt_valid_r; // @[dec_tlu_ctl.scala 3050:161]
  wire  _T_130 = _T_128 & _T_129; // @[dec_tlu_ctl.scala 3050:159]
  wire  _T_131 = ~io_take_ext_int_start; // @[dec_tlu_ctl.scala 3050:185]
  wire  _T_132 = _T_130 & _T_131; // @[dec_tlu_ctl.scala 3050:183]
  wire  _T_133 = ~io_internal_dbg_halt_mode_f; // @[dec_tlu_ctl.scala 3050:210]
  wire  _T_134 = _T_132 & _T_133; // @[dec_tlu_ctl.scala 3050:208]
  wire  _T_137 = int_timer1_int_ready & _T_126; // @[dec_tlu_ctl.scala 3051:57]
  wire  _T_138 = int_timer1_int_possible & io_int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 3051:132]
  wire  _T_140 = _T_138 & _T_129; // @[dec_tlu_ctl.scala 3051:159]
  wire  _T_142 = _T_140 & _T_131; // @[dec_tlu_ctl.scala 3051:183]
  wire  _T_144 = _T_142 & _T_133; // @[dec_tlu_ctl.scala 3051:208]
  wire  _T_146 = ~io_dcsr_single_step_running; // @[dec_tlu_ctl.scala 3053:70]
  wire  _T_149 = _T_146 | io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 3055:92]
  wire  _T_150 = io_internal_dbg_halt_mode & _T_149; // @[dec_tlu_ctl.scala 3055:60]
  wire  _T_151 = _T_150 | io_internal_pmu_fw_halt_mode; // @[dec_tlu_ctl.scala 3055:118]
  wire  _T_152 = _T_151 | io_i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 3055:149]
  wire  _T_153 = _T_152 | io_take_nmi; // @[dec_tlu_ctl.scala 3055:172]
  wire  _T_154 = _T_153 | io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 3055:186]
  wire  _T_155 = _T_154 | io_synchronous_flush_r; // @[dec_tlu_ctl.scala 3055:214]
  wire  _T_156 = _T_155 | io_exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 3055:240]
  wire  _T_157 = _T_156 | io_mret_r; // @[dec_tlu_ctl.scala 3055:267]
  wire  block_interrupts = _T_157 | io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 3055:279]
  wire  _T_158 = ~block_interrupts; // @[dec_tlu_ctl.scala 3063:61]
  wire  _T_160 = io_take_ext_int_start | io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 3064:60]
  wire  _T_161 = _T_160 | io_take_ext_int_start_d2; // @[dec_tlu_ctl.scala 3064:87]
  wire  _T_163 = |io_lsu_fir_error; // @[dec_tlu_ctl.scala 3065:81]
  wire  _T_164 = ~_T_163; // @[dec_tlu_ctl.scala 3065:63]
  wire  _T_165 = io_take_ext_int_start_d3 & _T_164; // @[dec_tlu_ctl.scala 3065:61]
  wire  _T_167 = ~io_ext_int_ready; // @[dec_tlu_ctl.scala 3080:46]
  wire  _T_168 = io_ce_int_ready & _T_167; // @[dec_tlu_ctl.scala 3080:44]
  wire  _T_172 = io_soft_int_ready & _T_167; // @[dec_tlu_ctl.scala 3081:47]
  wire  _T_173 = ~io_ce_int_ready; // @[dec_tlu_ctl.scala 3081:69]
  wire  _T_174 = _T_172 & _T_173; // @[dec_tlu_ctl.scala 3081:67]
  wire  _T_177 = ~io_soft_int_ready; // @[dec_tlu_ctl.scala 3082:51]
  wire  _T_178 = io_timer_int_ready & _T_177; // @[dec_tlu_ctl.scala 3082:49]
  wire  _T_180 = _T_178 & _T_167; // @[dec_tlu_ctl.scala 3082:70]
  wire  _T_182 = _T_180 & _T_173; // @[dec_tlu_ctl.scala 3082:90]
  wire  _T_185 = int_timer0_int_ready | io_int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 3083:57]
  wire  _T_186 = _T_185 & int_timer0_int_possible; // @[dec_tlu_ctl.scala 3083:85]
  wire  _T_188 = _T_186 & _T_85; // @[dec_tlu_ctl.scala 3083:111]
  wire  _T_189 = ~io_timer_int_ready; // @[dec_tlu_ctl.scala 3083:140]
  wire  _T_190 = _T_188 & _T_189; // @[dec_tlu_ctl.scala 3083:138]
  wire  _T_192 = _T_190 & _T_177; // @[dec_tlu_ctl.scala 3083:160]
  wire  _T_194 = _T_192 & _T_167; // @[dec_tlu_ctl.scala 3083:181]
  wire  _T_196 = _T_194 & _T_173; // @[dec_tlu_ctl.scala 3083:201]
  wire  _T_199 = int_timer1_int_ready | io_int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 3084:57]
  wire  _T_200 = _T_199 & int_timer1_int_possible; // @[dec_tlu_ctl.scala 3084:85]
  wire  _T_202 = _T_200 & _T_85; // @[dec_tlu_ctl.scala 3084:111]
  wire  _T_204 = ~_T_185; // @[dec_tlu_ctl.scala 3084:140]
  wire  _T_205 = _T_202 & _T_204; // @[dec_tlu_ctl.scala 3084:138]
  wire  _T_207 = _T_205 & _T_189; // @[dec_tlu_ctl.scala 3084:191]
  wire  _T_209 = _T_207 & _T_177; // @[dec_tlu_ctl.scala 3084:213]
  wire  _T_211 = _T_209 & _T_167; // @[dec_tlu_ctl.scala 3084:234]
  wire  _T_213 = _T_211 & _T_173; // @[dec_tlu_ctl.scala 3084:254]
  wire  _T_217 = ~io_internal_pmu_fw_halt_mode; // @[dec_tlu_ctl.scala 3086:46]
  wire  _T_218 = io_nmi_int_detected & _T_217; // @[dec_tlu_ctl.scala 3086:44]
  wire  _T_219 = ~io_internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 3086:79]
  wire  _T_221 = io_dcsr_single_step_running_f & io_dcsr[11]; // @[dec_tlu_ctl.scala 3086:139]
  wire  _T_222 = ~io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 3086:164]
  wire  _T_223 = _T_221 & _T_222; // @[dec_tlu_ctl.scala 3086:162]
  wire  _T_224 = ~io_dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 3086:189]
  wire  _T_225 = _T_223 & _T_224; // @[dec_tlu_ctl.scala 3086:187]
  wire  _T_226 = _T_219 | _T_225; // @[dec_tlu_ctl.scala 3086:106]
  wire  _T_227 = _T_218 & _T_226; // @[dec_tlu_ctl.scala 3086:76]
  wire  _T_228 = ~io_synchronous_flush_r; // @[dec_tlu_ctl.scala 3086:221]
  wire  _T_229 = _T_227 & _T_228; // @[dec_tlu_ctl.scala 3086:219]
  wire  _T_230 = ~io_mret_r; // @[dec_tlu_ctl.scala 3086:247]
  wire  _T_231 = _T_229 & _T_230; // @[dec_tlu_ctl.scala 3086:245]
  wire  _T_232 = ~io_take_reset; // @[dec_tlu_ctl.scala 3086:260]
  wire  _T_233 = _T_231 & _T_232; // @[dec_tlu_ctl.scala 3086:258]
  wire  _T_234 = ~io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 3086:277]
  wire  _T_235 = _T_233 & _T_234; // @[dec_tlu_ctl.scala 3086:275]
  wire  _T_236 = ~io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 3086:307]
  wire  _T_238 = io_take_ext_int_start_d3 & _T_163; // @[dec_tlu_ctl.scala 3086:357]
  wire  _T_239 = _T_236 | _T_238; // @[dec_tlu_ctl.scala 3086:329]
  wire  _T_241 = io_take_ext_int | io_take_timer_int; // @[dec_tlu_ctl.scala 3089:49]
  wire  _T_242 = _T_241 | io_take_soft_int; // @[dec_tlu_ctl.scala 3089:69]
  wire  _T_243 = _T_242 | io_take_nmi; // @[dec_tlu_ctl.scala 3089:88]
  wire  _T_244 = _T_243 | io_take_ce_int; // @[dec_tlu_ctl.scala 3089:102]
  wire  _T_245 = _T_244 | io_take_int_timer0_int; // @[dec_tlu_ctl.scala 3089:119]
  wire [30:0] _T_248 = {io_mtvec[30:1],1'h0}; // @[Cat.scala 29:58]
  wire [30:0] _T_250 = {25'h0,io_exc_cause_r,1'h0}; // @[Cat.scala 29:58]
  wire [30:0] vectored_path = _T_248 + _T_250; // @[dec_tlu_ctl.scala 3094:59]
  wire [30:0] _T_257 = io_mtvec[0] ? vectored_path : _T_248; // @[dec_tlu_ctl.scala 3095:69]
  wire [30:0] interrupt_path = io_take_nmi ? io_nmi_vec : _T_257; // @[dec_tlu_ctl.scala 3095:33]
  wire  _T_258 = io_lsu_i0_rfnpc_r | io_fence_i_r; // @[dec_tlu_ctl.scala 3096:44]
  wire  _T_259 = _T_258 | io_iccm_repair_state_rfnpc; // @[dec_tlu_ctl.scala 3096:59]
  wire  _T_261 = io_i_cpu_run_req_d1 & _T_129; // @[dec_tlu_ctl.scala 3096:111]
  wire  _T_262 = _T_259 | _T_261; // @[dec_tlu_ctl.scala 3096:88]
  wire  _T_264 = io_rfpc_i0_r & _T_222; // @[dec_tlu_ctl.scala 3096:152]
  wire  sel_npc_r = _T_262 | _T_264; // @[dec_tlu_ctl.scala 3096:136]
  wire  _T_265 = io_i_cpu_run_req_d1 & io_pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 3097:51]
  wire  sel_npc_resume = _T_265 | io_pause_expired_r; // @[dec_tlu_ctl.scala 3097:77]
  wire  _T_268 = io_i0_exception_valid_r | io_rfpc_i0_r; // @[dec_tlu_ctl.scala 3099:60]
  wire  _T_269 = _T_268 | io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 3099:75]
  wire  _T_270 = _T_269 | io_fence_i_r; // @[dec_tlu_ctl.scala 3099:96]
  wire  _T_271 = _T_270 | io_lsu_i0_rfnpc_r; // @[dec_tlu_ctl.scala 3099:111]
  wire  _T_272 = _T_271 | io_iccm_repair_state_rfnpc; // @[dec_tlu_ctl.scala 3099:131]
  wire  _T_273 = _T_272 | io_debug_resume_req_f; // @[dec_tlu_ctl.scala 3099:161]
  wire  _T_274 = _T_273 | sel_npc_resume; // @[dec_tlu_ctl.scala 3099:186]
  wire  _T_275 = _T_274 | io_dec_tlu_wr_pause_r_d1; // @[dec_tlu_ctl.scala 3099:204]
  wire  _T_277 = io_interrupt_valid_r | io_mret_r; // @[dec_tlu_ctl.scala 3100:54]
  wire  _T_278 = _T_277 | io_synchronous_flush_r; // @[dec_tlu_ctl.scala 3100:66]
  wire  _T_279 = _T_278 | io_take_halt; // @[dec_tlu_ctl.scala 3100:91]
  wire  _T_280 = _T_279 | io_take_reset; // @[dec_tlu_ctl.scala 3100:106]
  wire  _T_286 = _T_8 & sel_npc_r; // @[dec_tlu_ctl.scala 3104:36]
  wire  _T_289 = _T_8 & io_rfpc_i0_r; // @[dec_tlu_ctl.scala 3105:36]
  wire  _T_291 = _T_289 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 3105:57]
  wire  _T_292 = ~sel_npc_r; // @[dec_tlu_ctl.scala 3105:98]
  wire  _T_293 = _T_291 & _T_292; // @[dec_tlu_ctl.scala 3105:87]
  wire  _T_295 = ~_T_165; // @[dec_tlu_ctl.scala 3106:59]
  wire  _T_296 = io_interrupt_valid_r & _T_295; // @[dec_tlu_ctl.scala 3106:45]
  wire  _T_297 = io_i0_exception_valid_r | io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 3107:43]
  wire  _T_298 = ~io_trigger_hit_dmode_r; // @[dec_tlu_ctl.scala 3107:89]
  wire  _T_299 = io_i0_trigger_hit_r & _T_298; // @[dec_tlu_ctl.scala 3107:87]
  wire  _T_300 = _T_297 | _T_299; // @[dec_tlu_ctl.scala 3107:64]
  wire  _T_302 = _T_300 & _T_129; // @[dec_tlu_ctl.scala 3107:115]
  wire  _T_304 = _T_302 & _T_295; // @[dec_tlu_ctl.scala 3107:139]
  wire  _T_309 = _T_8 & io_mret_r; // @[dec_tlu_ctl.scala 3108:31]
  wire  _T_312 = _T_8 & io_debug_resume_req_f; // @[dec_tlu_ctl.scala 3109:31]
  wire  _T_315 = _T_8 & sel_npc_resume; // @[dec_tlu_ctl.scala 3110:31]
  wire [30:0] _T_317 = _T_165 ? io_lsu_fir_addr : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_318 = _T_286 ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_319 = _T_293 ? io_dec_tlu_i0_pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_320 = _T_296 ? interrupt_path : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_321 = _T_304 ? _T_248 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_322 = _T_309 ? io_mepc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_323 = _T_312 ? io_dpc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_324 = _T_315 ? io_npc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_325 = _T_317 | _T_318; // @[Mux.scala 27:72]
  wire [30:0] _T_326 = _T_325 | _T_319; // @[Mux.scala 27:72]
  wire [30:0] _T_327 = _T_326 | _T_320; // @[Mux.scala 27:72]
  wire [30:0] _T_328 = _T_327 | _T_321; // @[Mux.scala 27:72]
  wire [30:0] _T_329 = _T_328 | _T_322; // @[Mux.scala 27:72]
  wire [30:0] _T_330 = _T_329 | _T_323; // @[Mux.scala 27:72]
  wire [30:0] _T_331 = _T_330 | _T_324; // @[Mux.scala 27:72]
  reg [30:0] _T_336; // @[Reg.scala 27:20]
  wire  _T_337 = io_lsu_exc_valid_r | io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 3121:53]
  wire  _T_338 = _T_337 | io_interrupt_valid_r; // @[dec_tlu_ctl.scala 3121:79]
  reg  _T_346; // @[Reg.scala 27:20]
  wire  _T_344 = io_interrupt_valid_r ^ _T_346; // @[lib.scala 441:21]
  wire  _T_345 = |_T_344; // @[lib.scala 441:29]
  reg  _T_351; // @[Reg.scala 27:20]
  wire  _T_349 = io_i0_exception_valid_r ^ _T_351; // @[lib.scala 441:21]
  wire  _T_350 = |_T_349; // @[lib.scala 441:29]
  reg  _T_356; // @[Reg.scala 27:20]
  wire  _T_354 = io_exc_or_int_valid_r ^ _T_356; // @[lib.scala 441:21]
  wire  _T_355 = |_T_354; // @[lib.scala 441:29]
  reg [4:0] _T_361; // @[Reg.scala 27:20]
  wire [4:0] _T_359 = io_exc_cause_r ^ _T_361; // @[lib.scala 441:21]
  wire  _T_360 = |_T_359; // @[lib.scala 441:29]
  wire  _T_362 = ~io_illegal_r; // @[dec_tlu_ctl.scala 3127:104]
  wire  _T_363 = io_tlu_i0_commit_cmt & _T_362; // @[dec_tlu_ctl.scala 3127:102]
  reg  _T_368; // @[Reg.scala 27:20]
  wire  _T_366 = _T_363 ^ _T_368; // @[lib.scala 441:21]
  wire  _T_367 = |_T_366; // @[lib.scala 441:29]
  reg  _T_373; // @[Reg.scala 27:20]
  wire  _T_371 = io_i0_trigger_hit_r ^ _T_373; // @[lib.scala 441:21]
  wire  _T_372 = |_T_371; // @[lib.scala 441:29]
  reg  _T_378; // @[Reg.scala 27:20]
  wire  _T_376 = io_take_nmi ^ _T_378; // @[lib.scala 441:21]
  wire  _T_377 = |_T_376; // @[lib.scala 441:29]
  assign io_mhwakeup_ready = _T_88 & io_mie_ns[2]; // @[dec_tlu_ctl.scala 3034:28]
  assign io_ext_int_ready = _T_90 & _T_97; // @[dec_tlu_ctl.scala 3035:28]
  assign io_ce_int_ready = _T_103 & io_mie_ns[5]; // @[dec_tlu_ctl.scala 3036:28]
  assign io_soft_int_ready = _T_109 & io_mie_ns[0]; // @[dec_tlu_ctl.scala 3037:28]
  assign io_timer_int_ready = _T_115 & io_mie_ns[1]; // @[dec_tlu_ctl.scala 3038:28]
  assign io_int_timer0_int_hold = _T_127 | _T_134; // @[dec_tlu_ctl.scala 3050:32]
  assign io_int_timer1_int_hold = _T_137 | _T_144; // @[dec_tlu_ctl.scala 3051:32]
  assign io_internal_dbg_halt_timers = io_internal_dbg_halt_mode_f & _T_146; // @[dec_tlu_ctl.scala 3053:37]
  assign io_take_ext_int_start = io_ext_int_ready & _T_158; // @[dec_tlu_ctl.scala 3063:39]
  assign io_ext_int_freeze = _T_161 | io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 3064:35]
  assign io_take_ext_int = io_take_ext_int_start_d3 & _T_164; // @[dec_tlu_ctl.scala 3065:33]
  assign io_fast_int_meicpct = io_csr_pkt_csr_meicpct & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 3066:37]
  assign io_ignore_ext_int_due_to_lsu_stall = io_lsu_fastint_stall_any; // @[dec_tlu_ctl.scala 3067:52]
  assign io_take_ce_int = _T_168 & _T_158; // @[dec_tlu_ctl.scala 3080:25]
  assign io_take_soft_int = _T_174 & _T_158; // @[dec_tlu_ctl.scala 3081:26]
  assign io_take_timer_int = _T_182 & _T_158; // @[dec_tlu_ctl.scala 3082:27]
  assign io_take_int_timer0_int = _T_196 & _T_158; // @[dec_tlu_ctl.scala 3083:32]
  assign io_take_int_timer1_int = _T_213 & _T_158; // @[dec_tlu_ctl.scala 3084:32]
  assign io_take_reset = io_reset_delayed & io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 3085:23]
  assign io_take_nmi = _T_235 & _T_239; // @[dec_tlu_ctl.scala 3086:21]
  assign io_synchronous_flush_r = _T_275 | io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 3099:33]
  assign io_tlu_flush_lower_r = _T_280 | io_take_ext_int_start; // @[dec_tlu_ctl.scala 3100:30]
  assign io_dec_tlu_flush_lower_wb = io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 3115:41]
  assign io_dec_tlu_flush_lower_r = io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 3117:41]
  assign io_dec_tlu_flush_path_r = io_take_reset ? io_rst_vec : _T_331; // @[dec_tlu_ctl.scala 3118:41]
  assign io_interrupt_valid_r_d1 = _T_346; // @[dec_tlu_ctl.scala 3123:59]
  assign io_i0_exception_valid_r_d1 = _T_351; // @[dec_tlu_ctl.scala 3124:51]
  assign io_exc_or_int_valid_r_d1 = _T_356; // @[dec_tlu_ctl.scala 3125:53]
  assign io_exc_cause_wb = _T_361; // @[dec_tlu_ctl.scala 3126:65]
  assign io_i0_valid_wb = _T_368; // @[dec_tlu_ctl.scala 3127:71]
  assign io_trigger_hit_r_d1 = _T_373; // @[dec_tlu_ctl.scala 3128:63]
  assign io_take_nmi_r_d1 = _T_378; // @[dec_tlu_ctl.scala 3129:73]
  assign io_interrupt_valid_r = _T_245 | io_take_int_timer1_int; // @[dec_tlu_ctl.scala 3089:30]
  assign io_exc_cause_r = _T_82 | _T_70; // @[dec_tlu_ctl.scala 3009:24]
  assign io_i0_exception_valid_r = _T_5 & _T_6; // @[dec_tlu_ctl.scala 3001:33]
  assign io_tlu_flush_path_r_d1 = _T_336; // @[dec_tlu_ctl.scala 3113:31]
  assign io_exc_or_int_valid_r = _T_338 | _T_299; // @[dec_tlu_ctl.scala 3121:31]
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
  _T_336 = _RAND_0[30:0];
  _RAND_1 = {1{`RANDOM}};
  _T_346 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_351 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  _T_356 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  _T_361 = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  _T_368 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  _T_373 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  _T_378 = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    _T_336 = 31'h0;
  end
  if (reset) begin
    _T_346 = 1'h0;
  end
  if (reset) begin
    _T_351 = 1'h0;
  end
  if (reset) begin
    _T_356 = 1'h0;
  end
  if (reset) begin
    _T_361 = 5'h0;
  end
  if (reset) begin
    _T_368 = 1'h0;
  end
  if (reset) begin
    _T_373 = 1'h0;
  end
  if (reset) begin
    _T_378 = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_336 <= 31'h0;
    end else if (io_tlu_flush_lower_r) begin
      if (io_take_reset) begin
        _T_336 <= io_rst_vec;
      end else begin
        _T_336 <= _T_331;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_346 <= 1'h0;
    end else if (_T_345) begin
      _T_346 <= io_interrupt_valid_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_351 <= 1'h0;
    end else if (_T_350) begin
      _T_351 <= io_i0_exception_valid_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_356 <= 1'h0;
    end else if (_T_355) begin
      _T_356 <= io_exc_or_int_valid_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_361 <= 5'h0;
    end else if (_T_360) begin
      _T_361 <= io_exc_cause_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_368 <= 1'h0;
    end else if (_T_367) begin
      _T_368 <= _T_363;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_373 <= 1'h0;
    end else if (_T_372) begin
      _T_373 <= io_i0_trigger_hit_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_378 <= 1'h0;
    end else if (_T_377) begin
      _T_378 <= io_take_nmi;
    end
  end
endmodule
module perf_mux_and_flops(
  input        reset,
  output       io_mhpmc_inc_r_0,
  output       io_mhpmc_inc_r_1,
  output       io_mhpmc_inc_r_2,
  output       io_mhpmc_inc_r_3,
  input  [6:0] io_mcountinhibit,
  input  [9:0] io_mhpme_vec_0,
  input  [9:0] io_mhpme_vec_1,
  input  [9:0] io_mhpme_vec_2,
  input  [9:0] io_mhpme_vec_3,
  input        io_ifu_pmu_ic_hit,
  input        io_ifu_pmu_ic_miss,
  input        io_tlu_i0_commit_cmt,
  input        io_illegal_r,
  input        io_exu_pmu_i0_pc4,
  input        io_ifu_pmu_instr_aligned,
  input        io_dec_pmu_instr_decoded,
  input  [3:0] io_dec_tlu_packet_r_pmu_i0_itype,
  input        io_dec_tlu_packet_r_pmu_i0_br_unpred,
  input        io_dec_tlu_packet_r_pmu_divide,
  input        io_dec_tlu_packet_r_pmu_lsu_misaligned,
  input        io_exu_pmu_i0_br_misp,
  input        io_dec_pmu_decode_stall,
  input        io_exu_pmu_i0_br_ataken,
  input        io_ifu_pmu_fetch_stall,
  input        io_dec_pmu_postsync_stall,
  input        io_dec_pmu_presync_stall,
  input        io_lsu_store_stall_any,
  input        io_dma_dccm_stall_any,
  input        io_dma_iccm_stall_any,
  input        io_i0_exception_valid_r,
  input        io_dec_tlu_pmu_fw_halted,
  input        io_dma_pmu_any_read,
  input        io_dma_pmu_any_write,
  input        io_dma_pmu_dccm_read,
  input        io_dma_pmu_dccm_write,
  input        io_lsu_pmu_load_external_r,
  input        io_lsu_pmu_store_external_r,
  output [1:0] io_mstatus,
  input  [5:0] io_mie,
  input        io_ifu_pmu_bus_trxn,
  input        io_lsu_pmu_bus_trxn,
  input        io_lsu_pmu_bus_misaligned,
  input        io_ifu_pmu_bus_error,
  input        io_lsu_pmu_bus_error,
  input        io_ifu_pmu_bus_busy,
  input        io_lsu_pmu_bus_busy,
  input        io_i0_trigger_hit_r,
  input        io_lsu_exc_valid_r,
  input        io_take_timer_int,
  input        io_take_int_timer0_int,
  input        io_take_int_timer1_int,
  input        io_take_ext_int,
  input        io_tlu_flush_lower_r,
  input        io_dec_tlu_br0_error_r,
  input        io_rfpc_i0_r,
  input        io_dec_tlu_br0_start_error_r,
  output       io_mcyclel_cout_f,
  output       io_minstret_enable_f,
  output       io_minstretl_cout_f,
  output [3:0] io_meicidpl,
  output       io_icache_rd_valid_f,
  output       io_icache_wr_valid_f,
  output       io_mhpmc_inc_r_d1_0,
  output       io_mhpmc_inc_r_d1_1,
  output       io_mhpmc_inc_r_d1_2,
  output       io_mhpmc_inc_r_d1_3,
  output       io_perfcnt_halted_d1,
  output       io_mdseac_locked_f,
  output       io_lsu_single_ecc_error_r_d1,
  output       io_lsu_i0_exc_r_d1,
  output       io_take_ext_int_start_d1,
  output       io_take_ext_int_start_d2,
  output       io_take_ext_int_start_d3,
  output       io_ext_int_freeze_d1,
  output [5:0] io_mip,
  input        io_mdseac_locked_ns,
  input        io_lsu_single_ecc_error_r,
  input        io_lsu_i0_exc_r,
  input        io_take_ext_int_start,
  input        io_ext_int_freeze,
  input  [5:0] io_mip_ns,
  input        io_mcyclel_cout,
  input        io_wr_mcycleh_r,
  input        io_mcyclel_cout_in,
  input        io_minstret_enable,
  input        io_minstretl_cout_ns,
  input  [3:0] io_meicidpl_ns,
  input        io_icache_rd_valid,
  input        io_icache_wr_valid,
  input        io_perfcnt_halted,
  input  [1:0] io_mstatus_ns,
  input        io_free_l2clk
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
`endif // RANDOMIZE_REG_INIT
  wire [3:0] _T_1 = io_tlu_i0_commit_cmt ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] pmu_i0_itype_qual = io_dec_tlu_packet_r_pmu_i0_itype & _T_1; // @[dec_tlu_ctl.scala 2769:66]
  wire  _T_3 = ~io_mcountinhibit[3]; // @[dec_tlu_ctl.scala 2771:40]
  wire  _T_4 = io_mhpme_vec_0 == 10'h1; // @[dec_tlu_ctl.scala 2772:42]
  wire  _T_6 = io_mhpme_vec_0 == 10'h2; // @[dec_tlu_ctl.scala 2773:42]
  wire  _T_8 = io_mhpme_vec_0 == 10'h3; // @[dec_tlu_ctl.scala 2774:42]
  wire  _T_10 = io_mhpme_vec_0 == 10'h4; // @[dec_tlu_ctl.scala 2775:42]
  wire  _T_12 = ~io_illegal_r; // @[dec_tlu_ctl.scala 2775:104]
  wire  _T_13 = io_tlu_i0_commit_cmt & _T_12; // @[dec_tlu_ctl.scala 2775:102]
  wire  _T_14 = io_mhpme_vec_0 == 10'h5; // @[dec_tlu_ctl.scala 2776:42]
  wire  _T_16 = ~io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 2776:104]
  wire  _T_17 = io_tlu_i0_commit_cmt & _T_16; // @[dec_tlu_ctl.scala 2776:102]
  wire  _T_19 = _T_17 & _T_12; // @[dec_tlu_ctl.scala 2776:123]
  wire  _T_20 = io_mhpme_vec_0 == 10'h6; // @[dec_tlu_ctl.scala 2777:42]
  wire  _T_22 = io_tlu_i0_commit_cmt & io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 2777:102]
  wire  _T_24 = _T_22 & _T_12; // @[dec_tlu_ctl.scala 2777:123]
  wire  _T_25 = io_mhpme_vec_0 == 10'h7; // @[dec_tlu_ctl.scala 2778:42]
  wire  _T_27 = io_mhpme_vec_0 == 10'h8; // @[dec_tlu_ctl.scala 2779:42]
  wire  _T_29 = io_mhpme_vec_0 == 10'h1e; // @[dec_tlu_ctl.scala 2780:42]
  wire  _T_31 = io_mhpme_vec_0 == 10'h9; // @[dec_tlu_ctl.scala 2781:42]
  wire  _T_33 = pmu_i0_itype_qual == 4'h1; // @[dec_tlu_ctl.scala 2781:99]
  wire  _T_34 = io_mhpme_vec_0 == 10'ha; // @[dec_tlu_ctl.scala 2782:42]
  wire  _T_36 = io_dec_tlu_packet_r_pmu_divide & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2782:113]
  wire  _T_38 = _T_36 & _T_12; // @[dec_tlu_ctl.scala 2782:136]
  wire  _T_39 = io_mhpme_vec_0 == 10'hb; // @[dec_tlu_ctl.scala 2783:42]
  wire  _T_41 = pmu_i0_itype_qual == 4'h2; // @[dec_tlu_ctl.scala 2783:99]
  wire  _T_42 = io_mhpme_vec_0 == 10'hc; // @[dec_tlu_ctl.scala 2784:42]
  wire  _T_44 = pmu_i0_itype_qual == 4'h3; // @[dec_tlu_ctl.scala 2784:99]
  wire  _T_45 = io_mhpme_vec_0 == 10'hd; // @[dec_tlu_ctl.scala 2785:42]
  wire  _T_48 = _T_41 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 2785:108]
  wire  _T_49 = io_mhpme_vec_0 == 10'he; // @[dec_tlu_ctl.scala 2786:42]
  wire  _T_53 = _T_44 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 2786:109]
  wire  _T_54 = io_mhpme_vec_0 == 10'hf; // @[dec_tlu_ctl.scala 2787:42]
  wire  _T_56 = pmu_i0_itype_qual == 4'h4; // @[dec_tlu_ctl.scala 2787:97]
  wire  _T_57 = io_mhpme_vec_0 == 10'h10; // @[dec_tlu_ctl.scala 2788:42]
  wire  _T_59 = pmu_i0_itype_qual == 4'h5; // @[dec_tlu_ctl.scala 2788:97]
  wire  _T_60 = io_mhpme_vec_0 == 10'h12; // @[dec_tlu_ctl.scala 2789:42]
  wire  _T_62 = pmu_i0_itype_qual == 4'h6; // @[dec_tlu_ctl.scala 2789:97]
  wire  _T_63 = io_mhpme_vec_0 == 10'h11; // @[dec_tlu_ctl.scala 2790:42]
  wire  _T_65 = pmu_i0_itype_qual == 4'h7; // @[dec_tlu_ctl.scala 2790:97]
  wire  _T_66 = io_mhpme_vec_0 == 10'h13; // @[dec_tlu_ctl.scala 2791:42]
  wire  _T_68 = pmu_i0_itype_qual == 4'h8; // @[dec_tlu_ctl.scala 2791:97]
  wire  _T_69 = io_mhpme_vec_0 == 10'h14; // @[dec_tlu_ctl.scala 2792:42]
  wire  _T_71 = pmu_i0_itype_qual == 4'h9; // @[dec_tlu_ctl.scala 2792:97]
  wire  _T_72 = io_mhpme_vec_0 == 10'h15; // @[dec_tlu_ctl.scala 2793:42]
  wire  _T_74 = pmu_i0_itype_qual == 4'ha; // @[dec_tlu_ctl.scala 2793:97]
  wire  _T_75 = io_mhpme_vec_0 == 10'h16; // @[dec_tlu_ctl.scala 2794:42]
  wire  _T_77 = pmu_i0_itype_qual == 4'hb; // @[dec_tlu_ctl.scala 2794:97]
  wire  _T_78 = io_mhpme_vec_0 == 10'h17; // @[dec_tlu_ctl.scala 2795:42]
  wire  _T_80 = pmu_i0_itype_qual == 4'hc; // @[dec_tlu_ctl.scala 2795:97]
  wire  _T_81 = io_mhpme_vec_0 == 10'h18; // @[dec_tlu_ctl.scala 2796:42]
  wire  _T_83 = pmu_i0_itype_qual == 4'hd; // @[dec_tlu_ctl.scala 2796:97]
  wire  _T_84 = pmu_i0_itype_qual == 4'he; // @[dec_tlu_ctl.scala 2796:130]
  wire  _T_85 = _T_83 | _T_84; // @[dec_tlu_ctl.scala 2796:109]
  wire  _T_86 = io_mhpme_vec_0 == 10'h19; // @[dec_tlu_ctl.scala 2797:42]
  wire  _T_88 = io_exu_pmu_i0_br_misp & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2797:103]
  wire  _T_90 = _T_88 & _T_12; // @[dec_tlu_ctl.scala 2797:126]
  wire  _T_91 = io_mhpme_vec_0 == 10'h1a; // @[dec_tlu_ctl.scala 2798:42]
  wire  _T_93 = io_exu_pmu_i0_br_ataken & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2798:105]
  wire  _T_95 = _T_93 & _T_12; // @[dec_tlu_ctl.scala 2798:128]
  wire  _T_96 = io_mhpme_vec_0 == 10'h1b; // @[dec_tlu_ctl.scala 2799:42]
  wire  _T_98 = io_dec_tlu_packet_r_pmu_i0_br_unpred & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2799:118]
  wire  _T_100 = _T_98 & _T_12; // @[dec_tlu_ctl.scala 2799:141]
  wire  _T_101 = io_mhpme_vec_0 == 10'h1c; // @[dec_tlu_ctl.scala 2800:42]
  wire  _T_105 = io_mhpme_vec_0 == 10'h1f; // @[dec_tlu_ctl.scala 2802:42]
  wire  _T_107 = io_mhpme_vec_0 == 10'h20; // @[dec_tlu_ctl.scala 2803:42]
  wire  _T_109 = io_mhpme_vec_0 == 10'h22; // @[dec_tlu_ctl.scala 2804:42]
  wire  _T_111 = io_mhpme_vec_0 == 10'h23; // @[dec_tlu_ctl.scala 2805:42]
  wire  _T_113 = io_mhpme_vec_0 == 10'h24; // @[dec_tlu_ctl.scala 2806:42]
  wire  _T_115 = io_mhpme_vec_0 == 10'h25; // @[dec_tlu_ctl.scala 2807:42]
  wire  _T_117 = io_i0_exception_valid_r | io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 2807:106]
  wire  _T_118 = _T_117 | io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 2807:128]
  wire  _T_119 = io_mhpme_vec_0 == 10'h26; // @[dec_tlu_ctl.scala 2808:42]
  wire  _T_121 = io_take_timer_int | io_take_int_timer0_int; // @[dec_tlu_ctl.scala 2808:100]
  wire  _T_122 = _T_121 | io_take_int_timer1_int; // @[dec_tlu_ctl.scala 2808:125]
  wire  _T_123 = io_mhpme_vec_0 == 10'h27; // @[dec_tlu_ctl.scala 2809:42]
  wire  _T_125 = io_mhpme_vec_0 == 10'h28; // @[dec_tlu_ctl.scala 2810:42]
  wire  _T_127 = io_mhpme_vec_0 == 10'h29; // @[dec_tlu_ctl.scala 2811:42]
  wire  _T_129 = io_dec_tlu_br0_error_r | io_dec_tlu_br0_start_error_r; // @[dec_tlu_ctl.scala 2811:105]
  wire  _T_130 = _T_129 & io_rfpc_i0_r; // @[dec_tlu_ctl.scala 2811:137]
  wire  _T_131 = io_mhpme_vec_0 == 10'h2a; // @[dec_tlu_ctl.scala 2812:42]
  wire  _T_133 = io_mhpme_vec_0 == 10'h2b; // @[dec_tlu_ctl.scala 2813:42]
  wire  _T_135 = io_mhpme_vec_0 == 10'h2c; // @[dec_tlu_ctl.scala 2814:42]
  wire  _T_137 = io_mhpme_vec_0 == 10'h2d; // @[dec_tlu_ctl.scala 2815:42]
  wire  _T_139 = io_mhpme_vec_0 == 10'h2e; // @[dec_tlu_ctl.scala 2816:42]
  wire  _T_141 = io_mhpme_vec_0 == 10'h2f; // @[dec_tlu_ctl.scala 2817:42]
  wire  _T_143 = io_mhpme_vec_0 == 10'h30; // @[dec_tlu_ctl.scala 2818:42]
  wire  _T_145 = io_mhpme_vec_0 == 10'h31; // @[dec_tlu_ctl.scala 2819:42]
  wire  _T_149 = ~io_mstatus[0]; // @[dec_tlu_ctl.scala 2819:81]
  wire  _T_150 = io_mhpme_vec_0 == 10'h32; // @[dec_tlu_ctl.scala 2820:42]
  wire [5:0] _T_157 = io_mip & io_mie; // @[dec_tlu_ctl.scala 2820:121]
  wire  _T_158 = |_T_157; // @[dec_tlu_ctl.scala 2820:136]
  wire  _T_159 = _T_149 & _T_158; // @[dec_tlu_ctl.scala 2820:106]
  wire  _T_160 = io_mhpme_vec_0 == 10'h36; // @[dec_tlu_ctl.scala 2821:42]
  wire  _T_162 = pmu_i0_itype_qual == 4'hf; // @[dec_tlu_ctl.scala 2821:99]
  wire  _T_163 = io_mhpme_vec_0 == 10'h37; // @[dec_tlu_ctl.scala 2822:42]
  wire  _T_165 = io_tlu_i0_commit_cmt & io_lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 2822:102]
  wire  _T_167 = _T_165 & _T_12; // @[dec_tlu_ctl.scala 2822:131]
  wire  _T_168 = io_mhpme_vec_0 == 10'h38; // @[dec_tlu_ctl.scala 2823:42]
  wire  _T_170 = io_tlu_i0_commit_cmt & io_lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 2823:102]
  wire  _T_172 = _T_170 & _T_12; // @[dec_tlu_ctl.scala 2823:132]
  wire  _T_173 = io_mhpme_vec_0 == 10'h200; // @[dec_tlu_ctl.scala 2825:42]
  wire  _T_175 = io_mhpme_vec_0 == 10'h201; // @[dec_tlu_ctl.scala 2826:42]
  wire  _T_177 = io_mhpme_vec_0 == 10'h202; // @[dec_tlu_ctl.scala 2827:42]
  wire  _T_179 = io_mhpme_vec_0 == 10'h203; // @[dec_tlu_ctl.scala 2828:42]
  wire  _T_181 = io_mhpme_vec_0 == 10'h204; // @[dec_tlu_ctl.scala 2829:42]
  wire  _T_184 = _T_6 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_185 = _T_8 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_186 = _T_10 & _T_13; // @[Mux.scala 27:72]
  wire  _T_187 = _T_14 & _T_19; // @[Mux.scala 27:72]
  wire  _T_188 = _T_20 & _T_24; // @[Mux.scala 27:72]
  wire  _T_189 = _T_25 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_190 = _T_27 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_191 = _T_29 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_192 = _T_31 & _T_33; // @[Mux.scala 27:72]
  wire  _T_193 = _T_34 & _T_38; // @[Mux.scala 27:72]
  wire  _T_194 = _T_39 & _T_41; // @[Mux.scala 27:72]
  wire  _T_195 = _T_42 & _T_44; // @[Mux.scala 27:72]
  wire  _T_196 = _T_45 & _T_48; // @[Mux.scala 27:72]
  wire  _T_197 = _T_49 & _T_53; // @[Mux.scala 27:72]
  wire  _T_198 = _T_54 & _T_56; // @[Mux.scala 27:72]
  wire  _T_199 = _T_57 & _T_59; // @[Mux.scala 27:72]
  wire  _T_200 = _T_60 & _T_62; // @[Mux.scala 27:72]
  wire  _T_201 = _T_63 & _T_65; // @[Mux.scala 27:72]
  wire  _T_202 = _T_66 & _T_68; // @[Mux.scala 27:72]
  wire  _T_203 = _T_69 & _T_71; // @[Mux.scala 27:72]
  wire  _T_204 = _T_72 & _T_74; // @[Mux.scala 27:72]
  wire  _T_205 = _T_75 & _T_77; // @[Mux.scala 27:72]
  wire  _T_206 = _T_78 & _T_80; // @[Mux.scala 27:72]
  wire  _T_207 = _T_81 & _T_85; // @[Mux.scala 27:72]
  wire  _T_208 = _T_86 & _T_90; // @[Mux.scala 27:72]
  wire  _T_209 = _T_91 & _T_95; // @[Mux.scala 27:72]
  wire  _T_210 = _T_96 & _T_100; // @[Mux.scala 27:72]
  wire  _T_211 = _T_101 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_213 = _T_105 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_214 = _T_107 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_215 = _T_109 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_216 = _T_111 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_217 = _T_113 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_218 = _T_115 & _T_118; // @[Mux.scala 27:72]
  wire  _T_219 = _T_119 & _T_122; // @[Mux.scala 27:72]
  wire  _T_220 = _T_123 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_221 = _T_125 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_222 = _T_127 & _T_130; // @[Mux.scala 27:72]
  wire  _T_223 = _T_131 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_224 = _T_133 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_225 = _T_135 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_226 = _T_137 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_227 = _T_139 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_228 = _T_141 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_229 = _T_143 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_230 = _T_145 & _T_149; // @[Mux.scala 27:72]
  wire  _T_231 = _T_150 & _T_159; // @[Mux.scala 27:72]
  wire  _T_232 = _T_160 & _T_162; // @[Mux.scala 27:72]
  wire  _T_233 = _T_163 & _T_167; // @[Mux.scala 27:72]
  wire  _T_234 = _T_168 & _T_172; // @[Mux.scala 27:72]
  wire  _T_235 = _T_173 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_236 = _T_175 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_237 = _T_177 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_238 = _T_179 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_239 = _T_181 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_240 = _T_4 | _T_184; // @[Mux.scala 27:72]
  wire  _T_241 = _T_240 | _T_185; // @[Mux.scala 27:72]
  wire  _T_242 = _T_241 | _T_186; // @[Mux.scala 27:72]
  wire  _T_243 = _T_242 | _T_187; // @[Mux.scala 27:72]
  wire  _T_244 = _T_243 | _T_188; // @[Mux.scala 27:72]
  wire  _T_245 = _T_244 | _T_189; // @[Mux.scala 27:72]
  wire  _T_246 = _T_245 | _T_190; // @[Mux.scala 27:72]
  wire  _T_247 = _T_246 | _T_191; // @[Mux.scala 27:72]
  wire  _T_248 = _T_247 | _T_192; // @[Mux.scala 27:72]
  wire  _T_249 = _T_248 | _T_193; // @[Mux.scala 27:72]
  wire  _T_250 = _T_249 | _T_194; // @[Mux.scala 27:72]
  wire  _T_251 = _T_250 | _T_195; // @[Mux.scala 27:72]
  wire  _T_252 = _T_251 | _T_196; // @[Mux.scala 27:72]
  wire  _T_253 = _T_252 | _T_197; // @[Mux.scala 27:72]
  wire  _T_254 = _T_253 | _T_198; // @[Mux.scala 27:72]
  wire  _T_255 = _T_254 | _T_199; // @[Mux.scala 27:72]
  wire  _T_256 = _T_255 | _T_200; // @[Mux.scala 27:72]
  wire  _T_257 = _T_256 | _T_201; // @[Mux.scala 27:72]
  wire  _T_258 = _T_257 | _T_202; // @[Mux.scala 27:72]
  wire  _T_259 = _T_258 | _T_203; // @[Mux.scala 27:72]
  wire  _T_260 = _T_259 | _T_204; // @[Mux.scala 27:72]
  wire  _T_261 = _T_260 | _T_205; // @[Mux.scala 27:72]
  wire  _T_262 = _T_261 | _T_206; // @[Mux.scala 27:72]
  wire  _T_263 = _T_262 | _T_207; // @[Mux.scala 27:72]
  wire  _T_264 = _T_263 | _T_208; // @[Mux.scala 27:72]
  wire  _T_265 = _T_264 | _T_209; // @[Mux.scala 27:72]
  wire  _T_266 = _T_265 | _T_210; // @[Mux.scala 27:72]
  wire  _T_267 = _T_266 | _T_211; // @[Mux.scala 27:72]
  wire  _T_268 = _T_267 | _T_191; // @[Mux.scala 27:72]
  wire  _T_269 = _T_268 | _T_213; // @[Mux.scala 27:72]
  wire  _T_270 = _T_269 | _T_214; // @[Mux.scala 27:72]
  wire  _T_271 = _T_270 | _T_215; // @[Mux.scala 27:72]
  wire  _T_272 = _T_271 | _T_216; // @[Mux.scala 27:72]
  wire  _T_273 = _T_272 | _T_217; // @[Mux.scala 27:72]
  wire  _T_274 = _T_273 | _T_218; // @[Mux.scala 27:72]
  wire  _T_275 = _T_274 | _T_219; // @[Mux.scala 27:72]
  wire  _T_276 = _T_275 | _T_220; // @[Mux.scala 27:72]
  wire  _T_277 = _T_276 | _T_221; // @[Mux.scala 27:72]
  wire  _T_278 = _T_277 | _T_222; // @[Mux.scala 27:72]
  wire  _T_279 = _T_278 | _T_223; // @[Mux.scala 27:72]
  wire  _T_280 = _T_279 | _T_224; // @[Mux.scala 27:72]
  wire  _T_281 = _T_280 | _T_225; // @[Mux.scala 27:72]
  wire  _T_282 = _T_281 | _T_226; // @[Mux.scala 27:72]
  wire  _T_283 = _T_282 | _T_227; // @[Mux.scala 27:72]
  wire  _T_284 = _T_283 | _T_228; // @[Mux.scala 27:72]
  wire  _T_285 = _T_284 | _T_229; // @[Mux.scala 27:72]
  wire  _T_286 = _T_285 | _T_230; // @[Mux.scala 27:72]
  wire  _T_287 = _T_286 | _T_231; // @[Mux.scala 27:72]
  wire  _T_288 = _T_287 | _T_232; // @[Mux.scala 27:72]
  wire  _T_289 = _T_288 | _T_233; // @[Mux.scala 27:72]
  wire  _T_290 = _T_289 | _T_234; // @[Mux.scala 27:72]
  wire  _T_291 = _T_290 | _T_235; // @[Mux.scala 27:72]
  wire  _T_292 = _T_291 | _T_236; // @[Mux.scala 27:72]
  wire  _T_293 = _T_292 | _T_237; // @[Mux.scala 27:72]
  wire  _T_294 = _T_293 | _T_238; // @[Mux.scala 27:72]
  wire  _T_295 = _T_294 | _T_239; // @[Mux.scala 27:72]
  wire  _T_299 = ~io_mcountinhibit[4]; // @[dec_tlu_ctl.scala 2771:40]
  wire  _T_300 = io_mhpme_vec_1 == 10'h1; // @[dec_tlu_ctl.scala 2772:42]
  wire  _T_302 = io_mhpme_vec_1 == 10'h2; // @[dec_tlu_ctl.scala 2773:42]
  wire  _T_304 = io_mhpme_vec_1 == 10'h3; // @[dec_tlu_ctl.scala 2774:42]
  wire  _T_306 = io_mhpme_vec_1 == 10'h4; // @[dec_tlu_ctl.scala 2775:42]
  wire  _T_310 = io_mhpme_vec_1 == 10'h5; // @[dec_tlu_ctl.scala 2776:42]
  wire  _T_316 = io_mhpme_vec_1 == 10'h6; // @[dec_tlu_ctl.scala 2777:42]
  wire  _T_321 = io_mhpme_vec_1 == 10'h7; // @[dec_tlu_ctl.scala 2778:42]
  wire  _T_323 = io_mhpme_vec_1 == 10'h8; // @[dec_tlu_ctl.scala 2779:42]
  wire  _T_325 = io_mhpme_vec_1 == 10'h1e; // @[dec_tlu_ctl.scala 2780:42]
  wire  _T_327 = io_mhpme_vec_1 == 10'h9; // @[dec_tlu_ctl.scala 2781:42]
  wire  _T_330 = io_mhpme_vec_1 == 10'ha; // @[dec_tlu_ctl.scala 2782:42]
  wire  _T_335 = io_mhpme_vec_1 == 10'hb; // @[dec_tlu_ctl.scala 2783:42]
  wire  _T_338 = io_mhpme_vec_1 == 10'hc; // @[dec_tlu_ctl.scala 2784:42]
  wire  _T_341 = io_mhpme_vec_1 == 10'hd; // @[dec_tlu_ctl.scala 2785:42]
  wire  _T_345 = io_mhpme_vec_1 == 10'he; // @[dec_tlu_ctl.scala 2786:42]
  wire  _T_350 = io_mhpme_vec_1 == 10'hf; // @[dec_tlu_ctl.scala 2787:42]
  wire  _T_353 = io_mhpme_vec_1 == 10'h10; // @[dec_tlu_ctl.scala 2788:42]
  wire  _T_356 = io_mhpme_vec_1 == 10'h12; // @[dec_tlu_ctl.scala 2789:42]
  wire  _T_359 = io_mhpme_vec_1 == 10'h11; // @[dec_tlu_ctl.scala 2790:42]
  wire  _T_362 = io_mhpme_vec_1 == 10'h13; // @[dec_tlu_ctl.scala 2791:42]
  wire  _T_365 = io_mhpme_vec_1 == 10'h14; // @[dec_tlu_ctl.scala 2792:42]
  wire  _T_368 = io_mhpme_vec_1 == 10'h15; // @[dec_tlu_ctl.scala 2793:42]
  wire  _T_371 = io_mhpme_vec_1 == 10'h16; // @[dec_tlu_ctl.scala 2794:42]
  wire  _T_374 = io_mhpme_vec_1 == 10'h17; // @[dec_tlu_ctl.scala 2795:42]
  wire  _T_377 = io_mhpme_vec_1 == 10'h18; // @[dec_tlu_ctl.scala 2796:42]
  wire  _T_382 = io_mhpme_vec_1 == 10'h19; // @[dec_tlu_ctl.scala 2797:42]
  wire  _T_387 = io_mhpme_vec_1 == 10'h1a; // @[dec_tlu_ctl.scala 2798:42]
  wire  _T_392 = io_mhpme_vec_1 == 10'h1b; // @[dec_tlu_ctl.scala 2799:42]
  wire  _T_397 = io_mhpme_vec_1 == 10'h1c; // @[dec_tlu_ctl.scala 2800:42]
  wire  _T_401 = io_mhpme_vec_1 == 10'h1f; // @[dec_tlu_ctl.scala 2802:42]
  wire  _T_403 = io_mhpme_vec_1 == 10'h20; // @[dec_tlu_ctl.scala 2803:42]
  wire  _T_405 = io_mhpme_vec_1 == 10'h22; // @[dec_tlu_ctl.scala 2804:42]
  wire  _T_407 = io_mhpme_vec_1 == 10'h23; // @[dec_tlu_ctl.scala 2805:42]
  wire  _T_409 = io_mhpme_vec_1 == 10'h24; // @[dec_tlu_ctl.scala 2806:42]
  wire  _T_411 = io_mhpme_vec_1 == 10'h25; // @[dec_tlu_ctl.scala 2807:42]
  wire  _T_415 = io_mhpme_vec_1 == 10'h26; // @[dec_tlu_ctl.scala 2808:42]
  wire  _T_419 = io_mhpme_vec_1 == 10'h27; // @[dec_tlu_ctl.scala 2809:42]
  wire  _T_421 = io_mhpme_vec_1 == 10'h28; // @[dec_tlu_ctl.scala 2810:42]
  wire  _T_423 = io_mhpme_vec_1 == 10'h29; // @[dec_tlu_ctl.scala 2811:42]
  wire  _T_427 = io_mhpme_vec_1 == 10'h2a; // @[dec_tlu_ctl.scala 2812:42]
  wire  _T_429 = io_mhpme_vec_1 == 10'h2b; // @[dec_tlu_ctl.scala 2813:42]
  wire  _T_431 = io_mhpme_vec_1 == 10'h2c; // @[dec_tlu_ctl.scala 2814:42]
  wire  _T_433 = io_mhpme_vec_1 == 10'h2d; // @[dec_tlu_ctl.scala 2815:42]
  wire  _T_435 = io_mhpme_vec_1 == 10'h2e; // @[dec_tlu_ctl.scala 2816:42]
  wire  _T_437 = io_mhpme_vec_1 == 10'h2f; // @[dec_tlu_ctl.scala 2817:42]
  wire  _T_439 = io_mhpme_vec_1 == 10'h30; // @[dec_tlu_ctl.scala 2818:42]
  wire  _T_441 = io_mhpme_vec_1 == 10'h31; // @[dec_tlu_ctl.scala 2819:42]
  wire  _T_446 = io_mhpme_vec_1 == 10'h32; // @[dec_tlu_ctl.scala 2820:42]
  wire  _T_456 = io_mhpme_vec_1 == 10'h36; // @[dec_tlu_ctl.scala 2821:42]
  wire  _T_459 = io_mhpme_vec_1 == 10'h37; // @[dec_tlu_ctl.scala 2822:42]
  wire  _T_464 = io_mhpme_vec_1 == 10'h38; // @[dec_tlu_ctl.scala 2823:42]
  wire  _T_469 = io_mhpme_vec_1 == 10'h200; // @[dec_tlu_ctl.scala 2825:42]
  wire  _T_471 = io_mhpme_vec_1 == 10'h201; // @[dec_tlu_ctl.scala 2826:42]
  wire  _T_473 = io_mhpme_vec_1 == 10'h202; // @[dec_tlu_ctl.scala 2827:42]
  wire  _T_475 = io_mhpme_vec_1 == 10'h203; // @[dec_tlu_ctl.scala 2828:42]
  wire  _T_477 = io_mhpme_vec_1 == 10'h204; // @[dec_tlu_ctl.scala 2829:42]
  wire  _T_480 = _T_302 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_481 = _T_304 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_482 = _T_306 & _T_13; // @[Mux.scala 27:72]
  wire  _T_483 = _T_310 & _T_19; // @[Mux.scala 27:72]
  wire  _T_484 = _T_316 & _T_24; // @[Mux.scala 27:72]
  wire  _T_485 = _T_321 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_486 = _T_323 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_487 = _T_325 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_488 = _T_327 & _T_33; // @[Mux.scala 27:72]
  wire  _T_489 = _T_330 & _T_38; // @[Mux.scala 27:72]
  wire  _T_490 = _T_335 & _T_41; // @[Mux.scala 27:72]
  wire  _T_491 = _T_338 & _T_44; // @[Mux.scala 27:72]
  wire  _T_492 = _T_341 & _T_48; // @[Mux.scala 27:72]
  wire  _T_493 = _T_345 & _T_53; // @[Mux.scala 27:72]
  wire  _T_494 = _T_350 & _T_56; // @[Mux.scala 27:72]
  wire  _T_495 = _T_353 & _T_59; // @[Mux.scala 27:72]
  wire  _T_496 = _T_356 & _T_62; // @[Mux.scala 27:72]
  wire  _T_497 = _T_359 & _T_65; // @[Mux.scala 27:72]
  wire  _T_498 = _T_362 & _T_68; // @[Mux.scala 27:72]
  wire  _T_499 = _T_365 & _T_71; // @[Mux.scala 27:72]
  wire  _T_500 = _T_368 & _T_74; // @[Mux.scala 27:72]
  wire  _T_501 = _T_371 & _T_77; // @[Mux.scala 27:72]
  wire  _T_502 = _T_374 & _T_80; // @[Mux.scala 27:72]
  wire  _T_503 = _T_377 & _T_85; // @[Mux.scala 27:72]
  wire  _T_504 = _T_382 & _T_90; // @[Mux.scala 27:72]
  wire  _T_505 = _T_387 & _T_95; // @[Mux.scala 27:72]
  wire  _T_506 = _T_392 & _T_100; // @[Mux.scala 27:72]
  wire  _T_507 = _T_397 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_509 = _T_401 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_510 = _T_403 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_511 = _T_405 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_512 = _T_407 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_513 = _T_409 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_514 = _T_411 & _T_118; // @[Mux.scala 27:72]
  wire  _T_515 = _T_415 & _T_122; // @[Mux.scala 27:72]
  wire  _T_516 = _T_419 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_517 = _T_421 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_518 = _T_423 & _T_130; // @[Mux.scala 27:72]
  wire  _T_519 = _T_427 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_520 = _T_429 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_521 = _T_431 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_522 = _T_433 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_523 = _T_435 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_524 = _T_437 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_525 = _T_439 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_526 = _T_441 & _T_149; // @[Mux.scala 27:72]
  wire  _T_527 = _T_446 & _T_159; // @[Mux.scala 27:72]
  wire  _T_528 = _T_456 & _T_162; // @[Mux.scala 27:72]
  wire  _T_529 = _T_459 & _T_167; // @[Mux.scala 27:72]
  wire  _T_530 = _T_464 & _T_172; // @[Mux.scala 27:72]
  wire  _T_531 = _T_469 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_532 = _T_471 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_533 = _T_473 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_534 = _T_475 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_535 = _T_477 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_536 = _T_300 | _T_480; // @[Mux.scala 27:72]
  wire  _T_537 = _T_536 | _T_481; // @[Mux.scala 27:72]
  wire  _T_538 = _T_537 | _T_482; // @[Mux.scala 27:72]
  wire  _T_539 = _T_538 | _T_483; // @[Mux.scala 27:72]
  wire  _T_540 = _T_539 | _T_484; // @[Mux.scala 27:72]
  wire  _T_541 = _T_540 | _T_485; // @[Mux.scala 27:72]
  wire  _T_542 = _T_541 | _T_486; // @[Mux.scala 27:72]
  wire  _T_543 = _T_542 | _T_487; // @[Mux.scala 27:72]
  wire  _T_544 = _T_543 | _T_488; // @[Mux.scala 27:72]
  wire  _T_545 = _T_544 | _T_489; // @[Mux.scala 27:72]
  wire  _T_546 = _T_545 | _T_490; // @[Mux.scala 27:72]
  wire  _T_547 = _T_546 | _T_491; // @[Mux.scala 27:72]
  wire  _T_548 = _T_547 | _T_492; // @[Mux.scala 27:72]
  wire  _T_549 = _T_548 | _T_493; // @[Mux.scala 27:72]
  wire  _T_550 = _T_549 | _T_494; // @[Mux.scala 27:72]
  wire  _T_551 = _T_550 | _T_495; // @[Mux.scala 27:72]
  wire  _T_552 = _T_551 | _T_496; // @[Mux.scala 27:72]
  wire  _T_553 = _T_552 | _T_497; // @[Mux.scala 27:72]
  wire  _T_554 = _T_553 | _T_498; // @[Mux.scala 27:72]
  wire  _T_555 = _T_554 | _T_499; // @[Mux.scala 27:72]
  wire  _T_556 = _T_555 | _T_500; // @[Mux.scala 27:72]
  wire  _T_557 = _T_556 | _T_501; // @[Mux.scala 27:72]
  wire  _T_558 = _T_557 | _T_502; // @[Mux.scala 27:72]
  wire  _T_559 = _T_558 | _T_503; // @[Mux.scala 27:72]
  wire  _T_560 = _T_559 | _T_504; // @[Mux.scala 27:72]
  wire  _T_561 = _T_560 | _T_505; // @[Mux.scala 27:72]
  wire  _T_562 = _T_561 | _T_506; // @[Mux.scala 27:72]
  wire  _T_563 = _T_562 | _T_507; // @[Mux.scala 27:72]
  wire  _T_564 = _T_563 | _T_487; // @[Mux.scala 27:72]
  wire  _T_565 = _T_564 | _T_509; // @[Mux.scala 27:72]
  wire  _T_566 = _T_565 | _T_510; // @[Mux.scala 27:72]
  wire  _T_567 = _T_566 | _T_511; // @[Mux.scala 27:72]
  wire  _T_568 = _T_567 | _T_512; // @[Mux.scala 27:72]
  wire  _T_569 = _T_568 | _T_513; // @[Mux.scala 27:72]
  wire  _T_570 = _T_569 | _T_514; // @[Mux.scala 27:72]
  wire  _T_571 = _T_570 | _T_515; // @[Mux.scala 27:72]
  wire  _T_572 = _T_571 | _T_516; // @[Mux.scala 27:72]
  wire  _T_573 = _T_572 | _T_517; // @[Mux.scala 27:72]
  wire  _T_574 = _T_573 | _T_518; // @[Mux.scala 27:72]
  wire  _T_575 = _T_574 | _T_519; // @[Mux.scala 27:72]
  wire  _T_576 = _T_575 | _T_520; // @[Mux.scala 27:72]
  wire  _T_577 = _T_576 | _T_521; // @[Mux.scala 27:72]
  wire  _T_578 = _T_577 | _T_522; // @[Mux.scala 27:72]
  wire  _T_579 = _T_578 | _T_523; // @[Mux.scala 27:72]
  wire  _T_580 = _T_579 | _T_524; // @[Mux.scala 27:72]
  wire  _T_581 = _T_580 | _T_525; // @[Mux.scala 27:72]
  wire  _T_582 = _T_581 | _T_526; // @[Mux.scala 27:72]
  wire  _T_583 = _T_582 | _T_527; // @[Mux.scala 27:72]
  wire  _T_584 = _T_583 | _T_528; // @[Mux.scala 27:72]
  wire  _T_585 = _T_584 | _T_529; // @[Mux.scala 27:72]
  wire  _T_586 = _T_585 | _T_530; // @[Mux.scala 27:72]
  wire  _T_587 = _T_586 | _T_531; // @[Mux.scala 27:72]
  wire  _T_588 = _T_587 | _T_532; // @[Mux.scala 27:72]
  wire  _T_589 = _T_588 | _T_533; // @[Mux.scala 27:72]
  wire  _T_590 = _T_589 | _T_534; // @[Mux.scala 27:72]
  wire  _T_591 = _T_590 | _T_535; // @[Mux.scala 27:72]
  wire  _T_595 = ~io_mcountinhibit[5]; // @[dec_tlu_ctl.scala 2771:40]
  wire  _T_596 = io_mhpme_vec_2 == 10'h1; // @[dec_tlu_ctl.scala 2772:42]
  wire  _T_598 = io_mhpme_vec_2 == 10'h2; // @[dec_tlu_ctl.scala 2773:42]
  wire  _T_600 = io_mhpme_vec_2 == 10'h3; // @[dec_tlu_ctl.scala 2774:42]
  wire  _T_602 = io_mhpme_vec_2 == 10'h4; // @[dec_tlu_ctl.scala 2775:42]
  wire  _T_606 = io_mhpme_vec_2 == 10'h5; // @[dec_tlu_ctl.scala 2776:42]
  wire  _T_612 = io_mhpme_vec_2 == 10'h6; // @[dec_tlu_ctl.scala 2777:42]
  wire  _T_617 = io_mhpme_vec_2 == 10'h7; // @[dec_tlu_ctl.scala 2778:42]
  wire  _T_619 = io_mhpme_vec_2 == 10'h8; // @[dec_tlu_ctl.scala 2779:42]
  wire  _T_621 = io_mhpme_vec_2 == 10'h1e; // @[dec_tlu_ctl.scala 2780:42]
  wire  _T_623 = io_mhpme_vec_2 == 10'h9; // @[dec_tlu_ctl.scala 2781:42]
  wire  _T_626 = io_mhpme_vec_2 == 10'ha; // @[dec_tlu_ctl.scala 2782:42]
  wire  _T_631 = io_mhpme_vec_2 == 10'hb; // @[dec_tlu_ctl.scala 2783:42]
  wire  _T_634 = io_mhpme_vec_2 == 10'hc; // @[dec_tlu_ctl.scala 2784:42]
  wire  _T_637 = io_mhpme_vec_2 == 10'hd; // @[dec_tlu_ctl.scala 2785:42]
  wire  _T_641 = io_mhpme_vec_2 == 10'he; // @[dec_tlu_ctl.scala 2786:42]
  wire  _T_646 = io_mhpme_vec_2 == 10'hf; // @[dec_tlu_ctl.scala 2787:42]
  wire  _T_649 = io_mhpme_vec_2 == 10'h10; // @[dec_tlu_ctl.scala 2788:42]
  wire  _T_652 = io_mhpme_vec_2 == 10'h12; // @[dec_tlu_ctl.scala 2789:42]
  wire  _T_655 = io_mhpme_vec_2 == 10'h11; // @[dec_tlu_ctl.scala 2790:42]
  wire  _T_658 = io_mhpme_vec_2 == 10'h13; // @[dec_tlu_ctl.scala 2791:42]
  wire  _T_661 = io_mhpme_vec_2 == 10'h14; // @[dec_tlu_ctl.scala 2792:42]
  wire  _T_664 = io_mhpme_vec_2 == 10'h15; // @[dec_tlu_ctl.scala 2793:42]
  wire  _T_667 = io_mhpme_vec_2 == 10'h16; // @[dec_tlu_ctl.scala 2794:42]
  wire  _T_670 = io_mhpme_vec_2 == 10'h17; // @[dec_tlu_ctl.scala 2795:42]
  wire  _T_673 = io_mhpme_vec_2 == 10'h18; // @[dec_tlu_ctl.scala 2796:42]
  wire  _T_678 = io_mhpme_vec_2 == 10'h19; // @[dec_tlu_ctl.scala 2797:42]
  wire  _T_683 = io_mhpme_vec_2 == 10'h1a; // @[dec_tlu_ctl.scala 2798:42]
  wire  _T_688 = io_mhpme_vec_2 == 10'h1b; // @[dec_tlu_ctl.scala 2799:42]
  wire  _T_693 = io_mhpme_vec_2 == 10'h1c; // @[dec_tlu_ctl.scala 2800:42]
  wire  _T_697 = io_mhpme_vec_2 == 10'h1f; // @[dec_tlu_ctl.scala 2802:42]
  wire  _T_699 = io_mhpme_vec_2 == 10'h20; // @[dec_tlu_ctl.scala 2803:42]
  wire  _T_701 = io_mhpme_vec_2 == 10'h22; // @[dec_tlu_ctl.scala 2804:42]
  wire  _T_703 = io_mhpme_vec_2 == 10'h23; // @[dec_tlu_ctl.scala 2805:42]
  wire  _T_705 = io_mhpme_vec_2 == 10'h24; // @[dec_tlu_ctl.scala 2806:42]
  wire  _T_707 = io_mhpme_vec_2 == 10'h25; // @[dec_tlu_ctl.scala 2807:42]
  wire  _T_711 = io_mhpme_vec_2 == 10'h26; // @[dec_tlu_ctl.scala 2808:42]
  wire  _T_715 = io_mhpme_vec_2 == 10'h27; // @[dec_tlu_ctl.scala 2809:42]
  wire  _T_717 = io_mhpme_vec_2 == 10'h28; // @[dec_tlu_ctl.scala 2810:42]
  wire  _T_719 = io_mhpme_vec_2 == 10'h29; // @[dec_tlu_ctl.scala 2811:42]
  wire  _T_723 = io_mhpme_vec_2 == 10'h2a; // @[dec_tlu_ctl.scala 2812:42]
  wire  _T_725 = io_mhpme_vec_2 == 10'h2b; // @[dec_tlu_ctl.scala 2813:42]
  wire  _T_727 = io_mhpme_vec_2 == 10'h2c; // @[dec_tlu_ctl.scala 2814:42]
  wire  _T_729 = io_mhpme_vec_2 == 10'h2d; // @[dec_tlu_ctl.scala 2815:42]
  wire  _T_731 = io_mhpme_vec_2 == 10'h2e; // @[dec_tlu_ctl.scala 2816:42]
  wire  _T_733 = io_mhpme_vec_2 == 10'h2f; // @[dec_tlu_ctl.scala 2817:42]
  wire  _T_735 = io_mhpme_vec_2 == 10'h30; // @[dec_tlu_ctl.scala 2818:42]
  wire  _T_737 = io_mhpme_vec_2 == 10'h31; // @[dec_tlu_ctl.scala 2819:42]
  wire  _T_742 = io_mhpme_vec_2 == 10'h32; // @[dec_tlu_ctl.scala 2820:42]
  wire  _T_752 = io_mhpme_vec_2 == 10'h36; // @[dec_tlu_ctl.scala 2821:42]
  wire  _T_755 = io_mhpme_vec_2 == 10'h37; // @[dec_tlu_ctl.scala 2822:42]
  wire  _T_760 = io_mhpme_vec_2 == 10'h38; // @[dec_tlu_ctl.scala 2823:42]
  wire  _T_765 = io_mhpme_vec_2 == 10'h200; // @[dec_tlu_ctl.scala 2825:42]
  wire  _T_767 = io_mhpme_vec_2 == 10'h201; // @[dec_tlu_ctl.scala 2826:42]
  wire  _T_769 = io_mhpme_vec_2 == 10'h202; // @[dec_tlu_ctl.scala 2827:42]
  wire  _T_771 = io_mhpme_vec_2 == 10'h203; // @[dec_tlu_ctl.scala 2828:42]
  wire  _T_773 = io_mhpme_vec_2 == 10'h204; // @[dec_tlu_ctl.scala 2829:42]
  wire  _T_776 = _T_598 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_777 = _T_600 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_778 = _T_602 & _T_13; // @[Mux.scala 27:72]
  wire  _T_779 = _T_606 & _T_19; // @[Mux.scala 27:72]
  wire  _T_780 = _T_612 & _T_24; // @[Mux.scala 27:72]
  wire  _T_781 = _T_617 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_782 = _T_619 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_783 = _T_621 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_784 = _T_623 & _T_33; // @[Mux.scala 27:72]
  wire  _T_785 = _T_626 & _T_38; // @[Mux.scala 27:72]
  wire  _T_786 = _T_631 & _T_41; // @[Mux.scala 27:72]
  wire  _T_787 = _T_634 & _T_44; // @[Mux.scala 27:72]
  wire  _T_788 = _T_637 & _T_48; // @[Mux.scala 27:72]
  wire  _T_789 = _T_641 & _T_53; // @[Mux.scala 27:72]
  wire  _T_790 = _T_646 & _T_56; // @[Mux.scala 27:72]
  wire  _T_791 = _T_649 & _T_59; // @[Mux.scala 27:72]
  wire  _T_792 = _T_652 & _T_62; // @[Mux.scala 27:72]
  wire  _T_793 = _T_655 & _T_65; // @[Mux.scala 27:72]
  wire  _T_794 = _T_658 & _T_68; // @[Mux.scala 27:72]
  wire  _T_795 = _T_661 & _T_71; // @[Mux.scala 27:72]
  wire  _T_796 = _T_664 & _T_74; // @[Mux.scala 27:72]
  wire  _T_797 = _T_667 & _T_77; // @[Mux.scala 27:72]
  wire  _T_798 = _T_670 & _T_80; // @[Mux.scala 27:72]
  wire  _T_799 = _T_673 & _T_85; // @[Mux.scala 27:72]
  wire  _T_800 = _T_678 & _T_90; // @[Mux.scala 27:72]
  wire  _T_801 = _T_683 & _T_95; // @[Mux.scala 27:72]
  wire  _T_802 = _T_688 & _T_100; // @[Mux.scala 27:72]
  wire  _T_803 = _T_693 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_805 = _T_697 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_806 = _T_699 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_807 = _T_701 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_808 = _T_703 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_809 = _T_705 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_810 = _T_707 & _T_118; // @[Mux.scala 27:72]
  wire  _T_811 = _T_711 & _T_122; // @[Mux.scala 27:72]
  wire  _T_812 = _T_715 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_813 = _T_717 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_814 = _T_719 & _T_130; // @[Mux.scala 27:72]
  wire  _T_815 = _T_723 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_816 = _T_725 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_817 = _T_727 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_818 = _T_729 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_819 = _T_731 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_820 = _T_733 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_821 = _T_735 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_822 = _T_737 & _T_149; // @[Mux.scala 27:72]
  wire  _T_823 = _T_742 & _T_159; // @[Mux.scala 27:72]
  wire  _T_824 = _T_752 & _T_162; // @[Mux.scala 27:72]
  wire  _T_825 = _T_755 & _T_167; // @[Mux.scala 27:72]
  wire  _T_826 = _T_760 & _T_172; // @[Mux.scala 27:72]
  wire  _T_827 = _T_765 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_828 = _T_767 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_829 = _T_769 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_830 = _T_771 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_831 = _T_773 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_832 = _T_596 | _T_776; // @[Mux.scala 27:72]
  wire  _T_833 = _T_832 | _T_777; // @[Mux.scala 27:72]
  wire  _T_834 = _T_833 | _T_778; // @[Mux.scala 27:72]
  wire  _T_835 = _T_834 | _T_779; // @[Mux.scala 27:72]
  wire  _T_836 = _T_835 | _T_780; // @[Mux.scala 27:72]
  wire  _T_837 = _T_836 | _T_781; // @[Mux.scala 27:72]
  wire  _T_838 = _T_837 | _T_782; // @[Mux.scala 27:72]
  wire  _T_839 = _T_838 | _T_783; // @[Mux.scala 27:72]
  wire  _T_840 = _T_839 | _T_784; // @[Mux.scala 27:72]
  wire  _T_841 = _T_840 | _T_785; // @[Mux.scala 27:72]
  wire  _T_842 = _T_841 | _T_786; // @[Mux.scala 27:72]
  wire  _T_843 = _T_842 | _T_787; // @[Mux.scala 27:72]
  wire  _T_844 = _T_843 | _T_788; // @[Mux.scala 27:72]
  wire  _T_845 = _T_844 | _T_789; // @[Mux.scala 27:72]
  wire  _T_846 = _T_845 | _T_790; // @[Mux.scala 27:72]
  wire  _T_847 = _T_846 | _T_791; // @[Mux.scala 27:72]
  wire  _T_848 = _T_847 | _T_792; // @[Mux.scala 27:72]
  wire  _T_849 = _T_848 | _T_793; // @[Mux.scala 27:72]
  wire  _T_850 = _T_849 | _T_794; // @[Mux.scala 27:72]
  wire  _T_851 = _T_850 | _T_795; // @[Mux.scala 27:72]
  wire  _T_852 = _T_851 | _T_796; // @[Mux.scala 27:72]
  wire  _T_853 = _T_852 | _T_797; // @[Mux.scala 27:72]
  wire  _T_854 = _T_853 | _T_798; // @[Mux.scala 27:72]
  wire  _T_855 = _T_854 | _T_799; // @[Mux.scala 27:72]
  wire  _T_856 = _T_855 | _T_800; // @[Mux.scala 27:72]
  wire  _T_857 = _T_856 | _T_801; // @[Mux.scala 27:72]
  wire  _T_858 = _T_857 | _T_802; // @[Mux.scala 27:72]
  wire  _T_859 = _T_858 | _T_803; // @[Mux.scala 27:72]
  wire  _T_860 = _T_859 | _T_783; // @[Mux.scala 27:72]
  wire  _T_861 = _T_860 | _T_805; // @[Mux.scala 27:72]
  wire  _T_862 = _T_861 | _T_806; // @[Mux.scala 27:72]
  wire  _T_863 = _T_862 | _T_807; // @[Mux.scala 27:72]
  wire  _T_864 = _T_863 | _T_808; // @[Mux.scala 27:72]
  wire  _T_865 = _T_864 | _T_809; // @[Mux.scala 27:72]
  wire  _T_866 = _T_865 | _T_810; // @[Mux.scala 27:72]
  wire  _T_867 = _T_866 | _T_811; // @[Mux.scala 27:72]
  wire  _T_868 = _T_867 | _T_812; // @[Mux.scala 27:72]
  wire  _T_869 = _T_868 | _T_813; // @[Mux.scala 27:72]
  wire  _T_870 = _T_869 | _T_814; // @[Mux.scala 27:72]
  wire  _T_871 = _T_870 | _T_815; // @[Mux.scala 27:72]
  wire  _T_872 = _T_871 | _T_816; // @[Mux.scala 27:72]
  wire  _T_873 = _T_872 | _T_817; // @[Mux.scala 27:72]
  wire  _T_874 = _T_873 | _T_818; // @[Mux.scala 27:72]
  wire  _T_875 = _T_874 | _T_819; // @[Mux.scala 27:72]
  wire  _T_876 = _T_875 | _T_820; // @[Mux.scala 27:72]
  wire  _T_877 = _T_876 | _T_821; // @[Mux.scala 27:72]
  wire  _T_878 = _T_877 | _T_822; // @[Mux.scala 27:72]
  wire  _T_879 = _T_878 | _T_823; // @[Mux.scala 27:72]
  wire  _T_880 = _T_879 | _T_824; // @[Mux.scala 27:72]
  wire  _T_881 = _T_880 | _T_825; // @[Mux.scala 27:72]
  wire  _T_882 = _T_881 | _T_826; // @[Mux.scala 27:72]
  wire  _T_883 = _T_882 | _T_827; // @[Mux.scala 27:72]
  wire  _T_884 = _T_883 | _T_828; // @[Mux.scala 27:72]
  wire  _T_885 = _T_884 | _T_829; // @[Mux.scala 27:72]
  wire  _T_886 = _T_885 | _T_830; // @[Mux.scala 27:72]
  wire  _T_887 = _T_886 | _T_831; // @[Mux.scala 27:72]
  wire  _T_891 = ~io_mcountinhibit[6]; // @[dec_tlu_ctl.scala 2771:40]
  wire  _T_892 = io_mhpme_vec_3 == 10'h1; // @[dec_tlu_ctl.scala 2772:42]
  wire  _T_894 = io_mhpme_vec_3 == 10'h2; // @[dec_tlu_ctl.scala 2773:42]
  wire  _T_896 = io_mhpme_vec_3 == 10'h3; // @[dec_tlu_ctl.scala 2774:42]
  wire  _T_898 = io_mhpme_vec_3 == 10'h4; // @[dec_tlu_ctl.scala 2775:42]
  wire  _T_902 = io_mhpme_vec_3 == 10'h5; // @[dec_tlu_ctl.scala 2776:42]
  wire  _T_908 = io_mhpme_vec_3 == 10'h6; // @[dec_tlu_ctl.scala 2777:42]
  wire  _T_913 = io_mhpme_vec_3 == 10'h7; // @[dec_tlu_ctl.scala 2778:42]
  wire  _T_915 = io_mhpme_vec_3 == 10'h8; // @[dec_tlu_ctl.scala 2779:42]
  wire  _T_917 = io_mhpme_vec_3 == 10'h1e; // @[dec_tlu_ctl.scala 2780:42]
  wire  _T_919 = io_mhpme_vec_3 == 10'h9; // @[dec_tlu_ctl.scala 2781:42]
  wire  _T_922 = io_mhpme_vec_3 == 10'ha; // @[dec_tlu_ctl.scala 2782:42]
  wire  _T_927 = io_mhpme_vec_3 == 10'hb; // @[dec_tlu_ctl.scala 2783:42]
  wire  _T_930 = io_mhpme_vec_3 == 10'hc; // @[dec_tlu_ctl.scala 2784:42]
  wire  _T_933 = io_mhpme_vec_3 == 10'hd; // @[dec_tlu_ctl.scala 2785:42]
  wire  _T_937 = io_mhpme_vec_3 == 10'he; // @[dec_tlu_ctl.scala 2786:42]
  wire  _T_942 = io_mhpme_vec_3 == 10'hf; // @[dec_tlu_ctl.scala 2787:42]
  wire  _T_945 = io_mhpme_vec_3 == 10'h10; // @[dec_tlu_ctl.scala 2788:42]
  wire  _T_948 = io_mhpme_vec_3 == 10'h12; // @[dec_tlu_ctl.scala 2789:42]
  wire  _T_951 = io_mhpme_vec_3 == 10'h11; // @[dec_tlu_ctl.scala 2790:42]
  wire  _T_954 = io_mhpme_vec_3 == 10'h13; // @[dec_tlu_ctl.scala 2791:42]
  wire  _T_957 = io_mhpme_vec_3 == 10'h14; // @[dec_tlu_ctl.scala 2792:42]
  wire  _T_960 = io_mhpme_vec_3 == 10'h15; // @[dec_tlu_ctl.scala 2793:42]
  wire  _T_963 = io_mhpme_vec_3 == 10'h16; // @[dec_tlu_ctl.scala 2794:42]
  wire  _T_966 = io_mhpme_vec_3 == 10'h17; // @[dec_tlu_ctl.scala 2795:42]
  wire  _T_969 = io_mhpme_vec_3 == 10'h18; // @[dec_tlu_ctl.scala 2796:42]
  wire  _T_974 = io_mhpme_vec_3 == 10'h19; // @[dec_tlu_ctl.scala 2797:42]
  wire  _T_979 = io_mhpme_vec_3 == 10'h1a; // @[dec_tlu_ctl.scala 2798:42]
  wire  _T_984 = io_mhpme_vec_3 == 10'h1b; // @[dec_tlu_ctl.scala 2799:42]
  wire  _T_989 = io_mhpme_vec_3 == 10'h1c; // @[dec_tlu_ctl.scala 2800:42]
  wire  _T_993 = io_mhpme_vec_3 == 10'h1f; // @[dec_tlu_ctl.scala 2802:42]
  wire  _T_995 = io_mhpme_vec_3 == 10'h20; // @[dec_tlu_ctl.scala 2803:42]
  wire  _T_997 = io_mhpme_vec_3 == 10'h22; // @[dec_tlu_ctl.scala 2804:42]
  wire  _T_999 = io_mhpme_vec_3 == 10'h23; // @[dec_tlu_ctl.scala 2805:42]
  wire  _T_1001 = io_mhpme_vec_3 == 10'h24; // @[dec_tlu_ctl.scala 2806:42]
  wire  _T_1003 = io_mhpme_vec_3 == 10'h25; // @[dec_tlu_ctl.scala 2807:42]
  wire  _T_1007 = io_mhpme_vec_3 == 10'h26; // @[dec_tlu_ctl.scala 2808:42]
  wire  _T_1011 = io_mhpme_vec_3 == 10'h27; // @[dec_tlu_ctl.scala 2809:42]
  wire  _T_1013 = io_mhpme_vec_3 == 10'h28; // @[dec_tlu_ctl.scala 2810:42]
  wire  _T_1015 = io_mhpme_vec_3 == 10'h29; // @[dec_tlu_ctl.scala 2811:42]
  wire  _T_1019 = io_mhpme_vec_3 == 10'h2a; // @[dec_tlu_ctl.scala 2812:42]
  wire  _T_1021 = io_mhpme_vec_3 == 10'h2b; // @[dec_tlu_ctl.scala 2813:42]
  wire  _T_1023 = io_mhpme_vec_3 == 10'h2c; // @[dec_tlu_ctl.scala 2814:42]
  wire  _T_1025 = io_mhpme_vec_3 == 10'h2d; // @[dec_tlu_ctl.scala 2815:42]
  wire  _T_1027 = io_mhpme_vec_3 == 10'h2e; // @[dec_tlu_ctl.scala 2816:42]
  wire  _T_1029 = io_mhpme_vec_3 == 10'h2f; // @[dec_tlu_ctl.scala 2817:42]
  wire  _T_1031 = io_mhpme_vec_3 == 10'h30; // @[dec_tlu_ctl.scala 2818:42]
  wire  _T_1033 = io_mhpme_vec_3 == 10'h31; // @[dec_tlu_ctl.scala 2819:42]
  wire  _T_1038 = io_mhpme_vec_3 == 10'h32; // @[dec_tlu_ctl.scala 2820:42]
  wire  _T_1048 = io_mhpme_vec_3 == 10'h36; // @[dec_tlu_ctl.scala 2821:42]
  wire  _T_1051 = io_mhpme_vec_3 == 10'h37; // @[dec_tlu_ctl.scala 2822:42]
  wire  _T_1056 = io_mhpme_vec_3 == 10'h38; // @[dec_tlu_ctl.scala 2823:42]
  wire  _T_1061 = io_mhpme_vec_3 == 10'h200; // @[dec_tlu_ctl.scala 2825:42]
  wire  _T_1063 = io_mhpme_vec_3 == 10'h201; // @[dec_tlu_ctl.scala 2826:42]
  wire  _T_1065 = io_mhpme_vec_3 == 10'h202; // @[dec_tlu_ctl.scala 2827:42]
  wire  _T_1067 = io_mhpme_vec_3 == 10'h203; // @[dec_tlu_ctl.scala 2828:42]
  wire  _T_1069 = io_mhpme_vec_3 == 10'h204; // @[dec_tlu_ctl.scala 2829:42]
  wire  _T_1072 = _T_894 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1073 = _T_896 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1074 = _T_898 & _T_13; // @[Mux.scala 27:72]
  wire  _T_1075 = _T_902 & _T_19; // @[Mux.scala 27:72]
  wire  _T_1076 = _T_908 & _T_24; // @[Mux.scala 27:72]
  wire  _T_1077 = _T_913 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1078 = _T_915 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1079 = _T_917 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1080 = _T_919 & _T_33; // @[Mux.scala 27:72]
  wire  _T_1081 = _T_922 & _T_38; // @[Mux.scala 27:72]
  wire  _T_1082 = _T_927 & _T_41; // @[Mux.scala 27:72]
  wire  _T_1083 = _T_930 & _T_44; // @[Mux.scala 27:72]
  wire  _T_1084 = _T_933 & _T_48; // @[Mux.scala 27:72]
  wire  _T_1085 = _T_937 & _T_53; // @[Mux.scala 27:72]
  wire  _T_1086 = _T_942 & _T_56; // @[Mux.scala 27:72]
  wire  _T_1087 = _T_945 & _T_59; // @[Mux.scala 27:72]
  wire  _T_1088 = _T_948 & _T_62; // @[Mux.scala 27:72]
  wire  _T_1089 = _T_951 & _T_65; // @[Mux.scala 27:72]
  wire  _T_1090 = _T_954 & _T_68; // @[Mux.scala 27:72]
  wire  _T_1091 = _T_957 & _T_71; // @[Mux.scala 27:72]
  wire  _T_1092 = _T_960 & _T_74; // @[Mux.scala 27:72]
  wire  _T_1093 = _T_963 & _T_77; // @[Mux.scala 27:72]
  wire  _T_1094 = _T_966 & _T_80; // @[Mux.scala 27:72]
  wire  _T_1095 = _T_969 & _T_85; // @[Mux.scala 27:72]
  wire  _T_1096 = _T_974 & _T_90; // @[Mux.scala 27:72]
  wire  _T_1097 = _T_979 & _T_95; // @[Mux.scala 27:72]
  wire  _T_1098 = _T_984 & _T_100; // @[Mux.scala 27:72]
  wire  _T_1099 = _T_989 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1101 = _T_993 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1102 = _T_995 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1103 = _T_997 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1104 = _T_999 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1105 = _T_1001 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1106 = _T_1003 & _T_118; // @[Mux.scala 27:72]
  wire  _T_1107 = _T_1007 & _T_122; // @[Mux.scala 27:72]
  wire  _T_1108 = _T_1011 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1109 = _T_1013 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1110 = _T_1015 & _T_130; // @[Mux.scala 27:72]
  wire  _T_1111 = _T_1019 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1112 = _T_1021 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1113 = _T_1023 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1114 = _T_1025 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1115 = _T_1027 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1116 = _T_1029 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1117 = _T_1031 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1118 = _T_1033 & _T_149; // @[Mux.scala 27:72]
  wire  _T_1119 = _T_1038 & _T_159; // @[Mux.scala 27:72]
  wire  _T_1120 = _T_1048 & _T_162; // @[Mux.scala 27:72]
  wire  _T_1121 = _T_1051 & _T_167; // @[Mux.scala 27:72]
  wire  _T_1122 = _T_1056 & _T_172; // @[Mux.scala 27:72]
  wire  _T_1123 = _T_1061 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1124 = _T_1063 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1125 = _T_1065 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1126 = _T_1067 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1127 = _T_1069 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1128 = _T_892 | _T_1072; // @[Mux.scala 27:72]
  wire  _T_1129 = _T_1128 | _T_1073; // @[Mux.scala 27:72]
  wire  _T_1130 = _T_1129 | _T_1074; // @[Mux.scala 27:72]
  wire  _T_1131 = _T_1130 | _T_1075; // @[Mux.scala 27:72]
  wire  _T_1132 = _T_1131 | _T_1076; // @[Mux.scala 27:72]
  wire  _T_1133 = _T_1132 | _T_1077; // @[Mux.scala 27:72]
  wire  _T_1134 = _T_1133 | _T_1078; // @[Mux.scala 27:72]
  wire  _T_1135 = _T_1134 | _T_1079; // @[Mux.scala 27:72]
  wire  _T_1136 = _T_1135 | _T_1080; // @[Mux.scala 27:72]
  wire  _T_1137 = _T_1136 | _T_1081; // @[Mux.scala 27:72]
  wire  _T_1138 = _T_1137 | _T_1082; // @[Mux.scala 27:72]
  wire  _T_1139 = _T_1138 | _T_1083; // @[Mux.scala 27:72]
  wire  _T_1140 = _T_1139 | _T_1084; // @[Mux.scala 27:72]
  wire  _T_1141 = _T_1140 | _T_1085; // @[Mux.scala 27:72]
  wire  _T_1142 = _T_1141 | _T_1086; // @[Mux.scala 27:72]
  wire  _T_1143 = _T_1142 | _T_1087; // @[Mux.scala 27:72]
  wire  _T_1144 = _T_1143 | _T_1088; // @[Mux.scala 27:72]
  wire  _T_1145 = _T_1144 | _T_1089; // @[Mux.scala 27:72]
  wire  _T_1146 = _T_1145 | _T_1090; // @[Mux.scala 27:72]
  wire  _T_1147 = _T_1146 | _T_1091; // @[Mux.scala 27:72]
  wire  _T_1148 = _T_1147 | _T_1092; // @[Mux.scala 27:72]
  wire  _T_1149 = _T_1148 | _T_1093; // @[Mux.scala 27:72]
  wire  _T_1150 = _T_1149 | _T_1094; // @[Mux.scala 27:72]
  wire  _T_1151 = _T_1150 | _T_1095; // @[Mux.scala 27:72]
  wire  _T_1152 = _T_1151 | _T_1096; // @[Mux.scala 27:72]
  wire  _T_1153 = _T_1152 | _T_1097; // @[Mux.scala 27:72]
  wire  _T_1154 = _T_1153 | _T_1098; // @[Mux.scala 27:72]
  wire  _T_1155 = _T_1154 | _T_1099; // @[Mux.scala 27:72]
  wire  _T_1156 = _T_1155 | _T_1079; // @[Mux.scala 27:72]
  wire  _T_1157 = _T_1156 | _T_1101; // @[Mux.scala 27:72]
  wire  _T_1158 = _T_1157 | _T_1102; // @[Mux.scala 27:72]
  wire  _T_1159 = _T_1158 | _T_1103; // @[Mux.scala 27:72]
  wire  _T_1160 = _T_1159 | _T_1104; // @[Mux.scala 27:72]
  wire  _T_1161 = _T_1160 | _T_1105; // @[Mux.scala 27:72]
  wire  _T_1162 = _T_1161 | _T_1106; // @[Mux.scala 27:72]
  wire  _T_1163 = _T_1162 | _T_1107; // @[Mux.scala 27:72]
  wire  _T_1164 = _T_1163 | _T_1108; // @[Mux.scala 27:72]
  wire  _T_1165 = _T_1164 | _T_1109; // @[Mux.scala 27:72]
  wire  _T_1166 = _T_1165 | _T_1110; // @[Mux.scala 27:72]
  wire  _T_1167 = _T_1166 | _T_1111; // @[Mux.scala 27:72]
  wire  _T_1168 = _T_1167 | _T_1112; // @[Mux.scala 27:72]
  wire  _T_1169 = _T_1168 | _T_1113; // @[Mux.scala 27:72]
  wire  _T_1170 = _T_1169 | _T_1114; // @[Mux.scala 27:72]
  wire  _T_1171 = _T_1170 | _T_1115; // @[Mux.scala 27:72]
  wire  _T_1172 = _T_1171 | _T_1116; // @[Mux.scala 27:72]
  wire  _T_1173 = _T_1172 | _T_1117; // @[Mux.scala 27:72]
  wire  _T_1174 = _T_1173 | _T_1118; // @[Mux.scala 27:72]
  wire  _T_1175 = _T_1174 | _T_1119; // @[Mux.scala 27:72]
  wire  _T_1176 = _T_1175 | _T_1120; // @[Mux.scala 27:72]
  wire  _T_1177 = _T_1176 | _T_1121; // @[Mux.scala 27:72]
  wire  _T_1178 = _T_1177 | _T_1122; // @[Mux.scala 27:72]
  wire  _T_1179 = _T_1178 | _T_1123; // @[Mux.scala 27:72]
  wire  _T_1180 = _T_1179 | _T_1124; // @[Mux.scala 27:72]
  wire  _T_1181 = _T_1180 | _T_1125; // @[Mux.scala 27:72]
  wire  _T_1182 = _T_1181 | _T_1126; // @[Mux.scala 27:72]
  wire  _T_1183 = _T_1182 | _T_1127; // @[Mux.scala 27:72]
  reg  _T_1190; // @[Reg.scala 27:20]
  wire  _T_1188 = io_mdseac_locked_ns ^ _T_1190; // @[lib.scala 463:21]
  wire  _T_1189 = |_T_1188; // @[lib.scala 463:29]
  reg  _T_1195; // @[Reg.scala 27:20]
  wire  _T_1193 = io_lsu_single_ecc_error_r ^ _T_1195; // @[lib.scala 463:21]
  wire  _T_1194 = |_T_1193; // @[lib.scala 463:29]
  reg  _T_1205; // @[Reg.scala 27:20]
  wire  _T_1203 = io_lsu_i0_exc_r ^ _T_1205; // @[lib.scala 463:21]
  wire  _T_1204 = |_T_1203; // @[lib.scala 463:29]
  reg  _T_1210; // @[Reg.scala 27:20]
  wire  _T_1208 = io_take_ext_int_start ^ _T_1210; // @[lib.scala 463:21]
  wire  _T_1209 = |_T_1208; // @[lib.scala 463:29]
  reg  _T_1215; // @[Reg.scala 27:20]
  wire  _T_1213 = io_take_ext_int_start_d1 ^ _T_1215; // @[lib.scala 463:21]
  wire  _T_1214 = |_T_1213; // @[lib.scala 463:29]
  reg  _T_1220; // @[Reg.scala 27:20]
  wire  _T_1218 = io_take_ext_int_start_d2 ^ _T_1220; // @[lib.scala 463:21]
  wire  _T_1219 = |_T_1218; // @[lib.scala 463:29]
  reg  _T_1225; // @[Reg.scala 27:20]
  wire  _T_1223 = io_ext_int_freeze ^ _T_1225; // @[lib.scala 463:21]
  wire  _T_1224 = |_T_1223; // @[lib.scala 463:29]
  reg [5:0] _T_1230; // @[Reg.scala 27:20]
  wire [5:0] _T_1228 = io_mip_ns ^ _T_1230; // @[lib.scala 441:21]
  wire  _T_1229 = |_T_1228; // @[lib.scala 441:29]
  wire  _T_1231 = ~io_wr_mcycleh_r; // @[dec_tlu_ctl.scala 2849:96]
  wire  _T_1232 = io_mcyclel_cout & _T_1231; // @[dec_tlu_ctl.scala 2849:94]
  wire  _T_1233 = _T_1232 & io_mcyclel_cout_in; // @[dec_tlu_ctl.scala 2849:113]
  reg  _T_1238; // @[Reg.scala 27:20]
  wire  _T_1236 = _T_1233 ^ _T_1238; // @[lib.scala 463:21]
  wire  _T_1237 = |_T_1236; // @[lib.scala 463:29]
  reg  _T_1243; // @[Reg.scala 27:20]
  wire  _T_1241 = io_minstret_enable ^ _T_1243; // @[lib.scala 463:21]
  wire  _T_1242 = |_T_1241; // @[lib.scala 463:29]
  reg  _T_1248; // @[Reg.scala 27:20]
  wire  _T_1246 = io_minstretl_cout_ns ^ _T_1248; // @[lib.scala 463:21]
  wire  _T_1247 = |_T_1246; // @[lib.scala 463:29]
  reg [3:0] _T_1258; // @[Reg.scala 27:20]
  wire [3:0] _T_1256 = io_meicidpl_ns ^ _T_1258; // @[lib.scala 441:21]
  wire  _T_1257 = |_T_1256; // @[lib.scala 441:29]
  reg  _T_1263; // @[Reg.scala 27:20]
  wire  _T_1261 = io_icache_rd_valid ^ _T_1263; // @[lib.scala 463:21]
  wire  _T_1262 = |_T_1261; // @[lib.scala 463:29]
  reg  _T_1268; // @[Reg.scala 27:20]
  wire  _T_1266 = io_icache_wr_valid ^ _T_1268; // @[lib.scala 463:21]
  wire  _T_1267 = |_T_1266; // @[lib.scala 463:29]
  reg  _T_1283_0; // @[Reg.scala 27:20]
  wire  _T_1271 = io_mhpmc_inc_r_0 ^ _T_1283_0; // @[lib.scala 511:68]
  wire  _T_1272 = |_T_1271; // @[lib.scala 511:82]
  reg  _T_1283_1; // @[Reg.scala 27:20]
  wire  _T_1273 = io_mhpmc_inc_r_1 ^ _T_1283_1; // @[lib.scala 511:68]
  wire  _T_1274 = |_T_1273; // @[lib.scala 511:82]
  reg  _T_1283_2; // @[Reg.scala 27:20]
  wire  _T_1275 = io_mhpmc_inc_r_2 ^ _T_1283_2; // @[lib.scala 511:68]
  wire  _T_1276 = |_T_1275; // @[lib.scala 511:82]
  reg  _T_1283_3; // @[Reg.scala 27:20]
  wire  _T_1277 = io_mhpmc_inc_r_3 ^ _T_1283_3; // @[lib.scala 511:68]
  wire  _T_1278 = |_T_1277; // @[lib.scala 511:82]
  wire  _T_1279 = _T_1272 | _T_1274; // @[lib.scala 511:97]
  wire  _T_1280 = _T_1279 | _T_1276; // @[lib.scala 511:97]
  wire  _T_1281 = _T_1280 | _T_1278; // @[lib.scala 511:97]
  reg  _T_1288; // @[Reg.scala 27:20]
  wire  _T_1286 = io_perfcnt_halted ^ _T_1288; // @[lib.scala 463:21]
  wire  _T_1287 = |_T_1286; // @[lib.scala 463:29]
  reg [1:0] _T_1293; // @[Reg.scala 27:20]
  wire [1:0] _T_1291 = io_mstatus_ns ^ _T_1293; // @[lib.scala 441:21]
  wire  _T_1292 = |_T_1291; // @[lib.scala 441:29]
  assign io_mhpmc_inc_r_0 = _T_3 & _T_295; // @[dec_tlu_ctl.scala 2771:35]
  assign io_mhpmc_inc_r_1 = _T_299 & _T_591; // @[dec_tlu_ctl.scala 2771:35]
  assign io_mhpmc_inc_r_2 = _T_595 & _T_887; // @[dec_tlu_ctl.scala 2771:35]
  assign io_mhpmc_inc_r_3 = _T_891 & _T_1183; // @[dec_tlu_ctl.scala 2771:35]
  assign io_mstatus = _T_1293; // @[dec_tlu_ctl.scala 2858:68]
  assign io_mcyclel_cout_f = _T_1238; // @[dec_tlu_ctl.scala 2849:68]
  assign io_minstret_enable_f = _T_1243; // @[dec_tlu_ctl.scala 2850:68]
  assign io_minstretl_cout_f = _T_1248; // @[dec_tlu_ctl.scala 2851:68]
  assign io_meicidpl = _T_1258; // @[dec_tlu_ctl.scala 2853:68]
  assign io_icache_rd_valid_f = _T_1263; // @[dec_tlu_ctl.scala 2854:68]
  assign io_icache_wr_valid_f = _T_1268; // @[dec_tlu_ctl.scala 2855:68]
  assign io_mhpmc_inc_r_d1_0 = _T_1283_0; // @[dec_tlu_ctl.scala 2856:68]
  assign io_mhpmc_inc_r_d1_1 = _T_1283_1; // @[dec_tlu_ctl.scala 2856:68]
  assign io_mhpmc_inc_r_d1_2 = _T_1283_2; // @[dec_tlu_ctl.scala 2856:68]
  assign io_mhpmc_inc_r_d1_3 = _T_1283_3; // @[dec_tlu_ctl.scala 2856:68]
  assign io_perfcnt_halted_d1 = _T_1288; // @[dec_tlu_ctl.scala 2857:68]
  assign io_mdseac_locked_f = _T_1190; // @[dec_tlu_ctl.scala 2840:68]
  assign io_lsu_single_ecc_error_r_d1 = _T_1195; // @[dec_tlu_ctl.scala 2841:68]
  assign io_lsu_i0_exc_r_d1 = _T_1205; // @[dec_tlu_ctl.scala 2843:68]
  assign io_take_ext_int_start_d1 = _T_1210; // @[dec_tlu_ctl.scala 2844:68]
  assign io_take_ext_int_start_d2 = _T_1215; // @[dec_tlu_ctl.scala 2845:68]
  assign io_take_ext_int_start_d3 = _T_1220; // @[dec_tlu_ctl.scala 2846:68]
  assign io_ext_int_freeze_d1 = _T_1225; // @[dec_tlu_ctl.scala 2847:68]
  assign io_mip = _T_1230; // @[dec_tlu_ctl.scala 2848:68]
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
  _T_1190 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  _T_1195 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_1205 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  _T_1210 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  _T_1215 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  _T_1220 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  _T_1225 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  _T_1230 = _RAND_7[5:0];
  _RAND_8 = {1{`RANDOM}};
  _T_1238 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  _T_1243 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  _T_1248 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  _T_1258 = _RAND_11[3:0];
  _RAND_12 = {1{`RANDOM}};
  _T_1263 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  _T_1268 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  _T_1283_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  _T_1283_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  _T_1283_2 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  _T_1283_3 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  _T_1288 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  _T_1293 = _RAND_19[1:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    _T_1190 = 1'h0;
  end
  if (reset) begin
    _T_1195 = 1'h0;
  end
  if (reset) begin
    _T_1205 = 1'h0;
  end
  if (reset) begin
    _T_1210 = 1'h0;
  end
  if (reset) begin
    _T_1215 = 1'h0;
  end
  if (reset) begin
    _T_1220 = 1'h0;
  end
  if (reset) begin
    _T_1225 = 1'h0;
  end
  if (reset) begin
    _T_1230 = 6'h0;
  end
  if (reset) begin
    _T_1238 = 1'h0;
  end
  if (reset) begin
    _T_1243 = 1'h0;
  end
  if (reset) begin
    _T_1248 = 1'h0;
  end
  if (reset) begin
    _T_1258 = 4'h0;
  end
  if (reset) begin
    _T_1263 = 1'h0;
  end
  if (reset) begin
    _T_1268 = 1'h0;
  end
  if (reset) begin
    _T_1283_0 = 1'h0;
  end
  if (reset) begin
    _T_1283_1 = 1'h0;
  end
  if (reset) begin
    _T_1283_2 = 1'h0;
  end
  if (reset) begin
    _T_1283_3 = 1'h0;
  end
  if (reset) begin
    _T_1288 = 1'h0;
  end
  if (reset) begin
    _T_1293 = 2'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1190 <= 1'h0;
    end else if (_T_1189) begin
      _T_1190 <= io_mdseac_locked_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1195 <= 1'h0;
    end else if (_T_1194) begin
      _T_1195 <= io_lsu_single_ecc_error_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1205 <= 1'h0;
    end else if (_T_1204) begin
      _T_1205 <= io_lsu_i0_exc_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1210 <= 1'h0;
    end else if (_T_1209) begin
      _T_1210 <= io_take_ext_int_start;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1215 <= 1'h0;
    end else if (_T_1214) begin
      _T_1215 <= io_take_ext_int_start_d1;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1220 <= 1'h0;
    end else if (_T_1219) begin
      _T_1220 <= io_take_ext_int_start_d2;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1225 <= 1'h0;
    end else if (_T_1224) begin
      _T_1225 <= io_ext_int_freeze;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1230 <= 6'h0;
    end else if (_T_1229) begin
      _T_1230 <= io_mip_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1238 <= 1'h0;
    end else if (_T_1237) begin
      _T_1238 <= _T_1233;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1243 <= 1'h0;
    end else if (_T_1242) begin
      _T_1243 <= io_minstret_enable;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1248 <= 1'h0;
    end else if (_T_1247) begin
      _T_1248 <= io_minstretl_cout_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1258 <= 4'h0;
    end else if (_T_1257) begin
      _T_1258 <= io_meicidpl_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1263 <= 1'h0;
    end else if (_T_1262) begin
      _T_1263 <= io_icache_rd_valid;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1268 <= 1'h0;
    end else if (_T_1267) begin
      _T_1268 <= io_icache_wr_valid;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1283_0 <= 1'h0;
    end else if (_T_1281) begin
      _T_1283_0 <= io_mhpmc_inc_r_0;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1283_1 <= 1'h0;
    end else if (_T_1281) begin
      _T_1283_1 <= io_mhpmc_inc_r_1;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1283_2 <= 1'h0;
    end else if (_T_1281) begin
      _T_1283_2 <= io_mhpmc_inc_r_2;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1283_3 <= 1'h0;
    end else if (_T_1281) begin
      _T_1283_3 <= io_mhpmc_inc_r_3;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1288 <= 1'h0;
    end else if (_T_1287) begin
      _T_1288 <= io_perfcnt_halted;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_1293 <= 2'h0;
    end else if (_T_1292) begin
      _T_1293 <= io_mstatus_ns;
    end
  end
endmodule
module rvclkhdr(
  input   io_clk,
  input   io_en
);
  wire  clkhdr_Q; // @[lib.scala 336:26]
  wire  clkhdr_CK; // @[lib.scala 336:26]
  wire  clkhdr_EN; // @[lib.scala 336:26]
  wire  clkhdr_SE; // @[lib.scala 336:26]
  gated_latch clkhdr ( // @[lib.scala 336:26]
    .Q(clkhdr_Q),
    .CK(clkhdr_CK),
    .EN(clkhdr_EN),
    .SE(clkhdr_SE)
  );
  assign clkhdr_CK = io_clk; // @[lib.scala 338:18]
  assign clkhdr_EN = io_en; // @[lib.scala 339:18]
  assign clkhdr_SE = 1'h0; // @[lib.scala 340:18]
endmodule
module perf_csr(
  input         clock,
  input         reset,
  input         io_free_l2clk,
  input         io_dec_tlu_dbg_halted,
  input  [15:0] io_dcsr,
  input         io_dec_tlu_pmu_fw_halted,
  input  [9:0]  io_mhpme_vec_0,
  input  [9:0]  io_mhpme_vec_1,
  input  [9:0]  io_mhpme_vec_2,
  input  [9:0]  io_mhpme_vec_3,
  input         io_dec_csr_wen_r_mod,
  input  [11:0] io_dec_csr_wraddr_r,
  input  [31:0] io_dec_csr_wrdata_r,
  input         io_mhpmc_inc_r_0,
  input         io_mhpmc_inc_r_1,
  input         io_mhpmc_inc_r_2,
  input         io_mhpmc_inc_r_3,
  input         io_mhpmc_inc_r_d1_0,
  input         io_mhpmc_inc_r_d1_1,
  input         io_mhpmc_inc_r_d1_2,
  input         io_mhpmc_inc_r_d1_3,
  input         io_perfcnt_halted_d1,
  output [31:0] io_mhpmc3h,
  output [31:0] io_mhpmc3,
  output [31:0] io_mhpmc4h,
  output [31:0] io_mhpmc4,
  output [31:0] io_mhpmc5h,
  output [31:0] io_mhpmc5,
  output [31:0] io_mhpmc6h,
  output [31:0] io_mhpmc6,
  output [9:0]  io_mhpme3,
  output [9:0]  io_mhpme4,
  output [9:0]  io_mhpme5,
  output [9:0]  io_mhpme6,
  output        io_dec_tlu_perfcnt0,
  output        io_dec_tlu_perfcnt1,
  output        io_dec_tlu_perfcnt2,
  output        io_dec_tlu_perfcnt3
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
`endif // RANDOMIZE_REG_INIT
  wire  rvclkhdr_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_1_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_1_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_2_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_2_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_3_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_3_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_4_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_4_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_5_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_5_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_6_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_6_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_7_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_7_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_8_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_8_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_9_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_9_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_10_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_10_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_11_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_11_io_en; // @[lib.scala 397:23]
  wire  _T_1 = io_dec_tlu_dbg_halted & io_dcsr[10]; // @[dec_tlu_ctl.scala 2556:54]
  wire  perfcnt_halted = _T_1 | io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 2556:77]
  wire  _T_4 = ~_T_1; // @[dec_tlu_ctl.scala 2557:44]
  wire [3:0] _T_6 = _T_4 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_13 = {io_mhpme_vec_3[9],io_mhpme_vec_2[9],io_mhpme_vec_1[9],io_mhpme_vec_0[9]}; // @[Cat.scala 29:58]
  wire [3:0] perfcnt_during_sleep = _T_6 & _T_13; // @[dec_tlu_ctl.scala 2557:93]
  wire  _T_15 = ~perfcnt_during_sleep[0]; // @[dec_tlu_ctl.scala 2560:80]
  wire  _T_16 = io_perfcnt_halted_d1 & _T_15; // @[dec_tlu_ctl.scala 2560:78]
  wire  _T_17 = ~_T_16; // @[dec_tlu_ctl.scala 2560:55]
  wire  _T_20 = ~perfcnt_during_sleep[1]; // @[dec_tlu_ctl.scala 2561:80]
  wire  _T_21 = io_perfcnt_halted_d1 & _T_20; // @[dec_tlu_ctl.scala 2561:78]
  wire  _T_22 = ~_T_21; // @[dec_tlu_ctl.scala 2561:55]
  wire  _T_25 = ~perfcnt_during_sleep[2]; // @[dec_tlu_ctl.scala 2562:80]
  wire  _T_26 = io_perfcnt_halted_d1 & _T_25; // @[dec_tlu_ctl.scala 2562:78]
  wire  _T_27 = ~_T_26; // @[dec_tlu_ctl.scala 2562:55]
  wire  _T_30 = ~perfcnt_during_sleep[3]; // @[dec_tlu_ctl.scala 2563:80]
  wire  _T_31 = io_perfcnt_halted_d1 & _T_30; // @[dec_tlu_ctl.scala 2563:78]
  wire  _T_32 = ~_T_31; // @[dec_tlu_ctl.scala 2563:55]
  wire  _T_35 = io_dec_csr_wraddr_r == 12'hb03; // @[dec_tlu_ctl.scala 2569:79]
  wire  mhpmc3_wr_en0 = io_dec_csr_wen_r_mod & _T_35; // @[dec_tlu_ctl.scala 2569:50]
  wire  _T_36 = ~perfcnt_halted; // @[dec_tlu_ctl.scala 2570:30]
  wire  _T_38 = _T_36 | perfcnt_during_sleep[0]; // @[dec_tlu_ctl.scala 2570:46]
  wire  _T_39 = |io_mhpmc_inc_r_0; // @[dec_tlu_ctl.scala 2570:96]
  wire  mhpmc3_wr_en1 = _T_38 & _T_39; // @[dec_tlu_ctl.scala 2570:73]
  wire  mhpmc3_wr_en = mhpmc3_wr_en0 | mhpmc3_wr_en1; // @[dec_tlu_ctl.scala 2571:43]
  wire [63:0] _T_42 = {io_mhpmc3h,io_mhpmc3}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc3_incr = _T_42 + 64'h1; // @[dec_tlu_ctl.scala 2574:65]
  reg [31:0] _T_48; // @[Reg.scala 27:20]
  wire  _T_50 = io_dec_csr_wraddr_r == 12'hb83; // @[dec_tlu_ctl.scala 2579:80]
  wire  mhpmc3h_wr_en0 = io_dec_csr_wen_r_mod & _T_50; // @[dec_tlu_ctl.scala 2579:51]
  wire  mhpmc3h_wr_en = mhpmc3h_wr_en0 | mhpmc3_wr_en1; // @[dec_tlu_ctl.scala 2580:45]
  reg [31:0] _T_54; // @[Reg.scala 27:20]
  wire  _T_56 = io_dec_csr_wraddr_r == 12'hb04; // @[dec_tlu_ctl.scala 2588:79]
  wire  mhpmc4_wr_en0 = io_dec_csr_wen_r_mod & _T_56; // @[dec_tlu_ctl.scala 2588:50]
  wire  _T_59 = _T_36 | perfcnt_during_sleep[1]; // @[dec_tlu_ctl.scala 2589:46]
  wire  _T_60 = |io_mhpmc_inc_r_1; // @[dec_tlu_ctl.scala 2589:96]
  wire  mhpmc4_wr_en1 = _T_59 & _T_60; // @[dec_tlu_ctl.scala 2589:73]
  wire  mhpmc4_wr_en = mhpmc4_wr_en0 | mhpmc4_wr_en1; // @[dec_tlu_ctl.scala 2590:43]
  wire [63:0] _T_63 = {io_mhpmc4h,io_mhpmc4}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc4_incr = _T_63 + 64'h1; // @[dec_tlu_ctl.scala 2594:65]
  reg [31:0] _T_70; // @[Reg.scala 27:20]
  wire  _T_72 = io_dec_csr_wraddr_r == 12'hb84; // @[dec_tlu_ctl.scala 2598:80]
  wire  mhpmc4h_wr_en0 = io_dec_csr_wen_r_mod & _T_72; // @[dec_tlu_ctl.scala 2598:51]
  wire  mhpmc4h_wr_en = mhpmc4h_wr_en0 | mhpmc4_wr_en1; // @[dec_tlu_ctl.scala 2599:45]
  reg [31:0] _T_76; // @[Reg.scala 27:20]
  wire  _T_78 = io_dec_csr_wraddr_r == 12'hb05; // @[dec_tlu_ctl.scala 2607:79]
  wire  mhpmc5_wr_en0 = io_dec_csr_wen_r_mod & _T_78; // @[dec_tlu_ctl.scala 2607:50]
  wire  _T_81 = _T_36 | perfcnt_during_sleep[2]; // @[dec_tlu_ctl.scala 2608:46]
  wire  _T_82 = |io_mhpmc_inc_r_2; // @[dec_tlu_ctl.scala 2608:96]
  wire  mhpmc5_wr_en1 = _T_81 & _T_82; // @[dec_tlu_ctl.scala 2608:73]
  wire  mhpmc5_wr_en = mhpmc5_wr_en0 | mhpmc5_wr_en1; // @[dec_tlu_ctl.scala 2609:43]
  wire [63:0] _T_85 = {io_mhpmc5h,io_mhpmc5}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc5_incr = _T_85 + 64'h1; // @[dec_tlu_ctl.scala 2611:65]
  reg [31:0] _T_91; // @[Reg.scala 27:20]
  wire  _T_93 = io_dec_csr_wraddr_r == 12'hb85; // @[dec_tlu_ctl.scala 2616:80]
  wire  mhpmc5h_wr_en0 = io_dec_csr_wen_r_mod & _T_93; // @[dec_tlu_ctl.scala 2616:51]
  wire  mhpmc5h_wr_en = mhpmc5h_wr_en0 | mhpmc5_wr_en1; // @[dec_tlu_ctl.scala 2617:45]
  reg [31:0] _T_97; // @[Reg.scala 27:20]
  wire  _T_99 = io_dec_csr_wraddr_r == 12'hb06; // @[dec_tlu_ctl.scala 2625:79]
  wire  mhpmc6_wr_en0 = io_dec_csr_wen_r_mod & _T_99; // @[dec_tlu_ctl.scala 2625:50]
  wire  _T_102 = _T_36 | perfcnt_during_sleep[3]; // @[dec_tlu_ctl.scala 2626:46]
  wire  _T_103 = |io_mhpmc_inc_r_3; // @[dec_tlu_ctl.scala 2626:96]
  wire  mhpmc6_wr_en1 = _T_102 & _T_103; // @[dec_tlu_ctl.scala 2626:73]
  wire  mhpmc6_wr_en = mhpmc6_wr_en0 | mhpmc6_wr_en1; // @[dec_tlu_ctl.scala 2627:43]
  wire [63:0] _T_106 = {io_mhpmc6h,io_mhpmc6}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc6_incr = _T_106 + 64'h1; // @[dec_tlu_ctl.scala 2629:65]
  reg [31:0] _T_112; // @[Reg.scala 27:20]
  wire  _T_114 = io_dec_csr_wraddr_r == 12'hb86; // @[dec_tlu_ctl.scala 2634:80]
  wire  mhpmc6h_wr_en0 = io_dec_csr_wen_r_mod & _T_114; // @[dec_tlu_ctl.scala 2634:51]
  wire  mhpmc6h_wr_en = mhpmc6h_wr_en0 | mhpmc6_wr_en1; // @[dec_tlu_ctl.scala 2635:45]
  reg [31:0] _T_118; // @[Reg.scala 27:20]
  wire  _T_120 = io_dec_csr_wrdata_r[9:0] > 10'h204; // @[dec_tlu_ctl.scala 2645:56]
  wire  _T_122 = |io_dec_csr_wrdata_r[31:10]; // @[dec_tlu_ctl.scala 2645:102]
  wire  _T_123 = _T_120 | _T_122; // @[dec_tlu_ctl.scala 2645:72]
  wire  _T_125 = io_dec_csr_wrdata_r[9:0] < 10'h200; // @[dec_tlu_ctl.scala 2646:44]
  wire  _T_127 = io_dec_csr_wrdata_r[9:0] > 10'h38; // @[dec_tlu_ctl.scala 2646:88]
  wire  _T_128 = _T_125 & _T_127; // @[dec_tlu_ctl.scala 2646:60]
  wire  _T_129 = _T_123 | _T_128; // @[dec_tlu_ctl.scala 2645:107]
  wire  _T_131 = io_dec_csr_wrdata_r[9:0] < 10'h36; // @[dec_tlu_ctl.scala 2647:44]
  wire  _T_133 = io_dec_csr_wrdata_r[9:0] > 10'h32; // @[dec_tlu_ctl.scala 2647:88]
  wire  _T_134 = _T_131 & _T_133; // @[dec_tlu_ctl.scala 2647:60]
  wire  _T_135 = _T_129 | _T_134; // @[dec_tlu_ctl.scala 2646:103]
  wire  _T_137 = io_dec_csr_wrdata_r[9:0] == 10'h1d; // @[dec_tlu_ctl.scala 2648:43]
  wire  _T_138 = _T_135 | _T_137; // @[dec_tlu_ctl.scala 2647:103]
  wire  _T_140 = io_dec_csr_wrdata_r[9:0] == 10'h21; // @[dec_tlu_ctl.scala 2648:87]
  wire  zero_event_r = _T_138 | _T_140; // @[dec_tlu_ctl.scala 2648:59]
  wire  _T_143 = io_dec_csr_wraddr_r == 12'h323; // @[dec_tlu_ctl.scala 2651:77]
  wire  wr_mhpme3_r = io_dec_csr_wen_r_mod & _T_143; // @[dec_tlu_ctl.scala 2651:48]
  reg [9:0] _T_145; // @[Reg.scala 27:20]
  wire  _T_147 = io_dec_csr_wraddr_r == 12'h324; // @[dec_tlu_ctl.scala 2658:77]
  wire  wr_mhpme4_r = io_dec_csr_wen_r_mod & _T_147; // @[dec_tlu_ctl.scala 2658:48]
  reg [9:0] _T_149; // @[Reg.scala 27:20]
  wire  _T_151 = io_dec_csr_wraddr_r == 12'h325; // @[dec_tlu_ctl.scala 2665:77]
  wire  wr_mhpme5_r = io_dec_csr_wen_r_mod & _T_151; // @[dec_tlu_ctl.scala 2665:48]
  reg [9:0] _T_153; // @[Reg.scala 27:20]
  wire  _T_155 = io_dec_csr_wraddr_r == 12'h326; // @[dec_tlu_ctl.scala 2672:77]
  wire  wr_mhpme6_r = io_dec_csr_wen_r_mod & _T_155; // @[dec_tlu_ctl.scala 2672:48]
  reg [9:0] _T_157; // @[Reg.scala 27:20]
  rvclkhdr rvclkhdr ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en)
  );
  rvclkhdr rvclkhdr_1 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en)
  );
  rvclkhdr rvclkhdr_2 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en)
  );
  rvclkhdr rvclkhdr_3 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en)
  );
  rvclkhdr rvclkhdr_4 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en)
  );
  rvclkhdr rvclkhdr_5 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en)
  );
  rvclkhdr rvclkhdr_6 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en)
  );
  rvclkhdr rvclkhdr_7 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en)
  );
  rvclkhdr rvclkhdr_8 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en)
  );
  rvclkhdr rvclkhdr_9 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en)
  );
  rvclkhdr rvclkhdr_10 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en)
  );
  rvclkhdr rvclkhdr_11 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en)
  );
  assign io_mhpmc3h = _T_54; // @[dec_tlu_ctl.scala 2583:20]
  assign io_mhpmc3 = _T_48; // @[dec_tlu_ctl.scala 2577:19]
  assign io_mhpmc4h = _T_76; // @[dec_tlu_ctl.scala 2601:20]
  assign io_mhpmc4 = _T_70; // @[dec_tlu_ctl.scala 2596:19]
  assign io_mhpmc5h = _T_97; // @[dec_tlu_ctl.scala 2620:20]
  assign io_mhpmc5 = _T_91; // @[dec_tlu_ctl.scala 2614:19]
  assign io_mhpmc6h = _T_118; // @[dec_tlu_ctl.scala 2638:20]
  assign io_mhpmc6 = _T_112; // @[dec_tlu_ctl.scala 2632:19]
  assign io_mhpme3 = _T_145; // @[dec_tlu_ctl.scala 2653:19]
  assign io_mhpme4 = _T_149; // @[dec_tlu_ctl.scala 2659:19]
  assign io_mhpme5 = _T_153; // @[dec_tlu_ctl.scala 2666:19]
  assign io_mhpme6 = _T_157; // @[dec_tlu_ctl.scala 2673:19]
  assign io_dec_tlu_perfcnt0 = io_mhpmc_inc_r_d1_0 & _T_17; // @[dec_tlu_ctl.scala 2560:29]
  assign io_dec_tlu_perfcnt1 = io_mhpmc_inc_r_d1_1 & _T_22; // @[dec_tlu_ctl.scala 2561:29]
  assign io_dec_tlu_perfcnt2 = io_mhpmc_inc_r_d1_2 & _T_27; // @[dec_tlu_ctl.scala 2562:29]
  assign io_dec_tlu_perfcnt3 = io_mhpmc_inc_r_d1_3 & _T_32; // @[dec_tlu_ctl.scala 2563:29]
  assign rvclkhdr_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_io_en = mhpmc3_wr_en0 | mhpmc3_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_1_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_1_io_en = mhpmc3h_wr_en0 | mhpmc3_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_2_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_2_io_en = mhpmc4_wr_en0 | mhpmc4_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_3_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_3_io_en = mhpmc4h_wr_en0 | mhpmc4_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_4_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_4_io_en = mhpmc5_wr_en0 | mhpmc5_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_5_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_5_io_en = mhpmc5h_wr_en0 | mhpmc5_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_6_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_6_io_en = mhpmc6_wr_en0 | mhpmc6_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_7_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_7_io_en = mhpmc6h_wr_en0 | mhpmc6_wr_en1; // @[lib.scala 400:17]
  assign rvclkhdr_8_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_8_io_en = io_dec_csr_wen_r_mod & _T_143; // @[lib.scala 400:17]
  assign rvclkhdr_9_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_9_io_en = io_dec_csr_wen_r_mod & _T_147; // @[lib.scala 400:17]
  assign rvclkhdr_10_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_10_io_en = io_dec_csr_wen_r_mod & _T_151; // @[lib.scala 400:17]
  assign rvclkhdr_11_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_11_io_en = io_dec_csr_wen_r_mod & _T_155; // @[lib.scala 400:17]
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
  _T_48 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  _T_54 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  _T_70 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  _T_76 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  _T_91 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  _T_97 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  _T_112 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  _T_118 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  _T_145 = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  _T_149 = _RAND_9[9:0];
  _RAND_10 = {1{`RANDOM}};
  _T_153 = _RAND_10[9:0];
  _RAND_11 = {1{`RANDOM}};
  _T_157 = _RAND_11[9:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    _T_48 = 32'h0;
  end
  if (reset) begin
    _T_54 = 32'h0;
  end
  if (reset) begin
    _T_70 = 32'h0;
  end
  if (reset) begin
    _T_76 = 32'h0;
  end
  if (reset) begin
    _T_91 = 32'h0;
  end
  if (reset) begin
    _T_97 = 32'h0;
  end
  if (reset) begin
    _T_112 = 32'h0;
  end
  if (reset) begin
    _T_118 = 32'h0;
  end
  if (reset) begin
    _T_145 = 10'h0;
  end
  if (reset) begin
    _T_149 = 10'h0;
  end
  if (reset) begin
    _T_153 = 10'h0;
  end
  if (reset) begin
    _T_157 = 10'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_48 <= 32'h0;
    end else if (mhpmc3_wr_en) begin
      if (mhpmc3_wr_en0) begin
        _T_48 <= io_dec_csr_wrdata_r;
      end else begin
        _T_48 <= mhpmc3_incr[31:0];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_54 <= 32'h0;
    end else if (mhpmc3h_wr_en) begin
      if (mhpmc3h_wr_en0) begin
        _T_54 <= io_dec_csr_wrdata_r;
      end else begin
        _T_54 <= mhpmc3_incr[63:32];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_70 <= 32'h0;
    end else if (mhpmc4_wr_en) begin
      if (mhpmc4_wr_en0) begin
        _T_70 <= io_dec_csr_wrdata_r;
      end else begin
        _T_70 <= mhpmc4_incr[31:0];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_76 <= 32'h0;
    end else if (mhpmc4h_wr_en) begin
      if (mhpmc4h_wr_en0) begin
        _T_76 <= io_dec_csr_wrdata_r;
      end else begin
        _T_76 <= mhpmc4_incr[63:32];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_91 <= 32'h0;
    end else if (mhpmc5_wr_en) begin
      if (mhpmc5_wr_en0) begin
        _T_91 <= io_dec_csr_wrdata_r;
      end else begin
        _T_91 <= mhpmc5_incr[31:0];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_97 <= 32'h0;
    end else if (mhpmc5h_wr_en) begin
      if (mhpmc5h_wr_en0) begin
        _T_97 <= io_dec_csr_wrdata_r;
      end else begin
        _T_97 <= mhpmc5_incr[63:32];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_112 <= 32'h0;
    end else if (mhpmc6_wr_en) begin
      if (mhpmc6_wr_en0) begin
        _T_112 <= io_dec_csr_wrdata_r;
      end else begin
        _T_112 <= mhpmc6_incr[31:0];
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_118 <= 32'h0;
    end else if (mhpmc6h_wr_en) begin
      if (mhpmc6h_wr_en0) begin
        _T_118 <= io_dec_csr_wrdata_r;
      end else begin
        _T_118 <= mhpmc6_incr[63:32];
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_145 <= 10'h0;
    end else if (wr_mhpme3_r) begin
      if (zero_event_r) begin
        _T_145 <= 10'h0;
      end else begin
        _T_145 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_149 <= 10'h0;
    end else if (wr_mhpme4_r) begin
      if (zero_event_r) begin
        _T_149 <= 10'h0;
      end else begin
        _T_149 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_153 <= 10'h0;
    end else if (wr_mhpme5_r) begin
      if (zero_event_r) begin
        _T_153 <= 10'h0;
      end else begin
        _T_153 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_157 <= 10'h0;
    end else if (wr_mhpme6_r) begin
      if (zero_event_r) begin
        _T_157 <= 10'h0;
      end else begin
        _T_157 <= io_dec_csr_wrdata_r[9:0];
      end
    end
  end
endmodule
module csr_tlu(
  input         clock,
  input         reset,
  input         io_free_l2clk,
  input         io_free_clk,
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
  output        io_trigger_pkt_any_0_match_pkt,
  output        io_trigger_pkt_any_0_store,
  output        io_trigger_pkt_any_0_load,
  output        io_trigger_pkt_any_0_execute,
  output        io_trigger_pkt_any_0_m,
  output [31:0] io_trigger_pkt_any_0_tdata2,
  output        io_trigger_pkt_any_1_select,
  output        io_trigger_pkt_any_1_match_pkt,
  output        io_trigger_pkt_any_1_store,
  output        io_trigger_pkt_any_1_load,
  output        io_trigger_pkt_any_1_execute,
  output        io_trigger_pkt_any_1_m,
  output [31:0] io_trigger_pkt_any_1_tdata2,
  output        io_trigger_pkt_any_2_select,
  output        io_trigger_pkt_any_2_match_pkt,
  output        io_trigger_pkt_any_2_store,
  output        io_trigger_pkt_any_2_load,
  output        io_trigger_pkt_any_2_execute,
  output        io_trigger_pkt_any_2_m,
  output [31:0] io_trigger_pkt_any_2_tdata2,
  output        io_trigger_pkt_any_3_select,
  output        io_trigger_pkt_any_3_match_pkt,
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
  output        io_dec_tlu_picio_clk_override,
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
  output        io_dec_tlu_trace_disable,
  input  [31:0] io_dec_illegal_inst,
  input  [3:0]  io_lsu_error_pkt_r_bits_mscause,
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
  input         io_lsu_single_ecc_error_r,
  input         io_e4e5_int_clk,
  input         io_lsu_i0_exc_r,
  input         io_inst_acc_r,
  input         io_inst_acc_second_r,
  input         io_take_nmi,
  input  [31:0] io_lsu_error_pkt_addr_r,
  input  [4:0]  io_exc_cause_r,
  input         io_i0_valid_wb,
  input         io_interrupt_valid_r_d1,
  input         io_i0_exception_valid_r_d1,
  input  [4:0]  io_exc_cause_wb,
  input         io_nmi_lsu_store_type,
  input         io_nmi_lsu_load_type,
  input         io_tlu_i0_commit_cmt,
  input         io_ebreak_r,
  input         io_ecall_r,
  input         io_illegal_r,
  output        io_mdseac_locked_ns,
  output        io_mdseac_locked_f,
  input         io_nmi_int_detected_f,
  input         io_internal_dbg_halt_mode_f2,
  input         io_ext_int_freeze,
  output        io_ext_int_freeze_d1,
  output        io_take_ext_int_start_d1,
  output        io_take_ext_int_start_d2,
  output        io_take_ext_int_start_d3,
  input         io_ic_perr_r,
  input         io_iccm_sbecc_r,
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
  output [9:0]  io_mtdata1_t_3,
  input  [3:0]  io_trigger_enabled
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
`endif // RANDOMIZE_REG_INIT
  wire  perfmux_flop_reset; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_0; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_1; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_2; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_3; // @[dec_tlu_ctl.scala 1442:34]
  wire [6:0] perfmux_flop_io_mcountinhibit; // @[dec_tlu_ctl.scala 1442:34]
  wire [9:0] perfmux_flop_io_mhpme_vec_0; // @[dec_tlu_ctl.scala 1442:34]
  wire [9:0] perfmux_flop_io_mhpme_vec_1; // @[dec_tlu_ctl.scala 1442:34]
  wire [9:0] perfmux_flop_io_mhpme_vec_2; // @[dec_tlu_ctl.scala 1442:34]
  wire [9:0] perfmux_flop_io_mhpme_vec_3; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_ic_hit; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_ic_miss; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_illegal_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_instr_aligned; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_pmu_instr_decoded; // @[dec_tlu_ctl.scala 1442:34]
  wire [3:0] perfmux_flop_io_dec_tlu_packet_r_pmu_i0_itype; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_tlu_packet_r_pmu_divide; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_exu_pmu_i0_br_misp; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_pmu_decode_stall; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_fetch_stall; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_pmu_postsync_stall; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_pmu_presync_stall; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_store_stall_any; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dma_dccm_stall_any; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dma_iccm_stall_any; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dma_pmu_any_read; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dma_pmu_any_write; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dma_pmu_dccm_read; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dma_pmu_dccm_write; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 1442:34]
  wire [1:0] perfmux_flop_io_mstatus; // @[dec_tlu_ctl.scala 1442:34]
  wire [5:0] perfmux_flop_io_mie; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_pmu_bus_misaligned; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_bus_error; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_pmu_bus_error; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ifu_pmu_bus_busy; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_pmu_bus_busy; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_timer_int; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_int_timer0_int; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_int_timer1_int; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_ext_int; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_tlu_br0_error_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_rfpc_i0_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_dec_tlu_br0_start_error_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mcyclel_cout_f; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_minstret_enable_f; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_minstretl_cout_f; // @[dec_tlu_ctl.scala 1442:34]
  wire [3:0] perfmux_flop_io_meicidpl; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_icache_rd_valid_f; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_icache_wr_valid_f; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_d1_0; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_d1_1; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_d1_2; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mhpmc_inc_r_d1_3; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_perfcnt_halted_d1; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mdseac_locked_f; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_single_ecc_error_r_d1; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_i0_exc_r_d1; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_ext_int_start_d2; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 1442:34]
  wire [5:0] perfmux_flop_io_mip; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mdseac_locked_ns; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_single_ecc_error_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_lsu_i0_exc_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_take_ext_int_start; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_ext_int_freeze; // @[dec_tlu_ctl.scala 1442:34]
  wire [5:0] perfmux_flop_io_mip_ns; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mcyclel_cout; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_wr_mcycleh_r; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_mcyclel_cout_in; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_minstret_enable; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_minstretl_cout_ns; // @[dec_tlu_ctl.scala 1442:34]
  wire [3:0] perfmux_flop_io_meicidpl_ns; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_icache_rd_valid; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_icache_wr_valid; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_perfcnt_halted; // @[dec_tlu_ctl.scala 1442:34]
  wire [1:0] perfmux_flop_io_mstatus_ns; // @[dec_tlu_ctl.scala 1442:34]
  wire  perfmux_flop_io_free_l2clk; // @[dec_tlu_ctl.scala 1442:34]
  wire  perf_csrs_clock; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_reset; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_free_l2clk; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 1443:31]
  wire [15:0] perf_csrs_io_dcsr; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme_vec_0; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme_vec_1; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme_vec_2; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme_vec_3; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 1443:31]
  wire [11:0] perf_csrs_io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_0; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_1; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_2; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_3; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_d1_0; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_d1_1; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_d1_2; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_mhpmc_inc_r_d1_3; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_perfcnt_halted_d1; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc3h; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc3; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc4h; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc4; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc5h; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc5; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc6h; // @[dec_tlu_ctl.scala 1443:31]
  wire [31:0] perf_csrs_io_mhpmc6; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme3; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme4; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme5; // @[dec_tlu_ctl.scala 1443:31]
  wire [9:0] perf_csrs_io_mhpme6; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_tlu_perfcnt0; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_tlu_perfcnt1; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_tlu_perfcnt2; // @[dec_tlu_ctl.scala 1443:31]
  wire  perf_csrs_io_dec_tlu_perfcnt3; // @[dec_tlu_ctl.scala 1443:31]
  wire  rvclkhdr_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_1_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_1_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_2_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_2_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_3_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_3_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_4_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_4_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_5_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_5_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_6_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_6_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_7_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_7_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_8_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_8_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_9_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_9_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_10_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_10_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_11_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_11_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_12_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_12_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_13_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_13_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_14_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_14_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_15_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_15_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_16_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_16_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_17_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_17_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_18_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_18_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_19_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_19_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_20_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_20_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_21_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_21_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_22_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_22_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_23_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_23_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_24_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_24_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_25_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_25_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_26_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_26_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_27_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_27_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_28_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_28_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_29_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_29_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_30_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_30_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_31_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_31_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_32_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_32_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_33_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_33_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_34_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_34_io_en; // @[lib.scala 397:23]
  wire  _T = ~io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 1459:45]
  wire  _T_1 = io_dec_csr_wen_r & _T; // @[dec_tlu_ctl.scala 1459:43]
  wire  _T_2 = ~io_rfpc_i0_r; // @[dec_tlu_ctl.scala 1459:68]
  wire  _T_5 = io_dec_csr_wraddr_r == 12'h300; // @[dec_tlu_ctl.scala 1460:71]
  wire  wr_mstatus_r = io_dec_csr_wen_r_mod & _T_5; // @[dec_tlu_ctl.scala 1460:42]
  wire  _T_554 = io_dec_csr_wraddr_r == 12'h7c6; // @[dec_tlu_ctl.scala 1864:68]
  wire  wr_mpmc_r = io_dec_csr_wen_r_mod & _T_554; // @[dec_tlu_ctl.scala 1864:39]
  wire  _T_566 = ~io_dec_csr_wrdata_r[1]; // @[dec_tlu_ctl.scala 1872:37]
  reg  mpmc_b; // @[dec_tlu_ctl.scala 1874:44]
  wire  mpmc = ~mpmc_b; // @[dec_tlu_ctl.scala 1877:10]
  wire  _T_567 = ~mpmc; // @[dec_tlu_ctl.scala 1872:62]
  wire  mpmc_b_ns = wr_mpmc_r ? _T_566 : _T_567; // @[dec_tlu_ctl.scala 1872:18]
  wire  _T_6 = ~mpmc_b_ns; // @[dec_tlu_ctl.scala 1463:28]
  wire  set_mie_pmu_fw_halt = _T_6 & io_fw_halt_req; // @[dec_tlu_ctl.scala 1463:39]
  wire  _T_7 = ~wr_mstatus_r; // @[dec_tlu_ctl.scala 1466:5]
  wire  _T_8 = _T_7 & io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 1466:19]
  wire [1:0] _T_12 = {io_mstatus[0],1'h0}; // @[Cat.scala 29:58]
  wire  _T_13 = wr_mstatus_r & io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 1467:18]
  wire [1:0] _T_16 = {io_dec_csr_wrdata_r[3],1'h0}; // @[Cat.scala 29:58]
  wire  _T_17 = ~io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 1468:17]
  wire  _T_18 = io_mret_r & _T_17; // @[dec_tlu_ctl.scala 1468:15]
  wire [1:0] _T_21 = {1'h1,io_mstatus[1]}; // @[Cat.scala 29:58]
  wire [1:0] _T_24 = {io_mstatus[1],1'h1}; // @[Cat.scala 29:58]
  wire  _T_26 = wr_mstatus_r & _T_17; // @[dec_tlu_ctl.scala 1470:18]
  wire [1:0] _T_30 = {io_dec_csr_wrdata_r[7],io_dec_csr_wrdata_r[3]}; // @[Cat.scala 29:58]
  wire  _T_33 = _T_7 & _T_17; // @[dec_tlu_ctl.scala 1471:19]
  wire  _T_34 = ~io_mret_r; // @[dec_tlu_ctl.scala 1471:46]
  wire  _T_35 = _T_33 & _T_34; // @[dec_tlu_ctl.scala 1471:44]
  wire  _T_36 = ~set_mie_pmu_fw_halt; // @[dec_tlu_ctl.scala 1471:59]
  wire  _T_37 = _T_35 & _T_36; // @[dec_tlu_ctl.scala 1471:57]
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
  wire  _T_52 = ~io_dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 1474:50]
  wire  _T_54 = _T_52 | io_dcsr[11]; // @[dec_tlu_ctl.scala 1474:81]
  wire  _T_57 = io_dec_csr_wraddr_r == 12'h305; // @[dec_tlu_ctl.scala 1485:69]
  wire  wr_mtvec_r = io_dec_csr_wen_r_mod & _T_57; // @[dec_tlu_ctl.scala 1485:40]
  wire [30:0] mtvec_ns = {io_dec_csr_wrdata_r[31:2],io_dec_csr_wrdata_r[0]}; // @[Cat.scala 29:58]
  reg [30:0] _T_61; // @[Reg.scala 27:20]
  reg [31:0] mdccmect; // @[Reg.scala 27:20]
  wire [62:0] _T_630 = 63'hffffffff << mdccmect[31:27]; // @[dec_tlu_ctl.scala 1924:41]
  wire [31:0] _T_632 = {5'h0,mdccmect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_43 = {{31'd0}, _T_632}; // @[dec_tlu_ctl.scala 1924:61]
  wire [62:0] _T_633 = _T_630 & _GEN_43; // @[dec_tlu_ctl.scala 1924:61]
  wire  mdccme_ce_req = |_T_633; // @[dec_tlu_ctl.scala 1924:94]
  reg [31:0] miccmect; // @[Reg.scala 27:20]
  wire [62:0] _T_610 = 63'hffffffff << miccmect[31:27]; // @[dec_tlu_ctl.scala 1909:40]
  wire [31:0] _T_612 = {5'h0,miccmect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_44 = {{31'd0}, _T_612}; // @[dec_tlu_ctl.scala 1909:60]
  wire [62:0] _T_613 = _T_610 & _GEN_44; // @[dec_tlu_ctl.scala 1909:60]
  wire  miccme_ce_req = |_T_613; // @[dec_tlu_ctl.scala 1909:93]
  wire  _T_62 = mdccme_ce_req | miccme_ce_req; // @[dec_tlu_ctl.scala 1499:30]
  reg [31:0] micect; // @[Reg.scala 27:20]
  wire [62:0] _T_588 = 63'hffffffff << micect[31:27]; // @[dec_tlu_ctl.scala 1894:39]
  wire [31:0] _T_590 = {5'h0,micect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_45 = {{31'd0}, _T_590}; // @[dec_tlu_ctl.scala 1894:57]
  wire [62:0] _T_591 = _T_588 & _GEN_45; // @[dec_tlu_ctl.scala 1894:57]
  wire  mice_ce_req = |_T_591; // @[dec_tlu_ctl.scala 1894:88]
  wire  ce_int = _T_62 | mice_ce_req; // @[dec_tlu_ctl.scala 1499:46]
  wire [2:0] _T_64 = {io_mexintpend,io_timer_int_sync,io_soft_int_sync}; // @[Cat.scala 29:58]
  wire [2:0] _T_66 = {ce_int,io_dec_timer_t0_pulse,io_dec_timer_t1_pulse}; // @[Cat.scala 29:58]
  wire  _T_68 = io_dec_csr_wraddr_r == 12'h304; // @[dec_tlu_ctl.scala 1515:67]
  wire  wr_mie_r = io_dec_csr_wen_r_mod & _T_68; // @[dec_tlu_ctl.scala 1515:38]
  wire [5:0] _T_76 = {io_dec_csr_wrdata_r[30:28],io_dec_csr_wrdata_r[11],io_dec_csr_wrdata_r[7],io_dec_csr_wrdata_r[3]}; // @[Cat.scala 29:58]
  reg [5:0] mie; // @[dec_tlu_ctl.scala 1518:11]
  wire  kill_ebreak_count_r = io_ebreak_to_debug_mode_r & io_dcsr[10]; // @[dec_tlu_ctl.scala 1525:54]
  wire  _T_81 = io_dec_csr_wraddr_r == 12'hb00; // @[dec_tlu_ctl.scala 1527:71]
  wire  wr_mcyclel_r = io_dec_csr_wen_r_mod & _T_81; // @[dec_tlu_ctl.scala 1527:42]
  wire  _T_83 = io_dec_tlu_dbg_halted & io_dcsr[10]; // @[dec_tlu_ctl.scala 1529:71]
  wire  _T_84 = kill_ebreak_count_r | _T_83; // @[dec_tlu_ctl.scala 1529:46]
  wire  _T_85 = _T_84 | io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 1529:94]
  reg [4:0] temp_ncount6_2; // @[Reg.scala 27:20]
  wire [5:0] _T_1139 = {temp_ncount6_2,1'h0}; // @[Cat.scala 29:58]
  reg  temp_ncount0; // @[Reg.scala 27:20]
  wire [6:0] mcountinhibit = {temp_ncount6_2,1'h0,temp_ncount0}; // @[Cat.scala 29:58]
  wire  _T_87 = _T_85 | mcountinhibit[0]; // @[dec_tlu_ctl.scala 1529:121]
  wire  mcyclel_cout_in = ~_T_87; // @[dec_tlu_ctl.scala 1529:24]
  reg [23:0] _T_106; // @[Reg.scala 27:20]
  reg [7:0] _T_110; // @[Reg.scala 27:20]
  wire [31:0] mcyclel = {_T_106,_T_110}; // @[Cat.scala 29:58]
  wire [8:0] mcyclel_inc1 = mcyclel[7:0] + 8'h1; // @[dec_tlu_ctl.scala 1534:31]
  wire [23:0] _T_93 = {23'h0,mcyclel_inc1[8]}; // @[Cat.scala 29:58]
  wire [24:0] mcyclel_inc2 = mcyclel[31:8] + _T_93; // @[dec_tlu_ctl.scala 1535:32]
  wire [32:0] mcyclel_inc = {mcyclel_inc2,mcyclel_inc1[7:0]}; // @[Cat.scala 29:58]
  wire [31:0] mcyclel_ns = wr_mcyclel_r ? io_dec_csr_wrdata_r : mcyclel_inc[31:0]; // @[dec_tlu_ctl.scala 1537:22]
  wire  _T_102 = mcyclel_inc1[8] & mcyclel_cout_in; // @[dec_tlu_ctl.scala 1539:75]
  wire  _T_104 = wr_mcyclel_r | _T_102; // @[dec_tlu_ctl.scala 1539:56]
  wire  _T_108 = wr_mcyclel_r | mcyclel_cout_in; // @[dec_tlu_ctl.scala 1539:177]
  wire  _T_113 = io_dec_csr_wraddr_r == 12'hb80; // @[dec_tlu_ctl.scala 1546:71]
  wire  wr_mcycleh_r = io_dec_csr_wen_r_mod & _T_113; // @[dec_tlu_ctl.scala 1546:42]
  wire [31:0] _T_114 = {31'h0,perfmux_flop_io_mcyclel_cout_f}; // @[Cat.scala 29:58]
  reg [31:0] mcycleh; // @[Reg.scala 27:20]
  wire [31:0] mcycleh_inc = mcycleh + _T_114; // @[dec_tlu_ctl.scala 1548:28]
  wire  _T_117 = wr_mcycleh_r | perfmux_flop_io_mcyclel_cout_f; // @[dec_tlu_ctl.scala 1551:46]
  wire  _T_120 = io_ebreak_r | io_ecall_r; // @[dec_tlu_ctl.scala 1565:74]
  wire  _T_121 = _T_120 | io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 1565:87]
  wire  _T_122 = _T_121 | io_illegal_r; // @[dec_tlu_ctl.scala 1565:115]
  wire  _T_124 = _T_122 | mcountinhibit[2]; // @[dec_tlu_ctl.scala 1565:130]
  wire  _T_125 = ~_T_124; // @[dec_tlu_ctl.scala 1565:60]
  wire  i0_valid_no_ebreak_ecall_r = io_dec_tlu_i0_valid_r & _T_125; // @[dec_tlu_ctl.scala 1565:58]
  wire  _T_128 = io_dec_csr_wraddr_r == 12'hb02; // @[dec_tlu_ctl.scala 1567:73]
  wire  wr_minstretl_r = io_dec_csr_wen_r_mod & _T_128; // @[dec_tlu_ctl.scala 1567:44]
  reg [23:0] _T_150; // @[Reg.scala 27:20]
  reg [7:0] _T_153; // @[Reg.scala 27:20]
  wire [31:0] minstretl = {_T_150,_T_153}; // @[Cat.scala 29:58]
  wire [8:0] minstretl_inc1 = minstretl[7:0] + 8'h1; // @[dec_tlu_ctl.scala 1571:35]
  wire [23:0] _T_134 = {23'h0,minstretl_inc1[8]}; // @[Cat.scala 29:58]
  wire [24:0] minstretl_inc2 = minstretl[31:8] + _T_134; // @[dec_tlu_ctl.scala 1572:36]
  wire  minstretl_cout = minstretl_inc2[24]; // @[dec_tlu_ctl.scala 1573:37]
  wire [32:0] minstretl_inc = {minstretl_inc2,minstretl_inc1[7:0]}; // @[Cat.scala 29:58]
  wire  _T_138 = i0_valid_no_ebreak_ecall_r & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 1575:52]
  wire  minstret_enable = _T_138 | wr_minstretl_r; // @[dec_tlu_ctl.scala 1575:76]
  wire  _T_156 = io_dec_csr_wraddr_r == 12'hb82; // @[dec_tlu_ctl.scala 1589:71]
  wire  wr_minstreth_r = io_dec_csr_wen_r_mod & _T_156; // @[dec_tlu_ctl.scala 1589:42]
  wire  _T_139 = ~wr_minstreth_r; // @[dec_tlu_ctl.scala 1576:43]
  wire  _T_140 = minstretl_cout & _T_139; // @[dec_tlu_ctl.scala 1576:41]
  wire  _T_141 = _T_140 & i0_valid_no_ebreak_ecall_r; // @[dec_tlu_ctl.scala 1576:59]
  wire  _T_142 = ~io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 1576:90]
  wire [31:0] minstretl_ns = wr_minstretl_r ? io_dec_csr_wrdata_r : minstretl_inc[31:0]; // @[dec_tlu_ctl.scala 1577:24]
  wire  _T_147 = minstretl_inc1[8] & minstret_enable; // @[dec_tlu_ctl.scala 1579:81]
  wire  _T_148 = wr_minstretl_r | _T_147; // @[dec_tlu_ctl.scala 1579:60]
  wire [31:0] _T_159 = {31'h0,perfmux_flop_io_minstretl_cout_f}; // @[Cat.scala 29:58]
  reg [31:0] minstreth; // @[Reg.scala 27:20]
  wire [31:0] minstreth_inc = minstreth + _T_159; // @[dec_tlu_ctl.scala 1593:32]
  wire  _T_162 = perfmux_flop_io_minstret_enable_f & perfmux_flop_io_minstretl_cout_f; // @[dec_tlu_ctl.scala 1596:72]
  wire  _T_163 = _T_162 | wr_minstreth_r; // @[dec_tlu_ctl.scala 1596:109]
  wire  _T_167 = io_dec_csr_wraddr_r == 12'h340; // @[dec_tlu_ctl.scala 1604:72]
  wire  wr_mscratch_r = io_dec_csr_wen_r_mod & _T_167; // @[dec_tlu_ctl.scala 1604:43]
  reg [31:0] mscratch; // @[Reg.scala 27:20]
  wire  _T_171 = ~io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 1615:47]
  wire  _T_172 = _T_142 & _T_171; // @[dec_tlu_ctl.scala 1615:45]
  wire  sel_exu_npc_r = _T_172 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 1615:72]
  wire  _T_174 = _T_142 & io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 1616:47]
  wire  _T_175 = ~io_dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 1616:75]
  wire  sel_flush_npc_r = _T_174 & _T_175; // @[dec_tlu_ctl.scala 1616:73]
  wire  _T_176 = ~sel_exu_npc_r; // @[dec_tlu_ctl.scala 1617:23]
  wire  _T_177 = ~sel_flush_npc_r; // @[dec_tlu_ctl.scala 1617:40]
  wire  sel_hold_npc_r = _T_176 & _T_177; // @[dec_tlu_ctl.scala 1617:38]
  wire  _T_179 = ~io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 1621:13]
  wire  _T_180 = _T_179 & io_reset_delayed; // @[dec_tlu_ctl.scala 1621:35]
  wire [30:0] _T_184 = sel_exu_npc_r ? io_exu_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_185 = _T_180 ? io_rst_vec : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_186 = sel_flush_npc_r ? io_tlu_flush_path_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_187 = sel_hold_npc_r ? io_npc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_188 = _T_184 | _T_185; // @[Mux.scala 27:72]
  wire [30:0] _T_189 = _T_188 | _T_186; // @[Mux.scala 27:72]
  wire  _T_192 = sel_exu_npc_r | sel_flush_npc_r; // @[dec_tlu_ctl.scala 1625:51]
  wire  _T_193 = _T_192 | io_reset_delayed; // @[dec_tlu_ctl.scala 1625:69]
  reg [30:0] _T_196; // @[Reg.scala 27:20]
  wire  pc0_valid_r = _T_142 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 1628:44]
  wire  _T_199 = ~pc0_valid_r; // @[dec_tlu_ctl.scala 1632:22]
  wire [30:0] _T_200 = pc0_valid_r ? io_dec_tlu_i0_pc_r : 31'h0; // @[Mux.scala 27:72]
  reg [30:0] pc_r_d1; // @[Reg.scala 27:20]
  wire [30:0] _T_201 = _T_199 ? pc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] pc_r = _T_200 | _T_201; // @[Mux.scala 27:72]
  wire  _T_206 = io_dec_csr_wraddr_r == 12'h341; // @[dec_tlu_ctl.scala 1636:68]
  wire  wr_mepc_r = io_dec_csr_wen_r_mod & _T_206; // @[dec_tlu_ctl.scala 1636:39]
  wire  _T_207 = io_i0_exception_valid_r | io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 1639:27]
  wire  _T_208 = _T_207 | io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 1639:48]
  wire  _T_212 = wr_mepc_r & _T_17; // @[dec_tlu_ctl.scala 1641:13]
  wire  _T_215 = ~wr_mepc_r; // @[dec_tlu_ctl.scala 1642:3]
  wire  _T_217 = _T_215 & _T_17; // @[dec_tlu_ctl.scala 1642:14]
  wire [30:0] _T_219 = _T_208 ? pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_220 = io_interrupt_valid_r ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_221 = _T_212 ? io_dec_csr_wrdata_r[31:1] : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_222 = _T_217 ? io_mepc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_223 = _T_219 | _T_220; // @[Mux.scala 27:72]
  wire [30:0] _T_224 = _T_223 | _T_221; // @[Mux.scala 27:72]
  wire [30:0] mepc_ns = _T_224 | _T_222; // @[Mux.scala 27:72]
  wire  _T_228 = _T_208 | io_interrupt_valid_r; // @[dec_tlu_ctl.scala 1644:104]
  wire  _T_229 = _T_228 | wr_mepc_r; // @[dec_tlu_ctl.scala 1644:127]
  reg [30:0] _T_231; // @[Reg.scala 27:20]
  wire  _T_233 = io_dec_csr_wraddr_r == 12'h342; // @[dec_tlu_ctl.scala 1651:72]
  wire  wr_mcause_r = io_dec_csr_wen_r_mod & _T_233; // @[dec_tlu_ctl.scala 1651:43]
  wire  _T_234 = io_exc_or_int_valid_r & io_take_nmi; // @[dec_tlu_ctl.scala 1652:53]
  wire  mcause_sel_nmi_store = _T_234 & io_nmi_lsu_store_type; // @[dec_tlu_ctl.scala 1652:67]
  wire  mcause_sel_nmi_load = _T_234 & io_nmi_lsu_load_type; // @[dec_tlu_ctl.scala 1653:66]
  wire  _T_237 = _T_234 & io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 1654:64]
  wire  _T_238 = |io_lsu_fir_error; // @[dec_tlu_ctl.scala 1654:110]
  wire  _T_239 = _T_237 & _T_238; // @[dec_tlu_ctl.scala 1654:91]
  wire  _T_240 = ~io_nmi_int_detected_f; // @[dec_tlu_ctl.scala 1654:116]
  wire  mcause_sel_nmi_ext = _T_239 & _T_240; // @[dec_tlu_ctl.scala 1654:114]
  wire  _T_241 = &io_lsu_fir_error; // @[dec_tlu_ctl.scala 1660:53]
  wire  _T_244 = ~io_lsu_fir_error[0]; // @[dec_tlu_ctl.scala 1660:82]
  wire  _T_245 = io_lsu_fir_error[1] & _T_244; // @[dec_tlu_ctl.scala 1660:80]
  wire [31:0] _T_250 = {30'h3c000400,_T_241,_T_245}; // @[Cat.scala 29:58]
  wire  _T_251 = ~io_take_nmi; // @[dec_tlu_ctl.scala 1666:56]
  wire  _T_252 = io_exc_or_int_valid_r & _T_251; // @[dec_tlu_ctl.scala 1666:54]
  wire [31:0] _T_255 = {io_interrupt_valid_r,26'h0,io_exc_cause_r}; // @[Cat.scala 29:58]
  wire  _T_257 = wr_mcause_r & _T_17; // @[dec_tlu_ctl.scala 1667:44]
  wire  _T_259 = ~wr_mcause_r; // @[dec_tlu_ctl.scala 1668:32]
  wire  _T_261 = _T_259 & _T_17; // @[dec_tlu_ctl.scala 1668:45]
  wire [31:0] _T_263 = mcause_sel_nmi_store ? 32'hf0000000 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_264 = mcause_sel_nmi_load ? 32'hf0000001 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_265 = mcause_sel_nmi_ext ? _T_250 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_266 = _T_252 ? _T_255 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_267 = _T_257 ? io_dec_csr_wrdata_r : 32'h0; // @[Mux.scala 27:72]
  reg [31:0] mcause; // @[Reg.scala 27:20]
  wire [31:0] _T_268 = _T_261 ? mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_269 = _T_263 | _T_264; // @[Mux.scala 27:72]
  wire [31:0] _T_270 = _T_269 | _T_265; // @[Mux.scala 27:72]
  wire [31:0] _T_271 = _T_270 | _T_266; // @[Mux.scala 27:72]
  wire [31:0] _T_272 = _T_271 | _T_267; // @[Mux.scala 27:72]
  wire [31:0] mcause_ns = _T_272 | _T_268; // @[Mux.scala 27:72]
  wire  _T_274 = io_exc_or_int_valid_r | wr_mcause_r; // @[dec_tlu_ctl.scala 1670:54]
  wire  _T_278 = io_dec_csr_wraddr_r == 12'h7ff; // @[dec_tlu_ctl.scala 1677:71]
  wire  wr_mscause_r = io_dec_csr_wen_r_mod & _T_278; // @[dec_tlu_ctl.scala 1677:42]
  wire  _T_279 = io_dec_tlu_packet_r_icaf_type == 2'h0; // @[dec_tlu_ctl.scala 1679:56]
  wire [3:0] _T_280 = {2'h0,io_dec_tlu_packet_r_icaf_type}; // @[Cat.scala 29:58]
  wire [3:0] ifu_mscause = _T_279 ? 4'h9 : _T_280; // @[dec_tlu_ctl.scala 1679:24]
  wire [3:0] _T_285 = io_lsu_i0_exc_r ? io_lsu_error_pkt_r_bits_mscause : 4'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_287 = io_ebreak_r ? 2'h2 : 2'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_288 = io_inst_acc_r ? ifu_mscause : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _GEN_46 = {{3'd0}, io_i0_trigger_hit_r}; // @[Mux.scala 27:72]
  wire [3:0] _T_289 = _T_285 | _GEN_46; // @[Mux.scala 27:72]
  wire [3:0] _GEN_47 = {{2'd0}, _T_287}; // @[Mux.scala 27:72]
  wire [3:0] _T_290 = _T_289 | _GEN_47; // @[Mux.scala 27:72]
  wire [3:0] mscause_type = _T_290 | _T_288; // @[Mux.scala 27:72]
  wire  _T_294 = wr_mscause_r & _T_17; // @[dec_tlu_ctl.scala 1690:38]
  wire  _T_297 = ~wr_mscause_r; // @[dec_tlu_ctl.scala 1691:25]
  wire  _T_299 = _T_297 & _T_17; // @[dec_tlu_ctl.scala 1691:39]
  wire [3:0] _T_301 = io_exc_or_int_valid_r ? mscause_type : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_302 = _T_294 ? io_dec_csr_wrdata_r[3:0] : 4'h0; // @[Mux.scala 27:72]
  reg [3:0] mscause; // @[dec_tlu_ctl.scala 1693:47]
  wire [3:0] _T_303 = _T_299 ? mscause : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_304 = _T_301 | _T_302; // @[Mux.scala 27:72]
  wire  _T_308 = io_dec_csr_wraddr_r == 12'h343; // @[dec_tlu_ctl.scala 1700:69]
  wire  wr_mtval_r = io_dec_csr_wen_r_mod & _T_308; // @[dec_tlu_ctl.scala 1700:40]
  wire  _T_309 = ~io_inst_acc_second_r; // @[dec_tlu_ctl.scala 1701:83]
  wire  _T_310 = io_inst_acc_r & _T_309; // @[dec_tlu_ctl.scala 1701:81]
  wire  _T_311 = io_ebreak_r | _T_310; // @[dec_tlu_ctl.scala 1701:64]
  wire  _T_312 = _T_311 | io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 1701:106]
  wire  _T_313 = io_exc_or_int_valid_r & _T_312; // @[dec_tlu_ctl.scala 1701:49]
  wire  mtval_capture_pc_r = _T_313 & _T_251; // @[dec_tlu_ctl.scala 1701:138]
  wire  _T_315 = io_inst_acc_r & io_inst_acc_second_r; // @[dec_tlu_ctl.scala 1702:72]
  wire  _T_316 = io_exc_or_int_valid_r & _T_315; // @[dec_tlu_ctl.scala 1702:55]
  wire  mtval_capture_pc_plus2_r = _T_316 & _T_251; // @[dec_tlu_ctl.scala 1702:96]
  wire  _T_318 = io_exc_or_int_valid_r & io_illegal_r; // @[dec_tlu_ctl.scala 1703:51]
  wire  mtval_capture_inst_r = _T_318 & _T_251; // @[dec_tlu_ctl.scala 1703:66]
  wire  _T_320 = io_exc_or_int_valid_r & io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 1704:50]
  wire  mtval_capture_lsu_r = _T_320 & _T_251; // @[dec_tlu_ctl.scala 1704:71]
  wire  _T_322 = ~mtval_capture_pc_r; // @[dec_tlu_ctl.scala 1705:46]
  wire  _T_323 = io_exc_or_int_valid_r & _T_322; // @[dec_tlu_ctl.scala 1705:44]
  wire  _T_324 = ~mtval_capture_inst_r; // @[dec_tlu_ctl.scala 1705:68]
  wire  _T_325 = _T_323 & _T_324; // @[dec_tlu_ctl.scala 1705:66]
  wire  _T_326 = ~mtval_capture_lsu_r; // @[dec_tlu_ctl.scala 1705:92]
  wire  _T_327 = _T_325 & _T_326; // @[dec_tlu_ctl.scala 1705:90]
  wire  _T_328 = ~io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 1705:115]
  wire  mtval_clear_r = _T_327 & _T_328; // @[dec_tlu_ctl.scala 1705:113]
  wire [31:0] _T_330 = {pc_r,1'h0}; // @[Cat.scala 29:58]
  wire [30:0] _T_333 = pc_r + 31'h1; // @[dec_tlu_ctl.scala 1710:83]
  wire [31:0] _T_334 = {_T_333,1'h0}; // @[Cat.scala 29:58]
  wire  _T_337 = ~io_interrupt_valid_r; // @[dec_tlu_ctl.scala 1713:18]
  wire  _T_338 = wr_mtval_r & _T_337; // @[dec_tlu_ctl.scala 1713:16]
  wire  _T_341 = ~wr_mtval_r; // @[dec_tlu_ctl.scala 1714:20]
  wire  _T_342 = _T_251 & _T_341; // @[dec_tlu_ctl.scala 1714:18]
  wire  _T_344 = _T_342 & _T_322; // @[dec_tlu_ctl.scala 1714:32]
  wire  _T_346 = _T_344 & _T_324; // @[dec_tlu_ctl.scala 1714:54]
  wire  _T_347 = ~mtval_clear_r; // @[dec_tlu_ctl.scala 1714:80]
  wire  _T_348 = _T_346 & _T_347; // @[dec_tlu_ctl.scala 1714:78]
  wire  _T_350 = _T_348 & _T_326; // @[dec_tlu_ctl.scala 1714:95]
  wire [31:0] _T_352 = mtval_capture_pc_r ? _T_330 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_353 = mtval_capture_pc_plus2_r ? _T_334 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_354 = mtval_capture_inst_r ? io_dec_illegal_inst : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_355 = mtval_capture_lsu_r ? io_lsu_error_pkt_addr_r : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_356 = _T_338 ? io_dec_csr_wrdata_r : 32'h0; // @[Mux.scala 27:72]
  reg [31:0] mtval; // @[Reg.scala 27:20]
  wire [31:0] _T_357 = _T_350 ? mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_358 = _T_352 | _T_353; // @[Mux.scala 27:72]
  wire [31:0] _T_359 = _T_358 | _T_354; // @[Mux.scala 27:72]
  wire [31:0] _T_360 = _T_359 | _T_355; // @[Mux.scala 27:72]
  wire [31:0] _T_361 = _T_360 | _T_356; // @[Mux.scala 27:72]
  wire [31:0] mtval_ns = _T_361 | _T_357; // @[Mux.scala 27:72]
  wire  _T_363 = io_tlu_flush_lower_r | wr_mtval_r; // @[dec_tlu_ctl.scala 1716:48]
  wire  _T_367 = io_dec_csr_wraddr_r == 12'h7f8; // @[dec_tlu_ctl.scala 1733:68]
  wire  wr_mcgc_r = io_dec_csr_wen_r_mod & _T_367; // @[dec_tlu_ctl.scala 1733:39]
  wire  _T_370 = ~io_dec_csr_wrdata_r[9]; // @[dec_tlu_ctl.scala 1734:42]
  wire [9:0] _T_372 = {_T_370,io_dec_csr_wrdata_r[8:0]}; // @[Cat.scala 29:58]
  reg [9:0] mcgc_int; // @[Reg.scala 27:20]
  wire  _T_376 = ~mcgc_int[9]; // @[dec_tlu_ctl.scala 1736:24]
  wire [9:0] mcgc = {_T_376,mcgc_int[8:0]}; // @[Cat.scala 29:58]
  wire  _T_388 = io_dec_csr_wraddr_r == 12'h7f9; // @[dec_tlu_ctl.scala 1767:68]
  wire  wr_mfdc_r = io_dec_csr_wen_r_mod & _T_388; // @[dec_tlu_ctl.scala 1767:39]
  reg [15:0] mfdc_int; // @[Reg.scala 27:20]
  wire [2:0] _T_392 = ~io_dec_csr_wrdata_r[18:16]; // @[dec_tlu_ctl.scala 1777:20]
  wire  _T_396 = ~io_dec_csr_wrdata_r[6]; // @[dec_tlu_ctl.scala 1777:99]
  wire [15:0] mfdc_ns = {_T_392,io_dec_csr_wrdata_r[12],io_dec_csr_wrdata_r[11:7],_T_396,io_dec_csr_wrdata_r[5:0]}; // @[Cat.scala 29:58]
  wire [2:0] _T_403 = ~mfdc_int[15:13]; // @[dec_tlu_ctl.scala 1778:20]
  wire  _T_407 = ~mfdc_int[6]; // @[dec_tlu_ctl.scala 1778:76]
  wire [18:0] mfdc = {_T_403,3'h0,mfdc_int[12],mfdc_int[11:7],_T_407,mfdc_int[5:0]}; // @[Cat.scala 29:58]
  wire  _T_423 = io_dec_csr_wraddr_r == 12'h7c2; // @[dec_tlu_ctl.scala 1803:77]
  wire  _T_424 = io_dec_csr_wen_r_mod & _T_423; // @[dec_tlu_ctl.scala 1803:48]
  wire  _T_426 = _T_424 & _T_337; // @[dec_tlu_ctl.scala 1803:87]
  wire  _T_427 = ~io_take_ext_int_start; // @[dec_tlu_ctl.scala 1803:113]
  wire  _T_430 = io_dec_csr_wraddr_r == 12'h7c0; // @[dec_tlu_ctl.scala 1810:68]
  wire  wr_mrac_r = io_dec_csr_wen_r_mod & _T_430; // @[dec_tlu_ctl.scala 1810:39]
  wire  _T_434 = ~io_dec_csr_wrdata_r[31]; // @[dec_tlu_ctl.scala 1813:71]
  wire  _T_435 = io_dec_csr_wrdata_r[30] & _T_434; // @[dec_tlu_ctl.scala 1813:69]
  wire  _T_439 = ~io_dec_csr_wrdata_r[29]; // @[dec_tlu_ctl.scala 1814:73]
  wire  _T_440 = io_dec_csr_wrdata_r[28] & _T_439; // @[dec_tlu_ctl.scala 1814:71]
  wire  _T_444 = ~io_dec_csr_wrdata_r[27]; // @[dec_tlu_ctl.scala 1815:73]
  wire  _T_445 = io_dec_csr_wrdata_r[26] & _T_444; // @[dec_tlu_ctl.scala 1815:71]
  wire  _T_449 = ~io_dec_csr_wrdata_r[25]; // @[dec_tlu_ctl.scala 1816:73]
  wire  _T_450 = io_dec_csr_wrdata_r[24] & _T_449; // @[dec_tlu_ctl.scala 1816:71]
  wire  _T_454 = ~io_dec_csr_wrdata_r[23]; // @[dec_tlu_ctl.scala 1817:73]
  wire  _T_455 = io_dec_csr_wrdata_r[22] & _T_454; // @[dec_tlu_ctl.scala 1817:71]
  wire  _T_459 = ~io_dec_csr_wrdata_r[21]; // @[dec_tlu_ctl.scala 1818:73]
  wire  _T_460 = io_dec_csr_wrdata_r[20] & _T_459; // @[dec_tlu_ctl.scala 1818:71]
  wire  _T_464 = ~io_dec_csr_wrdata_r[19]; // @[dec_tlu_ctl.scala 1819:73]
  wire  _T_465 = io_dec_csr_wrdata_r[18] & _T_464; // @[dec_tlu_ctl.scala 1819:71]
  wire  _T_469 = ~io_dec_csr_wrdata_r[17]; // @[dec_tlu_ctl.scala 1820:73]
  wire  _T_470 = io_dec_csr_wrdata_r[16] & _T_469; // @[dec_tlu_ctl.scala 1820:71]
  wire  _T_474 = ~io_dec_csr_wrdata_r[15]; // @[dec_tlu_ctl.scala 1821:73]
  wire  _T_475 = io_dec_csr_wrdata_r[14] & _T_474; // @[dec_tlu_ctl.scala 1821:71]
  wire  _T_479 = ~io_dec_csr_wrdata_r[13]; // @[dec_tlu_ctl.scala 1822:73]
  wire  _T_480 = io_dec_csr_wrdata_r[12] & _T_479; // @[dec_tlu_ctl.scala 1822:71]
  wire  _T_484 = ~io_dec_csr_wrdata_r[11]; // @[dec_tlu_ctl.scala 1823:73]
  wire  _T_485 = io_dec_csr_wrdata_r[10] & _T_484; // @[dec_tlu_ctl.scala 1823:71]
  wire  _T_490 = io_dec_csr_wrdata_r[8] & _T_370; // @[dec_tlu_ctl.scala 1824:70]
  wire  _T_494 = ~io_dec_csr_wrdata_r[7]; // @[dec_tlu_ctl.scala 1825:73]
  wire  _T_495 = io_dec_csr_wrdata_r[6] & _T_494; // @[dec_tlu_ctl.scala 1825:70]
  wire  _T_499 = ~io_dec_csr_wrdata_r[5]; // @[dec_tlu_ctl.scala 1826:73]
  wire  _T_500 = io_dec_csr_wrdata_r[4] & _T_499; // @[dec_tlu_ctl.scala 1826:70]
  wire  _T_504 = ~io_dec_csr_wrdata_r[3]; // @[dec_tlu_ctl.scala 1827:73]
  wire  _T_505 = io_dec_csr_wrdata_r[2] & _T_504; // @[dec_tlu_ctl.scala 1827:70]
  wire  _T_510 = io_dec_csr_wrdata_r[0] & _T_566; // @[dec_tlu_ctl.scala 1828:70]
  wire [7:0] _T_517 = {io_dec_csr_wrdata_r[7],_T_495,io_dec_csr_wrdata_r[5],_T_500,io_dec_csr_wrdata_r[3],_T_505,io_dec_csr_wrdata_r[1],_T_510}; // @[Cat.scala 29:58]
  wire [15:0] _T_525 = {io_dec_csr_wrdata_r[15],_T_475,io_dec_csr_wrdata_r[13],_T_480,io_dec_csr_wrdata_r[11],_T_485,io_dec_csr_wrdata_r[9],_T_490,_T_517}; // @[Cat.scala 29:58]
  wire [7:0] _T_532 = {io_dec_csr_wrdata_r[23],_T_455,io_dec_csr_wrdata_r[21],_T_460,io_dec_csr_wrdata_r[19],_T_465,io_dec_csr_wrdata_r[17],_T_470}; // @[Cat.scala 29:58]
  wire [31:0] mrac_in = {io_dec_csr_wrdata_r[31],_T_435,io_dec_csr_wrdata_r[29],_T_440,io_dec_csr_wrdata_r[27],_T_445,io_dec_csr_wrdata_r[25],_T_450,_T_532,_T_525}; // @[Cat.scala 29:58]
  reg [31:0] mrac; // @[Reg.scala 27:20]
  wire  _T_543 = io_dec_csr_wraddr_r == 12'hbc0; // @[dec_tlu_ctl.scala 1841:69]
  wire  wr_mdeau_r = io_dec_csr_wen_r_mod & _T_543; // @[dec_tlu_ctl.scala 1841:40]
  wire  _T_544 = ~wr_mdeau_r; // @[dec_tlu_ctl.scala 1851:59]
  wire  _T_545 = io_mdseac_locked_f & _T_544; // @[dec_tlu_ctl.scala 1851:57]
  wire  _T_547 = io_lsu_imprecise_error_store_any | io_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 1853:49]
  wire  _T_549 = _T_547 & _T_240; // @[dec_tlu_ctl.scala 1853:84]
  wire  _T_550 = ~io_mdseac_locked_f; // @[dec_tlu_ctl.scala 1853:111]
  wire  mdseac_en = _T_549 & _T_550; // @[dec_tlu_ctl.scala 1853:109]
  reg [31:0] mdseac; // @[Reg.scala 27:20]
  wire  _T_556 = wr_mpmc_r & io_dec_csr_wrdata_r[0]; // @[dec_tlu_ctl.scala 1868:30]
  wire  _T_557 = ~io_internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 1868:57]
  wire  _T_558 = _T_556 & _T_557; // @[dec_tlu_ctl.scala 1868:55]
  wire  _T_559 = ~io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 1868:89]
  wire  _T_572 = io_dec_csr_wrdata_r[31:27] > 5'h1a; // @[dec_tlu_ctl.scala 1886:48]
  wire [4:0] csr_sat = _T_572 ? 5'h1a : io_dec_csr_wrdata_r[31:27]; // @[dec_tlu_ctl.scala 1886:19]
  wire  _T_575 = io_dec_csr_wraddr_r == 12'h7f0; // @[dec_tlu_ctl.scala 1888:70]
  wire  wr_micect_r = io_dec_csr_wen_r_mod & _T_575; // @[dec_tlu_ctl.scala 1888:41]
  wire [26:0] _T_576 = {26'h0,io_ic_perr_r}; // @[Cat.scala 29:58]
  wire [31:0] _GEN_48 = {{5'd0}, _T_576}; // @[dec_tlu_ctl.scala 1889:23]
  wire [31:0] _T_578 = micect + _GEN_48; // @[dec_tlu_ctl.scala 1889:23]
  wire [31:0] _T_581 = {csr_sat,io_dec_csr_wrdata_r[26:0]}; // @[Cat.scala 29:58]
  wire [26:0] micect_inc = _T_578[26:0]; // @[dec_tlu_ctl.scala 1889:13]
  wire [31:0] _T_583 = {micect[31:27],micect_inc}; // @[Cat.scala 29:58]
  wire  _T_584 = wr_micect_r | io_ic_perr_r; // @[dec_tlu_ctl.scala 1892:42]
  wire  _T_594 = io_dec_csr_wraddr_r == 12'h7f1; // @[dec_tlu_ctl.scala 1903:76]
  wire  wr_miccmect_r = io_dec_csr_wen_r_mod & _T_594; // @[dec_tlu_ctl.scala 1903:47]
  wire  _T_596 = io_iccm_sbecc_r | io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 1904:67]
  wire [26:0] _T_597 = {26'h0,_T_596}; // @[Cat.scala 29:58]
  wire [26:0] miccmect_inc = miccmect[26:0] + _T_597; // @[dec_tlu_ctl.scala 1904:33]
  wire [31:0] _T_604 = {miccmect[31:27],miccmect_inc}; // @[Cat.scala 29:58]
  wire  _T_605 = wr_miccmect_r | io_iccm_sbecc_r; // @[dec_tlu_ctl.scala 1907:48]
  wire  _T_606 = _T_605 | io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 1907:66]
  wire  _T_616 = io_dec_csr_wraddr_r == 12'h7f2; // @[dec_tlu_ctl.scala 1918:76]
  wire  wr_mdccmect_r = io_dec_csr_wen_r_mod & _T_616; // @[dec_tlu_ctl.scala 1918:47]
  wire [26:0] _T_618 = {26'h0,perfmux_flop_io_lsu_single_ecc_error_r_d1}; // @[Cat.scala 29:58]
  wire [26:0] mdccmect_inc = mdccmect[26:0] + _T_618; // @[dec_tlu_ctl.scala 1919:33]
  wire [31:0] _T_625 = {mdccmect[31:27],mdccmect_inc}; // @[Cat.scala 29:58]
  wire  _T_626 = wr_mdccmect_r | perfmux_flop_io_lsu_single_ecc_error_r_d1; // @[dec_tlu_ctl.scala 1922:49]
  wire  _T_636 = io_dec_csr_wraddr_r == 12'h7ce; // @[dec_tlu_ctl.scala 1934:69]
  wire  wr_mfdht_r = io_dec_csr_wen_r_mod & _T_636; // @[dec_tlu_ctl.scala 1934:40]
  reg [5:0] mfdht; // @[Reg.scala 27:20]
  wire  _T_642 = io_dec_csr_wraddr_r == 12'h7cf; // @[dec_tlu_ctl.scala 1947:69]
  wire  wr_mfdhs_r = io_dec_csr_wen_r_mod & _T_642; // @[dec_tlu_ctl.scala 1947:40]
  wire  _T_645 = ~io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 1950:43]
  wire  _T_646 = io_dbg_tlu_halted & _T_645; // @[dec_tlu_ctl.scala 1950:41]
  wire  _T_648 = ~io_lsu_idle_any_f; // @[dec_tlu_ctl.scala 1950:78]
  wire  _T_649 = ~io_ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 1950:98]
  wire [1:0] _T_650 = {_T_648,_T_649}; // @[Cat.scala 29:58]
  reg [1:0] mfdhs; // @[Reg.scala 27:20]
  wire  _T_652 = wr_mfdhs_r | io_dbg_tlu_halted; // @[dec_tlu_ctl.scala 1952:69]
  reg [31:0] force_halt_ctr_f; // @[Reg.scala 27:20]
  wire [31:0] _T_657 = force_halt_ctr_f + 32'h1; // @[dec_tlu_ctl.scala 1954:74]
  wire [62:0] _T_664 = 63'hffffffff << mfdht[5:1]; // @[dec_tlu_ctl.scala 1959:71]
  wire [62:0] _GEN_49 = {{31'd0}, force_halt_ctr_f}; // @[dec_tlu_ctl.scala 1959:48]
  wire [62:0] _T_665 = _GEN_49 & _T_664; // @[dec_tlu_ctl.scala 1959:48]
  wire  _T_666 = |_T_665; // @[dec_tlu_ctl.scala 1959:87]
  wire  _T_669 = io_dec_csr_wraddr_r == 12'hbc8; // @[dec_tlu_ctl.scala 1967:69]
  wire  wr_meivt_r = io_dec_csr_wen_r_mod & _T_669; // @[dec_tlu_ctl.scala 1967:40]
  reg [21:0] meivt; // @[Reg.scala 27:20]
  wire  _T_687 = io_dec_csr_wraddr_r == 12'hbca; // @[dec_tlu_ctl.scala 2018:69]
  wire  _T_688 = io_dec_csr_wen_r_mod & _T_687; // @[dec_tlu_ctl.scala 2018:40]
  wire  wr_meicpct_r = _T_688 | io_take_ext_int_start; // @[dec_tlu_ctl.scala 2018:83]
  reg [7:0] meihap; // @[Reg.scala 27:20]
  wire  _T_675 = io_dec_csr_wraddr_r == 12'hbcc; // @[dec_tlu_ctl.scala 1991:72]
  wire  wr_meicurpl_r = io_dec_csr_wen_r_mod & _T_675; // @[dec_tlu_ctl.scala 1991:43]
  reg [3:0] meicurpl; // @[dec_tlu_ctl.scala 1994:46]
  wire  _T_680 = io_dec_csr_wraddr_r == 12'hbcb; // @[dec_tlu_ctl.scala 2006:73]
  wire  _T_681 = io_dec_csr_wen_r_mod & _T_680; // @[dec_tlu_ctl.scala 2006:44]
  wire  wr_meicidpl_r = _T_681 | io_take_ext_int_start; // @[dec_tlu_ctl.scala 2006:88]
  wire [3:0] _T_685 = wr_meicidpl_r ? io_dec_csr_wrdata_r[3:0] : perfmux_flop_io_meicidpl; // @[dec_tlu_ctl.scala 2009:23]
  wire  _T_691 = io_dec_csr_wraddr_r == 12'hbc9; // @[dec_tlu_ctl.scala 2027:69]
  wire  wr_meipt_r = io_dec_csr_wen_r_mod & _T_691; // @[dec_tlu_ctl.scala 2027:40]
  reg [3:0] meipt; // @[dec_tlu_ctl.scala 2030:43]
  wire  _T_695 = io_trigger_hit_r_d1 & io_dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 2058:89]
  wire  trigger_hit_for_dscr_cause_r_d1 = io_trigger_hit_dmode_r_d1 | _T_695; // @[dec_tlu_ctl.scala 2058:66]
  wire  _T_696 = ~io_ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 2061:31]
  wire  _T_697 = io_dcsr_single_step_done_f & _T_696; // @[dec_tlu_ctl.scala 2061:29]
  wire  _T_698 = ~trigger_hit_for_dscr_cause_r_d1; // @[dec_tlu_ctl.scala 2061:63]
  wire  _T_699 = _T_697 & _T_698; // @[dec_tlu_ctl.scala 2061:61]
  wire  _T_700 = ~io_debug_halt_req; // @[dec_tlu_ctl.scala 2061:98]
  wire  _T_701 = _T_699 & _T_700; // @[dec_tlu_ctl.scala 2061:96]
  wire  _T_704 = io_debug_halt_req & _T_696; // @[dec_tlu_ctl.scala 2062:46]
  wire  _T_706 = _T_704 & _T_698; // @[dec_tlu_ctl.scala 2062:78]
  wire  _T_709 = io_ebreak_to_debug_mode_r_d1 & _T_698; // @[dec_tlu_ctl.scala 2063:75]
  wire [2:0] _T_712 = _T_701 ? 3'h4 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_713 = _T_706 ? 3'h3 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_714 = _T_709 ? 3'h1 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_715 = trigger_hit_for_dscr_cause_r_d1 ? 3'h2 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_716 = _T_712 | _T_713; // @[Mux.scala 27:72]
  wire [2:0] _T_717 = _T_716 | _T_714; // @[Mux.scala 27:72]
  wire [2:0] dcsr_cause = _T_717 | _T_715; // @[Mux.scala 27:72]
  wire  _T_719 = io_allow_dbg_halt_csr_write & io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 2066:46]
  wire  _T_721 = io_dec_csr_wraddr_r == 12'h7b0; // @[dec_tlu_ctl.scala 2066:98]
  wire  wr_dcsr_r = _T_719 & _T_721; // @[dec_tlu_ctl.scala 2066:69]
  wire  _T_723 = io_dcsr[8:6] == 3'h3; // @[dec_tlu_ctl.scala 2072:75]
  wire  dcsr_cause_upgradeable = io_internal_dbg_halt_mode_f & _T_723; // @[dec_tlu_ctl.scala 2072:59]
  wire  _T_724 = ~io_dbg_tlu_halted; // @[dec_tlu_ctl.scala 2073:59]
  wire  _T_725 = _T_724 | dcsr_cause_upgradeable; // @[dec_tlu_ctl.scala 2073:78]
  wire  enter_debug_halt_req_le = io_enter_debug_halt_req & _T_725; // @[dec_tlu_ctl.scala 2073:56]
  wire  nmi_in_debug_mode = io_nmi_int_detected_f & io_internal_dbg_halt_mode_f; // @[dec_tlu_ctl.scala 2075:48]
  wire [15:0] _T_731 = {io_dcsr[15:9],dcsr_cause,io_dcsr[5:2],2'h3}; // @[Cat.scala 29:58]
  wire  _T_737 = nmi_in_debug_mode | io_dcsr[3]; // @[dec_tlu_ctl.scala 2077:145]
  wire [15:0] _T_746 = {io_dec_csr_wrdata_r[15],3'h0,io_dec_csr_wrdata_r[11:10],1'h0,io_dcsr[8:6],2'h0,_T_737,io_dec_csr_wrdata_r[2],2'h3}; // @[Cat.scala 29:58]
  wire [15:0] _T_751 = {io_dcsr[15:4],nmi_in_debug_mode,io_dcsr[2],2'h3}; // @[Cat.scala 29:58]
  wire  _T_753 = enter_debug_halt_req_le | wr_dcsr_r; // @[dec_tlu_ctl.scala 2079:54]
  wire  _T_754 = _T_753 | io_internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 2079:66]
  wire  _T_755 = _T_754 | io_take_nmi; // @[dec_tlu_ctl.scala 2079:94]
  reg [15:0] _T_757; // @[Reg.scala 27:20]
  wire  _T_760 = io_dec_csr_wraddr_r == 12'h7b1; // @[dec_tlu_ctl.scala 2087:97]
  wire  wr_dpc_r = _T_719 & _T_760; // @[dec_tlu_ctl.scala 2087:68]
  wire  _T_763 = ~io_request_debug_mode_done; // @[dec_tlu_ctl.scala 2088:67]
  wire  dpc_capture_npc = _T_646 & _T_763; // @[dec_tlu_ctl.scala 2088:65]
  wire  _T_764 = ~io_request_debug_mode_r; // @[dec_tlu_ctl.scala 2092:21]
  wire  _T_765 = ~dpc_capture_npc; // @[dec_tlu_ctl.scala 2092:39]
  wire  _T_766 = _T_764 & _T_765; // @[dec_tlu_ctl.scala 2092:37]
  wire  _T_767 = _T_766 & wr_dpc_r; // @[dec_tlu_ctl.scala 2092:56]
  wire  _T_772 = _T_764 & dpc_capture_npc; // @[dec_tlu_ctl.scala 2094:49]
  wire [30:0] _T_774 = _T_767 ? io_dec_csr_wrdata_r[31:1] : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_775 = io_request_debug_mode_r ? pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_776 = _T_772 ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_777 = _T_774 | _T_775; // @[Mux.scala 27:72]
  wire [30:0] dpc_ns = _T_777 | _T_776; // @[Mux.scala 27:72]
  wire  _T_779 = wr_dpc_r | io_request_debug_mode_r; // @[dec_tlu_ctl.scala 2096:36]
  wire  _T_780 = _T_779 | dpc_capture_npc; // @[dec_tlu_ctl.scala 2096:53]
  reg [30:0] _T_782; // @[Reg.scala 27:20]
  wire [16:0] dicawics_ns = {io_dec_csr_wrdata_r[24],io_dec_csr_wrdata_r[21:20],io_dec_csr_wrdata_r[16:3]}; // @[Cat.scala 29:58]
  wire  _T_789 = io_dec_csr_wraddr_r == 12'h7c8; // @[dec_tlu_ctl.scala 2111:102]
  wire  wr_dicawics_r = _T_719 & _T_789; // @[dec_tlu_ctl.scala 2111:73]
  reg [16:0] dicawics; // @[Reg.scala 27:20]
  wire  _T_793 = io_dec_csr_wraddr_r == 12'h7c9; // @[dec_tlu_ctl.scala 2129:100]
  wire  wr_dicad0_r = _T_719 & _T_793; // @[dec_tlu_ctl.scala 2129:71]
  wire  _T_796 = wr_dicad0_r | io_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 2132:46]
  reg [31:0] dicad0; // @[Reg.scala 27:20]
  wire  _T_800 = io_dec_csr_wraddr_r == 12'h7cc; // @[dec_tlu_ctl.scala 2142:101]
  wire  wr_dicad0h_r = _T_719 & _T_800; // @[dec_tlu_ctl.scala 2142:72]
  wire  _T_803 = wr_dicad0h_r | io_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 2146:48]
  reg [31:0] dicad0h; // @[Reg.scala 27:20]
  wire  _T_808 = io_dec_csr_wraddr_r == 12'h7ca; // @[dec_tlu_ctl.scala 2154:100]
  wire  _T_809 = _T_719 & _T_808; // @[dec_tlu_ctl.scala 2154:71]
  wire  _T_814 = _T_809 | io_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 2158:46]
  reg [6:0] _T_816; // @[Reg.scala 27:20]
  wire [31:0] dicad1 = {25'h0,_T_816}; // @[Cat.scala 29:58]
  wire [38:0] _T_821 = {dicad1[6:0],dicad0h}; // @[Cat.scala 29:58]
  wire  _T_823 = io_allow_dbg_halt_csr_write & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 2186:52]
  wire  _T_824 = _T_823 & io_dec_i0_decode_d; // @[dec_tlu_ctl.scala 2186:75]
  wire  _T_825 = ~io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 2186:98]
  wire  _T_826 = _T_824 & _T_825; // @[dec_tlu_ctl.scala 2186:96]
  wire  _T_828 = io_dec_csr_rdaddr_d == 12'h7cb; // @[dec_tlu_ctl.scala 2186:149]
  wire  _T_831 = io_dec_csr_wraddr_r == 12'h7cb; // @[dec_tlu_ctl.scala 2187:104]
  wire  _T_833 = io_dec_csr_wraddr_r == 12'h7a0; // @[dec_tlu_ctl.scala 2201:69]
  wire  wr_mtsel_r = io_dec_csr_wen_r_mod & _T_833; // @[dec_tlu_ctl.scala 2201:40]
  reg [1:0] mtsel; // @[dec_tlu_ctl.scala 2204:43]
  wire  tdata_load = io_dec_csr_wrdata_r[0] & _T_464; // @[dec_tlu_ctl.scala 2239:42]
  wire  tdata_opcode = io_dec_csr_wrdata_r[2] & _T_464; // @[dec_tlu_ctl.scala 2241:44]
  wire  _T_844 = io_dec_csr_wrdata_r[27] & io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2243:46]
  wire  tdata_action = _T_844 & io_dec_csr_wrdata_r[12]; // @[dec_tlu_ctl.scala 2243:69]
  wire  _T_852 = io_mtdata1_t_3[9] & _T_444; // @[dec_tlu_ctl.scala 2247:155]
  wire  _T_853 = ~_T_852; // @[dec_tlu_ctl.scala 2247:122]
  wire  _T_854 = io_dec_csr_wrdata_r[11] & _T_853; // @[dec_tlu_ctl.scala 2247:120]
  wire  _T_859 = io_mtdata1_t_1[9] & _T_444; // @[dec_tlu_ctl.scala 2248:197]
  wire  _T_860 = ~_T_859; // @[dec_tlu_ctl.scala 2248:164]
  wire  _T_861 = io_dec_csr_wrdata_r[11] & _T_860; // @[dec_tlu_ctl.scala 2248:162]
  wire  _T_862 = mtsel[1] ? _T_854 : _T_861; // @[dec_tlu_ctl.scala 2247:84]
  wire  tdata_chain = mtsel[0] ? 1'h0 : _T_862; // @[dec_tlu_ctl.scala 2246:30]
  wire  _T_866 = ~io_mtdata1_t_2[9]; // @[dec_tlu_ctl.scala 2251:73]
  wire  _T_868 = _T_866 & io_mtdata1_t_2[5]; // @[dec_tlu_ctl.scala 2251:105]
  wire  _T_869 = io_dec_csr_wrdata_r[27] & _T_868; // @[dec_tlu_ctl.scala 2251:70]
  wire  _T_872 = ~io_mtdata1_t_0[9]; // @[dec_tlu_ctl.scala 2252:181]
  wire  _T_874 = _T_872 & io_mtdata1_t_0[5]; // @[dec_tlu_ctl.scala 2252:213]
  wire  _T_875 = io_dec_csr_wrdata_r[27] & _T_874; // @[dec_tlu_ctl.scala 2252:178]
  wire  tdata_kill_write = mtsel[1] ? _T_869 : _T_875; // @[dec_tlu_ctl.scala 2251:35]
  wire [9:0] tdata_wrdata_r = {_T_844,io_dec_csr_wrdata_r[20:19],tdata_action,tdata_chain,io_dec_csr_wrdata_r[7:6],tdata_opcode,io_dec_csr_wrdata_r[1],tdata_load}; // @[Cat.scala 29:58]
  wire  _T_888 = io_dec_csr_wraddr_r == 12'h7a1; // @[dec_tlu_ctl.scala 2257:120]
  wire  _T_889 = io_dec_csr_wen_r_mod & _T_888; // @[dec_tlu_ctl.scala 2257:91]
  wire  _T_890 = mtsel == 2'h0; // @[dec_tlu_ctl.scala 2257:142]
  wire  _T_891 = _T_889 & _T_890; // @[dec_tlu_ctl.scala 2257:133]
  wire  _T_894 = _T_872 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2257:191]
  wire  wr_mtdata1_t_r_0 = _T_891 & _T_894; // @[dec_tlu_ctl.scala 2257:156]
  wire  _T_899 = mtsel == 2'h1; // @[dec_tlu_ctl.scala 2257:291]
  wire  _T_900 = _T_889 & _T_899; // @[dec_tlu_ctl.scala 2257:282]
  wire  _T_902 = ~io_mtdata1_t_1[9]; // @[dec_tlu_ctl.scala 2257:308]
  wire  _T_903 = ~tdata_kill_write; // @[dec_tlu_ctl.scala 2257:365]
  wire  _T_904 = io_dbg_tlu_halted_f & _T_903; // @[dec_tlu_ctl.scala 2257:363]
  wire  _T_905 = _T_902 | _T_904; // @[dec_tlu_ctl.scala 2257:340]
  wire  wr_mtdata1_t_r_1 = _T_900 & _T_905; // @[dec_tlu_ctl.scala 2257:305]
  wire  _T_910 = mtsel == 2'h2; // @[dec_tlu_ctl.scala 2257:142]
  wire  _T_911 = _T_889 & _T_910; // @[dec_tlu_ctl.scala 2257:133]
  wire  _T_914 = _T_866 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2257:191]
  wire  wr_mtdata1_t_r_2 = _T_911 & _T_914; // @[dec_tlu_ctl.scala 2257:156]
  wire  _T_919 = mtsel == 2'h3; // @[dec_tlu_ctl.scala 2257:291]
  wire  _T_920 = _T_889 & _T_919; // @[dec_tlu_ctl.scala 2257:282]
  wire  _T_922 = ~io_mtdata1_t_3[9]; // @[dec_tlu_ctl.scala 2257:308]
  wire  _T_925 = _T_922 | _T_904; // @[dec_tlu_ctl.scala 2257:340]
  wire  wr_mtdata1_t_r_3 = _T_920 & _T_925; // @[dec_tlu_ctl.scala 2257:305]
  wire  _T_931 = io_update_hit_bit_r[0] | io_mtdata1_t_0[8]; // @[dec_tlu_ctl.scala 2258:141]
  wire [9:0] _T_934 = {io_mtdata1_t_0[9],_T_931,io_mtdata1_t_0[7:0]}; // @[Cat.scala 29:58]
  wire  _T_940 = io_update_hit_bit_r[1] | io_mtdata1_t_1[8]; // @[dec_tlu_ctl.scala 2258:141]
  wire [9:0] _T_943 = {io_mtdata1_t_1[9],_T_940,io_mtdata1_t_1[7:0]}; // @[Cat.scala 29:58]
  wire  _T_949 = io_update_hit_bit_r[2] | io_mtdata1_t_2[8]; // @[dec_tlu_ctl.scala 2258:141]
  wire [9:0] _T_952 = {io_mtdata1_t_2[9],_T_949,io_mtdata1_t_2[7:0]}; // @[Cat.scala 29:58]
  wire  _T_958 = io_update_hit_bit_r[3] | io_mtdata1_t_3[8]; // @[dec_tlu_ctl.scala 2258:141]
  wire [9:0] _T_961 = {io_mtdata1_t_3[9],_T_958,io_mtdata1_t_3[7:0]}; // @[Cat.scala 29:58]
  wire  _T_964 = io_trigger_enabled[0] | wr_mtdata1_t_r_0; // @[dec_tlu_ctl.scala 2260:87]
  reg [9:0] _T_966; // @[Reg.scala 27:20]
  wire  _T_968 = io_trigger_enabled[1] | wr_mtdata1_t_r_1; // @[dec_tlu_ctl.scala 2260:87]
  reg [9:0] _T_970; // @[Reg.scala 27:20]
  wire  _T_972 = io_trigger_enabled[2] | wr_mtdata1_t_r_2; // @[dec_tlu_ctl.scala 2260:87]
  reg [9:0] _T_974; // @[Reg.scala 27:20]
  wire  _T_976 = io_trigger_enabled[3] | wr_mtdata1_t_r_3; // @[dec_tlu_ctl.scala 2260:87]
  reg [9:0] _T_978; // @[Reg.scala 27:20]
  wire [31:0] _T_993 = {4'h2,io_mtdata1_t_0[9],6'h1f,io_mtdata1_t_0[8:7],6'h0,io_mtdata1_t_0[6:5],3'h0,io_mtdata1_t_0[4:3],3'h0,io_mtdata1_t_0[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1008 = {4'h2,io_mtdata1_t_1[9],6'h1f,io_mtdata1_t_1[8:7],6'h0,io_mtdata1_t_1[6:5],3'h0,io_mtdata1_t_1[4:3],3'h0,io_mtdata1_t_1[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1023 = {4'h2,io_mtdata1_t_2[9],6'h1f,io_mtdata1_t_2[8:7],6'h0,io_mtdata1_t_2[6:5],3'h0,io_mtdata1_t_2[4:3],3'h0,io_mtdata1_t_2[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1038 = {4'h2,io_mtdata1_t_3[9],6'h1f,io_mtdata1_t_3[8:7],6'h0,io_mtdata1_t_3[6:5],3'h0,io_mtdata1_t_3[4:3],3'h0,io_mtdata1_t_3[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1039 = _T_890 ? _T_993 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1040 = _T_899 ? _T_1008 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1041 = _T_910 ? _T_1023 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1042 = _T_919 ? _T_1038 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1043 = _T_1039 | _T_1040; // @[Mux.scala 27:72]
  wire [31:0] _T_1044 = _T_1043 | _T_1041; // @[Mux.scala 27:72]
  wire [31:0] mtdata1_tsel_out = _T_1044 | _T_1042; // @[Mux.scala 27:72]
  wire  _T_1071 = io_dec_csr_wraddr_r == 12'h7a2; // @[dec_tlu_ctl.scala 2277:98]
  wire  _T_1072 = io_dec_csr_wen_r_mod & _T_1071; // @[dec_tlu_ctl.scala 2277:69]
  wire  _T_1074 = _T_1072 & _T_890; // @[dec_tlu_ctl.scala 2277:111]
  wire  wr_mtdata2_t_r_0 = _T_1074 & _T_894; // @[dec_tlu_ctl.scala 2277:134]
  wire  _T_1083 = _T_1072 & _T_899; // @[dec_tlu_ctl.scala 2277:111]
  wire  _T_1086 = _T_902 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2277:169]
  wire  wr_mtdata2_t_r_1 = _T_1083 & _T_1086; // @[dec_tlu_ctl.scala 2277:134]
  wire  _T_1092 = _T_1072 & _T_910; // @[dec_tlu_ctl.scala 2277:111]
  wire  wr_mtdata2_t_r_2 = _T_1092 & _T_914; // @[dec_tlu_ctl.scala 2277:134]
  wire  _T_1101 = _T_1072 & _T_919; // @[dec_tlu_ctl.scala 2277:111]
  wire  _T_1104 = _T_922 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2277:169]
  wire  wr_mtdata2_t_r_3 = _T_1101 & _T_1104; // @[dec_tlu_ctl.scala 2277:134]
  reg [31:0] mtdata2_t_0; // @[Reg.scala 27:20]
  reg [31:0] mtdata2_t_1; // @[Reg.scala 27:20]
  reg [31:0] mtdata2_t_2; // @[Reg.scala 27:20]
  reg [31:0] mtdata2_t_3; // @[Reg.scala 27:20]
  wire [31:0] _T_1118 = _T_890 ? mtdata2_t_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1119 = _T_899 ? mtdata2_t_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1120 = _T_910 ? mtdata2_t_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1121 = _T_919 ? mtdata2_t_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1122 = _T_1118 | _T_1119; // @[Mux.scala 27:72]
  wire [31:0] _T_1123 = _T_1122 | _T_1120; // @[Mux.scala 27:72]
  wire [31:0] mtdata2_tsel_out = _T_1123 | _T_1121; // @[Mux.scala 27:72]
  wire  _T_1129 = io_dec_csr_wraddr_r == 12'h320; // @[dec_tlu_ctl.scala 2433:77]
  wire  wr_mcountinhibit_r = io_dec_csr_wen_r_mod & _T_1129; // @[dec_tlu_ctl.scala 2433:48]
  wire  _T_1141 = ~io_dec_tlu_trace_disable; // @[dec_tlu_ctl.scala 2446:42]
  wire  _T_1144 = io_i0_exception_valid_r_d1 | perfmux_flop_io_lsu_i0_exc_r_d1; // @[dec_tlu_ctl.scala 2447:92]
  wire  _T_1145 = ~io_trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 2447:152]
  wire  _T_1146 = io_trigger_hit_r_d1 & _T_1145; // @[dec_tlu_ctl.scala 2447:150]
  wire  _T_1147 = _T_1144 | _T_1146; // @[dec_tlu_ctl.scala 2447:127]
  wire [4:0] _T_1151 = _T_1141 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] dec_tlu_exc_cause_wb1_raw = _T_1151 & io_exc_cause_wb; // @[dec_tlu_ctl.scala 2448:71]
  wire  dec_tlu_int_valid_wb1_raw = _T_1141 & io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 2449:62]
  reg [4:0] dec_tlu_exc_cause_wb2; // @[Reg.scala 27:20]
  wire [4:0] _T_1153 = dec_tlu_exc_cause_wb1_raw ^ dec_tlu_exc_cause_wb2; // @[lib.scala 441:21]
  wire  _T_1154 = |_T_1153; // @[lib.scala 441:29]
  reg  dec_tlu_int_valid_wb2; // @[Reg.scala 27:20]
  wire  _T_1156 = dec_tlu_int_valid_wb1_raw ^ dec_tlu_int_valid_wb2; // @[lib.scala 463:21]
  wire  _T_1157 = |_T_1156; // @[lib.scala 463:29]
  wire [31:0] _T_1165 = {io_core_id,4'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1174 = {21'h3,3'h0,io_mstatus[1],3'h0,io_mstatus[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1179 = {io_mtvec[30:1],1'h0,io_mtvec[0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1192 = {1'h0,io_mip[5:3],16'h0,io_mip[2],3'h0,io_mip[1],3'h0,io_mip[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1205 = {1'h0,mie[5:3],16'h0,mie[2],3'h0,mie[1],3'h0,mie[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1217 = {io_mepc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1222 = {28'h0,mscause}; // @[Cat.scala 29:58]
  wire [31:0] _T_1230 = {meivt,10'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1233 = {meivt,meihap,2'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1236 = {28'h0,meicurpl}; // @[Cat.scala 29:58]
  wire [3:0] _T_1238 = perfmux_flop_io_meicidpl; // @[dec_tlu_ctl.scala 2487:97]
  wire [31:0] _T_1239 = {28'h0,_T_1238}; // @[Cat.scala 29:58]
  wire [31:0] _T_1242 = {28'h0,meipt}; // @[Cat.scala 29:58]
  wire [31:0] _T_1245 = {22'h0,_T_376,mcgc_int[8:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1248 = {13'h0,_T_403,3'h0,mfdc_int[12],mfdc_int[11:7],_T_407,mfdc_int[5:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1252 = {16'h4000,io_dcsr[15:2],2'h3}; // @[Cat.scala 29:58]
  wire [31:0] _T_1254 = {io_dpc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1270 = {7'h0,dicawics[16],2'h0,dicawics[15:14],3'h0,dicawics[13:0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1273 = {30'h0,mtsel}; // @[Cat.scala 29:58]
  wire [31:0] _T_1285 = perf_csrs_io_mhpmc3; // @[dec_tlu_ctl.scala 2503:77]
  wire [31:0] _T_1287 = perf_csrs_io_mhpmc4; // @[dec_tlu_ctl.scala 2504:77]
  wire [31:0] _T_1289 = perf_csrs_io_mhpmc5; // @[dec_tlu_ctl.scala 2505:77]
  wire [31:0] _T_1291 = perf_csrs_io_mhpmc6; // @[dec_tlu_ctl.scala 2506:77]
  wire [31:0] _T_1293 = perf_csrs_io_mhpmc3h; // @[dec_tlu_ctl.scala 2507:78]
  wire [31:0] _T_1295 = perf_csrs_io_mhpmc4h; // @[dec_tlu_ctl.scala 2508:78]
  wire [31:0] _T_1297 = perf_csrs_io_mhpmc5h; // @[dec_tlu_ctl.scala 2509:78]
  wire [31:0] _T_1299 = perf_csrs_io_mhpmc6h; // @[dec_tlu_ctl.scala 2510:78]
  wire [31:0] _T_1302 = {26'h0,mfdht}; // @[Cat.scala 29:58]
  wire [31:0] _T_1305 = {30'h0,mfdhs}; // @[Cat.scala 29:58]
  wire [9:0] _T_1307 = perf_csrs_io_mhpme3; // @[dec_tlu_ctl.scala 2513:92]
  wire [31:0] _T_1308 = {22'h0,_T_1307}; // @[Cat.scala 29:58]
  wire [9:0] _T_1310 = perf_csrs_io_mhpme4; // @[dec_tlu_ctl.scala 2514:92]
  wire [31:0] _T_1311 = {22'h0,_T_1310}; // @[Cat.scala 29:58]
  wire [9:0] _T_1313 = perf_csrs_io_mhpme5; // @[dec_tlu_ctl.scala 2515:91]
  wire [31:0] _T_1314 = {22'h0,_T_1313}; // @[Cat.scala 29:58]
  wire [9:0] _T_1316 = perf_csrs_io_mhpme6; // @[dec_tlu_ctl.scala 2516:91]
  wire [31:0] _T_1317 = {22'h0,_T_1316}; // @[Cat.scala 29:58]
  wire [31:0] _T_1320 = {25'h0,temp_ncount6_2,1'h0,temp_ncount0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1323 = {30'h0,mpmc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_1326 = io_csr_pkt_csr_misa ? 32'h40001104 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1327 = io_csr_pkt_csr_mvendorid ? 32'h45 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1328 = io_csr_pkt_csr_marchid ? 32'h10 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1329 = io_csr_pkt_csr_mimpid ? 32'h3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1330 = io_csr_pkt_csr_mhartid ? _T_1165 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1331 = io_csr_pkt_csr_mstatus ? _T_1174 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1332 = io_csr_pkt_csr_mtvec ? _T_1179 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1333 = io_csr_pkt_csr_mip ? _T_1192 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1334 = io_csr_pkt_csr_mie ? _T_1205 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1335 = io_csr_pkt_csr_mcyclel ? mcyclel : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1336 = io_csr_pkt_csr_mcycleh ? mcycleh_inc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1337 = io_csr_pkt_csr_minstretl ? minstretl : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1338 = io_csr_pkt_csr_minstreth ? minstreth_inc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1339 = io_csr_pkt_csr_mscratch ? mscratch : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1340 = io_csr_pkt_csr_mepc ? _T_1217 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1341 = io_csr_pkt_csr_mcause ? mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1342 = io_csr_pkt_csr_mscause ? _T_1222 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1343 = io_csr_pkt_csr_mtval ? mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1344 = io_csr_pkt_csr_mrac ? mrac : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1345 = io_csr_pkt_csr_mdseac ? mdseac : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1346 = io_csr_pkt_csr_meivt ? _T_1230 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1347 = io_csr_pkt_csr_meihap ? _T_1233 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1348 = io_csr_pkt_csr_meicurpl ? _T_1236 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1349 = io_csr_pkt_csr_meicidpl ? _T_1239 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1350 = io_csr_pkt_csr_meipt ? _T_1242 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1351 = io_csr_pkt_csr_mcgc ? _T_1245 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1352 = io_csr_pkt_csr_mfdc ? _T_1248 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1353 = io_csr_pkt_csr_dcsr ? _T_1252 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1354 = io_csr_pkt_csr_dpc ? _T_1254 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1355 = io_csr_pkt_csr_dicad0 ? dicad0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1356 = io_csr_pkt_csr_dicad0h ? dicad0h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1357 = io_csr_pkt_csr_dicad1 ? dicad1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1358 = io_csr_pkt_csr_dicawics ? _T_1270 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1359 = io_csr_pkt_csr_mtsel ? _T_1273 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1360 = io_csr_pkt_csr_mtdata1 ? mtdata1_tsel_out : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1361 = io_csr_pkt_csr_mtdata2 ? mtdata2_tsel_out : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1362 = io_csr_pkt_csr_micect ? micect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1363 = io_csr_pkt_csr_miccmect ? miccmect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1364 = io_csr_pkt_csr_mdccmect ? mdccmect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1365 = io_csr_pkt_csr_mhpmc3 ? _T_1285 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1366 = io_csr_pkt_csr_mhpmc4 ? _T_1287 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1367 = io_csr_pkt_csr_mhpmc5 ? _T_1289 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1368 = io_csr_pkt_csr_mhpmc6 ? _T_1291 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1369 = io_csr_pkt_csr_mhpmc3h ? _T_1293 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1370 = io_csr_pkt_csr_mhpmc4h ? _T_1295 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1371 = io_csr_pkt_csr_mhpmc5h ? _T_1297 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1372 = io_csr_pkt_csr_mhpmc6h ? _T_1299 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1373 = io_csr_pkt_csr_mfdht ? _T_1302 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1374 = io_csr_pkt_csr_mfdhs ? _T_1305 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1375 = io_csr_pkt_csr_mhpme3 ? _T_1308 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1376 = io_csr_pkt_csr_mhpme4 ? _T_1311 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1377 = io_csr_pkt_csr_mhpme5 ? _T_1314 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1378 = io_csr_pkt_csr_mhpme6 ? _T_1317 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1379 = io_csr_pkt_csr_mcountinhibit ? _T_1320 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1380 = io_csr_pkt_csr_mpmc ? _T_1323 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1381 = io_dec_timer_read_d ? io_dec_timer_rddata_d : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1382 = _T_1326 | _T_1327; // @[Mux.scala 27:72]
  wire [31:0] _T_1383 = _T_1382 | _T_1328; // @[Mux.scala 27:72]
  wire [31:0] _T_1384 = _T_1383 | _T_1329; // @[Mux.scala 27:72]
  wire [31:0] _T_1385 = _T_1384 | _T_1330; // @[Mux.scala 27:72]
  wire [31:0] _T_1386 = _T_1385 | _T_1331; // @[Mux.scala 27:72]
  wire [31:0] _T_1387 = _T_1386 | _T_1332; // @[Mux.scala 27:72]
  wire [31:0] _T_1388 = _T_1387 | _T_1333; // @[Mux.scala 27:72]
  wire [31:0] _T_1389 = _T_1388 | _T_1334; // @[Mux.scala 27:72]
  wire [31:0] _T_1390 = _T_1389 | _T_1335; // @[Mux.scala 27:72]
  wire [31:0] _T_1391 = _T_1390 | _T_1336; // @[Mux.scala 27:72]
  wire [31:0] _T_1392 = _T_1391 | _T_1337; // @[Mux.scala 27:72]
  wire [31:0] _T_1393 = _T_1392 | _T_1338; // @[Mux.scala 27:72]
  wire [31:0] _T_1394 = _T_1393 | _T_1339; // @[Mux.scala 27:72]
  wire [31:0] _T_1395 = _T_1394 | _T_1340; // @[Mux.scala 27:72]
  wire [31:0] _T_1396 = _T_1395 | _T_1341; // @[Mux.scala 27:72]
  wire [31:0] _T_1397 = _T_1396 | _T_1342; // @[Mux.scala 27:72]
  wire [31:0] _T_1398 = _T_1397 | _T_1343; // @[Mux.scala 27:72]
  wire [31:0] _T_1399 = _T_1398 | _T_1344; // @[Mux.scala 27:72]
  wire [31:0] _T_1400 = _T_1399 | _T_1345; // @[Mux.scala 27:72]
  wire [31:0] _T_1401 = _T_1400 | _T_1346; // @[Mux.scala 27:72]
  wire [31:0] _T_1402 = _T_1401 | _T_1347; // @[Mux.scala 27:72]
  wire [31:0] _T_1403 = _T_1402 | _T_1348; // @[Mux.scala 27:72]
  wire [31:0] _T_1404 = _T_1403 | _T_1349; // @[Mux.scala 27:72]
  wire [31:0] _T_1405 = _T_1404 | _T_1350; // @[Mux.scala 27:72]
  wire [31:0] _T_1406 = _T_1405 | _T_1351; // @[Mux.scala 27:72]
  wire [31:0] _T_1407 = _T_1406 | _T_1352; // @[Mux.scala 27:72]
  wire [31:0] _T_1408 = _T_1407 | _T_1353; // @[Mux.scala 27:72]
  wire [31:0] _T_1409 = _T_1408 | _T_1354; // @[Mux.scala 27:72]
  wire [31:0] _T_1410 = _T_1409 | _T_1355; // @[Mux.scala 27:72]
  wire [31:0] _T_1411 = _T_1410 | _T_1356; // @[Mux.scala 27:72]
  wire [31:0] _T_1412 = _T_1411 | _T_1357; // @[Mux.scala 27:72]
  wire [31:0] _T_1413 = _T_1412 | _T_1358; // @[Mux.scala 27:72]
  wire [31:0] _T_1414 = _T_1413 | _T_1359; // @[Mux.scala 27:72]
  wire [31:0] _T_1415 = _T_1414 | _T_1360; // @[Mux.scala 27:72]
  wire [31:0] _T_1416 = _T_1415 | _T_1361; // @[Mux.scala 27:72]
  wire [31:0] _T_1417 = _T_1416 | _T_1362; // @[Mux.scala 27:72]
  wire [31:0] _T_1418 = _T_1417 | _T_1363; // @[Mux.scala 27:72]
  wire [31:0] _T_1419 = _T_1418 | _T_1364; // @[Mux.scala 27:72]
  wire [31:0] _T_1420 = _T_1419 | _T_1365; // @[Mux.scala 27:72]
  wire [31:0] _T_1421 = _T_1420 | _T_1366; // @[Mux.scala 27:72]
  wire [31:0] _T_1422 = _T_1421 | _T_1367; // @[Mux.scala 27:72]
  wire [31:0] _T_1423 = _T_1422 | _T_1368; // @[Mux.scala 27:72]
  wire [31:0] _T_1424 = _T_1423 | _T_1369; // @[Mux.scala 27:72]
  wire [31:0] _T_1425 = _T_1424 | _T_1370; // @[Mux.scala 27:72]
  wire [31:0] _T_1426 = _T_1425 | _T_1371; // @[Mux.scala 27:72]
  wire [31:0] _T_1427 = _T_1426 | _T_1372; // @[Mux.scala 27:72]
  wire [31:0] _T_1428 = _T_1427 | _T_1373; // @[Mux.scala 27:72]
  wire [31:0] _T_1429 = _T_1428 | _T_1374; // @[Mux.scala 27:72]
  wire [31:0] _T_1430 = _T_1429 | _T_1375; // @[Mux.scala 27:72]
  wire [31:0] _T_1431 = _T_1430 | _T_1376; // @[Mux.scala 27:72]
  wire [31:0] _T_1432 = _T_1431 | _T_1377; // @[Mux.scala 27:72]
  wire [31:0] _T_1433 = _T_1432 | _T_1378; // @[Mux.scala 27:72]
  wire [31:0] _T_1434 = _T_1433 | _T_1379; // @[Mux.scala 27:72]
  wire [31:0] _T_1435 = _T_1434 | _T_1380; // @[Mux.scala 27:72]
  perf_mux_and_flops perfmux_flop ( // @[dec_tlu_ctl.scala 1442:34]
    .reset(perfmux_flop_reset),
    .io_mhpmc_inc_r_0(perfmux_flop_io_mhpmc_inc_r_0),
    .io_mhpmc_inc_r_1(perfmux_flop_io_mhpmc_inc_r_1),
    .io_mhpmc_inc_r_2(perfmux_flop_io_mhpmc_inc_r_2),
    .io_mhpmc_inc_r_3(perfmux_flop_io_mhpmc_inc_r_3),
    .io_mcountinhibit(perfmux_flop_io_mcountinhibit),
    .io_mhpme_vec_0(perfmux_flop_io_mhpme_vec_0),
    .io_mhpme_vec_1(perfmux_flop_io_mhpme_vec_1),
    .io_mhpme_vec_2(perfmux_flop_io_mhpme_vec_2),
    .io_mhpme_vec_3(perfmux_flop_io_mhpme_vec_3),
    .io_ifu_pmu_ic_hit(perfmux_flop_io_ifu_pmu_ic_hit),
    .io_ifu_pmu_ic_miss(perfmux_flop_io_ifu_pmu_ic_miss),
    .io_tlu_i0_commit_cmt(perfmux_flop_io_tlu_i0_commit_cmt),
    .io_illegal_r(perfmux_flop_io_illegal_r),
    .io_exu_pmu_i0_pc4(perfmux_flop_io_exu_pmu_i0_pc4),
    .io_ifu_pmu_instr_aligned(perfmux_flop_io_ifu_pmu_instr_aligned),
    .io_dec_pmu_instr_decoded(perfmux_flop_io_dec_pmu_instr_decoded),
    .io_dec_tlu_packet_r_pmu_i0_itype(perfmux_flop_io_dec_tlu_packet_r_pmu_i0_itype),
    .io_dec_tlu_packet_r_pmu_i0_br_unpred(perfmux_flop_io_dec_tlu_packet_r_pmu_i0_br_unpred),
    .io_dec_tlu_packet_r_pmu_divide(perfmux_flop_io_dec_tlu_packet_r_pmu_divide),
    .io_dec_tlu_packet_r_pmu_lsu_misaligned(perfmux_flop_io_dec_tlu_packet_r_pmu_lsu_misaligned),
    .io_exu_pmu_i0_br_misp(perfmux_flop_io_exu_pmu_i0_br_misp),
    .io_dec_pmu_decode_stall(perfmux_flop_io_dec_pmu_decode_stall),
    .io_exu_pmu_i0_br_ataken(perfmux_flop_io_exu_pmu_i0_br_ataken),
    .io_ifu_pmu_fetch_stall(perfmux_flop_io_ifu_pmu_fetch_stall),
    .io_dec_pmu_postsync_stall(perfmux_flop_io_dec_pmu_postsync_stall),
    .io_dec_pmu_presync_stall(perfmux_flop_io_dec_pmu_presync_stall),
    .io_lsu_store_stall_any(perfmux_flop_io_lsu_store_stall_any),
    .io_dma_dccm_stall_any(perfmux_flop_io_dma_dccm_stall_any),
    .io_dma_iccm_stall_any(perfmux_flop_io_dma_iccm_stall_any),
    .io_i0_exception_valid_r(perfmux_flop_io_i0_exception_valid_r),
    .io_dec_tlu_pmu_fw_halted(perfmux_flop_io_dec_tlu_pmu_fw_halted),
    .io_dma_pmu_any_read(perfmux_flop_io_dma_pmu_any_read),
    .io_dma_pmu_any_write(perfmux_flop_io_dma_pmu_any_write),
    .io_dma_pmu_dccm_read(perfmux_flop_io_dma_pmu_dccm_read),
    .io_dma_pmu_dccm_write(perfmux_flop_io_dma_pmu_dccm_write),
    .io_lsu_pmu_load_external_r(perfmux_flop_io_lsu_pmu_load_external_r),
    .io_lsu_pmu_store_external_r(perfmux_flop_io_lsu_pmu_store_external_r),
    .io_mstatus(perfmux_flop_io_mstatus),
    .io_mie(perfmux_flop_io_mie),
    .io_ifu_pmu_bus_trxn(perfmux_flop_io_ifu_pmu_bus_trxn),
    .io_lsu_pmu_bus_trxn(perfmux_flop_io_lsu_pmu_bus_trxn),
    .io_lsu_pmu_bus_misaligned(perfmux_flop_io_lsu_pmu_bus_misaligned),
    .io_ifu_pmu_bus_error(perfmux_flop_io_ifu_pmu_bus_error),
    .io_lsu_pmu_bus_error(perfmux_flop_io_lsu_pmu_bus_error),
    .io_ifu_pmu_bus_busy(perfmux_flop_io_ifu_pmu_bus_busy),
    .io_lsu_pmu_bus_busy(perfmux_flop_io_lsu_pmu_bus_busy),
    .io_i0_trigger_hit_r(perfmux_flop_io_i0_trigger_hit_r),
    .io_lsu_exc_valid_r(perfmux_flop_io_lsu_exc_valid_r),
    .io_take_timer_int(perfmux_flop_io_take_timer_int),
    .io_take_int_timer0_int(perfmux_flop_io_take_int_timer0_int),
    .io_take_int_timer1_int(perfmux_flop_io_take_int_timer1_int),
    .io_take_ext_int(perfmux_flop_io_take_ext_int),
    .io_tlu_flush_lower_r(perfmux_flop_io_tlu_flush_lower_r),
    .io_dec_tlu_br0_error_r(perfmux_flop_io_dec_tlu_br0_error_r),
    .io_rfpc_i0_r(perfmux_flop_io_rfpc_i0_r),
    .io_dec_tlu_br0_start_error_r(perfmux_flop_io_dec_tlu_br0_start_error_r),
    .io_mcyclel_cout_f(perfmux_flop_io_mcyclel_cout_f),
    .io_minstret_enable_f(perfmux_flop_io_minstret_enable_f),
    .io_minstretl_cout_f(perfmux_flop_io_minstretl_cout_f),
    .io_meicidpl(perfmux_flop_io_meicidpl),
    .io_icache_rd_valid_f(perfmux_flop_io_icache_rd_valid_f),
    .io_icache_wr_valid_f(perfmux_flop_io_icache_wr_valid_f),
    .io_mhpmc_inc_r_d1_0(perfmux_flop_io_mhpmc_inc_r_d1_0),
    .io_mhpmc_inc_r_d1_1(perfmux_flop_io_mhpmc_inc_r_d1_1),
    .io_mhpmc_inc_r_d1_2(perfmux_flop_io_mhpmc_inc_r_d1_2),
    .io_mhpmc_inc_r_d1_3(perfmux_flop_io_mhpmc_inc_r_d1_3),
    .io_perfcnt_halted_d1(perfmux_flop_io_perfcnt_halted_d1),
    .io_mdseac_locked_f(perfmux_flop_io_mdseac_locked_f),
    .io_lsu_single_ecc_error_r_d1(perfmux_flop_io_lsu_single_ecc_error_r_d1),
    .io_lsu_i0_exc_r_d1(perfmux_flop_io_lsu_i0_exc_r_d1),
    .io_take_ext_int_start_d1(perfmux_flop_io_take_ext_int_start_d1),
    .io_take_ext_int_start_d2(perfmux_flop_io_take_ext_int_start_d2),
    .io_take_ext_int_start_d3(perfmux_flop_io_take_ext_int_start_d3),
    .io_ext_int_freeze_d1(perfmux_flop_io_ext_int_freeze_d1),
    .io_mip(perfmux_flop_io_mip),
    .io_mdseac_locked_ns(perfmux_flop_io_mdseac_locked_ns),
    .io_lsu_single_ecc_error_r(perfmux_flop_io_lsu_single_ecc_error_r),
    .io_lsu_i0_exc_r(perfmux_flop_io_lsu_i0_exc_r),
    .io_take_ext_int_start(perfmux_flop_io_take_ext_int_start),
    .io_ext_int_freeze(perfmux_flop_io_ext_int_freeze),
    .io_mip_ns(perfmux_flop_io_mip_ns),
    .io_mcyclel_cout(perfmux_flop_io_mcyclel_cout),
    .io_wr_mcycleh_r(perfmux_flop_io_wr_mcycleh_r),
    .io_mcyclel_cout_in(perfmux_flop_io_mcyclel_cout_in),
    .io_minstret_enable(perfmux_flop_io_minstret_enable),
    .io_minstretl_cout_ns(perfmux_flop_io_minstretl_cout_ns),
    .io_meicidpl_ns(perfmux_flop_io_meicidpl_ns),
    .io_icache_rd_valid(perfmux_flop_io_icache_rd_valid),
    .io_icache_wr_valid(perfmux_flop_io_icache_wr_valid),
    .io_perfcnt_halted(perfmux_flop_io_perfcnt_halted),
    .io_mstatus_ns(perfmux_flop_io_mstatus_ns),
    .io_free_l2clk(perfmux_flop_io_free_l2clk)
  );
  perf_csr perf_csrs ( // @[dec_tlu_ctl.scala 1443:31]
    .clock(perf_csrs_clock),
    .reset(perf_csrs_reset),
    .io_free_l2clk(perf_csrs_io_free_l2clk),
    .io_dec_tlu_dbg_halted(perf_csrs_io_dec_tlu_dbg_halted),
    .io_dcsr(perf_csrs_io_dcsr),
    .io_dec_tlu_pmu_fw_halted(perf_csrs_io_dec_tlu_pmu_fw_halted),
    .io_mhpme_vec_0(perf_csrs_io_mhpme_vec_0),
    .io_mhpme_vec_1(perf_csrs_io_mhpme_vec_1),
    .io_mhpme_vec_2(perf_csrs_io_mhpme_vec_2),
    .io_mhpme_vec_3(perf_csrs_io_mhpme_vec_3),
    .io_dec_csr_wen_r_mod(perf_csrs_io_dec_csr_wen_r_mod),
    .io_dec_csr_wraddr_r(perf_csrs_io_dec_csr_wraddr_r),
    .io_dec_csr_wrdata_r(perf_csrs_io_dec_csr_wrdata_r),
    .io_mhpmc_inc_r_0(perf_csrs_io_mhpmc_inc_r_0),
    .io_mhpmc_inc_r_1(perf_csrs_io_mhpmc_inc_r_1),
    .io_mhpmc_inc_r_2(perf_csrs_io_mhpmc_inc_r_2),
    .io_mhpmc_inc_r_3(perf_csrs_io_mhpmc_inc_r_3),
    .io_mhpmc_inc_r_d1_0(perf_csrs_io_mhpmc_inc_r_d1_0),
    .io_mhpmc_inc_r_d1_1(perf_csrs_io_mhpmc_inc_r_d1_1),
    .io_mhpmc_inc_r_d1_2(perf_csrs_io_mhpmc_inc_r_d1_2),
    .io_mhpmc_inc_r_d1_3(perf_csrs_io_mhpmc_inc_r_d1_3),
    .io_perfcnt_halted_d1(perf_csrs_io_perfcnt_halted_d1),
    .io_mhpmc3h(perf_csrs_io_mhpmc3h),
    .io_mhpmc3(perf_csrs_io_mhpmc3),
    .io_mhpmc4h(perf_csrs_io_mhpmc4h),
    .io_mhpmc4(perf_csrs_io_mhpmc4),
    .io_mhpmc5h(perf_csrs_io_mhpmc5h),
    .io_mhpmc5(perf_csrs_io_mhpmc5),
    .io_mhpmc6h(perf_csrs_io_mhpmc6h),
    .io_mhpmc6(perf_csrs_io_mhpmc6),
    .io_mhpme3(perf_csrs_io_mhpme3),
    .io_mhpme4(perf_csrs_io_mhpme4),
    .io_mhpme5(perf_csrs_io_mhpme5),
    .io_mhpme6(perf_csrs_io_mhpme6),
    .io_dec_tlu_perfcnt0(perf_csrs_io_dec_tlu_perfcnt0),
    .io_dec_tlu_perfcnt1(perf_csrs_io_dec_tlu_perfcnt1),
    .io_dec_tlu_perfcnt2(perf_csrs_io_dec_tlu_perfcnt2),
    .io_dec_tlu_perfcnt3(perf_csrs_io_dec_tlu_perfcnt3)
  );
  rvclkhdr rvclkhdr ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en)
  );
  rvclkhdr rvclkhdr_1 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en)
  );
  rvclkhdr rvclkhdr_2 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en)
  );
  rvclkhdr rvclkhdr_3 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en)
  );
  rvclkhdr rvclkhdr_4 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en)
  );
  rvclkhdr rvclkhdr_5 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en)
  );
  rvclkhdr rvclkhdr_6 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en)
  );
  rvclkhdr rvclkhdr_7 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en)
  );
  rvclkhdr rvclkhdr_8 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en)
  );
  rvclkhdr rvclkhdr_9 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en)
  );
  rvclkhdr rvclkhdr_10 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en)
  );
  rvclkhdr rvclkhdr_11 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en)
  );
  rvclkhdr rvclkhdr_12 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_12_io_clk),
    .io_en(rvclkhdr_12_io_en)
  );
  rvclkhdr rvclkhdr_13 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_13_io_clk),
    .io_en(rvclkhdr_13_io_en)
  );
  rvclkhdr rvclkhdr_14 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_14_io_clk),
    .io_en(rvclkhdr_14_io_en)
  );
  rvclkhdr rvclkhdr_15 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_15_io_clk),
    .io_en(rvclkhdr_15_io_en)
  );
  rvclkhdr rvclkhdr_16 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_16_io_clk),
    .io_en(rvclkhdr_16_io_en)
  );
  rvclkhdr rvclkhdr_17 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_17_io_clk),
    .io_en(rvclkhdr_17_io_en)
  );
  rvclkhdr rvclkhdr_18 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_18_io_clk),
    .io_en(rvclkhdr_18_io_en)
  );
  rvclkhdr rvclkhdr_19 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_19_io_clk),
    .io_en(rvclkhdr_19_io_en)
  );
  rvclkhdr rvclkhdr_20 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_20_io_clk),
    .io_en(rvclkhdr_20_io_en)
  );
  rvclkhdr rvclkhdr_21 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_21_io_clk),
    .io_en(rvclkhdr_21_io_en)
  );
  rvclkhdr rvclkhdr_22 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_22_io_clk),
    .io_en(rvclkhdr_22_io_en)
  );
  rvclkhdr rvclkhdr_23 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_23_io_clk),
    .io_en(rvclkhdr_23_io_en)
  );
  rvclkhdr rvclkhdr_24 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_24_io_clk),
    .io_en(rvclkhdr_24_io_en)
  );
  rvclkhdr rvclkhdr_25 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_25_io_clk),
    .io_en(rvclkhdr_25_io_en)
  );
  rvclkhdr rvclkhdr_26 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_26_io_clk),
    .io_en(rvclkhdr_26_io_en)
  );
  rvclkhdr rvclkhdr_27 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_27_io_clk),
    .io_en(rvclkhdr_27_io_en)
  );
  rvclkhdr rvclkhdr_28 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_28_io_clk),
    .io_en(rvclkhdr_28_io_en)
  );
  rvclkhdr rvclkhdr_29 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_29_io_clk),
    .io_en(rvclkhdr_29_io_en)
  );
  rvclkhdr rvclkhdr_30 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_30_io_clk),
    .io_en(rvclkhdr_30_io_en)
  );
  rvclkhdr rvclkhdr_31 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_31_io_clk),
    .io_en(rvclkhdr_31_io_en)
  );
  rvclkhdr rvclkhdr_32 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_32_io_clk),
    .io_en(rvclkhdr_32_io_en)
  );
  rvclkhdr rvclkhdr_33 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_33_io_clk),
    .io_en(rvclkhdr_33_io_en)
  );
  rvclkhdr rvclkhdr_34 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_34_io_clk),
    .io_en(rvclkhdr_34_io_en)
  );
  assign io_dec_tlu_ic_diag_pkt_icache_wrdata = {_T_821,dicad0}; // @[dec_tlu_ctl.scala 2181:56]
  assign io_dec_tlu_ic_diag_pkt_icache_dicawics = dicawics; // @[dec_tlu_ctl.scala 2184:41]
  assign io_dec_tlu_ic_diag_pkt_icache_rd_valid = perfmux_flop_io_icache_rd_valid_f; // @[dec_tlu_ctl.scala 2192:41]
  assign io_dec_tlu_ic_diag_pkt_icache_wr_valid = perfmux_flop_io_icache_wr_valid_f; // @[dec_tlu_ctl.scala 2193:41]
  assign io_trigger_pkt_any_0_select = io_mtdata1_t_0[7]; // @[dec_tlu_ctl.scala 2265:40]
  assign io_trigger_pkt_any_0_match_pkt = io_mtdata1_t_0[4]; // @[dec_tlu_ctl.scala 2266:43]
  assign io_trigger_pkt_any_0_store = io_mtdata1_t_0[1]; // @[dec_tlu_ctl.scala 2267:40]
  assign io_trigger_pkt_any_0_load = io_mtdata1_t_0[0]; // @[dec_tlu_ctl.scala 2268:40]
  assign io_trigger_pkt_any_0_execute = io_mtdata1_t_0[2]; // @[dec_tlu_ctl.scala 2269:40]
  assign io_trigger_pkt_any_0_m = io_mtdata1_t_0[3]; // @[dec_tlu_ctl.scala 2270:40]
  assign io_trigger_pkt_any_0_tdata2 = mtdata2_t_0; // @[dec_tlu_ctl.scala 2283:51]
  assign io_trigger_pkt_any_1_select = io_mtdata1_t_1[7]; // @[dec_tlu_ctl.scala 2265:40]
  assign io_trigger_pkt_any_1_match_pkt = io_mtdata1_t_1[4]; // @[dec_tlu_ctl.scala 2266:43]
  assign io_trigger_pkt_any_1_store = io_mtdata1_t_1[1]; // @[dec_tlu_ctl.scala 2267:40]
  assign io_trigger_pkt_any_1_load = io_mtdata1_t_1[0]; // @[dec_tlu_ctl.scala 2268:40]
  assign io_trigger_pkt_any_1_execute = io_mtdata1_t_1[2]; // @[dec_tlu_ctl.scala 2269:40]
  assign io_trigger_pkt_any_1_m = io_mtdata1_t_1[3]; // @[dec_tlu_ctl.scala 2270:40]
  assign io_trigger_pkt_any_1_tdata2 = mtdata2_t_1; // @[dec_tlu_ctl.scala 2283:51]
  assign io_trigger_pkt_any_2_select = io_mtdata1_t_2[7]; // @[dec_tlu_ctl.scala 2265:40]
  assign io_trigger_pkt_any_2_match_pkt = io_mtdata1_t_2[4]; // @[dec_tlu_ctl.scala 2266:43]
  assign io_trigger_pkt_any_2_store = io_mtdata1_t_2[1]; // @[dec_tlu_ctl.scala 2267:40]
  assign io_trigger_pkt_any_2_load = io_mtdata1_t_2[0]; // @[dec_tlu_ctl.scala 2268:40]
  assign io_trigger_pkt_any_2_execute = io_mtdata1_t_2[2]; // @[dec_tlu_ctl.scala 2269:40]
  assign io_trigger_pkt_any_2_m = io_mtdata1_t_2[3]; // @[dec_tlu_ctl.scala 2270:40]
  assign io_trigger_pkt_any_2_tdata2 = mtdata2_t_2; // @[dec_tlu_ctl.scala 2283:51]
  assign io_trigger_pkt_any_3_select = io_mtdata1_t_3[7]; // @[dec_tlu_ctl.scala 2265:40]
  assign io_trigger_pkt_any_3_match_pkt = io_mtdata1_t_3[4]; // @[dec_tlu_ctl.scala 2266:43]
  assign io_trigger_pkt_any_3_store = io_mtdata1_t_3[1]; // @[dec_tlu_ctl.scala 2267:40]
  assign io_trigger_pkt_any_3_load = io_mtdata1_t_3[0]; // @[dec_tlu_ctl.scala 2268:40]
  assign io_trigger_pkt_any_3_execute = io_mtdata1_t_3[2]; // @[dec_tlu_ctl.scala 2269:40]
  assign io_trigger_pkt_any_3_m = io_mtdata1_t_3[3]; // @[dec_tlu_ctl.scala 2270:40]
  assign io_trigger_pkt_any_3_tdata2 = mtdata2_t_3; // @[dec_tlu_ctl.scala 2283:51]
  assign io_dec_tlu_int_valid_wb1 = dec_tlu_int_valid_wb2; // @[dec_tlu_ctl.scala 2456:28]
  assign io_dec_tlu_i0_exc_valid_wb1 = _T_1141 & _T_1147; // @[dec_tlu_ctl.scala 2447:33]
  assign io_dec_tlu_i0_valid_wb1 = _T_1141 & io_i0_valid_wb; // @[dec_tlu_ctl.scala 2446:39]
  assign io_dec_tlu_mtval_wb1 = mtval; // @[dec_tlu_ctl.scala 2457:31]
  assign io_dec_tlu_exc_cause_wb1 = dec_tlu_int_valid_wb2 ? dec_tlu_exc_cause_wb2 : dec_tlu_exc_cause_wb1_raw; // @[dec_tlu_ctl.scala 2455:28]
  assign io_dec_tlu_perfcnt0 = perf_csrs_io_dec_tlu_perfcnt0; // @[dec_tlu_ctl.scala 2414:30]
  assign io_dec_tlu_perfcnt1 = perf_csrs_io_dec_tlu_perfcnt1; // @[dec_tlu_ctl.scala 2415:30]
  assign io_dec_tlu_perfcnt2 = perf_csrs_io_dec_tlu_perfcnt2; // @[dec_tlu_ctl.scala 2416:30]
  assign io_dec_tlu_perfcnt3 = perf_csrs_io_dec_tlu_perfcnt3; // @[dec_tlu_ctl.scala 2417:30]
  assign io_dec_tlu_misc_clk_override = mcgc[8]; // @[dec_tlu_ctl.scala 1739:31]
  assign io_dec_tlu_picio_clk_override = mcgc[9]; // @[dec_tlu_ctl.scala 1738:32]
  assign io_dec_tlu_dec_clk_override = mcgc[7]; // @[dec_tlu_ctl.scala 1740:31]
  assign io_dec_tlu_ifu_clk_override = mcgc[5]; // @[dec_tlu_ctl.scala 1741:31]
  assign io_dec_tlu_lsu_clk_override = mcgc[4]; // @[dec_tlu_ctl.scala 1742:31]
  assign io_dec_tlu_bus_clk_override = mcgc[3]; // @[dec_tlu_ctl.scala 1743:31]
  assign io_dec_tlu_pic_clk_override = mcgc[2]; // @[dec_tlu_ctl.scala 1744:31]
  assign io_dec_tlu_dccm_clk_override = mcgc[1]; // @[dec_tlu_ctl.scala 1745:31]
  assign io_dec_tlu_icm_clk_override = mcgc[0]; // @[dec_tlu_ctl.scala 1746:31]
  assign io_dec_csr_rddata_d = _T_1435 | _T_1381; // @[dec_tlu_ctl.scala 2463:28]
  assign io_dec_tlu_pipelining_disable = mfdc[0]; // @[dec_tlu_ctl.scala 1794:39]
  assign io_dec_tlu_wr_pause_r = _T_426 & _T_427; // @[dec_tlu_ctl.scala 1803:24]
  assign io_dec_tlu_meipt = meipt; // @[dec_tlu_ctl.scala 2032:19]
  assign io_dec_tlu_meicurpl = meicurpl; // @[dec_tlu_ctl.scala 1996:22]
  assign io_dec_tlu_meihap = {meivt,meihap}; // @[dec_tlu_ctl.scala 1982:20]
  assign io_dec_tlu_mrac_ff = mrac; // @[dec_tlu_ctl.scala 1833:21]
  assign io_dec_tlu_wb_coalescing_disable = mfdc[2]; // @[dec_tlu_ctl.scala 1793:39]
  assign io_dec_tlu_bpred_disable = mfdc[3]; // @[dec_tlu_ctl.scala 1792:39]
  assign io_dec_tlu_sideeffect_posted_disable = mfdc[6]; // @[dec_tlu_ctl.scala 1791:39]
  assign io_dec_tlu_core_ecc_disable = mfdc[8]; // @[dec_tlu_ctl.scala 1790:39]
  assign io_dec_tlu_external_ldfwd_disable = mfdc[11]; // @[dec_tlu_ctl.scala 1789:39]
  assign io_dec_tlu_dma_qos_prty = mfdc[18:16]; // @[dec_tlu_ctl.scala 1787:39]
  assign io_dec_tlu_trace_disable = mfdc[12]; // @[dec_tlu_ctl.scala 1788:39]
  assign io_dec_csr_wen_r_mod = _T_1 & _T_2; // @[dec_tlu_ctl.scala 1459:23]
  assign io_fw_halt_req = _T_558 & _T_559; // @[dec_tlu_ctl.scala 1868:17]
  assign io_mstatus = perfmux_flop_io_mstatus; // @[dec_tlu_ctl.scala 2326:21]
  assign io_mstatus_mie_ns = io_mstatus[0] & _T_54; // @[dec_tlu_ctl.scala 1474:20]
  assign io_dcsr = _T_757; // @[dec_tlu_ctl.scala 2079:10]
  assign io_mtvec = _T_61; // @[dec_tlu_ctl.scala 1487:11]
  assign io_mip = perfmux_flop_io_mip; // @[dec_tlu_ctl.scala 2327:37]
  assign io_mie_ns = wr_mie_r ? _T_76 : mie; // @[dec_tlu_ctl.scala 1516:12]
  assign io_npc_r = _T_189 | _T_187; // @[dec_tlu_ctl.scala 1619:11]
  assign io_npc_r_d1 = _T_196; // @[dec_tlu_ctl.scala 1625:14]
  assign io_mepc = _T_231; // @[dec_tlu_ctl.scala 1644:10]
  assign io_mdseac_locked_ns = mdseac_en | _T_545; // @[dec_tlu_ctl.scala 1851:22]
  assign io_mdseac_locked_f = perfmux_flop_io_mdseac_locked_f; // @[dec_tlu_ctl.scala 2356:42]
  assign io_ext_int_freeze_d1 = perfmux_flop_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 2363:42]
  assign io_take_ext_int_start_d1 = perfmux_flop_io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 2360:42]
  assign io_take_ext_int_start_d2 = perfmux_flop_io_take_ext_int_start_d2; // @[dec_tlu_ctl.scala 2361:42]
  assign io_take_ext_int_start_d3 = perfmux_flop_io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 2362:42]
  assign io_force_halt = mfdht[0] & _T_666; // @[dec_tlu_ctl.scala 1959:16]
  assign io_dpc = _T_782; // @[dec_tlu_ctl.scala 2096:9]
  assign io_mtdata1_t_0 = _T_966; // @[dec_tlu_ctl.scala 2260:39]
  assign io_mtdata1_t_1 = _T_970; // @[dec_tlu_ctl.scala 2260:39]
  assign io_mtdata1_t_2 = _T_974; // @[dec_tlu_ctl.scala 2260:39]
  assign io_mtdata1_t_3 = _T_978; // @[dec_tlu_ctl.scala 2260:39]
  assign perfmux_flop_reset = reset;
  assign perfmux_flop_io_mcountinhibit = {_T_1139,temp_ncount0}; // @[dec_tlu_ctl.scala 2299:51]
  assign perfmux_flop_io_mhpme_vec_0 = perf_csrs_io_mhpme3; // @[dec_tlu_ctl.scala 2300:51]
  assign perfmux_flop_io_mhpme_vec_1 = perf_csrs_io_mhpme4; // @[dec_tlu_ctl.scala 2300:51]
  assign perfmux_flop_io_mhpme_vec_2 = perf_csrs_io_mhpme5; // @[dec_tlu_ctl.scala 2300:51]
  assign perfmux_flop_io_mhpme_vec_3 = perf_csrs_io_mhpme6; // @[dec_tlu_ctl.scala 2300:51]
  assign perfmux_flop_io_ifu_pmu_ic_hit = io_ifu_pmu_ic_hit; // @[dec_tlu_ctl.scala 2301:51]
  assign perfmux_flop_io_ifu_pmu_ic_miss = io_ifu_pmu_ic_miss; // @[dec_tlu_ctl.scala 2302:51]
  assign perfmux_flop_io_tlu_i0_commit_cmt = io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2303:51]
  assign perfmux_flop_io_illegal_r = io_illegal_r; // @[dec_tlu_ctl.scala 2304:51]
  assign perfmux_flop_io_exu_pmu_i0_pc4 = io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 2305:51]
  assign perfmux_flop_io_ifu_pmu_instr_aligned = io_ifu_pmu_instr_aligned; // @[dec_tlu_ctl.scala 2306:51]
  assign perfmux_flop_io_dec_pmu_instr_decoded = io_dec_pmu_instr_decoded; // @[dec_tlu_ctl.scala 2307:51]
  assign perfmux_flop_io_dec_tlu_packet_r_pmu_i0_itype = io_dec_tlu_packet_r_pmu_i0_itype; // @[dec_tlu_ctl.scala 2308:51]
  assign perfmux_flop_io_dec_tlu_packet_r_pmu_i0_br_unpred = io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec_tlu_ctl.scala 2308:51]
  assign perfmux_flop_io_dec_tlu_packet_r_pmu_divide = io_dec_tlu_packet_r_pmu_divide; // @[dec_tlu_ctl.scala 2308:51]
  assign perfmux_flop_io_dec_tlu_packet_r_pmu_lsu_misaligned = io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 2308:51]
  assign perfmux_flop_io_exu_pmu_i0_br_misp = io_exu_pmu_i0_br_misp; // @[dec_tlu_ctl.scala 2309:51]
  assign perfmux_flop_io_dec_pmu_decode_stall = io_dec_pmu_decode_stall; // @[dec_tlu_ctl.scala 2310:51]
  assign perfmux_flop_io_exu_pmu_i0_br_ataken = io_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 2311:51]
  assign perfmux_flop_io_ifu_pmu_fetch_stall = io_ifu_pmu_fetch_stall; // @[dec_tlu_ctl.scala 2312:51]
  assign perfmux_flop_io_dec_pmu_postsync_stall = io_dec_pmu_postsync_stall; // @[dec_tlu_ctl.scala 2313:51]
  assign perfmux_flop_io_dec_pmu_presync_stall = io_dec_pmu_presync_stall; // @[dec_tlu_ctl.scala 2314:51]
  assign perfmux_flop_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[dec_tlu_ctl.scala 2315:51]
  assign perfmux_flop_io_dma_dccm_stall_any = io_dma_dccm_stall_any; // @[dec_tlu_ctl.scala 2316:51]
  assign perfmux_flop_io_dma_iccm_stall_any = io_dma_iccm_stall_any; // @[dec_tlu_ctl.scala 2317:51]
  assign perfmux_flop_io_i0_exception_valid_r = io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 2318:51]
  assign perfmux_flop_io_dec_tlu_pmu_fw_halted = io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 2319:51]
  assign perfmux_flop_io_dma_pmu_any_read = io_dma_pmu_any_read; // @[dec_tlu_ctl.scala 2320:51]
  assign perfmux_flop_io_dma_pmu_any_write = io_dma_pmu_any_write; // @[dec_tlu_ctl.scala 2321:51]
  assign perfmux_flop_io_dma_pmu_dccm_read = io_dma_pmu_dccm_read; // @[dec_tlu_ctl.scala 2322:51]
  assign perfmux_flop_io_dma_pmu_dccm_write = io_dma_pmu_dccm_write; // @[dec_tlu_ctl.scala 2323:51]
  assign perfmux_flop_io_lsu_pmu_load_external_r = io_lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 2324:51]
  assign perfmux_flop_io_lsu_pmu_store_external_r = io_lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 2325:51]
  assign perfmux_flop_io_mie = mie; // @[dec_tlu_ctl.scala 2328:51]
  assign perfmux_flop_io_ifu_pmu_bus_trxn = io_ifu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 2329:51]
  assign perfmux_flop_io_lsu_pmu_bus_trxn = io_lsu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 2330:51]
  assign perfmux_flop_io_lsu_pmu_bus_misaligned = io_lsu_pmu_bus_misaligned; // @[dec_tlu_ctl.scala 2331:51]
  assign perfmux_flop_io_ifu_pmu_bus_error = io_ifu_pmu_bus_error; // @[dec_tlu_ctl.scala 2332:51]
  assign perfmux_flop_io_lsu_pmu_bus_error = io_lsu_pmu_bus_error; // @[dec_tlu_ctl.scala 2333:51]
  assign perfmux_flop_io_ifu_pmu_bus_busy = io_ifu_pmu_bus_busy; // @[dec_tlu_ctl.scala 2334:51]
  assign perfmux_flop_io_lsu_pmu_bus_busy = io_lsu_pmu_bus_busy; // @[dec_tlu_ctl.scala 2335:51]
  assign perfmux_flop_io_i0_trigger_hit_r = io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 2336:51]
  assign perfmux_flop_io_lsu_exc_valid_r = io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 2337:51]
  assign perfmux_flop_io_take_timer_int = io_take_timer_int; // @[dec_tlu_ctl.scala 2338:51]
  assign perfmux_flop_io_take_int_timer0_int = io_take_int_timer0_int; // @[dec_tlu_ctl.scala 2339:51]
  assign perfmux_flop_io_take_int_timer1_int = io_take_int_timer1_int; // @[dec_tlu_ctl.scala 2340:51]
  assign perfmux_flop_io_take_ext_int = io_take_ext_int; // @[dec_tlu_ctl.scala 2341:51]
  assign perfmux_flop_io_tlu_flush_lower_r = io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 2342:51]
  assign perfmux_flop_io_dec_tlu_br0_error_r = io_dec_tlu_br0_error_r; // @[dec_tlu_ctl.scala 2343:51]
  assign perfmux_flop_io_rfpc_i0_r = io_rfpc_i0_r; // @[dec_tlu_ctl.scala 2344:51]
  assign perfmux_flop_io_dec_tlu_br0_start_error_r = io_dec_tlu_br0_start_error_r; // @[dec_tlu_ctl.scala 2345:51]
  assign perfmux_flop_io_mdseac_locked_ns = io_mdseac_locked_ns; // @[dec_tlu_ctl.scala 2367:55]
  assign perfmux_flop_io_lsu_single_ecc_error_r = io_lsu_single_ecc_error_r; // @[dec_tlu_ctl.scala 2368:55]
  assign perfmux_flop_io_lsu_i0_exc_r = io_lsu_i0_exc_r; // @[dec_tlu_ctl.scala 2369:55]
  assign perfmux_flop_io_take_ext_int_start = io_take_ext_int_start; // @[dec_tlu_ctl.scala 2370:55]
  assign perfmux_flop_io_ext_int_freeze = io_ext_int_freeze; // @[dec_tlu_ctl.scala 2371:55]
  assign perfmux_flop_io_mip_ns = {_T_66,_T_64}; // @[dec_tlu_ctl.scala 2372:55]
  assign perfmux_flop_io_mcyclel_cout = mcyclel_inc2[24]; // @[dec_tlu_ctl.scala 2373:55]
  assign perfmux_flop_io_wr_mcycleh_r = io_dec_csr_wen_r_mod & _T_113; // @[dec_tlu_ctl.scala 2374:55]
  assign perfmux_flop_io_mcyclel_cout_in = ~_T_87; // @[dec_tlu_ctl.scala 2375:55]
  assign perfmux_flop_io_minstret_enable = _T_138 | wr_minstretl_r; // @[dec_tlu_ctl.scala 2376:55]
  assign perfmux_flop_io_minstretl_cout_ns = _T_141 & _T_142; // @[dec_tlu_ctl.scala 2377:55]
  assign perfmux_flop_io_meicidpl_ns = wr_meicpct_r ? io_pic_pl : _T_685; // @[dec_tlu_ctl.scala 2379:55]
  assign perfmux_flop_io_icache_rd_valid = _T_826 & _T_828; // @[dec_tlu_ctl.scala 2380:55]
  assign perfmux_flop_io_icache_wr_valid = _T_719 & _T_831; // @[dec_tlu_ctl.scala 2381:55]
  assign perfmux_flop_io_perfcnt_halted = _T_83 | io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 2382:55]
  assign perfmux_flop_io_mstatus_ns = _T_48 | _T_44; // @[dec_tlu_ctl.scala 2383:55]
  assign perfmux_flop_io_free_l2clk = io_free_l2clk; // @[dec_tlu_ctl.scala 2385:56]
  assign perf_csrs_clock = clock;
  assign perf_csrs_reset = reset;
  assign perf_csrs_io_free_l2clk = io_free_l2clk; // @[dec_tlu_ctl.scala 2389:50]
  assign perf_csrs_io_dec_tlu_dbg_halted = io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 2391:50]
  assign perf_csrs_io_dcsr = io_dcsr; // @[dec_tlu_ctl.scala 2392:50]
  assign perf_csrs_io_dec_tlu_pmu_fw_halted = io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 2393:50]
  assign perf_csrs_io_mhpme_vec_0 = perf_csrs_io_mhpme3; // @[dec_tlu_ctl.scala 2394:50]
  assign perf_csrs_io_mhpme_vec_1 = perf_csrs_io_mhpme4; // @[dec_tlu_ctl.scala 2394:50]
  assign perf_csrs_io_mhpme_vec_2 = perf_csrs_io_mhpme5; // @[dec_tlu_ctl.scala 2394:50]
  assign perf_csrs_io_mhpme_vec_3 = perf_csrs_io_mhpme6; // @[dec_tlu_ctl.scala 2394:50]
  assign perf_csrs_io_dec_csr_wen_r_mod = io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 2395:50]
  assign perf_csrs_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 2396:50]
  assign perf_csrs_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 2397:50]
  assign perf_csrs_io_mhpmc_inc_r_0 = perfmux_flop_io_mhpmc_inc_r_0; // @[dec_tlu_ctl.scala 2398:50]
  assign perf_csrs_io_mhpmc_inc_r_1 = perfmux_flop_io_mhpmc_inc_r_1; // @[dec_tlu_ctl.scala 2398:50]
  assign perf_csrs_io_mhpmc_inc_r_2 = perfmux_flop_io_mhpmc_inc_r_2; // @[dec_tlu_ctl.scala 2398:50]
  assign perf_csrs_io_mhpmc_inc_r_3 = perfmux_flop_io_mhpmc_inc_r_3; // @[dec_tlu_ctl.scala 2398:50]
  assign perf_csrs_io_mhpmc_inc_r_d1_0 = perfmux_flop_io_mhpmc_inc_r_d1_0; // @[dec_tlu_ctl.scala 2399:50]
  assign perf_csrs_io_mhpmc_inc_r_d1_1 = perfmux_flop_io_mhpmc_inc_r_d1_1; // @[dec_tlu_ctl.scala 2399:50]
  assign perf_csrs_io_mhpmc_inc_r_d1_2 = perfmux_flop_io_mhpmc_inc_r_d1_2; // @[dec_tlu_ctl.scala 2399:50]
  assign perf_csrs_io_mhpmc_inc_r_d1_3 = perfmux_flop_io_mhpmc_inc_r_d1_3; // @[dec_tlu_ctl.scala 2399:50]
  assign perf_csrs_io_perfcnt_halted_d1 = perfmux_flop_io_perfcnt_halted_d1; // @[dec_tlu_ctl.scala 2400:50]
  assign rvclkhdr_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_io_en = io_dec_csr_wen_r_mod & _T_57; // @[lib.scala 400:17]
  assign rvclkhdr_1_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_1_io_en = wr_mcyclel_r | _T_102; // @[lib.scala 400:17]
  assign rvclkhdr_2_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_2_io_en = wr_mcyclel_r | mcyclel_cout_in; // @[lib.scala 400:17]
  assign rvclkhdr_3_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_3_io_en = wr_mcycleh_r | perfmux_flop_io_mcyclel_cout_f; // @[lib.scala 400:17]
  assign rvclkhdr_4_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_4_io_en = wr_minstretl_r | _T_147; // @[lib.scala 400:17]
  assign rvclkhdr_5_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_5_io_en = _T_138 | wr_minstretl_r; // @[lib.scala 400:17]
  assign rvclkhdr_6_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_6_io_en = _T_162 | wr_minstreth_r; // @[lib.scala 400:17]
  assign rvclkhdr_7_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_7_io_en = io_dec_csr_wen_r_mod & _T_167; // @[lib.scala 400:17]
  assign rvclkhdr_8_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_8_io_en = _T_228 | wr_mepc_r; // @[lib.scala 400:17]
  assign rvclkhdr_9_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_9_io_en = io_exc_or_int_valid_r | wr_mcause_r; // @[lib.scala 400:17]
  assign rvclkhdr_10_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_10_io_en = io_tlu_flush_lower_r | wr_mtval_r; // @[lib.scala 400:17]
  assign rvclkhdr_11_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_11_io_en = io_dec_csr_wen_r_mod & _T_367; // @[lib.scala 400:17]
  assign rvclkhdr_12_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_12_io_en = io_dec_csr_wen_r_mod & _T_388; // @[lib.scala 400:17]
  assign rvclkhdr_13_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_13_io_en = io_dec_csr_wen_r_mod & _T_430; // @[lib.scala 400:17]
  assign rvclkhdr_14_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_14_io_en = _T_549 & _T_550; // @[lib.scala 400:17]
  assign rvclkhdr_15_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_15_io_en = wr_micect_r | io_ic_perr_r; // @[lib.scala 400:17]
  assign rvclkhdr_16_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_16_io_en = _T_605 | io_iccm_dma_sb_error; // @[lib.scala 400:17]
  assign rvclkhdr_17_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_17_io_en = wr_mdccmect_r | perfmux_flop_io_lsu_single_ecc_error_r_d1; // @[lib.scala 400:17]
  assign rvclkhdr_18_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_18_io_en = mfdht[0]; // @[lib.scala 400:17]
  assign rvclkhdr_19_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_19_io_en = io_dec_csr_wen_r_mod & _T_669; // @[lib.scala 400:17]
  assign rvclkhdr_20_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_20_io_en = _T_688 | io_take_ext_int_start; // @[lib.scala 400:17]
  assign rvclkhdr_21_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_21_io_en = _T_754 | io_take_nmi; // @[lib.scala 400:17]
  assign rvclkhdr_22_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_22_io_en = _T_779 | dpc_capture_npc; // @[lib.scala 400:17]
  assign rvclkhdr_23_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_23_io_en = _T_719 & _T_789; // @[lib.scala 400:17]
  assign rvclkhdr_24_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_24_io_en = wr_dicad0_r | io_ifu_ic_debug_rd_data_valid; // @[lib.scala 400:17]
  assign rvclkhdr_25_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_25_io_en = wr_dicad0h_r | io_ifu_ic_debug_rd_data_valid; // @[lib.scala 400:17]
  assign rvclkhdr_26_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_26_io_en = _T_809 | io_ifu_ic_debug_rd_data_valid; // @[lib.scala 400:17]
  assign rvclkhdr_27_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_27_io_en = io_trigger_enabled[0] | wr_mtdata1_t_r_0; // @[lib.scala 400:17]
  assign rvclkhdr_28_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_28_io_en = io_trigger_enabled[1] | wr_mtdata1_t_r_1; // @[lib.scala 400:17]
  assign rvclkhdr_29_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_29_io_en = io_trigger_enabled[2] | wr_mtdata1_t_r_2; // @[lib.scala 400:17]
  assign rvclkhdr_30_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_30_io_en = io_trigger_enabled[3] | wr_mtdata1_t_r_3; // @[lib.scala 400:17]
  assign rvclkhdr_31_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_31_io_en = _T_1074 & _T_894; // @[lib.scala 400:17]
  assign rvclkhdr_32_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_32_io_en = _T_1083 & _T_1086; // @[lib.scala 400:17]
  assign rvclkhdr_33_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_33_io_en = _T_1092 & _T_914; // @[lib.scala 400:17]
  assign rvclkhdr_34_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_34_io_en = _T_1101 & _T_1104; // @[lib.scala 400:17]
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
  _T_61 = _RAND_1[30:0];
  _RAND_2 = {1{`RANDOM}};
  mdccmect = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  miccmect = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  micect = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mie = _RAND_5[5:0];
  _RAND_6 = {1{`RANDOM}};
  temp_ncount6_2 = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  temp_ncount0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  _T_106 = _RAND_8[23:0];
  _RAND_9 = {1{`RANDOM}};
  _T_110 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  mcycleh = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  _T_150 = _RAND_11[23:0];
  _RAND_12 = {1{`RANDOM}};
  _T_153 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  minstreth = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  mscratch = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  _T_196 = _RAND_15[30:0];
  _RAND_16 = {1{`RANDOM}};
  pc_r_d1 = _RAND_16[30:0];
  _RAND_17 = {1{`RANDOM}};
  _T_231 = _RAND_17[30:0];
  _RAND_18 = {1{`RANDOM}};
  mcause = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mscause = _RAND_19[3:0];
  _RAND_20 = {1{`RANDOM}};
  mtval = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  mcgc_int = _RAND_21[9:0];
  _RAND_22 = {1{`RANDOM}};
  mfdc_int = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  mrac = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  mdseac = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  mfdht = _RAND_25[5:0];
  _RAND_26 = {1{`RANDOM}};
  mfdhs = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  force_halt_ctr_f = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  meivt = _RAND_28[21:0];
  _RAND_29 = {1{`RANDOM}};
  meihap = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  meicurpl = _RAND_30[3:0];
  _RAND_31 = {1{`RANDOM}};
  meipt = _RAND_31[3:0];
  _RAND_32 = {1{`RANDOM}};
  _T_757 = _RAND_32[15:0];
  _RAND_33 = {1{`RANDOM}};
  _T_782 = _RAND_33[30:0];
  _RAND_34 = {1{`RANDOM}};
  dicawics = _RAND_34[16:0];
  _RAND_35 = {1{`RANDOM}};
  dicad0 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  dicad0h = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  _T_816 = _RAND_37[6:0];
  _RAND_38 = {1{`RANDOM}};
  mtsel = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  _T_966 = _RAND_39[9:0];
  _RAND_40 = {1{`RANDOM}};
  _T_970 = _RAND_40[9:0];
  _RAND_41 = {1{`RANDOM}};
  _T_974 = _RAND_41[9:0];
  _RAND_42 = {1{`RANDOM}};
  _T_978 = _RAND_42[9:0];
  _RAND_43 = {1{`RANDOM}};
  mtdata2_t_0 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  mtdata2_t_1 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  mtdata2_t_2 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  mtdata2_t_3 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  dec_tlu_exc_cause_wb2 = _RAND_47[4:0];
  _RAND_48 = {1{`RANDOM}};
  dec_tlu_int_valid_wb2 = _RAND_48[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    mpmc_b = 1'h0;
  end
  if (reset) begin
    _T_61 = 31'h0;
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
    mie = 6'h0;
  end
  if (reset) begin
    temp_ncount6_2 = 5'h0;
  end
  if (reset) begin
    temp_ncount0 = 1'h0;
  end
  if (reset) begin
    _T_106 = 24'h0;
  end
  if (reset) begin
    _T_110 = 8'h0;
  end
  if (reset) begin
    mcycleh = 32'h0;
  end
  if (reset) begin
    _T_150 = 24'h0;
  end
  if (reset) begin
    _T_153 = 8'h0;
  end
  if (reset) begin
    minstreth = 32'h0;
  end
  if (reset) begin
    mscratch = 32'h0;
  end
  if (reset) begin
    _T_196 = 31'h0;
  end
  if (reset) begin
    pc_r_d1 = 31'h0;
  end
  if (reset) begin
    _T_231 = 31'h0;
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
    mcgc_int = 10'h0;
  end
  if (reset) begin
    mfdc_int = 16'h0;
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
    meipt = 4'h0;
  end
  if (reset) begin
    _T_757 = 16'h0;
  end
  if (reset) begin
    _T_782 = 31'h0;
  end
  if (reset) begin
    dicawics = 17'h0;
  end
  if (reset) begin
    dicad0 = 32'h0;
  end
  if (reset) begin
    dicad0h = 32'h0;
  end
  if (reset) begin
    _T_816 = 7'h0;
  end
  if (reset) begin
    mtsel = 2'h0;
  end
  if (reset) begin
    _T_966 = 10'h0;
  end
  if (reset) begin
    _T_970 = 10'h0;
  end
  if (reset) begin
    _T_974 = 10'h0;
  end
  if (reset) begin
    _T_978 = 10'h0;
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
    dec_tlu_exc_cause_wb2 = 5'h0;
  end
  if (reset) begin
    dec_tlu_int_valid_wb2 = 1'h0;
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
      mpmc_b <= _T_566;
    end else begin
      mpmc_b <= _T_567;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_61 <= 31'h0;
    end else if (wr_mtvec_r) begin
      _T_61 <= mtvec_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mdccmect <= 32'h0;
    end else if (_T_626) begin
      if (wr_mdccmect_r) begin
        mdccmect <= _T_581;
      end else begin
        mdccmect <= _T_625;
      end
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      miccmect <= 32'h0;
    end else if (_T_606) begin
      if (wr_miccmect_r) begin
        miccmect <= _T_581;
      end else begin
        miccmect <= _T_604;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      micect <= 32'h0;
    end else if (_T_584) begin
      if (wr_micect_r) begin
        micect <= _T_581;
      end else begin
        micect <= _T_583;
      end
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mie <= 6'h0;
    end else begin
      mie <= io_mie_ns;
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      temp_ncount6_2 <= 5'h0;
    end else if (wr_mcountinhibit_r) begin
      temp_ncount6_2 <= io_dec_csr_wrdata_r[6:2];
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      temp_ncount0 <= 1'h0;
    end else if (wr_mcountinhibit_r) begin
      temp_ncount0 <= io_dec_csr_wrdata_r[0];
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_106 <= 24'h0;
    end else if (_T_104) begin
      _T_106 <= mcyclel_ns[31:8];
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_110 <= 8'h0;
    end else if (_T_108) begin
      _T_110 <= mcyclel_ns[7:0];
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mcycleh <= 32'h0;
    end else if (_T_117) begin
      if (wr_mcycleh_r) begin
        mcycleh <= io_dec_csr_wrdata_r;
      end else begin
        mcycleh <= mcycleh_inc;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_150 <= 24'h0;
    end else if (_T_148) begin
      _T_150 <= minstretl_ns[31:8];
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_153 <= 8'h0;
    end else if (minstret_enable) begin
      _T_153 <= minstretl_ns[7:0];
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      minstreth <= 32'h0;
    end else if (_T_163) begin
      if (wr_minstreth_r) begin
        minstreth <= io_dec_csr_wrdata_r;
      end else begin
        minstreth <= minstreth_inc;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mscratch <= 32'h0;
    end else if (wr_mscratch_r) begin
      mscratch <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_196 <= 31'h0;
    end else if (_T_193) begin
      _T_196 <= io_npc_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      pc_r_d1 <= 31'h0;
    end else if (pc0_valid_r) begin
      pc_r_d1 <= pc_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_231 <= 31'h0;
    end else if (_T_229) begin
      _T_231 <= mepc_ns;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mcause <= 32'h0;
    end else if (_T_274) begin
      mcause <= mcause_ns;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mscause <= 4'h0;
    end else begin
      mscause <= _T_304 | _T_303;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mtval <= 32'h0;
    end else if (_T_363) begin
      mtval <= mtval_ns;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mcgc_int <= 10'h0;
    end else if (wr_mcgc_r) begin
      if (wr_mcgc_r) begin
        mcgc_int <= _T_372;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mfdc_int <= 16'h0;
    end else if (wr_mfdc_r) begin
      mfdc_int <= mfdc_ns;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mrac <= 32'h0;
    end else if (wr_mrac_r) begin
      mrac <= mrac_in;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mdseac <= 32'h0;
    end else if (mdseac_en) begin
      mdseac <= io_lsu_imprecise_error_addr_any;
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mfdht <= 6'h0;
    end else if (wr_mfdht_r) begin
      if (wr_mfdht_r) begin
        mfdht <= io_dec_csr_wrdata_r[5:0];
      end
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mfdhs <= 2'h0;
    end else if (_T_652) begin
      if (wr_mfdhs_r) begin
        mfdhs <= io_dec_csr_wrdata_r[1:0];
      end else if (_T_646) begin
        mfdhs <= _T_650;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      force_halt_ctr_f <= 32'h0;
    end else if (mfdht[0]) begin
      if (io_debug_halt_req_f) begin
        force_halt_ctr_f <= _T_657;
      end else if (io_dbg_tlu_halted_f) begin
        force_halt_ctr_f <= 32'h0;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      meivt <= 22'h0;
    end else if (wr_meivt_r) begin
      meivt <= io_dec_csr_wrdata_r[31:10];
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      meihap <= 8'h0;
    end else if (wr_meicpct_r) begin
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
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      meipt <= 4'h0;
    end else if (wr_meipt_r) begin
      meipt <= io_dec_csr_wrdata_r[3:0];
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_757 <= 16'h0;
    end else if (_T_755) begin
      if (enter_debug_halt_req_le) begin
        _T_757 <= _T_731;
      end else if (wr_dcsr_r) begin
        _T_757 <= _T_746;
      end else begin
        _T_757 <= _T_751;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_782 <= 31'h0;
    end else if (_T_780) begin
      _T_782 <= dpc_ns;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      dicawics <= 17'h0;
    end else if (wr_dicawics_r) begin
      dicawics <= dicawics_ns;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      dicad0 <= 32'h0;
    end else if (_T_796) begin
      if (wr_dicad0_r) begin
        dicad0 <= io_dec_csr_wrdata_r;
      end else begin
        dicad0 <= io_ifu_ic_debug_rd_data[31:0];
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      dicad0h <= 32'h0;
    end else if (_T_803) begin
      if (wr_dicad0h_r) begin
        dicad0h <= io_dec_csr_wrdata_r;
      end else begin
        dicad0h <= io_ifu_ic_debug_rd_data[63:32];
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_816 <= 7'h0;
    end else if (_T_814) begin
      if (_T_809) begin
        _T_816 <= io_dec_csr_wrdata_r[6:0];
      end else begin
        _T_816 <= io_ifu_ic_debug_rd_data[70:64];
      end
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mtsel <= 2'h0;
    end else if (wr_mtsel_r) begin
      mtsel <= io_dec_csr_wrdata_r[1:0];
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_966 <= 10'h0;
    end else if (_T_964) begin
      if (wr_mtdata1_t_r_0) begin
        _T_966 <= tdata_wrdata_r;
      end else begin
        _T_966 <= _T_934;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_970 <= 10'h0;
    end else if (_T_968) begin
      if (wr_mtdata1_t_r_1) begin
        _T_970 <= tdata_wrdata_r;
      end else begin
        _T_970 <= _T_943;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_974 <= 10'h0;
    end else if (_T_972) begin
      if (wr_mtdata1_t_r_2) begin
        _T_974 <= tdata_wrdata_r;
      end else begin
        _T_974 <= _T_952;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_978 <= 10'h0;
    end else if (_T_976) begin
      if (wr_mtdata1_t_r_3) begin
        _T_978 <= tdata_wrdata_r;
      end else begin
        _T_978 <= _T_961;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mtdata2_t_0 <= 32'h0;
    end else if (wr_mtdata2_t_r_0) begin
      mtdata2_t_0 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mtdata2_t_1 <= 32'h0;
    end else if (wr_mtdata2_t_r_1) begin
      mtdata2_t_1 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mtdata2_t_2 <= 32'h0;
    end else if (wr_mtdata2_t_r_2) begin
      mtdata2_t_2 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mtdata2_t_3 <= 32'h0;
    end else if (wr_mtdata2_t_r_3) begin
      mtdata2_t_3 <= io_dec_csr_wrdata_r;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      dec_tlu_exc_cause_wb2 <= 5'h0;
    end else if (_T_1154) begin
      dec_tlu_exc_cause_wb2 <= dec_tlu_exc_cause_wb1_raw;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      dec_tlu_int_valid_wb2 <= 1'h0;
    end else if (_T_1157) begin
      dec_tlu_int_valid_wb2 <= dec_tlu_int_valid_wb1_raw;
    end
  end
endmodule
module dec_timer_ctl(
  input         clock,
  input         reset,
  input         io_free_l2clk,
  input         io_csr_wr_clk,
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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  rvclkhdr_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_1_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_1_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_2_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_2_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_3_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_3_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_4_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_4_io_en; // @[lib.scala 397:23]
  wire  rvclkhdr_5_io_clk; // @[lib.scala 397:23]
  wire  rvclkhdr_5_io_en; // @[lib.scala 397:23]
  reg [23:0] _T_28; // @[Reg.scala 27:20]
  reg [7:0] _T_33; // @[Reg.scala 27:20]
  wire [31:0] mitcnt0 = {_T_28,_T_33}; // @[Cat.scala 29:58]
  reg [31:0] mitb0_b; // @[Reg.scala 27:20]
  wire [31:0] mitb0 = ~mitb0_b; // @[dec_tlu_ctl.scala 3303:22]
  wire  mit0_match_ns = mitcnt0 >= mitb0; // @[dec_tlu_ctl.scala 3246:36]
  reg [23:0] _T_67; // @[Reg.scala 27:20]
  reg [7:0] _T_72; // @[Reg.scala 27:20]
  wire [31:0] mitcnt1 = {_T_67,_T_72}; // @[Cat.scala 29:58]
  reg [31:0] mitb1_b; // @[Reg.scala 27:20]
  wire [31:0] mitb1 = ~mitb1_b; // @[dec_tlu_ctl.scala 3312:18]
  wire  mit1_match_ns = mitcnt1 >= mitb1; // @[dec_tlu_ctl.scala 3247:36]
  wire  _T = io_dec_csr_wraddr_r == 12'h7d2; // @[dec_tlu_ctl.scala 3257:72]
  wire  wr_mitcnt0_r = io_dec_csr_wen_r_mod & _T; // @[dec_tlu_ctl.scala 3257:49]
  reg [1:0] _T_90; // @[Reg.scala 27:20]
  reg  mitctl0_0_b; // @[Reg.scala 27:20]
  wire  _T_91 = ~mitctl0_0_b; // @[dec_tlu_ctl.scala 3328:107]
  wire [2:0] mitctl0 = {_T_90,_T_91}; // @[Cat.scala 29:58]
  wire  _T_2 = ~io_dec_pause_state; // @[dec_tlu_ctl.scala 3259:56]
  wire  _T_4 = _T_2 | mitctl0[2]; // @[dec_tlu_ctl.scala 3259:76]
  wire  _T_5 = mitctl0[0] & _T_4; // @[dec_tlu_ctl.scala 3259:53]
  wire  _T_6 = ~io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 3259:112]
  wire  _T_8 = _T_6 | mitctl0[1]; // @[dec_tlu_ctl.scala 3259:138]
  wire  _T_9 = _T_5 & _T_8; // @[dec_tlu_ctl.scala 3259:109]
  wire  _T_10 = ~io_internal_dbg_halt_timers; // @[dec_tlu_ctl.scala 3259:173]
  wire  mitcnt0_inc_ok = _T_9 & _T_10; // @[dec_tlu_ctl.scala 3259:171]
  wire [7:0] _T_14 = mitcnt0[7:0] + 8'h1; // @[dec_tlu_ctl.scala 3262:39]
  wire [8:0] mitcnt0_inc1 = {{1'd0}, _T_14}; // @[dec_tlu_ctl.scala 3262:23]
  wire  mitcnt0_inc_cout = mitcnt0_inc1[8]; // @[dec_tlu_ctl.scala 3263:44]
  wire [23:0] _T_16 = {23'h0,mitcnt0_inc_cout}; // @[Cat.scala 29:58]
  wire [23:0] mitcnt0_inc2 = mitcnt0[31:8] + _T_16; // @[dec_tlu_ctl.scala 3264:39]
  wire [31:0] mitcnt0_inc = {mitcnt0_inc2,mitcnt0_inc1[7:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_22 = mit0_match_ns ? 32'h0 : mitcnt0_inc; // @[dec_tlu_ctl.scala 3267:69]
  wire [31:0] mitcnt0_ns = wr_mitcnt0_r ? io_dec_csr_wrdata_r : _T_22; // @[dec_tlu_ctl.scala 3267:30]
  wire  _T_24 = mitcnt0_inc_ok & mitcnt0_inc_cout; // @[dec_tlu_ctl.scala 3269:87]
  wire  _T_25 = wr_mitcnt0_r | _T_24; // @[dec_tlu_ctl.scala 3269:69]
  wire  _T_26 = _T_25 | mit0_match_ns; // @[dec_tlu_ctl.scala 3269:107]
  wire  _T_30 = wr_mitcnt0_r | mitcnt0_inc_ok; // @[dec_tlu_ctl.scala 3270:104]
  wire  _T_31 = _T_30 | mit0_match_ns; // @[dec_tlu_ctl.scala 3270:121]
  wire  _T_35 = io_dec_csr_wraddr_r == 12'h7d5; // @[dec_tlu_ctl.scala 3277:66]
  wire  wr_mitcnt1_r = io_dec_csr_wen_r_mod & _T_35; // @[dec_tlu_ctl.scala 3277:43]
  reg [2:0] _T_101; // @[Reg.scala 27:20]
  reg  mitctl1_0_b; // @[Reg.scala 27:20]
  wire  _T_102 = ~mitctl1_0_b; // @[dec_tlu_ctl.scala 3342:92]
  wire [3:0] mitctl1 = {_T_101,_T_102}; // @[Cat.scala 29:58]
  wire  _T_39 = _T_2 | mitctl1[2]; // @[dec_tlu_ctl.scala 3279:70]
  wire  _T_40 = mitctl1[0] & _T_39; // @[dec_tlu_ctl.scala 3279:47]
  wire  _T_43 = _T_6 | mitctl1[1]; // @[dec_tlu_ctl.scala 3279:132]
  wire  _T_44 = _T_40 & _T_43; // @[dec_tlu_ctl.scala 3279:103]
  wire  _T_46 = _T_44 & _T_10; // @[dec_tlu_ctl.scala 3279:165]
  wire  _T_48 = ~mitctl1[3]; // @[dec_tlu_ctl.scala 3279:199]
  wire  _T_49 = _T_48 | mit0_match_ns; // @[dec_tlu_ctl.scala 3279:211]
  wire  mitcnt1_inc_ok = _T_46 & _T_49; // @[dec_tlu_ctl.scala 3279:196]
  wire [7:0] _T_53 = mitcnt1[7:0] + 8'h1; // @[dec_tlu_ctl.scala 3284:38]
  wire [8:0] mitcnt1_inc1 = {{1'd0}, _T_53}; // @[dec_tlu_ctl.scala 3284:22]
  wire  mitcnt1_inc_cout = mitcnt1_inc1[8]; // @[dec_tlu_ctl.scala 3285:44]
  wire [23:0] _T_55 = {23'h0,mitcnt1_inc_cout}; // @[Cat.scala 29:58]
  wire [23:0] mitcnt1_inc2 = mitcnt1[31:8] + _T_55; // @[dec_tlu_ctl.scala 3286:39]
  wire [31:0] mitcnt1_inc = {mitcnt1_inc2,mitcnt1_inc1[7:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_61 = mit1_match_ns ? 32'h0 : mitcnt1_inc; // @[dec_tlu_ctl.scala 3289:75]
  wire [31:0] mitcnt1_ns = wr_mitcnt1_r ? io_dec_csr_wrdata_r : _T_61; // @[dec_tlu_ctl.scala 3289:29]
  wire  _T_63 = mitcnt1_inc_ok & mitcnt1_inc_cout; // @[dec_tlu_ctl.scala 3291:87]
  wire  _T_64 = wr_mitcnt1_r | _T_63; // @[dec_tlu_ctl.scala 3291:69]
  wire  _T_65 = _T_64 | mit1_match_ns; // @[dec_tlu_ctl.scala 3291:107]
  wire  _T_69 = wr_mitcnt1_r | mitcnt1_inc_ok; // @[dec_tlu_ctl.scala 3292:98]
  wire  _T_70 = _T_69 | mit1_match_ns; // @[dec_tlu_ctl.scala 3292:115]
  wire  _T_74 = io_dec_csr_wraddr_r == 12'h7d3; // @[dec_tlu_ctl.scala 3301:70]
  wire  wr_mitb0_r = io_dec_csr_wen_r_mod & _T_74; // @[dec_tlu_ctl.scala 3301:47]
  wire [31:0] _T_75 = ~io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 3302:38]
  wire  _T_78 = io_dec_csr_wraddr_r == 12'h7d6; // @[dec_tlu_ctl.scala 3310:69]
  wire  wr_mitb1_r = io_dec_csr_wen_r_mod & _T_78; // @[dec_tlu_ctl.scala 3310:47]
  wire  _T_82 = io_dec_csr_wraddr_r == 12'h7d4; // @[dec_tlu_ctl.scala 3323:72]
  wire  wr_mitctl0_r = io_dec_csr_wen_r_mod & _T_82; // @[dec_tlu_ctl.scala 3323:49]
  wire [2:0] mitctl0_ns = wr_mitctl0_r ? io_dec_csr_wrdata_r[2:0] : mitctl0; // @[dec_tlu_ctl.scala 3324:31]
  wire  mitctl0_0_b_ns = ~mitctl0_ns[0]; // @[dec_tlu_ctl.scala 3326:30]
  wire  _T_93 = io_dec_csr_wraddr_r == 12'h7d7; // @[dec_tlu_ctl.scala 3338:71]
  wire  wr_mitctl1_r = io_dec_csr_wen_r_mod & _T_93; // @[dec_tlu_ctl.scala 3338:49]
  wire [3:0] mitctl1_ns = wr_mitctl1_r ? io_dec_csr_wrdata_r[3:0] : mitctl1; // @[dec_tlu_ctl.scala 3339:31]
  wire  mitctl1_0_b_ns = ~mitctl1_ns[0]; // @[dec_tlu_ctl.scala 3340:29]
  wire  _T_104 = io_csr_mitcnt1 | io_csr_mitcnt0; // @[dec_tlu_ctl.scala 3344:51]
  wire  _T_105 = _T_104 | io_csr_mitb1; // @[dec_tlu_ctl.scala 3344:68]
  wire  _T_106 = _T_105 | io_csr_mitb0; // @[dec_tlu_ctl.scala 3344:83]
  wire  _T_107 = _T_106 | io_csr_mitctl0; // @[dec_tlu_ctl.scala 3344:98]
  wire [31:0] _T_116 = {29'h0,_T_90,_T_91}; // @[Cat.scala 29:58]
  wire [31:0] _T_119 = {28'h0,_T_101,_T_102}; // @[Cat.scala 29:58]
  wire [31:0] _T_120 = io_csr_mitcnt0 ? mitcnt0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_121 = io_csr_mitcnt1 ? mitcnt1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_122 = io_csr_mitb0 ? mitb0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_123 = io_csr_mitb1 ? mitb1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_124 = io_csr_mitctl0 ? _T_116 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_125 = io_csr_mitctl1 ? _T_119 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_126 = _T_120 | _T_121; // @[Mux.scala 27:72]
  wire [31:0] _T_127 = _T_126 | _T_122; // @[Mux.scala 27:72]
  wire [31:0] _T_128 = _T_127 | _T_123; // @[Mux.scala 27:72]
  wire [31:0] _T_129 = _T_128 | _T_124; // @[Mux.scala 27:72]
  rvclkhdr rvclkhdr ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en)
  );
  rvclkhdr rvclkhdr_1 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en)
  );
  rvclkhdr rvclkhdr_2 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en)
  );
  rvclkhdr rvclkhdr_3 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en)
  );
  rvclkhdr rvclkhdr_4 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en)
  );
  rvclkhdr rvclkhdr_5 ( // @[lib.scala 397:23]
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en)
  );
  assign io_dec_timer_rddata_d = _T_129 | _T_125; // @[dec_tlu_ctl.scala 3345:33]
  assign io_dec_timer_read_d = _T_107 | io_csr_mitctl1; // @[dec_tlu_ctl.scala 3344:33]
  assign io_dec_timer_t0_pulse = mitcnt0 >= mitb0; // @[dec_tlu_ctl.scala 3249:31]
  assign io_dec_timer_t1_pulse = mitcnt1 >= mitb1; // @[dec_tlu_ctl.scala 3250:31]
  assign rvclkhdr_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_io_en = _T_25 | mit0_match_ns; // @[lib.scala 400:17]
  assign rvclkhdr_1_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_1_io_en = _T_30 | mit0_match_ns; // @[lib.scala 400:17]
  assign rvclkhdr_2_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_2_io_en = _T_64 | mit1_match_ns; // @[lib.scala 400:17]
  assign rvclkhdr_3_io_clk = io_free_l2clk; // @[lib.scala 399:18]
  assign rvclkhdr_3_io_en = _T_69 | mit1_match_ns; // @[lib.scala 400:17]
  assign rvclkhdr_4_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_4_io_en = io_dec_csr_wen_r_mod & _T_74; // @[lib.scala 400:17]
  assign rvclkhdr_5_io_clk = clock; // @[lib.scala 399:18]
  assign rvclkhdr_5_io_en = io_dec_csr_wen_r_mod & _T_78; // @[lib.scala 400:17]
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
  _T_28 = _RAND_0[23:0];
  _RAND_1 = {1{`RANDOM}};
  _T_33 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mitb0_b = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  _T_67 = _RAND_3[23:0];
  _RAND_4 = {1{`RANDOM}};
  _T_72 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  mitb1_b = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  _T_90 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  mitctl0_0_b = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  _T_101 = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  mitctl1_0_b = _RAND_9[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    _T_28 = 24'h0;
  end
  if (reset) begin
    _T_33 = 8'h0;
  end
  if (reset) begin
    mitb0_b = 32'h0;
  end
  if (reset) begin
    _T_67 = 24'h0;
  end
  if (reset) begin
    _T_72 = 8'h0;
  end
  if (reset) begin
    mitb1_b = 32'h0;
  end
  if (reset) begin
    _T_90 = 2'h0;
  end
  if (reset) begin
    mitctl0_0_b = 1'h0;
  end
  if (reset) begin
    _T_101 = 3'h0;
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
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_28 <= 24'h0;
    end else if (_T_26) begin
      _T_28 <= mitcnt0_ns[31:8];
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_33 <= 8'h0;
    end else if (_T_31) begin
      _T_33 <= mitcnt0_ns[7:0];
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mitb0_b <= 32'h0;
    end else if (wr_mitb0_r) begin
      mitb0_b <= _T_75;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_67 <= 24'h0;
    end else if (_T_65) begin
      _T_67 <= mitcnt1_ns[31:8];
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_72 <= 8'h0;
    end else if (_T_70) begin
      _T_72 <= mitcnt1_ns[7:0];
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      mitb1_b <= 32'h0;
    end else if (wr_mitb1_r) begin
      mitb1_b <= _T_75;
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      _T_90 <= 2'h0;
    end else if (wr_mitctl0_r) begin
      _T_90 <= mitctl0_ns[2:1];
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mitctl0_0_b <= 1'h0;
    end else if (wr_mitctl0_r) begin
      mitctl0_0_b <= mitctl0_0_b_ns;
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      _T_101 <= 3'h0;
    end else if (wr_mitctl1_r) begin
      _T_101 <= mitctl1_ns[3:1];
    end
  end
  always @(posedge io_csr_wr_clk or posedge reset) begin
    if (reset) begin
      mitctl1_0_b <= 1'h0;
    end else if (wr_mitctl1_r) begin
      mitctl1_0_b <= mitctl1_0_b_ns;
    end
  end
endmodule
module dec_decode_csr_read(
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
  wire  _T_1 = ~io_dec_csr_rdaddr_d[11]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_3 = ~io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_5 = ~io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_7 = ~io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_9 = _T_1 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_10 = _T_9 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_11 = _T_10 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_15 = ~io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_17 = ~io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_19 = io_dec_csr_rdaddr_d[10] & _T_15; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_20 = _T_19 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_27 = ~io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:165]
  wire  _T_29 = _T_19 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_36 = io_dec_csr_rdaddr_d[10] & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_37 = _T_36 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_69 = _T_10 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_70 = _T_69 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_75 = _T_15 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_94 = ~io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_96 = ~io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_101 = io_dec_csr_rdaddr_d[11] & _T_15; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_102 = _T_101 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_103 = _T_102 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_104 = _T_103 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_119 = io_dec_csr_rdaddr_d[7] & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_120 = _T_119 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_121 = _T_120 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_122 = _T_121 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_123 = _T_122 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_138 = _T_15 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_139 = _T_138 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_140 = _T_139 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_141 = _T_140 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_142 = _T_141 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_145 = ~io_dec_csr_rdaddr_d[10]; // @[dec_tlu_ctl.scala 3142:129]
  wire  _T_156 = _T_145 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_157 = _T_156 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_158 = _T_157 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_159 = _T_158 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_160 = _T_159 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_172 = _T_75 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_173 = _T_172 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_182 = _T_75 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_183 = _T_182 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_191 = _T_75 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_196 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_217 = _T_1 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_218 = _T_217 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_219 = _T_218 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_220 = _T_219 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_230 = io_dec_csr_rdaddr_d[10] & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_231 = _T_230 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_232 = _T_231 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_240 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[10]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_241 = _T_240 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_258 = _T_145 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_259 = _T_258 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_260 = _T_259 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_261 = _T_260 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_268 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_269 = _T_268 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_281 = _T_268 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_291 = _T_36 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_292 = _T_291 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_299 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_300 = _T_299 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_310 = _T_300 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_311 = _T_310 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_330 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_331 = _T_330 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_332 = _T_331 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_342 = _T_231 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_381 = _T_103 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_382 = _T_381 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_397 = _T_103 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_411 = _T_15 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_412 = _T_411 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_413 = _T_412 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_414 = _T_413 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_415 = _T_414 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_426 = io_dec_csr_rdaddr_d[7] & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_427 = _T_426 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_428 = _T_427 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_429 = _T_428 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_444 = _T_119 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_445 = _T_444 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_446 = _T_445 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_447 = _T_446 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_460 = _T_427 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_461 = _T_460 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_478 = _T_446 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_490 = _T_15 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_491 = _T_490 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_492 = _T_491 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_493 = _T_492 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_505 = io_dec_csr_rdaddr_d[5] & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_506 = _T_505 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_507 = _T_506 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_508 = _T_507 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_536 = _T_507 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_553 = _T_493 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_562 = io_dec_csr_rdaddr_d[6] & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_563 = _T_562 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_564 = _T_563 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_572 = io_dec_csr_rdaddr_d[6] & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_573 = _T_572 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_574 = _T_573 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_585 = _T_563 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_593 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_594 = _T_593 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_595 = _T_594 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_614 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_615 = _T_614 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_624 = io_dec_csr_rdaddr_d[6] & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_625 = _T_624 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_626 = _T_625 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_645 = _T_196 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_646 = _T_645 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_662 = _T_196 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_670 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_671 = _T_670 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_672 = _T_671 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_680 = _T_624 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_693 = _T_1 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_694 = _T_693 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_695 = _T_694 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_696 = _T_695 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_703 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_704 = _T_703 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_714 = _T_230 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_715 = _T_714 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_725 = _T_703 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_726 = _T_725 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_764 = _T_311 | _T_553; // @[dec_tlu_ctl.scala 3210:81]
  wire  _T_776 = _T_3 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_777 = _T_776 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_778 = _T_777 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_779 = _T_778 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_780 = _T_779 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_781 = _T_764 | _T_780; // @[dec_tlu_ctl.scala 3210:121]
  wire  _T_790 = io_dec_csr_rdaddr_d[11] & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_791 = _T_790 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_792 = _T_791 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_793 = _T_792 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_794 = _T_781 | _T_793; // @[dec_tlu_ctl.scala 3210:155]
  wire  _T_805 = _T_791 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_806 = _T_805 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_807 = _T_794 | _T_806; // @[dec_tlu_ctl.scala 3211:97]
  wire  _T_818 = io_dec_csr_rdaddr_d[7] & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_819 = _T_818 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_820 = _T_819 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_821 = _T_820 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_822 = _T_821 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_846 = _T_311 | _T_70; // @[dec_tlu_ctl.scala 3212:81]
  wire  _T_856 = _T_846 | _T_183; // @[dec_tlu_ctl.scala 3212:121]
  wire  _T_866 = _T_856 | _T_342; // @[dec_tlu_ctl.scala 3212:162]
  wire  _T_881 = _T_1 & _T_15; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_882 = _T_881 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_883 = _T_882 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_884 = _T_883 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_885 = _T_884 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_886 = _T_885 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_887 = _T_866 | _T_886; // @[dec_tlu_ctl.scala 3213:105]
  wire  _T_899 = _T_217 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_900 = _T_899 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_901 = _T_900 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_902 = _T_901 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_903 = _T_887 | _T_902; // @[dec_tlu_ctl.scala 3213:145]
  wire  _T_914 = _T_231 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_915 = _T_914 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_932 = _T_1 & io_dec_csr_rdaddr_d[10]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_933 = _T_932 & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_934 = _T_933 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_935 = _T_934 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_936 = _T_935 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_937 = _T_936 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_938 = _T_937 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_939 = _T_938 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_940 = _T_939 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_941 = _T_940 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_960 = _T_1 & _T_145; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_961 = _T_960 & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_962 = _T_961 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_963 = _T_962 & _T_15; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_964 = _T_963 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_965 = _T_964 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_966 = _T_965 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_967 = _T_966 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_968 = _T_967 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_969 = _T_941 | _T_968; // @[dec_tlu_ctl.scala 3215:81]
  wire  _T_990 = _T_964 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_991 = _T_990 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_992 = _T_991 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_993 = _T_969 | _T_992; // @[dec_tlu_ctl.scala 3215:129]
  wire  _T_1009 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1010 = _T_1009 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1011 = _T_1010 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1012 = _T_1011 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1013 = _T_1012 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1014 = _T_1013 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1015 = _T_1014 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1016 = _T_1015 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1017 = _T_1016 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1018 = _T_993 | _T_1017; // @[dec_tlu_ctl.scala 3216:105]
  wire  _T_1030 = io_dec_csr_rdaddr_d[11] & _T_145; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1031 = _T_1030 & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1032 = _T_1031 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1033 = _T_1032 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1034 = _T_1033 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1035 = _T_1034 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1036 = _T_1018 | _T_1035; // @[dec_tlu_ctl.scala 3216:153]
  wire  _T_1055 = _T_936 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1056 = _T_1055 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1057 = _T_1056 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1058 = _T_1057 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1059 = _T_1058 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1060 = _T_1059 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1061 = _T_1036 | _T_1060; // @[dec_tlu_ctl.scala 3217:105]
  wire  _T_1082 = _T_1056 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1083 = _T_1082 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1084 = _T_1061 | _T_1083; // @[dec_tlu_ctl.scala 3217:153]
  wire  _T_1102 = _T_1010 & _T_15; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1103 = _T_1102 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1104 = _T_1103 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1105 = _T_1104 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1106 = _T_1105 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1107 = _T_1106 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1108 = _T_1107 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1109 = _T_1084 | _T_1108; // @[dec_tlu_ctl.scala 3218:105]
  wire  _T_1129 = _T_935 & _T_3; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1130 = _T_1129 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1131 = _T_1130 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1132 = _T_1131 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1133 = _T_1132 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1134 = _T_1109 | _T_1133; // @[dec_tlu_ctl.scala 3218:161]
  wire  _T_1153 = _T_990 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1154 = _T_1134 | _T_1153; // @[dec_tlu_ctl.scala 3219:105]
  wire  _T_1179 = _T_1106 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1180 = _T_1179 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1181 = _T_1180 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1182 = _T_1154 | _T_1181; // @[dec_tlu_ctl.scala 3219:161]
  wire  _T_1201 = _T_936 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1202 = _T_1201 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1203 = _T_1202 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1204 = _T_1203 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1205 = _T_1182 | _T_1204; // @[dec_tlu_ctl.scala 3220:97]
  wire  _T_1225 = _T_1201 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1226 = _T_1225 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1227 = _T_1226 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1228 = _T_1205 | _T_1227; // @[dec_tlu_ctl.scala 3220:153]
  wire  _T_1252 = _T_1107 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1253 = _T_1228 | _T_1252; // @[dec_tlu_ctl.scala 3221:105]
  wire  _T_1273 = _T_990 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1274 = _T_1273 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1275 = _T_1253 | _T_1274; // @[dec_tlu_ctl.scala 3221:161]
  wire  _T_1292 = _T_1032 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1293 = _T_1292 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1294 = _T_1293 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1295 = _T_1294 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1296 = _T_1295 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1297 = _T_1275 | _T_1296; // @[dec_tlu_ctl.scala 3222:105]
  wire  _T_1320 = _T_1295 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1321 = _T_1320 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1322 = _T_1297 | _T_1321; // @[dec_tlu_ctl.scala 3222:161]
  wire  _T_1338 = _T_1034 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1339 = _T_1322 | _T_1338; // @[dec_tlu_ctl.scala 3223:105]
  wire  _T_1361 = _T_1226 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1362 = _T_1339 | _T_1361; // @[dec_tlu_ctl.scala 3223:161]
  wire  _T_1383 = _T_1202 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1384 = _T_1362 | _T_1383; // @[dec_tlu_ctl.scala 3224:105]
  wire  _T_1407 = _T_1203 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1408 = _T_1384 | _T_1407; // @[dec_tlu_ctl.scala 3224:161]
  wire  _T_1432 = _T_1130 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1433 = _T_1432 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1434 = _T_1433 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1435 = _T_1434 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1436 = _T_1408 | _T_1435; // @[dec_tlu_ctl.scala 3225:105]
  wire  _T_1452 = _T_1034 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1453 = _T_1436 | _T_1452; // @[dec_tlu_ctl.scala 3225:153]
  wire  _T_1475 = _T_963 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1476 = _T_1475 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1477 = _T_1476 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1478 = _T_1477 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1479 = _T_1478 & _T_7; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1480 = _T_1453 | _T_1479; // @[dec_tlu_ctl.scala 3226:113]
  wire  _T_1503 = _T_963 & _T_5; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1504 = _T_1503 & _T_94; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1505 = _T_1504 & _T_96; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1506 = _T_1505 & _T_17; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1507 = _T_1506 & _T_27; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1508 = _T_1480 | _T_1507; // @[dec_tlu_ctl.scala 3226:161]
  wire  _T_1527 = _T_990 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1528 = _T_1508 | _T_1527; // @[dec_tlu_ctl.scala 3227:97]
  wire  _T_1544 = _T_1034 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1545 = _T_1528 | _T_1544; // @[dec_tlu_ctl.scala 3227:153]
  wire  _T_1564 = _T_990 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  wire  _T_1565 = _T_1545 | _T_1564; // @[dec_tlu_ctl.scala 3228:113]
  wire  _T_1581 = _T_1034 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 3142:198]
  assign io_csr_pkt_csr_misa = _T_11 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3144:57]
  assign io_csr_pkt_csr_mvendorid = _T_20 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3145:57]
  assign io_csr_pkt_csr_marchid = _T_29 & _T_27; // @[dec_tlu_ctl.scala 3146:57]
  assign io_csr_pkt_csr_mimpid = _T_37 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3147:57]
  assign io_csr_pkt_csr_mhartid = _T_19 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3148:57]
  assign io_csr_pkt_csr_mstatus = _T_11 & _T_27; // @[dec_tlu_ctl.scala 3149:57]
  assign io_csr_pkt_csr_mtvec = _T_69 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3150:57]
  assign io_csr_pkt_csr_mip = _T_75 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3151:65]
  assign io_csr_pkt_csr_mie = _T_69 & _T_27; // @[dec_tlu_ctl.scala 3152:65]
  assign io_csr_pkt_csr_mcyclel = _T_104 & _T_17; // @[dec_tlu_ctl.scala 3153:57]
  assign io_csr_pkt_csr_mcycleh = _T_123 & _T_17; // @[dec_tlu_ctl.scala 3154:57]
  assign io_csr_pkt_csr_minstretl = _T_142 & _T_27; // @[dec_tlu_ctl.scala 3155:57]
  assign io_csr_pkt_csr_minstreth = _T_160 & _T_27; // @[dec_tlu_ctl.scala 3156:57]
  assign io_csr_pkt_csr_mscratch = _T_173 & _T_27; // @[dec_tlu_ctl.scala 3157:57]
  assign io_csr_pkt_csr_mepc = _T_182 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3158:57]
  assign io_csr_pkt_csr_mcause = _T_191 & _T_27; // @[dec_tlu_ctl.scala 3159:57]
  assign io_csr_pkt_csr_mscause = _T_196 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3160:57]
  assign io_csr_pkt_csr_mtval = _T_191 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3161:57]
  assign io_csr_pkt_csr_mrac = _T_220 & _T_17; // @[dec_tlu_ctl.scala 3162:57]
  assign io_csr_pkt_csr_dmst = _T_232 & _T_17; // @[dec_tlu_ctl.scala 3163:57]
  assign io_csr_pkt_csr_mdseac = _T_241 & _T_96; // @[dec_tlu_ctl.scala 3164:57]
  assign io_csr_pkt_csr_meihap = _T_240 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 3165:57]
  assign io_csr_pkt_csr_meivt = _T_261 & _T_27; // @[dec_tlu_ctl.scala 3166:57]
  assign io_csr_pkt_csr_meipt = _T_269 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3167:57]
  assign io_csr_pkt_csr_meicurpl = _T_268 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 3168:57]
  assign io_csr_pkt_csr_meicidpl = _T_281 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3169:57]
  assign io_csr_pkt_csr_dcsr = _T_292 & _T_27; // @[dec_tlu_ctl.scala 3170:57]
  assign io_csr_pkt_csr_mcgc = _T_300 & _T_27; // @[dec_tlu_ctl.scala 3171:57]
  assign io_csr_pkt_csr_mfdc = _T_310 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3172:57]
  assign io_csr_pkt_csr_dpc = _T_292 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3173:65]
  assign io_csr_pkt_csr_mtsel = _T_332 & _T_27; // @[dec_tlu_ctl.scala 3174:57]
  assign io_csr_pkt_csr_mtdata1 = _T_231 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3175:57]
  assign io_csr_pkt_csr_mtdata2 = _T_331 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3176:57]
  assign io_csr_pkt_csr_mhpmc3 = _T_104 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3177:57]
  assign io_csr_pkt_csr_mhpmc4 = _T_382 & _T_27; // @[dec_tlu_ctl.scala 3178:57]
  assign io_csr_pkt_csr_mhpmc5 = _T_397 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3179:57]
  assign io_csr_pkt_csr_mhpmc6 = _T_415 & _T_27; // @[dec_tlu_ctl.scala 3180:57]
  assign io_csr_pkt_csr_mhpmc3h = _T_429 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3181:57]
  assign io_csr_pkt_csr_mhpmc4h = _T_447 & _T_27; // @[dec_tlu_ctl.scala 3182:57]
  assign io_csr_pkt_csr_mhpmc5h = _T_461 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3183:57]
  assign io_csr_pkt_csr_mhpmc6h = _T_478 & _T_27; // @[dec_tlu_ctl.scala 3184:57]
  assign io_csr_pkt_csr_mhpme3 = _T_493 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3185:57]
  assign io_csr_pkt_csr_mhpme4 = _T_508 & _T_27; // @[dec_tlu_ctl.scala 3186:57]
  assign io_csr_pkt_csr_mhpme5 = _T_508 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3187:57]
  assign io_csr_pkt_csr_mhpme6 = _T_536 & _T_27; // @[dec_tlu_ctl.scala 3188:57]
  assign io_csr_pkt_csr_mcountinhibit = _T_493 & _T_27; // @[dec_tlu_ctl.scala 3189:49]
  assign io_csr_pkt_csr_mitctl0 = _T_564 & _T_27; // @[dec_tlu_ctl.scala 3190:57]
  assign io_csr_pkt_csr_mitctl1 = _T_574 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3191:57]
  assign io_csr_pkt_csr_mitb0 = _T_585 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3192:57]
  assign io_csr_pkt_csr_mitb1 = _T_595 & _T_27; // @[dec_tlu_ctl.scala 3193:57]
  assign io_csr_pkt_csr_mitcnt0 = _T_585 & _T_27; // @[dec_tlu_ctl.scala 3194:57]
  assign io_csr_pkt_csr_mitcnt1 = _T_615 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3195:57]
  assign io_csr_pkt_csr_mpmc = _T_626 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 3196:57]
  assign io_csr_pkt_csr_meicpct = _T_281 & _T_27; // @[dec_tlu_ctl.scala 3198:57]
  assign io_csr_pkt_csr_micect = _T_646 & _T_27; // @[dec_tlu_ctl.scala 3200:57]
  assign io_csr_pkt_csr_miccmect = _T_645 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3201:57]
  assign io_csr_pkt_csr_mdccmect = _T_662 & _T_27; // @[dec_tlu_ctl.scala 3202:57]
  assign io_csr_pkt_csr_mfdht = _T_672 & _T_27; // @[dec_tlu_ctl.scala 3203:57]
  assign io_csr_pkt_csr_mfdhs = _T_680 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3204:57]
  assign io_csr_pkt_csr_dicawics = _T_696 & _T_27; // @[dec_tlu_ctl.scala 3205:57]
  assign io_csr_pkt_csr_dicad0h = _T_704 & _T_17; // @[dec_tlu_ctl.scala 3206:57]
  assign io_csr_pkt_csr_dicad0 = _T_715 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3207:57]
  assign io_csr_pkt_csr_dicad1 = _T_726 & _T_27; // @[dec_tlu_ctl.scala 3208:57]
  assign io_csr_pkt_csr_dicago = _T_726 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 3209:57]
  assign io_csr_pkt_presync = _T_807 | _T_822; // @[dec_tlu_ctl.scala 3210:34]
  assign io_csr_pkt_postsync = _T_903 | _T_915; // @[dec_tlu_ctl.scala 3212:30]
  assign io_csr_pkt_legal = _T_1565 | _T_1581; // @[dec_tlu_ctl.scala 3215:26]
endmodule
module dec_tlu_ctl(
  input         clock,
  input         reset,
  output [29:0] io_tlu_exu_dec_tlu_meihap,
  output        io_tlu_exu_dec_tlu_flush_lower_r,
  output [30:0] io_tlu_exu_dec_tlu_flush_path_r,
  input  [1:0]  io_tlu_exu_exu_i0_br_hist_r,
  input         io_tlu_exu_exu_i0_br_error_r,
  input         io_tlu_exu_exu_i0_br_start_error_r,
  input  [7:0]  io_tlu_exu_exu_i0_br_index_r,
  input         io_tlu_exu_exu_i0_br_valid_r,
  input         io_tlu_exu_exu_i0_br_mp_r,
  input         io_tlu_exu_exu_i0_br_middle_r,
  input         io_tlu_exu_exu_pmu_i0_br_misp,
  input         io_tlu_exu_exu_pmu_i0_br_ataken,
  input         io_tlu_exu_exu_pmu_i0_pc4,
  input  [30:0] io_tlu_exu_exu_npc_r,
  input         io_tlu_dma_dma_pmu_dccm_read,
  input         io_tlu_dma_dma_pmu_dccm_write,
  input         io_tlu_dma_dma_pmu_any_read,
  input         io_tlu_dma_dma_pmu_any_write,
  output [2:0]  io_tlu_dma_dec_tlu_dma_qos_prty,
  input         io_tlu_dma_dma_dccm_stall_any,
  input         io_tlu_dma_dma_iccm_stall_any,
  input         io_free_clk,
  input         io_free_l2clk,
  input         io_scan_mode,
  input  [30:0] io_rst_vec,
  input         io_nmi_int,
  input  [30:0] io_nmi_vec,
  input         io_i_cpu_halt_req,
  input         io_i_cpu_run_req,
  input         io_lsu_fastint_stall_any,
  input         io_lsu_idle_any,
  input         io_dec_pmu_instr_decoded,
  input         io_dec_pmu_decode_stall,
  input         io_dec_pmu_presync_stall,
  input         io_dec_pmu_postsync_stall,
  input         io_lsu_store_stall_any,
  input  [30:0] io_lsu_fir_addr,
  input  [1:0]  io_lsu_fir_error,
  input         io_iccm_dma_sb_error,
  input         io_lsu_error_pkt_r_valid,
  input         io_lsu_error_pkt_r_bits_single_ecc_error,
  input         io_lsu_error_pkt_r_bits_inst_type,
  input         io_lsu_error_pkt_r_bits_exc_type,
  input  [3:0]  io_lsu_error_pkt_r_bits_mscause,
  input  [31:0] io_lsu_error_pkt_r_bits_addr,
  input         io_lsu_single_ecc_error_incr,
  input         io_dec_pause_state,
  input         io_dec_csr_wen_unq_d,
  input         io_dec_csr_any_unq_d,
  input  [11:0] io_dec_csr_rdaddr_d,
  input         io_dec_csr_wen_r,
  input  [11:0] io_dec_csr_wraddr_r,
  input  [31:0] io_dec_csr_wrdata_r,
  input         io_dec_csr_stall_int_ff,
  input         io_dec_tlu_i0_valid_r,
  input  [30:0] io_dec_tlu_i0_pc_r,
  input         io_dec_tlu_packet_r_legal,
  input         io_dec_tlu_packet_r_icaf,
  input         io_dec_tlu_packet_r_icaf_second,
  input  [1:0]  io_dec_tlu_packet_r_icaf_type,
  input         io_dec_tlu_packet_r_fence_i,
  input  [3:0]  io_dec_tlu_packet_r_i0trigger,
  input  [3:0]  io_dec_tlu_packet_r_pmu_i0_itype,
  input         io_dec_tlu_packet_r_pmu_i0_br_unpred,
  input         io_dec_tlu_packet_r_pmu_divide,
  input         io_dec_tlu_packet_r_pmu_lsu_misaligned,
  input  [31:0] io_dec_illegal_inst,
  input         io_dec_i0_decode_d,
  input         io_exu_i0_br_way_r,
  output        io_dec_tlu_core_empty,
  output        io_dec_dbg_cmd_done,
  output        io_dec_dbg_cmd_fail,
  output        io_dec_tlu_dbg_halted,
  output        io_dec_tlu_debug_mode,
  output        io_dec_tlu_resume_ack,
  output        io_dec_tlu_debug_stall,
  output        io_dec_tlu_mpc_halted_only,
  output        io_dec_tlu_flush_extint,
  input         io_dbg_halt_req,
  input         io_dbg_resume_req,
  input         io_dec_div_active,
  output        io_trigger_pkt_any_0_select,
  output        io_trigger_pkt_any_0_match_pkt,
  output        io_trigger_pkt_any_0_store,
  output        io_trigger_pkt_any_0_load,
  output        io_trigger_pkt_any_0_execute,
  output        io_trigger_pkt_any_0_m,
  output [31:0] io_trigger_pkt_any_0_tdata2,
  output        io_trigger_pkt_any_1_select,
  output        io_trigger_pkt_any_1_match_pkt,
  output        io_trigger_pkt_any_1_store,
  output        io_trigger_pkt_any_1_load,
  output        io_trigger_pkt_any_1_execute,
  output        io_trigger_pkt_any_1_m,
  output [31:0] io_trigger_pkt_any_1_tdata2,
  output        io_trigger_pkt_any_2_select,
  output        io_trigger_pkt_any_2_match_pkt,
  output        io_trigger_pkt_any_2_store,
  output        io_trigger_pkt_any_2_load,
  output        io_trigger_pkt_any_2_execute,
  output        io_trigger_pkt_any_2_m,
  output [31:0] io_trigger_pkt_any_2_tdata2,
  output        io_trigger_pkt_any_3_select,
  output        io_trigger_pkt_any_3_match_pkt,
  output        io_trigger_pkt_any_3_store,
  output        io_trigger_pkt_any_3_load,
  output        io_trigger_pkt_any_3_execute,
  output        io_trigger_pkt_any_3_m,
  output [31:0] io_trigger_pkt_any_3_tdata2,
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
  output [31:0] io_dec_csr_rddata_d,
  output        io_dec_csr_legal_d,
  output        io_dec_tlu_i0_kill_writeb_wb,
  output        io_dec_tlu_i0_kill_writeb_r,
  output        io_dec_tlu_wr_pause_r,
  output        io_dec_tlu_flush_pause_r,
  output        io_dec_tlu_presync_d,
  output        io_dec_tlu_postsync_d,
  output        io_dec_tlu_perfcnt0,
  output        io_dec_tlu_perfcnt1,
  output        io_dec_tlu_perfcnt2,
  output        io_dec_tlu_perfcnt3,
  output        io_dec_tlu_i0_exc_valid_wb1,
  output        io_dec_tlu_i0_valid_wb1,
  output        io_dec_tlu_int_valid_wb1,
  output [4:0]  io_dec_tlu_exc_cause_wb1,
  output [31:0] io_dec_tlu_mtval_wb1,
  output        io_dec_tlu_pipelining_disable,
  output        io_dec_tlu_trace_disable,
  output        io_dec_tlu_misc_clk_override,
  output        io_dec_tlu_dec_clk_override,
  output        io_dec_tlu_ifu_clk_override,
  output        io_dec_tlu_lsu_clk_override,
  output        io_dec_tlu_bus_clk_override,
  output        io_dec_tlu_pic_clk_override,
  output        io_dec_tlu_picio_clk_override,
  output        io_dec_tlu_dccm_clk_override,
  output        io_dec_tlu_icm_clk_override,
  output        io_dec_tlu_flush_lower_wb,
  input         io_ifu_pmu_instr_aligned,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_valid,
  output [1:0]  io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_way,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle,
  output        io_tlu_bp_dec_tlu_flush_leak_one_wb,
  output        io_tlu_bp_dec_tlu_bpred_disable,
  output        io_tlu_ifc_dec_tlu_flush_noredir_wb,
  output [31:0] io_tlu_ifc_dec_tlu_mrac_ff,
  input         io_tlu_ifc_ifu_pmu_fetch_stall,
  output        io_tlu_mem_dec_tlu_flush_err_wb,
  output        io_tlu_mem_dec_tlu_i0_commit_cmt,
  output        io_tlu_mem_dec_tlu_force_halt,
  output        io_tlu_mem_dec_tlu_fence_i_wb,
  output [70:0] io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata,
  output [16:0] io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics,
  output        io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid,
  output        io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid,
  output        io_tlu_mem_dec_tlu_core_ecc_disable,
  input         io_tlu_mem_ifu_pmu_ic_miss,
  input         io_tlu_mem_ifu_pmu_ic_hit,
  input         io_tlu_mem_ifu_pmu_bus_error,
  input         io_tlu_mem_ifu_pmu_bus_busy,
  input         io_tlu_mem_ifu_pmu_bus_trxn,
  input         io_tlu_mem_ifu_ic_error_start,
  input         io_tlu_mem_ifu_iccm_rd_ecc_single_err,
  input  [70:0] io_tlu_mem_ifu_ic_debug_rd_data,
  input         io_tlu_mem_ifu_ic_debug_rd_data_valid,
  input         io_tlu_mem_ifu_miss_state_idle,
  input         io_tlu_busbuff_lsu_pmu_bus_trxn,
  input         io_tlu_busbuff_lsu_pmu_bus_misaligned,
  input         io_tlu_busbuff_lsu_pmu_bus_error,
  input         io_tlu_busbuff_lsu_pmu_bus_busy,
  output        io_tlu_busbuff_dec_tlu_external_ldfwd_disable,
  output        io_tlu_busbuff_dec_tlu_wb_coalescing_disable,
  output        io_tlu_busbuff_dec_tlu_sideeffect_posted_disable,
  input         io_tlu_busbuff_lsu_imprecise_error_load_any,
  input         io_tlu_busbuff_lsu_imprecise_error_store_any,
  input  [31:0] io_tlu_busbuff_lsu_imprecise_error_addr_any,
  input         io_lsu_tlu_lsu_pmu_load_external_m,
  input         io_lsu_tlu_lsu_pmu_store_external_m,
  input  [7:0]  io_dec_pic_pic_claimid,
  input  [3:0]  io_dec_pic_pic_pl,
  input         io_dec_pic_mhwakeup,
  output [3:0]  io_dec_pic_dec_tlu_meicurpl,
  output [3:0]  io_dec_pic_dec_tlu_meipt,
  input         io_dec_pic_mexintpend
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
`endif // RANDOMIZE_REG_INIT
  wire  int_exc_clock; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_reset; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_mhwakeup_ready; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ext_int_ready; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ce_int_ready; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_soft_int_ready; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_timer_int_ready; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_int_timer0_int_hold; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_int_timer1_int_hold; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_internal_dbg_halt_timers; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_ext_int_start; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_ext_int_start_d2; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ext_int_freeze; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_ext_int; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_fast_int_meicpct; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ignore_ext_int_due_to_lsu_stall; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_ce_int; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_soft_int; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_timer_int; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_int_timer0_int; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_int_timer1_int; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_reset; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_nmi; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_synchronous_flush_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_tlu_flush_lower_wb; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_dec_tlu_flush_path_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_i0_exception_valid_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire [4:0] int_exc_io_exc_cause_wb; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_i0_valid_wb; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_trigger_hit_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_nmi_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_interrupt_valid_r; // @[dec_tlu_ctl.scala 282:29]
  wire [4:0] int_exc_io_exc_cause_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_tlu_flush_path_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_csr_stall_int_ff; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_mstatus_mie_ns; // @[dec_tlu_ctl.scala 282:29]
  wire [5:0] int_exc_io_mip; // @[dec_tlu_ctl.scala 282:29]
  wire [5:0] int_exc_io_mie_ns; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_mret_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_internal_dbg_halt_mode_f; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dcsr_single_step_running; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_internal_pmu_fw_halt_mode; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 282:29]
  wire [1:0] int_exc_io_lsu_fir_error; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_csr_pkt_csr_meicpct; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_lsu_fastint_stall_any; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_reset_delayed; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_nmi_int_detected; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 282:29]
  wire [15:0] int_exc_io_dcsr; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_mtvec; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_pause_expired_r; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_nmi_vec; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_lsu_i0_rfnpc_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_fence_i_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_iccm_repair_state_rfnpc; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_i_cpu_run_req_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_rfpc_i0_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_trigger_hit_dmode_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_take_halt; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_rst_vec; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_lsu_fir_addr; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_dec_tlu_i0_pc_r; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_npc_r; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_mepc; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_debug_resume_req_f; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_dpc; // @[dec_tlu_ctl.scala 282:29]
  wire [30:0] int_exc_io_npc_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ebreak_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_ecall_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_illegal_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_inst_acc_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_lsu_i0_exc_r; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_lsu_error_pkt_r_bits_inst_type; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_lsu_error_pkt_r_bits_exc_type; // @[dec_tlu_ctl.scala 282:29]
  wire  int_exc_io_dec_tlu_wr_pause_r_d1; // @[dec_tlu_ctl.scala 282:29]
  wire  csr_clock; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_reset; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_free_l2clk; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_free_clk; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 283:23]
  wire [11:0] csr_io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 283:23]
  wire [11:0] csr_io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_i0_decode_d; // @[dec_tlu_ctl.scala 283:23]
  wire [70:0] csr_io_dec_tlu_ic_diag_pkt_icache_wrdata; // @[dec_tlu_ctl.scala 283:23]
  wire [16:0] csr_io_dec_tlu_ic_diag_pkt_icache_dicawics; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_0_select; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_0_match_pkt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_0_store; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_0_load; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_0_execute; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_0_m; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_trigger_pkt_any_0_tdata2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_1_select; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_1_match_pkt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_1_store; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_1_load; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_1_execute; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_1_m; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_trigger_pkt_any_1_tdata2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_2_select; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_2_match_pkt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_2_store; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_2_load; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_2_execute; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_2_m; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_trigger_pkt_any_2_tdata2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_3_select; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_3_match_pkt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_3_store; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_3_load; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_3_execute; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_pkt_any_3_m; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_trigger_pkt_any_3_tdata2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dma_iccm_stall_any; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dma_dccm_stall_any; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_store_stall_any; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_pmu_presync_stall; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_pmu_postsync_stall; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_pmu_decode_stall; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_fetch_stall; // @[dec_tlu_ctl.scala 283:23]
  wire [1:0] csr_io_dec_tlu_packet_r_icaf_type; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_dec_tlu_packet_r_pmu_i0_itype; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_packet_r_pmu_divide; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_exu_pmu_i0_br_misp; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_pmu_instr_decoded; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_instr_aligned; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_ic_miss; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_ic_hit; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_int_valid_wb1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_i0_exc_valid_wb1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_i0_valid_wb1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_csr_wen_r; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_dec_tlu_mtval_wb1; // @[dec_tlu_ctl.scala 283:23]
  wire [4:0] csr_io_dec_tlu_exc_cause_wb1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_perfcnt0; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_perfcnt1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_perfcnt2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_perfcnt3; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dma_pmu_dccm_write; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dma_pmu_dccm_read; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dma_pmu_any_write; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dma_pmu_any_read; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_pmu_bus_busy; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_dec_tlu_i0_pc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_misc_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_picio_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_dec_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_ifu_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_lsu_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_bus_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_pic_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_dccm_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_icm_clk_override; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_dec_csr_rddata_d; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_pipelining_disable; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_wr_pause_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_bus_busy; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_pmu_bus_error; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_pmu_bus_error; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_pmu_bus_misaligned; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 283:23]
  wire [70:0] csr_io_ifu_ic_debug_rd_data; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_dec_tlu_meipt; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_pic_pl; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_dec_tlu_meicurpl; // @[dec_tlu_ctl.scala 283:23]
  wire [29:0] csr_io_dec_tlu_meihap; // @[dec_tlu_ctl.scala 283:23]
  wire [7:0] csr_io_pic_claimid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_lsu_imprecise_error_addr_any; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_dec_tlu_mrac_ff; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_wb_coalescing_disable; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_bpred_disable; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_sideeffect_posted_disable; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_core_ecc_disable; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_external_ldfwd_disable; // @[dec_tlu_ctl.scala 283:23]
  wire [2:0] csr_io_dec_tlu_dma_qos_prty; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_trace_disable; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_dec_illegal_inst; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_lsu_error_pkt_r_bits_mscause; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mexintpend; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_exu_npc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_rst_vec; // @[dec_tlu_ctl.scala 283:23]
  wire [27:0] csr_io_core_id; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_dec_timer_rddata_d; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_timer_read_d; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_rfpc_i0_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_fw_halt_req; // @[dec_tlu_ctl.scala 283:23]
  wire [1:0] csr_io_mstatus; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mret_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mstatus_mie_ns; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 283:23]
  wire [15:0] csr_io_dcsr; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_mtvec; // @[dec_tlu_ctl.scala 283:23]
  wire [5:0] csr_io_mip; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_timer_t0_pulse; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_timer_t1_pulse; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_timer_int_sync; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_soft_int_sync; // @[dec_tlu_ctl.scala 283:23]
  wire [5:0] csr_io_mie_ns; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_wr_clk; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 283:23]
  wire [1:0] csr_io_lsu_fir_error; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_npc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_tlu_flush_path_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_npc_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_reset_delayed; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_mepc; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_interrupt_valid_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_single_ecc_error_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_e4e5_int_clk; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_i0_exc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_inst_acc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_inst_acc_second_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_nmi; // @[dec_tlu_ctl.scala 283:23]
  wire [31:0] csr_io_lsu_error_pkt_addr_r; // @[dec_tlu_ctl.scala 283:23]
  wire [4:0] csr_io_exc_cause_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_i0_valid_wb; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_i0_exception_valid_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire [4:0] csr_io_exc_cause_wb; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_nmi_lsu_store_type; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_nmi_lsu_load_type; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ebreak_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ecall_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_illegal_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mdseac_locked_ns; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_mdseac_locked_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_nmi_int_detected_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ext_int_freeze; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_ext_int_start_d2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ic_perr_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_iccm_sbecc_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_idle_any_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dbg_tlu_halted; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_debug_halt_req_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_force_halt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_ext_int_start; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_trigger_hit_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_debug_halt_req; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_allow_dbg_halt_csr_write; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_internal_dbg_halt_mode_f; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_enter_debug_halt_req; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_request_debug_mode_done; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_request_debug_mode_r; // @[dec_tlu_ctl.scala 283:23]
  wire [30:0] csr_io_dpc; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_update_hit_bit_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_timer_int; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_int_timer0_int; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_int_timer1_int; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_take_ext_int; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_br0_error_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_dec_tlu_br0_start_error_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_misa; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mstatus; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mtvec; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mip; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mie; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mcyclel; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mcycleh; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_minstretl; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_minstreth; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mscratch; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mepc; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mcause; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mscause; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mtval; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mrac; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_meivt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_meipt; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_meicurpl; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_meicidpl; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mcgc; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mfdc; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mtsel; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mtdata1; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mtdata2; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc3; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc4; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc5; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc6; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc3h; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc4h; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc5h; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpmc6h; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpme3; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpme4; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpme5; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mhpme6; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mcountinhibit; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mpmc; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_micect; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_miccmect; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mdccmect; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mfdht; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_mfdhs; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 283:23]
  wire  csr_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 283:23]
  wire [9:0] csr_io_mtdata1_t_0; // @[dec_tlu_ctl.scala 283:23]
  wire [9:0] csr_io_mtdata1_t_1; // @[dec_tlu_ctl.scala 283:23]
  wire [9:0] csr_io_mtdata1_t_2; // @[dec_tlu_ctl.scala 283:23]
  wire [9:0] csr_io_mtdata1_t_3; // @[dec_tlu_ctl.scala 283:23]
  wire [3:0] csr_io_trigger_enabled; // @[dec_tlu_ctl.scala 283:23]
  wire  int_timers_clock; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_reset; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_free_l2clk; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_wr_clk; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 284:30]
  wire [11:0] int_timers_io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 284:30]
  wire [31:0] int_timers_io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_mitctl0; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_mitctl1; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_mitb0; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_mitb1; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_mitcnt0; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_csr_mitcnt1; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_dec_pause_state; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_internal_dbg_halt_timers; // @[dec_tlu_ctl.scala 284:30]
  wire [31:0] int_timers_io_dec_timer_rddata_d; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_dec_timer_read_d; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_dec_timer_t0_pulse; // @[dec_tlu_ctl.scala 284:30]
  wire  int_timers_io_dec_timer_t1_pulse; // @[dec_tlu_ctl.scala 284:30]
  wire [11:0] csr_read_io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_misa; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mstatus; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mtvec; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mip; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mie; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mcyclel; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mcycleh; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_minstretl; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_minstreth; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mscratch; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mepc; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mcause; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mscause; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mtval; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mrac; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dmst; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_meivt; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_meipt; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_meicurpl; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_meicidpl; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mcgc; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mfdc; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mtsel; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mtdata1; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mtdata2; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc3; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc4; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc5; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc6; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc3h; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc4h; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc5h; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc6h; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpme3; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpme4; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpme5; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mhpme6; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mcountinhibit; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mitctl0; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mitctl1; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mitb0; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mitb1; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mitcnt0; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mitcnt1; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mpmc; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_meicpct; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_micect; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_miccmect; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mdccmect; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mfdht; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_mfdhs; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_csr_dicago; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_presync; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_postsync; // @[dec_tlu_ctl.scala 1004:22]
  wire  csr_read_io_csr_pkt_legal; // @[dec_tlu_ctl.scala 1004:22]
  reg  dbg_halt_state_f; // @[Reg.scala 27:20]
  wire  _T = ~dbg_halt_state_f; // @[dec_tlu_ctl.scala 281:39]
  reg  mpc_halt_state_f; // @[Reg.scala 27:20]
  wire  _T_1 = _T & mpc_halt_state_f; // @[dec_tlu_ctl.scala 281:57]
  wire [2:0] _T_3 = {io_i_cpu_run_req,io_mpc_debug_halt_req,io_mpc_debug_run_req}; // @[Cat.scala 29:58]
  wire [3:0] _T_6 = {io_nmi_int,io_timer_int,io_soft_int,io_i_cpu_halt_req}; // @[Cat.scala 29:58]
  reg [6:0] _T_8; // @[lib.scala 39:81]
  reg [6:0] syncro_ff; // @[lib.scala 39:58]
  wire  nmi_int_sync = syncro_ff[6]; // @[dec_tlu_ctl.scala 311:67]
  wire  i_cpu_halt_req_sync = syncro_ff[3]; // @[dec_tlu_ctl.scala 314:59]
  wire  i_cpu_run_req_sync = syncro_ff[2]; // @[dec_tlu_ctl.scala 315:59]
  wire  mpc_debug_halt_req_sync_raw = syncro_ff[1]; // @[dec_tlu_ctl.scala 316:51]
  wire  mpc_debug_run_req_sync = syncro_ff[0]; // @[dec_tlu_ctl.scala 317:51]
  wire  dec_csr_wen_r_mod = csr_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 997:31]
  reg  debug_mode_status; // @[dec_tlu_ctl.scala 338:85]
  reg  i_cpu_run_req_d1_raw; // @[Reg.scala 27:20]
  reg  nmi_int_delayed; // @[Reg.scala 27:20]
  wire  _T_52 = ~nmi_int_delayed; // @[dec_tlu_ctl.scala 359:45]
  wire  _T_53 = nmi_int_sync & _T_52; // @[dec_tlu_ctl.scala 359:43]
  wire  mdseac_locked_f = csr_io_mdseac_locked_f; // @[dec_tlu_ctl.scala 952:21]
  wire  _T_48 = ~mdseac_locked_f; // @[dec_tlu_ctl.scala 356:32]
  wire  _T_49 = io_tlu_busbuff_lsu_imprecise_error_load_any | io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 356:96]
  wire  _T_50 = _T_48 & _T_49; // @[dec_tlu_ctl.scala 356:49]
  reg  nmi_int_detected_f; // @[Reg.scala 27:20]
  wire  _T_75 = ~nmi_int_detected_f; // @[dec_tlu_ctl.scala 364:25]
  wire  _T_76 = _T_75 & csr_io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 364:45]
  wire  _T_77 = |io_lsu_fir_error; // @[dec_tlu_ctl.scala 364:95]
  wire  nmi_fir_type = _T_76 & _T_77; // @[dec_tlu_ctl.scala 364:76]
  wire  _T_51 = ~nmi_fir_type; // @[dec_tlu_ctl.scala 356:146]
  wire  nmi_lsu_detected = _T_50 & _T_51; // @[dec_tlu_ctl.scala 356:144]
  wire  _T_54 = _T_53 | nmi_lsu_detected; // @[dec_tlu_ctl.scala 359:63]
  wire  take_nmi_r_d1 = int_exc_io_take_nmi_r_d1; // @[dec_tlu_ctl.scala 801:43]
  wire  _T_55 = ~take_nmi_r_d1; // @[dec_tlu_ctl.scala 359:106]
  wire  _T_56 = nmi_int_detected_f & _T_55; // @[dec_tlu_ctl.scala 359:104]
  wire  _T_57 = _T_54 | _T_56; // @[dec_tlu_ctl.scala 359:82]
  wire  nmi_int_detected = _T_57 | nmi_fir_type; // @[dec_tlu_ctl.scala 359:122]
  wire  timer_int_ready = int_exc_io_timer_int_ready; // @[dec_tlu_ctl.scala 771:43]
  wire  _T_552 = nmi_int_detected | timer_int_ready; // @[dec_tlu_ctl.scala 621:66]
  wire  soft_int_ready = int_exc_io_soft_int_ready; // @[dec_tlu_ctl.scala 770:43]
  wire  _T_553 = _T_552 | soft_int_ready; // @[dec_tlu_ctl.scala 621:84]
  reg  int_timer0_int_hold_f; // @[Reg.scala 27:20]
  wire  _T_554 = _T_553 | int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 621:101]
  reg  int_timer1_int_hold_f; // @[Reg.scala 27:20]
  wire  _T_555 = _T_554 | int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 621:125]
  wire  mhwakeup_ready = int_exc_io_mhwakeup_ready; // @[dec_tlu_ctl.scala 767:43]
  wire  _T_556 = io_dec_pic_mhwakeup & mhwakeup_ready; // @[dec_tlu_ctl.scala 621:172]
  wire  _T_557 = _T_555 | _T_556; // @[dec_tlu_ctl.scala 621:149]
  wire  _T_558 = _T_557 & io_o_cpu_halt_status; // @[dec_tlu_ctl.scala 621:191]
  reg  i_cpu_halt_req_d1; // @[Reg.scala 27:20]
  wire  _T_559 = ~i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 621:216]
  wire  _T_560 = _T_558 & _T_559; // @[dec_tlu_ctl.scala 621:214]
  wire  i_cpu_run_req_d1 = i_cpu_run_req_d1_raw | _T_560; // @[dec_tlu_ctl.scala 621:45]
  wire  interrupt_valid_r = int_exc_io_interrupt_valid_r; // @[dec_tlu_ctl.scala 803:43]
  wire  interrupt_valid_r_d1 = int_exc_io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 799:43]
  reg  reset_detect; // @[Reg.scala 27:20]
  reg  reset_detected; // @[Reg.scala 27:20]
  wire  reset_delayed = reset_detect ^ reset_detected; // @[dec_tlu_ctl.scala 368:64]
  wire  _T_321 = ~io_dec_pause_state; // @[dec_tlu_ctl.scala 503:28]
  reg  dec_pause_state_f; // @[Reg.scala 27:20]
  wire  _T_322 = _T_321 & dec_pause_state_f; // @[dec_tlu_ctl.scala 503:48]
  wire  ext_int_ready = int_exc_io_ext_int_ready; // @[dec_tlu_ctl.scala 768:43]
  wire  ce_int_ready = int_exc_io_ce_int_ready; // @[dec_tlu_ctl.scala 769:43]
  wire  _T_323 = ext_int_ready | ce_int_ready; // @[dec_tlu_ctl.scala 503:86]
  wire  _T_324 = _T_323 | timer_int_ready; // @[dec_tlu_ctl.scala 503:101]
  wire  _T_325 = _T_324 | soft_int_ready; // @[dec_tlu_ctl.scala 503:119]
  wire  _T_326 = _T_325 | int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 503:136]
  wire  _T_327 = _T_326 | int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 503:160]
  wire  _T_328 = _T_327 | nmi_int_detected; // @[dec_tlu_ctl.scala 503:184]
  wire  _T_329 = _T_328 | csr_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 503:203]
  wire  _T_330 = ~_T_329; // @[dec_tlu_ctl.scala 503:70]
  wire  _T_331 = _T_322 & _T_330; // @[dec_tlu_ctl.scala 503:68]
  wire  _T_332 = ~interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 503:233]
  wire  _T_333 = _T_331 & _T_332; // @[dec_tlu_ctl.scala 503:231]
  reg  debug_halt_req_f; // @[Reg.scala 27:20]
  wire  _T_334 = ~debug_halt_req_f; // @[dec_tlu_ctl.scala 503:257]
  wire  _T_335 = _T_333 & _T_334; // @[dec_tlu_ctl.scala 503:255]
  reg  pmu_fw_halt_req_f; // @[Reg.scala 27:20]
  wire  _T_336 = ~pmu_fw_halt_req_f; // @[dec_tlu_ctl.scala 503:277]
  wire  _T_337 = _T_335 & _T_336; // @[dec_tlu_ctl.scala 503:275]
  reg  halt_taken_f; // @[Reg.scala 27:20]
  wire  _T_338 = ~halt_taken_f; // @[dec_tlu_ctl.scala 503:298]
  reg  ifu_ic_error_start_f; // @[Reg.scala 27:20]
  wire  _T_656 = ~csr_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 697:44]
  wire  _T_657 = ifu_ic_error_start_f & _T_656; // @[dec_tlu_ctl.scala 697:42]
  wire  _T_658 = ~debug_mode_status; // @[dec_tlu_ctl.scala 697:73]
  reg  debug_resume_req_f_raw; // @[Reg.scala 27:20]
  wire  _T_309 = ~io_dbg_halt_req; // @[dec_tlu_ctl.scala 488:56]
  wire  debug_resume_req_f = debug_resume_req_f_raw & _T_309; // @[dec_tlu_ctl.scala 488:54]
  wire [15:0] dcsr = csr_io_dcsr; // @[dec_tlu_ctl.scala 1000:31]
  wire  _T_231 = debug_resume_req_f & dcsr[2]; // @[dec_tlu_ctl.scala 457:60]
  reg  dcsr_single_step_running_f; // @[Reg.scala 27:20]
  reg  dcsr_single_step_done_f; // @[Reg.scala 27:20]
  wire  _T_232 = ~dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 457:111]
  wire  _T_233 = dcsr_single_step_running_f & _T_232; // @[dec_tlu_ctl.scala 457:109]
  wire  dcsr_single_step_running = _T_231 | _T_233; // @[dec_tlu_ctl.scala 457:79]
  wire  _T_659 = _T_658 | dcsr_single_step_running; // @[dec_tlu_ctl.scala 697:99]
  wire  _T_660 = _T_657 & _T_659; // @[dec_tlu_ctl.scala 697:70]
  reg  internal_pmu_fw_halt_mode_f; // @[Reg.scala 27:20]
  wire  _T_661 = ~internal_pmu_fw_halt_mode_f; // @[dec_tlu_ctl.scala 697:129]
  wire  ic_perr_r = _T_660 & _T_661; // @[dec_tlu_ctl.scala 697:127]
  reg  ifu_iccm_rd_ecc_single_err_f; // @[Reg.scala 27:20]
  wire  _T_664 = ifu_iccm_rd_ecc_single_err_f & _T_656; // @[dec_tlu_ctl.scala 698:50]
  wire  _T_667 = _T_664 & _T_659; // @[dec_tlu_ctl.scala 698:78]
  wire  iccm_sbecc_r = _T_667 & _T_661; // @[dec_tlu_ctl.scala 698:135]
  wire  _T_23 = io_tlu_mem_ifu_ic_error_start ^ ifu_ic_error_start_f; // @[lib.scala 463:21]
  wire  _T_24 = |_T_23; // @[lib.scala 463:29]
  wire  _T_26 = io_tlu_mem_ifu_iccm_rd_ecc_single_err ^ ifu_iccm_rd_ecc_single_err_f; // @[lib.scala 463:21]
  wire  _T_27 = |_T_26; // @[lib.scala 463:29]
  reg  iccm_repair_state_d1; // @[Reg.scala 27:20]
  wire  _T_599 = ~io_tlu_exu_dec_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 654:67]
  wire  _T_600 = iccm_repair_state_d1 & _T_599; // @[dec_tlu_ctl.scala 654:65]
  wire  iccm_repair_state_ns = iccm_sbecc_r | _T_600; // @[dec_tlu_ctl.scala 654:41]
  wire  _T_29 = iccm_repair_state_ns ^ iccm_repair_state_d1; // @[lib.scala 441:21]
  wire  _T_30 = |_T_29; // @[lib.scala 441:29]
  reg  lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 339:82]
  reg  lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 340:74]
  reg  tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 341:84]
  reg  _T_34; // @[dec_tlu_ctl.scala 342:75]
  reg  internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 343:74]
  reg  _T_35; // @[dec_tlu_ctl.scala 344:91]
  wire  _T_36 = nmi_int_sync ^ nmi_int_delayed; // @[lib.scala 463:21]
  wire  _T_37 = |_T_36; // @[lib.scala 463:29]
  wire  _T_39 = nmi_int_detected ^ nmi_int_detected_f; // @[lib.scala 441:21]
  wire  _T_40 = |_T_39; // @[lib.scala 441:29]
  wire  _T_59 = nmi_lsu_detected & io_tlu_busbuff_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 361:49]
  wire  _T_62 = ~_T_56; // @[dec_tlu_ctl.scala 361:98]
  wire  _T_63 = _T_59 & _T_62; // @[dec_tlu_ctl.scala 361:95]
  reg  nmi_lsu_load_type_f; // @[Reg.scala 27:20]
  wire  _T_65 = nmi_lsu_load_type_f & _T_55; // @[dec_tlu_ctl.scala 361:162]
  wire  nmi_lsu_load_type = _T_63 | _T_65; // @[dec_tlu_ctl.scala 361:138]
  wire  _T_42 = nmi_lsu_load_type ^ nmi_lsu_load_type_f; // @[lib.scala 441:21]
  wire  _T_43 = |_T_42; // @[lib.scala 441:29]
  wire  _T_67 = nmi_lsu_detected & io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 362:49]
  wire  _T_71 = _T_67 & _T_62; // @[dec_tlu_ctl.scala 362:96]
  reg  nmi_lsu_store_type_f; // @[Reg.scala 27:20]
  wire  _T_73 = nmi_lsu_store_type_f & _T_55; // @[dec_tlu_ctl.scala 362:162]
  wire  nmi_lsu_store_type = _T_71 | _T_73; // @[dec_tlu_ctl.scala 362:138]
  wire  _T_45 = nmi_lsu_store_type ^ nmi_lsu_store_type_f; // @[lib.scala 441:21]
  wire  _T_46 = |_T_45; // @[lib.scala 441:29]
  wire  _T_79 = 1'h1 ^ reset_detect; // @[lib.scala 441:21]
  wire  _T_80 = |_T_79; // @[lib.scala 441:29]
  wire  _T_83 = |reset_delayed; // @[lib.scala 441:29]
  wire  mpc_debug_halt_req_sync = mpc_debug_halt_req_sync_raw & _T_656; // @[dec_tlu_ctl.scala 376:67]
  reg  mpc_debug_halt_req_sync_f; // @[Reg.scala 27:20]
  wire  _T_87 = mpc_debug_halt_req_sync ^ mpc_debug_halt_req_sync_f; // @[lib.scala 441:21]
  wire  _T_88 = |_T_87; // @[lib.scala 441:29]
  reg  mpc_debug_run_req_sync_f; // @[Reg.scala 27:20]
  wire  _T_90 = mpc_debug_run_req_sync ^ mpc_debug_run_req_sync_f; // @[lib.scala 463:21]
  wire  _T_91 = |_T_90; // @[lib.scala 463:29]
  wire  _T_120 = ~mpc_debug_halt_req_sync_f; // @[dec_tlu_ctl.scala 390:71]
  wire  mpc_debug_halt_req_sync_pulse = mpc_debug_halt_req_sync & _T_120; // @[dec_tlu_ctl.scala 390:69]
  wire  _T_122 = mpc_halt_state_f | mpc_debug_halt_req_sync_pulse; // @[dec_tlu_ctl.scala 393:48]
  wire  _T_123 = ~io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 393:99]
  wire  _T_124 = reset_delayed & _T_123; // @[dec_tlu_ctl.scala 393:97]
  wire  _T_125 = _T_122 | _T_124; // @[dec_tlu_ctl.scala 393:80]
  wire  _T_126 = ~mpc_debug_run_req_sync; // @[dec_tlu_ctl.scala 393:125]
  wire  mpc_halt_state_ns = _T_125 & _T_126; // @[dec_tlu_ctl.scala 393:123]
  wire  _T_94 = mpc_halt_state_ns ^ mpc_halt_state_f; // @[lib.scala 441:21]
  wire  _T_95 = |_T_94; // @[lib.scala 441:29]
  reg  mpc_run_state_f; // @[Reg.scala 27:20]
  wire  _T_121 = ~mpc_debug_run_req_sync_f; // @[dec_tlu_ctl.scala 391:70]
  wire  mpc_debug_run_req_sync_pulse = mpc_debug_run_req_sync & _T_121; // @[dec_tlu_ctl.scala 391:68]
  reg  mpc_debug_run_ack_f; // @[Reg.scala 27:20]
  wire  _T_128 = ~mpc_debug_run_ack_f; // @[dec_tlu_ctl.scala 394:80]
  wire  _T_129 = mpc_debug_run_req_sync_pulse & _T_128; // @[dec_tlu_ctl.scala 394:78]
  wire  _T_130 = mpc_run_state_f | _T_129; // @[dec_tlu_ctl.scala 394:46]
  wire  _T_131 = ~dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 394:133]
  wire  _T_132 = debug_mode_status & _T_131; // @[dec_tlu_ctl.scala 394:131]
  wire  mpc_run_state_ns = _T_130 & _T_132; // @[dec_tlu_ctl.scala 394:103]
  wire  _T_97 = mpc_run_state_ns ^ mpc_run_state_f; // @[lib.scala 441:21]
  wire  _T_98 = |_T_97; // @[lib.scala 441:29]
  reg  ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 705:64]
  reg  trigger_hit_dmode_r_d1; // @[Reg.scala 27:20]
  wire  debug_brkpt_valid = ebreak_to_debug_mode_r_d1 | trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 404:59]
  reg  debug_brkpt_status_f; // @[Reg.scala 27:20]
  wire  _T_146 = debug_brkpt_valid | debug_brkpt_status_f; // @[dec_tlu_ctl.scala 405:53]
  reg  dbg_halt_req_held; // @[Reg.scala 27:20]
  wire  _T_160 = io_dbg_halt_req | dbg_halt_req_held; // @[dec_tlu_ctl.scala 418:48]
  wire  dbg_halt_req_final = _T_160 & _T_656; // @[dec_tlu_ctl.scala 418:69]
  wire  _T_163 = dbg_halt_req_final | mpc_debug_halt_req_sync; // @[dec_tlu_ctl.scala 421:50]
  wire  _T_166 = _T_163 | _T_124; // @[dec_tlu_ctl.scala 421:76]
  wire  _T_168 = _T_166 & _T_658; // @[dec_tlu_ctl.scala 421:119]
  wire  debug_halt_req = _T_168 & _T_656; // @[dec_tlu_ctl.scala 421:147]
  wire  _T_207 = _T_658 & debug_halt_req; // @[dec_tlu_ctl.scala 441:63]
  wire  _T_208 = _T_207 | dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 441:81]
  wire  _T_209 = _T_208 | trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 441:107]
  wire  enter_debug_halt_req = _T_209 | ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 441:132]
  wire  force_halt = csr_io_force_halt; // @[dec_tlu_ctl.scala 994:31]
  reg  lsu_idle_any_f; // @[Reg.scala 27:20]
  wire  _T_196 = io_lsu_idle_any & lsu_idle_any_f; // @[dec_tlu_ctl.scala 435:53]
  wire  _T_197 = _T_196 & io_tlu_mem_ifu_miss_state_idle; // @[dec_tlu_ctl.scala 435:70]
  reg  ifu_miss_state_idle_f; // @[Reg.scala 27:20]
  wire  _T_198 = _T_197 & ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 435:103]
  wire  _T_199 = ~debug_halt_req; // @[dec_tlu_ctl.scala 435:129]
  wire  _T_200 = _T_198 & _T_199; // @[dec_tlu_ctl.scala 435:127]
  reg  debug_halt_req_d1; // @[Reg.scala 27:20]
  wire  _T_201 = ~debug_halt_req_d1; // @[dec_tlu_ctl.scala 435:147]
  wire  _T_202 = _T_200 & _T_201; // @[dec_tlu_ctl.scala 435:145]
  wire  _T_203 = ~io_dec_div_active; // @[dec_tlu_ctl.scala 435:168]
  wire  _T_204 = _T_202 & _T_203; // @[dec_tlu_ctl.scala 435:166]
  wire  core_empty = force_halt | _T_204; // @[dec_tlu_ctl.scala 435:34]
  wire  _T_217 = debug_halt_req_f & core_empty; // @[dec_tlu_ctl.scala 451:48]
  reg  dec_tlu_flush_noredir_r_d1; // @[Reg.scala 27:20]
  reg  dec_tlu_flush_pause_r_d1; // @[Reg.scala 27:20]
  wire  _T_186 = ~dec_tlu_flush_pause_r_d1; // @[dec_tlu_ctl.scala 431:56]
  wire  _T_187 = dec_tlu_flush_noredir_r_d1 & _T_186; // @[dec_tlu_ctl.scala 431:54]
  wire  _T_188 = ~csr_io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 431:84]
  wire  _T_189 = _T_187 & _T_188; // @[dec_tlu_ctl.scala 431:82]
  reg  dbg_tlu_halted_f; // @[Reg.scala 27:20]
  wire  _T_190 = ~dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 431:133]
  wire  _T_191 = halt_taken_f & _T_190; // @[dec_tlu_ctl.scala 431:131]
  reg  pmu_fw_tlu_halted_f; // @[Reg.scala 27:20]
  wire  _T_192 = ~pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 431:153]
  wire  _T_193 = _T_191 & _T_192; // @[dec_tlu_ctl.scala 431:151]
  wire  _T_195 = _T_193 & _T_332; // @[dec_tlu_ctl.scala 431:174]
  wire  halt_taken = _T_189 | _T_195; // @[dec_tlu_ctl.scala 431:115]
  wire  _T_218 = _T_217 & halt_taken; // @[dec_tlu_ctl.scala 451:61]
  wire  _T_219 = ~debug_resume_req_f; // @[dec_tlu_ctl.scala 451:97]
  wire  _T_220 = dbg_tlu_halted_f & _T_219; // @[dec_tlu_ctl.scala 451:95]
  wire  dbg_tlu_halted = _T_218 | _T_220; // @[dec_tlu_ctl.scala 451:75]
  wire  _T_221 = ~dbg_tlu_halted; // @[dec_tlu_ctl.scala 452:73]
  wire  _T_222 = debug_halt_req_f & _T_221; // @[dec_tlu_ctl.scala 452:71]
  wire  debug_halt_req_ns = enter_debug_halt_req | _T_222; // @[dec_tlu_ctl.scala 452:51]
  wire  _T_211 = ~dcsr[2]; // @[dec_tlu_ctl.scala 444:106]
  wire  _T_212 = debug_resume_req_f & _T_211; // @[dec_tlu_ctl.scala 444:104]
  wire  _T_213 = ~_T_212; // @[dec_tlu_ctl.scala 444:83]
  wire  _T_214 = debug_mode_status & _T_213; // @[dec_tlu_ctl.scala 444:81]
  wire  internal_dbg_halt_mode = debug_halt_req_ns | _T_214; // @[dec_tlu_ctl.scala 444:53]
  wire  _T_148 = internal_dbg_halt_mode & _T_131; // @[dec_tlu_ctl.scala 405:103]
  wire  debug_brkpt_status_ns = _T_146 & _T_148; // @[dec_tlu_ctl.scala 405:77]
  wire  _T_100 = debug_brkpt_status_ns ^ debug_brkpt_status_f; // @[lib.scala 441:21]
  wire  _T_101 = |_T_100; // @[lib.scala 441:29]
  wire  _T_150 = mpc_halt_state_f & debug_mode_status; // @[dec_tlu_ctl.scala 408:51]
  wire  _T_151 = _T_150 & mpc_debug_halt_req_sync; // @[dec_tlu_ctl.scala 408:78]
  wire  mpc_debug_halt_ack_ns = _T_151 & core_empty; // @[dec_tlu_ctl.scala 408:104]
  reg  mpc_debug_halt_ack_f; // @[Reg.scala 27:20]
  wire  _T_103 = mpc_debug_halt_ack_ns ^ mpc_debug_halt_ack_f; // @[lib.scala 441:21]
  wire  _T_104 = |_T_103; // @[lib.scala 441:29]
  wire  _T_134 = dbg_halt_req_final | dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 397:70]
  wire  _T_135 = _T_134 | trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 397:96]
  wire  _T_136 = _T_135 | ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 397:121]
  wire  _T_137 = dbg_halt_state_f | _T_136; // @[dec_tlu_ctl.scala 397:48]
  wire  _T_138 = ~io_dbg_resume_req; // @[dec_tlu_ctl.scala 397:153]
  wire  dbg_halt_state_ns = _T_137 & _T_138; // @[dec_tlu_ctl.scala 397:151]
  wire  _T_153 = ~dbg_halt_state_ns; // @[dec_tlu_ctl.scala 409:59]
  wire  _T_154 = mpc_debug_run_req_sync & _T_153; // @[dec_tlu_ctl.scala 409:57]
  wire  _T_155 = ~mpc_debug_halt_req_sync; // @[dec_tlu_ctl.scala 409:80]
  wire  _T_156 = _T_154 & _T_155; // @[dec_tlu_ctl.scala 409:78]
  wire  _T_157 = mpc_debug_run_ack_f & mpc_debug_run_req_sync; // @[dec_tlu_ctl.scala 409:129]
  wire  mpc_debug_run_ack_ns = _T_156 | _T_157; // @[dec_tlu_ctl.scala 409:106]
  wire  _T_106 = mpc_debug_run_ack_ns ^ mpc_debug_run_ack_f; // @[lib.scala 441:21]
  wire  _T_107 = |_T_106; // @[lib.scala 441:29]
  wire  _T_110 = dbg_halt_state_ns ^ dbg_halt_state_f; // @[lib.scala 441:21]
  wire  _T_111 = |_T_110; // @[lib.scala 441:29]
  reg  dbg_run_state_f; // @[Reg.scala 27:20]
  wire  _T_140 = dbg_run_state_f | io_dbg_resume_req; // @[dec_tlu_ctl.scala 398:46]
  wire  dbg_run_state_ns = _T_140 & _T_132; // @[dec_tlu_ctl.scala 398:67]
  wire  _T_113 = dbg_run_state_ns ^ dbg_run_state_f; // @[lib.scala 441:21]
  wire  _T_114 = |_T_113; // @[lib.scala 441:29]
  reg  _T_119; // @[Reg.scala 27:20]
  wire  _T_117 = _T_1 ^ _T_119; // @[lib.scala 441:21]
  wire  _T_118 = |_T_117; // @[lib.scala 441:29]
  wire  dbg_halt_req_held_ns = _T_160 & csr_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 417:74]
  wire  _T_172 = mpc_run_state_ns & _T_153; // @[dec_tlu_ctl.scala 423:73]
  wire  _T_173 = ~mpc_halt_state_ns; // @[dec_tlu_ctl.scala 423:117]
  wire  _T_174 = dbg_run_state_ns & _T_173; // @[dec_tlu_ctl.scala 423:115]
  wire  _T_175 = _T_172 | _T_174; // @[dec_tlu_ctl.scala 423:95]
  wire  debug_resume_req = _T_219 & _T_175; // @[dec_tlu_ctl.scala 423:52]
  wire  _T_176 = debug_halt_req_f | pmu_fw_halt_req_f; // @[dec_tlu_ctl.scala 428:43]
  wire  synchronous_flush_r = int_exc_io_synchronous_flush_r; // @[dec_tlu_ctl.scala 794:43]
  wire  _T_177 = ~synchronous_flush_r; // @[dec_tlu_ctl.scala 428:66]
  wire  _T_178 = _T_176 & _T_177; // @[dec_tlu_ctl.scala 428:64]
  wire  _T_645 = io_dec_tlu_packet_r_pmu_i0_itype == 4'hc; // @[dec_tlu_ctl.scala 694:51]
  wire  _T_646 = _T_645 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 694:64]
  wire  _T_407 = io_dec_tlu_flush_lower_wb | io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 541:58]
  wire [3:0] _T_409 = _T_407 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_410 = ~_T_409; // @[dec_tlu_ctl.scala 541:23]
  wire [3:0] _T_402 = io_dec_tlu_i0_valid_r ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_404 = _T_402 & io_dec_tlu_packet_r_i0trigger; // @[dec_tlu_ctl.scala 539:53]
  wire [9:0] mtdata1_t_3 = csr_io_mtdata1_t_3; // @[dec_tlu_ctl.scala 162:67 dec_tlu_ctl.scala 1003:33]
  wire [9:0] mtdata1_t_2 = csr_io_mtdata1_t_2; // @[dec_tlu_ctl.scala 162:67 dec_tlu_ctl.scala 1003:33]
  wire [9:0] mtdata1_t_1 = csr_io_mtdata1_t_1; // @[dec_tlu_ctl.scala 162:67 dec_tlu_ctl.scala 1003:33]
  wire [9:0] mtdata1_t_0 = csr_io_mtdata1_t_0; // @[dec_tlu_ctl.scala 162:67 dec_tlu_ctl.scala 1003:33]
  wire [3:0] trigger_execute = {mtdata1_t_3[2],mtdata1_t_2[2],mtdata1_t_1[2],mtdata1_t_0[2]}; // @[Cat.scala 29:58]
  wire [3:0] trigger_data = {mtdata1_t_3[7],mtdata1_t_2[7],mtdata1_t_1[7],mtdata1_t_0[7]}; // @[Cat.scala 29:58]
  wire [3:0] _T_389 = trigger_execute & trigger_data; // @[dec_tlu_ctl.scala 531:57]
  wire  inst_acc_r_raw = io_dec_tlu_packet_r_icaf & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 699:49]
  wire [3:0] _T_391 = inst_acc_r_raw ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_392 = _T_389 & _T_391; // @[dec_tlu_ctl.scala 531:72]
  wire  _T_393 = io_tlu_exu_exu_i0_br_error_r | io_tlu_exu_exu_i0_br_start_error_r; // @[dec_tlu_ctl.scala 531:137]
  wire [3:0] _T_395 = _T_393 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_396 = _T_392 | _T_395; // @[dec_tlu_ctl.scala 531:98]
  wire [3:0] i0_iside_trigger_has_pri_r = ~_T_396; // @[dec_tlu_ctl.scala 531:38]
  wire [3:0] _T_405 = _T_404 & i0_iside_trigger_has_pri_r; // @[dec_tlu_ctl.scala 539:90]
  wire [3:0] trigger_store = {mtdata1_t_3[1],mtdata1_t_2[1],mtdata1_t_1[1],mtdata1_t_0[1]}; // @[Cat.scala 29:58]
  wire [3:0] _T_397 = trigger_store & trigger_data; // @[dec_tlu_ctl.scala 534:51]
  wire [3:0] _T_399 = io_lsu_error_pkt_r_valid ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_400 = _T_397 & _T_399; // @[dec_tlu_ctl.scala 534:66]
  wire [3:0] i0_lsu_trigger_has_pri_r = ~_T_400; // @[dec_tlu_ctl.scala 534:35]
  wire [3:0] _T_406 = _T_405 & i0_lsu_trigger_has_pri_r; // @[dec_tlu_ctl.scala 539:119]
  wire [1:0] mstatus = csr_io_mstatus; // @[dec_tlu_ctl.scala 999:31]
  wire  _T_369 = mtdata1_t_3[6] | mstatus[0]; // @[dec_tlu_ctl.scala 528:62]
  wire  _T_371 = _T_369 & mtdata1_t_3[3]; // @[dec_tlu_ctl.scala 528:86]
  wire  _T_374 = mtdata1_t_2[6] | mstatus[0]; // @[dec_tlu_ctl.scala 528:150]
  wire  _T_376 = _T_374 & mtdata1_t_2[3]; // @[dec_tlu_ctl.scala 528:174]
  wire [1:0] _T_388 = {_T_371,_T_376}; // @[Cat.scala 29:58]
  wire  _T_379 = mtdata1_t_1[6] | mstatus[0]; // @[dec_tlu_ctl.scala 528:239]
  wire  _T_381 = _T_379 & mtdata1_t_1[3]; // @[dec_tlu_ctl.scala 528:263]
  wire  _T_384 = mtdata1_t_0[6] | mstatus[0]; // @[dec_tlu_ctl.scala 528:328]
  wire  _T_386 = _T_384 & mtdata1_t_0[3]; // @[dec_tlu_ctl.scala 528:352]
  wire [1:0] _T_387 = {_T_381,_T_386}; // @[Cat.scala 29:58]
  wire [3:0] trigger_enabled = {_T_371,_T_376,_T_381,_T_386}; // @[Cat.scala 29:58]
  wire [3:0] i0trigger_qual_r = _T_406 & trigger_enabled; // @[dec_tlu_ctl.scala 539:146]
  wire [3:0] i0_trigger_r = _T_410 & i0trigger_qual_r; // @[dec_tlu_ctl.scala 541:84]
  wire  _T_413 = ~mtdata1_t_2[5]; // @[dec_tlu_ctl.scala 544:60]
  wire  _T_415 = _T_413 | i0_trigger_r[2]; // @[dec_tlu_ctl.scala 544:89]
  wire  _T_416 = i0_trigger_r[3] & _T_415; // @[dec_tlu_ctl.scala 544:57]
  wire  _T_421 = _T_413 | i0_trigger_r[3]; // @[dec_tlu_ctl.scala 544:157]
  wire  _T_422 = i0_trigger_r[2] & _T_421; // @[dec_tlu_ctl.scala 544:125]
  wire  _T_425 = ~mtdata1_t_0[5]; // @[dec_tlu_ctl.scala 544:196]
  wire  _T_427 = _T_425 | i0_trigger_r[0]; // @[dec_tlu_ctl.scala 544:225]
  wire  _T_428 = i0_trigger_r[1] & _T_427; // @[dec_tlu_ctl.scala 544:193]
  wire  _T_433 = _T_425 | i0_trigger_r[1]; // @[dec_tlu_ctl.scala 544:293]
  wire  _T_434 = i0_trigger_r[0] & _T_433; // @[dec_tlu_ctl.scala 544:261]
  wire [3:0] i0_trigger_chain_masked_r = {_T_416,_T_422,_T_428,_T_434}; // @[Cat.scala 29:58]
  wire  i0_trigger_hit_raw_r = |i0_trigger_chain_masked_r; // @[dec_tlu_ctl.scala 547:57]
  wire  _T_647 = ~i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 694:90]
  wire  _T_648 = _T_646 & _T_647; // @[dec_tlu_ctl.scala 694:88]
  wire  _T_587 = ~tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 651:44]
  wire  _T_588 = io_dec_tlu_i0_valid_r & _T_587; // @[dec_tlu_ctl.scala 651:42]
  wire  _T_590 = _T_588 & _T_393; // @[dec_tlu_ctl.scala 651:66]
  wire  _T_591 = ic_perr_r | iccm_sbecc_r; // @[dec_tlu_ctl.scala 651:151]
  wire  _T_593 = _T_591 & _T_656; // @[dec_tlu_ctl.scala 651:167]
  wire  _T_594 = _T_590 | _T_593; // @[dec_tlu_ctl.scala 651:137]
  wire  _T_596 = _T_594 & _T_647; // @[dec_tlu_ctl.scala 651:197]
  wire  _T_568 = io_dec_tlu_i0_valid_r & _T_647; // @[dec_tlu_ctl.scala 639:47]
  wire  _T_569 = ~io_lsu_error_pkt_r_bits_inst_type; // @[dec_tlu_ctl.scala 639:70]
  wire  _T_570 = _T_569 & io_lsu_error_pkt_r_bits_single_ecc_error; // @[dec_tlu_ctl.scala 639:105]
  wire  lsu_i0_rfnpc_r = _T_568 & _T_570; // @[dec_tlu_ctl.scala 639:67]
  wire  _T_597 = ~lsu_i0_rfnpc_r; // @[dec_tlu_ctl.scala 651:221]
  wire  rfpc_i0_r = _T_596 & _T_597; // @[dec_tlu_ctl.scala 651:218]
  wire  _T_649 = ~rfpc_i0_r; // @[dec_tlu_ctl.scala 694:110]
  wire  mret_r = _T_648 & _T_649; // @[dec_tlu_ctl.scala 694:108]
  wire  _T_179 = ~mret_r; // @[dec_tlu_ctl.scala 428:89]
  wire  _T_180 = _T_178 & _T_179; // @[dec_tlu_ctl.scala 428:87]
  wire  _T_182 = _T_180 & _T_338; // @[dec_tlu_ctl.scala 428:97]
  wire  _T_183 = ~dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 428:115]
  wire  _T_184 = _T_182 & _T_183; // @[dec_tlu_ctl.scala 428:113]
  wire  take_reset = int_exc_io_take_reset; // @[dec_tlu_ctl.scala 792:43]
  wire  _T_185 = ~take_reset; // @[dec_tlu_ctl.scala 428:145]
  wire  take_halt = _T_184 & _T_185; // @[dec_tlu_ctl.scala 428:143]
  wire  _T_224 = debug_resume_req_f & dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 453:49]
  wire  resume_ack_ns = _T_224 & dbg_run_state_ns; // @[dec_tlu_ctl.scala 453:68]
  wire  _T_225 = ~io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 455:61]
  wire  _T_226 = io_dec_tlu_i0_valid_r & _T_225; // @[dec_tlu_ctl.scala 455:59]
  wire  _T_228 = _T_226 & dcsr[2]; // @[dec_tlu_ctl.scala 455:84]
  wire  dcsr_single_step_done = _T_228 & _T_649; // @[dec_tlu_ctl.scala 455:102]
  wire  _T_439 = mtdata1_t_3[6] & mtdata1_t_3[9]; // @[dec_tlu_ctl.scala 553:61]
  wire  _T_442 = mtdata1_t_2[6] & mtdata1_t_2[9]; // @[dec_tlu_ctl.scala 553:121]
  wire  _T_445 = _T_442 & _T_413; // @[dec_tlu_ctl.scala 553:151]
  wire  _T_448 = mtdata1_t_1[6] & mtdata1_t_1[9]; // @[dec_tlu_ctl.scala 553:212]
  wire  _T_451 = mtdata1_t_0[6] & mtdata1_t_0[9]; // @[dec_tlu_ctl.scala 553:272]
  wire  _T_454 = _T_451 & _T_425; // @[dec_tlu_ctl.scala 553:302]
  wire [3:0] trigger_action = {_T_439,_T_445,_T_448,_T_454}; // @[Cat.scala 29:58]
  wire [3:0] _T_469 = i0_trigger_chain_masked_r & trigger_action; // @[dec_tlu_ctl.scala 559:57]
  wire  i0_trigger_action_r = |_T_469; // @[dec_tlu_ctl.scala 559:75]
  wire  trigger_hit_dmode_r = i0_trigger_hit_raw_r & i0_trigger_action_r; // @[dec_tlu_ctl.scala 561:45]
  wire  _T_675 = io_dec_tlu_packet_r_pmu_i0_itype == 4'h8; // @[dec_tlu_ctl.scala 703:64]
  wire  _T_676 = _T_675 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 703:77]
  wire  _T_678 = _T_676 & _T_647; // @[dec_tlu_ctl.scala 703:101]
  wire  _T_680 = _T_678 & dcsr[15]; // @[dec_tlu_ctl.scala 703:121]
  wire  ebreak_to_debug_mode_r = _T_680 & _T_649; // @[dec_tlu_ctl.scala 703:142]
  wire  _T_234 = trigger_hit_dmode_r | ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 462:57]
  wire  _T_235 = ~io_dec_tlu_flush_lower_wb; // @[dec_tlu_ctl.scala 462:112]
  reg  request_debug_mode_r_d1; // @[Reg.scala 27:20]
  wire  _T_236 = request_debug_mode_r_d1 & _T_235; // @[dec_tlu_ctl.scala 462:110]
  wire  request_debug_mode_r = _T_234 | _T_236; // @[dec_tlu_ctl.scala 462:83]
  reg  request_debug_mode_done_f; // @[Reg.scala 27:20]
  wire  _T_237 = request_debug_mode_r_d1 | request_debug_mode_done_f; // @[dec_tlu_ctl.scala 464:64]
  wire  request_debug_mode_done = _T_237 & _T_190; // @[dec_tlu_ctl.scala 464:93]
  wire  _T_240 = io_tlu_ifc_dec_tlu_flush_noredir_wb ^ dec_tlu_flush_noredir_r_d1; // @[lib.scala 463:21]
  wire  _T_241 = |_T_240; // @[lib.scala 463:29]
  wire  _T_244 = halt_taken ^ halt_taken_f; // @[lib.scala 441:21]
  wire  _T_245 = |_T_244; // @[lib.scala 441:29]
  wire  _T_248 = io_lsu_idle_any ^ lsu_idle_any_f; // @[lib.scala 441:21]
  wire  _T_249 = |_T_248; // @[lib.scala 441:29]
  wire  _T_252 = io_tlu_mem_ifu_miss_state_idle ^ ifu_miss_state_idle_f; // @[lib.scala 463:21]
  wire  _T_253 = |_T_252; // @[lib.scala 463:29]
  wire  _T_256 = dbg_tlu_halted ^ dbg_tlu_halted_f; // @[lib.scala 441:21]
  wire  _T_257 = |_T_256; // @[lib.scala 441:29]
  reg  _T_262; // @[Reg.scala 27:20]
  wire  _T_260 = resume_ack_ns ^ _T_262; // @[lib.scala 441:21]
  wire  _T_261 = |_T_260; // @[lib.scala 441:29]
  wire  _T_264 = debug_halt_req_ns ^ debug_halt_req_f; // @[lib.scala 441:21]
  wire  _T_265 = |_T_264; // @[lib.scala 441:29]
  wire  _T_268 = debug_resume_req ^ debug_resume_req_f_raw; // @[lib.scala 441:21]
  wire  _T_269 = |_T_268; // @[lib.scala 441:29]
  wire  _T_272 = trigger_hit_dmode_r ^ trigger_hit_dmode_r_d1; // @[lib.scala 441:21]
  wire  _T_273 = |_T_272; // @[lib.scala 441:29]
  wire  _T_276 = dcsr_single_step_done ^ dcsr_single_step_done_f; // @[lib.scala 441:21]
  wire  _T_277 = |_T_276; // @[lib.scala 441:29]
  wire  _T_280 = debug_halt_req ^ debug_halt_req_d1; // @[lib.scala 441:21]
  wire  _T_281 = |_T_280; // @[lib.scala 441:29]
  reg  dec_tlu_wr_pause_r_d1; // @[Reg.scala 27:20]
  wire  _T_283 = io_dec_tlu_wr_pause_r ^ dec_tlu_wr_pause_r_d1; // @[lib.scala 441:21]
  wire  _T_284 = |_T_283; // @[lib.scala 441:29]
  wire  _T_286 = io_dec_pause_state ^ dec_pause_state_f; // @[lib.scala 441:21]
  wire  _T_287 = |_T_286; // @[lib.scala 441:29]
  wire  _T_290 = request_debug_mode_r ^ request_debug_mode_r_d1; // @[lib.scala 441:21]
  wire  _T_291 = |_T_290; // @[lib.scala 441:29]
  wire  _T_294 = request_debug_mode_done ^ request_debug_mode_done_f; // @[lib.scala 441:21]
  wire  _T_295 = |_T_294; // @[lib.scala 441:29]
  wire  _T_298 = dcsr_single_step_running ^ dcsr_single_step_running_f; // @[lib.scala 441:21]
  wire  _T_299 = |_T_298; // @[lib.scala 441:29]
  wire  _T_302 = io_dec_tlu_flush_pause_r ^ dec_tlu_flush_pause_r_d1; // @[lib.scala 441:21]
  wire  _T_303 = |_T_302; // @[lib.scala 441:29]
  wire  _T_306 = dbg_halt_req_held_ns ^ dbg_halt_req_held; // @[lib.scala 441:21]
  wire  _T_307 = |_T_306; // @[lib.scala 441:29]
  wire  _T_651 = io_dec_tlu_packet_r_fence_i & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 696:50]
  wire  _T_653 = _T_651 & _T_647; // @[dec_tlu_ctl.scala 696:74]
  wire  fence_i_r = _T_653 & _T_649; // @[dec_tlu_ctl.scala 696:95]
  wire  _T_311 = fence_i_r & internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 496:71]
  wire  _T_312 = take_halt | _T_311; // @[dec_tlu_ctl.scala 496:58]
  wire  _T_313 = _T_312 | io_dec_tlu_flush_pause_r; // @[dec_tlu_ctl.scala 496:97]
  wire  _T_314 = i0_trigger_hit_raw_r & trigger_hit_dmode_r; // @[dec_tlu_ctl.scala 496:144]
  wire  _T_315 = _T_313 | _T_314; // @[dec_tlu_ctl.scala 496:124]
  wire  take_ext_int_start = int_exc_io_take_ext_int_start; // @[dec_tlu_ctl.scala 775:43]
  wire  _T_317 = ~interrupt_valid_r; // @[dec_tlu_ctl.scala 501:61]
  wire  _T_318 = dec_tlu_wr_pause_r_d1 & _T_317; // @[dec_tlu_ctl.scala 501:59]
  wire  _T_319 = ~take_ext_int_start; // @[dec_tlu_ctl.scala 501:82]
  wire  _T_341 = io_tlu_exu_dec_tlu_flush_lower_r & dcsr[2]; // @[dec_tlu_ctl.scala 505:82]
  wire  _T_342 = io_dec_tlu_resume_ack | dcsr_single_step_running; // @[dec_tlu_ctl.scala 505:125]
  wire  _T_343 = _T_341 & _T_342; // @[dec_tlu_ctl.scala 505:100]
  wire  _T_344 = ~io_tlu_ifc_dec_tlu_flush_noredir_wb; // @[dec_tlu_ctl.scala 505:155]
  wire  _T_639 = ~io_dec_tlu_packet_r_legal; // @[dec_tlu_ctl.scala 693:17]
  wire  _T_640 = _T_639 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 693:46]
  wire  _T_642 = _T_640 & _T_647; // @[dec_tlu_ctl.scala 693:70]
  wire  illegal_r = _T_642 & _T_649; // @[dec_tlu_ctl.scala 693:90]
  wire  _T_457 = |i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 556:55]
  wire  _T_459 = _T_457 & _T_649; // @[dec_tlu_ctl.scala 556:59]
  wire [3:0] _T_461 = _T_459 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_468 = {i0_trigger_chain_masked_r[3],i0_trigger_r[2],i0_trigger_chain_masked_r[1],i0_trigger_r[0]}; // @[Cat.scala 29:58]
  wire  _T_471 = ~trigger_hit_dmode_r; // @[dec_tlu_ctl.scala 563:55]
  wire  _T_472 = ~io_dec_tlu_debug_mode; // @[dec_tlu_ctl.scala 590:62]
  wire  _T_473 = i_cpu_halt_req_sync & _T_472; // @[dec_tlu_ctl.scala 590:60]
  wire  i_cpu_halt_req_sync_qual = _T_473 & _T_656; // @[dec_tlu_ctl.scala 590:85]
  wire  _T_476 = i_cpu_run_req_sync & _T_472; // @[dec_tlu_ctl.scala 591:58]
  wire  _T_477 = _T_476 & pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 591:83]
  wire  i_cpu_run_req_sync_qual = _T_477 & _T_656; // @[dec_tlu_ctl.scala 591:105]
  wire  _T_479 = i_cpu_halt_req_sync_qual ^ i_cpu_halt_req_d1; // @[lib.scala 441:21]
  wire  _T_480 = |_T_479; // @[lib.scala 441:29]
  wire  _T_482 = i_cpu_run_req_sync_qual ^ i_cpu_run_req_d1_raw; // @[lib.scala 441:21]
  wire  _T_483 = |_T_482; // @[lib.scala 441:29]
  wire  _T_539 = ~i_cpu_run_req_d1; // @[dec_tlu_ctl.scala 615:46]
  wire  _T_540 = pmu_fw_tlu_halted_f & _T_539; // @[dec_tlu_ctl.scala 615:44]
  wire  _T_542 = io_o_cpu_halt_status & _T_539; // @[dec_tlu_ctl.scala 615:89]
  wire  _T_544 = _T_542 & _T_658; // @[dec_tlu_ctl.scala 615:109]
  wire  cpu_halt_status = _T_540 | _T_544; // @[dec_tlu_ctl.scala 615:65]
  reg  _T_488; // @[Reg.scala 27:20]
  wire  _T_486 = cpu_halt_status ^ _T_488; // @[lib.scala 441:21]
  wire  _T_487 = |_T_486; // @[lib.scala 441:29]
  wire  _T_536 = i_cpu_halt_req_d1 & pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 614:39]
  wire  _T_537 = io_o_cpu_halt_ack & i_cpu_halt_req_sync; // @[dec_tlu_ctl.scala 614:83]
  wire  cpu_halt_ack = _T_536 | _T_537; // @[dec_tlu_ctl.scala 614:62]
  reg  _T_492; // @[Reg.scala 27:20]
  wire  _T_490 = cpu_halt_ack ^ _T_492; // @[lib.scala 441:21]
  wire  _T_491 = |_T_490; // @[lib.scala 441:29]
  wire  _T_547 = _T_192 & i_cpu_run_req_sync; // @[dec_tlu_ctl.scala 616:41]
  wire  _T_548 = io_o_cpu_halt_status & i_cpu_run_req_d1_raw; // @[dec_tlu_ctl.scala 616:87]
  wire  _T_549 = _T_547 | _T_548; // @[dec_tlu_ctl.scala 616:63]
  wire  _T_550 = io_o_cpu_run_ack & i_cpu_run_req_sync; // @[dec_tlu_ctl.scala 616:131]
  wire  cpu_run_ack = _T_549 | _T_550; // @[dec_tlu_ctl.scala 616:111]
  reg  _T_496; // @[Reg.scala 27:20]
  wire  _T_494 = cpu_run_ack ^ _T_496; // @[lib.scala 441:21]
  wire  _T_495 = |_T_494; // @[lib.scala 441:29]
  wire  ext_halt_pulse = i_cpu_halt_req_sync_qual & _T_559; // @[dec_tlu_ctl.scala 606:50]
  wire  fw_halt_req = csr_io_fw_halt_req; // @[dec_tlu_ctl.scala 998:31]
  wire  enter_pmu_fw_halt_req = ext_halt_pulse | fw_halt_req; // @[dec_tlu_ctl.scala 607:48]
  wire  _T_527 = pmu_fw_halt_req_f & core_empty; // @[dec_tlu_ctl.scala 612:45]
  wire  _T_528 = _T_527 & halt_taken; // @[dec_tlu_ctl.scala 612:58]
  wire  _T_529 = ~enter_debug_halt_req; // @[dec_tlu_ctl.scala 612:73]
  wire  _T_530 = _T_528 & _T_529; // @[dec_tlu_ctl.scala 612:71]
  wire  _T_533 = _T_530 | _T_540; // @[dec_tlu_ctl.scala 612:96]
  wire  pmu_fw_tlu_halted = _T_533 & _T_334; // @[dec_tlu_ctl.scala 612:141]
  wire  _T_517 = ~pmu_fw_tlu_halted; // @[dec_tlu_ctl.scala 608:72]
  wire  _T_518 = pmu_fw_halt_req_f & _T_517; // @[dec_tlu_ctl.scala 608:70]
  wire  _T_519 = enter_pmu_fw_halt_req | _T_518; // @[dec_tlu_ctl.scala 608:49]
  wire  pmu_fw_halt_req_ns = _T_519 & _T_334; // @[dec_tlu_ctl.scala 608:93]
  wire  _T_523 = internal_pmu_fw_halt_mode_f & _T_539; // @[dec_tlu_ctl.scala 609:83]
  wire  _T_525 = _T_523 & _T_334; // @[dec_tlu_ctl.scala 609:103]
  wire  internal_pmu_fw_halt_mode = pmu_fw_halt_req_ns | _T_525; // @[dec_tlu_ctl.scala 609:52]
  wire  _T_497 = internal_pmu_fw_halt_mode ^ internal_pmu_fw_halt_mode_f; // @[lib.scala 441:21]
  wire  _T_498 = |_T_497; // @[lib.scala 441:29]
  wire  _T_501 = pmu_fw_halt_req_ns ^ pmu_fw_halt_req_f; // @[lib.scala 441:21]
  wire  _T_502 = |_T_501; // @[lib.scala 441:29]
  wire  _T_505 = pmu_fw_tlu_halted ^ pmu_fw_tlu_halted_f; // @[lib.scala 441:21]
  wire  _T_506 = |_T_505; // @[lib.scala 441:29]
  wire  int_timer0_int_hold = int_exc_io_int_timer0_int_hold; // @[dec_tlu_ctl.scala 772:43]
  wire  _T_509 = int_timer0_int_hold ^ int_timer0_int_hold_f; // @[lib.scala 441:21]
  wire  _T_510 = |_T_509; // @[lib.scala 441:29]
  wire  int_timer1_int_hold = int_exc_io_int_timer1_int_hold; // @[dec_tlu_ctl.scala 773:43]
  wire  _T_513 = int_timer1_int_hold ^ int_timer1_int_hold_f; // @[lib.scala 441:21]
  wire  _T_514 = |_T_513; // @[lib.scala 441:29]
  wire  lsu_exc_valid_r_raw = io_lsu_error_pkt_r_valid & _T_235; // @[dec_tlu_ctl.scala 630:55]
  wire  _T_563 = io_lsu_error_pkt_r_valid & lsu_exc_valid_r_raw; // @[dec_tlu_ctl.scala 632:40]
  wire  _T_565 = _T_563 & _T_647; // @[dec_tlu_ctl.scala 632:62]
  wire  lsu_exc_valid_r = _T_565 & _T_649; // @[dec_tlu_ctl.scala 632:82]
  wire  _T_572 = io_dec_tlu_i0_valid_r & _T_649; // @[dec_tlu_ctl.scala 642:50]
  wire  _T_573 = ~lsu_exc_valid_r; // @[dec_tlu_ctl.scala 642:65]
  wire  _T_574 = _T_572 & _T_573; // @[dec_tlu_ctl.scala 642:63]
  wire  _T_672 = inst_acc_r_raw & _T_649; // @[dec_tlu_ctl.scala 700:33]
  wire  inst_acc_r = _T_672 & _T_647; // @[dec_tlu_ctl.scala 700:46]
  wire  _T_575 = ~inst_acc_r; // @[dec_tlu_ctl.scala 642:82]
  wire  _T_576 = _T_574 & _T_575; // @[dec_tlu_ctl.scala 642:79]
  wire  _T_578 = _T_576 & _T_225; // @[dec_tlu_ctl.scala 642:94]
  wire  _T_579 = ~request_debug_mode_r_d1; // @[dec_tlu_ctl.scala 642:121]
  wire  _T_580 = _T_578 & _T_579; // @[dec_tlu_ctl.scala 642:119]
  wire  tlu_i0_commit_cmt = _T_580 & _T_647; // @[dec_tlu_ctl.scala 642:146]
  wire  _T_582 = rfpc_i0_r | lsu_exc_valid_r; // @[dec_tlu_ctl.scala 645:38]
  wire  _T_583 = _T_582 | inst_acc_r; // @[dec_tlu_ctl.scala 645:53]
  wire  _T_584 = illegal_r & io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 645:79]
  wire  _T_585 = _T_583 | _T_584; // @[dec_tlu_ctl.scala 645:66]
  wire  _T_602 = tlu_i0_commit_cmt & iccm_repair_state_d1; // @[dec_tlu_ctl.scala 660:52]
  wire  _T_629 = ~dcsr[15]; // @[dec_tlu_ctl.scala 691:110]
  wire  _T_630 = _T_678 & _T_629; // @[dec_tlu_ctl.scala 691:108]
  wire  ebreak_r = _T_630 & _T_649; // @[dec_tlu_ctl.scala 691:130]
  wire  _T_633 = io_dec_tlu_packet_r_pmu_i0_itype == 4'h9; // @[dec_tlu_ctl.scala 692:51]
  wire  _T_634 = _T_633 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 692:64]
  wire  _T_636 = _T_634 & _T_647; // @[dec_tlu_ctl.scala 692:88]
  wire  ecall_r = _T_636 & _T_649; // @[dec_tlu_ctl.scala 692:108]
  wire  _T_603 = ebreak_r | ecall_r; // @[dec_tlu_ctl.scala 660:88]
  wire  _T_604 = _T_603 | mret_r; // @[dec_tlu_ctl.scala 660:98]
  wire  _T_605 = _T_604 | take_reset; // @[dec_tlu_ctl.scala 660:107]
  wire  _T_606 = _T_605 | illegal_r; // @[dec_tlu_ctl.scala 660:120]
  wire  _T_607 = io_dec_csr_wraddr_r == 12'h7c2; // @[dec_tlu_ctl.scala 660:176]
  wire  _T_608 = dec_csr_wen_r_mod & _T_607; // @[dec_tlu_ctl.scala 660:153]
  wire  _T_609 = _T_606 | _T_608; // @[dec_tlu_ctl.scala 660:132]
  wire  _T_610 = ~_T_609; // @[dec_tlu_ctl.scala 660:77]
  wire  _T_611 = io_tlu_exu_exu_i0_br_error_r & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 667:69]
  wire  _T_614 = io_tlu_exu_exu_i0_br_start_error_r & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 668:81]
  wire  _T_617 = io_tlu_exu_exu_i0_br_valid_r & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 669:65]
  wire  _T_619 = _T_617 & _T_587; // @[dec_tlu_ctl.scala 669:89]
  wire  _T_620 = ~io_tlu_exu_exu_i0_br_mp_r; // @[dec_tlu_ctl.scala 669:116]
  wire  _T_621 = ~io_tlu_exu_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 669:145]
  wire  _T_622 = _T_620 | _T_621; // @[dec_tlu_ctl.scala 669:143]
  wire  csr_pkt_presync = csr_read_io_csr_pkt_presync; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_684 = csr_pkt_presync & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 1008:42]
  wire  _T_685 = ~io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 1008:67]
  wire  csr_pkt_postsync = csr_read_io_csr_pkt_postsync; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  csr_pkt_csr_dcsr = csr_read_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  csr_pkt_csr_dpc = csr_read_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_694 = csr_pkt_csr_dcsr | csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 1013:55]
  wire  csr_pkt_csr_dmst = csr_read_io_csr_pkt_csr_dmst; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_695 = _T_694 | csr_pkt_csr_dmst; // @[dec_tlu_ctl.scala 1013:73]
  wire  csr_pkt_csr_dicawics = csr_read_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_696 = _T_695 | csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 1013:92]
  wire  csr_pkt_csr_dicad0 = csr_read_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_697 = _T_696 | csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 1013:115]
  wire  csr_pkt_csr_dicad0h = csr_read_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_698 = _T_697 | csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 1013:136]
  wire  csr_pkt_csr_dicad1 = csr_read_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_699 = _T_698 | csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 1013:158]
  wire  csr_pkt_csr_dicago = csr_read_io_csr_pkt_csr_dicago; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_700 = _T_699 | csr_pkt_csr_dicago; // @[dec_tlu_ctl.scala 1013:179]
  wire  _T_701 = ~_T_700; // @[dec_tlu_ctl.scala 1013:36]
  wire  _T_702 = _T_701 | dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 1013:201]
  wire  csr_pkt_legal = csr_read_io_csr_pkt_legal; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_703 = csr_pkt_legal & _T_702; // @[dec_tlu_ctl.scala 1013:33]
  wire  fast_int_meicpct = int_exc_io_fast_int_meicpct; // @[dec_tlu_ctl.scala 785:43]
  wire  _T_704 = ~fast_int_meicpct; // @[dec_tlu_ctl.scala 1013:223]
  wire  valid_csr = _T_703 & _T_704; // @[dec_tlu_ctl.scala 1013:221]
  wire  _T_707 = io_dec_csr_any_unq_d & valid_csr; // @[dec_tlu_ctl.scala 1015:46]
  wire  csr_pkt_csr_mvendorid = csr_read_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  csr_pkt_csr_marchid = csr_read_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_708 = csr_pkt_csr_mvendorid | csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 1015:107]
  wire  csr_pkt_csr_mimpid = csr_read_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_709 = _T_708 | csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 1015:129]
  wire  csr_pkt_csr_mhartid = csr_read_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_710 = _T_709 | csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 1015:150]
  wire  csr_pkt_csr_mdseac = csr_read_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_711 = _T_710 | csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 1015:172]
  wire  csr_pkt_csr_meihap = csr_read_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 278:41 dec_tlu_ctl.scala 1006:16]
  wire  _T_712 = _T_711 | csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 1015:193]
  wire  _T_713 = io_dec_csr_wen_unq_d & _T_712; // @[dec_tlu_ctl.scala 1015:82]
  wire  _T_714 = ~_T_713; // @[dec_tlu_ctl.scala 1015:59]
  int_exc int_exc ( // @[dec_tlu_ctl.scala 282:29]
    .clock(int_exc_clock),
    .reset(int_exc_reset),
    .io_mhwakeup_ready(int_exc_io_mhwakeup_ready),
    .io_ext_int_ready(int_exc_io_ext_int_ready),
    .io_ce_int_ready(int_exc_io_ce_int_ready),
    .io_soft_int_ready(int_exc_io_soft_int_ready),
    .io_timer_int_ready(int_exc_io_timer_int_ready),
    .io_int_timer0_int_hold(int_exc_io_int_timer0_int_hold),
    .io_int_timer1_int_hold(int_exc_io_int_timer1_int_hold),
    .io_internal_dbg_halt_timers(int_exc_io_internal_dbg_halt_timers),
    .io_take_ext_int_start(int_exc_io_take_ext_int_start),
    .io_ext_int_freeze_d1(int_exc_io_ext_int_freeze_d1),
    .io_take_ext_int_start_d1(int_exc_io_take_ext_int_start_d1),
    .io_take_ext_int_start_d2(int_exc_io_take_ext_int_start_d2),
    .io_take_ext_int_start_d3(int_exc_io_take_ext_int_start_d3),
    .io_ext_int_freeze(int_exc_io_ext_int_freeze),
    .io_take_ext_int(int_exc_io_take_ext_int),
    .io_fast_int_meicpct(int_exc_io_fast_int_meicpct),
    .io_ignore_ext_int_due_to_lsu_stall(int_exc_io_ignore_ext_int_due_to_lsu_stall),
    .io_take_ce_int(int_exc_io_take_ce_int),
    .io_take_soft_int(int_exc_io_take_soft_int),
    .io_take_timer_int(int_exc_io_take_timer_int),
    .io_take_int_timer0_int(int_exc_io_take_int_timer0_int),
    .io_take_int_timer1_int(int_exc_io_take_int_timer1_int),
    .io_take_reset(int_exc_io_take_reset),
    .io_take_nmi(int_exc_io_take_nmi),
    .io_synchronous_flush_r(int_exc_io_synchronous_flush_r),
    .io_tlu_flush_lower_r(int_exc_io_tlu_flush_lower_r),
    .io_dec_tlu_flush_lower_wb(int_exc_io_dec_tlu_flush_lower_wb),
    .io_dec_tlu_flush_lower_r(int_exc_io_dec_tlu_flush_lower_r),
    .io_dec_tlu_flush_path_r(int_exc_io_dec_tlu_flush_path_r),
    .io_interrupt_valid_r_d1(int_exc_io_interrupt_valid_r_d1),
    .io_i0_exception_valid_r_d1(int_exc_io_i0_exception_valid_r_d1),
    .io_exc_or_int_valid_r_d1(int_exc_io_exc_or_int_valid_r_d1),
    .io_exc_cause_wb(int_exc_io_exc_cause_wb),
    .io_i0_valid_wb(int_exc_io_i0_valid_wb),
    .io_trigger_hit_r_d1(int_exc_io_trigger_hit_r_d1),
    .io_take_nmi_r_d1(int_exc_io_take_nmi_r_d1),
    .io_interrupt_valid_r(int_exc_io_interrupt_valid_r),
    .io_exc_cause_r(int_exc_io_exc_cause_r),
    .io_i0_exception_valid_r(int_exc_io_i0_exception_valid_r),
    .io_tlu_flush_path_r_d1(int_exc_io_tlu_flush_path_r_d1),
    .io_exc_or_int_valid_r(int_exc_io_exc_or_int_valid_r),
    .io_dec_csr_stall_int_ff(int_exc_io_dec_csr_stall_int_ff),
    .io_mstatus_mie_ns(int_exc_io_mstatus_mie_ns),
    .io_mip(int_exc_io_mip),
    .io_mie_ns(int_exc_io_mie_ns),
    .io_mret_r(int_exc_io_mret_r),
    .io_pmu_fw_tlu_halted_f(int_exc_io_pmu_fw_tlu_halted_f),
    .io_int_timer0_int_hold_f(int_exc_io_int_timer0_int_hold_f),
    .io_int_timer1_int_hold_f(int_exc_io_int_timer1_int_hold_f),
    .io_internal_dbg_halt_mode_f(int_exc_io_internal_dbg_halt_mode_f),
    .io_dcsr_single_step_running(int_exc_io_dcsr_single_step_running),
    .io_internal_dbg_halt_mode(int_exc_io_internal_dbg_halt_mode),
    .io_dec_tlu_i0_valid_r(int_exc_io_dec_tlu_i0_valid_r),
    .io_internal_pmu_fw_halt_mode(int_exc_io_internal_pmu_fw_halt_mode),
    .io_i_cpu_halt_req_d1(int_exc_io_i_cpu_halt_req_d1),
    .io_ebreak_to_debug_mode_r(int_exc_io_ebreak_to_debug_mode_r),
    .io_lsu_fir_error(int_exc_io_lsu_fir_error),
    .io_csr_pkt_csr_meicpct(int_exc_io_csr_pkt_csr_meicpct),
    .io_dec_csr_any_unq_d(int_exc_io_dec_csr_any_unq_d),
    .io_lsu_fastint_stall_any(int_exc_io_lsu_fastint_stall_any),
    .io_reset_delayed(int_exc_io_reset_delayed),
    .io_mpc_reset_run_req(int_exc_io_mpc_reset_run_req),
    .io_nmi_int_detected(int_exc_io_nmi_int_detected),
    .io_dcsr_single_step_running_f(int_exc_io_dcsr_single_step_running_f),
    .io_dcsr_single_step_done_f(int_exc_io_dcsr_single_step_done_f),
    .io_dcsr(int_exc_io_dcsr),
    .io_mtvec(int_exc_io_mtvec),
    .io_tlu_i0_commit_cmt(int_exc_io_tlu_i0_commit_cmt),
    .io_i0_trigger_hit_r(int_exc_io_i0_trigger_hit_r),
    .io_pause_expired_r(int_exc_io_pause_expired_r),
    .io_nmi_vec(int_exc_io_nmi_vec),
    .io_lsu_i0_rfnpc_r(int_exc_io_lsu_i0_rfnpc_r),
    .io_fence_i_r(int_exc_io_fence_i_r),
    .io_iccm_repair_state_rfnpc(int_exc_io_iccm_repair_state_rfnpc),
    .io_i_cpu_run_req_d1(int_exc_io_i_cpu_run_req_d1),
    .io_rfpc_i0_r(int_exc_io_rfpc_i0_r),
    .io_lsu_exc_valid_r(int_exc_io_lsu_exc_valid_r),
    .io_trigger_hit_dmode_r(int_exc_io_trigger_hit_dmode_r),
    .io_take_halt(int_exc_io_take_halt),
    .io_rst_vec(int_exc_io_rst_vec),
    .io_lsu_fir_addr(int_exc_io_lsu_fir_addr),
    .io_dec_tlu_i0_pc_r(int_exc_io_dec_tlu_i0_pc_r),
    .io_npc_r(int_exc_io_npc_r),
    .io_mepc(int_exc_io_mepc),
    .io_debug_resume_req_f(int_exc_io_debug_resume_req_f),
    .io_dpc(int_exc_io_dpc),
    .io_npc_r_d1(int_exc_io_npc_r_d1),
    .io_tlu_flush_lower_r_d1(int_exc_io_tlu_flush_lower_r_d1),
    .io_dec_tlu_dbg_halted(int_exc_io_dec_tlu_dbg_halted),
    .io_ebreak_r(int_exc_io_ebreak_r),
    .io_ecall_r(int_exc_io_ecall_r),
    .io_illegal_r(int_exc_io_illegal_r),
    .io_inst_acc_r(int_exc_io_inst_acc_r),
    .io_lsu_i0_exc_r(int_exc_io_lsu_i0_exc_r),
    .io_lsu_error_pkt_r_bits_inst_type(int_exc_io_lsu_error_pkt_r_bits_inst_type),
    .io_lsu_error_pkt_r_bits_exc_type(int_exc_io_lsu_error_pkt_r_bits_exc_type),
    .io_dec_tlu_wr_pause_r_d1(int_exc_io_dec_tlu_wr_pause_r_d1)
  );
  csr_tlu csr ( // @[dec_tlu_ctl.scala 283:23]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_free_l2clk(csr_io_free_l2clk),
    .io_free_clk(csr_io_free_clk),
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
    .io_trigger_pkt_any_0_match_pkt(csr_io_trigger_pkt_any_0_match_pkt),
    .io_trigger_pkt_any_0_store(csr_io_trigger_pkt_any_0_store),
    .io_trigger_pkt_any_0_load(csr_io_trigger_pkt_any_0_load),
    .io_trigger_pkt_any_0_execute(csr_io_trigger_pkt_any_0_execute),
    .io_trigger_pkt_any_0_m(csr_io_trigger_pkt_any_0_m),
    .io_trigger_pkt_any_0_tdata2(csr_io_trigger_pkt_any_0_tdata2),
    .io_trigger_pkt_any_1_select(csr_io_trigger_pkt_any_1_select),
    .io_trigger_pkt_any_1_match_pkt(csr_io_trigger_pkt_any_1_match_pkt),
    .io_trigger_pkt_any_1_store(csr_io_trigger_pkt_any_1_store),
    .io_trigger_pkt_any_1_load(csr_io_trigger_pkt_any_1_load),
    .io_trigger_pkt_any_1_execute(csr_io_trigger_pkt_any_1_execute),
    .io_trigger_pkt_any_1_m(csr_io_trigger_pkt_any_1_m),
    .io_trigger_pkt_any_1_tdata2(csr_io_trigger_pkt_any_1_tdata2),
    .io_trigger_pkt_any_2_select(csr_io_trigger_pkt_any_2_select),
    .io_trigger_pkt_any_2_match_pkt(csr_io_trigger_pkt_any_2_match_pkt),
    .io_trigger_pkt_any_2_store(csr_io_trigger_pkt_any_2_store),
    .io_trigger_pkt_any_2_load(csr_io_trigger_pkt_any_2_load),
    .io_trigger_pkt_any_2_execute(csr_io_trigger_pkt_any_2_execute),
    .io_trigger_pkt_any_2_m(csr_io_trigger_pkt_any_2_m),
    .io_trigger_pkt_any_2_tdata2(csr_io_trigger_pkt_any_2_tdata2),
    .io_trigger_pkt_any_3_select(csr_io_trigger_pkt_any_3_select),
    .io_trigger_pkt_any_3_match_pkt(csr_io_trigger_pkt_any_3_match_pkt),
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
    .io_dec_tlu_picio_clk_override(csr_io_dec_tlu_picio_clk_override),
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
    .io_dec_tlu_trace_disable(csr_io_dec_tlu_trace_disable),
    .io_dec_illegal_inst(csr_io_dec_illegal_inst),
    .io_lsu_error_pkt_r_bits_mscause(csr_io_lsu_error_pkt_r_bits_mscause),
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
    .io_lsu_single_ecc_error_r(csr_io_lsu_single_ecc_error_r),
    .io_e4e5_int_clk(csr_io_e4e5_int_clk),
    .io_lsu_i0_exc_r(csr_io_lsu_i0_exc_r),
    .io_inst_acc_r(csr_io_inst_acc_r),
    .io_inst_acc_second_r(csr_io_inst_acc_second_r),
    .io_take_nmi(csr_io_take_nmi),
    .io_lsu_error_pkt_addr_r(csr_io_lsu_error_pkt_addr_r),
    .io_exc_cause_r(csr_io_exc_cause_r),
    .io_i0_valid_wb(csr_io_i0_valid_wb),
    .io_interrupt_valid_r_d1(csr_io_interrupt_valid_r_d1),
    .io_i0_exception_valid_r_d1(csr_io_i0_exception_valid_r_d1),
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
    .io_ext_int_freeze(csr_io_ext_int_freeze),
    .io_ext_int_freeze_d1(csr_io_ext_int_freeze_d1),
    .io_take_ext_int_start_d1(csr_io_take_ext_int_start_d1),
    .io_take_ext_int_start_d2(csr_io_take_ext_int_start_d2),
    .io_take_ext_int_start_d3(csr_io_take_ext_int_start_d3),
    .io_ic_perr_r(csr_io_ic_perr_r),
    .io_iccm_sbecc_r(csr_io_iccm_sbecc_r),
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
    .io_mtdata1_t_3(csr_io_mtdata1_t_3),
    .io_trigger_enabled(csr_io_trigger_enabled)
  );
  dec_timer_ctl int_timers ( // @[dec_tlu_ctl.scala 284:30]
    .clock(int_timers_clock),
    .reset(int_timers_reset),
    .io_free_l2clk(int_timers_io_free_l2clk),
    .io_csr_wr_clk(int_timers_io_csr_wr_clk),
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
  dec_decode_csr_read csr_read ( // @[dec_tlu_ctl.scala 1004:22]
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
  assign io_tlu_exu_dec_tlu_meihap = csr_io_dec_tlu_meihap; // @[dec_tlu_ctl.scala 866:52]
  assign io_tlu_exu_dec_tlu_flush_lower_r = int_exc_io_dec_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 797:54]
  assign io_tlu_exu_dec_tlu_flush_path_r = int_exc_io_dec_tlu_flush_path_r; // @[dec_tlu_ctl.scala 798:54]
  assign io_tlu_dma_dec_tlu_dma_qos_prty = csr_io_dec_tlu_dma_qos_prty; // @[dec_tlu_ctl.scala 897:48]
  assign io_dec_tlu_core_empty = force_halt | _T_204; // @[dec_tlu_ctl.scala 436:31]
  assign io_dec_dbg_cmd_done = io_dec_tlu_i0_valid_r & io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 509:29]
  assign io_dec_dbg_cmd_fail = illegal_r & io_dec_dbg_cmd_done; // @[dec_tlu_ctl.scala 510:29]
  assign io_dec_tlu_dbg_halted = dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 491:41]
  assign io_dec_tlu_debug_mode = debug_mode_status; // @[dec_tlu_ctl.scala 492:41]
  assign io_dec_tlu_resume_ack = _T_262; // @[dec_tlu_ctl.scala 472:53]
  assign io_dec_tlu_debug_stall = debug_halt_req_f; // @[dec_tlu_ctl.scala 490:41]
  assign io_dec_tlu_mpc_halted_only = _T_119; // @[dec_tlu_ctl.scala 386:42]
  assign io_dec_tlu_flush_extint = int_exc_io_take_ext_int_start; // @[dec_tlu_ctl.scala 498:33]
  assign io_trigger_pkt_any_0_select = csr_io_trigger_pkt_any_0_select; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_0_match_pkt = csr_io_trigger_pkt_any_0_match_pkt; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_0_store = csr_io_trigger_pkt_any_0_store; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_0_load = csr_io_trigger_pkt_any_0_load; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_0_execute = csr_io_trigger_pkt_any_0_execute; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_0_m = csr_io_trigger_pkt_any_0_m; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_0_tdata2 = csr_io_trigger_pkt_any_0_tdata2; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_select = csr_io_trigger_pkt_any_1_select; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_match_pkt = csr_io_trigger_pkt_any_1_match_pkt; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_store = csr_io_trigger_pkt_any_1_store; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_load = csr_io_trigger_pkt_any_1_load; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_execute = csr_io_trigger_pkt_any_1_execute; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_m = csr_io_trigger_pkt_any_1_m; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_1_tdata2 = csr_io_trigger_pkt_any_1_tdata2; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_select = csr_io_trigger_pkt_any_2_select; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_match_pkt = csr_io_trigger_pkt_any_2_match_pkt; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_store = csr_io_trigger_pkt_any_2_store; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_load = csr_io_trigger_pkt_any_2_load; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_execute = csr_io_trigger_pkt_any_2_execute; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_m = csr_io_trigger_pkt_any_2_m; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_2_tdata2 = csr_io_trigger_pkt_any_2_tdata2; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_select = csr_io_trigger_pkt_any_3_select; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_match_pkt = csr_io_trigger_pkt_any_3_match_pkt; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_store = csr_io_trigger_pkt_any_3_store; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_load = csr_io_trigger_pkt_any_3_load; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_execute = csr_io_trigger_pkt_any_3_execute; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_m = csr_io_trigger_pkt_any_3_m; // @[dec_tlu_ctl.scala 872:40]
  assign io_trigger_pkt_any_3_tdata2 = csr_io_trigger_pkt_any_3_tdata2; // @[dec_tlu_ctl.scala 872:40]
  assign io_o_cpu_halt_status = _T_488; // @[dec_tlu_ctl.scala 595:60]
  assign io_o_cpu_halt_ack = _T_492; // @[dec_tlu_ctl.scala 596:60]
  assign io_o_cpu_run_ack = _T_496; // @[dec_tlu_ctl.scala 597:60]
  assign io_o_debug_mode_status = debug_mode_status; // @[dec_tlu_ctl.scala 618:27]
  assign io_mpc_debug_halt_ack = mpc_debug_halt_ack_f; // @[dec_tlu_ctl.scala 412:31]
  assign io_mpc_debug_run_ack = mpc_debug_run_ack_f; // @[dec_tlu_ctl.scala 413:31]
  assign io_debug_brkpt_status = debug_brkpt_status_f; // @[dec_tlu_ctl.scala 414:31]
  assign io_dec_csr_rddata_d = csr_io_dec_csr_rddata_d; // @[dec_tlu_ctl.scala 888:40]
  assign io_dec_csr_legal_d = _T_707 & _T_714; // @[dec_tlu_ctl.scala 1015:20]
  assign io_dec_tlu_i0_kill_writeb_wb = _T_34; // @[dec_tlu_ctl.scala 342:41]
  assign io_dec_tlu_i0_kill_writeb_r = _T_585 | i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 348:41]
  assign io_dec_tlu_wr_pause_r = csr_io_dec_tlu_wr_pause_r; // @[dec_tlu_ctl.scala 890:40]
  assign io_dec_tlu_flush_pause_r = _T_318 & _T_319; // @[dec_tlu_ctl.scala 501:34]
  assign io_dec_tlu_presync_d = _T_684 & _T_685; // @[dec_tlu_ctl.scala 1008:23]
  assign io_dec_tlu_postsync_d = csr_pkt_postsync & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 1009:23]
  assign io_dec_tlu_perfcnt0 = csr_io_dec_tlu_perfcnt0; // @[dec_tlu_ctl.scala 875:40]
  assign io_dec_tlu_perfcnt1 = csr_io_dec_tlu_perfcnt1; // @[dec_tlu_ctl.scala 876:40]
  assign io_dec_tlu_perfcnt2 = csr_io_dec_tlu_perfcnt2; // @[dec_tlu_ctl.scala 877:40]
  assign io_dec_tlu_perfcnt3 = csr_io_dec_tlu_perfcnt3; // @[dec_tlu_ctl.scala 878:40]
  assign io_dec_tlu_i0_exc_valid_wb1 = csr_io_dec_tlu_i0_exc_valid_wb1; // @[dec_tlu_ctl.scala 869:44]
  assign io_dec_tlu_i0_valid_wb1 = csr_io_dec_tlu_i0_valid_wb1; // @[dec_tlu_ctl.scala 870:44]
  assign io_dec_tlu_int_valid_wb1 = csr_io_dec_tlu_int_valid_wb1; // @[dec_tlu_ctl.scala 868:44]
  assign io_dec_tlu_exc_cause_wb1 = csr_io_dec_tlu_exc_cause_wb1; // @[dec_tlu_ctl.scala 874:40]
  assign io_dec_tlu_mtval_wb1 = csr_io_dec_tlu_mtval_wb1; // @[dec_tlu_ctl.scala 873:40]
  assign io_dec_tlu_pipelining_disable = csr_io_dec_tlu_pipelining_disable; // @[dec_tlu_ctl.scala 889:40]
  assign io_dec_tlu_trace_disable = csr_io_dec_tlu_trace_disable; // @[dec_tlu_ctl.scala 898:49]
  assign io_dec_tlu_misc_clk_override = csr_io_dec_tlu_misc_clk_override; // @[dec_tlu_ctl.scala 879:40]
  assign io_dec_tlu_dec_clk_override = csr_io_dec_tlu_dec_clk_override; // @[dec_tlu_ctl.scala 881:40]
  assign io_dec_tlu_ifu_clk_override = csr_io_dec_tlu_ifu_clk_override; // @[dec_tlu_ctl.scala 882:40]
  assign io_dec_tlu_lsu_clk_override = csr_io_dec_tlu_lsu_clk_override; // @[dec_tlu_ctl.scala 883:40]
  assign io_dec_tlu_bus_clk_override = csr_io_dec_tlu_bus_clk_override; // @[dec_tlu_ctl.scala 884:40]
  assign io_dec_tlu_pic_clk_override = csr_io_dec_tlu_pic_clk_override; // @[dec_tlu_ctl.scala 885:40]
  assign io_dec_tlu_picio_clk_override = csr_io_dec_tlu_picio_clk_override; // @[dec_tlu_ctl.scala 880:46]
  assign io_dec_tlu_dccm_clk_override = csr_io_dec_tlu_dccm_clk_override; // @[dec_tlu_ctl.scala 886:40]
  assign io_dec_tlu_icm_clk_override = csr_io_dec_tlu_icm_clk_override; // @[dec_tlu_ctl.scala 887:40]
  assign io_dec_tlu_flush_lower_wb = int_exc_io_dec_tlu_flush_lower_wb; // @[dec_tlu_ctl.scala 796:46]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_valid = _T_619 & _T_622; // @[dec_tlu_ctl.scala 675:73]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist = io_tlu_exu_exu_i0_br_hist_r; // @[dec_tlu_ctl.scala 672:73]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error = _T_611 & _T_587; // @[dec_tlu_ctl.scala 673:73]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error = _T_614 & _T_587; // @[dec_tlu_ctl.scala 674:73]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_way = io_exu_i0_br_way_r; // @[dec_tlu_ctl.scala 676:73]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle = io_tlu_exu_exu_i0_br_middle_r; // @[dec_tlu_ctl.scala 677:81]
  assign io_tlu_bp_dec_tlu_flush_leak_one_wb = _T_343 & _T_344; // @[dec_tlu_ctl.scala 505:45]
  assign io_tlu_bp_dec_tlu_bpred_disable = csr_io_dec_tlu_bpred_disable; // @[dec_tlu_ctl.scala 893:47]
  assign io_tlu_ifc_dec_tlu_flush_noredir_wb = _T_315 | take_ext_int_start; // @[dec_tlu_ctl.scala 496:45]
  assign io_tlu_ifc_dec_tlu_mrac_ff = csr_io_dec_tlu_mrac_ff; // @[dec_tlu_ctl.scala 891:48]
  assign io_tlu_mem_dec_tlu_flush_err_wb = io_tlu_exu_dec_tlu_flush_lower_r & _T_591; // @[dec_tlu_ctl.scala 506:41]
  assign io_tlu_mem_dec_tlu_i0_commit_cmt = _T_580 & _T_647; // @[dec_tlu_ctl.scala 646:37]
  assign io_tlu_mem_dec_tlu_force_halt = _T_35; // @[dec_tlu_ctl.scala 344:57]
  assign io_tlu_mem_dec_tlu_fence_i_wb = _T_653 & _T_649; // @[dec_tlu_ctl.scala 706:39]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata = csr_io_dec_tlu_ic_diag_pkt_icache_wrdata; // @[dec_tlu_ctl.scala 871:52]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics = csr_io_dec_tlu_ic_diag_pkt_icache_dicawics; // @[dec_tlu_ctl.scala 871:52]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid = csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[dec_tlu_ctl.scala 871:52]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid = csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[dec_tlu_ctl.scala 871:52]
  assign io_tlu_mem_dec_tlu_core_ecc_disable = csr_io_dec_tlu_core_ecc_disable; // @[dec_tlu_ctl.scala 895:48]
  assign io_tlu_busbuff_dec_tlu_external_ldfwd_disable = csr_io_dec_tlu_external_ldfwd_disable; // @[dec_tlu_ctl.scala 896:52]
  assign io_tlu_busbuff_dec_tlu_wb_coalescing_disable = csr_io_dec_tlu_wb_coalescing_disable; // @[dec_tlu_ctl.scala 892:52]
  assign io_tlu_busbuff_dec_tlu_sideeffect_posted_disable = csr_io_dec_tlu_sideeffect_posted_disable; // @[dec_tlu_ctl.scala 894:52]
  assign io_dec_pic_dec_tlu_meicurpl = csr_io_dec_tlu_meicurpl; // @[dec_tlu_ctl.scala 865:52]
  assign io_dec_pic_dec_tlu_meipt = csr_io_dec_tlu_meipt; // @[dec_tlu_ctl.scala 867:52]
  assign int_exc_clock = clock;
  assign int_exc_reset = reset;
  assign int_exc_io_ext_int_freeze_d1 = csr_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 776:34]
  assign int_exc_io_take_ext_int_start_d1 = csr_io_take_ext_int_start_d1; // @[dec_tlu_ctl.scala 777:44]
  assign int_exc_io_take_ext_int_start_d2 = csr_io_take_ext_int_start_d2; // @[dec_tlu_ctl.scala 778:44]
  assign int_exc_io_take_ext_int_start_d3 = csr_io_take_ext_int_start_d3; // @[dec_tlu_ctl.scala 779:44]
  assign int_exc_io_dec_csr_stall_int_ff = io_dec_csr_stall_int_ff; // @[dec_tlu_ctl.scala 711:49]
  assign int_exc_io_mstatus_mie_ns = csr_io_mstatus_mie_ns; // @[dec_tlu_ctl.scala 712:49]
  assign int_exc_io_mip = csr_io_mip; // @[dec_tlu_ctl.scala 713:49]
  assign int_exc_io_mie_ns = csr_io_mie_ns; // @[dec_tlu_ctl.scala 714:49]
  assign int_exc_io_mret_r = _T_648 & _T_649; // @[dec_tlu_ctl.scala 715:49]
  assign int_exc_io_pmu_fw_tlu_halted_f = pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 716:49]
  assign int_exc_io_int_timer0_int_hold_f = int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 717:49]
  assign int_exc_io_int_timer1_int_hold_f = int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 718:49]
  assign int_exc_io_internal_dbg_halt_mode_f = debug_mode_status; // @[dec_tlu_ctl.scala 719:49]
  assign int_exc_io_dcsr_single_step_running = _T_231 | _T_233; // @[dec_tlu_ctl.scala 720:49]
  assign int_exc_io_internal_dbg_halt_mode = debug_halt_req_ns | _T_214; // @[dec_tlu_ctl.scala 721:49]
  assign int_exc_io_dec_tlu_i0_valid_r = io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 722:49]
  assign int_exc_io_internal_pmu_fw_halt_mode = pmu_fw_halt_req_ns | _T_525; // @[dec_tlu_ctl.scala 723:49]
  assign int_exc_io_i_cpu_halt_req_d1 = i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 724:49]
  assign int_exc_io_ebreak_to_debug_mode_r = _T_680 & _T_649; // @[dec_tlu_ctl.scala 725:49]
  assign int_exc_io_lsu_fir_error = io_lsu_fir_error; // @[dec_tlu_ctl.scala 726:49]
  assign int_exc_io_csr_pkt_csr_meicpct = csr_read_io_csr_pkt_csr_meicpct; // @[dec_tlu_ctl.scala 727:49]
  assign int_exc_io_dec_csr_any_unq_d = io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 728:49]
  assign int_exc_io_lsu_fastint_stall_any = io_lsu_fastint_stall_any; // @[dec_tlu_ctl.scala 729:49]
  assign int_exc_io_reset_delayed = reset_detect ^ reset_detected; // @[dec_tlu_ctl.scala 730:49]
  assign int_exc_io_mpc_reset_run_req = io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 731:49]
  assign int_exc_io_nmi_int_detected = _T_57 | nmi_fir_type; // @[dec_tlu_ctl.scala 732:49]
  assign int_exc_io_dcsr_single_step_running_f = dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 733:49]
  assign int_exc_io_dcsr_single_step_done_f = dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 734:49]
  assign int_exc_io_dcsr = csr_io_dcsr; // @[dec_tlu_ctl.scala 735:49]
  assign int_exc_io_mtvec = csr_io_mtvec; // @[dec_tlu_ctl.scala 736:49]
  assign int_exc_io_tlu_i0_commit_cmt = _T_580 & _T_647; // @[dec_tlu_ctl.scala 737:49]
  assign int_exc_io_i0_trigger_hit_r = |i0_trigger_chain_masked_r; // @[dec_tlu_ctl.scala 738:49]
  assign int_exc_io_pause_expired_r = _T_337 & _T_338; // @[dec_tlu_ctl.scala 739:49]
  assign int_exc_io_nmi_vec = io_nmi_vec; // @[dec_tlu_ctl.scala 740:49]
  assign int_exc_io_lsu_i0_rfnpc_r = _T_568 & _T_570; // @[dec_tlu_ctl.scala 741:49]
  assign int_exc_io_fence_i_r = _T_653 & _T_649; // @[dec_tlu_ctl.scala 742:49]
  assign int_exc_io_iccm_repair_state_rfnpc = _T_602 & _T_610; // @[dec_tlu_ctl.scala 743:49]
  assign int_exc_io_i_cpu_run_req_d1 = i_cpu_run_req_d1_raw | _T_560; // @[dec_tlu_ctl.scala 744:49]
  assign int_exc_io_rfpc_i0_r = _T_596 & _T_597; // @[dec_tlu_ctl.scala 745:49]
  assign int_exc_io_lsu_exc_valid_r = _T_565 & _T_649; // @[dec_tlu_ctl.scala 746:49]
  assign int_exc_io_trigger_hit_dmode_r = i0_trigger_hit_raw_r & i0_trigger_action_r; // @[dec_tlu_ctl.scala 747:49]
  assign int_exc_io_take_halt = _T_184 & _T_185; // @[dec_tlu_ctl.scala 748:49]
  assign int_exc_io_rst_vec = io_rst_vec; // @[dec_tlu_ctl.scala 749:49]
  assign int_exc_io_lsu_fir_addr = io_lsu_fir_addr; // @[dec_tlu_ctl.scala 750:49]
  assign int_exc_io_dec_tlu_i0_pc_r = io_dec_tlu_i0_pc_r; // @[dec_tlu_ctl.scala 751:49]
  assign int_exc_io_npc_r = csr_io_npc_r; // @[dec_tlu_ctl.scala 752:49]
  assign int_exc_io_mepc = csr_io_mepc; // @[dec_tlu_ctl.scala 753:49]
  assign int_exc_io_debug_resume_req_f = debug_resume_req_f_raw & _T_309; // @[dec_tlu_ctl.scala 754:49]
  assign int_exc_io_dpc = csr_io_dpc; // @[dec_tlu_ctl.scala 755:49]
  assign int_exc_io_npc_r_d1 = csr_io_npc_r_d1; // @[dec_tlu_ctl.scala 756:49]
  assign int_exc_io_tlu_flush_lower_r_d1 = tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 757:49]
  assign int_exc_io_dec_tlu_dbg_halted = io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 758:49]
  assign int_exc_io_ebreak_r = _T_630 & _T_649; // @[dec_tlu_ctl.scala 759:49]
  assign int_exc_io_ecall_r = _T_636 & _T_649; // @[dec_tlu_ctl.scala 760:49]
  assign int_exc_io_illegal_r = _T_642 & _T_649; // @[dec_tlu_ctl.scala 761:49]
  assign int_exc_io_inst_acc_r = _T_672 & _T_647; // @[dec_tlu_ctl.scala 762:49]
  assign int_exc_io_lsu_i0_exc_r = _T_565 & _T_649; // @[dec_tlu_ctl.scala 763:49]
  assign int_exc_io_lsu_error_pkt_r_bits_inst_type = io_lsu_error_pkt_r_bits_inst_type; // @[dec_tlu_ctl.scala 764:49]
  assign int_exc_io_lsu_error_pkt_r_bits_exc_type = io_lsu_error_pkt_r_bits_exc_type; // @[dec_tlu_ctl.scala 764:49]
  assign int_exc_io_dec_tlu_wr_pause_r_d1 = dec_tlu_wr_pause_r_d1; // @[dec_tlu_ctl.scala 765:42]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_free_l2clk = io_free_l2clk; // @[dec_tlu_ctl.scala 809:44]
  assign csr_io_free_clk = io_free_clk; // @[dec_tlu_ctl.scala 808:44]
  assign csr_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 811:44]
  assign csr_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 812:44]
  assign csr_io_dec_csr_rdaddr_d = io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 813:44]
  assign csr_io_dec_csr_wen_unq_d = io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 814:44]
  assign csr_io_dec_i0_decode_d = io_dec_i0_decode_d; // @[dec_tlu_ctl.scala 815:44]
  assign csr_io_ifu_ic_debug_rd_data_valid = io_tlu_mem_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 816:44]
  assign csr_io_ifu_pmu_bus_trxn = io_tlu_mem_ifu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 817:44]
  assign csr_io_dma_iccm_stall_any = io_tlu_dma_dma_iccm_stall_any; // @[dec_tlu_ctl.scala 818:44]
  assign csr_io_dma_dccm_stall_any = io_tlu_dma_dma_dccm_stall_any; // @[dec_tlu_ctl.scala 819:44]
  assign csr_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[dec_tlu_ctl.scala 820:44]
  assign csr_io_dec_pmu_presync_stall = io_dec_pmu_presync_stall; // @[dec_tlu_ctl.scala 821:44]
  assign csr_io_dec_pmu_postsync_stall = io_dec_pmu_postsync_stall; // @[dec_tlu_ctl.scala 822:44]
  assign csr_io_dec_pmu_decode_stall = io_dec_pmu_decode_stall; // @[dec_tlu_ctl.scala 823:44]
  assign csr_io_ifu_pmu_fetch_stall = io_tlu_ifc_ifu_pmu_fetch_stall; // @[dec_tlu_ctl.scala 824:44]
  assign csr_io_dec_tlu_packet_r_icaf_type = io_dec_tlu_packet_r_icaf_type; // @[dec_tlu_ctl.scala 825:44]
  assign csr_io_dec_tlu_packet_r_pmu_i0_itype = io_dec_tlu_packet_r_pmu_i0_itype; // @[dec_tlu_ctl.scala 825:44]
  assign csr_io_dec_tlu_packet_r_pmu_i0_br_unpred = io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec_tlu_ctl.scala 825:44]
  assign csr_io_dec_tlu_packet_r_pmu_divide = io_dec_tlu_packet_r_pmu_divide; // @[dec_tlu_ctl.scala 825:44]
  assign csr_io_dec_tlu_packet_r_pmu_lsu_misaligned = io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 825:44]
  assign csr_io_exu_pmu_i0_br_ataken = io_tlu_exu_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 826:44]
  assign csr_io_exu_pmu_i0_br_misp = io_tlu_exu_exu_pmu_i0_br_misp; // @[dec_tlu_ctl.scala 827:44]
  assign csr_io_dec_pmu_instr_decoded = io_dec_pmu_instr_decoded; // @[dec_tlu_ctl.scala 828:44]
  assign csr_io_ifu_pmu_instr_aligned = io_ifu_pmu_instr_aligned; // @[dec_tlu_ctl.scala 829:44]
  assign csr_io_exu_pmu_i0_pc4 = io_tlu_exu_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 830:44]
  assign csr_io_ifu_pmu_ic_miss = io_tlu_mem_ifu_pmu_ic_miss; // @[dec_tlu_ctl.scala 831:44]
  assign csr_io_ifu_pmu_ic_hit = io_tlu_mem_ifu_pmu_ic_hit; // @[dec_tlu_ctl.scala 832:44]
  assign csr_io_dec_csr_wen_r = io_dec_csr_wen_r; // @[dec_tlu_ctl.scala 833:44]
  assign csr_io_dec_tlu_dbg_halted = io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 834:44]
  assign csr_io_dma_pmu_dccm_write = io_tlu_dma_dma_pmu_dccm_write; // @[dec_tlu_ctl.scala 835:44]
  assign csr_io_dma_pmu_dccm_read = io_tlu_dma_dma_pmu_dccm_read; // @[dec_tlu_ctl.scala 836:44]
  assign csr_io_dma_pmu_any_write = io_tlu_dma_dma_pmu_any_write; // @[dec_tlu_ctl.scala 837:44]
  assign csr_io_dma_pmu_any_read = io_tlu_dma_dma_pmu_any_read; // @[dec_tlu_ctl.scala 838:44]
  assign csr_io_lsu_pmu_bus_busy = io_tlu_busbuff_lsu_pmu_bus_busy; // @[dec_tlu_ctl.scala 839:44]
  assign csr_io_dec_tlu_i0_pc_r = io_dec_tlu_i0_pc_r; // @[dec_tlu_ctl.scala 840:44]
  assign csr_io_dec_tlu_i0_valid_r = io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 841:44]
  assign csr_io_dec_csr_any_unq_d = io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 843:44]
  assign csr_io_ifu_pmu_bus_busy = io_tlu_mem_ifu_pmu_bus_busy; // @[dec_tlu_ctl.scala 844:44]
  assign csr_io_lsu_pmu_bus_error = io_tlu_busbuff_lsu_pmu_bus_error; // @[dec_tlu_ctl.scala 845:44]
  assign csr_io_ifu_pmu_bus_error = io_tlu_mem_ifu_pmu_bus_error; // @[dec_tlu_ctl.scala 846:44]
  assign csr_io_lsu_pmu_bus_misaligned = io_tlu_busbuff_lsu_pmu_bus_misaligned; // @[dec_tlu_ctl.scala 847:44]
  assign csr_io_lsu_pmu_bus_trxn = io_tlu_busbuff_lsu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 848:44]
  assign csr_io_ifu_ic_debug_rd_data = io_tlu_mem_ifu_ic_debug_rd_data; // @[dec_tlu_ctl.scala 849:44]
  assign csr_io_pic_pl = io_dec_pic_pic_pl; // @[dec_tlu_ctl.scala 850:44]
  assign csr_io_pic_claimid = io_dec_pic_pic_claimid; // @[dec_tlu_ctl.scala 851:44]
  assign csr_io_iccm_dma_sb_error = io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 852:44]
  assign csr_io_lsu_imprecise_error_addr_any = io_tlu_busbuff_lsu_imprecise_error_addr_any; // @[dec_tlu_ctl.scala 853:44]
  assign csr_io_lsu_imprecise_error_load_any = io_tlu_busbuff_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 854:44]
  assign csr_io_lsu_imprecise_error_store_any = io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 855:44]
  assign csr_io_dec_illegal_inst = io_dec_illegal_inst; // @[dec_tlu_ctl.scala 856:44 dec_tlu_ctl.scala 899:44]
  assign csr_io_lsu_error_pkt_r_bits_mscause = io_lsu_error_pkt_r_bits_mscause; // @[dec_tlu_ctl.scala 857:44 dec_tlu_ctl.scala 900:44]
  assign csr_io_mexintpend = io_dec_pic_mexintpend; // @[dec_tlu_ctl.scala 858:44 dec_tlu_ctl.scala 901:44]
  assign csr_io_exu_npc_r = io_tlu_exu_exu_npc_r; // @[dec_tlu_ctl.scala 859:44 dec_tlu_ctl.scala 902:44]
  assign csr_io_mpc_reset_run_req = io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 860:44 dec_tlu_ctl.scala 903:44]
  assign csr_io_rst_vec = io_rst_vec; // @[dec_tlu_ctl.scala 861:44 dec_tlu_ctl.scala 904:44]
  assign csr_io_core_id = io_core_id; // @[dec_tlu_ctl.scala 862:44 dec_tlu_ctl.scala 905:44]
  assign csr_io_dec_timer_rddata_d = int_timers_io_dec_timer_rddata_d; // @[dec_tlu_ctl.scala 863:44 dec_tlu_ctl.scala 906:44]
  assign csr_io_dec_timer_read_d = int_timers_io_dec_timer_read_d; // @[dec_tlu_ctl.scala 864:44 dec_tlu_ctl.scala 907:44]
  assign csr_io_rfpc_i0_r = _T_596 & _T_597; // @[dec_tlu_ctl.scala 910:39]
  assign csr_io_i0_trigger_hit_r = |i0_trigger_chain_masked_r; // @[dec_tlu_ctl.scala 911:39]
  assign csr_io_exc_or_int_valid_r = int_exc_io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 912:39]
  assign csr_io_mret_r = _T_648 & _T_649; // @[dec_tlu_ctl.scala 913:39]
  assign csr_io_dcsr_single_step_running_f = dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 914:39]
  assign csr_io_dec_timer_t0_pulse = int_timers_io_dec_timer_t0_pulse; // @[dec_tlu_ctl.scala 915:39]
  assign csr_io_dec_timer_t1_pulse = int_timers_io_dec_timer_t1_pulse; // @[dec_tlu_ctl.scala 916:39]
  assign csr_io_timer_int_sync = syncro_ff[5]; // @[dec_tlu_ctl.scala 917:39]
  assign csr_io_soft_int_sync = syncro_ff[4]; // @[dec_tlu_ctl.scala 918:39]
  assign csr_io_csr_wr_clk = clock; // @[dec_tlu_ctl.scala 919:39]
  assign csr_io_ebreak_to_debug_mode_r = _T_680 & _T_649; // @[dec_tlu_ctl.scala 920:39]
  assign csr_io_dec_tlu_pmu_fw_halted = pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 921:39]
  assign csr_io_lsu_fir_error = io_lsu_fir_error; // @[dec_tlu_ctl.scala 922:39]
  assign csr_io_tlu_flush_lower_r_d1 = tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 923:39]
  assign csr_io_dec_tlu_flush_noredir_r_d1 = dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 924:39]
  assign csr_io_tlu_flush_path_r_d1 = int_exc_io_tlu_flush_path_r_d1; // @[dec_tlu_ctl.scala 925:39]
  assign csr_io_reset_delayed = reset_detect ^ reset_detected; // @[dec_tlu_ctl.scala 926:39]
  assign csr_io_interrupt_valid_r = int_exc_io_interrupt_valid_r; // @[dec_tlu_ctl.scala 927:39]
  assign csr_io_i0_exception_valid_r = int_exc_io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 928:39]
  assign csr_io_lsu_exc_valid_r = _T_565 & _T_649; // @[dec_tlu_ctl.scala 929:39]
  assign csr_io_mepc_trigger_hit_sel_pc_r = i0_trigger_hit_raw_r & _T_471; // @[dec_tlu_ctl.scala 930:39]
  assign csr_io_lsu_single_ecc_error_r = io_lsu_single_ecc_error_incr; // @[dec_tlu_ctl.scala 931:45]
  assign csr_io_e4e5_int_clk = clock; // @[dec_tlu_ctl.scala 932:39]
  assign csr_io_lsu_i0_exc_r = _T_565 & _T_649; // @[dec_tlu_ctl.scala 933:39]
  assign csr_io_inst_acc_r = _T_672 & _T_647; // @[dec_tlu_ctl.scala 934:39]
  assign csr_io_inst_acc_second_r = io_dec_tlu_packet_r_icaf_second; // @[dec_tlu_ctl.scala 935:39]
  assign csr_io_take_nmi = int_exc_io_take_nmi; // @[dec_tlu_ctl.scala 936:39]
  assign csr_io_lsu_error_pkt_addr_r = io_lsu_error_pkt_r_bits_addr; // @[dec_tlu_ctl.scala 937:39]
  assign csr_io_exc_cause_r = int_exc_io_exc_cause_r; // @[dec_tlu_ctl.scala 938:39]
  assign csr_io_i0_valid_wb = int_exc_io_i0_valid_wb; // @[dec_tlu_ctl.scala 939:39]
  assign csr_io_interrupt_valid_r_d1 = int_exc_io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 941:39]
  assign csr_io_i0_exception_valid_r_d1 = int_exc_io_i0_exception_valid_r_d1; // @[dec_tlu_ctl.scala 943:39]
  assign csr_io_exc_cause_wb = int_exc_io_exc_cause_wb; // @[dec_tlu_ctl.scala 945:39]
  assign csr_io_nmi_lsu_store_type = _T_71 | _T_73; // @[dec_tlu_ctl.scala 946:39]
  assign csr_io_nmi_lsu_load_type = _T_63 | _T_65; // @[dec_tlu_ctl.scala 947:39]
  assign csr_io_tlu_i0_commit_cmt = _T_580 & _T_647; // @[dec_tlu_ctl.scala 948:39]
  assign csr_io_ebreak_r = _T_630 & _T_649; // @[dec_tlu_ctl.scala 949:39]
  assign csr_io_ecall_r = _T_636 & _T_649; // @[dec_tlu_ctl.scala 950:39]
  assign csr_io_illegal_r = _T_642 & _T_649; // @[dec_tlu_ctl.scala 951:39]
  assign csr_io_nmi_int_detected_f = nmi_int_detected_f; // @[dec_tlu_ctl.scala 953:39]
  assign csr_io_internal_dbg_halt_mode_f2 = internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 954:39]
  assign csr_io_ext_int_freeze = int_exc_io_ext_int_freeze; // @[dec_tlu_ctl.scala 807:32]
  assign csr_io_ic_perr_r = _T_660 & _T_661; // @[dec_tlu_ctl.scala 956:39]
  assign csr_io_iccm_sbecc_r = _T_667 & _T_661; // @[dec_tlu_ctl.scala 957:39]
  assign csr_io_ifu_miss_state_idle_f = ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 959:39]
  assign csr_io_lsu_idle_any_f = lsu_idle_any_f; // @[dec_tlu_ctl.scala 960:39]
  assign csr_io_dbg_tlu_halted_f = dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 961:39]
  assign csr_io_dbg_tlu_halted = _T_218 | _T_220; // @[dec_tlu_ctl.scala 962:39]
  assign csr_io_debug_halt_req_f = debug_halt_req_f; // @[dec_tlu_ctl.scala 963:51]
  assign csr_io_take_ext_int_start = int_exc_io_take_ext_int_start; // @[dec_tlu_ctl.scala 964:47]
  assign csr_io_trigger_hit_dmode_r_d1 = trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 965:43]
  assign csr_io_trigger_hit_r_d1 = int_exc_io_trigger_hit_r_d1; // @[dec_tlu_ctl.scala 966:43]
  assign csr_io_dcsr_single_step_done_f = dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 967:43]
  assign csr_io_ebreak_to_debug_mode_r_d1 = ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 968:39]
  assign csr_io_debug_halt_req = _T_168 & _T_656; // @[dec_tlu_ctl.scala 969:51]
  assign csr_io_allow_dbg_halt_csr_write = debug_mode_status & _T_131; // @[dec_tlu_ctl.scala 970:39]
  assign csr_io_internal_dbg_halt_mode_f = debug_mode_status; // @[dec_tlu_ctl.scala 971:39]
  assign csr_io_enter_debug_halt_req = _T_209 | ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 972:39]
  assign csr_io_internal_dbg_halt_mode = debug_halt_req_ns | _T_214; // @[dec_tlu_ctl.scala 973:39]
  assign csr_io_request_debug_mode_done = _T_237 & _T_190; // @[dec_tlu_ctl.scala 974:39]
  assign csr_io_request_debug_mode_r = _T_234 | _T_236; // @[dec_tlu_ctl.scala 975:39]
  assign csr_io_update_hit_bit_r = _T_461 & _T_468; // @[dec_tlu_ctl.scala 976:39]
  assign csr_io_take_timer_int = int_exc_io_take_timer_int; // @[dec_tlu_ctl.scala 977:39]
  assign csr_io_take_int_timer0_int = int_exc_io_take_int_timer0_int; // @[dec_tlu_ctl.scala 978:39]
  assign csr_io_take_int_timer1_int = int_exc_io_take_int_timer1_int; // @[dec_tlu_ctl.scala 979:39]
  assign csr_io_take_ext_int = int_exc_io_take_ext_int; // @[dec_tlu_ctl.scala 980:39]
  assign csr_io_tlu_flush_lower_r = int_exc_io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 981:39]
  assign csr_io_dec_tlu_br0_error_r = _T_611 & _T_587; // @[dec_tlu_ctl.scala 982:39]
  assign csr_io_dec_tlu_br0_start_error_r = _T_614 & _T_587; // @[dec_tlu_ctl.scala 983:39]
  assign csr_io_lsu_pmu_load_external_r = lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 984:39]
  assign csr_io_lsu_pmu_store_external_r = lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 985:39]
  assign csr_io_csr_pkt_csr_misa = csr_read_io_csr_pkt_csr_misa; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mvendorid = csr_read_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_marchid = csr_read_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mimpid = csr_read_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhartid = csr_read_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mstatus = csr_read_io_csr_pkt_csr_mstatus; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mtvec = csr_read_io_csr_pkt_csr_mtvec; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mip = csr_read_io_csr_pkt_csr_mip; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mie = csr_read_io_csr_pkt_csr_mie; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mcyclel = csr_read_io_csr_pkt_csr_mcyclel; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mcycleh = csr_read_io_csr_pkt_csr_mcycleh; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_minstretl = csr_read_io_csr_pkt_csr_minstretl; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_minstreth = csr_read_io_csr_pkt_csr_minstreth; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mscratch = csr_read_io_csr_pkt_csr_mscratch; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mepc = csr_read_io_csr_pkt_csr_mepc; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mcause = csr_read_io_csr_pkt_csr_mcause; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mscause = csr_read_io_csr_pkt_csr_mscause; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mtval = csr_read_io_csr_pkt_csr_mtval; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mrac = csr_read_io_csr_pkt_csr_mrac; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mdseac = csr_read_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_meihap = csr_read_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_meivt = csr_read_io_csr_pkt_csr_meivt; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_meipt = csr_read_io_csr_pkt_csr_meipt; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_meicurpl = csr_read_io_csr_pkt_csr_meicurpl; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_meicidpl = csr_read_io_csr_pkt_csr_meicidpl; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_dcsr = csr_read_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mcgc = csr_read_io_csr_pkt_csr_mcgc; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mfdc = csr_read_io_csr_pkt_csr_mfdc; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_dpc = csr_read_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mtsel = csr_read_io_csr_pkt_csr_mtsel; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mtdata1 = csr_read_io_csr_pkt_csr_mtdata1; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mtdata2 = csr_read_io_csr_pkt_csr_mtdata2; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc3 = csr_read_io_csr_pkt_csr_mhpmc3; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc4 = csr_read_io_csr_pkt_csr_mhpmc4; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc5 = csr_read_io_csr_pkt_csr_mhpmc5; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc6 = csr_read_io_csr_pkt_csr_mhpmc6; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc3h = csr_read_io_csr_pkt_csr_mhpmc3h; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc4h = csr_read_io_csr_pkt_csr_mhpmc4h; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc5h = csr_read_io_csr_pkt_csr_mhpmc5h; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpmc6h = csr_read_io_csr_pkt_csr_mhpmc6h; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpme3 = csr_read_io_csr_pkt_csr_mhpme3; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpme4 = csr_read_io_csr_pkt_csr_mhpme4; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpme5 = csr_read_io_csr_pkt_csr_mhpme5; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mhpme6 = csr_read_io_csr_pkt_csr_mhpme6; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mcountinhibit = csr_read_io_csr_pkt_csr_mcountinhibit; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mpmc = csr_read_io_csr_pkt_csr_mpmc; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_micect = csr_read_io_csr_pkt_csr_micect; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_miccmect = csr_read_io_csr_pkt_csr_miccmect; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mdccmect = csr_read_io_csr_pkt_csr_mdccmect; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mfdht = csr_read_io_csr_pkt_csr_mfdht; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_mfdhs = csr_read_io_csr_pkt_csr_mfdhs; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_dicawics = csr_read_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_dicad0h = csr_read_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_dicad0 = csr_read_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_csr_pkt_csr_dicad1 = csr_read_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_trigger_enabled = {_T_388,_T_387}; // @[dec_tlu_ctl.scala 986:45]
  assign int_timers_clock = clock;
  assign int_timers_reset = reset;
  assign int_timers_io_free_l2clk = io_free_l2clk; // @[dec_tlu_ctl.scala 285:65]
  assign int_timers_io_csr_wr_clk = clock; // @[dec_tlu_ctl.scala 321:52]
  assign int_timers_io_dec_csr_wen_r_mod = csr_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 287:49]
  assign int_timers_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 289:49]
  assign int_timers_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 290:49]
  assign int_timers_io_csr_mitctl0 = csr_read_io_csr_pkt_csr_mitctl0; // @[dec_tlu_ctl.scala 291:57]
  assign int_timers_io_csr_mitctl1 = csr_read_io_csr_pkt_csr_mitctl1; // @[dec_tlu_ctl.scala 292:57]
  assign int_timers_io_csr_mitb0 = csr_read_io_csr_pkt_csr_mitb0; // @[dec_tlu_ctl.scala 293:57]
  assign int_timers_io_csr_mitb1 = csr_read_io_csr_pkt_csr_mitb1; // @[dec_tlu_ctl.scala 294:57]
  assign int_timers_io_csr_mitcnt0 = csr_read_io_csr_pkt_csr_mitcnt0; // @[dec_tlu_ctl.scala 295:57]
  assign int_timers_io_csr_mitcnt1 = csr_read_io_csr_pkt_csr_mitcnt1; // @[dec_tlu_ctl.scala 296:57]
  assign int_timers_io_dec_pause_state = io_dec_pause_state; // @[dec_tlu_ctl.scala 297:49]
  assign int_timers_io_dec_tlu_pmu_fw_halted = pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 298:49]
  assign int_timers_io_internal_dbg_halt_timers = int_exc_io_internal_dbg_halt_timers; // @[dec_tlu_ctl.scala 299:47]
  assign csr_read_io_dec_csr_rdaddr_d = io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 1005:37]
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
  debug_mode_status = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  i_cpu_run_req_d1_raw = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  nmi_int_delayed = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  nmi_int_detected_f = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  int_timer0_int_hold_f = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  int_timer1_int_hold_f = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  i_cpu_halt_req_d1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  reset_detect = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  reset_detected = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  dec_pause_state_f = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  debug_halt_req_f = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  pmu_fw_halt_req_f = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  halt_taken_f = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  ifu_ic_error_start_f = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  debug_resume_req_f_raw = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  dcsr_single_step_running_f = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dcsr_single_step_done_f = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  internal_pmu_fw_halt_mode_f = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  ifu_iccm_rd_ecc_single_err_f = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  iccm_repair_state_d1 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  lsu_pmu_load_external_r = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  lsu_pmu_store_external_r = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  tlu_flush_lower_r_d1 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  _T_34 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  internal_dbg_halt_mode_f2 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  _T_35 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  nmi_lsu_load_type_f = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  nmi_lsu_store_type_f = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  mpc_debug_halt_req_sync_f = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  mpc_debug_run_req_sync_f = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  mpc_run_state_f = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  mpc_debug_run_ack_f = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  ebreak_to_debug_mode_r_d1 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  trigger_hit_dmode_r_d1 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  debug_brkpt_status_f = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  dbg_halt_req_held = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  lsu_idle_any_f = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  ifu_miss_state_idle_f = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  debug_halt_req_d1 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  dec_tlu_flush_noredir_r_d1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  dec_tlu_flush_pause_r_d1 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  dbg_tlu_halted_f = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  pmu_fw_tlu_halted_f = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  mpc_debug_halt_ack_f = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  dbg_run_state_f = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  _T_119 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  request_debug_mode_r_d1 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  request_debug_mode_done_f = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  _T_262 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  dec_tlu_wr_pause_r_d1 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  _T_488 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  _T_492 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  _T_496 = _RAND_56[0:0];
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
    debug_mode_status = 1'h0;
  end
  if (reset) begin
    i_cpu_run_req_d1_raw = 1'h0;
  end
  if (reset) begin
    nmi_int_delayed = 1'h0;
  end
  if (reset) begin
    nmi_int_detected_f = 1'h0;
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
    reset_detect = 1'h0;
  end
  if (reset) begin
    reset_detected = 1'h0;
  end
  if (reset) begin
    dec_pause_state_f = 1'h0;
  end
  if (reset) begin
    debug_halt_req_f = 1'h0;
  end
  if (reset) begin
    pmu_fw_halt_req_f = 1'h0;
  end
  if (reset) begin
    halt_taken_f = 1'h0;
  end
  if (reset) begin
    ifu_ic_error_start_f = 1'h0;
  end
  if (reset) begin
    debug_resume_req_f_raw = 1'h0;
  end
  if (reset) begin
    dcsr_single_step_running_f = 1'h0;
  end
  if (reset) begin
    dcsr_single_step_done_f = 1'h0;
  end
  if (reset) begin
    internal_pmu_fw_halt_mode_f = 1'h0;
  end
  if (reset) begin
    ifu_iccm_rd_ecc_single_err_f = 1'h0;
  end
  if (reset) begin
    iccm_repair_state_d1 = 1'h0;
  end
  if (reset) begin
    lsu_pmu_load_external_r = 1'h0;
  end
  if (reset) begin
    lsu_pmu_store_external_r = 1'h0;
  end
  if (reset) begin
    tlu_flush_lower_r_d1 = 1'h0;
  end
  if (reset) begin
    _T_34 = 1'h0;
  end
  if (reset) begin
    internal_dbg_halt_mode_f2 = 1'h0;
  end
  if (reset) begin
    _T_35 = 1'h0;
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
    mpc_debug_run_ack_f = 1'h0;
  end
  if (reset) begin
    ebreak_to_debug_mode_r_d1 = 1'h0;
  end
  if (reset) begin
    trigger_hit_dmode_r_d1 = 1'h0;
  end
  if (reset) begin
    debug_brkpt_status_f = 1'h0;
  end
  if (reset) begin
    dbg_halt_req_held = 1'h0;
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
    dbg_tlu_halted_f = 1'h0;
  end
  if (reset) begin
    pmu_fw_tlu_halted_f = 1'h0;
  end
  if (reset) begin
    mpc_debug_halt_ack_f = 1'h0;
  end
  if (reset) begin
    dbg_run_state_f = 1'h0;
  end
  if (reset) begin
    _T_119 = 1'h0;
  end
  if (reset) begin
    request_debug_mode_r_d1 = 1'h0;
  end
  if (reset) begin
    request_debug_mode_done_f = 1'h0;
  end
  if (reset) begin
    _T_262 = 1'h0;
  end
  if (reset) begin
    dec_tlu_wr_pause_r_d1 = 1'h0;
  end
  if (reset) begin
    _T_488 = 1'h0;
  end
  if (reset) begin
    _T_492 = 1'h0;
  end
  if (reset) begin
    _T_496 = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dbg_halt_state_f <= 1'h0;
    end else if (_T_111) begin
      dbg_halt_state_f <= dbg_halt_state_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mpc_halt_state_f <= 1'h0;
    end else if (_T_95) begin
      mpc_halt_state_f <= mpc_halt_state_ns;
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
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      debug_mode_status <= 1'h0;
    end else begin
      debug_mode_status <= debug_halt_req_ns | _T_214;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      i_cpu_run_req_d1_raw <= 1'h0;
    end else if (_T_483) begin
      i_cpu_run_req_d1_raw <= i_cpu_run_req_sync_qual;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      nmi_int_delayed <= 1'h0;
    end else if (_T_37) begin
      nmi_int_delayed <= nmi_int_sync;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      nmi_int_detected_f <= 1'h0;
    end else if (_T_40) begin
      nmi_int_detected_f <= nmi_int_detected;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      int_timer0_int_hold_f <= 1'h0;
    end else if (_T_510) begin
      int_timer0_int_hold_f <= int_timer0_int_hold;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      int_timer1_int_hold_f <= 1'h0;
    end else if (_T_514) begin
      int_timer1_int_hold_f <= int_timer1_int_hold;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      i_cpu_halt_req_d1 <= 1'h0;
    end else if (_T_480) begin
      i_cpu_halt_req_d1 <= i_cpu_halt_req_sync_qual;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      reset_detect <= 1'h0;
    end else begin
      reset_detect <= _T_80 | reset_detect;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      reset_detected <= 1'h0;
    end else if (_T_83) begin
      reset_detected <= reset_detect;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dec_pause_state_f <= 1'h0;
    end else if (_T_287) begin
      dec_pause_state_f <= io_dec_pause_state;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      debug_halt_req_f <= 1'h0;
    end else if (_T_265) begin
      debug_halt_req_f <= debug_halt_req_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      pmu_fw_halt_req_f <= 1'h0;
    end else if (_T_502) begin
      pmu_fw_halt_req_f <= pmu_fw_halt_req_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      halt_taken_f <= 1'h0;
    end else if (_T_245) begin
      halt_taken_f <= halt_taken;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      ifu_ic_error_start_f <= 1'h0;
    end else if (_T_24) begin
      ifu_ic_error_start_f <= io_tlu_mem_ifu_ic_error_start;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      debug_resume_req_f_raw <= 1'h0;
    end else if (_T_269) begin
      debug_resume_req_f_raw <= debug_resume_req;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dcsr_single_step_running_f <= 1'h0;
    end else if (_T_299) begin
      dcsr_single_step_running_f <= dcsr_single_step_running;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dcsr_single_step_done_f <= 1'h0;
    end else if (_T_277) begin
      dcsr_single_step_done_f <= dcsr_single_step_done;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      internal_pmu_fw_halt_mode_f <= 1'h0;
    end else if (_T_498) begin
      internal_pmu_fw_halt_mode_f <= internal_pmu_fw_halt_mode;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      ifu_iccm_rd_ecc_single_err_f <= 1'h0;
    end else if (_T_27) begin
      ifu_iccm_rd_ecc_single_err_f <= io_tlu_mem_ifu_iccm_rd_ecc_single_err;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      iccm_repair_state_d1 <= 1'h0;
    end else if (_T_30) begin
      iccm_repair_state_d1 <= iccm_repair_state_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      lsu_pmu_load_external_r <= 1'h0;
    end else begin
      lsu_pmu_load_external_r <= io_lsu_tlu_lsu_pmu_load_external_m;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      lsu_pmu_store_external_r <= 1'h0;
    end else begin
      lsu_pmu_store_external_r <= io_lsu_tlu_lsu_pmu_store_external_m;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      tlu_flush_lower_r_d1 <= 1'h0;
    end else begin
      tlu_flush_lower_r_d1 <= int_exc_io_tlu_flush_lower_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_34 <= 1'h0;
    end else begin
      _T_34 <= _T_585 | i0_trigger_hit_raw_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      internal_dbg_halt_mode_f2 <= 1'h0;
    end else begin
      internal_dbg_halt_mode_f2 <= debug_mode_status;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_35 <= 1'h0;
    end else begin
      _T_35 <= csr_io_force_halt;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      nmi_lsu_load_type_f <= 1'h0;
    end else if (_T_43) begin
      nmi_lsu_load_type_f <= nmi_lsu_load_type;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      nmi_lsu_store_type_f <= 1'h0;
    end else if (_T_46) begin
      nmi_lsu_store_type_f <= nmi_lsu_store_type;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mpc_debug_halt_req_sync_f <= 1'h0;
    end else if (_T_88) begin
      mpc_debug_halt_req_sync_f <= mpc_debug_halt_req_sync;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mpc_debug_run_req_sync_f <= 1'h0;
    end else if (_T_91) begin
      mpc_debug_run_req_sync_f <= mpc_debug_run_req_sync;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mpc_run_state_f <= 1'h0;
    end else if (_T_98) begin
      mpc_run_state_f <= mpc_run_state_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mpc_debug_run_ack_f <= 1'h0;
    end else if (_T_107) begin
      mpc_debug_run_ack_f <= mpc_debug_run_ack_ns;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ebreak_to_debug_mode_r_d1 <= 1'h0;
    end else begin
      ebreak_to_debug_mode_r_d1 <= _T_680 & _T_649;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      trigger_hit_dmode_r_d1 <= 1'h0;
    end else if (_T_273) begin
      trigger_hit_dmode_r_d1 <= trigger_hit_dmode_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      debug_brkpt_status_f <= 1'h0;
    end else if (_T_101) begin
      debug_brkpt_status_f <= debug_brkpt_status_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dbg_halt_req_held <= 1'h0;
    end else if (_T_307) begin
      dbg_halt_req_held <= dbg_halt_req_held_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      lsu_idle_any_f <= 1'h0;
    end else if (_T_249) begin
      lsu_idle_any_f <= io_lsu_idle_any;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      ifu_miss_state_idle_f <= 1'h0;
    end else if (_T_253) begin
      ifu_miss_state_idle_f <= io_tlu_mem_ifu_miss_state_idle;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      debug_halt_req_d1 <= 1'h0;
    end else if (_T_281) begin
      debug_halt_req_d1 <= debug_halt_req;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dec_tlu_flush_noredir_r_d1 <= 1'h0;
    end else if (_T_241) begin
      dec_tlu_flush_noredir_r_d1 <= io_tlu_ifc_dec_tlu_flush_noredir_wb;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dec_tlu_flush_pause_r_d1 <= 1'h0;
    end else if (_T_303) begin
      dec_tlu_flush_pause_r_d1 <= io_dec_tlu_flush_pause_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dbg_tlu_halted_f <= 1'h0;
    end else if (_T_257) begin
      dbg_tlu_halted_f <= dbg_tlu_halted;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      pmu_fw_tlu_halted_f <= 1'h0;
    end else if (_T_506) begin
      pmu_fw_tlu_halted_f <= pmu_fw_tlu_halted;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      mpc_debug_halt_ack_f <= 1'h0;
    end else if (_T_104) begin
      mpc_debug_halt_ack_f <= mpc_debug_halt_ack_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dbg_run_state_f <= 1'h0;
    end else if (_T_114) begin
      dbg_run_state_f <= dbg_run_state_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_119 <= 1'h0;
    end else if (_T_118) begin
      _T_119 <= _T_1;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      request_debug_mode_r_d1 <= 1'h0;
    end else if (_T_291) begin
      request_debug_mode_r_d1 <= request_debug_mode_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      request_debug_mode_done_f <= 1'h0;
    end else if (_T_295) begin
      request_debug_mode_done_f <= request_debug_mode_done;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_262 <= 1'h0;
    end else if (_T_261) begin
      _T_262 <= resume_ack_ns;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      dec_tlu_wr_pause_r_d1 <= 1'h0;
    end else if (_T_284) begin
      dec_tlu_wr_pause_r_d1 <= io_dec_tlu_wr_pause_r;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_488 <= 1'h0;
    end else if (_T_487) begin
      _T_488 <= cpu_halt_status;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_492 <= 1'h0;
    end else if (_T_491) begin
      _T_492 <= cpu_halt_ack;
    end
  end
  always @(posedge io_free_l2clk or posedge reset) begin
    if (reset) begin
      _T_496 <= 1'h0;
    end else if (_T_495) begin
      _T_496 <= cpu_run_ack;
    end
  end
endmodule
