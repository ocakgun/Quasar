module el2_dec_ib_ctl(
  input         io_dbg_cmd_valid,
  input         io_dbg_cmd_write,
  input  [1:0]  io_dbg_cmd_type,
  input  [31:0] io_dbg_cmd_addr,
  input         io_i0_brp_valid,
  input  [11:0] io_i0_brp_toffset,
  input  [1:0]  io_i0_brp_hist,
  input         io_i0_brp_br_error,
  input         io_i0_brp_br_start_error,
  input  [30:0] io_i0_brp_prett,
  input         io_i0_brp_way,
  input         io_i0_brp_ret,
  input  [7:0]  io_ifu_i0_bp_index,
  input  [7:0]  io_ifu_i0_bp_fghr,
  input  [4:0]  io_ifu_i0_bp_btag,
  input         io_ifu_i0_valid,
  input         io_ifu_i0_icaf,
  input         io_ifu_i0_dbecc,
  input  [31:0] io_ifu_i0_instr,
  input  [30:0] io_ifu_i0_pc,
  output        io_dec_ib0_valid_d,
  output [31:0] io_dec_i0_instr_d,
  output [30:0] io_dec_i0_pc_d,
  output        io_dec_i0_brp_valid,
  output [11:0] io_dec_i0_brp_toffset,
  output [1:0]  io_dec_i0_brp_hist,
  output        io_dec_i0_brp_br_error,
  output        io_dec_i0_brp_br_start_error,
  output [30:0] io_dec_i0_brp_prett,
  output        io_dec_i0_brp_way,
  output        io_dec_i0_brp_ret,
  output [7:0]  io_dec_i0_bp_index,
  output [7:0]  io_dec_i0_bp_fghr,
  output [4:0]  io_dec_i0_bp_btag,
  output        io_dec_i0_icaf_d,
  output        io_dec_i0_dbecc_d,
  output        io_dec_debug_wdata_rs1_d,
  output        io_dec_debug_fence_d
);
  wire  _T = io_dbg_cmd_type != 2'h2; // @[el2_dec_ib_ctl.scala 31:60]
  wire  debug_valid = io_dbg_cmd_valid & _T; // @[el2_dec_ib_ctl.scala 31:41]
  wire  _T_1 = ~io_dbg_cmd_write; // @[el2_dec_ib_ctl.scala 32:38]
  wire  debug_read = debug_valid & _T_1; // @[el2_dec_ib_ctl.scala 32:36]
  wire  debug_write = debug_valid & io_dbg_cmd_write; // @[el2_dec_ib_ctl.scala 33:36]
  wire  _T_2 = io_dbg_cmd_type == 2'h0; // @[el2_dec_ib_ctl.scala 35:55]
  wire  debug_read_gpr = debug_read & _T_2; // @[el2_dec_ib_ctl.scala 35:37]
  wire  debug_write_gpr = debug_write & _T_2; // @[el2_dec_ib_ctl.scala 36:37]
  wire  _T_4 = io_dbg_cmd_type == 2'h1; // @[el2_dec_ib_ctl.scala 37:55]
  wire  debug_read_csr = debug_read & _T_4; // @[el2_dec_ib_ctl.scala 37:37]
  wire  debug_write_csr = debug_write & _T_4; // @[el2_dec_ib_ctl.scala 38:37]
  wire [4:0] dreg = io_dbg_cmd_addr[4:0]; // @[el2_dec_ib_ctl.scala 40:40]
  wire [11:0] dcsr = io_dbg_cmd_addr[11:0]; // @[el2_dec_ib_ctl.scala 41:40]
  wire [31:0] _T_9 = {12'h0,dreg,15'h6033}; // @[Cat.scala 29:58]
  wire [13:0] _T_12 = {3'h6,dreg,6'h33}; // @[Cat.scala 29:58]
  wire [25:0] _T_14 = {dcsr,14'h2073}; // @[Cat.scala 29:58]
  wire [24:0] _T_16 = {dcsr,13'h1073}; // @[Cat.scala 29:58]
  wire [31:0] _T_17 = debug_read_gpr ? _T_9 : 32'h0; // @[Mux.scala 27:72]
  wire [13:0] _T_18 = debug_write_gpr ? _T_12 : 14'h0; // @[Mux.scala 27:72]
  wire [25:0] _T_19 = debug_read_csr ? _T_14 : 26'h0; // @[Mux.scala 27:72]
  wire [24:0] _T_20 = debug_write_csr ? _T_16 : 25'h0; // @[Mux.scala 27:72]
  wire [31:0] _GEN_0 = {{18'd0}, _T_18}; // @[Mux.scala 27:72]
  wire [31:0] _T_21 = _T_17 | _GEN_0; // @[Mux.scala 27:72]
  wire [31:0] _GEN_1 = {{6'd0}, _T_19}; // @[Mux.scala 27:72]
  wire [31:0] _T_22 = _T_21 | _GEN_1; // @[Mux.scala 27:72]
  wire [31:0] _GEN_2 = {{7'd0}, _T_20}; // @[Mux.scala 27:72]
  wire [31:0] ib0_debug_in = _T_22 | _GEN_2; // @[Mux.scala 27:72]
  wire  _T_25 = dcsr == 12'h7c4; // @[el2_dec_ib_ctl.scala 54:51]
  assign io_dec_ib0_valid_d = io_ifu_i0_valid | debug_valid; // @[el2_dec_ib_ctl.scala 56:22]
  assign io_dec_i0_instr_d = debug_valid ? ib0_debug_in : io_ifu_i0_instr; // @[el2_dec_ib_ctl.scala 57:22]
  assign io_dec_i0_pc_d = io_ifu_i0_pc; // @[el2_dec_ib_ctl.scala 11:31]
  assign io_dec_i0_brp_valid = io_i0_brp_valid; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_toffset = io_i0_brp_toffset; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_hist = io_i0_brp_hist; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_br_error = io_i0_brp_br_error; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_br_start_error = io_i0_brp_br_start_error; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_prett = io_i0_brp_prett; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_way = io_i0_brp_way; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_brp_ret = io_i0_brp_ret; // @[el2_dec_ib_ctl.scala 14:31]
  assign io_dec_i0_bp_index = io_ifu_i0_bp_index; // @[el2_dec_ib_ctl.scala 15:31]
  assign io_dec_i0_bp_fghr = io_ifu_i0_bp_fghr; // @[el2_dec_ib_ctl.scala 16:31]
  assign io_dec_i0_bp_btag = io_ifu_i0_bp_btag; // @[el2_dec_ib_ctl.scala 17:31]
  assign io_dec_i0_icaf_d = io_ifu_i0_icaf; // @[el2_dec_ib_ctl.scala 10:31]
  assign io_dec_i0_dbecc_d = io_ifu_i0_dbecc; // @[el2_dec_ib_ctl.scala 9:31]
  assign io_dec_debug_wdata_rs1_d = debug_write_gpr | debug_write_csr; // @[el2_dec_ib_ctl.scala 51:28]
  assign io_dec_debug_fence_d = debug_write_csr & _T_25; // @[el2_dec_ib_ctl.scala 54:24]
endmodule
module rvclkhdr(
  output  io_l1clk,
  input   io_clk,
  input   io_en,
  input   io_scan_mode
);
  wire  clkhdr_Q; // @[beh_lib.scala 330:24]
  wire  clkhdr_CK; // @[beh_lib.scala 330:24]
  wire  clkhdr_EN; // @[beh_lib.scala 330:24]
  wire  clkhdr_SE; // @[beh_lib.scala 330:24]
  TEC_RV_ICG clkhdr ( // @[beh_lib.scala 330:24]
    .Q(clkhdr_Q),
    .CK(clkhdr_CK),
    .EN(clkhdr_EN),
    .SE(clkhdr_SE)
  );
  assign io_l1clk = clkhdr_Q; // @[beh_lib.scala 331:12]
  assign clkhdr_CK = io_clk; // @[beh_lib.scala 332:16]
  assign clkhdr_EN = io_en; // @[beh_lib.scala 333:16]
  assign clkhdr_SE = io_scan_mode; // @[beh_lib.scala 334:16]
endmodule
module el2_dec_dec_ctl(
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
  output        io_out_mul,
  output        io_out_rs1_sign,
  output        io_out_rs2_sign,
  output        io_out_low,
  output        io_out_div,
  output        io_out_rem,
  output        io_out_fence,
  output        io_out_legal
);
  wire  _T_2 = io_ins[2] | io_ins[6]; // @[el2_dec_dec_ctl.scala 20:27]
  wire  _T_4 = ~io_ins[25]; // @[el2_dec_dec_ctl.scala 20:42]
  wire  _T_6 = _T_4 & io_ins[4]; // @[el2_dec_dec_ctl.scala 20:53]
  wire  _T_7 = _T_2 | _T_6; // @[el2_dec_dec_ctl.scala 20:39]
  wire  _T_9 = ~io_ins[5]; // @[el2_dec_dec_ctl.scala 20:68]
  wire  _T_11 = _T_9 & io_ins[4]; // @[el2_dec_dec_ctl.scala 20:78]
  wire  _T_14 = ~io_ins[14]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_16 = ~io_ins[13]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_18 = ~io_ins[2]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_19 = _T_14 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_20 = _T_19 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_26 = _T_16 & io_ins[11]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_27 = _T_26 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_28 = _T_20 | _T_27; // @[el2_dec_dec_ctl.scala 21:43]
  wire  _T_33 = io_ins[19] & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_34 = _T_33 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_35 = _T_28 | _T_34; // @[el2_dec_dec_ctl.scala 21:70]
  wire  _T_41 = _T_16 & io_ins[10]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_42 = _T_41 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_43 = _T_35 | _T_42; // @[el2_dec_dec_ctl.scala 22:29]
  wire  _T_48 = io_ins[18] & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_49 = _T_48 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_50 = _T_43 | _T_49; // @[el2_dec_dec_ctl.scala 22:56]
  wire  _T_56 = _T_16 & io_ins[9]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_57 = _T_56 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_58 = _T_50 | _T_57; // @[el2_dec_dec_ctl.scala 23:29]
  wire  _T_63 = io_ins[17] & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_64 = _T_63 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_65 = _T_58 | _T_64; // @[el2_dec_dec_ctl.scala 23:55]
  wire  _T_71 = _T_16 & io_ins[8]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_72 = _T_71 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_73 = _T_65 | _T_72; // @[el2_dec_dec_ctl.scala 24:29]
  wire  _T_78 = io_ins[16] & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_79 = _T_78 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_80 = _T_73 | _T_79; // @[el2_dec_dec_ctl.scala 24:55]
  wire  _T_86 = _T_16 & io_ins[7]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_87 = _T_86 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_88 = _T_80 | _T_87; // @[el2_dec_dec_ctl.scala 25:29]
  wire  _T_93 = io_ins[15] & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_94 = _T_93 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_95 = _T_88 | _T_94; // @[el2_dec_dec_ctl.scala 25:55]
  wire  _T_97 = ~io_ins[4]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_99 = ~io_ins[3]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_100 = _T_97 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_101 = _T_95 | _T_100; // @[el2_dec_dec_ctl.scala 26:29]
  wire  _T_103 = ~io_ins[6]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_106 = _T_103 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_113 = io_ins[5] & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_114 = _T_113 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_120 = _T_103 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_121 = _T_120 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_129 = _T_100 & io_ins[2]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_136 = io_ins[13] & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_137 = _T_136 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_138 = _T_137 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_139 = _T_129 | _T_138; // @[el2_dec_dec_ctl.scala 28:42]
  wire  _T_143 = ~io_ins[12]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_146 = _T_16 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_147 = _T_146 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_148 = _T_147 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_149 = _T_139 | _T_148; // @[el2_dec_dec_ctl.scala 28:70]
  wire  _T_157 = _T_143 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_158 = _T_157 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_159 = _T_158 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_165 = _T_9 & _T_18; // @[el2_dec_dec_ctl.scala 30:28]
  wire  _T_168 = io_ins[5] & io_ins[2]; // @[el2_dec_dec_ctl.scala 30:55]
  wire  _T_169 = _T_165 | _T_168; // @[el2_dec_dec_ctl.scala 30:42]
  wire  _T_180 = _T_16 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_181 = _T_180 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_182 = _T_181 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_186 = io_ins[5] & io_ins[3]; // @[el2_dec_dec_ctl.scala 32:29]
  wire  _T_189 = io_ins[4] & io_ins[2]; // @[el2_dec_dec_ctl.scala 32:53]
  wire  _T_195 = _T_9 & _T_99; // @[el2_dec_dec_ctl.scala 33:28]
  wire  _T_197 = _T_195 & io_ins[2]; // @[el2_dec_dec_ctl.scala 33:41]
  wire  _T_208 = _T_9 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_223 = _T_103 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_235 = _T_19 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_236 = _T_235 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_237 = _T_236 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_245 = _T_237 | _T_197; // @[el2_dec_dec_ctl.scala 37:49]
  wire  _T_247 = ~io_ins[30]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_261 = _T_247 & _T_4; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_262 = _T_261 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_263 = _T_262 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_264 = _T_263 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_265 = _T_264 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_266 = _T_265 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_267 = _T_266 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_278 = io_ins[30] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_279 = _T_278 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_280 = _T_279 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_281 = _T_280 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_282 = _T_281 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_293 = _T_4 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_294 = _T_293 & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_295 = _T_294 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_296 = _T_295 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_297 = _T_296 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_298 = _T_282 | _T_297; // @[el2_dec_dec_ctl.scala 39:49]
  wire  _T_307 = _T_14 & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_308 = _T_307 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_309 = _T_308 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_310 = _T_309 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_311 = _T_298 | _T_310; // @[el2_dec_dec_ctl.scala 39:85]
  wire  _T_317 = io_ins[6] & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_318 = _T_317 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_327 = io_ins[14] & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_328 = _T_327 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_329 = _T_328 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_330 = _T_329 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_340 = _T_4 & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_341 = _T_340 & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_342 = _T_341 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_343 = _T_342 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_344 = _T_343 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_349 = _T_103 & io_ins[3]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_362 = _T_341 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_363 = _T_362 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_364 = _T_363 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_365 = _T_349 | _T_364; // @[el2_dec_dec_ctl.scala 42:37]
  wire  _T_369 = io_ins[5] & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_370 = _T_369 & io_ins[2]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_371 = _T_365 | _T_370; // @[el2_dec_dec_ctl.scala 42:74]
  wire  _T_381 = _T_371 | _T_148; // @[el2_dec_dec_ctl.scala 43:26]
  wire  _T_391 = _T_327 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_392 = _T_391 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_393 = _T_392 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_406 = _T_340 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_407 = _T_406 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_408 = _T_407 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_409 = _T_408 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_420 = io_ins[14] & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_421 = _T_420 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_422 = _T_421 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_423 = _T_422 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_424 = _T_423 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_439 = _T_293 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_440 = _T_439 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_441 = _T_440 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_442 = _T_441 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_453 = io_ins[30] & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_454 = _T_453 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_455 = _T_454 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_456 = _T_455 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_472 = _T_261 & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_473 = _T_472 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_474 = _T_473 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_475 = _T_474 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_476 = _T_475 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_515 = _T_307 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_516 = _T_515 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_517 = _T_516 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_524 = io_ins[13] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_525 = _T_524 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_526 = _T_525 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_527 = _T_517 | _T_526; // @[el2_dec_dec_ctl.scala 50:51]
  wire  _T_533 = io_ins[14] & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_534 = _T_533 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_535 = _T_527 | _T_534; // @[el2_dec_dec_ctl.scala 50:79]
  wire  _T_548 = _T_294 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_549 = _T_548 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_550 = _T_549 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_551 = _T_535 | _T_550; // @[el2_dec_dec_ctl.scala 51:29]
  wire  _T_560 = io_ins[25] & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_561 = _T_560 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_562 = _T_561 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_563 = _T_562 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_564 = _T_563 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_582 = _T_14 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_583 = _T_582 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_584 = _T_583 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_594 = _T_14 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_595 = _T_594 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_596 = _T_595 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_605 = io_ins[14] & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_606 = _T_605 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_607 = _T_606 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_617 = io_ins[14] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_618 = _T_617 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_619 = _T_618 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_635 = _T_146 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_636 = _T_635 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_645 = io_ins[12] & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_646 = _T_645 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_653 = io_ins[13] & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_659 = _T_524 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_663 = io_ins[7] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_664 = _T_663 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_665 = _T_659 | _T_664; // @[el2_dec_dec_ctl.scala 62:44]
  wire  _T_669 = io_ins[8] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_670 = _T_669 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_671 = _T_665 | _T_670; // @[el2_dec_dec_ctl.scala 62:67]
  wire  _T_675 = io_ins[9] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_676 = _T_675 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_677 = _T_671 | _T_676; // @[el2_dec_dec_ctl.scala 63:26]
  wire  _T_681 = io_ins[10] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_682 = _T_681 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_683 = _T_677 | _T_682; // @[el2_dec_dec_ctl.scala 63:49]
  wire  _T_687 = io_ins[11] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_688 = _T_687 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_696 = _T_93 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_697 = _T_696 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_698 = _T_697 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_705 = _T_78 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_706 = _T_705 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_707 = _T_706 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_708 = _T_698 | _T_707; // @[el2_dec_dec_ctl.scala 65:49]
  wire  _T_715 = _T_63 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_716 = _T_715 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_717 = _T_716 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_718 = _T_708 | _T_717; // @[el2_dec_dec_ctl.scala 65:79]
  wire  _T_724 = io_ins[18] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_725 = _T_724 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_726 = _T_725 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_727 = _T_718 | _T_726; // @[el2_dec_dec_ctl.scala 66:33]
  wire  _T_733 = io_ins[19] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_734 = _T_733 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_735 = _T_734 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_743 = _T_180 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_751 = _T_420 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_752 = _T_751 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_757 = io_ins[15] & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_758 = _T_757 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_759 = _T_758 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_760 = _T_752 | _T_759; // @[el2_dec_dec_ctl.scala 69:47]
  wire  _T_765 = io_ins[16] & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_766 = _T_765 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_767 = _T_766 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_768 = _T_760 | _T_767; // @[el2_dec_dec_ctl.scala 69:74]
  wire  _T_773 = io_ins[17] & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_774 = _T_773 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_775 = _T_774 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_776 = _T_768 | _T_775; // @[el2_dec_dec_ctl.scala 70:30]
  wire  _T_781 = io_ins[18] & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_782 = _T_781 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_783 = _T_782 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_784 = _T_776 | _T_783; // @[el2_dec_dec_ctl.scala 70:57]
  wire  _T_789 = io_ins[19] & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_790 = _T_789 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_791 = _T_790 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_798 = io_ins[15] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_799 = _T_798 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_800 = _T_799 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_806 = io_ins[16] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_807 = _T_806 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_808 = _T_807 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_809 = _T_800 | _T_808; // @[el2_dec_dec_ctl.scala 72:47]
  wire  _T_815 = io_ins[17] & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_816 = _T_815 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_817 = _T_816 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_818 = _T_809 | _T_817; // @[el2_dec_dec_ctl.scala 72:75]
  wire  _T_827 = _T_818 | _T_726; // @[el2_dec_dec_ctl.scala 73:31]
  wire  _T_838 = ~io_ins[22]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_852 = ~io_ins[21]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_854 = ~io_ins[20]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_886 = io_ins[25] & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_887 = _T_886 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_888 = _T_887 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_889 = _T_888 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_904 = _T_886 & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_905 = _T_904 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_906 = _T_905 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_907 = _T_906 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_908 = _T_907 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_909 = _T_908 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_922 = _T_886 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_923 = _T_922 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_924 = _T_923 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_925 = _T_924 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_926 = _T_925 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_958 = _T_922 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_959 = _T_958 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_960 = _T_959 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_970 = _T_560 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_971 = _T_970 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_982 = _T_560 & io_ins[13]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_983 = _T_982 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_984 = _T_983 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_989 = _T_9 & io_ins[3]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_994 = io_ins[12] & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_995 = _T_994 & io_ins[3]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1034 = _T_86 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1035 = _T_1034 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1036 = _T_989 | _T_1035; // @[el2_dec_dec_ctl.scala 89:41]
  wire  _T_1043 = _T_71 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1044 = _T_1043 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1045 = _T_1036 | _T_1044; // @[el2_dec_dec_ctl.scala 89:68]
  wire  _T_1052 = _T_56 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1053 = _T_1052 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1054 = _T_1045 | _T_1053; // @[el2_dec_dec_ctl.scala 90:30]
  wire  _T_1061 = _T_41 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1062 = _T_1061 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1063 = _T_1054 | _T_1062; // @[el2_dec_dec_ctl.scala 90:57]
  wire  _T_1070 = _T_26 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1071 = _T_1070 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1072 = _T_1063 | _T_1071; // @[el2_dec_dec_ctl.scala 91:31]
  wire  _T_1078 = _T_93 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1079 = _T_1078 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1080 = _T_1072 | _T_1079; // @[el2_dec_dec_ctl.scala 91:59]
  wire  _T_1086 = _T_78 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1087 = _T_1086 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1088 = _T_1080 | _T_1087; // @[el2_dec_dec_ctl.scala 92:30]
  wire  _T_1094 = _T_63 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1095 = _T_1094 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1096 = _T_1088 | _T_1095; // @[el2_dec_dec_ctl.scala 92:57]
  wire  _T_1102 = _T_48 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1103 = _T_1102 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1104 = _T_1096 | _T_1103; // @[el2_dec_dec_ctl.scala 93:30]
  wire  _T_1110 = _T_33 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1111 = _T_1110 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1127 = _T_838 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1128 = _T_1127 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1129 = _T_1128 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1130 = _T_1129 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1131 = _T_995 | _T_1130; // @[el2_dec_dec_ctl.scala 95:45]
  wire  _T_1140 = _T_1131 | _T_1035; // @[el2_dec_dec_ctl.scala 95:78]
  wire  _T_1149 = _T_1140 | _T_1044; // @[el2_dec_dec_ctl.scala 96:30]
  wire  _T_1158 = _T_1149 | _T_1053; // @[el2_dec_dec_ctl.scala 96:57]
  wire  _T_1167 = _T_1158 | _T_1062; // @[el2_dec_dec_ctl.scala 97:30]
  wire  _T_1176 = _T_1167 | _T_1071; // @[el2_dec_dec_ctl.scala 97:58]
  wire  _T_1184 = _T_1176 | _T_1079; // @[el2_dec_dec_ctl.scala 98:31]
  wire  _T_1192 = _T_1184 | _T_1087; // @[el2_dec_dec_ctl.scala 98:58]
  wire  _T_1200 = _T_1192 | _T_1095; // @[el2_dec_dec_ctl.scala 99:30]
  wire  _T_1208 = _T_1200 | _T_1103; // @[el2_dec_dec_ctl.scala 99:57]
  wire  _T_1218 = ~io_ins[31]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1224 = ~io_ins[27]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1226 = ~io_ins[26]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1230 = ~io_ins[24]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1232 = ~io_ins[23]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1239 = ~io_ins[19]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1241 = ~io_ins[18]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1243 = ~io_ins[17]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1245 = ~io_ins[16]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1247 = ~io_ins[15]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1251 = ~io_ins[11]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1253 = ~io_ins[10]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1255 = ~io_ins[9]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1257 = ~io_ins[8]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1259 = ~io_ins[7]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1269 = _T_1218 & _T_247; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1270 = _T_1269 & io_ins[29]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1271 = _T_1270 & io_ins[28]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1272 = _T_1271 & _T_1224; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1273 = _T_1272 & _T_1226; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1274 = _T_1273 & _T_4; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1275 = _T_1274 & _T_1230; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1276 = _T_1275 & _T_1232; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1277 = _T_1276 & _T_838; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1278 = _T_1277 & io_ins[21]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1279 = _T_1278 & _T_854; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1280 = _T_1279 & _T_1239; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1281 = _T_1280 & _T_1241; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1282 = _T_1281 & _T_1243; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1283 = _T_1282 & _T_1245; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1284 = _T_1283 & _T_1247; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1285 = _T_1284 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1286 = _T_1285 & _T_1251; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1287 = _T_1286 & _T_1253; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1288 = _T_1287 & _T_1255; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1289 = _T_1288 & _T_1257; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1290 = _T_1289 & _T_1259; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1291 = _T_1290 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1292 = _T_1291 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1293 = _T_1292 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1294 = _T_1293 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1295 = _T_1294 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1296 = _T_1295 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1297 = _T_1296 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1303 = ~io_ins[29]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1351 = _T_1269 & _T_1303; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1352 = _T_1351 & io_ins[28]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1353 = _T_1352 & _T_1224; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1354 = _T_1353 & _T_1226; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1355 = _T_1354 & _T_4; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1356 = _T_1355 & _T_1230; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1357 = _T_1356 & _T_1232; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1358 = _T_1357 & io_ins[22]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1359 = _T_1358 & _T_852; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1360 = _T_1359 & io_ins[20]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1361 = _T_1360 & _T_1239; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1362 = _T_1361 & _T_1241; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1363 = _T_1362 & _T_1243; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1364 = _T_1363 & _T_1245; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1365 = _T_1364 & _T_1247; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1366 = _T_1365 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1367 = _T_1366 & _T_1251; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1368 = _T_1367 & _T_1253; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1369 = _T_1368 & _T_1255; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1370 = _T_1369 & _T_1257; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1371 = _T_1370 & _T_1259; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1372 = _T_1371 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1373 = _T_1372 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1374 = _T_1373 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1375 = _T_1374 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1376 = _T_1375 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1377 = _T_1376 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1378 = _T_1377 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1379 = _T_1297 | _T_1378; // @[el2_dec_dec_ctl.scala 101:136]
  wire  _T_1387 = ~io_ins[28]; // @[el2_dec_dec_ctl.scala 15:46]
  wire  _T_1434 = _T_1351 & _T_1387; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1435 = _T_1434 & _T_1224; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1436 = _T_1435 & _T_1226; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1437 = _T_1436 & _T_4; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1438 = _T_1437 & _T_1230; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1439 = _T_1438 & _T_1232; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1440 = _T_1439 & _T_838; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1441 = _T_1440 & _T_852; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1442 = _T_1441 & _T_1239; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1443 = _T_1442 & _T_1241; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1444 = _T_1443 & _T_1243; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1445 = _T_1444 & _T_1245; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1446 = _T_1445 & _T_1247; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1447 = _T_1446 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1448 = _T_1447 & _T_1251; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1449 = _T_1448 & _T_1253; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1450 = _T_1449 & _T_1255; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1451 = _T_1450 & _T_1257; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1452 = _T_1451 & _T_1259; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1453 = _T_1452 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1454 = _T_1453 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1455 = _T_1454 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1456 = _T_1455 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1457 = _T_1456 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1458 = _T_1457 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1459 = _T_1379 | _T_1458; // @[el2_dec_dec_ctl.scala 102:122]
  wire  _T_1487 = _T_1437 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1488 = _T_1487 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1489 = _T_1488 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1490 = _T_1489 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1491 = _T_1490 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1492 = _T_1459 | _T_1491; // @[el2_dec_dec_ctl.scala 103:119]
  wire  _T_1519 = _T_1218 & _T_1303; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1520 = _T_1519 & _T_1387; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1521 = _T_1520 & _T_1224; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1522 = _T_1521 & _T_1226; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1523 = _T_1522 & _T_4; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1524 = _T_1523 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1525 = _T_1524 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1526 = _T_1525 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1527 = _T_1526 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1528 = _T_1527 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1529 = _T_1528 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1530 = _T_1529 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1531 = _T_1530 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1532 = _T_1492 | _T_1531; // @[el2_dec_dec_ctl.scala 104:60]
  wire  _T_1561 = _T_1523 & io_ins[14]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1562 = _T_1561 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1563 = _T_1562 & io_ins[12]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1564 = _T_1563 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1565 = _T_1564 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1566 = _T_1565 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1567 = _T_1566 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1568 = _T_1567 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1569 = _T_1532 | _T_1568; // @[el2_dec_dec_ctl.scala 105:69]
  wire  _T_1595 = _T_1436 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1596 = _T_1595 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1597 = _T_1596 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1598 = _T_1597 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1599 = _T_1598 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1600 = _T_1599 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1601 = _T_1569 | _T_1600; // @[el2_dec_dec_ctl.scala 106:66]
  wire  _T_1618 = _T_235 & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1619 = _T_1618 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1620 = _T_1619 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1621 = _T_1620 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1622 = _T_1621 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1623 = _T_1622 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1624 = _T_1601 | _T_1623; // @[el2_dec_dec_ctl.scala 107:58]
  wire  _T_1636 = io_ins[14] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1637 = _T_1636 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1638 = _T_1637 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1639 = _T_1638 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1640 = _T_1639 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1641 = _T_1640 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1642 = _T_1641 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1643 = _T_1624 | _T_1642; // @[el2_dec_dec_ctl.scala 108:46]
  wire  _T_1655 = _T_143 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1656 = _T_1655 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1657 = _T_1656 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1658 = _T_1657 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1659 = _T_1658 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1660 = _T_1659 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1661 = _T_1643 | _T_1660; // @[el2_dec_dec_ctl.scala 109:40]
  wire  _T_1676 = _T_19 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1677 = _T_1676 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1678 = _T_1677 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1679 = _T_1678 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1680 = _T_1679 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1681 = _T_1680 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1682 = _T_1661 | _T_1681; // @[el2_dec_dec_ctl.scala 110:39]
  wire  _T_1693 = io_ins[12] & io_ins[6]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1694 = _T_1693 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1695 = _T_1694 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1696 = _T_1695 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1697 = _T_1696 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1698 = _T_1697 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1699 = _T_1698 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1700 = _T_1682 | _T_1699; // @[el2_dec_dec_ctl.scala 111:43]
  wire  _T_1769 = _T_1441 & _T_854; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1770 = _T_1769 & _T_1239; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1771 = _T_1770 & _T_1241; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1772 = _T_1771 & _T_1243; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1773 = _T_1772 & _T_1245; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1774 = _T_1773 & _T_1247; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1775 = _T_1774 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1776 = _T_1775 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1777 = _T_1776 & _T_1251; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1778 = _T_1777 & _T_1253; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1779 = _T_1778 & _T_1255; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1780 = _T_1779 & _T_1257; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1781 = _T_1780 & _T_1259; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1782 = _T_1781 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1783 = _T_1782 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1784 = _T_1783 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1785 = _T_1784 & io_ins[3]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1786 = _T_1785 & io_ins[2]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1787 = _T_1786 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1788 = _T_1787 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1789 = _T_1700 | _T_1788; // @[el2_dec_dec_ctl.scala 112:39]
  wire  _T_1837 = _T_1434 & _T_1239; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1838 = _T_1837 & _T_1241; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1839 = _T_1838 & _T_1243; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1840 = _T_1839 & _T_1245; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1841 = _T_1840 & _T_1247; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1842 = _T_1841 & _T_14; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1843 = _T_1842 & _T_16; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1844 = _T_1843 & _T_143; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1845 = _T_1844 & _T_1251; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1846 = _T_1845 & _T_1253; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1847 = _T_1846 & _T_1255; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1848 = _T_1847 & _T_1257; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1849 = _T_1848 & _T_1259; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1850 = _T_1849 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1851 = _T_1850 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1852 = _T_1851 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1853 = _T_1852 & io_ins[3]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1854 = _T_1853 & io_ins[2]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1855 = _T_1854 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1856 = _T_1855 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1857 = _T_1789 | _T_1856; // @[el2_dec_dec_ctl.scala 113:130]
  wire  _T_1869 = _T_524 & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1870 = _T_1869 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1871 = _T_1870 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1872 = _T_1871 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1873 = _T_1872 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1874 = _T_1873 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1875 = _T_1857 | _T_1874; // @[el2_dec_dec_ctl.scala 114:102]
  wire  _T_1890 = _T_16 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1891 = _T_1890 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1892 = _T_1891 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1893 = _T_1892 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1894 = _T_1893 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1895 = _T_1894 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1896 = _T_1895 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1897 = _T_1875 | _T_1896; // @[el2_dec_dec_ctl.scala 115:39]
  wire  _T_1906 = io_ins[6] & io_ins[5]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1907 = _T_1906 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1908 = _T_1907 & io_ins[3]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1909 = _T_1908 & io_ins[2]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1910 = _T_1909 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1911 = _T_1910 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1912 = _T_1897 | _T_1911; // @[el2_dec_dec_ctl.scala 116:43]
  wire  _T_1924 = _T_653 & _T_9; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1925 = _T_1924 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1926 = _T_1925 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1927 = _T_1926 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1928 = _T_1927 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1929 = _T_1912 | _T_1928; // @[el2_dec_dec_ctl.scala 117:35]
  wire  _T_1945 = _T_582 & _T_103; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1946 = _T_1945 & _T_97; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1947 = _T_1946 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1948 = _T_1947 & _T_18; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1949 = _T_1948 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1950 = _T_1949 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1951 = _T_1929 | _T_1950; // @[el2_dec_dec_ctl.scala 118:38]
  wire  _T_1960 = _T_103 & io_ins[4]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1961 = _T_1960 & _T_99; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1962 = _T_1961 & io_ins[2]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1963 = _T_1962 & io_ins[1]; // @[el2_dec_dec_ctl.scala 17:17]
  wire  _T_1964 = _T_1963 & io_ins[0]; // @[el2_dec_dec_ctl.scala 17:17]
  assign io_out_alu = _T_7 | _T_11; // @[el2_dec_dec_ctl.scala 20:14]
  assign io_out_rs1 = _T_101 | _T_106; // @[el2_dec_dec_ctl.scala 21:14]
  assign io_out_rs2 = _T_114 | _T_121; // @[el2_dec_dec_ctl.scala 27:14]
  assign io_out_imm12 = _T_149 | _T_159; // @[el2_dec_dec_ctl.scala 28:16]
  assign io_out_rd = _T_169 | io_ins[4]; // @[el2_dec_dec_ctl.scala 30:13]
  assign io_out_shimm5 = _T_182 & _T_18; // @[el2_dec_dec_ctl.scala 31:17]
  assign io_out_imm20 = _T_186 | _T_189; // @[el2_dec_dec_ctl.scala 32:16]
  assign io_out_pc = _T_197 | _T_186; // @[el2_dec_dec_ctl.scala 33:13]
  assign io_out_load = _T_208 & _T_18; // @[el2_dec_dec_ctl.scala 34:15]
  assign io_out_store = _T_120 & _T_97; // @[el2_dec_dec_ctl.scala 35:16]
  assign io_out_lsu = _T_223 & _T_18; // @[el2_dec_dec_ctl.scala 36:14]
  assign io_out_add = _T_245 | _T_267; // @[el2_dec_dec_ctl.scala 37:14]
  assign io_out_sub = _T_311 | _T_318; // @[el2_dec_dec_ctl.scala 39:14]
  assign io_out_land = _T_330 | _T_344; // @[el2_dec_dec_ctl.scala 41:15]
  assign io_out_lor = _T_381 | _T_393; // @[el2_dec_dec_ctl.scala 42:14]
  assign io_out_lxor = _T_409 | _T_424; // @[el2_dec_dec_ctl.scala 45:15]
  assign io_out_sll = _T_442 & _T_18; // @[el2_dec_dec_ctl.scala 46:14]
  assign io_out_sra = _T_456 & _T_18; // @[el2_dec_dec_ctl.scala 47:14]
  assign io_out_srl = _T_476 & _T_18; // @[el2_dec_dec_ctl.scala 48:14]
  assign io_out_slt = _T_297 | _T_310; // @[el2_dec_dec_ctl.scala 49:14]
  assign io_out_unsign = _T_551 | _T_564; // @[el2_dec_dec_ctl.scala 50:17]
  assign io_out_condbr = _T_317 & _T_18; // @[el2_dec_dec_ctl.scala 53:17]
  assign io_out_beq = _T_584 & _T_18; // @[el2_dec_dec_ctl.scala 54:14]
  assign io_out_bne = _T_596 & _T_18; // @[el2_dec_dec_ctl.scala 55:14]
  assign io_out_bge = _T_607 & _T_18; // @[el2_dec_dec_ctl.scala 56:14]
  assign io_out_blt = _T_619 & _T_18; // @[el2_dec_dec_ctl.scala 57:14]
  assign io_out_jal = io_ins[6] & io_ins[2]; // @[el2_dec_dec_ctl.scala 58:14]
  assign io_out_by = _T_636 & _T_18; // @[el2_dec_dec_ctl.scala 59:13]
  assign io_out_half = _T_646 & _T_18; // @[el2_dec_dec_ctl.scala 60:15]
  assign io_out_word = _T_653 & _T_97; // @[el2_dec_dec_ctl.scala 61:15]
  assign io_out_csr_read = _T_683 | _T_688; // @[el2_dec_dec_ctl.scala 62:19]
  assign io_out_csr_clr = _T_727 | _T_735; // @[el2_dec_dec_ctl.scala 65:18]
  assign io_out_csr_set = _T_827 | _T_735; // @[el2_dec_dec_ctl.scala 72:18]
  assign io_out_csr_write = _T_743 & io_ins[4]; // @[el2_dec_dec_ctl.scala 68:20]
  assign io_out_csr_imm = _T_784 | _T_791; // @[el2_dec_dec_ctl.scala 69:18]
  assign io_out_presync = _T_1104 | _T_1111; // @[el2_dec_dec_ctl.scala 89:18]
  assign io_out_postsync = _T_1208 | _T_1111; // @[el2_dec_dec_ctl.scala 95:19]
  assign io_out_mul = _T_889 & _T_18; // @[el2_dec_dec_ctl.scala 78:14]
  assign io_out_rs1_sign = _T_909 | _T_926; // @[el2_dec_dec_ctl.scala 79:19]
  assign io_out_rs2_sign = _T_925 & _T_18; // @[el2_dec_dec_ctl.scala 81:19]
  assign io_out_low = _T_960 & _T_18; // @[el2_dec_dec_ctl.scala 82:14]
  assign io_out_div = _T_971 & _T_18; // @[el2_dec_dec_ctl.scala 83:14]
  assign io_out_rem = _T_984 & _T_18; // @[el2_dec_dec_ctl.scala 84:14]
  assign io_out_fence = _T_9 & io_ins[3]; // @[el2_dec_dec_ctl.scala 85:16]
  assign io_out_legal = _T_1951 | _T_1964; // @[el2_dec_dec_ctl.scala 101:16]
endmodule
module el2_dec_decode_ctl(
  input         clock,
  input         reset,
  output        io_dec_extint_stall,
  input         io_lsu_nonblock_load_valid_m,
  input  [2:0]  io_lsu_nonblock_load_tag_m,
  input         io_lsu_nonblock_load_inv_r,
  input  [2:0]  io_lsu_nonblock_load_inv_tag_r,
  input         io_lsu_nonblock_load_data_valid,
  input         io_lsu_nonblock_load_data_error,
  input  [2:0]  io_lsu_nonblock_load_data_tag,
  input  [31:0] io_lsu_nonblock_load_data,
  input         io_dec_debug_fence_d,
  input  [1:0]  io_dbg_cmd_wrdata,
  input         io_dec_i0_icaf_d,
  input         io_dec_i0_dbecc_d,
  input         io_dec_i0_brp_valid,
  input  [11:0] io_dec_i0_brp_toffset,
  input  [1:0]  io_dec_i0_brp_hist,
  input         io_dec_i0_brp_br_error,
  input         io_dec_i0_brp_br_start_error,
  input  [30:0] io_dec_i0_brp_prett,
  input         io_dec_i0_brp_way,
  input         io_dec_i0_brp_ret,
  input  [7:0]  io_dec_i0_bp_index,
  input  [7:0]  io_dec_i0_bp_fghr,
  input  [4:0]  io_dec_i0_bp_btag,
  input         io_lsu_idle_any,
  input         io_lsu_load_stall_any,
  input         io_lsu_store_stall_any,
  input         io_dma_dccm_stall_any,
  input         io_exu_div_wren,
  input         io_dec_i0_pc4_d,
  input  [31:0] io_lsu_result_m,
  input  [31:0] io_lsu_result_corr_r,
  input         io_exu_flush_final,
  input  [30:0] io_exu_i0_pc_x,
  input  [31:0] io_dec_i0_instr_d,
  input         io_dec_ib0_valid_d,
  input  [31:0] io_exu_i0_result_x,
  input         io_free_clk,
  input         io_active_clk,
  output        io_dec_i0_rs1_en_d,
  output        io_dec_i0_rs2_en_d,
  output [4:0]  io_dec_i0_rs1_d,
  output [4:0]  io_dec_i0_rs2_d,
  output [31:0] io_dec_i0_immed_d,
  output [11:0] io_dec_i0_br_immed_d,
  output        io_i0_ap_land,
  output        io_i0_ap_lor,
  output        io_i0_ap_lxor,
  output        io_i0_ap_sll,
  output        io_i0_ap_srl,
  output        io_i0_ap_sra,
  output        io_i0_ap_beq,
  output        io_i0_ap_bne,
  output        io_i0_ap_blt,
  output        io_i0_ap_bge,
  output        io_i0_ap_add,
  output        io_i0_ap_sub,
  output        io_i0_ap_slt,
  output        io_i0_ap_unsign,
  output        io_i0_ap_jal,
  output        io_i0_ap_predict_t,
  output        io_i0_ap_predict_nt,
  output        io_i0_ap_csr_write,
  output        io_i0_ap_csr_imm,
  output        io_dec_i0_decode_d,
  output        io_dec_i0_alu_decode_d,
  output [31:0] io_dec_i0_rs1_bypass_data_d,
  output [31:0] io_dec_i0_rs2_bypass_data_d,
  output [4:0]  io_dec_i0_waddr_r,
  output        io_dec_i0_wen_r,
  output [31:0] io_dec_i0_wdata_r,
  output        io_dec_i0_select_pc_d,
  output [1:0]  io_dec_i0_rs1_bypass_en_d,
  output [1:0]  io_dec_i0_rs2_bypass_en_d,
  output        io_lsu_p_fast_int,
  output        io_lsu_p_by,
  output        io_lsu_p_half,
  output        io_lsu_p_word,
  output        io_lsu_p_load,
  output        io_lsu_p_store,
  output        io_lsu_p_unsign,
  output        io_lsu_p_store_data_bypass_d,
  output        io_lsu_p_load_ldst_bypass_d,
  output        io_lsu_p_valid,
  output        io_mul_p_valid,
  output        io_mul_p_rs1_sign,
  output        io_mul_p_rs2_sign,
  output        io_mul_p_low,
  output        io_div_p_valid,
  output        io_div_p_unsign,
  output        io_div_p_rem,
  output [4:0]  io_div_waddr_wb,
  output        io_dec_div_cancel,
  output        io_dec_lsu_valid_raw_d,
  output [11:0] io_dec_lsu_offset_d,
  output        io_dec_csr_ren_d,
  output [30:0] io_pred_correct_npc_x,
  output        io_dec_i0_predict_p_d_pc4,
  output [1:0]  io_dec_i0_predict_p_d_hist,
  output [11:0] io_dec_i0_predict_p_d_toffset,
  output        io_dec_i0_predict_p_d_valid,
  output        io_dec_i0_predict_p_d_br_error,
  output        io_dec_i0_predict_p_d_br_start_error,
  output [30:0] io_dec_i0_predict_p_d_prett,
  output        io_dec_i0_predict_p_d_pcall,
  output        io_dec_i0_predict_p_d_pret,
  output        io_dec_i0_predict_p_d_pja,
  output        io_dec_i0_predict_p_d_way,
  output [7:0]  io_i0_predict_fghr_d,
  output [7:0]  io_i0_predict_index_d,
  output [4:0]  io_i0_predict_btag_d,
  output [1:0]  io_dec_data_en,
  output [1:0]  io_dec_ctl_en,
  output        io_dec_nonblock_load_wen,
  output [4:0]  io_dec_nonblock_load_waddr,
  output        io_dec_div_active,
  input         io_scan_mode
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
  wire  data_gated_cgc_io_l1clk; // @[el2_dec_decode_ctl.scala 221:29]
  wire  data_gated_cgc_io_clk; // @[el2_dec_decode_ctl.scala 221:29]
  wire  data_gated_cgc_io_en; // @[el2_dec_decode_ctl.scala 221:29]
  wire  data_gated_cgc_io_scan_mode; // @[el2_dec_decode_ctl.scala 221:29]
  wire [31:0] i0_dec_io_ins; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_alu; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_rs1; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_rs2; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_imm12; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_rd; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_shimm5; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_imm20; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_pc; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_load; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_store; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_lsu; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_add; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_sub; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_land; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_lor; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_lxor; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_sll; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_sra; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_srl; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_slt; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_unsign; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_condbr; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_beq; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_bne; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_bge; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_blt; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_jal; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_by; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_half; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_word; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_csr_read; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_csr_clr; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_csr_set; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_csr_write; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_csr_imm; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_presync; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_postsync; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_mul; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_rs1_sign; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_rs2_sign; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_low; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_div; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_rem; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_fence; // @[el2_dec_decode_ctl.scala 396:24]
  wire  i0_dec_io_out_legal; // @[el2_dec_decode_ctl.scala 396:24]
  wire  rvclkhdr_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_4_io_l1clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_4_io_clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_4_io_en; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_4_io_scan_mode; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_5_io_l1clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_5_io_clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_5_io_en; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_5_io_scan_mode; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_6_io_l1clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_6_io_clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_6_io_en; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_6_io_scan_mode; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_7_io_l1clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_7_io_clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_7_io_en; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_7_io_scan_mode; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_8_io_l1clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_8_io_clk; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_8_io_en; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_8_io_scan_mode; // @[beh_lib.scala 360:21]
  wire  rvclkhdr_9_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  i0_dp_raw_condbr = i0_dec_io_out_condbr; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_jal = i0_dec_io_out_jal; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire [20:0] i0_pcall_imm = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[19:12],io_dec_i0_instr_d[20],io_dec_i0_instr_d[30:21],1'h0}; // @[Cat.scala 29:58]
  wire  _T_298 = i0_pcall_imm[20:13] == 8'hff; // @[el2_dec_decode_ctl.scala 412:79]
  wire  _T_300 = i0_pcall_imm[20:13] == 8'h0; // @[el2_dec_decode_ctl.scala 412:112]
  wire  i0_pcall_12b_offset = i0_pcall_imm[12] ? _T_298 : _T_300; // @[el2_dec_decode_ctl.scala 412:33]
  wire  i0_dp_raw_imm20 = i0_dec_io_out_imm20; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  _T_301 = i0_pcall_12b_offset & i0_dp_raw_imm20; // @[el2_dec_decode_ctl.scala 413:47]
  wire [4:0] i0r_rd = io_dec_i0_instr_d[11:7]; // @[el2_dec_decode_ctl.scala 626:16]
  wire  _T_302 = i0r_rd == 5'h1; // @[el2_dec_decode_ctl.scala 413:76]
  wire  _T_303 = i0r_rd == 5'h5; // @[el2_dec_decode_ctl.scala 413:98]
  wire  _T_304 = _T_302 | _T_303; // @[el2_dec_decode_ctl.scala 413:89]
  wire  i0_pcall_case = _T_301 & _T_304; // @[el2_dec_decode_ctl.scala 413:65]
  wire  i0_pcall_raw = i0_dp_raw_jal & i0_pcall_case; // @[el2_dec_decode_ctl.scala 415:38]
  wire  _T_19 = i0_dp_raw_condbr | i0_pcall_raw; // @[el2_dec_decode_ctl.scala 240:75]
  wire  _T_309 = ~_T_304; // @[el2_dec_decode_ctl.scala 414:67]
  wire  i0_pja_case = _T_301 & _T_309; // @[el2_dec_decode_ctl.scala 414:65]
  wire  i0_pja_raw = i0_dp_raw_jal & i0_pja_case; // @[el2_dec_decode_ctl.scala 417:38]
  wire  _T_20 = _T_19 | i0_pja_raw; // @[el2_dec_decode_ctl.scala 240:90]
  wire  i0_dp_raw_imm12 = i0_dec_io_out_imm12; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  _T_325 = i0_dp_raw_jal & i0_dp_raw_imm12; // @[el2_dec_decode_ctl.scala 421:37]
  wire  _T_326 = i0r_rd == 5'h0; // @[el2_dec_decode_ctl.scala 421:65]
  wire  _T_327 = _T_325 & _T_326; // @[el2_dec_decode_ctl.scala 421:55]
  wire [4:0] i0r_rs1 = io_dec_i0_instr_d[19:15]; // @[el2_dec_decode_ctl.scala 624:16]
  wire  _T_328 = i0r_rs1 == 5'h1; // @[el2_dec_decode_ctl.scala 421:89]
  wire  _T_329 = i0r_rs1 == 5'h5; // @[el2_dec_decode_ctl.scala 421:111]
  wire  _T_330 = _T_328 | _T_329; // @[el2_dec_decode_ctl.scala 421:101]
  wire  i0_pret_case = _T_327 & _T_330; // @[el2_dec_decode_ctl.scala 421:79]
  wire  i0_pret_raw = i0_dp_raw_jal & i0_pret_case; // @[el2_dec_decode_ctl.scala 422:32]
  wire  _T_21 = _T_20 | i0_pret_raw; // @[el2_dec_decode_ctl.scala 240:103]
  wire  _T_22 = ~_T_21; // @[el2_dec_decode_ctl.scala 240:56]
  wire  i0_notbr_error = io_dec_i0_brp_valid & _T_22; // @[el2_dec_decode_ctl.scala 240:54]
  wire  _T_30 = io_dec_i0_brp_br_error | i0_notbr_error; // @[el2_dec_decode_ctl.scala 245:57]
  wire  _T_24 = io_dec_i0_brp_valid & io_dec_i0_brp_hist[1]; // @[el2_dec_decode_ctl.scala 243:47]
  wire  _T_314 = i0_pcall_raw | i0_pja_raw; // @[el2_dec_decode_ctl.scala 419:41]
  wire [11:0] _T_323 = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[7],io_dec_i0_instr_d[30:25],io_dec_i0_instr_d[11:8]}; // @[Cat.scala 29:58]
  wire [11:0] i0_br_offset = _T_314 ? i0_pcall_imm[12:1] : _T_323; // @[el2_dec_decode_ctl.scala 419:26]
  wire  _T_25 = io_dec_i0_brp_toffset != i0_br_offset; // @[el2_dec_decode_ctl.scala 243:96]
  wire  _T_26 = _T_24 & _T_25; // @[el2_dec_decode_ctl.scala 243:71]
  wire  _T_27 = ~i0_pret_raw; // @[el2_dec_decode_ctl.scala 243:116]
  wire  i0_br_toffset_error = _T_26 & _T_27; // @[el2_dec_decode_ctl.scala 243:114]
  wire  _T_31 = _T_30 | i0_br_toffset_error; // @[el2_dec_decode_ctl.scala 245:74]
  wire  _T_28 = io_dec_i0_brp_valid & io_dec_i0_brp_ret; // @[el2_dec_decode_ctl.scala 244:47]
  wire  i0_ret_error = _T_28 & _T_27; // @[el2_dec_decode_ctl.scala 244:67]
  wire  i0_br_error = _T_31 | i0_ret_error; // @[el2_dec_decode_ctl.scala 245:96]
  wire  i0_br_error_all = i0_br_error | io_dec_i0_brp_br_start_error; // @[el2_dec_decode_ctl.scala 250:47]
  wire  i0_icaf_d = io_dec_i0_icaf_d | io_dec_i0_dbecc_d; // @[el2_dec_decode_ctl.scala 259:36]
  wire  _T_40 = i0_br_error_all | i0_icaf_d; // @[el2_dec_decode_ctl.scala 263:25]
  wire  i0_dp_raw_postsync = i0_dec_io_out_postsync; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_postsync = _T_40 | i0_dp_raw_postsync; // @[el2_dec_decode_ctl.scala 263:50]
  wire  debug_fence_i = io_dec_debug_fence_d & io_dbg_cmd_wrdata[0]; // @[el2_dec_decode_ctl.scala 522:48]
  wire  _T_440 = i0_dp_postsync | debug_fence_i; // @[el2_dec_decode_ctl.scala 530:60]
  wire  i0_dp_raw_csr_write = i0_dec_io_out_csr_write; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_csr_write = _T_40 ? 1'h0 : i0_dp_raw_csr_write; // @[el2_dec_decode_ctl.scala 263:50]
  wire  _T_343 = ~io_dec_debug_fence_d; // @[el2_dec_decode_ctl.scala 461:42]
  wire  i0_csr_write = i0_dp_csr_write & _T_343; // @[el2_dec_decode_ctl.scala 461:40]
  wire  i0_dp_raw_csr_read = i0_dec_io_out_csr_read; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_csr_read = _T_40 ? 1'h0 : i0_dp_raw_csr_read; // @[el2_dec_decode_ctl.scala 263:50]
  wire  _T_347 = ~i0_dp_csr_read; // @[el2_dec_decode_ctl.scala 466:41]
  wire  i0_csr_write_only_d = i0_csr_write & _T_347; // @[el2_dec_decode_ctl.scala 466:39]
  wire  _T_442 = io_dec_i0_instr_d[31:20] == 12'h7c2; // @[el2_dec_decode_ctl.scala 530:112]
  wire  _T_443 = i0_csr_write_only_d & _T_442; // @[el2_dec_decode_ctl.scala 530:99]
  wire  i0_postsync = _T_440 | _T_443; // @[el2_dec_decode_ctl.scala 530:76]
  wire  i0_dp_raw_legal = i0_dec_io_out_legal; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_legal = _T_40 | i0_dp_raw_legal; // @[el2_dec_decode_ctl.scala 263:50]
  wire  any_csr_d = i0_dp_csr_read | i0_csr_write; // @[el2_dec_decode_ctl.scala 532:34]
  wire  _T_444 = ~any_csr_d; // @[el2_dec_decode_ctl.scala 534:40]
  wire  i0_legal = i0_dp_legal & _T_444; // @[el2_dec_decode_ctl.scala 534:37]
  wire  _T_504 = ~i0_legal; // @[el2_dec_decode_ctl.scala 574:56]
  wire  _T_505 = i0_postsync | _T_504; // @[el2_dec_decode_ctl.scala 574:54]
  wire  _T_506 = io_dec_i0_decode_d & _T_505; // @[el2_dec_decode_ctl.scala 574:39]
  reg  postsync_stall; // @[el2_dec_decode_ctl.scala 572:53]
  reg  x_d_i0valid; // @[beh_lib.scala 366:14]
  wire  _T_507 = postsync_stall & x_d_i0valid; // @[el2_dec_decode_ctl.scala 574:88]
  wire  ps_stall_in = _T_506 | _T_507; // @[el2_dec_decode_ctl.scala 574:69]
  wire  _T_12 = ps_stall_in ^ postsync_stall; // @[el2_dec_decode_ctl.scala 217:50]
  wire  _T_13 = io_dec_extint_stall | _T_12; // @[el2_dec_decode_ctl.scala 216:74]
  reg  flush_final_r; // @[el2_dec_decode_ctl.scala 620:52]
  wire  _T_14 = io_exu_flush_final ^ flush_final_r; // @[el2_dec_decode_ctl.scala 218:50]
  wire  _T_15 = _T_13 | _T_14; // @[el2_dec_decode_ctl.scala 217:74]
  wire  shift_illegal = io_dec_i0_decode_d & _T_504; // @[el2_dec_decode_ctl.scala 538:47]
  reg  illegal_lockout; // @[el2_dec_decode_ctl.scala 542:54]
  wire  _T_466 = shift_illegal | illegal_lockout; // @[el2_dec_decode_ctl.scala 541:40]
  wire  _T_467 = ~flush_final_r; // @[el2_dec_decode_ctl.scala 541:61]
  wire  illegal_lockout_in = _T_466 & _T_467; // @[el2_dec_decode_ctl.scala 541:59]
  wire  _T_16 = illegal_lockout_in ^ illegal_lockout; // @[el2_dec_decode_ctl.scala 219:50]
  wire  i0_legal_decode_d = io_dec_i0_decode_d & i0_legal; // @[el2_dec_decode_ctl.scala 648:46]
  wire  i0_dp_raw_fence = i0_dec_io_out_fence; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_fence = _T_40 ? 1'h0 : i0_dp_raw_fence; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_rem = i0_dec_io_out_rem; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_div = i0_dec_io_out_div; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_div = _T_40 ? 1'h0 : i0_dp_raw_div; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_low = i0_dec_io_out_low; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_rs2_sign = i0_dec_io_out_rs2_sign; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_rs1_sign = i0_dec_io_out_rs1_sign; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_mul = i0_dec_io_out_mul; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_mul = _T_40 ? 1'h0 : i0_dp_raw_mul; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_presync = i0_dec_io_out_presync; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_presync = _T_40 ? 1'h0 : i0_dp_raw_presync; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_csr_imm = i0_dec_io_out_csr_imm; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_csr_imm = _T_40 ? 1'h0 : i0_dp_raw_csr_imm; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_csr_set = i0_dec_io_out_csr_set; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_csr_set = _T_40 ? 1'h0 : i0_dp_raw_csr_set; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_csr_clr = i0_dec_io_out_csr_clr; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_csr_clr = _T_40 ? 1'h0 : i0_dp_raw_csr_clr; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_word = i0_dec_io_out_word; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_word = _T_40 ? 1'h0 : i0_dp_raw_word; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_half = i0_dec_io_out_half; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_half = _T_40 ? 1'h0 : i0_dp_raw_half; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_by = i0_dec_io_out_by; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_by = _T_40 ? 1'h0 : i0_dp_raw_by; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_jal = _T_40 ? 1'h0 : i0_dp_raw_jal; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_blt = i0_dec_io_out_blt; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_bge = i0_dec_io_out_bge; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_bne = i0_dec_io_out_bne; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_beq = i0_dec_io_out_beq; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_condbr = _T_40 ? 1'h0 : i0_dp_raw_condbr; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_unsign = i0_dec_io_out_unsign; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_unsign = _T_40 ? 1'h0 : i0_dp_raw_unsign; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_slt = i0_dec_io_out_slt; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_srl = i0_dec_io_out_srl; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_sra = i0_dec_io_out_sra; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_sll = i0_dec_io_out_sll; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_lxor = i0_dec_io_out_lxor; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_lor = i0_dec_io_out_lor; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_land = i0_dec_io_out_land; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_sub = i0_dec_io_out_sub; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_add = i0_dec_io_out_add; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_raw_lsu = i0_dec_io_out_lsu; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_lsu = _T_40 ? 1'h0 : i0_dp_raw_lsu; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_store = i0_dec_io_out_store; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_store = _T_40 ? 1'h0 : i0_dp_raw_store; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_load = i0_dec_io_out_load; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_load = _T_40 ? 1'h0 : i0_dp_raw_load; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_pc = i0_dec_io_out_pc; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_imm20 = _T_40 ? 1'h0 : i0_dp_raw_imm20; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_shimm5 = i0_dec_io_out_shimm5; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_shimm5 = _T_40 ? 1'h0 : i0_dp_raw_shimm5; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_rd = i0_dec_io_out_rd; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_rd = _T_40 ? 1'h0 : i0_dp_raw_rd; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_imm12 = _T_40 ? 1'h0 : i0_dp_raw_imm12; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_rs2 = i0_dec_io_out_rs2; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_rs2 = _T_40 | i0_dp_raw_rs2; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_rs1 = i0_dec_io_out_rs1; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_rs1 = _T_40 | i0_dp_raw_rs1; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_dp_raw_alu = i0_dec_io_out_alu; // @[el2_dec_decode_ctl.scala 156:22 el2_dec_decode_ctl.scala 398:14]
  wire  i0_dp_alu = _T_40 | i0_dp_raw_alu; // @[el2_dec_decode_ctl.scala 263:50]
  wire  i0_pcall = i0_dp_jal & i0_pcall_case; // @[el2_dec_decode_ctl.scala 416:38]
  wire  _T_43 = i0_dp_condbr | i0_pcall; // @[el2_dec_decode_ctl.scala 277:38]
  wire  i0_pja = i0_dp_jal & i0_pja_case; // @[el2_dec_decode_ctl.scala 418:38]
  wire  _T_44 = _T_43 | i0_pja; // @[el2_dec_decode_ctl.scala 277:49]
  wire  i0_pret = i0_dp_jal & i0_pret_case; // @[el2_dec_decode_ctl.scala 423:32]
  wire  i0_predict_br = _T_44 | i0_pret; // @[el2_dec_decode_ctl.scala 277:58]
  wire  _T_46 = io_dec_i0_brp_hist[1] & io_dec_i0_brp_valid; // @[el2_dec_decode_ctl.scala 279:50]
  wire  _T_47 = ~_T_46; // @[el2_dec_decode_ctl.scala 279:26]
  wire  i0_ap_pc2 = ~io_dec_i0_pc4_d; // @[el2_dec_decode_ctl.scala 281:20]
  wire  cam_data_reset = io_lsu_nonblock_load_data_valid | io_lsu_nonblock_load_data_error; // @[el2_dec_decode_ctl.scala 314:63]
  reg [2:0] cam_raw_0_tag; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_93 = io_lsu_nonblock_load_data_tag == cam_raw_0_tag; // @[el2_dec_decode_ctl.scala 325:67]
  wire  _T_94 = cam_data_reset & _T_93; // @[el2_dec_decode_ctl.scala 325:45]
  reg  cam_raw_0_valid; // @[el2_dec_decode_ctl.scala 350:47]
  wire  cam_data_reset_val_0 = _T_94 & cam_raw_0_valid; // @[el2_dec_decode_ctl.scala 325:83]
  wire  cam_0_valid = cam_data_reset_val_0 ? 1'h0 : cam_raw_0_valid; // @[el2_dec_decode_ctl.scala 329:39]
  wire  _T_50 = ~cam_0_valid; // @[el2_dec_decode_ctl.scala 306:79]
  reg [2:0] cam_raw_1_tag; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_119 = io_lsu_nonblock_load_data_tag == cam_raw_1_tag; // @[el2_dec_decode_ctl.scala 325:67]
  wire  _T_120 = cam_data_reset & _T_119; // @[el2_dec_decode_ctl.scala 325:45]
  reg  cam_raw_1_valid; // @[el2_dec_decode_ctl.scala 350:47]
  wire  cam_data_reset_val_1 = _T_120 & cam_raw_1_valid; // @[el2_dec_decode_ctl.scala 325:83]
  wire  cam_1_valid = cam_data_reset_val_1 ? 1'h0 : cam_raw_1_valid; // @[el2_dec_decode_ctl.scala 329:39]
  wire  _T_53 = ~cam_1_valid; // @[el2_dec_decode_ctl.scala 306:79]
  wire  _T_56 = cam_0_valid & _T_53; // @[el2_dec_decode_ctl.scala 306:127]
  wire [1:0] _T_58 = {io_lsu_nonblock_load_valid_m, 1'h0}; // @[el2_dec_decode_ctl.scala 306:159]
  reg [2:0] cam_raw_2_tag; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_145 = io_lsu_nonblock_load_data_tag == cam_raw_2_tag; // @[el2_dec_decode_ctl.scala 325:67]
  wire  _T_146 = cam_data_reset & _T_145; // @[el2_dec_decode_ctl.scala 325:45]
  reg  cam_raw_2_valid; // @[el2_dec_decode_ctl.scala 350:47]
  wire  cam_data_reset_val_2 = _T_146 & cam_raw_2_valid; // @[el2_dec_decode_ctl.scala 325:83]
  wire  cam_2_valid = cam_data_reset_val_2 ? 1'h0 : cam_raw_2_valid; // @[el2_dec_decode_ctl.scala 329:39]
  wire  _T_59 = ~cam_2_valid; // @[el2_dec_decode_ctl.scala 306:79]
  wire  _T_62 = cam_0_valid & cam_1_valid; // @[el2_dec_decode_ctl.scala 306:127]
  wire  _T_65 = _T_62 & _T_59; // @[el2_dec_decode_ctl.scala 306:127]
  wire [2:0] _T_67 = {io_lsu_nonblock_load_valid_m, 2'h0}; // @[el2_dec_decode_ctl.scala 306:159]
  reg [2:0] cam_raw_3_tag; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_171 = io_lsu_nonblock_load_data_tag == cam_raw_3_tag; // @[el2_dec_decode_ctl.scala 325:67]
  wire  _T_172 = cam_data_reset & _T_171; // @[el2_dec_decode_ctl.scala 325:45]
  reg  cam_raw_3_valid; // @[el2_dec_decode_ctl.scala 350:47]
  wire  cam_data_reset_val_3 = _T_172 & cam_raw_3_valid; // @[el2_dec_decode_ctl.scala 325:83]
  wire  cam_3_valid = cam_data_reset_val_3 ? 1'h0 : cam_raw_3_valid; // @[el2_dec_decode_ctl.scala 329:39]
  wire  _T_68 = ~cam_3_valid; // @[el2_dec_decode_ctl.scala 306:79]
  wire  _T_74 = _T_62 & cam_2_valid; // @[el2_dec_decode_ctl.scala 306:127]
  wire  _T_77 = _T_74 & _T_68; // @[el2_dec_decode_ctl.scala 306:127]
  wire [3:0] _T_79 = {io_lsu_nonblock_load_valid_m, 3'h0}; // @[el2_dec_decode_ctl.scala 306:159]
  wire  _T_80 = _T_50 & io_lsu_nonblock_load_valid_m; // @[Mux.scala 27:72]
  wire [1:0] _T_81 = _T_56 ? _T_58 : 2'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_82 = _T_65 ? _T_67 : 3'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_83 = _T_77 ? _T_79 : 4'h0; // @[Mux.scala 27:72]
  wire [1:0] _GEN_123 = {{1'd0}, _T_80}; // @[Mux.scala 27:72]
  wire [1:0] _T_84 = _GEN_123 | _T_81; // @[Mux.scala 27:72]
  wire [2:0] _GEN_124 = {{1'd0}, _T_84}; // @[Mux.scala 27:72]
  wire [2:0] _T_85 = _GEN_124 | _T_82; // @[Mux.scala 27:72]
  wire [3:0] _GEN_125 = {{1'd0}, _T_85}; // @[Mux.scala 27:72]
  wire [3:0] cam_wen = _GEN_125 | _T_83; // @[Mux.scala 27:72]
  reg  x_d_i0load; // @[beh_lib.scala 366:14]
  reg [4:0] x_d_i0rd; // @[beh_lib.scala 366:14]
  wire [4:0] nonblock_load_rd = x_d_i0load ? x_d_i0rd : 5'h0; // @[el2_dec_decode_ctl.scala 317:31]
  reg [2:0] _T_701; // @[el2_dec_decode_ctl.scala 656:72]
  wire [3:0] i0_pipe_en = {io_dec_i0_decode_d,_T_701}; // @[Cat.scala 29:58]
  wire  i0_r_ctl_en = |i0_pipe_en[2:1]; // @[el2_dec_decode_ctl.scala 659:49]
  reg  nonblock_load_valid_m_delay; // @[Reg.scala 27:20]
  reg  r_d_i0load; // @[beh_lib.scala 366:14]
  wire  i0_load_kill_wen_r = nonblock_load_valid_m_delay & r_d_i0load; // @[el2_dec_decode_ctl.scala 322:56]
  wire  _T_90 = io_lsu_nonblock_load_inv_tag_r == cam_raw_0_tag; // @[el2_dec_decode_ctl.scala 324:66]
  wire  _T_91 = io_lsu_nonblock_load_inv_r & _T_90; // @[el2_dec_decode_ctl.scala 324:45]
  wire  cam_inv_reset_val_0 = _T_91 & cam_0_valid; // @[el2_dec_decode_ctl.scala 324:82]
  reg  r_d_i0v; // @[beh_lib.scala 366:14]
  reg [4:0] r_d_i0rd; // @[beh_lib.scala 366:14]
  reg [4:0] cam_raw_0_rd; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_102 = r_d_i0rd == cam_raw_0_rd; // @[el2_dec_decode_ctl.scala 337:80]
  wire  _T_103 = r_d_i0v & _T_102; // @[el2_dec_decode_ctl.scala 337:64]
  reg  cam_raw_0_wb; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_105 = _T_103 & cam_raw_0_wb; // @[el2_dec_decode_ctl.scala 337:95]
  wire  _T_106 = cam_inv_reset_val_0 | _T_105; // @[el2_dec_decode_ctl.scala 337:44]
  wire  _GEN_52 = _T_106 ? 1'h0 : cam_0_valid; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_55 = _T_106 ? 1'h0 : cam_raw_0_wb; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_57 = cam_wen[0] ? 1'h0 : _GEN_55; // @[el2_dec_decode_ctl.scala 332:28]
  wire  _T_109 = nonblock_load_valid_m_delay & _T_90; // @[el2_dec_decode_ctl.scala 342:44]
  wire  _T_111 = _T_109 & cam_0_valid; // @[el2_dec_decode_ctl.scala 342:95]
  wire  nonblock_load_write_0 = _T_93 & cam_raw_0_valid; // @[el2_dec_decode_ctl.scala 351:66]
  wire  _T_116 = io_lsu_nonblock_load_inv_tag_r == cam_raw_1_tag; // @[el2_dec_decode_ctl.scala 324:66]
  wire  _T_117 = io_lsu_nonblock_load_inv_r & _T_116; // @[el2_dec_decode_ctl.scala 324:45]
  wire  cam_inv_reset_val_1 = _T_117 & cam_1_valid; // @[el2_dec_decode_ctl.scala 324:82]
  reg [4:0] cam_raw_1_rd; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_128 = r_d_i0rd == cam_raw_1_rd; // @[el2_dec_decode_ctl.scala 337:80]
  wire  _T_129 = r_d_i0v & _T_128; // @[el2_dec_decode_ctl.scala 337:64]
  reg  cam_raw_1_wb; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_131 = _T_129 & cam_raw_1_wb; // @[el2_dec_decode_ctl.scala 337:95]
  wire  _T_132 = cam_inv_reset_val_1 | _T_131; // @[el2_dec_decode_ctl.scala 337:44]
  wire  _GEN_63 = _T_132 ? 1'h0 : cam_1_valid; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_66 = _T_132 ? 1'h0 : cam_raw_1_wb; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_68 = cam_wen[1] ? 1'h0 : _GEN_66; // @[el2_dec_decode_ctl.scala 332:28]
  wire  _T_135 = nonblock_load_valid_m_delay & _T_116; // @[el2_dec_decode_ctl.scala 342:44]
  wire  _T_137 = _T_135 & cam_1_valid; // @[el2_dec_decode_ctl.scala 342:95]
  wire  nonblock_load_write_1 = _T_119 & cam_raw_1_valid; // @[el2_dec_decode_ctl.scala 351:66]
  wire  _T_142 = io_lsu_nonblock_load_inv_tag_r == cam_raw_2_tag; // @[el2_dec_decode_ctl.scala 324:66]
  wire  _T_143 = io_lsu_nonblock_load_inv_r & _T_142; // @[el2_dec_decode_ctl.scala 324:45]
  wire  cam_inv_reset_val_2 = _T_143 & cam_2_valid; // @[el2_dec_decode_ctl.scala 324:82]
  reg [4:0] cam_raw_2_rd; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_154 = r_d_i0rd == cam_raw_2_rd; // @[el2_dec_decode_ctl.scala 337:80]
  wire  _T_155 = r_d_i0v & _T_154; // @[el2_dec_decode_ctl.scala 337:64]
  reg  cam_raw_2_wb; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_157 = _T_155 & cam_raw_2_wb; // @[el2_dec_decode_ctl.scala 337:95]
  wire  _T_158 = cam_inv_reset_val_2 | _T_157; // @[el2_dec_decode_ctl.scala 337:44]
  wire  _GEN_74 = _T_158 ? 1'h0 : cam_2_valid; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_77 = _T_158 ? 1'h0 : cam_raw_2_wb; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_79 = cam_wen[2] ? 1'h0 : _GEN_77; // @[el2_dec_decode_ctl.scala 332:28]
  wire  _T_161 = nonblock_load_valid_m_delay & _T_142; // @[el2_dec_decode_ctl.scala 342:44]
  wire  _T_163 = _T_161 & cam_2_valid; // @[el2_dec_decode_ctl.scala 342:95]
  wire  nonblock_load_write_2 = _T_145 & cam_raw_2_valid; // @[el2_dec_decode_ctl.scala 351:66]
  wire  _T_168 = io_lsu_nonblock_load_inv_tag_r == cam_raw_3_tag; // @[el2_dec_decode_ctl.scala 324:66]
  wire  _T_169 = io_lsu_nonblock_load_inv_r & _T_168; // @[el2_dec_decode_ctl.scala 324:45]
  wire  cam_inv_reset_val_3 = _T_169 & cam_3_valid; // @[el2_dec_decode_ctl.scala 324:82]
  reg [4:0] cam_raw_3_rd; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_180 = r_d_i0rd == cam_raw_3_rd; // @[el2_dec_decode_ctl.scala 337:80]
  wire  _T_181 = r_d_i0v & _T_180; // @[el2_dec_decode_ctl.scala 337:64]
  reg  cam_raw_3_wb; // @[el2_dec_decode_ctl.scala 350:47]
  wire  _T_183 = _T_181 & cam_raw_3_wb; // @[el2_dec_decode_ctl.scala 337:95]
  wire  _T_184 = cam_inv_reset_val_3 | _T_183; // @[el2_dec_decode_ctl.scala 337:44]
  wire  _GEN_85 = _T_184 ? 1'h0 : cam_3_valid; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_88 = _T_184 ? 1'h0 : cam_raw_3_wb; // @[el2_dec_decode_ctl.scala 337:116]
  wire  _GEN_90 = cam_wen[3] ? 1'h0 : _GEN_88; // @[el2_dec_decode_ctl.scala 332:28]
  wire  _T_187 = nonblock_load_valid_m_delay & _T_168; // @[el2_dec_decode_ctl.scala 342:44]
  wire  _T_189 = _T_187 & cam_3_valid; // @[el2_dec_decode_ctl.scala 342:95]
  wire  nonblock_load_write_3 = _T_171 & cam_raw_3_valid; // @[el2_dec_decode_ctl.scala 351:66]
  wire  _T_194 = r_d_i0rd == io_dec_nonblock_load_waddr; // @[el2_dec_decode_ctl.scala 356:44]
  wire  nonblock_load_cancel = _T_194 & r_d_i0v; // @[el2_dec_decode_ctl.scala 356:76]
  wire  _T_195 = nonblock_load_write_0 | nonblock_load_write_1; // @[el2_dec_decode_ctl.scala 357:95]
  wire  _T_196 = _T_195 | nonblock_load_write_2; // @[el2_dec_decode_ctl.scala 357:95]
  wire  _T_197 = _T_196 | nonblock_load_write_3; // @[el2_dec_decode_ctl.scala 357:95]
  wire  _T_199 = io_lsu_nonblock_load_data_valid & _T_197; // @[el2_dec_decode_ctl.scala 357:64]
  wire  _T_200 = ~nonblock_load_cancel; // @[el2_dec_decode_ctl.scala 357:109]
  wire  _T_202 = nonblock_load_rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 358:54]
  wire  _T_203 = _T_202 & io_lsu_nonblock_load_valid_m; // @[el2_dec_decode_ctl.scala 358:66]
  wire  _T_204 = _T_203 & io_dec_i0_rs1_en_d; // @[el2_dec_decode_ctl.scala 358:97]
  wire [4:0] i0r_rs2 = io_dec_i0_instr_d[24:20]; // @[el2_dec_decode_ctl.scala 625:16]
  wire  _T_205 = nonblock_load_rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 358:137]
  wire  _T_206 = _T_205 & io_lsu_nonblock_load_valid_m; // @[el2_dec_decode_ctl.scala 358:149]
  wire  _T_207 = _T_206 & io_dec_i0_rs2_en_d; // @[el2_dec_decode_ctl.scala 358:180]
  wire  i0_nonblock_boundary_stall = _T_204 | _T_207; // @[el2_dec_decode_ctl.scala 358:118]
  wire [4:0] _T_209 = nonblock_load_write_0 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_210 = _T_209 & cam_raw_0_rd; // @[el2_dec_decode_ctl.scala 362:88]
  wire  _T_211 = io_dec_i0_rs1_en_d & cam_0_valid; // @[el2_dec_decode_ctl.scala 362:121]
  wire  _T_212 = cam_raw_0_rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 362:149]
  wire  _T_213 = _T_211 & _T_212; // @[el2_dec_decode_ctl.scala 362:136]
  wire  _T_214 = io_dec_i0_rs2_en_d & cam_0_valid; // @[el2_dec_decode_ctl.scala 362:182]
  wire  _T_215 = cam_raw_0_rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 362:210]
  wire  _T_216 = _T_214 & _T_215; // @[el2_dec_decode_ctl.scala 362:197]
  wire [4:0] _T_218 = nonblock_load_write_1 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_219 = _T_218 & cam_raw_1_rd; // @[el2_dec_decode_ctl.scala 362:88]
  wire  _T_220 = io_dec_i0_rs1_en_d & cam_1_valid; // @[el2_dec_decode_ctl.scala 362:121]
  wire  _T_221 = cam_raw_1_rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 362:149]
  wire  _T_222 = _T_220 & _T_221; // @[el2_dec_decode_ctl.scala 362:136]
  wire  _T_223 = io_dec_i0_rs2_en_d & cam_1_valid; // @[el2_dec_decode_ctl.scala 362:182]
  wire  _T_224 = cam_raw_1_rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 362:210]
  wire  _T_225 = _T_223 & _T_224; // @[el2_dec_decode_ctl.scala 362:197]
  wire [4:0] _T_227 = nonblock_load_write_2 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_228 = _T_227 & cam_raw_2_rd; // @[el2_dec_decode_ctl.scala 362:88]
  wire  _T_229 = io_dec_i0_rs1_en_d & cam_2_valid; // @[el2_dec_decode_ctl.scala 362:121]
  wire  _T_230 = cam_raw_2_rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 362:149]
  wire  _T_231 = _T_229 & _T_230; // @[el2_dec_decode_ctl.scala 362:136]
  wire  _T_232 = io_dec_i0_rs2_en_d & cam_2_valid; // @[el2_dec_decode_ctl.scala 362:182]
  wire  _T_233 = cam_raw_2_rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 362:210]
  wire  _T_234 = _T_232 & _T_233; // @[el2_dec_decode_ctl.scala 362:197]
  wire [4:0] _T_236 = nonblock_load_write_3 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_237 = _T_236 & cam_raw_3_rd; // @[el2_dec_decode_ctl.scala 362:88]
  wire  _T_238 = io_dec_i0_rs1_en_d & cam_3_valid; // @[el2_dec_decode_ctl.scala 362:121]
  wire  _T_239 = cam_raw_3_rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 362:149]
  wire  _T_240 = _T_238 & _T_239; // @[el2_dec_decode_ctl.scala 362:136]
  wire  _T_241 = io_dec_i0_rs2_en_d & cam_3_valid; // @[el2_dec_decode_ctl.scala 362:182]
  wire  _T_242 = cam_raw_3_rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 362:210]
  wire  _T_243 = _T_241 & _T_242; // @[el2_dec_decode_ctl.scala 362:197]
  wire [4:0] _T_244 = _T_210 | _T_219; // @[el2_dec_decode_ctl.scala 363:69]
  wire [4:0] _T_245 = _T_244 | _T_228; // @[el2_dec_decode_ctl.scala 363:69]
  wire  _T_246 = _T_213 | _T_222; // @[el2_dec_decode_ctl.scala 363:102]
  wire  _T_247 = _T_246 | _T_231; // @[el2_dec_decode_ctl.scala 363:102]
  wire  ld_stall_1 = _T_247 | _T_240; // @[el2_dec_decode_ctl.scala 363:102]
  wire  _T_248 = _T_216 | _T_225; // @[el2_dec_decode_ctl.scala 363:134]
  wire  _T_249 = _T_248 | _T_234; // @[el2_dec_decode_ctl.scala 363:134]
  wire  ld_stall_2 = _T_249 | _T_243; // @[el2_dec_decode_ctl.scala 363:134]
  wire  _T_250 = ld_stall_1 | ld_stall_2; // @[el2_dec_decode_ctl.scala 365:38]
  wire  i0_nonblock_load_stall = _T_250 | i0_nonblock_boundary_stall; // @[el2_dec_decode_ctl.scala 365:51]
  reg  lsu_idle; // @[el2_dec_decode_ctl.scala 400:45]
  wire  _T_333 = ~i0_pcall_case; // @[el2_dec_decode_ctl.scala 424:35]
  wire  _T_334 = i0_dp_jal & _T_333; // @[el2_dec_decode_ctl.scala 424:32]
  wire  _T_335 = ~i0_pja_case; // @[el2_dec_decode_ctl.scala 424:52]
  wire  _T_336 = _T_334 & _T_335; // @[el2_dec_decode_ctl.scala 424:50]
  wire  _T_337 = ~i0_pret_case; // @[el2_dec_decode_ctl.scala 424:67]
  wire  lsu_decode_d = i0_legal_decode_d & i0_dp_lsu; // @[el2_dec_decode_ctl.scala 578:40]
  wire  _T_902 = i0_dp_load | i0_dp_store; // @[el2_dec_decode_ctl.scala 792:47]
  reg  x_d_i0v; // @[beh_lib.scala 366:14]
  wire  _T_876 = io_dec_i0_rs1_en_d & x_d_i0v; // @[el2_dec_decode_ctl.scala 772:48]
  wire  _T_877 = x_d_i0rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 772:70]
  wire  i0_rs1_depend_i0_x = _T_876 & _T_877; // @[el2_dec_decode_ctl.scala 772:58]
  wire  _T_878 = io_dec_i0_rs1_en_d & r_d_i0v; // @[el2_dec_decode_ctl.scala 773:48]
  wire  _T_879 = r_d_i0rd == i0r_rs1; // @[el2_dec_decode_ctl.scala 773:70]
  wire  i0_rs1_depend_i0_r = _T_878 & _T_879; // @[el2_dec_decode_ctl.scala 773:58]
  wire [1:0] _T_891 = i0_rs1_depend_i0_r ? 2'h2 : 2'h0; // @[el2_dec_decode_ctl.scala 779:63]
  wire [1:0] i0_rs1_depth_d = i0_rs1_depend_i0_x ? 2'h1 : _T_891; // @[el2_dec_decode_ctl.scala 779:24]
  wire  _T_904 = _T_902 & i0_rs1_depth_d[0]; // @[el2_dec_decode_ctl.scala 792:62]
  reg  i0_x_c_load; // @[Reg.scala 15:16]
  reg  i0_r_c_load; // @[Reg.scala 15:16]
  wire  _T_887_load = i0_rs1_depend_i0_r & i0_r_c_load; // @[el2_dec_decode_ctl.scala 778:61]
  wire  i0_rs1_class_d_load = i0_rs1_depend_i0_x ? i0_x_c_load : _T_887_load; // @[el2_dec_decode_ctl.scala 778:24]
  wire  load_ldst_bypass_d = _T_904 & i0_rs1_class_d_load; // @[el2_dec_decode_ctl.scala 792:82]
  wire  _T_880 = io_dec_i0_rs2_en_d & x_d_i0v; // @[el2_dec_decode_ctl.scala 775:48]
  wire  _T_881 = x_d_i0rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 775:70]
  wire  i0_rs2_depend_i0_x = _T_880 & _T_881; // @[el2_dec_decode_ctl.scala 775:58]
  wire  _T_882 = io_dec_i0_rs2_en_d & r_d_i0v; // @[el2_dec_decode_ctl.scala 776:48]
  wire  _T_883 = r_d_i0rd == i0r_rs2; // @[el2_dec_decode_ctl.scala 776:70]
  wire  i0_rs2_depend_i0_r = _T_882 & _T_883; // @[el2_dec_decode_ctl.scala 776:58]
  wire [1:0] _T_900 = i0_rs2_depend_i0_r ? 2'h2 : 2'h0; // @[el2_dec_decode_ctl.scala 781:63]
  wire [1:0] i0_rs2_depth_d = i0_rs2_depend_i0_x ? 2'h1 : _T_900; // @[el2_dec_decode_ctl.scala 781:24]
  wire  _T_907 = i0_dp_store & i0_rs2_depth_d[0]; // @[el2_dec_decode_ctl.scala 793:47]
  wire  _T_896_load = i0_rs2_depend_i0_r & i0_r_c_load; // @[el2_dec_decode_ctl.scala 780:61]
  wire  i0_rs2_class_d_load = i0_rs2_depend_i0_x ? i0_x_c_load : _T_896_load; // @[el2_dec_decode_ctl.scala 780:24]
  wire  store_data_bypass_d = _T_907 & i0_rs2_class_d_load; // @[el2_dec_decode_ctl.scala 793:67]
  reg  r_d_i0valid; // @[beh_lib.scala 366:14]
  reg  csr_read_x; // @[el2_dec_decode_ctl.scala 480:52]
  reg  csr_clr_x; // @[el2_dec_decode_ctl.scala 481:51]
  reg  csr_set_x; // @[el2_dec_decode_ctl.scala 482:51]
  reg  csr_write_x; // @[el2_dec_decode_ctl.scala 483:53]
  wire  i0_x_data_en = i0_pipe_en[3]; // @[el2_dec_decode_ctl.scala 661:44]
  wire  _T_425 = csr_clr_x | csr_set_x; // @[el2_dec_decode_ctl.scala 511:34]
  wire  _T_426 = _T_425 | csr_write_x; // @[el2_dec_decode_ctl.scala 511:46]
  reg  r_d_csrwonly; // @[beh_lib.scala 366:14]
  wire  _T_764 = r_d_i0v & r_d_i0load; // @[el2_dec_decode_ctl.scala 714:37]
  reg [31:0] i0_result_r_raw; // @[beh_lib.scala 356:14]
  reg  x_d_csrwonly; // @[beh_lib.scala 366:14]
  wire  _T_432 = x_d_csrwonly | r_d_csrwonly; // @[el2_dec_decode_ctl.scala 520:38]
  reg  wbd_csrwonly; // @[beh_lib.scala 366:14]
  wire  prior_csr_write = _T_432 | wbd_csrwonly; // @[el2_dec_decode_ctl.scala 520:53]
  wire  debug_fence_raw = io_dec_debug_fence_d & io_dbg_cmd_wrdata[1]; // @[el2_dec_decode_ctl.scala 523:48]
  wire  debug_fence = debug_fence_raw | debug_fence_i; // @[el2_dec_decode_ctl.scala 524:40]
  wire  _T_437 = i0_dp_presync | debug_fence_i; // @[el2_dec_decode_ctl.scala 527:57]
  wire  i0_presync = _T_437 | debug_fence_raw; // @[el2_dec_decode_ctl.scala 527:73]
  wire  _T_464 = ~illegal_lockout; // @[el2_dec_decode_ctl.scala 539:44]
  wire  i0_div_prior_div_stall = i0_dp_div & io_dec_div_active; // @[el2_dec_decode_ctl.scala 543:42]
  wire  _T_470 = i0_dp_csr_read & prior_csr_write; // @[el2_dec_decode_ctl.scala 545:40]
  wire  _T_471 = _T_470 | io_dec_extint_stall; // @[el2_dec_decode_ctl.scala 545:59]
  wire  _T_475 = _T_471 | postsync_stall; // @[el2_dec_decode_ctl.scala 546:45]
  wire  prior_inflight = x_d_i0valid | r_d_i0valid; // @[el2_dec_decode_ctl.scala 568:41]
  wire  prior_inflight_eff = i0_dp_div ? x_d_i0valid : prior_inflight; // @[el2_dec_decode_ctl.scala 569:31]
  wire  presync_stall = i0_presync & prior_inflight_eff; // @[el2_dec_decode_ctl.scala 571:37]
  wire  _T_476 = _T_475 | presync_stall; // @[el2_dec_decode_ctl.scala 546:62]
  wire  _T_477 = i0_dp_fence | debug_fence; // @[el2_dec_decode_ctl.scala 547:19]
  wire  _T_478 = ~lsu_idle; // @[el2_dec_decode_ctl.scala 547:36]
  wire  _T_479 = _T_477 & _T_478; // @[el2_dec_decode_ctl.scala 547:34]
  wire  _T_480 = _T_476 | _T_479; // @[el2_dec_decode_ctl.scala 546:79]
  wire  _T_481 = _T_480 | i0_nonblock_load_stall; // @[el2_dec_decode_ctl.scala 547:47]
  wire  _T_822 = io_dec_i0_rs1_en_d & io_dec_div_active; // @[el2_dec_decode_ctl.scala 742:49]
  wire  _T_823 = io_div_waddr_wb == i0r_rs1; // @[el2_dec_decode_ctl.scala 742:88]
  wire  _T_824 = _T_822 & _T_823; // @[el2_dec_decode_ctl.scala 742:69]
  wire  _T_825 = io_dec_i0_rs2_en_d & io_dec_div_active; // @[el2_dec_decode_ctl.scala 743:52]
  wire  _T_826 = io_div_waddr_wb == i0r_rs2; // @[el2_dec_decode_ctl.scala 743:91]
  wire  _T_827 = _T_825 & _T_826; // @[el2_dec_decode_ctl.scala 743:72]
  wire  i0_nonblock_div_stall = _T_824 | _T_827; // @[el2_dec_decode_ctl.scala 742:102]
  wire  _T_483 = _T_481 | i0_nonblock_div_stall; // @[el2_dec_decode_ctl.scala 548:21]
  wire  i0_block_raw_d = _T_483 | i0_div_prior_div_stall; // @[el2_dec_decode_ctl.scala 548:45]
  wire  _T_484 = io_lsu_store_stall_any | io_dma_dccm_stall_any; // @[el2_dec_decode_ctl.scala 550:65]
  wire  i0_store_stall_d = i0_dp_store & _T_484; // @[el2_dec_decode_ctl.scala 550:39]
  wire  _T_485 = io_lsu_load_stall_any | io_dma_dccm_stall_any; // @[el2_dec_decode_ctl.scala 551:63]
  wire  i0_load_stall_d = i0_dp_load & _T_485; // @[el2_dec_decode_ctl.scala 551:38]
  wire  _T_486 = i0_block_raw_d | i0_store_stall_d; // @[el2_dec_decode_ctl.scala 552:38]
  wire  i0_block_d = _T_486 | i0_load_stall_d; // @[el2_dec_decode_ctl.scala 552:57]
  wire  _T_487 = ~i0_block_d; // @[el2_dec_decode_ctl.scala 556:46]
  wire  _T_488 = io_dec_ib0_valid_d & _T_487; // @[el2_dec_decode_ctl.scala 556:44]
  wire  _T_493 = ~i0_block_raw_d; // @[el2_dec_decode_ctl.scala 557:46]
  wire  _T_494 = io_dec_ib0_valid_d & _T_493; // @[el2_dec_decode_ctl.scala 557:44]
  wire  i0_exudecode_d = _T_494 & _T_467; // @[el2_dec_decode_ctl.scala 557:89]
  wire  i0_exulegal_decode_d = i0_exudecode_d & i0_legal; // @[el2_dec_decode_ctl.scala 558:46]
  wire  i0_x_ctl_en = |i0_pipe_en[3:2]; // @[el2_dec_decode_ctl.scala 658:49]
  reg  r_d_i0div; // @[beh_lib.scala 366:14]
  wire  _T_545 = r_d_i0div & r_d_i0valid; // @[el2_dec_decode_ctl.scala 617:53]
  wire  _T_556 = i0r_rs1 != 5'h0; // @[el2_dec_decode_ctl.scala 628:49]
  wire  _T_558 = i0r_rs2 != 5'h0; // @[el2_dec_decode_ctl.scala 629:49]
  wire  _T_560 = i0r_rd != 5'h0; // @[el2_dec_decode_ctl.scala 630:48]
  wire  i0_rd_en_d = i0_dp_rd & _T_560; // @[el2_dec_decode_ctl.scala 630:37]
  wire  i0_jalimm20 = i0_dp_jal & i0_dp_imm20; // @[el2_dec_decode_ctl.scala 634:38]
  wire  _T_561 = ~i0_dp_jal; // @[el2_dec_decode_ctl.scala 635:27]
  wire  i0_uiimm20 = _T_561 & i0_dp_imm20; // @[el2_dec_decode_ctl.scala 635:38]
  wire [9:0] _T_577 = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31]}; // @[Cat.scala 29:58]
  wire [18:0] _T_586 = {_T_577,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31]}; // @[Cat.scala 29:58]
  wire [31:0] _T_589 = {_T_586,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31:20]}; // @[Cat.scala 29:58]
  wire [31:0] _T_684 = i0_dp_imm12 ? _T_589 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_618 = {27'h0,i0r_rs2}; // @[Cat.scala 29:58]
  wire [31:0] _T_685 = i0_dp_shimm5 ? _T_618 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_689 = _T_684 | _T_685; // @[Mux.scala 27:72]
  wire [31:0] _T_638 = {_T_577,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[19:12],io_dec_i0_instr_d[20],io_dec_i0_instr_d[30:21],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_686 = i0_jalimm20 ? _T_638 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_690 = _T_689 | _T_686; // @[Mux.scala 27:72]
  wire [31:0] _T_652 = {io_dec_i0_instr_d[31:12],12'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_687 = i0_uiimm20 ? _T_652 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_691 = _T_690 | _T_687; // @[Mux.scala 27:72]
  wire  _T_653 = i0_csr_write_only_d & i0_dp_csr_imm; // @[el2_dec_decode_ctl.scala 646:40]
  wire [31:0] _T_683 = {27'h0,i0r_rs1}; // @[Cat.scala 29:58]
  wire [31:0] _T_688 = _T_653 ? _T_683 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] i0_immed_d = _T_691 | _T_688; // @[Mux.scala 27:72]
  wire  i0_d_c_mul = i0_dp_mul & i0_legal_decode_d; // @[el2_dec_decode_ctl.scala 650:44]
  wire  i0_d_c_load = i0_dp_load & i0_legal_decode_d; // @[el2_dec_decode_ctl.scala 651:44]
  wire  i0_d_c_alu = i0_dp_alu & i0_legal_decode_d; // @[el2_dec_decode_ctl.scala 652:44]
  reg  i0_x_c_mul; // @[Reg.scala 15:16]
  reg  i0_x_c_alu; // @[Reg.scala 15:16]
  reg  i0_r_c_mul; // @[Reg.scala 15:16]
  reg  i0_r_c_alu; // @[Reg.scala 15:16]
  wire  i0_r_data_en = i0_pipe_en[2]; // @[el2_dec_decode_ctl.scala 662:44]
  reg  x_d_i0div; // @[beh_lib.scala 366:14]
  wire  _T_756 = ~r_d_i0div; // @[el2_dec_decode_ctl.scala 700:49]
  wire  _T_757 = r_d_i0v & _T_756; // @[el2_dec_decode_ctl.scala 700:47]
  wire  _T_758 = ~i0_load_kill_wen_r; // @[el2_dec_decode_ctl.scala 700:65]
  wire  _T_761 = x_d_i0v & x_d_i0load; // @[el2_dec_decode_ctl.scala 709:45]
  wire  _T_768 = io_i0_ap_predict_nt & _T_561; // @[el2_dec_decode_ctl.scala 715:52]
  wire [11:0] _T_781 = {10'h0,io_dec_i0_pc4_d,i0_ap_pc2}; // @[Cat.scala 29:58]
  reg [11:0] last_br_immed_x; // @[beh_lib.scala 356:14]
  wire  _T_799 = x_d_i0div & x_d_i0valid; // @[el2_dec_decode_ctl.scala 723:40]
  wire  div_e1_to_r = _T_799 | _T_545; // @[el2_dec_decode_ctl.scala 723:55]
  wire  _T_802 = x_d_i0rd == 5'h0; // @[el2_dec_decode_ctl.scala 725:69]
  wire  div_flush = _T_799 & _T_802; // @[el2_dec_decode_ctl.scala 725:57]
  wire  _T_810 = io_dec_div_active & div_flush; // @[el2_dec_decode_ctl.scala 731:51]
  wire  _T_811 = ~div_e1_to_r; // @[el2_dec_decode_ctl.scala 732:26]
  wire  _T_812 = io_dec_div_active & _T_811; // @[el2_dec_decode_ctl.scala 732:24]
  wire  _T_813 = r_d_i0rd == io_div_waddr_wb; // @[el2_dec_decode_ctl.scala 732:51]
  wire  _T_814 = _T_812 & _T_813; // @[el2_dec_decode_ctl.scala 732:39]
  wire  _T_815 = _T_814 & r_d_i0v; // @[el2_dec_decode_ctl.scala 732:72]
  wire  nonblock_div_cancel = _T_810 | _T_815; // @[el2_dec_decode_ctl.scala 731:65]
  wire  i0_div_decode_d = i0_legal_decode_d & i0_dp_div; // @[el2_dec_decode_ctl.scala 735:55]
  wire  _T_817 = ~io_exu_div_wren; // @[el2_dec_decode_ctl.scala 737:62]
  wire  _T_818 = io_dec_div_active & _T_817; // @[el2_dec_decode_ctl.scala 737:60]
  wire  _T_819 = ~nonblock_div_cancel; // @[el2_dec_decode_ctl.scala 737:81]
  wire  _T_820 = _T_818 & _T_819; // @[el2_dec_decode_ctl.scala 737:79]
  reg  _T_821; // @[el2_dec_decode_ctl.scala 739:54]
  reg [4:0] _T_830; // @[Reg.scala 27:20]
  wire [31:0] _T_842 = {io_exu_i0_pc_x,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_843 = {last_br_immed_x,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_846 = _T_842[12:1] + _T_843[12:1]; // @[el2_lib.scala 310:31]
  wire [18:0] _T_849 = _T_842[31:13] + 19'h1; // @[el2_lib.scala 311:27]
  wire [18:0] _T_852 = _T_842[31:13] - 19'h1; // @[el2_lib.scala 312:27]
  wire  _T_855 = ~_T_846[12]; // @[el2_lib.scala 314:27]
  wire  _T_856 = _T_843[12] ^ _T_855; // @[el2_lib.scala 314:25]
  wire  _T_859 = ~_T_843[12]; // @[el2_lib.scala 315:8]
  wire  _T_861 = _T_859 & _T_846[12]; // @[el2_lib.scala 315:14]
  wire  _T_865 = _T_843[12] & _T_855; // @[el2_lib.scala 316:13]
  wire [18:0] _T_867 = _T_856 ? _T_842[31:13] : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_868 = _T_861 ? _T_849 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_869 = _T_865 ? _T_852 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_870 = _T_867 | _T_868; // @[Mux.scala 27:72]
  wire [18:0] _T_871 = _T_870 | _T_869; // @[Mux.scala 27:72]
  wire [31:0] temp_pred_correct_npc_x = {_T_871,_T_846[11:0],1'h0}; // @[Cat.scala 29:58]
  wire  _T_887_mul = i0_rs1_depend_i0_r & i0_r_c_mul; // @[el2_dec_decode_ctl.scala 778:61]
  wire  _T_887_alu = i0_rs1_depend_i0_r & i0_r_c_alu; // @[el2_dec_decode_ctl.scala 778:61]
  wire  i0_rs1_class_d_mul = i0_rs1_depend_i0_x ? i0_x_c_mul : _T_887_mul; // @[el2_dec_decode_ctl.scala 778:24]
  wire  i0_rs1_class_d_alu = i0_rs1_depend_i0_x ? i0_x_c_alu : _T_887_alu; // @[el2_dec_decode_ctl.scala 778:24]
  wire  _T_896_mul = i0_rs2_depend_i0_r & i0_r_c_mul; // @[el2_dec_decode_ctl.scala 780:61]
  wire  _T_896_alu = i0_rs2_depend_i0_r & i0_r_c_alu; // @[el2_dec_decode_ctl.scala 780:61]
  wire  i0_rs2_class_d_mul = i0_rs2_depend_i0_x ? i0_x_c_mul : _T_896_mul; // @[el2_dec_decode_ctl.scala 780:24]
  wire  i0_rs2_class_d_alu = i0_rs2_depend_i0_x ? i0_x_c_alu : _T_896_alu; // @[el2_dec_decode_ctl.scala 780:24]
  wire  _T_909 = io_dec_i0_rs1_en_d & io_dec_nonblock_load_wen; // @[el2_dec_decode_ctl.scala 798:62]
  wire  _T_910 = io_dec_nonblock_load_waddr == i0r_rs1; // @[el2_dec_decode_ctl.scala 798:119]
  wire  i0_rs1_nonblock_load_bypass_en_d = _T_909 & _T_910; // @[el2_dec_decode_ctl.scala 798:89]
  wire  _T_911 = io_dec_i0_rs2_en_d & io_dec_nonblock_load_wen; // @[el2_dec_decode_ctl.scala 800:62]
  wire  _T_912 = io_dec_nonblock_load_waddr == i0r_rs2; // @[el2_dec_decode_ctl.scala 800:119]
  wire  i0_rs2_nonblock_load_bypass_en_d = _T_911 & _T_912; // @[el2_dec_decode_ctl.scala 800:89]
  wire  _T_914 = i0_rs1_class_d_alu | i0_rs1_class_d_mul; // @[el2_dec_decode_ctl.scala 803:69]
  wire  _T_915 = i0_rs1_depth_d[0] & _T_914; // @[el2_dec_decode_ctl.scala 803:48]
  wire  _T_917 = i0_rs1_depth_d[0] & i0_rs1_class_d_load; // @[el2_dec_decode_ctl.scala 803:111]
  wire  _T_920 = _T_914 | i0_rs1_class_d_load; // @[el2_dec_decode_ctl.scala 803:199]
  wire  _T_921 = i0_rs1_depth_d[1] & _T_920; // @[el2_dec_decode_ctl.scala 803:156]
  wire [2:0] i0_rs1bypass = {_T_915,_T_917,_T_921}; // @[Cat.scala 29:58]
  wire  _T_925 = i0_rs2_class_d_alu | i0_rs2_class_d_mul; // @[el2_dec_decode_ctl.scala 805:70]
  wire  _T_926 = i0_rs2_depth_d[0] & _T_925; // @[el2_dec_decode_ctl.scala 805:48]
  wire  _T_928 = i0_rs2_depth_d[0] & i0_rs2_class_d_load; // @[el2_dec_decode_ctl.scala 805:112]
  wire  _T_931 = _T_925 | i0_rs2_class_d_load; // @[el2_dec_decode_ctl.scala 805:199]
  wire  _T_932 = i0_rs2_depth_d[1] & _T_931; // @[el2_dec_decode_ctl.scala 805:156]
  wire [2:0] i0_rs2bypass = {_T_926,_T_928,_T_932}; // @[Cat.scala 29:58]
  wire  _T_938 = i0_rs1bypass[1] | i0_rs1bypass[0]; // @[el2_dec_decode_ctl.scala 807:78]
  wire  _T_940 = ~i0_rs1bypass[2]; // @[el2_dec_decode_ctl.scala 807:99]
  wire  _T_941 = _T_940 & i0_rs1_nonblock_load_bypass_en_d; // @[el2_dec_decode_ctl.scala 807:116]
  wire  _T_942 = _T_938 | _T_941; // @[el2_dec_decode_ctl.scala 807:96]
  wire  _T_947 = i0_rs2bypass[1] | i0_rs2bypass[0]; // @[el2_dec_decode_ctl.scala 808:78]
  wire  _T_949 = ~i0_rs2bypass[2]; // @[el2_dec_decode_ctl.scala 808:99]
  wire  _T_950 = _T_949 & i0_rs2_nonblock_load_bypass_en_d; // @[el2_dec_decode_ctl.scala 808:116]
  wire  _T_951 = _T_947 | _T_950; // @[el2_dec_decode_ctl.scala 808:96]
  wire  _T_958 = ~i0_rs1bypass[1]; // @[el2_dec_decode_ctl.scala 813:30]
  wire  _T_960 = ~i0_rs1bypass[0]; // @[el2_dec_decode_ctl.scala 813:49]
  wire  _T_961 = _T_958 & _T_960; // @[el2_dec_decode_ctl.scala 813:47]
  wire  _T_962 = _T_961 & i0_rs1_nonblock_load_bypass_en_d; // @[el2_dec_decode_ctl.scala 813:66]
  wire [31:0] _T_964 = i0_rs1bypass[1] ? io_lsu_result_m : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_965 = i0_rs1bypass[0] ? i0_result_r_raw : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_966 = _T_962 ? io_lsu_nonblock_load_data : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_967 = _T_964 | _T_965; // @[Mux.scala 27:72]
  wire  _T_975 = ~i0_rs2bypass[1]; // @[el2_dec_decode_ctl.scala 818:31]
  wire  _T_977 = ~i0_rs2bypass[0]; // @[el2_dec_decode_ctl.scala 818:50]
  wire  _T_978 = _T_975 & _T_977; // @[el2_dec_decode_ctl.scala 818:48]
  wire  _T_979 = _T_978 & i0_rs2_nonblock_load_bypass_en_d; // @[el2_dec_decode_ctl.scala 818:67]
  wire [31:0] _T_981 = i0_rs2bypass[1] ? io_lsu_result_m : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_982 = i0_rs2bypass[0] ? i0_result_r_raw : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_983 = _T_979 ? io_lsu_nonblock_load_data : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_984 = _T_981 | _T_982; // @[Mux.scala 27:72]
  wire  _T_987 = i0_dp_raw_load | i0_dp_raw_store; // @[el2_dec_decode_ctl.scala 820:68]
  wire  _T_988 = io_dec_ib0_valid_d & _T_987; // @[el2_dec_decode_ctl.scala 820:50]
  wire  _T_989 = ~io_dma_dccm_stall_any; // @[el2_dec_decode_ctl.scala 820:89]
  wire  _T_990 = _T_988 & _T_989; // @[el2_dec_decode_ctl.scala 820:87]
  wire  _T_992 = _T_990 & _T_493; // @[el2_dec_decode_ctl.scala 820:112]
  wire  _T_994 = ~io_dec_extint_stall; // @[el2_dec_decode_ctl.scala 822:6]
  wire  _T_995 = _T_994 & i0_dp_lsu; // @[el2_dec_decode_ctl.scala 822:27]
  wire  _T_996 = _T_995 & i0_dp_load; // @[el2_dec_decode_ctl.scala 822:39]
  wire  _T_1001 = _T_995 & i0_dp_store; // @[el2_dec_decode_ctl.scala 823:39]
  wire [11:0] _T_1005 = {io_dec_i0_instr_d[31:25],i0r_rd}; // @[Cat.scala 29:58]
  wire [11:0] _T_1006 = _T_996 ? io_dec_i0_instr_d[31:20] : 12'h0; // @[Mux.scala 27:72]
  wire [11:0] _T_1007 = _T_1001 ? _T_1005 : 12'h0; // @[Mux.scala 27:72]
  rvclkhdr data_gated_cgc ( // @[el2_dec_decode_ctl.scala 221:29]
    .io_l1clk(data_gated_cgc_io_l1clk),
    .io_clk(data_gated_cgc_io_clk),
    .io_en(data_gated_cgc_io_en),
    .io_scan_mode(data_gated_cgc_io_scan_mode)
  );
  el2_dec_dec_ctl i0_dec ( // @[el2_dec_decode_ctl.scala 396:24]
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
    .io_out_mul(i0_dec_io_out_mul),
    .io_out_rs1_sign(i0_dec_io_out_rs1_sign),
    .io_out_rs2_sign(i0_dec_io_out_rs2_sign),
    .io_out_low(i0_dec_io_out_low),
    .io_out_div(i0_dec_io_out_div),
    .io_out_rem(i0_dec_io_out_rem),
    .io_out_fence(i0_dec_io_out_fence),
    .io_out_legal(i0_dec_io_out_legal)
  );
  rvclkhdr rvclkhdr ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  rvclkhdr rvclkhdr_2 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_2_io_l1clk),
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en),
    .io_scan_mode(rvclkhdr_2_io_scan_mode)
  );
  rvclkhdr rvclkhdr_3 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_3_io_l1clk),
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en),
    .io_scan_mode(rvclkhdr_3_io_scan_mode)
  );
  rvclkhdr rvclkhdr_4 ( // @[beh_lib.scala 360:21]
    .io_l1clk(rvclkhdr_4_io_l1clk),
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en),
    .io_scan_mode(rvclkhdr_4_io_scan_mode)
  );
  rvclkhdr rvclkhdr_5 ( // @[beh_lib.scala 360:21]
    .io_l1clk(rvclkhdr_5_io_l1clk),
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en),
    .io_scan_mode(rvclkhdr_5_io_scan_mode)
  );
  rvclkhdr rvclkhdr_6 ( // @[beh_lib.scala 360:21]
    .io_l1clk(rvclkhdr_6_io_l1clk),
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en),
    .io_scan_mode(rvclkhdr_6_io_scan_mode)
  );
  rvclkhdr rvclkhdr_7 ( // @[beh_lib.scala 360:21]
    .io_l1clk(rvclkhdr_7_io_l1clk),
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en),
    .io_scan_mode(rvclkhdr_7_io_scan_mode)
  );
  rvclkhdr rvclkhdr_8 ( // @[beh_lib.scala 360:21]
    .io_l1clk(rvclkhdr_8_io_l1clk),
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en),
    .io_scan_mode(rvclkhdr_8_io_scan_mode)
  );
  rvclkhdr rvclkhdr_9 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_9_io_l1clk),
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en),
    .io_scan_mode(rvclkhdr_9_io_scan_mode)
  );
  rvclkhdr rvclkhdr_10 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_10_io_l1clk),
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en),
    .io_scan_mode(rvclkhdr_10_io_scan_mode)
  );
  rvclkhdr rvclkhdr_11 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_11_io_l1clk),
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en),
    .io_scan_mode(rvclkhdr_11_io_scan_mode)
  );
  rvclkhdr rvclkhdr_12 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_12_io_l1clk),
    .io_clk(rvclkhdr_12_io_clk),
    .io_en(rvclkhdr_12_io_en),
    .io_scan_mode(rvclkhdr_12_io_scan_mode)
  );
  rvclkhdr rvclkhdr_13 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_13_io_l1clk),
    .io_clk(rvclkhdr_13_io_clk),
    .io_en(rvclkhdr_13_io_en),
    .io_scan_mode(rvclkhdr_13_io_scan_mode)
  );
  rvclkhdr rvclkhdr_14 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_14_io_l1clk),
    .io_clk(rvclkhdr_14_io_clk),
    .io_en(rvclkhdr_14_io_en),
    .io_scan_mode(rvclkhdr_14_io_scan_mode)
  );
  rvclkhdr rvclkhdr_15 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_15_io_l1clk),
    .io_clk(rvclkhdr_15_io_clk),
    .io_en(rvclkhdr_15_io_en),
    .io_scan_mode(rvclkhdr_15_io_scan_mode)
  );
  rvclkhdr rvclkhdr_16 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_16_io_l1clk),
    .io_clk(rvclkhdr_16_io_clk),
    .io_en(rvclkhdr_16_io_en),
    .io_scan_mode(rvclkhdr_16_io_scan_mode)
  );
  rvclkhdr rvclkhdr_17 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_17_io_l1clk),
    .io_clk(rvclkhdr_17_io_clk),
    .io_en(rvclkhdr_17_io_en),
    .io_scan_mode(rvclkhdr_17_io_scan_mode)
  );
  rvclkhdr rvclkhdr_18 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_18_io_l1clk),
    .io_clk(rvclkhdr_18_io_clk),
    .io_en(rvclkhdr_18_io_en),
    .io_scan_mode(rvclkhdr_18_io_scan_mode)
  );
  assign io_dec_extint_stall = 1'h0; // @[el2_dec_decode_ctl.scala 436:23]
  assign io_dec_i0_rs1_en_d = i0_dp_rs1 & _T_556; // @[el2_dec_decode_ctl.scala 628:24]
  assign io_dec_i0_rs2_en_d = i0_dp_rs2 & _T_558; // @[el2_dec_decode_ctl.scala 629:24]
  assign io_dec_i0_rs1_d = io_dec_i0_instr_d[19:15]; // @[el2_dec_decode_ctl.scala 631:19]
  assign io_dec_i0_rs2_d = io_dec_i0_instr_d[24:20]; // @[el2_dec_decode_ctl.scala 632:19]
  assign io_dec_i0_immed_d = _T_347 ? i0_immed_d : 32'h0; // @[el2_dec_decode_ctl.scala 637:21]
  assign io_dec_i0_br_immed_d = _T_768 ? i0_br_offset : _T_781; // @[el2_dec_decode_ctl.scala 715:24]
  assign io_i0_ap_land = _T_40 ? 1'h0 : i0_dp_raw_land; // @[el2_dec_decode_ctl.scala 288:20]
  assign io_i0_ap_lor = _T_40 | i0_dp_raw_lor; // @[el2_dec_decode_ctl.scala 289:20]
  assign io_i0_ap_lxor = _T_40 ? 1'h0 : i0_dp_raw_lxor; // @[el2_dec_decode_ctl.scala 290:20]
  assign io_i0_ap_sll = _T_40 ? 1'h0 : i0_dp_raw_sll; // @[el2_dec_decode_ctl.scala 291:20]
  assign io_i0_ap_srl = _T_40 ? 1'h0 : i0_dp_raw_srl; // @[el2_dec_decode_ctl.scala 292:20]
  assign io_i0_ap_sra = _T_40 ? 1'h0 : i0_dp_raw_sra; // @[el2_dec_decode_ctl.scala 293:20]
  assign io_i0_ap_beq = _T_40 ? 1'h0 : i0_dp_raw_beq; // @[el2_dec_decode_ctl.scala 296:20]
  assign io_i0_ap_bne = _T_40 ? 1'h0 : i0_dp_raw_bne; // @[el2_dec_decode_ctl.scala 297:20]
  assign io_i0_ap_blt = _T_40 ? 1'h0 : i0_dp_raw_blt; // @[el2_dec_decode_ctl.scala 298:20]
  assign io_i0_ap_bge = _T_40 ? 1'h0 : i0_dp_raw_bge; // @[el2_dec_decode_ctl.scala 299:20]
  assign io_i0_ap_add = _T_40 ? 1'h0 : i0_dp_raw_add; // @[el2_dec_decode_ctl.scala 286:20]
  assign io_i0_ap_sub = _T_40 ? 1'h0 : i0_dp_raw_sub; // @[el2_dec_decode_ctl.scala 287:20]
  assign io_i0_ap_slt = _T_40 ? 1'h0 : i0_dp_raw_slt; // @[el2_dec_decode_ctl.scala 294:20]
  assign io_i0_ap_unsign = _T_40 ? 1'h0 : i0_dp_raw_unsign; // @[el2_dec_decode_ctl.scala 295:20]
  assign io_i0_ap_jal = _T_336 & _T_337; // @[el2_dec_decode_ctl.scala 302:22]
  assign io_i0_ap_predict_t = _T_46 & i0_predict_br; // @[el2_dec_decode_ctl.scala 284:26]
  assign io_i0_ap_predict_nt = _T_47 & i0_predict_br; // @[el2_dec_decode_ctl.scala 283:26]
  assign io_i0_ap_csr_write = i0_csr_write & _T_347; // @[el2_dec_decode_ctl.scala 300:22]
  assign io_i0_ap_csr_imm = _T_40 ? 1'h0 : i0_dp_raw_csr_imm; // @[el2_dec_decode_ctl.scala 301:22]
  assign io_dec_i0_decode_d = _T_488 & _T_467; // @[el2_dec_decode_ctl.scala 556:22 el2_dec_decode_ctl.scala 622:22]
  assign io_dec_i0_alu_decode_d = i0_exulegal_decode_d & i0_dp_alu; // @[el2_dec_decode_ctl.scala 576:26]
  assign io_dec_i0_rs1_bypass_data_d = _T_967 | _T_966; // @[el2_dec_decode_ctl.scala 810:34]
  assign io_dec_i0_rs2_bypass_data_d = _T_984 | _T_983; // @[el2_dec_decode_ctl.scala 815:34]
  assign io_dec_i0_waddr_r = r_d_i0rd; // @[el2_dec_decode_ctl.scala 698:27]
  assign io_dec_i0_wen_r = _T_757 & _T_758; // @[el2_dec_decode_ctl.scala 700:32]
  assign io_dec_i0_wdata_r = _T_764 ? io_lsu_result_corr_r : i0_result_r_raw; // @[el2_dec_decode_ctl.scala 701:26]
  assign io_dec_i0_select_pc_d = _T_40 ? 1'h0 : i0_dp_raw_pc; // @[el2_dec_decode_ctl.scala 274:25]
  assign io_dec_i0_rs1_bypass_en_d = {i0_rs1bypass[2],_T_942}; // @[el2_dec_decode_ctl.scala 807:37]
  assign io_dec_i0_rs2_bypass_en_d = {i0_rs2bypass[2],_T_951}; // @[el2_dec_decode_ctl.scala 808:37]
  assign io_lsu_p_fast_int = io_dec_extint_stall; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 442:30]
  assign io_lsu_p_by = io_dec_extint_stall ? 1'h0 : i0_dp_by; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 448:41]
  assign io_lsu_p_half = io_dec_extint_stall ? 1'h0 : i0_dp_half; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 449:41]
  assign io_lsu_p_word = io_dec_extint_stall | i0_dp_word; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 441:30 el2_dec_decode_ctl.scala 450:41]
  assign io_lsu_p_load = io_dec_extint_stall | i0_dp_load; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 440:30 el2_dec_decode_ctl.scala 446:41]
  assign io_lsu_p_store = io_dec_extint_stall ? 1'h0 : i0_dp_store; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 447:41]
  assign io_lsu_p_unsign = io_dec_extint_stall ? 1'h0 : i0_dp_unsign; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 454:41]
  assign io_lsu_p_store_data_bypass_d = io_dec_extint_stall ? 1'h0 : store_data_bypass_d; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 452:41]
  assign io_lsu_p_load_ldst_bypass_d = io_dec_extint_stall ? 1'h0 : load_ldst_bypass_d; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 451:41]
  assign io_lsu_p_valid = io_dec_extint_stall | lsu_decode_d; // @[el2_dec_decode_ctl.scala 438:11 el2_dec_decode_ctl.scala 443:30 el2_dec_decode_ctl.scala 445:41]
  assign io_mul_p_valid = i0_exulegal_decode_d & i0_dp_mul; // @[el2_dec_decode_ctl.scala 126:12 el2_dec_decode_ctl.scala 431:21]
  assign io_mul_p_rs1_sign = _T_40 ? 1'h0 : i0_dp_raw_rs1_sign; // @[el2_dec_decode_ctl.scala 126:12 el2_dec_decode_ctl.scala 432:21]
  assign io_mul_p_rs2_sign = _T_40 ? 1'h0 : i0_dp_raw_rs2_sign; // @[el2_dec_decode_ctl.scala 126:12 el2_dec_decode_ctl.scala 433:21]
  assign io_mul_p_low = _T_40 ? 1'h0 : i0_dp_raw_low; // @[el2_dec_decode_ctl.scala 126:12 el2_dec_decode_ctl.scala 434:21]
  assign io_div_p_valid = i0_exulegal_decode_d & i0_dp_div; // @[el2_dec_decode_ctl.scala 427:21]
  assign io_div_p_unsign = _T_40 ? 1'h0 : i0_dp_raw_unsign; // @[el2_dec_decode_ctl.scala 428:21]
  assign io_div_p_rem = _T_40 ? 1'h0 : i0_dp_raw_rem; // @[el2_dec_decode_ctl.scala 429:21]
  assign io_div_waddr_wb = _T_830; // @[el2_dec_decode_ctl.scala 745:19]
  assign io_dec_div_cancel = _T_810 | _T_815; // @[el2_dec_decode_ctl.scala 734:29]
  assign io_dec_lsu_valid_raw_d = _T_992 | io_dec_extint_stall; // @[el2_dec_decode_ctl.scala 820:26]
  assign io_dec_lsu_offset_d = _T_1006 | _T_1007; // @[el2_dec_decode_ctl.scala 821:23]
  assign io_dec_csr_ren_d = _T_40 ? 1'h0 : i0_dp_raw_csr_read; // @[el2_dec_decode_ctl.scala 458:21]
  assign io_pred_correct_npc_x = temp_pred_correct_npc_x[31:1]; // @[el2_dec_decode_ctl.scala 768:25]
  assign io_dec_i0_predict_p_d_pc4 = io_dec_i0_pc4_d; // @[el2_dec_decode_ctl.scala 237:38]
  assign io_dec_i0_predict_p_d_hist = io_dec_i0_brp_hist; // @[el2_dec_decode_ctl.scala 238:38]
  assign io_dec_i0_predict_p_d_toffset = _T_314 ? i0_pcall_imm[12:1] : _T_323; // @[el2_dec_decode_ctl.scala 251:44]
  assign io_dec_i0_predict_p_d_valid = io_dec_i0_brp_valid & i0_legal_decode_d; // @[el2_dec_decode_ctl.scala 239:38]
  assign io_dec_i0_predict_p_d_br_error = i0_br_error & i0_legal_decode_d; // @[el2_dec_decode_ctl.scala 246:51]
  assign io_dec_i0_predict_p_d_br_start_error = io_dec_i0_brp_br_start_error & i0_legal_decode_d; // @[el2_dec_decode_ctl.scala 247:51]
  assign io_dec_i0_predict_p_d_prett = io_dec_i0_brp_prett; // @[el2_dec_decode_ctl.scala 236:38]
  assign io_dec_i0_predict_p_d_pcall = i0_dp_jal & i0_pcall_case; // @[el2_dec_decode_ctl.scala 233:38]
  assign io_dec_i0_predict_p_d_pret = i0_dp_jal & i0_pret_case; // @[el2_dec_decode_ctl.scala 235:38]
  assign io_dec_i0_predict_p_d_pja = i0_dp_jal & i0_pja_case; // @[el2_dec_decode_ctl.scala 234:38]
  assign io_dec_i0_predict_p_d_way = io_dec_i0_brp_way; // @[el2_dec_decode_ctl.scala 253:51]
  assign io_i0_predict_fghr_d = io_dec_i0_bp_fghr; // @[el2_dec_decode_ctl.scala 252:32]
  assign io_i0_predict_index_d = io_dec_i0_bp_index; // @[el2_dec_decode_ctl.scala 248:32]
  assign io_i0_predict_btag_d = io_dec_i0_bp_btag; // @[el2_dec_decode_ctl.scala 249:32]
  assign io_dec_data_en = {i0_x_data_en,i0_r_data_en}; // @[el2_dec_decode_ctl.scala 666:27]
  assign io_dec_ctl_en = {i0_x_ctl_en,i0_r_ctl_en}; // @[el2_dec_decode_ctl.scala 667:27]
  assign io_dec_nonblock_load_wen = _T_199 & _T_200; // @[el2_dec_decode_ctl.scala 357:28]
  assign io_dec_nonblock_load_waddr = _T_245 | _T_237; // @[el2_dec_decode_ctl.scala 354:29 el2_dec_decode_ctl.scala 364:29]
  assign io_dec_div_active = _T_821; // @[el2_dec_decode_ctl.scala 739:21]
  assign data_gated_cgc_io_clk = clock; // @[el2_dec_decode_ctl.scala 224:31]
  assign data_gated_cgc_io_en = _T_15 | _T_16; // @[el2_dec_decode_ctl.scala 222:31]
  assign data_gated_cgc_io_scan_mode = io_scan_mode; // @[el2_dec_decode_ctl.scala 223:31]
  assign i0_dec_io_ins = io_dec_i0_instr_d; // @[el2_dec_decode_ctl.scala 397:18]
  assign rvclkhdr_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_io_en = i0_pipe_en[3]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_1_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_1_io_en = i0_pipe_en[3]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_2_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_2_io_en = _T_426 & csr_read_x; // @[beh_lib.scala 353:15]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_3_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_3_io_en = shift_illegal & _T_464; // @[beh_lib.scala 353:15]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_4_io_clk = clock; // @[beh_lib.scala 362:16]
  assign rvclkhdr_4_io_en = |i0_pipe_en[3:2]; // @[beh_lib.scala 363:15]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[beh_lib.scala 364:22]
  assign rvclkhdr_5_io_clk = clock; // @[beh_lib.scala 362:16]
  assign rvclkhdr_5_io_en = |i0_pipe_en[3:2]; // @[beh_lib.scala 363:15]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[beh_lib.scala 364:22]
  assign rvclkhdr_6_io_clk = clock; // @[beh_lib.scala 362:16]
  assign rvclkhdr_6_io_en = |i0_pipe_en[3:2]; // @[beh_lib.scala 363:15]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[beh_lib.scala 364:22]
  assign rvclkhdr_7_io_clk = clock; // @[beh_lib.scala 362:16]
  assign rvclkhdr_7_io_en = |i0_pipe_en[2:1]; // @[beh_lib.scala 363:15]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[beh_lib.scala 364:22]
  assign rvclkhdr_8_io_clk = clock; // @[beh_lib.scala 362:16]
  assign rvclkhdr_8_io_en = |i0_pipe_en[1:0]; // @[beh_lib.scala 363:15]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[beh_lib.scala 364:22]
  assign rvclkhdr_9_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_9_io_en = i0_pipe_en[2]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_10_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_10_io_en = i0_pipe_en[3]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_11_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_11_io_en = i0_legal_decode_d & i0_dp_div; // @[beh_lib.scala 353:15]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_12_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_12_io_en = i0_pipe_en[3]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_13_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_13_io_en = i0_pipe_en[2]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_14_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_14_io_en = i0_pipe_en[1]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_15_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_15_io_en = i0_pipe_en[0]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_16_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_16_io_en = i0_pipe_en[1]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_17_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_17_io_en = i0_pipe_en[0]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_17_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_18_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_18_io_en = i0_pipe_en[2]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_18_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
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
  postsync_stall = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  x_d_i0valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  flush_final_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  illegal_lockout = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cam_raw_0_tag = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  cam_raw_0_valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  cam_raw_1_tag = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  cam_raw_1_valid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  cam_raw_2_tag = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  cam_raw_2_valid = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  cam_raw_3_tag = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  cam_raw_3_valid = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  x_d_i0load = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  x_d_i0rd = _RAND_13[4:0];
  _RAND_14 = {1{`RANDOM}};
  _T_701 = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  nonblock_load_valid_m_delay = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  r_d_i0load = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  r_d_i0v = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  r_d_i0rd = _RAND_18[4:0];
  _RAND_19 = {1{`RANDOM}};
  cam_raw_0_rd = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  cam_raw_0_wb = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  cam_raw_1_rd = _RAND_21[4:0];
  _RAND_22 = {1{`RANDOM}};
  cam_raw_1_wb = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  cam_raw_2_rd = _RAND_23[4:0];
  _RAND_24 = {1{`RANDOM}};
  cam_raw_2_wb = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  cam_raw_3_rd = _RAND_25[4:0];
  _RAND_26 = {1{`RANDOM}};
  cam_raw_3_wb = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  lsu_idle = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  x_d_i0v = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  i0_x_c_load = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  i0_r_c_load = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  r_d_i0valid = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  csr_read_x = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  csr_clr_x = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  csr_set_x = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  csr_write_x = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  r_d_csrwonly = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  i0_result_r_raw = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  x_d_csrwonly = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  wbd_csrwonly = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  r_d_i0div = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  i0_x_c_mul = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  i0_x_c_alu = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  i0_r_c_mul = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  i0_r_c_alu = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  x_d_i0div = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  last_br_immed_x = _RAND_46[11:0];
  _RAND_47 = {1{`RANDOM}};
  _T_821 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  _T_830 = _RAND_48[4:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    postsync_stall = 1'h0;
  end
  if (reset) begin
    x_d_i0valid = 1'h0;
  end
  if (reset) begin
    flush_final_r = 1'h0;
  end
  if (reset) begin
    illegal_lockout = 1'h0;
  end
  if (reset) begin
    cam_raw_0_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_0_valid = 1'h0;
  end
  if (reset) begin
    cam_raw_1_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_1_valid = 1'h0;
  end
  if (reset) begin
    cam_raw_2_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_2_valid = 1'h0;
  end
  if (reset) begin
    cam_raw_3_tag = 3'h0;
  end
  if (reset) begin
    cam_raw_3_valid = 1'h0;
  end
  if (reset) begin
    x_d_i0load = 1'h0;
  end
  if (reset) begin
    x_d_i0rd = 5'h0;
  end
  if (reset) begin
    _T_701 = 3'h0;
  end
  if (reset) begin
    nonblock_load_valid_m_delay = 1'h0;
  end
  if (reset) begin
    r_d_i0load = 1'h0;
  end
  if (reset) begin
    r_d_i0v = 1'h0;
  end
  if (reset) begin
    r_d_i0rd = 5'h0;
  end
  if (reset) begin
    cam_raw_0_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_0_wb = 1'h0;
  end
  if (reset) begin
    cam_raw_1_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_1_wb = 1'h0;
  end
  if (reset) begin
    cam_raw_2_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_2_wb = 1'h0;
  end
  if (reset) begin
    cam_raw_3_rd = 5'h0;
  end
  if (reset) begin
    cam_raw_3_wb = 1'h0;
  end
  if (reset) begin
    lsu_idle = 1'h0;
  end
  if (reset) begin
    x_d_i0v = 1'h0;
  end
  if (reset) begin
    r_d_i0valid = 1'h0;
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
    r_d_csrwonly = 1'h0;
  end
  if (reset) begin
    i0_result_r_raw = 32'h0;
  end
  if (reset) begin
    x_d_csrwonly = 1'h0;
  end
  if (reset) begin
    wbd_csrwonly = 1'h0;
  end
  if (reset) begin
    r_d_i0div = 1'h0;
  end
  if (reset) begin
    x_d_i0div = 1'h0;
  end
  if (reset) begin
    last_br_immed_x = 12'h0;
  end
  if (reset) begin
    _T_821 = 1'h0;
  end
  if (reset) begin
    _T_830 = 5'h0;
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
  always @(posedge data_gated_cgc_io_l1clk or posedge reset) begin
    if (reset) begin
      postsync_stall <= 1'h0;
    end else begin
      postsync_stall <= _T_506 | _T_507;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_i0valid <= 1'h0;
    end else begin
      x_d_i0valid <= io_dec_i0_decode_d;
    end
  end
  always @(posedge data_gated_cgc_io_l1clk or posedge reset) begin
    if (reset) begin
      flush_final_r <= 1'h0;
    end else begin
      flush_final_r <= io_exu_flush_final;
    end
  end
  always @(posedge data_gated_cgc_io_l1clk or posedge reset) begin
    if (reset) begin
      illegal_lockout <= 1'h0;
    end else begin
      illegal_lockout <= _T_466 & _T_467;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_tag <= 3'h0;
    end else if (cam_wen[0]) begin
      cam_raw_0_tag <= io_lsu_nonblock_load_tag_m;
    end else if (_T_106) begin
      cam_raw_0_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_valid <= 1'h0;
    end else begin
      cam_raw_0_valid <= cam_wen[0] | _GEN_52;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_tag <= 3'h0;
    end else if (cam_wen[1]) begin
      cam_raw_1_tag <= io_lsu_nonblock_load_tag_m;
    end else if (_T_132) begin
      cam_raw_1_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_valid <= 1'h0;
    end else begin
      cam_raw_1_valid <= cam_wen[1] | _GEN_63;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_tag <= 3'h0;
    end else if (cam_wen[2]) begin
      cam_raw_2_tag <= io_lsu_nonblock_load_tag_m;
    end else if (_T_158) begin
      cam_raw_2_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_valid <= 1'h0;
    end else begin
      cam_raw_2_valid <= cam_wen[2] | _GEN_74;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_tag <= 3'h0;
    end else if (cam_wen[3]) begin
      cam_raw_3_tag <= io_lsu_nonblock_load_tag_m;
    end else if (_T_184) begin
      cam_raw_3_tag <= 3'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_valid <= 1'h0;
    end else begin
      cam_raw_3_valid <= cam_wen[3] | _GEN_85;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_i0load <= 1'h0;
    end else begin
      x_d_i0load <= i0_dp_load & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_i0rd <= 5'h0;
    end else begin
      x_d_i0rd <= io_dec_i0_instr_d[11:7];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_701 <= 3'h0;
    end else begin
      _T_701 <= i0_pipe_en[3:1];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      nonblock_load_valid_m_delay <= 1'h0;
    end else if (i0_r_ctl_en) begin
      nonblock_load_valid_m_delay <= io_lsu_nonblock_load_valid_m;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_i0load <= 1'h0;
    end else begin
      r_d_i0load <= x_d_i0load;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_i0v <= 1'h0;
    end else begin
      r_d_i0v <= x_d_i0v;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_i0rd <= 5'h0;
    end else begin
      r_d_i0rd <= x_d_i0rd;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_rd <= 5'h0;
    end else if (cam_wen[0]) begin
      if (x_d_i0load) begin
        cam_raw_0_rd <= x_d_i0rd;
      end else begin
        cam_raw_0_rd <= 5'h0;
      end
    end else if (_T_106) begin
      cam_raw_0_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_wb <= 1'h0;
    end else begin
      cam_raw_0_wb <= _T_111 | _GEN_57;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_rd <= 5'h0;
    end else if (cam_wen[1]) begin
      if (x_d_i0load) begin
        cam_raw_1_rd <= x_d_i0rd;
      end else begin
        cam_raw_1_rd <= 5'h0;
      end
    end else if (_T_132) begin
      cam_raw_1_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_wb <= 1'h0;
    end else begin
      cam_raw_1_wb <= _T_137 | _GEN_68;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_rd <= 5'h0;
    end else if (cam_wen[2]) begin
      if (x_d_i0load) begin
        cam_raw_2_rd <= x_d_i0rd;
      end else begin
        cam_raw_2_rd <= 5'h0;
      end
    end else if (_T_158) begin
      cam_raw_2_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_wb <= 1'h0;
    end else begin
      cam_raw_2_wb <= _T_163 | _GEN_79;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_rd <= 5'h0;
    end else if (cam_wen[3]) begin
      if (x_d_i0load) begin
        cam_raw_3_rd <= x_d_i0rd;
      end else begin
        cam_raw_3_rd <= 5'h0;
      end
    end else if (_T_184) begin
      cam_raw_3_rd <= 5'h0;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_wb <= 1'h0;
    end else begin
      cam_raw_3_wb <= _T_189 | _GEN_90;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      lsu_idle <= 1'h0;
    end else begin
      lsu_idle <= io_lsu_idle_any;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_i0v <= 1'h0;
    end else begin
      x_d_i0v <= i0_rd_en_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_i0valid <= 1'h0;
    end else begin
      r_d_i0valid <= x_d_i0valid;
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
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_csrwonly <= 1'h0;
    end else begin
      r_d_csrwonly <= x_d_csrwonly;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_result_r_raw <= 32'h0;
    end else if (_T_761) begin
      i0_result_r_raw <= io_lsu_result_m;
    end else begin
      i0_result_r_raw <= io_exu_i0_result_x;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_csrwonly <= 1'h0;
    end else begin
      x_d_csrwonly <= i0_csr_write_only_d & io_dec_i0_decode_d;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      wbd_csrwonly <= 1'h0;
    end else begin
      wbd_csrwonly <= r_d_csrwonly;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      r_d_i0div <= 1'h0;
    end else begin
      r_d_i0div <= x_d_i0div;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      x_d_i0div <= 1'h0;
    end else begin
      x_d_i0div <= i0_dp_div & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      last_br_immed_x <= 12'h0;
    end else if (io_i0_ap_predict_nt) begin
      last_br_immed_x <= _T_781;
    end else if (_T_314) begin
      last_br_immed_x <= i0_pcall_imm[12:1];
    end else begin
      last_br_immed_x <= _T_323;
    end
  end
  always @(posedge io_free_clk or posedge reset) begin
    if (reset) begin
      _T_821 <= 1'h0;
    end else begin
      _T_821 <= i0_div_decode_d | _T_820;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      _T_830 <= 5'h0;
    end else if (i0_div_decode_d) begin
      _T_830 <= i0r_rd;
    end
  end
endmodule
module el2_dec_gpr_ctl(
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
  output [31:0] io_rd0,
  output [31:0] io_rd1,
  input         io_scan_mode
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
  wire  rvclkhdr_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_1_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_2_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_3_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_4_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_4_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_4_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_4_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_5_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_5_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_5_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_5_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_6_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_6_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_6_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_6_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_7_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_7_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_7_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_7_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_8_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_8_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_8_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_8_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_9_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_10_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_11_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_12_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_13_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_14_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_15_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_16_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_17_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_18_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_19_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_19_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_19_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_19_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_20_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_20_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_20_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_20_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_21_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_21_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_21_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_21_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_22_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_22_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_22_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_22_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_23_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_23_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_23_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_23_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_24_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_24_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_24_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_24_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_25_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_25_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_25_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_25_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_26_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_26_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_26_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_26_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_27_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_27_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_27_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_27_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_28_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_28_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_28_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_28_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_29_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_29_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_29_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_29_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_30_io_l1clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_30_io_clk; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_30_io_en; // @[beh_lib.scala 350:21]
  wire  rvclkhdr_30_io_scan_mode; // @[beh_lib.scala 350:21]
  wire  _T_95 = io_waddr0 == 5'h1; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_1 = io_wen0 & _T_95; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_112 = io_waddr0 == 5'h2; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_2 = io_wen0 & _T_112; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_129 = io_waddr0 == 5'h3; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_3 = io_wen0 & _T_129; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_146 = io_waddr0 == 5'h4; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_4 = io_wen0 & _T_146; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_163 = io_waddr0 == 5'h5; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_5 = io_wen0 & _T_163; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_180 = io_waddr0 == 5'h6; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_6 = io_wen0 & _T_180; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_197 = io_waddr0 == 5'h7; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_7 = io_wen0 & _T_197; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_214 = io_waddr0 == 5'h8; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_8 = io_wen0 & _T_214; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_231 = io_waddr0 == 5'h9; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_9 = io_wen0 & _T_231; // @[el2_dec_gpr_ctl.scala 26:33]
  wire [9:0] _T_8 = {w0v_9,w0v_8,w0v_7,w0v_6,w0v_5,w0v_4,w0v_3,w0v_2,w0v_1,1'h0}; // @[Cat.scala 29:58]
  wire  _T_248 = io_waddr0 == 5'ha; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_10 = io_wen0 & _T_248; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_265 = io_waddr0 == 5'hb; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_11 = io_wen0 & _T_265; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_282 = io_waddr0 == 5'hc; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_12 = io_wen0 & _T_282; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_299 = io_waddr0 == 5'hd; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_13 = io_wen0 & _T_299; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_316 = io_waddr0 == 5'he; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_14 = io_wen0 & _T_316; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_333 = io_waddr0 == 5'hf; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_15 = io_wen0 & _T_333; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_350 = io_waddr0 == 5'h10; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_16 = io_wen0 & _T_350; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_367 = io_waddr0 == 5'h11; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_17 = io_wen0 & _T_367; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_384 = io_waddr0 == 5'h12; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_18 = io_wen0 & _T_384; // @[el2_dec_gpr_ctl.scala 26:33]
  wire [18:0] _T_17 = {w0v_18,w0v_17,w0v_16,w0v_15,w0v_14,w0v_13,w0v_12,w0v_11,w0v_10,_T_8}; // @[Cat.scala 29:58]
  wire  _T_401 = io_waddr0 == 5'h13; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_19 = io_wen0 & _T_401; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_418 = io_waddr0 == 5'h14; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_20 = io_wen0 & _T_418; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_435 = io_waddr0 == 5'h15; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_21 = io_wen0 & _T_435; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_452 = io_waddr0 == 5'h16; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_22 = io_wen0 & _T_452; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_469 = io_waddr0 == 5'h17; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_23 = io_wen0 & _T_469; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_486 = io_waddr0 == 5'h18; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_24 = io_wen0 & _T_486; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_503 = io_waddr0 == 5'h19; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_25 = io_wen0 & _T_503; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_520 = io_waddr0 == 5'h1a; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_26 = io_wen0 & _T_520; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_537 = io_waddr0 == 5'h1b; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_27 = io_wen0 & _T_537; // @[el2_dec_gpr_ctl.scala 26:33]
  wire [27:0] _T_26 = {w0v_27,w0v_26,w0v_25,w0v_24,w0v_23,w0v_22,w0v_21,w0v_20,w0v_19,_T_17}; // @[Cat.scala 29:58]
  wire  _T_554 = io_waddr0 == 5'h1c; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_28 = io_wen0 & _T_554; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_571 = io_waddr0 == 5'h1d; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_29 = io_wen0 & _T_571; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_588 = io_waddr0 == 5'h1e; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_30 = io_wen0 & _T_588; // @[el2_dec_gpr_ctl.scala 26:33]
  wire  _T_605 = io_waddr0 == 5'h1f; // @[el2_dec_gpr_ctl.scala 26:45]
  wire  w0v_31 = io_wen0 & _T_605; // @[el2_dec_gpr_ctl.scala 26:33]
  wire [31:0] _T_30 = {w0v_31,w0v_30,w0v_29,w0v_28,_T_26}; // @[Cat.scala 29:58]
  wire  _T_97 = io_waddr1 == 5'h1; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_1 = io_wen1 & _T_97; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_114 = io_waddr1 == 5'h2; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_2 = io_wen1 & _T_114; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_131 = io_waddr1 == 5'h3; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_3 = io_wen1 & _T_131; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_148 = io_waddr1 == 5'h4; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_4 = io_wen1 & _T_148; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_165 = io_waddr1 == 5'h5; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_5 = io_wen1 & _T_165; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_182 = io_waddr1 == 5'h6; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_6 = io_wen1 & _T_182; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_199 = io_waddr1 == 5'h7; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_7 = io_wen1 & _T_199; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_216 = io_waddr1 == 5'h8; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_8 = io_wen1 & _T_216; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_233 = io_waddr1 == 5'h9; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_9 = io_wen1 & _T_233; // @[el2_dec_gpr_ctl.scala 27:33]
  wire [9:0] _T_39 = {w1v_9,w1v_8,w1v_7,w1v_6,w1v_5,w1v_4,w1v_3,w1v_2,w1v_1,1'h0}; // @[Cat.scala 29:58]
  wire  _T_250 = io_waddr1 == 5'ha; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_10 = io_wen1 & _T_250; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_267 = io_waddr1 == 5'hb; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_11 = io_wen1 & _T_267; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_284 = io_waddr1 == 5'hc; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_12 = io_wen1 & _T_284; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_301 = io_waddr1 == 5'hd; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_13 = io_wen1 & _T_301; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_318 = io_waddr1 == 5'he; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_14 = io_wen1 & _T_318; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_335 = io_waddr1 == 5'hf; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_15 = io_wen1 & _T_335; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_352 = io_waddr1 == 5'h10; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_16 = io_wen1 & _T_352; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_369 = io_waddr1 == 5'h11; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_17 = io_wen1 & _T_369; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_386 = io_waddr1 == 5'h12; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_18 = io_wen1 & _T_386; // @[el2_dec_gpr_ctl.scala 27:33]
  wire [18:0] _T_48 = {w1v_18,w1v_17,w1v_16,w1v_15,w1v_14,w1v_13,w1v_12,w1v_11,w1v_10,_T_39}; // @[Cat.scala 29:58]
  wire  _T_403 = io_waddr1 == 5'h13; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_19 = io_wen1 & _T_403; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_420 = io_waddr1 == 5'h14; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_20 = io_wen1 & _T_420; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_437 = io_waddr1 == 5'h15; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_21 = io_wen1 & _T_437; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_454 = io_waddr1 == 5'h16; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_22 = io_wen1 & _T_454; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_471 = io_waddr1 == 5'h17; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_23 = io_wen1 & _T_471; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_488 = io_waddr1 == 5'h18; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_24 = io_wen1 & _T_488; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_505 = io_waddr1 == 5'h19; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_25 = io_wen1 & _T_505; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_522 = io_waddr1 == 5'h1a; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_26 = io_wen1 & _T_522; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_539 = io_waddr1 == 5'h1b; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_27 = io_wen1 & _T_539; // @[el2_dec_gpr_ctl.scala 27:33]
  wire [27:0] _T_57 = {w1v_27,w1v_26,w1v_25,w1v_24,w1v_23,w1v_22,w1v_21,w1v_20,w1v_19,_T_48}; // @[Cat.scala 29:58]
  wire  _T_556 = io_waddr1 == 5'h1c; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_28 = io_wen1 & _T_556; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_573 = io_waddr1 == 5'h1d; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_29 = io_wen1 & _T_573; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_590 = io_waddr1 == 5'h1e; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_30 = io_wen1 & _T_590; // @[el2_dec_gpr_ctl.scala 27:33]
  wire  _T_607 = io_waddr1 == 5'h1f; // @[el2_dec_gpr_ctl.scala 27:45]
  wire  w1v_31 = io_wen1 & _T_607; // @[el2_dec_gpr_ctl.scala 27:33]
  wire [31:0] _T_61 = {w1v_31,w1v_30,w1v_29,w1v_28,_T_57}; // @[Cat.scala 29:58]
  wire [31:0] _T_62 = _T_30 | _T_61; // @[el2_dec_gpr_ctl.scala 23:57]
  wire  _T_99 = io_waddr2 == 5'h1; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_1 = io_wen2 & _T_99; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_116 = io_waddr2 == 5'h2; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_2 = io_wen2 & _T_116; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_133 = io_waddr2 == 5'h3; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_3 = io_wen2 & _T_133; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_150 = io_waddr2 == 5'h4; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_4 = io_wen2 & _T_150; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_167 = io_waddr2 == 5'h5; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_5 = io_wen2 & _T_167; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_184 = io_waddr2 == 5'h6; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_6 = io_wen2 & _T_184; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_201 = io_waddr2 == 5'h7; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_7 = io_wen2 & _T_201; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_218 = io_waddr2 == 5'h8; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_8 = io_wen2 & _T_218; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_235 = io_waddr2 == 5'h9; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_9 = io_wen2 & _T_235; // @[el2_dec_gpr_ctl.scala 28:33]
  wire [9:0] _T_71 = {w2v_9,w2v_8,w2v_7,w2v_6,w2v_5,w2v_4,w2v_3,w2v_2,w2v_1,1'h0}; // @[Cat.scala 29:58]
  wire  _T_252 = io_waddr2 == 5'ha; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_10 = io_wen2 & _T_252; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_269 = io_waddr2 == 5'hb; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_11 = io_wen2 & _T_269; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_286 = io_waddr2 == 5'hc; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_12 = io_wen2 & _T_286; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_303 = io_waddr2 == 5'hd; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_13 = io_wen2 & _T_303; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_320 = io_waddr2 == 5'he; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_14 = io_wen2 & _T_320; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_337 = io_waddr2 == 5'hf; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_15 = io_wen2 & _T_337; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_354 = io_waddr2 == 5'h10; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_16 = io_wen2 & _T_354; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_371 = io_waddr2 == 5'h11; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_17 = io_wen2 & _T_371; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_388 = io_waddr2 == 5'h12; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_18 = io_wen2 & _T_388; // @[el2_dec_gpr_ctl.scala 28:33]
  wire [18:0] _T_80 = {w2v_18,w2v_17,w2v_16,w2v_15,w2v_14,w2v_13,w2v_12,w2v_11,w2v_10,_T_71}; // @[Cat.scala 29:58]
  wire  _T_405 = io_waddr2 == 5'h13; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_19 = io_wen2 & _T_405; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_422 = io_waddr2 == 5'h14; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_20 = io_wen2 & _T_422; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_439 = io_waddr2 == 5'h15; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_21 = io_wen2 & _T_439; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_456 = io_waddr2 == 5'h16; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_22 = io_wen2 & _T_456; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_473 = io_waddr2 == 5'h17; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_23 = io_wen2 & _T_473; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_490 = io_waddr2 == 5'h18; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_24 = io_wen2 & _T_490; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_507 = io_waddr2 == 5'h19; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_25 = io_wen2 & _T_507; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_524 = io_waddr2 == 5'h1a; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_26 = io_wen2 & _T_524; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_541 = io_waddr2 == 5'h1b; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_27 = io_wen2 & _T_541; // @[el2_dec_gpr_ctl.scala 28:33]
  wire [27:0] _T_89 = {w2v_27,w2v_26,w2v_25,w2v_24,w2v_23,w2v_22,w2v_21,w2v_20,w2v_19,_T_80}; // @[Cat.scala 29:58]
  wire  _T_558 = io_waddr2 == 5'h1c; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_28 = io_wen2 & _T_558; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_575 = io_waddr2 == 5'h1d; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_29 = io_wen2 & _T_575; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_592 = io_waddr2 == 5'h1e; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_30 = io_wen2 & _T_592; // @[el2_dec_gpr_ctl.scala 28:33]
  wire  _T_609 = io_waddr2 == 5'h1f; // @[el2_dec_gpr_ctl.scala 28:45]
  wire  w2v_31 = io_wen2 & _T_609; // @[el2_dec_gpr_ctl.scala 28:33]
  wire [31:0] _T_93 = {w2v_31,w2v_30,w2v_29,w2v_28,_T_89}; // @[Cat.scala 29:58]
  wire [31:0] gpr_wr_en = _T_62 | _T_93; // @[el2_dec_gpr_ctl.scala 23:95]
  wire [31:0] _T_102 = w0v_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_103 = _T_102 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_105 = w1v_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_106 = _T_105 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_107 = _T_103 | _T_106; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_109 = w2v_1 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_110 = _T_109 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_119 = w0v_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_120 = _T_119 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_122 = w1v_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_123 = _T_122 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_124 = _T_120 | _T_123; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_126 = w2v_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_127 = _T_126 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_136 = w0v_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_137 = _T_136 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_139 = w1v_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_140 = _T_139 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_141 = _T_137 | _T_140; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_143 = w2v_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_144 = _T_143 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_153 = w0v_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_154 = _T_153 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_156 = w1v_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_157 = _T_156 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_158 = _T_154 | _T_157; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_160 = w2v_4 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_161 = _T_160 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_170 = w0v_5 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_171 = _T_170 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_173 = w1v_5 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_174 = _T_173 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_175 = _T_171 | _T_174; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_177 = w2v_5 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_178 = _T_177 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_187 = w0v_6 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_188 = _T_187 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_190 = w1v_6 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_191 = _T_190 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_192 = _T_188 | _T_191; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_194 = w2v_6 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_195 = _T_194 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_204 = w0v_7 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_205 = _T_204 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_207 = w1v_7 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_208 = _T_207 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_209 = _T_205 | _T_208; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_211 = w2v_7 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_212 = _T_211 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_221 = w0v_8 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_222 = _T_221 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_224 = w1v_8 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_225 = _T_224 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_226 = _T_222 | _T_225; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_228 = w2v_8 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_229 = _T_228 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_238 = w0v_9 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_239 = _T_238 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_241 = w1v_9 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_242 = _T_241 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_243 = _T_239 | _T_242; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_245 = w2v_9 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_246 = _T_245 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_255 = w0v_10 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_256 = _T_255 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_258 = w1v_10 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_259 = _T_258 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_260 = _T_256 | _T_259; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_262 = w2v_10 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_263 = _T_262 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_272 = w0v_11 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_273 = _T_272 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_275 = w1v_11 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_276 = _T_275 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_277 = _T_273 | _T_276; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_279 = w2v_11 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_280 = _T_279 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_289 = w0v_12 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_290 = _T_289 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_292 = w1v_12 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_293 = _T_292 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_294 = _T_290 | _T_293; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_296 = w2v_12 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_297 = _T_296 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_306 = w0v_13 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_307 = _T_306 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_309 = w1v_13 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_310 = _T_309 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_311 = _T_307 | _T_310; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_313 = w2v_13 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_314 = _T_313 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_323 = w0v_14 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_324 = _T_323 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_326 = w1v_14 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_327 = _T_326 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_328 = _T_324 | _T_327; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_330 = w2v_14 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_331 = _T_330 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_340 = w0v_15 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_341 = _T_340 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_343 = w1v_15 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_344 = _T_343 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_345 = _T_341 | _T_344; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_347 = w2v_15 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_348 = _T_347 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_357 = w0v_16 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_358 = _T_357 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_360 = w1v_16 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_361 = _T_360 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_362 = _T_358 | _T_361; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_364 = w2v_16 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_365 = _T_364 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_374 = w0v_17 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_375 = _T_374 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_377 = w1v_17 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_378 = _T_377 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_379 = _T_375 | _T_378; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_381 = w2v_17 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_382 = _T_381 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_391 = w0v_18 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_392 = _T_391 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_394 = w1v_18 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_395 = _T_394 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_396 = _T_392 | _T_395; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_398 = w2v_18 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_399 = _T_398 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_408 = w0v_19 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_409 = _T_408 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_411 = w1v_19 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_412 = _T_411 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_413 = _T_409 | _T_412; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_415 = w2v_19 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_416 = _T_415 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_425 = w0v_20 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_426 = _T_425 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_428 = w1v_20 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_429 = _T_428 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_430 = _T_426 | _T_429; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_432 = w2v_20 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_433 = _T_432 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_442 = w0v_21 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_443 = _T_442 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_445 = w1v_21 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_446 = _T_445 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_447 = _T_443 | _T_446; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_449 = w2v_21 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_450 = _T_449 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_459 = w0v_22 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_460 = _T_459 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_462 = w1v_22 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_463 = _T_462 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_464 = _T_460 | _T_463; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_466 = w2v_22 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_467 = _T_466 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_476 = w0v_23 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_477 = _T_476 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_479 = w1v_23 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_480 = _T_479 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_481 = _T_477 | _T_480; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_483 = w2v_23 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_484 = _T_483 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_493 = w0v_24 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_494 = _T_493 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_496 = w1v_24 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_497 = _T_496 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_498 = _T_494 | _T_497; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_500 = w2v_24 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_501 = _T_500 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_510 = w0v_25 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_511 = _T_510 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_513 = w1v_25 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_514 = _T_513 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_515 = _T_511 | _T_514; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_517 = w2v_25 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_518 = _T_517 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_527 = w0v_26 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_528 = _T_527 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_530 = w1v_26 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_531 = _T_530 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_532 = _T_528 | _T_531; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_534 = w2v_26 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_535 = _T_534 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_544 = w0v_27 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_545 = _T_544 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_547 = w1v_27 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_548 = _T_547 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_549 = _T_545 | _T_548; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_551 = w2v_27 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_552 = _T_551 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_561 = w0v_28 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_562 = _T_561 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_564 = w1v_28 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_565 = _T_564 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_566 = _T_562 | _T_565; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_568 = w2v_28 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_569 = _T_568 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_578 = w0v_29 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_579 = _T_578 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_581 = w1v_29 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_582 = _T_581 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_583 = _T_579 | _T_582; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_585 = w2v_29 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_586 = _T_585 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_595 = w0v_30 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_596 = _T_595 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_598 = w1v_30 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_599 = _T_598 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_600 = _T_596 | _T_599; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_602 = w2v_30 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_603 = _T_602 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  wire [31:0] _T_612 = w0v_31 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_613 = _T_612 & io_wd0; // @[el2_dec_gpr_ctl.scala 29:42]
  wire [31:0] _T_615 = w1v_31 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_616 = _T_615 & io_wd1; // @[el2_dec_gpr_ctl.scala 29:71]
  wire [31:0] _T_617 = _T_613 | _T_616; // @[el2_dec_gpr_ctl.scala 29:52]
  wire [31:0] _T_619 = w2v_31 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_620 = _T_619 & io_wd2; // @[el2_dec_gpr_ctl.scala 29:100]
  reg [31:0] gpr_out_1; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_2; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_3; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_4; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_5; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_6; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_7; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_8; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_9; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_10; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_11; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_12; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_13; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_14; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_15; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_16; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_17; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_18; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_19; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_20; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_21; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_22; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_23; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_24; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_25; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_26; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_27; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_28; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_29; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_30; // @[beh_lib.scala 356:14]
  reg [31:0] gpr_out_31; // @[beh_lib.scala 356:14]
  wire  _T_684 = io_raddr0 == 5'h1; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_686 = io_raddr0 == 5'h2; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_688 = io_raddr0 == 5'h3; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_690 = io_raddr0 == 5'h4; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_692 = io_raddr0 == 5'h5; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_694 = io_raddr0 == 5'h6; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_696 = io_raddr0 == 5'h7; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_698 = io_raddr0 == 5'h8; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_700 = io_raddr0 == 5'h9; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_702 = io_raddr0 == 5'ha; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_704 = io_raddr0 == 5'hb; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_706 = io_raddr0 == 5'hc; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_708 = io_raddr0 == 5'hd; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_710 = io_raddr0 == 5'he; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_712 = io_raddr0 == 5'hf; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_714 = io_raddr0 == 5'h10; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_716 = io_raddr0 == 5'h11; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_718 = io_raddr0 == 5'h12; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_720 = io_raddr0 == 5'h13; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_722 = io_raddr0 == 5'h14; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_724 = io_raddr0 == 5'h15; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_726 = io_raddr0 == 5'h16; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_728 = io_raddr0 == 5'h17; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_730 = io_raddr0 == 5'h18; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_732 = io_raddr0 == 5'h19; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_734 = io_raddr0 == 5'h1a; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_736 = io_raddr0 == 5'h1b; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_738 = io_raddr0 == 5'h1c; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_740 = io_raddr0 == 5'h1d; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_742 = io_raddr0 == 5'h1e; // @[el2_dec_gpr_ctl.scala 36:55]
  wire  _T_744 = io_raddr0 == 5'h1f; // @[el2_dec_gpr_ctl.scala 36:55]
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
  wire  _T_808 = io_raddr1 == 5'h1; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_810 = io_raddr1 == 5'h2; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_812 = io_raddr1 == 5'h3; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_814 = io_raddr1 == 5'h4; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_816 = io_raddr1 == 5'h5; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_818 = io_raddr1 == 5'h6; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_820 = io_raddr1 == 5'h7; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_822 = io_raddr1 == 5'h8; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_824 = io_raddr1 == 5'h9; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_826 = io_raddr1 == 5'ha; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_828 = io_raddr1 == 5'hb; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_830 = io_raddr1 == 5'hc; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_832 = io_raddr1 == 5'hd; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_834 = io_raddr1 == 5'he; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_836 = io_raddr1 == 5'hf; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_838 = io_raddr1 == 5'h10; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_840 = io_raddr1 == 5'h11; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_842 = io_raddr1 == 5'h12; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_844 = io_raddr1 == 5'h13; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_846 = io_raddr1 == 5'h14; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_848 = io_raddr1 == 5'h15; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_850 = io_raddr1 == 5'h16; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_852 = io_raddr1 == 5'h17; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_854 = io_raddr1 == 5'h18; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_856 = io_raddr1 == 5'h19; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_858 = io_raddr1 == 5'h1a; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_860 = io_raddr1 == 5'h1b; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_862 = io_raddr1 == 5'h1c; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_864 = io_raddr1 == 5'h1d; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_866 = io_raddr1 == 5'h1e; // @[el2_dec_gpr_ctl.scala 37:55]
  wire  _T_868 = io_raddr1 == 5'h1f; // @[el2_dec_gpr_ctl.scala 37:55]
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
  rvclkhdr rvclkhdr ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  rvclkhdr rvclkhdr_2 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_2_io_l1clk),
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en),
    .io_scan_mode(rvclkhdr_2_io_scan_mode)
  );
  rvclkhdr rvclkhdr_3 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_3_io_l1clk),
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en),
    .io_scan_mode(rvclkhdr_3_io_scan_mode)
  );
  rvclkhdr rvclkhdr_4 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_4_io_l1clk),
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en),
    .io_scan_mode(rvclkhdr_4_io_scan_mode)
  );
  rvclkhdr rvclkhdr_5 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_5_io_l1clk),
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en),
    .io_scan_mode(rvclkhdr_5_io_scan_mode)
  );
  rvclkhdr rvclkhdr_6 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_6_io_l1clk),
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en),
    .io_scan_mode(rvclkhdr_6_io_scan_mode)
  );
  rvclkhdr rvclkhdr_7 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_7_io_l1clk),
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en),
    .io_scan_mode(rvclkhdr_7_io_scan_mode)
  );
  rvclkhdr rvclkhdr_8 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_8_io_l1clk),
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en),
    .io_scan_mode(rvclkhdr_8_io_scan_mode)
  );
  rvclkhdr rvclkhdr_9 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_9_io_l1clk),
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en),
    .io_scan_mode(rvclkhdr_9_io_scan_mode)
  );
  rvclkhdr rvclkhdr_10 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_10_io_l1clk),
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en),
    .io_scan_mode(rvclkhdr_10_io_scan_mode)
  );
  rvclkhdr rvclkhdr_11 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_11_io_l1clk),
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en),
    .io_scan_mode(rvclkhdr_11_io_scan_mode)
  );
  rvclkhdr rvclkhdr_12 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_12_io_l1clk),
    .io_clk(rvclkhdr_12_io_clk),
    .io_en(rvclkhdr_12_io_en),
    .io_scan_mode(rvclkhdr_12_io_scan_mode)
  );
  rvclkhdr rvclkhdr_13 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_13_io_l1clk),
    .io_clk(rvclkhdr_13_io_clk),
    .io_en(rvclkhdr_13_io_en),
    .io_scan_mode(rvclkhdr_13_io_scan_mode)
  );
  rvclkhdr rvclkhdr_14 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_14_io_l1clk),
    .io_clk(rvclkhdr_14_io_clk),
    .io_en(rvclkhdr_14_io_en),
    .io_scan_mode(rvclkhdr_14_io_scan_mode)
  );
  rvclkhdr rvclkhdr_15 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_15_io_l1clk),
    .io_clk(rvclkhdr_15_io_clk),
    .io_en(rvclkhdr_15_io_en),
    .io_scan_mode(rvclkhdr_15_io_scan_mode)
  );
  rvclkhdr rvclkhdr_16 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_16_io_l1clk),
    .io_clk(rvclkhdr_16_io_clk),
    .io_en(rvclkhdr_16_io_en),
    .io_scan_mode(rvclkhdr_16_io_scan_mode)
  );
  rvclkhdr rvclkhdr_17 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_17_io_l1clk),
    .io_clk(rvclkhdr_17_io_clk),
    .io_en(rvclkhdr_17_io_en),
    .io_scan_mode(rvclkhdr_17_io_scan_mode)
  );
  rvclkhdr rvclkhdr_18 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_18_io_l1clk),
    .io_clk(rvclkhdr_18_io_clk),
    .io_en(rvclkhdr_18_io_en),
    .io_scan_mode(rvclkhdr_18_io_scan_mode)
  );
  rvclkhdr rvclkhdr_19 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_19_io_l1clk),
    .io_clk(rvclkhdr_19_io_clk),
    .io_en(rvclkhdr_19_io_en),
    .io_scan_mode(rvclkhdr_19_io_scan_mode)
  );
  rvclkhdr rvclkhdr_20 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_20_io_l1clk),
    .io_clk(rvclkhdr_20_io_clk),
    .io_en(rvclkhdr_20_io_en),
    .io_scan_mode(rvclkhdr_20_io_scan_mode)
  );
  rvclkhdr rvclkhdr_21 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_21_io_l1clk),
    .io_clk(rvclkhdr_21_io_clk),
    .io_en(rvclkhdr_21_io_en),
    .io_scan_mode(rvclkhdr_21_io_scan_mode)
  );
  rvclkhdr rvclkhdr_22 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_22_io_l1clk),
    .io_clk(rvclkhdr_22_io_clk),
    .io_en(rvclkhdr_22_io_en),
    .io_scan_mode(rvclkhdr_22_io_scan_mode)
  );
  rvclkhdr rvclkhdr_23 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_23_io_l1clk),
    .io_clk(rvclkhdr_23_io_clk),
    .io_en(rvclkhdr_23_io_en),
    .io_scan_mode(rvclkhdr_23_io_scan_mode)
  );
  rvclkhdr rvclkhdr_24 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_24_io_l1clk),
    .io_clk(rvclkhdr_24_io_clk),
    .io_en(rvclkhdr_24_io_en),
    .io_scan_mode(rvclkhdr_24_io_scan_mode)
  );
  rvclkhdr rvclkhdr_25 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_25_io_l1clk),
    .io_clk(rvclkhdr_25_io_clk),
    .io_en(rvclkhdr_25_io_en),
    .io_scan_mode(rvclkhdr_25_io_scan_mode)
  );
  rvclkhdr rvclkhdr_26 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_26_io_l1clk),
    .io_clk(rvclkhdr_26_io_clk),
    .io_en(rvclkhdr_26_io_en),
    .io_scan_mode(rvclkhdr_26_io_scan_mode)
  );
  rvclkhdr rvclkhdr_27 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_27_io_l1clk),
    .io_clk(rvclkhdr_27_io_clk),
    .io_en(rvclkhdr_27_io_en),
    .io_scan_mode(rvclkhdr_27_io_scan_mode)
  );
  rvclkhdr rvclkhdr_28 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_28_io_l1clk),
    .io_clk(rvclkhdr_28_io_clk),
    .io_en(rvclkhdr_28_io_en),
    .io_scan_mode(rvclkhdr_28_io_scan_mode)
  );
  rvclkhdr rvclkhdr_29 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_29_io_l1clk),
    .io_clk(rvclkhdr_29_io_clk),
    .io_en(rvclkhdr_29_io_en),
    .io_scan_mode(rvclkhdr_29_io_scan_mode)
  );
  rvclkhdr rvclkhdr_30 ( // @[beh_lib.scala 350:21]
    .io_l1clk(rvclkhdr_30_io_l1clk),
    .io_clk(rvclkhdr_30_io_clk),
    .io_en(rvclkhdr_30_io_en),
    .io_scan_mode(rvclkhdr_30_io_scan_mode)
  );
  assign io_rd0 = _T_805 | _T_776; // @[el2_dec_gpr_ctl.scala 21:15 el2_dec_gpr_ctl.scala 36:15]
  assign io_rd1 = _T_929 | _T_900; // @[el2_dec_gpr_ctl.scala 22:15 el2_dec_gpr_ctl.scala 37:15]
  assign rvclkhdr_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_io_en = gpr_wr_en[1]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_1_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_1_io_en = gpr_wr_en[2]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_2_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_2_io_en = gpr_wr_en[3]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_3_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_3_io_en = gpr_wr_en[4]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_4_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_4_io_en = gpr_wr_en[5]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_5_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_5_io_en = gpr_wr_en[6]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_6_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_6_io_en = gpr_wr_en[7]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_7_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_7_io_en = gpr_wr_en[8]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_8_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_8_io_en = gpr_wr_en[9]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_9_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_9_io_en = gpr_wr_en[10]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_10_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_10_io_en = gpr_wr_en[11]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_11_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_11_io_en = gpr_wr_en[12]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_12_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_12_io_en = gpr_wr_en[13]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_13_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_13_io_en = gpr_wr_en[14]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_14_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_14_io_en = gpr_wr_en[15]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_15_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_15_io_en = gpr_wr_en[16]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_16_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_16_io_en = gpr_wr_en[17]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_17_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_17_io_en = gpr_wr_en[18]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_17_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_18_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_18_io_en = gpr_wr_en[19]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_18_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_19_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_19_io_en = gpr_wr_en[20]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_19_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_20_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_20_io_en = gpr_wr_en[21]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_20_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_21_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_21_io_en = gpr_wr_en[22]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_21_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_22_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_22_io_en = gpr_wr_en[23]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_22_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_23_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_23_io_en = gpr_wr_en[24]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_23_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_24_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_24_io_en = gpr_wr_en[25]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_24_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_25_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_25_io_en = gpr_wr_en[26]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_25_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_26_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_26_io_en = gpr_wr_en[27]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_26_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_27_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_27_io_en = gpr_wr_en[28]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_27_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_28_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_28_io_en = gpr_wr_en[29]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_28_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_29_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_29_io_en = gpr_wr_en[30]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_29_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
  assign rvclkhdr_30_io_clk = clock; // @[beh_lib.scala 352:16]
  assign rvclkhdr_30_io_en = gpr_wr_en[31]; // @[beh_lib.scala 353:15]
  assign rvclkhdr_30_io_scan_mode = io_scan_mode; // @[beh_lib.scala 354:22]
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
      gpr_out_1 <= _T_107 | _T_110;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_2 <= 32'h0;
    end else begin
      gpr_out_2 <= _T_124 | _T_127;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_3 <= 32'h0;
    end else begin
      gpr_out_3 <= _T_141 | _T_144;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_4 <= 32'h0;
    end else begin
      gpr_out_4 <= _T_158 | _T_161;
    end
  end
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_5 <= 32'h0;
    end else begin
      gpr_out_5 <= _T_175 | _T_178;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_6 <= 32'h0;
    end else begin
      gpr_out_6 <= _T_192 | _T_195;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_7 <= 32'h0;
    end else begin
      gpr_out_7 <= _T_209 | _T_212;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_8 <= 32'h0;
    end else begin
      gpr_out_8 <= _T_226 | _T_229;
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_9 <= 32'h0;
    end else begin
      gpr_out_9 <= _T_243 | _T_246;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_10 <= 32'h0;
    end else begin
      gpr_out_10 <= _T_260 | _T_263;
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_11 <= 32'h0;
    end else begin
      gpr_out_11 <= _T_277 | _T_280;
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_12 <= 32'h0;
    end else begin
      gpr_out_12 <= _T_294 | _T_297;
    end
  end
  always @(posedge rvclkhdr_12_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_13 <= 32'h0;
    end else begin
      gpr_out_13 <= _T_311 | _T_314;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_14 <= 32'h0;
    end else begin
      gpr_out_14 <= _T_328 | _T_331;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_15 <= 32'h0;
    end else begin
      gpr_out_15 <= _T_345 | _T_348;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_16 <= 32'h0;
    end else begin
      gpr_out_16 <= _T_362 | _T_365;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_17 <= 32'h0;
    end else begin
      gpr_out_17 <= _T_379 | _T_382;
    end
  end
  always @(posedge rvclkhdr_17_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_18 <= 32'h0;
    end else begin
      gpr_out_18 <= _T_396 | _T_399;
    end
  end
  always @(posedge rvclkhdr_18_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_19 <= 32'h0;
    end else begin
      gpr_out_19 <= _T_413 | _T_416;
    end
  end
  always @(posedge rvclkhdr_19_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_20 <= 32'h0;
    end else begin
      gpr_out_20 <= _T_430 | _T_433;
    end
  end
  always @(posedge rvclkhdr_20_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_21 <= 32'h0;
    end else begin
      gpr_out_21 <= _T_447 | _T_450;
    end
  end
  always @(posedge rvclkhdr_21_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_22 <= 32'h0;
    end else begin
      gpr_out_22 <= _T_464 | _T_467;
    end
  end
  always @(posedge rvclkhdr_22_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_23 <= 32'h0;
    end else begin
      gpr_out_23 <= _T_481 | _T_484;
    end
  end
  always @(posedge rvclkhdr_23_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_24 <= 32'h0;
    end else begin
      gpr_out_24 <= _T_498 | _T_501;
    end
  end
  always @(posedge rvclkhdr_24_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_25 <= 32'h0;
    end else begin
      gpr_out_25 <= _T_515 | _T_518;
    end
  end
  always @(posedge rvclkhdr_25_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_26 <= 32'h0;
    end else begin
      gpr_out_26 <= _T_532 | _T_535;
    end
  end
  always @(posedge rvclkhdr_26_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_27 <= 32'h0;
    end else begin
      gpr_out_27 <= _T_549 | _T_552;
    end
  end
  always @(posedge rvclkhdr_27_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_28 <= 32'h0;
    end else begin
      gpr_out_28 <= _T_566 | _T_569;
    end
  end
  always @(posedge rvclkhdr_28_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_29 <= 32'h0;
    end else begin
      gpr_out_29 <= _T_583 | _T_586;
    end
  end
  always @(posedge rvclkhdr_29_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_30 <= 32'h0;
    end else begin
      gpr_out_30 <= _T_600 | _T_603;
    end
  end
  always @(posedge rvclkhdr_30_io_l1clk or posedge reset) begin
    if (reset) begin
      gpr_out_31 <= 32'h0;
    end else begin
      gpr_out_31 <= _T_617 | _T_620;
    end
  end
endmodule
module el2_dec_trigger(
  input  [30:0] io_dec_i0_pc_d,
  output [3:0]  io_dec_i0_trigger_match_d
);
  wire [31:0] dec_i0_match_data_0 = {io_dec_i0_pc_d,1'h1}; // @[Cat.scala 29:58]
  wire  _T_165 = ~dec_i0_match_data_0[1]; // @[el2_lib.scala 219:79]
  wire  _T_172 = ~dec_i0_match_data_0[2]; // @[el2_lib.scala 219:79]
  wire  _T_179 = ~dec_i0_match_data_0[3]; // @[el2_lib.scala 219:79]
  wire  _T_186 = ~dec_i0_match_data_0[4]; // @[el2_lib.scala 219:79]
  wire  _T_193 = ~dec_i0_match_data_0[5]; // @[el2_lib.scala 219:79]
  wire  _T_200 = ~dec_i0_match_data_0[6]; // @[el2_lib.scala 219:79]
  wire  _T_207 = ~dec_i0_match_data_0[7]; // @[el2_lib.scala 219:79]
  wire  _T_214 = ~dec_i0_match_data_0[8]; // @[el2_lib.scala 219:79]
  wire  _T_221 = ~dec_i0_match_data_0[9]; // @[el2_lib.scala 219:79]
  wire  _T_228 = ~dec_i0_match_data_0[10]; // @[el2_lib.scala 219:79]
  wire  _T_235 = ~dec_i0_match_data_0[11]; // @[el2_lib.scala 219:79]
  wire  _T_242 = ~dec_i0_match_data_0[12]; // @[el2_lib.scala 219:79]
  wire  _T_249 = ~dec_i0_match_data_0[13]; // @[el2_lib.scala 219:79]
  wire  _T_256 = ~dec_i0_match_data_0[14]; // @[el2_lib.scala 219:79]
  wire  _T_263 = ~dec_i0_match_data_0[15]; // @[el2_lib.scala 219:79]
  wire  _T_270 = ~dec_i0_match_data_0[16]; // @[el2_lib.scala 219:79]
  wire  _T_277 = ~dec_i0_match_data_0[17]; // @[el2_lib.scala 219:79]
  wire  _T_284 = ~dec_i0_match_data_0[18]; // @[el2_lib.scala 219:79]
  wire  _T_291 = ~dec_i0_match_data_0[19]; // @[el2_lib.scala 219:79]
  wire  _T_298 = ~dec_i0_match_data_0[20]; // @[el2_lib.scala 219:79]
  wire  _T_305 = ~dec_i0_match_data_0[21]; // @[el2_lib.scala 219:79]
  wire  _T_312 = ~dec_i0_match_data_0[22]; // @[el2_lib.scala 219:79]
  wire  _T_319 = ~dec_i0_match_data_0[23]; // @[el2_lib.scala 219:79]
  wire  _T_326 = ~dec_i0_match_data_0[24]; // @[el2_lib.scala 219:79]
  wire  _T_333 = ~dec_i0_match_data_0[25]; // @[el2_lib.scala 219:79]
  wire  _T_340 = ~dec_i0_match_data_0[26]; // @[el2_lib.scala 219:79]
  wire  _T_347 = ~dec_i0_match_data_0[27]; // @[el2_lib.scala 219:79]
  wire  _T_354 = ~dec_i0_match_data_0[28]; // @[el2_lib.scala 219:79]
  wire  _T_361 = ~dec_i0_match_data_0[29]; // @[el2_lib.scala 219:79]
  wire  _T_368 = ~dec_i0_match_data_0[30]; // @[el2_lib.scala 219:79]
  wire  _T_375 = ~dec_i0_match_data_0[31]; // @[el2_lib.scala 219:79]
  wire [7:0] _T_383 = {_T_207,_T_200,_T_193,_T_186,_T_179,_T_172,_T_165,dec_i0_match_data_0[0]}; // @[el2_lib.scala 220:14]
  wire [15:0] _T_391 = {_T_263,_T_256,_T_249,_T_242,_T_235,_T_228,_T_221,_T_214,_T_383}; // @[el2_lib.scala 220:14]
  wire [7:0] _T_398 = {_T_319,_T_312,_T_305,_T_298,_T_291,_T_284,_T_277,_T_270}; // @[el2_lib.scala 220:14]
  wire [31:0] _T_407 = {_T_375,_T_368,_T_361,_T_354,_T_347,_T_340,_T_333,_T_326,_T_398,_T_391}; // @[el2_lib.scala 220:14]
  wire  _T_408 = &_T_407; // @[el2_lib.scala 220:21]
  wire [2:0] _T_1197 = {_T_408,_T_408,_T_408}; // @[Cat.scala 29:58]
  assign io_dec_i0_trigger_match_d = {_T_1197,_T_408}; // @[el2_dec_trigger.scala 15:29]
endmodule
module el2_dec(
  input         clock,
  input         reset,
  input         io_free_clk,
  input         io_active_clk,
  input         io_lsu_fastint_stall_any,
  output        io_dec_extint_stall,
  output        io_dec_i0_decode_d,
  output        io_dec_pause_state_cg,
  input  [31:0] io_rst_vec,
  input         io_nmi_int,
  input  [31:0] io_nmi_vec,
  input         io_i_cpu_halt_req,
  input         io_i_cpu_run_req,
  output        io_o_cpu_halt_status,
  output        io_o_cpu_halt_ack,
  output        io_o_cpu_run_ack,
  output        io_o_debug_mode_status,
  input  [31:0] io_core_id,
  input         io_mpc_debug_halt_req,
  input         io_mpc_debug_run_req,
  input         io_mpc_reset_run_req,
  output        io_mpc_debug_halt_ack,
  output        io_mpc_debug_run_ack,
  output        io_debug_brkpt_status,
  input         io_exu_pmu_i0_br_misp,
  input         io_exu_pmu_i0_br_ataken,
  input         io_exu_pmu_i0_pc4,
  input         io_lsu_nonblock_load_valid_m,
  input  [2:0]  io_lsu_nonblock_load_tag_m,
  input         io_lsu_nonblock_load_inv_r,
  input  [2:0]  io_lsu_nonblock_load_inv_tag_r,
  input         io_lsu_nonblock_load_data_valid,
  input         io_lsu_nonblock_load_data_error,
  input  [2:0]  io_lsu_nonblock_load_data_tag,
  input  [31:0] io_lsu_nonblock_load_data,
  input         io_lsu_pmu_bus_trxn,
  input         io_lsu_pmu_bus_misaligned,
  input         io_lsu_pmu_bus_error,
  input         io_lsu_pmu_bus_busy,
  input         io_lsu_pmu_misaligned_m,
  input         io_lsu_pmu_load_external_m,
  input         io_lsu_pmu_store_external_m,
  input         io_dma_pmu_dccm_read,
  input         io_dma_pmu_dccm_write,
  input         io_dma_pmu_any_read,
  input         io_dma_pmu_any_write,
  input  [31:0] io_lsu_fir_addr,
  input  [1:0]  io_lsu_fir_error,
  input         io_ifu_pmu_instr_aligned,
  input         io_ifu_pmu_fetch_stall,
  input         io_ifu_pmu_ic_miss,
  input         io_ifu_pmu_ic_hit,
  input         io_ifu_pmu_bus_error,
  input         io_ifu_pmu_bus_busy,
  input         io_ifu_pmu_bus_trxn,
  input         io_ifu_ic_error_start,
  input         io_ifu_iccm_rd_ecc_single_err,
  input  [3:0]  io_lsu_trigger_match_m,
  input         io_dbg_cmd_valid,
  input         io_dbg_cmd_write,
  input  [1:0]  io_dbg_cmd_type,
  input  [31:0] io_dbg_cmd_addr,
  input  [1:0]  io_dbg_cmd_wrdata,
  input         io_ifu_i0_icaf,
  input  [1:0]  io_ifu_i0_icaf_type,
  input         io_ifu_i0_icaf_f1,
  input         io_ifu_i0_dbecc,
  input         io_lsu_idle_any,
  input         io_i0_brp_valid,
  input  [11:0] io_i0_brp_toffset,
  input  [1:0]  io_i0_brp_hist,
  input         io_i0_brp_br_error,
  input         io_i0_brp_br_start_error,
  input         io_i0_brp_bank,
  input  [30:0] io_i0_brp_prett,
  input         io_i0_brp_way,
  input         io_i0_brp_ret,
  input  [8:0]  io_ifu_i0_bp_index,
  input  [7:0]  io_ifu_i0_bp_fghr,
  input  [4:0]  io_ifu_i0_bp_btag,
  input         io_lsu_error_pkt_r_exc_valid,
  input         io_lsu_error_pkt_r_single_ecc_error,
  input         io_lsu_error_pkt_r_inst_type,
  input         io_lsu_error_pkt_r_exc_type,
  input         io_lsu_error_pkt_r_mscause,
  input         io_lsu_error_pkt_r_addr,
  input         io_lsu_single_ecc_error_incr,
  input         io_lsu_imprecise_error_load_any,
  input         io_lsu_imprecise_error_store_any,
  input  [31:0] io_lsu_imprecise_error_addr_any,
  input  [31:0] io_exu_div_result,
  input         io_exu_div_wren,
  input  [31:0] io_exu_csr_rs1_x,
  input  [31:0] io_lsu_result_m,
  input  [31:0] io_lsu_result_corr_r,
  input         io_lsu_load_stall_any,
  input         io_lsu_store_stall_any,
  input         io_dma_dccm_stall_any,
  input         io_dma_iccm_stall_any,
  input         io_iccm_dma_sb_error,
  input         io_exu_flush_final,
  input  [31:0] io_exu_npc_r,
  input  [31:0] io_exu_i0_result_x,
  input         io_ifu_i0_valid,
  input  [31:0] io_ifu_i0_instr,
  input  [31:0] io_ifu_i0_pc,
  input         io_ifu_i0_pc4,
  input  [31:0] io_exu_i0_pc_x,
  input         io_mexintpend,
  input         io_timer_int,
  input         io_soft_int,
  input  [7:0]  io_pic_claimid,
  input  [3:0]  io_pic_pl,
  input         io_mhwakeup,
  output [3:0]  io_dec_tlu_meicurpl,
  output [3:0]  io_dec_tlu_meipt,
  input  [69:0] io_ifu_ic_debug_rd_data,
  input         io_ifu_ic_debug_rd_data_valid,
  output [70:0] io_dec_tlu_ic_diag_pkt_icache_wrdata,
  output [16:0] io_dec_tlu_ic_diag_pkt_icache_dicawics,
  output        io_dec_tlu_ic_diag_pkt_icache_rd_valid,
  output        io_dec_tlu_ic_diag_pkt_icache_wr_valid,
  input         io_dbg_halt_req,
  input         io_dbg_resume_req,
  input         io_ifu_miss_state_idle,
  output        io_dec_tlu_dbg_halted,
  output        io_dec_tlu_debug_mode,
  output        io_dec_tlu_resume_ack,
  output        io_dec_tlu_flush_noredir_r,
  output        io_dec_tlu_mpc_halted_only,
  output        io_dec_tlu_flush_leak_one_r,
  output        io_dec_tlu_flush_err_r,
  output [31:0] io_dec_tlu_meihap,
  output        io_dec_debug_wdata_rs1_d,
  output [31:0] io_dec_dbg_rddata,
  output        io_dec_dbg_cmd_done,
  output        io_dec_dbg_cmd_fail,
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
  output        io_dec_tlu_force_halt,
  input  [1:0]  io_exu_i0_br_hist_r,
  input         io_exu_i0_br_error_r,
  input         io_exu_i0_br_start_error_r,
  input         io_exu_i0_br_valid_r,
  input         io_exu_i0_br_mp_r,
  input         io_exu_i0_br_middle_r,
  input         io_exu_i0_br_way_r,
  output        io_dec_i0_rs1_en_d,
  output        io_dec_i0_rs2_en_d,
  output [31:0] io_gpr_i0_rs1_d,
  output [31:0] io_gpr_i0_rs2_d,
  output [31:0] io_dec_i0_immed_d,
  output [12:0] io_dec_i0_br_immed_d,
  output        io_i0_ap_land,
  output        io_i0_ap_lor,
  output        io_i0_ap_lxor,
  output        io_i0_ap_sll,
  output        io_i0_ap_srl,
  output        io_i0_ap_sra,
  output        io_i0_ap_beq,
  output        io_i0_ap_bne,
  output        io_i0_ap_blt,
  output        io_i0_ap_bge,
  output        io_i0_ap_add,
  output        io_i0_ap_sub,
  output        io_i0_ap_slt,
  output        io_i0_ap_unsign,
  output        io_i0_ap_jal,
  output        io_i0_ap_predict_t,
  output        io_i0_ap_predict_nt,
  output        io_i0_ap_csr_write,
  output        io_i0_ap_csr_imm,
  output        io_dec_i0_alu_decode_d,
  output        io_dec_i0_select_pc_d,
  output [31:0] io_dec_i0_pc_d,
  output [1:0]  io_dec_i0_rs1_bypass_en_d,
  output [1:0]  io_dec_i0_rs2_bypass_en_d,
  output [31:0] io_dec_i0_rs1_bypass_data_d,
  output [31:0] io_dec_i0_rs2_bypass_data_d,
  output        io_lsu_p_fast_int,
  output        io_lsu_p_by,
  output        io_lsu_p_half,
  output        io_lsu_p_word,
  output        io_lsu_p_dword,
  output        io_lsu_p_load,
  output        io_lsu_p_store,
  output        io_lsu_p_unsign,
  output        io_lsu_p_dma,
  output        io_lsu_p_store_data_bypass_d,
  output        io_lsu_p_load_ldst_bypass_d,
  output        io_lsu_p_store_data_bypass_m,
  output        io_lsu_p_valid,
  output        io_mul_p_valid,
  output        io_mul_p_rs1_sign,
  output        io_mul_p_rs2_sign,
  output        io_mul_p_low,
  output        io_mul_p_bext,
  output        io_mul_p_bdep,
  output        io_mul_p_clmul,
  output        io_mul_p_clmulh,
  output        io_mul_p_clmulr,
  output        io_mul_p_grev,
  output        io_mul_p_shfl,
  output        io_mul_p_unshfl,
  output        io_mul_p_crc32_b,
  output        io_mul_p_crc32_h,
  output        io_mul_p_crc32_w,
  output        io_mul_p_crc32c_b,
  output        io_mul_p_crc32c_h,
  output        io_mul_p_crc32c_w,
  output        io_mul_p_bfp,
  output        io_div_p_valid,
  output        io_div_p_unsign,
  output        io_div_p_rem,
  output        io_dec_div_cancel,
  output [11:0] io_dec_lsu_offset_d,
  output        io_dec_csr_ren_d,
  output        io_dec_tlu_flush_lower_r,
  output [31:0] io_dec_tlu_flush_path_r,
  output        io_dec_tlu_i0_kill_writeb_r,
  output        io_dec_tlu_fence_i_r,
  output [31:0] io_pred_correct_npc_x,
  output        io_dec_tlu_br0_r_pkt_valid,
  output [1:0]  io_dec_tlu_br0_r_pkt_hist,
  output        io_dec_tlu_br0_r_pkt_br_error,
  output        io_dec_tlu_br0_r_pkt_br_start_error,
  output        io_dec_tlu_br0_r_pkt_way,
  output        io_dec_tlu_br0_r_pkt_middle,
  output        io_dec_tlu_perfcnt0,
  output        io_dec_tlu_perfcnt1,
  output        io_dec_tlu_perfcnt2,
  output        io_dec_tlu_perfcnt3,
  output        io_dec_i0_predict_p_d_misp,
  output        io_dec_i0_predict_p_d_ataken,
  output        io_dec_i0_predict_p_d_boffset,
  output        io_dec_i0_predict_p_d_pc4,
  output [1:0]  io_dec_i0_predict_p_d_hist,
  output [11:0] io_dec_i0_predict_p_d_toffset,
  output        io_dec_i0_predict_p_d_valid,
  output        io_dec_i0_predict_p_d_br_error,
  output        io_dec_i0_predict_p_d_br_start_error,
  output [30:0] io_dec_i0_predict_p_d_prett,
  output        io_dec_i0_predict_p_d_pcall,
  output        io_dec_i0_predict_p_d_pret,
  output        io_dec_i0_predict_p_d_pja,
  output        io_dec_i0_predict_p_d_way,
  output [7:0]  io_i0_predict_fghr_d,
  output [8:0]  io_i0_predict_index_d,
  output [4:0]  io_i0_predict_btag_d,
  output        io_dec_lsu_valid_raw_d,
  output [31:0] io_dec_tlu_mrac_ff,
  output [1:0]  io_dec_data_en,
  output [1:0]  io_dec_ctl_en,
  input  [15:0] io_ifu_i0_cinst,
  output        io_dec_tlu_external_ldfwd_disable,
  output        io_dec_tlu_sideeffect_posted_disable,
  output        io_dec_tlu_core_ecc_disable,
  output        io_dec_tlu_bpred_disable,
  output        io_dec_tlu_wb_coalescing_disable,
  output [2:0]  io_dec_tlu_dma_qos_prty,
  output        io_dec_tlu_misc_clk_override,
  output        io_dec_tlu_ifu_clk_override,
  output        io_dec_tlu_lsu_clk_override,
  output        io_dec_tlu_bus_clk_override,
  output        io_dec_tlu_pic_clk_override,
  output        io_dec_tlu_dccm_clk_override,
  output        io_dec_tlu_icm_clk_override,
  output        io_dec_tlu_i0_commit_cmt,
  input         io_scan_mode
);
  wire  instbuff_io_dbg_cmd_valid; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dbg_cmd_write; // @[el2_dec.scala 352:24]
  wire [1:0] instbuff_io_dbg_cmd_type; // @[el2_dec.scala 352:24]
  wire [31:0] instbuff_io_dbg_cmd_addr; // @[el2_dec.scala 352:24]
  wire  instbuff_io_i0_brp_valid; // @[el2_dec.scala 352:24]
  wire [11:0] instbuff_io_i0_brp_toffset; // @[el2_dec.scala 352:24]
  wire [1:0] instbuff_io_i0_brp_hist; // @[el2_dec.scala 352:24]
  wire  instbuff_io_i0_brp_br_error; // @[el2_dec.scala 352:24]
  wire  instbuff_io_i0_brp_br_start_error; // @[el2_dec.scala 352:24]
  wire [30:0] instbuff_io_i0_brp_prett; // @[el2_dec.scala 352:24]
  wire  instbuff_io_i0_brp_way; // @[el2_dec.scala 352:24]
  wire  instbuff_io_i0_brp_ret; // @[el2_dec.scala 352:24]
  wire [7:0] instbuff_io_ifu_i0_bp_index; // @[el2_dec.scala 352:24]
  wire [7:0] instbuff_io_ifu_i0_bp_fghr; // @[el2_dec.scala 352:24]
  wire [4:0] instbuff_io_ifu_i0_bp_btag; // @[el2_dec.scala 352:24]
  wire  instbuff_io_ifu_i0_valid; // @[el2_dec.scala 352:24]
  wire  instbuff_io_ifu_i0_icaf; // @[el2_dec.scala 352:24]
  wire  instbuff_io_ifu_i0_dbecc; // @[el2_dec.scala 352:24]
  wire [31:0] instbuff_io_ifu_i0_instr; // @[el2_dec.scala 352:24]
  wire [30:0] instbuff_io_ifu_i0_pc; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_ib0_valid_d; // @[el2_dec.scala 352:24]
  wire [31:0] instbuff_io_dec_i0_instr_d; // @[el2_dec.scala 352:24]
  wire [30:0] instbuff_io_dec_i0_pc_d; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_brp_valid; // @[el2_dec.scala 352:24]
  wire [11:0] instbuff_io_dec_i0_brp_toffset; // @[el2_dec.scala 352:24]
  wire [1:0] instbuff_io_dec_i0_brp_hist; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_brp_br_error; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_brp_br_start_error; // @[el2_dec.scala 352:24]
  wire [30:0] instbuff_io_dec_i0_brp_prett; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_brp_way; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_brp_ret; // @[el2_dec.scala 352:24]
  wire [7:0] instbuff_io_dec_i0_bp_index; // @[el2_dec.scala 352:24]
  wire [7:0] instbuff_io_dec_i0_bp_fghr; // @[el2_dec.scala 352:24]
  wire [4:0] instbuff_io_dec_i0_bp_btag; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_icaf_d; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_i0_dbecc_d; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_debug_wdata_rs1_d; // @[el2_dec.scala 352:24]
  wire  instbuff_io_dec_debug_fence_d; // @[el2_dec.scala 352:24]
  wire  decode_clock; // @[el2_dec.scala 353:22]
  wire  decode_reset; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_extint_stall; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_nonblock_load_valid_m; // @[el2_dec.scala 353:22]
  wire [2:0] decode_io_lsu_nonblock_load_tag_m; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_nonblock_load_inv_r; // @[el2_dec.scala 353:22]
  wire [2:0] decode_io_lsu_nonblock_load_inv_tag_r; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_nonblock_load_data_valid; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_nonblock_load_data_error; // @[el2_dec.scala 353:22]
  wire [2:0] decode_io_lsu_nonblock_load_data_tag; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_lsu_nonblock_load_data; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_debug_fence_d; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dbg_cmd_wrdata; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_icaf_d; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_dbecc_d; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_brp_valid; // @[el2_dec.scala 353:22]
  wire [11:0] decode_io_dec_i0_brp_toffset; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dec_i0_brp_hist; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_brp_br_error; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_brp_br_start_error; // @[el2_dec.scala 353:22]
  wire [30:0] decode_io_dec_i0_brp_prett; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_brp_way; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_brp_ret; // @[el2_dec.scala 353:22]
  wire [7:0] decode_io_dec_i0_bp_index; // @[el2_dec.scala 353:22]
  wire [7:0] decode_io_dec_i0_bp_fghr; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_dec_i0_bp_btag; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_idle_any; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_load_stall_any; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_store_stall_any; // @[el2_dec.scala 353:22]
  wire  decode_io_dma_dccm_stall_any; // @[el2_dec.scala 353:22]
  wire  decode_io_exu_div_wren; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_pc4_d; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_lsu_result_m; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_lsu_result_corr_r; // @[el2_dec.scala 353:22]
  wire  decode_io_exu_flush_final; // @[el2_dec.scala 353:22]
  wire [30:0] decode_io_exu_i0_pc_x; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_dec_i0_instr_d; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_ib0_valid_d; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_exu_i0_result_x; // @[el2_dec.scala 353:22]
  wire  decode_io_free_clk; // @[el2_dec.scala 353:22]
  wire  decode_io_active_clk; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_rs1_en_d; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_rs2_en_d; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_dec_i0_rs1_d; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_dec_i0_rs2_d; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_dec_i0_immed_d; // @[el2_dec.scala 353:22]
  wire [11:0] decode_io_dec_i0_br_immed_d; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_land; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_lor; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_lxor; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_sll; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_srl; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_sra; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_beq; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_bne; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_blt; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_bge; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_add; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_sub; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_slt; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_unsign; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_jal; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_predict_t; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_predict_nt; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_csr_write; // @[el2_dec.scala 353:22]
  wire  decode_io_i0_ap_csr_imm; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_decode_d; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_alu_decode_d; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_dec_i0_rs1_bypass_data_d; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_dec_i0_rs2_bypass_data_d; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_dec_i0_waddr_r; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_wen_r; // @[el2_dec.scala 353:22]
  wire [31:0] decode_io_dec_i0_wdata_r; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_select_pc_d; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dec_i0_rs1_bypass_en_d; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dec_i0_rs2_bypass_en_d; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_fast_int; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_by; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_half; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_word; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_load; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_store; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_unsign; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_store_data_bypass_d; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_load_ldst_bypass_d; // @[el2_dec.scala 353:22]
  wire  decode_io_lsu_p_valid; // @[el2_dec.scala 353:22]
  wire  decode_io_mul_p_valid; // @[el2_dec.scala 353:22]
  wire  decode_io_mul_p_rs1_sign; // @[el2_dec.scala 353:22]
  wire  decode_io_mul_p_rs2_sign; // @[el2_dec.scala 353:22]
  wire  decode_io_mul_p_low; // @[el2_dec.scala 353:22]
  wire  decode_io_div_p_valid; // @[el2_dec.scala 353:22]
  wire  decode_io_div_p_unsign; // @[el2_dec.scala 353:22]
  wire  decode_io_div_p_rem; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_div_waddr_wb; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_div_cancel; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_lsu_valid_raw_d; // @[el2_dec.scala 353:22]
  wire [11:0] decode_io_dec_lsu_offset_d; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_csr_ren_d; // @[el2_dec.scala 353:22]
  wire [30:0] decode_io_pred_correct_npc_x; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_pc4; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dec_i0_predict_p_d_hist; // @[el2_dec.scala 353:22]
  wire [11:0] decode_io_dec_i0_predict_p_d_toffset; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_valid; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_br_error; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_br_start_error; // @[el2_dec.scala 353:22]
  wire [30:0] decode_io_dec_i0_predict_p_d_prett; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_pcall; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_pret; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_pja; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_i0_predict_p_d_way; // @[el2_dec.scala 353:22]
  wire [7:0] decode_io_i0_predict_fghr_d; // @[el2_dec.scala 353:22]
  wire [7:0] decode_io_i0_predict_index_d; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_i0_predict_btag_d; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dec_data_en; // @[el2_dec.scala 353:22]
  wire [1:0] decode_io_dec_ctl_en; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_nonblock_load_wen; // @[el2_dec.scala 353:22]
  wire [4:0] decode_io_dec_nonblock_load_waddr; // @[el2_dec.scala 353:22]
  wire  decode_io_dec_div_active; // @[el2_dec.scala 353:22]
  wire  decode_io_scan_mode; // @[el2_dec.scala 353:22]
  wire  gpr_clock; // @[el2_dec.scala 354:19]
  wire  gpr_reset; // @[el2_dec.scala 354:19]
  wire [4:0] gpr_io_raddr0; // @[el2_dec.scala 354:19]
  wire [4:0] gpr_io_raddr1; // @[el2_dec.scala 354:19]
  wire  gpr_io_wen0; // @[el2_dec.scala 354:19]
  wire [4:0] gpr_io_waddr0; // @[el2_dec.scala 354:19]
  wire [31:0] gpr_io_wd0; // @[el2_dec.scala 354:19]
  wire  gpr_io_wen1; // @[el2_dec.scala 354:19]
  wire [4:0] gpr_io_waddr1; // @[el2_dec.scala 354:19]
  wire [31:0] gpr_io_wd1; // @[el2_dec.scala 354:19]
  wire  gpr_io_wen2; // @[el2_dec.scala 354:19]
  wire [4:0] gpr_io_waddr2; // @[el2_dec.scala 354:19]
  wire [31:0] gpr_io_wd2; // @[el2_dec.scala 354:19]
  wire [31:0] gpr_io_rd0; // @[el2_dec.scala 354:19]
  wire [31:0] gpr_io_rd1; // @[el2_dec.scala 354:19]
  wire  gpr_io_scan_mode; // @[el2_dec.scala 354:19]
  wire [30:0] dec_trigger_io_dec_i0_pc_d; // @[el2_dec.scala 356:27]
  wire [3:0] dec_trigger_io_dec_i0_trigger_match_d; // @[el2_dec.scala 356:27]
  el2_dec_ib_ctl instbuff ( // @[el2_dec.scala 352:24]
    .io_dbg_cmd_valid(instbuff_io_dbg_cmd_valid),
    .io_dbg_cmd_write(instbuff_io_dbg_cmd_write),
    .io_dbg_cmd_type(instbuff_io_dbg_cmd_type),
    .io_dbg_cmd_addr(instbuff_io_dbg_cmd_addr),
    .io_i0_brp_valid(instbuff_io_i0_brp_valid),
    .io_i0_brp_toffset(instbuff_io_i0_brp_toffset),
    .io_i0_brp_hist(instbuff_io_i0_brp_hist),
    .io_i0_brp_br_error(instbuff_io_i0_brp_br_error),
    .io_i0_brp_br_start_error(instbuff_io_i0_brp_br_start_error),
    .io_i0_brp_prett(instbuff_io_i0_brp_prett),
    .io_i0_brp_way(instbuff_io_i0_brp_way),
    .io_i0_brp_ret(instbuff_io_i0_brp_ret),
    .io_ifu_i0_bp_index(instbuff_io_ifu_i0_bp_index),
    .io_ifu_i0_bp_fghr(instbuff_io_ifu_i0_bp_fghr),
    .io_ifu_i0_bp_btag(instbuff_io_ifu_i0_bp_btag),
    .io_ifu_i0_valid(instbuff_io_ifu_i0_valid),
    .io_ifu_i0_icaf(instbuff_io_ifu_i0_icaf),
    .io_ifu_i0_dbecc(instbuff_io_ifu_i0_dbecc),
    .io_ifu_i0_instr(instbuff_io_ifu_i0_instr),
    .io_ifu_i0_pc(instbuff_io_ifu_i0_pc),
    .io_dec_ib0_valid_d(instbuff_io_dec_ib0_valid_d),
    .io_dec_i0_instr_d(instbuff_io_dec_i0_instr_d),
    .io_dec_i0_pc_d(instbuff_io_dec_i0_pc_d),
    .io_dec_i0_brp_valid(instbuff_io_dec_i0_brp_valid),
    .io_dec_i0_brp_toffset(instbuff_io_dec_i0_brp_toffset),
    .io_dec_i0_brp_hist(instbuff_io_dec_i0_brp_hist),
    .io_dec_i0_brp_br_error(instbuff_io_dec_i0_brp_br_error),
    .io_dec_i0_brp_br_start_error(instbuff_io_dec_i0_brp_br_start_error),
    .io_dec_i0_brp_prett(instbuff_io_dec_i0_brp_prett),
    .io_dec_i0_brp_way(instbuff_io_dec_i0_brp_way),
    .io_dec_i0_brp_ret(instbuff_io_dec_i0_brp_ret),
    .io_dec_i0_bp_index(instbuff_io_dec_i0_bp_index),
    .io_dec_i0_bp_fghr(instbuff_io_dec_i0_bp_fghr),
    .io_dec_i0_bp_btag(instbuff_io_dec_i0_bp_btag),
    .io_dec_i0_icaf_d(instbuff_io_dec_i0_icaf_d),
    .io_dec_i0_dbecc_d(instbuff_io_dec_i0_dbecc_d),
    .io_dec_debug_wdata_rs1_d(instbuff_io_dec_debug_wdata_rs1_d),
    .io_dec_debug_fence_d(instbuff_io_dec_debug_fence_d)
  );
  el2_dec_decode_ctl decode ( // @[el2_dec.scala 353:22]
    .clock(decode_clock),
    .reset(decode_reset),
    .io_dec_extint_stall(decode_io_dec_extint_stall),
    .io_lsu_nonblock_load_valid_m(decode_io_lsu_nonblock_load_valid_m),
    .io_lsu_nonblock_load_tag_m(decode_io_lsu_nonblock_load_tag_m),
    .io_lsu_nonblock_load_inv_r(decode_io_lsu_nonblock_load_inv_r),
    .io_lsu_nonblock_load_inv_tag_r(decode_io_lsu_nonblock_load_inv_tag_r),
    .io_lsu_nonblock_load_data_valid(decode_io_lsu_nonblock_load_data_valid),
    .io_lsu_nonblock_load_data_error(decode_io_lsu_nonblock_load_data_error),
    .io_lsu_nonblock_load_data_tag(decode_io_lsu_nonblock_load_data_tag),
    .io_lsu_nonblock_load_data(decode_io_lsu_nonblock_load_data),
    .io_dec_debug_fence_d(decode_io_dec_debug_fence_d),
    .io_dbg_cmd_wrdata(decode_io_dbg_cmd_wrdata),
    .io_dec_i0_icaf_d(decode_io_dec_i0_icaf_d),
    .io_dec_i0_dbecc_d(decode_io_dec_i0_dbecc_d),
    .io_dec_i0_brp_valid(decode_io_dec_i0_brp_valid),
    .io_dec_i0_brp_toffset(decode_io_dec_i0_brp_toffset),
    .io_dec_i0_brp_hist(decode_io_dec_i0_brp_hist),
    .io_dec_i0_brp_br_error(decode_io_dec_i0_brp_br_error),
    .io_dec_i0_brp_br_start_error(decode_io_dec_i0_brp_br_start_error),
    .io_dec_i0_brp_prett(decode_io_dec_i0_brp_prett),
    .io_dec_i0_brp_way(decode_io_dec_i0_brp_way),
    .io_dec_i0_brp_ret(decode_io_dec_i0_brp_ret),
    .io_dec_i0_bp_index(decode_io_dec_i0_bp_index),
    .io_dec_i0_bp_fghr(decode_io_dec_i0_bp_fghr),
    .io_dec_i0_bp_btag(decode_io_dec_i0_bp_btag),
    .io_lsu_idle_any(decode_io_lsu_idle_any),
    .io_lsu_load_stall_any(decode_io_lsu_load_stall_any),
    .io_lsu_store_stall_any(decode_io_lsu_store_stall_any),
    .io_dma_dccm_stall_any(decode_io_dma_dccm_stall_any),
    .io_exu_div_wren(decode_io_exu_div_wren),
    .io_dec_i0_pc4_d(decode_io_dec_i0_pc4_d),
    .io_lsu_result_m(decode_io_lsu_result_m),
    .io_lsu_result_corr_r(decode_io_lsu_result_corr_r),
    .io_exu_flush_final(decode_io_exu_flush_final),
    .io_exu_i0_pc_x(decode_io_exu_i0_pc_x),
    .io_dec_i0_instr_d(decode_io_dec_i0_instr_d),
    .io_dec_ib0_valid_d(decode_io_dec_ib0_valid_d),
    .io_exu_i0_result_x(decode_io_exu_i0_result_x),
    .io_free_clk(decode_io_free_clk),
    .io_active_clk(decode_io_active_clk),
    .io_dec_i0_rs1_en_d(decode_io_dec_i0_rs1_en_d),
    .io_dec_i0_rs2_en_d(decode_io_dec_i0_rs2_en_d),
    .io_dec_i0_rs1_d(decode_io_dec_i0_rs1_d),
    .io_dec_i0_rs2_d(decode_io_dec_i0_rs2_d),
    .io_dec_i0_immed_d(decode_io_dec_i0_immed_d),
    .io_dec_i0_br_immed_d(decode_io_dec_i0_br_immed_d),
    .io_i0_ap_land(decode_io_i0_ap_land),
    .io_i0_ap_lor(decode_io_i0_ap_lor),
    .io_i0_ap_lxor(decode_io_i0_ap_lxor),
    .io_i0_ap_sll(decode_io_i0_ap_sll),
    .io_i0_ap_srl(decode_io_i0_ap_srl),
    .io_i0_ap_sra(decode_io_i0_ap_sra),
    .io_i0_ap_beq(decode_io_i0_ap_beq),
    .io_i0_ap_bne(decode_io_i0_ap_bne),
    .io_i0_ap_blt(decode_io_i0_ap_blt),
    .io_i0_ap_bge(decode_io_i0_ap_bge),
    .io_i0_ap_add(decode_io_i0_ap_add),
    .io_i0_ap_sub(decode_io_i0_ap_sub),
    .io_i0_ap_slt(decode_io_i0_ap_slt),
    .io_i0_ap_unsign(decode_io_i0_ap_unsign),
    .io_i0_ap_jal(decode_io_i0_ap_jal),
    .io_i0_ap_predict_t(decode_io_i0_ap_predict_t),
    .io_i0_ap_predict_nt(decode_io_i0_ap_predict_nt),
    .io_i0_ap_csr_write(decode_io_i0_ap_csr_write),
    .io_i0_ap_csr_imm(decode_io_i0_ap_csr_imm),
    .io_dec_i0_decode_d(decode_io_dec_i0_decode_d),
    .io_dec_i0_alu_decode_d(decode_io_dec_i0_alu_decode_d),
    .io_dec_i0_rs1_bypass_data_d(decode_io_dec_i0_rs1_bypass_data_d),
    .io_dec_i0_rs2_bypass_data_d(decode_io_dec_i0_rs2_bypass_data_d),
    .io_dec_i0_waddr_r(decode_io_dec_i0_waddr_r),
    .io_dec_i0_wen_r(decode_io_dec_i0_wen_r),
    .io_dec_i0_wdata_r(decode_io_dec_i0_wdata_r),
    .io_dec_i0_select_pc_d(decode_io_dec_i0_select_pc_d),
    .io_dec_i0_rs1_bypass_en_d(decode_io_dec_i0_rs1_bypass_en_d),
    .io_dec_i0_rs2_bypass_en_d(decode_io_dec_i0_rs2_bypass_en_d),
    .io_lsu_p_fast_int(decode_io_lsu_p_fast_int),
    .io_lsu_p_by(decode_io_lsu_p_by),
    .io_lsu_p_half(decode_io_lsu_p_half),
    .io_lsu_p_word(decode_io_lsu_p_word),
    .io_lsu_p_load(decode_io_lsu_p_load),
    .io_lsu_p_store(decode_io_lsu_p_store),
    .io_lsu_p_unsign(decode_io_lsu_p_unsign),
    .io_lsu_p_store_data_bypass_d(decode_io_lsu_p_store_data_bypass_d),
    .io_lsu_p_load_ldst_bypass_d(decode_io_lsu_p_load_ldst_bypass_d),
    .io_lsu_p_valid(decode_io_lsu_p_valid),
    .io_mul_p_valid(decode_io_mul_p_valid),
    .io_mul_p_rs1_sign(decode_io_mul_p_rs1_sign),
    .io_mul_p_rs2_sign(decode_io_mul_p_rs2_sign),
    .io_mul_p_low(decode_io_mul_p_low),
    .io_div_p_valid(decode_io_div_p_valid),
    .io_div_p_unsign(decode_io_div_p_unsign),
    .io_div_p_rem(decode_io_div_p_rem),
    .io_div_waddr_wb(decode_io_div_waddr_wb),
    .io_dec_div_cancel(decode_io_dec_div_cancel),
    .io_dec_lsu_valid_raw_d(decode_io_dec_lsu_valid_raw_d),
    .io_dec_lsu_offset_d(decode_io_dec_lsu_offset_d),
    .io_dec_csr_ren_d(decode_io_dec_csr_ren_d),
    .io_pred_correct_npc_x(decode_io_pred_correct_npc_x),
    .io_dec_i0_predict_p_d_pc4(decode_io_dec_i0_predict_p_d_pc4),
    .io_dec_i0_predict_p_d_hist(decode_io_dec_i0_predict_p_d_hist),
    .io_dec_i0_predict_p_d_toffset(decode_io_dec_i0_predict_p_d_toffset),
    .io_dec_i0_predict_p_d_valid(decode_io_dec_i0_predict_p_d_valid),
    .io_dec_i0_predict_p_d_br_error(decode_io_dec_i0_predict_p_d_br_error),
    .io_dec_i0_predict_p_d_br_start_error(decode_io_dec_i0_predict_p_d_br_start_error),
    .io_dec_i0_predict_p_d_prett(decode_io_dec_i0_predict_p_d_prett),
    .io_dec_i0_predict_p_d_pcall(decode_io_dec_i0_predict_p_d_pcall),
    .io_dec_i0_predict_p_d_pret(decode_io_dec_i0_predict_p_d_pret),
    .io_dec_i0_predict_p_d_pja(decode_io_dec_i0_predict_p_d_pja),
    .io_dec_i0_predict_p_d_way(decode_io_dec_i0_predict_p_d_way),
    .io_i0_predict_fghr_d(decode_io_i0_predict_fghr_d),
    .io_i0_predict_index_d(decode_io_i0_predict_index_d),
    .io_i0_predict_btag_d(decode_io_i0_predict_btag_d),
    .io_dec_data_en(decode_io_dec_data_en),
    .io_dec_ctl_en(decode_io_dec_ctl_en),
    .io_dec_nonblock_load_wen(decode_io_dec_nonblock_load_wen),
    .io_dec_nonblock_load_waddr(decode_io_dec_nonblock_load_waddr),
    .io_dec_div_active(decode_io_dec_div_active),
    .io_scan_mode(decode_io_scan_mode)
  );
  el2_dec_gpr_ctl gpr ( // @[el2_dec.scala 354:19]
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
    .io_rd0(gpr_io_rd0),
    .io_rd1(gpr_io_rd1),
    .io_scan_mode(gpr_io_scan_mode)
  );
  el2_dec_trigger dec_trigger ( // @[el2_dec.scala 356:27]
    .io_dec_i0_pc_d(dec_trigger_io_dec_i0_pc_d),
    .io_dec_i0_trigger_match_d(dec_trigger_io_dec_i0_trigger_match_d)
  );
  assign io_dec_extint_stall = 1'h0; // @[el2_dec.scala 468:40]
  assign io_dec_i0_decode_d = decode_io_dec_i0_decode_d; // @[el2_dec.scala 478:40]
  assign io_dec_pause_state_cg = 1'h0; // @[el2_dec.scala 521:40]
  assign io_o_cpu_halt_status = 1'h0; // @[el2_dec.scala 654:29]
  assign io_o_cpu_halt_ack = 1'h0; // @[el2_dec.scala 655:29]
  assign io_o_cpu_run_ack = 1'h0; // @[el2_dec.scala 656:29]
  assign io_o_debug_mode_status = 1'h0; // @[el2_dec.scala 657:29]
  assign io_mpc_debug_halt_ack = 1'h0; // @[el2_dec.scala 658:29]
  assign io_mpc_debug_run_ack = 1'h0; // @[el2_dec.scala 659:29]
  assign io_debug_brkpt_status = 1'h0; // @[el2_dec.scala 660:29]
  assign io_dec_tlu_meicurpl = 4'h0; // @[el2_dec.scala 661:29]
  assign io_dec_tlu_meipt = 4'h0; // @[el2_dec.scala 662:29]
  assign io_dec_tlu_ic_diag_pkt_icache_wrdata = 71'h0; // @[el2_dec.scala 653:29]
  assign io_dec_tlu_ic_diag_pkt_icache_dicawics = 17'h0; // @[el2_dec.scala 653:29]
  assign io_dec_tlu_ic_diag_pkt_icache_rd_valid = 1'h0; // @[el2_dec.scala 653:29]
  assign io_dec_tlu_ic_diag_pkt_icache_wr_valid = 1'h0; // @[el2_dec.scala 653:29]
  assign io_dec_tlu_dbg_halted = 1'h0; // @[el2_dec.scala 642:28]
  assign io_dec_tlu_debug_mode = 1'h0; // @[el2_dec.scala 643:28]
  assign io_dec_tlu_resume_ack = 1'h0; // @[el2_dec.scala 644:28]
  assign io_dec_tlu_flush_noredir_r = 1'h0; // @[el2_dec.scala 646:34]
  assign io_dec_tlu_mpc_halted_only = 1'h0; // @[el2_dec.scala 647:34]
  assign io_dec_tlu_flush_leak_one_r = 1'h0; // @[el2_dec.scala 648:34]
  assign io_dec_tlu_flush_err_r = 1'h0; // @[el2_dec.scala 649:34]
  assign io_dec_tlu_meihap = 32'h0; // @[el2_dec.scala 651:29]
  assign io_dec_debug_wdata_rs1_d = instbuff_io_dec_debug_wdata_rs1_d; // @[el2_dec.scala 392:38]
  assign io_dec_dbg_rddata = decode_io_dec_i0_wdata_r; // @[el2_dec.scala 709:21]
  assign io_dec_dbg_cmd_done = 1'h0; // @[el2_dec.scala 640:28]
  assign io_dec_dbg_cmd_fail = 1'h0; // @[el2_dec.scala 641:28]
  assign io_trigger_pkt_any_0_select = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_0_match_ = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_0_store = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_0_load = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_0_execute = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_0_m = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_0_tdata2 = 32'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_select = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_match_ = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_store = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_load = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_execute = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_m = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_1_tdata2 = 32'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_select = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_match_ = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_store = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_load = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_execute = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_m = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_2_tdata2 = 32'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_select = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_match_ = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_store = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_load = 1'h0; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_execute = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_m = 1'h1; // @[el2_dec.scala 652:29]
  assign io_trigger_pkt_any_3_tdata2 = 32'h1; // @[el2_dec.scala 652:29]
  assign io_dec_tlu_force_halt = 1'h0; // @[el2_dec.scala 678:29]
  assign io_dec_i0_rs1_en_d = decode_io_dec_i0_rs1_en_d; // @[el2_dec.scala 471:40]
  assign io_dec_i0_rs2_en_d = decode_io_dec_i0_rs2_en_d; // @[el2_dec.scala 472:40]
  assign io_gpr_i0_rs1_d = gpr_io_rd0; // @[el2_dec.scala 544:19]
  assign io_gpr_i0_rs2_d = gpr_io_rd1; // @[el2_dec.scala 545:19]
  assign io_dec_i0_immed_d = decode_io_dec_i0_immed_d; // @[el2_dec.scala 475:40]
  assign io_dec_i0_br_immed_d = {{1'd0}, decode_io_dec_i0_br_immed_d}; // @[el2_dec.scala 476:40]
  assign io_i0_ap_land = decode_io_i0_ap_land; // @[el2_dec.scala 477:40]
  assign io_i0_ap_lor = decode_io_i0_ap_lor; // @[el2_dec.scala 477:40]
  assign io_i0_ap_lxor = decode_io_i0_ap_lxor; // @[el2_dec.scala 477:40]
  assign io_i0_ap_sll = decode_io_i0_ap_sll; // @[el2_dec.scala 477:40]
  assign io_i0_ap_srl = decode_io_i0_ap_srl; // @[el2_dec.scala 477:40]
  assign io_i0_ap_sra = decode_io_i0_ap_sra; // @[el2_dec.scala 477:40]
  assign io_i0_ap_beq = decode_io_i0_ap_beq; // @[el2_dec.scala 477:40]
  assign io_i0_ap_bne = decode_io_i0_ap_bne; // @[el2_dec.scala 477:40]
  assign io_i0_ap_blt = decode_io_i0_ap_blt; // @[el2_dec.scala 477:40]
  assign io_i0_ap_bge = decode_io_i0_ap_bge; // @[el2_dec.scala 477:40]
  assign io_i0_ap_add = decode_io_i0_ap_add; // @[el2_dec.scala 477:40]
  assign io_i0_ap_sub = decode_io_i0_ap_sub; // @[el2_dec.scala 477:40]
  assign io_i0_ap_slt = decode_io_i0_ap_slt; // @[el2_dec.scala 477:40]
  assign io_i0_ap_unsign = decode_io_i0_ap_unsign; // @[el2_dec.scala 477:40]
  assign io_i0_ap_jal = decode_io_i0_ap_jal; // @[el2_dec.scala 477:40]
  assign io_i0_ap_predict_t = decode_io_i0_ap_predict_t; // @[el2_dec.scala 477:40]
  assign io_i0_ap_predict_nt = decode_io_i0_ap_predict_nt; // @[el2_dec.scala 477:40]
  assign io_i0_ap_csr_write = decode_io_i0_ap_csr_write; // @[el2_dec.scala 477:40]
  assign io_i0_ap_csr_imm = decode_io_i0_ap_csr_imm; // @[el2_dec.scala 477:40]
  assign io_dec_i0_alu_decode_d = decode_io_dec_i0_alu_decode_d; // @[el2_dec.scala 479:40]
  assign io_dec_i0_select_pc_d = decode_io_dec_i0_select_pc_d; // @[el2_dec.scala 485:40]
  assign io_dec_i0_pc_d = 32'h0; // @[el2_dec.scala 272:18]
  assign io_dec_i0_rs1_bypass_en_d = decode_io_dec_i0_rs1_bypass_en_d; // @[el2_dec.scala 486:40]
  assign io_dec_i0_rs2_bypass_en_d = decode_io_dec_i0_rs2_bypass_en_d; // @[el2_dec.scala 487:40]
  assign io_dec_i0_rs1_bypass_data_d = decode_io_dec_i0_rs1_bypass_data_d; // @[el2_dec.scala 480:40]
  assign io_dec_i0_rs2_bypass_data_d = decode_io_dec_i0_rs2_bypass_data_d; // @[el2_dec.scala 481:40]
  assign io_lsu_p_fast_int = decode_io_lsu_p_fast_int; // @[el2_dec.scala 488:40]
  assign io_lsu_p_by = decode_io_lsu_p_by; // @[el2_dec.scala 488:40]
  assign io_lsu_p_half = decode_io_lsu_p_half; // @[el2_dec.scala 488:40]
  assign io_lsu_p_word = decode_io_lsu_p_word; // @[el2_dec.scala 488:40]
  assign io_lsu_p_dword = 1'h0; // @[el2_dec.scala 488:40]
  assign io_lsu_p_load = decode_io_lsu_p_load; // @[el2_dec.scala 488:40]
  assign io_lsu_p_store = decode_io_lsu_p_store; // @[el2_dec.scala 488:40]
  assign io_lsu_p_unsign = decode_io_lsu_p_unsign; // @[el2_dec.scala 488:40]
  assign io_lsu_p_dma = 1'h0; // @[el2_dec.scala 488:40]
  assign io_lsu_p_store_data_bypass_d = decode_io_lsu_p_store_data_bypass_d; // @[el2_dec.scala 488:40]
  assign io_lsu_p_load_ldst_bypass_d = decode_io_lsu_p_load_ldst_bypass_d; // @[el2_dec.scala 488:40]
  assign io_lsu_p_store_data_bypass_m = 1'h0; // @[el2_dec.scala 488:40]
  assign io_lsu_p_valid = decode_io_lsu_p_valid; // @[el2_dec.scala 488:40]
  assign io_mul_p_valid = decode_io_mul_p_valid; // @[el2_dec.scala 489:40]
  assign io_mul_p_rs1_sign = decode_io_mul_p_rs1_sign; // @[el2_dec.scala 489:40]
  assign io_mul_p_rs2_sign = decode_io_mul_p_rs2_sign; // @[el2_dec.scala 489:40]
  assign io_mul_p_low = decode_io_mul_p_low; // @[el2_dec.scala 489:40]
  assign io_mul_p_bext = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_bdep = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_clmul = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_clmulh = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_clmulr = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_grev = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_shfl = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_unshfl = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_crc32_b = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_crc32_h = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_crc32_w = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_crc32c_b = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_crc32c_h = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_crc32c_w = 1'h0; // @[el2_dec.scala 489:40]
  assign io_mul_p_bfp = 1'h0; // @[el2_dec.scala 489:40]
  assign io_div_p_valid = decode_io_div_p_valid; // @[el2_dec.scala 490:40]
  assign io_div_p_unsign = decode_io_div_p_unsign; // @[el2_dec.scala 490:40]
  assign io_div_p_rem = decode_io_div_p_rem; // @[el2_dec.scala 490:40]
  assign io_dec_div_cancel = decode_io_dec_div_cancel; // @[el2_dec.scala 492:40]
  assign io_dec_lsu_offset_d = decode_io_dec_lsu_offset_d; // @[el2_dec.scala 494:40]
  assign io_dec_csr_ren_d = decode_io_dec_csr_ren_d; // @[el2_dec.scala 495:40]
  assign io_dec_tlu_flush_lower_r = 1'h0; // @[el2_dec.scala 670:34]
  assign io_dec_tlu_flush_path_r = 32'h0; // @[el2_dec.scala 671:34]
  assign io_dec_tlu_i0_kill_writeb_r = 1'h0; // @[el2_dec.scala 669:34]
  assign io_dec_tlu_fence_i_r = 1'h0; // @[el2_dec.scala 672:34]
  assign io_pred_correct_npc_x = {{1'd0}, decode_io_pred_correct_npc_x}; // @[el2_dec.scala 507:40]
  assign io_dec_tlu_br0_r_pkt_valid = 1'h0; // @[el2_dec.scala 665:42]
  assign io_dec_tlu_br0_r_pkt_hist = 2'h0; // @[el2_dec.scala 665:42]
  assign io_dec_tlu_br0_r_pkt_br_error = 1'h0; // @[el2_dec.scala 665:42]
  assign io_dec_tlu_br0_r_pkt_br_start_error = 1'h0; // @[el2_dec.scala 665:42]
  assign io_dec_tlu_br0_r_pkt_way = 1'h0; // @[el2_dec.scala 665:42]
  assign io_dec_tlu_br0_r_pkt_middle = 1'h0; // @[el2_dec.scala 665:42]
  assign io_dec_tlu_perfcnt0 = 1'h0; // @[el2_dec.scala 679:29]
  assign io_dec_tlu_perfcnt1 = 1'h0; // @[el2_dec.scala 680:29]
  assign io_dec_tlu_perfcnt2 = 1'h0; // @[el2_dec.scala 681:29]
  assign io_dec_tlu_perfcnt3 = 1'h0; // @[el2_dec.scala 682:29]
  assign io_dec_i0_predict_p_d_misp = 1'h0; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_ataken = 1'h0; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_boffset = 1'h0; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_pc4 = decode_io_dec_i0_predict_p_d_pc4; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_hist = decode_io_dec_i0_predict_p_d_hist; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_toffset = decode_io_dec_i0_predict_p_d_toffset; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_valid = decode_io_dec_i0_predict_p_d_valid; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_br_error = decode_io_dec_i0_predict_p_d_br_error; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_br_start_error = decode_io_dec_i0_predict_p_d_br_start_error; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_prett = decode_io_dec_i0_predict_p_d_prett; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_pcall = decode_io_dec_i0_predict_p_d_pcall; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_pret = decode_io_dec_i0_predict_p_d_pret; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_pja = decode_io_dec_i0_predict_p_d_pja; // @[el2_dec.scala 508:40]
  assign io_dec_i0_predict_p_d_way = decode_io_dec_i0_predict_p_d_way; // @[el2_dec.scala 508:40]
  assign io_i0_predict_fghr_d = decode_io_i0_predict_fghr_d; // @[el2_dec.scala 509:40]
  assign io_i0_predict_index_d = {{1'd0}, decode_io_i0_predict_index_d}; // @[el2_dec.scala 510:40]
  assign io_i0_predict_btag_d = decode_io_i0_predict_btag_d; // @[el2_dec.scala 511:40]
  assign io_dec_lsu_valid_raw_d = decode_io_dec_lsu_valid_raw_d; // @[el2_dec.scala 493:40]
  assign io_dec_tlu_mrac_ff = 32'h0; // @[el2_dec.scala 677:29]
  assign io_dec_data_en = decode_io_dec_data_en; // @[el2_dec.scala 512:40]
  assign io_dec_ctl_en = decode_io_dec_ctl_en; // @[el2_dec.scala 513:40]
  assign io_dec_tlu_external_ldfwd_disable = 1'h0; // @[el2_dec.scala 688:43]
  assign io_dec_tlu_sideeffect_posted_disable = 1'h0; // @[el2_dec.scala 689:43]
  assign io_dec_tlu_core_ecc_disable = 1'h0; // @[el2_dec.scala 690:43]
  assign io_dec_tlu_bpred_disable = 1'h0; // @[el2_dec.scala 691:43]
  assign io_dec_tlu_wb_coalescing_disable = 1'h0; // @[el2_dec.scala 692:43]
  assign io_dec_tlu_dma_qos_prty = 3'h0; // @[el2_dec.scala 694:35]
  assign io_dec_tlu_misc_clk_override = 1'h0; // @[el2_dec.scala 695:35]
  assign io_dec_tlu_ifu_clk_override = 1'h0; // @[el2_dec.scala 697:36]
  assign io_dec_tlu_lsu_clk_override = 1'h0; // @[el2_dec.scala 698:36]
  assign io_dec_tlu_bus_clk_override = 1'h0; // @[el2_dec.scala 699:36]
  assign io_dec_tlu_pic_clk_override = 1'h0; // @[el2_dec.scala 700:36]
  assign io_dec_tlu_dccm_clk_override = 1'h0; // @[el2_dec.scala 701:36]
  assign io_dec_tlu_icm_clk_override = 1'h0; // @[el2_dec.scala 702:36]
  assign io_dec_tlu_i0_commit_cmt = 1'h0; // @[el2_dec.scala 668:34]
  assign instbuff_io_dbg_cmd_valid = io_dbg_cmd_valid; // @[el2_dec.scala 363:45]
  assign instbuff_io_dbg_cmd_write = io_dbg_cmd_write; // @[el2_dec.scala 364:45]
  assign instbuff_io_dbg_cmd_type = io_dbg_cmd_type; // @[el2_dec.scala 365:45]
  assign instbuff_io_dbg_cmd_addr = io_dbg_cmd_addr; // @[el2_dec.scala 366:45]
  assign instbuff_io_i0_brp_valid = io_i0_brp_valid; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_toffset = io_i0_brp_toffset; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_hist = io_i0_brp_hist; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_br_error = io_i0_brp_br_error; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_br_start_error = io_i0_brp_br_start_error; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_prett = io_i0_brp_prett; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_way = io_i0_brp_way; // @[el2_dec.scala 367:55]
  assign instbuff_io_i0_brp_ret = io_i0_brp_ret; // @[el2_dec.scala 367:55]
  assign instbuff_io_ifu_i0_bp_index = io_ifu_i0_bp_index[7:0]; // @[el2_dec.scala 368:35]
  assign instbuff_io_ifu_i0_bp_fghr = io_ifu_i0_bp_fghr; // @[el2_dec.scala 369:35]
  assign instbuff_io_ifu_i0_bp_btag = io_ifu_i0_bp_btag; // @[el2_dec.scala 370:35]
  assign instbuff_io_ifu_i0_valid = io_ifu_i0_valid; // @[el2_dec.scala 372:35]
  assign instbuff_io_ifu_i0_icaf = io_ifu_i0_icaf; // @[el2_dec.scala 373:35]
  assign instbuff_io_ifu_i0_dbecc = io_ifu_i0_dbecc; // @[el2_dec.scala 376:35]
  assign instbuff_io_ifu_i0_instr = io_ifu_i0_instr; // @[el2_dec.scala 377:35]
  assign instbuff_io_ifu_i0_pc = io_ifu_i0_pc[30:0]; // @[el2_dec.scala 378:35]
  assign decode_clock = clock;
  assign decode_reset = reset;
  assign decode_io_lsu_nonblock_load_valid_m = io_lsu_nonblock_load_valid_m; // @[el2_dec.scala 412:48]
  assign decode_io_lsu_nonblock_load_tag_m = io_lsu_nonblock_load_tag_m; // @[el2_dec.scala 413:48]
  assign decode_io_lsu_nonblock_load_inv_r = io_lsu_nonblock_load_inv_r; // @[el2_dec.scala 414:48]
  assign decode_io_lsu_nonblock_load_inv_tag_r = io_lsu_nonblock_load_inv_tag_r; // @[el2_dec.scala 415:48]
  assign decode_io_lsu_nonblock_load_data_valid = io_lsu_nonblock_load_data_valid; // @[el2_dec.scala 416:48]
  assign decode_io_lsu_nonblock_load_data_error = io_lsu_nonblock_load_data_error; // @[el2_dec.scala 417:48]
  assign decode_io_lsu_nonblock_load_data_tag = io_lsu_nonblock_load_data_tag; // @[el2_dec.scala 418:48]
  assign decode_io_lsu_nonblock_load_data = io_lsu_nonblock_load_data; // @[el2_dec.scala 419:48]
  assign decode_io_dec_debug_fence_d = instbuff_io_dec_debug_fence_d; // @[el2_dec.scala 393:38 el2_dec.scala 427:48]
  assign decode_io_dbg_cmd_wrdata = io_dbg_cmd_wrdata; // @[el2_dec.scala 428:48]
  assign decode_io_dec_i0_icaf_d = instbuff_io_dec_i0_icaf_d; // @[el2_dec.scala 389:38 el2_dec.scala 429:48]
  assign decode_io_dec_i0_dbecc_d = instbuff_io_dec_i0_dbecc_d; // @[el2_dec.scala 391:38 el2_dec.scala 432:48]
  assign decode_io_dec_i0_brp_valid = instbuff_io_dec_i0_brp_valid; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_toffset = instbuff_io_dec_i0_brp_toffset; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_hist = instbuff_io_dec_i0_brp_hist; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_br_error = instbuff_io_dec_i0_brp_br_error; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_br_start_error = instbuff_io_dec_i0_brp_br_start_error; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_prett = instbuff_io_dec_i0_brp_prett; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_way = instbuff_io_dec_i0_brp_way; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_brp_ret = instbuff_io_dec_i0_brp_ret; // @[el2_dec.scala 385:38 el2_dec.scala 433:48]
  assign decode_io_dec_i0_bp_index = instbuff_io_dec_i0_bp_index; // @[el2_dec.scala 386:38 el2_dec.scala 434:48]
  assign decode_io_dec_i0_bp_fghr = instbuff_io_dec_i0_bp_fghr; // @[el2_dec.scala 387:38 el2_dec.scala 435:48]
  assign decode_io_dec_i0_bp_btag = instbuff_io_dec_i0_bp_btag; // @[el2_dec.scala 388:38 el2_dec.scala 436:48]
  assign decode_io_lsu_idle_any = io_lsu_idle_any; // @[el2_dec.scala 438:48]
  assign decode_io_lsu_load_stall_any = io_lsu_load_stall_any; // @[el2_dec.scala 439:48]
  assign decode_io_lsu_store_stall_any = io_lsu_store_stall_any; // @[el2_dec.scala 440:48]
  assign decode_io_dma_dccm_stall_any = io_dma_dccm_stall_any; // @[el2_dec.scala 441:48]
  assign decode_io_exu_div_wren = io_exu_div_wren; // @[el2_dec.scala 442:48]
  assign decode_io_dec_i0_pc4_d = instbuff_io_dec_i0_pc_d[0]; // @[el2_dec.scala 384:38 el2_dec.scala 450:48]
  assign decode_io_lsu_result_m = io_lsu_result_m; // @[el2_dec.scala 454:48]
  assign decode_io_lsu_result_corr_r = io_lsu_result_corr_r; // @[el2_dec.scala 455:48]
  assign decode_io_exu_flush_final = io_exu_flush_final; // @[el2_dec.scala 456:48]
  assign decode_io_exu_i0_pc_x = io_exu_i0_pc_x[30:0]; // @[el2_dec.scala 457:48]
  assign decode_io_dec_i0_instr_d = instbuff_io_dec_i0_instr_d; // @[el2_dec.scala 382:38 el2_dec.scala 458:48]
  assign decode_io_dec_ib0_valid_d = instbuff_io_dec_ib0_valid_d; // @[el2_dec.scala 380:38 el2_dec.scala 459:48]
  assign decode_io_exu_i0_result_x = io_exu_i0_result_x; // @[el2_dec.scala 460:48]
  assign decode_io_free_clk = io_free_clk; // @[el2_dec.scala 462:48]
  assign decode_io_active_clk = io_active_clk; // @[el2_dec.scala 463:48]
  assign decode_io_scan_mode = io_scan_mode; // @[el2_dec.scala 466:48]
  assign gpr_clock = clock;
  assign gpr_reset = reset;
  assign gpr_io_raddr0 = decode_io_dec_i0_rs1_d; // @[el2_dec.scala 473:40 el2_dec.scala 529:23]
  assign gpr_io_raddr1 = decode_io_dec_i0_rs2_d; // @[el2_dec.scala 474:40 el2_dec.scala 530:23]
  assign gpr_io_wen0 = decode_io_dec_i0_wen_r; // @[el2_dec.scala 483:40 el2_dec.scala 531:23]
  assign gpr_io_waddr0 = decode_io_dec_i0_waddr_r; // @[el2_dec.scala 482:40 el2_dec.scala 532:23]
  assign gpr_io_wd0 = decode_io_dec_i0_wdata_r; // @[el2_dec.scala 484:40 el2_dec.scala 533:23]
  assign gpr_io_wen1 = decode_io_dec_nonblock_load_wen; // @[el2_dec.scala 534:23]
  assign gpr_io_waddr1 = decode_io_dec_nonblock_load_waddr; // @[el2_dec.scala 535:23]
  assign gpr_io_wd1 = io_lsu_nonblock_load_data; // @[el2_dec.scala 536:23]
  assign gpr_io_wen2 = io_exu_div_wren; // @[el2_dec.scala 537:23]
  assign gpr_io_waddr2 = decode_io_div_waddr_wb; // @[el2_dec.scala 491:40 el2_dec.scala 538:23]
  assign gpr_io_wd2 = io_exu_div_result; // @[el2_dec.scala 539:23]
  assign gpr_io_scan_mode = io_scan_mode; // @[el2_dec.scala 542:23]
  assign dec_trigger_io_dec_i0_pc_d = instbuff_io_dec_i0_pc_d; // @[el2_dec.scala 399:30]
endmodule
