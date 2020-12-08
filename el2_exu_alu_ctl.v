module rvclkhdr(
  output  io_l1clk,
  input   io_clk,
  input   io_en,
  input   io_scan_mode
);
  wire  clkhdr_Q; // @[beh_lib.scala 331:24]
  wire  clkhdr_CK; // @[beh_lib.scala 331:24]
  wire  clkhdr_EN; // @[beh_lib.scala 331:24]
  wire  clkhdr_SE; // @[beh_lib.scala 331:24]
  TEC_RV_ICG clkhdr ( // @[beh_lib.scala 331:24]
    .Q(clkhdr_Q),
    .CK(clkhdr_CK),
    .EN(clkhdr_EN),
    .SE(clkhdr_SE)
  );
  assign io_l1clk = clkhdr_Q; // @[beh_lib.scala 332:12]
  assign clkhdr_CK = io_clk; // @[beh_lib.scala 333:16]
  assign clkhdr_EN = io_en; // @[beh_lib.scala 334:16]
  assign clkhdr_SE = io_scan_mode; // @[beh_lib.scala 335:16]
endmodule
module el2_exu_alu_ctl(
  input         clock,
  input         reset,
  input         io_scan_mode,
  input         io_flush_upper_x,
  input         io_flush_lower_r,
  input         io_enable,
  input         io_valid_in,
  input         io_ap_land,
  input         io_ap_lor,
  input         io_ap_lxor,
  input         io_ap_sll,
  input         io_ap_srl,
  input         io_ap_sra,
  input         io_ap_beq,
  input         io_ap_bne,
  input         io_ap_blt,
  input         io_ap_bge,
  input         io_ap_add,
  input         io_ap_sub,
  input         io_ap_slt,
  input         io_ap_unsign,
  input         io_ap_jal,
  input         io_ap_predict_t,
  input         io_ap_predict_nt,
  input         io_ap_csr_write,
  input         io_ap_csr_imm,
  input         io_csr_ren_in,
  input  [31:0] io_a_in,
  input  [31:0] io_b_in,
  input  [30:0] io_pc_in,
  input         io_pp_in_misp,
  input         io_pp_in_ataken,
  input         io_pp_in_boffset,
  input         io_pp_in_pc4,
  input  [1:0]  io_pp_in_hist,
  input  [11:0] io_pp_in_toffset,
  input         io_pp_in_valid,
  input         io_pp_in_br_error,
  input         io_pp_in_br_start_error,
  input  [31:0] io_pp_in_prett,
  input         io_pp_in_pcall,
  input         io_pp_in_pret,
  input         io_pp_in_pja,
  input         io_pp_in_way,
  input  [11:0] io_brimm_in,
  output [31:0] io_result_ff,
  output        io_flush_upper_out,
  output        io_flush_final_out,
  output [30:0] io_flush_path_out,
  output [30:0] io_pc_ff,
  output        io_pred_correct_out,
  output        io_predict_p_out_misp,
  output        io_predict_p_out_ataken,
  output        io_predict_p_out_boffset,
  output        io_predict_p_out_pc4,
  output [1:0]  io_predict_p_out_hist,
  output [11:0] io_predict_p_out_toffset,
  output        io_predict_p_out_valid,
  output        io_predict_p_out_br_error,
  output        io_predict_p_out_br_start_error,
  output [31:0] io_predict_p_out_prett,
  output        io_predict_p_out_pcall,
  output        io_predict_p_out_pret,
  output        io_predict_p_out_pja,
  output        io_predict_p_out_way
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  rvclkhdr_io_l1clk; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_io_clk; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_io_en; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_io_scan_mode; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_1_io_l1clk; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_1_io_clk; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_1_io_en; // @[beh_lib.scala 351:21]
  wire  rvclkhdr_1_io_scan_mode; // @[beh_lib.scala 351:21]
  reg [30:0] _T_1; // @[beh_lib.scala 357:14]
  reg [31:0] _T_3; // @[beh_lib.scala 357:14]
  wire [31:0] _T_5 = ~io_b_in; // @[el2_exu_alu_ctl.scala 39:36]
  wire [31:0] bm = io_ap_sub ? _T_5 : io_b_in; // @[el2_exu_alu_ctl.scala 39:16]
  wire [32:0] _T_8 = {1'h0,io_a_in}; // @[Cat.scala 29:58]
  wire [32:0] _T_10 = {1'h0,_T_5}; // @[Cat.scala 29:58]
  wire [32:0] _T_12 = _T_8 + _T_10; // @[el2_exu_alu_ctl.scala 42:55]
  wire [32:0] _T_13 = {32'h0,io_ap_sub}; // @[Cat.scala 29:58]
  wire [32:0] _T_15 = _T_12 + _T_13; // @[el2_exu_alu_ctl.scala 42:80]
  wire [32:0] _T_18 = {1'h0,io_b_in}; // @[Cat.scala 29:58]
  wire [32:0] _T_20 = _T_8 + _T_18; // @[el2_exu_alu_ctl.scala 42:132]
  wire [32:0] _T_23 = _T_20 + _T_13; // @[el2_exu_alu_ctl.scala 42:157]
  wire [32:0] aout = io_ap_sub ? _T_15 : _T_23; // @[el2_exu_alu_ctl.scala 42:14]
  wire  cout = aout[32]; // @[el2_exu_alu_ctl.scala 43:18]
  wire  _T_26 = ~io_a_in[31]; // @[el2_exu_alu_ctl.scala 45:14]
  wire  _T_28 = ~bm[31]; // @[el2_exu_alu_ctl.scala 45:29]
  wire  _T_29 = _T_26 & _T_28; // @[el2_exu_alu_ctl.scala 45:27]
  wire  _T_31 = _T_29 & aout[31]; // @[el2_exu_alu_ctl.scala 45:37]
  wire  _T_34 = io_a_in[31] & bm[31]; // @[el2_exu_alu_ctl.scala 45:66]
  wire  _T_36 = ~aout[31]; // @[el2_exu_alu_ctl.scala 45:78]
  wire  _T_37 = _T_34 & _T_36; // @[el2_exu_alu_ctl.scala 45:76]
  wire  ov = _T_31 | _T_37; // @[el2_exu_alu_ctl.scala 45:50]
  wire  eq = $signed(io_a_in) == $signed(io_b_in); // @[el2_exu_alu_ctl.scala 47:38]
  wire  ne = ~eq; // @[el2_exu_alu_ctl.scala 48:29]
  wire  _T_39 = ~io_ap_unsign; // @[el2_exu_alu_ctl.scala 50:30]
  wire  _T_40 = aout[31] ^ ov; // @[el2_exu_alu_ctl.scala 50:51]
  wire  _T_41 = _T_39 & _T_40; // @[el2_exu_alu_ctl.scala 50:44]
  wire  _T_42 = ~cout; // @[el2_exu_alu_ctl.scala 50:78]
  wire  _T_43 = io_ap_unsign & _T_42; // @[el2_exu_alu_ctl.scala 50:76]
  wire  lt = _T_41 | _T_43; // @[el2_exu_alu_ctl.scala 50:58]
  wire  ge = ~lt; // @[el2_exu_alu_ctl.scala 51:29]
  wire [31:0] _T_63 = $signed(io_a_in) & $signed(io_b_in); // @[Mux.scala 27:72]
  wire [31:0] _T_66 = $signed(io_a_in) | $signed(io_b_in); // @[Mux.scala 27:72]
  wire [31:0] _T_69 = $signed(io_a_in) ^ $signed(io_b_in); // @[Mux.scala 27:72]
  wire [31:0] _T_70 = io_csr_ren_in ? $signed(io_b_in) : $signed(32'sh0); // @[Mux.scala 27:72]
  wire [31:0] _T_71 = io_ap_land ? $signed(_T_63) : $signed(32'sh0); // @[Mux.scala 27:72]
  wire [31:0] _T_72 = io_ap_lor ? $signed(_T_66) : $signed(32'sh0); // @[Mux.scala 27:72]
  wire [31:0] _T_73 = io_ap_lxor ? $signed(_T_69) : $signed(32'sh0); // @[Mux.scala 27:72]
  wire [31:0] _T_75 = $signed(_T_70) | $signed(_T_71); // @[Mux.scala 27:72]
  wire [31:0] _T_77 = $signed(_T_75) | $signed(_T_72); // @[Mux.scala 27:72]
  wire [5:0] _T_84 = {1'h0,io_b_in[4:0]}; // @[Cat.scala 29:58]
  wire [5:0] _T_86 = 6'h20 - _T_84; // @[el2_exu_alu_ctl.scala 61:43]
  wire [5:0] _T_93 = io_ap_sll ? _T_86 : 6'h0; // @[Mux.scala 27:72]
  wire [5:0] _T_94 = io_ap_srl ? _T_84 : 6'h0; // @[Mux.scala 27:72]
  wire [5:0] _T_95 = io_ap_sra ? _T_84 : 6'h0; // @[Mux.scala 27:72]
  wire [5:0] _T_96 = _T_93 | _T_94; // @[Mux.scala 27:72]
  wire [5:0] shift_amount = _T_96 | _T_95; // @[Mux.scala 27:72]
  wire [4:0] _T_102 = {io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll}; // @[Cat.scala 29:58]
  wire [4:0] _T_104 = _T_102 & io_b_in[4:0]; // @[el2_exu_alu_ctl.scala 66:63]
  wire [62:0] _T_105 = 63'hffffffff << _T_104; // @[el2_exu_alu_ctl.scala 66:41]
  wire [9:0] _T_115 = {io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra}; // @[Cat.scala 29:58]
  wire [18:0] _T_124 = {_T_115,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra}; // @[Cat.scala 29:58]
  wire [27:0] _T_133 = {_T_124,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra,io_ap_sra}; // @[Cat.scala 29:58]
  wire [30:0] _T_136 = {_T_133,io_ap_sra,io_ap_sra,io_ap_sra}; // @[Cat.scala 29:58]
  wire [9:0] _T_147 = {io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31]}; // @[Cat.scala 29:58]
  wire [18:0] _T_156 = {_T_147,io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31]}; // @[Cat.scala 29:58]
  wire [27:0] _T_165 = {_T_156,io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31],io_a_in[31]}; // @[Cat.scala 29:58]
  wire [30:0] _T_168 = {_T_165,io_a_in[31],io_a_in[31],io_a_in[31]}; // @[Cat.scala 29:58]
  wire [30:0] _T_169 = _T_136 & _T_168; // @[el2_exu_alu_ctl.scala 69:46]
  wire [9:0] _T_179 = {io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll}; // @[Cat.scala 29:58]
  wire [18:0] _T_188 = {_T_179,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll}; // @[Cat.scala 29:58]
  wire [27:0] _T_197 = {_T_188,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll,io_ap_sll}; // @[Cat.scala 29:58]
  wire [30:0] _T_200 = {_T_197,io_ap_sll,io_ap_sll,io_ap_sll}; // @[Cat.scala 29:58]
  wire [30:0] _T_202 = _T_200 & io_a_in[30:0]; // @[el2_exu_alu_ctl.scala 69:92]
  wire [30:0] _T_203 = _T_169 | _T_202; // @[el2_exu_alu_ctl.scala 69:70]
  wire [62:0] shift_extend = {_T_203,io_a_in}; // @[Cat.scala 29:58]
  wire [62:0] shift_long = shift_extend >> shift_amount; // @[el2_exu_alu_ctl.scala 72:34]
  wire [31:0] shift_mask = _T_105[31:0]; // @[el2_exu_alu_ctl.scala 66:16]
  wire [31:0] sout = shift_long[31:0] & shift_mask; // @[el2_exu_alu_ctl.scala 74:36]
  wire  _T_209 = io_ap_sll | io_ap_srl; // @[el2_exu_alu_ctl.scala 77:43]
  wire  sel_shift = _T_209 | io_ap_sra; // @[el2_exu_alu_ctl.scala 77:55]
  wire  _T_210 = io_ap_add | io_ap_sub; // @[el2_exu_alu_ctl.scala 78:43]
  wire  _T_211 = ~io_ap_slt; // @[el2_exu_alu_ctl.scala 78:58]
  wire  sel_adder = _T_210 & _T_211; // @[el2_exu_alu_ctl.scala 78:56]
  wire  _T_212 = io_ap_jal | io_pp_in_pcall; // @[el2_exu_alu_ctl.scala 79:43]
  wire  _T_213 = _T_212 | io_pp_in_pja; // @[el2_exu_alu_ctl.scala 79:60]
  wire  sel_pc = _T_213 | io_pp_in_pret; // @[el2_exu_alu_ctl.scala 79:75]
  wire  slt_one = io_ap_slt & lt; // @[el2_exu_alu_ctl.scala 82:42]
  wire [31:0] _T_216 = {io_pc_in,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_217 = {io_brimm_in,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_220 = _T_216[12:1] + _T_217[12:1]; // @[el2_lib.scala 310:31]
  wire [18:0] _T_223 = _T_216[31:13] + 19'h1; // @[el2_lib.scala 311:27]
  wire [18:0] _T_226 = _T_216[31:13] - 19'h1; // @[el2_lib.scala 312:27]
  wire  _T_229 = ~_T_220[12]; // @[el2_lib.scala 314:27]
  wire  _T_230 = _T_217[12] ^ _T_229; // @[el2_lib.scala 314:25]
  wire  _T_233 = ~_T_217[12]; // @[el2_lib.scala 315:8]
  wire  _T_235 = _T_233 & _T_220[12]; // @[el2_lib.scala 315:14]
  wire  _T_239 = _T_217[12] & _T_229; // @[el2_lib.scala 316:13]
  wire [18:0] _T_241 = _T_230 ? _T_216[31:13] : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_242 = _T_235 ? _T_223 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_243 = _T_239 ? _T_226 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_244 = _T_241 | _T_242; // @[Mux.scala 27:72]
  wire [18:0] _T_245 = _T_244 | _T_243; // @[Mux.scala 27:72]
  wire [31:0] pcout = {_T_245,_T_220[11:0],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_249 = $signed(_T_77) | $signed(_T_73); // @[el2_exu_alu_ctl.scala 88:26]
  wire [31:0] _T_250 = {31'h0,slt_one}; // @[Cat.scala 29:58]
  wire [31:0] _T_251 = _T_249 | _T_250; // @[el2_exu_alu_ctl.scala 88:33]
  wire [31:0] _T_258 = io_ap_csr_imm ? $signed(io_b_in) : $signed(io_a_in); // @[el2_exu_alu_ctl.scala 92:82]
  wire [31:0] _T_259 = sel_shift ? sout : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_260 = sel_adder ? aout[31:0] : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_261 = sel_pc ? pcout : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_262 = io_ap_csr_write ? _T_258 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_263 = _T_259 | _T_260; // @[Mux.scala 27:72]
  wire [31:0] _T_264 = _T_263 | _T_261; // @[Mux.scala 27:72]
  wire [31:0] _T_265 = _T_264 | _T_262; // @[Mux.scala 27:72]
  wire  _T_270 = io_ap_beq & eq; // @[el2_exu_alu_ctl.scala 101:42]
  wire  _T_271 = io_ap_bne & ne; // @[el2_exu_alu_ctl.scala 101:61]
  wire  _T_272 = _T_270 | _T_271; // @[el2_exu_alu_ctl.scala 101:48]
  wire  _T_273 = io_ap_blt & lt; // @[el2_exu_alu_ctl.scala 101:87]
  wire  _T_274 = _T_272 | _T_273; // @[el2_exu_alu_ctl.scala 101:74]
  wire  _T_275 = io_ap_bge & ge; // @[el2_exu_alu_ctl.scala 101:106]
  wire  _T_276 = _T_274 | _T_275; // @[el2_exu_alu_ctl.scala 101:93]
  wire  actual_taken = _T_276 | sel_pc; // @[el2_exu_alu_ctl.scala 101:112]
  wire  _T_277 = io_valid_in & io_ap_predict_nt; // @[el2_exu_alu_ctl.scala 106:44]
  wire  _T_278 = ~actual_taken; // @[el2_exu_alu_ctl.scala 106:65]
  wire  _T_279 = _T_277 & _T_278; // @[el2_exu_alu_ctl.scala 106:63]
  wire  _T_280 = ~sel_pc; // @[el2_exu_alu_ctl.scala 106:81]
  wire  _T_281 = _T_279 & _T_280; // @[el2_exu_alu_ctl.scala 106:79]
  wire  _T_282 = io_valid_in & io_ap_predict_t; // @[el2_exu_alu_ctl.scala 106:106]
  wire  _T_283 = _T_282 & actual_taken; // @[el2_exu_alu_ctl.scala 106:125]
  wire  _T_285 = _T_283 & _T_280; // @[el2_exu_alu_ctl.scala 106:141]
  wire  _T_292 = io_ap_predict_t & _T_278; // @[el2_exu_alu_ctl.scala 111:47]
  wire  _T_293 = io_ap_predict_nt & actual_taken; // @[el2_exu_alu_ctl.scala 111:84]
  wire  cond_mispredict = _T_292 | _T_293; // @[el2_exu_alu_ctl.scala 111:64]
  wire [31:0] _GEN_0 = {{1'd0}, aout[31:1]}; // @[el2_exu_alu_ctl.scala 114:64]
  wire  _T_295 = io_pp_in_prett != _GEN_0; // @[el2_exu_alu_ctl.scala 114:64]
  wire  target_mispredict = io_pp_in_pret & _T_295; // @[el2_exu_alu_ctl.scala 114:46]
  wire  _T_296 = io_ap_jal | cond_mispredict; // @[el2_exu_alu_ctl.scala 116:44]
  wire  _T_297 = _T_296 | target_mispredict; // @[el2_exu_alu_ctl.scala 116:62]
  wire  _T_298 = _T_297 & io_valid_in; // @[el2_exu_alu_ctl.scala 116:83]
  wire  _T_299 = ~io_flush_upper_x; // @[el2_exu_alu_ctl.scala 116:99]
  wire  _T_300 = _T_298 & _T_299; // @[el2_exu_alu_ctl.scala 116:97]
  wire  _T_301 = ~io_flush_lower_r; // @[el2_exu_alu_ctl.scala 116:121]
  wire  _T_311 = io_pp_in_hist[1] & io_pp_in_hist[0]; // @[el2_exu_alu_ctl.scala 122:43]
  wire  _T_313 = ~io_pp_in_hist[0]; // @[el2_exu_alu_ctl.scala 122:67]
  wire  _T_314 = _T_313 & actual_taken; // @[el2_exu_alu_ctl.scala 122:85]
  wire  _T_315 = _T_311 | _T_314; // @[el2_exu_alu_ctl.scala 122:64]
  wire  _T_317 = ~io_pp_in_hist[1]; // @[el2_exu_alu_ctl.scala 123:26]
  wire  _T_319 = _T_317 & _T_278; // @[el2_exu_alu_ctl.scala 123:44]
  wire  _T_321 = io_pp_in_hist[1] & actual_taken; // @[el2_exu_alu_ctl.scala 123:82]
  wire  _T_322 = _T_319 | _T_321; // @[el2_exu_alu_ctl.scala 123:62]
  wire  _T_326 = _T_299 & _T_301; // @[el2_exu_alu_ctl.scala 126:54]
  wire  _T_327 = cond_mispredict | target_mispredict; // @[el2_exu_alu_ctl.scala 126:93]
  rvclkhdr rvclkhdr ( // @[beh_lib.scala 351:21]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[beh_lib.scala 351:21]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  assign io_result_ff = _T_3; // @[el2_exu_alu_ctl.scala 37:16]
  assign io_flush_upper_out = _T_300 & _T_301; // @[el2_exu_alu_ctl.scala 116:28]
  assign io_flush_final_out = _T_300 | io_flush_lower_r; // @[el2_exu_alu_ctl.scala 118:28]
  assign io_flush_path_out = sel_pc ? aout[31:1] : pcout[31:1]; // @[el2_exu_alu_ctl.scala 108:24]
  assign io_pc_ff = _T_1; // @[el2_exu_alu_ctl.scala 35:12]
  assign io_pred_correct_out = _T_281 | _T_285; // @[el2_exu_alu_ctl.scala 106:28]
  assign io_predict_p_out_misp = _T_326 & _T_327; // @[el2_exu_alu_ctl.scala 125:33 el2_exu_alu_ctl.scala 126:33]
  assign io_predict_p_out_ataken = _T_276 | sel_pc; // @[el2_exu_alu_ctl.scala 125:33 el2_exu_alu_ctl.scala 127:33]
  assign io_predict_p_out_boffset = io_pp_in_boffset; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_pc4 = io_pp_in_pc4; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_hist = {_T_315,_T_322}; // @[el2_exu_alu_ctl.scala 125:33 el2_exu_alu_ctl.scala 128:33]
  assign io_predict_p_out_toffset = io_pp_in_toffset; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_valid = io_pp_in_valid; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_br_error = io_pp_in_br_error; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_br_start_error = io_pp_in_br_start_error; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_prett = io_pp_in_prett; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_pcall = io_pp_in_pcall; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_pret = io_pp_in_pret; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_pja = io_pp_in_pja; // @[el2_exu_alu_ctl.scala 125:33]
  assign io_predict_p_out_way = io_pp_in_way; // @[el2_exu_alu_ctl.scala 125:33]
  assign rvclkhdr_io_clk = clock; // @[beh_lib.scala 353:16]
  assign rvclkhdr_io_en = io_enable; // @[beh_lib.scala 354:15]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[beh_lib.scala 355:22]
  assign rvclkhdr_1_io_clk = clock; // @[beh_lib.scala 353:16]
  assign rvclkhdr_1_io_en = io_enable; // @[beh_lib.scala 354:15]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[beh_lib.scala 355:22]
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
  _T_1 = _RAND_0[30:0];
  _RAND_1 = {1{`RANDOM}};
  _T_3 = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    _T_1 = 31'h0;
  end
  if (reset) begin
    _T_3 = 32'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1 <= 31'h0;
    end else begin
      _T_1 <= io_pc_in;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_3 <= 32'h0;
    end else begin
      _T_3 <= _T_251 | _T_265;
    end
  end
endmodule
