module dec_ib_ctl(
  input         io_ifu_ib_ifu_i0_icaf,
  input  [1:0]  io_ifu_ib_ifu_i0_icaf_type,
  input         io_ifu_ib_ifu_i0_icaf_f1,
  input         io_ifu_ib_ifu_i0_dbecc,
  input  [7:0]  io_ifu_ib_ifu_i0_bp_index,
  input  [7:0]  io_ifu_ib_ifu_i0_bp_fghr,
  input  [4:0]  io_ifu_ib_ifu_i0_bp_btag,
  input         io_ifu_ib_ifu_i0_valid,
  input  [31:0] io_ifu_ib_ifu_i0_instr,
  input  [30:0] io_ifu_ib_ifu_i0_pc,
  input         io_ifu_ib_ifu_i0_pc4,
  input         io_ifu_ib_i0_brp_valid,
  input  [11:0] io_ifu_ib_i0_brp_bits_toffset,
  input  [1:0]  io_ifu_ib_i0_brp_bits_hist,
  input         io_ifu_ib_i0_brp_bits_br_error,
  input         io_ifu_ib_i0_brp_bits_br_start_error,
  input  [30:0] io_ifu_ib_i0_brp_bits_prett,
  input         io_ifu_ib_i0_brp_bits_way,
  input         io_ifu_ib_i0_brp_bits_ret,
  output [30:0] io_ib_exu_dec_i0_pc_d,
  output        io_ib_exu_dec_debug_wdata_rs1_d,
  input         io_dbg_ib_dbg_cmd_valid,
  input         io_dbg_ib_dbg_cmd_write,
  input  [1:0]  io_dbg_ib_dbg_cmd_type,
  input  [31:0] io_dbg_ib_dbg_cmd_addr,
  output        io_dec_ib0_valid_d,
  output [1:0]  io_dec_i0_icaf_type_d,
  output [31:0] io_dec_i0_instr_d,
  output        io_dec_i0_pc4_d,
  output        io_dec_i0_brp_valid,
  output [11:0] io_dec_i0_brp_bits_toffset,
  output [1:0]  io_dec_i0_brp_bits_hist,
  output        io_dec_i0_brp_bits_br_error,
  output        io_dec_i0_brp_bits_br_start_error,
  output [30:0] io_dec_i0_brp_bits_prett,
  output        io_dec_i0_brp_bits_way,
  output        io_dec_i0_brp_bits_ret,
  output [7:0]  io_dec_i0_bp_index,
  output [7:0]  io_dec_i0_bp_fghr,
  output [4:0]  io_dec_i0_bp_btag,
  output        io_dec_i0_icaf_d,
  output        io_dec_i0_icaf_f1_d,
  output        io_dec_i0_dbecc_d,
  output        io_dec_debug_fence_d
);
  wire  _T = io_dbg_ib_dbg_cmd_type != 2'h2; // @[dec_ib_ctl.scala 52:74]
  wire  debug_valid = io_dbg_ib_dbg_cmd_valid & _T; // @[dec_ib_ctl.scala 52:48]
  wire  _T_1 = ~io_dbg_ib_dbg_cmd_write; // @[dec_ib_ctl.scala 53:38]
  wire  debug_read = debug_valid & _T_1; // @[dec_ib_ctl.scala 53:36]
  wire  debug_write = debug_valid & io_dbg_ib_dbg_cmd_write; // @[dec_ib_ctl.scala 54:36]
  wire  _T_2 = io_dbg_ib_dbg_cmd_type == 2'h0; // @[dec_ib_ctl.scala 56:62]
  wire  debug_read_gpr = debug_read & _T_2; // @[dec_ib_ctl.scala 56:37]
  wire  debug_write_gpr = debug_write & _T_2; // @[dec_ib_ctl.scala 57:37]
  wire  _T_4 = io_dbg_ib_dbg_cmd_type == 2'h1; // @[dec_ib_ctl.scala 58:62]
  wire  debug_read_csr = debug_read & _T_4; // @[dec_ib_ctl.scala 58:37]
  wire  debug_write_csr = debug_write & _T_4; // @[dec_ib_ctl.scala 59:37]
  wire [4:0] dreg = io_dbg_ib_dbg_cmd_addr[4:0]; // @[dec_ib_ctl.scala 61:47]
  wire [11:0] dcsr = io_dbg_ib_dbg_cmd_addr[11:0]; // @[dec_ib_ctl.scala 62:47]
  wire [31:0] _T_9 = {12'h0,dreg,15'h6033}; // @[Cat.scala 29:58]
  wire [31:0] _T_12 = {20'h6,dreg,7'h33}; // @[Cat.scala 29:58]
  wire [31:0] _T_14 = {dcsr,20'h2073}; // @[Cat.scala 29:58]
  wire [31:0] _T_16 = {dcsr,20'h1073}; // @[Cat.scala 29:58]
  wire [31:0] _T_17 = debug_read_gpr ? _T_9 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_18 = debug_write_gpr ? _T_12 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_19 = debug_read_csr ? _T_14 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_20 = debug_write_csr ? _T_16 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_21 = _T_17 | _T_18; // @[Mux.scala 27:72]
  wire [31:0] _T_22 = _T_21 | _T_19; // @[Mux.scala 27:72]
  wire [31:0] ib0_debug_in = _T_22 | _T_20; // @[Mux.scala 27:72]
  wire  _T_25 = dcsr == 12'h7c4; // @[dec_ib_ctl.scala 75:51]
  assign io_ib_exu_dec_i0_pc_d = io_ifu_ib_ifu_i0_pc; // @[dec_ib_ctl.scala 32:31]
  assign io_ib_exu_dec_debug_wdata_rs1_d = debug_write_gpr | debug_write_csr; // @[dec_ib_ctl.scala 72:35]
  assign io_dec_ib0_valid_d = io_ifu_ib_ifu_i0_valid | debug_valid; // @[dec_ib_ctl.scala 77:22]
  assign io_dec_i0_icaf_type_d = io_ifu_ib_ifu_i0_icaf_type; // @[dec_ib_ctl.scala 34:31]
  assign io_dec_i0_instr_d = debug_valid ? ib0_debug_in : io_ifu_ib_ifu_i0_instr; // @[dec_ib_ctl.scala 78:22]
  assign io_dec_i0_pc4_d = io_ifu_ib_ifu_i0_pc4; // @[dec_ib_ctl.scala 33:31]
  assign io_dec_i0_brp_valid = io_ifu_ib_i0_brp_valid; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_toffset = io_ifu_ib_i0_brp_bits_toffset; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_hist = io_ifu_ib_i0_brp_bits_hist; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_br_error = io_ifu_ib_i0_brp_bits_br_error; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_br_start_error = io_ifu_ib_i0_brp_bits_br_start_error; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_prett = io_ifu_ib_i0_brp_bits_prett; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_way = io_ifu_ib_i0_brp_bits_way; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_brp_bits_ret = io_ifu_ib_i0_brp_bits_ret; // @[dec_ib_ctl.scala 35:31]
  assign io_dec_i0_bp_index = io_ifu_ib_ifu_i0_bp_index; // @[dec_ib_ctl.scala 36:31]
  assign io_dec_i0_bp_fghr = io_ifu_ib_ifu_i0_bp_fghr; // @[dec_ib_ctl.scala 37:31]
  assign io_dec_i0_bp_btag = io_ifu_ib_ifu_i0_bp_btag; // @[dec_ib_ctl.scala 38:31]
  assign io_dec_i0_icaf_d = io_ifu_ib_ifu_i0_icaf; // @[dec_ib_ctl.scala 31:31]
  assign io_dec_i0_icaf_f1_d = io_ifu_ib_ifu_i0_icaf_f1; // @[dec_ib_ctl.scala 29:31]
  assign io_dec_i0_dbecc_d = io_ifu_ib_ifu_i0_dbecc; // @[dec_ib_ctl.scala 30:31]
  assign io_dec_debug_fence_d = debug_write_csr & _T_25; // @[dec_ib_ctl.scala 75:24]
endmodule
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
module dec_dec_ctl(
  input  [31:0] io_ins,
  output        io_out_alu,
  output        io_out_rs1,
  output        io_out_rs2,
  output        io_out_imm12,
  output        io_out_rd,
  output        io_out_shimm5,
  output        io_out_imm20,
  output        io_out_pc,
  output        io_out_load,
  output        io_out_store,
  output        io_out_lsu,
  output        io_out_add,
  output        io_out_sub,
  output        io_out_land,
  output        io_out_lor,
  output        io_out_lxor,
  output        io_out_sll,
  output        io_out_sra,
  output        io_out_srl,
  output        io_out_slt,
  output        io_out_unsign,
  output        io_out_condbr,
  output        io_out_beq,
  output        io_out_bne,
  output        io_out_bge,
  output        io_out_blt,
  output        io_out_jal,
  output        io_out_by,
  output        io_out_half,
  output        io_out_word,
  output        io_out_csr_read,
  output        io_out_csr_clr,
  output        io_out_csr_set,
  output        io_out_csr_write,
  output        io_out_csr_imm,
  output        io_out_presync,
  output        io_out_postsync,
  output        io_out_ebreak,
  output        io_out_ecall,
  output        io_out_mret,
  output        io_out_mul,
  output        io_out_rs1_sign,
  output        io_out_rs2_sign,
  output        io_out_low,
  output        io_out_div,
  output        io_out_rem,
  output        io_out_fence,
  output        io_out_fence_i,
  output        io_out_pm_alu,
  output        io_out_legal
);
  wire  _T_2 = io_ins[2] | io_ins[6]; // @[dec_dec_ctl.scala 20:27]
  wire  _T_4 = ~io_ins[25]; // @[dec_dec_ctl.scala 20:42]
  wire  _T_6 = _T_4 & io_ins[4]; // @[dec_dec_ctl.scala 20:53]
  wire  _T_7 = _T_2 | _T_6; // @[dec_dec_ctl.scala 20:39]
  wire  _T_9 = ~io_ins[5]; // @[dec_dec_ctl.scala 20:68]
  wire  _T_11 = _T_9 & io_ins[4]; // @[dec_dec_ctl.scala 20:78]
  wire  _T_14 = ~io_ins[14]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_16 = ~io_ins[13]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_18 = ~io_ins[2]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_19 = _T_14 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_20 = _T_19 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_26 = _T_16 & io_ins[11]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_27 = _T_26 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_28 = _T_20 | _T_27; // @[dec_dec_ctl.scala 21:43]
  wire  _T_33 = io_ins[19] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_34 = _T_33 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_35 = _T_28 | _T_34; // @[dec_dec_ctl.scala 21:70]
  wire  _T_41 = _T_16 & io_ins[10]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_42 = _T_41 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_43 = _T_35 | _T_42; // @[dec_dec_ctl.scala 22:29]
  wire  _T_48 = io_ins[18] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_49 = _T_48 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_50 = _T_43 | _T_49; // @[dec_dec_ctl.scala 22:56]
  wire  _T_56 = _T_16 & io_ins[9]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_57 = _T_56 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_58 = _T_50 | _T_57; // @[dec_dec_ctl.scala 23:29]
  wire  _T_63 = io_ins[17] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_64 = _T_63 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_65 = _T_58 | _T_64; // @[dec_dec_ctl.scala 23:55]
  wire  _T_71 = _T_16 & io_ins[8]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_72 = _T_71 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_73 = _T_65 | _T_72; // @[dec_dec_ctl.scala 24:29]
  wire  _T_78 = io_ins[16] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_79 = _T_78 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_80 = _T_73 | _T_79; // @[dec_dec_ctl.scala 24:55]
  wire  _T_86 = _T_16 & io_ins[7]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_87 = _T_86 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_88 = _T_80 | _T_87; // @[dec_dec_ctl.scala 25:29]
  wire  _T_93 = io_ins[15] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_94 = _T_93 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_95 = _T_88 | _T_94; // @[dec_dec_ctl.scala 25:55]
  wire  _T_97 = ~io_ins[4]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_99 = ~io_ins[3]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_100 = _T_97 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_101 = _T_95 | _T_100; // @[dec_dec_ctl.scala 26:29]
  wire  _T_103 = ~io_ins[6]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_106 = _T_103 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_113 = io_ins[5] & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_114 = _T_113 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_120 = _T_103 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_121 = _T_120 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_129 = _T_100 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_136 = io_ins[13] & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_137 = _T_136 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_138 = _T_137 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_139 = _T_129 | _T_138; // @[dec_dec_ctl.scala 28:42]
  wire  _T_143 = ~io_ins[12]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_146 = _T_16 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_147 = _T_146 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_148 = _T_147 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_149 = _T_139 | _T_148; // @[dec_dec_ctl.scala 28:70]
  wire  _T_157 = _T_143 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_158 = _T_157 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_159 = _T_158 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_165 = _T_9 & _T_18; // @[dec_dec_ctl.scala 30:28]
  wire  _T_168 = io_ins[5] & io_ins[2]; // @[dec_dec_ctl.scala 30:55]
  wire  _T_169 = _T_165 | _T_168; // @[dec_dec_ctl.scala 30:42]
  wire  _T_180 = _T_16 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_181 = _T_180 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_182 = _T_181 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_186 = io_ins[5] & io_ins[3]; // @[dec_dec_ctl.scala 32:29]
  wire  _T_189 = io_ins[4] & io_ins[2]; // @[dec_dec_ctl.scala 32:53]
  wire  _T_195 = _T_9 & _T_99; // @[dec_dec_ctl.scala 33:28]
  wire  _T_197 = _T_195 & io_ins[2]; // @[dec_dec_ctl.scala 33:41]
  wire  _T_208 = _T_9 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_223 = _T_103 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_235 = _T_19 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_236 = _T_235 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_237 = _T_236 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_245 = _T_237 | _T_197; // @[dec_dec_ctl.scala 37:49]
  wire  _T_247 = ~io_ins[30]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_261 = _T_247 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_262 = _T_261 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_263 = _T_262 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_264 = _T_263 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_265 = _T_264 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_266 = _T_265 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_267 = _T_266 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_278 = io_ins[30] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_279 = _T_278 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_280 = _T_279 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_281 = _T_280 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_282 = _T_281 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_293 = _T_4 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_294 = _T_293 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_295 = _T_294 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_296 = _T_295 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_297 = _T_296 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_298 = _T_282 | _T_297; // @[dec_dec_ctl.scala 39:49]
  wire  _T_307 = _T_14 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_308 = _T_307 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_309 = _T_308 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_310 = _T_309 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_311 = _T_298 | _T_310; // @[dec_dec_ctl.scala 39:85]
  wire  _T_317 = io_ins[6] & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_318 = _T_317 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_327 = io_ins[14] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_328 = _T_327 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_329 = _T_328 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_330 = _T_329 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_340 = _T_4 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_341 = _T_340 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_342 = _T_341 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_343 = _T_342 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_344 = _T_343 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_349 = _T_103 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_362 = _T_341 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_363 = _T_362 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_364 = _T_363 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_365 = _T_349 | _T_364; // @[dec_dec_ctl.scala 42:37]
  wire  _T_369 = io_ins[5] & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_370 = _T_369 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_371 = _T_365 | _T_370; // @[dec_dec_ctl.scala 42:74]
  wire  _T_381 = _T_371 | _T_148; // @[dec_dec_ctl.scala 43:26]
  wire  _T_391 = _T_327 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_392 = _T_391 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_393 = _T_392 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_406 = _T_340 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_407 = _T_406 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_408 = _T_407 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_409 = _T_408 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_420 = io_ins[14] & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_421 = _T_420 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_422 = _T_421 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_423 = _T_422 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_424 = _T_423 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_439 = _T_293 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_440 = _T_439 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_441 = _T_440 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_442 = _T_441 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_453 = io_ins[30] & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_454 = _T_453 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_455 = _T_454 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_456 = _T_455 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_472 = _T_261 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_473 = _T_472 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_474 = _T_473 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_475 = _T_474 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_476 = _T_475 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_515 = _T_307 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_516 = _T_515 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_517 = _T_516 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_524 = io_ins[13] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_525 = _T_524 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_526 = _T_525 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_527 = _T_517 | _T_526; // @[dec_dec_ctl.scala 50:51]
  wire  _T_533 = io_ins[14] & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_534 = _T_533 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_535 = _T_527 | _T_534; // @[dec_dec_ctl.scala 50:79]
  wire  _T_548 = _T_294 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_549 = _T_548 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_550 = _T_549 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_551 = _T_535 | _T_550; // @[dec_dec_ctl.scala 51:29]
  wire  _T_560 = io_ins[25] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_561 = _T_560 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_562 = _T_561 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_563 = _T_562 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_564 = _T_563 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_582 = _T_14 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_583 = _T_582 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_584 = _T_583 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_594 = _T_14 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_595 = _T_594 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_596 = _T_595 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_605 = io_ins[14] & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_606 = _T_605 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_607 = _T_606 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_617 = io_ins[14] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_618 = _T_617 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_619 = _T_618 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_635 = _T_146 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_636 = _T_635 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_645 = io_ins[12] & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_646 = _T_645 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_653 = io_ins[13] & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_659 = _T_524 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_663 = io_ins[7] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_664 = _T_663 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_665 = _T_659 | _T_664; // @[dec_dec_ctl.scala 62:44]
  wire  _T_669 = io_ins[8] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_670 = _T_669 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_671 = _T_665 | _T_670; // @[dec_dec_ctl.scala 62:67]
  wire  _T_675 = io_ins[9] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_676 = _T_675 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_677 = _T_671 | _T_676; // @[dec_dec_ctl.scala 63:26]
  wire  _T_681 = io_ins[10] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_682 = _T_681 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_683 = _T_677 | _T_682; // @[dec_dec_ctl.scala 63:49]
  wire  _T_687 = io_ins[11] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_688 = _T_687 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_696 = _T_93 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_697 = _T_696 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_698 = _T_697 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_705 = _T_78 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_706 = _T_705 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_707 = _T_706 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_708 = _T_698 | _T_707; // @[dec_dec_ctl.scala 65:49]
  wire  _T_715 = _T_63 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_716 = _T_715 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_717 = _T_716 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_718 = _T_708 | _T_717; // @[dec_dec_ctl.scala 65:79]
  wire  _T_725 = _T_48 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_726 = _T_725 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_727 = _T_726 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_728 = _T_718 | _T_727; // @[dec_dec_ctl.scala 66:33]
  wire  _T_735 = _T_33 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_736 = _T_735 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_737 = _T_736 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_745 = _T_180 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_753 = _T_420 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_754 = _T_753 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_759 = io_ins[15] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_760 = _T_759 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_761 = _T_760 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_762 = _T_754 | _T_761; // @[dec_dec_ctl.scala 69:47]
  wire  _T_767 = io_ins[16] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_768 = _T_767 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_769 = _T_768 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_770 = _T_762 | _T_769; // @[dec_dec_ctl.scala 69:74]
  wire  _T_775 = io_ins[17] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_776 = _T_775 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_777 = _T_776 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_778 = _T_770 | _T_777; // @[dec_dec_ctl.scala 70:30]
  wire  _T_783 = io_ins[18] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_784 = _T_783 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_785 = _T_784 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_786 = _T_778 | _T_785; // @[dec_dec_ctl.scala 70:57]
  wire  _T_791 = io_ins[19] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_792 = _T_791 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_793 = _T_792 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_800 = io_ins[15] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_801 = _T_800 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_802 = _T_801 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_808 = io_ins[16] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_809 = _T_808 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_810 = _T_809 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_811 = _T_802 | _T_810; // @[dec_dec_ctl.scala 72:47]
  wire  _T_817 = io_ins[17] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_818 = _T_817 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_819 = _T_818 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_820 = _T_811 | _T_819; // @[dec_dec_ctl.scala 72:75]
  wire  _T_826 = io_ins[18] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_827 = _T_826 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_828 = _T_827 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_829 = _T_820 | _T_828; // @[dec_dec_ctl.scala 73:31]
  wire  _T_835 = io_ins[19] & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_836 = _T_835 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_837 = _T_836 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_840 = ~io_ins[22]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_848 = _T_840 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_849 = _T_848 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_850 = _T_849 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_851 = _T_850 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_854 = ~io_ins[21]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_856 = ~io_ins[20]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_863 = _T_854 & _T_856; // @[dec_dec_ctl.scala 17:17]
  wire  _T_864 = _T_863 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_865 = _T_864 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_866 = _T_865 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_875 = io_ins[29] & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_876 = _T_875 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_877 = _T_876 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_888 = io_ins[25] & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_889 = _T_888 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_890 = _T_889 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_891 = _T_890 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_906 = _T_888 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_907 = _T_906 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_908 = _T_907 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_909 = _T_908 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_910 = _T_909 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_911 = _T_910 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_924 = _T_888 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_925 = _T_924 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_926 = _T_925 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_927 = _T_926 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_928 = _T_927 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_960 = _T_924 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_961 = _T_960 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_962 = _T_961 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_972 = _T_560 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_973 = _T_972 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_984 = _T_560 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_985 = _T_984 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_986 = _T_985 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_991 = _T_9 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_996 = io_ins[12] & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_997 = _T_996 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1005 = io_ins[28] & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1006 = _T_1005 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1007 = _T_1006 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1008 = _T_1007 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1012 = _T_1008 | _T_189; // @[dec_dec_ctl.scala 87:51]
  wire  _T_1018 = _T_4 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1019 = _T_1018 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1020 = _T_1012 | _T_1019; // @[dec_dec_ctl.scala 87:72]
  wire  _T_1036 = _T_86 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1037 = _T_1036 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1038 = _T_991 | _T_1037; // @[dec_dec_ctl.scala 89:41]
  wire  _T_1045 = _T_71 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1046 = _T_1045 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1047 = _T_1038 | _T_1046; // @[dec_dec_ctl.scala 89:68]
  wire  _T_1054 = _T_56 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1055 = _T_1054 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1056 = _T_1047 | _T_1055; // @[dec_dec_ctl.scala 90:30]
  wire  _T_1063 = _T_41 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1064 = _T_1063 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1065 = _T_1056 | _T_1064; // @[dec_dec_ctl.scala 90:57]
  wire  _T_1072 = _T_26 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1073 = _T_1072 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1074 = _T_1065 | _T_1073; // @[dec_dec_ctl.scala 91:31]
  wire  _T_1080 = _T_93 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1081 = _T_1080 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1082 = _T_1074 | _T_1081; // @[dec_dec_ctl.scala 91:59]
  wire  _T_1088 = _T_78 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1089 = _T_1088 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1090 = _T_1082 | _T_1089; // @[dec_dec_ctl.scala 92:30]
  wire  _T_1096 = _T_63 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1097 = _T_1096 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1098 = _T_1090 | _T_1097; // @[dec_dec_ctl.scala 92:57]
  wire  _T_1104 = _T_48 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1105 = _T_1104 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1106 = _T_1098 | _T_1105; // @[dec_dec_ctl.scala 93:30]
  wire  _T_1112 = _T_33 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1113 = _T_1112 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1129 = _T_840 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1130 = _T_1129 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1131 = _T_1130 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1132 = _T_1131 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1133 = _T_997 | _T_1132; // @[dec_dec_ctl.scala 95:45]
  wire  _T_1142 = _T_1133 | _T_1037; // @[dec_dec_ctl.scala 95:78]
  wire  _T_1151 = _T_1142 | _T_1046; // @[dec_dec_ctl.scala 96:30]
  wire  _T_1160 = _T_1151 | _T_1055; // @[dec_dec_ctl.scala 96:57]
  wire  _T_1169 = _T_1160 | _T_1064; // @[dec_dec_ctl.scala 97:30]
  wire  _T_1178 = _T_1169 | _T_1073; // @[dec_dec_ctl.scala 97:58]
  wire  _T_1186 = _T_1178 | _T_1081; // @[dec_dec_ctl.scala 98:31]
  wire  _T_1194 = _T_1186 | _T_1089; // @[dec_dec_ctl.scala 98:58]
  wire  _T_1202 = _T_1194 | _T_1097; // @[dec_dec_ctl.scala 99:30]
  wire  _T_1210 = _T_1202 | _T_1105; // @[dec_dec_ctl.scala 99:57]
  wire  _T_1220 = ~io_ins[31]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1226 = ~io_ins[27]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1228 = ~io_ins[26]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1232 = ~io_ins[24]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1234 = ~io_ins[23]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1241 = ~io_ins[19]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1243 = ~io_ins[18]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1245 = ~io_ins[17]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1247 = ~io_ins[16]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1249 = ~io_ins[15]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1253 = ~io_ins[11]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1255 = ~io_ins[10]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1257 = ~io_ins[9]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1259 = ~io_ins[8]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1261 = ~io_ins[7]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1271 = _T_1220 & _T_247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1272 = _T_1271 & io_ins[29]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1273 = _T_1272 & io_ins[28]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1274 = _T_1273 & _T_1226; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1275 = _T_1274 & _T_1228; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1276 = _T_1275 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1277 = _T_1276 & _T_1232; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1278 = _T_1277 & _T_1234; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1279 = _T_1278 & _T_840; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1280 = _T_1279 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1281 = _T_1280 & _T_856; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1282 = _T_1281 & _T_1241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1283 = _T_1282 & _T_1243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1284 = _T_1283 & _T_1245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1285 = _T_1284 & _T_1247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1286 = _T_1285 & _T_1249; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1287 = _T_1286 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1288 = _T_1287 & _T_1253; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1289 = _T_1288 & _T_1255; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1290 = _T_1289 & _T_1257; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1291 = _T_1290 & _T_1259; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1292 = _T_1291 & _T_1261; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1293 = _T_1292 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1294 = _T_1293 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1295 = _T_1294 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1296 = _T_1295 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1297 = _T_1296 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1298 = _T_1297 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1299 = _T_1298 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1305 = ~io_ins[29]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1353 = _T_1271 & _T_1305; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1354 = _T_1353 & io_ins[28]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1355 = _T_1354 & _T_1226; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1356 = _T_1355 & _T_1228; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1357 = _T_1356 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1358 = _T_1357 & _T_1232; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1359 = _T_1358 & _T_1234; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1360 = _T_1359 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1361 = _T_1360 & _T_854; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1362 = _T_1361 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1363 = _T_1362 & _T_1241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1364 = _T_1363 & _T_1243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1365 = _T_1364 & _T_1245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1366 = _T_1365 & _T_1247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1367 = _T_1366 & _T_1249; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1368 = _T_1367 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1369 = _T_1368 & _T_1253; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1370 = _T_1369 & _T_1255; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1371 = _T_1370 & _T_1257; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1372 = _T_1371 & _T_1259; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1373 = _T_1372 & _T_1261; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1374 = _T_1373 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1375 = _T_1374 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1376 = _T_1375 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1377 = _T_1376 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1378 = _T_1377 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1379 = _T_1378 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1380 = _T_1379 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1381 = _T_1299 | _T_1380; // @[dec_dec_ctl.scala 101:136]
  wire  _T_1389 = ~io_ins[28]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_1436 = _T_1353 & _T_1389; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1437 = _T_1436 & _T_1226; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1438 = _T_1437 & _T_1228; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1439 = _T_1438 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1440 = _T_1439 & _T_1232; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1441 = _T_1440 & _T_1234; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1442 = _T_1441 & _T_840; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1443 = _T_1442 & _T_854; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1444 = _T_1443 & _T_1241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1445 = _T_1444 & _T_1243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1446 = _T_1445 & _T_1245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1447 = _T_1446 & _T_1247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1448 = _T_1447 & _T_1249; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1449 = _T_1448 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1450 = _T_1449 & _T_1253; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1451 = _T_1450 & _T_1255; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1452 = _T_1451 & _T_1257; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1453 = _T_1452 & _T_1259; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1454 = _T_1453 & _T_1261; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1455 = _T_1454 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1456 = _T_1455 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1457 = _T_1456 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1458 = _T_1457 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1459 = _T_1458 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1460 = _T_1459 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1461 = _T_1381 | _T_1460; // @[dec_dec_ctl.scala 102:122]
  wire  _T_1489 = _T_1439 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1490 = _T_1489 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1491 = _T_1490 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1492 = _T_1491 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1493 = _T_1492 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1494 = _T_1461 | _T_1493; // @[dec_dec_ctl.scala 103:119]
  wire  _T_1521 = _T_1220 & _T_1305; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1522 = _T_1521 & _T_1389; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1523 = _T_1522 & _T_1226; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1524 = _T_1523 & _T_1228; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1525 = _T_1524 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1526 = _T_1525 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1527 = _T_1526 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1528 = _T_1527 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1529 = _T_1528 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1530 = _T_1529 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1531 = _T_1530 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1532 = _T_1531 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1533 = _T_1532 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1534 = _T_1494 | _T_1533; // @[dec_dec_ctl.scala 104:60]
  wire  _T_1563 = _T_1525 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1564 = _T_1563 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1565 = _T_1564 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1566 = _T_1565 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1567 = _T_1566 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1568 = _T_1567 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1569 = _T_1568 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1570 = _T_1569 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1571 = _T_1534 | _T_1570; // @[dec_dec_ctl.scala 105:69]
  wire  _T_1597 = _T_1438 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1598 = _T_1597 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1599 = _T_1598 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1600 = _T_1599 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1601 = _T_1600 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1602 = _T_1601 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1603 = _T_1571 | _T_1602; // @[dec_dec_ctl.scala 106:66]
  wire  _T_1620 = _T_235 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1621 = _T_1620 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1622 = _T_1621 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1623 = _T_1622 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1624 = _T_1623 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1625 = _T_1624 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1626 = _T_1603 | _T_1625; // @[dec_dec_ctl.scala 107:58]
  wire  _T_1638 = io_ins[14] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1639 = _T_1638 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1640 = _T_1639 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1641 = _T_1640 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1642 = _T_1641 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1643 = _T_1642 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1644 = _T_1643 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1645 = _T_1626 | _T_1644; // @[dec_dec_ctl.scala 108:46]
  wire  _T_1657 = _T_143 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1658 = _T_1657 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1659 = _T_1658 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1660 = _T_1659 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1661 = _T_1660 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1662 = _T_1661 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1663 = _T_1645 | _T_1662; // @[dec_dec_ctl.scala 109:40]
  wire  _T_1678 = _T_19 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1679 = _T_1678 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1680 = _T_1679 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1681 = _T_1680 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1682 = _T_1681 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1683 = _T_1682 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1684 = _T_1663 | _T_1683; // @[dec_dec_ctl.scala 110:39]
  wire  _T_1695 = io_ins[12] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1696 = _T_1695 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1697 = _T_1696 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1698 = _T_1697 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1699 = _T_1698 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1700 = _T_1699 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1701 = _T_1700 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1702 = _T_1684 | _T_1701; // @[dec_dec_ctl.scala 111:43]
  wire  _T_1771 = _T_1443 & _T_856; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1772 = _T_1771 & _T_1241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1773 = _T_1772 & _T_1243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1774 = _T_1773 & _T_1245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1775 = _T_1774 & _T_1247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1776 = _T_1775 & _T_1249; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1777 = _T_1776 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1778 = _T_1777 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1779 = _T_1778 & _T_1253; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1780 = _T_1779 & _T_1255; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1781 = _T_1780 & _T_1257; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1782 = _T_1781 & _T_1259; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1783 = _T_1782 & _T_1261; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1784 = _T_1783 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1785 = _T_1784 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1786 = _T_1785 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1787 = _T_1786 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1788 = _T_1787 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1789 = _T_1788 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1790 = _T_1789 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1791 = _T_1702 | _T_1790; // @[dec_dec_ctl.scala 112:39]
  wire  _T_1839 = _T_1436 & _T_1241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1840 = _T_1839 & _T_1243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1841 = _T_1840 & _T_1245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1842 = _T_1841 & _T_1247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1843 = _T_1842 & _T_1249; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1844 = _T_1843 & _T_14; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1845 = _T_1844 & _T_16; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1846 = _T_1845 & _T_143; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1847 = _T_1846 & _T_1253; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1848 = _T_1847 & _T_1255; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1849 = _T_1848 & _T_1257; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1850 = _T_1849 & _T_1259; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1851 = _T_1850 & _T_1261; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1852 = _T_1851 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1853 = _T_1852 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1854 = _T_1853 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1855 = _T_1854 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1856 = _T_1855 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1857 = _T_1856 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1858 = _T_1857 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1859 = _T_1791 | _T_1858; // @[dec_dec_ctl.scala 113:130]
  wire  _T_1871 = _T_524 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1872 = _T_1871 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1873 = _T_1872 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1874 = _T_1873 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1875 = _T_1874 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1876 = _T_1875 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1877 = _T_1859 | _T_1876; // @[dec_dec_ctl.scala 114:102]
  wire  _T_1892 = _T_16 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1893 = _T_1892 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1894 = _T_1893 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1895 = _T_1894 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1896 = _T_1895 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1897 = _T_1896 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1898 = _T_1897 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1899 = _T_1877 | _T_1898; // @[dec_dec_ctl.scala 115:39]
  wire  _T_1908 = io_ins[6] & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1909 = _T_1908 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1910 = _T_1909 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1911 = _T_1910 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1912 = _T_1911 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1913 = _T_1912 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1914 = _T_1899 | _T_1913; // @[dec_dec_ctl.scala 116:43]
  wire  _T_1926 = _T_653 & _T_9; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1927 = _T_1926 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1928 = _T_1927 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1929 = _T_1928 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1930 = _T_1929 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1931 = _T_1914 | _T_1930; // @[dec_dec_ctl.scala 117:35]
  wire  _T_1947 = _T_582 & _T_103; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1948 = _T_1947 & _T_97; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1949 = _T_1948 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1950 = _T_1949 & _T_18; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1951 = _T_1950 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1952 = _T_1951 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1953 = _T_1931 | _T_1952; // @[dec_dec_ctl.scala 118:38]
  wire  _T_1962 = _T_103 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1963 = _T_1962 & _T_99; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1964 = _T_1963 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1965 = _T_1964 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1966 = _T_1965 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  assign io_out_alu = _T_7 | _T_11; // @[dec_dec_ctl.scala 20:14]
  assign io_out_rs1 = _T_101 | _T_106; // @[dec_dec_ctl.scala 21:14]
  assign io_out_rs2 = _T_114 | _T_121; // @[dec_dec_ctl.scala 27:14]
  assign io_out_imm12 = _T_149 | _T_159; // @[dec_dec_ctl.scala 28:16]
  assign io_out_rd = _T_169 | io_ins[4]; // @[dec_dec_ctl.scala 30:13]
  assign io_out_shimm5 = _T_182 & _T_18; // @[dec_dec_ctl.scala 31:17]
  assign io_out_imm20 = _T_186 | _T_189; // @[dec_dec_ctl.scala 32:16]
  assign io_out_pc = _T_197 | _T_186; // @[dec_dec_ctl.scala 33:13]
  assign io_out_load = _T_208 & _T_18; // @[dec_dec_ctl.scala 34:15]
  assign io_out_store = _T_120 & _T_97; // @[dec_dec_ctl.scala 35:16]
  assign io_out_lsu = _T_223 & _T_18; // @[dec_dec_ctl.scala 36:14]
  assign io_out_add = _T_245 | _T_267; // @[dec_dec_ctl.scala 37:14]
  assign io_out_sub = _T_311 | _T_318; // @[dec_dec_ctl.scala 39:14]
  assign io_out_land = _T_330 | _T_344; // @[dec_dec_ctl.scala 41:15]
  assign io_out_lor = _T_381 | _T_393; // @[dec_dec_ctl.scala 42:14]
  assign io_out_lxor = _T_409 | _T_424; // @[dec_dec_ctl.scala 45:15]
  assign io_out_sll = _T_442 & _T_18; // @[dec_dec_ctl.scala 46:14]
  assign io_out_sra = _T_456 & _T_18; // @[dec_dec_ctl.scala 47:14]
  assign io_out_srl = _T_476 & _T_18; // @[dec_dec_ctl.scala 48:14]
  assign io_out_slt = _T_297 | _T_310; // @[dec_dec_ctl.scala 49:14]
  assign io_out_unsign = _T_551 | _T_564; // @[dec_dec_ctl.scala 50:17]
  assign io_out_condbr = _T_317 & _T_18; // @[dec_dec_ctl.scala 53:17]
  assign io_out_beq = _T_584 & _T_18; // @[dec_dec_ctl.scala 54:14]
  assign io_out_bne = _T_596 & _T_18; // @[dec_dec_ctl.scala 55:14]
  assign io_out_bge = _T_607 & _T_18; // @[dec_dec_ctl.scala 56:14]
  assign io_out_blt = _T_619 & _T_18; // @[dec_dec_ctl.scala 57:14]
  assign io_out_jal = io_ins[6] & io_ins[2]; // @[dec_dec_ctl.scala 58:14]
  assign io_out_by = _T_636 & _T_18; // @[dec_dec_ctl.scala 59:13]
  assign io_out_half = _T_646 & _T_18; // @[dec_dec_ctl.scala 60:15]
  assign io_out_word = _T_653 & _T_97; // @[dec_dec_ctl.scala 61:15]
  assign io_out_csr_read = _T_683 | _T_688; // @[dec_dec_ctl.scala 62:19]
  assign io_out_csr_clr = _T_728 | _T_737; // @[dec_dec_ctl.scala 65:18]
  assign io_out_csr_set = _T_829 | _T_837; // @[dec_dec_ctl.scala 72:18]
  assign io_out_csr_write = _T_745 & io_ins[4]; // @[dec_dec_ctl.scala 68:20]
  assign io_out_csr_imm = _T_786 | _T_793; // @[dec_dec_ctl.scala 69:18]
  assign io_out_presync = _T_1106 | _T_1113; // @[dec_dec_ctl.scala 89:18]
  assign io_out_postsync = _T_1210 | _T_1113; // @[dec_dec_ctl.scala 95:19]
  assign io_out_ebreak = _T_851 & io_ins[4]; // @[dec_dec_ctl.scala 75:17]
  assign io_out_ecall = _T_866 & io_ins[4]; // @[dec_dec_ctl.scala 76:16]
  assign io_out_mret = _T_877 & io_ins[4]; // @[dec_dec_ctl.scala 77:15]
  assign io_out_mul = _T_891 & _T_18; // @[dec_dec_ctl.scala 78:14]
  assign io_out_rs1_sign = _T_911 | _T_928; // @[dec_dec_ctl.scala 79:19]
  assign io_out_rs2_sign = _T_927 & _T_18; // @[dec_dec_ctl.scala 81:19]
  assign io_out_low = _T_962 & _T_18; // @[dec_dec_ctl.scala 82:14]
  assign io_out_div = _T_973 & _T_18; // @[dec_dec_ctl.scala 83:14]
  assign io_out_rem = _T_986 & _T_18; // @[dec_dec_ctl.scala 84:14]
  assign io_out_fence = _T_9 & io_ins[3]; // @[dec_dec_ctl.scala 85:16]
  assign io_out_fence_i = _T_996 & io_ins[3]; // @[dec_dec_ctl.scala 86:18]
  assign io_out_pm_alu = _T_1020 | _T_11; // @[dec_dec_ctl.scala 87:17]
  assign io_out_legal = _T_1953 | _T_1966; // @[dec_dec_ctl.scala 101:16]
endmodule
module dec_decode_ctl(
  input         clock,
  input         reset,
  output [1:0]  io_decode_exu_dec_data_en,
  output [1:0]  io_decode_exu_dec_ctl_en,
  output        io_decode_exu_i0_ap_land,
  output        io_decode_exu_i0_ap_lor,
  output        io_decode_exu_i0_ap_lxor,
  output        io_decode_exu_i0_ap_sll,
  output        io_decode_exu_i0_ap_srl,
  output        io_decode_exu_i0_ap_sra,
  output        io_decode_exu_i0_ap_beq,
  output        io_decode_exu_i0_ap_bne,
  output        io_decode_exu_i0_ap_blt,
  output        io_decode_exu_i0_ap_bge,
  output        io_decode_exu_i0_ap_add,
  output        io_decode_exu_i0_ap_sub,
  output        io_decode_exu_i0_ap_slt,
  output        io_decode_exu_i0_ap_unsign,
  output        io_decode_exu_i0_ap_jal,
  output        io_decode_exu_i0_ap_predict_t,
  output        io_decode_exu_i0_ap_predict_nt,
  output        io_decode_exu_i0_ap_csr_write,
  output        io_decode_exu_i0_ap_csr_imm,
  output        io_decode_exu_dec_i0_predict_p_d_valid,
  output        io_decode_exu_dec_i0_predict_p_d_bits_pc4,
  output [1:0]  io_decode_exu_dec_i0_predict_p_d_bits_hist,
  output [11:0] io_decode_exu_dec_i0_predict_p_d_bits_toffset,
  output        io_decode_exu_dec_i0_predict_p_d_bits_br_error,
  output        io_decode_exu_dec_i0_predict_p_d_bits_br_start_error,
  output [30:0] io_decode_exu_dec_i0_predict_p_d_bits_prett,
  output        io_decode_exu_dec_i0_predict_p_d_bits_pcall,
  output        io_decode_exu_dec_i0_predict_p_d_bits_pret,
  output        io_decode_exu_dec_i0_predict_p_d_bits_pja,
  output        io_decode_exu_dec_i0_predict_p_d_bits_way,
  output [7:0]  io_decode_exu_i0_predict_fghr_d,
  output [7:0]  io_decode_exu_i0_predict_index_d,
  output [4:0]  io_decode_exu_i0_predict_btag_d,
  output        io_decode_exu_dec_i0_rs1_en_d,
  output        io_decode_exu_dec_i0_rs2_en_d,
  output [31:0] io_decode_exu_dec_i0_immed_d,
  output [31:0] io_decode_exu_dec_i0_rs1_bypass_data_d,
  output [31:0] io_decode_exu_dec_i0_rs2_bypass_data_d,
  output        io_decode_exu_dec_i0_select_pc_d,
  output [1:0]  io_decode_exu_dec_i0_rs1_bypass_en_d,
  output [1:0]  io_decode_exu_dec_i0_rs2_bypass_en_d,
  output        io_decode_exu_mul_p_valid,
  output        io_decode_exu_mul_p_bits_rs1_sign,
  output        io_decode_exu_mul_p_bits_rs2_sign,
  output        io_decode_exu_mul_p_bits_low,
  output [30:0] io_decode_exu_pred_correct_npc_x,
  output        io_decode_exu_dec_extint_stall,
  input  [31:0] io_decode_exu_exu_i0_result_x,
  input  [31:0] io_decode_exu_exu_csr_rs1_x,
  output        io_dec_alu_dec_i0_alu_decode_d,
  output        io_dec_alu_dec_csr_ren_d,
  output [11:0] io_dec_alu_dec_i0_br_immed_d,
  input  [30:0] io_dec_alu_exu_i0_pc_x,
  output        io_dec_div_div_p_valid,
  output        io_dec_div_div_p_bits_unsign,
  output        io_dec_div_div_p_bits_rem,
  output        io_dec_div_dec_div_cancel,
  input         io_dctl_busbuff_lsu_nonblock_load_valid_m,
  input  [1:0]  io_dctl_busbuff_lsu_nonblock_load_tag_m,
  input         io_dctl_busbuff_lsu_nonblock_load_inv_r,
  input  [1:0]  io_dctl_busbuff_lsu_nonblock_load_inv_tag_r,
  input         io_dctl_busbuff_lsu_nonblock_load_data_valid,
  input         io_dctl_busbuff_lsu_nonblock_load_data_error,
  input  [1:0]  io_dctl_busbuff_lsu_nonblock_load_data_tag,
  input  [31:0] io_dctl_busbuff_lsu_nonblock_load_data,
  input         io_dctl_dma_dma_dccm_stall_any,
  input         io_dec_tlu_flush_extint,
  input         io_dec_tlu_force_halt,
  output [31:0] io_dec_i0_inst_wb1,
  output [30:0] io_dec_i0_pc_wb1,
  input  [3:0]  io_dec_i0_trigger_match_d,
  input         io_dec_tlu_wr_pause_r,
  input         io_dec_tlu_pipelining_disable,
  input  [3:0]  io_lsu_trigger_match_m,
  input         io_lsu_pmu_misaligned_m,
  input         io_dec_tlu_debug_stall,
  input         io_dec_tlu_flush_leak_one_r,
  input         io_dec_debug_fence_d,
  input         io_dec_i0_icaf_d,
  input         io_dec_i0_icaf_f1_d,
  input  [1:0]  io_dec_i0_icaf_type_d,
  input         io_dec_i0_dbecc_d,
  input         io_dec_i0_brp_valid,
  input  [11:0] io_dec_i0_brp_bits_toffset,
  input  [1:0]  io_dec_i0_brp_bits_hist,
  input         io_dec_i0_brp_bits_br_error,
  input         io_dec_i0_brp_bits_br_start_error,
  input  [30:0] io_dec_i0_brp_bits_prett,
  input         io_dec_i0_brp_bits_way,
  input         io_dec_i0_brp_bits_ret,
  input  [7:0]  io_dec_i0_bp_index,
  input  [7:0]  io_dec_i0_bp_fghr,
  input  [4:0]  io_dec_i0_bp_btag,
  input         io_lsu_idle_any,
  input         io_lsu_load_stall_any,
  input         io_lsu_store_stall_any,
  input         io_exu_div_wren,
  input         io_dec_tlu_i0_kill_writeb_wb,
  input         io_dec_tlu_flush_lower_wb,
  input         io_dec_tlu_i0_kill_writeb_r,
  input         io_dec_tlu_flush_lower_r,
  input         io_dec_tlu_flush_pause_r,
  input         io_dec_tlu_presync_d,
  input         io_dec_tlu_postsync_d,
  input         io_dec_i0_pc4_d,
  input  [31:0] io_dec_csr_rddata_d,
  input         io_dec_csr_legal_d,
  input  [31:0] io_lsu_result_m,
  input  [31:0] io_lsu_result_corr_r,
  input         io_exu_flush_final,
  input  [31:0] io_dec_i0_instr_d,
  input         io_dec_ib0_valid_d,
  input         io_free_clk,
  input         io_active_clk,
  input         io_clk_override,
  output [4:0]  io_dec_i0_rs1_d,
  output [4:0]  io_dec_i0_rs2_d,
  output [4:0]  io_dec_i0_waddr_r,
  output        io_dec_i0_wen_r,
  output [31:0] io_dec_i0_wdata_r,
  output        io_lsu_p_valid,
  output        io_lsu_p_bits_fast_int,
  output        io_lsu_p_bits_by,
  output        io_lsu_p_bits_half,
  output        io_lsu_p_bits_word,
  output        io_lsu_p_bits_load,
  output        io_lsu_p_bits_store,
  output        io_lsu_p_bits_unsign,
  output        io_lsu_p_bits_store_data_bypass_d,
  output        io_lsu_p_bits_load_ldst_bypass_d,
  output [4:0]  io_div_waddr_wb,
  output        io_dec_lsu_valid_raw_d,
  output [11:0] io_dec_lsu_offset_d,
  output        io_dec_csr_wen_unq_d,
  output        io_dec_csr_any_unq_d,
  output [11:0] io_dec_csr_rdaddr_d,
  output        io_dec_csr_wen_r,
  output [11:0] io_dec_csr_wraddr_r,
  output [31:0] io_dec_csr_wrdata_r,
  output        io_dec_csr_stall_int_ff,
  output        io_dec_tlu_i0_valid_r,
  output        io_dec_tlu_packet_r_legal,
  output        io_dec_tlu_packet_r_icaf,
  output        io_dec_tlu_packet_r_icaf_f1,
  output [1:0]  io_dec_tlu_packet_r_icaf_type,
  output        io_dec_tlu_packet_r_fence_i,
  output [3:0]  io_dec_tlu_packet_r_i0trigger,
  output [3:0]  io_dec_tlu_packet_r_pmu_i0_itype,
  output        io_dec_tlu_packet_r_pmu_i0_br_unpred,
  output        io_dec_tlu_packet_r_pmu_divide,
  output        io_dec_tlu_packet_r_pmu_lsu_misaligned,
  output [30:0] io_dec_tlu_i0_pc_r,
  output [31:0] io_dec_illegal_inst,
  output        io_dec_pmu_instr_decoded,
  output        io_dec_pmu_decode_stall,
  output        io_dec_pmu_presync_stall,
  output        io_dec_pmu_postsync_stall,
  output        io_dec_nonblock_load_wen,
  output [4:0]  io_dec_nonblock_load_waddr,
  output        io_dec_pause_state,
  output        io_dec_pause_state_cg,
  output        io_dec_div_active,
  input         io_scan_mode,
  output        io_dec_aln_dec_i0_decode_d,
  input  [15:0] io_dec_aln_ifu_i0_cinst,
  input  [1:0]  io_dbg_dctl_dbg_cmd_wrdata
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
  reg [31:0] _RAND_80;
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
`endif // RANDOMIZE_REG_INIT
  wire  rvclkhdr_io_l1clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_io_clk; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_io_en; // @[el2_lib.scala 483:22]
  wire  rvclkhdr_io_scan_mode; // @[el2_lib.scala 483:22]
  wire [31:0] i0_dec_io_ins; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_alu; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_rs1; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_rs2; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_imm12; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_rd; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_shimm5; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_imm20; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_pc; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_load; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_store; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_lsu; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_add; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_sub; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_land; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_lor; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_lxor; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_sll; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_sra; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_srl; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_slt; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_unsign; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_condbr; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_beq; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_bne; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_bge; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_blt; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_jal; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_by; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_half; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_word; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_csr_read; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_csr_clr; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_csr_set; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_csr_write; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_csr_imm; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_presync; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_postsync; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_ebreak; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_ecall; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_mret; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_mul; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_rs1_sign; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_rs2_sign; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_low; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_div; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_rem; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_fence; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_fence_i; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_pm_alu; // @[dec_decode_ctl.scala 362:22]
  wire  i0_dec_io_out_legal; // @[dec_decode_ctl.scala 362:22]
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
  wire  rvclkhdr_5_io_l1clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_5_io_clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_5_io_en; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_5_io_scan_mode; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_6_io_l1clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_6_io_clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_6_io_en; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_6_io_scan_mode; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_7_io_l1clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_7_io_clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_7_io_en; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_7_io_scan_mode; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_8_io_l1clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_8_io_clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_8_io_en; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_8_io_scan_mode; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_9_io_l1clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_9_io_clk; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_9_io_en; // @[el2_lib.scala 518:23]
  wire  rvclkhdr_9_io_scan_mode; // @[el2_lib.scala 518:23]
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
  reg  tlu_wr_pause_r1; // @[dec_decode_ctl.scala 469:55]
  wire  _T_1 = io_dec_tlu_wr_pause_r ^ tlu_wr_pause_r1; // @[dec_decode_ctl.scala 181:51]
  reg  tlu_wr_pause_r2; // @[dec_decode_ctl.scala 470:55]
  wire  _T_2 = tlu_wr_pause_r1 ^ tlu_wr_pause_r2; // @[dec_decode_ctl.scala 182:32]
  wire  _T_3 = _T_1 | _T_2; // @[dec_decode_ctl.scala 181:73]
  wire  _T_4 = io_dec_tlu_flush_extint ^ io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 183:32]
  wire  _T_5 = _T_3 | _T_4; // @[dec_decode_ctl.scala 182:56]
  reg  leak1_i1_stall; // @[dec_decode_ctl.scala 370:56]
  wire  _T_280 = ~io_dec_tlu_flush_lower_r; // @[dec_decode_ctl.scala 369:73]
  wire  _T_281 = leak1_i1_stall & _T_280; // @[dec_decode_ctl.scala 369:71]
  wire  leak1_i1_stall_in = io_dec_tlu_flush_leak_one_r | _T_281; // @[dec_decode_ctl.scala 369:53]
  wire  _T_6 = leak1_i1_stall_in ^ leak1_i1_stall; // @[dec_decode_ctl.scala 184:32]
  wire  _T_7 = _T_5 | _T_6; // @[dec_decode_ctl.scala 183:67]
  wire  _T_284 = io_dec_aln_dec_i0_decode_d & leak1_i1_stall; // @[dec_decode_ctl.scala 372:53]
  reg  leak1_i0_stall; // @[dec_decode_ctl.scala 373:56]
  wire  _T_286 = leak1_i0_stall & _T_280; // @[dec_decode_ctl.scala 372:89]
  wire  leak1_i0_stall_in = _T_284 | _T_286; // @[dec_decode_ctl.scala 372:71]
  wire  _T_8 = leak1_i0_stall_in ^ leak1_i0_stall; // @[dec_decode_ctl.scala 185:32]
  wire  _T_9 = _T_7 | _T_8; // @[dec_decode_ctl.scala 184:56]
  reg  pause_stall; // @[dec_decode_ctl.scala 467:50]
  wire  _T_415 = io_dec_tlu_wr_pause_r | pause_stall; // @[dec_decode_ctl.scala 466:44]
  wire  _T_408 = ~io_dec_tlu_flush_pause_r; // @[dec_decode_ctl.scala 465:49]
  wire  _T_409 = io_dec_tlu_flush_lower_r & _T_408; // @[dec_decode_ctl.scala 465:47]
  reg [31:0] write_csr_data; // @[el2_lib.scala 514:16]
  wire [31:0] _T_412 = {31'h0,write_csr_data[0]}; // @[Cat.scala 29:58]
  wire  _T_413 = write_csr_data == _T_412; // @[dec_decode_ctl.scala 465:109]
  wire  _T_414 = pause_stall & _T_413; // @[dec_decode_ctl.scala 465:91]
  wire  clear_pause = _T_409 | _T_414; // @[dec_decode_ctl.scala 465:76]
  wire  _T_416 = ~clear_pause; // @[dec_decode_ctl.scala 466:61]
  wire  pause_state_in = _T_415 & _T_416; // @[dec_decode_ctl.scala 466:59]
  wire  _T_10 = pause_state_in ^ pause_stall; // @[dec_decode_ctl.scala 186:32]
  wire  _T_11 = _T_9 | _T_10; // @[dec_decode_ctl.scala 185:56]
  wire  _T_18 = ~leak1_i1_stall; // @[dec_decode_ctl.scala 196:62]
  wire  i0_brp_valid = io_dec_i0_brp_valid & _T_18; // @[dec_decode_ctl.scala 196:60]
  wire  i0_dp_raw_condbr = i0_dec_io_out_condbr; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_jal = i0_dec_io_out_jal; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire [19:0] i0_pcall_imm = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[19:12],io_dec_i0_instr_d[20],io_dec_i0_instr_d[30:21]}; // @[Cat.scala 29:58]
  wire  _T_298 = i0_pcall_imm[19:12] == 8'hff; // @[dec_decode_ctl.scala 378:79]
  wire  _T_300 = i0_pcall_imm[19:12] == 8'h0; // @[dec_decode_ctl.scala 378:112]
  wire  i0_pcall_12b_offset = i0_pcall_imm[11] ? _T_298 : _T_300; // @[dec_decode_ctl.scala 378:33]
  wire  i0_dp_raw_imm20 = i0_dec_io_out_imm20; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  _T_301 = i0_pcall_12b_offset & i0_dp_raw_imm20; // @[dec_decode_ctl.scala 379:47]
  wire [4:0] i0r_rd = io_dec_i0_instr_d[11:7]; // @[dec_decode_ctl.scala 592:16]
  wire  _T_302 = i0r_rd == 5'h1; // @[dec_decode_ctl.scala 379:76]
  wire  _T_303 = i0r_rd == 5'h5; // @[dec_decode_ctl.scala 379:98]
  wire  _T_304 = _T_302 | _T_303; // @[dec_decode_ctl.scala 379:89]
  wire  i0_pcall_case = _T_301 & _T_304; // @[dec_decode_ctl.scala 379:65]
  wire  i0_pcall_raw = i0_dp_raw_jal & i0_pcall_case; // @[dec_decode_ctl.scala 381:38]
  wire  _T_20 = i0_dp_raw_condbr | i0_pcall_raw; // @[dec_decode_ctl.scala 207:75]
  wire  _T_309 = ~_T_304; // @[dec_decode_ctl.scala 380:67]
  wire  i0_pja_case = _T_301 & _T_309; // @[dec_decode_ctl.scala 380:65]
  wire  i0_pja_raw = i0_dp_raw_jal & i0_pja_case; // @[dec_decode_ctl.scala 383:38]
  wire  _T_21 = _T_20 | i0_pja_raw; // @[dec_decode_ctl.scala 207:90]
  wire  i0_dp_raw_imm12 = i0_dec_io_out_imm12; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  _T_325 = i0_dp_raw_jal & i0_dp_raw_imm12; // @[dec_decode_ctl.scala 387:37]
  wire  _T_326 = i0r_rd == 5'h0; // @[dec_decode_ctl.scala 387:65]
  wire  _T_327 = _T_325 & _T_326; // @[dec_decode_ctl.scala 387:55]
  wire [4:0] i0r_rs1 = io_dec_i0_instr_d[19:15]; // @[dec_decode_ctl.scala 590:16]
  wire  _T_328 = i0r_rs1 == 5'h1; // @[dec_decode_ctl.scala 387:89]
  wire  _T_329 = i0r_rs1 == 5'h5; // @[dec_decode_ctl.scala 387:111]
  wire  _T_330 = _T_328 | _T_329; // @[dec_decode_ctl.scala 387:101]
  wire  i0_pret_case = _T_327 & _T_330; // @[dec_decode_ctl.scala 387:79]
  wire  i0_pret_raw = i0_dp_raw_jal & i0_pret_case; // @[dec_decode_ctl.scala 388:32]
  wire  _T_22 = _T_21 | i0_pret_raw; // @[dec_decode_ctl.scala 207:103]
  wire  _T_23 = ~_T_22; // @[dec_decode_ctl.scala 207:56]
  wire  i0_notbr_error = i0_brp_valid & _T_23; // @[dec_decode_ctl.scala 207:54]
  wire  _T_31 = io_dec_i0_brp_bits_br_error | i0_notbr_error; // @[dec_decode_ctl.scala 212:62]
  wire  _T_25 = i0_brp_valid & io_dec_i0_brp_bits_hist[1]; // @[dec_decode_ctl.scala 210:47]
  wire  _T_314 = i0_pcall_raw | i0_pja_raw; // @[dec_decode_ctl.scala 385:41]
  wire [11:0] _T_323 = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[7],io_dec_i0_instr_d[30:25],io_dec_i0_instr_d[11:8]}; // @[Cat.scala 29:58]
  wire [11:0] i0_br_offset = _T_314 ? i0_pcall_imm[11:0] : _T_323; // @[dec_decode_ctl.scala 385:26]
  wire  _T_26 = io_dec_i0_brp_bits_toffset != i0_br_offset; // @[dec_decode_ctl.scala 210:106]
  wire  _T_27 = _T_25 & _T_26; // @[dec_decode_ctl.scala 210:76]
  wire  _T_28 = ~i0_pret_raw; // @[dec_decode_ctl.scala 210:126]
  wire  i0_br_toffset_error = _T_27 & _T_28; // @[dec_decode_ctl.scala 210:124]
  wire  _T_32 = _T_31 | i0_br_toffset_error; // @[dec_decode_ctl.scala 212:79]
  wire  _T_29 = i0_brp_valid & io_dec_i0_brp_bits_ret; // @[dec_decode_ctl.scala 211:47]
  wire  i0_ret_error = _T_29 & _T_28; // @[dec_decode_ctl.scala 211:72]
  wire  i0_br_error = _T_32 | i0_ret_error; // @[dec_decode_ctl.scala 212:101]
  wire  _T_39 = i0_br_error | io_dec_i0_brp_bits_br_start_error; // @[dec_decode_ctl.scala 217:47]
  wire  i0_br_error_all = _T_39 & _T_18; // @[dec_decode_ctl.scala 217:84]
  wire  i0_icaf_d = io_dec_i0_icaf_d | io_dec_i0_dbecc_d; // @[dec_decode_ctl.scala 226:36]
  wire  _T_41 = i0_br_error_all | i0_icaf_d; // @[dec_decode_ctl.scala 230:25]
  wire  i0_dp_raw_postsync = i0_dec_io_out_postsync; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_postsync = _T_41 | i0_dp_raw_postsync; // @[dec_decode_ctl.scala 230:50]
  wire  _T_442 = i0_dp_postsync | io_dec_tlu_postsync_d; // @[dec_decode_ctl.scala 496:36]
  wire  debug_fence_i = io_dec_debug_fence_d & io_dbg_dctl_dbg_cmd_wrdata[0]; // @[dec_decode_ctl.scala 488:48]
  wire  _T_443 = _T_442 | debug_fence_i; // @[dec_decode_ctl.scala 496:60]
  wire  i0_dp_raw_csr_write = i0_dec_io_out_csr_write; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_csr_write = _T_41 ? 1'h0 : i0_dp_raw_csr_write; // @[dec_decode_ctl.scala 230:50]
  wire  _T_343 = ~io_dec_debug_fence_d; // @[dec_decode_ctl.scala 427:42]
  wire  i0_csr_write = i0_dp_csr_write & _T_343; // @[dec_decode_ctl.scala 427:40]
  wire  i0_dp_raw_csr_read = i0_dec_io_out_csr_read; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_csr_read = _T_41 ? 1'h0 : i0_dp_raw_csr_read; // @[dec_decode_ctl.scala 230:50]
  wire  _T_347 = ~i0_dp_csr_read; // @[dec_decode_ctl.scala 432:41]
  wire  i0_csr_write_only_d = i0_csr_write & _T_347; // @[dec_decode_ctl.scala 432:39]
  wire  _T_445 = io_dec_i0_instr_d[31:20] == 12'h7c2; // @[dec_decode_ctl.scala 496:112]
  wire  _T_446 = i0_csr_write_only_d & _T_445; // @[dec_decode_ctl.scala 496:99]
  wire  i0_postsync = _T_443 | _T_446; // @[dec_decode_ctl.scala 496:76]
  wire  i0_dp_raw_legal = i0_dec_io_out_legal; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_legal = _T_41 | i0_dp_raw_legal; // @[dec_decode_ctl.scala 230:50]
  wire  any_csr_d = i0_dp_csr_read | i0_csr_write; // @[dec_decode_ctl.scala 498:34]
  wire  _T_447 = ~any_csr_d; // @[dec_decode_ctl.scala 500:40]
  wire  _T_448 = _T_447 | io_dec_csr_legal_d; // @[dec_decode_ctl.scala 500:51]
  wire  i0_legal = i0_dp_legal & _T_448; // @[dec_decode_ctl.scala 500:37]
  wire  _T_507 = ~i0_legal; // @[dec_decode_ctl.scala 540:64]
  wire  _T_508 = i0_postsync | _T_507; // @[dec_decode_ctl.scala 540:62]
  wire  _T_509 = io_dec_aln_dec_i0_decode_d & _T_508; // @[dec_decode_ctl.scala 540:47]
  reg  postsync_stall; // @[dec_decode_ctl.scala 538:53]
  reg  x_d_valid; // @[el2_lib.scala 524:16]
  wire  _T_510 = postsync_stall & x_d_valid; // @[dec_decode_ctl.scala 540:96]
  wire  ps_stall_in = _T_509 | _T_510; // @[dec_decode_ctl.scala 540:77]
  wire  _T_12 = ps_stall_in ^ postsync_stall; // @[dec_decode_ctl.scala 187:32]
  wire  _T_13 = _T_11 | _T_12; // @[dec_decode_ctl.scala 186:56]
  reg  flush_final_r; // @[dec_decode_ctl.scala 586:52]
  wire  _T_14 = io_exu_flush_final ^ flush_final_r; // @[dec_decode_ctl.scala 188:32]
  wire  _T_15 = _T_13 | _T_14; // @[dec_decode_ctl.scala 187:56]
  wire  shift_illegal = io_dec_aln_dec_i0_decode_d & _T_507; // @[dec_decode_ctl.scala 504:55]
  reg  illegal_lockout; // @[dec_decode_ctl.scala 508:54]
  wire  _T_469 = shift_illegal | illegal_lockout; // @[dec_decode_ctl.scala 507:40]
  wire  _T_470 = ~flush_final_r; // @[dec_decode_ctl.scala 507:61]
  wire  illegal_lockout_in = _T_469 & _T_470; // @[dec_decode_ctl.scala 507:59]
  wire  _T_16 = illegal_lockout_in ^ illegal_lockout; // @[dec_decode_ctl.scala 189:32]
  wire  i0_legal_decode_d = io_dec_aln_dec_i0_decode_d & i0_legal; // @[dec_decode_ctl.scala 614:54]
  wire  _T_33 = i0_br_error & i0_legal_decode_d; // @[dec_decode_ctl.scala 213:83]
  wire  _T_36 = io_dec_i0_brp_bits_br_start_error & i0_legal_decode_d; // @[dec_decode_ctl.scala 214:105]
  wire  i0_dp_raw_pm_alu = i0_dec_io_out_pm_alu; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_pm_alu = _T_41 ? 1'h0 : i0_dp_raw_pm_alu; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_fence_i = i0_dec_io_out_fence_i; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_fence_i = _T_41 ? 1'h0 : i0_dp_raw_fence_i; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_fence = i0_dec_io_out_fence; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_fence = _T_41 ? 1'h0 : i0_dp_raw_fence; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_rem = i0_dec_io_out_rem; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_div = i0_dec_io_out_div; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_div = _T_41 ? 1'h0 : i0_dp_raw_div; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_low = i0_dec_io_out_low; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_rs2_sign = i0_dec_io_out_rs2_sign; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_rs1_sign = i0_dec_io_out_rs1_sign; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_mul = i0_dec_io_out_mul; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_mul = _T_41 ? 1'h0 : i0_dp_raw_mul; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_mret = i0_dec_io_out_mret; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_mret = _T_41 ? 1'h0 : i0_dp_raw_mret; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_ecall = i0_dec_io_out_ecall; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_ecall = _T_41 ? 1'h0 : i0_dp_raw_ecall; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_ebreak = i0_dec_io_out_ebreak; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_ebreak = _T_41 ? 1'h0 : i0_dp_raw_ebreak; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_presync = i0_dec_io_out_presync; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_presync = _T_41 ? 1'h0 : i0_dp_raw_presync; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_csr_imm = i0_dec_io_out_csr_imm; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_csr_imm = _T_41 ? 1'h0 : i0_dp_raw_csr_imm; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_csr_set = i0_dec_io_out_csr_set; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_csr_set = _T_41 ? 1'h0 : i0_dp_raw_csr_set; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_csr_clr = i0_dec_io_out_csr_clr; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_csr_clr = _T_41 ? 1'h0 : i0_dp_raw_csr_clr; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_word = i0_dec_io_out_word; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_word = _T_41 ? 1'h0 : i0_dp_raw_word; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_half = i0_dec_io_out_half; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_half = _T_41 ? 1'h0 : i0_dp_raw_half; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_by = i0_dec_io_out_by; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_by = _T_41 ? 1'h0 : i0_dp_raw_by; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_jal = _T_41 ? 1'h0 : i0_dp_raw_jal; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_blt = i0_dec_io_out_blt; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_bge = i0_dec_io_out_bge; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_bne = i0_dec_io_out_bne; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_beq = i0_dec_io_out_beq; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_condbr = _T_41 ? 1'h0 : i0_dp_raw_condbr; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_unsign = i0_dec_io_out_unsign; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_unsign = _T_41 ? 1'h0 : i0_dp_raw_unsign; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_slt = i0_dec_io_out_slt; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_srl = i0_dec_io_out_srl; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_sra = i0_dec_io_out_sra; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_sll = i0_dec_io_out_sll; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_lxor = i0_dec_io_out_lxor; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_lor = i0_dec_io_out_lor; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_land = i0_dec_io_out_land; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_sub = i0_dec_io_out_sub; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_add = i0_dec_io_out_add; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_raw_lsu = i0_dec_io_out_lsu; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_lsu = _T_41 ? 1'h0 : i0_dp_raw_lsu; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_store = i0_dec_io_out_store; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_store = _T_41 ? 1'h0 : i0_dp_raw_store; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_load = i0_dec_io_out_load; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_load = _T_41 ? 1'h0 : i0_dp_raw_load; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_pc = i0_dec_io_out_pc; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_imm20 = _T_41 ? 1'h0 : i0_dp_raw_imm20; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_shimm5 = i0_dec_io_out_shimm5; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_shimm5 = _T_41 ? 1'h0 : i0_dp_raw_shimm5; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_rd = i0_dec_io_out_rd; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_rd = _T_41 ? 1'h0 : i0_dp_raw_rd; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_imm12 = _T_41 ? 1'h0 : i0_dp_raw_imm12; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_rs2 = i0_dec_io_out_rs2; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_rs2 = _T_41 | i0_dp_raw_rs2; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_rs1 = i0_dec_io_out_rs1; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_rs1 = _T_41 | i0_dp_raw_rs1; // @[dec_decode_ctl.scala 230:50]
  wire  i0_dp_raw_alu = i0_dec_io_out_alu; // @[dec_decode_ctl.scala 127:22 dec_decode_ctl.scala 364:12]
  wire  i0_dp_alu = _T_41 | i0_dp_raw_alu; // @[dec_decode_ctl.scala 230:50]
  wire  i0_pcall = i0_dp_jal & i0_pcall_case; // @[dec_decode_ctl.scala 382:38]
  wire  _T_44 = i0_dp_condbr | i0_pcall; // @[dec_decode_ctl.scala 244:40]
  wire  i0_pja = i0_dp_jal & i0_pja_case; // @[dec_decode_ctl.scala 384:38]
  wire  _T_45 = _T_44 | i0_pja; // @[dec_decode_ctl.scala 244:51]
  wire  i0_pret = i0_dp_jal & i0_pret_case; // @[dec_decode_ctl.scala 389:32]
  wire  i0_predict_br = _T_45 | i0_pret; // @[dec_decode_ctl.scala 244:60]
  wire  _T_47 = io_dec_i0_brp_bits_hist[1] & i0_brp_valid; // @[dec_decode_ctl.scala 246:55]
  wire  _T_48 = ~_T_47; // @[dec_decode_ctl.scala 246:26]
  wire  i0_ap_pc2 = ~io_dec_i0_pc4_d; // @[dec_decode_ctl.scala 248:20]
  wire  cam_data_reset = io_dctl_busbuff_lsu_nonblock_load_data_valid | io_dctl_busbuff_lsu_nonblock_load_data_error; // @[dec_decode_ctl.scala 281:76]
  reg [2:0] cam_raw_0_bits_tag; // @[dec_decode_ctl.scala 317:47]
  wire [2:0] _GEN_123 = {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_data_tag}; // @[dec_decode_ctl.scala 292:67]
  wire  _T_94 = _GEN_123 == cam_raw_0_bits_tag; // @[dec_decode_ctl.scala 292:67]
  wire  _T_95 = cam_data_reset & _T_94; // @[dec_decode_ctl.scala 292:45]
  reg  cam_raw_0_valid; // @[dec_decode_ctl.scala 317:47]
  wire  cam_data_reset_val_0 = _T_95 & cam_raw_0_valid; // @[dec_decode_ctl.scala 292:88]
  wire  cam_0_valid = cam_data_reset_val_0 ? 1'h0 : cam_raw_0_valid; // @[dec_decode_ctl.scala 296:39]
  wire  _T_51 = ~cam_0_valid; // @[dec_decode_ctl.scala 273:78]
  reg [2:0] cam_raw_1_bits_tag; // @[dec_decode_ctl.scala 317:47]
  wire  _T_120 = _GEN_123 == cam_raw_1_bits_tag; // @[dec_decode_ctl.scala 292:67]
  wire  _T_121 = cam_data_reset & _T_120; // @[dec_decode_ctl.scala 292:45]
  reg  cam_raw_1_valid; // @[dec_decode_ctl.scala 317:47]
  wire  cam_data_reset_val_1 = _T_121 & cam_raw_1_valid; // @[dec_decode_ctl.scala 292:88]
  wire  cam_1_valid = cam_data_reset_val_1 ? 1'h0 : cam_raw_1_valid; // @[dec_decode_ctl.scala 296:39]
  wire  _T_54 = ~cam_1_valid; // @[dec_decode_ctl.scala 273:78]
  wire  _T_57 = cam_0_valid & _T_54; // @[dec_decode_ctl.scala 273:126]
  wire [1:0] _T_59 = {io_dctl_busbuff_lsu_nonblock_load_valid_m, 1'h0}; // @[dec_decode_ctl.scala 273:158]
  reg [2:0] cam_raw_2_bits_tag; // @[dec_decode_ctl.scala 317:47]
  wire  _T_146 = _GEN_123 == cam_raw_2_bits_tag; // @[dec_decode_ctl.scala 292:67]
  wire  _T_147 = cam_data_reset & _T_146; // @[dec_decode_ctl.scala 292:45]
  reg  cam_raw_2_valid; // @[dec_decode_ctl.scala 317:47]
  wire  cam_data_reset_val_2 = _T_147 & cam_raw_2_valid; // @[dec_decode_ctl.scala 292:88]
  wire  cam_2_valid = cam_data_reset_val_2 ? 1'h0 : cam_raw_2_valid; // @[dec_decode_ctl.scala 296:39]
  wire  _T_60 = ~cam_2_valid; // @[dec_decode_ctl.scala 273:78]
  wire  _T_63 = cam_0_valid & cam_1_valid; // @[dec_decode_ctl.scala 273:126]
  wire  _T_66 = _T_63 & _T_60; // @[dec_decode_ctl.scala 273:126]
  wire [2:0] _T_68 = {io_dctl_busbuff_lsu_nonblock_load_valid_m, 2'h0}; // @[dec_decode_ctl.scala 273:158]
  reg [2:0] cam_raw_3_bits_tag; // @[dec_decode_ctl.scala 317:47]
  wire  _T_172 = _GEN_123 == cam_raw_3_bits_tag; // @[dec_decode_ctl.scala 292:67]
  wire  _T_173 = cam_data_reset & _T_172; // @[dec_decode_ctl.scala 292:45]
  reg  cam_raw_3_valid; // @[dec_decode_ctl.scala 317:47]
  wire  cam_data_reset_val_3 = _T_173 & cam_raw_3_valid; // @[dec_decode_ctl.scala 292:88]
  wire  cam_3_valid = cam_data_reset_val_3 ? 1'h0 : cam_raw_3_valid; // @[dec_decode_ctl.scala 296:39]
  wire  _T_69 = ~cam_3_valid; // @[dec_decode_ctl.scala 273:78]
  wire  _T_75 = _T_63 & cam_2_valid; // @[dec_decode_ctl.scala 273:126]
  wire  _T_78 = _T_75 & _T_69; // @[dec_decode_ctl.scala 273:126]
  wire [3:0] _T_80 = {io_dctl_busbuff_lsu_nonblock_load_valid_m, 3'h0}; // @[dec_decode_ctl.scala 273:158]
  wire  _T_81 = _T_51 & io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[Mux.scala 27:72]
  wire [1:0] _T_82 = _T_57 ? _T_59 : 2'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_83 = _T_66 ? _T_68 : 3'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_84 = _T_78 ? _T_80 : 4'h0; // @[Mux.scala 27:72]
  wire [1:0] _GEN_127 = {{1'd0}, _T_81}; // @[Mux.scala 27:72]
  wire [1:0] _T_85 = _GEN_127 | _T_82; // @[Mux.scala 27:72]
  wire [2:0] _GEN_128 = {{1'd0}, _T_85}; // @[Mux.scala 27:72]
  wire [2:0] _T_86 = _GEN_128 | _T_83; // @[Mux.scala 27:72]
  wire [3:0] _GEN_129 = {{1'd0}, _T_86}; // @[Mux.scala 27:72]
  wire [3:0] cam_wen = _GEN_129 | _T_84; // @[Mux.scala 27:72]
  reg  x_d_bits_i0load; // @[el2_lib.scala 524:16]
  reg [4:0] x_d_bits_i0rd; // @[el2_lib.scala 524:16]
  wire [4:0] nonblock_load_rd = x_d_bits_i0load ? x_d_bits_i0rd : 5'h0; // @[dec_decode_ctl.scala 284:31]
  reg [2:0] _T_704; // @[dec_decode_ctl.scala 622:80]
  wire [3:0] i0_pipe_en = {io_dec_aln_dec_i0_decode_d,_T_704}; // @[Cat.scala 29:58]
  wire  _T_710 = |i0_pipe_en[2:1]; // @[dec_decode_ctl.scala 625:49]
  wire  i0_r_ctl_en = _T_710 | io_clk_override; // @[dec_decode_ctl.scala 625:53]
  reg  nonblock_load_valid_m_delay; // @[Reg.scala 27:20]
  reg  r_d_bits_i0load; // @[el2_lib.scala 524:16]
  wire  i0_load_kill_wen_r = nonblock_load_valid_m_delay & r_d_bits_i0load; // @[dec_decode_ctl.scala 289:56]
  wire [2:0] _GEN_130 = {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_inv_tag_r}; // @[dec_decode_ctl.scala 291:66]
  wire  _T_91 = _GEN_130 == cam_raw_0_bits_tag; // @[dec_decode_ctl.scala 291:66]
  wire  _T_92 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_91; // @[dec_decode_ctl.scala 291:45]
  wire  cam_inv_reset_val_0 = _T_92 & cam_0_valid; // @[dec_decode_ctl.scala 291:87]
  reg  r_d_bits_i0v; // @[el2_lib.scala 524:16]
  wire  _T_746 = ~io_dec_tlu_flush_lower_wb; // @[dec_decode_ctl.scala 657:51]
  wire  r_d_in_bits_i0v = r_d_bits_i0v & _T_746; // @[dec_decode_ctl.scala 657:49]
  wire  _T_757 = ~io_dec_tlu_i0_kill_writeb_r; // @[dec_decode_ctl.scala 665:47]
  wire  i0_wen_r = r_d_in_bits_i0v & _T_757; // @[dec_decode_ctl.scala 665:45]
  reg [4:0] r_d_bits_i0rd; // @[el2_lib.scala 524:16]
  reg [4:0] cam_raw_0_bits_rd; // @[dec_decode_ctl.scala 317:47]
  wire  _T_103 = r_d_bits_i0rd == cam_raw_0_bits_rd; // @[dec_decode_ctl.scala 304:85]
  wire  _T_104 = i0_wen_r & _T_103; // @[dec_decode_ctl.scala 304:64]
  reg  cam_raw_0_bits_wb; // @[dec_decode_ctl.scala 317:47]
  wire  _T_106 = _T_104 & cam_raw_0_bits_wb; // @[dec_decode_ctl.scala 304:105]
  wire  _T_107 = cam_inv_reset_val_0 | _T_106; // @[dec_decode_ctl.scala 304:44]
  wire  _GEN_52 = _T_107 ? 1'h0 : cam_0_valid; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_55 = _T_107 ? 1'h0 : cam_raw_0_bits_wb; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_56 = cam_wen[0] | _GEN_52; // @[dec_decode_ctl.scala 299:28]
  wire  _GEN_57 = cam_wen[0] ? 1'h0 : _GEN_55; // @[dec_decode_ctl.scala 299:28]
  wire  _T_110 = nonblock_load_valid_m_delay & _T_91; // @[dec_decode_ctl.scala 309:44]
  wire  _T_112 = _T_110 & cam_0_valid; // @[dec_decode_ctl.scala 309:113]
  wire  nonblock_load_write_0 = _T_94 & cam_raw_0_valid; // @[dec_decode_ctl.scala 318:71]
  wire  _T_117 = _GEN_130 == cam_raw_1_bits_tag; // @[dec_decode_ctl.scala 291:66]
  wire  _T_118 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_117; // @[dec_decode_ctl.scala 291:45]
  wire  cam_inv_reset_val_1 = _T_118 & cam_1_valid; // @[dec_decode_ctl.scala 291:87]
  reg [4:0] cam_raw_1_bits_rd; // @[dec_decode_ctl.scala 317:47]
  wire  _T_129 = r_d_bits_i0rd == cam_raw_1_bits_rd; // @[dec_decode_ctl.scala 304:85]
  wire  _T_130 = i0_wen_r & _T_129; // @[dec_decode_ctl.scala 304:64]
  reg  cam_raw_1_bits_wb; // @[dec_decode_ctl.scala 317:47]
  wire  _T_132 = _T_130 & cam_raw_1_bits_wb; // @[dec_decode_ctl.scala 304:105]
  wire  _T_133 = cam_inv_reset_val_1 | _T_132; // @[dec_decode_ctl.scala 304:44]
  wire  _GEN_63 = _T_133 ? 1'h0 : cam_1_valid; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_66 = _T_133 ? 1'h0 : cam_raw_1_bits_wb; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_67 = cam_wen[1] | _GEN_63; // @[dec_decode_ctl.scala 299:28]
  wire  _GEN_68 = cam_wen[1] ? 1'h0 : _GEN_66; // @[dec_decode_ctl.scala 299:28]
  wire  _T_136 = nonblock_load_valid_m_delay & _T_117; // @[dec_decode_ctl.scala 309:44]
  wire  _T_138 = _T_136 & cam_1_valid; // @[dec_decode_ctl.scala 309:113]
  wire  nonblock_load_write_1 = _T_120 & cam_raw_1_valid; // @[dec_decode_ctl.scala 318:71]
  wire  _T_143 = _GEN_130 == cam_raw_2_bits_tag; // @[dec_decode_ctl.scala 291:66]
  wire  _T_144 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_143; // @[dec_decode_ctl.scala 291:45]
  wire  cam_inv_reset_val_2 = _T_144 & cam_2_valid; // @[dec_decode_ctl.scala 291:87]
  reg [4:0] cam_raw_2_bits_rd; // @[dec_decode_ctl.scala 317:47]
  wire  _T_155 = r_d_bits_i0rd == cam_raw_2_bits_rd; // @[dec_decode_ctl.scala 304:85]
  wire  _T_156 = i0_wen_r & _T_155; // @[dec_decode_ctl.scala 304:64]
  reg  cam_raw_2_bits_wb; // @[dec_decode_ctl.scala 317:47]
  wire  _T_158 = _T_156 & cam_raw_2_bits_wb; // @[dec_decode_ctl.scala 304:105]
  wire  _T_159 = cam_inv_reset_val_2 | _T_158; // @[dec_decode_ctl.scala 304:44]
  wire  _GEN_74 = _T_159 ? 1'h0 : cam_2_valid; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_77 = _T_159 ? 1'h0 : cam_raw_2_bits_wb; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_78 = cam_wen[2] | _GEN_74; // @[dec_decode_ctl.scala 299:28]
  wire  _GEN_79 = cam_wen[2] ? 1'h0 : _GEN_77; // @[dec_decode_ctl.scala 299:28]
  wire  _T_162 = nonblock_load_valid_m_delay & _T_143; // @[dec_decode_ctl.scala 309:44]
  wire  _T_164 = _T_162 & cam_2_valid; // @[dec_decode_ctl.scala 309:113]
  wire  nonblock_load_write_2 = _T_146 & cam_raw_2_valid; // @[dec_decode_ctl.scala 318:71]
  wire  _T_169 = _GEN_130 == cam_raw_3_bits_tag; // @[dec_decode_ctl.scala 291:66]
  wire  _T_170 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_169; // @[dec_decode_ctl.scala 291:45]
  wire  cam_inv_reset_val_3 = _T_170 & cam_3_valid; // @[dec_decode_ctl.scala 291:87]
  reg [4:0] cam_raw_3_bits_rd; // @[dec_decode_ctl.scala 317:47]
  wire  _T_181 = r_d_bits_i0rd == cam_raw_3_bits_rd; // @[dec_decode_ctl.scala 304:85]
  wire  _T_182 = i0_wen_r & _T_181; // @[dec_decode_ctl.scala 304:64]
  reg  cam_raw_3_bits_wb; // @[dec_decode_ctl.scala 317:47]
  wire  _T_184 = _T_182 & cam_raw_3_bits_wb; // @[dec_decode_ctl.scala 304:105]
  wire  _T_185 = cam_inv_reset_val_3 | _T_184; // @[dec_decode_ctl.scala 304:44]
  wire  _GEN_85 = _T_185 ? 1'h0 : cam_3_valid; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_88 = _T_185 ? 1'h0 : cam_raw_3_bits_wb; // @[dec_decode_ctl.scala 304:131]
  wire  _GEN_89 = cam_wen[3] | _GEN_85; // @[dec_decode_ctl.scala 299:28]
  wire  _GEN_90 = cam_wen[3] ? 1'h0 : _GEN_88; // @[dec_decode_ctl.scala 299:28]
  wire  _T_188 = nonblock_load_valid_m_delay & _T_169; // @[dec_decode_ctl.scala 309:44]
  wire  _T_190 = _T_188 & cam_3_valid; // @[dec_decode_ctl.scala 309:113]
  wire  nonblock_load_write_3 = _T_172 & cam_raw_3_valid; // @[dec_decode_ctl.scala 318:71]
  wire  _T_195 = r_d_bits_i0rd == io_dec_nonblock_load_waddr; // @[dec_decode_ctl.scala 323:49]
  wire  nonblock_load_cancel = _T_195 & i0_wen_r; // @[dec_decode_ctl.scala 323:81]
  wire  _T_196 = nonblock_load_write_0 | nonblock_load_write_1; // @[dec_decode_ctl.scala 324:108]
  wire  _T_197 = _T_196 | nonblock_load_write_2; // @[dec_decode_ctl.scala 324:108]
  wire  _T_198 = _T_197 | nonblock_load_write_3; // @[dec_decode_ctl.scala 324:108]
  wire  _T_200 = io_dctl_busbuff_lsu_nonblock_load_data_valid & _T_198; // @[dec_decode_ctl.scala 324:77]
  wire  _T_201 = ~nonblock_load_cancel; // @[dec_decode_ctl.scala 324:122]
  wire  _T_203 = nonblock_load_rd == i0r_rs1; // @[dec_decode_ctl.scala 325:54]
  wire  _T_204 = _T_203 & io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[dec_decode_ctl.scala 325:66]
  wire  _T_205 = _T_204 & io_decode_exu_dec_i0_rs1_en_d; // @[dec_decode_ctl.scala 325:110]
  wire [4:0] i0r_rs2 = io_dec_i0_instr_d[24:20]; // @[dec_decode_ctl.scala 591:16]
  wire  _T_206 = nonblock_load_rd == i0r_rs2; // @[dec_decode_ctl.scala 325:161]
  wire  _T_207 = _T_206 & io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[dec_decode_ctl.scala 325:173]
  wire  _T_208 = _T_207 & io_decode_exu_dec_i0_rs2_en_d; // @[dec_decode_ctl.scala 325:217]
  wire  i0_nonblock_boundary_stall = _T_205 | _T_208; // @[dec_decode_ctl.scala 325:142]
  wire [4:0] _T_210 = nonblock_load_write_0 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_211 = _T_210 & cam_raw_0_bits_rd; // @[dec_decode_ctl.scala 329:88]
  wire  _T_212 = io_decode_exu_dec_i0_rs1_en_d & cam_0_valid; // @[dec_decode_ctl.scala 329:137]
  wire  _T_213 = cam_raw_0_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 329:170]
  wire  _T_214 = _T_212 & _T_213; // @[dec_decode_ctl.scala 329:152]
  wire  _T_215 = io_decode_exu_dec_i0_rs2_en_d & cam_0_valid; // @[dec_decode_ctl.scala 329:214]
  wire  _T_216 = cam_raw_0_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 329:247]
  wire  _T_217 = _T_215 & _T_216; // @[dec_decode_ctl.scala 329:229]
  wire [4:0] _T_219 = nonblock_load_write_1 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_220 = _T_219 & cam_raw_1_bits_rd; // @[dec_decode_ctl.scala 329:88]
  wire  _T_221 = io_decode_exu_dec_i0_rs1_en_d & cam_1_valid; // @[dec_decode_ctl.scala 329:137]
  wire  _T_222 = cam_raw_1_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 329:170]
  wire  _T_223 = _T_221 & _T_222; // @[dec_decode_ctl.scala 329:152]
  wire  _T_224 = io_decode_exu_dec_i0_rs2_en_d & cam_1_valid; // @[dec_decode_ctl.scala 329:214]
  wire  _T_225 = cam_raw_1_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 329:247]
  wire  _T_226 = _T_224 & _T_225; // @[dec_decode_ctl.scala 329:229]
  wire [4:0] _T_228 = nonblock_load_write_2 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_229 = _T_228 & cam_raw_2_bits_rd; // @[dec_decode_ctl.scala 329:88]
  wire  _T_230 = io_decode_exu_dec_i0_rs1_en_d & cam_2_valid; // @[dec_decode_ctl.scala 329:137]
  wire  _T_231 = cam_raw_2_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 329:170]
  wire  _T_232 = _T_230 & _T_231; // @[dec_decode_ctl.scala 329:152]
  wire  _T_233 = io_decode_exu_dec_i0_rs2_en_d & cam_2_valid; // @[dec_decode_ctl.scala 329:214]
  wire  _T_234 = cam_raw_2_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 329:247]
  wire  _T_235 = _T_233 & _T_234; // @[dec_decode_ctl.scala 329:229]
  wire [4:0] _T_237 = nonblock_load_write_3 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_238 = _T_237 & cam_raw_3_bits_rd; // @[dec_decode_ctl.scala 329:88]
  wire  _T_239 = io_decode_exu_dec_i0_rs1_en_d & cam_3_valid; // @[dec_decode_ctl.scala 329:137]
  wire  _T_240 = cam_raw_3_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 329:170]
  wire  _T_241 = _T_239 & _T_240; // @[dec_decode_ctl.scala 329:152]
  wire  _T_242 = io_decode_exu_dec_i0_rs2_en_d & cam_3_valid; // @[dec_decode_ctl.scala 329:214]
  wire  _T_243 = cam_raw_3_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 329:247]
  wire  _T_244 = _T_242 & _T_243; // @[dec_decode_ctl.scala 329:229]
  wire [4:0] _T_245 = _T_211 | _T_220; // @[dec_decode_ctl.scala 330:69]
  wire [4:0] _T_246 = _T_245 | _T_229; // @[dec_decode_ctl.scala 330:69]
  wire  _T_247 = _T_214 | _T_223; // @[dec_decode_ctl.scala 330:102]
  wire  _T_248 = _T_247 | _T_232; // @[dec_decode_ctl.scala 330:102]
  wire  ld_stall_1 = _T_248 | _T_241; // @[dec_decode_ctl.scala 330:102]
  wire  _T_249 = _T_217 | _T_226; // @[dec_decode_ctl.scala 330:134]
  wire  _T_250 = _T_249 | _T_235; // @[dec_decode_ctl.scala 330:134]
  wire  ld_stall_2 = _T_250 | _T_244; // @[dec_decode_ctl.scala 330:134]
  wire  _T_251 = ld_stall_1 | ld_stall_2; // @[dec_decode_ctl.scala 332:38]
  wire  i0_nonblock_load_stall = _T_251 | i0_nonblock_boundary_stall; // @[dec_decode_ctl.scala 332:51]
  wire  _T_253 = ~i0_predict_br; // @[dec_decode_ctl.scala 341:34]
  wire [3:0] _T_255 = i0_legal_decode_d ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire  csr_read = i0_dp_csr_read & i0_legal_decode_d; // @[dec_decode_ctl.scala 425:36]
  wire  _T_256 = csr_read & io_dec_csr_wen_unq_d; // @[dec_decode_ctl.scala 353:16]
  wire  _T_258 = ~csr_read; // @[dec_decode_ctl.scala 354:6]
  wire  _T_259 = _T_258 & io_dec_csr_wen_unq_d; // @[dec_decode_ctl.scala 354:16]
  wire  _T_261 = ~io_dec_csr_wen_unq_d; // @[dec_decode_ctl.scala 355:18]
  wire  _T_262 = csr_read & _T_261; // @[dec_decode_ctl.scala 355:16]
  wire [3:0] _T_264 = i0_dp_mul ? 4'h1 : 4'h0; // @[Mux.scala 98:16]
  wire [3:0] _T_265 = i0_dp_load ? 4'h2 : _T_264; // @[Mux.scala 98:16]
  wire [3:0] _T_266 = i0_dp_store ? 4'h3 : _T_265; // @[Mux.scala 98:16]
  wire [3:0] _T_267 = i0_dp_pm_alu ? 4'h4 : _T_266; // @[Mux.scala 98:16]
  wire [3:0] _T_268 = _T_262 ? 4'h5 : _T_267; // @[Mux.scala 98:16]
  wire [3:0] _T_269 = _T_259 ? 4'h6 : _T_268; // @[Mux.scala 98:16]
  wire [3:0] _T_270 = _T_256 ? 4'h7 : _T_269; // @[Mux.scala 98:16]
  wire [3:0] _T_271 = i0_dp_ebreak ? 4'h8 : _T_270; // @[Mux.scala 98:16]
  wire [3:0] _T_272 = i0_dp_ecall ? 4'h9 : _T_271; // @[Mux.scala 98:16]
  wire [3:0] _T_273 = i0_dp_fence ? 4'ha : _T_272; // @[Mux.scala 98:16]
  wire [3:0] _T_274 = i0_dp_fence_i ? 4'hb : _T_273; // @[Mux.scala 98:16]
  wire [3:0] _T_275 = i0_dp_mret ? 4'hc : _T_274; // @[Mux.scala 98:16]
  wire [3:0] _T_276 = i0_dp_condbr ? 4'hd : _T_275; // @[Mux.scala 98:16]
  wire [3:0] _T_277 = i0_dp_jal ? 4'he : _T_276; // @[Mux.scala 98:16]
  reg  lsu_idle; // @[dec_decode_ctl.scala 366:45]
  wire  _T_333 = ~i0_pcall_case; // @[dec_decode_ctl.scala 390:35]
  wire  _T_334 = i0_dp_jal & _T_333; // @[dec_decode_ctl.scala 390:32]
  wire  _T_335 = ~i0_pja_case; // @[dec_decode_ctl.scala 390:52]
  wire  _T_336 = _T_334 & _T_335; // @[dec_decode_ctl.scala 390:50]
  wire  _T_337 = ~i0_pret_case; // @[dec_decode_ctl.scala 390:67]
  reg  _T_339; // @[dec_decode_ctl.scala 402:69]
  wire  lsu_decode_d = i0_legal_decode_d & i0_dp_lsu; // @[dec_decode_ctl.scala 544:40]
  wire  _T_905 = i0_dp_load | i0_dp_store; // @[dec_decode_ctl.scala 758:43]
  reg  x_d_bits_i0v; // @[el2_lib.scala 524:16]
  wire  _T_879 = io_decode_exu_dec_i0_rs1_en_d & x_d_bits_i0v; // @[dec_decode_ctl.scala 738:59]
  wire  _T_880 = x_d_bits_i0rd == i0r_rs1; // @[dec_decode_ctl.scala 738:91]
  wire  i0_rs1_depend_i0_x = _T_879 & _T_880; // @[dec_decode_ctl.scala 738:74]
  wire  _T_881 = io_decode_exu_dec_i0_rs1_en_d & r_d_bits_i0v; // @[dec_decode_ctl.scala 739:59]
  wire  _T_882 = r_d_bits_i0rd == i0r_rs1; // @[dec_decode_ctl.scala 739:91]
  wire  i0_rs1_depend_i0_r = _T_881 & _T_882; // @[dec_decode_ctl.scala 739:74]
  wire [1:0] _T_894 = i0_rs1_depend_i0_r ? 2'h2 : 2'h0; // @[dec_decode_ctl.scala 745:63]
  wire [1:0] i0_rs1_depth_d = i0_rs1_depend_i0_x ? 2'h1 : _T_894; // @[dec_decode_ctl.scala 745:24]
  wire  _T_907 = _T_905 & i0_rs1_depth_d[0]; // @[dec_decode_ctl.scala 758:58]
  reg  i0_x_c_load; // @[Reg.scala 15:16]
  reg  i0_r_c_load; // @[Reg.scala 15:16]
  wire  _T_890_load = i0_rs1_depend_i0_r & i0_r_c_load; // @[dec_decode_ctl.scala 744:61]
  wire  i0_rs1_class_d_load = i0_rs1_depend_i0_x ? i0_x_c_load : _T_890_load; // @[dec_decode_ctl.scala 744:24]
  wire  load_ldst_bypass_d = _T_907 & i0_rs1_class_d_load; // @[dec_decode_ctl.scala 758:78]
  wire  _T_883 = io_decode_exu_dec_i0_rs2_en_d & x_d_bits_i0v; // @[dec_decode_ctl.scala 741:59]
  wire  _T_884 = x_d_bits_i0rd == i0r_rs2; // @[dec_decode_ctl.scala 741:91]
  wire  i0_rs2_depend_i0_x = _T_883 & _T_884; // @[dec_decode_ctl.scala 741:74]
  wire  _T_885 = io_decode_exu_dec_i0_rs2_en_d & r_d_bits_i0v; // @[dec_decode_ctl.scala 742:59]
  wire  _T_886 = r_d_bits_i0rd == i0r_rs2; // @[dec_decode_ctl.scala 742:91]
  wire  i0_rs2_depend_i0_r = _T_885 & _T_886; // @[dec_decode_ctl.scala 742:74]
  wire [1:0] _T_903 = i0_rs2_depend_i0_r ? 2'h2 : 2'h0; // @[dec_decode_ctl.scala 747:63]
  wire [1:0] i0_rs2_depth_d = i0_rs2_depend_i0_x ? 2'h1 : _T_903; // @[dec_decode_ctl.scala 747:24]
  wire  _T_910 = i0_dp_store & i0_rs2_depth_d[0]; // @[dec_decode_ctl.scala 759:43]
  wire  _T_899_load = i0_rs2_depend_i0_r & i0_r_c_load; // @[dec_decode_ctl.scala 746:61]
  wire  i0_rs2_class_d_load = i0_rs2_depend_i0_x ? i0_x_c_load : _T_899_load; // @[dec_decode_ctl.scala 746:24]
  wire  store_data_bypass_d = _T_910 & i0_rs2_class_d_load; // @[dec_decode_ctl.scala 759:63]
  wire  _T_349 = i0_dp_csr_clr | i0_dp_csr_set; // @[dec_decode_ctl.scala 433:42]
  reg  r_d_bits_csrwen; // @[el2_lib.scala 524:16]
  reg  r_d_valid; // @[el2_lib.scala 524:16]
  wire  _T_352 = r_d_bits_csrwen & r_d_valid; // @[dec_decode_ctl.scala 441:39]
  reg [11:0] r_d_bits_csrwaddr; // @[el2_lib.scala 524:16]
  wire  _T_355 = r_d_bits_csrwaddr == 12'h300; // @[dec_decode_ctl.scala 444:50]
  wire  _T_356 = r_d_bits_csrwaddr == 12'h304; // @[dec_decode_ctl.scala 444:85]
  wire  _T_357 = _T_355 | _T_356; // @[dec_decode_ctl.scala 444:64]
  wire  _T_358 = _T_357 & r_d_bits_csrwen; // @[dec_decode_ctl.scala 444:100]
  wire  _T_359 = _T_358 & r_d_valid; // @[dec_decode_ctl.scala 444:118]
  wire  _T_360 = ~io_dec_tlu_i0_kill_writeb_wb; // @[dec_decode_ctl.scala 444:132]
  reg  csr_read_x; // @[dec_decode_ctl.scala 446:52]
  reg  csr_clr_x; // @[dec_decode_ctl.scala 447:51]
  reg  csr_set_x; // @[dec_decode_ctl.scala 448:51]
  reg  csr_write_x; // @[dec_decode_ctl.scala 449:53]
  reg  csr_imm_x; // @[dec_decode_ctl.scala 450:51]
  wire  i0_x_data_en = i0_pipe_en[3] | io_clk_override; // @[dec_decode_ctl.scala 627:50]
  reg [4:0] csrimm_x; // @[el2_lib.scala 514:16]
  reg [31:0] csr_rddata_x; // @[el2_lib.scala 514:16]
  wire [31:0] _T_394 = {27'h0,csrimm_x}; // @[Cat.scala 29:58]
  wire  _T_396 = ~csr_imm_x; // @[dec_decode_ctl.scala 458:5]
  wire [31:0] _T_397 = csr_imm_x ? _T_394 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_398 = _T_396 ? io_decode_exu_exu_csr_rs1_x : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] csr_mask_x = _T_397 | _T_398; // @[Mux.scala 27:72]
  wire [31:0] _T_400 = ~csr_mask_x; // @[dec_decode_ctl.scala 461:38]
  wire [31:0] _T_401 = csr_rddata_x & _T_400; // @[dec_decode_ctl.scala 461:35]
  wire [31:0] _T_402 = csr_rddata_x | csr_mask_x; // @[dec_decode_ctl.scala 462:35]
  wire [31:0] _T_403 = csr_clr_x ? _T_401 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_404 = csr_set_x ? _T_402 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_405 = csr_write_x ? csr_mask_x : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_406 = _T_403 | _T_404; // @[Mux.scala 27:72]
  wire [31:0] write_csr_data_x = _T_406 | _T_405; // @[Mux.scala 27:72]
  wire  _T_421 = ~tlu_wr_pause_r1; // @[dec_decode_ctl.scala 472:44]
  wire  _T_422 = ~tlu_wr_pause_r2; // @[dec_decode_ctl.scala 472:64]
  wire  _T_423 = _T_421 & _T_422; // @[dec_decode_ctl.scala 472:61]
  wire [31:0] _T_426 = write_csr_data - 32'h1; // @[dec_decode_ctl.scala 475:59]
  wire  _T_428 = csr_clr_x | csr_set_x; // @[dec_decode_ctl.scala 477:34]
  wire  _T_429 = _T_428 | csr_write_x; // @[dec_decode_ctl.scala 477:46]
  wire  _T_430 = _T_429 & csr_read_x; // @[dec_decode_ctl.scala 477:61]
  wire  _T_431 = _T_430 | io_dec_tlu_wr_pause_r; // @[dec_decode_ctl.scala 477:75]
  reg  r_d_bits_csrwonly; // @[el2_lib.scala 524:16]
  wire  _T_767 = r_d_bits_i0v & r_d_bits_i0load; // @[dec_decode_ctl.scala 680:42]
  reg [31:0] i0_result_r_raw; // @[el2_lib.scala 514:16]
  wire [31:0] i0_result_corr_r = _T_767 ? io_lsu_result_corr_r : i0_result_r_raw; // @[dec_decode_ctl.scala 680:27]
  reg  x_d_bits_csrwonly; // @[el2_lib.scala 524:16]
  wire  _T_435 = x_d_bits_csrwonly | r_d_bits_csrwonly; // @[dec_decode_ctl.scala 486:43]
  reg  wbd_bits_csrwonly; // @[el2_lib.scala 524:16]
  wire  prior_csr_write = _T_435 | wbd_bits_csrwonly; // @[dec_decode_ctl.scala 486:63]
  wire  debug_fence_raw = io_dec_debug_fence_d & io_dbg_dctl_dbg_cmd_wrdata[1]; // @[dec_decode_ctl.scala 489:48]
  wire  debug_fence = debug_fence_raw | debug_fence_i; // @[dec_decode_ctl.scala 490:40]
  wire  _T_439 = i0_dp_presync | io_dec_tlu_presync_d; // @[dec_decode_ctl.scala 493:34]
  wire  _T_440 = _T_439 | debug_fence_i; // @[dec_decode_ctl.scala 493:57]
  wire  _T_441 = _T_440 | debug_fence_raw; // @[dec_decode_ctl.scala 493:73]
  wire  i0_presync = _T_441 | io_dec_tlu_pipelining_disable; // @[dec_decode_ctl.scala 493:91]
  wire [31:0] _T_465 = {16'h0,io_dec_aln_ifu_i0_cinst}; // @[Cat.scala 29:58]
  wire  _T_467 = ~illegal_lockout; // @[dec_decode_ctl.scala 505:44]
  reg [31:0] _T_468; // @[el2_lib.scala 514:16]
  wire  i0_div_prior_div_stall = i0_dp_div & io_dec_div_active; // @[dec_decode_ctl.scala 509:42]
  wire  _T_473 = i0_dp_csr_read & prior_csr_write; // @[dec_decode_ctl.scala 511:40]
  wire  _T_474 = _T_473 | io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 511:59]
  wire  _T_475 = _T_474 | pause_stall; // @[dec_decode_ctl.scala 511:92]
  wire  _T_476 = _T_475 | leak1_i0_stall; // @[dec_decode_ctl.scala 511:106]
  wire  _T_477 = _T_476 | io_dec_tlu_debug_stall; // @[dec_decode_ctl.scala 512:20]
  wire  _T_478 = _T_477 | postsync_stall; // @[dec_decode_ctl.scala 512:45]
  wire  prior_inflight = x_d_valid | r_d_valid; // @[dec_decode_ctl.scala 534:41]
  wire  prior_inflight_eff = i0_dp_div ? x_d_valid : prior_inflight; // @[dec_decode_ctl.scala 535:31]
  wire  presync_stall = i0_presync & prior_inflight_eff; // @[dec_decode_ctl.scala 537:37]
  wire  _T_479 = _T_478 | presync_stall; // @[dec_decode_ctl.scala 512:62]
  wire  _T_480 = i0_dp_fence | debug_fence; // @[dec_decode_ctl.scala 513:19]
  wire  _T_481 = ~lsu_idle; // @[dec_decode_ctl.scala 513:36]
  wire  _T_482 = _T_480 & _T_481; // @[dec_decode_ctl.scala 513:34]
  wire  _T_483 = _T_479 | _T_482; // @[dec_decode_ctl.scala 512:79]
  wire  _T_484 = _T_483 | i0_nonblock_load_stall; // @[dec_decode_ctl.scala 513:47]
  wire  _T_825 = io_decode_exu_dec_i0_rs1_en_d & io_dec_div_active; // @[dec_decode_ctl.scala 708:60]
  wire  _T_826 = io_div_waddr_wb == i0r_rs1; // @[dec_decode_ctl.scala 708:99]
  wire  _T_827 = _T_825 & _T_826; // @[dec_decode_ctl.scala 708:80]
  wire  _T_828 = io_decode_exu_dec_i0_rs2_en_d & io_dec_div_active; // @[dec_decode_ctl.scala 709:36]
  wire  _T_829 = io_div_waddr_wb == i0r_rs2; // @[dec_decode_ctl.scala 709:75]
  wire  _T_830 = _T_828 & _T_829; // @[dec_decode_ctl.scala 709:56]
  wire  i0_nonblock_div_stall = _T_827 | _T_830; // @[dec_decode_ctl.scala 708:113]
  wire  _T_486 = _T_484 | i0_nonblock_div_stall; // @[dec_decode_ctl.scala 514:21]
  wire  i0_block_raw_d = _T_486 | i0_div_prior_div_stall; // @[dec_decode_ctl.scala 514:45]
  wire  _T_487 = io_lsu_store_stall_any | io_dctl_dma_dma_dccm_stall_any; // @[dec_decode_ctl.scala 516:65]
  wire  i0_store_stall_d = i0_dp_store & _T_487; // @[dec_decode_ctl.scala 516:39]
  wire  _T_488 = io_lsu_load_stall_any | io_dctl_dma_dma_dccm_stall_any; // @[dec_decode_ctl.scala 517:63]
  wire  i0_load_stall_d = i0_dp_load & _T_488; // @[dec_decode_ctl.scala 517:38]
  wire  _T_489 = i0_block_raw_d | i0_store_stall_d; // @[dec_decode_ctl.scala 518:38]
  wire  i0_block_d = _T_489 | i0_load_stall_d; // @[dec_decode_ctl.scala 518:57]
  wire  _T_490 = ~i0_block_d; // @[dec_decode_ctl.scala 522:54]
  wire  _T_491 = io_dec_ib0_valid_d & _T_490; // @[dec_decode_ctl.scala 522:52]
  wire  _T_493 = _T_491 & _T_280; // @[dec_decode_ctl.scala 522:69]
  wire  _T_496 = ~i0_block_raw_d; // @[dec_decode_ctl.scala 523:46]
  wire  _T_497 = io_dec_ib0_valid_d & _T_496; // @[dec_decode_ctl.scala 523:44]
  wire  _T_499 = _T_497 & _T_280; // @[dec_decode_ctl.scala 523:61]
  wire  i0_exudecode_d = _T_499 & _T_470; // @[dec_decode_ctl.scala 523:89]
  wire  i0_exulegal_decode_d = i0_exudecode_d & i0_legal; // @[dec_decode_ctl.scala 524:46]
  wire  _T_501 = ~io_dec_aln_dec_i0_decode_d; // @[dec_decode_ctl.scala 528:51]
  wire  _T_520 = i0_dp_fence_i | debug_fence_i; // @[dec_decode_ctl.scala 556:44]
  wire [3:0] _T_525 = {io_dec_aln_dec_i0_decode_d,io_dec_aln_dec_i0_decode_d,io_dec_aln_dec_i0_decode_d,io_dec_aln_dec_i0_decode_d}; // @[Cat.scala 29:58]
  wire  _T_707 = |i0_pipe_en[3:2]; // @[dec_decode_ctl.scala 624:49]
  wire  i0_x_ctl_en = _T_707 | io_clk_override; // @[dec_decode_ctl.scala 624:53]
  reg  x_t_legal; // @[el2_lib.scala 524:16]
  reg  x_t_icaf; // @[el2_lib.scala 524:16]
  reg  x_t_icaf_f1; // @[el2_lib.scala 524:16]
  reg [1:0] x_t_icaf_type; // @[el2_lib.scala 524:16]
  reg  x_t_fence_i; // @[el2_lib.scala 524:16]
  reg [3:0] x_t_i0trigger; // @[el2_lib.scala 524:16]
  reg [3:0] x_t_pmu_i0_itype; // @[el2_lib.scala 524:16]
  reg  x_t_pmu_i0_br_unpred; // @[el2_lib.scala 524:16]
  wire [3:0] _T_533 = {io_dec_tlu_flush_lower_wb,io_dec_tlu_flush_lower_wb,io_dec_tlu_flush_lower_wb,io_dec_tlu_flush_lower_wb}; // @[Cat.scala 29:58]
  wire [3:0] _T_534 = ~_T_533; // @[dec_decode_ctl.scala 569:39]
  reg  r_t_legal; // @[el2_lib.scala 524:16]
  reg  r_t_icaf; // @[el2_lib.scala 524:16]
  reg  r_t_icaf_f1; // @[el2_lib.scala 524:16]
  reg [1:0] r_t_icaf_type; // @[el2_lib.scala 524:16]
  reg  r_t_fence_i; // @[el2_lib.scala 524:16]
  reg [3:0] r_t_i0trigger; // @[el2_lib.scala 524:16]
  reg [3:0] r_t_pmu_i0_itype; // @[el2_lib.scala 524:16]
  reg  r_t_pmu_i0_br_unpred; // @[el2_lib.scala 524:16]
  reg [3:0] lsu_trigger_match_r; // @[dec_decode_ctl.scala 572:36]
  reg  lsu_pmu_misaligned_r; // @[dec_decode_ctl.scala 573:37]
  reg  r_d_bits_i0store; // @[el2_lib.scala 524:16]
  wire  _T_539 = r_d_bits_i0load | r_d_bits_i0store; // @[dec_decode_ctl.scala 577:61]
  wire [3:0] _T_543 = {_T_539,_T_539,_T_539,_T_539}; // @[Cat.scala 29:58]
  wire [3:0] _T_544 = _T_543 & lsu_trigger_match_r; // @[dec_decode_ctl.scala 577:82]
  wire [3:0] _T_545 = _T_544 | r_t_i0trigger; // @[dec_decode_ctl.scala 577:105]
  reg  r_d_bits_i0div; // @[el2_lib.scala 524:16]
  wire  _T_548 = r_d_bits_i0div & r_d_valid; // @[dec_decode_ctl.scala 583:58]
  wire  _T_559 = i0r_rs1 != 5'h0; // @[dec_decode_ctl.scala 594:60]
  wire  _T_561 = i0r_rs2 != 5'h0; // @[dec_decode_ctl.scala 595:60]
  wire  _T_563 = i0r_rd != 5'h0; // @[dec_decode_ctl.scala 596:48]
  wire  i0_rd_en_d = i0_dp_rd & _T_563; // @[dec_decode_ctl.scala 596:37]
  wire  i0_jalimm20 = i0_dp_jal & i0_dp_imm20; // @[dec_decode_ctl.scala 600:38]
  wire  _T_564 = ~i0_dp_jal; // @[dec_decode_ctl.scala 601:27]
  wire  i0_uiimm20 = _T_564 & i0_dp_imm20; // @[dec_decode_ctl.scala 601:38]
  wire [31:0] _T_566 = i0_dp_csr_read ? io_dec_csr_rddata_d : 32'h0; // @[Mux.scala 27:72]
  wire [9:0] _T_580 = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31]}; // @[Cat.scala 29:58]
  wire [18:0] _T_589 = {_T_580,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31]}; // @[Cat.scala 29:58]
  wire [31:0] _T_592 = {_T_589,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31:20]}; // @[Cat.scala 29:58]
  wire [31:0] _T_687 = i0_dp_imm12 ? _T_592 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_621 = {27'h0,i0r_rs2}; // @[Cat.scala 29:58]
  wire [31:0] _T_688 = i0_dp_shimm5 ? _T_621 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_692 = _T_687 | _T_688; // @[Mux.scala 27:72]
  wire [31:0] _T_641 = {_T_580,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[19:12],io_dec_i0_instr_d[20],io_dec_i0_instr_d[30:21],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_689 = i0_jalimm20 ? _T_641 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_693 = _T_692 | _T_689; // @[Mux.scala 27:72]
  wire [31:0] _T_655 = {io_dec_i0_instr_d[31:12],12'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_690 = i0_uiimm20 ? _T_655 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_694 = _T_693 | _T_690; // @[Mux.scala 27:72]
  wire  _T_656 = i0_csr_write_only_d & i0_dp_csr_imm; // @[dec_decode_ctl.scala 612:26]
  wire [31:0] _T_686 = {27'h0,i0r_rs1}; // @[Cat.scala 29:58]
  wire [31:0] _T_691 = _T_656 ? _T_686 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] i0_immed_d = _T_694 | _T_691; // @[Mux.scala 27:72]
  wire [31:0] _T_567 = _T_347 ? i0_immed_d : 32'h0; // @[Mux.scala 27:72]
  wire  i0_d_c_mul = i0_dp_mul & i0_legal_decode_d; // @[dec_decode_ctl.scala 616:44]
  wire  i0_d_c_load = i0_dp_load & i0_legal_decode_d; // @[dec_decode_ctl.scala 617:44]
  wire  i0_d_c_alu = i0_dp_alu & i0_legal_decode_d; // @[dec_decode_ctl.scala 618:44]
  reg  i0_x_c_mul; // @[Reg.scala 15:16]
  reg  i0_x_c_alu; // @[Reg.scala 15:16]
  reg  i0_r_c_mul; // @[Reg.scala 15:16]
  reg  i0_r_c_alu; // @[Reg.scala 15:16]
  wire  _T_713 = |i0_pipe_en[1:0]; // @[dec_decode_ctl.scala 626:49]
  wire  i0_r_data_en = i0_pipe_en[2] | io_clk_override; // @[dec_decode_ctl.scala 628:50]
  reg  x_d_bits_i0store; // @[el2_lib.scala 524:16]
  reg  x_d_bits_i0div; // @[el2_lib.scala 524:16]
  reg  x_d_bits_csrwen; // @[el2_lib.scala 524:16]
  reg [11:0] x_d_bits_csrwaddr; // @[el2_lib.scala 524:16]
  wire  _T_736 = x_d_bits_i0v & _T_746; // @[dec_decode_ctl.scala 650:47]
  wire  _T_740 = x_d_valid & _T_746; // @[dec_decode_ctl.scala 651:33]
  wire  _T_759 = ~r_d_bits_i0div; // @[dec_decode_ctl.scala 666:49]
  wire  _T_760 = i0_wen_r & _T_759; // @[dec_decode_ctl.scala 666:47]
  wire  _T_761 = ~i0_load_kill_wen_r; // @[dec_decode_ctl.scala 666:70]
  wire  _T_764 = x_d_bits_i0v & x_d_bits_i0load; // @[dec_decode_ctl.scala 675:47]
  wire  _T_771 = io_decode_exu_i0_ap_predict_nt & _T_564; // @[dec_decode_ctl.scala 681:71]
  wire [11:0] _T_784 = {10'h0,io_dec_i0_pc4_d,i0_ap_pc2}; // @[Cat.scala 29:58]
  reg [11:0] last_br_immed_x; // @[el2_lib.scala 514:16]
  wire  _T_802 = x_d_bits_i0div & x_d_valid; // @[dec_decode_ctl.scala 689:45]
  wire  div_e1_to_r = _T_802 | _T_548; // @[dec_decode_ctl.scala 689:58]
  wire  _T_805 = x_d_bits_i0rd == 5'h0; // @[dec_decode_ctl.scala 691:77]
  wire  _T_806 = _T_802 & _T_805; // @[dec_decode_ctl.scala 691:60]
  wire  _T_808 = _T_802 & io_dec_tlu_flush_lower_r; // @[dec_decode_ctl.scala 692:33]
  wire  _T_809 = _T_806 | _T_808; // @[dec_decode_ctl.scala 691:94]
  wire  _T_811 = _T_548 & io_dec_tlu_flush_lower_r; // @[dec_decode_ctl.scala 693:33]
  wire  _T_812 = _T_811 & io_dec_tlu_i0_kill_writeb_r; // @[dec_decode_ctl.scala 693:60]
  wire  div_flush = _T_809 | _T_812; // @[dec_decode_ctl.scala 692:62]
  wire  _T_813 = io_dec_div_active & div_flush; // @[dec_decode_ctl.scala 697:51]
  wire  _T_814 = ~div_e1_to_r; // @[dec_decode_ctl.scala 698:26]
  wire  _T_815 = io_dec_div_active & _T_814; // @[dec_decode_ctl.scala 698:24]
  wire  _T_816 = r_d_bits_i0rd == io_div_waddr_wb; // @[dec_decode_ctl.scala 698:56]
  wire  _T_817 = _T_815 & _T_816; // @[dec_decode_ctl.scala 698:39]
  wire  _T_818 = _T_817 & i0_wen_r; // @[dec_decode_ctl.scala 698:77]
  wire  nonblock_div_cancel = _T_813 | _T_818; // @[dec_decode_ctl.scala 697:65]
  wire  i0_div_decode_d = i0_legal_decode_d & i0_dp_div; // @[dec_decode_ctl.scala 701:55]
  wire  _T_820 = ~io_exu_div_wren; // @[dec_decode_ctl.scala 703:62]
  wire  _T_821 = io_dec_div_active & _T_820; // @[dec_decode_ctl.scala 703:60]
  wire  _T_822 = ~nonblock_div_cancel; // @[dec_decode_ctl.scala 703:81]
  wire  _T_823 = _T_821 & _T_822; // @[dec_decode_ctl.scala 703:79]
  reg  _T_824; // @[dec_decode_ctl.scala 705:54]
  reg [4:0] _T_833; // @[Reg.scala 27:20]
  reg [31:0] i0_inst_x; // @[el2_lib.scala 514:16]
  reg [31:0] i0_inst_r; // @[el2_lib.scala 514:16]
  reg [31:0] i0_inst_wb; // @[el2_lib.scala 514:16]
  reg [31:0] _T_840; // @[el2_lib.scala 514:16]
  reg [30:0] i0_pc_wb; // @[el2_lib.scala 514:16]
  reg [30:0] _T_843; // @[el2_lib.scala 514:16]
  reg [30:0] dec_i0_pc_r; // @[el2_lib.scala 514:16]
  wire [31:0] _T_845 = {io_dec_alu_exu_i0_pc_x,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_846 = {last_br_immed_x,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_849 = _T_845[12:1] + _T_846[12:1]; // @[el2_lib.scala 208:31]
  wire [18:0] _T_852 = _T_845[31:13] + 19'h1; // @[el2_lib.scala 209:27]
  wire [18:0] _T_855 = _T_845[31:13] - 19'h1; // @[el2_lib.scala 210:27]
  wire  _T_858 = ~_T_849[12]; // @[el2_lib.scala 212:28]
  wire  _T_859 = _T_846[12] ^ _T_858; // @[el2_lib.scala 212:26]
  wire  _T_862 = ~_T_846[12]; // @[el2_lib.scala 213:20]
  wire  _T_864 = _T_862 & _T_849[12]; // @[el2_lib.scala 213:26]
  wire  _T_868 = _T_846[12] & _T_858; // @[el2_lib.scala 214:26]
  wire [18:0] _T_870 = _T_859 ? _T_845[31:13] : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_871 = _T_864 ? _T_852 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_872 = _T_868 ? _T_855 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_873 = _T_870 | _T_871; // @[Mux.scala 27:72]
  wire [18:0] _T_874 = _T_873 | _T_872; // @[Mux.scala 27:72]
  wire [31:0] temp_pred_correct_npc_x = {_T_874,_T_849[11:0],1'h0}; // @[Cat.scala 29:58]
  wire  _T_890_mul = i0_rs1_depend_i0_r & i0_r_c_mul; // @[dec_decode_ctl.scala 744:61]
  wire  _T_890_alu = i0_rs1_depend_i0_r & i0_r_c_alu; // @[dec_decode_ctl.scala 744:61]
  wire  i0_rs1_class_d_mul = i0_rs1_depend_i0_x ? i0_x_c_mul : _T_890_mul; // @[dec_decode_ctl.scala 744:24]
  wire  i0_rs1_class_d_alu = i0_rs1_depend_i0_x ? i0_x_c_alu : _T_890_alu; // @[dec_decode_ctl.scala 744:24]
  wire  _T_899_mul = i0_rs2_depend_i0_r & i0_r_c_mul; // @[dec_decode_ctl.scala 746:61]
  wire  _T_899_alu = i0_rs2_depend_i0_r & i0_r_c_alu; // @[dec_decode_ctl.scala 746:61]
  wire  i0_rs2_class_d_mul = i0_rs2_depend_i0_x ? i0_x_c_mul : _T_899_mul; // @[dec_decode_ctl.scala 746:24]
  wire  i0_rs2_class_d_alu = i0_rs2_depend_i0_x ? i0_x_c_alu : _T_899_alu; // @[dec_decode_ctl.scala 746:24]
  wire  _T_912 = io_decode_exu_dec_i0_rs1_en_d & io_dec_nonblock_load_wen; // @[dec_decode_ctl.scala 764:73]
  wire  _T_913 = io_dec_nonblock_load_waddr == i0r_rs1; // @[dec_decode_ctl.scala 764:130]
  wire  i0_rs1_nonblock_load_bypass_en_d = _T_912 & _T_913; // @[dec_decode_ctl.scala 764:100]
  wire  _T_914 = io_decode_exu_dec_i0_rs2_en_d & io_dec_nonblock_load_wen; // @[dec_decode_ctl.scala 766:73]
  wire  _T_915 = io_dec_nonblock_load_waddr == i0r_rs2; // @[dec_decode_ctl.scala 766:130]
  wire  i0_rs2_nonblock_load_bypass_en_d = _T_914 & _T_915; // @[dec_decode_ctl.scala 766:100]
  wire  _T_917 = i0_rs1_class_d_alu | i0_rs1_class_d_mul; // @[dec_decode_ctl.scala 769:66]
  wire  _T_918 = i0_rs1_depth_d[0] & _T_917; // @[dec_decode_ctl.scala 769:45]
  wire  _T_920 = i0_rs1_depth_d[0] & i0_rs1_class_d_load; // @[dec_decode_ctl.scala 769:108]
  wire  _T_923 = _T_917 | i0_rs1_class_d_load; // @[dec_decode_ctl.scala 769:196]
  wire  _T_924 = i0_rs1_depth_d[1] & _T_923; // @[dec_decode_ctl.scala 769:153]
  wire [2:0] i0_rs1bypass = {_T_918,_T_920,_T_924}; // @[Cat.scala 29:58]
  wire  _T_928 = i0_rs2_class_d_alu | i0_rs2_class_d_mul; // @[dec_decode_ctl.scala 771:67]
  wire  _T_929 = i0_rs2_depth_d[0] & _T_928; // @[dec_decode_ctl.scala 771:45]
  wire  _T_931 = i0_rs2_depth_d[0] & i0_rs2_class_d_load; // @[dec_decode_ctl.scala 771:109]
  wire  _T_934 = _T_928 | i0_rs2_class_d_load; // @[dec_decode_ctl.scala 771:196]
  wire  _T_935 = i0_rs2_depth_d[1] & _T_934; // @[dec_decode_ctl.scala 771:153]
  wire [2:0] i0_rs2bypass = {_T_929,_T_931,_T_935}; // @[Cat.scala 29:58]
  wire  _T_941 = i0_rs1bypass[1] | i0_rs1bypass[0]; // @[dec_decode_ctl.scala 773:86]
  wire  _T_943 = ~i0_rs1bypass[2]; // @[dec_decode_ctl.scala 773:107]
  wire  _T_944 = _T_943 & i0_rs1_nonblock_load_bypass_en_d; // @[dec_decode_ctl.scala 773:124]
  wire  _T_945 = _T_941 | _T_944; // @[dec_decode_ctl.scala 773:104]
  wire  _T_950 = i0_rs2bypass[1] | i0_rs2bypass[0]; // @[dec_decode_ctl.scala 774:86]
  wire  _T_952 = ~i0_rs2bypass[2]; // @[dec_decode_ctl.scala 774:107]
  wire  _T_953 = _T_952 & i0_rs2_nonblock_load_bypass_en_d; // @[dec_decode_ctl.scala 774:124]
  wire  _T_954 = _T_950 | _T_953; // @[dec_decode_ctl.scala 774:104]
  wire  _T_961 = ~i0_rs1bypass[1]; // @[dec_decode_ctl.scala 780:6]
  wire  _T_963 = ~i0_rs1bypass[0]; // @[dec_decode_ctl.scala 780:25]
  wire  _T_964 = _T_961 & _T_963; // @[dec_decode_ctl.scala 780:23]
  wire  _T_965 = _T_964 & i0_rs1_nonblock_load_bypass_en_d; // @[dec_decode_ctl.scala 780:42]
  wire [31:0] _T_967 = i0_rs1bypass[1] ? io_lsu_result_m : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_968 = i0_rs1bypass[0] ? i0_result_r_raw : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_969 = _T_965 ? io_dctl_busbuff_lsu_nonblock_load_data : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_970 = _T_967 | _T_968; // @[Mux.scala 27:72]
  wire  _T_978 = ~i0_rs2bypass[1]; // @[dec_decode_ctl.scala 785:6]
  wire  _T_980 = ~i0_rs2bypass[0]; // @[dec_decode_ctl.scala 785:25]
  wire  _T_981 = _T_978 & _T_980; // @[dec_decode_ctl.scala 785:23]
  wire  _T_982 = _T_981 & i0_rs2_nonblock_load_bypass_en_d; // @[dec_decode_ctl.scala 785:42]
  wire [31:0] _T_984 = i0_rs2bypass[1] ? io_lsu_result_m : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_985 = i0_rs2bypass[0] ? i0_result_r_raw : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_986 = _T_982 ? io_dctl_busbuff_lsu_nonblock_load_data : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_987 = _T_984 | _T_985; // @[Mux.scala 27:72]
  wire  _T_990 = i0_dp_raw_load | i0_dp_raw_store; // @[dec_decode_ctl.scala 787:68]
  wire  _T_991 = io_dec_ib0_valid_d & _T_990; // @[dec_decode_ctl.scala 787:50]
  wire  _T_992 = ~io_dctl_dma_dma_dccm_stall_any; // @[dec_decode_ctl.scala 787:89]
  wire  _T_993 = _T_991 & _T_992; // @[dec_decode_ctl.scala 787:87]
  wire  _T_995 = _T_993 & _T_496; // @[dec_decode_ctl.scala 787:121]
  wire  _T_997 = ~io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 789:6]
  wire  _T_998 = _T_997 & i0_dp_lsu; // @[dec_decode_ctl.scala 789:38]
  wire  _T_999 = _T_998 & i0_dp_load; // @[dec_decode_ctl.scala 789:50]
  wire  _T_1004 = _T_998 & i0_dp_store; // @[dec_decode_ctl.scala 790:50]
  wire [11:0] _T_1008 = {io_dec_i0_instr_d[31:25],i0r_rd}; // @[Cat.scala 29:58]
  wire [11:0] _T_1009 = _T_999 ? io_dec_i0_instr_d[31:20] : 12'h0; // @[Mux.scala 27:72]
  wire [11:0] _T_1010 = _T_1004 ? _T_1008 : 12'h0; // @[Mux.scala 27:72]
  rvclkhdr rvclkhdr ( // @[el2_lib.scala 483:22]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  dec_dec_ctl i0_dec ( // @[dec_decode_ctl.scala 362:22]
    .io_ins(i0_dec_io_ins),
    .io_out_alu(i0_dec_io_out_alu),
    .io_out_rs1(i0_dec_io_out_rs1),
    .io_out_rs2(i0_dec_io_out_rs2),
    .io_out_imm12(i0_dec_io_out_imm12),
    .io_out_rd(i0_dec_io_out_rd),
    .io_out_shimm5(i0_dec_io_out_shimm5),
    .io_out_imm20(i0_dec_io_out_imm20),
    .io_out_pc(i0_dec_io_out_pc),
    .io_out_load(i0_dec_io_out_load),
    .io_out_store(i0_dec_io_out_store),
    .io_out_lsu(i0_dec_io_out_lsu),
    .io_out_add(i0_dec_io_out_add),
    .io_out_sub(i0_dec_io_out_sub),
    .io_out_land(i0_dec_io_out_land),
    .io_out_lor(i0_dec_io_out_lor),
    .io_out_lxor(i0_dec_io_out_lxor),
    .io_out_sll(i0_dec_io_out_sll),
    .io_out_sra(i0_dec_io_out_sra),
    .io_out_srl(i0_dec_io_out_srl),
    .io_out_slt(i0_dec_io_out_slt),
    .io_out_unsign(i0_dec_io_out_unsign),
    .io_out_condbr(i0_dec_io_out_condbr),
    .io_out_beq(i0_dec_io_out_beq),
    .io_out_bne(i0_dec_io_out_bne),
    .io_out_bge(i0_dec_io_out_bge),
    .io_out_blt(i0_dec_io_out_blt),
    .io_out_jal(i0_dec_io_out_jal),
    .io_out_by(i0_dec_io_out_by),
    .io_out_half(i0_dec_io_out_half),
    .io_out_word(i0_dec_io_out_word),
    .io_out_csr_read(i0_dec_io_out_csr_read),
    .io_out_csr_clr(i0_dec_io_out_csr_clr),
    .io_out_csr_set(i0_dec_io_out_csr_set),
    .io_out_csr_write(i0_dec_io_out_csr_write),
    .io_out_csr_imm(i0_dec_io_out_csr_imm),
    .io_out_presync(i0_dec_io_out_presync),
    .io_out_postsync(i0_dec_io_out_postsync),
    .io_out_ebreak(i0_dec_io_out_ebreak),
    .io_out_ecall(i0_dec_io_out_ecall),
    .io_out_mret(i0_dec_io_out_mret),
    .io_out_mul(i0_dec_io_out_mul),
    .io_out_rs1_sign(i0_dec_io_out_rs1_sign),
    .io_out_rs2_sign(i0_dec_io_out_rs2_sign),
    .io_out_low(i0_dec_io_out_low),
    .io_out_div(i0_dec_io_out_div),
    .io_out_rem(i0_dec_io_out_rem),
    .io_out_fence(i0_dec_io_out_fence),
    .io_out_fence_i(i0_dec_io_out_fence_i),
    .io_out_pm_alu(i0_dec_io_out_pm_alu),
    .io_out_legal(i0_dec_io_out_legal)
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
  rvclkhdr rvclkhdr_5 ( // @[el2_lib.scala 518:23]
    .io_l1clk(rvclkhdr_5_io_l1clk),
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en),
    .io_scan_mode(rvclkhdr_5_io_scan_mode)
  );
  rvclkhdr rvclkhdr_6 ( // @[el2_lib.scala 518:23]
    .io_l1clk(rvclkhdr_6_io_l1clk),
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en),
    .io_scan_mode(rvclkhdr_6_io_scan_mode)
  );
  rvclkhdr rvclkhdr_7 ( // @[el2_lib.scala 518:23]
    .io_l1clk(rvclkhdr_7_io_l1clk),
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en),
    .io_scan_mode(rvclkhdr_7_io_scan_mode)
  );
  rvclkhdr rvclkhdr_8 ( // @[el2_lib.scala 518:23]
    .io_l1clk(rvclkhdr_8_io_l1clk),
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en),
    .io_scan_mode(rvclkhdr_8_io_scan_mode)
  );
  rvclkhdr rvclkhdr_9 ( // @[el2_lib.scala 518:23]
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
  assign io_decode_exu_dec_data_en = {i0_x_data_en,i0_r_data_en}; // @[dec_decode_ctl.scala 632:38]
  assign io_decode_exu_dec_ctl_en = {i0_x_ctl_en,i0_r_ctl_en}; // @[dec_decode_ctl.scala 633:38]
  assign io_decode_exu_i0_ap_land = _T_41 ? 1'h0 : i0_dp_raw_land; // @[dec_decode_ctl.scala 255:31]
  assign io_decode_exu_i0_ap_lor = _T_41 | i0_dp_raw_lor; // @[dec_decode_ctl.scala 256:31]
  assign io_decode_exu_i0_ap_lxor = _T_41 ? 1'h0 : i0_dp_raw_lxor; // @[dec_decode_ctl.scala 257:31]
  assign io_decode_exu_i0_ap_sll = _T_41 ? 1'h0 : i0_dp_raw_sll; // @[dec_decode_ctl.scala 258:31]
  assign io_decode_exu_i0_ap_srl = _T_41 ? 1'h0 : i0_dp_raw_srl; // @[dec_decode_ctl.scala 259:31]
  assign io_decode_exu_i0_ap_sra = _T_41 ? 1'h0 : i0_dp_raw_sra; // @[dec_decode_ctl.scala 260:31]
  assign io_decode_exu_i0_ap_beq = _T_41 ? 1'h0 : i0_dp_raw_beq; // @[dec_decode_ctl.scala 263:31]
  assign io_decode_exu_i0_ap_bne = _T_41 ? 1'h0 : i0_dp_raw_bne; // @[dec_decode_ctl.scala 264:31]
  assign io_decode_exu_i0_ap_blt = _T_41 ? 1'h0 : i0_dp_raw_blt; // @[dec_decode_ctl.scala 265:31]
  assign io_decode_exu_i0_ap_bge = _T_41 ? 1'h0 : i0_dp_raw_bge; // @[dec_decode_ctl.scala 266:31]
  assign io_decode_exu_i0_ap_add = _T_41 ? 1'h0 : i0_dp_raw_add; // @[dec_decode_ctl.scala 253:31]
  assign io_decode_exu_i0_ap_sub = _T_41 ? 1'h0 : i0_dp_raw_sub; // @[dec_decode_ctl.scala 254:31]
  assign io_decode_exu_i0_ap_slt = _T_41 ? 1'h0 : i0_dp_raw_slt; // @[dec_decode_ctl.scala 261:31]
  assign io_decode_exu_i0_ap_unsign = _T_41 ? 1'h0 : i0_dp_raw_unsign; // @[dec_decode_ctl.scala 262:31]
  assign io_decode_exu_i0_ap_jal = _T_336 & _T_337; // @[dec_decode_ctl.scala 269:33]
  assign io_decode_exu_i0_ap_predict_t = _T_47 & i0_predict_br; // @[dec_decode_ctl.scala 251:37]
  assign io_decode_exu_i0_ap_predict_nt = _T_48 & i0_predict_br; // @[dec_decode_ctl.scala 250:37]
  assign io_decode_exu_i0_ap_csr_write = i0_csr_write & _T_347; // @[dec_decode_ctl.scala 267:33]
  assign io_decode_exu_i0_ap_csr_imm = _T_41 ? 1'h0 : i0_dp_raw_csr_imm; // @[dec_decode_ctl.scala 268:33]
  assign io_decode_exu_dec_i0_predict_p_d_valid = i0_brp_valid & i0_legal_decode_d; // @[dec_decode_ctl.scala 206:49]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pc4 = io_dec_i0_pc4_d; // @[dec_decode_ctl.scala 204:54]
  assign io_decode_exu_dec_i0_predict_p_d_bits_hist = io_dec_i0_brp_bits_hist; // @[dec_decode_ctl.scala 205:54]
  assign io_decode_exu_dec_i0_predict_p_d_bits_toffset = _T_314 ? i0_pcall_imm[11:0] : _T_323; // @[dec_decode_ctl.scala 218:60]
  assign io_decode_exu_dec_i0_predict_p_d_bits_br_error = _T_33 & _T_18; // @[dec_decode_ctl.scala 213:67]
  assign io_decode_exu_dec_i0_predict_p_d_bits_br_start_error = _T_36 & _T_18; // @[dec_decode_ctl.scala 214:67]
  assign io_decode_exu_dec_i0_predict_p_d_bits_prett = io_dec_i0_brp_bits_prett; // @[dec_decode_ctl.scala 203:54]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pcall = i0_dp_jal & i0_pcall_case; // @[dec_decode_ctl.scala 200:54]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pret = i0_dp_jal & i0_pret_case; // @[dec_decode_ctl.scala 202:54]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pja = i0_dp_jal & i0_pja_case; // @[dec_decode_ctl.scala 201:54]
  assign io_decode_exu_dec_i0_predict_p_d_bits_way = io_dec_i0_brp_bits_way; // @[dec_decode_ctl.scala 220:67]
  assign io_decode_exu_i0_predict_fghr_d = io_dec_i0_bp_fghr; // @[dec_decode_ctl.scala 219:43]
  assign io_decode_exu_i0_predict_index_d = io_dec_i0_bp_index; // @[dec_decode_ctl.scala 215:43]
  assign io_decode_exu_i0_predict_btag_d = io_dec_i0_bp_btag; // @[dec_decode_ctl.scala 216:43]
  assign io_decode_exu_dec_i0_rs1_en_d = i0_dp_rs1 & _T_559; // @[dec_decode_ctl.scala 594:35]
  assign io_decode_exu_dec_i0_rs2_en_d = i0_dp_rs2 & _T_561; // @[dec_decode_ctl.scala 595:35]
  assign io_decode_exu_dec_i0_immed_d = _T_566 | _T_567; // @[dec_decode_ctl.scala 603:32]
  assign io_decode_exu_dec_i0_rs1_bypass_data_d = _T_970 | _T_969; // @[dec_decode_ctl.scala 777:42]
  assign io_decode_exu_dec_i0_rs2_bypass_data_d = _T_987 | _T_986; // @[dec_decode_ctl.scala 782:42]
  assign io_decode_exu_dec_i0_select_pc_d = _T_41 ? 1'h0 : i0_dp_raw_pc; // @[dec_decode_ctl.scala 241:36]
  assign io_decode_exu_dec_i0_rs1_bypass_en_d = {i0_rs1bypass[2],_T_945}; // @[dec_decode_ctl.scala 773:45]
  assign io_decode_exu_dec_i0_rs2_bypass_en_d = {i0_rs2bypass[2],_T_954}; // @[dec_decode_ctl.scala 774:45]
  assign io_decode_exu_mul_p_valid = i0_exulegal_decode_d & i0_dp_mul; // @[dec_decode_ctl.scala 97:23 dec_decode_ctl.scala 397:32]
  assign io_decode_exu_mul_p_bits_rs1_sign = _T_41 ? 1'h0 : i0_dp_raw_rs1_sign; // @[dec_decode_ctl.scala 97:23 dec_decode_ctl.scala 398:37]
  assign io_decode_exu_mul_p_bits_rs2_sign = _T_41 ? 1'h0 : i0_dp_raw_rs2_sign; // @[dec_decode_ctl.scala 97:23 dec_decode_ctl.scala 399:37]
  assign io_decode_exu_mul_p_bits_low = _T_41 ? 1'h0 : i0_dp_raw_low; // @[dec_decode_ctl.scala 97:23 dec_decode_ctl.scala 400:37]
  assign io_decode_exu_pred_correct_npc_x = temp_pred_correct_npc_x[31:1]; // @[dec_decode_ctl.scala 734:36]
  assign io_decode_exu_dec_extint_stall = _T_339; // @[dec_decode_ctl.scala 402:34]
  assign io_dec_alu_dec_i0_alu_decode_d = i0_exulegal_decode_d & i0_dp_alu; // @[dec_decode_ctl.scala 542:34]
  assign io_dec_alu_dec_csr_ren_d = _T_41 ? 1'h0 : i0_dp_raw_csr_read; // @[dec_decode_ctl.scala 424:29]
  assign io_dec_alu_dec_i0_br_immed_d = _T_771 ? i0_br_offset : _T_784; // @[dec_decode_ctl.scala 681:32]
  assign io_dec_div_div_p_valid = i0_exulegal_decode_d & i0_dp_div; // @[dec_decode_ctl.scala 393:29]
  assign io_dec_div_div_p_bits_unsign = _T_41 ? 1'h0 : i0_dp_raw_unsign; // @[dec_decode_ctl.scala 394:34]
  assign io_dec_div_div_p_bits_rem = _T_41 ? 1'h0 : i0_dp_raw_rem; // @[dec_decode_ctl.scala 395:34]
  assign io_dec_div_dec_div_cancel = _T_813 | _T_818; // @[dec_decode_ctl.scala 700:37]
  assign io_dec_i0_inst_wb1 = _T_840; // @[dec_decode_ctl.scala 723:22]
  assign io_dec_i0_pc_wb1 = _T_843; // @[dec_decode_ctl.scala 726:20]
  assign io_dec_i0_rs1_d = io_dec_i0_instr_d[19:15]; // @[dec_decode_ctl.scala 597:19]
  assign io_dec_i0_rs2_d = io_dec_i0_instr_d[24:20]; // @[dec_decode_ctl.scala 598:19]
  assign io_dec_i0_waddr_r = r_d_bits_i0rd; // @[dec_decode_ctl.scala 664:27]
  assign io_dec_i0_wen_r = _T_760 & _T_761; // @[dec_decode_ctl.scala 666:32]
  assign io_dec_i0_wdata_r = _T_767 ? io_lsu_result_corr_r : i0_result_r_raw; // @[dec_decode_ctl.scala 667:26]
  assign io_lsu_p_valid = io_decode_exu_dec_extint_stall | lsu_decode_d; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 409:24 dec_decode_ctl.scala 411:35]
  assign io_lsu_p_bits_fast_int = io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 408:29]
  assign io_lsu_p_bits_by = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_by; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 414:40]
  assign io_lsu_p_bits_half = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_half; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 415:40]
  assign io_lsu_p_bits_word = io_decode_exu_dec_extint_stall | i0_dp_word; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 407:29 dec_decode_ctl.scala 416:40]
  assign io_lsu_p_bits_load = io_decode_exu_dec_extint_stall | i0_dp_load; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 406:29 dec_decode_ctl.scala 412:40]
  assign io_lsu_p_bits_store = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_store; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 413:40]
  assign io_lsu_p_bits_unsign = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_unsign; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 420:40]
  assign io_lsu_p_bits_store_data_bypass_d = io_decode_exu_dec_extint_stall ? 1'h0 : store_data_bypass_d; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 418:40]
  assign io_lsu_p_bits_load_ldst_bypass_d = io_decode_exu_dec_extint_stall ? 1'h0 : load_ldst_bypass_d; // @[dec_decode_ctl.scala 404:12 dec_decode_ctl.scala 417:40]
  assign io_div_waddr_wb = _T_833; // @[dec_decode_ctl.scala 711:19]
  assign io_dec_lsu_valid_raw_d = _T_995 | io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 787:26]
  assign io_dec_lsu_offset_d = _T_1009 | _T_1010; // @[dec_decode_ctl.scala 788:23]
  assign io_dec_csr_wen_unq_d = _T_349 | i0_csr_write; // @[dec_decode_ctl.scala 433:24]
  assign io_dec_csr_any_unq_d = i0_dp_csr_read | i0_csr_write; // @[dec_decode_ctl.scala 499:24]
  assign io_dec_csr_rdaddr_d = io_dec_i0_instr_d[31:20]; // @[dec_decode_ctl.scala 436:24]
  assign io_dec_csr_wen_r = _T_352 & _T_757; // @[dec_decode_ctl.scala 441:20]
  assign io_dec_csr_wraddr_r = r_d_bits_csrwaddr; // @[dec_decode_ctl.scala 437:23]
  assign io_dec_csr_wrdata_r = r_d_bits_csrwonly ? i0_result_corr_r : write_csr_data; // @[dec_decode_ctl.scala 484:24]
  assign io_dec_csr_stall_int_ff = _T_359 & _T_360; // @[dec_decode_ctl.scala 444:27]
  assign io_dec_tlu_i0_valid_r = r_d_valid & _T_746; // @[dec_decode_ctl.scala 548:29]
  assign io_dec_tlu_packet_r_legal = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_legal; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_icaf = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_icaf; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_icaf_f1 = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_icaf_f1; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_icaf_type = io_dec_tlu_flush_lower_wb ? 2'h0 : r_t_icaf_type; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_fence_i = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_fence_i; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_i0trigger = io_dec_tlu_flush_lower_wb ? 4'h0 : _T_545; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_pmu_i0_itype = io_dec_tlu_flush_lower_wb ? 4'h0 : r_t_pmu_i0_itype; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_pmu_i0_br_unpred = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_pmu_i0_br_unpred; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_packet_r_pmu_divide = r_d_bits_i0div & r_d_valid; // @[dec_decode_ctl.scala 582:39 dec_decode_ctl.scala 583:39]
  assign io_dec_tlu_packet_r_pmu_lsu_misaligned = io_dec_tlu_flush_lower_wb ? 1'h0 : lsu_pmu_misaligned_r; // @[dec_decode_ctl.scala 582:39]
  assign io_dec_tlu_i0_pc_r = dec_i0_pc_r; // @[dec_decode_ctl.scala 729:27]
  assign io_dec_illegal_inst = _T_468; // @[dec_decode_ctl.scala 506:23]
  assign io_dec_pmu_instr_decoded = io_dec_aln_dec_i0_decode_d; // @[dec_decode_ctl.scala 527:28]
  assign io_dec_pmu_decode_stall = io_dec_ib0_valid_d & _T_501; // @[dec_decode_ctl.scala 528:27]
  assign io_dec_pmu_presync_stall = i0_presync & prior_inflight_eff; // @[dec_decode_ctl.scala 530:29]
  assign io_dec_pmu_postsync_stall = postsync_stall; // @[dec_decode_ctl.scala 529:29]
  assign io_dec_nonblock_load_wen = _T_200 & _T_201; // @[dec_decode_ctl.scala 324:28]
  assign io_dec_nonblock_load_waddr = _T_246 | _T_238; // @[dec_decode_ctl.scala 321:29 dec_decode_ctl.scala 331:29]
  assign io_dec_pause_state = pause_stall; // @[dec_decode_ctl.scala 468:22]
  assign io_dec_pause_state_cg = pause_stall & _T_423; // @[dec_decode_ctl.scala 472:25]
  assign io_dec_div_active = _T_824; // @[dec_decode_ctl.scala 705:21]
  assign io_dec_aln_dec_i0_decode_d = _T_493 & _T_470; // @[dec_decode_ctl.scala 522:30 dec_decode_ctl.scala 588:30]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 484:17]
  assign rvclkhdr_io_en = _T_15 | _T_16; // @[el2_lib.scala 485:16]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 486:23]
  assign i0_dec_io_ins = io_dec_i0_instr_d; // @[dec_decode_ctl.scala 363:16]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = i0_pipe_en[3] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_2_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_2_io_en = i0_pipe_en[3] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_3_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_3_io_en = _T_431 | pause_stall; // @[el2_lib.scala 511:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_4_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_4_io_en = shift_illegal & _T_467; // @[el2_lib.scala 511:17]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_5_io_clk = clock; // @[el2_lib.scala 520:18]
  assign rvclkhdr_5_io_en = _T_707 | io_clk_override; // @[el2_lib.scala 521:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[el2_lib.scala 522:24]
  assign rvclkhdr_6_io_clk = clock; // @[el2_lib.scala 520:18]
  assign rvclkhdr_6_io_en = _T_707 | io_clk_override; // @[el2_lib.scala 521:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[el2_lib.scala 522:24]
  assign rvclkhdr_7_io_clk = clock; // @[el2_lib.scala 520:18]
  assign rvclkhdr_7_io_en = _T_707 | io_clk_override; // @[el2_lib.scala 521:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[el2_lib.scala 522:24]
  assign rvclkhdr_8_io_clk = clock; // @[el2_lib.scala 520:18]
  assign rvclkhdr_8_io_en = _T_710 | io_clk_override; // @[el2_lib.scala 521:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[el2_lib.scala 522:24]
  assign rvclkhdr_9_io_clk = clock; // @[el2_lib.scala 520:18]
  assign rvclkhdr_9_io_en = _T_713 | io_clk_override; // @[el2_lib.scala 521:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[el2_lib.scala 522:24]
  assign rvclkhdr_10_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_10_io_en = i0_pipe_en[2] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_11_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_11_io_en = i0_pipe_en[3] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_12_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_12_io_en = i0_legal_decode_d & i0_dp_div; // @[el2_lib.scala 511:17]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_13_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_13_io_en = i0_pipe_en[3] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_14_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_14_io_en = i0_pipe_en[2] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_15_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_15_io_en = i0_pipe_en[1] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_16_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_16_io_en = i0_pipe_en[0] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_17_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_17_io_en = i0_pipe_en[1] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_17_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_18_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_18_io_en = i0_pipe_en[0] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_18_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_19_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_19_io_en = i0_pipe_en[2] | io_clk_override; // @[el2_lib.scala 511:17]
  assign rvclkhdr_19_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
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
  tlu_wr_pause_r1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  tlu_wr_pause_r2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  leak1_i1_stall = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  leak1_i0_stall = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  pause_stall = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  write_csr_data = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  postsync_stall = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  x_d_valid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  flush_final_r = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  illegal_lockout = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  cam_raw_0_bits_tag = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  cam_raw_0_valid = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  cam_raw_1_bits_tag = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  cam_raw_1_valid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  cam_raw_2_bits_tag = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  cam_raw_2_valid = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  cam_raw_3_bits_tag = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  cam_raw_3_valid = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  x_d_bits_i0load = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  x_d_bits_i0rd = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  _T_704 = _RAND_20[2:0];
  _RAND_21 = {1{`RANDOM}};
  nonblock_load_valid_m_delay = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  r_d_bits_i0load = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  r_d_bits_i0v = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  r_d_bits_i0rd = _RAND_24[4:0];
  _RAND_25 = {1{`RANDOM}};
  cam_raw_0_bits_rd = _RAND_25[4:0];
  _RAND_26 = {1{`RANDOM}};
  cam_raw_0_bits_wb = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  cam_raw_1_bits_rd = _RAND_27[4:0];
  _RAND_28 = {1{`RANDOM}};
  cam_raw_1_bits_wb = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  cam_raw_2_bits_rd = _RAND_29[4:0];
  _RAND_30 = {1{`RANDOM}};
  cam_raw_2_bits_wb = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  cam_raw_3_bits_rd = _RAND_31[4:0];
  _RAND_32 = {1{`RANDOM}};
  cam_raw_3_bits_wb = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  lsu_idle = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  _T_339 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  x_d_bits_i0v = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  i0_x_c_load = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  i0_r_c_load = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  r_d_bits_csrwen = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  r_d_valid = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  r_d_bits_csrwaddr = _RAND_40[11:0];
  _RAND_41 = {1{`RANDOM}};
  csr_read_x = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  csr_clr_x = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  csr_set_x = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  csr_write_x = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  csr_imm_x = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  csrimm_x = _RAND_46[4:0];
  _RAND_47 = {1{`RANDOM}};
  csr_rddata_x = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  r_d_bits_csrwonly = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  i0_result_r_raw = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  x_d_bits_csrwonly = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  wbd_bits_csrwonly = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  _T_468 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  x_t_legal = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  x_t_icaf = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  x_t_icaf_f1 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  x_t_icaf_type = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  x_t_fence_i = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  x_t_i0trigger = _RAND_58[3:0];
  _RAND_59 = {1{`RANDOM}};
  x_t_pmu_i0_itype = _RAND_59[3:0];
  _RAND_60 = {1{`RANDOM}};
  x_t_pmu_i0_br_unpred = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  r_t_legal = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  r_t_icaf = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  r_t_icaf_f1 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  r_t_icaf_type = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  r_t_fence_i = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  r_t_i0trigger = _RAND_66[3:0];
  _RAND_67 = {1{`RANDOM}};
  r_t_pmu_i0_itype = _RAND_67[3:0];
  _RAND_68 = {1{`RANDOM}};
  r_t_pmu_i0_br_unpred = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  lsu_trigger_match_r = _RAND_69[3:0];
  _RAND_70 = {1{`RANDOM}};
  lsu_pmu_misaligned_r = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  r_d_bits_i0store = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  r_d_bits_i0div = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  i0_x_c_mul = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  i0_x_c_alu = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  i0_r_c_mul = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  i0_r_c_alu = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  x_d_bits_i0store = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  x_d_bits_i0div = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  x_d_bits_csrwen = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  x_d_bits_csrwaddr = _RAND_80[11:0];
  _RAND_81 = {1{`RANDOM}};
  last_br_immed_x = _RAND_81[11:0];
  _RAND_82 = {1{`RANDOM}};
  _T_824 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  _T_833 = _RAND_83[4:0];
  _RAND_84 = {1{`RANDOM}};
  i0_inst_x = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  i0_inst_r = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  i0_inst_wb = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  _T_840 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  i0_pc_wb = _RAND_88[30:0];
  _RAND_89 = {1{`RANDOM}};
  _T_843 = _RAND_89[30:0];
  _RAND_90 = {1{`RANDOM}};
  dec_i0_pc_r = _RAND_90[30:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    tlu_wr_pause_r1 = 1'h0;
  end
  if (reset) begin
    tlu_wr_pause_r2 = 1'h0;
  end
  if (reset) begin
    leak1_i1_stall = 1'h0;
  end
  if (reset) begin
    leak1_i0_stall = 1'h0;
  end
  if (reset) begin
    pause_stall = 1'h0;
  end
  if (reset) begin
    write_csr_data = 32'h0;
  end
  if (reset) begin
    postsync_stall = 1'h0;
  end
  if (reset) begin
    x_d_valid = 1'h0;
  end
  if (reset) begin
    flush_final_r = 1'h0;
  end
  if (reset) begin
    illegal_lockout = 1'h0;
  end
  if (reset) begin
    cam_raw_0_bits_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_0_valid = 1'h0;
  end
  if (reset) begin
    cam_raw_1_bits_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_1_valid = 1'h0;
  end
  if (reset) begin
    cam_raw_2_bits_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_2_valid = 1'h0;
  end
  if (reset) begin
    cam_raw_3_bits_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_3_valid = 1'h0;
  end
  if (reset) begin
    x_d_bits_i0load = 1'h0;
  end
  if (reset) begin
    x_d_bits_i0rd = 5'h0;
  end
  if (reset) begin
    _T_704 = 3'h0;
  end
  if (reset) begin
    nonblock_load_valid_m_delay = 1'h0;
  end
  if (reset) begin
    r_d_bits_i0load = 1'h0;
  end
  if (reset) begin
    r_d_bits_i0v = 1'h0;
  end
  if (reset) begin
    r_d_bits_i0rd = 5'h0;
  end
  if (reset) begin
    cam_raw_0_bits_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_0_bits_wb = 1'h0;
  end
  if (reset) begin
    cam_raw_1_bits_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_1_bits_wb = 1'h0;
  end
  if (reset) begin
    cam_raw_2_bits_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_2_bits_wb = 1'h0;
  end
  if (reset) begin
    cam_raw_3_bits_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_3_bits_wb = 1'h0;
  end
  if (reset) begin
    lsu_idle = 1'h0;
  end
  if (reset) begin
    _T_339 = 1'h0;
  end
  if (reset) begin
    x_d_bits_i0v = 1'h0;
  end
  if (reset) begin
    r_d_bits_csrwen = 1'h0;
  end
  if (reset) begin
    r_d_valid = 1'h0;
  end
  if (reset) begin
    r_d_bits_csrwaddr = 12'h0;
  end
  if (reset) begin
    csr_read_x = 1'h0;
  end
  if (reset) begin
    csr_clr_x = 1'h0;
  end
  if (reset) begin
    csr_set_x = 1'h0;
  end
  if (reset) begin
    csr_write_x = 1'h0;
  end
  if (reset) begin
    csr_imm_x = 1'h0;
  end
  if (reset) begin
    csrimm_x = 5'h0;
  end
  if (reset) begin
    csr_rddata_x = 32'h0;
  end
  if (reset) begin
    r_d_bits_csrwonly = 1'h0;
  end
  if (reset) begin
    i0_result_r_raw = 32'h0;
  end
  if (reset) begin
    x_d_bits_csrwonly = 1'h0;
  end
  if (reset) begin
    wbd_bits_csrwonly = 1'h0;
  end
  if (reset) begin
    _T_468 = 32'h0;
  end
  if (reset) begin
    x_t_legal = 1'h0;
  end
  if (reset) begin
    x_t_icaf = 1'h0;
  end
  if (reset) begin
    x_t_icaf_f1 = 1'h0;
  end
  if (reset) begin
    x_t_icaf_type = 2'h0;
  end
  if (reset) begin
    x_t_fence_i = 1'h0;
  end
  if (reset) begin
    x_t_i0trigger = 4'h0;
  end
  if (reset) begin
    x_t_pmu_i0_itype = 4'h0;
  end
  if (reset) begin
    x_t_pmu_i0_br_unpred = 1'h0;
  end
  if (reset) begin
    r_t_legal = 1'h0;
  end
  if (reset) begin
    r_t_icaf = 1'h0;
  end
  if (reset) begin
    r_t_icaf_f1 = 1'h0;
  end
  if (reset) begin
    r_t_icaf_type = 2'h0;
  end
  if (reset) begin
    r_t_fence_i = 1'h0;
  end
  if (reset) begin
    r_t_i0trigger = 4'h0;
  end
  if (reset) begin
    r_t_pmu_i0_itype = 4'h0;
  end
  if (reset) begin
    r_t_pmu_i0_br_unpred = 1'h0;
  end
  if (reset) begin
    lsu_trigger_match_r = 4'h0;
  end
  if (reset) begin
    lsu_pmu_misaligned_r = 1'h0;
  end
  if (reset) begin
    r_d_bits_i0store = 1'h0;
  end
  if (reset) begin
    r_d_bits_i0div = 1'h0;
  end
  if (reset) begin
    x_d_bits_i0store = 1'h0;
  end
  if (reset) begin
    x_d_bits_i0div = 1'h0;
  end
  if (reset) begin
    x_d_bits_csrwen = 1'h0;
  end
  if (reset) begin
    x_d_bits_csrwaddr = 12'h0;
  end
  if (reset) begin
    last_br_immed_x = 12'h0;
  end
  if (reset) begin
    _T_824 = 1'h0;
  end
  if (reset) begin
    _T_833 = 5'h0;
  end
  if (reset) begin
    i0_inst_x = 32'h0;
  end
  if (reset) begin
    i0_inst_r = 32'h0;
  end
  if (reset) begin
    i0_inst_wb = 32'h0;
  end
  if (reset) begin
    _T_840 = 32'h0;
  end
  if (reset) begin
    i0_pc_wb = 31'h0;
  end
  if (reset) begin
    _T_843 = 31'h0;
  end
  if (reset) begin
    dec_i0_pc_r = 31'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_active_clk) begin
    if (i0_x_ctl_en) begin
      i0_x_c_load <= i0_d_c_load;
    end
    if (i0_r_ctl_en) begin
      i0_r_c_load <= i0_x_c_load;
    end
    if (i0_x_ctl_en) begin
      i0_x_c_mul <= i0_d_c_mul;
    end
    if (i0_x_ctl_en) begin
      i0_x_c_alu <= i0_d_c_alu;
    end
    if (i0_r_ctl_en) begin
      i0_r_c_mul <= i0_x_c_mul;
    end
    if (i0_r_ctl_en) begin
      i0_r_c_alu <= i0_x_c_alu;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      tlu_wr_pause_r1 <= 1'h0;
    end else begin
      tlu_wr_pause_r1 <= io_dec_tlu_wr_pause_r;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      tlu_wr_pause_r2 <= 1'h0;
    end else begin
      tlu_wr_pause_r2 <= tlu_wr_pause_r1;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      leak1_i1_stall <= 1'h0;
    end else begin
      leak1_i1_stall <= io_dec_tlu_flush_leak_one_r | _T_281;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      leak1_i0_stall <= 1'h0;
    end else begin
      leak1_i0_stall <= _T_284 | _T_286;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      pause_stall <= 1'h0;
    end else begin
      pause_stall <= _T_415 & _T_416;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      write_csr_data <= 32'h0;
    end else if (pause_stall) begin
      write_csr_data <= _T_426;
    end else if (io_dec_tlu_wr_pause_r) begin
      write_csr_data <= io_dec_csr_wrdata_r;
    end else begin
      write_csr_data <= write_csr_data_x;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      postsync_stall <= 1'h0;
    end else begin
      postsync_stall <= _T_509 | _T_510;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_valid <= 1'h0;
    end else begin
      x_d_valid <= io_dec_aln_dec_i0_decode_d;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      flush_final_r <= 1'h0;
    end else begin
      flush_final_r <= io_exu_flush_final;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      illegal_lockout <= 1'h0;
    end else begin
      illegal_lockout <= _T_469 & _T_470;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_bits_tag <= 3'h0;
    end else if (cam_wen[0]) begin
      cam_raw_0_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_107) begin
      cam_raw_0_bits_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_0_valid <= 1'h0;
    end else begin
      cam_raw_0_valid <= _GEN_56;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_bits_tag <= 3'h0;
    end else if (cam_wen[1]) begin
      cam_raw_1_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_133) begin
      cam_raw_1_bits_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_1_valid <= 1'h0;
    end else begin
      cam_raw_1_valid <= _GEN_67;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_bits_tag <= 3'h0;
    end else if (cam_wen[2]) begin
      cam_raw_2_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_159) begin
      cam_raw_2_bits_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_2_valid <= 1'h0;
    end else begin
      cam_raw_2_valid <= _GEN_78;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_bits_tag <= 3'h0;
    end else if (cam_wen[3]) begin
      cam_raw_3_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_185) begin
      cam_raw_3_bits_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_3_valid <= 1'h0;
    end else begin
      cam_raw_3_valid <= _GEN_89;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_i0load <= 1'h0;
    end else begin
      x_d_bits_i0load <= i0_dp_load & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_i0rd <= 5'h0;
    end else begin
      x_d_bits_i0rd <= io_dec_i0_instr_d[11:7];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_704 <= 3'h0;
    end else begin
      _T_704 <= i0_pipe_en[3:1];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      nonblock_load_valid_m_delay <= 1'h0;
    end else if (i0_r_ctl_en) begin
      nonblock_load_valid_m_delay <= io_dctl_busbuff_lsu_nonblock_load_valid_m;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_i0load <= 1'h0;
    end else begin
      r_d_bits_i0load <= x_d_bits_i0load;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_i0v <= 1'h0;
    end else begin
      r_d_bits_i0v <= _T_736 & _T_280;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_i0rd <= 5'h0;
    end else begin
      r_d_bits_i0rd <= x_d_bits_i0rd;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_bits_rd <= 5'h0;
    end else if (cam_wen[0]) begin
      if (x_d_bits_i0load) begin
        cam_raw_0_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_0_bits_rd <= 5'h0;
      end
    end else if (_T_107) begin
      cam_raw_0_bits_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_bits_wb <= 1'h0;
    end else begin
      cam_raw_0_bits_wb <= _T_112 | _GEN_57;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_bits_rd <= 5'h0;
    end else if (cam_wen[1]) begin
      if (x_d_bits_i0load) begin
        cam_raw_1_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_1_bits_rd <= 5'h0;
      end
    end else if (_T_133) begin
      cam_raw_1_bits_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_bits_wb <= 1'h0;
    end else begin
      cam_raw_1_bits_wb <= _T_138 | _GEN_68;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_bits_rd <= 5'h0;
    end else if (cam_wen[2]) begin
      if (x_d_bits_i0load) begin
        cam_raw_2_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_2_bits_rd <= 5'h0;
      end
    end else if (_T_159) begin
      cam_raw_2_bits_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_bits_wb <= 1'h0;
    end else begin
      cam_raw_2_bits_wb <= _T_164 | _GEN_79;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_bits_rd <= 5'h0;
    end else if (cam_wen[3]) begin
      if (x_d_bits_i0load) begin
        cam_raw_3_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_3_bits_rd <= 5'h0;
      end
    end else if (_T_185) begin
      cam_raw_3_bits_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_bits_wb <= 1'h0;
    end else begin
      cam_raw_3_bits_wb <= _T_190 | _GEN_90;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      lsu_idle <= 1'h0;
    end else begin
      lsu_idle <= io_lsu_idle_any;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_339 <= 1'h0;
    end else begin
      _T_339 <= io_dec_tlu_flush_extint;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_i0v <= 1'h0;
    end else begin
      x_d_bits_i0v <= i0_rd_en_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_csrwen <= 1'h0;
    end else begin
      r_d_bits_csrwen <= x_d_bits_csrwen;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_valid <= 1'h0;
    end else begin
      r_d_valid <= _T_740 & _T_280;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_csrwaddr <= 12'h0;
    end else begin
      r_d_bits_csrwaddr <= x_d_bits_csrwaddr;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      csr_read_x <= 1'h0;
    end else begin
      csr_read_x <= i0_dp_csr_read & i0_legal_decode_d;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      csr_clr_x <= 1'h0;
    end else begin
      csr_clr_x <= i0_dp_csr_clr & i0_legal_decode_d;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      csr_set_x <= 1'h0;
    end else begin
      csr_set_x <= i0_dp_csr_set & i0_legal_decode_d;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      csr_write_x <= 1'h0;
    end else begin
      csr_write_x <= i0_csr_write & i0_legal_decode_d;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      csr_imm_x <= 1'h0;
    end else if (_T_41) begin
      csr_imm_x <= 1'h0;
    end else begin
      csr_imm_x <= i0_dp_raw_csr_imm;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      csrimm_x <= 5'h0;
    end else begin
      csrimm_x <= io_dec_i0_instr_d[19:15];
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      csr_rddata_x <= 32'h0;
    end else begin
      csr_rddata_x <= io_dec_csr_rddata_d;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_csrwonly <= 1'h0;
    end else begin
      r_d_bits_csrwonly <= x_d_bits_csrwonly;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_result_r_raw <= 32'h0;
    end else if (_T_764) begin
      i0_result_r_raw <= io_lsu_result_m;
    end else begin
      i0_result_r_raw <= io_decode_exu_exu_i0_result_x;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_csrwonly <= 1'h0;
    end else begin
      x_d_bits_csrwonly <= i0_csr_write_only_d & io_dec_aln_dec_i0_decode_d;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      wbd_bits_csrwonly <= 1'h0;
    end else begin
      wbd_bits_csrwonly <= r_d_bits_csrwonly;
    end
  end
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_468 <= 32'h0;
    end else if (io_dec_i0_pc4_d) begin
      _T_468 <= io_dec_i0_instr_d;
    end else begin
      _T_468 <= _T_465;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_legal <= 1'h0;
    end else begin
      x_t_legal <= io_dec_aln_dec_i0_decode_d & i0_legal;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_icaf <= 1'h0;
    end else begin
      x_t_icaf <= i0_icaf_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_icaf_f1 <= 1'h0;
    end else begin
      x_t_icaf_f1 <= io_dec_i0_icaf_f1_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_icaf_type <= 2'h0;
    end else begin
      x_t_icaf_type <= io_dec_i0_icaf_type_d;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_fence_i <= 1'h0;
    end else begin
      x_t_fence_i <= _T_520 & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_i0trigger <= 4'h0;
    end else begin
      x_t_i0trigger <= io_dec_i0_trigger_match_d & _T_525;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_pmu_i0_itype <= 4'h0;
    end else begin
      x_t_pmu_i0_itype <= _T_255 & _T_277;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      x_t_pmu_i0_br_unpred <= 1'h0;
    end else begin
      x_t_pmu_i0_br_unpred <= i0_dp_jal & _T_253;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_legal <= 1'h0;
    end else begin
      r_t_legal <= x_t_legal;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_icaf <= 1'h0;
    end else begin
      r_t_icaf <= x_t_icaf;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_icaf_f1 <= 1'h0;
    end else begin
      r_t_icaf_f1 <= x_t_icaf_f1;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_icaf_type <= 2'h0;
    end else begin
      r_t_icaf_type <= x_t_icaf_type;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_fence_i <= 1'h0;
    end else begin
      r_t_fence_i <= x_t_fence_i;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_i0trigger <= 4'h0;
    end else begin
      r_t_i0trigger <= x_t_i0trigger & _T_534;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_pmu_i0_itype <= 4'h0;
    end else begin
      r_t_pmu_i0_itype <= x_t_pmu_i0_itype;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      r_t_pmu_i0_br_unpred <= 1'h0;
    end else begin
      r_t_pmu_i0_br_unpred <= x_t_pmu_i0_br_unpred;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      lsu_trigger_match_r <= 4'h0;
    end else begin
      lsu_trigger_match_r <= io_lsu_trigger_match_m;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      lsu_pmu_misaligned_r <= 1'h0;
    end else begin
      lsu_pmu_misaligned_r <= io_lsu_pmu_misaligned_m;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_i0store <= 1'h0;
    end else begin
      r_d_bits_i0store <= x_d_bits_i0store;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_bits_i0div <= 1'h0;
    end else begin
      r_d_bits_i0div <= x_d_bits_i0div;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_i0store <= 1'h0;
    end else begin
      x_d_bits_i0store <= i0_dp_store & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_i0div <= 1'h0;
    end else begin
      x_d_bits_i0div <= i0_dp_div & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_csrwen <= 1'h0;
    end else begin
      x_d_bits_csrwen <= io_dec_csr_wen_unq_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_bits_csrwaddr <= 12'h0;
    end else begin
      x_d_bits_csrwaddr <= io_dec_i0_instr_d[31:20];
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      last_br_immed_x <= 12'h0;
    end else if (io_decode_exu_i0_ap_predict_nt) begin
      last_br_immed_x <= _T_784;
    end else if (_T_314) begin
      last_br_immed_x <= i0_pcall_imm[11:0];
    end else begin
      last_br_immed_x <= _T_323;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_824 <= 1'h0;
    end else begin
      _T_824 <= i0_div_decode_d | _T_823;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_833 <= 5'h0;
    end else if (i0_div_decode_d) begin
      _T_833 <= i0r_rd;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_inst_x <= 32'h0;
    end else if (io_dec_i0_pc4_d) begin
      i0_inst_x <= io_dec_i0_instr_d;
    end else begin
      i0_inst_x <= _T_465;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_inst_r <= 32'h0;
    end else begin
      i0_inst_r <= i0_inst_x;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_inst_wb <= 32'h0;
    end else begin
      i0_inst_wb <= i0_inst_r;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_840 <= 32'h0;
    end else begin
      _T_840 <= i0_inst_wb;
    end
  end
  always @(posedge rvclkhdr_17_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_pc_wb <= 31'h0;
    end else begin
      i0_pc_wb <= io_dec_tlu_i0_pc_r;
    end
  end
  always @(posedge rvclkhdr_18_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_843 <= 31'h0;
    end else begin
      _T_843 <= i0_pc_wb;
    end
  end
  always @(posedge rvclkhdr_19_io_l1clk or posedge reset) begin
    if (reset) begin
      dec_i0_pc_r <= 31'h0;
    end else begin
      dec_i0_pc_r <= io_dec_alu_exu_i0_pc_x;
    end
  end
endmodule
module dec_gpr_ctl(
  input         clock,
  input         reset,
  input  [4:0]  io_raddr0,
  input  [4:0]  io_raddr1,
  input         io_wen0,
  input  [4:0]  io_waddr0,
  input  [31:0] io_wd0,
  input         io_wen1,
  input  [4:0]  io_waddr1,
  input  [31:0] io_wd1,
  input         io_wen2,
  input  [4:0]  io_waddr2,
  input  [31:0] io_wd2,
  input         io_scan_mode,
  output [31:0] io_gpr_exu_gpr_i0_rs1_d,
  output [31:0] io_gpr_exu_gpr_i0_rs2_d
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
  wire  _T = io_waddr0 == 5'h1; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_1 = io_wen0 & _T; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_2 = io_waddr1 == 5'h1; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_1 = io_wen1 & _T_2; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_4 = io_waddr2 == 5'h1; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_1 = io_wen2 & _T_4; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_7 = w0v_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_8 = _T_7 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_10 = w1v_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_11 = _T_10 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_12 = _T_8 | _T_11; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_14 = w2v_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_15 = _T_14 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_17 = io_waddr0 == 5'h2; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_2 = io_wen0 & _T_17; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_19 = io_waddr1 == 5'h2; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_2 = io_wen1 & _T_19; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_21 = io_waddr2 == 5'h2; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_2 = io_wen2 & _T_21; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_24 = w0v_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_25 = _T_24 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_27 = w1v_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_28 = _T_27 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_29 = _T_25 | _T_28; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_31 = w2v_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_32 = _T_31 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_34 = io_waddr0 == 5'h3; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_3 = io_wen0 & _T_34; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_36 = io_waddr1 == 5'h3; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_3 = io_wen1 & _T_36; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_38 = io_waddr2 == 5'h3; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_3 = io_wen2 & _T_38; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_41 = w0v_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_42 = _T_41 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_44 = w1v_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_45 = _T_44 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_46 = _T_42 | _T_45; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_48 = w2v_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_49 = _T_48 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_51 = io_waddr0 == 5'h4; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_4 = io_wen0 & _T_51; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_53 = io_waddr1 == 5'h4; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_4 = io_wen1 & _T_53; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_55 = io_waddr2 == 5'h4; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_4 = io_wen2 & _T_55; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_58 = w0v_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_59 = _T_58 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_61 = w1v_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_62 = _T_61 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_63 = _T_59 | _T_62; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_65 = w2v_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_66 = _T_65 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_68 = io_waddr0 == 5'h5; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_5 = io_wen0 & _T_68; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_70 = io_waddr1 == 5'h5; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_5 = io_wen1 & _T_70; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_72 = io_waddr2 == 5'h5; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_5 = io_wen2 & _T_72; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_75 = w0v_5 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_76 = _T_75 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_78 = w1v_5 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_79 = _T_78 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_80 = _T_76 | _T_79; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_82 = w2v_5 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_83 = _T_82 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_85 = io_waddr0 == 5'h6; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_6 = io_wen0 & _T_85; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_87 = io_waddr1 == 5'h6; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_6 = io_wen1 & _T_87; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_89 = io_waddr2 == 5'h6; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_6 = io_wen2 & _T_89; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_92 = w0v_6 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_93 = _T_92 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_95 = w1v_6 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_96 = _T_95 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_97 = _T_93 | _T_96; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_99 = w2v_6 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_100 = _T_99 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_102 = io_waddr0 == 5'h7; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_7 = io_wen0 & _T_102; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_104 = io_waddr1 == 5'h7; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_7 = io_wen1 & _T_104; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_106 = io_waddr2 == 5'h7; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_7 = io_wen2 & _T_106; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_109 = w0v_7 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_110 = _T_109 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_112 = w1v_7 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_113 = _T_112 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_114 = _T_110 | _T_113; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_116 = w2v_7 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_117 = _T_116 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_119 = io_waddr0 == 5'h8; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_8 = io_wen0 & _T_119; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_121 = io_waddr1 == 5'h8; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_8 = io_wen1 & _T_121; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_123 = io_waddr2 == 5'h8; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_8 = io_wen2 & _T_123; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_126 = w0v_8 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_127 = _T_126 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_129 = w1v_8 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_130 = _T_129 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_131 = _T_127 | _T_130; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_133 = w2v_8 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_134 = _T_133 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_136 = io_waddr0 == 5'h9; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_9 = io_wen0 & _T_136; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_138 = io_waddr1 == 5'h9; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_9 = io_wen1 & _T_138; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_140 = io_waddr2 == 5'h9; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_9 = io_wen2 & _T_140; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_143 = w0v_9 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_144 = _T_143 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_146 = w1v_9 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_147 = _T_146 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_148 = _T_144 | _T_147; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_150 = w2v_9 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_151 = _T_150 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_153 = io_waddr0 == 5'ha; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_10 = io_wen0 & _T_153; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_155 = io_waddr1 == 5'ha; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_10 = io_wen1 & _T_155; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_157 = io_waddr2 == 5'ha; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_10 = io_wen2 & _T_157; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_160 = w0v_10 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_161 = _T_160 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_163 = w1v_10 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_164 = _T_163 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_165 = _T_161 | _T_164; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_167 = w2v_10 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_168 = _T_167 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_170 = io_waddr0 == 5'hb; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_11 = io_wen0 & _T_170; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_172 = io_waddr1 == 5'hb; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_11 = io_wen1 & _T_172; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_174 = io_waddr2 == 5'hb; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_11 = io_wen2 & _T_174; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_177 = w0v_11 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_178 = _T_177 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_180 = w1v_11 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_181 = _T_180 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_182 = _T_178 | _T_181; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_184 = w2v_11 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_185 = _T_184 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_187 = io_waddr0 == 5'hc; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_12 = io_wen0 & _T_187; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_189 = io_waddr1 == 5'hc; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_12 = io_wen1 & _T_189; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_191 = io_waddr2 == 5'hc; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_12 = io_wen2 & _T_191; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_194 = w0v_12 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_195 = _T_194 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_197 = w1v_12 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_198 = _T_197 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_199 = _T_195 | _T_198; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_201 = w2v_12 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_202 = _T_201 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_204 = io_waddr0 == 5'hd; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_13 = io_wen0 & _T_204; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_206 = io_waddr1 == 5'hd; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_13 = io_wen1 & _T_206; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_208 = io_waddr2 == 5'hd; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_13 = io_wen2 & _T_208; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_211 = w0v_13 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_212 = _T_211 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_214 = w1v_13 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_215 = _T_214 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_216 = _T_212 | _T_215; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_218 = w2v_13 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_219 = _T_218 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_221 = io_waddr0 == 5'he; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_14 = io_wen0 & _T_221; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_223 = io_waddr1 == 5'he; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_14 = io_wen1 & _T_223; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_225 = io_waddr2 == 5'he; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_14 = io_wen2 & _T_225; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_228 = w0v_14 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_229 = _T_228 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_231 = w1v_14 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_232 = _T_231 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_233 = _T_229 | _T_232; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_235 = w2v_14 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_236 = _T_235 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_238 = io_waddr0 == 5'hf; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_15 = io_wen0 & _T_238; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_240 = io_waddr1 == 5'hf; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_15 = io_wen1 & _T_240; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_242 = io_waddr2 == 5'hf; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_15 = io_wen2 & _T_242; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_245 = w0v_15 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_246 = _T_245 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_248 = w1v_15 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_249 = _T_248 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_250 = _T_246 | _T_249; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_252 = w2v_15 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_253 = _T_252 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_255 = io_waddr0 == 5'h10; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_16 = io_wen0 & _T_255; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_257 = io_waddr1 == 5'h10; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_16 = io_wen1 & _T_257; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_259 = io_waddr2 == 5'h10; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_16 = io_wen2 & _T_259; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_262 = w0v_16 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_263 = _T_262 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_265 = w1v_16 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_266 = _T_265 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_267 = _T_263 | _T_266; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_269 = w2v_16 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_270 = _T_269 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_272 = io_waddr0 == 5'h11; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_17 = io_wen0 & _T_272; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_274 = io_waddr1 == 5'h11; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_17 = io_wen1 & _T_274; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_276 = io_waddr2 == 5'h11; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_17 = io_wen2 & _T_276; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_279 = w0v_17 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_280 = _T_279 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_282 = w1v_17 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_283 = _T_282 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_284 = _T_280 | _T_283; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_286 = w2v_17 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_287 = _T_286 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_289 = io_waddr0 == 5'h12; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_18 = io_wen0 & _T_289; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_291 = io_waddr1 == 5'h12; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_18 = io_wen1 & _T_291; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_293 = io_waddr2 == 5'h12; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_18 = io_wen2 & _T_293; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_296 = w0v_18 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_297 = _T_296 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_299 = w1v_18 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_300 = _T_299 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_301 = _T_297 | _T_300; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_303 = w2v_18 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_304 = _T_303 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_306 = io_waddr0 == 5'h13; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_19 = io_wen0 & _T_306; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_308 = io_waddr1 == 5'h13; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_19 = io_wen1 & _T_308; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_310 = io_waddr2 == 5'h13; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_19 = io_wen2 & _T_310; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_313 = w0v_19 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_314 = _T_313 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_316 = w1v_19 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_317 = _T_316 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_318 = _T_314 | _T_317; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_320 = w2v_19 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_321 = _T_320 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_323 = io_waddr0 == 5'h14; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_20 = io_wen0 & _T_323; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_325 = io_waddr1 == 5'h14; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_20 = io_wen1 & _T_325; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_327 = io_waddr2 == 5'h14; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_20 = io_wen2 & _T_327; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_330 = w0v_20 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_331 = _T_330 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_333 = w1v_20 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_334 = _T_333 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_335 = _T_331 | _T_334; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_337 = w2v_20 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_338 = _T_337 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_340 = io_waddr0 == 5'h15; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_21 = io_wen0 & _T_340; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_342 = io_waddr1 == 5'h15; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_21 = io_wen1 & _T_342; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_344 = io_waddr2 == 5'h15; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_21 = io_wen2 & _T_344; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_347 = w0v_21 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_348 = _T_347 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_350 = w1v_21 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_351 = _T_350 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_352 = _T_348 | _T_351; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_354 = w2v_21 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_355 = _T_354 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_357 = io_waddr0 == 5'h16; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_22 = io_wen0 & _T_357; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_359 = io_waddr1 == 5'h16; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_22 = io_wen1 & _T_359; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_361 = io_waddr2 == 5'h16; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_22 = io_wen2 & _T_361; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_364 = w0v_22 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_365 = _T_364 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_367 = w1v_22 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_368 = _T_367 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_369 = _T_365 | _T_368; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_371 = w2v_22 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_372 = _T_371 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_374 = io_waddr0 == 5'h17; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_23 = io_wen0 & _T_374; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_376 = io_waddr1 == 5'h17; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_23 = io_wen1 & _T_376; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_378 = io_waddr2 == 5'h17; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_23 = io_wen2 & _T_378; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_381 = w0v_23 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_382 = _T_381 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_384 = w1v_23 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_385 = _T_384 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_386 = _T_382 | _T_385; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_388 = w2v_23 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_389 = _T_388 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_391 = io_waddr0 == 5'h18; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_24 = io_wen0 & _T_391; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_393 = io_waddr1 == 5'h18; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_24 = io_wen1 & _T_393; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_395 = io_waddr2 == 5'h18; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_24 = io_wen2 & _T_395; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_398 = w0v_24 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_399 = _T_398 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_401 = w1v_24 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_402 = _T_401 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_403 = _T_399 | _T_402; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_405 = w2v_24 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_406 = _T_405 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_408 = io_waddr0 == 5'h19; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_25 = io_wen0 & _T_408; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_410 = io_waddr1 == 5'h19; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_25 = io_wen1 & _T_410; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_412 = io_waddr2 == 5'h19; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_25 = io_wen2 & _T_412; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_415 = w0v_25 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_416 = _T_415 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_418 = w1v_25 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_419 = _T_418 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_420 = _T_416 | _T_419; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_422 = w2v_25 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_423 = _T_422 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_425 = io_waddr0 == 5'h1a; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_26 = io_wen0 & _T_425; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_427 = io_waddr1 == 5'h1a; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_26 = io_wen1 & _T_427; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_429 = io_waddr2 == 5'h1a; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_26 = io_wen2 & _T_429; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_432 = w0v_26 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_433 = _T_432 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_435 = w1v_26 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_436 = _T_435 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_437 = _T_433 | _T_436; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_439 = w2v_26 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_440 = _T_439 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_442 = io_waddr0 == 5'h1b; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_27 = io_wen0 & _T_442; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_444 = io_waddr1 == 5'h1b; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_27 = io_wen1 & _T_444; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_446 = io_waddr2 == 5'h1b; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_27 = io_wen2 & _T_446; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_449 = w0v_27 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_450 = _T_449 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_452 = w1v_27 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_453 = _T_452 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_454 = _T_450 | _T_453; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_456 = w2v_27 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_457 = _T_456 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_459 = io_waddr0 == 5'h1c; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_28 = io_wen0 & _T_459; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_461 = io_waddr1 == 5'h1c; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_28 = io_wen1 & _T_461; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_463 = io_waddr2 == 5'h1c; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_28 = io_wen2 & _T_463; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_466 = w0v_28 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_467 = _T_466 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_469 = w1v_28 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_470 = _T_469 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_471 = _T_467 | _T_470; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_473 = w2v_28 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_474 = _T_473 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_476 = io_waddr0 == 5'h1d; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_29 = io_wen0 & _T_476; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_478 = io_waddr1 == 5'h1d; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_29 = io_wen1 & _T_478; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_480 = io_waddr2 == 5'h1d; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_29 = io_wen2 & _T_480; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_483 = w0v_29 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_484 = _T_483 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_486 = w1v_29 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_487 = _T_486 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_488 = _T_484 | _T_487; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_490 = w2v_29 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_491 = _T_490 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_493 = io_waddr0 == 5'h1e; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_30 = io_wen0 & _T_493; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_495 = io_waddr1 == 5'h1e; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_30 = io_wen1 & _T_495; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_497 = io_waddr2 == 5'h1e; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_30 = io_wen2 & _T_497; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_500 = w0v_30 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_501 = _T_500 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_503 = w1v_30 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_504 = _T_503 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_505 = _T_501 | _T_504; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_507 = w2v_30 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_508 = _T_507 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire  _T_510 = io_waddr0 == 5'h1f; // @[dec_gpr_ctl.scala 52:45]
  wire  w0v_31 = io_wen0 & _T_510; // @[dec_gpr_ctl.scala 52:33]
  wire  _T_512 = io_waddr1 == 5'h1f; // @[dec_gpr_ctl.scala 53:45]
  wire  w1v_31 = io_wen1 & _T_512; // @[dec_gpr_ctl.scala 53:33]
  wire  _T_514 = io_waddr2 == 5'h1f; // @[dec_gpr_ctl.scala 54:45]
  wire  w2v_31 = io_wen2 & _T_514; // @[dec_gpr_ctl.scala 54:33]
  wire [31:0] _T_517 = w0v_31 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_518 = _T_517 & io_wd0; // @[dec_gpr_ctl.scala 55:42]
  wire [31:0] _T_520 = w1v_31 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_521 = _T_520 & io_wd1; // @[dec_gpr_ctl.scala 55:71]
  wire [31:0] _T_522 = _T_518 | _T_521; // @[dec_gpr_ctl.scala 55:52]
  wire [31:0] _T_524 = w2v_31 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_525 = _T_524 & io_wd2; // @[dec_gpr_ctl.scala 55:100]
  wire [9:0] _T_535 = {w0v_9,w0v_8,w0v_7,w0v_6,w0v_5,w0v_4,w0v_3,w0v_2,w0v_1,1'h0}; // @[Cat.scala 29:58]
  wire [18:0] _T_544 = {w0v_18,w0v_17,w0v_16,w0v_15,w0v_14,w0v_13,w0v_12,w0v_11,w0v_10,_T_535}; // @[Cat.scala 29:58]
  wire [27:0] _T_553 = {w0v_27,w0v_26,w0v_25,w0v_24,w0v_23,w0v_22,w0v_21,w0v_20,w0v_19,_T_544}; // @[Cat.scala 29:58]
  wire [31:0] _T_557 = {w0v_31,w0v_30,w0v_29,w0v_28,_T_553}; // @[Cat.scala 29:58]
  wire [9:0] _T_566 = {w1v_9,w1v_8,w1v_7,w1v_6,w1v_5,w1v_4,w1v_3,w1v_2,w1v_1,1'h0}; // @[Cat.scala 29:58]
  wire [18:0] _T_575 = {w1v_18,w1v_17,w1v_16,w1v_15,w1v_14,w1v_13,w1v_12,w1v_11,w1v_10,_T_566}; // @[Cat.scala 29:58]
  wire [27:0] _T_584 = {w1v_27,w1v_26,w1v_25,w1v_24,w1v_23,w1v_22,w1v_21,w1v_20,w1v_19,_T_575}; // @[Cat.scala 29:58]
  wire [31:0] _T_588 = {w1v_31,w1v_30,w1v_29,w1v_28,_T_584}; // @[Cat.scala 29:58]
  wire [31:0] _T_589 = _T_557 | _T_588; // @[dec_gpr_ctl.scala 57:57]
  wire [9:0] _T_598 = {w2v_9,w2v_8,w2v_7,w2v_6,w2v_5,w2v_4,w2v_3,w2v_2,w2v_1,1'h0}; // @[Cat.scala 29:58]
  wire [18:0] _T_607 = {w2v_18,w2v_17,w2v_16,w2v_15,w2v_14,w2v_13,w2v_12,w2v_11,w2v_10,_T_598}; // @[Cat.scala 29:58]
  wire [27:0] _T_616 = {w2v_27,w2v_26,w2v_25,w2v_24,w2v_23,w2v_22,w2v_21,w2v_20,w2v_19,_T_607}; // @[Cat.scala 29:58]
  wire [31:0] _T_620 = {w2v_31,w2v_30,w2v_29,w2v_28,_T_616}; // @[Cat.scala 29:58]
  wire [31:0] gpr_wr_en = _T_589 | _T_620; // @[dec_gpr_ctl.scala 57:95]
  reg [31:0] gpr_out_1; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_2; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_3; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_4; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_5; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_6; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_7; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_8; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_9; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_10; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_11; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_12; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_13; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_14; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_15; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_16; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_17; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_18; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_19; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_20; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_21; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_22; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_23; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_24; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_25; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_26; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_27; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_28; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_29; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_30; // @[el2_lib.scala 514:16]
  reg [31:0] gpr_out_31; // @[el2_lib.scala 514:16]
  wire  _T_684 = io_raddr0 == 5'h1; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_686 = io_raddr0 == 5'h2; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_688 = io_raddr0 == 5'h3; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_690 = io_raddr0 == 5'h4; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_692 = io_raddr0 == 5'h5; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_694 = io_raddr0 == 5'h6; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_696 = io_raddr0 == 5'h7; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_698 = io_raddr0 == 5'h8; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_700 = io_raddr0 == 5'h9; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_702 = io_raddr0 == 5'ha; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_704 = io_raddr0 == 5'hb; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_706 = io_raddr0 == 5'hc; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_708 = io_raddr0 == 5'hd; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_710 = io_raddr0 == 5'he; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_712 = io_raddr0 == 5'hf; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_714 = io_raddr0 == 5'h10; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_716 = io_raddr0 == 5'h11; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_718 = io_raddr0 == 5'h12; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_720 = io_raddr0 == 5'h13; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_722 = io_raddr0 == 5'h14; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_724 = io_raddr0 == 5'h15; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_726 = io_raddr0 == 5'h16; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_728 = io_raddr0 == 5'h17; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_730 = io_raddr0 == 5'h18; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_732 = io_raddr0 == 5'h19; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_734 = io_raddr0 == 5'h1a; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_736 = io_raddr0 == 5'h1b; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_738 = io_raddr0 == 5'h1c; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_740 = io_raddr0 == 5'h1d; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_742 = io_raddr0 == 5'h1e; // @[dec_gpr_ctl.scala 64:72]
  wire  _T_744 = io_raddr0 == 5'h1f; // @[dec_gpr_ctl.scala 64:72]
  wire [31:0] _T_746 = _T_684 ? gpr_out_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_747 = _T_686 ? gpr_out_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_748 = _T_688 ? gpr_out_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_749 = _T_690 ? gpr_out_4 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_750 = _T_692 ? gpr_out_5 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_751 = _T_694 ? gpr_out_6 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_752 = _T_696 ? gpr_out_7 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_753 = _T_698 ? gpr_out_8 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_754 = _T_700 ? gpr_out_9 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_755 = _T_702 ? gpr_out_10 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_756 = _T_704 ? gpr_out_11 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_757 = _T_706 ? gpr_out_12 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_758 = _T_708 ? gpr_out_13 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_759 = _T_710 ? gpr_out_14 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_760 = _T_712 ? gpr_out_15 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_761 = _T_714 ? gpr_out_16 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_762 = _T_716 ? gpr_out_17 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_763 = _T_718 ? gpr_out_18 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_764 = _T_720 ? gpr_out_19 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_765 = _T_722 ? gpr_out_20 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_766 = _T_724 ? gpr_out_21 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_767 = _T_726 ? gpr_out_22 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_768 = _T_728 ? gpr_out_23 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_769 = _T_730 ? gpr_out_24 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_770 = _T_732 ? gpr_out_25 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_771 = _T_734 ? gpr_out_26 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_772 = _T_736 ? gpr_out_27 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_773 = _T_738 ? gpr_out_28 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_774 = _T_740 ? gpr_out_29 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_775 = _T_742 ? gpr_out_30 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_776 = _T_744 ? gpr_out_31 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_777 = _T_746 | _T_747; // @[Mux.scala 27:72]
  wire [31:0] _T_778 = _T_777 | _T_748; // @[Mux.scala 27:72]
  wire [31:0] _T_779 = _T_778 | _T_749; // @[Mux.scala 27:72]
  wire [31:0] _T_780 = _T_779 | _T_750; // @[Mux.scala 27:72]
  wire [31:0] _T_781 = _T_780 | _T_751; // @[Mux.scala 27:72]
  wire [31:0] _T_782 = _T_781 | _T_752; // @[Mux.scala 27:72]
  wire [31:0] _T_783 = _T_782 | _T_753; // @[Mux.scala 27:72]
  wire [31:0] _T_784 = _T_783 | _T_754; // @[Mux.scala 27:72]
  wire [31:0] _T_785 = _T_784 | _T_755; // @[Mux.scala 27:72]
  wire [31:0] _T_786 = _T_785 | _T_756; // @[Mux.scala 27:72]
  wire [31:0] _T_787 = _T_786 | _T_757; // @[Mux.scala 27:72]
  wire [31:0] _T_788 = _T_787 | _T_758; // @[Mux.scala 27:72]
  wire [31:0] _T_789 = _T_788 | _T_759; // @[Mux.scala 27:72]
  wire [31:0] _T_790 = _T_789 | _T_760; // @[Mux.scala 27:72]
  wire [31:0] _T_791 = _T_790 | _T_761; // @[Mux.scala 27:72]
  wire [31:0] _T_792 = _T_791 | _T_762; // @[Mux.scala 27:72]
  wire [31:0] _T_793 = _T_792 | _T_763; // @[Mux.scala 27:72]
  wire [31:0] _T_794 = _T_793 | _T_764; // @[Mux.scala 27:72]
  wire [31:0] _T_795 = _T_794 | _T_765; // @[Mux.scala 27:72]
  wire [31:0] _T_796 = _T_795 | _T_766; // @[Mux.scala 27:72]
  wire [31:0] _T_797 = _T_796 | _T_767; // @[Mux.scala 27:72]
  wire [31:0] _T_798 = _T_797 | _T_768; // @[Mux.scala 27:72]
  wire [31:0] _T_799 = _T_798 | _T_769; // @[Mux.scala 27:72]
  wire [31:0] _T_800 = _T_799 | _T_770; // @[Mux.scala 27:72]
  wire [31:0] _T_801 = _T_800 | _T_771; // @[Mux.scala 27:72]
  wire [31:0] _T_802 = _T_801 | _T_772; // @[Mux.scala 27:72]
  wire [31:0] _T_803 = _T_802 | _T_773; // @[Mux.scala 27:72]
  wire [31:0] _T_804 = _T_803 | _T_774; // @[Mux.scala 27:72]
  wire [31:0] _T_805 = _T_804 | _T_775; // @[Mux.scala 27:72]
  wire  _T_808 = io_raddr1 == 5'h1; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_810 = io_raddr1 == 5'h2; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_812 = io_raddr1 == 5'h3; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_814 = io_raddr1 == 5'h4; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_816 = io_raddr1 == 5'h5; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_818 = io_raddr1 == 5'h6; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_820 = io_raddr1 == 5'h7; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_822 = io_raddr1 == 5'h8; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_824 = io_raddr1 == 5'h9; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_826 = io_raddr1 == 5'ha; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_828 = io_raddr1 == 5'hb; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_830 = io_raddr1 == 5'hc; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_832 = io_raddr1 == 5'hd; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_834 = io_raddr1 == 5'he; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_836 = io_raddr1 == 5'hf; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_838 = io_raddr1 == 5'h10; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_840 = io_raddr1 == 5'h11; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_842 = io_raddr1 == 5'h12; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_844 = io_raddr1 == 5'h13; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_846 = io_raddr1 == 5'h14; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_848 = io_raddr1 == 5'h15; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_850 = io_raddr1 == 5'h16; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_852 = io_raddr1 == 5'h17; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_854 = io_raddr1 == 5'h18; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_856 = io_raddr1 == 5'h19; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_858 = io_raddr1 == 5'h1a; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_860 = io_raddr1 == 5'h1b; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_862 = io_raddr1 == 5'h1c; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_864 = io_raddr1 == 5'h1d; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_866 = io_raddr1 == 5'h1e; // @[dec_gpr_ctl.scala 65:72]
  wire  _T_868 = io_raddr1 == 5'h1f; // @[dec_gpr_ctl.scala 65:72]
  wire [31:0] _T_870 = _T_808 ? gpr_out_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_871 = _T_810 ? gpr_out_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_872 = _T_812 ? gpr_out_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_873 = _T_814 ? gpr_out_4 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_874 = _T_816 ? gpr_out_5 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_875 = _T_818 ? gpr_out_6 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_876 = _T_820 ? gpr_out_7 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_877 = _T_822 ? gpr_out_8 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_878 = _T_824 ? gpr_out_9 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_879 = _T_826 ? gpr_out_10 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_880 = _T_828 ? gpr_out_11 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_881 = _T_830 ? gpr_out_12 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_882 = _T_832 ? gpr_out_13 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_883 = _T_834 ? gpr_out_14 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_884 = _T_836 ? gpr_out_15 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_885 = _T_838 ? gpr_out_16 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_886 = _T_840 ? gpr_out_17 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_887 = _T_842 ? gpr_out_18 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_888 = _T_844 ? gpr_out_19 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_889 = _T_846 ? gpr_out_20 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_890 = _T_848 ? gpr_out_21 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_891 = _T_850 ? gpr_out_22 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_892 = _T_852 ? gpr_out_23 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_893 = _T_854 ? gpr_out_24 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_894 = _T_856 ? gpr_out_25 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_895 = _T_858 ? gpr_out_26 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_896 = _T_860 ? gpr_out_27 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_897 = _T_862 ? gpr_out_28 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_898 = _T_864 ? gpr_out_29 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_899 = _T_866 ? gpr_out_30 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_900 = _T_868 ? gpr_out_31 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_901 = _T_870 | _T_871; // @[Mux.scala 27:72]
  wire [31:0] _T_902 = _T_901 | _T_872; // @[Mux.scala 27:72]
  wire [31:0] _T_903 = _T_902 | _T_873; // @[Mux.scala 27:72]
  wire [31:0] _T_904 = _T_903 | _T_874; // @[Mux.scala 27:72]
  wire [31:0] _T_905 = _T_904 | _T_875; // @[Mux.scala 27:72]
  wire [31:0] _T_906 = _T_905 | _T_876; // @[Mux.scala 27:72]
  wire [31:0] _T_907 = _T_906 | _T_877; // @[Mux.scala 27:72]
  wire [31:0] _T_908 = _T_907 | _T_878; // @[Mux.scala 27:72]
  wire [31:0] _T_909 = _T_908 | _T_879; // @[Mux.scala 27:72]
  wire [31:0] _T_910 = _T_909 | _T_880; // @[Mux.scala 27:72]
  wire [31:0] _T_911 = _T_910 | _T_881; // @[Mux.scala 27:72]
  wire [31:0] _T_912 = _T_911 | _T_882; // @[Mux.scala 27:72]
  wire [31:0] _T_913 = _T_912 | _T_883; // @[Mux.scala 27:72]
  wire [31:0] _T_914 = _T_913 | _T_884; // @[Mux.scala 27:72]
  wire [31:0] _T_915 = _T_914 | _T_885; // @[Mux.scala 27:72]
  wire [31:0] _T_916 = _T_915 | _T_886; // @[Mux.scala 27:72]
  wire [31:0] _T_917 = _T_916 | _T_887; // @[Mux.scala 27:72]
  wire [31:0] _T_918 = _T_917 | _T_888; // @[Mux.scala 27:72]
  wire [31:0] _T_919 = _T_918 | _T_889; // @[Mux.scala 27:72]
  wire [31:0] _T_920 = _T_919 | _T_890; // @[Mux.scala 27:72]
  wire [31:0] _T_921 = _T_920 | _T_891; // @[Mux.scala 27:72]
  wire [31:0] _T_922 = _T_921 | _T_892; // @[Mux.scala 27:72]
  wire [31:0] _T_923 = _T_922 | _T_893; // @[Mux.scala 27:72]
  wire [31:0] _T_924 = _T_923 | _T_894; // @[Mux.scala 27:72]
  wire [31:0] _T_925 = _T_924 | _T_895; // @[Mux.scala 27:72]
  wire [31:0] _T_926 = _T_925 | _T_896; // @[Mux.scala 27:72]
  wire [31:0] _T_927 = _T_926 | _T_897; // @[Mux.scala 27:72]
  wire [31:0] _T_928 = _T_927 | _T_898; // @[Mux.scala 27:72]
  wire [31:0] _T_929 = _T_928 | _T_899; // @[Mux.scala 27:72]
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
  assign io_gpr_exu_gpr_i0_rs1_d = _T_805 | _T_776; // @[dec_gpr_ctl.scala 48:32 dec_gpr_ctl.scala 64:32]
  assign io_gpr_exu_gpr_i0_rs2_d = _T_929 | _T_900; // @[dec_gpr_ctl.scala 49:32 dec_gpr_ctl.scala 65:32]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_io_en = gpr_wr_en[1]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = gpr_wr_en[2]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_2_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_2_io_en = gpr_wr_en[3]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_3_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_3_io_en = gpr_wr_en[4]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_4_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_4_io_en = gpr_wr_en[5]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_5_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_5_io_en = gpr_wr_en[6]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_6_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_6_io_en = gpr_wr_en[7]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_7_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_7_io_en = gpr_wr_en[8]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_8_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_8_io_en = gpr_wr_en[9]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_9_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_9_io_en = gpr_wr_en[10]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_10_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_10_io_en = gpr_wr_en[11]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_11_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_11_io_en = gpr_wr_en[12]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_12_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_12_io_en = gpr_wr_en[13]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_13_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_13_io_en = gpr_wr_en[14]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_14_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_14_io_en = gpr_wr_en[15]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_15_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_15_io_en = gpr_wr_en[16]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_16_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_16_io_en = gpr_wr_en[17]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_17_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_17_io_en = gpr_wr_en[18]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_17_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_18_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_18_io_en = gpr_wr_en[19]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_18_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_19_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_19_io_en = gpr_wr_en[20]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_19_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_20_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_20_io_en = gpr_wr_en[21]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_20_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_21_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_21_io_en = gpr_wr_en[22]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_21_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_22_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_22_io_en = gpr_wr_en[23]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_22_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_23_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_23_io_en = gpr_wr_en[24]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_23_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_24_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_24_io_en = gpr_wr_en[25]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_24_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_25_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_25_io_en = gpr_wr_en[26]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_25_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_26_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_26_io_en = gpr_wr_en[27]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_26_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_27_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_27_io_en = gpr_wr_en[28]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_27_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_28_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_28_io_en = gpr_wr_en[29]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_28_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_29_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_29_io_en = gpr_wr_en[30]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_29_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_30_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_30_io_en = gpr_wr_en[31]; // @[el2_lib.scala 511:17]
  assign rvclkhdr_30_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
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
  gpr_out_1 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  gpr_out_2 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  gpr_out_3 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  gpr_out_4 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  gpr_out_5 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  gpr_out_6 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  gpr_out_7 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  gpr_out_8 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  gpr_out_9 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  gpr_out_10 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  gpr_out_11 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  gpr_out_12 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  gpr_out_13 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  gpr_out_14 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  gpr_out_15 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  gpr_out_16 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  gpr_out_17 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  gpr_out_18 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  gpr_out_19 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  gpr_out_20 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  gpr_out_21 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  gpr_out_22 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  gpr_out_23 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  gpr_out_24 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  gpr_out_25 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  gpr_out_26 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  gpr_out_27 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  gpr_out_28 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  gpr_out_29 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  gpr_out_30 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  gpr_out_31 = _RAND_30[31:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    gpr_out_1 = 32'h0;
  end
  if (reset) begin
    gpr_out_2 = 32'h0;
  end
  if (reset) begin
    gpr_out_3 = 32'h0;
  end
  if (reset) begin
    gpr_out_4 = 32'h0;
  end
  if (reset) begin
    gpr_out_5 = 32'h0;
  end
  if (reset) begin
    gpr_out_6 = 32'h0;
  end
  if (reset) begin
    gpr_out_7 = 32'h0;
  end
  if (reset) begin
    gpr_out_8 = 32'h0;
  end
  if (reset) begin
    gpr_out_9 = 32'h0;
  end
  if (reset) begin
    gpr_out_10 = 32'h0;
  end
  if (reset) begin
    gpr_out_11 = 32'h0;
  end
  if (reset) begin
    gpr_out_12 = 32'h0;
  end
  if (reset) begin
    gpr_out_13 = 32'h0;
  end
  if (reset) begin
    gpr_out_14 = 32'h0;
  end
  if (reset) begin
    gpr_out_15 = 32'h0;
  end
  if (reset) begin
    gpr_out_16 = 32'h0;
  end
  if (reset) begin
    gpr_out_17 = 32'h0;
  end
  if (reset) begin
    gpr_out_18 = 32'h0;
  end
  if (reset) begin
    gpr_out_19 = 32'h0;
  end
  if (reset) begin
    gpr_out_20 = 32'h0;
  end
  if (reset) begin
    gpr_out_21 = 32'h0;
  end
  if (reset) begin
    gpr_out_22 = 32'h0;
  end
  if (reset) begin
    gpr_out_23 = 32'h0;
  end
  if (reset) begin
    gpr_out_24 = 32'h0;
  end
  if (reset) begin
    gpr_out_25 = 32'h0;
  end
  if (reset) begin
    gpr_out_26 = 32'h0;
  end
  if (reset) begin
    gpr_out_27 = 32'h0;
  end
  if (reset) begin
    gpr_out_28 = 32'h0;
  end
  if (reset) begin
    gpr_out_29 = 32'h0;
  end
  if (reset) begin
    gpr_out_30 = 32'h0;
  end
  if (reset) begin
    gpr_out_31 = 32'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_1 <= 32'h0;
    end else begin
      gpr_out_1 <= _T_12 | _T_15;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_2 <= 32'h0;
    end else begin
      gpr_out_2 <= _T_29 | _T_32;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_3 <= 32'h0;
    end else begin
      gpr_out_3 <= _T_46 | _T_49;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_4 <= 32'h0;
    end else begin
      gpr_out_4 <= _T_63 | _T_66;
    end
  end
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_5 <= 32'h0;
    end else begin
      gpr_out_5 <= _T_80 | _T_83;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_6 <= 32'h0;
    end else begin
      gpr_out_6 <= _T_97 | _T_100;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_7 <= 32'h0;
    end else begin
      gpr_out_7 <= _T_114 | _T_117;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_8 <= 32'h0;
    end else begin
      gpr_out_8 <= _T_131 | _T_134;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_9 <= 32'h0;
    end else begin
      gpr_out_9 <= _T_148 | _T_151;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_10 <= 32'h0;
    end else begin
      gpr_out_10 <= _T_165 | _T_168;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_11 <= 32'h0;
    end else begin
      gpr_out_11 <= _T_182 | _T_185;
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_12 <= 32'h0;
    end else begin
      gpr_out_12 <= _T_199 | _T_202;
    end
  end
  always @(posedge rvclkhdr_12_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_13 <= 32'h0;
    end else begin
      gpr_out_13 <= _T_216 | _T_219;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_14 <= 32'h0;
    end else begin
      gpr_out_14 <= _T_233 | _T_236;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_15 <= 32'h0;
    end else begin
      gpr_out_15 <= _T_250 | _T_253;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_16 <= 32'h0;
    end else begin
      gpr_out_16 <= _T_267 | _T_270;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_17 <= 32'h0;
    end else begin
      gpr_out_17 <= _T_284 | _T_287;
    end
  end
  always @(posedge rvclkhdr_17_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_18 <= 32'h0;
    end else begin
      gpr_out_18 <= _T_301 | _T_304;
    end
  end
  always @(posedge rvclkhdr_18_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_19 <= 32'h0;
    end else begin
      gpr_out_19 <= _T_318 | _T_321;
    end
  end
  always @(posedge rvclkhdr_19_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_20 <= 32'h0;
    end else begin
      gpr_out_20 <= _T_335 | _T_338;
    end
  end
  always @(posedge rvclkhdr_20_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_21 <= 32'h0;
    end else begin
      gpr_out_21 <= _T_352 | _T_355;
    end
  end
  always @(posedge rvclkhdr_21_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_22 <= 32'h0;
    end else begin
      gpr_out_22 <= _T_369 | _T_372;
    end
  end
  always @(posedge rvclkhdr_22_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_23 <= 32'h0;
    end else begin
      gpr_out_23 <= _T_386 | _T_389;
    end
  end
  always @(posedge rvclkhdr_23_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_24 <= 32'h0;
    end else begin
      gpr_out_24 <= _T_403 | _T_406;
    end
  end
  always @(posedge rvclkhdr_24_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_25 <= 32'h0;
    end else begin
      gpr_out_25 <= _T_420 | _T_423;
    end
  end
  always @(posedge rvclkhdr_25_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_26 <= 32'h0;
    end else begin
      gpr_out_26 <= _T_437 | _T_440;
    end
  end
  always @(posedge rvclkhdr_26_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_27 <= 32'h0;
    end else begin
      gpr_out_27 <= _T_454 | _T_457;
    end
  end
  always @(posedge rvclkhdr_27_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_28 <= 32'h0;
    end else begin
      gpr_out_28 <= _T_471 | _T_474;
    end
  end
  always @(posedge rvclkhdr_28_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_29 <= 32'h0;
    end else begin
      gpr_out_29 <= _T_488 | _T_491;
    end
  end
  always @(posedge rvclkhdr_29_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_30 <= 32'h0;
    end else begin
      gpr_out_30 <= _T_505 | _T_508;
    end
  end
  always @(posedge rvclkhdr_30_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_31 <= 32'h0;
    end else begin
      gpr_out_31 <= _T_522 | _T_525;
    end
  end
endmodule
module dec_timer_ctl(
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
  wire [31:0] mitb0 = ~mitb0_b; // @[dec_tlu_ctl.scala 2712:22]
  wire  mit0_match_ns = mitcnt0 >= mitb0; // @[dec_tlu_ctl.scala 2673:36]
  reg [31:0] mitcnt1; // @[el2_lib.scala 514:16]
  reg [31:0] mitb1_b; // @[el2_lib.scala 514:16]
  wire [31:0] mitb1 = ~mitb1_b; // @[dec_tlu_ctl.scala 2721:18]
  wire  mit1_match_ns = mitcnt1 >= mitb1; // @[dec_tlu_ctl.scala 2674:36]
  wire  _T = io_dec_csr_wraddr_r == 12'h7d2; // @[dec_tlu_ctl.scala 2684:72]
  wire  wr_mitcnt0_r = io_dec_csr_wen_r_mod & _T; // @[dec_tlu_ctl.scala 2684:49]
  reg [1:0] _T_57; // @[dec_tlu_ctl.scala 2737:67]
  reg  mitctl0_0_b; // @[dec_tlu_ctl.scala 2736:60]
  wire  _T_58 = ~mitctl0_0_b; // @[dec_tlu_ctl.scala 2737:90]
  wire [2:0] mitctl0 = {_T_57,_T_58}; // @[Cat.scala 29:58]
  wire  _T_2 = ~io_dec_pause_state; // @[dec_tlu_ctl.scala 2686:56]
  wire  _T_4 = _T_2 | mitctl0[2]; // @[dec_tlu_ctl.scala 2686:76]
  wire  _T_5 = mitctl0[0] & _T_4; // @[dec_tlu_ctl.scala 2686:53]
  wire  _T_6 = ~io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 2686:112]
  wire  _T_8 = _T_6 | mitctl0[1]; // @[dec_tlu_ctl.scala 2686:138]
  wire  _T_9 = _T_5 & _T_8; // @[dec_tlu_ctl.scala 2686:109]
  wire  _T_10 = ~io_internal_dbg_halt_timers; // @[dec_tlu_ctl.scala 2686:173]
  wire  mitcnt0_inc_ok = _T_9 & _T_10; // @[dec_tlu_ctl.scala 2686:171]
  wire [31:0] mitcnt0_inc = mitcnt0 + 32'h1; // @[dec_tlu_ctl.scala 2687:35]
  wire  _T_15 = wr_mitcnt0_r | mitcnt0_inc_ok; // @[dec_tlu_ctl.scala 2689:59]
  wire  _T_19 = io_dec_csr_wraddr_r == 12'h7d5; // @[dec_tlu_ctl.scala 2696:72]
  wire  wr_mitcnt1_r = io_dec_csr_wen_r_mod & _T_19; // @[dec_tlu_ctl.scala 2696:49]
  reg [2:0] _T_66; // @[dec_tlu_ctl.scala 2751:52]
  reg  mitctl1_0_b; // @[dec_tlu_ctl.scala 2750:55]
  wire  _T_67 = ~mitctl1_0_b; // @[dec_tlu_ctl.scala 2751:75]
  wire [3:0] mitctl1 = {_T_66,_T_67}; // @[Cat.scala 29:58]
  wire  _T_23 = _T_2 | mitctl1[2]; // @[dec_tlu_ctl.scala 2698:76]
  wire  _T_24 = mitctl1[0] & _T_23; // @[dec_tlu_ctl.scala 2698:53]
  wire  _T_27 = _T_6 | mitctl1[1]; // @[dec_tlu_ctl.scala 2698:138]
  wire  _T_28 = _T_24 & _T_27; // @[dec_tlu_ctl.scala 2698:109]
  wire  mitcnt1_inc_ok = _T_28 & _T_10; // @[dec_tlu_ctl.scala 2698:171]
  wire  _T_32 = ~mitctl1[3]; // @[dec_tlu_ctl.scala 2701:60]
  wire  _T_33 = _T_32 | mit0_match_ns; // @[dec_tlu_ctl.scala 2701:72]
  wire [31:0] _T_34 = {31'h0,_T_33}; // @[Cat.scala 29:58]
  wire [31:0] mitcnt1_inc = mitcnt1 + _T_34; // @[dec_tlu_ctl.scala 2701:35]
  wire  _T_39 = wr_mitcnt1_r | mitcnt1_inc_ok; // @[dec_tlu_ctl.scala 2703:60]
  wire  _T_43 = io_dec_csr_wraddr_r == 12'h7d3; // @[dec_tlu_ctl.scala 2710:70]
  wire  _T_47 = io_dec_csr_wraddr_r == 12'h7d6; // @[dec_tlu_ctl.scala 2719:69]
  wire  _T_51 = io_dec_csr_wraddr_r == 12'h7d4; // @[dec_tlu_ctl.scala 2732:72]
  wire  wr_mitctl0_r = io_dec_csr_wen_r_mod & _T_51; // @[dec_tlu_ctl.scala 2732:49]
  wire [2:0] mitctl0_ns = wr_mitctl0_r ? io_dec_csr_wrdata_r[2:0] : mitctl0; // @[dec_tlu_ctl.scala 2733:31]
  wire  _T_60 = io_dec_csr_wraddr_r == 12'h7d7; // @[dec_tlu_ctl.scala 2747:71]
  wire  wr_mitctl1_r = io_dec_csr_wen_r_mod & _T_60; // @[dec_tlu_ctl.scala 2747:49]
  wire [3:0] mitctl1_ns = wr_mitctl1_r ? io_dec_csr_wrdata_r[3:0] : mitctl1; // @[dec_tlu_ctl.scala 2748:31]
  wire  _T_69 = io_csr_mitcnt1 | io_csr_mitcnt0; // @[dec_tlu_ctl.scala 2753:51]
  wire  _T_70 = _T_69 | io_csr_mitb1; // @[dec_tlu_ctl.scala 2753:68]
  wire  _T_71 = _T_70 | io_csr_mitb0; // @[dec_tlu_ctl.scala 2753:83]
  wire  _T_72 = _T_71 | io_csr_mitctl0; // @[dec_tlu_ctl.scala 2753:98]
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
  assign io_dec_timer_rddata_d = _T_94 | _T_90; // @[dec_tlu_ctl.scala 2754:33]
  assign io_dec_timer_read_d = _T_72 | io_csr_mitctl1; // @[dec_tlu_ctl.scala 2753:33]
  assign io_dec_timer_t0_pulse = mitcnt0 >= mitb0; // @[dec_tlu_ctl.scala 2676:31]
  assign io_dec_timer_t1_pulse = mitcnt1 >= mitb1; // @[dec_tlu_ctl.scala 2677:31]
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
  wire  _T = ~io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 1450:45]
  wire  _T_1 = io_dec_csr_wen_r & _T; // @[dec_tlu_ctl.scala 1450:43]
  wire  _T_2 = ~io_rfpc_i0_r; // @[dec_tlu_ctl.scala 1450:68]
  wire  _T_5 = io_dec_csr_wraddr_r == 12'h300; // @[dec_tlu_ctl.scala 1451:71]
  wire  wr_mstatus_r = io_dec_csr_wen_r_mod & _T_5; // @[dec_tlu_ctl.scala 1451:42]
  wire  _T_498 = io_dec_csr_wraddr_r == 12'h7c6; // @[dec_tlu_ctl.scala 1837:68]
  wire  wr_mpmc_r = io_dec_csr_wen_r_mod & _T_498; // @[dec_tlu_ctl.scala 1837:39]
  wire  _T_510 = ~io_dec_csr_wrdata_r[1]; // @[dec_tlu_ctl.scala 1845:37]
  reg  mpmc_b; // @[dec_tlu_ctl.scala 1847:44]
  wire  mpmc = ~mpmc_b; // @[dec_tlu_ctl.scala 1850:10]
  wire  _T_511 = ~mpmc; // @[dec_tlu_ctl.scala 1845:62]
  wire  mpmc_b_ns = wr_mpmc_r ? _T_510 : _T_511; // @[dec_tlu_ctl.scala 1845:18]
  wire  _T_6 = ~mpmc_b_ns; // @[dec_tlu_ctl.scala 1454:28]
  wire  set_mie_pmu_fw_halt = _T_6 & io_fw_halt_req; // @[dec_tlu_ctl.scala 1454:39]
  wire  _T_7 = ~wr_mstatus_r; // @[dec_tlu_ctl.scala 1457:5]
  wire  _T_8 = _T_7 & io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 1457:19]
  wire [1:0] _T_12 = {io_mstatus[0],1'h0}; // @[Cat.scala 29:58]
  wire  _T_13 = wr_mstatus_r & io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 1458:18]
  wire [1:0] _T_16 = {io_dec_csr_wrdata_r[3],1'h0}; // @[Cat.scala 29:58]
  wire  _T_17 = ~io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 1459:17]
  wire  _T_18 = io_mret_r & _T_17; // @[dec_tlu_ctl.scala 1459:15]
  wire [1:0] _T_21 = {1'h1,io_mstatus[1]}; // @[Cat.scala 29:58]
  wire [1:0] _T_24 = {io_mstatus[1],1'h1}; // @[Cat.scala 29:58]
  wire  _T_26 = wr_mstatus_r & _T_17; // @[dec_tlu_ctl.scala 1461:18]
  wire [1:0] _T_30 = {io_dec_csr_wrdata_r[7],io_dec_csr_wrdata_r[3]}; // @[Cat.scala 29:58]
  wire  _T_33 = _T_7 & _T_17; // @[dec_tlu_ctl.scala 1462:19]
  wire  _T_34 = ~io_mret_r; // @[dec_tlu_ctl.scala 1462:46]
  wire  _T_35 = _T_33 & _T_34; // @[dec_tlu_ctl.scala 1462:44]
  wire  _T_36 = ~set_mie_pmu_fw_halt; // @[dec_tlu_ctl.scala 1462:59]
  wire  _T_37 = _T_35 & _T_36; // @[dec_tlu_ctl.scala 1462:57]
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
  wire  _T_52 = ~io_dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 1465:50]
  wire  _T_54 = _T_52 | io_dcsr[11]; // @[dec_tlu_ctl.scala 1465:81]
  reg [1:0] _T_56; // @[dec_tlu_ctl.scala 1467:11]
  wire  _T_58 = io_dec_csr_wraddr_r == 12'h305; // @[dec_tlu_ctl.scala 1476:69]
  reg [30:0] _T_62; // @[el2_lib.scala 514:16]
  reg [31:0] mdccmect; // @[el2_lib.scala 514:16]
  wire [62:0] _T_574 = 63'hffffffff << mdccmect[31:27]; // @[dec_tlu_ctl.scala 1897:41]
  wire [31:0] _T_576 = {5'h0,mdccmect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_9 = {{31'd0}, _T_576}; // @[dec_tlu_ctl.scala 1897:61]
  wire [62:0] _T_577 = _T_574 & _GEN_9; // @[dec_tlu_ctl.scala 1897:61]
  wire  mdccme_ce_req = |_T_577; // @[dec_tlu_ctl.scala 1897:94]
  reg [31:0] miccmect; // @[el2_lib.scala 514:16]
  wire [62:0] _T_554 = 63'hffffffff << miccmect[31:27]; // @[dec_tlu_ctl.scala 1882:40]
  wire [31:0] _T_556 = {5'h0,miccmect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_10 = {{31'd0}, _T_556}; // @[dec_tlu_ctl.scala 1882:60]
  wire [62:0] _T_557 = _T_554 & _GEN_10; // @[dec_tlu_ctl.scala 1882:60]
  wire  miccme_ce_req = |_T_557; // @[dec_tlu_ctl.scala 1882:93]
  wire  _T_63 = mdccme_ce_req | miccme_ce_req; // @[dec_tlu_ctl.scala 1490:30]
  reg [31:0] micect; // @[el2_lib.scala 514:16]
  wire [62:0] _T_532 = 63'hffffffff << micect[31:27]; // @[dec_tlu_ctl.scala 1867:39]
  wire [31:0] _T_534 = {5'h0,micect[26:0]}; // @[Cat.scala 29:58]
  wire [62:0] _GEN_11 = {{31'd0}, _T_534}; // @[dec_tlu_ctl.scala 1867:57]
  wire [62:0] _T_535 = _T_532 & _GEN_11; // @[dec_tlu_ctl.scala 1867:57]
  wire  mice_ce_req = |_T_535; // @[dec_tlu_ctl.scala 1867:88]
  wire  ce_int = _T_63 | mice_ce_req; // @[dec_tlu_ctl.scala 1490:46]
  wire [2:0] _T_65 = {io_mexintpend,io_timer_int_sync,io_soft_int_sync}; // @[Cat.scala 29:58]
  wire [2:0] _T_67 = {ce_int,io_dec_timer_t0_pulse,io_dec_timer_t1_pulse}; // @[Cat.scala 29:58]
  reg [5:0] _T_68; // @[dec_tlu_ctl.scala 1494:11]
  wire  _T_70 = io_dec_csr_wraddr_r == 12'h304; // @[dec_tlu_ctl.scala 1506:67]
  wire  wr_mie_r = io_dec_csr_wen_r_mod & _T_70; // @[dec_tlu_ctl.scala 1506:38]
  wire [5:0] _T_78 = {io_dec_csr_wrdata_r[30:28],io_dec_csr_wrdata_r[11],io_dec_csr_wrdata_r[7],io_dec_csr_wrdata_r[3]}; // @[Cat.scala 29:58]
  reg [5:0] mie; // @[dec_tlu_ctl.scala 1509:11]
  wire  kill_ebreak_count_r = io_ebreak_to_debug_mode_r & io_dcsr[10]; // @[dec_tlu_ctl.scala 1516:54]
  wire  _T_83 = io_dec_csr_wraddr_r == 12'hb00; // @[dec_tlu_ctl.scala 1518:71]
  wire  wr_mcyclel_r = io_dec_csr_wen_r_mod & _T_83; // @[dec_tlu_ctl.scala 1518:42]
  wire  _T_85 = io_dec_tlu_dbg_halted & io_dcsr[10]; // @[dec_tlu_ctl.scala 1520:71]
  wire  _T_86 = kill_ebreak_count_r | _T_85; // @[dec_tlu_ctl.scala 1520:46]
  wire  _T_87 = _T_86 | io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 1520:94]
  reg [4:0] temp_ncount6_2; // @[Reg.scala 27:20]
  reg  temp_ncount0; // @[Reg.scala 27:20]
  wire [6:0] mcountinhibit = {temp_ncount6_2,1'h0,temp_ncount0}; // @[Cat.scala 29:58]
  wire  _T_89 = _T_87 | mcountinhibit[0]; // @[dec_tlu_ctl.scala 1520:121]
  wire  mcyclel_cout_in = ~_T_89; // @[dec_tlu_ctl.scala 1520:24]
  wire [31:0] _T_90 = {31'h0,mcyclel_cout_in}; // @[Cat.scala 29:58]
  reg [31:0] mcyclel; // @[el2_lib.scala 514:16]
  wire [32:0] mcyclel_inc = mcyclel + _T_90; // @[dec_tlu_ctl.scala 1524:25]
  wire  mcyclel_cout = mcyclel_inc[32]; // @[dec_tlu_ctl.scala 1526:32]
  wire  _T_101 = io_dec_csr_wraddr_r == 12'hb80; // @[dec_tlu_ctl.scala 1534:68]
  wire  wr_mcycleh_r = io_dec_csr_wen_r_mod & _T_101; // @[dec_tlu_ctl.scala 1534:39]
  wire  _T_98 = ~wr_mcycleh_r; // @[dec_tlu_ctl.scala 1528:71]
  reg  mcyclel_cout_f; // @[dec_tlu_ctl.scala 1528:54]
  wire [31:0] _T_103 = {31'h0,mcyclel_cout_f}; // @[Cat.scala 29:58]
  reg [31:0] mcycleh; // @[el2_lib.scala 514:16]
  wire [31:0] mcycleh_inc = mcycleh + _T_103; // @[dec_tlu_ctl.scala 1536:28]
  wire  _T_109 = io_ebreak_r | io_ecall_r; // @[dec_tlu_ctl.scala 1553:72]
  wire  _T_110 = _T_109 | io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 1553:85]
  wire  _T_111 = _T_110 | io_illegal_r; // @[dec_tlu_ctl.scala 1553:113]
  wire  _T_113 = _T_111 | mcountinhibit[2]; // @[dec_tlu_ctl.scala 1553:128]
  wire  _T_115 = ~_T_113; // @[dec_tlu_ctl.scala 1553:58]
  wire  i0_valid_no_ebreak_ecall_r = io_tlu_i0_commit_cmt & _T_115; // @[dec_tlu_ctl.scala 1553:56]
  wire  _T_117 = io_dec_csr_wraddr_r == 12'hb02; // @[dec_tlu_ctl.scala 1555:73]
  wire  wr_minstretl_r = io_dec_csr_wen_r_mod & _T_117; // @[dec_tlu_ctl.scala 1555:44]
  wire [31:0] _T_118 = {31'h0,i0_valid_no_ebreak_ecall_r}; // @[Cat.scala 29:58]
  reg [31:0] minstretl; // @[el2_lib.scala 514:16]
  wire [32:0] minstretl_inc = minstretl + _T_118; // @[dec_tlu_ctl.scala 1557:29]
  wire  minstretl_cout = minstretl_inc[32]; // @[dec_tlu_ctl.scala 1558:36]
  reg  minstret_enable_f; // @[dec_tlu_ctl.scala 1563:56]
  wire  _T_128 = io_dec_csr_wraddr_r == 12'hb82; // @[dec_tlu_ctl.scala 1572:71]
  wire  wr_minstreth_r = io_dec_csr_wen_r_mod & _T_128; // @[dec_tlu_ctl.scala 1572:42]
  wire  _T_125 = ~wr_minstreth_r; // @[dec_tlu_ctl.scala 1564:75]
  reg  minstretl_cout_f; // @[dec_tlu_ctl.scala 1564:56]
  wire [31:0] _T_131 = {31'h0,minstretl_cout_f}; // @[Cat.scala 29:58]
  reg [31:0] minstreth; // @[el2_lib.scala 514:16]
  wire [31:0] minstreth_inc = minstreth + _T_131; // @[dec_tlu_ctl.scala 1575:29]
  wire  _T_139 = io_dec_csr_wraddr_r == 12'h340; // @[dec_tlu_ctl.scala 1586:72]
  reg [31:0] mscratch; // @[el2_lib.scala 514:16]
  wire  _T_142 = ~io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 1597:22]
  wire  _T_143 = ~io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 1597:47]
  wire  _T_144 = _T_142 & _T_143; // @[dec_tlu_ctl.scala 1597:45]
  wire  sel_exu_npc_r = _T_144 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 1597:72]
  wire  _T_146 = _T_142 & io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 1598:47]
  wire  _T_147 = ~io_dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 1598:75]
  wire  sel_flush_npc_r = _T_146 & _T_147; // @[dec_tlu_ctl.scala 1598:73]
  wire  _T_148 = ~sel_exu_npc_r; // @[dec_tlu_ctl.scala 1599:23]
  wire  _T_149 = ~sel_flush_npc_r; // @[dec_tlu_ctl.scala 1599:40]
  wire  sel_hold_npc_r = _T_148 & _T_149; // @[dec_tlu_ctl.scala 1599:38]
  wire  _T_151 = ~io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 1603:13]
  wire  _T_152 = _T_151 & io_reset_delayed; // @[dec_tlu_ctl.scala 1603:35]
  wire [30:0] _T_156 = sel_exu_npc_r ? io_exu_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_157 = _T_152 ? io_rst_vec : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_158 = sel_flush_npc_r ? io_tlu_flush_path_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_159 = sel_hold_npc_r ? io_npc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_160 = _T_156 | _T_157; // @[Mux.scala 27:72]
  wire [30:0] _T_161 = _T_160 | _T_158; // @[Mux.scala 27:72]
  wire  _T_164 = sel_exu_npc_r | sel_flush_npc_r; // @[dec_tlu_ctl.scala 1607:48]
  reg [30:0] _T_167; // @[el2_lib.scala 514:16]
  wire  pc0_valid_r = _T_142 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 1610:44]
  wire  _T_170 = ~pc0_valid_r; // @[dec_tlu_ctl.scala 1614:22]
  wire [30:0] _T_171 = pc0_valid_r ? io_dec_tlu_i0_pc_r : 31'h0; // @[Mux.scala 27:72]
  reg [30:0] pc_r_d1; // @[el2_lib.scala 514:16]
  wire [30:0] _T_172 = _T_170 ? pc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] pc_r = _T_171 | _T_172; // @[Mux.scala 27:72]
  wire  _T_176 = io_dec_csr_wraddr_r == 12'h341; // @[dec_tlu_ctl.scala 1618:68]
  wire  wr_mepc_r = io_dec_csr_wen_r_mod & _T_176; // @[dec_tlu_ctl.scala 1618:39]
  wire  _T_177 = io_i0_exception_valid_r | io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 1621:27]
  wire  _T_178 = _T_177 | io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 1621:48]
  wire  _T_182 = wr_mepc_r & _T_17; // @[dec_tlu_ctl.scala 1623:13]
  wire  _T_185 = ~wr_mepc_r; // @[dec_tlu_ctl.scala 1624:3]
  wire  _T_187 = _T_185 & _T_17; // @[dec_tlu_ctl.scala 1624:14]
  wire [30:0] _T_189 = _T_178 ? pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_190 = io_interrupt_valid_r ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_191 = _T_182 ? io_dec_csr_wrdata_r[31:1] : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_192 = _T_187 ? io_mepc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_193 = _T_189 | _T_190; // @[Mux.scala 27:72]
  wire [30:0] _T_194 = _T_193 | _T_191; // @[Mux.scala 27:72]
  reg [30:0] _T_196; // @[dec_tlu_ctl.scala 1626:47]
  wire  _T_198 = io_dec_csr_wraddr_r == 12'h342; // @[dec_tlu_ctl.scala 1633:72]
  wire  wr_mcause_r = io_dec_csr_wen_r_mod & _T_198; // @[dec_tlu_ctl.scala 1633:43]
  wire  _T_199 = io_exc_or_int_valid_r & io_take_nmi; // @[dec_tlu_ctl.scala 1634:53]
  wire  mcause_sel_nmi_store = _T_199 & io_nmi_lsu_store_type; // @[dec_tlu_ctl.scala 1634:67]
  wire  mcause_sel_nmi_load = _T_199 & io_nmi_lsu_load_type; // @[dec_tlu_ctl.scala 1635:66]
  wire  _T_202 = |io_lsu_fir_error; // @[dec_tlu_ctl.scala 1636:84]
  wire  mcause_sel_nmi_ext = _T_199 & _T_202; // @[dec_tlu_ctl.scala 1636:65]
  wire  _T_203 = &io_lsu_fir_error; // @[dec_tlu_ctl.scala 1642:53]
  wire  _T_206 = ~io_lsu_fir_error[0]; // @[dec_tlu_ctl.scala 1642:82]
  wire  _T_207 = io_lsu_fir_error[1] & _T_206; // @[dec_tlu_ctl.scala 1642:80]
  wire [31:0] _T_212 = {30'h3c000400,_T_203,_T_207}; // @[Cat.scala 29:58]
  wire  _T_213 = ~io_take_nmi; // @[dec_tlu_ctl.scala 1648:56]
  wire  _T_214 = io_exc_or_int_valid_r & _T_213; // @[dec_tlu_ctl.scala 1648:54]
  wire [31:0] _T_217 = {io_interrupt_valid_r,26'h0,io_exc_cause_r}; // @[Cat.scala 29:58]
  wire  _T_219 = wr_mcause_r & _T_17; // @[dec_tlu_ctl.scala 1649:44]
  wire  _T_221 = ~wr_mcause_r; // @[dec_tlu_ctl.scala 1650:32]
  wire  _T_223 = _T_221 & _T_17; // @[dec_tlu_ctl.scala 1650:45]
  wire [31:0] _T_225 = mcause_sel_nmi_store ? 32'hf0000000 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_226 = mcause_sel_nmi_load ? 32'hf0000001 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_227 = mcause_sel_nmi_ext ? _T_212 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_228 = _T_214 ? _T_217 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_229 = _T_219 ? io_dec_csr_wrdata_r : 32'h0; // @[Mux.scala 27:72]
  reg [31:0] mcause; // @[dec_tlu_ctl.scala 1652:49]
  wire [31:0] _T_230 = _T_223 ? mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_231 = _T_225 | _T_226; // @[Mux.scala 27:72]
  wire [31:0] _T_232 = _T_231 | _T_227; // @[Mux.scala 27:72]
  wire [31:0] _T_233 = _T_232 | _T_228; // @[Mux.scala 27:72]
  wire [31:0] _T_234 = _T_233 | _T_229; // @[Mux.scala 27:72]
  wire  _T_238 = io_dec_csr_wraddr_r == 12'h7ff; // @[dec_tlu_ctl.scala 1659:71]
  wire  wr_mscause_r = io_dec_csr_wen_r_mod & _T_238; // @[dec_tlu_ctl.scala 1659:42]
  wire  _T_239 = io_dec_tlu_packet_r_icaf_type == 2'h0; // @[dec_tlu_ctl.scala 1661:56]
  wire [3:0] _T_240 = {2'h0,io_dec_tlu_packet_r_icaf_type}; // @[Cat.scala 29:58]
  wire [3:0] ifu_mscause = _T_239 ? 4'h9 : _T_240; // @[dec_tlu_ctl.scala 1661:24]
  wire [3:0] _T_245 = io_lsu_i0_exc_r ? io_lsu_error_pkt_r_bits_mscause : 4'h0; // @[Mux.scala 27:72]
  wire [1:0] _T_247 = io_ebreak_r ? 2'h2 : 2'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_248 = io_inst_acc_r ? ifu_mscause : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _GEN_12 = {{3'd0}, io_i0_trigger_hit_r}; // @[Mux.scala 27:72]
  wire [3:0] _T_249 = _T_245 | _GEN_12; // @[Mux.scala 27:72]
  wire [3:0] _GEN_13 = {{2'd0}, _T_247}; // @[Mux.scala 27:72]
  wire [3:0] _T_250 = _T_249 | _GEN_13; // @[Mux.scala 27:72]
  wire [3:0] mscause_type = _T_250 | _T_248; // @[Mux.scala 27:72]
  wire  _T_254 = wr_mscause_r & _T_17; // @[dec_tlu_ctl.scala 1672:38]
  wire  _T_257 = ~wr_mscause_r; // @[dec_tlu_ctl.scala 1673:25]
  wire  _T_259 = _T_257 & _T_17; // @[dec_tlu_ctl.scala 1673:39]
  wire [3:0] _T_261 = io_exc_or_int_valid_r ? mscause_type : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_262 = _T_254 ? io_dec_csr_wrdata_r[3:0] : 4'h0; // @[Mux.scala 27:72]
  reg [3:0] mscause; // @[dec_tlu_ctl.scala 1675:47]
  wire [3:0] _T_263 = _T_259 ? mscause : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_264 = _T_261 | _T_262; // @[Mux.scala 27:72]
  wire  _T_268 = io_dec_csr_wraddr_r == 12'h343; // @[dec_tlu_ctl.scala 1682:69]
  wire  wr_mtval_r = io_dec_csr_wen_r_mod & _T_268; // @[dec_tlu_ctl.scala 1682:40]
  wire  _T_269 = ~io_inst_acc_second_r; // @[dec_tlu_ctl.scala 1683:83]
  wire  _T_270 = io_inst_acc_r & _T_269; // @[dec_tlu_ctl.scala 1683:81]
  wire  _T_271 = io_ebreak_r | _T_270; // @[dec_tlu_ctl.scala 1683:64]
  wire  _T_272 = _T_271 | io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 1683:106]
  wire  _T_273 = io_exc_or_int_valid_r & _T_272; // @[dec_tlu_ctl.scala 1683:49]
  wire  mtval_capture_pc_r = _T_273 & _T_213; // @[dec_tlu_ctl.scala 1683:138]
  wire  _T_275 = io_inst_acc_r & io_inst_acc_second_r; // @[dec_tlu_ctl.scala 1684:72]
  wire  _T_276 = io_exc_or_int_valid_r & _T_275; // @[dec_tlu_ctl.scala 1684:55]
  wire  mtval_capture_pc_plus2_r = _T_276 & _T_213; // @[dec_tlu_ctl.scala 1684:96]
  wire  _T_278 = io_exc_or_int_valid_r & io_illegal_r; // @[dec_tlu_ctl.scala 1685:51]
  wire  mtval_capture_inst_r = _T_278 & _T_213; // @[dec_tlu_ctl.scala 1685:66]
  wire  _T_280 = io_exc_or_int_valid_r & io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 1686:50]
  wire  mtval_capture_lsu_r = _T_280 & _T_213; // @[dec_tlu_ctl.scala 1686:71]
  wire  _T_282 = ~mtval_capture_pc_r; // @[dec_tlu_ctl.scala 1687:46]
  wire  _T_283 = io_exc_or_int_valid_r & _T_282; // @[dec_tlu_ctl.scala 1687:44]
  wire  _T_284 = ~mtval_capture_inst_r; // @[dec_tlu_ctl.scala 1687:68]
  wire  _T_285 = _T_283 & _T_284; // @[dec_tlu_ctl.scala 1687:66]
  wire  _T_286 = ~mtval_capture_lsu_r; // @[dec_tlu_ctl.scala 1687:92]
  wire  _T_287 = _T_285 & _T_286; // @[dec_tlu_ctl.scala 1687:90]
  wire  _T_288 = ~io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 1687:115]
  wire  mtval_clear_r = _T_287 & _T_288; // @[dec_tlu_ctl.scala 1687:113]
  wire [31:0] _T_290 = {pc_r,1'h0}; // @[Cat.scala 29:58]
  wire [30:0] _T_293 = pc_r + 31'h1; // @[dec_tlu_ctl.scala 1692:83]
  wire [31:0] _T_294 = {_T_293,1'h0}; // @[Cat.scala 29:58]
  wire  _T_297 = ~io_interrupt_valid_r; // @[dec_tlu_ctl.scala 1695:18]
  wire  _T_298 = wr_mtval_r & _T_297; // @[dec_tlu_ctl.scala 1695:16]
  wire  _T_301 = ~wr_mtval_r; // @[dec_tlu_ctl.scala 1696:20]
  wire  _T_302 = _T_213 & _T_301; // @[dec_tlu_ctl.scala 1696:18]
  wire  _T_304 = _T_302 & _T_282; // @[dec_tlu_ctl.scala 1696:32]
  wire  _T_306 = _T_304 & _T_284; // @[dec_tlu_ctl.scala 1696:54]
  wire  _T_307 = ~mtval_clear_r; // @[dec_tlu_ctl.scala 1696:80]
  wire  _T_308 = _T_306 & _T_307; // @[dec_tlu_ctl.scala 1696:78]
  wire  _T_310 = _T_308 & _T_286; // @[dec_tlu_ctl.scala 1696:95]
  wire [31:0] _T_312 = mtval_capture_pc_r ? _T_290 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_313 = mtval_capture_pc_plus2_r ? _T_294 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_314 = mtval_capture_inst_r ? io_dec_illegal_inst : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_315 = mtval_capture_lsu_r ? io_lsu_error_pkt_addr_r : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_316 = _T_298 ? io_dec_csr_wrdata_r : 32'h0; // @[Mux.scala 27:72]
  reg [31:0] mtval; // @[dec_tlu_ctl.scala 1698:46]
  wire [31:0] _T_317 = _T_310 ? mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_318 = _T_312 | _T_313; // @[Mux.scala 27:72]
  wire [31:0] _T_319 = _T_318 | _T_314; // @[Mux.scala 27:72]
  wire [31:0] _T_320 = _T_319 | _T_315; // @[Mux.scala 27:72]
  wire [31:0] _T_321 = _T_320 | _T_316; // @[Mux.scala 27:72]
  wire  _T_325 = io_dec_csr_wraddr_r == 12'h7f8; // @[dec_tlu_ctl.scala 1713:68]
  reg [8:0] mcgc; // @[el2_lib.scala 514:16]
  wire  _T_337 = io_dec_csr_wraddr_r == 12'h7f9; // @[dec_tlu_ctl.scala 1743:68]
  reg [14:0] mfdc_int; // @[el2_lib.scala 514:16]
  wire [2:0] _T_341 = ~io_dec_csr_wrdata_r[18:16]; // @[dec_tlu_ctl.scala 1752:20]
  wire  _T_344 = ~io_dec_csr_wrdata_r[6]; // @[dec_tlu_ctl.scala 1752:75]
  wire [6:0] _T_346 = {_T_344,io_dec_csr_wrdata_r[5:0]}; // @[Cat.scala 29:58]
  wire [7:0] _T_347 = {_T_341,io_dec_csr_wrdata_r[11:7]}; // @[Cat.scala 29:58]
  wire [2:0] _T_350 = ~mfdc_int[14:12]; // @[dec_tlu_ctl.scala 1753:20]
  wire  _T_353 = ~mfdc_int[6]; // @[dec_tlu_ctl.scala 1753:63]
  wire [18:0] mfdc = {_T_350,4'h0,mfdc_int[11:7],_T_353,mfdc_int[5:0]}; // @[Cat.scala 29:58]
  wire  _T_367 = io_dec_csr_wraddr_r == 12'h7c2; // @[dec_tlu_ctl.scala 1776:77]
  wire  _T_368 = io_dec_csr_wen_r_mod & _T_367; // @[dec_tlu_ctl.scala 1776:48]
  wire  _T_370 = _T_368 & _T_297; // @[dec_tlu_ctl.scala 1776:87]
  wire  _T_371 = ~io_take_ext_int_start; // @[dec_tlu_ctl.scala 1776:113]
  wire  _T_374 = io_dec_csr_wraddr_r == 12'h7c0; // @[dec_tlu_ctl.scala 1783:68]
  wire  _T_378 = ~io_dec_csr_wrdata_r[31]; // @[dec_tlu_ctl.scala 1786:71]
  wire  _T_379 = io_dec_csr_wrdata_r[30] & _T_378; // @[dec_tlu_ctl.scala 1786:69]
  wire  _T_383 = ~io_dec_csr_wrdata_r[29]; // @[dec_tlu_ctl.scala 1787:73]
  wire  _T_384 = io_dec_csr_wrdata_r[28] & _T_383; // @[dec_tlu_ctl.scala 1787:71]
  wire  _T_388 = ~io_dec_csr_wrdata_r[27]; // @[dec_tlu_ctl.scala 1788:73]
  wire  _T_389 = io_dec_csr_wrdata_r[26] & _T_388; // @[dec_tlu_ctl.scala 1788:71]
  wire  _T_393 = ~io_dec_csr_wrdata_r[25]; // @[dec_tlu_ctl.scala 1789:73]
  wire  _T_394 = io_dec_csr_wrdata_r[24] & _T_393; // @[dec_tlu_ctl.scala 1789:71]
  wire  _T_398 = ~io_dec_csr_wrdata_r[23]; // @[dec_tlu_ctl.scala 1790:73]
  wire  _T_399 = io_dec_csr_wrdata_r[22] & _T_398; // @[dec_tlu_ctl.scala 1790:71]
  wire  _T_403 = ~io_dec_csr_wrdata_r[21]; // @[dec_tlu_ctl.scala 1791:73]
  wire  _T_404 = io_dec_csr_wrdata_r[20] & _T_403; // @[dec_tlu_ctl.scala 1791:71]
  wire  _T_408 = ~io_dec_csr_wrdata_r[19]; // @[dec_tlu_ctl.scala 1792:73]
  wire  _T_409 = io_dec_csr_wrdata_r[18] & _T_408; // @[dec_tlu_ctl.scala 1792:71]
  wire  _T_413 = ~io_dec_csr_wrdata_r[17]; // @[dec_tlu_ctl.scala 1793:73]
  wire  _T_414 = io_dec_csr_wrdata_r[16] & _T_413; // @[dec_tlu_ctl.scala 1793:71]
  wire  _T_418 = ~io_dec_csr_wrdata_r[15]; // @[dec_tlu_ctl.scala 1794:73]
  wire  _T_419 = io_dec_csr_wrdata_r[14] & _T_418; // @[dec_tlu_ctl.scala 1794:71]
  wire  _T_423 = ~io_dec_csr_wrdata_r[13]; // @[dec_tlu_ctl.scala 1795:73]
  wire  _T_424 = io_dec_csr_wrdata_r[12] & _T_423; // @[dec_tlu_ctl.scala 1795:71]
  wire  _T_428 = ~io_dec_csr_wrdata_r[11]; // @[dec_tlu_ctl.scala 1796:73]
  wire  _T_429 = io_dec_csr_wrdata_r[10] & _T_428; // @[dec_tlu_ctl.scala 1796:71]
  wire  _T_433 = ~io_dec_csr_wrdata_r[9]; // @[dec_tlu_ctl.scala 1797:73]
  wire  _T_434 = io_dec_csr_wrdata_r[8] & _T_433; // @[dec_tlu_ctl.scala 1797:70]
  wire  _T_438 = ~io_dec_csr_wrdata_r[7]; // @[dec_tlu_ctl.scala 1798:73]
  wire  _T_439 = io_dec_csr_wrdata_r[6] & _T_438; // @[dec_tlu_ctl.scala 1798:70]
  wire  _T_443 = ~io_dec_csr_wrdata_r[5]; // @[dec_tlu_ctl.scala 1799:73]
  wire  _T_444 = io_dec_csr_wrdata_r[4] & _T_443; // @[dec_tlu_ctl.scala 1799:70]
  wire  _T_448 = ~io_dec_csr_wrdata_r[3]; // @[dec_tlu_ctl.scala 1800:73]
  wire  _T_449 = io_dec_csr_wrdata_r[2] & _T_448; // @[dec_tlu_ctl.scala 1800:70]
  wire  _T_454 = io_dec_csr_wrdata_r[0] & _T_510; // @[dec_tlu_ctl.scala 1801:70]
  wire [7:0] _T_461 = {io_dec_csr_wrdata_r[7],_T_439,io_dec_csr_wrdata_r[5],_T_444,io_dec_csr_wrdata_r[3],_T_449,io_dec_csr_wrdata_r[1],_T_454}; // @[Cat.scala 29:58]
  wire [15:0] _T_469 = {io_dec_csr_wrdata_r[15],_T_419,io_dec_csr_wrdata_r[13],_T_424,io_dec_csr_wrdata_r[11],_T_429,io_dec_csr_wrdata_r[9],_T_434,_T_461}; // @[Cat.scala 29:58]
  wire [7:0] _T_476 = {io_dec_csr_wrdata_r[23],_T_399,io_dec_csr_wrdata_r[21],_T_404,io_dec_csr_wrdata_r[19],_T_409,io_dec_csr_wrdata_r[17],_T_414}; // @[Cat.scala 29:58]
  wire [15:0] _T_484 = {io_dec_csr_wrdata_r[31],_T_379,io_dec_csr_wrdata_r[29],_T_384,io_dec_csr_wrdata_r[27],_T_389,io_dec_csr_wrdata_r[25],_T_394,_T_476}; // @[Cat.scala 29:58]
  reg [31:0] mrac; // @[el2_lib.scala 514:16]
  wire  _T_487 = io_dec_csr_wraddr_r == 12'hbc0; // @[dec_tlu_ctl.scala 1814:69]
  wire  wr_mdeau_r = io_dec_csr_wen_r_mod & _T_487; // @[dec_tlu_ctl.scala 1814:40]
  wire  _T_488 = ~wr_mdeau_r; // @[dec_tlu_ctl.scala 1824:59]
  wire  _T_489 = io_mdseac_locked_f & _T_488; // @[dec_tlu_ctl.scala 1824:57]
  wire  _T_491 = io_lsu_imprecise_error_store_any | io_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 1826:49]
  wire  _T_492 = ~io_nmi_int_detected_f; // @[dec_tlu_ctl.scala 1826:86]
  wire  _T_493 = _T_491 & _T_492; // @[dec_tlu_ctl.scala 1826:84]
  wire  _T_494 = ~io_mdseac_locked_f; // @[dec_tlu_ctl.scala 1826:111]
  wire  mdseac_en = _T_493 & _T_494; // @[dec_tlu_ctl.scala 1826:109]
  reg [31:0] mdseac; // @[el2_lib.scala 514:16]
  wire  _T_500 = wr_mpmc_r & io_dec_csr_wrdata_r[0]; // @[dec_tlu_ctl.scala 1841:30]
  wire  _T_501 = ~io_internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 1841:57]
  wire  _T_502 = _T_500 & _T_501; // @[dec_tlu_ctl.scala 1841:55]
  wire  _T_503 = ~io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 1841:89]
  wire  _T_516 = io_dec_csr_wrdata_r[31:27] > 5'h1a; // @[dec_tlu_ctl.scala 1859:48]
  wire [4:0] csr_sat = _T_516 ? 5'h1a : io_dec_csr_wrdata_r[31:27]; // @[dec_tlu_ctl.scala 1859:19]
  wire  _T_519 = io_dec_csr_wraddr_r == 12'h7f0; // @[dec_tlu_ctl.scala 1861:70]
  wire  wr_micect_r = io_dec_csr_wen_r_mod & _T_519; // @[dec_tlu_ctl.scala 1861:41]
  wire [26:0] _T_520 = {26'h0,io_ic_perr_r_d1}; // @[Cat.scala 29:58]
  wire [31:0] _GEN_14 = {{5'd0}, _T_520}; // @[dec_tlu_ctl.scala 1862:23]
  wire [31:0] _T_522 = micect + _GEN_14; // @[dec_tlu_ctl.scala 1862:23]
  wire [31:0] _T_525 = {csr_sat,io_dec_csr_wrdata_r[26:0]}; // @[Cat.scala 29:58]
  wire [26:0] micect_inc = _T_522[26:0]; // @[dec_tlu_ctl.scala 1862:13]
  wire [31:0] _T_527 = {micect[31:27],micect_inc}; // @[Cat.scala 29:58]
  wire  _T_538 = io_dec_csr_wraddr_r == 12'h7f1; // @[dec_tlu_ctl.scala 1876:76]
  wire  wr_miccmect_r = io_dec_csr_wen_r_mod & _T_538; // @[dec_tlu_ctl.scala 1876:47]
  wire  _T_540 = io_iccm_sbecc_r_d1 | io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 1877:70]
  wire [26:0] _T_541 = {26'h0,_T_540}; // @[Cat.scala 29:58]
  wire [26:0] miccmect_inc = miccmect[26:0] + _T_541; // @[dec_tlu_ctl.scala 1877:33]
  wire [31:0] _T_548 = {miccmect[31:27],miccmect_inc}; // @[Cat.scala 29:58]
  wire  _T_549 = wr_miccmect_r | io_iccm_sbecc_r_d1; // @[dec_tlu_ctl.scala 1880:48]
  wire  _T_560 = io_dec_csr_wraddr_r == 12'h7f2; // @[dec_tlu_ctl.scala 1891:76]
  wire  wr_mdccmect_r = io_dec_csr_wen_r_mod & _T_560; // @[dec_tlu_ctl.scala 1891:47]
  wire [26:0] _T_562 = {26'h0,io_lsu_single_ecc_error_r_d1}; // @[Cat.scala 29:58]
  wire [26:0] mdccmect_inc = mdccmect[26:0] + _T_562; // @[dec_tlu_ctl.scala 1892:33]
  wire [31:0] _T_569 = {mdccmect[31:27],mdccmect_inc}; // @[Cat.scala 29:58]
  wire  _T_580 = io_dec_csr_wraddr_r == 12'h7ce; // @[dec_tlu_ctl.scala 1907:69]
  wire  wr_mfdht_r = io_dec_csr_wen_r_mod & _T_580; // @[dec_tlu_ctl.scala 1907:40]
  reg [5:0] mfdht; // @[dec_tlu_ctl.scala 1911:43]
  wire  _T_585 = io_dec_csr_wraddr_r == 12'h7cf; // @[dec_tlu_ctl.scala 1920:69]
  wire  wr_mfdhs_r = io_dec_csr_wen_r_mod & _T_585; // @[dec_tlu_ctl.scala 1920:40]
  wire  _T_588 = ~io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 1923:43]
  wire  _T_589 = io_dbg_tlu_halted & _T_588; // @[dec_tlu_ctl.scala 1923:41]
  wire  _T_591 = ~io_lsu_idle_any_f; // @[dec_tlu_ctl.scala 1923:78]
  wire  _T_592 = ~io_ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 1923:98]
  wire [1:0] _T_593 = {_T_591,_T_592}; // @[Cat.scala 29:58]
  reg [1:0] mfdhs; // @[Reg.scala 27:20]
  wire  _T_595 = wr_mfdhs_r | io_dbg_tlu_halted; // @[dec_tlu_ctl.scala 1925:71]
  reg [31:0] force_halt_ctr_f; // @[Reg.scala 27:20]
  wire [31:0] _T_600 = force_halt_ctr_f + 32'h1; // @[dec_tlu_ctl.scala 1927:74]
  wire [62:0] _T_607 = 63'hffffffff << mfdht[5:1]; // @[dec_tlu_ctl.scala 1932:71]
  wire [62:0] _GEN_15 = {{31'd0}, force_halt_ctr_f}; // @[dec_tlu_ctl.scala 1932:48]
  wire [62:0] _T_608 = _GEN_15 & _T_607; // @[dec_tlu_ctl.scala 1932:48]
  wire  _T_609 = |_T_608; // @[dec_tlu_ctl.scala 1932:87]
  wire  _T_612 = io_dec_csr_wraddr_r == 12'hbc8; // @[dec_tlu_ctl.scala 1940:69]
  reg [21:0] meivt; // @[el2_lib.scala 514:16]
  wire  _T_631 = io_dec_csr_wraddr_r == 12'hbca; // @[dec_tlu_ctl.scala 1991:69]
  wire  _T_632 = io_dec_csr_wen_r_mod & _T_631; // @[dec_tlu_ctl.scala 1991:40]
  wire  wr_meicpct_r = _T_632 | io_take_ext_int_start; // @[dec_tlu_ctl.scala 1991:83]
  reg [7:0] meihap; // @[el2_lib.scala 514:16]
  wire  _T_618 = io_dec_csr_wraddr_r == 12'hbcc; // @[dec_tlu_ctl.scala 1964:72]
  wire  wr_meicurpl_r = io_dec_csr_wen_r_mod & _T_618; // @[dec_tlu_ctl.scala 1964:43]
  reg [3:0] meicurpl; // @[dec_tlu_ctl.scala 1967:46]
  wire  _T_623 = io_dec_csr_wraddr_r == 12'hbcb; // @[dec_tlu_ctl.scala 1979:73]
  wire  _T_624 = io_dec_csr_wen_r_mod & _T_623; // @[dec_tlu_ctl.scala 1979:44]
  wire  wr_meicidpl_r = _T_624 | io_take_ext_int_start; // @[dec_tlu_ctl.scala 1979:88]
  reg [3:0] meicidpl; // @[dec_tlu_ctl.scala 1984:44]
  wire  _T_635 = io_dec_csr_wraddr_r == 12'hbc9; // @[dec_tlu_ctl.scala 2000:69]
  wire  wr_meipt_r = io_dec_csr_wen_r_mod & _T_635; // @[dec_tlu_ctl.scala 2000:40]
  reg [3:0] meipt; // @[dec_tlu_ctl.scala 2003:43]
  wire  _T_639 = io_trigger_hit_r_d1 & io_dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 2031:89]
  wire  trigger_hit_for_dscr_cause_r_d1 = io_trigger_hit_dmode_r_d1 | _T_639; // @[dec_tlu_ctl.scala 2031:66]
  wire  _T_640 = ~io_ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 2034:31]
  wire  _T_641 = io_dcsr_single_step_done_f & _T_640; // @[dec_tlu_ctl.scala 2034:29]
  wire  _T_642 = ~trigger_hit_for_dscr_cause_r_d1; // @[dec_tlu_ctl.scala 2034:63]
  wire  _T_643 = _T_641 & _T_642; // @[dec_tlu_ctl.scala 2034:61]
  wire  _T_644 = ~io_debug_halt_req; // @[dec_tlu_ctl.scala 2034:98]
  wire  _T_645 = _T_643 & _T_644; // @[dec_tlu_ctl.scala 2034:96]
  wire  _T_648 = io_debug_halt_req & _T_640; // @[dec_tlu_ctl.scala 2035:46]
  wire  _T_650 = _T_648 & _T_642; // @[dec_tlu_ctl.scala 2035:78]
  wire  _T_653 = io_ebreak_to_debug_mode_r_d1 & _T_642; // @[dec_tlu_ctl.scala 2036:75]
  wire [2:0] _T_656 = _T_645 ? 3'h4 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_657 = _T_650 ? 3'h3 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_658 = _T_653 ? 3'h1 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_659 = trigger_hit_for_dscr_cause_r_d1 ? 3'h2 : 3'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_660 = _T_656 | _T_657; // @[Mux.scala 27:72]
  wire [2:0] _T_661 = _T_660 | _T_658; // @[Mux.scala 27:72]
  wire [2:0] dcsr_cause = _T_661 | _T_659; // @[Mux.scala 27:72]
  wire  _T_663 = io_allow_dbg_halt_csr_write & io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 2039:46]
  wire  _T_665 = io_dec_csr_wraddr_r == 12'h7b0; // @[dec_tlu_ctl.scala 2039:98]
  wire  wr_dcsr_r = _T_663 & _T_665; // @[dec_tlu_ctl.scala 2039:69]
  wire  _T_667 = io_dcsr[8:6] == 3'h3; // @[dec_tlu_ctl.scala 2045:75]
  wire  dcsr_cause_upgradeable = io_internal_dbg_halt_mode_f & _T_667; // @[dec_tlu_ctl.scala 2045:59]
  wire  _T_668 = ~io_dbg_tlu_halted; // @[dec_tlu_ctl.scala 2046:59]
  wire  _T_669 = _T_668 | dcsr_cause_upgradeable; // @[dec_tlu_ctl.scala 2046:78]
  wire  enter_debug_halt_req_le = io_enter_debug_halt_req & _T_669; // @[dec_tlu_ctl.scala 2046:56]
  wire  nmi_in_debug_mode = io_nmi_int_detected_f & io_internal_dbg_halt_mode_f; // @[dec_tlu_ctl.scala 2048:48]
  wire [15:0] _T_675 = {io_dcsr[15:9],dcsr_cause,io_dcsr[5:2],2'h3}; // @[Cat.scala 29:58]
  wire  _T_681 = nmi_in_debug_mode | io_dcsr[3]; // @[dec_tlu_ctl.scala 2050:145]
  wire [15:0] _T_690 = {io_dec_csr_wrdata_r[15],3'h0,io_dec_csr_wrdata_r[11:10],1'h0,io_dcsr[8:6],2'h0,_T_681,io_dec_csr_wrdata_r[2],2'h3}; // @[Cat.scala 29:58]
  wire [15:0] _T_695 = {io_dcsr[15:4],nmi_in_debug_mode,io_dcsr[2],2'h3}; // @[Cat.scala 29:58]
  wire  _T_697 = enter_debug_halt_req_le | wr_dcsr_r; // @[dec_tlu_ctl.scala 2052:54]
  wire  _T_698 = _T_697 | io_internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 2052:66]
  reg [15:0] _T_701; // @[el2_lib.scala 514:16]
  wire  _T_704 = io_dec_csr_wraddr_r == 12'h7b1; // @[dec_tlu_ctl.scala 2060:97]
  wire  wr_dpc_r = _T_663 & _T_704; // @[dec_tlu_ctl.scala 2060:68]
  wire  _T_707 = ~io_request_debug_mode_done; // @[dec_tlu_ctl.scala 2061:67]
  wire  dpc_capture_npc = _T_589 & _T_707; // @[dec_tlu_ctl.scala 2061:65]
  wire  _T_708 = ~io_request_debug_mode_r; // @[dec_tlu_ctl.scala 2065:21]
  wire  _T_709 = ~dpc_capture_npc; // @[dec_tlu_ctl.scala 2065:39]
  wire  _T_710 = _T_708 & _T_709; // @[dec_tlu_ctl.scala 2065:37]
  wire  _T_711 = _T_710 & wr_dpc_r; // @[dec_tlu_ctl.scala 2065:56]
  wire  _T_716 = _T_708 & dpc_capture_npc; // @[dec_tlu_ctl.scala 2067:49]
  wire [30:0] _T_718 = _T_711 ? io_dec_csr_wrdata_r[31:1] : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_719 = io_request_debug_mode_r ? pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_720 = _T_716 ? io_npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_721 = _T_718 | _T_719; // @[Mux.scala 27:72]
  wire  _T_723 = wr_dpc_r | io_request_debug_mode_r; // @[dec_tlu_ctl.scala 2069:36]
  reg [30:0] _T_726; // @[el2_lib.scala 514:16]
  wire [2:0] _T_730 = {io_dec_csr_wrdata_r[24],io_dec_csr_wrdata_r[21:20]}; // @[Cat.scala 29:58]
  wire  _T_733 = io_dec_csr_wraddr_r == 12'h7c8; // @[dec_tlu_ctl.scala 2084:102]
  reg [16:0] dicawics; // @[el2_lib.scala 514:16]
  wire  _T_737 = io_dec_csr_wraddr_r == 12'h7c9; // @[dec_tlu_ctl.scala 2102:100]
  wire  wr_dicad0_r = _T_663 & _T_737; // @[dec_tlu_ctl.scala 2102:71]
  reg [70:0] dicad0; // @[el2_lib.scala 514:16]
  wire  _T_743 = io_dec_csr_wraddr_r == 12'h7cc; // @[dec_tlu_ctl.scala 2115:101]
  wire  wr_dicad0h_r = _T_663 & _T_743; // @[dec_tlu_ctl.scala 2115:72]
  reg [31:0] dicad0h; // @[el2_lib.scala 514:16]
  wire  _T_751 = io_dec_csr_wraddr_r == 12'h7ca; // @[dec_tlu_ctl.scala 2127:100]
  wire  _T_752 = _T_663 & _T_751; // @[dec_tlu_ctl.scala 2127:71]
  wire  _T_756 = _T_752 | io_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 2131:78]
  reg [31:0] _T_758; // @[Reg.scala 27:20]
  wire [31:0] dicad1 = {25'h0,_T_758[6:0]}; // @[Cat.scala 29:58]
  wire [38:0] _T_763 = {dicad1[6:0],dicad0h}; // @[Cat.scala 29:58]
  wire  _T_765 = io_allow_dbg_halt_csr_write & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 2159:52]
  wire  _T_766 = _T_765 & io_dec_i0_decode_d; // @[dec_tlu_ctl.scala 2159:75]
  wire  _T_767 = ~io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 2159:98]
  wire  _T_768 = _T_766 & _T_767; // @[dec_tlu_ctl.scala 2159:96]
  wire  _T_770 = io_dec_csr_rdaddr_d == 12'h7cb; // @[dec_tlu_ctl.scala 2159:149]
  wire  _T_773 = io_dec_csr_wraddr_r == 12'h7cb; // @[dec_tlu_ctl.scala 2160:104]
  reg  icache_rd_valid_f; // @[dec_tlu_ctl.scala 2162:58]
  reg  icache_wr_valid_f; // @[dec_tlu_ctl.scala 2163:58]
  wire  _T_775 = io_dec_csr_wraddr_r == 12'h7a0; // @[dec_tlu_ctl.scala 2174:69]
  wire  wr_mtsel_r = io_dec_csr_wen_r_mod & _T_775; // @[dec_tlu_ctl.scala 2174:40]
  reg [1:0] mtsel; // @[dec_tlu_ctl.scala 2177:43]
  wire  tdata_load = io_dec_csr_wrdata_r[0] & _T_408; // @[dec_tlu_ctl.scala 2212:42]
  wire  tdata_opcode = io_dec_csr_wrdata_r[2] & _T_408; // @[dec_tlu_ctl.scala 2214:44]
  wire  _T_786 = io_dec_csr_wrdata_r[27] & io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2216:46]
  wire  tdata_action = _T_786 & io_dec_csr_wrdata_r[12]; // @[dec_tlu_ctl.scala 2216:69]
  wire [9:0] tdata_wrdata_r = {_T_786,io_dec_csr_wrdata_r[20:19],tdata_action,io_dec_csr_wrdata_r[11],io_dec_csr_wrdata_r[7:6],tdata_opcode,io_dec_csr_wrdata_r[1],tdata_load}; // @[Cat.scala 29:58]
  wire  _T_801 = io_dec_csr_wraddr_r == 12'h7a1; // @[dec_tlu_ctl.scala 2222:99]
  wire  _T_802 = io_dec_csr_wen_r_mod & _T_801; // @[dec_tlu_ctl.scala 2222:70]
  wire  _T_803 = mtsel == 2'h0; // @[dec_tlu_ctl.scala 2222:121]
  wire  _T_804 = _T_802 & _T_803; // @[dec_tlu_ctl.scala 2222:112]
  wire  _T_806 = ~io_mtdata1_t_0[9]; // @[dec_tlu_ctl.scala 2222:138]
  wire  _T_807 = _T_806 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2222:170]
  wire  wr_mtdata1_t_r_0 = _T_804 & _T_807; // @[dec_tlu_ctl.scala 2222:135]
  wire  _T_812 = mtsel == 2'h1; // @[dec_tlu_ctl.scala 2222:121]
  wire  _T_813 = _T_802 & _T_812; // @[dec_tlu_ctl.scala 2222:112]
  wire  _T_815 = ~io_mtdata1_t_1[9]; // @[dec_tlu_ctl.scala 2222:138]
  wire  _T_816 = _T_815 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2222:170]
  wire  wr_mtdata1_t_r_1 = _T_813 & _T_816; // @[dec_tlu_ctl.scala 2222:135]
  wire  _T_821 = mtsel == 2'h2; // @[dec_tlu_ctl.scala 2222:121]
  wire  _T_822 = _T_802 & _T_821; // @[dec_tlu_ctl.scala 2222:112]
  wire  _T_824 = ~io_mtdata1_t_2[9]; // @[dec_tlu_ctl.scala 2222:138]
  wire  _T_825 = _T_824 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2222:170]
  wire  wr_mtdata1_t_r_2 = _T_822 & _T_825; // @[dec_tlu_ctl.scala 2222:135]
  wire  _T_830 = mtsel == 2'h3; // @[dec_tlu_ctl.scala 2222:121]
  wire  _T_831 = _T_802 & _T_830; // @[dec_tlu_ctl.scala 2222:112]
  wire  _T_833 = ~io_mtdata1_t_3[9]; // @[dec_tlu_ctl.scala 2222:138]
  wire  _T_834 = _T_833 | io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 2222:170]
  wire  wr_mtdata1_t_r_3 = _T_831 & _T_834; // @[dec_tlu_ctl.scala 2222:135]
  wire  _T_840 = io_update_hit_bit_r[0] | io_mtdata1_t_0[8]; // @[dec_tlu_ctl.scala 2223:139]
  wire [9:0] _T_843 = {io_mtdata1_t_0[9],_T_840,io_mtdata1_t_0[7:0]}; // @[Cat.scala 29:58]
  wire  _T_849 = io_update_hit_bit_r[1] | io_mtdata1_t_1[8]; // @[dec_tlu_ctl.scala 2223:139]
  wire [9:0] _T_852 = {io_mtdata1_t_1[9],_T_849,io_mtdata1_t_1[7:0]}; // @[Cat.scala 29:58]
  wire  _T_858 = io_update_hit_bit_r[2] | io_mtdata1_t_2[8]; // @[dec_tlu_ctl.scala 2223:139]
  wire [9:0] _T_861 = {io_mtdata1_t_2[9],_T_858,io_mtdata1_t_2[7:0]}; // @[Cat.scala 29:58]
  wire  _T_867 = io_update_hit_bit_r[3] | io_mtdata1_t_3[8]; // @[dec_tlu_ctl.scala 2223:139]
  wire [9:0] _T_870 = {io_mtdata1_t_3[9],_T_867,io_mtdata1_t_3[7:0]}; // @[Cat.scala 29:58]
  reg [9:0] _T_872; // @[dec_tlu_ctl.scala 2225:74]
  reg [9:0] _T_873; // @[dec_tlu_ctl.scala 2225:74]
  reg [9:0] _T_874; // @[dec_tlu_ctl.scala 2225:74]
  reg [9:0] _T_875; // @[dec_tlu_ctl.scala 2225:74]
  wire [31:0] _T_890 = {4'h2,io_mtdata1_t_0[9],6'h1f,io_mtdata1_t_0[8:7],6'h0,io_mtdata1_t_0[6:5],3'h0,io_mtdata1_t_0[4:3],3'h0,io_mtdata1_t_0[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_905 = {4'h2,io_mtdata1_t_1[9],6'h1f,io_mtdata1_t_1[8:7],6'h0,io_mtdata1_t_1[6:5],3'h0,io_mtdata1_t_1[4:3],3'h0,io_mtdata1_t_1[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_920 = {4'h2,io_mtdata1_t_2[9],6'h1f,io_mtdata1_t_2[8:7],6'h0,io_mtdata1_t_2[6:5],3'h0,io_mtdata1_t_2[4:3],3'h0,io_mtdata1_t_2[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_935 = {4'h2,io_mtdata1_t_3[9],6'h1f,io_mtdata1_t_3[8:7],6'h0,io_mtdata1_t_3[6:5],3'h0,io_mtdata1_t_3[4:3],3'h0,io_mtdata1_t_3[2:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_936 = _T_803 ? _T_890 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_937 = _T_812 ? _T_905 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_938 = _T_821 ? _T_920 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_939 = _T_830 ? _T_935 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_940 = _T_936 | _T_937; // @[Mux.scala 27:72]
  wire [31:0] _T_941 = _T_940 | _T_938; // @[Mux.scala 27:72]
  wire [31:0] mtdata1_tsel_out = _T_941 | _T_939; // @[Mux.scala 27:72]
  wire  _T_968 = io_dec_csr_wraddr_r == 12'h7a2; // @[dec_tlu_ctl.scala 2242:98]
  wire  _T_969 = io_dec_csr_wen_r_mod & _T_968; // @[dec_tlu_ctl.scala 2242:69]
  wire  _T_971 = _T_969 & _T_803; // @[dec_tlu_ctl.scala 2242:111]
  wire  _T_980 = _T_969 & _T_812; // @[dec_tlu_ctl.scala 2242:111]
  wire  _T_989 = _T_969 & _T_821; // @[dec_tlu_ctl.scala 2242:111]
  wire  _T_998 = _T_969 & _T_830; // @[dec_tlu_ctl.scala 2242:111]
  reg [31:0] mtdata2_t_0; // @[el2_lib.scala 514:16]
  reg [31:0] mtdata2_t_1; // @[el2_lib.scala 514:16]
  reg [31:0] mtdata2_t_2; // @[el2_lib.scala 514:16]
  reg [31:0] mtdata2_t_3; // @[el2_lib.scala 514:16]
  wire [31:0] _T_1015 = _T_803 ? mtdata2_t_0 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1016 = _T_812 ? mtdata2_t_1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1017 = _T_821 ? mtdata2_t_2 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1018 = _T_830 ? mtdata2_t_3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_1019 = _T_1015 | _T_1016; // @[Mux.scala 27:72]
  wire [31:0] _T_1020 = _T_1019 | _T_1017; // @[Mux.scala 27:72]
  wire [31:0] mtdata2_tsel_out = _T_1020 | _T_1018; // @[Mux.scala 27:72]
  wire [3:0] _T_1023 = io_tlu_i0_commit_cmt ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] pmu_i0_itype_qual = io_dec_tlu_packet_r_pmu_i0_itype & _T_1023; // @[dec_tlu_ctl.scala 2267:59]
  wire  _T_1025 = ~mcountinhibit[3]; // @[dec_tlu_ctl.scala 2273:24]
  reg [9:0] mhpme3; // @[Reg.scala 27:20]
  wire  _T_1026 = mhpme3 == 10'h1; // @[dec_tlu_ctl.scala 2274:34]
  wire  _T_1028 = mhpme3 == 10'h2; // @[dec_tlu_ctl.scala 2275:34]
  wire  _T_1030 = mhpme3 == 10'h3; // @[dec_tlu_ctl.scala 2276:34]
  wire  _T_1032 = mhpme3 == 10'h4; // @[dec_tlu_ctl.scala 2277:34]
  wire  _T_1034 = ~io_illegal_r; // @[dec_tlu_ctl.scala 2277:96]
  wire  _T_1035 = io_tlu_i0_commit_cmt & _T_1034; // @[dec_tlu_ctl.scala 2277:94]
  wire  _T_1036 = mhpme3 == 10'h5; // @[dec_tlu_ctl.scala 2278:34]
  wire  _T_1038 = ~io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 2278:96]
  wire  _T_1039 = io_tlu_i0_commit_cmt & _T_1038; // @[dec_tlu_ctl.scala 2278:94]
  wire  _T_1041 = _T_1039 & _T_1034; // @[dec_tlu_ctl.scala 2278:115]
  wire  _T_1042 = mhpme3 == 10'h6; // @[dec_tlu_ctl.scala 2279:34]
  wire  _T_1044 = io_tlu_i0_commit_cmt & io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 2279:94]
  wire  _T_1046 = _T_1044 & _T_1034; // @[dec_tlu_ctl.scala 2279:115]
  wire  _T_1047 = mhpme3 == 10'h7; // @[dec_tlu_ctl.scala 2280:34]
  wire  _T_1049 = mhpme3 == 10'h8; // @[dec_tlu_ctl.scala 2281:34]
  wire  _T_1051 = mhpme3 == 10'h1e; // @[dec_tlu_ctl.scala 2282:34]
  wire  _T_1053 = mhpme3 == 10'h9; // @[dec_tlu_ctl.scala 2283:34]
  wire  _T_1055 = pmu_i0_itype_qual == 4'h1; // @[dec_tlu_ctl.scala 2283:91]
  wire  _T_1056 = mhpme3 == 10'ha; // @[dec_tlu_ctl.scala 2284:34]
  wire  _T_1058 = io_dec_tlu_packet_r_pmu_divide & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2284:105]
  wire  _T_1059 = mhpme3 == 10'hb; // @[dec_tlu_ctl.scala 2285:34]
  wire  _T_1061 = pmu_i0_itype_qual == 4'h2; // @[dec_tlu_ctl.scala 2285:91]
  wire  _T_1062 = mhpme3 == 10'hc; // @[dec_tlu_ctl.scala 2286:34]
  wire  _T_1064 = pmu_i0_itype_qual == 4'h3; // @[dec_tlu_ctl.scala 2286:91]
  wire  _T_1065 = mhpme3 == 10'hd; // @[dec_tlu_ctl.scala 2287:34]
  wire  _T_1068 = _T_1061 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 2287:100]
  wire  _T_1069 = mhpme3 == 10'he; // @[dec_tlu_ctl.scala 2288:34]
  wire  _T_1073 = _T_1064 & io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 2288:101]
  wire  _T_1074 = mhpme3 == 10'hf; // @[dec_tlu_ctl.scala 2289:34]
  wire  _T_1076 = pmu_i0_itype_qual == 4'h4; // @[dec_tlu_ctl.scala 2289:89]
  wire  _T_1077 = mhpme3 == 10'h10; // @[dec_tlu_ctl.scala 2290:34]
  wire  _T_1079 = pmu_i0_itype_qual == 4'h5; // @[dec_tlu_ctl.scala 2290:89]
  wire  _T_1080 = mhpme3 == 10'h12; // @[dec_tlu_ctl.scala 2291:34]
  wire  _T_1082 = pmu_i0_itype_qual == 4'h6; // @[dec_tlu_ctl.scala 2291:89]
  wire  _T_1083 = mhpme3 == 10'h11; // @[dec_tlu_ctl.scala 2292:34]
  wire  _T_1085 = pmu_i0_itype_qual == 4'h7; // @[dec_tlu_ctl.scala 2292:89]
  wire  _T_1086 = mhpme3 == 10'h13; // @[dec_tlu_ctl.scala 2293:34]
  wire  _T_1088 = pmu_i0_itype_qual == 4'h8; // @[dec_tlu_ctl.scala 2293:89]
  wire  _T_1089 = mhpme3 == 10'h14; // @[dec_tlu_ctl.scala 2294:34]
  wire  _T_1091 = pmu_i0_itype_qual == 4'h9; // @[dec_tlu_ctl.scala 2294:89]
  wire  _T_1092 = mhpme3 == 10'h15; // @[dec_tlu_ctl.scala 2295:34]
  wire  _T_1094 = pmu_i0_itype_qual == 4'ha; // @[dec_tlu_ctl.scala 2295:89]
  wire  _T_1095 = mhpme3 == 10'h16; // @[dec_tlu_ctl.scala 2296:34]
  wire  _T_1097 = pmu_i0_itype_qual == 4'hb; // @[dec_tlu_ctl.scala 2296:89]
  wire  _T_1098 = mhpme3 == 10'h17; // @[dec_tlu_ctl.scala 2297:34]
  wire  _T_1100 = pmu_i0_itype_qual == 4'hc; // @[dec_tlu_ctl.scala 2297:89]
  wire  _T_1101 = mhpme3 == 10'h18; // @[dec_tlu_ctl.scala 2298:34]
  wire  _T_1103 = pmu_i0_itype_qual == 4'hd; // @[dec_tlu_ctl.scala 2298:89]
  wire  _T_1104 = pmu_i0_itype_qual == 4'he; // @[dec_tlu_ctl.scala 2298:122]
  wire  _T_1105 = _T_1103 | _T_1104; // @[dec_tlu_ctl.scala 2298:101]
  wire  _T_1106 = mhpme3 == 10'h19; // @[dec_tlu_ctl.scala 2299:34]
  wire  _T_1108 = io_exu_pmu_i0_br_misp & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2299:95]
  wire  _T_1109 = mhpme3 == 10'h1a; // @[dec_tlu_ctl.scala 2300:34]
  wire  _T_1111 = io_exu_pmu_i0_br_ataken & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2300:97]
  wire  _T_1112 = mhpme3 == 10'h1b; // @[dec_tlu_ctl.scala 2301:34]
  wire  _T_1114 = io_dec_tlu_packet_r_pmu_i0_br_unpred & io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 2301:110]
  wire  _T_1115 = mhpme3 == 10'h1c; // @[dec_tlu_ctl.scala 2302:34]
  wire  _T_1119 = mhpme3 == 10'h1f; // @[dec_tlu_ctl.scala 2304:34]
  wire  _T_1121 = mhpme3 == 10'h20; // @[dec_tlu_ctl.scala 2305:34]
  wire  _T_1123 = mhpme3 == 10'h22; // @[dec_tlu_ctl.scala 2306:34]
  wire  _T_1125 = mhpme3 == 10'h23; // @[dec_tlu_ctl.scala 2307:34]
  wire  _T_1127 = mhpme3 == 10'h24; // @[dec_tlu_ctl.scala 2308:34]
  wire  _T_1129 = mhpme3 == 10'h25; // @[dec_tlu_ctl.scala 2309:34]
  wire  _T_1131 = io_i0_exception_valid_r | io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 2309:98]
  wire  _T_1132 = _T_1131 | io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 2309:120]
  wire  _T_1133 = mhpme3 == 10'h26; // @[dec_tlu_ctl.scala 2310:34]
  wire  _T_1135 = io_take_timer_int | io_take_int_timer0_int; // @[dec_tlu_ctl.scala 2310:92]
  wire  _T_1136 = _T_1135 | io_take_int_timer1_int; // @[dec_tlu_ctl.scala 2310:117]
  wire  _T_1137 = mhpme3 == 10'h27; // @[dec_tlu_ctl.scala 2311:34]
  wire  _T_1139 = mhpme3 == 10'h28; // @[dec_tlu_ctl.scala 2312:34]
  wire  _T_1141 = mhpme3 == 10'h29; // @[dec_tlu_ctl.scala 2313:34]
  wire  _T_1143 = io_dec_tlu_br0_error_r | io_dec_tlu_br0_start_error_r; // @[dec_tlu_ctl.scala 2313:97]
  wire  _T_1144 = _T_1143 & io_rfpc_i0_r; // @[dec_tlu_ctl.scala 2313:129]
  wire  _T_1145 = mhpme3 == 10'h2a; // @[dec_tlu_ctl.scala 2314:34]
  wire  _T_1147 = mhpme3 == 10'h2b; // @[dec_tlu_ctl.scala 2315:34]
  wire  _T_1149 = mhpme3 == 10'h2c; // @[dec_tlu_ctl.scala 2316:34]
  wire  _T_1151 = mhpme3 == 10'h2d; // @[dec_tlu_ctl.scala 2317:34]
  wire  _T_1153 = mhpme3 == 10'h2e; // @[dec_tlu_ctl.scala 2318:34]
  wire  _T_1155 = mhpme3 == 10'h2f; // @[dec_tlu_ctl.scala 2319:34]
  wire  _T_1157 = mhpme3 == 10'h30; // @[dec_tlu_ctl.scala 2320:34]
  wire  _T_1159 = mhpme3 == 10'h31; // @[dec_tlu_ctl.scala 2321:34]
  wire  _T_1163 = ~io_mstatus[0]; // @[dec_tlu_ctl.scala 2321:73]
  wire  _T_1164 = mhpme3 == 10'h32; // @[dec_tlu_ctl.scala 2322:34]
  wire [5:0] _T_1171 = io_mip & mie; // @[dec_tlu_ctl.scala 2322:113]
  wire  _T_1172 = |_T_1171; // @[dec_tlu_ctl.scala 2322:125]
  wire  _T_1173 = _T_1163 & _T_1172; // @[dec_tlu_ctl.scala 2322:98]
  wire  _T_1174 = mhpme3 == 10'h36; // @[dec_tlu_ctl.scala 2323:34]
  wire  _T_1176 = pmu_i0_itype_qual == 4'hf; // @[dec_tlu_ctl.scala 2323:91]
  wire  _T_1177 = mhpme3 == 10'h37; // @[dec_tlu_ctl.scala 2324:34]
  wire  _T_1179 = io_tlu_i0_commit_cmt & io_lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 2324:94]
  wire  _T_1180 = mhpme3 == 10'h38; // @[dec_tlu_ctl.scala 2325:34]
  wire  _T_1182 = io_tlu_i0_commit_cmt & io_lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 2325:94]
  wire  _T_1183 = mhpme3 == 10'h200; // @[dec_tlu_ctl.scala 2327:34]
  wire  _T_1185 = mhpme3 == 10'h201; // @[dec_tlu_ctl.scala 2328:34]
  wire  _T_1187 = mhpme3 == 10'h202; // @[dec_tlu_ctl.scala 2329:34]
  wire  _T_1189 = mhpme3 == 10'h203; // @[dec_tlu_ctl.scala 2330:34]
  wire  _T_1191 = mhpme3 == 10'h204; // @[dec_tlu_ctl.scala 2331:34]
  wire  _T_1194 = _T_1028 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1195 = _T_1030 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1196 = _T_1032 & _T_1035; // @[Mux.scala 27:72]
  wire  _T_1197 = _T_1036 & _T_1041; // @[Mux.scala 27:72]
  wire  _T_1198 = _T_1042 & _T_1046; // @[Mux.scala 27:72]
  wire  _T_1199 = _T_1047 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1200 = _T_1049 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1201 = _T_1051 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1202 = _T_1053 & _T_1055; // @[Mux.scala 27:72]
  wire  _T_1203 = _T_1056 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_1204 = _T_1059 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_1205 = _T_1062 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_1206 = _T_1065 & _T_1068; // @[Mux.scala 27:72]
  wire  _T_1207 = _T_1069 & _T_1073; // @[Mux.scala 27:72]
  wire  _T_1208 = _T_1074 & _T_1076; // @[Mux.scala 27:72]
  wire  _T_1209 = _T_1077 & _T_1079; // @[Mux.scala 27:72]
  wire  _T_1210 = _T_1080 & _T_1082; // @[Mux.scala 27:72]
  wire  _T_1211 = _T_1083 & _T_1085; // @[Mux.scala 27:72]
  wire  _T_1212 = _T_1086 & _T_1088; // @[Mux.scala 27:72]
  wire  _T_1213 = _T_1089 & _T_1091; // @[Mux.scala 27:72]
  wire  _T_1214 = _T_1092 & _T_1094; // @[Mux.scala 27:72]
  wire  _T_1215 = _T_1095 & _T_1097; // @[Mux.scala 27:72]
  wire  _T_1216 = _T_1098 & _T_1100; // @[Mux.scala 27:72]
  wire  _T_1217 = _T_1101 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_1218 = _T_1106 & _T_1108; // @[Mux.scala 27:72]
  wire  _T_1219 = _T_1109 & _T_1111; // @[Mux.scala 27:72]
  wire  _T_1220 = _T_1112 & _T_1114; // @[Mux.scala 27:72]
  wire  _T_1221 = _T_1115 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1223 = _T_1119 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1224 = _T_1121 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1225 = _T_1123 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1226 = _T_1125 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1227 = _T_1127 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1228 = _T_1129 & _T_1132; // @[Mux.scala 27:72]
  wire  _T_1229 = _T_1133 & _T_1136; // @[Mux.scala 27:72]
  wire  _T_1230 = _T_1137 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1231 = _T_1139 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1232 = _T_1141 & _T_1144; // @[Mux.scala 27:72]
  wire  _T_1233 = _T_1145 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1234 = _T_1147 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1235 = _T_1149 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1236 = _T_1151 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1237 = _T_1153 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1238 = _T_1155 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1239 = _T_1157 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1240 = _T_1159 & _T_1163; // @[Mux.scala 27:72]
  wire  _T_1241 = _T_1164 & _T_1173; // @[Mux.scala 27:72]
  wire  _T_1242 = _T_1174 & _T_1176; // @[Mux.scala 27:72]
  wire  _T_1243 = _T_1177 & _T_1179; // @[Mux.scala 27:72]
  wire  _T_1244 = _T_1180 & _T_1182; // @[Mux.scala 27:72]
  wire  _T_1245 = _T_1183 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1246 = _T_1185 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1247 = _T_1187 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1248 = _T_1189 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1249 = _T_1191 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1250 = _T_1026 | _T_1194; // @[Mux.scala 27:72]
  wire  _T_1251 = _T_1250 | _T_1195; // @[Mux.scala 27:72]
  wire  _T_1252 = _T_1251 | _T_1196; // @[Mux.scala 27:72]
  wire  _T_1253 = _T_1252 | _T_1197; // @[Mux.scala 27:72]
  wire  _T_1254 = _T_1253 | _T_1198; // @[Mux.scala 27:72]
  wire  _T_1255 = _T_1254 | _T_1199; // @[Mux.scala 27:72]
  wire  _T_1256 = _T_1255 | _T_1200; // @[Mux.scala 27:72]
  wire  _T_1257 = _T_1256 | _T_1201; // @[Mux.scala 27:72]
  wire  _T_1258 = _T_1257 | _T_1202; // @[Mux.scala 27:72]
  wire  _T_1259 = _T_1258 | _T_1203; // @[Mux.scala 27:72]
  wire  _T_1260 = _T_1259 | _T_1204; // @[Mux.scala 27:72]
  wire  _T_1261 = _T_1260 | _T_1205; // @[Mux.scala 27:72]
  wire  _T_1262 = _T_1261 | _T_1206; // @[Mux.scala 27:72]
  wire  _T_1263 = _T_1262 | _T_1207; // @[Mux.scala 27:72]
  wire  _T_1264 = _T_1263 | _T_1208; // @[Mux.scala 27:72]
  wire  _T_1265 = _T_1264 | _T_1209; // @[Mux.scala 27:72]
  wire  _T_1266 = _T_1265 | _T_1210; // @[Mux.scala 27:72]
  wire  _T_1267 = _T_1266 | _T_1211; // @[Mux.scala 27:72]
  wire  _T_1268 = _T_1267 | _T_1212; // @[Mux.scala 27:72]
  wire  _T_1269 = _T_1268 | _T_1213; // @[Mux.scala 27:72]
  wire  _T_1270 = _T_1269 | _T_1214; // @[Mux.scala 27:72]
  wire  _T_1271 = _T_1270 | _T_1215; // @[Mux.scala 27:72]
  wire  _T_1272 = _T_1271 | _T_1216; // @[Mux.scala 27:72]
  wire  _T_1273 = _T_1272 | _T_1217; // @[Mux.scala 27:72]
  wire  _T_1274 = _T_1273 | _T_1218; // @[Mux.scala 27:72]
  wire  _T_1275 = _T_1274 | _T_1219; // @[Mux.scala 27:72]
  wire  _T_1276 = _T_1275 | _T_1220; // @[Mux.scala 27:72]
  wire  _T_1277 = _T_1276 | _T_1221; // @[Mux.scala 27:72]
  wire  _T_1278 = _T_1277 | _T_1201; // @[Mux.scala 27:72]
  wire  _T_1279 = _T_1278 | _T_1223; // @[Mux.scala 27:72]
  wire  _T_1280 = _T_1279 | _T_1224; // @[Mux.scala 27:72]
  wire  _T_1281 = _T_1280 | _T_1225; // @[Mux.scala 27:72]
  wire  _T_1282 = _T_1281 | _T_1226; // @[Mux.scala 27:72]
  wire  _T_1283 = _T_1282 | _T_1227; // @[Mux.scala 27:72]
  wire  _T_1284 = _T_1283 | _T_1228; // @[Mux.scala 27:72]
  wire  _T_1285 = _T_1284 | _T_1229; // @[Mux.scala 27:72]
  wire  _T_1286 = _T_1285 | _T_1230; // @[Mux.scala 27:72]
  wire  _T_1287 = _T_1286 | _T_1231; // @[Mux.scala 27:72]
  wire  _T_1288 = _T_1287 | _T_1232; // @[Mux.scala 27:72]
  wire  _T_1289 = _T_1288 | _T_1233; // @[Mux.scala 27:72]
  wire  _T_1290 = _T_1289 | _T_1234; // @[Mux.scala 27:72]
  wire  _T_1291 = _T_1290 | _T_1235; // @[Mux.scala 27:72]
  wire  _T_1292 = _T_1291 | _T_1236; // @[Mux.scala 27:72]
  wire  _T_1293 = _T_1292 | _T_1237; // @[Mux.scala 27:72]
  wire  _T_1294 = _T_1293 | _T_1238; // @[Mux.scala 27:72]
  wire  _T_1295 = _T_1294 | _T_1239; // @[Mux.scala 27:72]
  wire  _T_1296 = _T_1295 | _T_1240; // @[Mux.scala 27:72]
  wire  _T_1297 = _T_1296 | _T_1241; // @[Mux.scala 27:72]
  wire  _T_1298 = _T_1297 | _T_1242; // @[Mux.scala 27:72]
  wire  _T_1299 = _T_1298 | _T_1243; // @[Mux.scala 27:72]
  wire  _T_1300 = _T_1299 | _T_1244; // @[Mux.scala 27:72]
  wire  _T_1301 = _T_1300 | _T_1245; // @[Mux.scala 27:72]
  wire  _T_1302 = _T_1301 | _T_1246; // @[Mux.scala 27:72]
  wire  _T_1303 = _T_1302 | _T_1247; // @[Mux.scala 27:72]
  wire  _T_1304 = _T_1303 | _T_1248; // @[Mux.scala 27:72]
  wire  _T_1305 = _T_1304 | _T_1249; // @[Mux.scala 27:72]
  wire  mhpmc_inc_r_0 = _T_1025 & _T_1305; // @[dec_tlu_ctl.scala 2273:44]
  wire  _T_1309 = ~mcountinhibit[4]; // @[dec_tlu_ctl.scala 2273:24]
  reg [9:0] mhpme4; // @[Reg.scala 27:20]
  wire  _T_1310 = mhpme4 == 10'h1; // @[dec_tlu_ctl.scala 2274:34]
  wire  _T_1312 = mhpme4 == 10'h2; // @[dec_tlu_ctl.scala 2275:34]
  wire  _T_1314 = mhpme4 == 10'h3; // @[dec_tlu_ctl.scala 2276:34]
  wire  _T_1316 = mhpme4 == 10'h4; // @[dec_tlu_ctl.scala 2277:34]
  wire  _T_1320 = mhpme4 == 10'h5; // @[dec_tlu_ctl.scala 2278:34]
  wire  _T_1326 = mhpme4 == 10'h6; // @[dec_tlu_ctl.scala 2279:34]
  wire  _T_1331 = mhpme4 == 10'h7; // @[dec_tlu_ctl.scala 2280:34]
  wire  _T_1333 = mhpme4 == 10'h8; // @[dec_tlu_ctl.scala 2281:34]
  wire  _T_1335 = mhpme4 == 10'h1e; // @[dec_tlu_ctl.scala 2282:34]
  wire  _T_1337 = mhpme4 == 10'h9; // @[dec_tlu_ctl.scala 2283:34]
  wire  _T_1340 = mhpme4 == 10'ha; // @[dec_tlu_ctl.scala 2284:34]
  wire  _T_1343 = mhpme4 == 10'hb; // @[dec_tlu_ctl.scala 2285:34]
  wire  _T_1346 = mhpme4 == 10'hc; // @[dec_tlu_ctl.scala 2286:34]
  wire  _T_1349 = mhpme4 == 10'hd; // @[dec_tlu_ctl.scala 2287:34]
  wire  _T_1353 = mhpme4 == 10'he; // @[dec_tlu_ctl.scala 2288:34]
  wire  _T_1358 = mhpme4 == 10'hf; // @[dec_tlu_ctl.scala 2289:34]
  wire  _T_1361 = mhpme4 == 10'h10; // @[dec_tlu_ctl.scala 2290:34]
  wire  _T_1364 = mhpme4 == 10'h12; // @[dec_tlu_ctl.scala 2291:34]
  wire  _T_1367 = mhpme4 == 10'h11; // @[dec_tlu_ctl.scala 2292:34]
  wire  _T_1370 = mhpme4 == 10'h13; // @[dec_tlu_ctl.scala 2293:34]
  wire  _T_1373 = mhpme4 == 10'h14; // @[dec_tlu_ctl.scala 2294:34]
  wire  _T_1376 = mhpme4 == 10'h15; // @[dec_tlu_ctl.scala 2295:34]
  wire  _T_1379 = mhpme4 == 10'h16; // @[dec_tlu_ctl.scala 2296:34]
  wire  _T_1382 = mhpme4 == 10'h17; // @[dec_tlu_ctl.scala 2297:34]
  wire  _T_1385 = mhpme4 == 10'h18; // @[dec_tlu_ctl.scala 2298:34]
  wire  _T_1390 = mhpme4 == 10'h19; // @[dec_tlu_ctl.scala 2299:34]
  wire  _T_1393 = mhpme4 == 10'h1a; // @[dec_tlu_ctl.scala 2300:34]
  wire  _T_1396 = mhpme4 == 10'h1b; // @[dec_tlu_ctl.scala 2301:34]
  wire  _T_1399 = mhpme4 == 10'h1c; // @[dec_tlu_ctl.scala 2302:34]
  wire  _T_1403 = mhpme4 == 10'h1f; // @[dec_tlu_ctl.scala 2304:34]
  wire  _T_1405 = mhpme4 == 10'h20; // @[dec_tlu_ctl.scala 2305:34]
  wire  _T_1407 = mhpme4 == 10'h22; // @[dec_tlu_ctl.scala 2306:34]
  wire  _T_1409 = mhpme4 == 10'h23; // @[dec_tlu_ctl.scala 2307:34]
  wire  _T_1411 = mhpme4 == 10'h24; // @[dec_tlu_ctl.scala 2308:34]
  wire  _T_1413 = mhpme4 == 10'h25; // @[dec_tlu_ctl.scala 2309:34]
  wire  _T_1417 = mhpme4 == 10'h26; // @[dec_tlu_ctl.scala 2310:34]
  wire  _T_1421 = mhpme4 == 10'h27; // @[dec_tlu_ctl.scala 2311:34]
  wire  _T_1423 = mhpme4 == 10'h28; // @[dec_tlu_ctl.scala 2312:34]
  wire  _T_1425 = mhpme4 == 10'h29; // @[dec_tlu_ctl.scala 2313:34]
  wire  _T_1429 = mhpme4 == 10'h2a; // @[dec_tlu_ctl.scala 2314:34]
  wire  _T_1431 = mhpme4 == 10'h2b; // @[dec_tlu_ctl.scala 2315:34]
  wire  _T_1433 = mhpme4 == 10'h2c; // @[dec_tlu_ctl.scala 2316:34]
  wire  _T_1435 = mhpme4 == 10'h2d; // @[dec_tlu_ctl.scala 2317:34]
  wire  _T_1437 = mhpme4 == 10'h2e; // @[dec_tlu_ctl.scala 2318:34]
  wire  _T_1439 = mhpme4 == 10'h2f; // @[dec_tlu_ctl.scala 2319:34]
  wire  _T_1441 = mhpme4 == 10'h30; // @[dec_tlu_ctl.scala 2320:34]
  wire  _T_1443 = mhpme4 == 10'h31; // @[dec_tlu_ctl.scala 2321:34]
  wire  _T_1448 = mhpme4 == 10'h32; // @[dec_tlu_ctl.scala 2322:34]
  wire  _T_1458 = mhpme4 == 10'h36; // @[dec_tlu_ctl.scala 2323:34]
  wire  _T_1461 = mhpme4 == 10'h37; // @[dec_tlu_ctl.scala 2324:34]
  wire  _T_1464 = mhpme4 == 10'h38; // @[dec_tlu_ctl.scala 2325:34]
  wire  _T_1467 = mhpme4 == 10'h200; // @[dec_tlu_ctl.scala 2327:34]
  wire  _T_1469 = mhpme4 == 10'h201; // @[dec_tlu_ctl.scala 2328:34]
  wire  _T_1471 = mhpme4 == 10'h202; // @[dec_tlu_ctl.scala 2329:34]
  wire  _T_1473 = mhpme4 == 10'h203; // @[dec_tlu_ctl.scala 2330:34]
  wire  _T_1475 = mhpme4 == 10'h204; // @[dec_tlu_ctl.scala 2331:34]
  wire  _T_1478 = _T_1312 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1479 = _T_1314 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1480 = _T_1316 & _T_1035; // @[Mux.scala 27:72]
  wire  _T_1481 = _T_1320 & _T_1041; // @[Mux.scala 27:72]
  wire  _T_1482 = _T_1326 & _T_1046; // @[Mux.scala 27:72]
  wire  _T_1483 = _T_1331 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1484 = _T_1333 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1485 = _T_1335 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1486 = _T_1337 & _T_1055; // @[Mux.scala 27:72]
  wire  _T_1487 = _T_1340 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_1488 = _T_1343 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_1489 = _T_1346 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_1490 = _T_1349 & _T_1068; // @[Mux.scala 27:72]
  wire  _T_1491 = _T_1353 & _T_1073; // @[Mux.scala 27:72]
  wire  _T_1492 = _T_1358 & _T_1076; // @[Mux.scala 27:72]
  wire  _T_1493 = _T_1361 & _T_1079; // @[Mux.scala 27:72]
  wire  _T_1494 = _T_1364 & _T_1082; // @[Mux.scala 27:72]
  wire  _T_1495 = _T_1367 & _T_1085; // @[Mux.scala 27:72]
  wire  _T_1496 = _T_1370 & _T_1088; // @[Mux.scala 27:72]
  wire  _T_1497 = _T_1373 & _T_1091; // @[Mux.scala 27:72]
  wire  _T_1498 = _T_1376 & _T_1094; // @[Mux.scala 27:72]
  wire  _T_1499 = _T_1379 & _T_1097; // @[Mux.scala 27:72]
  wire  _T_1500 = _T_1382 & _T_1100; // @[Mux.scala 27:72]
  wire  _T_1501 = _T_1385 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_1502 = _T_1390 & _T_1108; // @[Mux.scala 27:72]
  wire  _T_1503 = _T_1393 & _T_1111; // @[Mux.scala 27:72]
  wire  _T_1504 = _T_1396 & _T_1114; // @[Mux.scala 27:72]
  wire  _T_1505 = _T_1399 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1507 = _T_1403 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1508 = _T_1405 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1509 = _T_1407 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1510 = _T_1409 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1511 = _T_1411 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1512 = _T_1413 & _T_1132; // @[Mux.scala 27:72]
  wire  _T_1513 = _T_1417 & _T_1136; // @[Mux.scala 27:72]
  wire  _T_1514 = _T_1421 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1515 = _T_1423 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1516 = _T_1425 & _T_1144; // @[Mux.scala 27:72]
  wire  _T_1517 = _T_1429 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1518 = _T_1431 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1519 = _T_1433 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1520 = _T_1435 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1521 = _T_1437 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1522 = _T_1439 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1523 = _T_1441 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1524 = _T_1443 & _T_1163; // @[Mux.scala 27:72]
  wire  _T_1525 = _T_1448 & _T_1173; // @[Mux.scala 27:72]
  wire  _T_1526 = _T_1458 & _T_1176; // @[Mux.scala 27:72]
  wire  _T_1527 = _T_1461 & _T_1179; // @[Mux.scala 27:72]
  wire  _T_1528 = _T_1464 & _T_1182; // @[Mux.scala 27:72]
  wire  _T_1529 = _T_1467 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1530 = _T_1469 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1531 = _T_1471 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1532 = _T_1473 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1533 = _T_1475 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1534 = _T_1310 | _T_1478; // @[Mux.scala 27:72]
  wire  _T_1535 = _T_1534 | _T_1479; // @[Mux.scala 27:72]
  wire  _T_1536 = _T_1535 | _T_1480; // @[Mux.scala 27:72]
  wire  _T_1537 = _T_1536 | _T_1481; // @[Mux.scala 27:72]
  wire  _T_1538 = _T_1537 | _T_1482; // @[Mux.scala 27:72]
  wire  _T_1539 = _T_1538 | _T_1483; // @[Mux.scala 27:72]
  wire  _T_1540 = _T_1539 | _T_1484; // @[Mux.scala 27:72]
  wire  _T_1541 = _T_1540 | _T_1485; // @[Mux.scala 27:72]
  wire  _T_1542 = _T_1541 | _T_1486; // @[Mux.scala 27:72]
  wire  _T_1543 = _T_1542 | _T_1487; // @[Mux.scala 27:72]
  wire  _T_1544 = _T_1543 | _T_1488; // @[Mux.scala 27:72]
  wire  _T_1545 = _T_1544 | _T_1489; // @[Mux.scala 27:72]
  wire  _T_1546 = _T_1545 | _T_1490; // @[Mux.scala 27:72]
  wire  _T_1547 = _T_1546 | _T_1491; // @[Mux.scala 27:72]
  wire  _T_1548 = _T_1547 | _T_1492; // @[Mux.scala 27:72]
  wire  _T_1549 = _T_1548 | _T_1493; // @[Mux.scala 27:72]
  wire  _T_1550 = _T_1549 | _T_1494; // @[Mux.scala 27:72]
  wire  _T_1551 = _T_1550 | _T_1495; // @[Mux.scala 27:72]
  wire  _T_1552 = _T_1551 | _T_1496; // @[Mux.scala 27:72]
  wire  _T_1553 = _T_1552 | _T_1497; // @[Mux.scala 27:72]
  wire  _T_1554 = _T_1553 | _T_1498; // @[Mux.scala 27:72]
  wire  _T_1555 = _T_1554 | _T_1499; // @[Mux.scala 27:72]
  wire  _T_1556 = _T_1555 | _T_1500; // @[Mux.scala 27:72]
  wire  _T_1557 = _T_1556 | _T_1501; // @[Mux.scala 27:72]
  wire  _T_1558 = _T_1557 | _T_1502; // @[Mux.scala 27:72]
  wire  _T_1559 = _T_1558 | _T_1503; // @[Mux.scala 27:72]
  wire  _T_1560 = _T_1559 | _T_1504; // @[Mux.scala 27:72]
  wire  _T_1561 = _T_1560 | _T_1505; // @[Mux.scala 27:72]
  wire  _T_1562 = _T_1561 | _T_1485; // @[Mux.scala 27:72]
  wire  _T_1563 = _T_1562 | _T_1507; // @[Mux.scala 27:72]
  wire  _T_1564 = _T_1563 | _T_1508; // @[Mux.scala 27:72]
  wire  _T_1565 = _T_1564 | _T_1509; // @[Mux.scala 27:72]
  wire  _T_1566 = _T_1565 | _T_1510; // @[Mux.scala 27:72]
  wire  _T_1567 = _T_1566 | _T_1511; // @[Mux.scala 27:72]
  wire  _T_1568 = _T_1567 | _T_1512; // @[Mux.scala 27:72]
  wire  _T_1569 = _T_1568 | _T_1513; // @[Mux.scala 27:72]
  wire  _T_1570 = _T_1569 | _T_1514; // @[Mux.scala 27:72]
  wire  _T_1571 = _T_1570 | _T_1515; // @[Mux.scala 27:72]
  wire  _T_1572 = _T_1571 | _T_1516; // @[Mux.scala 27:72]
  wire  _T_1573 = _T_1572 | _T_1517; // @[Mux.scala 27:72]
  wire  _T_1574 = _T_1573 | _T_1518; // @[Mux.scala 27:72]
  wire  _T_1575 = _T_1574 | _T_1519; // @[Mux.scala 27:72]
  wire  _T_1576 = _T_1575 | _T_1520; // @[Mux.scala 27:72]
  wire  _T_1577 = _T_1576 | _T_1521; // @[Mux.scala 27:72]
  wire  _T_1578 = _T_1577 | _T_1522; // @[Mux.scala 27:72]
  wire  _T_1579 = _T_1578 | _T_1523; // @[Mux.scala 27:72]
  wire  _T_1580 = _T_1579 | _T_1524; // @[Mux.scala 27:72]
  wire  _T_1581 = _T_1580 | _T_1525; // @[Mux.scala 27:72]
  wire  _T_1582 = _T_1581 | _T_1526; // @[Mux.scala 27:72]
  wire  _T_1583 = _T_1582 | _T_1527; // @[Mux.scala 27:72]
  wire  _T_1584 = _T_1583 | _T_1528; // @[Mux.scala 27:72]
  wire  _T_1585 = _T_1584 | _T_1529; // @[Mux.scala 27:72]
  wire  _T_1586 = _T_1585 | _T_1530; // @[Mux.scala 27:72]
  wire  _T_1587 = _T_1586 | _T_1531; // @[Mux.scala 27:72]
  wire  _T_1588 = _T_1587 | _T_1532; // @[Mux.scala 27:72]
  wire  _T_1589 = _T_1588 | _T_1533; // @[Mux.scala 27:72]
  wire  mhpmc_inc_r_1 = _T_1309 & _T_1589; // @[dec_tlu_ctl.scala 2273:44]
  wire  _T_1593 = ~mcountinhibit[5]; // @[dec_tlu_ctl.scala 2273:24]
  reg [9:0] mhpme5; // @[Reg.scala 27:20]
  wire  _T_1594 = mhpme5 == 10'h1; // @[dec_tlu_ctl.scala 2274:34]
  wire  _T_1596 = mhpme5 == 10'h2; // @[dec_tlu_ctl.scala 2275:34]
  wire  _T_1598 = mhpme5 == 10'h3; // @[dec_tlu_ctl.scala 2276:34]
  wire  _T_1600 = mhpme5 == 10'h4; // @[dec_tlu_ctl.scala 2277:34]
  wire  _T_1604 = mhpme5 == 10'h5; // @[dec_tlu_ctl.scala 2278:34]
  wire  _T_1610 = mhpme5 == 10'h6; // @[dec_tlu_ctl.scala 2279:34]
  wire  _T_1615 = mhpme5 == 10'h7; // @[dec_tlu_ctl.scala 2280:34]
  wire  _T_1617 = mhpme5 == 10'h8; // @[dec_tlu_ctl.scala 2281:34]
  wire  _T_1619 = mhpme5 == 10'h1e; // @[dec_tlu_ctl.scala 2282:34]
  wire  _T_1621 = mhpme5 == 10'h9; // @[dec_tlu_ctl.scala 2283:34]
  wire  _T_1624 = mhpme5 == 10'ha; // @[dec_tlu_ctl.scala 2284:34]
  wire  _T_1627 = mhpme5 == 10'hb; // @[dec_tlu_ctl.scala 2285:34]
  wire  _T_1630 = mhpme5 == 10'hc; // @[dec_tlu_ctl.scala 2286:34]
  wire  _T_1633 = mhpme5 == 10'hd; // @[dec_tlu_ctl.scala 2287:34]
  wire  _T_1637 = mhpme5 == 10'he; // @[dec_tlu_ctl.scala 2288:34]
  wire  _T_1642 = mhpme5 == 10'hf; // @[dec_tlu_ctl.scala 2289:34]
  wire  _T_1645 = mhpme5 == 10'h10; // @[dec_tlu_ctl.scala 2290:34]
  wire  _T_1648 = mhpme5 == 10'h12; // @[dec_tlu_ctl.scala 2291:34]
  wire  _T_1651 = mhpme5 == 10'h11; // @[dec_tlu_ctl.scala 2292:34]
  wire  _T_1654 = mhpme5 == 10'h13; // @[dec_tlu_ctl.scala 2293:34]
  wire  _T_1657 = mhpme5 == 10'h14; // @[dec_tlu_ctl.scala 2294:34]
  wire  _T_1660 = mhpme5 == 10'h15; // @[dec_tlu_ctl.scala 2295:34]
  wire  _T_1663 = mhpme5 == 10'h16; // @[dec_tlu_ctl.scala 2296:34]
  wire  _T_1666 = mhpme5 == 10'h17; // @[dec_tlu_ctl.scala 2297:34]
  wire  _T_1669 = mhpme5 == 10'h18; // @[dec_tlu_ctl.scala 2298:34]
  wire  _T_1674 = mhpme5 == 10'h19; // @[dec_tlu_ctl.scala 2299:34]
  wire  _T_1677 = mhpme5 == 10'h1a; // @[dec_tlu_ctl.scala 2300:34]
  wire  _T_1680 = mhpme5 == 10'h1b; // @[dec_tlu_ctl.scala 2301:34]
  wire  _T_1683 = mhpme5 == 10'h1c; // @[dec_tlu_ctl.scala 2302:34]
  wire  _T_1687 = mhpme5 == 10'h1f; // @[dec_tlu_ctl.scala 2304:34]
  wire  _T_1689 = mhpme5 == 10'h20; // @[dec_tlu_ctl.scala 2305:34]
  wire  _T_1691 = mhpme5 == 10'h22; // @[dec_tlu_ctl.scala 2306:34]
  wire  _T_1693 = mhpme5 == 10'h23; // @[dec_tlu_ctl.scala 2307:34]
  wire  _T_1695 = mhpme5 == 10'h24; // @[dec_tlu_ctl.scala 2308:34]
  wire  _T_1697 = mhpme5 == 10'h25; // @[dec_tlu_ctl.scala 2309:34]
  wire  _T_1701 = mhpme5 == 10'h26; // @[dec_tlu_ctl.scala 2310:34]
  wire  _T_1705 = mhpme5 == 10'h27; // @[dec_tlu_ctl.scala 2311:34]
  wire  _T_1707 = mhpme5 == 10'h28; // @[dec_tlu_ctl.scala 2312:34]
  wire  _T_1709 = mhpme5 == 10'h29; // @[dec_tlu_ctl.scala 2313:34]
  wire  _T_1713 = mhpme5 == 10'h2a; // @[dec_tlu_ctl.scala 2314:34]
  wire  _T_1715 = mhpme5 == 10'h2b; // @[dec_tlu_ctl.scala 2315:34]
  wire  _T_1717 = mhpme5 == 10'h2c; // @[dec_tlu_ctl.scala 2316:34]
  wire  _T_1719 = mhpme5 == 10'h2d; // @[dec_tlu_ctl.scala 2317:34]
  wire  _T_1721 = mhpme5 == 10'h2e; // @[dec_tlu_ctl.scala 2318:34]
  wire  _T_1723 = mhpme5 == 10'h2f; // @[dec_tlu_ctl.scala 2319:34]
  wire  _T_1725 = mhpme5 == 10'h30; // @[dec_tlu_ctl.scala 2320:34]
  wire  _T_1727 = mhpme5 == 10'h31; // @[dec_tlu_ctl.scala 2321:34]
  wire  _T_1732 = mhpme5 == 10'h32; // @[dec_tlu_ctl.scala 2322:34]
  wire  _T_1742 = mhpme5 == 10'h36; // @[dec_tlu_ctl.scala 2323:34]
  wire  _T_1745 = mhpme5 == 10'h37; // @[dec_tlu_ctl.scala 2324:34]
  wire  _T_1748 = mhpme5 == 10'h38; // @[dec_tlu_ctl.scala 2325:34]
  wire  _T_1751 = mhpme5 == 10'h200; // @[dec_tlu_ctl.scala 2327:34]
  wire  _T_1753 = mhpme5 == 10'h201; // @[dec_tlu_ctl.scala 2328:34]
  wire  _T_1755 = mhpme5 == 10'h202; // @[dec_tlu_ctl.scala 2329:34]
  wire  _T_1757 = mhpme5 == 10'h203; // @[dec_tlu_ctl.scala 2330:34]
  wire  _T_1759 = mhpme5 == 10'h204; // @[dec_tlu_ctl.scala 2331:34]
  wire  _T_1762 = _T_1596 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_1763 = _T_1598 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_1764 = _T_1600 & _T_1035; // @[Mux.scala 27:72]
  wire  _T_1765 = _T_1604 & _T_1041; // @[Mux.scala 27:72]
  wire  _T_1766 = _T_1610 & _T_1046; // @[Mux.scala 27:72]
  wire  _T_1767 = _T_1615 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_1768 = _T_1617 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_1769 = _T_1619 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_1770 = _T_1621 & _T_1055; // @[Mux.scala 27:72]
  wire  _T_1771 = _T_1624 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_1772 = _T_1627 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_1773 = _T_1630 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_1774 = _T_1633 & _T_1068; // @[Mux.scala 27:72]
  wire  _T_1775 = _T_1637 & _T_1073; // @[Mux.scala 27:72]
  wire  _T_1776 = _T_1642 & _T_1076; // @[Mux.scala 27:72]
  wire  _T_1777 = _T_1645 & _T_1079; // @[Mux.scala 27:72]
  wire  _T_1778 = _T_1648 & _T_1082; // @[Mux.scala 27:72]
  wire  _T_1779 = _T_1651 & _T_1085; // @[Mux.scala 27:72]
  wire  _T_1780 = _T_1654 & _T_1088; // @[Mux.scala 27:72]
  wire  _T_1781 = _T_1657 & _T_1091; // @[Mux.scala 27:72]
  wire  _T_1782 = _T_1660 & _T_1094; // @[Mux.scala 27:72]
  wire  _T_1783 = _T_1663 & _T_1097; // @[Mux.scala 27:72]
  wire  _T_1784 = _T_1666 & _T_1100; // @[Mux.scala 27:72]
  wire  _T_1785 = _T_1669 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_1786 = _T_1674 & _T_1108; // @[Mux.scala 27:72]
  wire  _T_1787 = _T_1677 & _T_1111; // @[Mux.scala 27:72]
  wire  _T_1788 = _T_1680 & _T_1114; // @[Mux.scala 27:72]
  wire  _T_1789 = _T_1683 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_1791 = _T_1687 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_1792 = _T_1689 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_1793 = _T_1691 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_1794 = _T_1693 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1795 = _T_1695 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_1796 = _T_1697 & _T_1132; // @[Mux.scala 27:72]
  wire  _T_1797 = _T_1701 & _T_1136; // @[Mux.scala 27:72]
  wire  _T_1798 = _T_1705 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_1799 = _T_1707 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_1800 = _T_1709 & _T_1144; // @[Mux.scala 27:72]
  wire  _T_1801 = _T_1713 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1802 = _T_1715 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_1803 = _T_1717 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_1804 = _T_1719 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1805 = _T_1721 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_1806 = _T_1723 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1807 = _T_1725 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_1808 = _T_1727 & _T_1163; // @[Mux.scala 27:72]
  wire  _T_1809 = _T_1732 & _T_1173; // @[Mux.scala 27:72]
  wire  _T_1810 = _T_1742 & _T_1176; // @[Mux.scala 27:72]
  wire  _T_1811 = _T_1745 & _T_1179; // @[Mux.scala 27:72]
  wire  _T_1812 = _T_1748 & _T_1182; // @[Mux.scala 27:72]
  wire  _T_1813 = _T_1751 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_1814 = _T_1753 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_1815 = _T_1755 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_1816 = _T_1757 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_1817 = _T_1759 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_1818 = _T_1594 | _T_1762; // @[Mux.scala 27:72]
  wire  _T_1819 = _T_1818 | _T_1763; // @[Mux.scala 27:72]
  wire  _T_1820 = _T_1819 | _T_1764; // @[Mux.scala 27:72]
  wire  _T_1821 = _T_1820 | _T_1765; // @[Mux.scala 27:72]
  wire  _T_1822 = _T_1821 | _T_1766; // @[Mux.scala 27:72]
  wire  _T_1823 = _T_1822 | _T_1767; // @[Mux.scala 27:72]
  wire  _T_1824 = _T_1823 | _T_1768; // @[Mux.scala 27:72]
  wire  _T_1825 = _T_1824 | _T_1769; // @[Mux.scala 27:72]
  wire  _T_1826 = _T_1825 | _T_1770; // @[Mux.scala 27:72]
  wire  _T_1827 = _T_1826 | _T_1771; // @[Mux.scala 27:72]
  wire  _T_1828 = _T_1827 | _T_1772; // @[Mux.scala 27:72]
  wire  _T_1829 = _T_1828 | _T_1773; // @[Mux.scala 27:72]
  wire  _T_1830 = _T_1829 | _T_1774; // @[Mux.scala 27:72]
  wire  _T_1831 = _T_1830 | _T_1775; // @[Mux.scala 27:72]
  wire  _T_1832 = _T_1831 | _T_1776; // @[Mux.scala 27:72]
  wire  _T_1833 = _T_1832 | _T_1777; // @[Mux.scala 27:72]
  wire  _T_1834 = _T_1833 | _T_1778; // @[Mux.scala 27:72]
  wire  _T_1835 = _T_1834 | _T_1779; // @[Mux.scala 27:72]
  wire  _T_1836 = _T_1835 | _T_1780; // @[Mux.scala 27:72]
  wire  _T_1837 = _T_1836 | _T_1781; // @[Mux.scala 27:72]
  wire  _T_1838 = _T_1837 | _T_1782; // @[Mux.scala 27:72]
  wire  _T_1839 = _T_1838 | _T_1783; // @[Mux.scala 27:72]
  wire  _T_1840 = _T_1839 | _T_1784; // @[Mux.scala 27:72]
  wire  _T_1841 = _T_1840 | _T_1785; // @[Mux.scala 27:72]
  wire  _T_1842 = _T_1841 | _T_1786; // @[Mux.scala 27:72]
  wire  _T_1843 = _T_1842 | _T_1787; // @[Mux.scala 27:72]
  wire  _T_1844 = _T_1843 | _T_1788; // @[Mux.scala 27:72]
  wire  _T_1845 = _T_1844 | _T_1789; // @[Mux.scala 27:72]
  wire  _T_1846 = _T_1845 | _T_1769; // @[Mux.scala 27:72]
  wire  _T_1847 = _T_1846 | _T_1791; // @[Mux.scala 27:72]
  wire  _T_1848 = _T_1847 | _T_1792; // @[Mux.scala 27:72]
  wire  _T_1849 = _T_1848 | _T_1793; // @[Mux.scala 27:72]
  wire  _T_1850 = _T_1849 | _T_1794; // @[Mux.scala 27:72]
  wire  _T_1851 = _T_1850 | _T_1795; // @[Mux.scala 27:72]
  wire  _T_1852 = _T_1851 | _T_1796; // @[Mux.scala 27:72]
  wire  _T_1853 = _T_1852 | _T_1797; // @[Mux.scala 27:72]
  wire  _T_1854 = _T_1853 | _T_1798; // @[Mux.scala 27:72]
  wire  _T_1855 = _T_1854 | _T_1799; // @[Mux.scala 27:72]
  wire  _T_1856 = _T_1855 | _T_1800; // @[Mux.scala 27:72]
  wire  _T_1857 = _T_1856 | _T_1801; // @[Mux.scala 27:72]
  wire  _T_1858 = _T_1857 | _T_1802; // @[Mux.scala 27:72]
  wire  _T_1859 = _T_1858 | _T_1803; // @[Mux.scala 27:72]
  wire  _T_1860 = _T_1859 | _T_1804; // @[Mux.scala 27:72]
  wire  _T_1861 = _T_1860 | _T_1805; // @[Mux.scala 27:72]
  wire  _T_1862 = _T_1861 | _T_1806; // @[Mux.scala 27:72]
  wire  _T_1863 = _T_1862 | _T_1807; // @[Mux.scala 27:72]
  wire  _T_1864 = _T_1863 | _T_1808; // @[Mux.scala 27:72]
  wire  _T_1865 = _T_1864 | _T_1809; // @[Mux.scala 27:72]
  wire  _T_1866 = _T_1865 | _T_1810; // @[Mux.scala 27:72]
  wire  _T_1867 = _T_1866 | _T_1811; // @[Mux.scala 27:72]
  wire  _T_1868 = _T_1867 | _T_1812; // @[Mux.scala 27:72]
  wire  _T_1869 = _T_1868 | _T_1813; // @[Mux.scala 27:72]
  wire  _T_1870 = _T_1869 | _T_1814; // @[Mux.scala 27:72]
  wire  _T_1871 = _T_1870 | _T_1815; // @[Mux.scala 27:72]
  wire  _T_1872 = _T_1871 | _T_1816; // @[Mux.scala 27:72]
  wire  _T_1873 = _T_1872 | _T_1817; // @[Mux.scala 27:72]
  wire  mhpmc_inc_r_2 = _T_1593 & _T_1873; // @[dec_tlu_ctl.scala 2273:44]
  wire  _T_1877 = ~mcountinhibit[6]; // @[dec_tlu_ctl.scala 2273:24]
  reg [9:0] mhpme6; // @[Reg.scala 27:20]
  wire  _T_1878 = mhpme6 == 10'h1; // @[dec_tlu_ctl.scala 2274:34]
  wire  _T_1880 = mhpme6 == 10'h2; // @[dec_tlu_ctl.scala 2275:34]
  wire  _T_1882 = mhpme6 == 10'h3; // @[dec_tlu_ctl.scala 2276:34]
  wire  _T_1884 = mhpme6 == 10'h4; // @[dec_tlu_ctl.scala 2277:34]
  wire  _T_1888 = mhpme6 == 10'h5; // @[dec_tlu_ctl.scala 2278:34]
  wire  _T_1894 = mhpme6 == 10'h6; // @[dec_tlu_ctl.scala 2279:34]
  wire  _T_1899 = mhpme6 == 10'h7; // @[dec_tlu_ctl.scala 2280:34]
  wire  _T_1901 = mhpme6 == 10'h8; // @[dec_tlu_ctl.scala 2281:34]
  wire  _T_1903 = mhpme6 == 10'h1e; // @[dec_tlu_ctl.scala 2282:34]
  wire  _T_1905 = mhpme6 == 10'h9; // @[dec_tlu_ctl.scala 2283:34]
  wire  _T_1908 = mhpme6 == 10'ha; // @[dec_tlu_ctl.scala 2284:34]
  wire  _T_1911 = mhpme6 == 10'hb; // @[dec_tlu_ctl.scala 2285:34]
  wire  _T_1914 = mhpme6 == 10'hc; // @[dec_tlu_ctl.scala 2286:34]
  wire  _T_1917 = mhpme6 == 10'hd; // @[dec_tlu_ctl.scala 2287:34]
  wire  _T_1921 = mhpme6 == 10'he; // @[dec_tlu_ctl.scala 2288:34]
  wire  _T_1926 = mhpme6 == 10'hf; // @[dec_tlu_ctl.scala 2289:34]
  wire  _T_1929 = mhpme6 == 10'h10; // @[dec_tlu_ctl.scala 2290:34]
  wire  _T_1932 = mhpme6 == 10'h12; // @[dec_tlu_ctl.scala 2291:34]
  wire  _T_1935 = mhpme6 == 10'h11; // @[dec_tlu_ctl.scala 2292:34]
  wire  _T_1938 = mhpme6 == 10'h13; // @[dec_tlu_ctl.scala 2293:34]
  wire  _T_1941 = mhpme6 == 10'h14; // @[dec_tlu_ctl.scala 2294:34]
  wire  _T_1944 = mhpme6 == 10'h15; // @[dec_tlu_ctl.scala 2295:34]
  wire  _T_1947 = mhpme6 == 10'h16; // @[dec_tlu_ctl.scala 2296:34]
  wire  _T_1950 = mhpme6 == 10'h17; // @[dec_tlu_ctl.scala 2297:34]
  wire  _T_1953 = mhpme6 == 10'h18; // @[dec_tlu_ctl.scala 2298:34]
  wire  _T_1958 = mhpme6 == 10'h19; // @[dec_tlu_ctl.scala 2299:34]
  wire  _T_1961 = mhpme6 == 10'h1a; // @[dec_tlu_ctl.scala 2300:34]
  wire  _T_1964 = mhpme6 == 10'h1b; // @[dec_tlu_ctl.scala 2301:34]
  wire  _T_1967 = mhpme6 == 10'h1c; // @[dec_tlu_ctl.scala 2302:34]
  wire  _T_1971 = mhpme6 == 10'h1f; // @[dec_tlu_ctl.scala 2304:34]
  wire  _T_1973 = mhpme6 == 10'h20; // @[dec_tlu_ctl.scala 2305:34]
  wire  _T_1975 = mhpme6 == 10'h22; // @[dec_tlu_ctl.scala 2306:34]
  wire  _T_1977 = mhpme6 == 10'h23; // @[dec_tlu_ctl.scala 2307:34]
  wire  _T_1979 = mhpme6 == 10'h24; // @[dec_tlu_ctl.scala 2308:34]
  wire  _T_1981 = mhpme6 == 10'h25; // @[dec_tlu_ctl.scala 2309:34]
  wire  _T_1985 = mhpme6 == 10'h26; // @[dec_tlu_ctl.scala 2310:34]
  wire  _T_1989 = mhpme6 == 10'h27; // @[dec_tlu_ctl.scala 2311:34]
  wire  _T_1991 = mhpme6 == 10'h28; // @[dec_tlu_ctl.scala 2312:34]
  wire  _T_1993 = mhpme6 == 10'h29; // @[dec_tlu_ctl.scala 2313:34]
  wire  _T_1997 = mhpme6 == 10'h2a; // @[dec_tlu_ctl.scala 2314:34]
  wire  _T_1999 = mhpme6 == 10'h2b; // @[dec_tlu_ctl.scala 2315:34]
  wire  _T_2001 = mhpme6 == 10'h2c; // @[dec_tlu_ctl.scala 2316:34]
  wire  _T_2003 = mhpme6 == 10'h2d; // @[dec_tlu_ctl.scala 2317:34]
  wire  _T_2005 = mhpme6 == 10'h2e; // @[dec_tlu_ctl.scala 2318:34]
  wire  _T_2007 = mhpme6 == 10'h2f; // @[dec_tlu_ctl.scala 2319:34]
  wire  _T_2009 = mhpme6 == 10'h30; // @[dec_tlu_ctl.scala 2320:34]
  wire  _T_2011 = mhpme6 == 10'h31; // @[dec_tlu_ctl.scala 2321:34]
  wire  _T_2016 = mhpme6 == 10'h32; // @[dec_tlu_ctl.scala 2322:34]
  wire  _T_2026 = mhpme6 == 10'h36; // @[dec_tlu_ctl.scala 2323:34]
  wire  _T_2029 = mhpme6 == 10'h37; // @[dec_tlu_ctl.scala 2324:34]
  wire  _T_2032 = mhpme6 == 10'h38; // @[dec_tlu_ctl.scala 2325:34]
  wire  _T_2035 = mhpme6 == 10'h200; // @[dec_tlu_ctl.scala 2327:34]
  wire  _T_2037 = mhpme6 == 10'h201; // @[dec_tlu_ctl.scala 2328:34]
  wire  _T_2039 = mhpme6 == 10'h202; // @[dec_tlu_ctl.scala 2329:34]
  wire  _T_2041 = mhpme6 == 10'h203; // @[dec_tlu_ctl.scala 2330:34]
  wire  _T_2043 = mhpme6 == 10'h204; // @[dec_tlu_ctl.scala 2331:34]
  wire  _T_2046 = _T_1880 & io_ifu_pmu_ic_hit; // @[Mux.scala 27:72]
  wire  _T_2047 = _T_1882 & io_ifu_pmu_ic_miss; // @[Mux.scala 27:72]
  wire  _T_2048 = _T_1884 & _T_1035; // @[Mux.scala 27:72]
  wire  _T_2049 = _T_1888 & _T_1041; // @[Mux.scala 27:72]
  wire  _T_2050 = _T_1894 & _T_1046; // @[Mux.scala 27:72]
  wire  _T_2051 = _T_1899 & io_ifu_pmu_instr_aligned; // @[Mux.scala 27:72]
  wire  _T_2052 = _T_1901 & io_dec_pmu_instr_decoded; // @[Mux.scala 27:72]
  wire  _T_2053 = _T_1903 & io_dec_pmu_decode_stall; // @[Mux.scala 27:72]
  wire  _T_2054 = _T_1905 & _T_1055; // @[Mux.scala 27:72]
  wire  _T_2055 = _T_1908 & _T_1058; // @[Mux.scala 27:72]
  wire  _T_2056 = _T_1911 & _T_1061; // @[Mux.scala 27:72]
  wire  _T_2057 = _T_1914 & _T_1064; // @[Mux.scala 27:72]
  wire  _T_2058 = _T_1917 & _T_1068; // @[Mux.scala 27:72]
  wire  _T_2059 = _T_1921 & _T_1073; // @[Mux.scala 27:72]
  wire  _T_2060 = _T_1926 & _T_1076; // @[Mux.scala 27:72]
  wire  _T_2061 = _T_1929 & _T_1079; // @[Mux.scala 27:72]
  wire  _T_2062 = _T_1932 & _T_1082; // @[Mux.scala 27:72]
  wire  _T_2063 = _T_1935 & _T_1085; // @[Mux.scala 27:72]
  wire  _T_2064 = _T_1938 & _T_1088; // @[Mux.scala 27:72]
  wire  _T_2065 = _T_1941 & _T_1091; // @[Mux.scala 27:72]
  wire  _T_2066 = _T_1944 & _T_1094; // @[Mux.scala 27:72]
  wire  _T_2067 = _T_1947 & _T_1097; // @[Mux.scala 27:72]
  wire  _T_2068 = _T_1950 & _T_1100; // @[Mux.scala 27:72]
  wire  _T_2069 = _T_1953 & _T_1105; // @[Mux.scala 27:72]
  wire  _T_2070 = _T_1958 & _T_1108; // @[Mux.scala 27:72]
  wire  _T_2071 = _T_1961 & _T_1111; // @[Mux.scala 27:72]
  wire  _T_2072 = _T_1964 & _T_1114; // @[Mux.scala 27:72]
  wire  _T_2073 = _T_1967 & io_ifu_pmu_fetch_stall; // @[Mux.scala 27:72]
  wire  _T_2075 = _T_1971 & io_dec_pmu_postsync_stall; // @[Mux.scala 27:72]
  wire  _T_2076 = _T_1973 & io_dec_pmu_presync_stall; // @[Mux.scala 27:72]
  wire  _T_2077 = _T_1975 & io_lsu_store_stall_any; // @[Mux.scala 27:72]
  wire  _T_2078 = _T_1977 & io_dma_dccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_2079 = _T_1979 & io_dma_iccm_stall_any; // @[Mux.scala 27:72]
  wire  _T_2080 = _T_1981 & _T_1132; // @[Mux.scala 27:72]
  wire  _T_2081 = _T_1985 & _T_1136; // @[Mux.scala 27:72]
  wire  _T_2082 = _T_1989 & io_take_ext_int; // @[Mux.scala 27:72]
  wire  _T_2083 = _T_1991 & io_tlu_flush_lower_r; // @[Mux.scala 27:72]
  wire  _T_2084 = _T_1993 & _T_1144; // @[Mux.scala 27:72]
  wire  _T_2085 = _T_1997 & io_ifu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_2086 = _T_1999 & io_lsu_pmu_bus_trxn; // @[Mux.scala 27:72]
  wire  _T_2087 = _T_2001 & io_lsu_pmu_bus_misaligned; // @[Mux.scala 27:72]
  wire  _T_2088 = _T_2003 & io_ifu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_2089 = _T_2005 & io_lsu_pmu_bus_error; // @[Mux.scala 27:72]
  wire  _T_2090 = _T_2007 & io_ifu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_2091 = _T_2009 & io_lsu_pmu_bus_busy; // @[Mux.scala 27:72]
  wire  _T_2092 = _T_2011 & _T_1163; // @[Mux.scala 27:72]
  wire  _T_2093 = _T_2016 & _T_1173; // @[Mux.scala 27:72]
  wire  _T_2094 = _T_2026 & _T_1176; // @[Mux.scala 27:72]
  wire  _T_2095 = _T_2029 & _T_1179; // @[Mux.scala 27:72]
  wire  _T_2096 = _T_2032 & _T_1182; // @[Mux.scala 27:72]
  wire  _T_2097 = _T_2035 & io_dec_tlu_pmu_fw_halted; // @[Mux.scala 27:72]
  wire  _T_2098 = _T_2037 & io_dma_pmu_any_read; // @[Mux.scala 27:72]
  wire  _T_2099 = _T_2039 & io_dma_pmu_any_write; // @[Mux.scala 27:72]
  wire  _T_2100 = _T_2041 & io_dma_pmu_dccm_read; // @[Mux.scala 27:72]
  wire  _T_2101 = _T_2043 & io_dma_pmu_dccm_write; // @[Mux.scala 27:72]
  wire  _T_2102 = _T_1878 | _T_2046; // @[Mux.scala 27:72]
  wire  _T_2103 = _T_2102 | _T_2047; // @[Mux.scala 27:72]
  wire  _T_2104 = _T_2103 | _T_2048; // @[Mux.scala 27:72]
  wire  _T_2105 = _T_2104 | _T_2049; // @[Mux.scala 27:72]
  wire  _T_2106 = _T_2105 | _T_2050; // @[Mux.scala 27:72]
  wire  _T_2107 = _T_2106 | _T_2051; // @[Mux.scala 27:72]
  wire  _T_2108 = _T_2107 | _T_2052; // @[Mux.scala 27:72]
  wire  _T_2109 = _T_2108 | _T_2053; // @[Mux.scala 27:72]
  wire  _T_2110 = _T_2109 | _T_2054; // @[Mux.scala 27:72]
  wire  _T_2111 = _T_2110 | _T_2055; // @[Mux.scala 27:72]
  wire  _T_2112 = _T_2111 | _T_2056; // @[Mux.scala 27:72]
  wire  _T_2113 = _T_2112 | _T_2057; // @[Mux.scala 27:72]
  wire  _T_2114 = _T_2113 | _T_2058; // @[Mux.scala 27:72]
  wire  _T_2115 = _T_2114 | _T_2059; // @[Mux.scala 27:72]
  wire  _T_2116 = _T_2115 | _T_2060; // @[Mux.scala 27:72]
  wire  _T_2117 = _T_2116 | _T_2061; // @[Mux.scala 27:72]
  wire  _T_2118 = _T_2117 | _T_2062; // @[Mux.scala 27:72]
  wire  _T_2119 = _T_2118 | _T_2063; // @[Mux.scala 27:72]
  wire  _T_2120 = _T_2119 | _T_2064; // @[Mux.scala 27:72]
  wire  _T_2121 = _T_2120 | _T_2065; // @[Mux.scala 27:72]
  wire  _T_2122 = _T_2121 | _T_2066; // @[Mux.scala 27:72]
  wire  _T_2123 = _T_2122 | _T_2067; // @[Mux.scala 27:72]
  wire  _T_2124 = _T_2123 | _T_2068; // @[Mux.scala 27:72]
  wire  _T_2125 = _T_2124 | _T_2069; // @[Mux.scala 27:72]
  wire  _T_2126 = _T_2125 | _T_2070; // @[Mux.scala 27:72]
  wire  _T_2127 = _T_2126 | _T_2071; // @[Mux.scala 27:72]
  wire  _T_2128 = _T_2127 | _T_2072; // @[Mux.scala 27:72]
  wire  _T_2129 = _T_2128 | _T_2073; // @[Mux.scala 27:72]
  wire  _T_2130 = _T_2129 | _T_2053; // @[Mux.scala 27:72]
  wire  _T_2131 = _T_2130 | _T_2075; // @[Mux.scala 27:72]
  wire  _T_2132 = _T_2131 | _T_2076; // @[Mux.scala 27:72]
  wire  _T_2133 = _T_2132 | _T_2077; // @[Mux.scala 27:72]
  wire  _T_2134 = _T_2133 | _T_2078; // @[Mux.scala 27:72]
  wire  _T_2135 = _T_2134 | _T_2079; // @[Mux.scala 27:72]
  wire  _T_2136 = _T_2135 | _T_2080; // @[Mux.scala 27:72]
  wire  _T_2137 = _T_2136 | _T_2081; // @[Mux.scala 27:72]
  wire  _T_2138 = _T_2137 | _T_2082; // @[Mux.scala 27:72]
  wire  _T_2139 = _T_2138 | _T_2083; // @[Mux.scala 27:72]
  wire  _T_2140 = _T_2139 | _T_2084; // @[Mux.scala 27:72]
  wire  _T_2141 = _T_2140 | _T_2085; // @[Mux.scala 27:72]
  wire  _T_2142 = _T_2141 | _T_2086; // @[Mux.scala 27:72]
  wire  _T_2143 = _T_2142 | _T_2087; // @[Mux.scala 27:72]
  wire  _T_2144 = _T_2143 | _T_2088; // @[Mux.scala 27:72]
  wire  _T_2145 = _T_2144 | _T_2089; // @[Mux.scala 27:72]
  wire  _T_2146 = _T_2145 | _T_2090; // @[Mux.scala 27:72]
  wire  _T_2147 = _T_2146 | _T_2091; // @[Mux.scala 27:72]
  wire  _T_2148 = _T_2147 | _T_2092; // @[Mux.scala 27:72]
  wire  _T_2149 = _T_2148 | _T_2093; // @[Mux.scala 27:72]
  wire  _T_2150 = _T_2149 | _T_2094; // @[Mux.scala 27:72]
  wire  _T_2151 = _T_2150 | _T_2095; // @[Mux.scala 27:72]
  wire  _T_2152 = _T_2151 | _T_2096; // @[Mux.scala 27:72]
  wire  _T_2153 = _T_2152 | _T_2097; // @[Mux.scala 27:72]
  wire  _T_2154 = _T_2153 | _T_2098; // @[Mux.scala 27:72]
  wire  _T_2155 = _T_2154 | _T_2099; // @[Mux.scala 27:72]
  wire  _T_2156 = _T_2155 | _T_2100; // @[Mux.scala 27:72]
  wire  _T_2157 = _T_2156 | _T_2101; // @[Mux.scala 27:72]
  wire  mhpmc_inc_r_3 = _T_1877 & _T_2157; // @[dec_tlu_ctl.scala 2273:44]
  reg  mhpmc_inc_r_d1_0; // @[dec_tlu_ctl.scala 2334:53]
  reg  mhpmc_inc_r_d1_1; // @[dec_tlu_ctl.scala 2335:53]
  reg  mhpmc_inc_r_d1_2; // @[dec_tlu_ctl.scala 2336:53]
  reg  mhpmc_inc_r_d1_3; // @[dec_tlu_ctl.scala 2337:53]
  reg  perfcnt_halted_d1; // @[dec_tlu_ctl.scala 2338:56]
  wire  perfcnt_halted = _T_85 | io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 2341:67]
  wire  _T_2169 = ~_T_85; // @[dec_tlu_ctl.scala 2342:37]
  wire [3:0] _T_2171 = _T_2169 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_2178 = {mhpme6[9],mhpme5[9],mhpme4[9],mhpme3[9]}; // @[Cat.scala 29:58]
  wire [3:0] perfcnt_during_sleep = _T_2171 & _T_2178; // @[dec_tlu_ctl.scala 2342:86]
  wire  _T_2180 = ~perfcnt_during_sleep[0]; // @[dec_tlu_ctl.scala 2344:67]
  wire  _T_2181 = perfcnt_halted_d1 & _T_2180; // @[dec_tlu_ctl.scala 2344:65]
  wire  _T_2182 = ~_T_2181; // @[dec_tlu_ctl.scala 2344:45]
  wire  _T_2185 = ~perfcnt_during_sleep[1]; // @[dec_tlu_ctl.scala 2345:67]
  wire  _T_2186 = perfcnt_halted_d1 & _T_2185; // @[dec_tlu_ctl.scala 2345:65]
  wire  _T_2187 = ~_T_2186; // @[dec_tlu_ctl.scala 2345:45]
  wire  _T_2190 = ~perfcnt_during_sleep[2]; // @[dec_tlu_ctl.scala 2346:67]
  wire  _T_2191 = perfcnt_halted_d1 & _T_2190; // @[dec_tlu_ctl.scala 2346:65]
  wire  _T_2192 = ~_T_2191; // @[dec_tlu_ctl.scala 2346:45]
  wire  _T_2195 = ~perfcnt_during_sleep[3]; // @[dec_tlu_ctl.scala 2347:67]
  wire  _T_2196 = perfcnt_halted_d1 & _T_2195; // @[dec_tlu_ctl.scala 2347:65]
  wire  _T_2197 = ~_T_2196; // @[dec_tlu_ctl.scala 2347:45]
  wire  _T_2200 = io_dec_csr_wraddr_r == 12'hb03; // @[dec_tlu_ctl.scala 2353:72]
  wire  mhpmc3_wr_en0 = io_dec_csr_wen_r_mod & _T_2200; // @[dec_tlu_ctl.scala 2353:43]
  wire  _T_2201 = ~perfcnt_halted; // @[dec_tlu_ctl.scala 2354:23]
  wire  _T_2203 = _T_2201 | perfcnt_during_sleep[0]; // @[dec_tlu_ctl.scala 2354:39]
  wire  _T_2204 = |mhpmc_inc_r_0; // @[dec_tlu_ctl.scala 2354:86]
  wire  mhpmc3_wr_en1 = _T_2203 & _T_2204; // @[dec_tlu_ctl.scala 2354:66]
  reg [31:0] mhpmc3h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc3; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2207 = {mhpmc3h,mhpmc3}; // @[Cat.scala 29:58]
  wire [63:0] _T_2208 = {63'h0,mhpmc_inc_r_0}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc3_incr = _T_2207 + _T_2208; // @[dec_tlu_ctl.scala 2358:49]
  wire  _T_2216 = io_dec_csr_wraddr_r == 12'hb83; // @[dec_tlu_ctl.scala 2363:73]
  wire  mhpmc3h_wr_en0 = io_dec_csr_wen_r_mod & _T_2216; // @[dec_tlu_ctl.scala 2363:44]
  wire  _T_2222 = io_dec_csr_wraddr_r == 12'hb04; // @[dec_tlu_ctl.scala 2372:72]
  wire  mhpmc4_wr_en0 = io_dec_csr_wen_r_mod & _T_2222; // @[dec_tlu_ctl.scala 2372:43]
  wire  _T_2225 = _T_2201 | perfcnt_during_sleep[1]; // @[dec_tlu_ctl.scala 2373:39]
  wire  _T_2226 = |mhpmc_inc_r_1; // @[dec_tlu_ctl.scala 2373:86]
  wire  mhpmc4_wr_en1 = _T_2225 & _T_2226; // @[dec_tlu_ctl.scala 2373:66]
  reg [31:0] mhpmc4h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc4; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2229 = {mhpmc4h,mhpmc4}; // @[Cat.scala 29:58]
  wire [63:0] _T_2230 = {63'h0,mhpmc_inc_r_1}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc4_incr = _T_2229 + _T_2230; // @[dec_tlu_ctl.scala 2378:49]
  wire  _T_2239 = io_dec_csr_wraddr_r == 12'hb84; // @[dec_tlu_ctl.scala 2382:73]
  wire  mhpmc4h_wr_en0 = io_dec_csr_wen_r_mod & _T_2239; // @[dec_tlu_ctl.scala 2382:44]
  wire  _T_2245 = io_dec_csr_wraddr_r == 12'hb05; // @[dec_tlu_ctl.scala 2391:72]
  wire  mhpmc5_wr_en0 = io_dec_csr_wen_r_mod & _T_2245; // @[dec_tlu_ctl.scala 2391:43]
  wire  _T_2248 = _T_2201 | perfcnt_during_sleep[2]; // @[dec_tlu_ctl.scala 2392:39]
  wire  _T_2249 = |mhpmc_inc_r_2; // @[dec_tlu_ctl.scala 2392:86]
  wire  mhpmc5_wr_en1 = _T_2248 & _T_2249; // @[dec_tlu_ctl.scala 2392:66]
  reg [31:0] mhpmc5h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc5; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2252 = {mhpmc5h,mhpmc5}; // @[Cat.scala 29:58]
  wire [63:0] _T_2253 = {63'h0,mhpmc_inc_r_2}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc5_incr = _T_2252 + _T_2253; // @[dec_tlu_ctl.scala 2395:49]
  wire  _T_2261 = io_dec_csr_wraddr_r == 12'hb85; // @[dec_tlu_ctl.scala 2400:73]
  wire  mhpmc5h_wr_en0 = io_dec_csr_wen_r_mod & _T_2261; // @[dec_tlu_ctl.scala 2400:44]
  wire  _T_2267 = io_dec_csr_wraddr_r == 12'hb06; // @[dec_tlu_ctl.scala 2409:72]
  wire  mhpmc6_wr_en0 = io_dec_csr_wen_r_mod & _T_2267; // @[dec_tlu_ctl.scala 2409:43]
  wire  _T_2270 = _T_2201 | perfcnt_during_sleep[3]; // @[dec_tlu_ctl.scala 2410:39]
  wire  _T_2271 = |mhpmc_inc_r_3; // @[dec_tlu_ctl.scala 2410:86]
  wire  mhpmc6_wr_en1 = _T_2270 & _T_2271; // @[dec_tlu_ctl.scala 2410:66]
  reg [31:0] mhpmc6h; // @[el2_lib.scala 514:16]
  reg [31:0] mhpmc6; // @[el2_lib.scala 514:16]
  wire [63:0] _T_2274 = {mhpmc6h,mhpmc6}; // @[Cat.scala 29:58]
  wire [63:0] _T_2275 = {63'h0,mhpmc_inc_r_3}; // @[Cat.scala 29:58]
  wire [63:0] mhpmc6_incr = _T_2274 + _T_2275; // @[dec_tlu_ctl.scala 2413:49]
  wire  _T_2283 = io_dec_csr_wraddr_r == 12'hb86; // @[dec_tlu_ctl.scala 2418:73]
  wire  mhpmc6h_wr_en0 = io_dec_csr_wen_r_mod & _T_2283; // @[dec_tlu_ctl.scala 2418:44]
  wire  _T_2289 = io_dec_csr_wrdata_r[9:0] > 10'h204; // @[dec_tlu_ctl.scala 2429:56]
  wire  _T_2291 = |io_dec_csr_wrdata_r[31:10]; // @[dec_tlu_ctl.scala 2429:102]
  wire  _T_2292 = _T_2289 | _T_2291; // @[dec_tlu_ctl.scala 2429:71]
  wire  _T_2295 = io_dec_csr_wraddr_r == 12'h323; // @[dec_tlu_ctl.scala 2431:70]
  wire  wr_mhpme3_r = io_dec_csr_wen_r_mod & _T_2295; // @[dec_tlu_ctl.scala 2431:41]
  wire  _T_2299 = io_dec_csr_wraddr_r == 12'h324; // @[dec_tlu_ctl.scala 2438:70]
  wire  wr_mhpme4_r = io_dec_csr_wen_r_mod & _T_2299; // @[dec_tlu_ctl.scala 2438:41]
  wire  _T_2303 = io_dec_csr_wraddr_r == 12'h325; // @[dec_tlu_ctl.scala 2445:70]
  wire  wr_mhpme5_r = io_dec_csr_wen_r_mod & _T_2303; // @[dec_tlu_ctl.scala 2445:41]
  wire  _T_2307 = io_dec_csr_wraddr_r == 12'h326; // @[dec_tlu_ctl.scala 2452:70]
  wire  wr_mhpme6_r = io_dec_csr_wen_r_mod & _T_2307; // @[dec_tlu_ctl.scala 2452:41]
  wire  _T_2311 = io_dec_csr_wraddr_r == 12'h320; // @[dec_tlu_ctl.scala 2469:77]
  wire  wr_mcountinhibit_r = io_dec_csr_wen_r_mod & _T_2311; // @[dec_tlu_ctl.scala 2469:48]
  wire  _T_2323 = io_i0_valid_wb | io_exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 2484:51]
  wire  _T_2324 = _T_2323 | io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 2484:78]
  wire  _T_2325 = _T_2324 | io_dec_tlu_i0_valid_wb1; // @[dec_tlu_ctl.scala 2484:104]
  wire  _T_2326 = _T_2325 | io_dec_tlu_i0_exc_valid_wb1; // @[dec_tlu_ctl.scala 2484:130]
  wire  _T_2327 = _T_2326 | io_dec_tlu_int_valid_wb1; // @[dec_tlu_ctl.scala 2485:32]
  reg  _T_2330; // @[dec_tlu_ctl.scala 2487:62]
  wire  _T_2331 = io_i0_exception_valid_r_d1 | io_lsu_i0_exc_r_d1; // @[dec_tlu_ctl.scala 2488:91]
  wire  _T_2332 = ~io_trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 2488:137]
  wire  _T_2333 = io_trigger_hit_r_d1 & _T_2332; // @[dec_tlu_ctl.scala 2488:135]
  reg  _T_2335; // @[dec_tlu_ctl.scala 2488:62]
  reg [4:0] _T_2336; // @[dec_tlu_ctl.scala 2489:62]
  reg  _T_2337; // @[dec_tlu_ctl.scala 2490:62]
  wire [31:0] _T_2343 = {io_core_id,4'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2352 = {21'h3,3'h0,io_mstatus[1],3'h0,io_mstatus[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2357 = {io_mtvec[30:1],1'h0,io_mtvec[0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_2370 = {1'h0,io_mip[5:3],16'h0,io_mip[2],3'h0,io_mip[1],3'h0,io_mip[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2383 = {1'h0,mie[5:3],16'h0,mie[2],3'h0,mie[1],3'h0,mie[0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2395 = {io_mepc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2400 = {28'h0,mscause}; // @[Cat.scala 29:58]
  wire [31:0] _T_2408 = {meivt,10'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2411 = {meivt,meihap,2'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2414 = {28'h0,meicurpl}; // @[Cat.scala 29:58]
  wire [31:0] _T_2417 = {28'h0,meicidpl}; // @[Cat.scala 29:58]
  wire [31:0] _T_2420 = {28'h0,meipt}; // @[Cat.scala 29:58]
  wire [31:0] _T_2423 = {23'h0,mcgc}; // @[Cat.scala 29:58]
  wire [31:0] _T_2426 = {13'h0,_T_350,4'h0,mfdc_int[11:7],_T_353,mfdc_int[5:0]}; // @[Cat.scala 29:58]
  wire [31:0] _T_2430 = {16'h4000,io_dcsr[15:2],2'h3}; // @[Cat.scala 29:58]
  wire [31:0] _T_2432 = {io_dpc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2448 = {7'h0,dicawics[16],2'h0,dicawics[15:14],3'h0,dicawics[13:0],3'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2451 = {30'h0,mtsel}; // @[Cat.scala 29:58]
  wire [31:0] _T_2480 = {26'h0,mfdht}; // @[Cat.scala 29:58]
  wire [31:0] _T_2483 = {30'h0,mfdhs}; // @[Cat.scala 29:58]
  wire [31:0] _T_2486 = {22'h0,mhpme3}; // @[Cat.scala 29:58]
  wire [31:0] _T_2489 = {22'h0,mhpme4}; // @[Cat.scala 29:58]
  wire [31:0] _T_2492 = {22'h0,mhpme5}; // @[Cat.scala 29:58]
  wire [31:0] _T_2495 = {22'h0,mhpme6}; // @[Cat.scala 29:58]
  wire [31:0] _T_2498 = {25'h0,temp_ncount6_2,1'h0,temp_ncount0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2501 = {30'h0,mpmc,1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_2504 = io_csr_pkt_csr_misa ? 32'h40001104 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2505 = io_csr_pkt_csr_mvendorid ? 32'h45 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2506 = io_csr_pkt_csr_marchid ? 32'h10 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2507 = io_csr_pkt_csr_mimpid ? 32'h1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2508 = io_csr_pkt_csr_mhartid ? _T_2343 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2509 = io_csr_pkt_csr_mstatus ? _T_2352 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2510 = io_csr_pkt_csr_mtvec ? _T_2357 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2511 = io_csr_pkt_csr_mip ? _T_2370 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2512 = io_csr_pkt_csr_mie ? _T_2383 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2513 = io_csr_pkt_csr_mcyclel ? mcyclel : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2514 = io_csr_pkt_csr_mcycleh ? mcycleh_inc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2515 = io_csr_pkt_csr_minstretl ? minstretl : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2516 = io_csr_pkt_csr_minstreth ? minstreth_inc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2517 = io_csr_pkt_csr_mscratch ? mscratch : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2518 = io_csr_pkt_csr_mepc ? _T_2395 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2519 = io_csr_pkt_csr_mcause ? mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2520 = io_csr_pkt_csr_mscause ? _T_2400 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2521 = io_csr_pkt_csr_mtval ? mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2522 = io_csr_pkt_csr_mrac ? mrac : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2523 = io_csr_pkt_csr_mdseac ? mdseac : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2524 = io_csr_pkt_csr_meivt ? _T_2408 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2525 = io_csr_pkt_csr_meihap ? _T_2411 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2526 = io_csr_pkt_csr_meicurpl ? _T_2414 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2527 = io_csr_pkt_csr_meicidpl ? _T_2417 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2528 = io_csr_pkt_csr_meipt ? _T_2420 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2529 = io_csr_pkt_csr_mcgc ? _T_2423 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2530 = io_csr_pkt_csr_mfdc ? _T_2426 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2531 = io_csr_pkt_csr_dcsr ? _T_2430 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2532 = io_csr_pkt_csr_dpc ? _T_2432 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2533 = io_csr_pkt_csr_dicad0 ? dicad0[31:0] : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2534 = io_csr_pkt_csr_dicad0h ? dicad0h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2535 = io_csr_pkt_csr_dicad1 ? dicad1 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2536 = io_csr_pkt_csr_dicawics ? _T_2448 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2537 = io_csr_pkt_csr_mtsel ? _T_2451 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2538 = io_csr_pkt_csr_mtdata1 ? mtdata1_tsel_out : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2539 = io_csr_pkt_csr_mtdata2 ? mtdata2_tsel_out : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2540 = io_csr_pkt_csr_micect ? micect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2541 = io_csr_pkt_csr_miccmect ? miccmect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2542 = io_csr_pkt_csr_mdccmect ? mdccmect : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2543 = io_csr_pkt_csr_mhpmc3 ? mhpmc3 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2544 = io_csr_pkt_csr_mhpmc4 ? mhpmc4 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2545 = io_csr_pkt_csr_mhpmc5 ? mhpmc5 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2546 = io_csr_pkt_csr_mhpmc6 ? mhpmc6 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2547 = io_csr_pkt_csr_mhpmc3h ? mhpmc3h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2548 = io_csr_pkt_csr_mhpmc4h ? mhpmc4h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2549 = io_csr_pkt_csr_mhpmc5h ? mhpmc5h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2550 = io_csr_pkt_csr_mhpmc6h ? mhpmc6h : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2551 = io_csr_pkt_csr_mfdht ? _T_2480 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2552 = io_csr_pkt_csr_mfdhs ? _T_2483 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2553 = io_csr_pkt_csr_mhpme3 ? _T_2486 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2554 = io_csr_pkt_csr_mhpme4 ? _T_2489 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2555 = io_csr_pkt_csr_mhpme5 ? _T_2492 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2556 = io_csr_pkt_csr_mhpme6 ? _T_2495 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2557 = io_csr_pkt_csr_mcountinhibit ? _T_2498 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2558 = io_csr_pkt_csr_mpmc ? _T_2501 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2559 = io_dec_timer_read_d ? io_dec_timer_rddata_d : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_2560 = _T_2504 | _T_2505; // @[Mux.scala 27:72]
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
  wire [31:0] _T_2613 = _T_2612 | _T_2558; // @[Mux.scala 27:72]
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
  assign io_dec_tlu_ic_diag_pkt_icache_wrdata = {_T_763,dicad0[31:0]}; // @[dec_tlu_ctl.scala 2154:64]
  assign io_dec_tlu_ic_diag_pkt_icache_dicawics = dicawics; // @[dec_tlu_ctl.scala 2157:41]
  assign io_dec_tlu_ic_diag_pkt_icache_rd_valid = icache_rd_valid_f; // @[dec_tlu_ctl.scala 2165:41]
  assign io_dec_tlu_ic_diag_pkt_icache_wr_valid = icache_wr_valid_f; // @[dec_tlu_ctl.scala 2166:41]
  assign io_trigger_pkt_any_0_select = io_mtdata1_t_0[7]; // @[dec_tlu_ctl.scala 2230:40]
  assign io_trigger_pkt_any_0_match_pkt = io_mtdata1_t_0[4]; // @[dec_tlu_ctl.scala 2231:43]
  assign io_trigger_pkt_any_0_store = io_mtdata1_t_0[1]; // @[dec_tlu_ctl.scala 2232:40]
  assign io_trigger_pkt_any_0_load = io_mtdata1_t_0[0]; // @[dec_tlu_ctl.scala 2233:40]
  assign io_trigger_pkt_any_0_execute = io_mtdata1_t_0[2]; // @[dec_tlu_ctl.scala 2234:40]
  assign io_trigger_pkt_any_0_m = io_mtdata1_t_0[3]; // @[dec_tlu_ctl.scala 2235:40]
  assign io_trigger_pkt_any_0_tdata2 = mtdata2_t_0; // @[dec_tlu_ctl.scala 2248:51]
  assign io_trigger_pkt_any_1_select = io_mtdata1_t_1[7]; // @[dec_tlu_ctl.scala 2230:40]
  assign io_trigger_pkt_any_1_match_pkt = io_mtdata1_t_1[4]; // @[dec_tlu_ctl.scala 2231:43]
  assign io_trigger_pkt_any_1_store = io_mtdata1_t_1[1]; // @[dec_tlu_ctl.scala 2232:40]
  assign io_trigger_pkt_any_1_load = io_mtdata1_t_1[0]; // @[dec_tlu_ctl.scala 2233:40]
  assign io_trigger_pkt_any_1_execute = io_mtdata1_t_1[2]; // @[dec_tlu_ctl.scala 2234:40]
  assign io_trigger_pkt_any_1_m = io_mtdata1_t_1[3]; // @[dec_tlu_ctl.scala 2235:40]
  assign io_trigger_pkt_any_1_tdata2 = mtdata2_t_1; // @[dec_tlu_ctl.scala 2248:51]
  assign io_trigger_pkt_any_2_select = io_mtdata1_t_2[7]; // @[dec_tlu_ctl.scala 2230:40]
  assign io_trigger_pkt_any_2_match_pkt = io_mtdata1_t_2[4]; // @[dec_tlu_ctl.scala 2231:43]
  assign io_trigger_pkt_any_2_store = io_mtdata1_t_2[1]; // @[dec_tlu_ctl.scala 2232:40]
  assign io_trigger_pkt_any_2_load = io_mtdata1_t_2[0]; // @[dec_tlu_ctl.scala 2233:40]
  assign io_trigger_pkt_any_2_execute = io_mtdata1_t_2[2]; // @[dec_tlu_ctl.scala 2234:40]
  assign io_trigger_pkt_any_2_m = io_mtdata1_t_2[3]; // @[dec_tlu_ctl.scala 2235:40]
  assign io_trigger_pkt_any_2_tdata2 = mtdata2_t_2; // @[dec_tlu_ctl.scala 2248:51]
  assign io_trigger_pkt_any_3_select = io_mtdata1_t_3[7]; // @[dec_tlu_ctl.scala 2230:40]
  assign io_trigger_pkt_any_3_match_pkt = io_mtdata1_t_3[4]; // @[dec_tlu_ctl.scala 2231:43]
  assign io_trigger_pkt_any_3_store = io_mtdata1_t_3[1]; // @[dec_tlu_ctl.scala 2232:40]
  assign io_trigger_pkt_any_3_load = io_mtdata1_t_3[0]; // @[dec_tlu_ctl.scala 2233:40]
  assign io_trigger_pkt_any_3_execute = io_mtdata1_t_3[2]; // @[dec_tlu_ctl.scala 2234:40]
  assign io_trigger_pkt_any_3_m = io_mtdata1_t_3[3]; // @[dec_tlu_ctl.scala 2235:40]
  assign io_trigger_pkt_any_3_tdata2 = mtdata2_t_3; // @[dec_tlu_ctl.scala 2248:51]
  assign io_dec_tlu_int_valid_wb1 = _T_2337; // @[dec_tlu_ctl.scala 2490:30]
  assign io_dec_tlu_i0_exc_valid_wb1 = _T_2335; // @[dec_tlu_ctl.scala 2488:30]
  assign io_dec_tlu_i0_valid_wb1 = _T_2330; // @[dec_tlu_ctl.scala 2487:30]
  assign io_dec_tlu_mtval_wb1 = mtval; // @[dec_tlu_ctl.scala 2492:24]
  assign io_dec_tlu_exc_cause_wb1 = _T_2336; // @[dec_tlu_ctl.scala 2489:30]
  assign io_dec_tlu_perfcnt0 = mhpmc_inc_r_d1_0 & _T_2182; // @[dec_tlu_ctl.scala 2344:22]
  assign io_dec_tlu_perfcnt1 = mhpmc_inc_r_d1_1 & _T_2187; // @[dec_tlu_ctl.scala 2345:22]
  assign io_dec_tlu_perfcnt2 = mhpmc_inc_r_d1_2 & _T_2192; // @[dec_tlu_ctl.scala 2346:22]
  assign io_dec_tlu_perfcnt3 = mhpmc_inc_r_d1_3 & _T_2197; // @[dec_tlu_ctl.scala 2347:22]
  assign io_dec_tlu_misc_clk_override = mcgc[8]; // @[dec_tlu_ctl.scala 1717:31]
  assign io_dec_tlu_dec_clk_override = mcgc[7]; // @[dec_tlu_ctl.scala 1718:31]
  assign io_dec_tlu_ifu_clk_override = mcgc[5]; // @[dec_tlu_ctl.scala 1719:31]
  assign io_dec_tlu_lsu_clk_override = mcgc[4]; // @[dec_tlu_ctl.scala 1720:31]
  assign io_dec_tlu_bus_clk_override = mcgc[3]; // @[dec_tlu_ctl.scala 1721:31]
  assign io_dec_tlu_pic_clk_override = mcgc[2]; // @[dec_tlu_ctl.scala 1722:31]
  assign io_dec_tlu_dccm_clk_override = mcgc[1]; // @[dec_tlu_ctl.scala 1723:31]
  assign io_dec_tlu_icm_clk_override = mcgc[0]; // @[dec_tlu_ctl.scala 1724:31]
  assign io_dec_csr_rddata_d = _T_2613 | _T_2559; // @[dec_tlu_ctl.scala 2497:21]
  assign io_dec_tlu_pipelining_disable = mfdc[0]; // @[dec_tlu_ctl.scala 1767:39]
  assign io_dec_tlu_wr_pause_r = _T_370 & _T_371; // @[dec_tlu_ctl.scala 1776:24]
  assign io_dec_tlu_meipt = meipt; // @[dec_tlu_ctl.scala 2005:19]
  assign io_dec_tlu_meicurpl = meicurpl; // @[dec_tlu_ctl.scala 1969:22]
  assign io_dec_tlu_meihap = {meivt,meihap}; // @[dec_tlu_ctl.scala 1955:20]
  assign io_dec_tlu_mrac_ff = mrac; // @[dec_tlu_ctl.scala 1806:21]
  assign io_dec_tlu_wb_coalescing_disable = mfdc[2]; // @[dec_tlu_ctl.scala 1766:39]
  assign io_dec_tlu_bpred_disable = mfdc[3]; // @[dec_tlu_ctl.scala 1765:39]
  assign io_dec_tlu_sideeffect_posted_disable = mfdc[6]; // @[dec_tlu_ctl.scala 1764:39]
  assign io_dec_tlu_core_ecc_disable = mfdc[8]; // @[dec_tlu_ctl.scala 1763:39]
  assign io_dec_tlu_external_ldfwd_disable = mfdc[11]; // @[dec_tlu_ctl.scala 1762:39]
  assign io_dec_tlu_dma_qos_prty = mfdc[18:16]; // @[dec_tlu_ctl.scala 1761:39]
  assign io_dec_csr_wen_r_mod = _T_1 & _T_2; // @[dec_tlu_ctl.scala 1450:23]
  assign io_fw_halt_req = _T_502 & _T_503; // @[dec_tlu_ctl.scala 1841:17]
  assign io_mstatus = _T_56; // @[dec_tlu_ctl.scala 1466:13]
  assign io_mstatus_mie_ns = io_mstatus[0] & _T_54; // @[dec_tlu_ctl.scala 1465:20]
  assign io_dcsr = _T_701; // @[dec_tlu_ctl.scala 2052:10]
  assign io_mtvec = _T_62; // @[dec_tlu_ctl.scala 1478:11]
  assign io_mip = _T_68; // @[dec_tlu_ctl.scala 1493:9]
  assign io_mie_ns = wr_mie_r ? _T_78 : mie; // @[dec_tlu_ctl.scala 1507:12]
  assign io_npc_r = _T_161 | _T_159; // @[dec_tlu_ctl.scala 1601:11]
  assign io_npc_r_d1 = _T_167; // @[dec_tlu_ctl.scala 1607:14]
  assign io_mepc = _T_196; // @[dec_tlu_ctl.scala 1626:10]
  assign io_mdseac_locked_ns = mdseac_en | _T_489; // @[dec_tlu_ctl.scala 1824:22]
  assign io_force_halt = mfdht[0] & _T_609; // @[dec_tlu_ctl.scala 1932:16]
  assign io_dpc = _T_726; // @[dec_tlu_ctl.scala 2069:9]
  assign io_mtdata1_t_0 = _T_872; // @[dec_tlu_ctl.scala 2225:39]
  assign io_mtdata1_t_1 = _T_873; // @[dec_tlu_ctl.scala 2225:39]
  assign io_mtdata1_t_2 = _T_874; // @[dec_tlu_ctl.scala 2225:39]
  assign io_mtdata1_t_3 = _T_875; // @[dec_tlu_ctl.scala 2225:39]
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
  assign rvclkhdr_5_io_en = io_dec_csr_wen_r_mod & _T_139; // @[el2_lib.scala 511:17]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_6_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_6_io_en = _T_164 | io_reset_delayed; // @[el2_lib.scala 511:17]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_7_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_7_io_en = _T_142 & io_dec_tlu_i0_valid_r; // @[el2_lib.scala 511:17]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_8_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_8_io_en = io_dec_csr_wen_r_mod & _T_325; // @[el2_lib.scala 511:17]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_9_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_9_io_en = io_dec_csr_wen_r_mod & _T_337; // @[el2_lib.scala 511:17]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_10_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_10_io_en = io_dec_csr_wen_r_mod & _T_374; // @[el2_lib.scala 511:17]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_11_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_11_io_en = _T_493 & _T_494; // @[el2_lib.scala 511:17]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_12_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_12_io_en = wr_micect_r | io_ic_perr_r_d1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_13_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_13_io_en = _T_549 | io_iccm_dma_sb_error; // @[el2_lib.scala 511:17]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_14_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_14_io_en = wr_mdccmect_r | io_lsu_single_ecc_error_r_d1; // @[el2_lib.scala 511:17]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_15_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_15_io_en = io_dec_csr_wen_r_mod & _T_612; // @[el2_lib.scala 511:17]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_16_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_16_io_en = _T_632 | io_take_ext_int_start; // @[el2_lib.scala 511:17]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_17_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_17_io_en = _T_698 | io_take_nmi; // @[el2_lib.scala 511:17]
  assign rvclkhdr_17_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_18_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_18_io_en = _T_723 | dpc_capture_npc; // @[el2_lib.scala 511:17]
  assign rvclkhdr_18_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_19_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_19_io_en = _T_663 & _T_733; // @[el2_lib.scala 511:17]
  assign rvclkhdr_19_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_20_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_20_io_en = wr_dicad0_r | io_ifu_ic_debug_rd_data_valid; // @[el2_lib.scala 511:17]
  assign rvclkhdr_20_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_21_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_21_io_en = wr_dicad0h_r | io_ifu_ic_debug_rd_data_valid; // @[el2_lib.scala 511:17]
  assign rvclkhdr_21_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_22_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_22_io_en = _T_971 & _T_807; // @[el2_lib.scala 511:17]
  assign rvclkhdr_22_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_23_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_23_io_en = _T_980 & _T_816; // @[el2_lib.scala 511:17]
  assign rvclkhdr_23_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_24_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_24_io_en = _T_989 & _T_825; // @[el2_lib.scala 511:17]
  assign rvclkhdr_24_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_25_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_25_io_en = _T_998 & _T_834; // @[el2_lib.scala 511:17]
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
  assign rvclkhdr_34_io_en = _T_2327 | io_clk_override; // @[el2_lib.scala 485:16]
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
  _T_167 = _RAND_18[30:0];
  _RAND_19 = {1{`RANDOM}};
  pc_r_d1 = _RAND_19[30:0];
  _RAND_20 = {1{`RANDOM}};
  _T_196 = _RAND_20[30:0];
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
  _T_701 = _RAND_36[15:0];
  _RAND_37 = {1{`RANDOM}};
  _T_726 = _RAND_37[30:0];
  _RAND_38 = {1{`RANDOM}};
  dicawics = _RAND_38[16:0];
  _RAND_39 = {3{`RANDOM}};
  dicad0 = _RAND_39[70:0];
  _RAND_40 = {1{`RANDOM}};
  dicad0h = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  _T_758 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  icache_rd_valid_f = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  icache_wr_valid_f = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  mtsel = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  _T_872 = _RAND_45[9:0];
  _RAND_46 = {1{`RANDOM}};
  _T_873 = _RAND_46[9:0];
  _RAND_47 = {1{`RANDOM}};
  _T_874 = _RAND_47[9:0];
  _RAND_48 = {1{`RANDOM}};
  _T_875 = _RAND_48[9:0];
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
  _T_2330 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  _T_2335 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  _T_2336 = _RAND_72[4:0];
  _RAND_73 = {1{`RANDOM}};
  _T_2337 = _RAND_73[0:0];
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
    _T_167 = 31'h0;
  end
  if (reset) begin
    pc_r_d1 = 31'h0;
  end
  if (reset) begin
    _T_196 = 31'h0;
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
    _T_701 = 16'h0;
  end
  if (reset) begin
    _T_726 = 31'h0;
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
    _T_758 = 32'h0;
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
    _T_872 = 10'h0;
  end
  if (reset) begin
    _T_873 = 10'h0;
  end
  if (reset) begin
    _T_874 = 10'h0;
  end
  if (reset) begin
    _T_875 = 10'h0;
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
    _T_2330 = 1'h0;
  end
  if (reset) begin
    _T_2335 = 1'h0;
  end
  if (reset) begin
    _T_2336 = 5'h0;
  end
  if (reset) begin
    _T_2337 = 1'h0;
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
      mpmc_b <= _T_510;
    end else begin
      mpmc_b <= _T_511;
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
      mdccmect <= _T_525;
    end else begin
      mdccmect <= _T_569;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      miccmect <= 32'h0;
    end else if (wr_miccmect_r) begin
      miccmect <= _T_525;
    end else begin
      miccmect <= _T_548;
    end
  end
  always @(posedge rvclkhdr_12_io_l1clk or posedge reset) begin
    if (reset) begin
      micect <= 32'h0;
    end else if (wr_micect_r) begin
      micect <= _T_525;
    end else begin
      micect <= _T_527;
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
      mcyclel_cout_f <= mcyclel_cout & _T_98;
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
      minstretl_cout_f <= minstretl_cout & _T_125;
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
      _T_167 <= 31'h0;
    end else begin
      _T_167 <= io_npc_r;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      pc_r_d1 <= 31'h0;
    end else begin
      pc_r_d1 <= _T_171 | _T_172;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      _T_196 <= 31'h0;
    end else begin
      _T_196 <= _T_194 | _T_192;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mcause <= 32'h0;
    end else begin
      mcause <= _T_234 | _T_230;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mscause <= 4'h0;
    end else begin
      mscause <= _T_264 | _T_263;
    end
  end
  always @(posedge io_e4e5_int_clk or posedge reset) begin
    if (reset) begin
      mtval <= 32'h0;
    end else begin
      mtval <= _T_321 | _T_317;
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
      mfdc_int <= {_T_347,_T_346};
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      mrac <= 32'h0;
    end else begin
      mrac <= {_T_484,_T_469};
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
    end else if (_T_595) begin
      if (wr_mfdhs_r) begin
        mfdhs <= io_dec_csr_wrdata_r[1:0];
      end else if (_T_589) begin
        mfdhs <= _T_593;
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      force_halt_ctr_f <= 32'h0;
    end else if (mfdht[0]) begin
      if (io_debug_halt_req_f) begin
        force_halt_ctr_f <= _T_600;
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
      _T_701 <= 16'h0;
    end else if (enter_debug_halt_req_le) begin
      _T_701 <= _T_675;
    end else if (wr_dcsr_r) begin
      _T_701 <= _T_690;
    end else begin
      _T_701 <= _T_695;
    end
  end
  always @(posedge rvclkhdr_18_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_726 <= 31'h0;
    end else begin
      _T_726 <= _T_721 | _T_720;
    end
  end
  always @(posedge rvclkhdr_19_io_l1clk or posedge reset) begin
    if (reset) begin
      dicawics <= 17'h0;
    end else begin
      dicawics <= {_T_730,io_dec_csr_wrdata_r[16:3]};
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
      _T_758 <= 32'h0;
    end else if (_T_756) begin
      if (_T_752) begin
        _T_758 <= io_dec_csr_wrdata_r;
      end else begin
        _T_758 <= {{25'd0}, io_ifu_ic_debug_rd_data[70:64]};
      end
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      icache_rd_valid_f <= 1'h0;
    end else begin
      icache_rd_valid_f <= _T_768 & _T_770;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      icache_wr_valid_f <= 1'h0;
    end else begin
      icache_wr_valid_f <= _T_663 & _T_773;
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
      _T_872 <= 10'h0;
    end else if (wr_mtdata1_t_r_0) begin
      _T_872 <= tdata_wrdata_r;
    end else begin
      _T_872 <= _T_843;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_873 <= 10'h0;
    end else if (wr_mtdata1_t_r_1) begin
      _T_873 <= tdata_wrdata_r;
    end else begin
      _T_873 <= _T_852;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_874 <= 10'h0;
    end else if (wr_mtdata1_t_r_2) begin
      _T_874 <= tdata_wrdata_r;
    end else begin
      _T_874 <= _T_861;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_875 <= 10'h0;
    end else if (wr_mtdata1_t_r_3) begin
      _T_875 <= tdata_wrdata_r;
    end else begin
      _T_875 <= _T_870;
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
      if (_T_2292) begin
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
      if (_T_2292) begin
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
      if (_T_2292) begin
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
      if (_T_2292) begin
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
      mhpmc_inc_r_d1_0 <= _T_1025 & _T_1305;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_1 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_1 <= _T_1309 & _T_1589;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_2 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_2 <= _T_1593 & _T_1873;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      mhpmc_inc_r_d1_3 <= 1'h0;
    end else begin
      mhpmc_inc_r_d1_3 <= _T_1877 & _T_2157;
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
      _T_2330 <= 1'h0;
    end else begin
      _T_2330 <= io_i0_valid_wb;
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2335 <= 1'h0;
    end else begin
      _T_2335 <= _T_2331 | _T_2333;
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2336 <= 5'h0;
    end else begin
      _T_2336 <= io_exc_cause_wb;
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_2337 <= 1'h0;
    end else begin
      _T_2337 <= io_interrupt_valid_r_d1;
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
  wire  _T_1 = ~io_dec_csr_rdaddr_d[11]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_3 = ~io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_5 = ~io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_7 = ~io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_9 = _T_1 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_10 = _T_9 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_11 = _T_10 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_15 = ~io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_17 = ~io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_19 = io_dec_csr_rdaddr_d[10] & _T_15; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_20 = _T_19 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_27 = ~io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:165]
  wire  _T_29 = _T_19 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_36 = io_dec_csr_rdaddr_d[10] & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_37 = _T_36 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_69 = _T_10 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_70 = _T_69 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_75 = _T_15 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_94 = ~io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_96 = ~io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_101 = io_dec_csr_rdaddr_d[11] & _T_15; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_102 = _T_101 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_103 = _T_102 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_104 = _T_103 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_119 = io_dec_csr_rdaddr_d[7] & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_120 = _T_119 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_121 = _T_120 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_122 = _T_121 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_123 = _T_122 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_138 = _T_15 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_139 = _T_138 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_140 = _T_139 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_141 = _T_140 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_142 = _T_141 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_145 = ~io_dec_csr_rdaddr_d[10]; // @[dec_tlu_ctl.scala 2569:129]
  wire  _T_156 = _T_145 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_157 = _T_156 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_158 = _T_157 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_159 = _T_158 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_160 = _T_159 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_172 = _T_75 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_173 = _T_172 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_182 = _T_75 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_183 = _T_182 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_191 = _T_75 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_196 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_217 = _T_1 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_218 = _T_217 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_219 = _T_218 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_220 = _T_219 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_230 = io_dec_csr_rdaddr_d[10] & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_231 = _T_230 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_232 = _T_231 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_240 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[10]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_241 = _T_240 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_258 = _T_145 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_259 = _T_258 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_260 = _T_259 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_261 = _T_260 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_268 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_269 = _T_268 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_281 = _T_268 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_291 = _T_36 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_292 = _T_291 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_299 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_300 = _T_299 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_310 = _T_300 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_311 = _T_310 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_330 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_331 = _T_330 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_332 = _T_331 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_342 = _T_231 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_381 = _T_103 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_382 = _T_381 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_397 = _T_103 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_411 = _T_15 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_412 = _T_411 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_413 = _T_412 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_414 = _T_413 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_415 = _T_414 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_426 = io_dec_csr_rdaddr_d[7] & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_427 = _T_426 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_428 = _T_427 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_429 = _T_428 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_444 = _T_119 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_445 = _T_444 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_446 = _T_445 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_447 = _T_446 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_460 = _T_427 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_461 = _T_460 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_478 = _T_446 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_490 = _T_15 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_491 = _T_490 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_492 = _T_491 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_493 = _T_492 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_505 = io_dec_csr_rdaddr_d[5] & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_506 = _T_505 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_507 = _T_506 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_508 = _T_507 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_536 = _T_507 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_553 = _T_493 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_562 = io_dec_csr_rdaddr_d[6] & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_563 = _T_562 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_564 = _T_563 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_572 = io_dec_csr_rdaddr_d[6] & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_573 = _T_572 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_574 = _T_573 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_585 = _T_563 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_593 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_594 = _T_593 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_595 = _T_594 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_614 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_615 = _T_614 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_624 = io_dec_csr_rdaddr_d[6] & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_625 = _T_624 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_626 = _T_625 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_668 = _T_196 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_669 = _T_668 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_685 = _T_196 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_693 = io_dec_csr_rdaddr_d[6] & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_694 = _T_693 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_695 = _T_694 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_703 = _T_624 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_716 = _T_1 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_717 = _T_716 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_718 = _T_717 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_719 = _T_718 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_726 = io_dec_csr_rdaddr_d[10] & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_727 = _T_726 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_737 = _T_230 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_738 = _T_737 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_748 = _T_726 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_749 = _T_748 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_787 = _T_311 | _T_553; // @[dec_tlu_ctl.scala 2637:81]
  wire  _T_799 = _T_3 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_800 = _T_799 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_801 = _T_800 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_802 = _T_801 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_803 = _T_802 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_804 = _T_787 | _T_803; // @[dec_tlu_ctl.scala 2637:121]
  wire  _T_813 = io_dec_csr_rdaddr_d[11] & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_814 = _T_813 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_815 = _T_814 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_816 = _T_815 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_817 = _T_804 | _T_816; // @[dec_tlu_ctl.scala 2637:155]
  wire  _T_828 = _T_814 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_829 = _T_828 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_830 = _T_817 | _T_829; // @[dec_tlu_ctl.scala 2638:97]
  wire  _T_841 = io_dec_csr_rdaddr_d[7] & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_842 = _T_841 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_843 = _T_842 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_844 = _T_843 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_845 = _T_844 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_869 = _T_311 | _T_70; // @[dec_tlu_ctl.scala 2639:81]
  wire  _T_879 = _T_869 | _T_183; // @[dec_tlu_ctl.scala 2639:121]
  wire  _T_889 = _T_879 | _T_342; // @[dec_tlu_ctl.scala 2639:162]
  wire  _T_904 = _T_1 & _T_15; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_905 = _T_904 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_906 = _T_905 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_907 = _T_906 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_908 = _T_907 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_909 = _T_908 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_910 = _T_889 | _T_909; // @[dec_tlu_ctl.scala 2640:105]
  wire  _T_922 = _T_217 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_923 = _T_922 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_924 = _T_923 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_925 = _T_924 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_926 = _T_910 | _T_925; // @[dec_tlu_ctl.scala 2640:145]
  wire  _T_937 = _T_231 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_938 = _T_937 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_955 = _T_1 & io_dec_csr_rdaddr_d[10]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_956 = _T_955 & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_957 = _T_956 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_958 = _T_957 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_959 = _T_958 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_960 = _T_959 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_961 = _T_960 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_962 = _T_961 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_963 = _T_962 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_964 = _T_963 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_983 = _T_1 & _T_145; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_984 = _T_983 & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_985 = _T_984 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_986 = _T_985 & _T_15; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_987 = _T_986 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_988 = _T_987 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_989 = _T_988 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_990 = _T_989 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_991 = _T_990 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_992 = _T_964 | _T_991; // @[dec_tlu_ctl.scala 2642:81]
  wire  _T_1013 = _T_987 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1014 = _T_1013 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1015 = _T_1014 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1016 = _T_992 | _T_1015; // @[dec_tlu_ctl.scala 2642:129]
  wire  _T_1032 = io_dec_csr_rdaddr_d[11] & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1033 = _T_1032 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1034 = _T_1033 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1035 = _T_1034 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1036 = _T_1035 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1037 = _T_1036 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1038 = _T_1037 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1039 = _T_1038 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1040 = _T_1039 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1041 = _T_1016 | _T_1040; // @[dec_tlu_ctl.scala 2643:105]
  wire  _T_1053 = io_dec_csr_rdaddr_d[11] & _T_145; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1054 = _T_1053 & io_dec_csr_rdaddr_d[9]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1055 = _T_1054 & io_dec_csr_rdaddr_d[8]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1056 = _T_1055 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1057 = _T_1056 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1058 = _T_1057 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1059 = _T_1041 | _T_1058; // @[dec_tlu_ctl.scala 2643:153]
  wire  _T_1078 = _T_959 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1079 = _T_1078 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1080 = _T_1079 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1081 = _T_1080 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1082 = _T_1081 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1083 = _T_1082 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1084 = _T_1059 | _T_1083; // @[dec_tlu_ctl.scala 2644:105]
  wire  _T_1105 = _T_1079 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1106 = _T_1105 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1107 = _T_1084 | _T_1106; // @[dec_tlu_ctl.scala 2644:153]
  wire  _T_1125 = _T_1033 & _T_15; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1126 = _T_1125 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1127 = _T_1126 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1128 = _T_1127 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1129 = _T_1128 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1130 = _T_1129 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1131 = _T_1130 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1132 = _T_1107 | _T_1131; // @[dec_tlu_ctl.scala 2645:105]
  wire  _T_1152 = _T_958 & _T_3; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1153 = _T_1152 & io_dec_csr_rdaddr_d[5]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1154 = _T_1153 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1155 = _T_1154 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1156 = _T_1155 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1157 = _T_1132 | _T_1156; // @[dec_tlu_ctl.scala 2645:161]
  wire  _T_1176 = _T_1013 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1177 = _T_1157 | _T_1176; // @[dec_tlu_ctl.scala 2646:105]
  wire  _T_1202 = _T_1129 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1203 = _T_1202 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1204 = _T_1203 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1205 = _T_1177 | _T_1204; // @[dec_tlu_ctl.scala 2646:161]
  wire  _T_1224 = _T_959 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1225 = _T_1224 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1226 = _T_1225 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1227 = _T_1226 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1228 = _T_1205 | _T_1227; // @[dec_tlu_ctl.scala 2647:97]
  wire  _T_1248 = _T_1224 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1249 = _T_1248 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1250 = _T_1249 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1251 = _T_1228 | _T_1250; // @[dec_tlu_ctl.scala 2647:153]
  wire  _T_1275 = _T_1130 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1276 = _T_1251 | _T_1275; // @[dec_tlu_ctl.scala 2648:105]
  wire  _T_1296 = _T_1013 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1297 = _T_1296 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1298 = _T_1276 | _T_1297; // @[dec_tlu_ctl.scala 2648:161]
  wire  _T_1315 = _T_1055 & io_dec_csr_rdaddr_d[7]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1316 = _T_1315 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1317 = _T_1316 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1318 = _T_1317 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1319 = _T_1318 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1320 = _T_1298 | _T_1319; // @[dec_tlu_ctl.scala 2649:105]
  wire  _T_1343 = _T_1318 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1344 = _T_1343 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1345 = _T_1320 | _T_1344; // @[dec_tlu_ctl.scala 2649:161]
  wire  _T_1361 = _T_1057 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1362 = _T_1345 | _T_1361; // @[dec_tlu_ctl.scala 2650:105]
  wire  _T_1384 = _T_1249 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1385 = _T_1362 | _T_1384; // @[dec_tlu_ctl.scala 2650:161]
  wire  _T_1406 = _T_1225 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1407 = _T_1385 | _T_1406; // @[dec_tlu_ctl.scala 2651:105]
  wire  _T_1430 = _T_1226 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1431 = _T_1407 | _T_1430; // @[dec_tlu_ctl.scala 2651:161]
  wire  _T_1455 = _T_1153 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1456 = _T_1455 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1457 = _T_1456 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1458 = _T_1457 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1459 = _T_1431 | _T_1458; // @[dec_tlu_ctl.scala 2652:105]
  wire  _T_1475 = _T_1057 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1476 = _T_1459 | _T_1475; // @[dec_tlu_ctl.scala 2652:153]
  wire  _T_1498 = _T_986 & io_dec_csr_rdaddr_d[6]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1499 = _T_1498 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1500 = _T_1499 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1501 = _T_1500 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1502 = _T_1501 & _T_7; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1503 = _T_1476 | _T_1502; // @[dec_tlu_ctl.scala 2653:113]
  wire  _T_1526 = _T_986 & _T_5; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1527 = _T_1526 & _T_94; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1528 = _T_1527 & _T_96; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1529 = _T_1528 & _T_17; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1530 = _T_1529 & _T_27; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1531 = _T_1503 | _T_1530; // @[dec_tlu_ctl.scala 2653:161]
  wire  _T_1550 = _T_1013 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1551 = _T_1531 | _T_1550; // @[dec_tlu_ctl.scala 2654:97]
  wire  _T_1567 = _T_1057 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1568 = _T_1551 | _T_1567; // @[dec_tlu_ctl.scala 2654:153]
  wire  _T_1587 = _T_1013 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  wire  _T_1588 = _T_1568 | _T_1587; // @[dec_tlu_ctl.scala 2655:113]
  wire  _T_1604 = _T_1057 & io_dec_csr_rdaddr_d[4]; // @[dec_tlu_ctl.scala 2569:198]
  assign io_csr_pkt_csr_misa = _T_11 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2571:57]
  assign io_csr_pkt_csr_mvendorid = _T_20 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2572:57]
  assign io_csr_pkt_csr_marchid = _T_29 & _T_27; // @[dec_tlu_ctl.scala 2573:57]
  assign io_csr_pkt_csr_mimpid = _T_37 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2574:57]
  assign io_csr_pkt_csr_mhartid = _T_19 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2575:57]
  assign io_csr_pkt_csr_mstatus = _T_11 & _T_27; // @[dec_tlu_ctl.scala 2576:57]
  assign io_csr_pkt_csr_mtvec = _T_69 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2577:57]
  assign io_csr_pkt_csr_mip = _T_75 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2578:65]
  assign io_csr_pkt_csr_mie = _T_69 & _T_27; // @[dec_tlu_ctl.scala 2579:65]
  assign io_csr_pkt_csr_mcyclel = _T_104 & _T_17; // @[dec_tlu_ctl.scala 2580:57]
  assign io_csr_pkt_csr_mcycleh = _T_123 & _T_17; // @[dec_tlu_ctl.scala 2581:57]
  assign io_csr_pkt_csr_minstretl = _T_142 & _T_27; // @[dec_tlu_ctl.scala 2582:57]
  assign io_csr_pkt_csr_minstreth = _T_160 & _T_27; // @[dec_tlu_ctl.scala 2583:57]
  assign io_csr_pkt_csr_mscratch = _T_173 & _T_27; // @[dec_tlu_ctl.scala 2584:57]
  assign io_csr_pkt_csr_mepc = _T_182 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2585:57]
  assign io_csr_pkt_csr_mcause = _T_191 & _T_27; // @[dec_tlu_ctl.scala 2586:57]
  assign io_csr_pkt_csr_mscause = _T_196 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2587:57]
  assign io_csr_pkt_csr_mtval = _T_191 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2588:57]
  assign io_csr_pkt_csr_mrac = _T_220 & _T_17; // @[dec_tlu_ctl.scala 2589:57]
  assign io_csr_pkt_csr_dmst = _T_232 & _T_17; // @[dec_tlu_ctl.scala 2590:57]
  assign io_csr_pkt_csr_mdseac = _T_241 & _T_96; // @[dec_tlu_ctl.scala 2591:57]
  assign io_csr_pkt_csr_meihap = _T_240 & io_dec_csr_rdaddr_d[3]; // @[dec_tlu_ctl.scala 2592:57]
  assign io_csr_pkt_csr_meivt = _T_261 & _T_27; // @[dec_tlu_ctl.scala 2593:57]
  assign io_csr_pkt_csr_meipt = _T_269 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2594:57]
  assign io_csr_pkt_csr_meicurpl = _T_268 & io_dec_csr_rdaddr_d[2]; // @[dec_tlu_ctl.scala 2595:57]
  assign io_csr_pkt_csr_meicidpl = _T_281 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2596:57]
  assign io_csr_pkt_csr_dcsr = _T_292 & _T_27; // @[dec_tlu_ctl.scala 2597:57]
  assign io_csr_pkt_csr_mcgc = _T_300 & _T_27; // @[dec_tlu_ctl.scala 2598:57]
  assign io_csr_pkt_csr_mfdc = _T_310 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2599:57]
  assign io_csr_pkt_csr_dpc = _T_292 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2600:65]
  assign io_csr_pkt_csr_mtsel = _T_332 & _T_27; // @[dec_tlu_ctl.scala 2601:57]
  assign io_csr_pkt_csr_mtdata1 = _T_231 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2602:57]
  assign io_csr_pkt_csr_mtdata2 = _T_331 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2603:57]
  assign io_csr_pkt_csr_mhpmc3 = _T_104 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2604:57]
  assign io_csr_pkt_csr_mhpmc4 = _T_382 & _T_27; // @[dec_tlu_ctl.scala 2605:57]
  assign io_csr_pkt_csr_mhpmc5 = _T_397 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2606:57]
  assign io_csr_pkt_csr_mhpmc6 = _T_415 & _T_27; // @[dec_tlu_ctl.scala 2607:57]
  assign io_csr_pkt_csr_mhpmc3h = _T_429 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2608:57]
  assign io_csr_pkt_csr_mhpmc4h = _T_447 & _T_27; // @[dec_tlu_ctl.scala 2609:57]
  assign io_csr_pkt_csr_mhpmc5h = _T_461 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2610:57]
  assign io_csr_pkt_csr_mhpmc6h = _T_478 & _T_27; // @[dec_tlu_ctl.scala 2611:57]
  assign io_csr_pkt_csr_mhpme3 = _T_493 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2612:57]
  assign io_csr_pkt_csr_mhpme4 = _T_508 & _T_27; // @[dec_tlu_ctl.scala 2613:57]
  assign io_csr_pkt_csr_mhpme5 = _T_508 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2614:57]
  assign io_csr_pkt_csr_mhpme6 = _T_536 & _T_27; // @[dec_tlu_ctl.scala 2615:57]
  assign io_csr_pkt_csr_mcountinhibit = _T_493 & _T_27; // @[dec_tlu_ctl.scala 2616:49]
  assign io_csr_pkt_csr_mitctl0 = _T_564 & _T_27; // @[dec_tlu_ctl.scala 2617:57]
  assign io_csr_pkt_csr_mitctl1 = _T_574 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2618:57]
  assign io_csr_pkt_csr_mitb0 = _T_585 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2619:57]
  assign io_csr_pkt_csr_mitb1 = _T_595 & _T_27; // @[dec_tlu_ctl.scala 2620:57]
  assign io_csr_pkt_csr_mitcnt0 = _T_585 & _T_27; // @[dec_tlu_ctl.scala 2621:57]
  assign io_csr_pkt_csr_mitcnt1 = _T_615 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2622:57]
  assign io_csr_pkt_csr_mpmc = _T_626 & io_dec_csr_rdaddr_d[1]; // @[dec_tlu_ctl.scala 2623:57]
  assign io_csr_pkt_csr_meicpct = _T_281 & _T_27; // @[dec_tlu_ctl.scala 2625:57]
  assign io_csr_pkt_csr_micect = _T_669 & _T_27; // @[dec_tlu_ctl.scala 2627:57]
  assign io_csr_pkt_csr_miccmect = _T_668 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2628:57]
  assign io_csr_pkt_csr_mdccmect = _T_685 & _T_27; // @[dec_tlu_ctl.scala 2629:57]
  assign io_csr_pkt_csr_mfdht = _T_695 & _T_27; // @[dec_tlu_ctl.scala 2630:57]
  assign io_csr_pkt_csr_mfdhs = _T_703 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2631:57]
  assign io_csr_pkt_csr_dicawics = _T_719 & _T_27; // @[dec_tlu_ctl.scala 2632:57]
  assign io_csr_pkt_csr_dicad0h = _T_727 & _T_17; // @[dec_tlu_ctl.scala 2633:57]
  assign io_csr_pkt_csr_dicad0 = _T_738 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2634:57]
  assign io_csr_pkt_csr_dicad1 = _T_749 & _T_27; // @[dec_tlu_ctl.scala 2635:57]
  assign io_csr_pkt_csr_dicago = _T_749 & io_dec_csr_rdaddr_d[0]; // @[dec_tlu_ctl.scala 2636:57]
  assign io_csr_pkt_presync = _T_830 | _T_845; // @[dec_tlu_ctl.scala 2637:34]
  assign io_csr_pkt_postsync = _T_926 | _T_938; // @[dec_tlu_ctl.scala 2639:30]
  assign io_csr_pkt_legal = _T_1588 | _T_1604; // @[dec_tlu_ctl.scala 2642:26]
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
  input         io_active_clk,
  input         io_free_clk,
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
  input         io_exu_i0_br_way_r,
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
  output        io_dec_tlu_misc_clk_override,
  output        io_dec_tlu_dec_clk_override,
  output        io_dec_tlu_ifu_clk_override,
  output        io_dec_tlu_lsu_clk_override,
  output        io_dec_tlu_bus_clk_override,
  output        io_dec_tlu_pic_clk_override,
  output        io_dec_tlu_dccm_clk_override,
  output        io_dec_tlu_icm_clk_override,
  input         io_ifu_pmu_instr_aligned,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_valid,
  output [1:0]  io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_way,
  output        io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle,
  output        io_tlu_bp_dec_tlu_flush_lower_wb,
  output        io_tlu_bp_dec_tlu_flush_leak_one_wb,
  output        io_tlu_bp_dec_tlu_bpred_disable,
  output        io_tlu_ifc_dec_tlu_flush_noredir_wb,
  output [31:0] io_tlu_ifc_dec_tlu_mrac_ff,
  input         io_tlu_ifc_ifu_pmu_fetch_stall,
  output        io_tlu_mem_dec_tlu_flush_lower_wb,
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
  wire  int_timers_clock; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_reset; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_free_clk; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_scan_mode; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 274:30]
  wire [11:0] int_timers_io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 274:30]
  wire [31:0] int_timers_io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_csr_mitctl0; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_csr_mitctl1; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_csr_mitb0; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_csr_mitb1; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_csr_mitcnt0; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_csr_mitcnt1; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_dec_pause_state; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_internal_dbg_halt_timers; // @[dec_tlu_ctl.scala 274:30]
  wire [31:0] int_timers_io_dec_timer_rddata_d; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_dec_timer_read_d; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_dec_timer_t0_pulse; // @[dec_tlu_ctl.scala 274:30]
  wire  int_timers_io_dec_timer_t1_pulse; // @[dec_tlu_ctl.scala 274:30]
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
  wire  csr_clock; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_reset; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_free_clk; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_active_clk; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_scan_mode; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 817:15]
  wire [11:0] csr_io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 817:15]
  wire [11:0] csr_io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_i0_decode_d; // @[dec_tlu_ctl.scala 817:15]
  wire [70:0] csr_io_dec_tlu_ic_diag_pkt_icache_wrdata; // @[dec_tlu_ctl.scala 817:15]
  wire [16:0] csr_io_dec_tlu_ic_diag_pkt_icache_dicawics; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_0_select; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_0_match_pkt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_0_store; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_0_load; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_0_execute; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_0_m; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_trigger_pkt_any_0_tdata2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_1_select; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_1_match_pkt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_1_store; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_1_load; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_1_execute; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_1_m; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_trigger_pkt_any_1_tdata2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_2_select; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_2_match_pkt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_2_store; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_2_load; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_2_execute; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_2_m; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_trigger_pkt_any_2_tdata2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_3_select; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_3_match_pkt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_3_store; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_3_load; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_3_execute; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_pkt_any_3_m; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_trigger_pkt_any_3_tdata2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dma_iccm_stall_any; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dma_dccm_stall_any; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_store_stall_any; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_pmu_presync_stall; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_pmu_postsync_stall; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_pmu_decode_stall; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_fetch_stall; // @[dec_tlu_ctl.scala 817:15]
  wire [1:0] csr_io_dec_tlu_packet_r_icaf_type; // @[dec_tlu_ctl.scala 817:15]
  wire [3:0] csr_io_dec_tlu_packet_r_pmu_i0_itype; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_packet_r_pmu_divide; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_exu_pmu_i0_br_misp; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_pmu_instr_decoded; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_instr_aligned; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_ic_miss; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_ic_hit; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_int_valid_wb1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_i0_exc_valid_wb1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_i0_valid_wb1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_csr_wen_r; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_dec_tlu_mtval_wb1; // @[dec_tlu_ctl.scala 817:15]
  wire [4:0] csr_io_dec_tlu_exc_cause_wb1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_perfcnt0; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_perfcnt1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_perfcnt2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_perfcnt3; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dma_pmu_dccm_write; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dma_pmu_dccm_read; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dma_pmu_any_write; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dma_pmu_any_read; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_pmu_bus_busy; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_dec_tlu_i0_pc_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_misc_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_dec_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_ifu_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_lsu_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_bus_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_pic_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_dccm_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_icm_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_dec_csr_rddata_d; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_pipelining_disable; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_wr_pause_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_bus_busy; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_pmu_bus_error; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_pmu_bus_error; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_pmu_bus_misaligned; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 817:15]
  wire [70:0] csr_io_ifu_ic_debug_rd_data; // @[dec_tlu_ctl.scala 817:15]
  wire [3:0] csr_io_dec_tlu_meipt; // @[dec_tlu_ctl.scala 817:15]
  wire [3:0] csr_io_pic_pl; // @[dec_tlu_ctl.scala 817:15]
  wire [3:0] csr_io_dec_tlu_meicurpl; // @[dec_tlu_ctl.scala 817:15]
  wire [29:0] csr_io_dec_tlu_meihap; // @[dec_tlu_ctl.scala 817:15]
  wire [7:0] csr_io_pic_claimid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_lsu_imprecise_error_addr_any; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_dec_tlu_mrac_ff; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_wb_coalescing_disable; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_bpred_disable; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_sideeffect_posted_disable; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_core_ecc_disable; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_external_ldfwd_disable; // @[dec_tlu_ctl.scala 817:15]
  wire [2:0] csr_io_dec_tlu_dma_qos_prty; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_dec_illegal_inst; // @[dec_tlu_ctl.scala 817:15]
  wire [3:0] csr_io_lsu_error_pkt_r_bits_mscause; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mexintpend; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_exu_npc_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_rst_vec; // @[dec_tlu_ctl.scala 817:15]
  wire [27:0] csr_io_core_id; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_dec_timer_rddata_d; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_timer_read_d; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_rfpc_i0_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_i0_trigger_hit_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_fw_halt_req; // @[dec_tlu_ctl.scala 817:15]
  wire [1:0] csr_io_mstatus; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_exc_or_int_valid_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mret_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mstatus_mie_ns; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 817:15]
  wire [15:0] csr_io_dcsr; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_mtvec; // @[dec_tlu_ctl.scala 817:15]
  wire [5:0] csr_io_mip; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_timer_t0_pulse; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_timer_t1_pulse; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_timer_int_sync; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_soft_int_sync; // @[dec_tlu_ctl.scala 817:15]
  wire [5:0] csr_io_mie_ns; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_wr_clk; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_pmu_fw_halted; // @[dec_tlu_ctl.scala 817:15]
  wire [1:0] csr_io_lsu_fir_error; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_npc_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_tlu_flush_path_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_npc_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_reset_delayed; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_mepc; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_interrupt_valid_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_i0_exception_valid_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_exc_valid_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_e4e5_int_clk; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_i0_exc_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_inst_acc_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_inst_acc_second_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_take_nmi; // @[dec_tlu_ctl.scala 817:15]
  wire [31:0] csr_io_lsu_error_pkt_addr_r; // @[dec_tlu_ctl.scala 817:15]
  wire [4:0] csr_io_exc_cause_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_i0_valid_wb; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_clk_override; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_i0_exception_valid_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_i0_exc_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire [4:0] csr_io_exc_cause_wb; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_nmi_lsu_store_type; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_nmi_lsu_load_type; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_tlu_i0_commit_cmt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ebreak_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ecall_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_illegal_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mdseac_locked_ns; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_mdseac_locked_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_nmi_int_detected_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ext_int_freeze_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ic_perr_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_iccm_sbecc_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_single_ecc_error_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_idle_any_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dbg_tlu_halted; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_debug_halt_req_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_force_halt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_take_ext_int_start; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_trigger_hit_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_debug_halt_req; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_allow_dbg_halt_csr_write; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_internal_dbg_halt_mode_f; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_enter_debug_halt_req; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_request_debug_mode_done; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_request_debug_mode_r; // @[dec_tlu_ctl.scala 817:15]
  wire [30:0] csr_io_dpc; // @[dec_tlu_ctl.scala 817:15]
  wire [3:0] csr_io_update_hit_bit_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_take_timer_int; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_take_int_timer0_int; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_take_int_timer1_int; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_take_ext_int; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_br0_error_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_dec_tlu_br0_start_error_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_misa; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mstatus; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mtvec; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mip; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mie; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mcyclel; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mcycleh; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_minstretl; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_minstreth; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mscratch; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mepc; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mcause; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mscause; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mtval; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mrac; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_meivt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_meipt; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_meicurpl; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_meicidpl; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mcgc; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mfdc; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mtsel; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mtdata1; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mtdata2; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc3; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc4; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc5; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc6; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc3h; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc4h; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc5h; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpmc6h; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpme3; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpme4; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpme5; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mhpme6; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mcountinhibit; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mpmc; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_micect; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_miccmect; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mdccmect; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mfdht; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_mfdhs; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 817:15]
  wire  csr_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 817:15]
  wire [9:0] csr_io_mtdata1_t_0; // @[dec_tlu_ctl.scala 817:15]
  wire [9:0] csr_io_mtdata1_t_1; // @[dec_tlu_ctl.scala 817:15]
  wire [9:0] csr_io_mtdata1_t_2; // @[dec_tlu_ctl.scala 817:15]
  wire [9:0] csr_io_mtdata1_t_3; // @[dec_tlu_ctl.scala 817:15]
  wire [11:0] csr_read_io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_misa; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mstatus; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mtvec; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mip; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mie; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mcyclel; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mcycleh; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_minstretl; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_minstreth; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mscratch; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mepc; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mcause; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mscause; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mtval; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mrac; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dmst; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_meivt; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_meipt; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_meicurpl; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_meicidpl; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mcgc; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mfdc; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mtsel; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mtdata1; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mtdata2; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc3; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc4; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc5; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc6; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc3h; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc4h; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc5h; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpmc6h; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpme3; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpme4; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpme5; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mhpme6; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mcountinhibit; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mitctl0; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mitctl1; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mitb0; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mitb1; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mitcnt0; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mitcnt1; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mpmc; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_meicpct; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_micect; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_miccmect; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mdccmect; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mfdht; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_mfdhs; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_csr_dicago; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_presync; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_postsync; // @[dec_tlu_ctl.scala 1010:22]
  wire  csr_read_io_csr_pkt_legal; // @[dec_tlu_ctl.scala 1010:22]
  reg  dbg_halt_state_f; // @[dec_tlu_ctl.scala 366:89]
  wire  _T = ~dbg_halt_state_f; // @[dec_tlu_ctl.scala 273:39]
  reg  mpc_halt_state_f; // @[dec_tlu_ctl.scala 361:89]
  wire [2:0] _T_3 = {io_i_cpu_run_req,io_mpc_debug_halt_req,io_mpc_debug_run_req}; // @[Cat.scala 29:58]
  wire [3:0] _T_6 = {io_nmi_int,io_timer_int,io_soft_int,io_i_cpu_halt_req}; // @[Cat.scala 29:58]
  reg [6:0] _T_8; // @[el2_lib.scala 177:81]
  reg [6:0] syncro_ff; // @[el2_lib.scala 177:58]
  wire  nmi_int_sync = syncro_ff[6]; // @[dec_tlu_ctl.scala 301:67]
  wire  i_cpu_halt_req_sync = syncro_ff[3]; // @[dec_tlu_ctl.scala 304:59]
  wire  i_cpu_run_req_sync = syncro_ff[2]; // @[dec_tlu_ctl.scala 305:59]
  wire  mpc_debug_halt_req_sync_raw = syncro_ff[1]; // @[dec_tlu_ctl.scala 306:51]
  wire  mpc_debug_run_req_sync = syncro_ff[0]; // @[dec_tlu_ctl.scala 307:51]
  wire  dec_csr_wen_r_mod = csr_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 1003:31]
  reg  lsu_exc_valid_r_d1; // @[dec_tlu_ctl.scala 612:74]
  wire  _T_11 = io_lsu_error_pkt_r_valid | lsu_exc_valid_r_d1; // @[dec_tlu_ctl.scala 311:67]
  reg  e5_valid; // @[dec_tlu_ctl.scala 323:97]
  wire  e4e5_valid = io_dec_tlu_i0_valid_r | e5_valid; // @[dec_tlu_ctl.scala 314:30]
  reg  debug_mode_status; // @[dec_tlu_ctl.scala 324:81]
  reg  i_cpu_run_req_d1_raw; // @[dec_tlu_ctl.scala 572:80]
  reg  nmi_int_delayed; // @[dec_tlu_ctl.scala 339:72]
  wire  _T_37 = ~nmi_int_delayed; // @[dec_tlu_ctl.scala 348:45]
  wire  _T_38 = nmi_int_sync & _T_37; // @[dec_tlu_ctl.scala 348:43]
  reg  mdseac_locked_f; // @[dec_tlu_ctl.scala 605:89]
  wire  _T_35 = ~mdseac_locked_f; // @[dec_tlu_ctl.scala 346:32]
  wire  _T_36 = io_tlu_busbuff_lsu_imprecise_error_load_any | io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 346:96]
  wire  nmi_lsu_detected = _T_35 & _T_36; // @[dec_tlu_ctl.scala 346:49]
  wire  _T_39 = _T_38 | nmi_lsu_detected; // @[dec_tlu_ctl.scala 348:63]
  reg  nmi_int_detected_f; // @[dec_tlu_ctl.scala 340:72]
  reg  take_nmi_r_d1; // @[dec_tlu_ctl.scala 814:98]
  wire  _T_40 = ~take_nmi_r_d1; // @[dec_tlu_ctl.scala 348:106]
  wire  _T_41 = nmi_int_detected_f & _T_40; // @[dec_tlu_ctl.scala 348:104]
  wire  _T_42 = _T_39 | _T_41; // @[dec_tlu_ctl.scala 348:82]
  reg  take_ext_int_start_d3; // @[dec_tlu_ctl.scala 745:62]
  wire  _T_43 = |io_lsu_fir_error; // @[dec_tlu_ctl.scala 348:165]
  wire  _T_44 = take_ext_int_start_d3 & _T_43; // @[dec_tlu_ctl.scala 348:146]
  wire  nmi_int_detected = _T_42 | _T_44; // @[dec_tlu_ctl.scala 348:122]
  wire  _T_631 = ~io_dec_csr_stall_int_ff; // @[dec_tlu_ctl.scala 722:23]
  wire  mstatus_mie_ns = csr_io_mstatus_mie_ns; // @[dec_tlu_ctl.scala 1002:31]
  wire  _T_632 = _T_631 & mstatus_mie_ns; // @[dec_tlu_ctl.scala 722:48]
  wire [5:0] mip = csr_io_mip; // @[dec_tlu_ctl.scala 1008:31]
  wire  _T_634 = _T_632 & mip[1]; // @[dec_tlu_ctl.scala 722:65]
  wire [5:0] mie_ns = csr_io_mie_ns; // @[dec_tlu_ctl.scala 997:31]
  wire  timer_int_ready = _T_634 & mie_ns[1]; // @[dec_tlu_ctl.scala 722:83]
  wire  _T_391 = nmi_int_detected | timer_int_ready; // @[dec_tlu_ctl.scala 599:66]
  wire  _T_628 = _T_632 & mip[0]; // @[dec_tlu_ctl.scala 721:65]
  wire  soft_int_ready = _T_628 & mie_ns[0]; // @[dec_tlu_ctl.scala 721:83]
  wire  _T_392 = _T_391 | soft_int_ready; // @[dec_tlu_ctl.scala 599:84]
  reg  int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 579:73]
  wire  _T_393 = _T_392 | int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 599:101]
  reg  int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 580:73]
  wire  _T_394 = _T_393 | int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 599:125]
  wire  _T_608 = _T_632 & mip[2]; // @[dec_tlu_ctl.scala 718:66]
  wire  mhwakeup_ready = _T_608 & mie_ns[2]; // @[dec_tlu_ctl.scala 718:84]
  wire  _T_395 = io_dec_pic_mhwakeup & mhwakeup_ready; // @[dec_tlu_ctl.scala 599:172]
  wire  _T_396 = _T_394 | _T_395; // @[dec_tlu_ctl.scala 599:149]
  wire  _T_397 = _T_396 & io_o_cpu_halt_status; // @[dec_tlu_ctl.scala 599:191]
  reg  i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 571:80]
  wire  _T_398 = ~i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 599:216]
  wire  _T_399 = _T_397 & _T_398; // @[dec_tlu_ctl.scala 599:214]
  wire  i_cpu_run_req_d1 = i_cpu_run_req_d1_raw | _T_399; // @[dec_tlu_ctl.scala 599:45]
  wire  _T_14 = debug_mode_status | i_cpu_run_req_d1; // @[dec_tlu_ctl.scala 315:50]
  wire  _T_685 = ~_T_43; // @[dec_tlu_ctl.scala 750:49]
  wire  take_ext_int = take_ext_int_start_d3 & _T_685; // @[dec_tlu_ctl.scala 750:47]
  wire  _T_698 = ~soft_int_ready; // @[dec_tlu_ctl.scala 767:40]
  wire  _T_699 = timer_int_ready & _T_698; // @[dec_tlu_ctl.scala 767:38]
  wire  _T_617 = ~io_lsu_fastint_stall_any; // @[dec_tlu_ctl.scala 719:104]
  wire  ext_int_ready = mhwakeup_ready & _T_617; // @[dec_tlu_ctl.scala 719:102]
  wire  _T_700 = ~ext_int_ready; // @[dec_tlu_ctl.scala 767:58]
  wire  _T_701 = _T_699 & _T_700; // @[dec_tlu_ctl.scala 767:56]
  wire  _T_622 = _T_632 & mip[5]; // @[dec_tlu_ctl.scala 720:65]
  wire  ce_int_ready = _T_622 & mie_ns[5]; // @[dec_tlu_ctl.scala 720:83]
  wire  _T_702 = ~ce_int_ready; // @[dec_tlu_ctl.scala 767:75]
  wire  _T_703 = _T_701 & _T_702; // @[dec_tlu_ctl.scala 767:73]
  wire  _T_152 = ~debug_mode_status; // @[dec_tlu_ctl.scala 422:37]
  reg  dbg_halt_req_held; // @[dec_tlu_ctl.scala 465:81]
  wire  _T_106 = io_dbg_halt_req | dbg_halt_req_held; // @[dec_tlu_ctl.scala 399:48]
  reg  ext_int_freeze_d1; // @[dec_tlu_ctl.scala 746:66]
  wire  _T_107 = ~ext_int_freeze_d1; // @[dec_tlu_ctl.scala 399:71]
  wire  dbg_halt_req_final = _T_106 & _T_107; // @[dec_tlu_ctl.scala 399:69]
  wire  mpc_debug_halt_req_sync = mpc_debug_halt_req_sync_raw & _T_107; // @[dec_tlu_ctl.scala 358:67]
  wire  _T_109 = dbg_halt_req_final | mpc_debug_halt_req_sync; // @[dec_tlu_ctl.scala 402:50]
  reg  reset_detect; // @[dec_tlu_ctl.scala 335:88]
  reg  reset_detected; // @[dec_tlu_ctl.scala 336:88]
  wire  reset_delayed = reset_detect ^ reset_detected; // @[dec_tlu_ctl.scala 337:64]
  wire  _T_110 = ~io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 402:95]
  wire  _T_111 = reset_delayed & _T_110; // @[dec_tlu_ctl.scala 402:93]
  wire  _T_112 = _T_109 | _T_111; // @[dec_tlu_ctl.scala 402:76]
  wire  _T_114 = _T_112 & _T_152; // @[dec_tlu_ctl.scala 402:119]
  wire  debug_halt_req = _T_114 & _T_107; // @[dec_tlu_ctl.scala 402:147]
  wire  _T_153 = _T_152 & debug_halt_req; // @[dec_tlu_ctl.scala 422:63]
  reg  dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 457:81]
  wire  _T_154 = _T_153 | dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 422:81]
  reg  trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 456:81]
  wire  _T_155 = _T_154 | trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 422:107]
  reg  ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 671:64]
  wire  enter_debug_halt_req = _T_155 | ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 422:132]
  reg  debug_halt_req_f; // @[dec_tlu_ctl.scala 454:89]
  wire  force_halt = csr_io_force_halt; // @[dec_tlu_ctl.scala 1000:31]
  reg  lsu_idle_any_f; // @[dec_tlu_ctl.scala 450:89]
  wire  _T_142 = io_lsu_idle_any & lsu_idle_any_f; // @[dec_tlu_ctl.scala 416:53]
  wire  _T_143 = _T_142 & io_tlu_mem_ifu_miss_state_idle; // @[dec_tlu_ctl.scala 416:70]
  reg  ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 451:81]
  wire  _T_144 = _T_143 & ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 416:103]
  wire  _T_145 = ~debug_halt_req; // @[dec_tlu_ctl.scala 416:129]
  wire  _T_146 = _T_144 & _T_145; // @[dec_tlu_ctl.scala 416:127]
  reg  debug_halt_req_d1; // @[dec_tlu_ctl.scala 458:89]
  wire  _T_147 = ~debug_halt_req_d1; // @[dec_tlu_ctl.scala 416:147]
  wire  _T_148 = _T_146 & _T_147; // @[dec_tlu_ctl.scala 416:145]
  wire  _T_149 = ~io_dec_div_active; // @[dec_tlu_ctl.scala 416:168]
  wire  _T_150 = _T_148 & _T_149; // @[dec_tlu_ctl.scala 416:166]
  wire  core_empty = force_halt | _T_150; // @[dec_tlu_ctl.scala 416:34]
  wire  _T_163 = debug_halt_req_f & core_empty; // @[dec_tlu_ctl.scala 432:48]
  reg  dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 448:81]
  reg  dec_tlu_flush_pause_r_d1; // @[dec_tlu_ctl.scala 464:73]
  wire  _T_132 = ~dec_tlu_flush_pause_r_d1; // @[dec_tlu_ctl.scala 412:56]
  wire  _T_133 = dec_tlu_flush_noredir_r_d1 & _T_132; // @[dec_tlu_ctl.scala 412:54]
  reg  take_ext_int_start_d1; // @[dec_tlu_ctl.scala 743:62]
  wire  _T_134 = ~take_ext_int_start_d1; // @[dec_tlu_ctl.scala 412:84]
  wire  _T_135 = _T_133 & _T_134; // @[dec_tlu_ctl.scala 412:82]
  reg  halt_taken_f; // @[dec_tlu_ctl.scala 449:89]
  reg  dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 452:89]
  wire  _T_136 = ~dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 412:126]
  wire  _T_137 = halt_taken_f & _T_136; // @[dec_tlu_ctl.scala 412:124]
  reg  pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 578:73]
  wire  _T_138 = ~pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 412:146]
  wire  _T_139 = _T_137 & _T_138; // @[dec_tlu_ctl.scala 412:144]
  reg  interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 808:90]
  wire  _T_140 = ~interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 412:169]
  wire  _T_141 = _T_139 & _T_140; // @[dec_tlu_ctl.scala 412:167]
  wire  halt_taken = _T_135 | _T_141; // @[dec_tlu_ctl.scala 412:108]
  wire  _T_164 = _T_163 & halt_taken; // @[dec_tlu_ctl.scala 432:61]
  reg  debug_resume_req_f; // @[dec_tlu_ctl.scala 455:89]
  wire  _T_165 = ~debug_resume_req_f; // @[dec_tlu_ctl.scala 432:97]
  wire  _T_166 = dbg_tlu_halted_f & _T_165; // @[dec_tlu_ctl.scala 432:95]
  wire  dbg_tlu_halted = _T_164 | _T_166; // @[dec_tlu_ctl.scala 432:75]
  wire  _T_167 = ~dbg_tlu_halted; // @[dec_tlu_ctl.scala 433:73]
  wire  _T_168 = debug_halt_req_f & _T_167; // @[dec_tlu_ctl.scala 433:71]
  wire  debug_halt_req_ns = enter_debug_halt_req | _T_168; // @[dec_tlu_ctl.scala 433:51]
  wire [15:0] dcsr = csr_io_dcsr; // @[dec_tlu_ctl.scala 1006:31]
  wire  _T_157 = ~dcsr[2]; // @[dec_tlu_ctl.scala 425:106]
  wire  _T_158 = debug_resume_req_f & _T_157; // @[dec_tlu_ctl.scala 425:104]
  wire  _T_159 = ~_T_158; // @[dec_tlu_ctl.scala 425:83]
  wire  _T_160 = debug_mode_status & _T_159; // @[dec_tlu_ctl.scala 425:81]
  wire  internal_dbg_halt_mode = debug_halt_req_ns | _T_160; // @[dec_tlu_ctl.scala 425:53]
  wire  _T_177 = debug_resume_req_f & dcsr[2]; // @[dec_tlu_ctl.scala 438:60]
  reg  dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 463:73]
  wire  _T_178 = ~dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 438:111]
  wire  _T_179 = dcsr_single_step_running_f & _T_178; // @[dec_tlu_ctl.scala 438:109]
  wire  dcsr_single_step_running = _T_177 | _T_179; // @[dec_tlu_ctl.scala 438:79]
  wire  _T_665 = ~dcsr_single_step_running; // @[dec_tlu_ctl.scala 739:55]
  wire  _T_666 = _T_665 | io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 739:81]
  wire  _T_667 = internal_dbg_halt_mode & _T_666; // @[dec_tlu_ctl.scala 739:52]
  wire  _T_346 = ~io_dec_tlu_debug_mode; // @[dec_tlu_ctl.scala 568:62]
  wire  _T_347 = i_cpu_halt_req_sync & _T_346; // @[dec_tlu_ctl.scala 568:60]
  wire  i_cpu_halt_req_sync_qual = _T_347 & _T_107; // @[dec_tlu_ctl.scala 568:85]
  wire  ext_halt_pulse = i_cpu_halt_req_sync_qual & _T_398; // @[dec_tlu_ctl.scala 584:50]
  wire  fw_halt_req = csr_io_fw_halt_req; // @[dec_tlu_ctl.scala 1004:31]
  wire  enter_pmu_fw_halt_req = ext_halt_pulse | fw_halt_req; // @[dec_tlu_ctl.scala 585:48]
  reg  pmu_fw_halt_req_f; // @[dec_tlu_ctl.scala 577:73]
  wire  _T_371 = pmu_fw_halt_req_f & core_empty; // @[dec_tlu_ctl.scala 590:45]
  wire  _T_372 = _T_371 & halt_taken; // @[dec_tlu_ctl.scala 590:58]
  wire  _T_373 = ~enter_debug_halt_req; // @[dec_tlu_ctl.scala 590:73]
  wire  _T_374 = _T_372 & _T_373; // @[dec_tlu_ctl.scala 590:71]
  wire  _T_375 = ~i_cpu_run_req_d1; // @[dec_tlu_ctl.scala 590:121]
  wire  _T_376 = pmu_fw_tlu_halted_f & _T_375; // @[dec_tlu_ctl.scala 590:119]
  wire  _T_377 = _T_374 | _T_376; // @[dec_tlu_ctl.scala 590:96]
  wire  _T_378 = ~debug_halt_req_f; // @[dec_tlu_ctl.scala 590:143]
  wire  pmu_fw_tlu_halted = _T_377 & _T_378; // @[dec_tlu_ctl.scala 590:141]
  wire  _T_361 = ~pmu_fw_tlu_halted; // @[dec_tlu_ctl.scala 586:72]
  wire  _T_362 = pmu_fw_halt_req_f & _T_361; // @[dec_tlu_ctl.scala 586:70]
  wire  _T_363 = enter_pmu_fw_halt_req | _T_362; // @[dec_tlu_ctl.scala 586:49]
  wire  pmu_fw_halt_req_ns = _T_363 & _T_378; // @[dec_tlu_ctl.scala 586:93]
  reg  internal_pmu_fw_halt_mode_f; // @[dec_tlu_ctl.scala 576:68]
  wire  _T_367 = internal_pmu_fw_halt_mode_f & _T_375; // @[dec_tlu_ctl.scala 587:83]
  wire  _T_369 = _T_367 & _T_378; // @[dec_tlu_ctl.scala 587:103]
  wire  internal_pmu_fw_halt_mode = pmu_fw_halt_req_ns | _T_369; // @[dec_tlu_ctl.scala 587:52]
  wire  _T_668 = _T_667 | internal_pmu_fw_halt_mode; // @[dec_tlu_ctl.scala 739:107]
  wire  _T_669 = _T_668 | i_cpu_halt_req_d1; // @[dec_tlu_ctl.scala 739:135]
  wire  _T_738 = ~internal_pmu_fw_halt_mode; // @[dec_tlu_ctl.scala 771:35]
  wire  _T_739 = nmi_int_detected & _T_738; // @[dec_tlu_ctl.scala 771:33]
  wire  _T_740 = ~internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 771:65]
  wire  _T_742 = dcsr_single_step_running_f & dcsr[11]; // @[dec_tlu_ctl.scala 771:119]
  wire  _T_743 = ~io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 771:141]
  wire  _T_744 = _T_742 & _T_743; // @[dec_tlu_ctl.scala 771:139]
  wire  _T_746 = _T_744 & _T_178; // @[dec_tlu_ctl.scala 771:164]
  wire  _T_747 = _T_740 | _T_746; // @[dec_tlu_ctl.scala 771:89]
  wire  _T_748 = _T_739 & _T_747; // @[dec_tlu_ctl.scala 771:62]
  wire  _T_463 = io_dec_tlu_packet_r_pmu_i0_itype == 4'h8; // @[dec_tlu_ctl.scala 657:51]
  wire  _T_464 = _T_463 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 657:64]
  wire  _T_297 = io_tlu_bp_dec_tlu_flush_lower_wb | io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 519:65]
  wire [3:0] _T_299 = _T_297 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_300 = ~_T_299; // @[dec_tlu_ctl.scala 519:23]
  wire [3:0] _T_292 = io_dec_tlu_i0_valid_r ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_294 = _T_292 & io_dec_tlu_packet_r_i0trigger; // @[dec_tlu_ctl.scala 517:53]
  wire [9:0] mtdata1_t_3 = csr_io_mtdata1_t_3; // @[dec_tlu_ctl.scala 155:67 dec_tlu_ctl.scala 1009:33]
  wire [9:0] mtdata1_t_2 = csr_io_mtdata1_t_2; // @[dec_tlu_ctl.scala 155:67 dec_tlu_ctl.scala 1009:33]
  wire [9:0] mtdata1_t_1 = csr_io_mtdata1_t_1; // @[dec_tlu_ctl.scala 155:67 dec_tlu_ctl.scala 1009:33]
  wire [9:0] mtdata1_t_0 = csr_io_mtdata1_t_0; // @[dec_tlu_ctl.scala 155:67 dec_tlu_ctl.scala 1009:33]
  wire [3:0] trigger_execute = {mtdata1_t_3[2],mtdata1_t_2[2],mtdata1_t_1[2],mtdata1_t_0[2]}; // @[Cat.scala 29:58]
  wire [3:0] trigger_data = {mtdata1_t_3[7],mtdata1_t_2[7],mtdata1_t_1[7],mtdata1_t_0[7]}; // @[Cat.scala 29:58]
  wire [3:0] _T_279 = trigger_execute & trigger_data; // @[dec_tlu_ctl.scala 509:57]
  wire  inst_acc_r_raw = io_dec_tlu_packet_r_icaf & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 665:49]
  wire [3:0] _T_281 = inst_acc_r_raw ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_282 = _T_279 & _T_281; // @[dec_tlu_ctl.scala 509:72]
  wire  _T_283 = io_tlu_exu_exu_i0_br_error_r | io_tlu_exu_exu_i0_br_start_error_r; // @[dec_tlu_ctl.scala 509:137]
  wire [3:0] _T_285 = _T_283 ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_286 = _T_282 | _T_285; // @[dec_tlu_ctl.scala 509:98]
  wire [3:0] i0_iside_trigger_has_pri_r = ~_T_286; // @[dec_tlu_ctl.scala 509:38]
  wire [3:0] _T_295 = _T_294 & i0_iside_trigger_has_pri_r; // @[dec_tlu_ctl.scala 517:90]
  wire [3:0] trigger_store = {mtdata1_t_3[1],mtdata1_t_2[1],mtdata1_t_1[1],mtdata1_t_0[1]}; // @[Cat.scala 29:58]
  wire [3:0] _T_287 = trigger_store & trigger_data; // @[dec_tlu_ctl.scala 512:51]
  wire [3:0] _T_289 = io_lsu_error_pkt_r_valid ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire [3:0] _T_290 = _T_287 & _T_289; // @[dec_tlu_ctl.scala 512:66]
  wire [3:0] i0_lsu_trigger_has_pri_r = ~_T_290; // @[dec_tlu_ctl.scala 512:35]
  wire [3:0] _T_296 = _T_295 & i0_lsu_trigger_has_pri_r; // @[dec_tlu_ctl.scala 517:119]
  wire [1:0] mstatus = csr_io_mstatus; // @[dec_tlu_ctl.scala 1005:31]
  wire  _T_259 = mtdata1_t_3[6] | mstatus[0]; // @[dec_tlu_ctl.scala 506:62]
  wire  _T_261 = _T_259 & mtdata1_t_3[3]; // @[dec_tlu_ctl.scala 506:86]
  wire  _T_264 = mtdata1_t_2[6] | mstatus[0]; // @[dec_tlu_ctl.scala 506:150]
  wire  _T_266 = _T_264 & mtdata1_t_2[3]; // @[dec_tlu_ctl.scala 506:174]
  wire  _T_269 = mtdata1_t_1[6] | mstatus[0]; // @[dec_tlu_ctl.scala 506:239]
  wire  _T_271 = _T_269 & mtdata1_t_1[3]; // @[dec_tlu_ctl.scala 506:263]
  wire  _T_274 = mtdata1_t_0[6] | mstatus[0]; // @[dec_tlu_ctl.scala 506:328]
  wire  _T_276 = _T_274 & mtdata1_t_0[3]; // @[dec_tlu_ctl.scala 506:352]
  wire [3:0] trigger_enabled = {_T_261,_T_266,_T_271,_T_276}; // @[Cat.scala 29:58]
  wire [3:0] i0trigger_qual_r = _T_296 & trigger_enabled; // @[dec_tlu_ctl.scala 517:146]
  wire [3:0] i0_trigger_r = _T_300 & i0trigger_qual_r; // @[dec_tlu_ctl.scala 519:91]
  wire  _T_303 = ~mtdata1_t_2[5]; // @[dec_tlu_ctl.scala 522:60]
  wire  _T_305 = _T_303 | i0_trigger_r[2]; // @[dec_tlu_ctl.scala 522:89]
  wire  _T_306 = i0_trigger_r[3] & _T_305; // @[dec_tlu_ctl.scala 522:57]
  wire  _T_311 = _T_303 | i0_trigger_r[3]; // @[dec_tlu_ctl.scala 522:157]
  wire  _T_312 = i0_trigger_r[2] & _T_311; // @[dec_tlu_ctl.scala 522:125]
  wire  _T_315 = ~mtdata1_t_0[5]; // @[dec_tlu_ctl.scala 522:196]
  wire  _T_317 = _T_315 | i0_trigger_r[0]; // @[dec_tlu_ctl.scala 522:225]
  wire  _T_318 = i0_trigger_r[1] & _T_317; // @[dec_tlu_ctl.scala 522:193]
  wire  _T_323 = _T_315 | i0_trigger_r[1]; // @[dec_tlu_ctl.scala 522:293]
  wire  _T_324 = i0_trigger_r[0] & _T_323; // @[dec_tlu_ctl.scala 522:261]
  wire [3:0] i0_trigger_chain_masked_r = {_T_306,_T_312,_T_318,_T_324}; // @[Cat.scala 29:58]
  wire  i0_trigger_hit_raw_r = |i0_trigger_chain_masked_r; // @[dec_tlu_ctl.scala 525:57]
  wire  _T_465 = ~i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 657:90]
  wire  _T_466 = _T_464 & _T_465; // @[dec_tlu_ctl.scala 657:88]
  wire  _T_468 = ~dcsr[15]; // @[dec_tlu_ctl.scala 657:110]
  wire  _T_469 = _T_466 & _T_468; // @[dec_tlu_ctl.scala 657:108]
  reg  tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 327:80]
  wire  _T_429 = ~tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 632:44]
  wire  _T_430 = io_dec_tlu_i0_valid_r & _T_429; // @[dec_tlu_ctl.scala 632:42]
  wire  _T_432 = _T_430 & _T_283; // @[dec_tlu_ctl.scala 632:66]
  reg  ic_perr_r_d1; // @[dec_tlu_ctl.scala 321:89]
  reg  iccm_sbecc_r_d1; // @[dec_tlu_ctl.scala 322:89]
  wire  _T_433 = ic_perr_r_d1 | iccm_sbecc_r_d1; // @[dec_tlu_ctl.scala 632:154]
  wire  _T_435 = _T_433 & _T_107; // @[dec_tlu_ctl.scala 632:173]
  wire  _T_436 = _T_432 | _T_435; // @[dec_tlu_ctl.scala 632:137]
  wire  _T_438 = _T_436 & _T_465; // @[dec_tlu_ctl.scala 632:196]
  wire  _T_410 = io_dec_tlu_i0_valid_r & _T_465; // @[dec_tlu_ctl.scala 620:47]
  wire  _T_411 = ~io_lsu_error_pkt_r_bits_inst_type; // @[dec_tlu_ctl.scala 620:70]
  wire  _T_412 = _T_411 & io_lsu_error_pkt_r_bits_single_ecc_error; // @[dec_tlu_ctl.scala 620:105]
  wire  lsu_i0_rfnpc_r = _T_410 & _T_412; // @[dec_tlu_ctl.scala 620:67]
  wire  _T_439 = ~lsu_i0_rfnpc_r; // @[dec_tlu_ctl.scala 632:220]
  wire  rfpc_i0_r = _T_438 & _T_439; // @[dec_tlu_ctl.scala 632:217]
  wire  _T_470 = ~rfpc_i0_r; // @[dec_tlu_ctl.scala 657:132]
  wire  ebreak_r = _T_469 & _T_470; // @[dec_tlu_ctl.scala 657:130]
  wire  _T_472 = io_dec_tlu_packet_r_pmu_i0_itype == 4'h9; // @[dec_tlu_ctl.scala 658:51]
  wire  _T_473 = _T_472 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 658:64]
  wire  _T_475 = _T_473 & _T_465; // @[dec_tlu_ctl.scala 658:88]
  wire  ecall_r = _T_475 & _T_470; // @[dec_tlu_ctl.scala 658:108]
  wire  _T_523 = ebreak_r | ecall_r; // @[dec_tlu_ctl.scala 685:41]
  wire  _T_478 = ~io_dec_tlu_packet_r_legal; // @[dec_tlu_ctl.scala 659:17]
  wire  _T_479 = _T_478 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 659:46]
  wire  _T_481 = _T_479 & _T_465; // @[dec_tlu_ctl.scala 659:70]
  wire  illegal_r = _T_481 & _T_470; // @[dec_tlu_ctl.scala 659:90]
  wire  _T_524 = _T_523 | illegal_r; // @[dec_tlu_ctl.scala 685:51]
  wire  _T_511 = inst_acc_r_raw & _T_470; // @[dec_tlu_ctl.scala 666:33]
  wire  inst_acc_r = _T_511 & _T_465; // @[dec_tlu_ctl.scala 666:46]
  wire  _T_525 = _T_524 | inst_acc_r; // @[dec_tlu_ctl.scala 685:63]
  wire  _T_527 = _T_525 & _T_470; // @[dec_tlu_ctl.scala 685:77]
  wire  _T_528 = ~io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 685:92]
  wire  i0_exception_valid_r = _T_527 & _T_528; // @[dec_tlu_ctl.scala 685:90]
  wire  _T_789 = i0_exception_valid_r | rfpc_i0_r; // @[dec_tlu_ctl.scala 784:49]
  wire  _T_402 = ~io_tlu_bp_dec_tlu_flush_lower_wb; // @[dec_tlu_ctl.scala 608:57]
  wire  lsu_exc_valid_r_raw = io_lsu_error_pkt_r_valid & _T_402; // @[dec_tlu_ctl.scala 608:55]
  wire  _T_403 = io_lsu_error_pkt_r_valid & lsu_exc_valid_r_raw; // @[dec_tlu_ctl.scala 610:40]
  wire  _T_405 = _T_403 & _T_465; // @[dec_tlu_ctl.scala 610:62]
  wire  lsu_exc_valid_r = _T_405 & _T_470; // @[dec_tlu_ctl.scala 610:82]
  wire  _T_790 = _T_789 | lsu_exc_valid_r; // @[dec_tlu_ctl.scala 784:61]
  wire  _T_490 = io_dec_tlu_packet_r_fence_i & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 662:50]
  wire  _T_492 = _T_490 & _T_465; // @[dec_tlu_ctl.scala 662:74]
  wire  fence_i_r = _T_492 & _T_470; // @[dec_tlu_ctl.scala 662:95]
  wire  _T_791 = _T_790 | fence_i_r; // @[dec_tlu_ctl.scala 784:79]
  wire  _T_792 = _T_791 | lsu_i0_rfnpc_r; // @[dec_tlu_ctl.scala 784:91]
  wire  _T_414 = io_dec_tlu_i0_valid_r & _T_470; // @[dec_tlu_ctl.scala 623:50]
  wire  _T_415 = ~lsu_exc_valid_r; // @[dec_tlu_ctl.scala 623:65]
  wire  _T_416 = _T_414 & _T_415; // @[dec_tlu_ctl.scala 623:63]
  wire  _T_417 = ~inst_acc_r; // @[dec_tlu_ctl.scala 623:82]
  wire  _T_418 = _T_416 & _T_417; // @[dec_tlu_ctl.scala 623:79]
  wire  _T_420 = _T_418 & _T_528; // @[dec_tlu_ctl.scala 623:94]
  reg  request_debug_mode_r_d1; // @[dec_tlu_ctl.scala 461:81]
  wire  _T_421 = ~request_debug_mode_r_d1; // @[dec_tlu_ctl.scala 623:121]
  wire  _T_422 = _T_420 & _T_421; // @[dec_tlu_ctl.scala 623:119]
  wire  tlu_i0_commit_cmt = _T_422 & _T_465; // @[dec_tlu_ctl.scala 623:146]
  reg  iccm_repair_state_d1; // @[dec_tlu_ctl.scala 320:80]
  wire  _T_444 = tlu_i0_commit_cmt & iccm_repair_state_d1; // @[dec_tlu_ctl.scala 641:52]
  wire  _T_484 = io_dec_tlu_packet_r_pmu_i0_itype == 4'hc; // @[dec_tlu_ctl.scala 660:51]
  wire  _T_485 = _T_484 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 660:64]
  wire  _T_487 = _T_485 & _T_465; // @[dec_tlu_ctl.scala 660:88]
  wire  mret_r = _T_487 & _T_470; // @[dec_tlu_ctl.scala 660:108]
  wire  _T_446 = _T_523 | mret_r; // @[dec_tlu_ctl.scala 641:98]
  wire  take_reset = reset_delayed & io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 770:32]
  wire  _T_447 = _T_446 | take_reset; // @[dec_tlu_ctl.scala 641:107]
  wire  _T_448 = _T_447 | illegal_r; // @[dec_tlu_ctl.scala 641:120]
  wire  _T_449 = io_dec_csr_wraddr_r == 12'h7c2; // @[dec_tlu_ctl.scala 641:176]
  wire  _T_450 = dec_csr_wen_r_mod & _T_449; // @[dec_tlu_ctl.scala 641:153]
  wire  _T_451 = _T_448 | _T_450; // @[dec_tlu_ctl.scala 641:132]
  wire  _T_452 = ~_T_451; // @[dec_tlu_ctl.scala 641:77]
  wire  iccm_repair_state_rfnpc = _T_444 & _T_452; // @[dec_tlu_ctl.scala 641:75]
  wire  _T_793 = _T_792 | iccm_repair_state_rfnpc; // @[dec_tlu_ctl.scala 784:108]
  wire  _T_794 = _T_793 | debug_resume_req_f; // @[dec_tlu_ctl.scala 784:135]
  wire  _T_786 = i_cpu_run_req_d1 & pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 782:43]
  wire  _T_211 = ~io_dec_pause_state; // @[dec_tlu_ctl.scala 481:28]
  reg  dec_pause_state_f; // @[dec_tlu_ctl.scala 460:81]
  wire  _T_212 = _T_211 & dec_pause_state_f; // @[dec_tlu_ctl.scala 481:48]
  wire  _T_213 = ext_int_ready | ce_int_ready; // @[dec_tlu_ctl.scala 481:86]
  wire  _T_214 = _T_213 | timer_int_ready; // @[dec_tlu_ctl.scala 481:101]
  wire  _T_215 = _T_214 | soft_int_ready; // @[dec_tlu_ctl.scala 481:119]
  wire  _T_216 = _T_215 | int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 481:136]
  wire  _T_217 = _T_216 | int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 481:160]
  wire  _T_218 = _T_217 | nmi_int_detected; // @[dec_tlu_ctl.scala 481:184]
  wire  _T_219 = _T_218 | ext_int_freeze_d1; // @[dec_tlu_ctl.scala 481:203]
  wire  _T_220 = ~_T_219; // @[dec_tlu_ctl.scala 481:70]
  wire  _T_221 = _T_212 & _T_220; // @[dec_tlu_ctl.scala 481:68]
  wire  _T_223 = _T_221 & _T_140; // @[dec_tlu_ctl.scala 481:224]
  wire  _T_225 = _T_223 & _T_378; // @[dec_tlu_ctl.scala 481:248]
  wire  _T_226 = ~pmu_fw_halt_req_f; // @[dec_tlu_ctl.scala 481:270]
  wire  _T_227 = _T_225 & _T_226; // @[dec_tlu_ctl.scala 481:268]
  wire  _T_228 = ~halt_taken_f; // @[dec_tlu_ctl.scala 481:291]
  wire  pause_expired_r = _T_227 & _T_228; // @[dec_tlu_ctl.scala 481:289]
  wire  sel_npc_resume = _T_786 | pause_expired_r; // @[dec_tlu_ctl.scala 782:66]
  wire  _T_795 = _T_794 | sel_npc_resume; // @[dec_tlu_ctl.scala 784:157]
  reg  dec_tlu_wr_pause_r_d1; // @[dec_tlu_ctl.scala 459:81]
  wire  _T_796 = _T_795 | dec_tlu_wr_pause_r_d1; // @[dec_tlu_ctl.scala 784:175]
  wire  synchronous_flush_r = _T_796 | i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 784:201]
  wire  _T_749 = ~synchronous_flush_r; // @[dec_tlu_ctl.scala 771:195]
  wire  _T_750 = _T_748 & _T_749; // @[dec_tlu_ctl.scala 771:193]
  wire  _T_751 = ~mret_r; // @[dec_tlu_ctl.scala 771:218]
  wire  _T_752 = _T_750 & _T_751; // @[dec_tlu_ctl.scala 771:216]
  wire  _T_753 = ~take_reset; // @[dec_tlu_ctl.scala 771:228]
  wire  _T_754 = _T_752 & _T_753; // @[dec_tlu_ctl.scala 771:226]
  wire  _T_519 = _T_466 & dcsr[15]; // @[dec_tlu_ctl.scala 669:121]
  wire  ebreak_to_debug_mode_r = _T_519 & _T_470; // @[dec_tlu_ctl.scala 669:142]
  wire  _T_755 = ~ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 771:242]
  wire  _T_756 = _T_754 & _T_755; // @[dec_tlu_ctl.scala 771:240]
  wire  _T_760 = _T_107 | _T_44; // @[dec_tlu_ctl.scala 771:288]
  wire  take_nmi = _T_756 & _T_760; // @[dec_tlu_ctl.scala 771:266]
  wire  _T_670 = _T_669 | take_nmi; // @[dec_tlu_ctl.scala 739:155]
  wire  _T_671 = _T_670 | ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 739:166]
  wire  _T_672 = _T_671 | synchronous_flush_r; // @[dec_tlu_ctl.scala 739:191]
  reg  exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 810:90]
  wire  _T_673 = _T_672 | exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 739:214]
  wire  _T_674 = _T_673 | mret_r; // @[dec_tlu_ctl.scala 739:238]
  wire  block_interrupts = _T_674 | ext_int_freeze_d1; // @[dec_tlu_ctl.scala 739:247]
  wire  _T_704 = ~block_interrupts; // @[dec_tlu_ctl.scala 767:91]
  wire  take_timer_int = _T_703 & _T_704; // @[dec_tlu_ctl.scala 767:89]
  wire  _T_762 = take_ext_int | take_timer_int; // @[dec_tlu_ctl.scala 774:38]
  wire  _T_693 = soft_int_ready & _T_700; // @[dec_tlu_ctl.scala 766:36]
  wire  _T_695 = _T_693 & _T_702; // @[dec_tlu_ctl.scala 766:53]
  wire  take_soft_int = _T_695 & _T_704; // @[dec_tlu_ctl.scala 766:69]
  wire  _T_763 = _T_762 | take_soft_int; // @[dec_tlu_ctl.scala 774:55]
  wire  _T_764 = _T_763 | take_nmi; // @[dec_tlu_ctl.scala 774:71]
  wire  _T_689 = ce_int_ready & _T_700; // @[dec_tlu_ctl.scala 765:33]
  wire  take_ce_int = _T_689 & _T_704; // @[dec_tlu_ctl.scala 765:50]
  wire  _T_765 = _T_764 | take_ce_int; // @[dec_tlu_ctl.scala 774:82]
  wire  int_timer0_int_possible = mstatus_mie_ns & mie_ns[4]; // @[dec_tlu_ctl.scala 725:49]
  wire  int_timer0_int_ready = mip[4] & int_timer0_int_possible; // @[dec_tlu_ctl.scala 726:47]
  wire  _T_706 = int_timer0_int_ready | int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 768:49]
  wire  _T_707 = _T_706 & int_timer0_int_possible; // @[dec_tlu_ctl.scala 768:74]
  wire  _T_709 = _T_707 & _T_631; // @[dec_tlu_ctl.scala 768:100]
  wire  _T_710 = ~timer_int_ready; // @[dec_tlu_ctl.scala 768:129]
  wire  _T_711 = _T_709 & _T_710; // @[dec_tlu_ctl.scala 768:127]
  wire  _T_713 = _T_711 & _T_698; // @[dec_tlu_ctl.scala 768:146]
  wire  _T_715 = _T_713 & _T_700; // @[dec_tlu_ctl.scala 768:164]
  wire  _T_717 = _T_715 & _T_702; // @[dec_tlu_ctl.scala 768:181]
  wire  take_int_timer0_int = _T_717 & _T_704; // @[dec_tlu_ctl.scala 768:197]
  wire  _T_766 = _T_765 | take_int_timer0_int; // @[dec_tlu_ctl.scala 774:96]
  wire  int_timer1_int_possible = mstatus_mie_ns & mie_ns[3]; // @[dec_tlu_ctl.scala 727:49]
  wire  int_timer1_int_ready = mip[3] & int_timer1_int_possible; // @[dec_tlu_ctl.scala 728:47]
  wire  _T_720 = int_timer1_int_ready | int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 769:49]
  wire  _T_721 = _T_720 & int_timer1_int_possible; // @[dec_tlu_ctl.scala 769:74]
  wire  _T_723 = _T_721 & _T_631; // @[dec_tlu_ctl.scala 769:100]
  wire  _T_725 = ~_T_706; // @[dec_tlu_ctl.scala 769:129]
  wire  _T_726 = _T_723 & _T_725; // @[dec_tlu_ctl.scala 769:127]
  wire  _T_728 = _T_726 & _T_710; // @[dec_tlu_ctl.scala 769:177]
  wire  _T_730 = _T_728 & _T_698; // @[dec_tlu_ctl.scala 769:196]
  wire  _T_732 = _T_730 & _T_700; // @[dec_tlu_ctl.scala 769:214]
  wire  _T_734 = _T_732 & _T_702; // @[dec_tlu_ctl.scala 769:231]
  wire  take_int_timer1_int = _T_734 & _T_704; // @[dec_tlu_ctl.scala 769:247]
  wire  interrupt_valid_r = _T_766 | take_int_timer1_int; // @[dec_tlu_ctl.scala 774:118]
  wire  _T_15 = _T_14 | interrupt_valid_r; // @[dec_tlu_ctl.scala 315:69]
  wire  _T_16 = _T_15 | interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 315:89]
  wire  _T_17 = _T_16 | reset_delayed; // @[dec_tlu_ctl.scala 315:112]
  wire  _T_18 = _T_17 | pause_expired_r; // @[dec_tlu_ctl.scala 315:128]
  reg  pause_expired_wb; // @[dec_tlu_ctl.scala 815:90]
  wire  _T_19 = _T_18 | pause_expired_wb; // @[dec_tlu_ctl.scala 315:146]
  wire  _T_496 = io_tlu_mem_ifu_ic_error_start & _T_107; // @[dec_tlu_ctl.scala 663:51]
  wire  _T_498 = _T_152 | dcsr_single_step_running; // @[dec_tlu_ctl.scala 663:101]
  wire  _T_499 = _T_496 & _T_498; // @[dec_tlu_ctl.scala 663:72]
  wire  _T_500 = ~internal_pmu_fw_halt_mode_f; // @[dec_tlu_ctl.scala 663:131]
  wire  ic_perr_r = _T_499 & _T_500; // @[dec_tlu_ctl.scala 663:129]
  wire  _T_20 = _T_19 | ic_perr_r; // @[dec_tlu_ctl.scala 315:165]
  wire  _T_21 = _T_20 | ic_perr_r_d1; // @[dec_tlu_ctl.scala 315:177]
  wire  _T_503 = io_tlu_mem_ifu_iccm_rd_ecc_single_err & _T_107; // @[dec_tlu_ctl.scala 664:59]
  wire  _T_506 = _T_503 & _T_498; // @[dec_tlu_ctl.scala 664:80]
  wire  iccm_sbecc_r = _T_506 & _T_500; // @[dec_tlu_ctl.scala 664:137]
  wire  _T_22 = _T_21 | iccm_sbecc_r; // @[dec_tlu_ctl.scala 315:192]
  wire  _T_23 = _T_22 | iccm_sbecc_r_d1; // @[dec_tlu_ctl.scala 315:207]
  wire  flush_clkvalid = _T_23 | io_dec_tlu_dec_clk_override; // @[dec_tlu_ctl.scala 315:225]
  reg  lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 325:80]
  reg  lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 326:72]
  reg  _T_32; // @[dec_tlu_ctl.scala 328:73]
  reg  internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 329:72]
  reg  _T_33; // @[dec_tlu_ctl.scala 330:89]
  reg  nmi_lsu_load_type_f; // @[dec_tlu_ctl.scala 341:72]
  reg  nmi_lsu_store_type_f; // @[dec_tlu_ctl.scala 342:72]
  wire  _T_46 = nmi_lsu_detected & io_tlu_busbuff_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 350:48]
  wire  _T_49 = ~_T_41; // @[dec_tlu_ctl.scala 350:96]
  wire  _T_50 = _T_46 & _T_49; // @[dec_tlu_ctl.scala 350:94]
  wire  _T_52 = nmi_lsu_load_type_f & _T_40; // @[dec_tlu_ctl.scala 350:159]
  wire  _T_54 = nmi_lsu_detected & io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 351:49]
  wire  _T_58 = _T_54 & _T_49; // @[dec_tlu_ctl.scala 351:96]
  wire  _T_60 = nmi_lsu_store_type_f & _T_40; // @[dec_tlu_ctl.scala 351:162]
  reg  mpc_debug_halt_req_sync_f; // @[dec_tlu_ctl.scala 359:72]
  reg  mpc_debug_run_req_sync_f; // @[dec_tlu_ctl.scala 360:72]
  reg  mpc_run_state_f; // @[dec_tlu_ctl.scala 362:88]
  reg  debug_brkpt_status_f; // @[dec_tlu_ctl.scala 363:80]
  reg  mpc_debug_halt_ack_f; // @[dec_tlu_ctl.scala 364:80]
  reg  mpc_debug_run_ack_f; // @[dec_tlu_ctl.scala 365:80]
  reg  dbg_run_state_f; // @[dec_tlu_ctl.scala 367:88]
  reg  _T_65; // @[dec_tlu_ctl.scala 368:81]
  wire  _T_66 = ~mpc_debug_halt_req_sync_f; // @[dec_tlu_ctl.scala 372:71]
  wire  mpc_debug_halt_req_sync_pulse = mpc_debug_halt_req_sync & _T_66; // @[dec_tlu_ctl.scala 372:69]
  wire  _T_67 = ~mpc_debug_run_req_sync_f; // @[dec_tlu_ctl.scala 373:70]
  wire  mpc_debug_run_req_sync_pulse = mpc_debug_run_req_sync & _T_67; // @[dec_tlu_ctl.scala 373:68]
  wire  _T_68 = mpc_halt_state_f | mpc_debug_halt_req_sync_pulse; // @[dec_tlu_ctl.scala 375:48]
  wire  _T_71 = _T_68 | _T_111; // @[dec_tlu_ctl.scala 375:80]
  wire  _T_72 = ~mpc_debug_run_req_sync; // @[dec_tlu_ctl.scala 375:125]
  wire  mpc_halt_state_ns = _T_71 & _T_72; // @[dec_tlu_ctl.scala 375:123]
  wire  _T_74 = ~mpc_debug_run_ack_f; // @[dec_tlu_ctl.scala 376:80]
  wire  _T_75 = mpc_debug_run_req_sync_pulse & _T_74; // @[dec_tlu_ctl.scala 376:78]
  wire  _T_76 = mpc_run_state_f | _T_75; // @[dec_tlu_ctl.scala 376:46]
  wire  _T_77 = ~dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 376:133]
  wire  _T_78 = debug_mode_status & _T_77; // @[dec_tlu_ctl.scala 376:131]
  wire  mpc_run_state_ns = _T_76 & _T_78; // @[dec_tlu_ctl.scala 376:103]
  wire  _T_80 = dbg_halt_req_final | dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 378:70]
  wire  _T_81 = _T_80 | trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 378:96]
  wire  _T_82 = _T_81 | ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 378:121]
  wire  _T_83 = dbg_halt_state_f | _T_82; // @[dec_tlu_ctl.scala 378:48]
  wire  _T_84 = ~io_dbg_resume_req; // @[dec_tlu_ctl.scala 378:153]
  wire  dbg_halt_state_ns = _T_83 & _T_84; // @[dec_tlu_ctl.scala 378:151]
  wire  _T_86 = dbg_run_state_f | io_dbg_resume_req; // @[dec_tlu_ctl.scala 379:46]
  wire  dbg_run_state_ns = _T_86 & _T_78; // @[dec_tlu_ctl.scala 379:67]
  wire  debug_brkpt_valid = ebreak_to_debug_mode_r_d1 | trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 385:59]
  wire  _T_92 = debug_brkpt_valid | debug_brkpt_status_f; // @[dec_tlu_ctl.scala 386:53]
  wire  _T_94 = internal_dbg_halt_mode & _T_77; // @[dec_tlu_ctl.scala 386:103]
  wire  _T_96 = mpc_halt_state_f & debug_mode_status; // @[dec_tlu_ctl.scala 389:51]
  wire  _T_97 = _T_96 & mpc_debug_halt_req_sync; // @[dec_tlu_ctl.scala 389:78]
  wire  _T_99 = ~dbg_halt_state_ns; // @[dec_tlu_ctl.scala 390:59]
  wire  _T_100 = mpc_debug_run_req_sync & _T_99; // @[dec_tlu_ctl.scala 390:57]
  wire  _T_101 = ~mpc_debug_halt_req_sync; // @[dec_tlu_ctl.scala 390:80]
  wire  _T_102 = _T_100 & _T_101; // @[dec_tlu_ctl.scala 390:78]
  wire  _T_103 = mpc_debug_run_ack_f & mpc_debug_run_req_sync; // @[dec_tlu_ctl.scala 390:129]
  wire  _T_118 = mpc_run_state_ns & _T_99; // @[dec_tlu_ctl.scala 404:73]
  wire  _T_119 = ~mpc_halt_state_ns; // @[dec_tlu_ctl.scala 404:117]
  wire  _T_120 = dbg_run_state_ns & _T_119; // @[dec_tlu_ctl.scala 404:115]
  wire  _T_121 = _T_118 | _T_120; // @[dec_tlu_ctl.scala 404:95]
  wire  _T_122 = debug_halt_req_f | pmu_fw_halt_req_f; // @[dec_tlu_ctl.scala 409:43]
  wire  _T_124 = _T_122 & _T_749; // @[dec_tlu_ctl.scala 409:64]
  wire  _T_126 = _T_124 & _T_751; // @[dec_tlu_ctl.scala 409:87]
  wire  _T_128 = _T_126 & _T_228; // @[dec_tlu_ctl.scala 409:97]
  wire  _T_129 = ~dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 409:115]
  wire  _T_130 = _T_128 & _T_129; // @[dec_tlu_ctl.scala 409:113]
  wire  take_halt = _T_130 & _T_753; // @[dec_tlu_ctl.scala 409:143]
  wire  _T_170 = debug_resume_req_f & dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 434:49]
  wire  _T_172 = io_dec_tlu_i0_valid_r & _T_528; // @[dec_tlu_ctl.scala 436:59]
  wire  _T_174 = _T_172 & dcsr[2]; // @[dec_tlu_ctl.scala 436:84]
  wire  _T_329 = mtdata1_t_3[6] & mtdata1_t_3[9]; // @[dec_tlu_ctl.scala 531:61]
  wire  _T_332 = mtdata1_t_2[6] & mtdata1_t_2[9]; // @[dec_tlu_ctl.scala 531:121]
  wire  _T_335 = mtdata1_t_1[6] & mtdata1_t_1[9]; // @[dec_tlu_ctl.scala 531:181]
  wire  _T_338 = mtdata1_t_0[6] & mtdata1_t_0[9]; // @[dec_tlu_ctl.scala 531:241]
  wire [3:0] trigger_action = {_T_329,_T_332,_T_335,_T_338}; // @[Cat.scala 29:58]
  wire [3:0] _T_343 = i0_trigger_chain_masked_r & trigger_action; // @[dec_tlu_ctl.scala 537:57]
  wire  i0_trigger_action_r = |_T_343; // @[dec_tlu_ctl.scala 537:75]
  wire  trigger_hit_dmode_r = i0_trigger_hit_raw_r & i0_trigger_action_r; // @[dec_tlu_ctl.scala 539:45]
  wire  _T_180 = trigger_hit_dmode_r | ebreak_to_debug_mode_r; // @[dec_tlu_ctl.scala 443:57]
  wire  _T_182 = request_debug_mode_r_d1 & _T_402; // @[dec_tlu_ctl.scala 443:110]
  reg  request_debug_mode_done_f; // @[dec_tlu_ctl.scala 462:73]
  wire  _T_183 = request_debug_mode_r_d1 | request_debug_mode_done_f; // @[dec_tlu_ctl.scala 445:64]
  reg  _T_190; // @[dec_tlu_ctl.scala 453:81]
  wire  _T_201 = fence_i_r & internal_dbg_halt_mode; // @[dec_tlu_ctl.scala 474:71]
  wire  _T_202 = take_halt | _T_201; // @[dec_tlu_ctl.scala 474:58]
  wire  _T_203 = _T_202 | io_dec_tlu_flush_pause_r; // @[dec_tlu_ctl.scala 474:97]
  wire  _T_204 = i0_trigger_hit_raw_r & trigger_hit_dmode_r; // @[dec_tlu_ctl.scala 474:144]
  wire  _T_205 = _T_203 | _T_204; // @[dec_tlu_ctl.scala 474:124]
  wire  take_ext_int_start = ext_int_ready & _T_704; // @[dec_tlu_ctl.scala 747:45]
  wire  _T_207 = ~interrupt_valid_r; // @[dec_tlu_ctl.scala 479:61]
  wire  _T_208 = dec_tlu_wr_pause_r_d1 & _T_207; // @[dec_tlu_ctl.scala 479:59]
  wire  _T_209 = ~take_ext_int_start; // @[dec_tlu_ctl.scala 479:82]
  wire  _T_231 = io_tlu_exu_dec_tlu_flush_lower_r & dcsr[2]; // @[dec_tlu_ctl.scala 483:82]
  wire  _T_232 = io_dec_tlu_resume_ack | dcsr_single_step_running; // @[dec_tlu_ctl.scala 483:125]
  wire  _T_233 = _T_231 & _T_232; // @[dec_tlu_ctl.scala 483:100]
  wire  _T_234 = ~io_tlu_ifc_dec_tlu_flush_noredir_wb; // @[dec_tlu_ctl.scala 483:155]
  wire [3:0] _T_342 = i0_trigger_hit_raw_r ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire  _T_345 = ~trigger_hit_dmode_r; // @[dec_tlu_ctl.scala 541:55]
  wire  mepc_trigger_hit_sel_pc_r = i0_trigger_hit_raw_r & _T_345; // @[dec_tlu_ctl.scala 541:53]
  wire  _T_350 = i_cpu_run_req_sync & _T_346; // @[dec_tlu_ctl.scala 569:58]
  wire  _T_351 = _T_350 & pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 569:83]
  wire  i_cpu_run_req_sync_qual = _T_351 & _T_107; // @[dec_tlu_ctl.scala 569:105]
  reg  _T_353; // @[dec_tlu_ctl.scala 573:81]
  reg  _T_354; // @[dec_tlu_ctl.scala 574:81]
  reg  _T_355; // @[dec_tlu_ctl.scala 575:81]
  wire  _T_384 = io_o_cpu_halt_status & _T_375; // @[dec_tlu_ctl.scala 593:89]
  wire  _T_386 = _T_384 & _T_152; // @[dec_tlu_ctl.scala 593:109]
  wire  _T_388 = io_o_cpu_halt_status & i_cpu_run_req_sync_qual; // @[dec_tlu_ctl.scala 594:41]
  wire  _T_389 = io_o_cpu_run_ack & i_cpu_run_req_sync_qual; // @[dec_tlu_ctl.scala 594:88]
  reg  lsu_single_ecc_error_r_d1; // @[dec_tlu_ctl.scala 606:72]
  reg  lsu_i0_exc_r_d1; // @[dec_tlu_ctl.scala 613:73]
  wire  _T_408 = ~io_lsu_error_pkt_r_bits_exc_type; // @[dec_tlu_ctl.scala 614:40]
  wire  lsu_exc_ma_r = lsu_exc_valid_r & _T_408; // @[dec_tlu_ctl.scala 614:38]
  wire  lsu_exc_acc_r = lsu_exc_valid_r & io_lsu_error_pkt_r_bits_exc_type; // @[dec_tlu_ctl.scala 615:38]
  wire  lsu_exc_st_r = lsu_exc_valid_r & io_lsu_error_pkt_r_bits_inst_type; // @[dec_tlu_ctl.scala 616:38]
  wire  _T_424 = rfpc_i0_r | lsu_exc_valid_r; // @[dec_tlu_ctl.scala 626:38]
  wire  _T_425 = _T_424 | inst_acc_r; // @[dec_tlu_ctl.scala 626:53]
  wire  _T_426 = illegal_r & io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 626:79]
  wire  _T_427 = _T_425 | _T_426; // @[dec_tlu_ctl.scala 626:66]
  wire  _T_441 = ~io_tlu_exu_dec_tlu_flush_lower_r; // @[dec_tlu_ctl.scala 635:70]
  wire  _T_442 = iccm_repair_state_d1 & _T_441; // @[dec_tlu_ctl.scala 635:68]
  wire  _T_453 = io_tlu_exu_exu_i0_br_error_r & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 644:59]
  wire  _T_455 = io_tlu_exu_exu_i0_br_start_error_r & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 645:71]
  wire  _T_457 = io_tlu_exu_exu_i0_br_valid_r & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 646:55]
  wire  _T_459 = _T_457 & _T_429; // @[dec_tlu_ctl.scala 646:79]
  wire  _T_460 = ~io_tlu_exu_exu_i0_br_mp_r; // @[dec_tlu_ctl.scala 646:106]
  wire  _T_461 = ~io_tlu_exu_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 646:135]
  wire  _T_462 = _T_460 | _T_461; // @[dec_tlu_ctl.scala 646:133]
  wire  _T_529 = ~take_nmi; // @[dec_tlu_ctl.scala 694:33]
  wire  _T_530 = take_ext_int & _T_529; // @[dec_tlu_ctl.scala 694:31]
  wire  _T_533 = take_timer_int & _T_529; // @[dec_tlu_ctl.scala 695:25]
  wire  _T_536 = take_soft_int & _T_529; // @[dec_tlu_ctl.scala 696:24]
  wire  _T_539 = take_int_timer0_int & _T_529; // @[dec_tlu_ctl.scala 697:30]
  wire  _T_542 = take_int_timer1_int & _T_529; // @[dec_tlu_ctl.scala 698:30]
  wire  _T_545 = take_ce_int & _T_529; // @[dec_tlu_ctl.scala 699:22]
  wire  _T_548 = illegal_r & _T_529; // @[dec_tlu_ctl.scala 700:20]
  wire  _T_551 = ecall_r & _T_529; // @[dec_tlu_ctl.scala 701:19]
  wire  _T_554 = inst_acc_r & _T_529; // @[dec_tlu_ctl.scala 702:22]
  wire  _T_556 = ebreak_r | i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 703:20]
  wire  _T_558 = _T_556 & _T_529; // @[dec_tlu_ctl.scala 703:40]
  wire  _T_560 = ~lsu_exc_st_r; // @[dec_tlu_ctl.scala 704:25]
  wire  _T_561 = lsu_exc_ma_r & _T_560; // @[dec_tlu_ctl.scala 704:23]
  wire  _T_563 = _T_561 & _T_529; // @[dec_tlu_ctl.scala 704:39]
  wire  _T_566 = lsu_exc_acc_r & _T_560; // @[dec_tlu_ctl.scala 705:24]
  wire  _T_568 = _T_566 & _T_529; // @[dec_tlu_ctl.scala 705:40]
  wire  _T_570 = lsu_exc_ma_r & lsu_exc_st_r; // @[dec_tlu_ctl.scala 706:23]
  wire  _T_572 = _T_570 & _T_529; // @[dec_tlu_ctl.scala 706:38]
  wire  _T_574 = lsu_exc_acc_r & lsu_exc_st_r; // @[dec_tlu_ctl.scala 707:24]
  wire  _T_576 = _T_574 & _T_529; // @[dec_tlu_ctl.scala 707:39]
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
  wire  _T_641 = io_dec_csr_stall_int_ff | synchronous_flush_r; // @[dec_tlu_ctl.scala 732:52]
  wire  _T_642 = _T_641 | exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 732:74]
  wire  int_timer_stalled = _T_642 | mret_r; // @[dec_tlu_ctl.scala 732:98]
  wire  _T_643 = pmu_fw_tlu_halted_f | int_timer_stalled; // @[dec_tlu_ctl.scala 734:72]
  wire  _T_644 = int_timer0_int_ready & _T_643; // @[dec_tlu_ctl.scala 734:49]
  wire  _T_645 = int_timer0_int_possible & int_timer0_int_hold_f; // @[dec_tlu_ctl.scala 734:121]
  wire  _T_647 = _T_645 & _T_207; // @[dec_tlu_ctl.scala 734:145]
  wire  _T_649 = _T_647 & _T_209; // @[dec_tlu_ctl.scala 734:166]
  wire  _T_651 = _T_649 & _T_152; // @[dec_tlu_ctl.scala 734:188]
  wire  _T_654 = int_timer1_int_ready & _T_643; // @[dec_tlu_ctl.scala 735:49]
  wire  _T_655 = int_timer1_int_possible & int_timer1_int_hold_f; // @[dec_tlu_ctl.scala 735:121]
  wire  _T_657 = _T_655 & _T_207; // @[dec_tlu_ctl.scala 735:145]
  wire  _T_659 = _T_657 & _T_209; // @[dec_tlu_ctl.scala 735:166]
  wire  _T_661 = _T_659 & _T_152; // @[dec_tlu_ctl.scala 735:188]
  reg  take_ext_int_start_d2; // @[dec_tlu_ctl.scala 744:62]
  wire  _T_681 = take_ext_int_start | take_ext_int_start_d1; // @[dec_tlu_ctl.scala 749:46]
  wire  _T_682 = _T_681 | take_ext_int_start_d2; // @[dec_tlu_ctl.scala 749:70]
  wire  csr_pkt_csr_meicpct = csr_read_io_csr_pkt_csr_meicpct; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  fast_int_meicpct = csr_pkt_csr_meicpct & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 751:49]
  wire [30:0] mtvec = csr_io_mtvec; // @[dec_tlu_ctl.scala 1007:31]
  wire [30:0] _T_769 = {mtvec[30:1],1'h0}; // @[Cat.scala 29:58]
  wire [30:0] _T_771 = {25'h0,exc_cause_r,1'h0}; // @[Cat.scala 29:58]
  wire [30:0] vectored_path = _T_769 + _T_771; // @[dec_tlu_ctl.scala 779:51]
  wire [30:0] _T_778 = mtvec[0] ? vectored_path : _T_769; // @[dec_tlu_ctl.scala 780:61]
  wire [30:0] interrupt_path = take_nmi ? io_nmi_vec : _T_778; // @[dec_tlu_ctl.scala 780:28]
  wire  _T_779 = lsu_i0_rfnpc_r | fence_i_r; // @[dec_tlu_ctl.scala 781:36]
  wire  _T_780 = _T_779 | iccm_repair_state_rfnpc; // @[dec_tlu_ctl.scala 781:48]
  wire  _T_782 = i_cpu_run_req_d1 & _T_207; // @[dec_tlu_ctl.scala 781:94]
  wire  _T_783 = _T_780 | _T_782; // @[dec_tlu_ctl.scala 781:74]
  wire  _T_785 = rfpc_i0_r & _T_743; // @[dec_tlu_ctl.scala 781:129]
  wire  sel_npc_r = _T_783 | _T_785; // @[dec_tlu_ctl.scala 781:116]
  wire  _T_798 = interrupt_valid_r | mret_r; // @[dec_tlu_ctl.scala 785:43]
  wire  _T_799 = _T_798 | synchronous_flush_r; // @[dec_tlu_ctl.scala 785:52]
  wire  _T_800 = _T_799 | take_halt; // @[dec_tlu_ctl.scala 785:74]
  wire  _T_801 = _T_800 | take_reset; // @[dec_tlu_ctl.scala 785:86]
  wire  _T_807 = _T_529 & sel_npc_r; // @[dec_tlu_ctl.scala 789:73]
  wire  _T_810 = _T_529 & rfpc_i0_r; // @[dec_tlu_ctl.scala 790:73]
  wire  _T_812 = _T_810 & io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 790:91]
  wire  _T_813 = ~sel_npc_r; // @[dec_tlu_ctl.scala 790:132]
  wire  _T_814 = _T_812 & _T_813; // @[dec_tlu_ctl.scala 790:121]
  wire  _T_816 = ~take_ext_int; // @[dec_tlu_ctl.scala 791:96]
  wire  _T_817 = interrupt_valid_r & _T_816; // @[dec_tlu_ctl.scala 791:82]
  wire  _T_818 = i0_exception_valid_r | lsu_exc_valid_r; // @[dec_tlu_ctl.scala 792:80]
  wire  _T_821 = _T_818 | mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 792:98]
  wire  _T_823 = _T_821 & _T_207; // @[dec_tlu_ctl.scala 792:143]
  wire  _T_825 = _T_823 & _T_816; // @[dec_tlu_ctl.scala 792:164]
  wire  _T_830 = _T_529 & mret_r; // @[dec_tlu_ctl.scala 793:68]
  wire  _T_833 = _T_529 & debug_resume_req_f; // @[dec_tlu_ctl.scala 794:68]
  wire  _T_836 = _T_529 & sel_npc_resume; // @[dec_tlu_ctl.scala 795:68]
  wire [30:0] _T_838 = take_ext_int ? io_lsu_fir_addr : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] npc_r = csr_io_npc_r; // @[dec_tlu_ctl.scala 995:31]
  wire [30:0] _T_839 = _T_807 ? npc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_840 = _T_814 ? io_dec_tlu_i0_pc_r : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_841 = _T_817 ? interrupt_path : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_842 = _T_825 ? _T_769 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] mepc = csr_io_mepc; // @[dec_tlu_ctl.scala 998:31]
  wire [30:0] _T_843 = _T_830 ? mepc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] dpc = csr_io_dpc; // @[dec_tlu_ctl.scala 1001:31]
  wire [30:0] _T_844 = _T_833 ? dpc : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] npc_r_d1 = csr_io_npc_r_d1; // @[dec_tlu_ctl.scala 996:31]
  wire [30:0] _T_845 = _T_836 ? npc_r_d1 : 31'h0; // @[Mux.scala 27:72]
  wire [30:0] _T_846 = _T_838 | _T_839; // @[Mux.scala 27:72]
  wire [30:0] _T_847 = _T_846 | _T_840; // @[Mux.scala 27:72]
  wire [30:0] _T_848 = _T_847 | _T_841; // @[Mux.scala 27:72]
  wire [30:0] _T_849 = _T_848 | _T_842; // @[Mux.scala 27:72]
  wire [30:0] _T_850 = _T_849 | _T_843; // @[Mux.scala 27:72]
  wire [30:0] _T_851 = _T_850 | _T_844; // @[Mux.scala 27:72]
  wire [30:0] _T_852 = _T_851 | _T_845; // @[Mux.scala 27:72]
  reg [30:0] tlu_flush_path_r_d1; // @[dec_tlu_ctl.scala 798:64]
  wire  _T_854 = lsu_exc_valid_r | i0_exception_valid_r; // @[dec_tlu_ctl.scala 806:45]
  wire  _T_855 = _T_854 | interrupt_valid_r; // @[dec_tlu_ctl.scala 806:68]
  reg  i0_exception_valid_r_d1; // @[dec_tlu_ctl.scala 809:89]
  reg [4:0] exc_cause_wb; // @[dec_tlu_ctl.scala 811:89]
  wire  _T_860 = ~illegal_r; // @[dec_tlu_ctl.scala 812:119]
  reg  i0_valid_wb; // @[dec_tlu_ctl.scala 812:97]
  reg  trigger_hit_r_d1; // @[dec_tlu_ctl.scala 813:89]
  wire  csr_pkt_presync = csr_read_io_csr_pkt_presync; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_864 = csr_pkt_presync & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 1014:42]
  wire  _T_865 = ~io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 1014:67]
  wire  csr_pkt_postsync = csr_read_io_csr_pkt_postsync; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  csr_pkt_csr_dcsr = csr_read_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  csr_pkt_csr_dpc = csr_read_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_874 = csr_pkt_csr_dcsr | csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 1019:55]
  wire  csr_pkt_csr_dmst = csr_read_io_csr_pkt_csr_dmst; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_875 = _T_874 | csr_pkt_csr_dmst; // @[dec_tlu_ctl.scala 1019:73]
  wire  csr_pkt_csr_dicawics = csr_read_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_876 = _T_875 | csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 1019:92]
  wire  csr_pkt_csr_dicad0 = csr_read_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_877 = _T_876 | csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 1019:115]
  wire  csr_pkt_csr_dicad0h = csr_read_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_878 = _T_877 | csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 1019:136]
  wire  csr_pkt_csr_dicad1 = csr_read_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_879 = _T_878 | csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 1019:158]
  wire  csr_pkt_csr_dicago = csr_read_io_csr_pkt_csr_dicago; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_880 = _T_879 | csr_pkt_csr_dicago; // @[dec_tlu_ctl.scala 1019:179]
  wire  _T_881 = ~_T_880; // @[dec_tlu_ctl.scala 1019:36]
  wire  _T_882 = _T_881 | dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 1019:201]
  wire  csr_pkt_legal = csr_read_io_csr_pkt_legal; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_883 = csr_pkt_legal & _T_882; // @[dec_tlu_ctl.scala 1019:33]
  wire  _T_884 = ~fast_int_meicpct; // @[dec_tlu_ctl.scala 1019:223]
  wire  valid_csr = _T_883 & _T_884; // @[dec_tlu_ctl.scala 1019:221]
  wire  _T_887 = io_dec_csr_any_unq_d & valid_csr; // @[dec_tlu_ctl.scala 1021:46]
  wire  csr_pkt_csr_mvendorid = csr_read_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  csr_pkt_csr_marchid = csr_read_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_888 = csr_pkt_csr_mvendorid | csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 1021:107]
  wire  csr_pkt_csr_mimpid = csr_read_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_889 = _T_888 | csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 1021:129]
  wire  csr_pkt_csr_mhartid = csr_read_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_890 = _T_889 | csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 1021:150]
  wire  csr_pkt_csr_mdseac = csr_read_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_891 = _T_890 | csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 1021:172]
  wire  csr_pkt_csr_meihap = csr_read_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 270:41 dec_tlu_ctl.scala 1012:16]
  wire  _T_892 = _T_891 | csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 1021:193]
  wire  _T_893 = io_dec_csr_wen_unq_d & _T_892; // @[dec_tlu_ctl.scala 1021:82]
  wire  _T_894 = ~_T_893; // @[dec_tlu_ctl.scala 1021:59]
  dec_timer_ctl int_timers ( // @[dec_tlu_ctl.scala 274:30]
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
  csr_tlu csr ( // @[dec_tlu_ctl.scala 817:15]
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
  dec_decode_csr_read csr_read ( // @[dec_tlu_ctl.scala 1010:22]
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
  assign io_tlu_exu_dec_tlu_meihap = csr_io_dec_tlu_meihap; // @[dec_tlu_ctl.scala 876:52]
  assign io_tlu_exu_dec_tlu_flush_lower_r = _T_801 | take_ext_int_start; // @[dec_tlu_ctl.scala 802:49]
  assign io_tlu_exu_dec_tlu_flush_path_r = take_reset ? io_rst_vec : _T_852; // @[dec_tlu_ctl.scala 803:49]
  assign io_tlu_dma_dec_tlu_dma_qos_prty = csr_io_dec_tlu_dma_qos_prty; // @[dec_tlu_ctl.scala 906:48]
  assign io_dec_dbg_cmd_done = io_dec_tlu_i0_valid_r & io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 487:29]
  assign io_dec_dbg_cmd_fail = illegal_r & io_dec_dbg_cmd_done; // @[dec_tlu_ctl.scala 488:29]
  assign io_dec_tlu_dbg_halted = dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 469:41]
  assign io_dec_tlu_debug_mode = debug_mode_status; // @[dec_tlu_ctl.scala 470:41]
  assign io_dec_tlu_resume_ack = _T_190; // @[dec_tlu_ctl.scala 453:49]
  assign io_dec_tlu_debug_stall = debug_halt_req_f; // @[dec_tlu_ctl.scala 468:41]
  assign io_dec_tlu_mpc_halted_only = _T_65; // @[dec_tlu_ctl.scala 368:49]
  assign io_dec_tlu_flush_extint = ext_int_ready & _T_704; // @[dec_tlu_ctl.scala 476:33]
  assign io_trigger_pkt_any_0_select = csr_io_trigger_pkt_any_0_select; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_0_match_pkt = csr_io_trigger_pkt_any_0_match_pkt; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_0_store = csr_io_trigger_pkt_any_0_store; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_0_load = csr_io_trigger_pkt_any_0_load; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_0_execute = csr_io_trigger_pkt_any_0_execute; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_0_m = csr_io_trigger_pkt_any_0_m; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_0_tdata2 = csr_io_trigger_pkt_any_0_tdata2; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_select = csr_io_trigger_pkt_any_1_select; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_match_pkt = csr_io_trigger_pkt_any_1_match_pkt; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_store = csr_io_trigger_pkt_any_1_store; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_load = csr_io_trigger_pkt_any_1_load; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_execute = csr_io_trigger_pkt_any_1_execute; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_m = csr_io_trigger_pkt_any_1_m; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_1_tdata2 = csr_io_trigger_pkt_any_1_tdata2; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_select = csr_io_trigger_pkt_any_2_select; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_match_pkt = csr_io_trigger_pkt_any_2_match_pkt; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_store = csr_io_trigger_pkt_any_2_store; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_load = csr_io_trigger_pkt_any_2_load; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_execute = csr_io_trigger_pkt_any_2_execute; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_m = csr_io_trigger_pkt_any_2_m; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_2_tdata2 = csr_io_trigger_pkt_any_2_tdata2; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_select = csr_io_trigger_pkt_any_3_select; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_match_pkt = csr_io_trigger_pkt_any_3_match_pkt; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_store = csr_io_trigger_pkt_any_3_store; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_load = csr_io_trigger_pkt_any_3_load; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_execute = csr_io_trigger_pkt_any_3_execute; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_m = csr_io_trigger_pkt_any_3_m; // @[dec_tlu_ctl.scala 882:40]
  assign io_trigger_pkt_any_3_tdata2 = csr_io_trigger_pkt_any_3_tdata2; // @[dec_tlu_ctl.scala 882:40]
  assign io_o_cpu_halt_status = _T_353; // @[dec_tlu_ctl.scala 573:49]
  assign io_o_cpu_halt_ack = _T_354; // @[dec_tlu_ctl.scala 574:49]
  assign io_o_cpu_run_ack = _T_355; // @[dec_tlu_ctl.scala 575:49]
  assign io_o_debug_mode_status = debug_mode_status; // @[dec_tlu_ctl.scala 596:27]
  assign io_mpc_debug_halt_ack = mpc_debug_halt_ack_f; // @[dec_tlu_ctl.scala 393:31]
  assign io_mpc_debug_run_ack = mpc_debug_run_ack_f; // @[dec_tlu_ctl.scala 394:31]
  assign io_debug_brkpt_status = debug_brkpt_status_f; // @[dec_tlu_ctl.scala 395:31]
  assign io_dec_csr_rddata_d = csr_io_dec_csr_rddata_d; // @[dec_tlu_ctl.scala 897:40]
  assign io_dec_csr_legal_d = _T_887 & _T_894; // @[dec_tlu_ctl.scala 1021:20]
  assign io_dec_tlu_i0_kill_writeb_wb = _T_32; // @[dec_tlu_ctl.scala 328:41]
  assign io_dec_tlu_i0_kill_writeb_r = _T_427 | i0_trigger_hit_raw_r; // @[dec_tlu_ctl.scala 334:41]
  assign io_dec_tlu_wr_pause_r = csr_io_dec_tlu_wr_pause_r; // @[dec_tlu_ctl.scala 899:40]
  assign io_dec_tlu_flush_pause_r = _T_208 & _T_209; // @[dec_tlu_ctl.scala 479:34]
  assign io_dec_tlu_presync_d = _T_864 & _T_865; // @[dec_tlu_ctl.scala 1014:23]
  assign io_dec_tlu_postsync_d = csr_pkt_postsync & io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 1015:23]
  assign io_dec_tlu_perfcnt0 = csr_io_dec_tlu_perfcnt0; // @[dec_tlu_ctl.scala 885:40]
  assign io_dec_tlu_perfcnt1 = csr_io_dec_tlu_perfcnt1; // @[dec_tlu_ctl.scala 886:40]
  assign io_dec_tlu_perfcnt2 = csr_io_dec_tlu_perfcnt2; // @[dec_tlu_ctl.scala 887:40]
  assign io_dec_tlu_perfcnt3 = csr_io_dec_tlu_perfcnt3; // @[dec_tlu_ctl.scala 888:40]
  assign io_dec_tlu_i0_exc_valid_wb1 = csr_io_dec_tlu_i0_exc_valid_wb1; // @[dec_tlu_ctl.scala 879:44]
  assign io_dec_tlu_i0_valid_wb1 = csr_io_dec_tlu_i0_valid_wb1; // @[dec_tlu_ctl.scala 880:44]
  assign io_dec_tlu_int_valid_wb1 = csr_io_dec_tlu_int_valid_wb1; // @[dec_tlu_ctl.scala 878:44]
  assign io_dec_tlu_exc_cause_wb1 = csr_io_dec_tlu_exc_cause_wb1; // @[dec_tlu_ctl.scala 884:40]
  assign io_dec_tlu_mtval_wb1 = csr_io_dec_tlu_mtval_wb1; // @[dec_tlu_ctl.scala 883:40]
  assign io_dec_tlu_pipelining_disable = csr_io_dec_tlu_pipelining_disable; // @[dec_tlu_ctl.scala 898:40]
  assign io_dec_tlu_misc_clk_override = csr_io_dec_tlu_misc_clk_override; // @[dec_tlu_ctl.scala 889:40]
  assign io_dec_tlu_dec_clk_override = csr_io_dec_tlu_dec_clk_override; // @[dec_tlu_ctl.scala 890:40]
  assign io_dec_tlu_ifu_clk_override = csr_io_dec_tlu_ifu_clk_override; // @[dec_tlu_ctl.scala 891:40]
  assign io_dec_tlu_lsu_clk_override = csr_io_dec_tlu_lsu_clk_override; // @[dec_tlu_ctl.scala 892:40]
  assign io_dec_tlu_bus_clk_override = csr_io_dec_tlu_bus_clk_override; // @[dec_tlu_ctl.scala 893:40]
  assign io_dec_tlu_pic_clk_override = csr_io_dec_tlu_pic_clk_override; // @[dec_tlu_ctl.scala 894:40]
  assign io_dec_tlu_dccm_clk_override = csr_io_dec_tlu_dccm_clk_override; // @[dec_tlu_ctl.scala 895:40]
  assign io_dec_tlu_icm_clk_override = csr_io_dec_tlu_icm_clk_override; // @[dec_tlu_ctl.scala 896:40]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_valid = _T_459 & _T_462; // @[dec_tlu_ctl.scala 652:57]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist = io_tlu_exu_exu_i0_br_hist_r; // @[dec_tlu_ctl.scala 649:65]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error = _T_453 & _T_429; // @[dec_tlu_ctl.scala 650:57]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error = _T_455 & _T_429; // @[dec_tlu_ctl.scala 651:57]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_way = io_exu_i0_br_way_r; // @[dec_tlu_ctl.scala 653:65]
  assign io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle = io_tlu_exu_exu_i0_br_middle_r; // @[dec_tlu_ctl.scala 654:65]
  assign io_tlu_bp_dec_tlu_flush_lower_wb = tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 800:49]
  assign io_tlu_bp_dec_tlu_flush_leak_one_wb = _T_233 & _T_234; // @[dec_tlu_ctl.scala 483:45]
  assign io_tlu_bp_dec_tlu_bpred_disable = csr_io_dec_tlu_bpred_disable; // @[dec_tlu_ctl.scala 902:47]
  assign io_tlu_ifc_dec_tlu_flush_noredir_wb = _T_205 | take_ext_int_start; // @[dec_tlu_ctl.scala 474:45]
  assign io_tlu_ifc_dec_tlu_mrac_ff = csr_io_dec_tlu_mrac_ff; // @[dec_tlu_ctl.scala 900:48]
  assign io_tlu_mem_dec_tlu_flush_lower_wb = io_tlu_bp_dec_tlu_flush_lower_wb; // @[dec_tlu_ctl.scala 801:41]
  assign io_tlu_mem_dec_tlu_flush_err_wb = io_tlu_exu_dec_tlu_flush_lower_r & _T_433; // @[dec_tlu_ctl.scala 484:41]
  assign io_tlu_mem_dec_tlu_i0_commit_cmt = _T_422 & _T_465; // @[dec_tlu_ctl.scala 627:37]
  assign io_tlu_mem_dec_tlu_force_halt = _T_33; // @[dec_tlu_ctl.scala 330:57]
  assign io_tlu_mem_dec_tlu_fence_i_wb = _T_492 & _T_470; // @[dec_tlu_ctl.scala 672:39]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata = csr_io_dec_tlu_ic_diag_pkt_icache_wrdata; // @[dec_tlu_ctl.scala 881:52]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics = csr_io_dec_tlu_ic_diag_pkt_icache_dicawics; // @[dec_tlu_ctl.scala 881:52]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid = csr_io_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[dec_tlu_ctl.scala 881:52]
  assign io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid = csr_io_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[dec_tlu_ctl.scala 881:52]
  assign io_tlu_mem_dec_tlu_core_ecc_disable = csr_io_dec_tlu_core_ecc_disable; // @[dec_tlu_ctl.scala 904:48]
  assign io_tlu_busbuff_dec_tlu_external_ldfwd_disable = csr_io_dec_tlu_external_ldfwd_disable; // @[dec_tlu_ctl.scala 905:52]
  assign io_tlu_busbuff_dec_tlu_wb_coalescing_disable = csr_io_dec_tlu_wb_coalescing_disable; // @[dec_tlu_ctl.scala 901:52]
  assign io_tlu_busbuff_dec_tlu_sideeffect_posted_disable = csr_io_dec_tlu_sideeffect_posted_disable; // @[dec_tlu_ctl.scala 903:52]
  assign io_dec_pic_dec_tlu_meicurpl = csr_io_dec_tlu_meicurpl; // @[dec_tlu_ctl.scala 875:52]
  assign io_dec_pic_dec_tlu_meipt = csr_io_dec_tlu_meipt; // @[dec_tlu_ctl.scala 877:52]
  assign int_timers_clock = clock;
  assign int_timers_reset = reset;
  assign int_timers_io_free_clk = io_free_clk; // @[dec_tlu_ctl.scala 275:57]
  assign int_timers_io_scan_mode = io_scan_mode; // @[dec_tlu_ctl.scala 276:57]
  assign int_timers_io_dec_csr_wen_r_mod = csr_io_dec_csr_wen_r_mod; // @[dec_tlu_ctl.scala 277:49]
  assign int_timers_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 279:49]
  assign int_timers_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 280:49]
  assign int_timers_io_csr_mitctl0 = csr_read_io_csr_pkt_csr_mitctl0; // @[dec_tlu_ctl.scala 281:57]
  assign int_timers_io_csr_mitctl1 = csr_read_io_csr_pkt_csr_mitctl1; // @[dec_tlu_ctl.scala 282:57]
  assign int_timers_io_csr_mitb0 = csr_read_io_csr_pkt_csr_mitb0; // @[dec_tlu_ctl.scala 283:57]
  assign int_timers_io_csr_mitb1 = csr_read_io_csr_pkt_csr_mitb1; // @[dec_tlu_ctl.scala 284:57]
  assign int_timers_io_csr_mitcnt0 = csr_read_io_csr_pkt_csr_mitcnt0; // @[dec_tlu_ctl.scala 285:57]
  assign int_timers_io_csr_mitcnt1 = csr_read_io_csr_pkt_csr_mitcnt1; // @[dec_tlu_ctl.scala 286:57]
  assign int_timers_io_dec_pause_state = io_dec_pause_state; // @[dec_tlu_ctl.scala 287:49]
  assign int_timers_io_dec_tlu_pmu_fw_halted = pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 288:49]
  assign int_timers_io_internal_dbg_halt_timers = debug_mode_status & _T_665; // @[dec_tlu_ctl.scala 289:47]
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
  assign csr_io_free_clk = io_free_clk; // @[dec_tlu_ctl.scala 818:44]
  assign csr_io_active_clk = io_active_clk; // @[dec_tlu_ctl.scala 819:44]
  assign csr_io_scan_mode = io_scan_mode; // @[dec_tlu_ctl.scala 820:44]
  assign csr_io_dec_csr_wrdata_r = io_dec_csr_wrdata_r; // @[dec_tlu_ctl.scala 821:44]
  assign csr_io_dec_csr_wraddr_r = io_dec_csr_wraddr_r; // @[dec_tlu_ctl.scala 822:44]
  assign csr_io_dec_csr_rdaddr_d = io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 823:44]
  assign csr_io_dec_csr_wen_unq_d = io_dec_csr_wen_unq_d; // @[dec_tlu_ctl.scala 824:44]
  assign csr_io_dec_i0_decode_d = io_dec_i0_decode_d; // @[dec_tlu_ctl.scala 825:44]
  assign csr_io_ifu_ic_debug_rd_data_valid = io_tlu_mem_ifu_ic_debug_rd_data_valid; // @[dec_tlu_ctl.scala 826:44]
  assign csr_io_ifu_pmu_bus_trxn = io_tlu_mem_ifu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 827:44]
  assign csr_io_dma_iccm_stall_any = io_tlu_dma_dma_iccm_stall_any; // @[dec_tlu_ctl.scala 828:44]
  assign csr_io_dma_dccm_stall_any = io_tlu_dma_dma_dccm_stall_any; // @[dec_tlu_ctl.scala 829:44]
  assign csr_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[dec_tlu_ctl.scala 830:44]
  assign csr_io_dec_pmu_presync_stall = io_dec_pmu_presync_stall; // @[dec_tlu_ctl.scala 831:44]
  assign csr_io_dec_pmu_postsync_stall = io_dec_pmu_postsync_stall; // @[dec_tlu_ctl.scala 832:44]
  assign csr_io_dec_pmu_decode_stall = io_dec_pmu_decode_stall; // @[dec_tlu_ctl.scala 833:44]
  assign csr_io_ifu_pmu_fetch_stall = io_tlu_ifc_ifu_pmu_fetch_stall; // @[dec_tlu_ctl.scala 834:44]
  assign csr_io_dec_tlu_packet_r_icaf_type = io_dec_tlu_packet_r_icaf_type; // @[dec_tlu_ctl.scala 835:44]
  assign csr_io_dec_tlu_packet_r_pmu_i0_itype = io_dec_tlu_packet_r_pmu_i0_itype; // @[dec_tlu_ctl.scala 835:44]
  assign csr_io_dec_tlu_packet_r_pmu_i0_br_unpred = io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec_tlu_ctl.scala 835:44]
  assign csr_io_dec_tlu_packet_r_pmu_divide = io_dec_tlu_packet_r_pmu_divide; // @[dec_tlu_ctl.scala 835:44]
  assign csr_io_dec_tlu_packet_r_pmu_lsu_misaligned = io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec_tlu_ctl.scala 835:44]
  assign csr_io_exu_pmu_i0_br_ataken = io_tlu_exu_exu_pmu_i0_br_ataken; // @[dec_tlu_ctl.scala 836:44]
  assign csr_io_exu_pmu_i0_br_misp = io_tlu_exu_exu_pmu_i0_br_misp; // @[dec_tlu_ctl.scala 837:44]
  assign csr_io_dec_pmu_instr_decoded = io_dec_pmu_instr_decoded; // @[dec_tlu_ctl.scala 838:44]
  assign csr_io_ifu_pmu_instr_aligned = io_ifu_pmu_instr_aligned; // @[dec_tlu_ctl.scala 839:44]
  assign csr_io_exu_pmu_i0_pc4 = io_tlu_exu_exu_pmu_i0_pc4; // @[dec_tlu_ctl.scala 840:44]
  assign csr_io_ifu_pmu_ic_miss = io_tlu_mem_ifu_pmu_ic_miss; // @[dec_tlu_ctl.scala 841:44]
  assign csr_io_ifu_pmu_ic_hit = io_tlu_mem_ifu_pmu_ic_hit; // @[dec_tlu_ctl.scala 842:44]
  assign csr_io_dec_csr_wen_r = io_dec_csr_wen_r; // @[dec_tlu_ctl.scala 843:44]
  assign csr_io_dec_tlu_dbg_halted = io_dec_tlu_dbg_halted; // @[dec_tlu_ctl.scala 844:44]
  assign csr_io_dma_pmu_dccm_write = io_tlu_dma_dma_pmu_dccm_write; // @[dec_tlu_ctl.scala 845:44]
  assign csr_io_dma_pmu_dccm_read = io_tlu_dma_dma_pmu_dccm_read; // @[dec_tlu_ctl.scala 846:44]
  assign csr_io_dma_pmu_any_write = io_tlu_dma_dma_pmu_any_write; // @[dec_tlu_ctl.scala 847:44]
  assign csr_io_dma_pmu_any_read = io_tlu_dma_dma_pmu_any_read; // @[dec_tlu_ctl.scala 848:44]
  assign csr_io_lsu_pmu_bus_busy = io_tlu_busbuff_lsu_pmu_bus_busy; // @[dec_tlu_ctl.scala 849:44]
  assign csr_io_dec_tlu_i0_pc_r = io_dec_tlu_i0_pc_r; // @[dec_tlu_ctl.scala 850:44]
  assign csr_io_dec_tlu_i0_valid_r = io_dec_tlu_i0_valid_r; // @[dec_tlu_ctl.scala 851:44]
  assign csr_io_dec_csr_any_unq_d = io_dec_csr_any_unq_d; // @[dec_tlu_ctl.scala 853:44]
  assign csr_io_ifu_pmu_bus_busy = io_tlu_mem_ifu_pmu_bus_busy; // @[dec_tlu_ctl.scala 854:44]
  assign csr_io_lsu_pmu_bus_error = io_tlu_busbuff_lsu_pmu_bus_error; // @[dec_tlu_ctl.scala 855:44]
  assign csr_io_ifu_pmu_bus_error = io_tlu_mem_ifu_pmu_bus_error; // @[dec_tlu_ctl.scala 856:44]
  assign csr_io_lsu_pmu_bus_misaligned = io_tlu_busbuff_lsu_pmu_bus_misaligned; // @[dec_tlu_ctl.scala 857:44]
  assign csr_io_lsu_pmu_bus_trxn = io_tlu_busbuff_lsu_pmu_bus_trxn; // @[dec_tlu_ctl.scala 858:44]
  assign csr_io_ifu_ic_debug_rd_data = io_tlu_mem_ifu_ic_debug_rd_data; // @[dec_tlu_ctl.scala 859:44]
  assign csr_io_pic_pl = io_dec_pic_pic_pl; // @[dec_tlu_ctl.scala 860:44]
  assign csr_io_pic_claimid = io_dec_pic_pic_claimid; // @[dec_tlu_ctl.scala 861:44]
  assign csr_io_iccm_dma_sb_error = io_iccm_dma_sb_error; // @[dec_tlu_ctl.scala 862:44]
  assign csr_io_lsu_imprecise_error_addr_any = io_tlu_busbuff_lsu_imprecise_error_addr_any; // @[dec_tlu_ctl.scala 863:44]
  assign csr_io_lsu_imprecise_error_load_any = io_tlu_busbuff_lsu_imprecise_error_load_any; // @[dec_tlu_ctl.scala 864:44]
  assign csr_io_lsu_imprecise_error_store_any = io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec_tlu_ctl.scala 865:44]
  assign csr_io_dec_illegal_inst = io_dec_illegal_inst; // @[dec_tlu_ctl.scala 866:44 dec_tlu_ctl.scala 907:44]
  assign csr_io_lsu_error_pkt_r_bits_mscause = io_lsu_error_pkt_r_bits_mscause; // @[dec_tlu_ctl.scala 867:44 dec_tlu_ctl.scala 908:44]
  assign csr_io_mexintpend = io_dec_pic_mexintpend; // @[dec_tlu_ctl.scala 868:44 dec_tlu_ctl.scala 909:44]
  assign csr_io_exu_npc_r = io_tlu_exu_exu_npc_r; // @[dec_tlu_ctl.scala 869:44 dec_tlu_ctl.scala 910:44]
  assign csr_io_mpc_reset_run_req = io_mpc_reset_run_req; // @[dec_tlu_ctl.scala 870:44 dec_tlu_ctl.scala 911:44]
  assign csr_io_rst_vec = io_rst_vec; // @[dec_tlu_ctl.scala 871:44 dec_tlu_ctl.scala 912:44]
  assign csr_io_core_id = io_core_id; // @[dec_tlu_ctl.scala 872:44 dec_tlu_ctl.scala 913:44]
  assign csr_io_dec_timer_rddata_d = int_timers_io_dec_timer_rddata_d; // @[dec_tlu_ctl.scala 873:44 dec_tlu_ctl.scala 914:44]
  assign csr_io_dec_timer_read_d = int_timers_io_dec_timer_read_d; // @[dec_tlu_ctl.scala 874:44 dec_tlu_ctl.scala 915:44]
  assign csr_io_rfpc_i0_r = _T_438 & _T_439; // @[dec_tlu_ctl.scala 918:39]
  assign csr_io_i0_trigger_hit_r = |i0_trigger_chain_masked_r; // @[dec_tlu_ctl.scala 919:39]
  assign csr_io_exc_or_int_valid_r = _T_855 | mepc_trigger_hit_sel_pc_r; // @[dec_tlu_ctl.scala 920:39]
  assign csr_io_mret_r = _T_487 & _T_470; // @[dec_tlu_ctl.scala 921:39]
  assign csr_io_dcsr_single_step_running_f = dcsr_single_step_running_f; // @[dec_tlu_ctl.scala 922:39]
  assign csr_io_dec_timer_t0_pulse = int_timers_io_dec_timer_t0_pulse; // @[dec_tlu_ctl.scala 923:39]
  assign csr_io_dec_timer_t1_pulse = int_timers_io_dec_timer_t1_pulse; // @[dec_tlu_ctl.scala 924:39]
  assign csr_io_timer_int_sync = syncro_ff[5]; // @[dec_tlu_ctl.scala 925:39]
  assign csr_io_soft_int_sync = syncro_ff[4]; // @[dec_tlu_ctl.scala 926:39]
  assign csr_io_csr_wr_clk = rvclkhdr_io_l1clk; // @[dec_tlu_ctl.scala 927:39]
  assign csr_io_ebreak_to_debug_mode_r = _T_519 & _T_470; // @[dec_tlu_ctl.scala 928:39]
  assign csr_io_dec_tlu_pmu_fw_halted = pmu_fw_tlu_halted_f; // @[dec_tlu_ctl.scala 929:39]
  assign csr_io_lsu_fir_error = io_lsu_fir_error; // @[dec_tlu_ctl.scala 930:39]
  assign csr_io_tlu_flush_lower_r_d1 = tlu_flush_lower_r_d1; // @[dec_tlu_ctl.scala 931:39]
  assign csr_io_dec_tlu_flush_noredir_r_d1 = dec_tlu_flush_noredir_r_d1; // @[dec_tlu_ctl.scala 932:39]
  assign csr_io_tlu_flush_path_r_d1 = tlu_flush_path_r_d1; // @[dec_tlu_ctl.scala 933:39]
  assign csr_io_reset_delayed = reset_detect ^ reset_detected; // @[dec_tlu_ctl.scala 934:39]
  assign csr_io_interrupt_valid_r = _T_766 | take_int_timer1_int; // @[dec_tlu_ctl.scala 935:39]
  assign csr_io_i0_exception_valid_r = _T_527 & _T_528; // @[dec_tlu_ctl.scala 936:39]
  assign csr_io_lsu_exc_valid_r = _T_405 & _T_470; // @[dec_tlu_ctl.scala 937:39]
  assign csr_io_mepc_trigger_hit_sel_pc_r = i0_trigger_hit_raw_r & _T_345; // @[dec_tlu_ctl.scala 938:39]
  assign csr_io_e4e5_int_clk = rvclkhdr_3_io_l1clk; // @[dec_tlu_ctl.scala 939:39]
  assign csr_io_lsu_i0_exc_r = _T_405 & _T_470; // @[dec_tlu_ctl.scala 940:39]
  assign csr_io_inst_acc_r = _T_511 & _T_465; // @[dec_tlu_ctl.scala 941:39]
  assign csr_io_inst_acc_second_r = io_dec_tlu_packet_r_icaf_f1; // @[dec_tlu_ctl.scala 942:39]
  assign csr_io_take_nmi = _T_756 & _T_760; // @[dec_tlu_ctl.scala 943:39]
  assign csr_io_lsu_error_pkt_addr_r = io_lsu_error_pkt_r_bits_addr; // @[dec_tlu_ctl.scala 944:39]
  assign csr_io_exc_cause_r = _T_603 | _T_591; // @[dec_tlu_ctl.scala 945:39]
  assign csr_io_i0_valid_wb = i0_valid_wb; // @[dec_tlu_ctl.scala 946:39]
  assign csr_io_exc_or_int_valid_r_d1 = exc_or_int_valid_r_d1; // @[dec_tlu_ctl.scala 947:39]
  assign csr_io_interrupt_valid_r_d1 = interrupt_valid_r_d1; // @[dec_tlu_ctl.scala 948:39]
  assign csr_io_clk_override = io_dec_tlu_dec_clk_override; // @[dec_tlu_ctl.scala 949:39]
  assign csr_io_i0_exception_valid_r_d1 = i0_exception_valid_r_d1; // @[dec_tlu_ctl.scala 950:39]
  assign csr_io_lsu_i0_exc_r_d1 = lsu_i0_exc_r_d1; // @[dec_tlu_ctl.scala 951:39]
  assign csr_io_exc_cause_wb = exc_cause_wb; // @[dec_tlu_ctl.scala 952:39]
  assign csr_io_nmi_lsu_store_type = _T_58 | _T_60; // @[dec_tlu_ctl.scala 953:39]
  assign csr_io_nmi_lsu_load_type = _T_50 | _T_52; // @[dec_tlu_ctl.scala 954:39]
  assign csr_io_tlu_i0_commit_cmt = _T_422 & _T_465; // @[dec_tlu_ctl.scala 955:39]
  assign csr_io_ebreak_r = _T_469 & _T_470; // @[dec_tlu_ctl.scala 956:39]
  assign csr_io_ecall_r = _T_475 & _T_470; // @[dec_tlu_ctl.scala 957:39]
  assign csr_io_illegal_r = _T_481 & _T_470; // @[dec_tlu_ctl.scala 958:39]
  assign csr_io_mdseac_locked_f = mdseac_locked_f; // @[dec_tlu_ctl.scala 959:39]
  assign csr_io_nmi_int_detected_f = nmi_int_detected_f; // @[dec_tlu_ctl.scala 960:39]
  assign csr_io_internal_dbg_halt_mode_f2 = internal_dbg_halt_mode_f2; // @[dec_tlu_ctl.scala 961:39]
  assign csr_io_ext_int_freeze_d1 = ext_int_freeze_d1; // @[dec_tlu_ctl.scala 962:39]
  assign csr_io_ic_perr_r_d1 = ic_perr_r_d1; // @[dec_tlu_ctl.scala 963:39]
  assign csr_io_iccm_sbecc_r_d1 = iccm_sbecc_r_d1; // @[dec_tlu_ctl.scala 964:39]
  assign csr_io_lsu_single_ecc_error_r_d1 = lsu_single_ecc_error_r_d1; // @[dec_tlu_ctl.scala 965:39]
  assign csr_io_ifu_miss_state_idle_f = ifu_miss_state_idle_f; // @[dec_tlu_ctl.scala 966:39]
  assign csr_io_lsu_idle_any_f = lsu_idle_any_f; // @[dec_tlu_ctl.scala 967:39]
  assign csr_io_dbg_tlu_halted_f = dbg_tlu_halted_f; // @[dec_tlu_ctl.scala 968:39]
  assign csr_io_dbg_tlu_halted = _T_164 | _T_166; // @[dec_tlu_ctl.scala 969:39]
  assign csr_io_debug_halt_req_f = debug_halt_req_f; // @[dec_tlu_ctl.scala 970:51]
  assign csr_io_take_ext_int_start = ext_int_ready & _T_704; // @[dec_tlu_ctl.scala 971:47]
  assign csr_io_trigger_hit_dmode_r_d1 = trigger_hit_dmode_r_d1; // @[dec_tlu_ctl.scala 972:43]
  assign csr_io_trigger_hit_r_d1 = trigger_hit_r_d1; // @[dec_tlu_ctl.scala 973:43]
  assign csr_io_dcsr_single_step_done_f = dcsr_single_step_done_f; // @[dec_tlu_ctl.scala 974:43]
  assign csr_io_ebreak_to_debug_mode_r_d1 = ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 975:39]
  assign csr_io_debug_halt_req = _T_114 & _T_107; // @[dec_tlu_ctl.scala 976:51]
  assign csr_io_allow_dbg_halt_csr_write = debug_mode_status & _T_77; // @[dec_tlu_ctl.scala 977:39]
  assign csr_io_internal_dbg_halt_mode_f = debug_mode_status; // @[dec_tlu_ctl.scala 978:39]
  assign csr_io_enter_debug_halt_req = _T_155 | ebreak_to_debug_mode_r_d1; // @[dec_tlu_ctl.scala 979:39]
  assign csr_io_internal_dbg_halt_mode = debug_halt_req_ns | _T_160; // @[dec_tlu_ctl.scala 980:39]
  assign csr_io_request_debug_mode_done = _T_183 & _T_136; // @[dec_tlu_ctl.scala 981:39]
  assign csr_io_request_debug_mode_r = _T_180 | _T_182; // @[dec_tlu_ctl.scala 982:39]
  assign csr_io_update_hit_bit_r = _T_342 & i0_trigger_chain_masked_r; // @[dec_tlu_ctl.scala 983:39]
  assign csr_io_take_timer_int = _T_703 & _T_704; // @[dec_tlu_ctl.scala 984:39]
  assign csr_io_take_int_timer0_int = _T_717 & _T_704; // @[dec_tlu_ctl.scala 985:39]
  assign csr_io_take_int_timer1_int = _T_734 & _T_704; // @[dec_tlu_ctl.scala 986:39]
  assign csr_io_take_ext_int = take_ext_int_start_d3 & _T_685; // @[dec_tlu_ctl.scala 987:39]
  assign csr_io_tlu_flush_lower_r = _T_801 | take_ext_int_start; // @[dec_tlu_ctl.scala 988:39]
  assign csr_io_dec_tlu_br0_error_r = _T_453 & _T_429; // @[dec_tlu_ctl.scala 989:39]
  assign csr_io_dec_tlu_br0_start_error_r = _T_455 & _T_429; // @[dec_tlu_ctl.scala 990:39]
  assign csr_io_lsu_pmu_load_external_r = lsu_pmu_load_external_r; // @[dec_tlu_ctl.scala 991:39]
  assign csr_io_lsu_pmu_store_external_r = lsu_pmu_store_external_r; // @[dec_tlu_ctl.scala 992:39]
  assign csr_io_csr_pkt_csr_misa = csr_read_io_csr_pkt_csr_misa; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mvendorid = csr_read_io_csr_pkt_csr_mvendorid; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_marchid = csr_read_io_csr_pkt_csr_marchid; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mimpid = csr_read_io_csr_pkt_csr_mimpid; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhartid = csr_read_io_csr_pkt_csr_mhartid; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mstatus = csr_read_io_csr_pkt_csr_mstatus; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mtvec = csr_read_io_csr_pkt_csr_mtvec; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mip = csr_read_io_csr_pkt_csr_mip; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mie = csr_read_io_csr_pkt_csr_mie; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mcyclel = csr_read_io_csr_pkt_csr_mcyclel; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mcycleh = csr_read_io_csr_pkt_csr_mcycleh; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_minstretl = csr_read_io_csr_pkt_csr_minstretl; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_minstreth = csr_read_io_csr_pkt_csr_minstreth; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mscratch = csr_read_io_csr_pkt_csr_mscratch; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mepc = csr_read_io_csr_pkt_csr_mepc; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mcause = csr_read_io_csr_pkt_csr_mcause; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mscause = csr_read_io_csr_pkt_csr_mscause; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mtval = csr_read_io_csr_pkt_csr_mtval; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mrac = csr_read_io_csr_pkt_csr_mrac; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mdseac = csr_read_io_csr_pkt_csr_mdseac; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_meihap = csr_read_io_csr_pkt_csr_meihap; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_meivt = csr_read_io_csr_pkt_csr_meivt; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_meipt = csr_read_io_csr_pkt_csr_meipt; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_meicurpl = csr_read_io_csr_pkt_csr_meicurpl; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_meicidpl = csr_read_io_csr_pkt_csr_meicidpl; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_dcsr = csr_read_io_csr_pkt_csr_dcsr; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mcgc = csr_read_io_csr_pkt_csr_mcgc; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mfdc = csr_read_io_csr_pkt_csr_mfdc; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_dpc = csr_read_io_csr_pkt_csr_dpc; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mtsel = csr_read_io_csr_pkt_csr_mtsel; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mtdata1 = csr_read_io_csr_pkt_csr_mtdata1; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mtdata2 = csr_read_io_csr_pkt_csr_mtdata2; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc3 = csr_read_io_csr_pkt_csr_mhpmc3; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc4 = csr_read_io_csr_pkt_csr_mhpmc4; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc5 = csr_read_io_csr_pkt_csr_mhpmc5; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc6 = csr_read_io_csr_pkt_csr_mhpmc6; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc3h = csr_read_io_csr_pkt_csr_mhpmc3h; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc4h = csr_read_io_csr_pkt_csr_mhpmc4h; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc5h = csr_read_io_csr_pkt_csr_mhpmc5h; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpmc6h = csr_read_io_csr_pkt_csr_mhpmc6h; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpme3 = csr_read_io_csr_pkt_csr_mhpme3; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpme4 = csr_read_io_csr_pkt_csr_mhpme4; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpme5 = csr_read_io_csr_pkt_csr_mhpme5; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mhpme6 = csr_read_io_csr_pkt_csr_mhpme6; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mcountinhibit = csr_read_io_csr_pkt_csr_mcountinhibit; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mpmc = csr_read_io_csr_pkt_csr_mpmc; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_micect = csr_read_io_csr_pkt_csr_micect; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_miccmect = csr_read_io_csr_pkt_csr_miccmect; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mdccmect = csr_read_io_csr_pkt_csr_mdccmect; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mfdht = csr_read_io_csr_pkt_csr_mfdht; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_mfdhs = csr_read_io_csr_pkt_csr_mfdhs; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_dicawics = csr_read_io_csr_pkt_csr_dicawics; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_dicad0h = csr_read_io_csr_pkt_csr_dicad0h; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_dicad0 = csr_read_io_csr_pkt_csr_dicad0; // @[dec_tlu_ctl.scala 993:39]
  assign csr_io_csr_pkt_csr_dicad1 = csr_read_io_csr_pkt_csr_dicad1; // @[dec_tlu_ctl.scala 993:39]
  assign csr_read_io_dec_csr_rdaddr_d = io_dec_csr_rdaddr_d; // @[dec_tlu_ctl.scala 1011:37]
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
      ifu_miss_state_idle_f <= io_tlu_mem_ifu_miss_state_idle;
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
      dec_tlu_flush_noredir_r_d1 <= io_tlu_ifc_dec_tlu_flush_noredir_wb;
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
      lsu_pmu_load_external_r <= io_lsu_tlu_lsu_pmu_load_external_m;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      lsu_pmu_store_external_r <= 1'h0;
    end else begin
      lsu_pmu_store_external_r <= io_lsu_tlu_lsu_pmu_store_external_m;
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
module dec_trigger(
  input         io_trigger_pkt_any_0_select,
  input         io_trigger_pkt_any_0_match_pkt,
  input         io_trigger_pkt_any_0_execute,
  input         io_trigger_pkt_any_0_m,
  input  [31:0] io_trigger_pkt_any_0_tdata2,
  input         io_trigger_pkt_any_1_select,
  input         io_trigger_pkt_any_1_match_pkt,
  input         io_trigger_pkt_any_1_execute,
  input         io_trigger_pkt_any_1_m,
  input  [31:0] io_trigger_pkt_any_1_tdata2,
  input         io_trigger_pkt_any_2_select,
  input         io_trigger_pkt_any_2_match_pkt,
  input         io_trigger_pkt_any_2_execute,
  input         io_trigger_pkt_any_2_m,
  input  [31:0] io_trigger_pkt_any_2_tdata2,
  input         io_trigger_pkt_any_3_select,
  input         io_trigger_pkt_any_3_match_pkt,
  input         io_trigger_pkt_any_3_execute,
  input         io_trigger_pkt_any_3_m,
  input  [31:0] io_trigger_pkt_any_3_tdata2,
  input  [30:0] io_dec_i0_pc_d,
  output [3:0]  io_dec_i0_trigger_match_d
);
  wire  _T = ~io_trigger_pkt_any_0_select; // @[dec_trigger.scala 14:63]
  wire  _T_1 = _T & io_trigger_pkt_any_0_execute; // @[dec_trigger.scala 14:93]
  wire [9:0] _T_11 = {_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1}; // @[Cat.scala 29:58]
  wire [18:0] _T_20 = {_T_11,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1}; // @[Cat.scala 29:58]
  wire [27:0] _T_29 = {_T_20,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1,_T_1}; // @[Cat.scala 29:58]
  wire [31:0] _T_33 = {_T_29,_T_1,_T_1,_T_1,_T_1}; // @[Cat.scala 29:58]
  wire [31:0] _T_35 = {io_dec_i0_pc_d,io_trigger_pkt_any_0_tdata2[0]}; // @[Cat.scala 29:58]
  wire [31:0] dec_i0_match_data_0 = _T_33 & _T_35; // @[dec_trigger.scala 14:127]
  wire  _T_37 = ~io_trigger_pkt_any_1_select; // @[dec_trigger.scala 14:63]
  wire  _T_38 = _T_37 & io_trigger_pkt_any_1_execute; // @[dec_trigger.scala 14:93]
  wire [9:0] _T_48 = {_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38}; // @[Cat.scala 29:58]
  wire [18:0] _T_57 = {_T_48,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38}; // @[Cat.scala 29:58]
  wire [27:0] _T_66 = {_T_57,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38,_T_38}; // @[Cat.scala 29:58]
  wire [31:0] _T_70 = {_T_66,_T_38,_T_38,_T_38,_T_38}; // @[Cat.scala 29:58]
  wire [31:0] _T_72 = {io_dec_i0_pc_d,io_trigger_pkt_any_1_tdata2[0]}; // @[Cat.scala 29:58]
  wire [31:0] dec_i0_match_data_1 = _T_70 & _T_72; // @[dec_trigger.scala 14:127]
  wire  _T_74 = ~io_trigger_pkt_any_2_select; // @[dec_trigger.scala 14:63]
  wire  _T_75 = _T_74 & io_trigger_pkt_any_2_execute; // @[dec_trigger.scala 14:93]
  wire [9:0] _T_85 = {_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75}; // @[Cat.scala 29:58]
  wire [18:0] _T_94 = {_T_85,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75}; // @[Cat.scala 29:58]
  wire [27:0] _T_103 = {_T_94,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75,_T_75}; // @[Cat.scala 29:58]
  wire [31:0] _T_107 = {_T_103,_T_75,_T_75,_T_75,_T_75}; // @[Cat.scala 29:58]
  wire [31:0] _T_109 = {io_dec_i0_pc_d,io_trigger_pkt_any_2_tdata2[0]}; // @[Cat.scala 29:58]
  wire [31:0] dec_i0_match_data_2 = _T_107 & _T_109; // @[dec_trigger.scala 14:127]
  wire  _T_111 = ~io_trigger_pkt_any_3_select; // @[dec_trigger.scala 14:63]
  wire  _T_112 = _T_111 & io_trigger_pkt_any_3_execute; // @[dec_trigger.scala 14:93]
  wire [9:0] _T_122 = {_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112}; // @[Cat.scala 29:58]
  wire [18:0] _T_131 = {_T_122,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112}; // @[Cat.scala 29:58]
  wire [27:0] _T_140 = {_T_131,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112,_T_112}; // @[Cat.scala 29:58]
  wire [31:0] _T_144 = {_T_140,_T_112,_T_112,_T_112,_T_112}; // @[Cat.scala 29:58]
  wire [31:0] _T_146 = {io_dec_i0_pc_d,io_trigger_pkt_any_3_tdata2[0]}; // @[Cat.scala 29:58]
  wire [31:0] dec_i0_match_data_3 = _T_144 & _T_146; // @[dec_trigger.scala 14:127]
  wire  _T_148 = io_trigger_pkt_any_0_execute & io_trigger_pkt_any_0_m; // @[dec_trigger.scala 15:83]
  wire  _T_151 = &io_trigger_pkt_any_0_tdata2; // @[el2_lib.scala 241:45]
  wire  _T_152 = ~_T_151; // @[el2_lib.scala 241:39]
  wire  _T_153 = io_trigger_pkt_any_0_match_pkt & _T_152; // @[el2_lib.scala 241:37]
  wire  _T_156 = io_trigger_pkt_any_0_tdata2[0] == dec_i0_match_data_0[0]; // @[el2_lib.scala 242:52]
  wire  _T_157 = _T_153 | _T_156; // @[el2_lib.scala 242:41]
  wire  _T_159 = &io_trigger_pkt_any_0_tdata2[0]; // @[el2_lib.scala 244:36]
  wire  _T_160 = _T_159 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_163 = io_trigger_pkt_any_0_tdata2[1] == dec_i0_match_data_0[1]; // @[el2_lib.scala 244:78]
  wire  _T_164 = _T_160 | _T_163; // @[el2_lib.scala 244:23]
  wire  _T_166 = &io_trigger_pkt_any_0_tdata2[1:0]; // @[el2_lib.scala 244:36]
  wire  _T_167 = _T_166 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_170 = io_trigger_pkt_any_0_tdata2[2] == dec_i0_match_data_0[2]; // @[el2_lib.scala 244:78]
  wire  _T_171 = _T_167 | _T_170; // @[el2_lib.scala 244:23]
  wire  _T_173 = &io_trigger_pkt_any_0_tdata2[2:0]; // @[el2_lib.scala 244:36]
  wire  _T_174 = _T_173 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_177 = io_trigger_pkt_any_0_tdata2[3] == dec_i0_match_data_0[3]; // @[el2_lib.scala 244:78]
  wire  _T_178 = _T_174 | _T_177; // @[el2_lib.scala 244:23]
  wire  _T_180 = &io_trigger_pkt_any_0_tdata2[3:0]; // @[el2_lib.scala 244:36]
  wire  _T_181 = _T_180 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_184 = io_trigger_pkt_any_0_tdata2[4] == dec_i0_match_data_0[4]; // @[el2_lib.scala 244:78]
  wire  _T_185 = _T_181 | _T_184; // @[el2_lib.scala 244:23]
  wire  _T_187 = &io_trigger_pkt_any_0_tdata2[4:0]; // @[el2_lib.scala 244:36]
  wire  _T_188 = _T_187 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_191 = io_trigger_pkt_any_0_tdata2[5] == dec_i0_match_data_0[5]; // @[el2_lib.scala 244:78]
  wire  _T_192 = _T_188 | _T_191; // @[el2_lib.scala 244:23]
  wire  _T_194 = &io_trigger_pkt_any_0_tdata2[5:0]; // @[el2_lib.scala 244:36]
  wire  _T_195 = _T_194 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_198 = io_trigger_pkt_any_0_tdata2[6] == dec_i0_match_data_0[6]; // @[el2_lib.scala 244:78]
  wire  _T_199 = _T_195 | _T_198; // @[el2_lib.scala 244:23]
  wire  _T_201 = &io_trigger_pkt_any_0_tdata2[6:0]; // @[el2_lib.scala 244:36]
  wire  _T_202 = _T_201 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_205 = io_trigger_pkt_any_0_tdata2[7] == dec_i0_match_data_0[7]; // @[el2_lib.scala 244:78]
  wire  _T_206 = _T_202 | _T_205; // @[el2_lib.scala 244:23]
  wire  _T_208 = &io_trigger_pkt_any_0_tdata2[7:0]; // @[el2_lib.scala 244:36]
  wire  _T_209 = _T_208 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_212 = io_trigger_pkt_any_0_tdata2[8] == dec_i0_match_data_0[8]; // @[el2_lib.scala 244:78]
  wire  _T_213 = _T_209 | _T_212; // @[el2_lib.scala 244:23]
  wire  _T_215 = &io_trigger_pkt_any_0_tdata2[8:0]; // @[el2_lib.scala 244:36]
  wire  _T_216 = _T_215 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_219 = io_trigger_pkt_any_0_tdata2[9] == dec_i0_match_data_0[9]; // @[el2_lib.scala 244:78]
  wire  _T_220 = _T_216 | _T_219; // @[el2_lib.scala 244:23]
  wire  _T_222 = &io_trigger_pkt_any_0_tdata2[9:0]; // @[el2_lib.scala 244:36]
  wire  _T_223 = _T_222 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_226 = io_trigger_pkt_any_0_tdata2[10] == dec_i0_match_data_0[10]; // @[el2_lib.scala 244:78]
  wire  _T_227 = _T_223 | _T_226; // @[el2_lib.scala 244:23]
  wire  _T_229 = &io_trigger_pkt_any_0_tdata2[10:0]; // @[el2_lib.scala 244:36]
  wire  _T_230 = _T_229 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_233 = io_trigger_pkt_any_0_tdata2[11] == dec_i0_match_data_0[11]; // @[el2_lib.scala 244:78]
  wire  _T_234 = _T_230 | _T_233; // @[el2_lib.scala 244:23]
  wire  _T_236 = &io_trigger_pkt_any_0_tdata2[11:0]; // @[el2_lib.scala 244:36]
  wire  _T_237 = _T_236 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_240 = io_trigger_pkt_any_0_tdata2[12] == dec_i0_match_data_0[12]; // @[el2_lib.scala 244:78]
  wire  _T_241 = _T_237 | _T_240; // @[el2_lib.scala 244:23]
  wire  _T_243 = &io_trigger_pkt_any_0_tdata2[12:0]; // @[el2_lib.scala 244:36]
  wire  _T_244 = _T_243 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_247 = io_trigger_pkt_any_0_tdata2[13] == dec_i0_match_data_0[13]; // @[el2_lib.scala 244:78]
  wire  _T_248 = _T_244 | _T_247; // @[el2_lib.scala 244:23]
  wire  _T_250 = &io_trigger_pkt_any_0_tdata2[13:0]; // @[el2_lib.scala 244:36]
  wire  _T_251 = _T_250 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_254 = io_trigger_pkt_any_0_tdata2[14] == dec_i0_match_data_0[14]; // @[el2_lib.scala 244:78]
  wire  _T_255 = _T_251 | _T_254; // @[el2_lib.scala 244:23]
  wire  _T_257 = &io_trigger_pkt_any_0_tdata2[14:0]; // @[el2_lib.scala 244:36]
  wire  _T_258 = _T_257 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_261 = io_trigger_pkt_any_0_tdata2[15] == dec_i0_match_data_0[15]; // @[el2_lib.scala 244:78]
  wire  _T_262 = _T_258 | _T_261; // @[el2_lib.scala 244:23]
  wire  _T_264 = &io_trigger_pkt_any_0_tdata2[15:0]; // @[el2_lib.scala 244:36]
  wire  _T_265 = _T_264 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_268 = io_trigger_pkt_any_0_tdata2[16] == dec_i0_match_data_0[16]; // @[el2_lib.scala 244:78]
  wire  _T_269 = _T_265 | _T_268; // @[el2_lib.scala 244:23]
  wire  _T_271 = &io_trigger_pkt_any_0_tdata2[16:0]; // @[el2_lib.scala 244:36]
  wire  _T_272 = _T_271 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_275 = io_trigger_pkt_any_0_tdata2[17] == dec_i0_match_data_0[17]; // @[el2_lib.scala 244:78]
  wire  _T_276 = _T_272 | _T_275; // @[el2_lib.scala 244:23]
  wire  _T_278 = &io_trigger_pkt_any_0_tdata2[17:0]; // @[el2_lib.scala 244:36]
  wire  _T_279 = _T_278 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_282 = io_trigger_pkt_any_0_tdata2[18] == dec_i0_match_data_0[18]; // @[el2_lib.scala 244:78]
  wire  _T_283 = _T_279 | _T_282; // @[el2_lib.scala 244:23]
  wire  _T_285 = &io_trigger_pkt_any_0_tdata2[18:0]; // @[el2_lib.scala 244:36]
  wire  _T_286 = _T_285 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_289 = io_trigger_pkt_any_0_tdata2[19] == dec_i0_match_data_0[19]; // @[el2_lib.scala 244:78]
  wire  _T_290 = _T_286 | _T_289; // @[el2_lib.scala 244:23]
  wire  _T_292 = &io_trigger_pkt_any_0_tdata2[19:0]; // @[el2_lib.scala 244:36]
  wire  _T_293 = _T_292 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_296 = io_trigger_pkt_any_0_tdata2[20] == dec_i0_match_data_0[20]; // @[el2_lib.scala 244:78]
  wire  _T_297 = _T_293 | _T_296; // @[el2_lib.scala 244:23]
  wire  _T_299 = &io_trigger_pkt_any_0_tdata2[20:0]; // @[el2_lib.scala 244:36]
  wire  _T_300 = _T_299 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_303 = io_trigger_pkt_any_0_tdata2[21] == dec_i0_match_data_0[21]; // @[el2_lib.scala 244:78]
  wire  _T_304 = _T_300 | _T_303; // @[el2_lib.scala 244:23]
  wire  _T_306 = &io_trigger_pkt_any_0_tdata2[21:0]; // @[el2_lib.scala 244:36]
  wire  _T_307 = _T_306 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_310 = io_trigger_pkt_any_0_tdata2[22] == dec_i0_match_data_0[22]; // @[el2_lib.scala 244:78]
  wire  _T_311 = _T_307 | _T_310; // @[el2_lib.scala 244:23]
  wire  _T_313 = &io_trigger_pkt_any_0_tdata2[22:0]; // @[el2_lib.scala 244:36]
  wire  _T_314 = _T_313 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_317 = io_trigger_pkt_any_0_tdata2[23] == dec_i0_match_data_0[23]; // @[el2_lib.scala 244:78]
  wire  _T_318 = _T_314 | _T_317; // @[el2_lib.scala 244:23]
  wire  _T_320 = &io_trigger_pkt_any_0_tdata2[23:0]; // @[el2_lib.scala 244:36]
  wire  _T_321 = _T_320 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_324 = io_trigger_pkt_any_0_tdata2[24] == dec_i0_match_data_0[24]; // @[el2_lib.scala 244:78]
  wire  _T_325 = _T_321 | _T_324; // @[el2_lib.scala 244:23]
  wire  _T_327 = &io_trigger_pkt_any_0_tdata2[24:0]; // @[el2_lib.scala 244:36]
  wire  _T_328 = _T_327 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_331 = io_trigger_pkt_any_0_tdata2[25] == dec_i0_match_data_0[25]; // @[el2_lib.scala 244:78]
  wire  _T_332 = _T_328 | _T_331; // @[el2_lib.scala 244:23]
  wire  _T_334 = &io_trigger_pkt_any_0_tdata2[25:0]; // @[el2_lib.scala 244:36]
  wire  _T_335 = _T_334 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_338 = io_trigger_pkt_any_0_tdata2[26] == dec_i0_match_data_0[26]; // @[el2_lib.scala 244:78]
  wire  _T_339 = _T_335 | _T_338; // @[el2_lib.scala 244:23]
  wire  _T_341 = &io_trigger_pkt_any_0_tdata2[26:0]; // @[el2_lib.scala 244:36]
  wire  _T_342 = _T_341 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_345 = io_trigger_pkt_any_0_tdata2[27] == dec_i0_match_data_0[27]; // @[el2_lib.scala 244:78]
  wire  _T_346 = _T_342 | _T_345; // @[el2_lib.scala 244:23]
  wire  _T_348 = &io_trigger_pkt_any_0_tdata2[27:0]; // @[el2_lib.scala 244:36]
  wire  _T_349 = _T_348 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_352 = io_trigger_pkt_any_0_tdata2[28] == dec_i0_match_data_0[28]; // @[el2_lib.scala 244:78]
  wire  _T_353 = _T_349 | _T_352; // @[el2_lib.scala 244:23]
  wire  _T_355 = &io_trigger_pkt_any_0_tdata2[28:0]; // @[el2_lib.scala 244:36]
  wire  _T_356 = _T_355 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_359 = io_trigger_pkt_any_0_tdata2[29] == dec_i0_match_data_0[29]; // @[el2_lib.scala 244:78]
  wire  _T_360 = _T_356 | _T_359; // @[el2_lib.scala 244:23]
  wire  _T_362 = &io_trigger_pkt_any_0_tdata2[29:0]; // @[el2_lib.scala 244:36]
  wire  _T_363 = _T_362 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_366 = io_trigger_pkt_any_0_tdata2[30] == dec_i0_match_data_0[30]; // @[el2_lib.scala 244:78]
  wire  _T_367 = _T_363 | _T_366; // @[el2_lib.scala 244:23]
  wire  _T_369 = &io_trigger_pkt_any_0_tdata2[30:0]; // @[el2_lib.scala 244:36]
  wire  _T_370 = _T_369 & _T_153; // @[el2_lib.scala 244:41]
  wire  _T_373 = io_trigger_pkt_any_0_tdata2[31] == dec_i0_match_data_0[31]; // @[el2_lib.scala 244:78]
  wire  _T_374 = _T_370 | _T_373; // @[el2_lib.scala 244:23]
  wire [7:0] _T_381 = {_T_206,_T_199,_T_192,_T_185,_T_178,_T_171,_T_164,_T_157}; // @[el2_lib.scala 245:14]
  wire [15:0] _T_389 = {_T_262,_T_255,_T_248,_T_241,_T_234,_T_227,_T_220,_T_213,_T_381}; // @[el2_lib.scala 245:14]
  wire [7:0] _T_396 = {_T_318,_T_311,_T_304,_T_297,_T_290,_T_283,_T_276,_T_269}; // @[el2_lib.scala 245:14]
  wire [31:0] _T_405 = {_T_374,_T_367,_T_360,_T_353,_T_346,_T_339,_T_332,_T_325,_T_396,_T_389}; // @[el2_lib.scala 245:14]
  wire [31:0] _GEN_0 = {{31'd0}, _T_148}; // @[dec_trigger.scala 15:109]
  wire [31:0] _T_406 = _GEN_0 & _T_405; // @[dec_trigger.scala 15:109]
  wire  _T_407 = io_trigger_pkt_any_1_execute & io_trigger_pkt_any_1_m; // @[dec_trigger.scala 15:83]
  wire  _T_410 = &io_trigger_pkt_any_1_tdata2; // @[el2_lib.scala 241:45]
  wire  _T_411 = ~_T_410; // @[el2_lib.scala 241:39]
  wire  _T_412 = io_trigger_pkt_any_1_match_pkt & _T_411; // @[el2_lib.scala 241:37]
  wire  _T_415 = io_trigger_pkt_any_1_tdata2[0] == dec_i0_match_data_1[0]; // @[el2_lib.scala 242:52]
  wire  _T_416 = _T_412 | _T_415; // @[el2_lib.scala 242:41]
  wire  _T_418 = &io_trigger_pkt_any_1_tdata2[0]; // @[el2_lib.scala 244:36]
  wire  _T_419 = _T_418 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_422 = io_trigger_pkt_any_1_tdata2[1] == dec_i0_match_data_1[1]; // @[el2_lib.scala 244:78]
  wire  _T_423 = _T_419 | _T_422; // @[el2_lib.scala 244:23]
  wire  _T_425 = &io_trigger_pkt_any_1_tdata2[1:0]; // @[el2_lib.scala 244:36]
  wire  _T_426 = _T_425 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_429 = io_trigger_pkt_any_1_tdata2[2] == dec_i0_match_data_1[2]; // @[el2_lib.scala 244:78]
  wire  _T_430 = _T_426 | _T_429; // @[el2_lib.scala 244:23]
  wire  _T_432 = &io_trigger_pkt_any_1_tdata2[2:0]; // @[el2_lib.scala 244:36]
  wire  _T_433 = _T_432 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_436 = io_trigger_pkt_any_1_tdata2[3] == dec_i0_match_data_1[3]; // @[el2_lib.scala 244:78]
  wire  _T_437 = _T_433 | _T_436; // @[el2_lib.scala 244:23]
  wire  _T_439 = &io_trigger_pkt_any_1_tdata2[3:0]; // @[el2_lib.scala 244:36]
  wire  _T_440 = _T_439 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_443 = io_trigger_pkt_any_1_tdata2[4] == dec_i0_match_data_1[4]; // @[el2_lib.scala 244:78]
  wire  _T_444 = _T_440 | _T_443; // @[el2_lib.scala 244:23]
  wire  _T_446 = &io_trigger_pkt_any_1_tdata2[4:0]; // @[el2_lib.scala 244:36]
  wire  _T_447 = _T_446 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_450 = io_trigger_pkt_any_1_tdata2[5] == dec_i0_match_data_1[5]; // @[el2_lib.scala 244:78]
  wire  _T_451 = _T_447 | _T_450; // @[el2_lib.scala 244:23]
  wire  _T_453 = &io_trigger_pkt_any_1_tdata2[5:0]; // @[el2_lib.scala 244:36]
  wire  _T_454 = _T_453 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_457 = io_trigger_pkt_any_1_tdata2[6] == dec_i0_match_data_1[6]; // @[el2_lib.scala 244:78]
  wire  _T_458 = _T_454 | _T_457; // @[el2_lib.scala 244:23]
  wire  _T_460 = &io_trigger_pkt_any_1_tdata2[6:0]; // @[el2_lib.scala 244:36]
  wire  _T_461 = _T_460 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_464 = io_trigger_pkt_any_1_tdata2[7] == dec_i0_match_data_1[7]; // @[el2_lib.scala 244:78]
  wire  _T_465 = _T_461 | _T_464; // @[el2_lib.scala 244:23]
  wire  _T_467 = &io_trigger_pkt_any_1_tdata2[7:0]; // @[el2_lib.scala 244:36]
  wire  _T_468 = _T_467 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_471 = io_trigger_pkt_any_1_tdata2[8] == dec_i0_match_data_1[8]; // @[el2_lib.scala 244:78]
  wire  _T_472 = _T_468 | _T_471; // @[el2_lib.scala 244:23]
  wire  _T_474 = &io_trigger_pkt_any_1_tdata2[8:0]; // @[el2_lib.scala 244:36]
  wire  _T_475 = _T_474 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_478 = io_trigger_pkt_any_1_tdata2[9] == dec_i0_match_data_1[9]; // @[el2_lib.scala 244:78]
  wire  _T_479 = _T_475 | _T_478; // @[el2_lib.scala 244:23]
  wire  _T_481 = &io_trigger_pkt_any_1_tdata2[9:0]; // @[el2_lib.scala 244:36]
  wire  _T_482 = _T_481 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_485 = io_trigger_pkt_any_1_tdata2[10] == dec_i0_match_data_1[10]; // @[el2_lib.scala 244:78]
  wire  _T_486 = _T_482 | _T_485; // @[el2_lib.scala 244:23]
  wire  _T_488 = &io_trigger_pkt_any_1_tdata2[10:0]; // @[el2_lib.scala 244:36]
  wire  _T_489 = _T_488 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_492 = io_trigger_pkt_any_1_tdata2[11] == dec_i0_match_data_1[11]; // @[el2_lib.scala 244:78]
  wire  _T_493 = _T_489 | _T_492; // @[el2_lib.scala 244:23]
  wire  _T_495 = &io_trigger_pkt_any_1_tdata2[11:0]; // @[el2_lib.scala 244:36]
  wire  _T_496 = _T_495 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_499 = io_trigger_pkt_any_1_tdata2[12] == dec_i0_match_data_1[12]; // @[el2_lib.scala 244:78]
  wire  _T_500 = _T_496 | _T_499; // @[el2_lib.scala 244:23]
  wire  _T_502 = &io_trigger_pkt_any_1_tdata2[12:0]; // @[el2_lib.scala 244:36]
  wire  _T_503 = _T_502 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_506 = io_trigger_pkt_any_1_tdata2[13] == dec_i0_match_data_1[13]; // @[el2_lib.scala 244:78]
  wire  _T_507 = _T_503 | _T_506; // @[el2_lib.scala 244:23]
  wire  _T_509 = &io_trigger_pkt_any_1_tdata2[13:0]; // @[el2_lib.scala 244:36]
  wire  _T_510 = _T_509 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_513 = io_trigger_pkt_any_1_tdata2[14] == dec_i0_match_data_1[14]; // @[el2_lib.scala 244:78]
  wire  _T_514 = _T_510 | _T_513; // @[el2_lib.scala 244:23]
  wire  _T_516 = &io_trigger_pkt_any_1_tdata2[14:0]; // @[el2_lib.scala 244:36]
  wire  _T_517 = _T_516 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_520 = io_trigger_pkt_any_1_tdata2[15] == dec_i0_match_data_1[15]; // @[el2_lib.scala 244:78]
  wire  _T_521 = _T_517 | _T_520; // @[el2_lib.scala 244:23]
  wire  _T_523 = &io_trigger_pkt_any_1_tdata2[15:0]; // @[el2_lib.scala 244:36]
  wire  _T_524 = _T_523 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_527 = io_trigger_pkt_any_1_tdata2[16] == dec_i0_match_data_1[16]; // @[el2_lib.scala 244:78]
  wire  _T_528 = _T_524 | _T_527; // @[el2_lib.scala 244:23]
  wire  _T_530 = &io_trigger_pkt_any_1_tdata2[16:0]; // @[el2_lib.scala 244:36]
  wire  _T_531 = _T_530 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_534 = io_trigger_pkt_any_1_tdata2[17] == dec_i0_match_data_1[17]; // @[el2_lib.scala 244:78]
  wire  _T_535 = _T_531 | _T_534; // @[el2_lib.scala 244:23]
  wire  _T_537 = &io_trigger_pkt_any_1_tdata2[17:0]; // @[el2_lib.scala 244:36]
  wire  _T_538 = _T_537 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_541 = io_trigger_pkt_any_1_tdata2[18] == dec_i0_match_data_1[18]; // @[el2_lib.scala 244:78]
  wire  _T_542 = _T_538 | _T_541; // @[el2_lib.scala 244:23]
  wire  _T_544 = &io_trigger_pkt_any_1_tdata2[18:0]; // @[el2_lib.scala 244:36]
  wire  _T_545 = _T_544 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_548 = io_trigger_pkt_any_1_tdata2[19] == dec_i0_match_data_1[19]; // @[el2_lib.scala 244:78]
  wire  _T_549 = _T_545 | _T_548; // @[el2_lib.scala 244:23]
  wire  _T_551 = &io_trigger_pkt_any_1_tdata2[19:0]; // @[el2_lib.scala 244:36]
  wire  _T_552 = _T_551 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_555 = io_trigger_pkt_any_1_tdata2[20] == dec_i0_match_data_1[20]; // @[el2_lib.scala 244:78]
  wire  _T_556 = _T_552 | _T_555; // @[el2_lib.scala 244:23]
  wire  _T_558 = &io_trigger_pkt_any_1_tdata2[20:0]; // @[el2_lib.scala 244:36]
  wire  _T_559 = _T_558 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_562 = io_trigger_pkt_any_1_tdata2[21] == dec_i0_match_data_1[21]; // @[el2_lib.scala 244:78]
  wire  _T_563 = _T_559 | _T_562; // @[el2_lib.scala 244:23]
  wire  _T_565 = &io_trigger_pkt_any_1_tdata2[21:0]; // @[el2_lib.scala 244:36]
  wire  _T_566 = _T_565 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_569 = io_trigger_pkt_any_1_tdata2[22] == dec_i0_match_data_1[22]; // @[el2_lib.scala 244:78]
  wire  _T_570 = _T_566 | _T_569; // @[el2_lib.scala 244:23]
  wire  _T_572 = &io_trigger_pkt_any_1_tdata2[22:0]; // @[el2_lib.scala 244:36]
  wire  _T_573 = _T_572 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_576 = io_trigger_pkt_any_1_tdata2[23] == dec_i0_match_data_1[23]; // @[el2_lib.scala 244:78]
  wire  _T_577 = _T_573 | _T_576; // @[el2_lib.scala 244:23]
  wire  _T_579 = &io_trigger_pkt_any_1_tdata2[23:0]; // @[el2_lib.scala 244:36]
  wire  _T_580 = _T_579 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_583 = io_trigger_pkt_any_1_tdata2[24] == dec_i0_match_data_1[24]; // @[el2_lib.scala 244:78]
  wire  _T_584 = _T_580 | _T_583; // @[el2_lib.scala 244:23]
  wire  _T_586 = &io_trigger_pkt_any_1_tdata2[24:0]; // @[el2_lib.scala 244:36]
  wire  _T_587 = _T_586 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_590 = io_trigger_pkt_any_1_tdata2[25] == dec_i0_match_data_1[25]; // @[el2_lib.scala 244:78]
  wire  _T_591 = _T_587 | _T_590; // @[el2_lib.scala 244:23]
  wire  _T_593 = &io_trigger_pkt_any_1_tdata2[25:0]; // @[el2_lib.scala 244:36]
  wire  _T_594 = _T_593 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_597 = io_trigger_pkt_any_1_tdata2[26] == dec_i0_match_data_1[26]; // @[el2_lib.scala 244:78]
  wire  _T_598 = _T_594 | _T_597; // @[el2_lib.scala 244:23]
  wire  _T_600 = &io_trigger_pkt_any_1_tdata2[26:0]; // @[el2_lib.scala 244:36]
  wire  _T_601 = _T_600 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_604 = io_trigger_pkt_any_1_tdata2[27] == dec_i0_match_data_1[27]; // @[el2_lib.scala 244:78]
  wire  _T_605 = _T_601 | _T_604; // @[el2_lib.scala 244:23]
  wire  _T_607 = &io_trigger_pkt_any_1_tdata2[27:0]; // @[el2_lib.scala 244:36]
  wire  _T_608 = _T_607 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_611 = io_trigger_pkt_any_1_tdata2[28] == dec_i0_match_data_1[28]; // @[el2_lib.scala 244:78]
  wire  _T_612 = _T_608 | _T_611; // @[el2_lib.scala 244:23]
  wire  _T_614 = &io_trigger_pkt_any_1_tdata2[28:0]; // @[el2_lib.scala 244:36]
  wire  _T_615 = _T_614 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_618 = io_trigger_pkt_any_1_tdata2[29] == dec_i0_match_data_1[29]; // @[el2_lib.scala 244:78]
  wire  _T_619 = _T_615 | _T_618; // @[el2_lib.scala 244:23]
  wire  _T_621 = &io_trigger_pkt_any_1_tdata2[29:0]; // @[el2_lib.scala 244:36]
  wire  _T_622 = _T_621 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_625 = io_trigger_pkt_any_1_tdata2[30] == dec_i0_match_data_1[30]; // @[el2_lib.scala 244:78]
  wire  _T_626 = _T_622 | _T_625; // @[el2_lib.scala 244:23]
  wire  _T_628 = &io_trigger_pkt_any_1_tdata2[30:0]; // @[el2_lib.scala 244:36]
  wire  _T_629 = _T_628 & _T_412; // @[el2_lib.scala 244:41]
  wire  _T_632 = io_trigger_pkt_any_1_tdata2[31] == dec_i0_match_data_1[31]; // @[el2_lib.scala 244:78]
  wire  _T_633 = _T_629 | _T_632; // @[el2_lib.scala 244:23]
  wire [7:0] _T_640 = {_T_465,_T_458,_T_451,_T_444,_T_437,_T_430,_T_423,_T_416}; // @[el2_lib.scala 245:14]
  wire [15:0] _T_648 = {_T_521,_T_514,_T_507,_T_500,_T_493,_T_486,_T_479,_T_472,_T_640}; // @[el2_lib.scala 245:14]
  wire [7:0] _T_655 = {_T_577,_T_570,_T_563,_T_556,_T_549,_T_542,_T_535,_T_528}; // @[el2_lib.scala 245:14]
  wire [31:0] _T_664 = {_T_633,_T_626,_T_619,_T_612,_T_605,_T_598,_T_591,_T_584,_T_655,_T_648}; // @[el2_lib.scala 245:14]
  wire [31:0] _GEN_1 = {{31'd0}, _T_407}; // @[dec_trigger.scala 15:109]
  wire [31:0] _T_665 = _GEN_1 & _T_664; // @[dec_trigger.scala 15:109]
  wire  _T_666 = io_trigger_pkt_any_2_execute & io_trigger_pkt_any_2_m; // @[dec_trigger.scala 15:83]
  wire  _T_669 = &io_trigger_pkt_any_2_tdata2; // @[el2_lib.scala 241:45]
  wire  _T_670 = ~_T_669; // @[el2_lib.scala 241:39]
  wire  _T_671 = io_trigger_pkt_any_2_match_pkt & _T_670; // @[el2_lib.scala 241:37]
  wire  _T_674 = io_trigger_pkt_any_2_tdata2[0] == dec_i0_match_data_2[0]; // @[el2_lib.scala 242:52]
  wire  _T_675 = _T_671 | _T_674; // @[el2_lib.scala 242:41]
  wire  _T_677 = &io_trigger_pkt_any_2_tdata2[0]; // @[el2_lib.scala 244:36]
  wire  _T_678 = _T_677 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_681 = io_trigger_pkt_any_2_tdata2[1] == dec_i0_match_data_2[1]; // @[el2_lib.scala 244:78]
  wire  _T_682 = _T_678 | _T_681; // @[el2_lib.scala 244:23]
  wire  _T_684 = &io_trigger_pkt_any_2_tdata2[1:0]; // @[el2_lib.scala 244:36]
  wire  _T_685 = _T_684 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_688 = io_trigger_pkt_any_2_tdata2[2] == dec_i0_match_data_2[2]; // @[el2_lib.scala 244:78]
  wire  _T_689 = _T_685 | _T_688; // @[el2_lib.scala 244:23]
  wire  _T_691 = &io_trigger_pkt_any_2_tdata2[2:0]; // @[el2_lib.scala 244:36]
  wire  _T_692 = _T_691 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_695 = io_trigger_pkt_any_2_tdata2[3] == dec_i0_match_data_2[3]; // @[el2_lib.scala 244:78]
  wire  _T_696 = _T_692 | _T_695; // @[el2_lib.scala 244:23]
  wire  _T_698 = &io_trigger_pkt_any_2_tdata2[3:0]; // @[el2_lib.scala 244:36]
  wire  _T_699 = _T_698 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_702 = io_trigger_pkt_any_2_tdata2[4] == dec_i0_match_data_2[4]; // @[el2_lib.scala 244:78]
  wire  _T_703 = _T_699 | _T_702; // @[el2_lib.scala 244:23]
  wire  _T_705 = &io_trigger_pkt_any_2_tdata2[4:0]; // @[el2_lib.scala 244:36]
  wire  _T_706 = _T_705 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_709 = io_trigger_pkt_any_2_tdata2[5] == dec_i0_match_data_2[5]; // @[el2_lib.scala 244:78]
  wire  _T_710 = _T_706 | _T_709; // @[el2_lib.scala 244:23]
  wire  _T_712 = &io_trigger_pkt_any_2_tdata2[5:0]; // @[el2_lib.scala 244:36]
  wire  _T_713 = _T_712 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_716 = io_trigger_pkt_any_2_tdata2[6] == dec_i0_match_data_2[6]; // @[el2_lib.scala 244:78]
  wire  _T_717 = _T_713 | _T_716; // @[el2_lib.scala 244:23]
  wire  _T_719 = &io_trigger_pkt_any_2_tdata2[6:0]; // @[el2_lib.scala 244:36]
  wire  _T_720 = _T_719 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_723 = io_trigger_pkt_any_2_tdata2[7] == dec_i0_match_data_2[7]; // @[el2_lib.scala 244:78]
  wire  _T_724 = _T_720 | _T_723; // @[el2_lib.scala 244:23]
  wire  _T_726 = &io_trigger_pkt_any_2_tdata2[7:0]; // @[el2_lib.scala 244:36]
  wire  _T_727 = _T_726 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_730 = io_trigger_pkt_any_2_tdata2[8] == dec_i0_match_data_2[8]; // @[el2_lib.scala 244:78]
  wire  _T_731 = _T_727 | _T_730; // @[el2_lib.scala 244:23]
  wire  _T_733 = &io_trigger_pkt_any_2_tdata2[8:0]; // @[el2_lib.scala 244:36]
  wire  _T_734 = _T_733 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_737 = io_trigger_pkt_any_2_tdata2[9] == dec_i0_match_data_2[9]; // @[el2_lib.scala 244:78]
  wire  _T_738 = _T_734 | _T_737; // @[el2_lib.scala 244:23]
  wire  _T_740 = &io_trigger_pkt_any_2_tdata2[9:0]; // @[el2_lib.scala 244:36]
  wire  _T_741 = _T_740 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_744 = io_trigger_pkt_any_2_tdata2[10] == dec_i0_match_data_2[10]; // @[el2_lib.scala 244:78]
  wire  _T_745 = _T_741 | _T_744; // @[el2_lib.scala 244:23]
  wire  _T_747 = &io_trigger_pkt_any_2_tdata2[10:0]; // @[el2_lib.scala 244:36]
  wire  _T_748 = _T_747 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_751 = io_trigger_pkt_any_2_tdata2[11] == dec_i0_match_data_2[11]; // @[el2_lib.scala 244:78]
  wire  _T_752 = _T_748 | _T_751; // @[el2_lib.scala 244:23]
  wire  _T_754 = &io_trigger_pkt_any_2_tdata2[11:0]; // @[el2_lib.scala 244:36]
  wire  _T_755 = _T_754 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_758 = io_trigger_pkt_any_2_tdata2[12] == dec_i0_match_data_2[12]; // @[el2_lib.scala 244:78]
  wire  _T_759 = _T_755 | _T_758; // @[el2_lib.scala 244:23]
  wire  _T_761 = &io_trigger_pkt_any_2_tdata2[12:0]; // @[el2_lib.scala 244:36]
  wire  _T_762 = _T_761 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_765 = io_trigger_pkt_any_2_tdata2[13] == dec_i0_match_data_2[13]; // @[el2_lib.scala 244:78]
  wire  _T_766 = _T_762 | _T_765; // @[el2_lib.scala 244:23]
  wire  _T_768 = &io_trigger_pkt_any_2_tdata2[13:0]; // @[el2_lib.scala 244:36]
  wire  _T_769 = _T_768 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_772 = io_trigger_pkt_any_2_tdata2[14] == dec_i0_match_data_2[14]; // @[el2_lib.scala 244:78]
  wire  _T_773 = _T_769 | _T_772; // @[el2_lib.scala 244:23]
  wire  _T_775 = &io_trigger_pkt_any_2_tdata2[14:0]; // @[el2_lib.scala 244:36]
  wire  _T_776 = _T_775 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_779 = io_trigger_pkt_any_2_tdata2[15] == dec_i0_match_data_2[15]; // @[el2_lib.scala 244:78]
  wire  _T_780 = _T_776 | _T_779; // @[el2_lib.scala 244:23]
  wire  _T_782 = &io_trigger_pkt_any_2_tdata2[15:0]; // @[el2_lib.scala 244:36]
  wire  _T_783 = _T_782 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_786 = io_trigger_pkt_any_2_tdata2[16] == dec_i0_match_data_2[16]; // @[el2_lib.scala 244:78]
  wire  _T_787 = _T_783 | _T_786; // @[el2_lib.scala 244:23]
  wire  _T_789 = &io_trigger_pkt_any_2_tdata2[16:0]; // @[el2_lib.scala 244:36]
  wire  _T_790 = _T_789 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_793 = io_trigger_pkt_any_2_tdata2[17] == dec_i0_match_data_2[17]; // @[el2_lib.scala 244:78]
  wire  _T_794 = _T_790 | _T_793; // @[el2_lib.scala 244:23]
  wire  _T_796 = &io_trigger_pkt_any_2_tdata2[17:0]; // @[el2_lib.scala 244:36]
  wire  _T_797 = _T_796 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_800 = io_trigger_pkt_any_2_tdata2[18] == dec_i0_match_data_2[18]; // @[el2_lib.scala 244:78]
  wire  _T_801 = _T_797 | _T_800; // @[el2_lib.scala 244:23]
  wire  _T_803 = &io_trigger_pkt_any_2_tdata2[18:0]; // @[el2_lib.scala 244:36]
  wire  _T_804 = _T_803 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_807 = io_trigger_pkt_any_2_tdata2[19] == dec_i0_match_data_2[19]; // @[el2_lib.scala 244:78]
  wire  _T_808 = _T_804 | _T_807; // @[el2_lib.scala 244:23]
  wire  _T_810 = &io_trigger_pkt_any_2_tdata2[19:0]; // @[el2_lib.scala 244:36]
  wire  _T_811 = _T_810 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_814 = io_trigger_pkt_any_2_tdata2[20] == dec_i0_match_data_2[20]; // @[el2_lib.scala 244:78]
  wire  _T_815 = _T_811 | _T_814; // @[el2_lib.scala 244:23]
  wire  _T_817 = &io_trigger_pkt_any_2_tdata2[20:0]; // @[el2_lib.scala 244:36]
  wire  _T_818 = _T_817 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_821 = io_trigger_pkt_any_2_tdata2[21] == dec_i0_match_data_2[21]; // @[el2_lib.scala 244:78]
  wire  _T_822 = _T_818 | _T_821; // @[el2_lib.scala 244:23]
  wire  _T_824 = &io_trigger_pkt_any_2_tdata2[21:0]; // @[el2_lib.scala 244:36]
  wire  _T_825 = _T_824 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_828 = io_trigger_pkt_any_2_tdata2[22] == dec_i0_match_data_2[22]; // @[el2_lib.scala 244:78]
  wire  _T_829 = _T_825 | _T_828; // @[el2_lib.scala 244:23]
  wire  _T_831 = &io_trigger_pkt_any_2_tdata2[22:0]; // @[el2_lib.scala 244:36]
  wire  _T_832 = _T_831 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_835 = io_trigger_pkt_any_2_tdata2[23] == dec_i0_match_data_2[23]; // @[el2_lib.scala 244:78]
  wire  _T_836 = _T_832 | _T_835; // @[el2_lib.scala 244:23]
  wire  _T_838 = &io_trigger_pkt_any_2_tdata2[23:0]; // @[el2_lib.scala 244:36]
  wire  _T_839 = _T_838 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_842 = io_trigger_pkt_any_2_tdata2[24] == dec_i0_match_data_2[24]; // @[el2_lib.scala 244:78]
  wire  _T_843 = _T_839 | _T_842; // @[el2_lib.scala 244:23]
  wire  _T_845 = &io_trigger_pkt_any_2_tdata2[24:0]; // @[el2_lib.scala 244:36]
  wire  _T_846 = _T_845 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_849 = io_trigger_pkt_any_2_tdata2[25] == dec_i0_match_data_2[25]; // @[el2_lib.scala 244:78]
  wire  _T_850 = _T_846 | _T_849; // @[el2_lib.scala 244:23]
  wire  _T_852 = &io_trigger_pkt_any_2_tdata2[25:0]; // @[el2_lib.scala 244:36]
  wire  _T_853 = _T_852 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_856 = io_trigger_pkt_any_2_tdata2[26] == dec_i0_match_data_2[26]; // @[el2_lib.scala 244:78]
  wire  _T_857 = _T_853 | _T_856; // @[el2_lib.scala 244:23]
  wire  _T_859 = &io_trigger_pkt_any_2_tdata2[26:0]; // @[el2_lib.scala 244:36]
  wire  _T_860 = _T_859 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_863 = io_trigger_pkt_any_2_tdata2[27] == dec_i0_match_data_2[27]; // @[el2_lib.scala 244:78]
  wire  _T_864 = _T_860 | _T_863; // @[el2_lib.scala 244:23]
  wire  _T_866 = &io_trigger_pkt_any_2_tdata2[27:0]; // @[el2_lib.scala 244:36]
  wire  _T_867 = _T_866 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_870 = io_trigger_pkt_any_2_tdata2[28] == dec_i0_match_data_2[28]; // @[el2_lib.scala 244:78]
  wire  _T_871 = _T_867 | _T_870; // @[el2_lib.scala 244:23]
  wire  _T_873 = &io_trigger_pkt_any_2_tdata2[28:0]; // @[el2_lib.scala 244:36]
  wire  _T_874 = _T_873 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_877 = io_trigger_pkt_any_2_tdata2[29] == dec_i0_match_data_2[29]; // @[el2_lib.scala 244:78]
  wire  _T_878 = _T_874 | _T_877; // @[el2_lib.scala 244:23]
  wire  _T_880 = &io_trigger_pkt_any_2_tdata2[29:0]; // @[el2_lib.scala 244:36]
  wire  _T_881 = _T_880 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_884 = io_trigger_pkt_any_2_tdata2[30] == dec_i0_match_data_2[30]; // @[el2_lib.scala 244:78]
  wire  _T_885 = _T_881 | _T_884; // @[el2_lib.scala 244:23]
  wire  _T_887 = &io_trigger_pkt_any_2_tdata2[30:0]; // @[el2_lib.scala 244:36]
  wire  _T_888 = _T_887 & _T_671; // @[el2_lib.scala 244:41]
  wire  _T_891 = io_trigger_pkt_any_2_tdata2[31] == dec_i0_match_data_2[31]; // @[el2_lib.scala 244:78]
  wire  _T_892 = _T_888 | _T_891; // @[el2_lib.scala 244:23]
  wire [7:0] _T_899 = {_T_724,_T_717,_T_710,_T_703,_T_696,_T_689,_T_682,_T_675}; // @[el2_lib.scala 245:14]
  wire [15:0] _T_907 = {_T_780,_T_773,_T_766,_T_759,_T_752,_T_745,_T_738,_T_731,_T_899}; // @[el2_lib.scala 245:14]
  wire [7:0] _T_914 = {_T_836,_T_829,_T_822,_T_815,_T_808,_T_801,_T_794,_T_787}; // @[el2_lib.scala 245:14]
  wire [31:0] _T_923 = {_T_892,_T_885,_T_878,_T_871,_T_864,_T_857,_T_850,_T_843,_T_914,_T_907}; // @[el2_lib.scala 245:14]
  wire [31:0] _GEN_2 = {{31'd0}, _T_666}; // @[dec_trigger.scala 15:109]
  wire [31:0] _T_924 = _GEN_2 & _T_923; // @[dec_trigger.scala 15:109]
  wire  _T_925 = io_trigger_pkt_any_3_execute & io_trigger_pkt_any_3_m; // @[dec_trigger.scala 15:83]
  wire  _T_928 = &io_trigger_pkt_any_3_tdata2; // @[el2_lib.scala 241:45]
  wire  _T_929 = ~_T_928; // @[el2_lib.scala 241:39]
  wire  _T_930 = io_trigger_pkt_any_3_match_pkt & _T_929; // @[el2_lib.scala 241:37]
  wire  _T_933 = io_trigger_pkt_any_3_tdata2[0] == dec_i0_match_data_3[0]; // @[el2_lib.scala 242:52]
  wire  _T_934 = _T_930 | _T_933; // @[el2_lib.scala 242:41]
  wire  _T_936 = &io_trigger_pkt_any_3_tdata2[0]; // @[el2_lib.scala 244:36]
  wire  _T_937 = _T_936 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_940 = io_trigger_pkt_any_3_tdata2[1] == dec_i0_match_data_3[1]; // @[el2_lib.scala 244:78]
  wire  _T_941 = _T_937 | _T_940; // @[el2_lib.scala 244:23]
  wire  _T_943 = &io_trigger_pkt_any_3_tdata2[1:0]; // @[el2_lib.scala 244:36]
  wire  _T_944 = _T_943 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_947 = io_trigger_pkt_any_3_tdata2[2] == dec_i0_match_data_3[2]; // @[el2_lib.scala 244:78]
  wire  _T_948 = _T_944 | _T_947; // @[el2_lib.scala 244:23]
  wire  _T_950 = &io_trigger_pkt_any_3_tdata2[2:0]; // @[el2_lib.scala 244:36]
  wire  _T_951 = _T_950 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_954 = io_trigger_pkt_any_3_tdata2[3] == dec_i0_match_data_3[3]; // @[el2_lib.scala 244:78]
  wire  _T_955 = _T_951 | _T_954; // @[el2_lib.scala 244:23]
  wire  _T_957 = &io_trigger_pkt_any_3_tdata2[3:0]; // @[el2_lib.scala 244:36]
  wire  _T_958 = _T_957 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_961 = io_trigger_pkt_any_3_tdata2[4] == dec_i0_match_data_3[4]; // @[el2_lib.scala 244:78]
  wire  _T_962 = _T_958 | _T_961; // @[el2_lib.scala 244:23]
  wire  _T_964 = &io_trigger_pkt_any_3_tdata2[4:0]; // @[el2_lib.scala 244:36]
  wire  _T_965 = _T_964 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_968 = io_trigger_pkt_any_3_tdata2[5] == dec_i0_match_data_3[5]; // @[el2_lib.scala 244:78]
  wire  _T_969 = _T_965 | _T_968; // @[el2_lib.scala 244:23]
  wire  _T_971 = &io_trigger_pkt_any_3_tdata2[5:0]; // @[el2_lib.scala 244:36]
  wire  _T_972 = _T_971 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_975 = io_trigger_pkt_any_3_tdata2[6] == dec_i0_match_data_3[6]; // @[el2_lib.scala 244:78]
  wire  _T_976 = _T_972 | _T_975; // @[el2_lib.scala 244:23]
  wire  _T_978 = &io_trigger_pkt_any_3_tdata2[6:0]; // @[el2_lib.scala 244:36]
  wire  _T_979 = _T_978 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_982 = io_trigger_pkt_any_3_tdata2[7] == dec_i0_match_data_3[7]; // @[el2_lib.scala 244:78]
  wire  _T_983 = _T_979 | _T_982; // @[el2_lib.scala 244:23]
  wire  _T_985 = &io_trigger_pkt_any_3_tdata2[7:0]; // @[el2_lib.scala 244:36]
  wire  _T_986 = _T_985 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_989 = io_trigger_pkt_any_3_tdata2[8] == dec_i0_match_data_3[8]; // @[el2_lib.scala 244:78]
  wire  _T_990 = _T_986 | _T_989; // @[el2_lib.scala 244:23]
  wire  _T_992 = &io_trigger_pkt_any_3_tdata2[8:0]; // @[el2_lib.scala 244:36]
  wire  _T_993 = _T_992 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_996 = io_trigger_pkt_any_3_tdata2[9] == dec_i0_match_data_3[9]; // @[el2_lib.scala 244:78]
  wire  _T_997 = _T_993 | _T_996; // @[el2_lib.scala 244:23]
  wire  _T_999 = &io_trigger_pkt_any_3_tdata2[9:0]; // @[el2_lib.scala 244:36]
  wire  _T_1000 = _T_999 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1003 = io_trigger_pkt_any_3_tdata2[10] == dec_i0_match_data_3[10]; // @[el2_lib.scala 244:78]
  wire  _T_1004 = _T_1000 | _T_1003; // @[el2_lib.scala 244:23]
  wire  _T_1006 = &io_trigger_pkt_any_3_tdata2[10:0]; // @[el2_lib.scala 244:36]
  wire  _T_1007 = _T_1006 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1010 = io_trigger_pkt_any_3_tdata2[11] == dec_i0_match_data_3[11]; // @[el2_lib.scala 244:78]
  wire  _T_1011 = _T_1007 | _T_1010; // @[el2_lib.scala 244:23]
  wire  _T_1013 = &io_trigger_pkt_any_3_tdata2[11:0]; // @[el2_lib.scala 244:36]
  wire  _T_1014 = _T_1013 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1017 = io_trigger_pkt_any_3_tdata2[12] == dec_i0_match_data_3[12]; // @[el2_lib.scala 244:78]
  wire  _T_1018 = _T_1014 | _T_1017; // @[el2_lib.scala 244:23]
  wire  _T_1020 = &io_trigger_pkt_any_3_tdata2[12:0]; // @[el2_lib.scala 244:36]
  wire  _T_1021 = _T_1020 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1024 = io_trigger_pkt_any_3_tdata2[13] == dec_i0_match_data_3[13]; // @[el2_lib.scala 244:78]
  wire  _T_1025 = _T_1021 | _T_1024; // @[el2_lib.scala 244:23]
  wire  _T_1027 = &io_trigger_pkt_any_3_tdata2[13:0]; // @[el2_lib.scala 244:36]
  wire  _T_1028 = _T_1027 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1031 = io_trigger_pkt_any_3_tdata2[14] == dec_i0_match_data_3[14]; // @[el2_lib.scala 244:78]
  wire  _T_1032 = _T_1028 | _T_1031; // @[el2_lib.scala 244:23]
  wire  _T_1034 = &io_trigger_pkt_any_3_tdata2[14:0]; // @[el2_lib.scala 244:36]
  wire  _T_1035 = _T_1034 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1038 = io_trigger_pkt_any_3_tdata2[15] == dec_i0_match_data_3[15]; // @[el2_lib.scala 244:78]
  wire  _T_1039 = _T_1035 | _T_1038; // @[el2_lib.scala 244:23]
  wire  _T_1041 = &io_trigger_pkt_any_3_tdata2[15:0]; // @[el2_lib.scala 244:36]
  wire  _T_1042 = _T_1041 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1045 = io_trigger_pkt_any_3_tdata2[16] == dec_i0_match_data_3[16]; // @[el2_lib.scala 244:78]
  wire  _T_1046 = _T_1042 | _T_1045; // @[el2_lib.scala 244:23]
  wire  _T_1048 = &io_trigger_pkt_any_3_tdata2[16:0]; // @[el2_lib.scala 244:36]
  wire  _T_1049 = _T_1048 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1052 = io_trigger_pkt_any_3_tdata2[17] == dec_i0_match_data_3[17]; // @[el2_lib.scala 244:78]
  wire  _T_1053 = _T_1049 | _T_1052; // @[el2_lib.scala 244:23]
  wire  _T_1055 = &io_trigger_pkt_any_3_tdata2[17:0]; // @[el2_lib.scala 244:36]
  wire  _T_1056 = _T_1055 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1059 = io_trigger_pkt_any_3_tdata2[18] == dec_i0_match_data_3[18]; // @[el2_lib.scala 244:78]
  wire  _T_1060 = _T_1056 | _T_1059; // @[el2_lib.scala 244:23]
  wire  _T_1062 = &io_trigger_pkt_any_3_tdata2[18:0]; // @[el2_lib.scala 244:36]
  wire  _T_1063 = _T_1062 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1066 = io_trigger_pkt_any_3_tdata2[19] == dec_i0_match_data_3[19]; // @[el2_lib.scala 244:78]
  wire  _T_1067 = _T_1063 | _T_1066; // @[el2_lib.scala 244:23]
  wire  _T_1069 = &io_trigger_pkt_any_3_tdata2[19:0]; // @[el2_lib.scala 244:36]
  wire  _T_1070 = _T_1069 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1073 = io_trigger_pkt_any_3_tdata2[20] == dec_i0_match_data_3[20]; // @[el2_lib.scala 244:78]
  wire  _T_1074 = _T_1070 | _T_1073; // @[el2_lib.scala 244:23]
  wire  _T_1076 = &io_trigger_pkt_any_3_tdata2[20:0]; // @[el2_lib.scala 244:36]
  wire  _T_1077 = _T_1076 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1080 = io_trigger_pkt_any_3_tdata2[21] == dec_i0_match_data_3[21]; // @[el2_lib.scala 244:78]
  wire  _T_1081 = _T_1077 | _T_1080; // @[el2_lib.scala 244:23]
  wire  _T_1083 = &io_trigger_pkt_any_3_tdata2[21:0]; // @[el2_lib.scala 244:36]
  wire  _T_1084 = _T_1083 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1087 = io_trigger_pkt_any_3_tdata2[22] == dec_i0_match_data_3[22]; // @[el2_lib.scala 244:78]
  wire  _T_1088 = _T_1084 | _T_1087; // @[el2_lib.scala 244:23]
  wire  _T_1090 = &io_trigger_pkt_any_3_tdata2[22:0]; // @[el2_lib.scala 244:36]
  wire  _T_1091 = _T_1090 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1094 = io_trigger_pkt_any_3_tdata2[23] == dec_i0_match_data_3[23]; // @[el2_lib.scala 244:78]
  wire  _T_1095 = _T_1091 | _T_1094; // @[el2_lib.scala 244:23]
  wire  _T_1097 = &io_trigger_pkt_any_3_tdata2[23:0]; // @[el2_lib.scala 244:36]
  wire  _T_1098 = _T_1097 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1101 = io_trigger_pkt_any_3_tdata2[24] == dec_i0_match_data_3[24]; // @[el2_lib.scala 244:78]
  wire  _T_1102 = _T_1098 | _T_1101; // @[el2_lib.scala 244:23]
  wire  _T_1104 = &io_trigger_pkt_any_3_tdata2[24:0]; // @[el2_lib.scala 244:36]
  wire  _T_1105 = _T_1104 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1108 = io_trigger_pkt_any_3_tdata2[25] == dec_i0_match_data_3[25]; // @[el2_lib.scala 244:78]
  wire  _T_1109 = _T_1105 | _T_1108; // @[el2_lib.scala 244:23]
  wire  _T_1111 = &io_trigger_pkt_any_3_tdata2[25:0]; // @[el2_lib.scala 244:36]
  wire  _T_1112 = _T_1111 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1115 = io_trigger_pkt_any_3_tdata2[26] == dec_i0_match_data_3[26]; // @[el2_lib.scala 244:78]
  wire  _T_1116 = _T_1112 | _T_1115; // @[el2_lib.scala 244:23]
  wire  _T_1118 = &io_trigger_pkt_any_3_tdata2[26:0]; // @[el2_lib.scala 244:36]
  wire  _T_1119 = _T_1118 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1122 = io_trigger_pkt_any_3_tdata2[27] == dec_i0_match_data_3[27]; // @[el2_lib.scala 244:78]
  wire  _T_1123 = _T_1119 | _T_1122; // @[el2_lib.scala 244:23]
  wire  _T_1125 = &io_trigger_pkt_any_3_tdata2[27:0]; // @[el2_lib.scala 244:36]
  wire  _T_1126 = _T_1125 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1129 = io_trigger_pkt_any_3_tdata2[28] == dec_i0_match_data_3[28]; // @[el2_lib.scala 244:78]
  wire  _T_1130 = _T_1126 | _T_1129; // @[el2_lib.scala 244:23]
  wire  _T_1132 = &io_trigger_pkt_any_3_tdata2[28:0]; // @[el2_lib.scala 244:36]
  wire  _T_1133 = _T_1132 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1136 = io_trigger_pkt_any_3_tdata2[29] == dec_i0_match_data_3[29]; // @[el2_lib.scala 244:78]
  wire  _T_1137 = _T_1133 | _T_1136; // @[el2_lib.scala 244:23]
  wire  _T_1139 = &io_trigger_pkt_any_3_tdata2[29:0]; // @[el2_lib.scala 244:36]
  wire  _T_1140 = _T_1139 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1143 = io_trigger_pkt_any_3_tdata2[30] == dec_i0_match_data_3[30]; // @[el2_lib.scala 244:78]
  wire  _T_1144 = _T_1140 | _T_1143; // @[el2_lib.scala 244:23]
  wire  _T_1146 = &io_trigger_pkt_any_3_tdata2[30:0]; // @[el2_lib.scala 244:36]
  wire  _T_1147 = _T_1146 & _T_930; // @[el2_lib.scala 244:41]
  wire  _T_1150 = io_trigger_pkt_any_3_tdata2[31] == dec_i0_match_data_3[31]; // @[el2_lib.scala 244:78]
  wire  _T_1151 = _T_1147 | _T_1150; // @[el2_lib.scala 244:23]
  wire [7:0] _T_1158 = {_T_983,_T_976,_T_969,_T_962,_T_955,_T_948,_T_941,_T_934}; // @[el2_lib.scala 245:14]
  wire [15:0] _T_1166 = {_T_1039,_T_1032,_T_1025,_T_1018,_T_1011,_T_1004,_T_997,_T_990,_T_1158}; // @[el2_lib.scala 245:14]
  wire [7:0] _T_1173 = {_T_1095,_T_1088,_T_1081,_T_1074,_T_1067,_T_1060,_T_1053,_T_1046}; // @[el2_lib.scala 245:14]
  wire [31:0] _T_1182 = {_T_1151,_T_1144,_T_1137,_T_1130,_T_1123,_T_1116,_T_1109,_T_1102,_T_1173,_T_1166}; // @[el2_lib.scala 245:14]
  wire [31:0] _GEN_3 = {{31'd0}, _T_925}; // @[dec_trigger.scala 15:109]
  wire [31:0] _T_1183 = _GEN_3 & _T_1182; // @[dec_trigger.scala 15:109]
  wire [127:0] _T_1186 = {_T_1183,_T_924,_T_665,_T_406}; // @[Cat.scala 29:58]
  assign io_dec_i0_trigger_match_d = _T_1186[3:0]; // @[dec_trigger.scala 15:29]
endmodule
module dec(
  input         clock,
  input         reset,
  input         io_free_clk,
  input         io_active_clk,
  input         io_lsu_fastint_stall_any,
  output        io_dec_pause_state_cg,
  input  [30:0] io_rst_vec,
  input         io_nmi_int,
  input  [30:0] io_nmi_vec,
  input         io_i_cpu_halt_req,
  input         io_i_cpu_run_req,
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
  input         io_lsu_pmu_misaligned_m,
  input  [30:0] io_lsu_fir_addr,
  input  [1:0]  io_lsu_fir_error,
  input  [3:0]  io_lsu_trigger_match_m,
  input         io_lsu_idle_any,
  input         io_lsu_error_pkt_r_valid,
  input         io_lsu_error_pkt_r_bits_single_ecc_error,
  input         io_lsu_error_pkt_r_bits_inst_type,
  input         io_lsu_error_pkt_r_bits_exc_type,
  input  [3:0]  io_lsu_error_pkt_r_bits_mscause,
  input  [31:0] io_lsu_error_pkt_r_bits_addr,
  input         io_lsu_single_ecc_error_incr,
  input  [31:0] io_exu_div_result,
  input         io_exu_div_wren,
  input  [31:0] io_lsu_result_m,
  input  [31:0] io_lsu_result_corr_r,
  input         io_lsu_load_stall_any,
  input         io_lsu_store_stall_any,
  input         io_iccm_dma_sb_error,
  input         io_exu_flush_final,
  input         io_timer_int,
  input         io_soft_int,
  input         io_dbg_halt_req,
  input         io_dbg_resume_req,
  output        io_dec_tlu_dbg_halted,
  output        io_dec_tlu_debug_mode,
  output        io_dec_tlu_resume_ack,
  output        io_dec_tlu_mpc_halted_only,
  output [31:0] io_dec_dbg_rddata,
  output        io_dec_dbg_cmd_done,
  output        io_dec_dbg_cmd_fail,
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
  input         io_exu_i0_br_way_r,
  output        io_lsu_p_valid,
  output        io_lsu_p_bits_fast_int,
  output        io_lsu_p_bits_by,
  output        io_lsu_p_bits_half,
  output        io_lsu_p_bits_word,
  output        io_lsu_p_bits_dword,
  output        io_lsu_p_bits_load,
  output        io_lsu_p_bits_store,
  output        io_lsu_p_bits_unsign,
  output        io_lsu_p_bits_dma,
  output        io_lsu_p_bits_store_data_bypass_d,
  output        io_lsu_p_bits_load_ldst_bypass_d,
  output        io_lsu_p_bits_store_data_bypass_m,
  output [11:0] io_dec_lsu_offset_d,
  output        io_dec_tlu_i0_kill_writeb_r,
  output        io_dec_tlu_perfcnt0,
  output        io_dec_tlu_perfcnt1,
  output        io_dec_tlu_perfcnt2,
  output        io_dec_tlu_perfcnt3,
  output        io_dec_lsu_valid_raw_d,
  output [1:0]  io_rv_trace_pkt_rv_i_valid_ip,
  output [31:0] io_rv_trace_pkt_rv_i_insn_ip,
  output [31:0] io_rv_trace_pkt_rv_i_address_ip,
  output [1:0]  io_rv_trace_pkt_rv_i_exception_ip,
  output [4:0]  io_rv_trace_pkt_rv_i_ecause_ip,
  output [1:0]  io_rv_trace_pkt_rv_i_interrupt_ip,
  output [31:0] io_rv_trace_pkt_rv_i_tval_ip,
  output        io_dec_tlu_misc_clk_override,
  output        io_dec_tlu_ifu_clk_override,
  output        io_dec_tlu_lsu_clk_override,
  output        io_dec_tlu_bus_clk_override,
  output        io_dec_tlu_pic_clk_override,
  output        io_dec_tlu_dccm_clk_override,
  output        io_dec_tlu_icm_clk_override,
  input         io_scan_mode,
  output        io_ifu_dec_dec_aln_aln_dec_dec_i0_decode_d,
  input  [15:0] io_ifu_dec_dec_aln_aln_dec_ifu_i0_cinst,
  input         io_ifu_dec_dec_aln_aln_ib_ifu_i0_icaf,
  input  [1:0]  io_ifu_dec_dec_aln_aln_ib_ifu_i0_icaf_type,
  input         io_ifu_dec_dec_aln_aln_ib_ifu_i0_icaf_f1,
  input         io_ifu_dec_dec_aln_aln_ib_ifu_i0_dbecc,
  input  [7:0]  io_ifu_dec_dec_aln_aln_ib_ifu_i0_bp_index,
  input  [7:0]  io_ifu_dec_dec_aln_aln_ib_ifu_i0_bp_fghr,
  input  [4:0]  io_ifu_dec_dec_aln_aln_ib_ifu_i0_bp_btag,
  input         io_ifu_dec_dec_aln_aln_ib_ifu_i0_valid,
  input  [31:0] io_ifu_dec_dec_aln_aln_ib_ifu_i0_instr,
  input  [30:0] io_ifu_dec_dec_aln_aln_ib_ifu_i0_pc,
  input         io_ifu_dec_dec_aln_aln_ib_ifu_i0_pc4,
  input         io_ifu_dec_dec_aln_aln_ib_i0_brp_valid,
  input  [11:0] io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_toffset,
  input  [1:0]  io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_hist,
  input         io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_br_error,
  input         io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_br_start_error,
  input         io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_bank,
  input  [30:0] io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_prett,
  input         io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_way,
  input         io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_ret,
  input         io_ifu_dec_dec_aln_ifu_pmu_instr_aligned,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_flush_lower_wb,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_flush_err_wb,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_i0_commit_cmt,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_force_halt,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_fence_i_wb,
  output [70:0] io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_wrdata,
  output [16:0] io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_dicawics,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_rd_valid,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_wr_valid,
  output        io_ifu_dec_dec_mem_ctrl_dec_tlu_core_ecc_disable,
  input         io_ifu_dec_dec_mem_ctrl_ifu_pmu_ic_miss,
  input         io_ifu_dec_dec_mem_ctrl_ifu_pmu_ic_hit,
  input         io_ifu_dec_dec_mem_ctrl_ifu_pmu_bus_error,
  input         io_ifu_dec_dec_mem_ctrl_ifu_pmu_bus_busy,
  input         io_ifu_dec_dec_mem_ctrl_ifu_pmu_bus_trxn,
  input         io_ifu_dec_dec_mem_ctrl_ifu_ic_error_start,
  input         io_ifu_dec_dec_mem_ctrl_ifu_iccm_rd_ecc_single_err,
  input  [70:0] io_ifu_dec_dec_mem_ctrl_ifu_ic_debug_rd_data,
  input         io_ifu_dec_dec_mem_ctrl_ifu_ic_debug_rd_data_valid,
  input         io_ifu_dec_dec_mem_ctrl_ifu_miss_state_idle,
  output        io_ifu_dec_dec_ifc_dec_tlu_flush_noredir_wb,
  output [31:0] io_ifu_dec_dec_ifc_dec_tlu_mrac_ff,
  input         io_ifu_dec_dec_ifc_ifu_pmu_fetch_stall,
  output        io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_valid,
  output [1:0]  io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_hist,
  output        io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_br_error,
  output        io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_br_start_error,
  output        io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_way,
  output        io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_middle,
  output        io_ifu_dec_dec_bp_dec_tlu_flush_lower_wb,
  output        io_ifu_dec_dec_bp_dec_tlu_flush_leak_one_wb,
  output        io_ifu_dec_dec_bp_dec_tlu_bpred_disable,
  output        io_dec_exu_dec_alu_dec_i0_alu_decode_d,
  output        io_dec_exu_dec_alu_dec_csr_ren_d,
  output [11:0] io_dec_exu_dec_alu_dec_i0_br_immed_d,
  input  [30:0] io_dec_exu_dec_alu_exu_i0_pc_x,
  output        io_dec_exu_dec_div_div_p_valid,
  output        io_dec_exu_dec_div_div_p_bits_unsign,
  output        io_dec_exu_dec_div_div_p_bits_rem,
  output        io_dec_exu_dec_div_dec_div_cancel,
  output [1:0]  io_dec_exu_decode_exu_dec_data_en,
  output [1:0]  io_dec_exu_decode_exu_dec_ctl_en,
  output        io_dec_exu_decode_exu_i0_ap_land,
  output        io_dec_exu_decode_exu_i0_ap_lor,
  output        io_dec_exu_decode_exu_i0_ap_lxor,
  output        io_dec_exu_decode_exu_i0_ap_sll,
  output        io_dec_exu_decode_exu_i0_ap_srl,
  output        io_dec_exu_decode_exu_i0_ap_sra,
  output        io_dec_exu_decode_exu_i0_ap_beq,
  output        io_dec_exu_decode_exu_i0_ap_bne,
  output        io_dec_exu_decode_exu_i0_ap_blt,
  output        io_dec_exu_decode_exu_i0_ap_bge,
  output        io_dec_exu_decode_exu_i0_ap_add,
  output        io_dec_exu_decode_exu_i0_ap_sub,
  output        io_dec_exu_decode_exu_i0_ap_slt,
  output        io_dec_exu_decode_exu_i0_ap_unsign,
  output        io_dec_exu_decode_exu_i0_ap_jal,
  output        io_dec_exu_decode_exu_i0_ap_predict_t,
  output        io_dec_exu_decode_exu_i0_ap_predict_nt,
  output        io_dec_exu_decode_exu_i0_ap_csr_write,
  output        io_dec_exu_decode_exu_i0_ap_csr_imm,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_valid,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_misp,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_ataken,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_boffset,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pc4,
  output [1:0]  io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_hist,
  output [11:0] io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_toffset,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_br_error,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_br_start_error,
  output [30:0] io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_prett,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pcall,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pret,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pja,
  output        io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_way,
  output [7:0]  io_dec_exu_decode_exu_i0_predict_fghr_d,
  output [7:0]  io_dec_exu_decode_exu_i0_predict_index_d,
  output [4:0]  io_dec_exu_decode_exu_i0_predict_btag_d,
  output        io_dec_exu_decode_exu_dec_i0_rs1_en_d,
  output        io_dec_exu_decode_exu_dec_i0_rs2_en_d,
  output [31:0] io_dec_exu_decode_exu_dec_i0_immed_d,
  output [31:0] io_dec_exu_decode_exu_dec_i0_rs1_bypass_data_d,
  output [31:0] io_dec_exu_decode_exu_dec_i0_rs2_bypass_data_d,
  output        io_dec_exu_decode_exu_dec_i0_select_pc_d,
  output [1:0]  io_dec_exu_decode_exu_dec_i0_rs1_bypass_en_d,
  output [1:0]  io_dec_exu_decode_exu_dec_i0_rs2_bypass_en_d,
  output        io_dec_exu_decode_exu_mul_p_valid,
  output        io_dec_exu_decode_exu_mul_p_bits_rs1_sign,
  output        io_dec_exu_decode_exu_mul_p_bits_rs2_sign,
  output        io_dec_exu_decode_exu_mul_p_bits_low,
  output        io_dec_exu_decode_exu_mul_p_bits_bext,
  output        io_dec_exu_decode_exu_mul_p_bits_bdep,
  output        io_dec_exu_decode_exu_mul_p_bits_clmul,
  output        io_dec_exu_decode_exu_mul_p_bits_clmulh,
  output        io_dec_exu_decode_exu_mul_p_bits_clmulr,
  output        io_dec_exu_decode_exu_mul_p_bits_grev,
  output        io_dec_exu_decode_exu_mul_p_bits_shfl,
  output        io_dec_exu_decode_exu_mul_p_bits_unshfl,
  output        io_dec_exu_decode_exu_mul_p_bits_crc32_b,
  output        io_dec_exu_decode_exu_mul_p_bits_crc32_h,
  output        io_dec_exu_decode_exu_mul_p_bits_crc32_w,
  output        io_dec_exu_decode_exu_mul_p_bits_crc32c_b,
  output        io_dec_exu_decode_exu_mul_p_bits_crc32c_h,
  output        io_dec_exu_decode_exu_mul_p_bits_crc32c_w,
  output        io_dec_exu_decode_exu_mul_p_bits_bfp,
  output [30:0] io_dec_exu_decode_exu_pred_correct_npc_x,
  output        io_dec_exu_decode_exu_dec_extint_stall,
  input  [31:0] io_dec_exu_decode_exu_exu_i0_result_x,
  input  [31:0] io_dec_exu_decode_exu_exu_csr_rs1_x,
  output [29:0] io_dec_exu_tlu_exu_dec_tlu_meihap,
  output        io_dec_exu_tlu_exu_dec_tlu_flush_lower_r,
  output [30:0] io_dec_exu_tlu_exu_dec_tlu_flush_path_r,
  input  [1:0]  io_dec_exu_tlu_exu_exu_i0_br_hist_r,
  input         io_dec_exu_tlu_exu_exu_i0_br_error_r,
  input         io_dec_exu_tlu_exu_exu_i0_br_start_error_r,
  input  [7:0]  io_dec_exu_tlu_exu_exu_i0_br_index_r,
  input         io_dec_exu_tlu_exu_exu_i0_br_valid_r,
  input         io_dec_exu_tlu_exu_exu_i0_br_mp_r,
  input         io_dec_exu_tlu_exu_exu_i0_br_middle_r,
  input         io_dec_exu_tlu_exu_exu_pmu_i0_br_misp,
  input         io_dec_exu_tlu_exu_exu_pmu_i0_br_ataken,
  input         io_dec_exu_tlu_exu_exu_pmu_i0_pc4,
  input  [30:0] io_dec_exu_tlu_exu_exu_npc_r,
  output [30:0] io_dec_exu_ib_exu_dec_i0_pc_d,
  output        io_dec_exu_ib_exu_dec_debug_wdata_rs1_d,
  output [31:0] io_dec_exu_gpr_exu_gpr_i0_rs1_d,
  output [31:0] io_dec_exu_gpr_exu_gpr_i0_rs2_d,
  input         io_lsu_dec_tlu_busbuff_lsu_pmu_bus_trxn,
  input         io_lsu_dec_tlu_busbuff_lsu_pmu_bus_misaligned,
  input         io_lsu_dec_tlu_busbuff_lsu_pmu_bus_error,
  input         io_lsu_dec_tlu_busbuff_lsu_pmu_bus_busy,
  output        io_lsu_dec_tlu_busbuff_dec_tlu_external_ldfwd_disable,
  output        io_lsu_dec_tlu_busbuff_dec_tlu_wb_coalescing_disable,
  output        io_lsu_dec_tlu_busbuff_dec_tlu_sideeffect_posted_disable,
  input         io_lsu_dec_tlu_busbuff_lsu_imprecise_error_load_any,
  input         io_lsu_dec_tlu_busbuff_lsu_imprecise_error_store_any,
  input  [31:0] io_lsu_dec_tlu_busbuff_lsu_imprecise_error_addr_any,
  input         io_lsu_dec_dctl_busbuff_lsu_nonblock_load_valid_m,
  input  [1:0]  io_lsu_dec_dctl_busbuff_lsu_nonblock_load_tag_m,
  input         io_lsu_dec_dctl_busbuff_lsu_nonblock_load_inv_r,
  input  [1:0]  io_lsu_dec_dctl_busbuff_lsu_nonblock_load_inv_tag_r,
  input         io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data_valid,
  input         io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data_error,
  input  [1:0]  io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data_tag,
  input  [31:0] io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data,
  input         io_lsu_tlu_lsu_pmu_load_external_m,
  input         io_lsu_tlu_lsu_pmu_store_external_m,
  input         io_dec_dbg_dbg_ib_dbg_cmd_valid,
  input         io_dec_dbg_dbg_ib_dbg_cmd_write,
  input  [1:0]  io_dec_dbg_dbg_ib_dbg_cmd_type,
  input  [31:0] io_dec_dbg_dbg_ib_dbg_cmd_addr,
  input  [1:0]  io_dec_dbg_dbg_dctl_dbg_cmd_wrdata,
  input         io_dec_dma_dctl_dma_dma_dccm_stall_any,
  input         io_dec_dma_tlu_dma_dma_pmu_dccm_read,
  input         io_dec_dma_tlu_dma_dma_pmu_dccm_write,
  input         io_dec_dma_tlu_dma_dma_pmu_any_read,
  input         io_dec_dma_tlu_dma_dma_pmu_any_write,
  output [2:0]  io_dec_dma_tlu_dma_dec_tlu_dma_qos_prty,
  input         io_dec_dma_tlu_dma_dma_dccm_stall_any,
  input         io_dec_dma_tlu_dma_dma_iccm_stall_any,
  input  [7:0]  io_dec_pic_pic_claimid,
  input  [3:0]  io_dec_pic_pic_pl,
  input         io_dec_pic_mhwakeup,
  output [3:0]  io_dec_pic_dec_tlu_meicurpl,
  output [3:0]  io_dec_pic_dec_tlu_meipt,
  input         io_dec_pic_mexintpend
);
  wire  instbuff_io_ifu_ib_ifu_i0_icaf; // @[dec.scala 117:24]
  wire [1:0] instbuff_io_ifu_ib_ifu_i0_icaf_type; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_ifu_i0_icaf_f1; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_ifu_i0_dbecc; // @[dec.scala 117:24]
  wire [7:0] instbuff_io_ifu_ib_ifu_i0_bp_index; // @[dec.scala 117:24]
  wire [7:0] instbuff_io_ifu_ib_ifu_i0_bp_fghr; // @[dec.scala 117:24]
  wire [4:0] instbuff_io_ifu_ib_ifu_i0_bp_btag; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_ifu_i0_valid; // @[dec.scala 117:24]
  wire [31:0] instbuff_io_ifu_ib_ifu_i0_instr; // @[dec.scala 117:24]
  wire [30:0] instbuff_io_ifu_ib_ifu_i0_pc; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_ifu_i0_pc4; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_i0_brp_valid; // @[dec.scala 117:24]
  wire [11:0] instbuff_io_ifu_ib_i0_brp_bits_toffset; // @[dec.scala 117:24]
  wire [1:0] instbuff_io_ifu_ib_i0_brp_bits_hist; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_i0_brp_bits_br_error; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_i0_brp_bits_br_start_error; // @[dec.scala 117:24]
  wire [30:0] instbuff_io_ifu_ib_i0_brp_bits_prett; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_i0_brp_bits_way; // @[dec.scala 117:24]
  wire  instbuff_io_ifu_ib_i0_brp_bits_ret; // @[dec.scala 117:24]
  wire [30:0] instbuff_io_ib_exu_dec_i0_pc_d; // @[dec.scala 117:24]
  wire  instbuff_io_ib_exu_dec_debug_wdata_rs1_d; // @[dec.scala 117:24]
  wire  instbuff_io_dbg_ib_dbg_cmd_valid; // @[dec.scala 117:24]
  wire  instbuff_io_dbg_ib_dbg_cmd_write; // @[dec.scala 117:24]
  wire [1:0] instbuff_io_dbg_ib_dbg_cmd_type; // @[dec.scala 117:24]
  wire [31:0] instbuff_io_dbg_ib_dbg_cmd_addr; // @[dec.scala 117:24]
  wire  instbuff_io_dec_ib0_valid_d; // @[dec.scala 117:24]
  wire [1:0] instbuff_io_dec_i0_icaf_type_d; // @[dec.scala 117:24]
  wire [31:0] instbuff_io_dec_i0_instr_d; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_pc4_d; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_brp_valid; // @[dec.scala 117:24]
  wire [11:0] instbuff_io_dec_i0_brp_bits_toffset; // @[dec.scala 117:24]
  wire [1:0] instbuff_io_dec_i0_brp_bits_hist; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_brp_bits_br_error; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_brp_bits_br_start_error; // @[dec.scala 117:24]
  wire [30:0] instbuff_io_dec_i0_brp_bits_prett; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_brp_bits_way; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_brp_bits_ret; // @[dec.scala 117:24]
  wire [7:0] instbuff_io_dec_i0_bp_index; // @[dec.scala 117:24]
  wire [7:0] instbuff_io_dec_i0_bp_fghr; // @[dec.scala 117:24]
  wire [4:0] instbuff_io_dec_i0_bp_btag; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_icaf_d; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_icaf_f1_d; // @[dec.scala 117:24]
  wire  instbuff_io_dec_i0_dbecc_d; // @[dec.scala 117:24]
  wire  instbuff_io_dec_debug_fence_d; // @[dec.scala 117:24]
  wire  decode_clock; // @[dec.scala 118:22]
  wire  decode_reset; // @[dec.scala 118:22]
  wire [1:0] decode_io_decode_exu_dec_data_en; // @[dec.scala 118:22]
  wire [1:0] decode_io_decode_exu_dec_ctl_en; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_land; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_lor; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_lxor; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_sll; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_srl; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_sra; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_beq; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_bne; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_blt; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_bge; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_add; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_sub; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_slt; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_unsign; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_jal; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_predict_t; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_predict_nt; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_csr_write; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_i0_ap_csr_imm; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_valid; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_pc4; // @[dec.scala 118:22]
  wire [1:0] decode_io_decode_exu_dec_i0_predict_p_d_bits_hist; // @[dec.scala 118:22]
  wire [11:0] decode_io_decode_exu_dec_i0_predict_p_d_bits_toffset; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_br_error; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_br_start_error; // @[dec.scala 118:22]
  wire [30:0] decode_io_decode_exu_dec_i0_predict_p_d_bits_prett; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_pcall; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_pret; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_pja; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_predict_p_d_bits_way; // @[dec.scala 118:22]
  wire [7:0] decode_io_decode_exu_i0_predict_fghr_d; // @[dec.scala 118:22]
  wire [7:0] decode_io_decode_exu_i0_predict_index_d; // @[dec.scala 118:22]
  wire [4:0] decode_io_decode_exu_i0_predict_btag_d; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_rs1_en_d; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_rs2_en_d; // @[dec.scala 118:22]
  wire [31:0] decode_io_decode_exu_dec_i0_immed_d; // @[dec.scala 118:22]
  wire [31:0] decode_io_decode_exu_dec_i0_rs1_bypass_data_d; // @[dec.scala 118:22]
  wire [31:0] decode_io_decode_exu_dec_i0_rs2_bypass_data_d; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_i0_select_pc_d; // @[dec.scala 118:22]
  wire [1:0] decode_io_decode_exu_dec_i0_rs1_bypass_en_d; // @[dec.scala 118:22]
  wire [1:0] decode_io_decode_exu_dec_i0_rs2_bypass_en_d; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_mul_p_valid; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_mul_p_bits_rs1_sign; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_mul_p_bits_rs2_sign; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_mul_p_bits_low; // @[dec.scala 118:22]
  wire [30:0] decode_io_decode_exu_pred_correct_npc_x; // @[dec.scala 118:22]
  wire  decode_io_decode_exu_dec_extint_stall; // @[dec.scala 118:22]
  wire [31:0] decode_io_decode_exu_exu_i0_result_x; // @[dec.scala 118:22]
  wire [31:0] decode_io_decode_exu_exu_csr_rs1_x; // @[dec.scala 118:22]
  wire  decode_io_dec_alu_dec_i0_alu_decode_d; // @[dec.scala 118:22]
  wire  decode_io_dec_alu_dec_csr_ren_d; // @[dec.scala 118:22]
  wire [11:0] decode_io_dec_alu_dec_i0_br_immed_d; // @[dec.scala 118:22]
  wire [30:0] decode_io_dec_alu_exu_i0_pc_x; // @[dec.scala 118:22]
  wire  decode_io_dec_div_div_p_valid; // @[dec.scala 118:22]
  wire  decode_io_dec_div_div_p_bits_unsign; // @[dec.scala 118:22]
  wire  decode_io_dec_div_div_p_bits_rem; // @[dec.scala 118:22]
  wire  decode_io_dec_div_dec_div_cancel; // @[dec.scala 118:22]
  wire  decode_io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[dec.scala 118:22]
  wire [1:0] decode_io_dctl_busbuff_lsu_nonblock_load_tag_m; // @[dec.scala 118:22]
  wire  decode_io_dctl_busbuff_lsu_nonblock_load_inv_r; // @[dec.scala 118:22]
  wire [1:0] decode_io_dctl_busbuff_lsu_nonblock_load_inv_tag_r; // @[dec.scala 118:22]
  wire  decode_io_dctl_busbuff_lsu_nonblock_load_data_valid; // @[dec.scala 118:22]
  wire  decode_io_dctl_busbuff_lsu_nonblock_load_data_error; // @[dec.scala 118:22]
  wire [1:0] decode_io_dctl_busbuff_lsu_nonblock_load_data_tag; // @[dec.scala 118:22]
  wire [31:0] decode_io_dctl_busbuff_lsu_nonblock_load_data; // @[dec.scala 118:22]
  wire  decode_io_dctl_dma_dma_dccm_stall_any; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_flush_extint; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_force_halt; // @[dec.scala 118:22]
  wire [31:0] decode_io_dec_i0_inst_wb1; // @[dec.scala 118:22]
  wire [30:0] decode_io_dec_i0_pc_wb1; // @[dec.scala 118:22]
  wire [3:0] decode_io_dec_i0_trigger_match_d; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_wr_pause_r; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_pipelining_disable; // @[dec.scala 118:22]
  wire [3:0] decode_io_lsu_trigger_match_m; // @[dec.scala 118:22]
  wire  decode_io_lsu_pmu_misaligned_m; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_debug_stall; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_flush_leak_one_r; // @[dec.scala 118:22]
  wire  decode_io_dec_debug_fence_d; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_icaf_d; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_icaf_f1_d; // @[dec.scala 118:22]
  wire [1:0] decode_io_dec_i0_icaf_type_d; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_dbecc_d; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_brp_valid; // @[dec.scala 118:22]
  wire [11:0] decode_io_dec_i0_brp_bits_toffset; // @[dec.scala 118:22]
  wire [1:0] decode_io_dec_i0_brp_bits_hist; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_brp_bits_br_error; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_brp_bits_br_start_error; // @[dec.scala 118:22]
  wire [30:0] decode_io_dec_i0_brp_bits_prett; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_brp_bits_way; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_brp_bits_ret; // @[dec.scala 118:22]
  wire [7:0] decode_io_dec_i0_bp_index; // @[dec.scala 118:22]
  wire [7:0] decode_io_dec_i0_bp_fghr; // @[dec.scala 118:22]
  wire [4:0] decode_io_dec_i0_bp_btag; // @[dec.scala 118:22]
  wire  decode_io_lsu_idle_any; // @[dec.scala 118:22]
  wire  decode_io_lsu_load_stall_any; // @[dec.scala 118:22]
  wire  decode_io_lsu_store_stall_any; // @[dec.scala 118:22]
  wire  decode_io_exu_div_wren; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_i0_kill_writeb_wb; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_flush_lower_wb; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_i0_kill_writeb_r; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_flush_lower_r; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_flush_pause_r; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_presync_d; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_postsync_d; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_pc4_d; // @[dec.scala 118:22]
  wire [31:0] decode_io_dec_csr_rddata_d; // @[dec.scala 118:22]
  wire  decode_io_dec_csr_legal_d; // @[dec.scala 118:22]
  wire [31:0] decode_io_lsu_result_m; // @[dec.scala 118:22]
  wire [31:0] decode_io_lsu_result_corr_r; // @[dec.scala 118:22]
  wire  decode_io_exu_flush_final; // @[dec.scala 118:22]
  wire [31:0] decode_io_dec_i0_instr_d; // @[dec.scala 118:22]
  wire  decode_io_dec_ib0_valid_d; // @[dec.scala 118:22]
  wire  decode_io_free_clk; // @[dec.scala 118:22]
  wire  decode_io_active_clk; // @[dec.scala 118:22]
  wire  decode_io_clk_override; // @[dec.scala 118:22]
  wire [4:0] decode_io_dec_i0_rs1_d; // @[dec.scala 118:22]
  wire [4:0] decode_io_dec_i0_rs2_d; // @[dec.scala 118:22]
  wire [4:0] decode_io_dec_i0_waddr_r; // @[dec.scala 118:22]
  wire  decode_io_dec_i0_wen_r; // @[dec.scala 118:22]
  wire [31:0] decode_io_dec_i0_wdata_r; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_valid; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_fast_int; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_by; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_half; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_word; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_load; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_store; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_unsign; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_store_data_bypass_d; // @[dec.scala 118:22]
  wire  decode_io_lsu_p_bits_load_ldst_bypass_d; // @[dec.scala 118:22]
  wire [4:0] decode_io_div_waddr_wb; // @[dec.scala 118:22]
  wire  decode_io_dec_lsu_valid_raw_d; // @[dec.scala 118:22]
  wire [11:0] decode_io_dec_lsu_offset_d; // @[dec.scala 118:22]
  wire  decode_io_dec_csr_wen_unq_d; // @[dec.scala 118:22]
  wire  decode_io_dec_csr_any_unq_d; // @[dec.scala 118:22]
  wire [11:0] decode_io_dec_csr_rdaddr_d; // @[dec.scala 118:22]
  wire  decode_io_dec_csr_wen_r; // @[dec.scala 118:22]
  wire [11:0] decode_io_dec_csr_wraddr_r; // @[dec.scala 118:22]
  wire [31:0] decode_io_dec_csr_wrdata_r; // @[dec.scala 118:22]
  wire  decode_io_dec_csr_stall_int_ff; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_i0_valid_r; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_legal; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_icaf; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_icaf_f1; // @[dec.scala 118:22]
  wire [1:0] decode_io_dec_tlu_packet_r_icaf_type; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_fence_i; // @[dec.scala 118:22]
  wire [3:0] decode_io_dec_tlu_packet_r_i0trigger; // @[dec.scala 118:22]
  wire [3:0] decode_io_dec_tlu_packet_r_pmu_i0_itype; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_pmu_divide; // @[dec.scala 118:22]
  wire  decode_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec.scala 118:22]
  wire [30:0] decode_io_dec_tlu_i0_pc_r; // @[dec.scala 118:22]
  wire [31:0] decode_io_dec_illegal_inst; // @[dec.scala 118:22]
  wire  decode_io_dec_pmu_instr_decoded; // @[dec.scala 118:22]
  wire  decode_io_dec_pmu_decode_stall; // @[dec.scala 118:22]
  wire  decode_io_dec_pmu_presync_stall; // @[dec.scala 118:22]
  wire  decode_io_dec_pmu_postsync_stall; // @[dec.scala 118:22]
  wire  decode_io_dec_nonblock_load_wen; // @[dec.scala 118:22]
  wire [4:0] decode_io_dec_nonblock_load_waddr; // @[dec.scala 118:22]
  wire  decode_io_dec_pause_state; // @[dec.scala 118:22]
  wire  decode_io_dec_pause_state_cg; // @[dec.scala 118:22]
  wire  decode_io_dec_div_active; // @[dec.scala 118:22]
  wire  decode_io_scan_mode; // @[dec.scala 118:22]
  wire  decode_io_dec_aln_dec_i0_decode_d; // @[dec.scala 118:22]
  wire [15:0] decode_io_dec_aln_ifu_i0_cinst; // @[dec.scala 118:22]
  wire [1:0] decode_io_dbg_dctl_dbg_cmd_wrdata; // @[dec.scala 118:22]
  wire  gpr_clock; // @[dec.scala 119:19]
  wire  gpr_reset; // @[dec.scala 119:19]
  wire [4:0] gpr_io_raddr0; // @[dec.scala 119:19]
  wire [4:0] gpr_io_raddr1; // @[dec.scala 119:19]
  wire  gpr_io_wen0; // @[dec.scala 119:19]
  wire [4:0] gpr_io_waddr0; // @[dec.scala 119:19]
  wire [31:0] gpr_io_wd0; // @[dec.scala 119:19]
  wire  gpr_io_wen1; // @[dec.scala 119:19]
  wire [4:0] gpr_io_waddr1; // @[dec.scala 119:19]
  wire [31:0] gpr_io_wd1; // @[dec.scala 119:19]
  wire  gpr_io_wen2; // @[dec.scala 119:19]
  wire [4:0] gpr_io_waddr2; // @[dec.scala 119:19]
  wire [31:0] gpr_io_wd2; // @[dec.scala 119:19]
  wire  gpr_io_scan_mode; // @[dec.scala 119:19]
  wire [31:0] gpr_io_gpr_exu_gpr_i0_rs1_d; // @[dec.scala 119:19]
  wire [31:0] gpr_io_gpr_exu_gpr_i0_rs2_d; // @[dec.scala 119:19]
  wire  tlu_clock; // @[dec.scala 120:19]
  wire  tlu_reset; // @[dec.scala 120:19]
  wire [29:0] tlu_io_tlu_exu_dec_tlu_meihap; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_dec_tlu_flush_lower_r; // @[dec.scala 120:19]
  wire [30:0] tlu_io_tlu_exu_dec_tlu_flush_path_r; // @[dec.scala 120:19]
  wire [1:0] tlu_io_tlu_exu_exu_i0_br_hist_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_i0_br_error_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_i0_br_start_error_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_i0_br_valid_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_i0_br_mp_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_i0_br_middle_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_pmu_i0_br_misp; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_pmu_i0_br_ataken; // @[dec.scala 120:19]
  wire  tlu_io_tlu_exu_exu_pmu_i0_pc4; // @[dec.scala 120:19]
  wire [30:0] tlu_io_tlu_exu_exu_npc_r; // @[dec.scala 120:19]
  wire  tlu_io_tlu_dma_dma_pmu_dccm_read; // @[dec.scala 120:19]
  wire  tlu_io_tlu_dma_dma_pmu_dccm_write; // @[dec.scala 120:19]
  wire  tlu_io_tlu_dma_dma_pmu_any_read; // @[dec.scala 120:19]
  wire  tlu_io_tlu_dma_dma_pmu_any_write; // @[dec.scala 120:19]
  wire [2:0] tlu_io_tlu_dma_dec_tlu_dma_qos_prty; // @[dec.scala 120:19]
  wire  tlu_io_tlu_dma_dma_dccm_stall_any; // @[dec.scala 120:19]
  wire  tlu_io_tlu_dma_dma_iccm_stall_any; // @[dec.scala 120:19]
  wire  tlu_io_active_clk; // @[dec.scala 120:19]
  wire  tlu_io_free_clk; // @[dec.scala 120:19]
  wire  tlu_io_scan_mode; // @[dec.scala 120:19]
  wire [30:0] tlu_io_rst_vec; // @[dec.scala 120:19]
  wire  tlu_io_nmi_int; // @[dec.scala 120:19]
  wire [30:0] tlu_io_nmi_vec; // @[dec.scala 120:19]
  wire  tlu_io_i_cpu_halt_req; // @[dec.scala 120:19]
  wire  tlu_io_i_cpu_run_req; // @[dec.scala 120:19]
  wire  tlu_io_lsu_fastint_stall_any; // @[dec.scala 120:19]
  wire  tlu_io_lsu_idle_any; // @[dec.scala 120:19]
  wire  tlu_io_dec_pmu_instr_decoded; // @[dec.scala 120:19]
  wire  tlu_io_dec_pmu_decode_stall; // @[dec.scala 120:19]
  wire  tlu_io_dec_pmu_presync_stall; // @[dec.scala 120:19]
  wire  tlu_io_dec_pmu_postsync_stall; // @[dec.scala 120:19]
  wire  tlu_io_lsu_store_stall_any; // @[dec.scala 120:19]
  wire [30:0] tlu_io_lsu_fir_addr; // @[dec.scala 120:19]
  wire [1:0] tlu_io_lsu_fir_error; // @[dec.scala 120:19]
  wire  tlu_io_iccm_dma_sb_error; // @[dec.scala 120:19]
  wire  tlu_io_lsu_error_pkt_r_valid; // @[dec.scala 120:19]
  wire  tlu_io_lsu_error_pkt_r_bits_single_ecc_error; // @[dec.scala 120:19]
  wire  tlu_io_lsu_error_pkt_r_bits_inst_type; // @[dec.scala 120:19]
  wire  tlu_io_lsu_error_pkt_r_bits_exc_type; // @[dec.scala 120:19]
  wire [3:0] tlu_io_lsu_error_pkt_r_bits_mscause; // @[dec.scala 120:19]
  wire [31:0] tlu_io_lsu_error_pkt_r_bits_addr; // @[dec.scala 120:19]
  wire  tlu_io_lsu_single_ecc_error_incr; // @[dec.scala 120:19]
  wire  tlu_io_dec_pause_state; // @[dec.scala 120:19]
  wire  tlu_io_dec_csr_wen_unq_d; // @[dec.scala 120:19]
  wire  tlu_io_dec_csr_any_unq_d; // @[dec.scala 120:19]
  wire [11:0] tlu_io_dec_csr_rdaddr_d; // @[dec.scala 120:19]
  wire  tlu_io_dec_csr_wen_r; // @[dec.scala 120:19]
  wire [11:0] tlu_io_dec_csr_wraddr_r; // @[dec.scala 120:19]
  wire [31:0] tlu_io_dec_csr_wrdata_r; // @[dec.scala 120:19]
  wire  tlu_io_dec_csr_stall_int_ff; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_i0_valid_r; // @[dec.scala 120:19]
  wire [30:0] tlu_io_dec_tlu_i0_pc_r; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_legal; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_icaf; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_icaf_f1; // @[dec.scala 120:19]
  wire [1:0] tlu_io_dec_tlu_packet_r_icaf_type; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_fence_i; // @[dec.scala 120:19]
  wire [3:0] tlu_io_dec_tlu_packet_r_i0trigger; // @[dec.scala 120:19]
  wire [3:0] tlu_io_dec_tlu_packet_r_pmu_i0_itype; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_pmu_divide; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec.scala 120:19]
  wire [31:0] tlu_io_dec_illegal_inst; // @[dec.scala 120:19]
  wire  tlu_io_dec_i0_decode_d; // @[dec.scala 120:19]
  wire  tlu_io_exu_i0_br_way_r; // @[dec.scala 120:19]
  wire  tlu_io_dec_dbg_cmd_done; // @[dec.scala 120:19]
  wire  tlu_io_dec_dbg_cmd_fail; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_dbg_halted; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_debug_mode; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_resume_ack; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_debug_stall; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_mpc_halted_only; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_flush_extint; // @[dec.scala 120:19]
  wire  tlu_io_dbg_halt_req; // @[dec.scala 120:19]
  wire  tlu_io_dbg_resume_req; // @[dec.scala 120:19]
  wire  tlu_io_dec_div_active; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_0_select; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_0_match_pkt; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_0_store; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_0_load; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_0_execute; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_0_m; // @[dec.scala 120:19]
  wire [31:0] tlu_io_trigger_pkt_any_0_tdata2; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_1_select; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_1_match_pkt; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_1_store; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_1_load; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_1_execute; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_1_m; // @[dec.scala 120:19]
  wire [31:0] tlu_io_trigger_pkt_any_1_tdata2; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_2_select; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_2_match_pkt; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_2_store; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_2_load; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_2_execute; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_2_m; // @[dec.scala 120:19]
  wire [31:0] tlu_io_trigger_pkt_any_2_tdata2; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_3_select; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_3_match_pkt; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_3_store; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_3_load; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_3_execute; // @[dec.scala 120:19]
  wire  tlu_io_trigger_pkt_any_3_m; // @[dec.scala 120:19]
  wire [31:0] tlu_io_trigger_pkt_any_3_tdata2; // @[dec.scala 120:19]
  wire  tlu_io_timer_int; // @[dec.scala 120:19]
  wire  tlu_io_soft_int; // @[dec.scala 120:19]
  wire  tlu_io_o_cpu_halt_status; // @[dec.scala 120:19]
  wire  tlu_io_o_cpu_halt_ack; // @[dec.scala 120:19]
  wire  tlu_io_o_cpu_run_ack; // @[dec.scala 120:19]
  wire  tlu_io_o_debug_mode_status; // @[dec.scala 120:19]
  wire [27:0] tlu_io_core_id; // @[dec.scala 120:19]
  wire  tlu_io_mpc_debug_halt_req; // @[dec.scala 120:19]
  wire  tlu_io_mpc_debug_run_req; // @[dec.scala 120:19]
  wire  tlu_io_mpc_reset_run_req; // @[dec.scala 120:19]
  wire  tlu_io_mpc_debug_halt_ack; // @[dec.scala 120:19]
  wire  tlu_io_mpc_debug_run_ack; // @[dec.scala 120:19]
  wire  tlu_io_debug_brkpt_status; // @[dec.scala 120:19]
  wire [31:0] tlu_io_dec_csr_rddata_d; // @[dec.scala 120:19]
  wire  tlu_io_dec_csr_legal_d; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_i0_kill_writeb_wb; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_i0_kill_writeb_r; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_wr_pause_r; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_flush_pause_r; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_presync_d; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_postsync_d; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_perfcnt0; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_perfcnt1; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_perfcnt2; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_perfcnt3; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_i0_exc_valid_wb1; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_i0_valid_wb1; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_int_valid_wb1; // @[dec.scala 120:19]
  wire [4:0] tlu_io_dec_tlu_exc_cause_wb1; // @[dec.scala 120:19]
  wire [31:0] tlu_io_dec_tlu_mtval_wb1; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_pipelining_disable; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_misc_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_dec_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_ifu_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_lsu_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_bus_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_pic_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_dccm_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_dec_tlu_icm_clk_override; // @[dec.scala 120:19]
  wire  tlu_io_ifu_pmu_instr_aligned; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_br0_r_pkt_valid; // @[dec.scala 120:19]
  wire [1:0] tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_way; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_flush_lower_wb; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_flush_leak_one_wb; // @[dec.scala 120:19]
  wire  tlu_io_tlu_bp_dec_tlu_bpred_disable; // @[dec.scala 120:19]
  wire  tlu_io_tlu_ifc_dec_tlu_flush_noredir_wb; // @[dec.scala 120:19]
  wire [31:0] tlu_io_tlu_ifc_dec_tlu_mrac_ff; // @[dec.scala 120:19]
  wire  tlu_io_tlu_ifc_ifu_pmu_fetch_stall; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_flush_lower_wb; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_flush_err_wb; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_i0_commit_cmt; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_force_halt; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_fence_i_wb; // @[dec.scala 120:19]
  wire [70:0] tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata; // @[dec.scala 120:19]
  wire [16:0] tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_dec_tlu_core_ecc_disable; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_pmu_ic_miss; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_pmu_ic_hit; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_pmu_bus_error; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_pmu_bus_busy; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_pmu_bus_trxn; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_ic_error_start; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_iccm_rd_ecc_single_err; // @[dec.scala 120:19]
  wire [70:0] tlu_io_tlu_mem_ifu_ic_debug_rd_data; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_ic_debug_rd_data_valid; // @[dec.scala 120:19]
  wire  tlu_io_tlu_mem_ifu_miss_state_idle; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_lsu_pmu_bus_trxn; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_lsu_pmu_bus_misaligned; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_lsu_pmu_bus_error; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_lsu_pmu_bus_busy; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_dec_tlu_external_ldfwd_disable; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_dec_tlu_wb_coalescing_disable; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_lsu_imprecise_error_load_any; // @[dec.scala 120:19]
  wire  tlu_io_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec.scala 120:19]
  wire [31:0] tlu_io_tlu_busbuff_lsu_imprecise_error_addr_any; // @[dec.scala 120:19]
  wire  tlu_io_lsu_tlu_lsu_pmu_load_external_m; // @[dec.scala 120:19]
  wire  tlu_io_lsu_tlu_lsu_pmu_store_external_m; // @[dec.scala 120:19]
  wire [7:0] tlu_io_dec_pic_pic_claimid; // @[dec.scala 120:19]
  wire [3:0] tlu_io_dec_pic_pic_pl; // @[dec.scala 120:19]
  wire  tlu_io_dec_pic_mhwakeup; // @[dec.scala 120:19]
  wire [3:0] tlu_io_dec_pic_dec_tlu_meicurpl; // @[dec.scala 120:19]
  wire [3:0] tlu_io_dec_pic_dec_tlu_meipt; // @[dec.scala 120:19]
  wire  tlu_io_dec_pic_mexintpend; // @[dec.scala 120:19]
  wire  dec_trigger_io_trigger_pkt_any_0_select; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_0_match_pkt; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_0_execute; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_0_m; // @[dec.scala 121:27]
  wire [31:0] dec_trigger_io_trigger_pkt_any_0_tdata2; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_1_select; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_1_match_pkt; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_1_execute; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_1_m; // @[dec.scala 121:27]
  wire [31:0] dec_trigger_io_trigger_pkt_any_1_tdata2; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_2_select; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_2_match_pkt; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_2_execute; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_2_m; // @[dec.scala 121:27]
  wire [31:0] dec_trigger_io_trigger_pkt_any_2_tdata2; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_3_select; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_3_match_pkt; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_3_execute; // @[dec.scala 121:27]
  wire  dec_trigger_io_trigger_pkt_any_3_m; // @[dec.scala 121:27]
  wire [31:0] dec_trigger_io_trigger_pkt_any_3_tdata2; // @[dec.scala 121:27]
  wire [30:0] dec_trigger_io_dec_i0_pc_d; // @[dec.scala 121:27]
  wire [3:0] dec_trigger_io_dec_i0_trigger_match_d; // @[dec.scala 121:27]
  wire  _T_1 = tlu_io_dec_tlu_i0_valid_wb1 | tlu_io_dec_tlu_i0_exc_valid_wb1; // @[dec.scala 296:98]
  dec_ib_ctl instbuff ( // @[dec.scala 117:24]
    .io_ifu_ib_ifu_i0_icaf(instbuff_io_ifu_ib_ifu_i0_icaf),
    .io_ifu_ib_ifu_i0_icaf_type(instbuff_io_ifu_ib_ifu_i0_icaf_type),
    .io_ifu_ib_ifu_i0_icaf_f1(instbuff_io_ifu_ib_ifu_i0_icaf_f1),
    .io_ifu_ib_ifu_i0_dbecc(instbuff_io_ifu_ib_ifu_i0_dbecc),
    .io_ifu_ib_ifu_i0_bp_index(instbuff_io_ifu_ib_ifu_i0_bp_index),
    .io_ifu_ib_ifu_i0_bp_fghr(instbuff_io_ifu_ib_ifu_i0_bp_fghr),
    .io_ifu_ib_ifu_i0_bp_btag(instbuff_io_ifu_ib_ifu_i0_bp_btag),
    .io_ifu_ib_ifu_i0_valid(instbuff_io_ifu_ib_ifu_i0_valid),
    .io_ifu_ib_ifu_i0_instr(instbuff_io_ifu_ib_ifu_i0_instr),
    .io_ifu_ib_ifu_i0_pc(instbuff_io_ifu_ib_ifu_i0_pc),
    .io_ifu_ib_ifu_i0_pc4(instbuff_io_ifu_ib_ifu_i0_pc4),
    .io_ifu_ib_i0_brp_valid(instbuff_io_ifu_ib_i0_brp_valid),
    .io_ifu_ib_i0_brp_bits_toffset(instbuff_io_ifu_ib_i0_brp_bits_toffset),
    .io_ifu_ib_i0_brp_bits_hist(instbuff_io_ifu_ib_i0_brp_bits_hist),
    .io_ifu_ib_i0_brp_bits_br_error(instbuff_io_ifu_ib_i0_brp_bits_br_error),
    .io_ifu_ib_i0_brp_bits_br_start_error(instbuff_io_ifu_ib_i0_brp_bits_br_start_error),
    .io_ifu_ib_i0_brp_bits_prett(instbuff_io_ifu_ib_i0_brp_bits_prett),
    .io_ifu_ib_i0_brp_bits_way(instbuff_io_ifu_ib_i0_brp_bits_way),
    .io_ifu_ib_i0_brp_bits_ret(instbuff_io_ifu_ib_i0_brp_bits_ret),
    .io_ib_exu_dec_i0_pc_d(instbuff_io_ib_exu_dec_i0_pc_d),
    .io_ib_exu_dec_debug_wdata_rs1_d(instbuff_io_ib_exu_dec_debug_wdata_rs1_d),
    .io_dbg_ib_dbg_cmd_valid(instbuff_io_dbg_ib_dbg_cmd_valid),
    .io_dbg_ib_dbg_cmd_write(instbuff_io_dbg_ib_dbg_cmd_write),
    .io_dbg_ib_dbg_cmd_type(instbuff_io_dbg_ib_dbg_cmd_type),
    .io_dbg_ib_dbg_cmd_addr(instbuff_io_dbg_ib_dbg_cmd_addr),
    .io_dec_ib0_valid_d(instbuff_io_dec_ib0_valid_d),
    .io_dec_i0_icaf_type_d(instbuff_io_dec_i0_icaf_type_d),
    .io_dec_i0_instr_d(instbuff_io_dec_i0_instr_d),
    .io_dec_i0_pc4_d(instbuff_io_dec_i0_pc4_d),
    .io_dec_i0_brp_valid(instbuff_io_dec_i0_brp_valid),
    .io_dec_i0_brp_bits_toffset(instbuff_io_dec_i0_brp_bits_toffset),
    .io_dec_i0_brp_bits_hist(instbuff_io_dec_i0_brp_bits_hist),
    .io_dec_i0_brp_bits_br_error(instbuff_io_dec_i0_brp_bits_br_error),
    .io_dec_i0_brp_bits_br_start_error(instbuff_io_dec_i0_brp_bits_br_start_error),
    .io_dec_i0_brp_bits_prett(instbuff_io_dec_i0_brp_bits_prett),
    .io_dec_i0_brp_bits_way(instbuff_io_dec_i0_brp_bits_way),
    .io_dec_i0_brp_bits_ret(instbuff_io_dec_i0_brp_bits_ret),
    .io_dec_i0_bp_index(instbuff_io_dec_i0_bp_index),
    .io_dec_i0_bp_fghr(instbuff_io_dec_i0_bp_fghr),
    .io_dec_i0_bp_btag(instbuff_io_dec_i0_bp_btag),
    .io_dec_i0_icaf_d(instbuff_io_dec_i0_icaf_d),
    .io_dec_i0_icaf_f1_d(instbuff_io_dec_i0_icaf_f1_d),
    .io_dec_i0_dbecc_d(instbuff_io_dec_i0_dbecc_d),
    .io_dec_debug_fence_d(instbuff_io_dec_debug_fence_d)
  );
  dec_decode_ctl decode ( // @[dec.scala 118:22]
    .clock(decode_clock),
    .reset(decode_reset),
    .io_decode_exu_dec_data_en(decode_io_decode_exu_dec_data_en),
    .io_decode_exu_dec_ctl_en(decode_io_decode_exu_dec_ctl_en),
    .io_decode_exu_i0_ap_land(decode_io_decode_exu_i0_ap_land),
    .io_decode_exu_i0_ap_lor(decode_io_decode_exu_i0_ap_lor),
    .io_decode_exu_i0_ap_lxor(decode_io_decode_exu_i0_ap_lxor),
    .io_decode_exu_i0_ap_sll(decode_io_decode_exu_i0_ap_sll),
    .io_decode_exu_i0_ap_srl(decode_io_decode_exu_i0_ap_srl),
    .io_decode_exu_i0_ap_sra(decode_io_decode_exu_i0_ap_sra),
    .io_decode_exu_i0_ap_beq(decode_io_decode_exu_i0_ap_beq),
    .io_decode_exu_i0_ap_bne(decode_io_decode_exu_i0_ap_bne),
    .io_decode_exu_i0_ap_blt(decode_io_decode_exu_i0_ap_blt),
    .io_decode_exu_i0_ap_bge(decode_io_decode_exu_i0_ap_bge),
    .io_decode_exu_i0_ap_add(decode_io_decode_exu_i0_ap_add),
    .io_decode_exu_i0_ap_sub(decode_io_decode_exu_i0_ap_sub),
    .io_decode_exu_i0_ap_slt(decode_io_decode_exu_i0_ap_slt),
    .io_decode_exu_i0_ap_unsign(decode_io_decode_exu_i0_ap_unsign),
    .io_decode_exu_i0_ap_jal(decode_io_decode_exu_i0_ap_jal),
    .io_decode_exu_i0_ap_predict_t(decode_io_decode_exu_i0_ap_predict_t),
    .io_decode_exu_i0_ap_predict_nt(decode_io_decode_exu_i0_ap_predict_nt),
    .io_decode_exu_i0_ap_csr_write(decode_io_decode_exu_i0_ap_csr_write),
    .io_decode_exu_i0_ap_csr_imm(decode_io_decode_exu_i0_ap_csr_imm),
    .io_decode_exu_dec_i0_predict_p_d_valid(decode_io_decode_exu_dec_i0_predict_p_d_valid),
    .io_decode_exu_dec_i0_predict_p_d_bits_pc4(decode_io_decode_exu_dec_i0_predict_p_d_bits_pc4),
    .io_decode_exu_dec_i0_predict_p_d_bits_hist(decode_io_decode_exu_dec_i0_predict_p_d_bits_hist),
    .io_decode_exu_dec_i0_predict_p_d_bits_toffset(decode_io_decode_exu_dec_i0_predict_p_d_bits_toffset),
    .io_decode_exu_dec_i0_predict_p_d_bits_br_error(decode_io_decode_exu_dec_i0_predict_p_d_bits_br_error),
    .io_decode_exu_dec_i0_predict_p_d_bits_br_start_error(decode_io_decode_exu_dec_i0_predict_p_d_bits_br_start_error),
    .io_decode_exu_dec_i0_predict_p_d_bits_prett(decode_io_decode_exu_dec_i0_predict_p_d_bits_prett),
    .io_decode_exu_dec_i0_predict_p_d_bits_pcall(decode_io_decode_exu_dec_i0_predict_p_d_bits_pcall),
    .io_decode_exu_dec_i0_predict_p_d_bits_pret(decode_io_decode_exu_dec_i0_predict_p_d_bits_pret),
    .io_decode_exu_dec_i0_predict_p_d_bits_pja(decode_io_decode_exu_dec_i0_predict_p_d_bits_pja),
    .io_decode_exu_dec_i0_predict_p_d_bits_way(decode_io_decode_exu_dec_i0_predict_p_d_bits_way),
    .io_decode_exu_i0_predict_fghr_d(decode_io_decode_exu_i0_predict_fghr_d),
    .io_decode_exu_i0_predict_index_d(decode_io_decode_exu_i0_predict_index_d),
    .io_decode_exu_i0_predict_btag_d(decode_io_decode_exu_i0_predict_btag_d),
    .io_decode_exu_dec_i0_rs1_en_d(decode_io_decode_exu_dec_i0_rs1_en_d),
    .io_decode_exu_dec_i0_rs2_en_d(decode_io_decode_exu_dec_i0_rs2_en_d),
    .io_decode_exu_dec_i0_immed_d(decode_io_decode_exu_dec_i0_immed_d),
    .io_decode_exu_dec_i0_rs1_bypass_data_d(decode_io_decode_exu_dec_i0_rs1_bypass_data_d),
    .io_decode_exu_dec_i0_rs2_bypass_data_d(decode_io_decode_exu_dec_i0_rs2_bypass_data_d),
    .io_decode_exu_dec_i0_select_pc_d(decode_io_decode_exu_dec_i0_select_pc_d),
    .io_decode_exu_dec_i0_rs1_bypass_en_d(decode_io_decode_exu_dec_i0_rs1_bypass_en_d),
    .io_decode_exu_dec_i0_rs2_bypass_en_d(decode_io_decode_exu_dec_i0_rs2_bypass_en_d),
    .io_decode_exu_mul_p_valid(decode_io_decode_exu_mul_p_valid),
    .io_decode_exu_mul_p_bits_rs1_sign(decode_io_decode_exu_mul_p_bits_rs1_sign),
    .io_decode_exu_mul_p_bits_rs2_sign(decode_io_decode_exu_mul_p_bits_rs2_sign),
    .io_decode_exu_mul_p_bits_low(decode_io_decode_exu_mul_p_bits_low),
    .io_decode_exu_pred_correct_npc_x(decode_io_decode_exu_pred_correct_npc_x),
    .io_decode_exu_dec_extint_stall(decode_io_decode_exu_dec_extint_stall),
    .io_decode_exu_exu_i0_result_x(decode_io_decode_exu_exu_i0_result_x),
    .io_decode_exu_exu_csr_rs1_x(decode_io_decode_exu_exu_csr_rs1_x),
    .io_dec_alu_dec_i0_alu_decode_d(decode_io_dec_alu_dec_i0_alu_decode_d),
    .io_dec_alu_dec_csr_ren_d(decode_io_dec_alu_dec_csr_ren_d),
    .io_dec_alu_dec_i0_br_immed_d(decode_io_dec_alu_dec_i0_br_immed_d),
    .io_dec_alu_exu_i0_pc_x(decode_io_dec_alu_exu_i0_pc_x),
    .io_dec_div_div_p_valid(decode_io_dec_div_div_p_valid),
    .io_dec_div_div_p_bits_unsign(decode_io_dec_div_div_p_bits_unsign),
    .io_dec_div_div_p_bits_rem(decode_io_dec_div_div_p_bits_rem),
    .io_dec_div_dec_div_cancel(decode_io_dec_div_dec_div_cancel),
    .io_dctl_busbuff_lsu_nonblock_load_valid_m(decode_io_dctl_busbuff_lsu_nonblock_load_valid_m),
    .io_dctl_busbuff_lsu_nonblock_load_tag_m(decode_io_dctl_busbuff_lsu_nonblock_load_tag_m),
    .io_dctl_busbuff_lsu_nonblock_load_inv_r(decode_io_dctl_busbuff_lsu_nonblock_load_inv_r),
    .io_dctl_busbuff_lsu_nonblock_load_inv_tag_r(decode_io_dctl_busbuff_lsu_nonblock_load_inv_tag_r),
    .io_dctl_busbuff_lsu_nonblock_load_data_valid(decode_io_dctl_busbuff_lsu_nonblock_load_data_valid),
    .io_dctl_busbuff_lsu_nonblock_load_data_error(decode_io_dctl_busbuff_lsu_nonblock_load_data_error),
    .io_dctl_busbuff_lsu_nonblock_load_data_tag(decode_io_dctl_busbuff_lsu_nonblock_load_data_tag),
    .io_dctl_busbuff_lsu_nonblock_load_data(decode_io_dctl_busbuff_lsu_nonblock_load_data),
    .io_dctl_dma_dma_dccm_stall_any(decode_io_dctl_dma_dma_dccm_stall_any),
    .io_dec_tlu_flush_extint(decode_io_dec_tlu_flush_extint),
    .io_dec_tlu_force_halt(decode_io_dec_tlu_force_halt),
    .io_dec_i0_inst_wb1(decode_io_dec_i0_inst_wb1),
    .io_dec_i0_pc_wb1(decode_io_dec_i0_pc_wb1),
    .io_dec_i0_trigger_match_d(decode_io_dec_i0_trigger_match_d),
    .io_dec_tlu_wr_pause_r(decode_io_dec_tlu_wr_pause_r),
    .io_dec_tlu_pipelining_disable(decode_io_dec_tlu_pipelining_disable),
    .io_lsu_trigger_match_m(decode_io_lsu_trigger_match_m),
    .io_lsu_pmu_misaligned_m(decode_io_lsu_pmu_misaligned_m),
    .io_dec_tlu_debug_stall(decode_io_dec_tlu_debug_stall),
    .io_dec_tlu_flush_leak_one_r(decode_io_dec_tlu_flush_leak_one_r),
    .io_dec_debug_fence_d(decode_io_dec_debug_fence_d),
    .io_dec_i0_icaf_d(decode_io_dec_i0_icaf_d),
    .io_dec_i0_icaf_f1_d(decode_io_dec_i0_icaf_f1_d),
    .io_dec_i0_icaf_type_d(decode_io_dec_i0_icaf_type_d),
    .io_dec_i0_dbecc_d(decode_io_dec_i0_dbecc_d),
    .io_dec_i0_brp_valid(decode_io_dec_i0_brp_valid),
    .io_dec_i0_brp_bits_toffset(decode_io_dec_i0_brp_bits_toffset),
    .io_dec_i0_brp_bits_hist(decode_io_dec_i0_brp_bits_hist),
    .io_dec_i0_brp_bits_br_error(decode_io_dec_i0_brp_bits_br_error),
    .io_dec_i0_brp_bits_br_start_error(decode_io_dec_i0_brp_bits_br_start_error),
    .io_dec_i0_brp_bits_prett(decode_io_dec_i0_brp_bits_prett),
    .io_dec_i0_brp_bits_way(decode_io_dec_i0_brp_bits_way),
    .io_dec_i0_brp_bits_ret(decode_io_dec_i0_brp_bits_ret),
    .io_dec_i0_bp_index(decode_io_dec_i0_bp_index),
    .io_dec_i0_bp_fghr(decode_io_dec_i0_bp_fghr),
    .io_dec_i0_bp_btag(decode_io_dec_i0_bp_btag),
    .io_lsu_idle_any(decode_io_lsu_idle_any),
    .io_lsu_load_stall_any(decode_io_lsu_load_stall_any),
    .io_lsu_store_stall_any(decode_io_lsu_store_stall_any),
    .io_exu_div_wren(decode_io_exu_div_wren),
    .io_dec_tlu_i0_kill_writeb_wb(decode_io_dec_tlu_i0_kill_writeb_wb),
    .io_dec_tlu_flush_lower_wb(decode_io_dec_tlu_flush_lower_wb),
    .io_dec_tlu_i0_kill_writeb_r(decode_io_dec_tlu_i0_kill_writeb_r),
    .io_dec_tlu_flush_lower_r(decode_io_dec_tlu_flush_lower_r),
    .io_dec_tlu_flush_pause_r(decode_io_dec_tlu_flush_pause_r),
    .io_dec_tlu_presync_d(decode_io_dec_tlu_presync_d),
    .io_dec_tlu_postsync_d(decode_io_dec_tlu_postsync_d),
    .io_dec_i0_pc4_d(decode_io_dec_i0_pc4_d),
    .io_dec_csr_rddata_d(decode_io_dec_csr_rddata_d),
    .io_dec_csr_legal_d(decode_io_dec_csr_legal_d),
    .io_lsu_result_m(decode_io_lsu_result_m),
    .io_lsu_result_corr_r(decode_io_lsu_result_corr_r),
    .io_exu_flush_final(decode_io_exu_flush_final),
    .io_dec_i0_instr_d(decode_io_dec_i0_instr_d),
    .io_dec_ib0_valid_d(decode_io_dec_ib0_valid_d),
    .io_free_clk(decode_io_free_clk),
    .io_active_clk(decode_io_active_clk),
    .io_clk_override(decode_io_clk_override),
    .io_dec_i0_rs1_d(decode_io_dec_i0_rs1_d),
    .io_dec_i0_rs2_d(decode_io_dec_i0_rs2_d),
    .io_dec_i0_waddr_r(decode_io_dec_i0_waddr_r),
    .io_dec_i0_wen_r(decode_io_dec_i0_wen_r),
    .io_dec_i0_wdata_r(decode_io_dec_i0_wdata_r),
    .io_lsu_p_valid(decode_io_lsu_p_valid),
    .io_lsu_p_bits_fast_int(decode_io_lsu_p_bits_fast_int),
    .io_lsu_p_bits_by(decode_io_lsu_p_bits_by),
    .io_lsu_p_bits_half(decode_io_lsu_p_bits_half),
    .io_lsu_p_bits_word(decode_io_lsu_p_bits_word),
    .io_lsu_p_bits_load(decode_io_lsu_p_bits_load),
    .io_lsu_p_bits_store(decode_io_lsu_p_bits_store),
    .io_lsu_p_bits_unsign(decode_io_lsu_p_bits_unsign),
    .io_lsu_p_bits_store_data_bypass_d(decode_io_lsu_p_bits_store_data_bypass_d),
    .io_lsu_p_bits_load_ldst_bypass_d(decode_io_lsu_p_bits_load_ldst_bypass_d),
    .io_div_waddr_wb(decode_io_div_waddr_wb),
    .io_dec_lsu_valid_raw_d(decode_io_dec_lsu_valid_raw_d),
    .io_dec_lsu_offset_d(decode_io_dec_lsu_offset_d),
    .io_dec_csr_wen_unq_d(decode_io_dec_csr_wen_unq_d),
    .io_dec_csr_any_unq_d(decode_io_dec_csr_any_unq_d),
    .io_dec_csr_rdaddr_d(decode_io_dec_csr_rdaddr_d),
    .io_dec_csr_wen_r(decode_io_dec_csr_wen_r),
    .io_dec_csr_wraddr_r(decode_io_dec_csr_wraddr_r),
    .io_dec_csr_wrdata_r(decode_io_dec_csr_wrdata_r),
    .io_dec_csr_stall_int_ff(decode_io_dec_csr_stall_int_ff),
    .io_dec_tlu_i0_valid_r(decode_io_dec_tlu_i0_valid_r),
    .io_dec_tlu_packet_r_legal(decode_io_dec_tlu_packet_r_legal),
    .io_dec_tlu_packet_r_icaf(decode_io_dec_tlu_packet_r_icaf),
    .io_dec_tlu_packet_r_icaf_f1(decode_io_dec_tlu_packet_r_icaf_f1),
    .io_dec_tlu_packet_r_icaf_type(decode_io_dec_tlu_packet_r_icaf_type),
    .io_dec_tlu_packet_r_fence_i(decode_io_dec_tlu_packet_r_fence_i),
    .io_dec_tlu_packet_r_i0trigger(decode_io_dec_tlu_packet_r_i0trigger),
    .io_dec_tlu_packet_r_pmu_i0_itype(decode_io_dec_tlu_packet_r_pmu_i0_itype),
    .io_dec_tlu_packet_r_pmu_i0_br_unpred(decode_io_dec_tlu_packet_r_pmu_i0_br_unpred),
    .io_dec_tlu_packet_r_pmu_divide(decode_io_dec_tlu_packet_r_pmu_divide),
    .io_dec_tlu_packet_r_pmu_lsu_misaligned(decode_io_dec_tlu_packet_r_pmu_lsu_misaligned),
    .io_dec_tlu_i0_pc_r(decode_io_dec_tlu_i0_pc_r),
    .io_dec_illegal_inst(decode_io_dec_illegal_inst),
    .io_dec_pmu_instr_decoded(decode_io_dec_pmu_instr_decoded),
    .io_dec_pmu_decode_stall(decode_io_dec_pmu_decode_stall),
    .io_dec_pmu_presync_stall(decode_io_dec_pmu_presync_stall),
    .io_dec_pmu_postsync_stall(decode_io_dec_pmu_postsync_stall),
    .io_dec_nonblock_load_wen(decode_io_dec_nonblock_load_wen),
    .io_dec_nonblock_load_waddr(decode_io_dec_nonblock_load_waddr),
    .io_dec_pause_state(decode_io_dec_pause_state),
    .io_dec_pause_state_cg(decode_io_dec_pause_state_cg),
    .io_dec_div_active(decode_io_dec_div_active),
    .io_scan_mode(decode_io_scan_mode),
    .io_dec_aln_dec_i0_decode_d(decode_io_dec_aln_dec_i0_decode_d),
    .io_dec_aln_ifu_i0_cinst(decode_io_dec_aln_ifu_i0_cinst),
    .io_dbg_dctl_dbg_cmd_wrdata(decode_io_dbg_dctl_dbg_cmd_wrdata)
  );
  dec_gpr_ctl gpr ( // @[dec.scala 119:19]
    .clock(gpr_clock),
    .reset(gpr_reset),
    .io_raddr0(gpr_io_raddr0),
    .io_raddr1(gpr_io_raddr1),
    .io_wen0(gpr_io_wen0),
    .io_waddr0(gpr_io_waddr0),
    .io_wd0(gpr_io_wd0),
    .io_wen1(gpr_io_wen1),
    .io_waddr1(gpr_io_waddr1),
    .io_wd1(gpr_io_wd1),
    .io_wen2(gpr_io_wen2),
    .io_waddr2(gpr_io_waddr2),
    .io_wd2(gpr_io_wd2),
    .io_scan_mode(gpr_io_scan_mode),
    .io_gpr_exu_gpr_i0_rs1_d(gpr_io_gpr_exu_gpr_i0_rs1_d),
    .io_gpr_exu_gpr_i0_rs2_d(gpr_io_gpr_exu_gpr_i0_rs2_d)
  );
  dec_tlu_ctl tlu ( // @[dec.scala 120:19]
    .clock(tlu_clock),
    .reset(tlu_reset),
    .io_tlu_exu_dec_tlu_meihap(tlu_io_tlu_exu_dec_tlu_meihap),
    .io_tlu_exu_dec_tlu_flush_lower_r(tlu_io_tlu_exu_dec_tlu_flush_lower_r),
    .io_tlu_exu_dec_tlu_flush_path_r(tlu_io_tlu_exu_dec_tlu_flush_path_r),
    .io_tlu_exu_exu_i0_br_hist_r(tlu_io_tlu_exu_exu_i0_br_hist_r),
    .io_tlu_exu_exu_i0_br_error_r(tlu_io_tlu_exu_exu_i0_br_error_r),
    .io_tlu_exu_exu_i0_br_start_error_r(tlu_io_tlu_exu_exu_i0_br_start_error_r),
    .io_tlu_exu_exu_i0_br_valid_r(tlu_io_tlu_exu_exu_i0_br_valid_r),
    .io_tlu_exu_exu_i0_br_mp_r(tlu_io_tlu_exu_exu_i0_br_mp_r),
    .io_tlu_exu_exu_i0_br_middle_r(tlu_io_tlu_exu_exu_i0_br_middle_r),
    .io_tlu_exu_exu_pmu_i0_br_misp(tlu_io_tlu_exu_exu_pmu_i0_br_misp),
    .io_tlu_exu_exu_pmu_i0_br_ataken(tlu_io_tlu_exu_exu_pmu_i0_br_ataken),
    .io_tlu_exu_exu_pmu_i0_pc4(tlu_io_tlu_exu_exu_pmu_i0_pc4),
    .io_tlu_exu_exu_npc_r(tlu_io_tlu_exu_exu_npc_r),
    .io_tlu_dma_dma_pmu_dccm_read(tlu_io_tlu_dma_dma_pmu_dccm_read),
    .io_tlu_dma_dma_pmu_dccm_write(tlu_io_tlu_dma_dma_pmu_dccm_write),
    .io_tlu_dma_dma_pmu_any_read(tlu_io_tlu_dma_dma_pmu_any_read),
    .io_tlu_dma_dma_pmu_any_write(tlu_io_tlu_dma_dma_pmu_any_write),
    .io_tlu_dma_dec_tlu_dma_qos_prty(tlu_io_tlu_dma_dec_tlu_dma_qos_prty),
    .io_tlu_dma_dma_dccm_stall_any(tlu_io_tlu_dma_dma_dccm_stall_any),
    .io_tlu_dma_dma_iccm_stall_any(tlu_io_tlu_dma_dma_iccm_stall_any),
    .io_active_clk(tlu_io_active_clk),
    .io_free_clk(tlu_io_free_clk),
    .io_scan_mode(tlu_io_scan_mode),
    .io_rst_vec(tlu_io_rst_vec),
    .io_nmi_int(tlu_io_nmi_int),
    .io_nmi_vec(tlu_io_nmi_vec),
    .io_i_cpu_halt_req(tlu_io_i_cpu_halt_req),
    .io_i_cpu_run_req(tlu_io_i_cpu_run_req),
    .io_lsu_fastint_stall_any(tlu_io_lsu_fastint_stall_any),
    .io_lsu_idle_any(tlu_io_lsu_idle_any),
    .io_dec_pmu_instr_decoded(tlu_io_dec_pmu_instr_decoded),
    .io_dec_pmu_decode_stall(tlu_io_dec_pmu_decode_stall),
    .io_dec_pmu_presync_stall(tlu_io_dec_pmu_presync_stall),
    .io_dec_pmu_postsync_stall(tlu_io_dec_pmu_postsync_stall),
    .io_lsu_store_stall_any(tlu_io_lsu_store_stall_any),
    .io_lsu_fir_addr(tlu_io_lsu_fir_addr),
    .io_lsu_fir_error(tlu_io_lsu_fir_error),
    .io_iccm_dma_sb_error(tlu_io_iccm_dma_sb_error),
    .io_lsu_error_pkt_r_valid(tlu_io_lsu_error_pkt_r_valid),
    .io_lsu_error_pkt_r_bits_single_ecc_error(tlu_io_lsu_error_pkt_r_bits_single_ecc_error),
    .io_lsu_error_pkt_r_bits_inst_type(tlu_io_lsu_error_pkt_r_bits_inst_type),
    .io_lsu_error_pkt_r_bits_exc_type(tlu_io_lsu_error_pkt_r_bits_exc_type),
    .io_lsu_error_pkt_r_bits_mscause(tlu_io_lsu_error_pkt_r_bits_mscause),
    .io_lsu_error_pkt_r_bits_addr(tlu_io_lsu_error_pkt_r_bits_addr),
    .io_lsu_single_ecc_error_incr(tlu_io_lsu_single_ecc_error_incr),
    .io_dec_pause_state(tlu_io_dec_pause_state),
    .io_dec_csr_wen_unq_d(tlu_io_dec_csr_wen_unq_d),
    .io_dec_csr_any_unq_d(tlu_io_dec_csr_any_unq_d),
    .io_dec_csr_rdaddr_d(tlu_io_dec_csr_rdaddr_d),
    .io_dec_csr_wen_r(tlu_io_dec_csr_wen_r),
    .io_dec_csr_wraddr_r(tlu_io_dec_csr_wraddr_r),
    .io_dec_csr_wrdata_r(tlu_io_dec_csr_wrdata_r),
    .io_dec_csr_stall_int_ff(tlu_io_dec_csr_stall_int_ff),
    .io_dec_tlu_i0_valid_r(tlu_io_dec_tlu_i0_valid_r),
    .io_dec_tlu_i0_pc_r(tlu_io_dec_tlu_i0_pc_r),
    .io_dec_tlu_packet_r_legal(tlu_io_dec_tlu_packet_r_legal),
    .io_dec_tlu_packet_r_icaf(tlu_io_dec_tlu_packet_r_icaf),
    .io_dec_tlu_packet_r_icaf_f1(tlu_io_dec_tlu_packet_r_icaf_f1),
    .io_dec_tlu_packet_r_icaf_type(tlu_io_dec_tlu_packet_r_icaf_type),
    .io_dec_tlu_packet_r_fence_i(tlu_io_dec_tlu_packet_r_fence_i),
    .io_dec_tlu_packet_r_i0trigger(tlu_io_dec_tlu_packet_r_i0trigger),
    .io_dec_tlu_packet_r_pmu_i0_itype(tlu_io_dec_tlu_packet_r_pmu_i0_itype),
    .io_dec_tlu_packet_r_pmu_i0_br_unpred(tlu_io_dec_tlu_packet_r_pmu_i0_br_unpred),
    .io_dec_tlu_packet_r_pmu_divide(tlu_io_dec_tlu_packet_r_pmu_divide),
    .io_dec_tlu_packet_r_pmu_lsu_misaligned(tlu_io_dec_tlu_packet_r_pmu_lsu_misaligned),
    .io_dec_illegal_inst(tlu_io_dec_illegal_inst),
    .io_dec_i0_decode_d(tlu_io_dec_i0_decode_d),
    .io_exu_i0_br_way_r(tlu_io_exu_i0_br_way_r),
    .io_dec_dbg_cmd_done(tlu_io_dec_dbg_cmd_done),
    .io_dec_dbg_cmd_fail(tlu_io_dec_dbg_cmd_fail),
    .io_dec_tlu_dbg_halted(tlu_io_dec_tlu_dbg_halted),
    .io_dec_tlu_debug_mode(tlu_io_dec_tlu_debug_mode),
    .io_dec_tlu_resume_ack(tlu_io_dec_tlu_resume_ack),
    .io_dec_tlu_debug_stall(tlu_io_dec_tlu_debug_stall),
    .io_dec_tlu_mpc_halted_only(tlu_io_dec_tlu_mpc_halted_only),
    .io_dec_tlu_flush_extint(tlu_io_dec_tlu_flush_extint),
    .io_dbg_halt_req(tlu_io_dbg_halt_req),
    .io_dbg_resume_req(tlu_io_dbg_resume_req),
    .io_dec_div_active(tlu_io_dec_div_active),
    .io_trigger_pkt_any_0_select(tlu_io_trigger_pkt_any_0_select),
    .io_trigger_pkt_any_0_match_pkt(tlu_io_trigger_pkt_any_0_match_pkt),
    .io_trigger_pkt_any_0_store(tlu_io_trigger_pkt_any_0_store),
    .io_trigger_pkt_any_0_load(tlu_io_trigger_pkt_any_0_load),
    .io_trigger_pkt_any_0_execute(tlu_io_trigger_pkt_any_0_execute),
    .io_trigger_pkt_any_0_m(tlu_io_trigger_pkt_any_0_m),
    .io_trigger_pkt_any_0_tdata2(tlu_io_trigger_pkt_any_0_tdata2),
    .io_trigger_pkt_any_1_select(tlu_io_trigger_pkt_any_1_select),
    .io_trigger_pkt_any_1_match_pkt(tlu_io_trigger_pkt_any_1_match_pkt),
    .io_trigger_pkt_any_1_store(tlu_io_trigger_pkt_any_1_store),
    .io_trigger_pkt_any_1_load(tlu_io_trigger_pkt_any_1_load),
    .io_trigger_pkt_any_1_execute(tlu_io_trigger_pkt_any_1_execute),
    .io_trigger_pkt_any_1_m(tlu_io_trigger_pkt_any_1_m),
    .io_trigger_pkt_any_1_tdata2(tlu_io_trigger_pkt_any_1_tdata2),
    .io_trigger_pkt_any_2_select(tlu_io_trigger_pkt_any_2_select),
    .io_trigger_pkt_any_2_match_pkt(tlu_io_trigger_pkt_any_2_match_pkt),
    .io_trigger_pkt_any_2_store(tlu_io_trigger_pkt_any_2_store),
    .io_trigger_pkt_any_2_load(tlu_io_trigger_pkt_any_2_load),
    .io_trigger_pkt_any_2_execute(tlu_io_trigger_pkt_any_2_execute),
    .io_trigger_pkt_any_2_m(tlu_io_trigger_pkt_any_2_m),
    .io_trigger_pkt_any_2_tdata2(tlu_io_trigger_pkt_any_2_tdata2),
    .io_trigger_pkt_any_3_select(tlu_io_trigger_pkt_any_3_select),
    .io_trigger_pkt_any_3_match_pkt(tlu_io_trigger_pkt_any_3_match_pkt),
    .io_trigger_pkt_any_3_store(tlu_io_trigger_pkt_any_3_store),
    .io_trigger_pkt_any_3_load(tlu_io_trigger_pkt_any_3_load),
    .io_trigger_pkt_any_3_execute(tlu_io_trigger_pkt_any_3_execute),
    .io_trigger_pkt_any_3_m(tlu_io_trigger_pkt_any_3_m),
    .io_trigger_pkt_any_3_tdata2(tlu_io_trigger_pkt_any_3_tdata2),
    .io_timer_int(tlu_io_timer_int),
    .io_soft_int(tlu_io_soft_int),
    .io_o_cpu_halt_status(tlu_io_o_cpu_halt_status),
    .io_o_cpu_halt_ack(tlu_io_o_cpu_halt_ack),
    .io_o_cpu_run_ack(tlu_io_o_cpu_run_ack),
    .io_o_debug_mode_status(tlu_io_o_debug_mode_status),
    .io_core_id(tlu_io_core_id),
    .io_mpc_debug_halt_req(tlu_io_mpc_debug_halt_req),
    .io_mpc_debug_run_req(tlu_io_mpc_debug_run_req),
    .io_mpc_reset_run_req(tlu_io_mpc_reset_run_req),
    .io_mpc_debug_halt_ack(tlu_io_mpc_debug_halt_ack),
    .io_mpc_debug_run_ack(tlu_io_mpc_debug_run_ack),
    .io_debug_brkpt_status(tlu_io_debug_brkpt_status),
    .io_dec_csr_rddata_d(tlu_io_dec_csr_rddata_d),
    .io_dec_csr_legal_d(tlu_io_dec_csr_legal_d),
    .io_dec_tlu_i0_kill_writeb_wb(tlu_io_dec_tlu_i0_kill_writeb_wb),
    .io_dec_tlu_i0_kill_writeb_r(tlu_io_dec_tlu_i0_kill_writeb_r),
    .io_dec_tlu_wr_pause_r(tlu_io_dec_tlu_wr_pause_r),
    .io_dec_tlu_flush_pause_r(tlu_io_dec_tlu_flush_pause_r),
    .io_dec_tlu_presync_d(tlu_io_dec_tlu_presync_d),
    .io_dec_tlu_postsync_d(tlu_io_dec_tlu_postsync_d),
    .io_dec_tlu_perfcnt0(tlu_io_dec_tlu_perfcnt0),
    .io_dec_tlu_perfcnt1(tlu_io_dec_tlu_perfcnt1),
    .io_dec_tlu_perfcnt2(tlu_io_dec_tlu_perfcnt2),
    .io_dec_tlu_perfcnt3(tlu_io_dec_tlu_perfcnt3),
    .io_dec_tlu_i0_exc_valid_wb1(tlu_io_dec_tlu_i0_exc_valid_wb1),
    .io_dec_tlu_i0_valid_wb1(tlu_io_dec_tlu_i0_valid_wb1),
    .io_dec_tlu_int_valid_wb1(tlu_io_dec_tlu_int_valid_wb1),
    .io_dec_tlu_exc_cause_wb1(tlu_io_dec_tlu_exc_cause_wb1),
    .io_dec_tlu_mtval_wb1(tlu_io_dec_tlu_mtval_wb1),
    .io_dec_tlu_pipelining_disable(tlu_io_dec_tlu_pipelining_disable),
    .io_dec_tlu_misc_clk_override(tlu_io_dec_tlu_misc_clk_override),
    .io_dec_tlu_dec_clk_override(tlu_io_dec_tlu_dec_clk_override),
    .io_dec_tlu_ifu_clk_override(tlu_io_dec_tlu_ifu_clk_override),
    .io_dec_tlu_lsu_clk_override(tlu_io_dec_tlu_lsu_clk_override),
    .io_dec_tlu_bus_clk_override(tlu_io_dec_tlu_bus_clk_override),
    .io_dec_tlu_pic_clk_override(tlu_io_dec_tlu_pic_clk_override),
    .io_dec_tlu_dccm_clk_override(tlu_io_dec_tlu_dccm_clk_override),
    .io_dec_tlu_icm_clk_override(tlu_io_dec_tlu_icm_clk_override),
    .io_ifu_pmu_instr_aligned(tlu_io_ifu_pmu_instr_aligned),
    .io_tlu_bp_dec_tlu_br0_r_pkt_valid(tlu_io_tlu_bp_dec_tlu_br0_r_pkt_valid),
    .io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist(tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist),
    .io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error(tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error),
    .io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error(tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error),
    .io_tlu_bp_dec_tlu_br0_r_pkt_bits_way(tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_way),
    .io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle(tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle),
    .io_tlu_bp_dec_tlu_flush_lower_wb(tlu_io_tlu_bp_dec_tlu_flush_lower_wb),
    .io_tlu_bp_dec_tlu_flush_leak_one_wb(tlu_io_tlu_bp_dec_tlu_flush_leak_one_wb),
    .io_tlu_bp_dec_tlu_bpred_disable(tlu_io_tlu_bp_dec_tlu_bpred_disable),
    .io_tlu_ifc_dec_tlu_flush_noredir_wb(tlu_io_tlu_ifc_dec_tlu_flush_noredir_wb),
    .io_tlu_ifc_dec_tlu_mrac_ff(tlu_io_tlu_ifc_dec_tlu_mrac_ff),
    .io_tlu_ifc_ifu_pmu_fetch_stall(tlu_io_tlu_ifc_ifu_pmu_fetch_stall),
    .io_tlu_mem_dec_tlu_flush_lower_wb(tlu_io_tlu_mem_dec_tlu_flush_lower_wb),
    .io_tlu_mem_dec_tlu_flush_err_wb(tlu_io_tlu_mem_dec_tlu_flush_err_wb),
    .io_tlu_mem_dec_tlu_i0_commit_cmt(tlu_io_tlu_mem_dec_tlu_i0_commit_cmt),
    .io_tlu_mem_dec_tlu_force_halt(tlu_io_tlu_mem_dec_tlu_force_halt),
    .io_tlu_mem_dec_tlu_fence_i_wb(tlu_io_tlu_mem_dec_tlu_fence_i_wb),
    .io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata(tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata),
    .io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics(tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics),
    .io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid(tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid),
    .io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid(tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid),
    .io_tlu_mem_dec_tlu_core_ecc_disable(tlu_io_tlu_mem_dec_tlu_core_ecc_disable),
    .io_tlu_mem_ifu_pmu_ic_miss(tlu_io_tlu_mem_ifu_pmu_ic_miss),
    .io_tlu_mem_ifu_pmu_ic_hit(tlu_io_tlu_mem_ifu_pmu_ic_hit),
    .io_tlu_mem_ifu_pmu_bus_error(tlu_io_tlu_mem_ifu_pmu_bus_error),
    .io_tlu_mem_ifu_pmu_bus_busy(tlu_io_tlu_mem_ifu_pmu_bus_busy),
    .io_tlu_mem_ifu_pmu_bus_trxn(tlu_io_tlu_mem_ifu_pmu_bus_trxn),
    .io_tlu_mem_ifu_ic_error_start(tlu_io_tlu_mem_ifu_ic_error_start),
    .io_tlu_mem_ifu_iccm_rd_ecc_single_err(tlu_io_tlu_mem_ifu_iccm_rd_ecc_single_err),
    .io_tlu_mem_ifu_ic_debug_rd_data(tlu_io_tlu_mem_ifu_ic_debug_rd_data),
    .io_tlu_mem_ifu_ic_debug_rd_data_valid(tlu_io_tlu_mem_ifu_ic_debug_rd_data_valid),
    .io_tlu_mem_ifu_miss_state_idle(tlu_io_tlu_mem_ifu_miss_state_idle),
    .io_tlu_busbuff_lsu_pmu_bus_trxn(tlu_io_tlu_busbuff_lsu_pmu_bus_trxn),
    .io_tlu_busbuff_lsu_pmu_bus_misaligned(tlu_io_tlu_busbuff_lsu_pmu_bus_misaligned),
    .io_tlu_busbuff_lsu_pmu_bus_error(tlu_io_tlu_busbuff_lsu_pmu_bus_error),
    .io_tlu_busbuff_lsu_pmu_bus_busy(tlu_io_tlu_busbuff_lsu_pmu_bus_busy),
    .io_tlu_busbuff_dec_tlu_external_ldfwd_disable(tlu_io_tlu_busbuff_dec_tlu_external_ldfwd_disable),
    .io_tlu_busbuff_dec_tlu_wb_coalescing_disable(tlu_io_tlu_busbuff_dec_tlu_wb_coalescing_disable),
    .io_tlu_busbuff_dec_tlu_sideeffect_posted_disable(tlu_io_tlu_busbuff_dec_tlu_sideeffect_posted_disable),
    .io_tlu_busbuff_lsu_imprecise_error_load_any(tlu_io_tlu_busbuff_lsu_imprecise_error_load_any),
    .io_tlu_busbuff_lsu_imprecise_error_store_any(tlu_io_tlu_busbuff_lsu_imprecise_error_store_any),
    .io_tlu_busbuff_lsu_imprecise_error_addr_any(tlu_io_tlu_busbuff_lsu_imprecise_error_addr_any),
    .io_lsu_tlu_lsu_pmu_load_external_m(tlu_io_lsu_tlu_lsu_pmu_load_external_m),
    .io_lsu_tlu_lsu_pmu_store_external_m(tlu_io_lsu_tlu_lsu_pmu_store_external_m),
    .io_dec_pic_pic_claimid(tlu_io_dec_pic_pic_claimid),
    .io_dec_pic_pic_pl(tlu_io_dec_pic_pic_pl),
    .io_dec_pic_mhwakeup(tlu_io_dec_pic_mhwakeup),
    .io_dec_pic_dec_tlu_meicurpl(tlu_io_dec_pic_dec_tlu_meicurpl),
    .io_dec_pic_dec_tlu_meipt(tlu_io_dec_pic_dec_tlu_meipt),
    .io_dec_pic_mexintpend(tlu_io_dec_pic_mexintpend)
  );
  dec_trigger dec_trigger ( // @[dec.scala 121:27]
    .io_trigger_pkt_any_0_select(dec_trigger_io_trigger_pkt_any_0_select),
    .io_trigger_pkt_any_0_match_pkt(dec_trigger_io_trigger_pkt_any_0_match_pkt),
    .io_trigger_pkt_any_0_execute(dec_trigger_io_trigger_pkt_any_0_execute),
    .io_trigger_pkt_any_0_m(dec_trigger_io_trigger_pkt_any_0_m),
    .io_trigger_pkt_any_0_tdata2(dec_trigger_io_trigger_pkt_any_0_tdata2),
    .io_trigger_pkt_any_1_select(dec_trigger_io_trigger_pkt_any_1_select),
    .io_trigger_pkt_any_1_match_pkt(dec_trigger_io_trigger_pkt_any_1_match_pkt),
    .io_trigger_pkt_any_1_execute(dec_trigger_io_trigger_pkt_any_1_execute),
    .io_trigger_pkt_any_1_m(dec_trigger_io_trigger_pkt_any_1_m),
    .io_trigger_pkt_any_1_tdata2(dec_trigger_io_trigger_pkt_any_1_tdata2),
    .io_trigger_pkt_any_2_select(dec_trigger_io_trigger_pkt_any_2_select),
    .io_trigger_pkt_any_2_match_pkt(dec_trigger_io_trigger_pkt_any_2_match_pkt),
    .io_trigger_pkt_any_2_execute(dec_trigger_io_trigger_pkt_any_2_execute),
    .io_trigger_pkt_any_2_m(dec_trigger_io_trigger_pkt_any_2_m),
    .io_trigger_pkt_any_2_tdata2(dec_trigger_io_trigger_pkt_any_2_tdata2),
    .io_trigger_pkt_any_3_select(dec_trigger_io_trigger_pkt_any_3_select),
    .io_trigger_pkt_any_3_match_pkt(dec_trigger_io_trigger_pkt_any_3_match_pkt),
    .io_trigger_pkt_any_3_execute(dec_trigger_io_trigger_pkt_any_3_execute),
    .io_trigger_pkt_any_3_m(dec_trigger_io_trigger_pkt_any_3_m),
    .io_trigger_pkt_any_3_tdata2(dec_trigger_io_trigger_pkt_any_3_tdata2),
    .io_dec_i0_pc_d(dec_trigger_io_dec_i0_pc_d),
    .io_dec_i0_trigger_match_d(dec_trigger_io_dec_i0_trigger_match_d)
  );
  assign io_dec_pause_state_cg = decode_io_dec_pause_state_cg; // @[dec.scala 188:40]
  assign io_o_cpu_halt_status = tlu_io_o_cpu_halt_status; // @[dec.scala 265:29]
  assign io_o_cpu_halt_ack = tlu_io_o_cpu_halt_ack; // @[dec.scala 266:29]
  assign io_o_cpu_run_ack = tlu_io_o_cpu_run_ack; // @[dec.scala 267:29]
  assign io_o_debug_mode_status = tlu_io_o_debug_mode_status; // @[dec.scala 268:29]
  assign io_mpc_debug_halt_ack = tlu_io_mpc_debug_halt_ack; // @[dec.scala 269:29]
  assign io_mpc_debug_run_ack = tlu_io_mpc_debug_run_ack; // @[dec.scala 270:29]
  assign io_debug_brkpt_status = tlu_io_debug_brkpt_status; // @[dec.scala 271:29]
  assign io_dec_tlu_dbg_halted = tlu_io_dec_tlu_dbg_halted; // @[dec.scala 260:28]
  assign io_dec_tlu_debug_mode = tlu_io_dec_tlu_debug_mode; // @[dec.scala 261:28]
  assign io_dec_tlu_resume_ack = tlu_io_dec_tlu_resume_ack; // @[dec.scala 262:28]
  assign io_dec_tlu_mpc_halted_only = tlu_io_dec_tlu_mpc_halted_only; // @[dec.scala 263:51]
  assign io_dec_dbg_rddata = decode_io_dec_i0_wdata_r; // @[dec.scala 304:21]
  assign io_dec_dbg_cmd_done = tlu_io_dec_dbg_cmd_done; // @[dec.scala 258:28]
  assign io_dec_dbg_cmd_fail = tlu_io_dec_dbg_cmd_fail; // @[dec.scala 259:28]
  assign io_trigger_pkt_any_0_select = tlu_io_trigger_pkt_any_0_select; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_0_match_pkt = tlu_io_trigger_pkt_any_0_match_pkt; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_0_store = tlu_io_trigger_pkt_any_0_store; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_0_load = tlu_io_trigger_pkt_any_0_load; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_0_execute = tlu_io_trigger_pkt_any_0_execute; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_0_m = tlu_io_trigger_pkt_any_0_m; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_0_tdata2 = tlu_io_trigger_pkt_any_0_tdata2; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_select = tlu_io_trigger_pkt_any_1_select; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_match_pkt = tlu_io_trigger_pkt_any_1_match_pkt; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_store = tlu_io_trigger_pkt_any_1_store; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_load = tlu_io_trigger_pkt_any_1_load; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_execute = tlu_io_trigger_pkt_any_1_execute; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_m = tlu_io_trigger_pkt_any_1_m; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_1_tdata2 = tlu_io_trigger_pkt_any_1_tdata2; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_select = tlu_io_trigger_pkt_any_2_select; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_match_pkt = tlu_io_trigger_pkt_any_2_match_pkt; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_store = tlu_io_trigger_pkt_any_2_store; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_load = tlu_io_trigger_pkt_any_2_load; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_execute = tlu_io_trigger_pkt_any_2_execute; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_m = tlu_io_trigger_pkt_any_2_m; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_2_tdata2 = tlu_io_trigger_pkt_any_2_tdata2; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_select = tlu_io_trigger_pkt_any_3_select; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_match_pkt = tlu_io_trigger_pkt_any_3_match_pkt; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_store = tlu_io_trigger_pkt_any_3_store; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_load = tlu_io_trigger_pkt_any_3_load; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_execute = tlu_io_trigger_pkt_any_3_execute; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_m = tlu_io_trigger_pkt_any_3_m; // @[dec.scala 264:29]
  assign io_trigger_pkt_any_3_tdata2 = tlu_io_trigger_pkt_any_3_tdata2; // @[dec.scala 264:29]
  assign io_lsu_p_valid = decode_io_lsu_p_valid; // @[dec.scala 185:40]
  assign io_lsu_p_bits_fast_int = decode_io_lsu_p_bits_fast_int; // @[dec.scala 185:40]
  assign io_lsu_p_bits_by = decode_io_lsu_p_bits_by; // @[dec.scala 185:40]
  assign io_lsu_p_bits_half = decode_io_lsu_p_bits_half; // @[dec.scala 185:40]
  assign io_lsu_p_bits_word = decode_io_lsu_p_bits_word; // @[dec.scala 185:40]
  assign io_lsu_p_bits_dword = 1'h0; // @[dec.scala 185:40]
  assign io_lsu_p_bits_load = decode_io_lsu_p_bits_load; // @[dec.scala 185:40]
  assign io_lsu_p_bits_store = decode_io_lsu_p_bits_store; // @[dec.scala 185:40]
  assign io_lsu_p_bits_unsign = decode_io_lsu_p_bits_unsign; // @[dec.scala 185:40]
  assign io_lsu_p_bits_dma = 1'h0; // @[dec.scala 185:40]
  assign io_lsu_p_bits_store_data_bypass_d = decode_io_lsu_p_bits_store_data_bypass_d; // @[dec.scala 185:40]
  assign io_lsu_p_bits_load_ldst_bypass_d = decode_io_lsu_p_bits_load_ldst_bypass_d; // @[dec.scala 185:40]
  assign io_lsu_p_bits_store_data_bypass_m = 1'h0; // @[dec.scala 185:40]
  assign io_dec_lsu_offset_d = decode_io_dec_lsu_offset_d; // @[dec.scala 187:40]
  assign io_dec_tlu_i0_kill_writeb_r = tlu_io_dec_tlu_i0_kill_writeb_r; // @[dec.scala 274:34]
  assign io_dec_tlu_perfcnt0 = tlu_io_dec_tlu_perfcnt0; // @[dec.scala 275:29]
  assign io_dec_tlu_perfcnt1 = tlu_io_dec_tlu_perfcnt1; // @[dec.scala 276:29]
  assign io_dec_tlu_perfcnt2 = tlu_io_dec_tlu_perfcnt2; // @[dec.scala 277:29]
  assign io_dec_tlu_perfcnt3 = tlu_io_dec_tlu_perfcnt3; // @[dec.scala 278:29]
  assign io_dec_lsu_valid_raw_d = decode_io_dec_lsu_valid_raw_d; // @[dec.scala 186:40]
  assign io_rv_trace_pkt_rv_i_valid_ip = {tlu_io_dec_tlu_int_valid_wb1,_T_1}; // @[dec.scala 296:33]
  assign io_rv_trace_pkt_rv_i_insn_ip = decode_io_dec_i0_inst_wb1; // @[dec.scala 294:32]
  assign io_rv_trace_pkt_rv_i_address_ip = {decode_io_dec_i0_pc_wb1,1'h0}; // @[dec.scala 295:35]
  assign io_rv_trace_pkt_rv_i_exception_ip = {tlu_io_dec_tlu_int_valid_wb1,tlu_io_dec_tlu_i0_exc_valid_wb1}; // @[dec.scala 297:37]
  assign io_rv_trace_pkt_rv_i_ecause_ip = tlu_io_dec_tlu_exc_cause_wb1; // @[dec.scala 298:34]
  assign io_rv_trace_pkt_rv_i_interrupt_ip = {tlu_io_dec_tlu_int_valid_wb1,1'h0}; // @[dec.scala 299:37]
  assign io_rv_trace_pkt_rv_i_tval_ip = tlu_io_dec_tlu_mtval_wb1; // @[dec.scala 300:32]
  assign io_dec_tlu_misc_clk_override = tlu_io_dec_tlu_misc_clk_override; // @[dec.scala 284:35]
  assign io_dec_tlu_ifu_clk_override = tlu_io_dec_tlu_ifu_clk_override; // @[dec.scala 285:36]
  assign io_dec_tlu_lsu_clk_override = tlu_io_dec_tlu_lsu_clk_override; // @[dec.scala 286:36]
  assign io_dec_tlu_bus_clk_override = tlu_io_dec_tlu_bus_clk_override; // @[dec.scala 287:36]
  assign io_dec_tlu_pic_clk_override = tlu_io_dec_tlu_pic_clk_override; // @[dec.scala 288:36]
  assign io_dec_tlu_dccm_clk_override = tlu_io_dec_tlu_dccm_clk_override; // @[dec.scala 289:36]
  assign io_dec_tlu_icm_clk_override = tlu_io_dec_tlu_icm_clk_override; // @[dec.scala 290:36]
  assign io_ifu_dec_dec_aln_aln_dec_dec_i0_decode_d = decode_io_dec_aln_dec_i0_decode_d; // @[dec.scala 133:21]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_flush_lower_wb = tlu_io_tlu_mem_dec_tlu_flush_lower_wb; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_flush_err_wb = tlu_io_tlu_mem_dec_tlu_flush_err_wb; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_i0_commit_cmt = tlu_io_tlu_mem_dec_tlu_i0_commit_cmt; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_force_halt = tlu_io_tlu_mem_dec_tlu_force_halt; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_fence_i_wb = tlu_io_tlu_mem_dec_tlu_fence_i_wb; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_wrdata = tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wrdata; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_dicawics = tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_dicawics; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_rd_valid = tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_rd_valid; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_ic_diag_pkt_icache_wr_valid = tlu_io_tlu_mem_dec_tlu_ic_diag_pkt_icache_wr_valid; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_mem_ctrl_dec_tlu_core_ecc_disable = tlu_io_tlu_mem_dec_tlu_core_ecc_disable; // @[dec.scala 202:18]
  assign io_ifu_dec_dec_ifc_dec_tlu_flush_noredir_wb = tlu_io_tlu_ifc_dec_tlu_flush_noredir_wb; // @[dec.scala 203:18]
  assign io_ifu_dec_dec_ifc_dec_tlu_mrac_ff = tlu_io_tlu_ifc_dec_tlu_mrac_ff; // @[dec.scala 203:18]
  assign io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_valid = tlu_io_tlu_bp_dec_tlu_br0_r_pkt_valid; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_hist = tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_hist; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_br_error = tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_error; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_br_start_error = tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_br_start_error; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_way = tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_way; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_br0_r_pkt_bits_middle = tlu_io_tlu_bp_dec_tlu_br0_r_pkt_bits_middle; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_flush_lower_wb = tlu_io_tlu_bp_dec_tlu_flush_lower_wb; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_flush_leak_one_wb = tlu_io_tlu_bp_dec_tlu_flush_leak_one_wb; // @[dec.scala 204:18]
  assign io_ifu_dec_dec_bp_dec_tlu_bpred_disable = tlu_io_tlu_bp_dec_tlu_bpred_disable; // @[dec.scala 204:18]
  assign io_dec_exu_dec_alu_dec_i0_alu_decode_d = decode_io_dec_alu_dec_i0_alu_decode_d; // @[dec.scala 136:20]
  assign io_dec_exu_dec_alu_dec_csr_ren_d = decode_io_dec_alu_dec_csr_ren_d; // @[dec.scala 136:20]
  assign io_dec_exu_dec_alu_dec_i0_br_immed_d = decode_io_dec_alu_dec_i0_br_immed_d; // @[dec.scala 136:20]
  assign io_dec_exu_dec_div_div_p_valid = decode_io_dec_div_div_p_valid; // @[dec.scala 137:20]
  assign io_dec_exu_dec_div_div_p_bits_unsign = decode_io_dec_div_div_p_bits_unsign; // @[dec.scala 137:20]
  assign io_dec_exu_dec_div_div_p_bits_rem = decode_io_dec_div_div_p_bits_rem; // @[dec.scala 137:20]
  assign io_dec_exu_dec_div_dec_div_cancel = decode_io_dec_div_dec_div_cancel; // @[dec.scala 137:20]
  assign io_dec_exu_decode_exu_dec_data_en = decode_io_decode_exu_dec_data_en; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_ctl_en = decode_io_decode_exu_dec_ctl_en; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_land = decode_io_decode_exu_i0_ap_land; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_lor = decode_io_decode_exu_i0_ap_lor; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_lxor = decode_io_decode_exu_i0_ap_lxor; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_sll = decode_io_decode_exu_i0_ap_sll; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_srl = decode_io_decode_exu_i0_ap_srl; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_sra = decode_io_decode_exu_i0_ap_sra; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_beq = decode_io_decode_exu_i0_ap_beq; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_bne = decode_io_decode_exu_i0_ap_bne; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_blt = decode_io_decode_exu_i0_ap_blt; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_bge = decode_io_decode_exu_i0_ap_bge; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_add = decode_io_decode_exu_i0_ap_add; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_sub = decode_io_decode_exu_i0_ap_sub; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_slt = decode_io_decode_exu_i0_ap_slt; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_unsign = decode_io_decode_exu_i0_ap_unsign; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_jal = decode_io_decode_exu_i0_ap_jal; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_predict_t = decode_io_decode_exu_i0_ap_predict_t; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_predict_nt = decode_io_decode_exu_i0_ap_predict_nt; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_csr_write = decode_io_decode_exu_i0_ap_csr_write; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_ap_csr_imm = decode_io_decode_exu_i0_ap_csr_imm; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_valid = decode_io_decode_exu_dec_i0_predict_p_d_valid; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_misp = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_ataken = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_boffset = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pc4 = decode_io_decode_exu_dec_i0_predict_p_d_bits_pc4; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_hist = decode_io_decode_exu_dec_i0_predict_p_d_bits_hist; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_toffset = decode_io_decode_exu_dec_i0_predict_p_d_bits_toffset; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_br_error = decode_io_decode_exu_dec_i0_predict_p_d_bits_br_error; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_br_start_error = decode_io_decode_exu_dec_i0_predict_p_d_bits_br_start_error; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_prett = decode_io_decode_exu_dec_i0_predict_p_d_bits_prett; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pcall = decode_io_decode_exu_dec_i0_predict_p_d_bits_pcall; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pret = decode_io_decode_exu_dec_i0_predict_p_d_bits_pret; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_pja = decode_io_decode_exu_dec_i0_predict_p_d_bits_pja; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_predict_p_d_bits_way = decode_io_decode_exu_dec_i0_predict_p_d_bits_way; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_predict_fghr_d = decode_io_decode_exu_i0_predict_fghr_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_predict_index_d = decode_io_decode_exu_i0_predict_index_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_i0_predict_btag_d = decode_io_decode_exu_i0_predict_btag_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_rs1_en_d = decode_io_decode_exu_dec_i0_rs1_en_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_rs2_en_d = decode_io_decode_exu_dec_i0_rs2_en_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_immed_d = decode_io_decode_exu_dec_i0_immed_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_rs1_bypass_data_d = decode_io_decode_exu_dec_i0_rs1_bypass_data_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_rs2_bypass_data_d = decode_io_decode_exu_dec_i0_rs2_bypass_data_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_select_pc_d = decode_io_decode_exu_dec_i0_select_pc_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_rs1_bypass_en_d = decode_io_decode_exu_dec_i0_rs1_bypass_en_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_i0_rs2_bypass_en_d = decode_io_decode_exu_dec_i0_rs2_bypass_en_d; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_valid = decode_io_decode_exu_mul_p_valid; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_rs1_sign = decode_io_decode_exu_mul_p_bits_rs1_sign; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_rs2_sign = decode_io_decode_exu_mul_p_bits_rs2_sign; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_low = decode_io_decode_exu_mul_p_bits_low; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_bext = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_bdep = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_clmul = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_clmulh = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_clmulr = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_grev = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_shfl = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_unshfl = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_crc32_b = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_crc32_h = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_crc32_w = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_crc32c_b = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_crc32c_h = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_crc32c_w = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_mul_p_bits_bfp = 1'h0; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_pred_correct_npc_x = decode_io_decode_exu_pred_correct_npc_x; // @[dec.scala 135:23]
  assign io_dec_exu_decode_exu_dec_extint_stall = decode_io_decode_exu_dec_extint_stall; // @[dec.scala 135:23]
  assign io_dec_exu_tlu_exu_dec_tlu_meihap = tlu_io_tlu_exu_dec_tlu_meihap; // @[dec.scala 205:18]
  assign io_dec_exu_tlu_exu_dec_tlu_flush_lower_r = tlu_io_tlu_exu_dec_tlu_flush_lower_r; // @[dec.scala 205:18]
  assign io_dec_exu_tlu_exu_dec_tlu_flush_path_r = tlu_io_tlu_exu_dec_tlu_flush_path_r; // @[dec.scala 205:18]
  assign io_dec_exu_ib_exu_dec_i0_pc_d = instbuff_io_ib_exu_dec_i0_pc_d; // @[dec.scala 126:22]
  assign io_dec_exu_ib_exu_dec_debug_wdata_rs1_d = instbuff_io_ib_exu_dec_debug_wdata_rs1_d; // @[dec.scala 126:22]
  assign io_dec_exu_gpr_exu_gpr_i0_rs1_d = gpr_io_gpr_exu_gpr_i0_rs1_d; // @[dec.scala 201:22]
  assign io_dec_exu_gpr_exu_gpr_i0_rs2_d = gpr_io_gpr_exu_gpr_i0_rs2_d; // @[dec.scala 201:22]
  assign io_lsu_dec_tlu_busbuff_dec_tlu_external_ldfwd_disable = tlu_io_tlu_busbuff_dec_tlu_external_ldfwd_disable; // @[dec.scala 222:26]
  assign io_lsu_dec_tlu_busbuff_dec_tlu_wb_coalescing_disable = tlu_io_tlu_busbuff_dec_tlu_wb_coalescing_disable; // @[dec.scala 222:26]
  assign io_lsu_dec_tlu_busbuff_dec_tlu_sideeffect_posted_disable = tlu_io_tlu_busbuff_dec_tlu_sideeffect_posted_disable; // @[dec.scala 222:26]
  assign io_dec_dma_tlu_dma_dec_tlu_dma_qos_prty = tlu_io_tlu_dma_dec_tlu_dma_qos_prty; // @[dec.scala 206:18]
  assign io_dec_pic_dec_tlu_meicurpl = tlu_io_dec_pic_dec_tlu_meicurpl; // @[dec.scala 224:14]
  assign io_dec_pic_dec_tlu_meipt = tlu_io_dec_pic_dec_tlu_meipt; // @[dec.scala 224:14]
  assign instbuff_io_ifu_ib_ifu_i0_icaf = io_ifu_dec_dec_aln_aln_ib_ifu_i0_icaf; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_icaf_type = io_ifu_dec_dec_aln_aln_ib_ifu_i0_icaf_type; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_icaf_f1 = io_ifu_dec_dec_aln_aln_ib_ifu_i0_icaf_f1; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_dbecc = io_ifu_dec_dec_aln_aln_ib_ifu_i0_dbecc; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_bp_index = io_ifu_dec_dec_aln_aln_ib_ifu_i0_bp_index; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_bp_fghr = io_ifu_dec_dec_aln_aln_ib_ifu_i0_bp_fghr; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_bp_btag = io_ifu_dec_dec_aln_aln_ib_ifu_i0_bp_btag; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_valid = io_ifu_dec_dec_aln_aln_ib_ifu_i0_valid; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_instr = io_ifu_dec_dec_aln_aln_ib_ifu_i0_instr; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_pc = io_ifu_dec_dec_aln_aln_ib_ifu_i0_pc; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_ifu_i0_pc4 = io_ifu_dec_dec_aln_aln_ib_ifu_i0_pc4; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_valid = io_ifu_dec_dec_aln_aln_ib_i0_brp_valid; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_toffset = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_toffset; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_hist = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_hist; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_br_error = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_br_error; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_br_start_error = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_br_start_error; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_prett = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_prett; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_way = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_way; // @[dec.scala 125:22]
  assign instbuff_io_ifu_ib_i0_brp_bits_ret = io_ifu_dec_dec_aln_aln_ib_i0_brp_bits_ret; // @[dec.scala 125:22]
  assign instbuff_io_dbg_ib_dbg_cmd_valid = io_dec_dbg_dbg_ib_dbg_cmd_valid; // @[dec.scala 127:22]
  assign instbuff_io_dbg_ib_dbg_cmd_write = io_dec_dbg_dbg_ib_dbg_cmd_write; // @[dec.scala 127:22]
  assign instbuff_io_dbg_ib_dbg_cmd_type = io_dec_dbg_dbg_ib_dbg_cmd_type; // @[dec.scala 127:22]
  assign instbuff_io_dbg_ib_dbg_cmd_addr = io_dec_dbg_dbg_ib_dbg_cmd_addr; // @[dec.scala 127:22]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_io_decode_exu_exu_i0_result_x = io_dec_exu_decode_exu_exu_i0_result_x; // @[dec.scala 135:23]
  assign decode_io_decode_exu_exu_csr_rs1_x = io_dec_exu_decode_exu_exu_csr_rs1_x; // @[dec.scala 135:23]
  assign decode_io_dec_alu_exu_i0_pc_x = io_dec_exu_dec_alu_exu_i0_pc_x; // @[dec.scala 136:20]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_valid_m = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_valid_m; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_tag_m = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_tag_m; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_inv_r = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_inv_r; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_inv_tag_r = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_inv_tag_r; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_data_valid = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data_valid; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_data_error = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data_error; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_data_tag = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data_tag; // @[dec.scala 141:26]
  assign decode_io_dctl_busbuff_lsu_nonblock_load_data = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data; // @[dec.scala 141:26]
  assign decode_io_dctl_dma_dma_dccm_stall_any = io_dec_dma_dctl_dma_dma_dccm_stall_any; // @[dec.scala 138:22]
  assign decode_io_dec_tlu_flush_extint = tlu_io_dec_tlu_flush_extint; // @[dec.scala 139:48]
  assign decode_io_dec_tlu_force_halt = tlu_io_tlu_mem_dec_tlu_force_halt; // @[dec.scala 140:48]
  assign decode_io_dec_i0_trigger_match_d = dec_trigger_io_dec_i0_trigger_match_d; // @[dec.scala 142:48]
  assign decode_io_dec_tlu_wr_pause_r = tlu_io_dec_tlu_wr_pause_r; // @[dec.scala 143:48]
  assign decode_io_dec_tlu_pipelining_disable = tlu_io_dec_tlu_pipelining_disable; // @[dec.scala 144:48]
  assign decode_io_lsu_trigger_match_m = io_lsu_trigger_match_m; // @[dec.scala 145:48]
  assign decode_io_lsu_pmu_misaligned_m = io_lsu_pmu_misaligned_m; // @[dec.scala 146:48]
  assign decode_io_dec_tlu_debug_stall = tlu_io_dec_tlu_debug_stall; // @[dec.scala 147:48]
  assign decode_io_dec_tlu_flush_leak_one_r = tlu_io_tlu_bp_dec_tlu_flush_leak_one_wb; // @[dec.scala 148:48]
  assign decode_io_dec_debug_fence_d = instbuff_io_dec_debug_fence_d; // @[dec.scala 149:48]
  assign decode_io_dec_i0_icaf_d = instbuff_io_dec_i0_icaf_d; // @[dec.scala 151:48]
  assign decode_io_dec_i0_icaf_f1_d = instbuff_io_dec_i0_icaf_f1_d; // @[dec.scala 152:48]
  assign decode_io_dec_i0_icaf_type_d = instbuff_io_dec_i0_icaf_type_d; // @[dec.scala 153:48]
  assign decode_io_dec_i0_dbecc_d = instbuff_io_dec_i0_dbecc_d; // @[dec.scala 154:48]
  assign decode_io_dec_i0_brp_valid = instbuff_io_dec_i0_brp_valid; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_toffset = instbuff_io_dec_i0_brp_bits_toffset; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_hist = instbuff_io_dec_i0_brp_bits_hist; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_br_error = instbuff_io_dec_i0_brp_bits_br_error; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_br_start_error = instbuff_io_dec_i0_brp_bits_br_start_error; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_prett = instbuff_io_dec_i0_brp_bits_prett; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_way = instbuff_io_dec_i0_brp_bits_way; // @[dec.scala 155:48]
  assign decode_io_dec_i0_brp_bits_ret = instbuff_io_dec_i0_brp_bits_ret; // @[dec.scala 155:48]
  assign decode_io_dec_i0_bp_index = instbuff_io_dec_i0_bp_index; // @[dec.scala 156:48]
  assign decode_io_dec_i0_bp_fghr = instbuff_io_dec_i0_bp_fghr; // @[dec.scala 157:48]
  assign decode_io_dec_i0_bp_btag = instbuff_io_dec_i0_bp_btag; // @[dec.scala 158:48]
  assign decode_io_lsu_idle_any = io_lsu_idle_any; // @[dec.scala 160:48]
  assign decode_io_lsu_load_stall_any = io_lsu_load_stall_any; // @[dec.scala 161:48]
  assign decode_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[dec.scala 162:48]
  assign decode_io_exu_div_wren = io_exu_div_wren; // @[dec.scala 163:48]
  assign decode_io_dec_tlu_i0_kill_writeb_wb = tlu_io_dec_tlu_i0_kill_writeb_wb; // @[dec.scala 164:48]
  assign decode_io_dec_tlu_flush_lower_wb = tlu_io_tlu_bp_dec_tlu_flush_lower_wb; // @[dec.scala 165:48]
  assign decode_io_dec_tlu_i0_kill_writeb_r = tlu_io_dec_tlu_i0_kill_writeb_r; // @[dec.scala 166:48]
  assign decode_io_dec_tlu_flush_lower_r = tlu_io_tlu_exu_dec_tlu_flush_lower_r; // @[dec.scala 167:48]
  assign decode_io_dec_tlu_flush_pause_r = tlu_io_dec_tlu_flush_pause_r; // @[dec.scala 168:48]
  assign decode_io_dec_tlu_presync_d = tlu_io_dec_tlu_presync_d; // @[dec.scala 169:48]
  assign decode_io_dec_tlu_postsync_d = tlu_io_dec_tlu_postsync_d; // @[dec.scala 170:48]
  assign decode_io_dec_i0_pc4_d = instbuff_io_dec_i0_pc4_d; // @[dec.scala 171:48]
  assign decode_io_dec_csr_rddata_d = tlu_io_dec_csr_rddata_d; // @[dec.scala 172:48]
  assign decode_io_dec_csr_legal_d = tlu_io_dec_csr_legal_d; // @[dec.scala 173:48]
  assign decode_io_lsu_result_m = io_lsu_result_m; // @[dec.scala 174:48]
  assign decode_io_lsu_result_corr_r = io_lsu_result_corr_r; // @[dec.scala 175:48]
  assign decode_io_exu_flush_final = io_exu_flush_final; // @[dec.scala 176:48]
  assign decode_io_dec_i0_instr_d = instbuff_io_dec_i0_instr_d; // @[dec.scala 177:48]
  assign decode_io_dec_ib0_valid_d = instbuff_io_dec_ib0_valid_d; // @[dec.scala 178:48]
  assign decode_io_free_clk = io_free_clk; // @[dec.scala 179:48]
  assign decode_io_active_clk = io_active_clk; // @[dec.scala 180:48]
  assign decode_io_clk_override = tlu_io_dec_tlu_dec_clk_override; // @[dec.scala 181:48]
  assign decode_io_scan_mode = io_scan_mode; // @[dec.scala 182:48]
  assign decode_io_dec_aln_ifu_i0_cinst = io_ifu_dec_dec_aln_aln_dec_ifu_i0_cinst; // @[dec.scala 133:21]
  assign decode_io_dbg_dctl_dbg_cmd_wrdata = io_dec_dbg_dbg_dctl_dbg_cmd_wrdata; // @[dec.scala 150:22]
  assign gpr_clock = clock;
  assign gpr_reset = reset;
  assign gpr_io_raddr0 = decode_io_dec_i0_rs1_d; // @[dec.scala 189:23]
  assign gpr_io_raddr1 = decode_io_dec_i0_rs2_d; // @[dec.scala 190:23]
  assign gpr_io_wen0 = decode_io_dec_i0_wen_r; // @[dec.scala 191:23]
  assign gpr_io_waddr0 = decode_io_dec_i0_waddr_r; // @[dec.scala 192:23]
  assign gpr_io_wd0 = decode_io_dec_i0_wdata_r; // @[dec.scala 193:23]
  assign gpr_io_wen1 = decode_io_dec_nonblock_load_wen; // @[dec.scala 194:23]
  assign gpr_io_waddr1 = decode_io_dec_nonblock_load_waddr; // @[dec.scala 195:23]
  assign gpr_io_wd1 = io_lsu_dec_dctl_busbuff_lsu_nonblock_load_data; // @[dec.scala 196:23]
  assign gpr_io_wen2 = io_exu_div_wren; // @[dec.scala 197:23]
  assign gpr_io_waddr2 = decode_io_div_waddr_wb; // @[dec.scala 198:23]
  assign gpr_io_wd2 = io_exu_div_result; // @[dec.scala 199:23]
  assign gpr_io_scan_mode = io_scan_mode; // @[dec.scala 200:23]
  assign tlu_clock = clock;
  assign tlu_reset = reset;
  assign tlu_io_tlu_exu_exu_i0_br_hist_r = io_dec_exu_tlu_exu_exu_i0_br_hist_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_i0_br_error_r = io_dec_exu_tlu_exu_exu_i0_br_error_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_i0_br_start_error_r = io_dec_exu_tlu_exu_exu_i0_br_start_error_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_i0_br_valid_r = io_dec_exu_tlu_exu_exu_i0_br_valid_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_i0_br_mp_r = io_dec_exu_tlu_exu_exu_i0_br_mp_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_i0_br_middle_r = io_dec_exu_tlu_exu_exu_i0_br_middle_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_pmu_i0_br_misp = io_dec_exu_tlu_exu_exu_pmu_i0_br_misp; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_pmu_i0_br_ataken = io_dec_exu_tlu_exu_exu_pmu_i0_br_ataken; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_pmu_i0_pc4 = io_dec_exu_tlu_exu_exu_pmu_i0_pc4; // @[dec.scala 205:18]
  assign tlu_io_tlu_exu_exu_npc_r = io_dec_exu_tlu_exu_exu_npc_r; // @[dec.scala 205:18]
  assign tlu_io_tlu_dma_dma_pmu_dccm_read = io_dec_dma_tlu_dma_dma_pmu_dccm_read; // @[dec.scala 206:18]
  assign tlu_io_tlu_dma_dma_pmu_dccm_write = io_dec_dma_tlu_dma_dma_pmu_dccm_write; // @[dec.scala 206:18]
  assign tlu_io_tlu_dma_dma_pmu_any_read = io_dec_dma_tlu_dma_dma_pmu_any_read; // @[dec.scala 206:18]
  assign tlu_io_tlu_dma_dma_pmu_any_write = io_dec_dma_tlu_dma_dma_pmu_any_write; // @[dec.scala 206:18]
  assign tlu_io_tlu_dma_dma_dccm_stall_any = io_dec_dma_tlu_dma_dma_dccm_stall_any; // @[dec.scala 206:18]
  assign tlu_io_tlu_dma_dma_iccm_stall_any = io_dec_dma_tlu_dma_dma_iccm_stall_any; // @[dec.scala 206:18]
  assign tlu_io_active_clk = io_active_clk; // @[dec.scala 207:45]
  assign tlu_io_free_clk = io_free_clk; // @[dec.scala 208:45]
  assign tlu_io_scan_mode = io_scan_mode; // @[dec.scala 209:45]
  assign tlu_io_rst_vec = io_rst_vec; // @[dec.scala 210:45]
  assign tlu_io_nmi_int = io_nmi_int; // @[dec.scala 211:45]
  assign tlu_io_nmi_vec = io_nmi_vec; // @[dec.scala 212:45]
  assign tlu_io_i_cpu_halt_req = io_i_cpu_halt_req; // @[dec.scala 213:45]
  assign tlu_io_i_cpu_run_req = io_i_cpu_run_req; // @[dec.scala 214:45]
  assign tlu_io_lsu_fastint_stall_any = io_lsu_fastint_stall_any; // @[dec.scala 215:45]
  assign tlu_io_lsu_idle_any = io_lsu_idle_any; // @[dec.scala 246:45]
  assign tlu_io_dec_pmu_instr_decoded = decode_io_dec_pmu_instr_decoded; // @[dec.scala 217:45]
  assign tlu_io_dec_pmu_decode_stall = decode_io_dec_pmu_decode_stall; // @[dec.scala 218:45]
  assign tlu_io_dec_pmu_presync_stall = decode_io_dec_pmu_presync_stall; // @[dec.scala 219:45]
  assign tlu_io_dec_pmu_postsync_stall = decode_io_dec_pmu_postsync_stall; // @[dec.scala 220:45]
  assign tlu_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[dec.scala 221:45]
  assign tlu_io_lsu_fir_addr = io_lsu_fir_addr; // @[dec.scala 225:45]
  assign tlu_io_lsu_fir_error = io_lsu_fir_error; // @[dec.scala 226:45]
  assign tlu_io_iccm_dma_sb_error = io_iccm_dma_sb_error; // @[dec.scala 227:45]
  assign tlu_io_lsu_error_pkt_r_valid = io_lsu_error_pkt_r_valid; // @[dec.scala 228:45]
  assign tlu_io_lsu_error_pkt_r_bits_single_ecc_error = io_lsu_error_pkt_r_bits_single_ecc_error; // @[dec.scala 228:45]
  assign tlu_io_lsu_error_pkt_r_bits_inst_type = io_lsu_error_pkt_r_bits_inst_type; // @[dec.scala 228:45]
  assign tlu_io_lsu_error_pkt_r_bits_exc_type = io_lsu_error_pkt_r_bits_exc_type; // @[dec.scala 228:45]
  assign tlu_io_lsu_error_pkt_r_bits_mscause = io_lsu_error_pkt_r_bits_mscause; // @[dec.scala 228:45]
  assign tlu_io_lsu_error_pkt_r_bits_addr = io_lsu_error_pkt_r_bits_addr; // @[dec.scala 228:45]
  assign tlu_io_lsu_single_ecc_error_incr = io_lsu_single_ecc_error_incr; // @[dec.scala 229:45]
  assign tlu_io_dec_pause_state = decode_io_dec_pause_state; // @[dec.scala 230:45]
  assign tlu_io_dec_csr_wen_unq_d = decode_io_dec_csr_wen_unq_d; // @[dec.scala 231:45]
  assign tlu_io_dec_csr_any_unq_d = decode_io_dec_csr_any_unq_d; // @[dec.scala 232:45]
  assign tlu_io_dec_csr_rdaddr_d = decode_io_dec_csr_rdaddr_d; // @[dec.scala 233:45]
  assign tlu_io_dec_csr_wen_r = decode_io_dec_csr_wen_r; // @[dec.scala 234:45]
  assign tlu_io_dec_csr_wraddr_r = decode_io_dec_csr_wraddr_r; // @[dec.scala 235:45]
  assign tlu_io_dec_csr_wrdata_r = decode_io_dec_csr_wrdata_r; // @[dec.scala 236:45]
  assign tlu_io_dec_csr_stall_int_ff = decode_io_dec_csr_stall_int_ff; // @[dec.scala 237:45]
  assign tlu_io_dec_tlu_i0_valid_r = decode_io_dec_tlu_i0_valid_r; // @[dec.scala 238:45]
  assign tlu_io_dec_tlu_i0_pc_r = decode_io_dec_tlu_i0_pc_r; // @[dec.scala 239:45]
  assign tlu_io_dec_tlu_packet_r_legal = decode_io_dec_tlu_packet_r_legal; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_icaf = decode_io_dec_tlu_packet_r_icaf; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_icaf_f1 = decode_io_dec_tlu_packet_r_icaf_f1; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_icaf_type = decode_io_dec_tlu_packet_r_icaf_type; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_fence_i = decode_io_dec_tlu_packet_r_fence_i; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_i0trigger = decode_io_dec_tlu_packet_r_i0trigger; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_pmu_i0_itype = decode_io_dec_tlu_packet_r_pmu_i0_itype; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_pmu_i0_br_unpred = decode_io_dec_tlu_packet_r_pmu_i0_br_unpred; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_pmu_divide = decode_io_dec_tlu_packet_r_pmu_divide; // @[dec.scala 240:45]
  assign tlu_io_dec_tlu_packet_r_pmu_lsu_misaligned = decode_io_dec_tlu_packet_r_pmu_lsu_misaligned; // @[dec.scala 240:45]
  assign tlu_io_dec_illegal_inst = decode_io_dec_illegal_inst; // @[dec.scala 241:45]
  assign tlu_io_dec_i0_decode_d = decode_io_dec_aln_dec_i0_decode_d; // @[dec.scala 242:45]
  assign tlu_io_exu_i0_br_way_r = io_exu_i0_br_way_r; // @[dec.scala 243:45]
  assign tlu_io_dbg_halt_req = io_dbg_halt_req; // @[dec.scala 244:45]
  assign tlu_io_dbg_resume_req = io_dbg_resume_req; // @[dec.scala 245:45]
  assign tlu_io_dec_div_active = decode_io_dec_div_active; // @[dec.scala 247:45]
  assign tlu_io_timer_int = io_timer_int; // @[dec.scala 252:45]
  assign tlu_io_soft_int = io_soft_int; // @[dec.scala 253:45]
  assign tlu_io_core_id = io_core_id; // @[dec.scala 254:45]
  assign tlu_io_mpc_debug_halt_req = io_mpc_debug_halt_req; // @[dec.scala 255:45]
  assign tlu_io_mpc_debug_run_req = io_mpc_debug_run_req; // @[dec.scala 256:45]
  assign tlu_io_mpc_reset_run_req = io_mpc_reset_run_req; // @[dec.scala 257:45]
  assign tlu_io_ifu_pmu_instr_aligned = io_ifu_dec_dec_aln_ifu_pmu_instr_aligned; // @[dec.scala 216:45]
  assign tlu_io_tlu_ifc_ifu_pmu_fetch_stall = io_ifu_dec_dec_ifc_ifu_pmu_fetch_stall; // @[dec.scala 203:18]
  assign tlu_io_tlu_mem_ifu_pmu_ic_miss = io_ifu_dec_dec_mem_ctrl_ifu_pmu_ic_miss; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_pmu_ic_hit = io_ifu_dec_dec_mem_ctrl_ifu_pmu_ic_hit; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_pmu_bus_error = io_ifu_dec_dec_mem_ctrl_ifu_pmu_bus_error; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_pmu_bus_busy = io_ifu_dec_dec_mem_ctrl_ifu_pmu_bus_busy; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_pmu_bus_trxn = io_ifu_dec_dec_mem_ctrl_ifu_pmu_bus_trxn; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_ic_error_start = io_ifu_dec_dec_mem_ctrl_ifu_ic_error_start; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_iccm_rd_ecc_single_err = io_ifu_dec_dec_mem_ctrl_ifu_iccm_rd_ecc_single_err; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_ic_debug_rd_data = io_ifu_dec_dec_mem_ctrl_ifu_ic_debug_rd_data; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_ic_debug_rd_data_valid = io_ifu_dec_dec_mem_ctrl_ifu_ic_debug_rd_data_valid; // @[dec.scala 202:18]
  assign tlu_io_tlu_mem_ifu_miss_state_idle = io_ifu_dec_dec_mem_ctrl_ifu_miss_state_idle; // @[dec.scala 202:18]
  assign tlu_io_tlu_busbuff_lsu_pmu_bus_trxn = io_lsu_dec_tlu_busbuff_lsu_pmu_bus_trxn; // @[dec.scala 222:26]
  assign tlu_io_tlu_busbuff_lsu_pmu_bus_misaligned = io_lsu_dec_tlu_busbuff_lsu_pmu_bus_misaligned; // @[dec.scala 222:26]
  assign tlu_io_tlu_busbuff_lsu_pmu_bus_error = io_lsu_dec_tlu_busbuff_lsu_pmu_bus_error; // @[dec.scala 222:26]
  assign tlu_io_tlu_busbuff_lsu_pmu_bus_busy = io_lsu_dec_tlu_busbuff_lsu_pmu_bus_busy; // @[dec.scala 222:26]
  assign tlu_io_tlu_busbuff_lsu_imprecise_error_load_any = io_lsu_dec_tlu_busbuff_lsu_imprecise_error_load_any; // @[dec.scala 222:26]
  assign tlu_io_tlu_busbuff_lsu_imprecise_error_store_any = io_lsu_dec_tlu_busbuff_lsu_imprecise_error_store_any; // @[dec.scala 222:26]
  assign tlu_io_tlu_busbuff_lsu_imprecise_error_addr_any = io_lsu_dec_tlu_busbuff_lsu_imprecise_error_addr_any; // @[dec.scala 222:26]
  assign tlu_io_lsu_tlu_lsu_pmu_load_external_m = io_lsu_tlu_lsu_pmu_load_external_m; // @[dec.scala 223:14]
  assign tlu_io_lsu_tlu_lsu_pmu_store_external_m = io_lsu_tlu_lsu_pmu_store_external_m; // @[dec.scala 223:14]
  assign tlu_io_dec_pic_pic_claimid = io_dec_pic_pic_claimid; // @[dec.scala 224:14]
  assign tlu_io_dec_pic_pic_pl = io_dec_pic_pic_pl; // @[dec.scala 224:14]
  assign tlu_io_dec_pic_mhwakeup = io_dec_pic_mhwakeup; // @[dec.scala 224:14]
  assign tlu_io_dec_pic_mexintpend = io_dec_pic_mexintpend; // @[dec.scala 224:14]
  assign dec_trigger_io_trigger_pkt_any_0_select = tlu_io_trigger_pkt_any_0_select; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_0_match_pkt = tlu_io_trigger_pkt_any_0_match_pkt; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_0_execute = tlu_io_trigger_pkt_any_0_execute; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_0_m = tlu_io_trigger_pkt_any_0_m; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_0_tdata2 = tlu_io_trigger_pkt_any_0_tdata2; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_1_select = tlu_io_trigger_pkt_any_1_select; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_1_match_pkt = tlu_io_trigger_pkt_any_1_match_pkt; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_1_execute = tlu_io_trigger_pkt_any_1_execute; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_1_m = tlu_io_trigger_pkt_any_1_m; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_1_tdata2 = tlu_io_trigger_pkt_any_1_tdata2; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_2_select = tlu_io_trigger_pkt_any_2_select; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_2_match_pkt = tlu_io_trigger_pkt_any_2_match_pkt; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_2_execute = tlu_io_trigger_pkt_any_2_execute; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_2_m = tlu_io_trigger_pkt_any_2_m; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_2_tdata2 = tlu_io_trigger_pkt_any_2_tdata2; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_3_select = tlu_io_trigger_pkt_any_3_select; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_3_match_pkt = tlu_io_trigger_pkt_any_3_match_pkt; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_3_execute = tlu_io_trigger_pkt_any_3_execute; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_3_m = tlu_io_trigger_pkt_any_3_m; // @[dec.scala 129:34]
  assign dec_trigger_io_trigger_pkt_any_3_tdata2 = tlu_io_trigger_pkt_any_3_tdata2; // @[dec.scala 129:34]
  assign dec_trigger_io_dec_i0_pc_d = instbuff_io_ib_exu_dec_i0_pc_d; // @[dec.scala 128:30]
endmodule
