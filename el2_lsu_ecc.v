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
module el2_lsu_ecc(
  input         clock,
  input         reset,
  input         io_lsu_c2_r_clk,
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
  input  [31:0] io_stbuf_data_any,
  input         io_dec_tlu_core_ecc_disable,
  input         io_lsu_dccm_rden_r,
  input         io_addr_in_dccm_r,
  input  [15:0] io_lsu_addr_r,
  input  [15:0] io_end_addr_r,
  input  [15:0] io_lsu_addr_m,
  input  [15:0] io_end_addr_m,
  input  [31:0] io_dccm_rdata_hi_r,
  input  [31:0] io_dccm_rdata_lo_r,
  input  [31:0] io_dccm_rdata_hi_m,
  input  [31:0] io_dccm_rdata_lo_m,
  input  [6:0]  io_dccm_data_ecc_hi_r,
  input  [6:0]  io_dccm_data_ecc_lo_r,
  input  [6:0]  io_dccm_data_ecc_hi_m,
  input  [6:0]  io_dccm_data_ecc_lo_m,
  input         io_ld_single_ecc_error_r,
  input         io_ld_single_ecc_error_r_ff,
  input         io_lsu_dccm_rden_m,
  input         io_addr_in_dccm_m,
  input         io_dma_dccm_wen,
  input  [31:0] io_dma_dccm_wdata_lo,
  input  [31:0] io_dma_dccm_wdata_hi,
  input         io_scan_mode,
  output [31:0] io_sec_data_hi_r,
  output [31:0] io_sec_data_lo_r,
  output [31:0] io_sec_data_hi_m,
  output [31:0] io_sec_data_lo_m,
  output [31:0] io_sec_data_hi_r_ff,
  output [31:0] io_sec_data_lo_r_ff,
  output [6:0]  io_dma_dccm_wdata_ecc_hi,
  output [6:0]  io_dma_dccm_wdata_ecc_lo,
  output [6:0]  io_stbuf_ecc_any,
  output [6:0]  io_sec_data_ecc_hi_r_ff,
  output [6:0]  io_sec_data_ecc_lo_r_ff,
  output        io_single_ecc_error_hi_r,
  output        io_single_ecc_error_lo_r,
  output        io_lsu_single_ecc_error_r,
  output        io_lsu_double_ecc_error_r,
  output        io_lsu_single_ecc_error_m,
  output        io_lsu_double_ecc_error_m
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
  wire  _T_96 = ^io_dccm_rdata_hi_m; // @[el2_lib.scala 333:30]
  wire  _T_97 = ^io_dccm_data_ecc_hi_m; // @[el2_lib.scala 333:44]
  wire  _T_98 = _T_96 ^ _T_97; // @[el2_lib.scala 333:35]
  wire [5:0] _T_106 = {io_dccm_rdata_hi_m[31],io_dccm_rdata_hi_m[30],io_dccm_rdata_hi_m[29],io_dccm_rdata_hi_m[28],io_dccm_rdata_hi_m[27],io_dccm_rdata_hi_m[26]}; // @[el2_lib.scala 333:76]
  wire  _T_107 = ^_T_106; // @[el2_lib.scala 333:83]
  wire  _T_108 = io_dccm_data_ecc_hi_m[5] ^ _T_107; // @[el2_lib.scala 333:71]
  wire [6:0] _T_115 = {io_dccm_rdata_hi_m[17],io_dccm_rdata_hi_m[16],io_dccm_rdata_hi_m[15],io_dccm_rdata_hi_m[14],io_dccm_rdata_hi_m[13],io_dccm_rdata_hi_m[12],io_dccm_rdata_hi_m[11]}; // @[el2_lib.scala 333:103]
  wire [14:0] _T_123 = {io_dccm_rdata_hi_m[25],io_dccm_rdata_hi_m[24],io_dccm_rdata_hi_m[23],io_dccm_rdata_hi_m[22],io_dccm_rdata_hi_m[21],io_dccm_rdata_hi_m[20],io_dccm_rdata_hi_m[19],io_dccm_rdata_hi_m[18],_T_115}; // @[el2_lib.scala 333:103]
  wire  _T_124 = ^_T_123; // @[el2_lib.scala 333:110]
  wire  _T_125 = io_dccm_data_ecc_hi_m[4] ^ _T_124; // @[el2_lib.scala 333:98]
  wire [6:0] _T_132 = {io_dccm_rdata_hi_m[10],io_dccm_rdata_hi_m[9],io_dccm_rdata_hi_m[8],io_dccm_rdata_hi_m[7],io_dccm_rdata_hi_m[6],io_dccm_rdata_hi_m[5],io_dccm_rdata_hi_m[4]}; // @[el2_lib.scala 333:130]
  wire [14:0] _T_140 = {io_dccm_rdata_hi_m[25],io_dccm_rdata_hi_m[24],io_dccm_rdata_hi_m[23],io_dccm_rdata_hi_m[22],io_dccm_rdata_hi_m[21],io_dccm_rdata_hi_m[20],io_dccm_rdata_hi_m[19],io_dccm_rdata_hi_m[18],_T_132}; // @[el2_lib.scala 333:130]
  wire  _T_141 = ^_T_140; // @[el2_lib.scala 333:137]
  wire  _T_142 = io_dccm_data_ecc_hi_m[3] ^ _T_141; // @[el2_lib.scala 333:125]
  wire [8:0] _T_151 = {io_dccm_rdata_hi_m[15],io_dccm_rdata_hi_m[14],io_dccm_rdata_hi_m[10],io_dccm_rdata_hi_m[9],io_dccm_rdata_hi_m[8],io_dccm_rdata_hi_m[7],io_dccm_rdata_hi_m[3],io_dccm_rdata_hi_m[2],io_dccm_rdata_hi_m[1]}; // @[el2_lib.scala 333:157]
  wire [17:0] _T_160 = {io_dccm_rdata_hi_m[31],io_dccm_rdata_hi_m[30],io_dccm_rdata_hi_m[29],io_dccm_rdata_hi_m[25],io_dccm_rdata_hi_m[24],io_dccm_rdata_hi_m[23],io_dccm_rdata_hi_m[22],io_dccm_rdata_hi_m[17],io_dccm_rdata_hi_m[16],_T_151}; // @[el2_lib.scala 333:157]
  wire  _T_161 = ^_T_160; // @[el2_lib.scala 333:164]
  wire  _T_162 = io_dccm_data_ecc_hi_m[2] ^ _T_161; // @[el2_lib.scala 333:152]
  wire [8:0] _T_171 = {io_dccm_rdata_hi_m[13],io_dccm_rdata_hi_m[12],io_dccm_rdata_hi_m[10],io_dccm_rdata_hi_m[9],io_dccm_rdata_hi_m[6],io_dccm_rdata_hi_m[5],io_dccm_rdata_hi_m[3],io_dccm_rdata_hi_m[2],io_dccm_rdata_hi_m[0]}; // @[el2_lib.scala 333:184]
  wire [17:0] _T_180 = {io_dccm_rdata_hi_m[31],io_dccm_rdata_hi_m[28],io_dccm_rdata_hi_m[27],io_dccm_rdata_hi_m[25],io_dccm_rdata_hi_m[24],io_dccm_rdata_hi_m[21],io_dccm_rdata_hi_m[20],io_dccm_rdata_hi_m[17],io_dccm_rdata_hi_m[16],_T_171}; // @[el2_lib.scala 333:184]
  wire  _T_181 = ^_T_180; // @[el2_lib.scala 333:191]
  wire  _T_182 = io_dccm_data_ecc_hi_m[1] ^ _T_181; // @[el2_lib.scala 333:179]
  wire [8:0] _T_191 = {io_dccm_rdata_hi_m[13],io_dccm_rdata_hi_m[11],io_dccm_rdata_hi_m[10],io_dccm_rdata_hi_m[8],io_dccm_rdata_hi_m[6],io_dccm_rdata_hi_m[4],io_dccm_rdata_hi_m[3],io_dccm_rdata_hi_m[1],io_dccm_rdata_hi_m[0]}; // @[el2_lib.scala 333:211]
  wire [17:0] _T_200 = {io_dccm_rdata_hi_m[30],io_dccm_rdata_hi_m[28],io_dccm_rdata_hi_m[26],io_dccm_rdata_hi_m[25],io_dccm_rdata_hi_m[23],io_dccm_rdata_hi_m[21],io_dccm_rdata_hi_m[19],io_dccm_rdata_hi_m[17],io_dccm_rdata_hi_m[15],_T_191}; // @[el2_lib.scala 333:211]
  wire  _T_201 = ^_T_200; // @[el2_lib.scala 333:218]
  wire  _T_202 = io_dccm_data_ecc_hi_m[0] ^ _T_201; // @[el2_lib.scala 333:206]
  wire [6:0] _T_208 = {_T_98,_T_108,_T_125,_T_142,_T_162,_T_182,_T_202}; // @[Cat.scala 29:58]
  wire  _T_209 = _T_208 != 7'h0; // @[el2_lib.scala 334:44]
  wire  _T_1131 = ~io_dec_tlu_core_ecc_disable; // @[el2_lsu_ecc.scala 107:68]
  wire  _T_1138 = io_lsu_pkt_m_load | io_lsu_pkt_m_store; // @[el2_lsu_ecc.scala 125:60]
  wire  _T_1139 = io_lsu_pkt_m_valid & _T_1138; // @[el2_lsu_ecc.scala 125:39]
  wire  _T_1140 = _T_1139 & io_addr_in_dccm_m; // @[el2_lsu_ecc.scala 125:82]
  wire  is_ldst_m = _T_1140 & io_lsu_dccm_rden_m; // @[el2_lsu_ecc.scala 125:102]
  wire  ldst_dual_m = io_lsu_addr_m[2] != io_end_addr_m[2]; // @[el2_lsu_ecc.scala 124:39]
  wire  _T_1144 = ldst_dual_m | io_lsu_pkt_m_dma; // @[el2_lsu_ecc.scala 127:48]
  wire  _T_1145 = is_ldst_m & _T_1144; // @[el2_lsu_ecc.scala 127:33]
  wire  is_ldst_hi_m = _T_1145 & _T_1131; // @[el2_lsu_ecc.scala 127:68]
  wire  _T_210 = is_ldst_hi_m & _T_209; // @[el2_lib.scala 334:32]
  wire  single_ecc_error_hi_any = _T_210 & _T_208[6]; // @[el2_lib.scala 334:53]
  wire  _T_215 = ~_T_208[6]; // @[el2_lib.scala 335:55]
  wire  double_ecc_error_hi_any = _T_210 & _T_215; // @[el2_lib.scala 335:53]
  wire  _T_218 = _T_208[5:0] == 6'h1; // @[el2_lib.scala 339:41]
  wire  _T_220 = _T_208[5:0] == 6'h2; // @[el2_lib.scala 339:41]
  wire  _T_222 = _T_208[5:0] == 6'h3; // @[el2_lib.scala 339:41]
  wire  _T_224 = _T_208[5:0] == 6'h4; // @[el2_lib.scala 339:41]
  wire  _T_226 = _T_208[5:0] == 6'h5; // @[el2_lib.scala 339:41]
  wire  _T_228 = _T_208[5:0] == 6'h6; // @[el2_lib.scala 339:41]
  wire  _T_230 = _T_208[5:0] == 6'h7; // @[el2_lib.scala 339:41]
  wire  _T_232 = _T_208[5:0] == 6'h8; // @[el2_lib.scala 339:41]
  wire  _T_234 = _T_208[5:0] == 6'h9; // @[el2_lib.scala 339:41]
  wire  _T_236 = _T_208[5:0] == 6'ha; // @[el2_lib.scala 339:41]
  wire  _T_238 = _T_208[5:0] == 6'hb; // @[el2_lib.scala 339:41]
  wire  _T_240 = _T_208[5:0] == 6'hc; // @[el2_lib.scala 339:41]
  wire  _T_242 = _T_208[5:0] == 6'hd; // @[el2_lib.scala 339:41]
  wire  _T_244 = _T_208[5:0] == 6'he; // @[el2_lib.scala 339:41]
  wire  _T_246 = _T_208[5:0] == 6'hf; // @[el2_lib.scala 339:41]
  wire  _T_248 = _T_208[5:0] == 6'h10; // @[el2_lib.scala 339:41]
  wire  _T_250 = _T_208[5:0] == 6'h11; // @[el2_lib.scala 339:41]
  wire  _T_252 = _T_208[5:0] == 6'h12; // @[el2_lib.scala 339:41]
  wire  _T_254 = _T_208[5:0] == 6'h13; // @[el2_lib.scala 339:41]
  wire  _T_256 = _T_208[5:0] == 6'h14; // @[el2_lib.scala 339:41]
  wire  _T_258 = _T_208[5:0] == 6'h15; // @[el2_lib.scala 339:41]
  wire  _T_260 = _T_208[5:0] == 6'h16; // @[el2_lib.scala 339:41]
  wire  _T_262 = _T_208[5:0] == 6'h17; // @[el2_lib.scala 339:41]
  wire  _T_264 = _T_208[5:0] == 6'h18; // @[el2_lib.scala 339:41]
  wire  _T_266 = _T_208[5:0] == 6'h19; // @[el2_lib.scala 339:41]
  wire  _T_268 = _T_208[5:0] == 6'h1a; // @[el2_lib.scala 339:41]
  wire  _T_270 = _T_208[5:0] == 6'h1b; // @[el2_lib.scala 339:41]
  wire  _T_272 = _T_208[5:0] == 6'h1c; // @[el2_lib.scala 339:41]
  wire  _T_274 = _T_208[5:0] == 6'h1d; // @[el2_lib.scala 339:41]
  wire  _T_276 = _T_208[5:0] == 6'h1e; // @[el2_lib.scala 339:41]
  wire  _T_278 = _T_208[5:0] == 6'h1f; // @[el2_lib.scala 339:41]
  wire  _T_280 = _T_208[5:0] == 6'h20; // @[el2_lib.scala 339:41]
  wire  _T_282 = _T_208[5:0] == 6'h21; // @[el2_lib.scala 339:41]
  wire  _T_284 = _T_208[5:0] == 6'h22; // @[el2_lib.scala 339:41]
  wire  _T_286 = _T_208[5:0] == 6'h23; // @[el2_lib.scala 339:41]
  wire  _T_288 = _T_208[5:0] == 6'h24; // @[el2_lib.scala 339:41]
  wire  _T_290 = _T_208[5:0] == 6'h25; // @[el2_lib.scala 339:41]
  wire  _T_292 = _T_208[5:0] == 6'h26; // @[el2_lib.scala 339:41]
  wire  _T_294 = _T_208[5:0] == 6'h27; // @[el2_lib.scala 339:41]
  wire [7:0] _T_309 = {io_dccm_data_ecc_hi_m[3],io_dccm_rdata_hi_m[3:1],io_dccm_data_ecc_hi_m[2],io_dccm_rdata_hi_m[0],io_dccm_data_ecc_hi_m[1:0]}; // @[Cat.scala 29:58]
  wire [38:0] _T_315 = {io_dccm_data_ecc_hi_m[6],io_dccm_rdata_hi_m[31:26],io_dccm_data_ecc_hi_m[5],io_dccm_rdata_hi_m[25:11],io_dccm_data_ecc_hi_m[4],io_dccm_rdata_hi_m[10:4],_T_309}; // @[Cat.scala 29:58]
  wire [9:0] _T_333 = {_T_254,_T_252,_T_250,_T_248,_T_246,_T_244,_T_242,_T_240,_T_238,_T_236}; // @[el2_lib.scala 342:69]
  wire [18:0] _T_334 = {_T_333,_T_234,_T_232,_T_230,_T_228,_T_226,_T_224,_T_222,_T_220,_T_218}; // @[el2_lib.scala 342:69]
  wire [9:0] _T_343 = {_T_274,_T_272,_T_270,_T_268,_T_266,_T_264,_T_262,_T_260,_T_258,_T_256}; // @[el2_lib.scala 342:69]
  wire [9:0] _T_352 = {_T_294,_T_292,_T_290,_T_288,_T_286,_T_284,_T_282,_T_280,_T_278,_T_276}; // @[el2_lib.scala 342:69]
  wire [38:0] _T_354 = {_T_352,_T_343,_T_334}; // @[el2_lib.scala 342:69]
  wire [38:0] _T_355 = _T_354 ^ _T_315; // @[el2_lib.scala 342:76]
  wire [38:0] _T_356 = single_ecc_error_hi_any ? _T_355 : _T_315; // @[el2_lib.scala 342:31]
  wire [3:0] _T_362 = {_T_356[6:4],_T_356[2]}; // @[Cat.scala 29:58]
  wire [27:0] _T_364 = {_T_356[37:32],_T_356[30:16],_T_356[14:8]}; // @[Cat.scala 29:58]
  wire  _T_474 = ^io_dccm_rdata_lo_m; // @[el2_lib.scala 333:30]
  wire  _T_475 = ^io_dccm_data_ecc_lo_m; // @[el2_lib.scala 333:44]
  wire  _T_476 = _T_474 ^ _T_475; // @[el2_lib.scala 333:35]
  wire [5:0] _T_484 = {io_dccm_rdata_lo_m[31],io_dccm_rdata_lo_m[30],io_dccm_rdata_lo_m[29],io_dccm_rdata_lo_m[28],io_dccm_rdata_lo_m[27],io_dccm_rdata_lo_m[26]}; // @[el2_lib.scala 333:76]
  wire  _T_485 = ^_T_484; // @[el2_lib.scala 333:83]
  wire  _T_486 = io_dccm_data_ecc_lo_m[5] ^ _T_485; // @[el2_lib.scala 333:71]
  wire [6:0] _T_493 = {io_dccm_rdata_lo_m[17],io_dccm_rdata_lo_m[16],io_dccm_rdata_lo_m[15],io_dccm_rdata_lo_m[14],io_dccm_rdata_lo_m[13],io_dccm_rdata_lo_m[12],io_dccm_rdata_lo_m[11]}; // @[el2_lib.scala 333:103]
  wire [14:0] _T_501 = {io_dccm_rdata_lo_m[25],io_dccm_rdata_lo_m[24],io_dccm_rdata_lo_m[23],io_dccm_rdata_lo_m[22],io_dccm_rdata_lo_m[21],io_dccm_rdata_lo_m[20],io_dccm_rdata_lo_m[19],io_dccm_rdata_lo_m[18],_T_493}; // @[el2_lib.scala 333:103]
  wire  _T_502 = ^_T_501; // @[el2_lib.scala 333:110]
  wire  _T_503 = io_dccm_data_ecc_lo_m[4] ^ _T_502; // @[el2_lib.scala 333:98]
  wire [6:0] _T_510 = {io_dccm_rdata_lo_m[10],io_dccm_rdata_lo_m[9],io_dccm_rdata_lo_m[8],io_dccm_rdata_lo_m[7],io_dccm_rdata_lo_m[6],io_dccm_rdata_lo_m[5],io_dccm_rdata_lo_m[4]}; // @[el2_lib.scala 333:130]
  wire [14:0] _T_518 = {io_dccm_rdata_lo_m[25],io_dccm_rdata_lo_m[24],io_dccm_rdata_lo_m[23],io_dccm_rdata_lo_m[22],io_dccm_rdata_lo_m[21],io_dccm_rdata_lo_m[20],io_dccm_rdata_lo_m[19],io_dccm_rdata_lo_m[18],_T_510}; // @[el2_lib.scala 333:130]
  wire  _T_519 = ^_T_518; // @[el2_lib.scala 333:137]
  wire  _T_520 = io_dccm_data_ecc_lo_m[3] ^ _T_519; // @[el2_lib.scala 333:125]
  wire [8:0] _T_529 = {io_dccm_rdata_lo_m[15],io_dccm_rdata_lo_m[14],io_dccm_rdata_lo_m[10],io_dccm_rdata_lo_m[9],io_dccm_rdata_lo_m[8],io_dccm_rdata_lo_m[7],io_dccm_rdata_lo_m[3],io_dccm_rdata_lo_m[2],io_dccm_rdata_lo_m[1]}; // @[el2_lib.scala 333:157]
  wire [17:0] _T_538 = {io_dccm_rdata_lo_m[31],io_dccm_rdata_lo_m[30],io_dccm_rdata_lo_m[29],io_dccm_rdata_lo_m[25],io_dccm_rdata_lo_m[24],io_dccm_rdata_lo_m[23],io_dccm_rdata_lo_m[22],io_dccm_rdata_lo_m[17],io_dccm_rdata_lo_m[16],_T_529}; // @[el2_lib.scala 333:157]
  wire  _T_539 = ^_T_538; // @[el2_lib.scala 333:164]
  wire  _T_540 = io_dccm_data_ecc_lo_m[2] ^ _T_539; // @[el2_lib.scala 333:152]
  wire [8:0] _T_549 = {io_dccm_rdata_lo_m[13],io_dccm_rdata_lo_m[12],io_dccm_rdata_lo_m[10],io_dccm_rdata_lo_m[9],io_dccm_rdata_lo_m[6],io_dccm_rdata_lo_m[5],io_dccm_rdata_lo_m[3],io_dccm_rdata_lo_m[2],io_dccm_rdata_lo_m[0]}; // @[el2_lib.scala 333:184]
  wire [17:0] _T_558 = {io_dccm_rdata_lo_m[31],io_dccm_rdata_lo_m[28],io_dccm_rdata_lo_m[27],io_dccm_rdata_lo_m[25],io_dccm_rdata_lo_m[24],io_dccm_rdata_lo_m[21],io_dccm_rdata_lo_m[20],io_dccm_rdata_lo_m[17],io_dccm_rdata_lo_m[16],_T_549}; // @[el2_lib.scala 333:184]
  wire  _T_559 = ^_T_558; // @[el2_lib.scala 333:191]
  wire  _T_560 = io_dccm_data_ecc_lo_m[1] ^ _T_559; // @[el2_lib.scala 333:179]
  wire [8:0] _T_569 = {io_dccm_rdata_lo_m[13],io_dccm_rdata_lo_m[11],io_dccm_rdata_lo_m[10],io_dccm_rdata_lo_m[8],io_dccm_rdata_lo_m[6],io_dccm_rdata_lo_m[4],io_dccm_rdata_lo_m[3],io_dccm_rdata_lo_m[1],io_dccm_rdata_lo_m[0]}; // @[el2_lib.scala 333:211]
  wire [17:0] _T_578 = {io_dccm_rdata_lo_m[30],io_dccm_rdata_lo_m[28],io_dccm_rdata_lo_m[26],io_dccm_rdata_lo_m[25],io_dccm_rdata_lo_m[23],io_dccm_rdata_lo_m[21],io_dccm_rdata_lo_m[19],io_dccm_rdata_lo_m[17],io_dccm_rdata_lo_m[15],_T_569}; // @[el2_lib.scala 333:211]
  wire  _T_579 = ^_T_578; // @[el2_lib.scala 333:218]
  wire  _T_580 = io_dccm_data_ecc_lo_m[0] ^ _T_579; // @[el2_lib.scala 333:206]
  wire [6:0] _T_586 = {_T_476,_T_486,_T_503,_T_520,_T_540,_T_560,_T_580}; // @[Cat.scala 29:58]
  wire  _T_587 = _T_586 != 7'h0; // @[el2_lib.scala 334:44]
  wire  is_ldst_lo_m = is_ldst_m & _T_1131; // @[el2_lsu_ecc.scala 126:33]
  wire  _T_588 = is_ldst_lo_m & _T_587; // @[el2_lib.scala 334:32]
  wire  single_ecc_error_lo_any = _T_588 & _T_586[6]; // @[el2_lib.scala 334:53]
  wire  _T_593 = ~_T_586[6]; // @[el2_lib.scala 335:55]
  wire  double_ecc_error_lo_any = _T_588 & _T_593; // @[el2_lib.scala 335:53]
  wire  _T_596 = _T_586[5:0] == 6'h1; // @[el2_lib.scala 339:41]
  wire  _T_598 = _T_586[5:0] == 6'h2; // @[el2_lib.scala 339:41]
  wire  _T_600 = _T_586[5:0] == 6'h3; // @[el2_lib.scala 339:41]
  wire  _T_602 = _T_586[5:0] == 6'h4; // @[el2_lib.scala 339:41]
  wire  _T_604 = _T_586[5:0] == 6'h5; // @[el2_lib.scala 339:41]
  wire  _T_606 = _T_586[5:0] == 6'h6; // @[el2_lib.scala 339:41]
  wire  _T_608 = _T_586[5:0] == 6'h7; // @[el2_lib.scala 339:41]
  wire  _T_610 = _T_586[5:0] == 6'h8; // @[el2_lib.scala 339:41]
  wire  _T_612 = _T_586[5:0] == 6'h9; // @[el2_lib.scala 339:41]
  wire  _T_614 = _T_586[5:0] == 6'ha; // @[el2_lib.scala 339:41]
  wire  _T_616 = _T_586[5:0] == 6'hb; // @[el2_lib.scala 339:41]
  wire  _T_618 = _T_586[5:0] == 6'hc; // @[el2_lib.scala 339:41]
  wire  _T_620 = _T_586[5:0] == 6'hd; // @[el2_lib.scala 339:41]
  wire  _T_622 = _T_586[5:0] == 6'he; // @[el2_lib.scala 339:41]
  wire  _T_624 = _T_586[5:0] == 6'hf; // @[el2_lib.scala 339:41]
  wire  _T_626 = _T_586[5:0] == 6'h10; // @[el2_lib.scala 339:41]
  wire  _T_628 = _T_586[5:0] == 6'h11; // @[el2_lib.scala 339:41]
  wire  _T_630 = _T_586[5:0] == 6'h12; // @[el2_lib.scala 339:41]
  wire  _T_632 = _T_586[5:0] == 6'h13; // @[el2_lib.scala 339:41]
  wire  _T_634 = _T_586[5:0] == 6'h14; // @[el2_lib.scala 339:41]
  wire  _T_636 = _T_586[5:0] == 6'h15; // @[el2_lib.scala 339:41]
  wire  _T_638 = _T_586[5:0] == 6'h16; // @[el2_lib.scala 339:41]
  wire  _T_640 = _T_586[5:0] == 6'h17; // @[el2_lib.scala 339:41]
  wire  _T_642 = _T_586[5:0] == 6'h18; // @[el2_lib.scala 339:41]
  wire  _T_644 = _T_586[5:0] == 6'h19; // @[el2_lib.scala 339:41]
  wire  _T_646 = _T_586[5:0] == 6'h1a; // @[el2_lib.scala 339:41]
  wire  _T_648 = _T_586[5:0] == 6'h1b; // @[el2_lib.scala 339:41]
  wire  _T_650 = _T_586[5:0] == 6'h1c; // @[el2_lib.scala 339:41]
  wire  _T_652 = _T_586[5:0] == 6'h1d; // @[el2_lib.scala 339:41]
  wire  _T_654 = _T_586[5:0] == 6'h1e; // @[el2_lib.scala 339:41]
  wire  _T_656 = _T_586[5:0] == 6'h1f; // @[el2_lib.scala 339:41]
  wire  _T_658 = _T_586[5:0] == 6'h20; // @[el2_lib.scala 339:41]
  wire  _T_660 = _T_586[5:0] == 6'h21; // @[el2_lib.scala 339:41]
  wire  _T_662 = _T_586[5:0] == 6'h22; // @[el2_lib.scala 339:41]
  wire  _T_664 = _T_586[5:0] == 6'h23; // @[el2_lib.scala 339:41]
  wire  _T_666 = _T_586[5:0] == 6'h24; // @[el2_lib.scala 339:41]
  wire  _T_668 = _T_586[5:0] == 6'h25; // @[el2_lib.scala 339:41]
  wire  _T_670 = _T_586[5:0] == 6'h26; // @[el2_lib.scala 339:41]
  wire  _T_672 = _T_586[5:0] == 6'h27; // @[el2_lib.scala 339:41]
  wire [7:0] _T_687 = {io_dccm_data_ecc_lo_m[3],io_dccm_rdata_lo_m[3:1],io_dccm_data_ecc_lo_m[2],io_dccm_rdata_lo_m[0],io_dccm_data_ecc_lo_m[1:0]}; // @[Cat.scala 29:58]
  wire [38:0] _T_693 = {io_dccm_data_ecc_lo_m[6],io_dccm_rdata_lo_m[31:26],io_dccm_data_ecc_lo_m[5],io_dccm_rdata_lo_m[25:11],io_dccm_data_ecc_lo_m[4],io_dccm_rdata_lo_m[10:4],_T_687}; // @[Cat.scala 29:58]
  wire [9:0] _T_711 = {_T_632,_T_630,_T_628,_T_626,_T_624,_T_622,_T_620,_T_618,_T_616,_T_614}; // @[el2_lib.scala 342:69]
  wire [18:0] _T_712 = {_T_711,_T_612,_T_610,_T_608,_T_606,_T_604,_T_602,_T_600,_T_598,_T_596}; // @[el2_lib.scala 342:69]
  wire [9:0] _T_721 = {_T_652,_T_650,_T_648,_T_646,_T_644,_T_642,_T_640,_T_638,_T_636,_T_634}; // @[el2_lib.scala 342:69]
  wire [9:0] _T_730 = {_T_672,_T_670,_T_668,_T_666,_T_664,_T_662,_T_660,_T_658,_T_656,_T_654}; // @[el2_lib.scala 342:69]
  wire [38:0] _T_732 = {_T_730,_T_721,_T_712}; // @[el2_lib.scala 342:69]
  wire [38:0] _T_733 = _T_732 ^ _T_693; // @[el2_lib.scala 342:76]
  wire [38:0] _T_734 = single_ecc_error_lo_any ? _T_733 : _T_693; // @[el2_lib.scala 342:31]
  wire [3:0] _T_740 = {_T_734[6:4],_T_734[2]}; // @[Cat.scala 29:58]
  wire [27:0] _T_742 = {_T_734[37:32],_T_734[30:16],_T_734[14:8]}; // @[Cat.scala 29:58]
  wire [31:0] _T_1158 = io_dma_dccm_wen ? io_dma_dccm_wdata_lo : io_stbuf_data_any; // @[el2_lsu_ecc.scala 149:87]
  wire [31:0] dccm_wdata_lo_any = io_ld_single_ecc_error_r_ff ? io_sec_data_lo_r_ff : _T_1158; // @[el2_lsu_ecc.scala 149:27]
  wire  _T_774 = dccm_wdata_lo_any[0] ^ dccm_wdata_lo_any[1]; // @[el2_lib.scala 259:74]
  wire  _T_775 = _T_774 ^ dccm_wdata_lo_any[3]; // @[el2_lib.scala 259:74]
  wire  _T_776 = _T_775 ^ dccm_wdata_lo_any[4]; // @[el2_lib.scala 259:74]
  wire  _T_777 = _T_776 ^ dccm_wdata_lo_any[6]; // @[el2_lib.scala 259:74]
  wire  _T_778 = _T_777 ^ dccm_wdata_lo_any[8]; // @[el2_lib.scala 259:74]
  wire  _T_779 = _T_778 ^ dccm_wdata_lo_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_780 = _T_779 ^ dccm_wdata_lo_any[11]; // @[el2_lib.scala 259:74]
  wire  _T_781 = _T_780 ^ dccm_wdata_lo_any[13]; // @[el2_lib.scala 259:74]
  wire  _T_782 = _T_781 ^ dccm_wdata_lo_any[15]; // @[el2_lib.scala 259:74]
  wire  _T_783 = _T_782 ^ dccm_wdata_lo_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_784 = _T_783 ^ dccm_wdata_lo_any[19]; // @[el2_lib.scala 259:74]
  wire  _T_785 = _T_784 ^ dccm_wdata_lo_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_786 = _T_785 ^ dccm_wdata_lo_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_787 = _T_786 ^ dccm_wdata_lo_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_788 = _T_787 ^ dccm_wdata_lo_any[26]; // @[el2_lib.scala 259:74]
  wire  _T_789 = _T_788 ^ dccm_wdata_lo_any[28]; // @[el2_lib.scala 259:74]
  wire  _T_790 = _T_789 ^ dccm_wdata_lo_any[30]; // @[el2_lib.scala 259:74]
  wire  _T_809 = dccm_wdata_lo_any[0] ^ dccm_wdata_lo_any[2]; // @[el2_lib.scala 259:74]
  wire  _T_810 = _T_809 ^ dccm_wdata_lo_any[3]; // @[el2_lib.scala 259:74]
  wire  _T_811 = _T_810 ^ dccm_wdata_lo_any[5]; // @[el2_lib.scala 259:74]
  wire  _T_812 = _T_811 ^ dccm_wdata_lo_any[6]; // @[el2_lib.scala 259:74]
  wire  _T_813 = _T_812 ^ dccm_wdata_lo_any[9]; // @[el2_lib.scala 259:74]
  wire  _T_814 = _T_813 ^ dccm_wdata_lo_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_815 = _T_814 ^ dccm_wdata_lo_any[12]; // @[el2_lib.scala 259:74]
  wire  _T_816 = _T_815 ^ dccm_wdata_lo_any[13]; // @[el2_lib.scala 259:74]
  wire  _T_817 = _T_816 ^ dccm_wdata_lo_any[16]; // @[el2_lib.scala 259:74]
  wire  _T_818 = _T_817 ^ dccm_wdata_lo_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_819 = _T_818 ^ dccm_wdata_lo_any[20]; // @[el2_lib.scala 259:74]
  wire  _T_820 = _T_819 ^ dccm_wdata_lo_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_821 = _T_820 ^ dccm_wdata_lo_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_822 = _T_821 ^ dccm_wdata_lo_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_823 = _T_822 ^ dccm_wdata_lo_any[27]; // @[el2_lib.scala 259:74]
  wire  _T_824 = _T_823 ^ dccm_wdata_lo_any[28]; // @[el2_lib.scala 259:74]
  wire  _T_825 = _T_824 ^ dccm_wdata_lo_any[31]; // @[el2_lib.scala 259:74]
  wire  _T_844 = dccm_wdata_lo_any[1] ^ dccm_wdata_lo_any[2]; // @[el2_lib.scala 259:74]
  wire  _T_845 = _T_844 ^ dccm_wdata_lo_any[3]; // @[el2_lib.scala 259:74]
  wire  _T_846 = _T_845 ^ dccm_wdata_lo_any[7]; // @[el2_lib.scala 259:74]
  wire  _T_847 = _T_846 ^ dccm_wdata_lo_any[8]; // @[el2_lib.scala 259:74]
  wire  _T_848 = _T_847 ^ dccm_wdata_lo_any[9]; // @[el2_lib.scala 259:74]
  wire  _T_849 = _T_848 ^ dccm_wdata_lo_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_850 = _T_849 ^ dccm_wdata_lo_any[14]; // @[el2_lib.scala 259:74]
  wire  _T_851 = _T_850 ^ dccm_wdata_lo_any[15]; // @[el2_lib.scala 259:74]
  wire  _T_852 = _T_851 ^ dccm_wdata_lo_any[16]; // @[el2_lib.scala 259:74]
  wire  _T_853 = _T_852 ^ dccm_wdata_lo_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_854 = _T_853 ^ dccm_wdata_lo_any[22]; // @[el2_lib.scala 259:74]
  wire  _T_855 = _T_854 ^ dccm_wdata_lo_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_856 = _T_855 ^ dccm_wdata_lo_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_857 = _T_856 ^ dccm_wdata_lo_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_858 = _T_857 ^ dccm_wdata_lo_any[29]; // @[el2_lib.scala 259:74]
  wire  _T_859 = _T_858 ^ dccm_wdata_lo_any[30]; // @[el2_lib.scala 259:74]
  wire  _T_860 = _T_859 ^ dccm_wdata_lo_any[31]; // @[el2_lib.scala 259:74]
  wire  _T_876 = dccm_wdata_lo_any[4] ^ dccm_wdata_lo_any[5]; // @[el2_lib.scala 259:74]
  wire  _T_877 = _T_876 ^ dccm_wdata_lo_any[6]; // @[el2_lib.scala 259:74]
  wire  _T_878 = _T_877 ^ dccm_wdata_lo_any[7]; // @[el2_lib.scala 259:74]
  wire  _T_879 = _T_878 ^ dccm_wdata_lo_any[8]; // @[el2_lib.scala 259:74]
  wire  _T_880 = _T_879 ^ dccm_wdata_lo_any[9]; // @[el2_lib.scala 259:74]
  wire  _T_881 = _T_880 ^ dccm_wdata_lo_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_882 = _T_881 ^ dccm_wdata_lo_any[18]; // @[el2_lib.scala 259:74]
  wire  _T_883 = _T_882 ^ dccm_wdata_lo_any[19]; // @[el2_lib.scala 259:74]
  wire  _T_884 = _T_883 ^ dccm_wdata_lo_any[20]; // @[el2_lib.scala 259:74]
  wire  _T_885 = _T_884 ^ dccm_wdata_lo_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_886 = _T_885 ^ dccm_wdata_lo_any[22]; // @[el2_lib.scala 259:74]
  wire  _T_887 = _T_886 ^ dccm_wdata_lo_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_888 = _T_887 ^ dccm_wdata_lo_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_889 = _T_888 ^ dccm_wdata_lo_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_905 = dccm_wdata_lo_any[11] ^ dccm_wdata_lo_any[12]; // @[el2_lib.scala 259:74]
  wire  _T_906 = _T_905 ^ dccm_wdata_lo_any[13]; // @[el2_lib.scala 259:74]
  wire  _T_907 = _T_906 ^ dccm_wdata_lo_any[14]; // @[el2_lib.scala 259:74]
  wire  _T_908 = _T_907 ^ dccm_wdata_lo_any[15]; // @[el2_lib.scala 259:74]
  wire  _T_909 = _T_908 ^ dccm_wdata_lo_any[16]; // @[el2_lib.scala 259:74]
  wire  _T_910 = _T_909 ^ dccm_wdata_lo_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_911 = _T_910 ^ dccm_wdata_lo_any[18]; // @[el2_lib.scala 259:74]
  wire  _T_912 = _T_911 ^ dccm_wdata_lo_any[19]; // @[el2_lib.scala 259:74]
  wire  _T_913 = _T_912 ^ dccm_wdata_lo_any[20]; // @[el2_lib.scala 259:74]
  wire  _T_914 = _T_913 ^ dccm_wdata_lo_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_915 = _T_914 ^ dccm_wdata_lo_any[22]; // @[el2_lib.scala 259:74]
  wire  _T_916 = _T_915 ^ dccm_wdata_lo_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_917 = _T_916 ^ dccm_wdata_lo_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_918 = _T_917 ^ dccm_wdata_lo_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_925 = dccm_wdata_lo_any[26] ^ dccm_wdata_lo_any[27]; // @[el2_lib.scala 259:74]
  wire  _T_926 = _T_925 ^ dccm_wdata_lo_any[28]; // @[el2_lib.scala 259:74]
  wire  _T_927 = _T_926 ^ dccm_wdata_lo_any[29]; // @[el2_lib.scala 259:74]
  wire  _T_928 = _T_927 ^ dccm_wdata_lo_any[30]; // @[el2_lib.scala 259:74]
  wire  _T_929 = _T_928 ^ dccm_wdata_lo_any[31]; // @[el2_lib.scala 259:74]
  wire [5:0] _T_934 = {_T_929,_T_918,_T_889,_T_860,_T_825,_T_790}; // @[Cat.scala 29:58]
  wire  _T_935 = ^dccm_wdata_lo_any; // @[el2_lib.scala 267:13]
  wire  _T_936 = ^_T_934; // @[el2_lib.scala 267:23]
  wire  _T_937 = _T_935 ^ _T_936; // @[el2_lib.scala 267:18]
  wire [31:0] _T_1162 = io_dma_dccm_wen ? io_dma_dccm_wdata_hi : io_stbuf_data_any; // @[el2_lsu_ecc.scala 150:87]
  wire [31:0] dccm_wdata_hi_any = io_ld_single_ecc_error_r_ff ? io_sec_data_hi_r_ff : _T_1162; // @[el2_lsu_ecc.scala 150:27]
  wire  _T_956 = dccm_wdata_hi_any[0] ^ dccm_wdata_hi_any[1]; // @[el2_lib.scala 259:74]
  wire  _T_957 = _T_956 ^ dccm_wdata_hi_any[3]; // @[el2_lib.scala 259:74]
  wire  _T_958 = _T_957 ^ dccm_wdata_hi_any[4]; // @[el2_lib.scala 259:74]
  wire  _T_959 = _T_958 ^ dccm_wdata_hi_any[6]; // @[el2_lib.scala 259:74]
  wire  _T_960 = _T_959 ^ dccm_wdata_hi_any[8]; // @[el2_lib.scala 259:74]
  wire  _T_961 = _T_960 ^ dccm_wdata_hi_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_962 = _T_961 ^ dccm_wdata_hi_any[11]; // @[el2_lib.scala 259:74]
  wire  _T_963 = _T_962 ^ dccm_wdata_hi_any[13]; // @[el2_lib.scala 259:74]
  wire  _T_964 = _T_963 ^ dccm_wdata_hi_any[15]; // @[el2_lib.scala 259:74]
  wire  _T_965 = _T_964 ^ dccm_wdata_hi_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_966 = _T_965 ^ dccm_wdata_hi_any[19]; // @[el2_lib.scala 259:74]
  wire  _T_967 = _T_966 ^ dccm_wdata_hi_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_968 = _T_967 ^ dccm_wdata_hi_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_969 = _T_968 ^ dccm_wdata_hi_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_970 = _T_969 ^ dccm_wdata_hi_any[26]; // @[el2_lib.scala 259:74]
  wire  _T_971 = _T_970 ^ dccm_wdata_hi_any[28]; // @[el2_lib.scala 259:74]
  wire  _T_972 = _T_971 ^ dccm_wdata_hi_any[30]; // @[el2_lib.scala 259:74]
  wire  _T_991 = dccm_wdata_hi_any[0] ^ dccm_wdata_hi_any[2]; // @[el2_lib.scala 259:74]
  wire  _T_992 = _T_991 ^ dccm_wdata_hi_any[3]; // @[el2_lib.scala 259:74]
  wire  _T_993 = _T_992 ^ dccm_wdata_hi_any[5]; // @[el2_lib.scala 259:74]
  wire  _T_994 = _T_993 ^ dccm_wdata_hi_any[6]; // @[el2_lib.scala 259:74]
  wire  _T_995 = _T_994 ^ dccm_wdata_hi_any[9]; // @[el2_lib.scala 259:74]
  wire  _T_996 = _T_995 ^ dccm_wdata_hi_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_997 = _T_996 ^ dccm_wdata_hi_any[12]; // @[el2_lib.scala 259:74]
  wire  _T_998 = _T_997 ^ dccm_wdata_hi_any[13]; // @[el2_lib.scala 259:74]
  wire  _T_999 = _T_998 ^ dccm_wdata_hi_any[16]; // @[el2_lib.scala 259:74]
  wire  _T_1000 = _T_999 ^ dccm_wdata_hi_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_1001 = _T_1000 ^ dccm_wdata_hi_any[20]; // @[el2_lib.scala 259:74]
  wire  _T_1002 = _T_1001 ^ dccm_wdata_hi_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_1003 = _T_1002 ^ dccm_wdata_hi_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_1004 = _T_1003 ^ dccm_wdata_hi_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_1005 = _T_1004 ^ dccm_wdata_hi_any[27]; // @[el2_lib.scala 259:74]
  wire  _T_1006 = _T_1005 ^ dccm_wdata_hi_any[28]; // @[el2_lib.scala 259:74]
  wire  _T_1007 = _T_1006 ^ dccm_wdata_hi_any[31]; // @[el2_lib.scala 259:74]
  wire  _T_1026 = dccm_wdata_hi_any[1] ^ dccm_wdata_hi_any[2]; // @[el2_lib.scala 259:74]
  wire  _T_1027 = _T_1026 ^ dccm_wdata_hi_any[3]; // @[el2_lib.scala 259:74]
  wire  _T_1028 = _T_1027 ^ dccm_wdata_hi_any[7]; // @[el2_lib.scala 259:74]
  wire  _T_1029 = _T_1028 ^ dccm_wdata_hi_any[8]; // @[el2_lib.scala 259:74]
  wire  _T_1030 = _T_1029 ^ dccm_wdata_hi_any[9]; // @[el2_lib.scala 259:74]
  wire  _T_1031 = _T_1030 ^ dccm_wdata_hi_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_1032 = _T_1031 ^ dccm_wdata_hi_any[14]; // @[el2_lib.scala 259:74]
  wire  _T_1033 = _T_1032 ^ dccm_wdata_hi_any[15]; // @[el2_lib.scala 259:74]
  wire  _T_1034 = _T_1033 ^ dccm_wdata_hi_any[16]; // @[el2_lib.scala 259:74]
  wire  _T_1035 = _T_1034 ^ dccm_wdata_hi_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_1036 = _T_1035 ^ dccm_wdata_hi_any[22]; // @[el2_lib.scala 259:74]
  wire  _T_1037 = _T_1036 ^ dccm_wdata_hi_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_1038 = _T_1037 ^ dccm_wdata_hi_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_1039 = _T_1038 ^ dccm_wdata_hi_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_1040 = _T_1039 ^ dccm_wdata_hi_any[29]; // @[el2_lib.scala 259:74]
  wire  _T_1041 = _T_1040 ^ dccm_wdata_hi_any[30]; // @[el2_lib.scala 259:74]
  wire  _T_1042 = _T_1041 ^ dccm_wdata_hi_any[31]; // @[el2_lib.scala 259:74]
  wire  _T_1058 = dccm_wdata_hi_any[4] ^ dccm_wdata_hi_any[5]; // @[el2_lib.scala 259:74]
  wire  _T_1059 = _T_1058 ^ dccm_wdata_hi_any[6]; // @[el2_lib.scala 259:74]
  wire  _T_1060 = _T_1059 ^ dccm_wdata_hi_any[7]; // @[el2_lib.scala 259:74]
  wire  _T_1061 = _T_1060 ^ dccm_wdata_hi_any[8]; // @[el2_lib.scala 259:74]
  wire  _T_1062 = _T_1061 ^ dccm_wdata_hi_any[9]; // @[el2_lib.scala 259:74]
  wire  _T_1063 = _T_1062 ^ dccm_wdata_hi_any[10]; // @[el2_lib.scala 259:74]
  wire  _T_1064 = _T_1063 ^ dccm_wdata_hi_any[18]; // @[el2_lib.scala 259:74]
  wire  _T_1065 = _T_1064 ^ dccm_wdata_hi_any[19]; // @[el2_lib.scala 259:74]
  wire  _T_1066 = _T_1065 ^ dccm_wdata_hi_any[20]; // @[el2_lib.scala 259:74]
  wire  _T_1067 = _T_1066 ^ dccm_wdata_hi_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_1068 = _T_1067 ^ dccm_wdata_hi_any[22]; // @[el2_lib.scala 259:74]
  wire  _T_1069 = _T_1068 ^ dccm_wdata_hi_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_1070 = _T_1069 ^ dccm_wdata_hi_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_1071 = _T_1070 ^ dccm_wdata_hi_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_1087 = dccm_wdata_hi_any[11] ^ dccm_wdata_hi_any[12]; // @[el2_lib.scala 259:74]
  wire  _T_1088 = _T_1087 ^ dccm_wdata_hi_any[13]; // @[el2_lib.scala 259:74]
  wire  _T_1089 = _T_1088 ^ dccm_wdata_hi_any[14]; // @[el2_lib.scala 259:74]
  wire  _T_1090 = _T_1089 ^ dccm_wdata_hi_any[15]; // @[el2_lib.scala 259:74]
  wire  _T_1091 = _T_1090 ^ dccm_wdata_hi_any[16]; // @[el2_lib.scala 259:74]
  wire  _T_1092 = _T_1091 ^ dccm_wdata_hi_any[17]; // @[el2_lib.scala 259:74]
  wire  _T_1093 = _T_1092 ^ dccm_wdata_hi_any[18]; // @[el2_lib.scala 259:74]
  wire  _T_1094 = _T_1093 ^ dccm_wdata_hi_any[19]; // @[el2_lib.scala 259:74]
  wire  _T_1095 = _T_1094 ^ dccm_wdata_hi_any[20]; // @[el2_lib.scala 259:74]
  wire  _T_1096 = _T_1095 ^ dccm_wdata_hi_any[21]; // @[el2_lib.scala 259:74]
  wire  _T_1097 = _T_1096 ^ dccm_wdata_hi_any[22]; // @[el2_lib.scala 259:74]
  wire  _T_1098 = _T_1097 ^ dccm_wdata_hi_any[23]; // @[el2_lib.scala 259:74]
  wire  _T_1099 = _T_1098 ^ dccm_wdata_hi_any[24]; // @[el2_lib.scala 259:74]
  wire  _T_1100 = _T_1099 ^ dccm_wdata_hi_any[25]; // @[el2_lib.scala 259:74]
  wire  _T_1107 = dccm_wdata_hi_any[26] ^ dccm_wdata_hi_any[27]; // @[el2_lib.scala 259:74]
  wire  _T_1108 = _T_1107 ^ dccm_wdata_hi_any[28]; // @[el2_lib.scala 259:74]
  wire  _T_1109 = _T_1108 ^ dccm_wdata_hi_any[29]; // @[el2_lib.scala 259:74]
  wire  _T_1110 = _T_1109 ^ dccm_wdata_hi_any[30]; // @[el2_lib.scala 259:74]
  wire  _T_1111 = _T_1110 ^ dccm_wdata_hi_any[31]; // @[el2_lib.scala 259:74]
  wire [5:0] _T_1116 = {_T_1111,_T_1100,_T_1071,_T_1042,_T_1007,_T_972}; // @[Cat.scala 29:58]
  wire  _T_1117 = ^dccm_wdata_hi_any; // @[el2_lib.scala 267:13]
  wire  _T_1118 = ^_T_1116; // @[el2_lib.scala 267:23]
  wire  _T_1119 = _T_1117 ^ _T_1118; // @[el2_lib.scala 267:18]
  reg  _T_1150; // @[el2_lsu_ecc.scala 141:72]
  reg  _T_1151; // @[el2_lsu_ecc.scala 142:72]
  reg  _T_1152; // @[el2_lsu_ecc.scala 143:72]
  reg  _T_1153; // @[el2_lsu_ecc.scala 144:72]
  reg [31:0] _T_1154; // @[el2_lsu_ecc.scala 145:72]
  reg [31:0] _T_1155; // @[el2_lsu_ecc.scala 146:72]
  reg [31:0] _T_1164; // @[el2_lib.scala 514:16]
  reg [31:0] _T_1165; // @[el2_lib.scala 514:16]
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
  assign io_sec_data_hi_r = _T_1154; // @[el2_lsu_ecc.scala 114:22 el2_lsu_ecc.scala 145:62]
  assign io_sec_data_lo_r = _T_1155; // @[el2_lsu_ecc.scala 117:25 el2_lsu_ecc.scala 146:62]
  assign io_sec_data_hi_m = {_T_364,_T_362}; // @[el2_lsu_ecc.scala 90:32 el2_lsu_ecc.scala 134:27]
  assign io_sec_data_lo_m = {_T_742,_T_740}; // @[el2_lsu_ecc.scala 91:32 el2_lsu_ecc.scala 136:27]
  assign io_sec_data_hi_r_ff = _T_1164; // @[el2_lsu_ecc.scala 157:23]
  assign io_sec_data_lo_r_ff = _T_1165; // @[el2_lsu_ecc.scala 158:23]
  assign io_dma_dccm_wdata_ecc_hi = {_T_1119,_T_1116}; // @[el2_lsu_ecc.scala 154:28]
  assign io_dma_dccm_wdata_ecc_lo = {_T_937,_T_934}; // @[el2_lsu_ecc.scala 155:28]
  assign io_stbuf_ecc_any = {_T_937,_T_934}; // @[el2_lsu_ecc.scala 153:28]
  assign io_sec_data_ecc_hi_r_ff = {_T_1119,_T_1116}; // @[el2_lsu_ecc.scala 151:28]
  assign io_sec_data_ecc_lo_r_ff = {_T_937,_T_934}; // @[el2_lsu_ecc.scala 152:28]
  assign io_single_ecc_error_hi_r = _T_1153; // @[el2_lsu_ecc.scala 115:31 el2_lsu_ecc.scala 144:62]
  assign io_single_ecc_error_lo_r = _T_1152; // @[el2_lsu_ecc.scala 118:31 el2_lsu_ecc.scala 143:62]
  assign io_lsu_single_ecc_error_r = _T_1150; // @[el2_lsu_ecc.scala 120:31 el2_lsu_ecc.scala 141:62]
  assign io_lsu_double_ecc_error_r = _T_1151; // @[el2_lsu_ecc.scala 121:31 el2_lsu_ecc.scala 142:62]
  assign io_lsu_single_ecc_error_m = single_ecc_error_hi_any | single_ecc_error_lo_any; // @[el2_lsu_ecc.scala 92:30 el2_lsu_ecc.scala 138:33]
  assign io_lsu_double_ecc_error_m = double_ecc_error_hi_any | double_ecc_error_lo_any; // @[el2_lsu_ecc.scala 93:30 el2_lsu_ecc.scala 139:33]
  assign rvclkhdr_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_io_en = io_ld_single_ecc_error_r; // @[el2_lib.scala 511:17]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
  assign rvclkhdr_1_io_clk = clock; // @[el2_lib.scala 510:18]
  assign rvclkhdr_1_io_en = io_ld_single_ecc_error_r; // @[el2_lib.scala 511:17]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[el2_lib.scala 512:24]
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
  _T_1150 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  _T_1151 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_1152 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  _T_1153 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  _T_1154 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  _T_1155 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  _T_1164 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  _T_1165 = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    _T_1150 = 1'h0;
  end
  if (reset) begin
    _T_1151 = 1'h0;
  end
  if (reset) begin
    _T_1152 = 1'h0;
  end
  if (reset) begin
    _T_1153 = 1'h0;
  end
  if (reset) begin
    _T_1154 = 32'h0;
  end
  if (reset) begin
    _T_1155 = 32'h0;
  end
  if (reset) begin
    _T_1164 = 32'h0;
  end
  if (reset) begin
    _T_1165 = 32'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_1150 <= 1'h0;
    end else begin
      _T_1150 <= io_lsu_single_ecc_error_m;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_1151 <= 1'h0;
    end else begin
      _T_1151 <= io_lsu_double_ecc_error_m;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_1152 <= 1'h0;
    end else begin
      _T_1152 <= _T_588 & _T_586[6];
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_1153 <= 1'h0;
    end else begin
      _T_1153 <= _T_210 & _T_208[6];
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_1154 <= 32'h0;
    end else begin
      _T_1154 <= io_sec_data_hi_m;
    end
  end
  always @(posedge io_lsu_c2_r_clk or posedge reset) begin
    if (reset) begin
      _T_1155 <= 32'h0;
    end else begin
      _T_1155 <= io_sec_data_lo_m;
    end
  end
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1164 <= 32'h0;
    end else begin
      _T_1164 <= io_sec_data_hi_r;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1165 <= 32'h0;
    end else begin
      _T_1165 <= io_sec_data_lo_r;
    end
  end
endmodule
