module rvclkhdr(
  output  io_l1clk,
  input   io_clk,
  input   io_en,
  input   io_scan_mode
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
  assign io_l1clk = clkhdr_Q; // @[lib.scala 337:14]
  assign clkhdr_CK = io_clk; // @[lib.scala 338:18]
  assign clkhdr_EN = io_en; // @[lib.scala 339:18]
  assign clkhdr_SE = io_scan_mode; // @[lib.scala 340:18]
endmodule
module dec_dec_ctl(
  input  [31:0] io_ins,
  output        io_out_clz,
  output        io_out_ctz,
  output        io_out_pcnt,
  output        io_out_sext_b,
  output        io_out_sext_h,
  output        io_out_slo,
  output        io_out_sro,
  output        io_out_min,
  output        io_out_max,
  output        io_out_pack,
  output        io_out_packu,
  output        io_out_packh,
  output        io_out_rol,
  output        io_out_ror,
  output        io_out_grev,
  output        io_out_gorc,
  output        io_out_zbb,
  output        io_out_sbset,
  output        io_out_sbclr,
  output        io_out_sbinv,
  output        io_out_sbext,
  output        io_out_zbs,
  output        io_out_bext,
  output        io_out_bdep,
  output        io_out_zbe,
  output        io_out_clmul,
  output        io_out_clmulh,
  output        io_out_clmulr,
  output        io_out_zbc,
  output        io_out_shfl,
  output        io_out_unshfl,
  output        io_out_zbp,
  output        io_out_crc32_b,
  output        io_out_crc32_h,
  output        io_out_crc32_w,
  output        io_out_crc32c_b,
  output        io_out_crc32c_h,
  output        io_out_crc32c_w,
  output        io_out_zbr,
  output        io_out_bfp,
  output        io_out_zbf,
  output        io_out_sh1add,
  output        io_out_sh2add,
  output        io_out_sh3add,
  output        io_out_zba,
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
  wire  _T_4 = ~io_ins[22]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_6 = ~io_ins[21]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_8 = ~io_ins[20]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_11 = ~io_ins[5]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_13 = io_ins[30] & io_ins[24]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_14 = _T_13 & io_ins[23]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_15 = _T_14 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_16 = _T_15 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_17 = _T_16 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_18 = _T_17 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_19 = _T_18 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_20 = _T_19 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_23 = ~io_ins[27]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_25 = ~io_ins[24]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_27 = io_ins[29] & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_28 = _T_27 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_29 = _T_28 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_30 = _T_20 | _T_29; // @[dec_dec_ctl.scala 20:62]
  wire  _T_32 = ~io_ins[25]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_34 = ~io_ins[13]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_36 = ~io_ins[12]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_38 = _T_32 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_39 = _T_38 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_40 = _T_39 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_41 = _T_30 | _T_40; // @[dec_dec_ctl.scala 20:92]
  wire  _T_43 = ~io_ins[30]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_48 = _T_43 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_49 = _T_48 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_50 = _T_49 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_51 = _T_41 | _T_50; // @[dec_dec_ctl.scala 21:34]
  wire  _T_56 = io_ins[27] & io_ins[25]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_57 = _T_56 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_58 = _T_57 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_59 = _T_51 | _T_58; // @[dec_dec_ctl.scala 21:66]
  wire  _T_63 = ~io_ins[14]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_65 = io_ins[29] & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_66 = _T_65 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_67 = _T_66 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_68 = _T_59 | _T_67; // @[dec_dec_ctl.scala 21:94]
  wire  _T_74 = io_ins[29] & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_75 = _T_74 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_76 = _T_75 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_77 = _T_68 | _T_76; // @[dec_dec_ctl.scala 22:32]
  wire  _T_84 = _T_23 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_85 = _T_84 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_86 = _T_85 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_87 = _T_77 | _T_86; // @[dec_dec_ctl.scala 22:60]
  wire  _T_90 = ~io_ins[29]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_94 = io_ins[30] & _T_90; // @[dec_dec_ctl.scala 17:17]
  wire  _T_95 = _T_94 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_96 = _T_95 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_97 = _T_87 | _T_96; // @[dec_dec_ctl.scala 22:90]
  wire  _T_105 = _T_43 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_106 = _T_105 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_107 = _T_106 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_108 = _T_97 | _T_107; // @[dec_dec_ctl.scala 23:33]
  wire  _T_113 = io_ins[13] & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_114 = _T_113 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_115 = _T_108 | _T_114; // @[dec_dec_ctl.scala 23:64]
  wire  _T_121 = _T_36 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_122 = _T_121 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_123 = _T_115 | _T_122; // @[dec_dec_ctl.scala 23:89]
  wire  _T_125 = _T_123 | io_ins[2]; // @[dec_dec_ctl.scala 24:29]
  wire  _T_127 = _T_125 | io_ins[6]; // @[dec_dec_ctl.scala 24:48]
  wire  _T_139 = _T_14 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_140 = _T_139 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_141 = _T_140 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_142 = _T_141 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_143 = _T_142 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_144 = _T_127 | _T_143; // @[dec_dec_ctl.scala 24:67]
  wire  _T_151 = ~io_ins[23]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_158 = _T_43 & io_ins[29]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_159 = _T_158 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_160 = _T_159 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_161 = _T_160 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_162 = _T_161 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_163 = _T_162 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_164 = _T_163 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_165 = _T_164 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_166 = _T_144 | _T_165; // @[dec_dec_ctl.scala 24:107]
  wire  _T_181 = _T_43 & io_ins[24]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_182 = _T_181 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_183 = _T_182 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_184 = _T_183 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_185 = _T_184 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_186 = _T_185 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_187 = _T_186 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_194 = ~io_ins[2]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_195 = _T_63 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_196 = _T_195 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_202 = _T_34 & io_ins[11]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_203 = _T_202 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_204 = _T_196 | _T_203; // @[dec_dec_ctl.scala 27:43]
  wire  _T_209 = io_ins[19] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_210 = _T_209 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_211 = _T_204 | _T_210; // @[dec_dec_ctl.scala 27:70]
  wire  _T_217 = _T_34 & io_ins[10]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_218 = _T_217 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_219 = _T_211 | _T_218; // @[dec_dec_ctl.scala 27:96]
  wire  _T_224 = io_ins[18] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_225 = _T_224 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_226 = _T_219 | _T_225; // @[dec_dec_ctl.scala 28:30]
  wire  _T_232 = _T_34 & io_ins[9]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_233 = _T_232 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_234 = _T_226 | _T_233; // @[dec_dec_ctl.scala 28:57]
  wire  _T_239 = io_ins[17] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_240 = _T_239 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_241 = _T_234 | _T_240; // @[dec_dec_ctl.scala 28:83]
  wire  _T_247 = _T_34 & io_ins[8]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_248 = _T_247 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_249 = _T_241 | _T_248; // @[dec_dec_ctl.scala 28:109]
  wire  _T_254 = io_ins[16] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_255 = _T_254 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_256 = _T_249 | _T_255; // @[dec_dec_ctl.scala 29:29]
  wire  _T_262 = _T_34 & io_ins[7]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_263 = _T_262 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_264 = _T_256 | _T_263; // @[dec_dec_ctl.scala 29:55]
  wire  _T_269 = io_ins[15] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_270 = _T_269 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_271 = _T_264 | _T_270; // @[dec_dec_ctl.scala 29:81]
  wire  _T_273 = ~io_ins[4]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_275 = ~io_ins[3]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_276 = _T_273 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_277 = _T_271 | _T_276; // @[dec_dec_ctl.scala 30:29]
  wire  _T_279 = ~io_ins[6]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_282 = _T_279 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_289 = io_ins[5] & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_290 = _T_289 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_296 = _T_279 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_297 = _T_296 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_305 = _T_276 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_314 = _T_114 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_315 = _T_305 | _T_314; // @[dec_dec_ctl.scala 34:42]
  wire  _T_322 = _T_34 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_323 = _T_322 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_324 = _T_323 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_325 = _T_315 | _T_324; // @[dec_dec_ctl.scala 34:70]
  wire  _T_335 = _T_122 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_341 = _T_11 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_344 = io_ins[5] & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_345 = _T_341 | _T_344; // @[dec_dec_ctl.scala 36:37]
  wire  _T_357 = io_ins[27] & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_358 = _T_357 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_359 = _T_358 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_360 = _T_359 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_361 = _T_360 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_372 = _T_43 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_373 = _T_372 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_374 = _T_373 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_375 = _T_374 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_376 = _T_375 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_377 = _T_361 | _T_376; // @[dec_dec_ctl.scala 38:53]
  wire  _T_387 = io_ins[14] & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_388 = _T_387 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_389 = _T_388 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_390 = _T_389 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_391 = _T_390 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_395 = io_ins[5] & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_398 = io_ins[4] & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_405 = _T_11 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_406 = _T_405 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_417 = _T_11 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_432 = _T_279 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_444 = _T_195 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_445 = _T_444 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_446 = _T_445 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_454 = _T_446 | _T_406; // @[dec_dec_ctl.scala 50:49]
  wire  _T_471 = _T_48 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_472 = _T_471 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_473 = _T_472 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_474 = _T_473 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_475 = _T_474 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_476 = _T_475 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_489 = io_ins[30] & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_490 = _T_489 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_491 = _T_490 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_492 = _T_491 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_493 = _T_492 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_494 = _T_493 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_507 = _T_90 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_508 = _T_507 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_509 = _T_508 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_510 = _T_509 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_511 = _T_510 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_512 = _T_511 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_513 = _T_494 | _T_512; // @[dec_dec_ctl.scala 52:53]
  wire  _T_524 = _T_57 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_525 = _T_524 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_526 = _T_525 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_527 = _T_513 | _T_526; // @[dec_dec_ctl.scala 52:93]
  wire  _T_536 = _T_63 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_537 = _T_536 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_538 = _T_537 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_539 = _T_538 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_540 = _T_527 | _T_539; // @[dec_dec_ctl.scala 53:37]
  wire  _T_546 = io_ins[6] & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_547 = _T_546 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_562 = _T_85 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_563 = _T_562 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_564 = _T_563 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_565 = _T_564 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_573 = io_ins[14] & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_574 = _T_573 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_575 = _T_574 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_576 = _T_575 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_581 = _T_279 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_596 = _T_90 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_597 = _T_596 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_598 = _T_597 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_599 = _T_598 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_600 = _T_599 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_601 = _T_600 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_602 = _T_601 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_603 = _T_581 | _T_602; // @[dec_dec_ctl.scala 57:37]
  wire  _T_607 = io_ins[5] & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_608 = _T_607 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_609 = _T_603 | _T_608; // @[dec_dec_ctl.scala 57:82]
  wire  _T_619 = _T_609 | _T_324; // @[dec_dec_ctl.scala 57:105]
  wire  _T_629 = _T_573 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_630 = _T_629 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_631 = _T_630 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_650 = _T_598 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_651 = _T_650 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_652 = _T_651 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_653 = _T_652 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_665 = _T_387 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_666 = _T_665 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_667 = _T_666 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_668 = _T_667 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_688 = _T_597 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_689 = _T_688 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_690 = _T_689 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_691 = _T_690 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_692 = _T_691 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_708 = _T_94 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_709 = _T_708 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_710 = _T_709 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_711 = _T_710 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_712 = _T_711 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_731 = _T_43 & _T_90; // @[dec_dec_ctl.scala 17:17]
  wire  _T_732 = _T_731 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_733 = _T_732 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_734 = _T_733 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_735 = _T_734 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_736 = _T_735 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_737 = _T_736 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_738 = _T_737 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_781 = _T_23 & io_ins[25]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_782 = _T_781 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_783 = _T_782 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_784 = _T_783 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_785 = _T_784 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_786 = _T_785 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_796 = _T_536 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_797 = _T_796 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_798 = _T_797 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_799 = _T_786 | _T_798; // @[dec_dec_ctl.scala 70:56]
  wire  _T_806 = io_ins[13] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_807 = _T_806 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_808 = _T_807 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_809 = _T_799 | _T_808; // @[dec_dec_ctl.scala 70:89]
  wire  _T_815 = io_ins[14] & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_816 = _T_815 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_817 = _T_809 | _T_816; // @[dec_dec_ctl.scala 71:31]
  wire  _T_828 = _T_32 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_829 = _T_828 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_830 = _T_829 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_831 = _T_830 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_832 = _T_831 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_833 = _T_817 | _T_832; // @[dec_dec_ctl.scala 71:57]
  wire  _T_845 = _T_57 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_846 = _T_845 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_847 = _T_846 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_848 = _T_847 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_866 = _T_63 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_867 = _T_866 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_868 = _T_867 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_878 = _T_63 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_879 = _T_878 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_880 = _T_879 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_889 = io_ins[14] & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_890 = _T_889 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_891 = _T_890 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_901 = io_ins[14] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_902 = _T_901 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_903 = _T_902 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_919 = _T_322 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_920 = _T_919 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_929 = io_ins[12] & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_930 = _T_929 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_937 = io_ins[13] & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_943 = _T_806 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_947 = io_ins[7] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_948 = _T_947 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_949 = _T_943 | _T_948; // @[dec_dec_ctl.scala 92:44]
  wire  _T_953 = io_ins[8] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_954 = _T_953 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_955 = _T_949 | _T_954; // @[dec_dec_ctl.scala 92:67]
  wire  _T_959 = io_ins[9] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_960 = _T_959 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_961 = _T_955 | _T_960; // @[dec_dec_ctl.scala 92:90]
  wire  _T_965 = io_ins[10] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_966 = _T_965 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_967 = _T_961 | _T_966; // @[dec_dec_ctl.scala 93:26]
  wire  _T_971 = io_ins[11] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_972 = _T_971 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_980 = _T_269 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_981 = _T_980 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_982 = _T_981 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_989 = _T_254 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_990 = _T_989 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_991 = _T_990 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_992 = _T_982 | _T_991; // @[dec_dec_ctl.scala 95:49]
  wire  _T_999 = _T_239 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1000 = _T_999 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1001 = _T_1000 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1002 = _T_992 | _T_1001; // @[dec_dec_ctl.scala 95:79]
  wire  _T_1009 = _T_224 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1010 = _T_1009 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1011 = _T_1010 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1012 = _T_1002 | _T_1011; // @[dec_dec_ctl.scala 96:33]
  wire  _T_1019 = _T_209 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1020 = _T_1019 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1021 = _T_1020 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1028 = io_ins[15] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1029 = _T_1028 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1030 = _T_1029 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1036 = io_ins[16] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1037 = _T_1036 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1038 = _T_1037 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1039 = _T_1030 | _T_1038; // @[dec_dec_ctl.scala 98:47]
  wire  _T_1045 = io_ins[17] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1046 = _T_1045 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1047 = _T_1046 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1048 = _T_1039 | _T_1047; // @[dec_dec_ctl.scala 98:75]
  wire  _T_1054 = io_ins[18] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1055 = _T_1054 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1056 = _T_1055 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1057 = _T_1048 | _T_1056; // @[dec_dec_ctl.scala 98:103]
  wire  _T_1063 = io_ins[19] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1064 = _T_1063 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1065 = _T_1064 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1072 = _T_34 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1073 = _T_1072 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1081 = _T_387 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1082 = _T_1081 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1087 = io_ins[15] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1088 = _T_1087 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1089 = _T_1088 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1090 = _T_1082 | _T_1089; // @[dec_dec_ctl.scala 103:47]
  wire  _T_1095 = io_ins[16] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1096 = _T_1095 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1097 = _T_1096 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1098 = _T_1090 | _T_1097; // @[dec_dec_ctl.scala 103:74]
  wire  _T_1103 = io_ins[17] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1104 = _T_1103 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1105 = _T_1104 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1106 = _T_1098 | _T_1105; // @[dec_dec_ctl.scala 103:101]
  wire  _T_1111 = io_ins[18] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1112 = _T_1111 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1113 = _T_1112 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1114 = _T_1106 | _T_1113; // @[dec_dec_ctl.scala 104:30]
  wire  _T_1119 = io_ins[19] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1120 = _T_1119 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1121 = _T_1120 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1126 = _T_11 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1133 = _T_262 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1134 = _T_1133 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1135 = _T_1126 | _T_1134; // @[dec_dec_ctl.scala 106:41]
  wire  _T_1142 = _T_247 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1143 = _T_1142 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1144 = _T_1135 | _T_1143; // @[dec_dec_ctl.scala 106:68]
  wire  _T_1151 = _T_232 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1152 = _T_1151 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1153 = _T_1144 | _T_1152; // @[dec_dec_ctl.scala 106:95]
  wire  _T_1160 = _T_217 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1161 = _T_1160 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1162 = _T_1153 | _T_1161; // @[dec_dec_ctl.scala 107:30]
  wire  _T_1169 = _T_202 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1170 = _T_1169 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1171 = _T_1162 | _T_1170; // @[dec_dec_ctl.scala 107:58]
  wire  _T_1177 = _T_269 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1178 = _T_1177 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1179 = _T_1171 | _T_1178; // @[dec_dec_ctl.scala 107:86]
  wire  _T_1185 = _T_254 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1186 = _T_1185 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1187 = _T_1179 | _T_1186; // @[dec_dec_ctl.scala 108:30]
  wire  _T_1193 = _T_239 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1194 = _T_1193 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1195 = _T_1187 | _T_1194; // @[dec_dec_ctl.scala 108:57]
  wire  _T_1201 = _T_224 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1202 = _T_1201 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1203 = _T_1195 | _T_1202; // @[dec_dec_ctl.scala 108:84]
  wire  _T_1209 = _T_209 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1210 = _T_1209 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1216 = io_ins[12] & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1217 = _T_1216 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1226 = _T_4 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1227 = _T_1226 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1228 = _T_1227 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1229 = _T_1228 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1230 = _T_1217 | _T_1229; // @[dec_dec_ctl.scala 111:45]
  wire  _T_1239 = _T_1230 | _T_1134; // @[dec_dec_ctl.scala 111:78]
  wire  _T_1248 = _T_1239 | _T_1143; // @[dec_dec_ctl.scala 112:30]
  wire  _T_1257 = _T_1248 | _T_1152; // @[dec_dec_ctl.scala 112:57]
  wire  _T_1266 = _T_1257 | _T_1161; // @[dec_dec_ctl.scala 112:84]
  wire  _T_1275 = _T_1266 | _T_1170; // @[dec_dec_ctl.scala 112:112]
  wire  _T_1283 = _T_1275 | _T_1178; // @[dec_dec_ctl.scala 113:31]
  wire  _T_1291 = _T_1283 | _T_1186; // @[dec_dec_ctl.scala 113:58]
  wire  _T_1299 = _T_1291 | _T_1194; // @[dec_dec_ctl.scala 113:85]
  wire  _T_1307 = _T_1299 | _T_1202; // @[dec_dec_ctl.scala 113:112]
  wire  _T_1325 = _T_4 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1326 = _T_1325 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1327 = _T_1326 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1328 = _T_1327 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1340 = _T_6 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1341 = _T_1340 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1342 = _T_1341 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1343 = _T_1342 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1352 = io_ins[29] & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1353 = _T_1352 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1354 = _T_1353 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1370 = _T_43 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1371 = _T_1370 & io_ins[24]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1372 = _T_1371 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1373 = _T_1372 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1374 = _T_1373 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1375 = _T_1374 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1376 = _T_1375 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1377 = _T_1376 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1378 = _T_1377 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1394 = _T_65 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1395 = _T_1394 & io_ins[23]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1396 = _T_1395 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1397 = _T_1396 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1398 = _T_1397 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1399 = _T_1398 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1400 = _T_1399 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1401 = _T_1400 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1402 = _T_1378 | _T_1401; // @[dec_dec_ctl.scala 122:63]
  wire  _T_1420 = _T_1394 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1421 = _T_1420 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1422 = _T_1421 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1423 = _T_1422 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1424 = _T_1423 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1425 = _T_1424 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1426 = _T_1425 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1427 = _T_1402 | _T_1426; // @[dec_dec_ctl.scala 122:111]
  wire  _T_1440 = io_ins[27] & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1441 = _T_1440 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1442 = _T_1441 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1443 = _T_1442 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1444 = _T_1443 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1445 = _T_1444 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1446 = _T_1445 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1447 = _T_1427 | _T_1446; // @[dec_dec_ctl.scala 123:52]
  wire  _T_1457 = io_ins[30] & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1458 = _T_1457 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1459 = _T_1458 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1460 = _T_1459 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1461 = _T_1460 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1462 = _T_1461 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1463 = _T_1447 | _T_1462; // @[dec_dec_ctl.scala 123:93]
  wire  _T_1479 = _T_65 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1480 = _T_1479 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1481 = _T_1480 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1482 = _T_1481 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1483 = _T_1482 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1484 = _T_1483 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1485 = _T_1484 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1486 = _T_1485 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1487 = _T_1463 | _T_1486; // @[dec_dec_ctl.scala 124:39]
  wire  _T_1503 = _T_65 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1504 = _T_1503 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1505 = _T_1504 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1506 = _T_1505 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1507 = _T_1506 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1508 = _T_1507 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1509 = _T_1508 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1510 = _T_1509 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1511 = _T_1487 | _T_1510; // @[dec_dec_ctl.scala 124:87]
  wire  _T_1527 = _T_65 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1528 = _T_1527 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1529 = _T_1528 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1530 = _T_1529 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1531 = _T_1530 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1532 = _T_1531 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1533 = _T_1532 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1534 = _T_1533 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1535 = _T_1511 | _T_1534; // @[dec_dec_ctl.scala 125:51]
  wire  _T_1550 = io_ins[30] & io_ins[29]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1551 = _T_1550 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1552 = _T_1551 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1553 = _T_1552 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1554 = _T_1553 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1555 = _T_1554 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1556 = _T_1555 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1557 = _T_1556 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1558 = _T_1557 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1559 = _T_1535 | _T_1558; // @[dec_dec_ctl.scala 125:99]
  wire  _T_1574 = _T_1370 & io_ins[23]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1575 = _T_1574 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1576 = _T_1575 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1577 = _T_1576 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1578 = _T_1577 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1579 = _T_1578 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1580 = _T_1579 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1581 = _T_1559 | _T_1580; // @[dec_dec_ctl.scala 126:51]
  wire  _T_1598 = _T_731 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1599 = _T_1598 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1600 = _T_1599 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1601 = _T_1600 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1602 = _T_1601 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1603 = _T_1602 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1604 = _T_1603 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1605 = _T_1581 | _T_1604; // @[dec_dec_ctl.scala 126:96]
  wire  _T_1615 = io_ins[25] & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1616 = _T_1615 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1617 = _T_1616 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1618 = _T_1617 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1619 = _T_1618 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1620 = _T_1605 | _T_1619; // @[dec_dec_ctl.scala 127:50]
  wire  _T_1635 = io_ins[30] & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1636 = _T_1635 & io_ins[24]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1637 = _T_1636 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1638 = _T_1637 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1639 = _T_1638 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1640 = _T_1639 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1641 = _T_1640 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1642 = _T_1641 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1643 = _T_1620 | _T_1642; // @[dec_dec_ctl.scala 127:84]
  wire  _T_1653 = _T_65 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1654 = _T_1653 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1655 = _T_1654 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1656 = _T_1655 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1673 = _T_781 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1674 = _T_1673 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1675 = _T_1674 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1676 = _T_1675 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1677 = _T_1676 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1678 = _T_1677 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1679 = _T_1678 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1695 = _T_1673 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1696 = _T_1695 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1697 = _T_1696 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1698 = _T_1697 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1699 = _T_1698 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1733 = _T_1615 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1734 = _T_1733 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1735 = _T_1734 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1736 = _T_1735 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1749 = _T_782 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1750 = _T_1749 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1764 = _T_782 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1765 = _T_1764 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1766 = _T_1765 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1800 = _T_1635 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1801 = _T_1800 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1802 = _T_1801 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1803 = _T_1802 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1804 = _T_1803 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1805 = _T_1804 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1806 = _T_1805 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1807 = _T_1806 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1808 = _T_1807 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1831 = _T_1801 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1832 = _T_1831 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1833 = _T_1832 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1834 = _T_1833 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1835 = _T_1834 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1836 = _T_1835 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1856 = _T_1800 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1857 = _T_1856 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1858 = _T_1857 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1859 = _T_1858 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1860 = _T_1859 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1861 = _T_1860 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1880 = _T_1635 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1881 = _T_1880 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1882 = _T_1881 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1883 = _T_1882 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1884 = _T_1883 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1885 = _T_1884 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1886 = _T_1885 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1905 = _T_1880 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1906 = _T_1905 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1907 = _T_1906 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1908 = _T_1907 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1909 = _T_1908 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1910 = _T_1909 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1928 = _T_158 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1929 = _T_1928 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1930 = _T_1929 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1931 = _T_1930 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1932 = _T_1931 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1933 = _T_1932 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1951 = _T_1928 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1952 = _T_1951 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1953 = _T_1952 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1954 = _T_1953 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1955 = _T_1954 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1969 = _T_57 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1970 = _T_1969 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1971 = _T_1970 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1984 = _T_57 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1985 = _T_1984 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_1986 = _T_1985 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2002 = _T_1370 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2003 = _T_2002 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2004 = _T_2003 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2005 = _T_2004 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2006 = _T_2005 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2019 = _T_1457 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2020 = _T_2019 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2021 = _T_2020 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2022 = _T_2021 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2038 = _T_2002 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2039 = _T_2038 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2040 = _T_2039 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2041 = _T_2040 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2056 = _T_1635 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2057 = _T_2056 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2058 = _T_2057 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2059 = _T_2058 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2060 = _T_2059 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2076 = _T_1550 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2077 = _T_2076 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2078 = _T_2077 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2079 = _T_2078 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2080 = _T_2079 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2081 = _T_2080 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2100 = _T_1800 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2101 = _T_2100 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2102 = _T_2101 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2103 = _T_2102 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2104 = _T_2103 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2105 = _T_2104 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2118 = _T_1370 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2119 = _T_2118 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2120 = _T_2119 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2121 = _T_2120 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2122 = _T_2121 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2123 = _T_2122 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2124 = _T_2105 | _T_2123; // @[dec_dec_ctl.scala 172:62]
  wire  _T_2143 = _T_2079 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2144 = _T_2143 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2145 = _T_2144 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2146 = _T_2124 | _T_2145; // @[dec_dec_ctl.scala 172:103]
  wire  _T_2157 = _T_357 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2158 = _T_2157 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2159 = _T_2158 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2160 = _T_2159 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2161 = _T_2146 | _T_2160; // @[dec_dec_ctl.scala 173:48]
  wire  _T_2173 = io_ins[30] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2174 = _T_2173 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2175 = _T_2174 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2176 = _T_2175 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2177 = _T_2176 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2178 = _T_2177 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2179 = _T_2161 | _T_2178; // @[dec_dec_ctl.scala 173:83]
  wire  _T_2191 = _T_1635 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2192 = _T_2191 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2193 = _T_2192 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2194 = _T_2193 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2195 = _T_2194 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2196 = _T_2179 | _T_2195; // @[dec_dec_ctl.scala 174:42]
  wire  _T_2209 = _T_2076 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2210 = _T_2209 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2211 = _T_2210 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2212 = _T_2211 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2213 = _T_2196 | _T_2212; // @[dec_dec_ctl.scala 174:79]
  wire  _T_2231 = _T_1550 & io_ins[24]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2232 = _T_2231 & io_ins[23]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2233 = _T_2232 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2234 = _T_2233 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2235 = _T_2234 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2236 = _T_2235 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2237 = _T_2236 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2238 = _T_2237 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2239 = _T_2238 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2240 = _T_2239 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2241 = _T_2240 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2242 = _T_2213 | _T_2241; // @[dec_dec_ctl.scala 175:40]
  wire  _T_2264 = _T_158 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2265 = _T_2264 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2266 = _T_2265 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2267 = _T_2266 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2268 = _T_2267 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2269 = _T_2268 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2270 = _T_2269 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2271 = _T_2270 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2272 = _T_2271 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2273 = _T_2272 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2274 = _T_2273 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2275 = _T_2274 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2276 = _T_2242 | _T_2275; // @[dec_dec_ctl.scala 175:96]
  wire  _T_2300 = _T_1371 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2301 = _T_2300 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2302 = _T_2301 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2303 = _T_2302 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2304 = _T_2303 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2305 = _T_2304 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2306 = _T_2305 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2307 = _T_2306 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2308 = _T_2307 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2309 = _T_2308 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2310 = _T_2276 | _T_2309; // @[dec_dec_ctl.scala 176:65]
  wire  _T_2333 = _T_2232 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2334 = _T_2333 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2335 = _T_2334 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2336 = _T_2335 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2337 = _T_2336 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2338 = _T_2337 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2339 = _T_2338 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2340 = _T_2339 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2341 = _T_2340 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2342 = _T_2310 | _T_2341; // @[dec_dec_ctl.scala 177:64]
  wire  _T_2373 = _T_2264 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2374 = _T_2373 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2375 = _T_2374 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2376 = _T_2375 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2377 = _T_2376 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2393 = _T_94 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2394 = _T_2393 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2395 = _T_2394 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2396 = _T_2395 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2397 = _T_2396 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2414 = _T_1551 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2415 = _T_2414 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2416 = _T_2415 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2417 = _T_2416 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2418 = _T_2417 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2434 = _T_94 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2435 = _T_2434 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2436 = _T_2435 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2437 = _T_2436 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2438 = _T_2437 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2439 = _T_2438 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2455 = _T_66 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2456 = _T_2455 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2457 = _T_2456 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2458 = _T_2457 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2459 = _T_2458 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2474 = _T_2434 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2475 = _T_2474 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2476 = _T_2475 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2477 = _T_2476 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2478 = _T_2477 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2497 = _T_2038 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2498 = _T_2497 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2499 = _T_2498 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2500 = _T_2499 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2515 = _T_1458 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2516 = _T_2515 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2517 = _T_2516 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2518 = _T_2517 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2552 = _T_56 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2553 = _T_2552 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2554 = _T_2553 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2555 = _T_2554 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2556 = _T_2555 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2568 = io_ins[27] & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2569 = _T_2568 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2570 = _T_2569 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2571 = _T_2570 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2572 = _T_2571 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2586 = _T_2568 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2587 = _T_2586 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2588 = _T_2587 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2589 = _T_2588 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2603 = _T_2552 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2604 = _T_2603 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2605 = _T_2604 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2621 = _T_1551 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2622 = _T_2621 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2623 = _T_2622 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2624 = _T_2623 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2625 = _T_2624 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2642 = _T_2264 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2643 = _T_2642 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2644 = _T_2643 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2645 = _T_2644 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2646 = _T_2645 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2668 = _T_1599 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2669 = _T_2668 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2670 = _T_2669 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2671 = _T_2670 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2672 = _T_2671 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2693 = _T_1599 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2694 = _T_2693 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2695 = _T_2694 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2696 = _T_2695 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2697 = _T_2696 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2714 = _T_1928 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2715 = _T_2714 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2716 = _T_2715 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2717 = _T_2716 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2718 = _T_2717 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2734 = _T_1598 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2735 = _T_2734 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2736 = _T_2735 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2737 = _T_2736 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2738 = _T_2737 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2739 = _T_2718 | _T_2738; // @[dec_dec_ctl.scala 212:58]
  wire  _T_2756 = _T_2739 | _T_2195; // @[dec_dec_ctl.scala 212:101]
  wire  _T_2769 = _T_1440 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2770 = _T_2769 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2771 = _T_2770 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2772 = _T_2771 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2773 = _T_2772 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2774 = _T_2756 | _T_2773; // @[dec_dec_ctl.scala 213:40]
  wire  _T_2788 = _T_2175 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2789 = _T_2788 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2790 = _T_2789 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2791 = _T_2774 | _T_2790; // @[dec_dec_ctl.scala 213:79]
  wire  _T_2803 = _T_27 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2804 = _T_2803 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2805 = _T_2804 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2806 = _T_2805 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2807 = _T_2806 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2808 = _T_2791 | _T_2807; // @[dec_dec_ctl.scala 214:41]
  wire  _T_2826 = _T_1599 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2827 = _T_2826 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2828 = _T_2827 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2829 = _T_2828 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2830 = _T_2829 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2831 = _T_2808 | _T_2830; // @[dec_dec_ctl.scala 214:78]
  wire  _T_2842 = io_ins[29] & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2843 = _T_2842 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2844 = _T_2843 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2845 = _T_2844 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2846 = _T_2845 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2847 = _T_2846 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2871 = _T_1636 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2872 = _T_2871 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2873 = _T_2872 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2874 = _T_2873 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2875 = _T_2874 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2876 = _T_2875 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2877 = _T_2876 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2878 = _T_2877 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2900 = _T_2871 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2901 = _T_2900 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2902 = _T_2901 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2903 = _T_2902 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2904 = _T_2903 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2905 = _T_2904 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2927 = _T_2871 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2928 = _T_2927 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2929 = _T_2928 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2930 = _T_2929 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2931 = _T_2930 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2932 = _T_2931 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2953 = _T_1635 & io_ins[23]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2954 = _T_2953 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2955 = _T_2954 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2956 = _T_2955 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2957 = _T_2956 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2958 = _T_2957 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2959 = _T_2958 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2960 = _T_2959 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2979 = _T_2953 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2980 = _T_2979 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2981 = _T_2980 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2982 = _T_2981 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2983 = _T_2982 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_2984 = _T_2983 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3003 = _T_2953 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3004 = _T_3003 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3005 = _T_3004 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3006 = _T_3005 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3007 = _T_3006 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3008 = _T_3007 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3043 = _T_1458 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3044 = _T_3043 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3045 = _T_3044 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3074 = _T_74 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3075 = _T_3074 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3076 = _T_3075 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3077 = _T_3076 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3091 = _T_2843 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3092 = _T_3091 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3093 = _T_3092 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3104 = _T_2842 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3105 = _T_3104 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3106 = _T_3105 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3117 = io_ins[29] & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3118 = _T_3117 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3119 = _T_3118 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3120 = _T_3119 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3129 = io_ins[28] & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3130 = _T_3129 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3131 = _T_3130 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3132 = _T_3131 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3147 = _T_733 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3148 = _T_3147 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3149 = _T_3132 | _T_3148; // @[dec_dec_ctl.scala 243:51]
  wire  _T_3164 = _T_597 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3165 = _T_3164 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3166 = _T_3165 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3167 = _T_3166 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3168 = _T_3149 | _T_3167; // @[dec_dec_ctl.scala 243:89]
  wire  _T_3183 = _T_688 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3184 = _T_3183 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3185 = _T_3168 | _T_3184; // @[dec_dec_ctl.scala 244:44]
  wire  _T_3192 = _T_3185 | _T_114; // @[dec_dec_ctl.scala 244:82]
  wire  _T_3196 = _T_3192 | _T_398; // @[dec_dec_ctl.scala 245:28]
  wire  _T_3206 = ~io_ins[31]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3215 = ~io_ins[26]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3227 = ~io_ins[19]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3229 = ~io_ins[18]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3231 = ~io_ins[17]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3233 = ~io_ins[16]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3235 = ~io_ins[15]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3239 = ~io_ins[11]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3241 = ~io_ins[10]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3243 = ~io_ins[9]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3245 = ~io_ins[8]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3247 = ~io_ins[7]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3257 = _T_3206 & _T_43; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3258 = _T_3257 & _T_90; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3259 = _T_3258 & io_ins[28]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3260 = _T_3259 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3261 = _T_3260 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3262 = _T_3261 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3263 = _T_3262 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3264 = _T_3263 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3265 = _T_3264 & io_ins[22]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3266 = _T_3265 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3267 = _T_3266 & io_ins[20]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3268 = _T_3267 & _T_3227; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3269 = _T_3268 & _T_3229; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3270 = _T_3269 & _T_3231; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3271 = _T_3270 & _T_3233; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3272 = _T_3271 & _T_3235; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3273 = _T_3272 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3274 = _T_3273 & _T_3239; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3275 = _T_3274 & _T_3241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3276 = _T_3275 & _T_3243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3277 = _T_3276 & _T_3245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3278 = _T_3277 & _T_3247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3279 = _T_3278 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3280 = _T_3279 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3281 = _T_3280 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3282 = _T_3281 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3283 = _T_3282 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3284 = _T_3283 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3285 = _T_3284 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3339 = _T_3257 & io_ins[29]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3340 = _T_3339 & io_ins[28]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3341 = _T_3340 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3342 = _T_3341 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3343 = _T_3342 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3344 = _T_3343 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3345 = _T_3344 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3346 = _T_3345 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3347 = _T_3346 & io_ins[21]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3348 = _T_3347 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3349 = _T_3348 & _T_3227; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3350 = _T_3349 & _T_3229; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3351 = _T_3350 & _T_3231; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3352 = _T_3351 & _T_3233; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3353 = _T_3352 & _T_3235; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3354 = _T_3353 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3355 = _T_3354 & _T_3239; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3356 = _T_3355 & _T_3241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3357 = _T_3356 & _T_3243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3358 = _T_3357 & _T_3245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3359 = _T_3358 & _T_3247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3360 = _T_3359 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3361 = _T_3360 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3362 = _T_3361 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3363 = _T_3362 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3364 = _T_3363 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3365 = _T_3364 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3366 = _T_3365 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3367 = _T_3285 | _T_3366; // @[dec_dec_ctl.scala 248:136]
  wire  _T_3375 = ~io_ins[28]; // @[dec_dec_ctl.scala 15:46]
  wire  _T_3422 = _T_3258 & _T_3375; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3423 = _T_3422 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3424 = _T_3423 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3425 = _T_3424 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3426 = _T_3425 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3427 = _T_3426 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3428 = _T_3427 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3429 = _T_3428 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3430 = _T_3429 & _T_3227; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3431 = _T_3430 & _T_3229; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3432 = _T_3431 & _T_3231; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3433 = _T_3432 & _T_3233; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3434 = _T_3433 & _T_3235; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3435 = _T_3434 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3436 = _T_3435 & _T_3239; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3437 = _T_3436 & _T_3241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3438 = _T_3437 & _T_3243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3439 = _T_3438 & _T_3245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3440 = _T_3439 & _T_3247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3441 = _T_3440 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3442 = _T_3441 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3443 = _T_3442 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3444 = _T_3443 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3445 = _T_3444 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3446 = _T_3445 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3447 = _T_3367 | _T_3446; // @[dec_dec_ctl.scala 249:122]
  wire  _T_3471 = _T_3206 & io_ins[29]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3472 = _T_3471 & _T_3375; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3473 = _T_3472 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3474 = _T_3473 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3475 = _T_3474 & io_ins[24]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3476 = _T_3475 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3477 = _T_3476 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3478 = _T_3477 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3479 = _T_3478 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3480 = _T_3479 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3481 = _T_3480 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3482 = _T_3481 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3483 = _T_3482 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3484 = _T_3447 | _T_3483; // @[dec_dec_ctl.scala 250:119]
  wire  _T_3514 = _T_3476 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3515 = _T_3514 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3516 = _T_3515 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3517 = _T_3516 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3518 = _T_3517 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3519 = _T_3518 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3520 = _T_3519 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3521 = _T_3484 | _T_3520; // @[dec_dec_ctl.scala 251:65]
  wire  _T_3550 = _T_3474 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3551 = _T_3550 & _T_4; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3552 = _T_3551 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3553 = _T_3552 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3554 = _T_3553 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3555 = _T_3554 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3556 = _T_3555 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3557 = _T_3556 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3558 = _T_3557 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3559 = _T_3521 | _T_3558; // @[dec_dec_ctl.scala 251:127]
  wire  _T_3588 = _T_3474 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3589 = _T_3588 & _T_151; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3590 = _T_3589 & _T_6; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3591 = _T_3590 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3592 = _T_3591 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3593 = _T_3592 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3594 = _T_3593 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3595 = _T_3594 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3596 = _T_3595 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3597 = _T_3559 | _T_3596; // @[dec_dec_ctl.scala 252:66]
  wire  _T_3620 = _T_3422 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3621 = _T_3620 & io_ins[25]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3622 = _T_3621 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3623 = _T_3622 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3624 = _T_3623 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3625 = _T_3624 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3626 = _T_3625 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3627 = _T_3626 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3628 = _T_3597 | _T_3627; // @[dec_dec_ctl.scala 252:129]
  wire  _T_3651 = _T_3257 & _T_3375; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3652 = _T_3651 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3653 = _T_3652 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3654 = _T_3653 & _T_25; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3655 = _T_3654 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3656 = _T_3655 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3657 = _T_3656 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3658 = _T_3657 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3659 = _T_3658 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3660 = _T_3659 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3661 = _T_3628 | _T_3660; // @[dec_dec_ctl.scala 253:58]
  wire  _T_3686 = _T_3651 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3687 = _T_3686 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3688 = _T_3687 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3689 = _T_3688 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3690 = _T_3689 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3691 = _T_3690 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3692 = _T_3691 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3693 = _T_3692 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3694 = _T_3693 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3695 = _T_3694 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3696 = _T_3661 | _T_3695; // @[dec_dec_ctl.scala 253:114]
  wire  _T_3724 = _T_3688 & io_ins[13]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3725 = _T_3724 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3726 = _T_3725 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3727 = _T_3726 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3728 = _T_3727 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3729 = _T_3728 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3730 = _T_3729 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3731 = _T_3696 | _T_3730; // @[dec_dec_ctl.scala 254:63]
  wire  _T_3755 = _T_3206 & _T_90; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3756 = _T_3755 & _T_3375; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3757 = _T_3756 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3758 = _T_3757 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3759 = _T_3758 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3760 = _T_3759 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3761 = _T_3760 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3762 = _T_3761 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3763 = _T_3762 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3764 = _T_3763 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3765 = _T_3764 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3766 = _T_3765 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3767 = _T_3731 | _T_3766; // @[dec_dec_ctl.scala 254:123]
  wire  _T_3788 = _T_3206 & _T_3375; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3789 = _T_3788 & _T_23; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3790 = _T_3789 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3791 = _T_3790 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3792 = _T_3791 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3793 = _T_3792 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3794 = _T_3793 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3795 = _T_3794 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3796 = _T_3795 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3797 = _T_3796 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3798 = _T_3797 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3799 = _T_3767 | _T_3798; // @[dec_dec_ctl.scala 255:64]
  wire  _T_3825 = _T_3620 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3826 = _T_3825 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3827 = _T_3826 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3828 = _T_3827 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3829 = _T_3828 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3830 = _T_3829 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3831 = _T_3830 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3832 = _T_3831 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3833 = _T_3799 | _T_3832; // @[dec_dec_ctl.scala 255:119]
  wire  _T_3857 = _T_3620 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3858 = _T_3857 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3859 = _T_3858 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3860 = _T_3859 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3861 = _T_3860 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3862 = _T_3861 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3863 = _T_3862 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3864 = _T_3833 | _T_3863; // @[dec_dec_ctl.scala 256:61]
  wire  _T_3885 = _T_3206 & io_ins[30]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3886 = _T_3885 & _T_3375; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3887 = _T_3886 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3888 = _T_3887 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3889 = _T_3888 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3890 = _T_3889 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3891 = _T_3890 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3892 = _T_3891 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3893 = _T_3892 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3894 = _T_3893 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3895 = _T_3894 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3896 = _T_3895 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3897 = _T_3864 | _T_3896; // @[dec_dec_ctl.scala 256:115]
  wire  _T_3919 = _T_3472 & io_ins[27]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3920 = _T_3919 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3921 = _T_3920 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3922 = _T_3921 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3923 = _T_3922 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3924 = _T_3923 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3925 = _T_3924 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3926 = _T_3925 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3927 = _T_3926 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3928 = _T_3897 | _T_3927; // @[dec_dec_ctl.scala 257:61]
  wire  _T_3955 = _T_3688 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3956 = _T_3955 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3957 = _T_3956 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3958 = _T_3957 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3959 = _T_3958 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3960 = _T_3959 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3961 = _T_3928 | _T_3960; // @[dec_dec_ctl.scala 257:116]
  wire  _T_3987 = _T_3424 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3988 = _T_3987 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3989 = _T_3988 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3990 = _T_3989 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3991 = _T_3990 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3992 = _T_3991 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_3993 = _T_3961 | _T_3992; // @[dec_dec_ctl.scala 258:59]
  wire  _T_4010 = _T_444 & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4011 = _T_4010 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4012 = _T_4011 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4013 = _T_4012 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4014 = _T_4013 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4015 = _T_4014 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4016 = _T_3993 | _T_4015; // @[dec_dec_ctl.scala 258:114]
  wire  _T_4038 = _T_3756 & _T_3215; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4039 = _T_4038 & _T_32; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4040 = _T_4039 & io_ins[14]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4041 = _T_4040 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4042 = _T_4041 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4043 = _T_4042 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4044 = _T_4043 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4045 = _T_4044 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4046 = _T_4045 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4047 = _T_4016 | _T_4046; // @[dec_dec_ctl.scala 259:46]
  wire  _T_4072 = _T_3474 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4073 = _T_4072 & io_ins[12]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4074 = _T_4073 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4075 = _T_4074 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4076 = _T_4075 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4077 = _T_4076 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4078 = _T_4077 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4079 = _T_4078 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4080 = _T_4047 | _T_4079; // @[dec_dec_ctl.scala 259:100]
  wire  _T_4092 = io_ins[14] & io_ins[6]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4093 = _T_4092 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4094 = _T_4093 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4095 = _T_4094 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4096 = _T_4095 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4097 = _T_4096 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4098 = _T_4097 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4099 = _T_4080 | _T_4098; // @[dec_dec_ctl.scala 260:60]
  wire  _T_4114 = _T_195 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4115 = _T_4114 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4116 = _T_4115 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4117 = _T_4116 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4118 = _T_4117 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4119 = _T_4118 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4120 = _T_4099 | _T_4119; // @[dec_dec_ctl.scala 260:97]
  wire  _T_4132 = _T_36 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4133 = _T_4132 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4134 = _T_4133 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4135 = _T_4134 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4136 = _T_4135 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4137 = _T_4136 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4138 = _T_4120 | _T_4137; // @[dec_dec_ctl.scala 261:43]
  wire  _T_4152 = _T_1073 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4153 = _T_4152 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4154 = _T_4153 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4155 = _T_4154 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4156 = _T_4155 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4157 = _T_4138 | _T_4156; // @[dec_dec_ctl.scala 261:79]
  wire  _T_4226 = _T_3429 & _T_8; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4227 = _T_4226 & _T_3227; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4228 = _T_4227 & _T_3229; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4229 = _T_4228 & _T_3231; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4230 = _T_4229 & _T_3233; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4231 = _T_4230 & _T_3235; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4232 = _T_4231 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4233 = _T_4232 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4234 = _T_4233 & _T_3239; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4235 = _T_4234 & _T_3241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4236 = _T_4235 & _T_3243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4237 = _T_4236 & _T_3245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4238 = _T_4237 & _T_3247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4239 = _T_4238 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4240 = _T_4239 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4241 = _T_4240 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4242 = _T_4241 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4243 = _T_4242 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4244 = _T_4243 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4245 = _T_4244 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4246 = _T_4157 | _T_4245; // @[dec_dec_ctl.scala 261:117]
  wire  _T_4294 = _T_3422 & _T_3227; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4295 = _T_4294 & _T_3229; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4296 = _T_4295 & _T_3231; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4297 = _T_4296 & _T_3233; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4298 = _T_4297 & _T_3235; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4299 = _T_4298 & _T_63; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4300 = _T_4299 & _T_34; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4301 = _T_4300 & _T_36; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4302 = _T_4301 & _T_3239; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4303 = _T_4302 & _T_3241; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4304 = _T_4303 & _T_3243; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4305 = _T_4304 & _T_3245; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4306 = _T_4305 & _T_3247; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4307 = _T_4306 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4308 = _T_4307 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4309 = _T_4308 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4310 = _T_4309 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4311 = _T_4310 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4312 = _T_4311 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4313 = _T_4312 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4314 = _T_4246 | _T_4313; // @[dec_dec_ctl.scala 262:130]
  wire  _T_4326 = _T_806 & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4327 = _T_4326 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4328 = _T_4327 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4329 = _T_4328 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4330 = _T_4329 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4331 = _T_4330 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4332 = _T_4314 | _T_4331; // @[dec_dec_ctl.scala 263:102]
  wire  _T_4341 = io_ins[6] & io_ins[5]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4342 = _T_4341 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4343 = _T_4342 & io_ins[3]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4344 = _T_4343 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4345 = _T_4344 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4346 = _T_4345 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4347 = _T_4332 | _T_4346; // @[dec_dec_ctl.scala 264:39]
  wire  _T_4363 = _T_866 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4364 = _T_4363 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4365 = _T_4364 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4366 = _T_4365 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4367 = _T_4366 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4368 = _T_4367 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4369 = _T_4347 | _T_4368; // @[dec_dec_ctl.scala 264:71]
  wire  _T_4384 = _T_34 & _T_279; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4385 = _T_4384 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4386 = _T_4385 & _T_273; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4387 = _T_4386 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4388 = _T_4387 & _T_194; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4389 = _T_4388 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4390 = _T_4389 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4391 = _T_4369 | _T_4390; // @[dec_dec_ctl.scala 264:112]
  wire  _T_4403 = _T_937 & _T_11; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4404 = _T_4403 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4405 = _T_4404 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4406 = _T_4405 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4407 = _T_4406 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4408 = _T_4391 | _T_4407; // @[dec_dec_ctl.scala 265:43]
  wire  _T_4417 = _T_279 & io_ins[4]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4418 = _T_4417 & _T_275; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4419 = _T_4418 & io_ins[2]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4420 = _T_4419 & io_ins[1]; // @[dec_dec_ctl.scala 17:17]
  wire  _T_4421 = _T_4420 & io_ins[0]; // @[dec_dec_ctl.scala 17:17]
  assign io_out_clz = _T_1808 & _T_194; // @[dec_dec_ctl.scala 144:14]
  assign io_out_ctz = _T_1836 & _T_194; // @[dec_dec_ctl.scala 146:14]
  assign io_out_pcnt = _T_1861 & _T_194; // @[dec_dec_ctl.scala 148:15]
  assign io_out_sext_b = _T_1886 & _T_194; // @[dec_dec_ctl.scala 150:17]
  assign io_out_sext_h = _T_1910 & _T_194; // @[dec_dec_ctl.scala 152:17]
  assign io_out_slo = _T_1933 & _T_194; // @[dec_dec_ctl.scala 154:14]
  assign io_out_sro = _T_1955 & _T_194; // @[dec_dec_ctl.scala 156:14]
  assign io_out_min = _T_1971 & _T_194; // @[dec_dec_ctl.scala 158:14]
  assign io_out_max = _T_1986 & _T_194; // @[dec_dec_ctl.scala 160:14]
  assign io_out_pack = _T_2006 & _T_194; // @[dec_dec_ctl.scala 162:15]
  assign io_out_packu = _T_2022 & _T_194; // @[dec_dec_ctl.scala 164:16]
  assign io_out_packh = _T_2041 & _T_194; // @[dec_dec_ctl.scala 166:16]
  assign io_out_rol = _T_2060 & _T_194; // @[dec_dec_ctl.scala 168:14]
  assign io_out_ror = _T_2081 & _T_194; // @[dec_dec_ctl.scala 170:14]
  assign io_out_grev = _T_2625 & _T_194; // @[dec_dec_ctl.scala 204:15]
  assign io_out_gorc = _T_2646 & _T_194; // @[dec_dec_ctl.scala 206:15]
  assign io_out_zbb = _T_2342 | _T_526; // @[dec_dec_ctl.scala 172:14]
  assign io_out_sbset = _T_2377 & _T_194; // @[dec_dec_ctl.scala 180:16]
  assign io_out_sbclr = _T_2397 & _T_194; // @[dec_dec_ctl.scala 182:16]
  assign io_out_sbinv = _T_2418 & _T_194; // @[dec_dec_ctl.scala 184:16]
  assign io_out_sbext = _T_2439 & _T_194; // @[dec_dec_ctl.scala 186:16]
  assign io_out_zbs = _T_2459 | _T_2478; // @[dec_dec_ctl.scala 188:14]
  assign io_out_bext = _T_2500 & _T_194; // @[dec_dec_ctl.scala 190:15]
  assign io_out_bdep = _T_2518 & _T_194; // @[dec_dec_ctl.scala 192:15]
  assign io_out_zbe = _T_1445 & _T_194; // @[dec_dec_ctl.scala 194:14]
  assign io_out_clmul = _T_2556 & _T_194; // @[dec_dec_ctl.scala 196:16]
  assign io_out_clmulh = _T_2572 & _T_194; // @[dec_dec_ctl.scala 198:17]
  assign io_out_clmulr = _T_2589 & _T_194; // @[dec_dec_ctl.scala 200:17]
  assign io_out_zbc = _T_2605 & _T_194; // @[dec_dec_ctl.scala 202:14]
  assign io_out_shfl = _T_2672 & _T_194; // @[dec_dec_ctl.scala 208:15]
  assign io_out_unshfl = _T_2697 & _T_194; // @[dec_dec_ctl.scala 210:17]
  assign io_out_zbp = _T_2831 | _T_2847; // @[dec_dec_ctl.scala 212:14]
  assign io_out_crc32_b = _T_2878 & _T_194; // @[dec_dec_ctl.scala 217:18]
  assign io_out_crc32_h = _T_2905 & _T_194; // @[dec_dec_ctl.scala 219:18]
  assign io_out_crc32_w = _T_2932 & _T_194; // @[dec_dec_ctl.scala 221:18]
  assign io_out_crc32c_b = _T_2960 & _T_194; // @[dec_dec_ctl.scala 223:19]
  assign io_out_crc32c_h = _T_2984 & _T_194; // @[dec_dec_ctl.scala 225:19]
  assign io_out_crc32c_w = _T_3008 & _T_194; // @[dec_dec_ctl.scala 227:19]
  assign io_out_zbr = _T_1641 & _T_194; // @[dec_dec_ctl.scala 229:14]
  assign io_out_bfp = _T_3045 & _T_194; // @[dec_dec_ctl.scala 231:14]
  assign io_out_zbf = _T_3045 & _T_194; // @[dec_dec_ctl.scala 233:14]
  assign io_out_sh1add = _T_3077 & _T_194; // @[dec_dec_ctl.scala 235:17]
  assign io_out_sh2add = _T_3093 & _T_194; // @[dec_dec_ctl.scala 237:17]
  assign io_out_sh3add = _T_3106 & _T_194; // @[dec_dec_ctl.scala 239:17]
  assign io_out_zba = _T_3120 & _T_194; // @[dec_dec_ctl.scala 241:14]
  assign io_out_alu = _T_166 | _T_187; // @[dec_dec_ctl.scala 20:14]
  assign io_out_rs1 = _T_277 | _T_282; // @[dec_dec_ctl.scala 27:14]
  assign io_out_rs2 = _T_290 | _T_297; // @[dec_dec_ctl.scala 32:14]
  assign io_out_imm12 = _T_325 | _T_335; // @[dec_dec_ctl.scala 34:16]
  assign io_out_rd = _T_345 | io_ins[4]; // @[dec_dec_ctl.scala 36:13]
  assign io_out_shimm5 = _T_377 | _T_391; // @[dec_dec_ctl.scala 38:17]
  assign io_out_imm20 = _T_395 | _T_398; // @[dec_dec_ctl.scala 40:16]
  assign io_out_pc = _T_406 | _T_395; // @[dec_dec_ctl.scala 42:13]
  assign io_out_load = _T_417 & _T_194; // @[dec_dec_ctl.scala 44:15]
  assign io_out_store = _T_296 & _T_273; // @[dec_dec_ctl.scala 46:16]
  assign io_out_lsu = _T_432 & _T_194; // @[dec_dec_ctl.scala 48:14]
  assign io_out_add = _T_454 | _T_476; // @[dec_dec_ctl.scala 50:14]
  assign io_out_sub = _T_540 | _T_547; // @[dec_dec_ctl.scala 52:14]
  assign io_out_land = _T_565 | _T_576; // @[dec_dec_ctl.scala 55:15]
  assign io_out_lor = _T_619 | _T_631; // @[dec_dec_ctl.scala 57:14]
  assign io_out_lxor = _T_653 | _T_668; // @[dec_dec_ctl.scala 60:15]
  assign io_out_sll = _T_692 & _T_194; // @[dec_dec_ctl.scala 62:14]
  assign io_out_sra = _T_712 & _T_194; // @[dec_dec_ctl.scala 64:14]
  assign io_out_srl = _T_738 & _T_194; // @[dec_dec_ctl.scala 66:14]
  assign io_out_slt = _T_512 | _T_539; // @[dec_dec_ctl.scala 68:14]
  assign io_out_unsign = _T_833 | _T_848; // @[dec_dec_ctl.scala 70:17]
  assign io_out_condbr = _T_546 & _T_194; // @[dec_dec_ctl.scala 74:17]
  assign io_out_beq = _T_868 & _T_194; // @[dec_dec_ctl.scala 76:14]
  assign io_out_bne = _T_880 & _T_194; // @[dec_dec_ctl.scala 78:14]
  assign io_out_bge = _T_891 & _T_194; // @[dec_dec_ctl.scala 80:14]
  assign io_out_blt = _T_903 & _T_194; // @[dec_dec_ctl.scala 82:14]
  assign io_out_jal = io_ins[6] & io_ins[2]; // @[dec_dec_ctl.scala 84:14]
  assign io_out_by = _T_920 & _T_194; // @[dec_dec_ctl.scala 86:13]
  assign io_out_half = _T_930 & _T_194; // @[dec_dec_ctl.scala 88:15]
  assign io_out_word = _T_937 & _T_273; // @[dec_dec_ctl.scala 90:15]
  assign io_out_csr_read = _T_967 | _T_972; // @[dec_dec_ctl.scala 92:19]
  assign io_out_csr_clr = _T_1012 | _T_1021; // @[dec_dec_ctl.scala 95:18]
  assign io_out_csr_set = _T_1057 | _T_1065; // @[dec_dec_ctl.scala 98:18]
  assign io_out_csr_write = _T_1073 & io_ins[4]; // @[dec_dec_ctl.scala 101:20]
  assign io_out_csr_imm = _T_1114 | _T_1121; // @[dec_dec_ctl.scala 103:18]
  assign io_out_presync = _T_1203 | _T_1210; // @[dec_dec_ctl.scala 106:18]
  assign io_out_postsync = _T_1307 | _T_1210; // @[dec_dec_ctl.scala 111:19]
  assign io_out_ebreak = _T_1328 & io_ins[4]; // @[dec_dec_ctl.scala 116:17]
  assign io_out_ecall = _T_1343 & io_ins[4]; // @[dec_dec_ctl.scala 118:16]
  assign io_out_mret = _T_1354 & io_ins[4]; // @[dec_dec_ctl.scala 120:15]
  assign io_out_mul = _T_1643 | _T_1656; // @[dec_dec_ctl.scala 122:14]
  assign io_out_rs1_sign = _T_1679 | _T_1699; // @[dec_dec_ctl.scala 130:19]
  assign io_out_rs2_sign = _T_1698 & _T_194; // @[dec_dec_ctl.scala 132:19]
  assign io_out_low = _T_1736 & _T_194; // @[dec_dec_ctl.scala 134:14]
  assign io_out_div = _T_1750 & _T_194; // @[dec_dec_ctl.scala 136:14]
  assign io_out_rem = _T_1766 & _T_194; // @[dec_dec_ctl.scala 138:14]
  assign io_out_fence = _T_11 & io_ins[3]; // @[dec_dec_ctl.scala 140:16]
  assign io_out_fence_i = _T_1216 & io_ins[3]; // @[dec_dec_ctl.scala 142:18]
  assign io_out_pm_alu = _T_3196 | _T_122; // @[dec_dec_ctl.scala 243:17]
  assign io_out_legal = _T_4408 | _T_4421; // @[dec_dec_ctl.scala 248:16]
endmodule
module dec_decode_ctl(
  input         clock,
  input         reset,
  output [1:0]  io_decode_exu_dec_data_en,
  output [1:0]  io_decode_exu_dec_ctl_en,
  output        io_decode_exu_i0_ap_clz,
  output        io_decode_exu_i0_ap_ctz,
  output        io_decode_exu_i0_ap_pcnt,
  output        io_decode_exu_i0_ap_sext_b,
  output        io_decode_exu_i0_ap_sext_h,
  output        io_decode_exu_i0_ap_slo,
  output        io_decode_exu_i0_ap_sro,
  output        io_decode_exu_i0_ap_min,
  output        io_decode_exu_i0_ap_max,
  output        io_decode_exu_i0_ap_pack,
  output        io_decode_exu_i0_ap_packu,
  output        io_decode_exu_i0_ap_packh,
  output        io_decode_exu_i0_ap_rol,
  output        io_decode_exu_i0_ap_ror,
  output        io_decode_exu_i0_ap_grev,
  output        io_decode_exu_i0_ap_gorc,
  output        io_decode_exu_i0_ap_zbb,
  output        io_decode_exu_i0_ap_sbset,
  output        io_decode_exu_i0_ap_sbclr,
  output        io_decode_exu_i0_ap_sbinv,
  output        io_decode_exu_i0_ap_sbext,
  output        io_decode_exu_i0_ap_sh1add,
  output        io_decode_exu_i0_ap_sh2add,
  output        io_decode_exu_i0_ap_sh3add,
  output        io_decode_exu_i0_ap_zba,
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
  output        io_decode_exu_dec_i0_predict_p_d_bits_misp,
  output        io_decode_exu_dec_i0_predict_p_d_bits_ataken,
  output        io_decode_exu_dec_i0_predict_p_d_bits_boffset,
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
  output        io_decode_exu_dec_i0_select_pc_d,
  output [3:0]  io_decode_exu_dec_i0_rs1_bypass_en_d,
  output [3:0]  io_decode_exu_dec_i0_rs2_bypass_en_d,
  output        io_decode_exu_mul_p_valid,
  output        io_decode_exu_mul_p_bits_rs1_sign,
  output        io_decode_exu_mul_p_bits_rs2_sign,
  output        io_decode_exu_mul_p_bits_low,
  output        io_decode_exu_mul_p_bits_bext,
  output        io_decode_exu_mul_p_bits_bdep,
  output        io_decode_exu_mul_p_bits_clmul,
  output        io_decode_exu_mul_p_bits_clmulh,
  output        io_decode_exu_mul_p_bits_clmulr,
  output        io_decode_exu_mul_p_bits_grev,
  output        io_decode_exu_mul_p_bits_gorc,
  output        io_decode_exu_mul_p_bits_shfl,
  output        io_decode_exu_mul_p_bits_unshfl,
  output        io_decode_exu_mul_p_bits_crc32_b,
  output        io_decode_exu_mul_p_bits_crc32_h,
  output        io_decode_exu_mul_p_bits_crc32_w,
  output        io_decode_exu_mul_p_bits_crc32c_b,
  output        io_decode_exu_mul_p_bits_crc32c_h,
  output        io_decode_exu_mul_p_bits_crc32c_w,
  output        io_decode_exu_mul_p_bits_bfp,
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
  output        io_dec_aln_dec_i0_decode_d,
  input  [15:0] io_dec_aln_ifu_i0_cinst,
  input  [31:0] io_dbg_dctl_dbg_cmd_wrdata,
  input         io_dec_tlu_trace_disable,
  input         io_dec_debug_valid_d,
  input         io_dec_tlu_flush_extint,
  input         io_dec_tlu_force_halt,
  output [31:0] io_dec_i0_inst_wb,
  output [30:0] io_dec_i0_pc_wb,
  input  [3:0]  io_dec_i0_trigger_match_d,
  input         io_dec_tlu_wr_pause_r,
  input         io_dec_tlu_pipelining_disable,
  input  [3:0]  io_lsu_trigger_match_m,
  input         io_lsu_pmu_misaligned_m,
  input         io_dec_tlu_debug_stall,
  input         io_dec_tlu_flush_leak_one_r,
  input         io_dec_debug_fence_d,
  input         io_dec_i0_icaf_d,
  input         io_dec_i0_icaf_second_d,
  input  [1:0]  io_dec_i0_icaf_type_d,
  input         io_dec_i0_dbecc_d,
  input         io_dec_i0_brp_valid,
  input  [11:0] io_dec_i0_brp_bits_toffset,
  input  [1:0]  io_dec_i0_brp_bits_hist,
  input         io_dec_i0_brp_bits_br_error,
  input         io_dec_i0_brp_bits_br_start_error,
  input         io_dec_i0_brp_bits_bank,
  input  [30:0] io_dec_i0_brp_bits_prett,
  input         io_dec_i0_brp_bits_way,
  input         io_dec_i0_brp_bits_ret,
  input  [7:0]  io_dec_i0_bp_index,
  input  [7:0]  io_dec_i0_bp_fghr,
  input  [4:0]  io_dec_i0_bp_btag,
  input  [8:0]  io_dec_i0_bp_fa_index,
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
  input         io_active_clk,
  input         io_free_l2clk,
  input         io_clk_override,
  output [4:0]  io_dec_i0_rs1_d,
  output [4:0]  io_dec_i0_rs2_d,
  output [4:0]  io_dec_i0_waddr_r,
  output        io_dec_i0_wen_r,
  output [31:0] io_dec_i0_wdata_r,
  output        io_dec_i0_branch_d,
  output [31:0] io_dec_i0_result_r,
  output        io_dec_qual_lsu_d,
  output        io_lsu_p_valid,
  output        io_lsu_p_bits_fast_int,
  output        io_lsu_p_bits_stack,
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
  output        io_dec_tlu_packet_r_icaf_second,
  output [1:0]  io_dec_tlu_packet_r_icaf_type,
  output        io_dec_tlu_packet_r_fence_i,
  output [3:0]  io_dec_tlu_packet_r_i0trigger,
  output [3:0]  io_dec_tlu_packet_r_pmu_i0_itype,
  output        io_dec_tlu_packet_r_pmu_i0_br_unpred,
  output        io_dec_tlu_packet_r_pmu_divide,
  output        io_dec_tlu_packet_r_pmu_lsu_misaligned,
  output [30:0] io_dec_tlu_i0_pc_r,
  output [31:0] io_dec_illegal_inst,
  output [8:0]  io_dec_fa_error_index,
  output        io_dec_pmu_instr_decoded,
  output        io_dec_pmu_decode_stall,
  output        io_dec_pmu_presync_stall,
  output        io_dec_pmu_postsync_stall,
  output        io_dec_nonblock_load_wen,
  output [4:0]  io_dec_nonblock_load_waddr,
  output        io_dec_pause_state,
  output        io_dec_pause_state_cg,
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
`endif // RANDOMIZE_REG_INIT
  wire  rvclkhdr_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_1_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_1_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_1_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_1_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_2_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_2_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_2_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_2_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_3_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_3_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_3_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_3_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_4_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_4_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_4_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_4_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_5_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_5_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_5_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_5_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_6_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_6_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_6_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_6_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_7_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_7_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_7_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_7_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_8_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_8_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_8_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_8_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_9_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_9_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_9_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_9_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_10_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_10_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_10_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_10_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_11_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_11_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_11_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_11_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_12_io_l1clk; // @[lib.scala 444:25]
  wire  rvclkhdr_12_io_clk; // @[lib.scala 444:25]
  wire  rvclkhdr_12_io_en; // @[lib.scala 444:25]
  wire  rvclkhdr_12_io_scan_mode; // @[lib.scala 444:25]
  wire  rvclkhdr_13_io_l1clk; // @[lib.scala 468:25]
  wire  rvclkhdr_13_io_clk; // @[lib.scala 468:25]
  wire  rvclkhdr_13_io_en; // @[lib.scala 468:25]
  wire  rvclkhdr_13_io_scan_mode; // @[lib.scala 468:25]
  wire  rvclkhdr_14_io_l1clk; // @[lib.scala 468:25]
  wire  rvclkhdr_14_io_clk; // @[lib.scala 468:25]
  wire  rvclkhdr_14_io_en; // @[lib.scala 468:25]
  wire  rvclkhdr_14_io_scan_mode; // @[lib.scala 468:25]
  wire  rvclkhdr_15_io_l1clk; // @[lib.scala 468:25]
  wire  rvclkhdr_15_io_clk; // @[lib.scala 468:25]
  wire  rvclkhdr_15_io_en; // @[lib.scala 468:25]
  wire  rvclkhdr_15_io_scan_mode; // @[lib.scala 468:25]
  wire  rvclkhdr_16_io_l1clk; // @[lib.scala 468:25]
  wire  rvclkhdr_16_io_clk; // @[lib.scala 468:25]
  wire  rvclkhdr_16_io_en; // @[lib.scala 468:25]
  wire  rvclkhdr_16_io_scan_mode; // @[lib.scala 468:25]
  wire [31:0] i0_dec_io_ins; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_clz; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_ctz; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_pcnt; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sext_b; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sext_h; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_slo; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sro; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_min; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_max; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_pack; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_packu; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_packh; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rol; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_ror; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_grev; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_gorc; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbb; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sbset; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sbclr; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sbinv; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sbext; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbs; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_bext; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_bdep; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbe; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_clmul; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_clmulh; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_clmulr; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbc; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_shfl; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_unshfl; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbp; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_crc32_b; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_crc32_h; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_crc32_w; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_crc32c_b; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_crc32c_h; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_crc32c_w; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbr; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_bfp; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zbf; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sh1add; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sh2add; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sh3add; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_zba; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_alu; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rs1; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rs2; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_imm12; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rd; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_shimm5; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_imm20; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_pc; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_load; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_store; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_lsu; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_add; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sub; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_land; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_lor; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_lxor; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sll; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_sra; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_srl; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_slt; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_unsign; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_condbr; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_beq; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_bne; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_bge; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_blt; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_jal; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_by; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_half; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_word; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_csr_read; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_csr_clr; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_csr_set; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_csr_write; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_csr_imm; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_presync; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_postsync; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_ebreak; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_ecall; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_mret; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_mul; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rs1_sign; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rs2_sign; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_low; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_div; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_rem; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_fence; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_fence_i; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_pm_alu; // @[dec_decode_ctl.scala 438:22]
  wire  i0_dec_io_out_legal; // @[dec_decode_ctl.scala 438:22]
  wire  rvclkhdr_17_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_17_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_17_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_17_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_18_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_18_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_18_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_18_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_19_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_19_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_19_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_19_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_20_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_20_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_20_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_20_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_21_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_21_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_21_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_21_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_22_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_22_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_22_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_22_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_23_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_23_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_23_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_23_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_24_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_24_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_24_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_24_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_25_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_25_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_25_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_25_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_26_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_26_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_26_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_26_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_27_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_27_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_27_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_27_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_28_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_28_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_28_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_28_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_29_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_29_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_29_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_29_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_30_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_30_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_30_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_30_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_31_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_31_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_31_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_31_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_32_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_32_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_32_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_32_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_33_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_33_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_33_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_33_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_34_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_34_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_34_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_34_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_35_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_35_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_35_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_35_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_36_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_36_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_36_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_36_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_37_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_37_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_37_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_37_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_38_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_38_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_38_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_38_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_39_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_39_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_39_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_39_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_40_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_40_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_40_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_40_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_41_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_41_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_41_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_41_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_42_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_42_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_42_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_42_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_43_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_43_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_43_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_43_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_44_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_44_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_44_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_44_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_45_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_45_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_45_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_45_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_46_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_46_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_46_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_46_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_47_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_47_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_47_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_47_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_48_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_48_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_48_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_48_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_49_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_49_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_49_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_49_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_50_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_50_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_50_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_50_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_51_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_51_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_51_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_51_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_52_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_52_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_52_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_52_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_53_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_53_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_53_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_53_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_54_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_54_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_54_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_54_io_scan_mode; // @[lib.scala 392:23]
  wire  rvclkhdr_55_io_l1clk; // @[lib.scala 392:23]
  wire  rvclkhdr_55_io_clk; // @[lib.scala 392:23]
  wire  rvclkhdr_55_io_en; // @[lib.scala 392:23]
  wire  rvclkhdr_55_io_scan_mode; // @[lib.scala 392:23]
  reg  leak1_i1_stall; // @[lib.scala 450:26]
  wire  _T_366 = ~io_dec_tlu_flush_lower_r; // @[dec_decode_ctl.scala 445:73]
  wire  _T_367 = leak1_i1_stall & _T_366; // @[dec_decode_ctl.scala 445:71]
  wire  leak1_i1_stall_in = io_dec_tlu_flush_leak_one_r | _T_367; // @[dec_decode_ctl.scala 445:53]
  wire  _T_2 = leak1_i1_stall_in ^ leak1_i1_stall; // @[lib.scala 436:21]
  wire  _T_369 = io_dec_aln_dec_i0_decode_d & leak1_i1_stall; // @[dec_decode_ctl.scala 447:53]
  reg  leak1_i0_stall; // @[lib.scala 450:26]
  wire  _T_371 = leak1_i0_stall & _T_366; // @[dec_decode_ctl.scala 447:89]
  wire  leak1_i0_stall_in = _T_369 | _T_371; // @[dec_decode_ctl.scala 447:71]
  wire  _T_6 = leak1_i0_stall_in ^ leak1_i0_stall; // @[lib.scala 436:21]
  reg  _T_12; // @[lib.scala 450:26]
  wire  _T_10 = io_dec_tlu_flush_extint ^ _T_12; // @[lib.scala 436:21]
  reg  pause_stall; // @[lib.scala 450:26]
  wire  _T_509 = io_dec_tlu_wr_pause_r | pause_stall; // @[dec_decode_ctl.scala 559:44]
  wire  _T_502 = ~io_dec_tlu_flush_pause_r; // @[dec_decode_ctl.scala 558:49]
  wire  _T_503 = io_dec_tlu_flush_lower_r & _T_502; // @[dec_decode_ctl.scala 558:47]
  reg [31:0] write_csr_data; // @[lib.scala 401:18]
  wire [31:0] _T_506 = {31'h0,write_csr_data[0]}; // @[Cat.scala 29:58]
  wire  _T_507 = write_csr_data == _T_506; // @[dec_decode_ctl.scala 558:109]
  wire  _T_508 = pause_stall & _T_507; // @[dec_decode_ctl.scala 558:91]
  wire  clear_pause = _T_503 | _T_508; // @[dec_decode_ctl.scala 558:76]
  wire  _T_510 = ~clear_pause; // @[dec_decode_ctl.scala 559:61]
  wire  pause_state_in = _T_509 & _T_510; // @[dec_decode_ctl.scala 559:59]
  wire  _T_14 = pause_state_in ^ pause_stall; // @[lib.scala 436:21]
  reg  tlu_wr_pause_r1; // @[lib.scala 450:26]
  wire  _T_18 = io_dec_tlu_wr_pause_r ^ tlu_wr_pause_r1; // @[lib.scala 436:21]
  reg  tlu_wr_pause_r2; // @[lib.scala 450:26]
  wire  _T_22 = tlu_wr_pause_r1 ^ tlu_wr_pause_r2; // @[lib.scala 436:21]
  wire  _T_50 = ~leak1_i1_stall; // @[dec_decode_ctl.scala 222:80]
  wire  i0_brp_valid = io_dec_i0_brp_valid & _T_50; // @[dec_decode_ctl.scala 222:78]
  wire  i0_dp_raw_condbr = i0_dec_io_out_condbr; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_jal = i0_dec_io_out_jal; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire [19:0] i0_pcall_imm = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[19:12],io_dec_i0_instr_d[20],io_dec_i0_instr_d[30:21]}; // @[Cat.scala 29:58]
  wire  _T_382 = i0_pcall_imm[19:12] == 8'hff; // @[dec_decode_ctl.scala 452:79]
  wire  _T_384 = i0_pcall_imm[19:12] == 8'h0; // @[dec_decode_ctl.scala 452:112]
  wire  i0_pcall_12b_offset = i0_pcall_imm[11] ? _T_382 : _T_384; // @[dec_decode_ctl.scala 452:33]
  wire  i0_dp_raw_imm20 = i0_dec_io_out_imm20; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  _T_385 = i0_pcall_12b_offset & i0_dp_raw_imm20; // @[dec_decode_ctl.scala 453:47]
  wire [4:0] i0r_rd = io_dec_i0_instr_d[11:7]; // @[dec_decode_ctl.scala 678:16]
  wire  _T_386 = i0r_rd == 5'h1; // @[dec_decode_ctl.scala 453:76]
  wire  _T_387 = i0r_rd == 5'h5; // @[dec_decode_ctl.scala 453:98]
  wire  _T_388 = _T_386 | _T_387; // @[dec_decode_ctl.scala 453:89]
  wire  i0_pcall_case = _T_385 & _T_388; // @[dec_decode_ctl.scala 453:65]
  wire  i0_pcall_raw = i0_dp_raw_jal & i0_pcall_case; // @[dec_decode_ctl.scala 455:38]
  wire  _T_53 = i0_dp_raw_condbr | i0_pcall_raw; // @[dec_decode_ctl.scala 233:92]
  wire  _T_393 = ~_T_388; // @[dec_decode_ctl.scala 454:67]
  wire  i0_pja_case = _T_385 & _T_393; // @[dec_decode_ctl.scala 454:65]
  wire  i0_pja_raw = i0_dp_raw_jal & i0_pja_case; // @[dec_decode_ctl.scala 457:38]
  wire  _T_54 = _T_53 | i0_pja_raw; // @[dec_decode_ctl.scala 233:107]
  wire  i0_dp_raw_imm12 = i0_dec_io_out_imm12; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  _T_409 = i0_dp_raw_jal & i0_dp_raw_imm12; // @[dec_decode_ctl.scala 461:37]
  wire  _T_410 = i0r_rd == 5'h0; // @[dec_decode_ctl.scala 461:65]
  wire  _T_411 = _T_409 & _T_410; // @[dec_decode_ctl.scala 461:55]
  wire [4:0] i0r_rs1 = io_dec_i0_instr_d[19:15]; // @[dec_decode_ctl.scala 676:16]
  wire  _T_412 = i0r_rs1 == 5'h1; // @[dec_decode_ctl.scala 461:89]
  wire  _T_413 = i0r_rs1 == 5'h5; // @[dec_decode_ctl.scala 461:111]
  wire  _T_414 = _T_412 | _T_413; // @[dec_decode_ctl.scala 461:101]
  wire  i0_pret_case = _T_411 & _T_414; // @[dec_decode_ctl.scala 461:79]
  wire  i0_pret_raw = i0_dp_raw_jal & i0_pret_case; // @[dec_decode_ctl.scala 462:32]
  wire  _T_55 = _T_54 | i0_pret_raw; // @[dec_decode_ctl.scala 233:120]
  wire  _T_56 = ~_T_55; // @[dec_decode_ctl.scala 233:73]
  wire  _T_57 = i0_brp_valid & _T_56; // @[dec_decode_ctl.scala 233:71]
  wire  _T_67 = io_dec_i0_brp_bits_br_error | _T_57; // @[dec_decode_ctl.scala 238:87]
  wire  _T_59 = i0_brp_valid & io_dec_i0_brp_bits_hist[1]; // @[dec_decode_ctl.scala 236:72]
  wire  _T_398 = i0_pcall_raw | i0_pja_raw; // @[dec_decode_ctl.scala 459:41]
  wire [11:0] _T_407 = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[7],io_dec_i0_instr_d[30:25],io_dec_i0_instr_d[11:8]}; // @[Cat.scala 29:58]
  wire [11:0] i0_br_offset = _T_398 ? i0_pcall_imm[11:0] : _T_407; // @[dec_decode_ctl.scala 459:26]
  wire  _T_60 = io_dec_i0_brp_bits_toffset != i0_br_offset; // @[dec_decode_ctl.scala 236:131]
  wire  _T_61 = _T_59 & _T_60; // @[dec_decode_ctl.scala 236:101]
  wire  _T_62 = ~i0_pret_raw; // @[dec_decode_ctl.scala 236:151]
  wire  _T_63 = _T_61 & _T_62; // @[dec_decode_ctl.scala 236:149]
  wire  _T_68 = _T_67 | _T_63; // @[dec_decode_ctl.scala 238:104]
  wire  _T_64 = i0_brp_valid & io_dec_i0_brp_bits_ret; // @[dec_decode_ctl.scala 237:72]
  wire  _T_66 = _T_64 & _T_62; // @[dec_decode_ctl.scala 237:97]
  wire  _T_69 = _T_68 | _T_66; // @[dec_decode_ctl.scala 238:126]
  wire  _T_76 = _T_69 | io_dec_i0_brp_bits_br_start_error; // @[dec_decode_ctl.scala 243:72]
  wire  i0_br_error_all = _T_76 & _T_50; // @[dec_decode_ctl.scala 243:109]
  wire  i0_icaf_d = io_dec_i0_icaf_d | io_dec_i0_dbecc_d; // @[dec_decode_ctl.scala 277:43]
  wire  _T_79 = i0_br_error_all | i0_icaf_d; // @[dec_decode_ctl.scala 280:25]
  wire  i0_dp_raw_legal = i0_dec_io_out_legal; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_legal = _T_79 | i0_dp_raw_legal; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_csr_read = i0_dec_io_out_csr_read; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_csr_read = _T_79 ? 1'h0 : i0_dp_raw_csr_read; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_csr_write = i0_dec_io_out_csr_write; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_csr_write = _T_79 ? 1'h0 : i0_dp_raw_csr_write; // @[dec_decode_ctl.scala 280:50]
  wire  _T_428 = ~io_dec_debug_fence_d; // @[dec_decode_ctl.scala 519:42]
  wire  i0_csr_write = i0_dp_csr_write & _T_428; // @[dec_decode_ctl.scala 519:40]
  wire  any_csr_d = i0_dp_csr_read | i0_csr_write; // @[dec_decode_ctl.scala 527:34]
  wire  _T_539 = ~any_csr_d; // @[dec_decode_ctl.scala 590:40]
  wire  _T_540 = _T_539 | io_dec_csr_legal_d; // @[dec_decode_ctl.scala 590:51]
  wire  i0_legal = i0_dp_legal & _T_540; // @[dec_decode_ctl.scala 590:37]
  wire  _T_558 = ~i0_legal; // @[dec_decode_ctl.scala 594:57]
  wire  shift_illegal = io_dec_aln_dec_i0_decode_d & _T_558; // @[dec_decode_ctl.scala 594:55]
  reg  illegal_lockout; // @[lib.scala 450:26]
  wire  _T_561 = shift_illegal | illegal_lockout; // @[dec_decode_ctl.scala 597:40]
  reg  flush_final_r; // @[lib.scala 450:26]
  wire  _T_562 = ~flush_final_r; // @[dec_decode_ctl.scala 597:61]
  wire  illegal_lockout_in = _T_561 & _T_562; // @[dec_decode_ctl.scala 597:59]
  wire  _T_26 = illegal_lockout_in ^ illegal_lockout; // @[lib.scala 436:21]
  wire  i0_dp_raw_postsync = i0_dec_io_out_postsync; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_postsync = _T_79 | i0_dp_raw_postsync; // @[dec_decode_ctl.scala 280:50]
  wire  _T_534 = i0_dp_postsync | io_dec_tlu_postsync_d; // @[dec_decode_ctl.scala 586:36]
  wire  debug_fence_i = io_dec_debug_fence_d & io_dbg_dctl_dbg_cmd_wrdata[0]; // @[dec_decode_ctl.scala 578:48]
  wire  _T_535 = _T_534 | debug_fence_i; // @[dec_decode_ctl.scala 586:60]
  wire  _T_432 = ~i0_dp_csr_read; // @[dec_decode_ctl.scala 524:41]
  wire  i0_csr_write_only_d = i0_csr_write & _T_432; // @[dec_decode_ctl.scala 524:39]
  wire  _T_537 = io_dec_i0_instr_d[31:20] == 12'h7c2; // @[dec_decode_ctl.scala 586:112]
  wire  _T_538 = i0_csr_write_only_d & _T_537; // @[dec_decode_ctl.scala 586:99]
  wire  i0_postsync = _T_535 | _T_538; // @[dec_decode_ctl.scala 586:76]
  wire  _T_600 = i0_postsync | _T_558; // @[dec_decode_ctl.scala 628:62]
  wire  _T_601 = io_dec_aln_dec_i0_decode_d & _T_600; // @[dec_decode_ctl.scala 628:47]
  reg  postsync_stall; // @[lib.scala 450:26]
  reg  _T_967; // @[lib.scala 401:18]
  reg [22:0] _T_966; // @[lib.scala 401:18]
  wire [23:0] _T_970 = {_T_967,_T_966}; // @[lib.scala 562:21]
  wire  x_d_valid = _T_970[23]; // @[lib.scala 562:21]
  wire  _T_602 = postsync_stall & x_d_valid; // @[dec_decode_ctl.scala 628:96]
  wire  ps_stall_in = _T_601 | _T_602; // @[dec_decode_ctl.scala 628:77]
  wire  _T_30 = ps_stall_in ^ postsync_stall; // @[lib.scala 436:21]
  reg [3:0] lsu_trigger_match_r; // @[lib.scala 450:26]
  wire [3:0] _T_33 = io_lsu_trigger_match_m ^ lsu_trigger_match_r; // @[lib.scala 436:21]
  reg  lsu_pmu_misaligned_r; // @[lib.scala 450:26]
  wire  _T_36 = io_lsu_pmu_misaligned_m ^ lsu_pmu_misaligned_r; // @[lib.scala 436:21]
  wire  i0_legal_decode_d = io_dec_aln_dec_i0_decode_d & i0_legal; // @[dec_decode_ctl.scala 756:54]
  wire  i0_dp_raw_div = i0_dec_io_out_div; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_div = _T_79 ? 1'h0 : i0_dp_raw_div; // @[dec_decode_ctl.scala 280:50]
  wire  i0_div_decode_d = i0_legal_decode_d & i0_dp_div; // @[dec_decode_ctl.scala 843:55]
  wire  _T_1109 = ~io_exu_div_wren; // @[dec_decode_ctl.scala 845:59]
  wire  _T_1110 = io_dec_div_active & _T_1109; // @[dec_decode_ctl.scala 845:57]
  wire  x_d_bits_i0div = _T_970[15]; // @[lib.scala 562:21]
  wire  _T_1093 = x_d_bits_i0div & x_d_valid; // @[dec_decode_ctl.scala 833:48]
  wire [4:0] x_d_bits_i0rd = _T_970[22:18]; // @[lib.scala 562:21]
  wire  _T_1094 = x_d_bits_i0rd == 5'h0; // @[dec_decode_ctl.scala 833:77]
  wire  _T_1095 = _T_1093 & _T_1094; // @[dec_decode_ctl.scala 833:60]
  wire  _T_1097 = _T_1093 & io_dec_tlu_flush_lower_r; // @[dec_decode_ctl.scala 834:33]
  wire  _T_1098 = _T_1095 | _T_1097; // @[dec_decode_ctl.scala 833:94]
  reg  _T_998; // @[lib.scala 401:18]
  reg [22:0] _T_997; // @[lib.scala 401:18]
  wire [23:0] _T_1001 = {_T_998,_T_997}; // @[lib.scala 562:21]
  wire  r_d_bits_i0div = _T_1001[15]; // @[lib.scala 562:21]
  wire  r_d_valid = _T_1001[23]; // @[lib.scala 562:21]
  wire  _T_1099 = r_d_bits_i0div & r_d_valid; // @[dec_decode_ctl.scala 835:21]
  wire  _T_1100 = _T_1099 & io_dec_tlu_flush_lower_r; // @[dec_decode_ctl.scala 835:33]
  wire  _T_1101 = _T_1100 & io_dec_tlu_i0_kill_writeb_r; // @[dec_decode_ctl.scala 835:60]
  wire  div_flush = _T_1098 | _T_1101; // @[dec_decode_ctl.scala 834:62]
  wire  _T_1102 = io_dec_div_active & div_flush; // @[dec_decode_ctl.scala 839:51]
  wire  div_e1_to_r = _T_1093 | _T_1099; // @[dec_decode_ctl.scala 831:58]
  wire  _T_1103 = ~div_e1_to_r; // @[dec_decode_ctl.scala 840:26]
  wire  _T_1104 = io_dec_div_active & _T_1103; // @[dec_decode_ctl.scala 840:24]
  wire [4:0] r_d_bits_i0rd = _T_1001[22:18]; // @[lib.scala 562:21]
  wire  _T_1105 = r_d_bits_i0rd == io_div_waddr_wb; // @[dec_decode_ctl.scala 840:56]
  wire  _T_1106 = _T_1104 & _T_1105; // @[dec_decode_ctl.scala 840:39]
  wire  r_d_bits_i0v = _T_1001[14]; // @[lib.scala 562:21]
  wire  _T_1012 = ~io_dec_tlu_flush_lower_wb; // @[dec_decode_ctl.scala 798:51]
  wire  r_d_in_bits_i0v = r_d_bits_i0v & _T_1012; // @[dec_decode_ctl.scala 798:49]
  wire  _T_1043 = ~io_dec_tlu_i0_kill_writeb_r; // @[dec_decode_ctl.scala 806:47]
  wire  i0_wen_r = r_d_in_bits_i0v & _T_1043; // @[dec_decode_ctl.scala 806:45]
  wire  _T_1107 = _T_1106 & i0_wen_r; // @[dec_decode_ctl.scala 840:77]
  wire  nonblock_div_cancel = _T_1102 | _T_1107; // @[dec_decode_ctl.scala 839:65]
  wire  _T_1111 = ~nonblock_div_cancel; // @[dec_decode_ctl.scala 845:78]
  wire  _T_1112 = _T_1110 & _T_1111; // @[dec_decode_ctl.scala 845:76]
  wire  div_active_in = i0_div_decode_d | _T_1112; // @[dec_decode_ctl.scala 845:36]
  reg  _T_42; // @[lib.scala 450:26]
  wire  _T_40 = div_active_in ^ _T_42; // @[lib.scala 436:21]
  wire  _T_44 = io_exu_flush_final ^ flush_final_r; // @[lib.scala 436:21]
  reg  debug_valid_x; // @[lib.scala 450:26]
  wire  _T_47 = io_dec_debug_valid_d ^ debug_valid_x; // @[lib.scala 436:21]
  wire  _T_70 = _T_69 & i0_legal_decode_d; // @[dec_decode_ctl.scala 239:72]
  wire  _T_73 = io_dec_i0_brp_bits_br_start_error & i0_legal_decode_d; // @[dec_decode_ctl.scala 240:94]
  wire  i0_dp_raw_pm_alu = i0_dec_io_out_pm_alu; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_pm_alu = _T_79 ? 1'h0 : i0_dp_raw_pm_alu; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_fence_i = i0_dec_io_out_fence_i; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_fence_i = _T_79 ? 1'h0 : i0_dp_raw_fence_i; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_fence = i0_dec_io_out_fence; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_fence = _T_79 ? 1'h0 : i0_dp_raw_fence; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_rem = i0_dec_io_out_rem; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_low = i0_dec_io_out_low; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_rs2_sign = i0_dec_io_out_rs2_sign; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_rs1_sign = i0_dec_io_out_rs1_sign; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_mul = i0_dec_io_out_mul; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_mul = _T_79 ? 1'h0 : i0_dp_raw_mul; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_mret = i0_dec_io_out_mret; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_mret = _T_79 ? 1'h0 : i0_dp_raw_mret; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_ecall = i0_dec_io_out_ecall; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_ecall = _T_79 ? 1'h0 : i0_dp_raw_ecall; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_ebreak = i0_dec_io_out_ebreak; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_ebreak = _T_79 ? 1'h0 : i0_dp_raw_ebreak; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_presync = i0_dec_io_out_presync; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_presync = _T_79 ? 1'h0 : i0_dp_raw_presync; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_csr_imm = i0_dec_io_out_csr_imm; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_csr_imm = _T_79 ? 1'h0 : i0_dp_raw_csr_imm; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_csr_set = i0_dec_io_out_csr_set; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_csr_set = _T_79 ? 1'h0 : i0_dp_raw_csr_set; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_csr_clr = i0_dec_io_out_csr_clr; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_csr_clr = _T_79 ? 1'h0 : i0_dp_raw_csr_clr; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_word = i0_dec_io_out_word; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_word = _T_79 ? 1'h0 : i0_dp_raw_word; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_half = i0_dec_io_out_half; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_half = _T_79 ? 1'h0 : i0_dp_raw_half; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_by = i0_dec_io_out_by; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_by = _T_79 ? 1'h0 : i0_dp_raw_by; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_jal = _T_79 ? 1'h0 : i0_dp_raw_jal; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_blt = i0_dec_io_out_blt; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_bge = i0_dec_io_out_bge; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_bne = i0_dec_io_out_bne; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_beq = i0_dec_io_out_beq; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_condbr = _T_79 ? 1'h0 : i0_dp_raw_condbr; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_unsign = i0_dec_io_out_unsign; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_unsign = _T_79 ? 1'h0 : i0_dp_raw_unsign; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_slt = i0_dec_io_out_slt; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_srl = i0_dec_io_out_srl; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sra = i0_dec_io_out_sra; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sll = i0_dec_io_out_sll; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_lxor = i0_dec_io_out_lxor; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_lor = i0_dec_io_out_lor; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_land = i0_dec_io_out_land; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sub = i0_dec_io_out_sub; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_add = i0_dec_io_out_add; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_lsu = i0_dec_io_out_lsu; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_lsu = _T_79 ? 1'h0 : i0_dp_raw_lsu; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_store = i0_dec_io_out_store; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_store = _T_79 ? 1'h0 : i0_dp_raw_store; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_load = i0_dec_io_out_load; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_load = _T_79 ? 1'h0 : i0_dp_raw_load; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_pc = i0_dec_io_out_pc; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_imm20 = _T_79 ? 1'h0 : i0_dp_raw_imm20; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_shimm5 = i0_dec_io_out_shimm5; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_shimm5 = _T_79 ? 1'h0 : i0_dp_raw_shimm5; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_rd = i0_dec_io_out_rd; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_rd = _T_79 ? 1'h0 : i0_dp_raw_rd; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_imm12 = _T_79 ? 1'h0 : i0_dp_raw_imm12; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_rs2 = i0_dec_io_out_rs2; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_rs2 = _T_79 | i0_dp_raw_rs2; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_rs1 = i0_dec_io_out_rs1; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_rs1 = _T_79 | i0_dp_raw_rs1; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_alu = i0_dec_io_out_alu; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_alu = _T_79 | i0_dp_raw_alu; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_zba = i0_dec_io_out_zba; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zba = _T_79 ? 1'h0 : i0_dp_raw_zba; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_sh3add = i0_dec_io_out_sh3add; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sh2add = i0_dec_io_out_sh2add; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sh1add = i0_dec_io_out_sh1add; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbf = i0_dec_io_out_zbf; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbf = _T_79 ? 1'h0 : i0_dp_raw_zbf; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_bfp = i0_dec_io_out_bfp; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbr = i0_dec_io_out_zbr; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbr = _T_79 ? 1'h0 : i0_dp_raw_zbr; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_crc32c_w = i0_dec_io_out_crc32c_w; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_crc32c_h = i0_dec_io_out_crc32c_h; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_crc32c_b = i0_dec_io_out_crc32c_b; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_crc32_w = i0_dec_io_out_crc32_w; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_crc32_h = i0_dec_io_out_crc32_h; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_crc32_b = i0_dec_io_out_crc32_b; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbp = i0_dec_io_out_zbp; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbp = _T_79 ? 1'h0 : i0_dp_raw_zbp; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_unshfl = i0_dec_io_out_unshfl; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_shfl = i0_dec_io_out_shfl; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbc = i0_dec_io_out_zbc; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbc = _T_79 ? 1'h0 : i0_dp_raw_zbc; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_clmulr = i0_dec_io_out_clmulr; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_clmulh = i0_dec_io_out_clmulh; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_clmul = i0_dec_io_out_clmul; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbe = i0_dec_io_out_zbe; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbe = _T_79 ? 1'h0 : i0_dp_raw_zbe; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_bdep = i0_dec_io_out_bdep; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_bext = i0_dec_io_out_bext; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbs = i0_dec_io_out_zbs; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbs = _T_79 ? 1'h0 : i0_dp_raw_zbs; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_sbext = i0_dec_io_out_sbext; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sbinv = i0_dec_io_out_sbinv; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sbclr = i0_dec_io_out_sbclr; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sbset = i0_dec_io_out_sbset; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_zbb = i0_dec_io_out_zbb; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_zbb = _T_79 ? 1'h0 : i0_dp_raw_zbb; // @[dec_decode_ctl.scala 280:50]
  wire  i0_dp_raw_gorc = i0_dec_io_out_gorc; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_grev = i0_dec_io_out_grev; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_ror = i0_dec_io_out_ror; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_rol = i0_dec_io_out_rol; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_packh = i0_dec_io_out_packh; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_packu = i0_dec_io_out_packu; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_pack = i0_dec_io_out_pack; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_max = i0_dec_io_out_max; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_min = i0_dec_io_out_min; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sro = i0_dec_io_out_sro; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_slo = i0_dec_io_out_slo; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sext_h = i0_dec_io_out_sext_h; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_sext_b = i0_dec_io_out_sext_b; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_pcnt = i0_dec_io_out_pcnt; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_ctz = i0_dec_io_out_ctz; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_dp_raw_clz = i0_dec_io_out_clz; // @[dec_decode_ctl.scala 146:37 dec_decode_ctl.scala 440:12]
  wire  i0_pcall = i0_dp_jal & i0_pcall_case; // @[dec_decode_ctl.scala 456:38]
  wire  _T_82 = i0_dp_condbr | i0_pcall; // @[dec_decode_ctl.scala 294:54]
  wire  i0_pja = i0_dp_jal & i0_pja_case; // @[dec_decode_ctl.scala 458:38]
  wire  _T_83 = _T_82 | i0_pja; // @[dec_decode_ctl.scala 294:65]
  wire  i0_pret = i0_dp_jal & i0_pret_case; // @[dec_decode_ctl.scala 463:32]
  wire  i0_predict_br = _T_83 | i0_pret; // @[dec_decode_ctl.scala 294:74]
  wire  _T_85 = io_dec_i0_brp_bits_hist[1] & i0_brp_valid; // @[dec_decode_ctl.scala 295:69]
  wire  _T_86 = ~_T_85; // @[dec_decode_ctl.scala 295:40]
  wire  i0_ap_pc2 = ~io_dec_i0_pc4_d; // @[dec_decode_ctl.scala 297:40]
  wire  cam_data_reset = io_dctl_busbuff_lsu_nonblock_load_data_valid | io_dctl_busbuff_lsu_nonblock_load_data_error; // @[dec_decode_ctl.scala 356:76]
  reg [2:0] cam_raw_0_bits_tag; // @[lib.scala 474:26]
  wire [2:0] _GEN_168 = {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_data_tag}; // @[dec_decode_ctl.scala 367:67]
  wire  _T_132 = _GEN_168 == cam_raw_0_bits_tag; // @[dec_decode_ctl.scala 367:67]
  wire  _T_133 = cam_data_reset & _T_132; // @[dec_decode_ctl.scala 367:45]
  reg  cam_raw_0_valid; // @[lib.scala 474:26]
  wire  cam_data_reset_val_0 = _T_133 & cam_raw_0_valid; // @[dec_decode_ctl.scala 367:88]
  wire  cam_0_valid = cam_data_reset_val_0 ? 1'h0 : cam_raw_0_valid; // @[dec_decode_ctl.scala 371:39]
  wire  _T_89 = ~cam_0_valid; // @[dec_decode_ctl.scala 348:78]
  reg [2:0] cam_raw_1_bits_tag; // @[lib.scala 474:26]
  wire  _T_168 = _GEN_168 == cam_raw_1_bits_tag; // @[dec_decode_ctl.scala 367:67]
  wire  _T_169 = cam_data_reset & _T_168; // @[dec_decode_ctl.scala 367:45]
  reg  cam_raw_1_valid; // @[lib.scala 474:26]
  wire  cam_data_reset_val_1 = _T_169 & cam_raw_1_valid; // @[dec_decode_ctl.scala 367:88]
  wire  cam_1_valid = cam_data_reset_val_1 ? 1'h0 : cam_raw_1_valid; // @[dec_decode_ctl.scala 371:39]
  wire  _T_92 = ~cam_1_valid; // @[dec_decode_ctl.scala 348:78]
  wire  _T_95 = cam_0_valid & _T_92; // @[dec_decode_ctl.scala 348:126]
  wire [1:0] _T_97 = {io_dctl_busbuff_lsu_nonblock_load_valid_m, 1'h0}; // @[dec_decode_ctl.scala 348:158]
  reg [2:0] cam_raw_2_bits_tag; // @[lib.scala 474:26]
  wire  _T_204 = _GEN_168 == cam_raw_2_bits_tag; // @[dec_decode_ctl.scala 367:67]
  wire  _T_205 = cam_data_reset & _T_204; // @[dec_decode_ctl.scala 367:45]
  reg  cam_raw_2_valid; // @[lib.scala 474:26]
  wire  cam_data_reset_val_2 = _T_205 & cam_raw_2_valid; // @[dec_decode_ctl.scala 367:88]
  wire  cam_2_valid = cam_data_reset_val_2 ? 1'h0 : cam_raw_2_valid; // @[dec_decode_ctl.scala 371:39]
  wire  _T_98 = ~cam_2_valid; // @[dec_decode_ctl.scala 348:78]
  wire  _T_101 = cam_0_valid & cam_1_valid; // @[dec_decode_ctl.scala 348:126]
  wire  _T_104 = _T_101 & _T_98; // @[dec_decode_ctl.scala 348:126]
  wire [2:0] _T_106 = {io_dctl_busbuff_lsu_nonblock_load_valid_m, 2'h0}; // @[dec_decode_ctl.scala 348:158]
  reg [2:0] cam_raw_3_bits_tag; // @[lib.scala 474:26]
  wire  _T_240 = _GEN_168 == cam_raw_3_bits_tag; // @[dec_decode_ctl.scala 367:67]
  wire  _T_241 = cam_data_reset & _T_240; // @[dec_decode_ctl.scala 367:45]
  reg  cam_raw_3_valid; // @[lib.scala 474:26]
  wire  cam_data_reset_val_3 = _T_241 & cam_raw_3_valid; // @[dec_decode_ctl.scala 367:88]
  wire  cam_3_valid = cam_data_reset_val_3 ? 1'h0 : cam_raw_3_valid; // @[dec_decode_ctl.scala 371:39]
  wire  _T_107 = ~cam_3_valid; // @[dec_decode_ctl.scala 348:78]
  wire  _T_113 = _T_101 & cam_2_valid; // @[dec_decode_ctl.scala 348:126]
  wire  _T_116 = _T_113 & _T_107; // @[dec_decode_ctl.scala 348:126]
  wire [3:0] _T_118 = {io_dctl_busbuff_lsu_nonblock_load_valid_m, 3'h0}; // @[dec_decode_ctl.scala 348:158]
  wire  _T_119 = _T_89 & io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[Mux.scala 27:72]
  wire [1:0] _T_120 = _T_95 ? _T_97 : 2'h0; // @[Mux.scala 27:72]
  wire [2:0] _T_121 = _T_104 ? _T_106 : 3'h0; // @[Mux.scala 27:72]
  wire [3:0] _T_122 = _T_116 ? _T_118 : 4'h0; // @[Mux.scala 27:72]
  wire [1:0] _GEN_172 = {{1'd0}, _T_119}; // @[Mux.scala 27:72]
  wire [1:0] _T_123 = _GEN_172 | _T_120; // @[Mux.scala 27:72]
  wire [2:0] _GEN_173 = {{1'd0}, _T_123}; // @[Mux.scala 27:72]
  wire [2:0] _T_124 = _GEN_173 | _T_121; // @[Mux.scala 27:72]
  wire [3:0] _GEN_174 = {{1'd0}, _T_124}; // @[Mux.scala 27:72]
  wire [3:0] cam_wen = _GEN_174 | _T_122; // @[Mux.scala 27:72]
  wire  x_d_bits_i0load = _T_970[17]; // @[lib.scala 562:21]
  wire [4:0] nonblock_load_rd = x_d_bits_i0load ? x_d_bits_i0rd : 5'h0; // @[dec_decode_ctl.scala 359:31]
  reg [2:0] _T_930; // @[dec_decode_ctl.scala 764:80]
  wire [3:0] i0_pipe_en = {io_dec_aln_dec_i0_decode_d,_T_930}; // @[Cat.scala 29:58]
  wire  _T_936 = |i0_pipe_en[2:1]; // @[dec_decode_ctl.scala 767:49]
  wire  i0_r_ctl_en = _T_936 | io_clk_override; // @[dec_decode_ctl.scala 767:53]
  reg  nonblock_load_valid_m_delay; // @[Reg.scala 27:20]
  wire  r_d_bits_i0load = _T_1001[17]; // @[lib.scala 562:21]
  wire  i0_load_kill_wen_r = nonblock_load_valid_m_delay & r_d_bits_i0load; // @[dec_decode_ctl.scala 364:56]
  wire [2:0] _GEN_175 = {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_inv_tag_r}; // @[dec_decode_ctl.scala 366:66]
  wire  _T_129 = _GEN_175 == cam_raw_0_bits_tag; // @[dec_decode_ctl.scala 366:66]
  wire  _T_130 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_129; // @[dec_decode_ctl.scala 366:45]
  wire  cam_inv_reset_val_0 = _T_130 & cam_0_valid; // @[dec_decode_ctl.scala 366:87]
  reg [4:0] cam_raw_0_bits_rd; // @[lib.scala 474:26]
  wire  _T_141 = r_d_bits_i0rd == cam_raw_0_bits_rd; // @[dec_decode_ctl.scala 379:85]
  wire  _T_142 = i0_wen_r & _T_141; // @[dec_decode_ctl.scala 379:64]
  reg  cam_raw_0_bits_wb; // @[lib.scala 474:26]
  wire  _T_144 = _T_142 & cam_raw_0_bits_wb; // @[dec_decode_ctl.scala 379:105]
  wire  _T_145 = cam_inv_reset_val_0 | _T_144; // @[dec_decode_ctl.scala 379:44]
  wire  _GEN_97 = _T_145 ? 1'h0 : cam_0_valid; // @[dec_decode_ctl.scala 379:131]
  wire [4:0] _GEN_98 = _T_145 ? 5'h0 : cam_raw_0_bits_rd; // @[dec_decode_ctl.scala 379:131]
  wire [2:0] _GEN_99 = _T_145 ? 3'h0 : cam_raw_0_bits_tag; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_100 = _T_145 ? 1'h0 : cam_raw_0_bits_wb; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_101 = cam_wen[0] | _GEN_97; // @[dec_decode_ctl.scala 374:28]
  wire  _GEN_102 = cam_wen[0] ? 1'h0 : _GEN_100; // @[dec_decode_ctl.scala 374:28]
  wire [2:0] cam_in_0_bits_tag = cam_wen[0] ? {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m} : _GEN_99; // @[dec_decode_ctl.scala 374:28]
  wire [4:0] cam_in_0_bits_rd = cam_wen[0] ? nonblock_load_rd : _GEN_98; // @[dec_decode_ctl.scala 374:28]
  wire  _T_148 = nonblock_load_valid_m_delay & _T_129; // @[dec_decode_ctl.scala 384:44]
  wire  _T_150 = _T_148 & cam_0_valid; // @[dec_decode_ctl.scala 384:113]
  wire  cam_in_0_bits_wb = _T_150 | _GEN_102; // @[dec_decode_ctl.scala 384:135]
  wire  cam_in_0_valid = io_dec_tlu_force_halt ? 1'h0 : _GEN_101; // @[dec_decode_ctl.scala 388:32]
  wire [8:0] _T_153 = {cam_in_0_bits_wb,cam_in_0_bits_tag,cam_in_0_bits_rd}; // @[lib.scala 461:61]
  wire [8:0] _T_155 = {cam_raw_0_bits_wb,cam_raw_0_bits_tag,cam_raw_0_bits_rd}; // @[lib.scala 461:74]
  wire [8:0] _T_156 = _T_153 ^ _T_155; // @[lib.scala 461:68]
  wire  _T_157 = |_T_156; // @[lib.scala 461:82]
  wire  _T_158 = cam_in_0_valid ^ cam_raw_0_valid; // @[lib.scala 461:68]
  wire  _T_159 = |_T_158; // @[lib.scala 461:82]
  wire  nonblock_load_write_0 = _T_132 & cam_raw_0_valid; // @[dec_decode_ctl.scala 393:71]
  wire  _T_165 = _GEN_175 == cam_raw_1_bits_tag; // @[dec_decode_ctl.scala 366:66]
  wire  _T_166 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_165; // @[dec_decode_ctl.scala 366:45]
  wire  cam_inv_reset_val_1 = _T_166 & cam_1_valid; // @[dec_decode_ctl.scala 366:87]
  reg [4:0] cam_raw_1_bits_rd; // @[lib.scala 474:26]
  wire  _T_177 = r_d_bits_i0rd == cam_raw_1_bits_rd; // @[dec_decode_ctl.scala 379:85]
  wire  _T_178 = i0_wen_r & _T_177; // @[dec_decode_ctl.scala 379:64]
  reg  cam_raw_1_bits_wb; // @[lib.scala 474:26]
  wire  _T_180 = _T_178 & cam_raw_1_bits_wb; // @[dec_decode_ctl.scala 379:105]
  wire  _T_181 = cam_inv_reset_val_1 | _T_180; // @[dec_decode_ctl.scala 379:44]
  wire  _GEN_108 = _T_181 ? 1'h0 : cam_1_valid; // @[dec_decode_ctl.scala 379:131]
  wire [4:0] _GEN_109 = _T_181 ? 5'h0 : cam_raw_1_bits_rd; // @[dec_decode_ctl.scala 379:131]
  wire [2:0] _GEN_110 = _T_181 ? 3'h0 : cam_raw_1_bits_tag; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_111 = _T_181 ? 1'h0 : cam_raw_1_bits_wb; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_112 = cam_wen[1] | _GEN_108; // @[dec_decode_ctl.scala 374:28]
  wire  _GEN_113 = cam_wen[1] ? 1'h0 : _GEN_111; // @[dec_decode_ctl.scala 374:28]
  wire [2:0] cam_in_1_bits_tag = cam_wen[1] ? {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m} : _GEN_110; // @[dec_decode_ctl.scala 374:28]
  wire [4:0] cam_in_1_bits_rd = cam_wen[1] ? nonblock_load_rd : _GEN_109; // @[dec_decode_ctl.scala 374:28]
  wire  _T_184 = nonblock_load_valid_m_delay & _T_165; // @[dec_decode_ctl.scala 384:44]
  wire  _T_186 = _T_184 & cam_1_valid; // @[dec_decode_ctl.scala 384:113]
  wire  cam_in_1_bits_wb = _T_186 | _GEN_113; // @[dec_decode_ctl.scala 384:135]
  wire  cam_in_1_valid = io_dec_tlu_force_halt ? 1'h0 : _GEN_112; // @[dec_decode_ctl.scala 388:32]
  wire [8:0] _T_189 = {cam_in_1_bits_wb,cam_in_1_bits_tag,cam_in_1_bits_rd}; // @[lib.scala 461:61]
  wire [8:0] _T_191 = {cam_raw_1_bits_wb,cam_raw_1_bits_tag,cam_raw_1_bits_rd}; // @[lib.scala 461:74]
  wire [8:0] _T_192 = _T_189 ^ _T_191; // @[lib.scala 461:68]
  wire  _T_193 = |_T_192; // @[lib.scala 461:82]
  wire  _T_194 = cam_in_1_valid ^ cam_raw_1_valid; // @[lib.scala 461:68]
  wire  _T_195 = |_T_194; // @[lib.scala 461:82]
  wire  nonblock_load_write_1 = _T_168 & cam_raw_1_valid; // @[dec_decode_ctl.scala 393:71]
  wire  _T_201 = _GEN_175 == cam_raw_2_bits_tag; // @[dec_decode_ctl.scala 366:66]
  wire  _T_202 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_201; // @[dec_decode_ctl.scala 366:45]
  wire  cam_inv_reset_val_2 = _T_202 & cam_2_valid; // @[dec_decode_ctl.scala 366:87]
  reg [4:0] cam_raw_2_bits_rd; // @[lib.scala 474:26]
  wire  _T_213 = r_d_bits_i0rd == cam_raw_2_bits_rd; // @[dec_decode_ctl.scala 379:85]
  wire  _T_214 = i0_wen_r & _T_213; // @[dec_decode_ctl.scala 379:64]
  reg  cam_raw_2_bits_wb; // @[lib.scala 474:26]
  wire  _T_216 = _T_214 & cam_raw_2_bits_wb; // @[dec_decode_ctl.scala 379:105]
  wire  _T_217 = cam_inv_reset_val_2 | _T_216; // @[dec_decode_ctl.scala 379:44]
  wire  _GEN_119 = _T_217 ? 1'h0 : cam_2_valid; // @[dec_decode_ctl.scala 379:131]
  wire [4:0] _GEN_120 = _T_217 ? 5'h0 : cam_raw_2_bits_rd; // @[dec_decode_ctl.scala 379:131]
  wire [2:0] _GEN_121 = _T_217 ? 3'h0 : cam_raw_2_bits_tag; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_122 = _T_217 ? 1'h0 : cam_raw_2_bits_wb; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_123 = cam_wen[2] | _GEN_119; // @[dec_decode_ctl.scala 374:28]
  wire  _GEN_124 = cam_wen[2] ? 1'h0 : _GEN_122; // @[dec_decode_ctl.scala 374:28]
  wire [2:0] cam_in_2_bits_tag = cam_wen[2] ? {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m} : _GEN_121; // @[dec_decode_ctl.scala 374:28]
  wire [4:0] cam_in_2_bits_rd = cam_wen[2] ? nonblock_load_rd : _GEN_120; // @[dec_decode_ctl.scala 374:28]
  wire  _T_220 = nonblock_load_valid_m_delay & _T_201; // @[dec_decode_ctl.scala 384:44]
  wire  _T_222 = _T_220 & cam_2_valid; // @[dec_decode_ctl.scala 384:113]
  wire  cam_in_2_bits_wb = _T_222 | _GEN_124; // @[dec_decode_ctl.scala 384:135]
  wire  cam_in_2_valid = io_dec_tlu_force_halt ? 1'h0 : _GEN_123; // @[dec_decode_ctl.scala 388:32]
  wire [8:0] _T_225 = {cam_in_2_bits_wb,cam_in_2_bits_tag,cam_in_2_bits_rd}; // @[lib.scala 461:61]
  wire [8:0] _T_227 = {cam_raw_2_bits_wb,cam_raw_2_bits_tag,cam_raw_2_bits_rd}; // @[lib.scala 461:74]
  wire [8:0] _T_228 = _T_225 ^ _T_227; // @[lib.scala 461:68]
  wire  _T_229 = |_T_228; // @[lib.scala 461:82]
  wire  _T_230 = cam_in_2_valid ^ cam_raw_2_valid; // @[lib.scala 461:68]
  wire  _T_231 = |_T_230; // @[lib.scala 461:82]
  wire  nonblock_load_write_2 = _T_204 & cam_raw_2_valid; // @[dec_decode_ctl.scala 393:71]
  wire  _T_237 = _GEN_175 == cam_raw_3_bits_tag; // @[dec_decode_ctl.scala 366:66]
  wire  _T_238 = io_dctl_busbuff_lsu_nonblock_load_inv_r & _T_237; // @[dec_decode_ctl.scala 366:45]
  wire  cam_inv_reset_val_3 = _T_238 & cam_3_valid; // @[dec_decode_ctl.scala 366:87]
  reg [4:0] cam_raw_3_bits_rd; // @[lib.scala 474:26]
  wire  _T_249 = r_d_bits_i0rd == cam_raw_3_bits_rd; // @[dec_decode_ctl.scala 379:85]
  wire  _T_250 = i0_wen_r & _T_249; // @[dec_decode_ctl.scala 379:64]
  reg  cam_raw_3_bits_wb; // @[lib.scala 474:26]
  wire  _T_252 = _T_250 & cam_raw_3_bits_wb; // @[dec_decode_ctl.scala 379:105]
  wire  _T_253 = cam_inv_reset_val_3 | _T_252; // @[dec_decode_ctl.scala 379:44]
  wire  _GEN_130 = _T_253 ? 1'h0 : cam_3_valid; // @[dec_decode_ctl.scala 379:131]
  wire [4:0] _GEN_131 = _T_253 ? 5'h0 : cam_raw_3_bits_rd; // @[dec_decode_ctl.scala 379:131]
  wire [2:0] _GEN_132 = _T_253 ? 3'h0 : cam_raw_3_bits_tag; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_133 = _T_253 ? 1'h0 : cam_raw_3_bits_wb; // @[dec_decode_ctl.scala 379:131]
  wire  _GEN_134 = cam_wen[3] | _GEN_130; // @[dec_decode_ctl.scala 374:28]
  wire  _GEN_135 = cam_wen[3] ? 1'h0 : _GEN_133; // @[dec_decode_ctl.scala 374:28]
  wire [2:0] cam_in_3_bits_tag = cam_wen[3] ? {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m} : _GEN_132; // @[dec_decode_ctl.scala 374:28]
  wire [4:0] cam_in_3_bits_rd = cam_wen[3] ? nonblock_load_rd : _GEN_131; // @[dec_decode_ctl.scala 374:28]
  wire  _T_256 = nonblock_load_valid_m_delay & _T_237; // @[dec_decode_ctl.scala 384:44]
  wire  _T_258 = _T_256 & cam_3_valid; // @[dec_decode_ctl.scala 384:113]
  wire  cam_in_3_bits_wb = _T_258 | _GEN_135; // @[dec_decode_ctl.scala 384:135]
  wire  cam_in_3_valid = io_dec_tlu_force_halt ? 1'h0 : _GEN_134; // @[dec_decode_ctl.scala 388:32]
  wire [8:0] _T_261 = {cam_in_3_bits_wb,cam_in_3_bits_tag,cam_in_3_bits_rd}; // @[lib.scala 461:61]
  wire [8:0] _T_263 = {cam_raw_3_bits_wb,cam_raw_3_bits_tag,cam_raw_3_bits_rd}; // @[lib.scala 461:74]
  wire [8:0] _T_264 = _T_261 ^ _T_263; // @[lib.scala 461:68]
  wire  _T_265 = |_T_264; // @[lib.scala 461:82]
  wire  _T_266 = cam_in_3_valid ^ cam_raw_3_valid; // @[lib.scala 461:68]
  wire  _T_267 = |_T_266; // @[lib.scala 461:82]
  wire  nonblock_load_write_3 = _T_240 & cam_raw_3_valid; // @[dec_decode_ctl.scala 393:71]
  wire  _T_273 = r_d_bits_i0rd == io_dec_nonblock_load_waddr; // @[dec_decode_ctl.scala 398:49]
  wire  nonblock_load_cancel = _T_273 & i0_wen_r; // @[dec_decode_ctl.scala 398:81]
  wire  _T_274 = nonblock_load_write_0 | nonblock_load_write_1; // @[dec_decode_ctl.scala 399:108]
  wire  _T_275 = _T_274 | nonblock_load_write_2; // @[dec_decode_ctl.scala 399:108]
  wire  _T_276 = _T_275 | nonblock_load_write_3; // @[dec_decode_ctl.scala 399:108]
  wire  _T_278 = io_dctl_busbuff_lsu_nonblock_load_data_valid & _T_276; // @[dec_decode_ctl.scala 399:77]
  wire  _T_279 = ~nonblock_load_cancel; // @[dec_decode_ctl.scala 399:122]
  wire  _T_281 = nonblock_load_rd == i0r_rs1; // @[dec_decode_ctl.scala 400:54]
  wire  _T_282 = _T_281 & io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[dec_decode_ctl.scala 400:66]
  wire  _T_283 = _T_282 & io_decode_exu_dec_i0_rs1_en_d; // @[dec_decode_ctl.scala 400:110]
  wire [4:0] i0r_rs2 = io_dec_i0_instr_d[24:20]; // @[dec_decode_ctl.scala 677:16]
  wire  _T_284 = nonblock_load_rd == i0r_rs2; // @[dec_decode_ctl.scala 400:161]
  wire  _T_285 = _T_284 & io_dctl_busbuff_lsu_nonblock_load_valid_m; // @[dec_decode_ctl.scala 400:173]
  wire  _T_286 = _T_285 & io_decode_exu_dec_i0_rs2_en_d; // @[dec_decode_ctl.scala 400:217]
  wire  i0_nonblock_boundary_stall = _T_283 | _T_286; // @[dec_decode_ctl.scala 400:142]
  wire [4:0] _T_288 = nonblock_load_write_0 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_289 = _T_288 & cam_raw_0_bits_rd; // @[dec_decode_ctl.scala 404:88]
  wire  _T_290 = io_decode_exu_dec_i0_rs1_en_d & cam_0_valid; // @[dec_decode_ctl.scala 404:137]
  wire  _T_291 = cam_raw_0_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 404:170]
  wire  _T_292 = _T_290 & _T_291; // @[dec_decode_ctl.scala 404:152]
  wire  _T_293 = io_decode_exu_dec_i0_rs2_en_d & cam_0_valid; // @[dec_decode_ctl.scala 404:214]
  wire  _T_294 = cam_raw_0_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 404:247]
  wire  _T_295 = _T_293 & _T_294; // @[dec_decode_ctl.scala 404:229]
  wire [4:0] _T_297 = nonblock_load_write_1 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_298 = _T_297 & cam_raw_1_bits_rd; // @[dec_decode_ctl.scala 404:88]
  wire  _T_299 = io_decode_exu_dec_i0_rs1_en_d & cam_1_valid; // @[dec_decode_ctl.scala 404:137]
  wire  _T_300 = cam_raw_1_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 404:170]
  wire  _T_301 = _T_299 & _T_300; // @[dec_decode_ctl.scala 404:152]
  wire  _T_302 = io_decode_exu_dec_i0_rs2_en_d & cam_1_valid; // @[dec_decode_ctl.scala 404:214]
  wire  _T_303 = cam_raw_1_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 404:247]
  wire  _T_304 = _T_302 & _T_303; // @[dec_decode_ctl.scala 404:229]
  wire [4:0] _T_306 = nonblock_load_write_2 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_307 = _T_306 & cam_raw_2_bits_rd; // @[dec_decode_ctl.scala 404:88]
  wire  _T_308 = io_decode_exu_dec_i0_rs1_en_d & cam_2_valid; // @[dec_decode_ctl.scala 404:137]
  wire  _T_309 = cam_raw_2_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 404:170]
  wire  _T_310 = _T_308 & _T_309; // @[dec_decode_ctl.scala 404:152]
  wire  _T_311 = io_decode_exu_dec_i0_rs2_en_d & cam_2_valid; // @[dec_decode_ctl.scala 404:214]
  wire  _T_312 = cam_raw_2_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 404:247]
  wire  _T_313 = _T_311 & _T_312; // @[dec_decode_ctl.scala 404:229]
  wire [4:0] _T_315 = nonblock_load_write_3 ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [4:0] _T_316 = _T_315 & cam_raw_3_bits_rd; // @[dec_decode_ctl.scala 404:88]
  wire  _T_317 = io_decode_exu_dec_i0_rs1_en_d & cam_3_valid; // @[dec_decode_ctl.scala 404:137]
  wire  _T_318 = cam_raw_3_bits_rd == i0r_rs1; // @[dec_decode_ctl.scala 404:170]
  wire  _T_319 = _T_317 & _T_318; // @[dec_decode_ctl.scala 404:152]
  wire  _T_320 = io_decode_exu_dec_i0_rs2_en_d & cam_3_valid; // @[dec_decode_ctl.scala 404:214]
  wire  _T_321 = cam_raw_3_bits_rd == i0r_rs2; // @[dec_decode_ctl.scala 404:247]
  wire  _T_322 = _T_320 & _T_321; // @[dec_decode_ctl.scala 404:229]
  wire [4:0] _T_323 = _T_289 | _T_298; // @[dec_decode_ctl.scala 405:69]
  wire [4:0] _T_324 = _T_323 | _T_307; // @[dec_decode_ctl.scala 405:69]
  wire  _T_325 = _T_292 | _T_301; // @[dec_decode_ctl.scala 405:102]
  wire  _T_326 = _T_325 | _T_310; // @[dec_decode_ctl.scala 405:102]
  wire  ld_stall_1 = _T_326 | _T_319; // @[dec_decode_ctl.scala 405:102]
  wire  _T_327 = _T_295 | _T_304; // @[dec_decode_ctl.scala 405:134]
  wire  _T_328 = _T_327 | _T_313; // @[dec_decode_ctl.scala 405:134]
  wire  ld_stall_2 = _T_328 | _T_322; // @[dec_decode_ctl.scala 405:134]
  wire  _T_329 = ld_stall_1 | ld_stall_2; // @[dec_decode_ctl.scala 407:38]
  wire  i0_nonblock_load_stall = _T_329 | i0_nonblock_boundary_stall; // @[dec_decode_ctl.scala 407:51]
  wire  _T_331 = ~i0_predict_br; // @[dec_decode_ctl.scala 416:34]
  wire [3:0] _T_333 = i0_legal_decode_d ? 4'hf : 4'h0; // @[Bitwise.scala 72:12]
  wire  csr_read = i0_dp_csr_read & i0_legal_decode_d; // @[dec_decode_ctl.scala 517:36]
  wire  _T_334 = csr_read & io_dec_csr_wen_unq_d; // @[dec_decode_ctl.scala 428:16]
  wire  _T_336 = ~csr_read; // @[dec_decode_ctl.scala 429:6]
  wire  _T_337 = _T_336 & io_dec_csr_wen_unq_d; // @[dec_decode_ctl.scala 429:16]
  wire  _T_339 = ~io_dec_csr_wen_unq_d; // @[dec_decode_ctl.scala 430:18]
  wire  _T_340 = csr_read & _T_339; // @[dec_decode_ctl.scala 430:16]
  wire  _T_342 = i0_dp_zbb | i0_dp_zbs; // @[dec_decode_ctl.scala 431:16]
  wire  _T_343 = _T_342 | i0_dp_zbe; // @[dec_decode_ctl.scala 431:28]
  wire  _T_344 = _T_343 | i0_dp_zbc; // @[dec_decode_ctl.scala 431:40]
  wire  _T_345 = _T_344 | i0_dp_zbp; // @[dec_decode_ctl.scala 431:52]
  wire  _T_346 = _T_345 | i0_dp_zbr; // @[dec_decode_ctl.scala 431:65]
  wire  _T_347 = _T_346 | i0_dp_zbf; // @[dec_decode_ctl.scala 431:77]
  wire  _T_348 = _T_347 | i0_dp_zba; // @[dec_decode_ctl.scala 431:89]
  wire [3:0] _T_349 = i0_dp_mul ? 4'h1 : 4'h0; // @[Mux.scala 98:16]
  wire [3:0] _T_350 = i0_dp_load ? 4'h2 : _T_349; // @[Mux.scala 98:16]
  wire [3:0] _T_351 = i0_dp_store ? 4'h3 : _T_350; // @[Mux.scala 98:16]
  wire [3:0] _T_352 = i0_dp_pm_alu ? 4'h4 : _T_351; // @[Mux.scala 98:16]
  wire [3:0] _T_353 = _T_348 ? 4'hf : _T_352; // @[Mux.scala 98:16]
  wire [3:0] _T_354 = _T_340 ? 4'h5 : _T_353; // @[Mux.scala 98:16]
  wire [3:0] _T_355 = _T_337 ? 4'h6 : _T_354; // @[Mux.scala 98:16]
  wire [3:0] _T_356 = _T_334 ? 4'h7 : _T_355; // @[Mux.scala 98:16]
  wire [3:0] _T_357 = i0_dp_ebreak ? 4'h8 : _T_356; // @[Mux.scala 98:16]
  wire [3:0] _T_358 = i0_dp_ecall ? 4'h9 : _T_357; // @[Mux.scala 98:16]
  wire [3:0] _T_359 = i0_dp_fence ? 4'ha : _T_358; // @[Mux.scala 98:16]
  wire [3:0] _T_360 = i0_dp_fence_i ? 4'hb : _T_359; // @[Mux.scala 98:16]
  wire [3:0] _T_361 = i0_dp_mret ? 4'hc : _T_360; // @[Mux.scala 98:16]
  wire [3:0] _T_362 = i0_dp_condbr ? 4'hd : _T_361; // @[Mux.scala 98:16]
  wire [3:0] _T_363 = i0_dp_jal ? 4'he : _T_362; // @[Mux.scala 98:16]
  reg  lsu_idle; // @[dec_decode_ctl.scala 442:45]
  wire  _T_417 = ~i0_pcall_case; // @[dec_decode_ctl.scala 464:35]
  wire  _T_418 = i0_dp_jal & _T_417; // @[dec_decode_ctl.scala 464:32]
  wire  _T_419 = ~i0_pja_case; // @[dec_decode_ctl.scala 464:52]
  wire  _T_420 = _T_418 & _T_419; // @[dec_decode_ctl.scala 464:50]
  wire  _T_421 = ~i0_pret_case; // @[dec_decode_ctl.scala 464:67]
  wire  _T_424 = i0r_rs1 == 5'h2; // @[dec_decode_ctl.scala 508:41]
  wire  lsu_decode_d = i0_legal_decode_d & i0_dp_lsu; // @[dec_decode_ctl.scala 633:40]
  wire  _T_1201 = i0_dp_load | i0_dp_store; // @[dec_decode_ctl.scala 901:43]
  wire  x_d_bits_i0v = _T_970[14]; // @[lib.scala 562:21]
  wire  _T_1175 = io_decode_exu_dec_i0_rs1_en_d & x_d_bits_i0v; // @[dec_decode_ctl.scala 881:59]
  wire  _T_1176 = x_d_bits_i0rd == i0r_rs1; // @[dec_decode_ctl.scala 881:91]
  wire  i0_rs1_depend_i0_x = _T_1175 & _T_1176; // @[dec_decode_ctl.scala 881:74]
  wire  _T_1177 = io_decode_exu_dec_i0_rs1_en_d & r_d_bits_i0v; // @[dec_decode_ctl.scala 882:59]
  wire  _T_1178 = r_d_bits_i0rd == i0r_rs1; // @[dec_decode_ctl.scala 882:91]
  wire  i0_rs1_depend_i0_r = _T_1177 & _T_1178; // @[dec_decode_ctl.scala 882:74]
  wire [1:0] _T_1190 = i0_rs1_depend_i0_r ? 2'h2 : 2'h0; // @[dec_decode_ctl.scala 888:63]
  wire [1:0] i0_rs1_depth_d = i0_rs1_depend_i0_x ? 2'h1 : _T_1190; // @[dec_decode_ctl.scala 888:24]
  wire  _T_1203 = _T_1201 & i0_rs1_depth_d[0]; // @[dec_decode_ctl.scala 901:58]
  reg  i0_x_c_load; // @[Reg.scala 27:20]
  reg  i0_r_c_load; // @[Reg.scala 27:20]
  wire  _T_1186_load = i0_rs1_depend_i0_r & i0_r_c_load; // @[dec_decode_ctl.scala 887:61]
  wire  i0_rs1_class_d_load = i0_rs1_depend_i0_x ? i0_x_c_load : _T_1186_load; // @[dec_decode_ctl.scala 887:24]
  wire  load_ldst_bypass_d = _T_1203 & i0_rs1_class_d_load; // @[dec_decode_ctl.scala 901:78]
  wire  _T_1179 = io_decode_exu_dec_i0_rs2_en_d & x_d_bits_i0v; // @[dec_decode_ctl.scala 884:59]
  wire  _T_1180 = x_d_bits_i0rd == i0r_rs2; // @[dec_decode_ctl.scala 884:91]
  wire  i0_rs2_depend_i0_x = _T_1179 & _T_1180; // @[dec_decode_ctl.scala 884:74]
  wire  _T_1181 = io_decode_exu_dec_i0_rs2_en_d & r_d_bits_i0v; // @[dec_decode_ctl.scala 885:59]
  wire  _T_1182 = r_d_bits_i0rd == i0r_rs2; // @[dec_decode_ctl.scala 885:91]
  wire  i0_rs2_depend_i0_r = _T_1181 & _T_1182; // @[dec_decode_ctl.scala 885:74]
  wire [1:0] _T_1199 = i0_rs2_depend_i0_r ? 2'h2 : 2'h0; // @[dec_decode_ctl.scala 890:63]
  wire [1:0] i0_rs2_depth_d = i0_rs2_depend_i0_x ? 2'h1 : _T_1199; // @[dec_decode_ctl.scala 890:24]
  wire  _T_1206 = i0_dp_store & i0_rs2_depth_d[0]; // @[dec_decode_ctl.scala 902:43]
  wire  _T_1195_load = i0_rs2_depend_i0_r & i0_r_c_load; // @[dec_decode_ctl.scala 889:61]
  wire  i0_rs2_class_d_load = i0_rs2_depend_i0_x ? i0_x_c_load : _T_1195_load; // @[dec_decode_ctl.scala 889:24]
  wire  store_data_bypass_d = _T_1206 & i0_rs2_class_d_load; // @[dec_decode_ctl.scala 902:63]
  wire  _T_434 = i0_dp_csr_clr | i0_dp_csr_set; // @[dec_decode_ctl.scala 525:42]
  wire  _T_435 = _T_434 | i0_csr_write; // @[dec_decode_ctl.scala 525:58]
  wire [11:0] _T_439 = io_dec_csr_any_unq_d ? 12'hfff : 12'h0; // @[Bitwise.scala 72:12]
  wire  r_d_bits_csrwen = _T_1001[13]; // @[lib.scala 562:21]
  wire  _T_442 = r_d_bits_csrwen & r_d_valid; // @[dec_decode_ctl.scala 530:53]
  wire [11:0] _T_444 = _T_442 ? 12'hfff : 12'h0; // @[Bitwise.scala 72:12]
  wire [11:0] r_d_bits_csrwaddr = _T_1001[11:0]; // @[lib.scala 562:21]
  wire  _T_449 = r_d_bits_csrwaddr == 12'h300; // @[dec_decode_ctl.scala 537:50]
  wire  _T_450 = r_d_bits_csrwaddr == 12'h304; // @[dec_decode_ctl.scala 537:85]
  wire  _T_451 = _T_449 | _T_450; // @[dec_decode_ctl.scala 537:64]
  wire  _T_452 = _T_451 & r_d_bits_csrwen; // @[dec_decode_ctl.scala 537:100]
  wire  _T_453 = _T_452 & r_d_valid; // @[dec_decode_ctl.scala 537:118]
  wire  _T_454 = ~io_dec_tlu_i0_kill_writeb_wb; // @[dec_decode_ctl.scala 537:132]
  reg  csr_read_x; // @[dec_decode_ctl.scala 539:52]
  reg  csr_clr_x; // @[dec_decode_ctl.scala 540:51]
  reg  csr_set_x; // @[dec_decode_ctl.scala 541:51]
  reg  csr_write_x; // @[dec_decode_ctl.scala 542:53]
  reg  csr_imm_x; // @[dec_decode_ctl.scala 543:51]
  wire  i0_x_data_en = i0_pipe_en[3] | io_clk_override; // @[dec_decode_ctl.scala 769:50]
  reg [4:0] csrimm_x; // @[lib.scala 401:18]
  reg [31:0] csr_rddata_x; // @[lib.scala 401:18]
  wire [31:0] _T_488 = {27'h0,csrimm_x}; // @[Cat.scala 29:58]
  wire  _T_490 = ~csr_imm_x; // @[dec_decode_ctl.scala 551:5]
  wire [31:0] _T_491 = csr_imm_x ? _T_488 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_492 = _T_490 ? io_decode_exu_exu_csr_rs1_x : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] csr_mask_x = _T_491 | _T_492; // @[Mux.scala 27:72]
  wire [31:0] _T_494 = ~csr_mask_x; // @[dec_decode_ctl.scala 554:38]
  wire [31:0] _T_495 = csr_rddata_x & _T_494; // @[dec_decode_ctl.scala 554:35]
  wire [31:0] _T_496 = csr_rddata_x | csr_mask_x; // @[dec_decode_ctl.scala 555:35]
  wire [31:0] _T_497 = csr_clr_x ? _T_495 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_498 = csr_set_x ? _T_496 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_499 = csr_write_x ? csr_mask_x : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_500 = _T_497 | _T_498; // @[Mux.scala 27:72]
  wire [31:0] write_csr_data_x = _T_500 | _T_499; // @[Mux.scala 27:72]
  wire  _T_512 = ~tlu_wr_pause_r1; // @[dec_decode_ctl.scala 562:44]
  wire  _T_513 = ~tlu_wr_pause_r2; // @[dec_decode_ctl.scala 562:64]
  wire  _T_514 = _T_512 & _T_513; // @[dec_decode_ctl.scala 562:61]
  wire [31:0] _T_517 = write_csr_data - 32'h1; // @[dec_decode_ctl.scala 565:59]
  wire  _T_519 = csr_clr_x | csr_set_x; // @[dec_decode_ctl.scala 567:34]
  wire  _T_520 = _T_519 | csr_write_x; // @[dec_decode_ctl.scala 567:46]
  wire  _T_521 = _T_520 & csr_read_x; // @[dec_decode_ctl.scala 567:61]
  wire  _T_522 = _T_521 | io_dec_tlu_wr_pause_r; // @[dec_decode_ctl.scala 567:75]
  wire  r_d_bits_csrwonly = _T_1001[12]; // @[lib.scala 562:21]
  wire  _T_524 = r_d_bits_csrwonly & r_d_valid; // @[dec_decode_ctl.scala 574:50]
  wire  _T_1056 = r_d_bits_i0v & r_d_bits_i0load; // @[dec_decode_ctl.scala 822:42]
  reg [31:0] i0_result_r_raw; // @[lib.scala 401:18]
  wire [31:0] i0_result_corr_r = _T_1056 ? io_lsu_result_corr_r : i0_result_r_raw; // @[dec_decode_ctl.scala 822:27]
  wire  x_d_bits_csrwonly = _T_970[12]; // @[lib.scala 562:21]
  wire  _T_527 = x_d_bits_csrwonly | r_d_bits_csrwonly; // @[dec_decode_ctl.scala 576:43]
  reg  _T_1029; // @[lib.scala 401:18]
  reg [22:0] _T_1028; // @[lib.scala 401:18]
  wire [23:0] _T_1032 = {_T_1029,_T_1028}; // @[lib.scala 562:21]
  wire  wbd_bits_csrwonly = _T_1032[12]; // @[lib.scala 562:21]
  wire  prior_csr_write = _T_527 | wbd_bits_csrwonly; // @[dec_decode_ctl.scala 576:63]
  wire  debug_fence_raw = io_dec_debug_fence_d & io_dbg_dctl_dbg_cmd_wrdata[1]; // @[dec_decode_ctl.scala 579:48]
  wire  debug_fence = debug_fence_raw | debug_fence_i; // @[dec_decode_ctl.scala 580:40]
  wire  _T_531 = i0_dp_presync | io_dec_tlu_presync_d; // @[dec_decode_ctl.scala 583:34]
  wire  _T_532 = _T_531 | debug_fence_i; // @[dec_decode_ctl.scala 583:57]
  wire  _T_533 = _T_532 | debug_fence_raw; // @[dec_decode_ctl.scala 583:73]
  wire  i0_presync = _T_533 | io_dec_tlu_pipelining_disable; // @[dec_decode_ctl.scala 583:91]
  wire [31:0] _T_557 = {16'h0,io_dec_aln_ifu_i0_cinst}; // @[Cat.scala 29:58]
  wire  _T_559 = ~illegal_lockout; // @[dec_decode_ctl.scala 595:44]
  reg [31:0] _T_560; // @[lib.scala 401:18]
  wire  i0_div_prior_div_stall = i0_dp_div & io_dec_div_active; // @[dec_decode_ctl.scala 598:42]
  wire  _T_564 = i0_dp_csr_read & prior_csr_write; // @[dec_decode_ctl.scala 600:40]
  wire  _T_565 = _T_564 | io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 600:59]
  wire  _T_566 = _T_565 | pause_stall; // @[dec_decode_ctl.scala 600:92]
  wire  _T_567 = _T_566 | leak1_i0_stall; // @[dec_decode_ctl.scala 600:106]
  wire  _T_568 = _T_567 | io_dec_tlu_debug_stall; // @[dec_decode_ctl.scala 601:20]
  wire  _T_569 = _T_568 | postsync_stall; // @[dec_decode_ctl.scala 601:45]
  wire  prior_inflight = x_d_valid | r_d_valid; // @[dec_decode_ctl.scala 623:41]
  wire  prior_inflight_eff = i0_dp_div ? x_d_valid : prior_inflight; // @[dec_decode_ctl.scala 624:31]
  wire  presync_stall = i0_presync & prior_inflight_eff; // @[dec_decode_ctl.scala 626:37]
  wire  _T_570 = _T_569 | presync_stall; // @[dec_decode_ctl.scala 601:62]
  wire  _T_571 = i0_dp_fence | debug_fence; // @[dec_decode_ctl.scala 602:19]
  wire  _T_572 = ~lsu_idle; // @[dec_decode_ctl.scala 602:36]
  wire  _T_573 = _T_571 & _T_572; // @[dec_decode_ctl.scala 602:34]
  wire  _T_574 = _T_570 | _T_573; // @[dec_decode_ctl.scala 601:79]
  wire  _T_575 = _T_574 | i0_nonblock_load_stall; // @[dec_decode_ctl.scala 602:47]
  wire  _T_1114 = io_decode_exu_dec_i0_rs1_en_d & io_dec_div_active; // @[dec_decode_ctl.scala 850:60]
  wire  _T_1115 = io_div_waddr_wb == i0r_rs1; // @[dec_decode_ctl.scala 850:99]
  wire  _T_1116 = _T_1114 & _T_1115; // @[dec_decode_ctl.scala 850:80]
  wire  _T_1117 = io_decode_exu_dec_i0_rs2_en_d & io_dec_div_active; // @[dec_decode_ctl.scala 851:36]
  wire  _T_1118 = io_div_waddr_wb == i0r_rs2; // @[dec_decode_ctl.scala 851:75]
  wire  _T_1119 = _T_1117 & _T_1118; // @[dec_decode_ctl.scala 851:56]
  wire  i0_nonblock_div_stall = _T_1116 | _T_1119; // @[dec_decode_ctl.scala 850:113]
  wire  _T_577 = _T_575 | i0_nonblock_div_stall; // @[dec_decode_ctl.scala 603:21]
  wire  i0_block_raw_d = _T_577 | i0_div_prior_div_stall; // @[dec_decode_ctl.scala 603:45]
  wire  _T_578 = io_lsu_store_stall_any | io_dctl_dma_dma_dccm_stall_any; // @[dec_decode_ctl.scala 605:65]
  wire  i0_store_stall_d = i0_dp_store & _T_578; // @[dec_decode_ctl.scala 605:39]
  wire  _T_579 = io_lsu_load_stall_any | io_dctl_dma_dma_dccm_stall_any; // @[dec_decode_ctl.scala 606:63]
  wire  i0_load_stall_d = i0_dp_load & _T_579; // @[dec_decode_ctl.scala 606:38]
  wire  _T_580 = i0_block_raw_d | i0_store_stall_d; // @[dec_decode_ctl.scala 607:38]
  wire  i0_block_d = _T_580 | i0_load_stall_d; // @[dec_decode_ctl.scala 607:57]
  wire  _T_581 = ~i0_block_d; // @[dec_decode_ctl.scala 611:54]
  wire  _T_582 = io_dec_ib0_valid_d & _T_581; // @[dec_decode_ctl.scala 611:52]
  wire  _T_584 = _T_582 & _T_366; // @[dec_decode_ctl.scala 611:69]
  wire  _T_587 = ~i0_block_raw_d; // @[dec_decode_ctl.scala 612:46]
  wire  _T_588 = io_dec_ib0_valid_d & _T_587; // @[dec_decode_ctl.scala 612:44]
  wire  _T_590 = _T_588 & _T_366; // @[dec_decode_ctl.scala 612:61]
  wire  i0_exudecode_d = _T_590 & _T_562; // @[dec_decode_ctl.scala 612:89]
  wire  i0_exulegal_decode_d = i0_exudecode_d & i0_legal; // @[dec_decode_ctl.scala 613:46]
  wire  _T_592 = ~io_dec_aln_dec_i0_decode_d; // @[dec_decode_ctl.scala 617:51]
  wire  _T_605 = i0_dp_condbr | i0_dp_jal; // @[dec_decode_ctl.scala 631:42]
  wire  d_t_icaf = i0_icaf_d & i0_legal_decode_d; // @[dec_decode_ctl.scala 641:40]
  wire  d_t_icaf_second = io_dec_i0_icaf_second_d & i0_legal_decode_d; // @[dec_decode_ctl.scala 642:58]
  wire  _T_614 = i0_dp_fence_i | debug_fence_i; // @[dec_decode_ctl.scala 645:44]
  wire  d_t_fence_i = _T_614 & i0_legal_decode_d; // @[dec_decode_ctl.scala 645:61]
  wire [3:0] _T_619 = {io_dec_aln_dec_i0_decode_d,io_dec_aln_dec_i0_decode_d,io_dec_aln_dec_i0_decode_d,io_dec_aln_dec_i0_decode_d}; // @[Cat.scala 29:58]
  wire [3:0] d_t_i0trigger = io_dec_i0_trigger_match_d & _T_619; // @[dec_decode_ctl.scala 652:56]
  wire  _T_933 = |i0_pipe_en[3:2]; // @[dec_decode_ctl.scala 766:49]
  wire  i0_x_ctl_en = _T_933 | io_clk_override; // @[dec_decode_ctl.scala 766:53]
  reg  _T_624; // @[lib.scala 401:18]
  reg [3:0] _T_625; // @[lib.scala 401:18]
  reg [3:0] _T_631; // @[lib.scala 401:18]
  wire [3:0] _T_628 = d_t_i0trigger ^ _T_631; // @[lib.scala 515:26]
  wire  _T_629 = |_T_628; // @[lib.scala 515:34]
  reg  _T_637; // @[lib.scala 401:18]
  wire  _T_634 = d_t_fence_i ^ _T_637; // @[lib.scala 515:26]
  wire  _T_635 = |_T_634; // @[lib.scala 515:34]
  reg [1:0] _T_643; // @[lib.scala 401:18]
  wire [1:0] _T_640 = io_dec_i0_icaf_type_d ^ _T_643; // @[lib.scala 515:26]
  wire  _T_641 = |_T_640; // @[lib.scala 515:34]
  reg  _T_649; // @[lib.scala 401:18]
  wire  _T_646 = d_t_icaf_second ^ _T_649; // @[lib.scala 515:26]
  wire  _T_647 = |_T_646; // @[lib.scala 515:34]
  reg  _T_655; // @[lib.scala 401:18]
  wire  _T_652 = d_t_icaf ^ _T_655; // @[lib.scala 515:26]
  wire  _T_653 = |_T_652; // @[lib.scala 515:34]
  reg  _T_661; // @[lib.scala 401:18]
  wire  _T_658 = i0_legal_decode_d ^ _T_661; // @[lib.scala 515:26]
  wire  _T_659 = |_T_658; // @[lib.scala 515:34]
  wire [16:0] _T_672 = {_T_661,_T_655,_T_649,_T_643,_T_637,_T_631,_T_625,_T_624,2'h0}; // @[lib.scala 562:21]
  wire [3:0] x_t_i0trigger = _T_672[10:7]; // @[lib.scala 562:21]
  wire  x_t_fence_i = _T_672[11]; // @[lib.scala 562:21]
  wire [1:0] x_t_icaf_type = _T_672[13:12]; // @[lib.scala 562:21]
  wire  x_t_icaf_second = _T_672[14]; // @[lib.scala 562:21]
  wire  x_t_icaf = _T_672[15]; // @[lib.scala 562:21]
  wire  x_t_legal = _T_672[16]; // @[lib.scala 562:21]
  wire [3:0] _T_687 = {io_dec_tlu_flush_lower_wb,io_dec_tlu_flush_lower_wb,io_dec_tlu_flush_lower_wb,io_dec_tlu_flush_lower_wb}; // @[Cat.scala 29:58]
  wire [3:0] _T_688 = ~_T_687; // @[dec_decode_ctl.scala 658:39]
  wire [3:0] x_t_in_i0trigger = x_t_i0trigger & _T_688; // @[dec_decode_ctl.scala 658:37]
  reg  _T_691; // @[lib.scala 401:18]
  reg  _T_692; // @[lib.scala 401:18]
  reg  _T_693; // @[lib.scala 401:18]
  reg [3:0] _T_694; // @[lib.scala 401:18]
  reg [3:0] _T_700; // @[lib.scala 401:18]
  wire [3:0] _T_697 = x_t_in_i0trigger ^ _T_700; // @[lib.scala 515:26]
  wire  _T_698 = |_T_697; // @[lib.scala 515:34]
  reg  _T_706; // @[lib.scala 401:18]
  wire  _T_703 = x_t_fence_i ^ _T_706; // @[lib.scala 515:26]
  wire  _T_704 = |_T_703; // @[lib.scala 515:34]
  reg [1:0] _T_712; // @[lib.scala 401:18]
  wire [1:0] _T_709 = x_t_icaf_type ^ _T_712; // @[lib.scala 515:26]
  wire  _T_710 = |_T_709; // @[lib.scala 515:34]
  reg  _T_718; // @[lib.scala 401:18]
  wire  _T_715 = x_t_icaf_second ^ _T_718; // @[lib.scala 515:26]
  wire  _T_716 = |_T_715; // @[lib.scala 515:34]
  reg  _T_724; // @[lib.scala 401:18]
  wire  _T_721 = x_t_icaf ^ _T_724; // @[lib.scala 515:26]
  wire  _T_722 = |_T_721; // @[lib.scala 515:34]
  reg  _T_730; // @[lib.scala 401:18]
  wire  _T_727 = x_t_legal ^ _T_730; // @[lib.scala 515:26]
  wire  _T_728 = |_T_727; // @[lib.scala 515:34]
  wire [16:0] _T_741 = {_T_730,_T_724,_T_718,_T_712,_T_706,_T_700,_T_694,_T_693,_T_692,_T_691}; // @[lib.scala 562:21]
  wire  r_t_pmu_i0_br_unpred = _T_741[2]; // @[lib.scala 562:21]
  wire [3:0] r_t_pmu_i0_itype = _T_741[6:3]; // @[lib.scala 562:21]
  wire [3:0] r_t_i0trigger = _T_741[10:7]; // @[lib.scala 562:21]
  wire  r_t_fence_i = _T_741[11]; // @[lib.scala 562:21]
  wire [1:0] r_t_icaf_type = _T_741[13:12]; // @[lib.scala 562:21]
  wire  r_t_icaf_second = _T_741[14]; // @[lib.scala 562:21]
  wire  r_t_icaf = _T_741[15]; // @[lib.scala 562:21]
  wire  r_t_legal = _T_741[16]; // @[lib.scala 562:21]
  wire  r_d_bits_i0store = _T_1001[16]; // @[lib.scala 562:21]
  wire  _T_753 = r_d_bits_i0load | r_d_bits_i0store; // @[dec_decode_ctl.scala 664:61]
  wire [3:0] _T_757 = {_T_753,_T_753,_T_753,_T_753}; // @[Cat.scala 29:58]
  wire [3:0] _T_758 = _T_757 & lsu_trigger_match_r; // @[dec_decode_ctl.scala 664:82]
  wire [3:0] _T_759 = _T_758 | r_t_i0trigger; // @[dec_decode_ctl.scala 664:105]
  wire  _T_772 = i0r_rs1 != 5'h0; // @[dec_decode_ctl.scala 680:60]
  wire  _T_774 = i0r_rs2 != 5'h0; // @[dec_decode_ctl.scala 681:60]
  wire  _T_776 = i0r_rd != 5'h0; // @[dec_decode_ctl.scala 682:48]
  wire  i0_rd_en_d = i0_dp_rd & _T_776; // @[dec_decode_ctl.scala 682:37]
  wire  i0_jalimm20 = i0_dp_jal & i0_dp_imm20; // @[dec_decode_ctl.scala 686:38]
  wire  _T_777 = ~i0_dp_jal; // @[dec_decode_ctl.scala 687:27]
  wire  i0_uiimm20 = _T_777 & i0_dp_imm20; // @[dec_decode_ctl.scala 687:38]
  wire [9:0] _T_788 = {io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31]}; // @[Cat.scala 29:58]
  wire [18:0] _T_797 = {_T_788,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[31]}; // @[Cat.scala 29:58]
  wire [31:0] _T_800 = {_T_797,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31:20]}; // @[Cat.scala 29:58]
  wire [31:0] _T_829 = {27'h0,i0r_rs2}; // @[Cat.scala 29:58]
  wire [31:0] _T_849 = {_T_788,io_dec_i0_instr_d[31],io_dec_i0_instr_d[31],io_dec_i0_instr_d[19:12],io_dec_i0_instr_d[20],io_dec_i0_instr_d[30:21],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_863 = {io_dec_i0_instr_d[31:12],12'h0}; // @[Cat.scala 29:58]
  wire  _T_864 = i0_csr_write_only_d & i0_dp_csr_imm; // @[dec_decode_ctl.scala 698:26]
  wire [31:0] _T_894 = {27'h0,i0r_rs1}; // @[Cat.scala 29:58]
  wire [31:0] _T_895 = i0_dp_imm12 ? _T_800 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_896 = i0_dp_shimm5 ? _T_829 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_897 = i0_jalimm20 ? _T_849 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_898 = i0_uiimm20 ? _T_863 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_899 = _T_864 ? _T_894 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_900 = _T_895 | _T_896; // @[Mux.scala 27:72]
  wire [31:0] _T_901 = _T_900 | _T_897; // @[Mux.scala 27:72]
  wire [31:0] _T_902 = _T_901 | _T_898; // @[Mux.scala 27:72]
  wire  i0_d_c_mul = i0_dp_mul & i0_legal_decode_d; // @[dec_decode_ctl.scala 758:44]
  wire  i0_d_c_load = i0_dp_load & i0_legal_decode_d; // @[dec_decode_ctl.scala 759:44]
  wire  i0_d_c_alu = i0_dp_alu & i0_legal_decode_d; // @[dec_decode_ctl.scala 760:44]
  reg  i0_x_c_mul; // @[Reg.scala 27:20]
  reg  i0_x_c_alu; // @[Reg.scala 27:20]
  reg  i0_r_c_mul; // @[Reg.scala 27:20]
  reg  i0_r_c_alu; // @[Reg.scala 27:20]
  wire  _T_939 = |i0_pipe_en[1:0]; // @[dec_decode_ctl.scala 768:49]
  wire  i0_r_data_en = i0_pipe_en[2] | io_clk_override; // @[dec_decode_ctl.scala 770:50]
  wire  i0_wb_data_en = i0_pipe_en[1] | io_clk_override; // @[dec_decode_ctl.scala 771:50]
  wire  d_d_bits_i0v = i0_rd_en_d & i0_legal_decode_d; // @[dec_decode_ctl.scala 777:50]
  wire  d_d_bits_i0store = i0_dp_store & i0_legal_decode_d; // @[dec_decode_ctl.scala 781:50]
  wire  d_d_bits_i0div = i0_dp_div & i0_legal_decode_d; // @[dec_decode_ctl.scala 782:50]
  wire  d_d_bits_csrwen = io_dec_csr_wen_unq_d & i0_legal_decode_d; // @[dec_decode_ctl.scala 784:61]
  wire  d_d_bits_csrwonly = i0_csr_write_only_d & io_dec_aln_dec_i0_decode_d; // @[dec_decode_ctl.scala 785:58]
  wire [11:0] d_d_bits_csrwaddr = d_d_bits_csrwen ? io_dec_i0_instr_d[31:20] : 12'h0; // @[dec_decode_ctl.scala 786:41]
  wire [14:0] _T_961 = {d_d_bits_i0v,d_d_bits_csrwen,d_d_bits_csrwonly,d_d_bits_csrwaddr}; // @[lib.scala 559:59]
  wire [7:0] _T_964 = {i0r_rd,i0_d_c_load,d_d_bits_i0store,d_d_bits_i0div}; // @[lib.scala 559:59]
  wire [11:0] x_d_bits_csrwaddr = _T_970[11:0]; // @[lib.scala 562:21]
  wire  x_d_bits_csrwen = _T_970[13]; // @[lib.scala 562:21]
  wire  x_d_bits_i0store = _T_970[16]; // @[lib.scala 562:21]
  wire  _T_982 = x_d_bits_i0v & _T_1012; // @[dec_decode_ctl.scala 791:47]
  wire  x_d_in_bits_i0v = _T_982 & _T_366; // @[dec_decode_ctl.scala 791:76]
  wire  _T_986 = x_d_valid & _T_1012; // @[dec_decode_ctl.scala 792:33]
  wire [14:0] _T_992 = {x_d_in_bits_i0v,x_d_bits_csrwen,x_d_bits_csrwonly,x_d_bits_csrwaddr}; // @[lib.scala 559:59]
  wire [7:0] _T_995 = {x_d_bits_i0rd,x_d_bits_i0load,x_d_bits_i0store,x_d_bits_i0div}; // @[lib.scala 559:59]
  wire  r_d_in_bits_i0load = r_d_bits_i0load & _T_1012; // @[dec_decode_ctl.scala 800:49]
  wire  r_d_in_bits_i0store = r_d_bits_i0store & _T_1012; // @[dec_decode_ctl.scala 801:49]
  wire [14:0] _T_1023 = {r_d_in_bits_i0v,r_d_bits_csrwen,r_d_bits_csrwonly,r_d_bits_csrwaddr}; // @[lib.scala 559:59]
  wire [7:0] _T_1026 = {r_d_bits_i0rd,r_d_in_bits_i0load,r_d_in_bits_i0store,r_d_bits_i0div}; // @[lib.scala 559:59]
  wire  _T_1045 = ~r_d_bits_i0div; // @[dec_decode_ctl.scala 807:49]
  wire  _T_1046 = i0_wen_r & _T_1045; // @[dec_decode_ctl.scala 807:47]
  wire  _T_1047 = ~i0_load_kill_wen_r; // @[dec_decode_ctl.scala 807:70]
  wire  _T_1049 = x_d_bits_i0v | x_d_bits_csrwen; // @[dec_decode_ctl.scala 811:74]
  wire  _T_1050 = _T_1049 | debug_valid_x; // @[dec_decode_ctl.scala 811:92]
  wire  _T_1053 = x_d_bits_i0v & x_d_bits_i0load; // @[dec_decode_ctl.scala 817:47]
  wire  _T_1060 = io_decode_exu_i0_ap_predict_nt & _T_777; // @[dec_decode_ctl.scala 823:71]
  wire [11:0] _T_1073 = {10'h0,io_dec_i0_pc4_d,i0_ap_pc2}; // @[Cat.scala 29:58]
  reg [11:0] last_br_immed_x; // @[lib.scala 401:18]
  wire  trace_enable = ~io_dec_tlu_trace_disable; // @[dec_decode_ctl.scala 858:22]
  reg [4:0] _T_1122; // @[lib.scala 401:18]
  reg [31:0] i0_inst_x; // @[lib.scala 401:18]
  reg [31:0] i0_inst_r; // @[lib.scala 401:18]
  reg [31:0] i0_inst_wb; // @[lib.scala 401:18]
  reg [30:0] i0_pc_wb; // @[lib.scala 401:18]
  reg [18:0] _T_1138; // @[lib.scala 401:18]
  wire [18:0] _T_1135 = io_dec_alu_exu_i0_pc_x[30:12] ^ _T_1138; // @[lib.scala 515:26]
  wire  _T_1136 = |_T_1135; // @[lib.scala 515:34]
  reg [11:0] _T_1140; // @[lib.scala 401:18]
  wire [31:0] _T_1141 = {io_dec_alu_exu_i0_pc_x,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_1142 = {last_br_immed_x,1'h0}; // @[Cat.scala 29:58]
  wire [12:0] _T_1145 = _T_1141[12:1] + _T_1142[12:1]; // @[lib.scala 70:31]
  wire [18:0] _T_1148 = _T_1141[31:13] + 19'h1; // @[lib.scala 71:27]
  wire [18:0] _T_1151 = _T_1141[31:13] - 19'h1; // @[lib.scala 72:27]
  wire  _T_1154 = ~_T_1145[12]; // @[lib.scala 74:28]
  wire  _T_1155 = _T_1142[12] ^ _T_1154; // @[lib.scala 74:26]
  wire  _T_1158 = ~_T_1142[12]; // @[lib.scala 75:20]
  wire  _T_1160 = _T_1158 & _T_1145[12]; // @[lib.scala 75:26]
  wire  _T_1164 = _T_1142[12] & _T_1154; // @[lib.scala 76:26]
  wire [18:0] _T_1166 = _T_1155 ? _T_1141[31:13] : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_1167 = _T_1160 ? _T_1148 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_1168 = _T_1164 ? _T_1151 : 19'h0; // @[Mux.scala 27:72]
  wire [18:0] _T_1169 = _T_1166 | _T_1167; // @[Mux.scala 27:72]
  wire [18:0] _T_1170 = _T_1169 | _T_1168; // @[Mux.scala 27:72]
  wire [31:0] temp_pred_correct_npc_x = {_T_1170,_T_1145[11:0],1'h0}; // @[Cat.scala 29:58]
  wire  _T_1186_mul = i0_rs1_depend_i0_r & i0_r_c_mul; // @[dec_decode_ctl.scala 887:61]
  wire  _T_1186_alu = i0_rs1_depend_i0_r & i0_r_c_alu; // @[dec_decode_ctl.scala 887:61]
  wire  i0_rs1_class_d_mul = i0_rs1_depend_i0_x ? i0_x_c_mul : _T_1186_mul; // @[dec_decode_ctl.scala 887:24]
  wire  i0_rs1_class_d_alu = i0_rs1_depend_i0_x ? i0_x_c_alu : _T_1186_alu; // @[dec_decode_ctl.scala 887:24]
  wire  _T_1195_mul = i0_rs2_depend_i0_r & i0_r_c_mul; // @[dec_decode_ctl.scala 889:61]
  wire  _T_1195_alu = i0_rs2_depend_i0_r & i0_r_c_alu; // @[dec_decode_ctl.scala 889:61]
  wire  i0_rs2_class_d_mul = i0_rs2_depend_i0_x ? i0_x_c_mul : _T_1195_mul; // @[dec_decode_ctl.scala 889:24]
  wire  i0_rs2_class_d_alu = i0_rs2_depend_i0_x ? i0_x_c_alu : _T_1195_alu; // @[dec_decode_ctl.scala 889:24]
  wire  _T_1208 = io_decode_exu_dec_i0_rs1_en_d & io_dec_nonblock_load_wen; // @[dec_decode_ctl.scala 907:73]
  wire  _T_1209 = io_dec_nonblock_load_waddr == i0r_rs1; // @[dec_decode_ctl.scala 907:130]
  wire  i0_rs1_nonblock_load_bypass_en_d = _T_1208 & _T_1209; // @[dec_decode_ctl.scala 907:100]
  wire  _T_1210 = io_decode_exu_dec_i0_rs2_en_d & io_dec_nonblock_load_wen; // @[dec_decode_ctl.scala 909:73]
  wire  _T_1211 = io_dec_nonblock_load_waddr == i0r_rs2; // @[dec_decode_ctl.scala 909:130]
  wire  i0_rs2_nonblock_load_bypass_en_d = _T_1210 & _T_1211; // @[dec_decode_ctl.scala 909:100]
  wire  _T_1213 = i0_rs1_class_d_alu | i0_rs1_class_d_mul; // @[dec_decode_ctl.scala 912:66]
  wire  _T_1214 = i0_rs1_depth_d[0] & _T_1213; // @[dec_decode_ctl.scala 912:45]
  wire  _T_1216 = i0_rs1_depth_d[0] & i0_rs1_class_d_load; // @[dec_decode_ctl.scala 912:108]
  wire  _T_1219 = _T_1213 | i0_rs1_class_d_load; // @[dec_decode_ctl.scala 912:196]
  wire  _T_1220 = i0_rs1_depth_d[1] & _T_1219; // @[dec_decode_ctl.scala 912:153]
  wire [2:0] i0_rs1bypass = {_T_1214,_T_1216,_T_1220}; // @[Cat.scala 29:58]
  wire  _T_1224 = i0_rs2_class_d_alu | i0_rs2_class_d_mul; // @[dec_decode_ctl.scala 914:67]
  wire  _T_1225 = i0_rs2_depth_d[0] & _T_1224; // @[dec_decode_ctl.scala 914:45]
  wire  _T_1227 = i0_rs2_depth_d[0] & i0_rs2_class_d_load; // @[dec_decode_ctl.scala 914:109]
  wire  _T_1230 = _T_1224 | i0_rs2_class_d_load; // @[dec_decode_ctl.scala 914:196]
  wire  _T_1231 = i0_rs2_depth_d[1] & _T_1230; // @[dec_decode_ctl.scala 914:153]
  wire [2:0] i0_rs2bypass = {_T_1225,_T_1227,_T_1231}; // @[Cat.scala 29:58]
  wire  _T_1235 = ~i0_rs1bypass[0]; // @[dec_decode_ctl.scala 916:53]
  wire  _T_1237 = ~i0_rs1bypass[1]; // @[dec_decode_ctl.scala 916:72]
  wire  _T_1238 = _T_1235 & _T_1237; // @[dec_decode_ctl.scala 916:70]
  wire  _T_1240 = ~i0_rs1bypass[2]; // @[dec_decode_ctl.scala 916:91]
  wire  _T_1241 = _T_1238 & _T_1240; // @[dec_decode_ctl.scala 916:89]
  wire  _T_1242 = _T_1241 & i0_rs1_nonblock_load_bypass_en_d; // @[dec_decode_ctl.scala 916:108]
  wire [1:0] _T_1246 = {i0_rs1bypass[1],i0_rs1bypass[0]}; // @[Cat.scala 29:58]
  wire [1:0] _T_1247 = {_T_1242,i0_rs1bypass[2]}; // @[Cat.scala 29:58]
  wire  _T_1250 = ~i0_rs2bypass[0]; // @[dec_decode_ctl.scala 917:53]
  wire  _T_1252 = ~i0_rs2bypass[1]; // @[dec_decode_ctl.scala 917:72]
  wire  _T_1253 = _T_1250 & _T_1252; // @[dec_decode_ctl.scala 917:70]
  wire  _T_1255 = ~i0_rs2bypass[2]; // @[dec_decode_ctl.scala 917:91]
  wire  _T_1256 = _T_1253 & _T_1255; // @[dec_decode_ctl.scala 917:89]
  wire  _T_1257 = _T_1256 & i0_rs2_nonblock_load_bypass_en_d; // @[dec_decode_ctl.scala 917:108]
  wire [1:0] _T_1261 = {i0_rs2bypass[1],i0_rs2bypass[0]}; // @[Cat.scala 29:58]
  wire [1:0] _T_1262 = {_T_1257,i0_rs2bypass[2]}; // @[Cat.scala 29:58]
  wire  _T_1264 = i0_dp_raw_load | i0_dp_raw_store; // @[dec_decode_ctl.scala 921:68]
  wire  _T_1265 = io_dec_ib0_valid_d & _T_1264; // @[dec_decode_ctl.scala 921:50]
  wire  _T_1266 = ~io_dctl_dma_dma_dccm_stall_any; // @[dec_decode_ctl.scala 921:89]
  wire  _T_1267 = _T_1265 & _T_1266; // @[dec_decode_ctl.scala 921:87]
  wire  _T_1269 = _T_1267 & _T_587; // @[dec_decode_ctl.scala 921:121]
  wire  _T_1271 = ~io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 923:6]
  wire  _T_1272 = _T_1271 & i0_dp_lsu; // @[dec_decode_ctl.scala 923:38]
  wire  _T_1273 = _T_1272 & i0_dp_load; // @[dec_decode_ctl.scala 923:50]
  wire  _T_1278 = _T_1272 & i0_dp_store; // @[dec_decode_ctl.scala 924:50]
  wire [11:0] _T_1282 = {io_dec_i0_instr_d[31:25],i0r_rd}; // @[Cat.scala 29:58]
  wire [11:0] _T_1283 = _T_1273 ? io_dec_i0_instr_d[31:20] : 12'h0; // @[Mux.scala 27:72]
  wire [11:0] _T_1284 = _T_1278 ? _T_1282 : 12'h0; // @[Mux.scala 27:72]
  rvclkhdr rvclkhdr ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_io_l1clk),
    .io_clk(rvclkhdr_io_clk),
    .io_en(rvclkhdr_io_en),
    .io_scan_mode(rvclkhdr_io_scan_mode)
  );
  rvclkhdr rvclkhdr_1 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_1_io_l1clk),
    .io_clk(rvclkhdr_1_io_clk),
    .io_en(rvclkhdr_1_io_en),
    .io_scan_mode(rvclkhdr_1_io_scan_mode)
  );
  rvclkhdr rvclkhdr_2 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_2_io_l1clk),
    .io_clk(rvclkhdr_2_io_clk),
    .io_en(rvclkhdr_2_io_en),
    .io_scan_mode(rvclkhdr_2_io_scan_mode)
  );
  rvclkhdr rvclkhdr_3 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_3_io_l1clk),
    .io_clk(rvclkhdr_3_io_clk),
    .io_en(rvclkhdr_3_io_en),
    .io_scan_mode(rvclkhdr_3_io_scan_mode)
  );
  rvclkhdr rvclkhdr_4 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_4_io_l1clk),
    .io_clk(rvclkhdr_4_io_clk),
    .io_en(rvclkhdr_4_io_en),
    .io_scan_mode(rvclkhdr_4_io_scan_mode)
  );
  rvclkhdr rvclkhdr_5 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_5_io_l1clk),
    .io_clk(rvclkhdr_5_io_clk),
    .io_en(rvclkhdr_5_io_en),
    .io_scan_mode(rvclkhdr_5_io_scan_mode)
  );
  rvclkhdr rvclkhdr_6 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_6_io_l1clk),
    .io_clk(rvclkhdr_6_io_clk),
    .io_en(rvclkhdr_6_io_en),
    .io_scan_mode(rvclkhdr_6_io_scan_mode)
  );
  rvclkhdr rvclkhdr_7 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_7_io_l1clk),
    .io_clk(rvclkhdr_7_io_clk),
    .io_en(rvclkhdr_7_io_en),
    .io_scan_mode(rvclkhdr_7_io_scan_mode)
  );
  rvclkhdr rvclkhdr_8 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_8_io_l1clk),
    .io_clk(rvclkhdr_8_io_clk),
    .io_en(rvclkhdr_8_io_en),
    .io_scan_mode(rvclkhdr_8_io_scan_mode)
  );
  rvclkhdr rvclkhdr_9 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_9_io_l1clk),
    .io_clk(rvclkhdr_9_io_clk),
    .io_en(rvclkhdr_9_io_en),
    .io_scan_mode(rvclkhdr_9_io_scan_mode)
  );
  rvclkhdr rvclkhdr_10 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_10_io_l1clk),
    .io_clk(rvclkhdr_10_io_clk),
    .io_en(rvclkhdr_10_io_en),
    .io_scan_mode(rvclkhdr_10_io_scan_mode)
  );
  rvclkhdr rvclkhdr_11 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_11_io_l1clk),
    .io_clk(rvclkhdr_11_io_clk),
    .io_en(rvclkhdr_11_io_en),
    .io_scan_mode(rvclkhdr_11_io_scan_mode)
  );
  rvclkhdr rvclkhdr_12 ( // @[lib.scala 444:25]
    .io_l1clk(rvclkhdr_12_io_l1clk),
    .io_clk(rvclkhdr_12_io_clk),
    .io_en(rvclkhdr_12_io_en),
    .io_scan_mode(rvclkhdr_12_io_scan_mode)
  );
  rvclkhdr rvclkhdr_13 ( // @[lib.scala 468:25]
    .io_l1clk(rvclkhdr_13_io_l1clk),
    .io_clk(rvclkhdr_13_io_clk),
    .io_en(rvclkhdr_13_io_en),
    .io_scan_mode(rvclkhdr_13_io_scan_mode)
  );
  rvclkhdr rvclkhdr_14 ( // @[lib.scala 468:25]
    .io_l1clk(rvclkhdr_14_io_l1clk),
    .io_clk(rvclkhdr_14_io_clk),
    .io_en(rvclkhdr_14_io_en),
    .io_scan_mode(rvclkhdr_14_io_scan_mode)
  );
  rvclkhdr rvclkhdr_15 ( // @[lib.scala 468:25]
    .io_l1clk(rvclkhdr_15_io_l1clk),
    .io_clk(rvclkhdr_15_io_clk),
    .io_en(rvclkhdr_15_io_en),
    .io_scan_mode(rvclkhdr_15_io_scan_mode)
  );
  rvclkhdr rvclkhdr_16 ( // @[lib.scala 468:25]
    .io_l1clk(rvclkhdr_16_io_l1clk),
    .io_clk(rvclkhdr_16_io_clk),
    .io_en(rvclkhdr_16_io_en),
    .io_scan_mode(rvclkhdr_16_io_scan_mode)
  );
  dec_dec_ctl i0_dec ( // @[dec_decode_ctl.scala 438:22]
    .io_ins(i0_dec_io_ins),
    .io_out_clz(i0_dec_io_out_clz),
    .io_out_ctz(i0_dec_io_out_ctz),
    .io_out_pcnt(i0_dec_io_out_pcnt),
    .io_out_sext_b(i0_dec_io_out_sext_b),
    .io_out_sext_h(i0_dec_io_out_sext_h),
    .io_out_slo(i0_dec_io_out_slo),
    .io_out_sro(i0_dec_io_out_sro),
    .io_out_min(i0_dec_io_out_min),
    .io_out_max(i0_dec_io_out_max),
    .io_out_pack(i0_dec_io_out_pack),
    .io_out_packu(i0_dec_io_out_packu),
    .io_out_packh(i0_dec_io_out_packh),
    .io_out_rol(i0_dec_io_out_rol),
    .io_out_ror(i0_dec_io_out_ror),
    .io_out_grev(i0_dec_io_out_grev),
    .io_out_gorc(i0_dec_io_out_gorc),
    .io_out_zbb(i0_dec_io_out_zbb),
    .io_out_sbset(i0_dec_io_out_sbset),
    .io_out_sbclr(i0_dec_io_out_sbclr),
    .io_out_sbinv(i0_dec_io_out_sbinv),
    .io_out_sbext(i0_dec_io_out_sbext),
    .io_out_zbs(i0_dec_io_out_zbs),
    .io_out_bext(i0_dec_io_out_bext),
    .io_out_bdep(i0_dec_io_out_bdep),
    .io_out_zbe(i0_dec_io_out_zbe),
    .io_out_clmul(i0_dec_io_out_clmul),
    .io_out_clmulh(i0_dec_io_out_clmulh),
    .io_out_clmulr(i0_dec_io_out_clmulr),
    .io_out_zbc(i0_dec_io_out_zbc),
    .io_out_shfl(i0_dec_io_out_shfl),
    .io_out_unshfl(i0_dec_io_out_unshfl),
    .io_out_zbp(i0_dec_io_out_zbp),
    .io_out_crc32_b(i0_dec_io_out_crc32_b),
    .io_out_crc32_h(i0_dec_io_out_crc32_h),
    .io_out_crc32_w(i0_dec_io_out_crc32_w),
    .io_out_crc32c_b(i0_dec_io_out_crc32c_b),
    .io_out_crc32c_h(i0_dec_io_out_crc32c_h),
    .io_out_crc32c_w(i0_dec_io_out_crc32c_w),
    .io_out_zbr(i0_dec_io_out_zbr),
    .io_out_bfp(i0_dec_io_out_bfp),
    .io_out_zbf(i0_dec_io_out_zbf),
    .io_out_sh1add(i0_dec_io_out_sh1add),
    .io_out_sh2add(i0_dec_io_out_sh2add),
    .io_out_sh3add(i0_dec_io_out_sh3add),
    .io_out_zba(i0_dec_io_out_zba),
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
  rvclkhdr rvclkhdr_17 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_17_io_l1clk),
    .io_clk(rvclkhdr_17_io_clk),
    .io_en(rvclkhdr_17_io_en),
    .io_scan_mode(rvclkhdr_17_io_scan_mode)
  );
  rvclkhdr rvclkhdr_18 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_18_io_l1clk),
    .io_clk(rvclkhdr_18_io_clk),
    .io_en(rvclkhdr_18_io_en),
    .io_scan_mode(rvclkhdr_18_io_scan_mode)
  );
  rvclkhdr rvclkhdr_19 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_19_io_l1clk),
    .io_clk(rvclkhdr_19_io_clk),
    .io_en(rvclkhdr_19_io_en),
    .io_scan_mode(rvclkhdr_19_io_scan_mode)
  );
  rvclkhdr rvclkhdr_20 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_20_io_l1clk),
    .io_clk(rvclkhdr_20_io_clk),
    .io_en(rvclkhdr_20_io_en),
    .io_scan_mode(rvclkhdr_20_io_scan_mode)
  );
  rvclkhdr rvclkhdr_21 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_21_io_l1clk),
    .io_clk(rvclkhdr_21_io_clk),
    .io_en(rvclkhdr_21_io_en),
    .io_scan_mode(rvclkhdr_21_io_scan_mode)
  );
  rvclkhdr rvclkhdr_22 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_22_io_l1clk),
    .io_clk(rvclkhdr_22_io_clk),
    .io_en(rvclkhdr_22_io_en),
    .io_scan_mode(rvclkhdr_22_io_scan_mode)
  );
  rvclkhdr rvclkhdr_23 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_23_io_l1clk),
    .io_clk(rvclkhdr_23_io_clk),
    .io_en(rvclkhdr_23_io_en),
    .io_scan_mode(rvclkhdr_23_io_scan_mode)
  );
  rvclkhdr rvclkhdr_24 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_24_io_l1clk),
    .io_clk(rvclkhdr_24_io_clk),
    .io_en(rvclkhdr_24_io_en),
    .io_scan_mode(rvclkhdr_24_io_scan_mode)
  );
  rvclkhdr rvclkhdr_25 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_25_io_l1clk),
    .io_clk(rvclkhdr_25_io_clk),
    .io_en(rvclkhdr_25_io_en),
    .io_scan_mode(rvclkhdr_25_io_scan_mode)
  );
  rvclkhdr rvclkhdr_26 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_26_io_l1clk),
    .io_clk(rvclkhdr_26_io_clk),
    .io_en(rvclkhdr_26_io_en),
    .io_scan_mode(rvclkhdr_26_io_scan_mode)
  );
  rvclkhdr rvclkhdr_27 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_27_io_l1clk),
    .io_clk(rvclkhdr_27_io_clk),
    .io_en(rvclkhdr_27_io_en),
    .io_scan_mode(rvclkhdr_27_io_scan_mode)
  );
  rvclkhdr rvclkhdr_28 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_28_io_l1clk),
    .io_clk(rvclkhdr_28_io_clk),
    .io_en(rvclkhdr_28_io_en),
    .io_scan_mode(rvclkhdr_28_io_scan_mode)
  );
  rvclkhdr rvclkhdr_29 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_29_io_l1clk),
    .io_clk(rvclkhdr_29_io_clk),
    .io_en(rvclkhdr_29_io_en),
    .io_scan_mode(rvclkhdr_29_io_scan_mode)
  );
  rvclkhdr rvclkhdr_30 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_30_io_l1clk),
    .io_clk(rvclkhdr_30_io_clk),
    .io_en(rvclkhdr_30_io_en),
    .io_scan_mode(rvclkhdr_30_io_scan_mode)
  );
  rvclkhdr rvclkhdr_31 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_31_io_l1clk),
    .io_clk(rvclkhdr_31_io_clk),
    .io_en(rvclkhdr_31_io_en),
    .io_scan_mode(rvclkhdr_31_io_scan_mode)
  );
  rvclkhdr rvclkhdr_32 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_32_io_l1clk),
    .io_clk(rvclkhdr_32_io_clk),
    .io_en(rvclkhdr_32_io_en),
    .io_scan_mode(rvclkhdr_32_io_scan_mode)
  );
  rvclkhdr rvclkhdr_33 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_33_io_l1clk),
    .io_clk(rvclkhdr_33_io_clk),
    .io_en(rvclkhdr_33_io_en),
    .io_scan_mode(rvclkhdr_33_io_scan_mode)
  );
  rvclkhdr rvclkhdr_34 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_34_io_l1clk),
    .io_clk(rvclkhdr_34_io_clk),
    .io_en(rvclkhdr_34_io_en),
    .io_scan_mode(rvclkhdr_34_io_scan_mode)
  );
  rvclkhdr rvclkhdr_35 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_35_io_l1clk),
    .io_clk(rvclkhdr_35_io_clk),
    .io_en(rvclkhdr_35_io_en),
    .io_scan_mode(rvclkhdr_35_io_scan_mode)
  );
  rvclkhdr rvclkhdr_36 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_36_io_l1clk),
    .io_clk(rvclkhdr_36_io_clk),
    .io_en(rvclkhdr_36_io_en),
    .io_scan_mode(rvclkhdr_36_io_scan_mode)
  );
  rvclkhdr rvclkhdr_37 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_37_io_l1clk),
    .io_clk(rvclkhdr_37_io_clk),
    .io_en(rvclkhdr_37_io_en),
    .io_scan_mode(rvclkhdr_37_io_scan_mode)
  );
  rvclkhdr rvclkhdr_38 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_38_io_l1clk),
    .io_clk(rvclkhdr_38_io_clk),
    .io_en(rvclkhdr_38_io_en),
    .io_scan_mode(rvclkhdr_38_io_scan_mode)
  );
  rvclkhdr rvclkhdr_39 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_39_io_l1clk),
    .io_clk(rvclkhdr_39_io_clk),
    .io_en(rvclkhdr_39_io_en),
    .io_scan_mode(rvclkhdr_39_io_scan_mode)
  );
  rvclkhdr rvclkhdr_40 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_40_io_l1clk),
    .io_clk(rvclkhdr_40_io_clk),
    .io_en(rvclkhdr_40_io_en),
    .io_scan_mode(rvclkhdr_40_io_scan_mode)
  );
  rvclkhdr rvclkhdr_41 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_41_io_l1clk),
    .io_clk(rvclkhdr_41_io_clk),
    .io_en(rvclkhdr_41_io_en),
    .io_scan_mode(rvclkhdr_41_io_scan_mode)
  );
  rvclkhdr rvclkhdr_42 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_42_io_l1clk),
    .io_clk(rvclkhdr_42_io_clk),
    .io_en(rvclkhdr_42_io_en),
    .io_scan_mode(rvclkhdr_42_io_scan_mode)
  );
  rvclkhdr rvclkhdr_43 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_43_io_l1clk),
    .io_clk(rvclkhdr_43_io_clk),
    .io_en(rvclkhdr_43_io_en),
    .io_scan_mode(rvclkhdr_43_io_scan_mode)
  );
  rvclkhdr rvclkhdr_44 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_44_io_l1clk),
    .io_clk(rvclkhdr_44_io_clk),
    .io_en(rvclkhdr_44_io_en),
    .io_scan_mode(rvclkhdr_44_io_scan_mode)
  );
  rvclkhdr rvclkhdr_45 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_45_io_l1clk),
    .io_clk(rvclkhdr_45_io_clk),
    .io_en(rvclkhdr_45_io_en),
    .io_scan_mode(rvclkhdr_45_io_scan_mode)
  );
  rvclkhdr rvclkhdr_46 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_46_io_l1clk),
    .io_clk(rvclkhdr_46_io_clk),
    .io_en(rvclkhdr_46_io_en),
    .io_scan_mode(rvclkhdr_46_io_scan_mode)
  );
  rvclkhdr rvclkhdr_47 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_47_io_l1clk),
    .io_clk(rvclkhdr_47_io_clk),
    .io_en(rvclkhdr_47_io_en),
    .io_scan_mode(rvclkhdr_47_io_scan_mode)
  );
  rvclkhdr rvclkhdr_48 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_48_io_l1clk),
    .io_clk(rvclkhdr_48_io_clk),
    .io_en(rvclkhdr_48_io_en),
    .io_scan_mode(rvclkhdr_48_io_scan_mode)
  );
  rvclkhdr rvclkhdr_49 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_49_io_l1clk),
    .io_clk(rvclkhdr_49_io_clk),
    .io_en(rvclkhdr_49_io_en),
    .io_scan_mode(rvclkhdr_49_io_scan_mode)
  );
  rvclkhdr rvclkhdr_50 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_50_io_l1clk),
    .io_clk(rvclkhdr_50_io_clk),
    .io_en(rvclkhdr_50_io_en),
    .io_scan_mode(rvclkhdr_50_io_scan_mode)
  );
  rvclkhdr rvclkhdr_51 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_51_io_l1clk),
    .io_clk(rvclkhdr_51_io_clk),
    .io_en(rvclkhdr_51_io_en),
    .io_scan_mode(rvclkhdr_51_io_scan_mode)
  );
  rvclkhdr rvclkhdr_52 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_52_io_l1clk),
    .io_clk(rvclkhdr_52_io_clk),
    .io_en(rvclkhdr_52_io_en),
    .io_scan_mode(rvclkhdr_52_io_scan_mode)
  );
  rvclkhdr rvclkhdr_53 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_53_io_l1clk),
    .io_clk(rvclkhdr_53_io_clk),
    .io_en(rvclkhdr_53_io_en),
    .io_scan_mode(rvclkhdr_53_io_scan_mode)
  );
  rvclkhdr rvclkhdr_54 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_54_io_l1clk),
    .io_clk(rvclkhdr_54_io_clk),
    .io_en(rvclkhdr_54_io_en),
    .io_scan_mode(rvclkhdr_54_io_scan_mode)
  );
  rvclkhdr rvclkhdr_55 ( // @[lib.scala 392:23]
    .io_l1clk(rvclkhdr_55_io_l1clk),
    .io_clk(rvclkhdr_55_io_clk),
    .io_en(rvclkhdr_55_io_en),
    .io_scan_mode(rvclkhdr_55_io_scan_mode)
  );
  assign io_decode_exu_dec_data_en = {i0_x_data_en,i0_r_data_en}; // @[dec_decode_ctl.scala 773:38]
  assign io_decode_exu_dec_ctl_en = {i0_x_ctl_en,i0_r_ctl_en}; // @[dec_decode_ctl.scala 774:38]
  assign io_decode_exu_i0_ap_clz = _T_79 ? 1'h0 : i0_dp_raw_clz; // @[dec_decode_ctl.scala 317:33]
  assign io_decode_exu_i0_ap_ctz = _T_79 ? 1'h0 : i0_dp_raw_ctz; // @[dec_decode_ctl.scala 318:33]
  assign io_decode_exu_i0_ap_pcnt = _T_79 ? 1'h0 : i0_dp_raw_pcnt; // @[dec_decode_ctl.scala 319:33]
  assign io_decode_exu_i0_ap_sext_b = _T_79 ? 1'h0 : i0_dp_raw_sext_b; // @[dec_decode_ctl.scala 320:33]
  assign io_decode_exu_i0_ap_sext_h = _T_79 ? 1'h0 : i0_dp_raw_sext_h; // @[dec_decode_ctl.scala 321:33]
  assign io_decode_exu_i0_ap_slo = _T_79 ? 1'h0 : i0_dp_raw_slo; // @[dec_decode_ctl.scala 326:33]
  assign io_decode_exu_i0_ap_sro = _T_79 ? 1'h0 : i0_dp_raw_sro; // @[dec_decode_ctl.scala 327:33]
  assign io_decode_exu_i0_ap_min = _T_79 ? 1'h0 : i0_dp_raw_min; // @[dec_decode_ctl.scala 328:33]
  assign io_decode_exu_i0_ap_max = _T_79 ? 1'h0 : i0_dp_raw_max; // @[dec_decode_ctl.scala 329:33]
  assign io_decode_exu_i0_ap_pack = _T_79 ? 1'h0 : i0_dp_raw_pack; // @[dec_decode_ctl.scala 330:33]
  assign io_decode_exu_i0_ap_packu = _T_79 ? 1'h0 : i0_dp_raw_packu; // @[dec_decode_ctl.scala 331:33]
  assign io_decode_exu_i0_ap_packh = _T_79 ? 1'h0 : i0_dp_raw_packh; // @[dec_decode_ctl.scala 332:33]
  assign io_decode_exu_i0_ap_rol = _T_79 ? 1'h0 : i0_dp_raw_rol; // @[dec_decode_ctl.scala 333:33]
  assign io_decode_exu_i0_ap_ror = _T_79 ? 1'h0 : i0_dp_raw_ror; // @[dec_decode_ctl.scala 334:33]
  assign io_decode_exu_i0_ap_grev = _T_79 ? 1'h0 : i0_dp_raw_grev; // @[dec_decode_ctl.scala 335:33]
  assign io_decode_exu_i0_ap_gorc = _T_79 ? 1'h0 : i0_dp_raw_gorc; // @[dec_decode_ctl.scala 336:33]
  assign io_decode_exu_i0_ap_zbb = _T_79 ? 1'h0 : i0_dp_raw_zbb; // @[dec_decode_ctl.scala 337:33]
  assign io_decode_exu_i0_ap_sbset = _T_79 ? 1'h0 : i0_dp_raw_sbset; // @[dec_decode_ctl.scala 338:33]
  assign io_decode_exu_i0_ap_sbclr = _T_79 ? 1'h0 : i0_dp_raw_sbclr; // @[dec_decode_ctl.scala 339:33]
  assign io_decode_exu_i0_ap_sbinv = _T_79 ? 1'h0 : i0_dp_raw_sbinv; // @[dec_decode_ctl.scala 340:33]
  assign io_decode_exu_i0_ap_sbext = _T_79 ? 1'h0 : i0_dp_raw_sbext; // @[dec_decode_ctl.scala 341:33]
  assign io_decode_exu_i0_ap_sh1add = _T_79 ? 1'h0 : i0_dp_raw_sh1add; // @[dec_decode_ctl.scala 322:33]
  assign io_decode_exu_i0_ap_sh2add = _T_79 ? 1'h0 : i0_dp_raw_sh2add; // @[dec_decode_ctl.scala 323:33]
  assign io_decode_exu_i0_ap_sh3add = _T_79 ? 1'h0 : i0_dp_raw_sh3add; // @[dec_decode_ctl.scala 324:33]
  assign io_decode_exu_i0_ap_zba = _T_79 ? 1'h0 : i0_dp_raw_zba; // @[dec_decode_ctl.scala 325:33]
  assign io_decode_exu_i0_ap_land = _T_79 ? 1'h0 : i0_dp_raw_land; // @[dec_decode_ctl.scala 305:33]
  assign io_decode_exu_i0_ap_lor = _T_79 | i0_dp_raw_lor; // @[dec_decode_ctl.scala 306:33]
  assign io_decode_exu_i0_ap_lxor = _T_79 ? 1'h0 : i0_dp_raw_lxor; // @[dec_decode_ctl.scala 307:33]
  assign io_decode_exu_i0_ap_sll = _T_79 ? 1'h0 : i0_dp_raw_sll; // @[dec_decode_ctl.scala 308:33]
  assign io_decode_exu_i0_ap_srl = _T_79 ? 1'h0 : i0_dp_raw_srl; // @[dec_decode_ctl.scala 309:33]
  assign io_decode_exu_i0_ap_sra = _T_79 ? 1'h0 : i0_dp_raw_sra; // @[dec_decode_ctl.scala 310:33]
  assign io_decode_exu_i0_ap_beq = _T_79 ? 1'h0 : i0_dp_raw_beq; // @[dec_decode_ctl.scala 313:33]
  assign io_decode_exu_i0_ap_bne = _T_79 ? 1'h0 : i0_dp_raw_bne; // @[dec_decode_ctl.scala 314:33]
  assign io_decode_exu_i0_ap_blt = _T_79 ? 1'h0 : i0_dp_raw_blt; // @[dec_decode_ctl.scala 315:33]
  assign io_decode_exu_i0_ap_bge = _T_79 ? 1'h0 : i0_dp_raw_bge; // @[dec_decode_ctl.scala 316:33]
  assign io_decode_exu_i0_ap_add = _T_79 ? 1'h0 : i0_dp_raw_add; // @[dec_decode_ctl.scala 303:33]
  assign io_decode_exu_i0_ap_sub = _T_79 ? 1'h0 : i0_dp_raw_sub; // @[dec_decode_ctl.scala 304:33]
  assign io_decode_exu_i0_ap_slt = _T_79 ? 1'h0 : i0_dp_raw_slt; // @[dec_decode_ctl.scala 311:33]
  assign io_decode_exu_i0_ap_unsign = _T_79 ? 1'h0 : i0_dp_raw_unsign; // @[dec_decode_ctl.scala 312:33]
  assign io_decode_exu_i0_ap_jal = _T_420 & _T_421; // @[dec_decode_ctl.scala 344:33]
  assign io_decode_exu_i0_ap_predict_t = _T_85 & i0_predict_br; // @[dec_decode_ctl.scala 300:37]
  assign io_decode_exu_i0_ap_predict_nt = _T_86 & i0_predict_br; // @[dec_decode_ctl.scala 299:37]
  assign io_decode_exu_i0_ap_csr_write = i0_csr_write & _T_432; // @[dec_decode_ctl.scala 342:33]
  assign io_decode_exu_i0_ap_csr_imm = _T_79 ? 1'h0 : i0_dp_raw_csr_imm; // @[dec_decode_ctl.scala 343:33]
  assign io_decode_exu_dec_i0_predict_p_d_valid = i0_brp_valid & i0_legal_decode_d; // @[dec_decode_ctl.scala 232:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_misp = 1'h0; // @[dec_decode_ctl.scala 223:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_ataken = 1'h0; // @[dec_decode_ctl.scala 224:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_boffset = 1'h0; // @[dec_decode_ctl.scala 225:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pc4 = io_dec_i0_pc4_d; // @[dec_decode_ctl.scala 230:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_hist = io_dec_i0_brp_bits_hist; // @[dec_decode_ctl.scala 231:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_toffset = _T_398 ? i0_pcall_imm[11:0] : _T_407; // @[dec_decode_ctl.scala 244:56]
  assign io_decode_exu_dec_i0_predict_p_d_bits_br_error = _T_70 & _T_50; // @[dec_decode_ctl.scala 239:56]
  assign io_decode_exu_dec_i0_predict_p_d_bits_br_start_error = _T_73 & _T_50; // @[dec_decode_ctl.scala 240:56]
  assign io_decode_exu_dec_i0_predict_p_d_bits_prett = io_dec_i0_brp_bits_prett; // @[dec_decode_ctl.scala 229:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pcall = i0_dp_jal & i0_pcall_case; // @[dec_decode_ctl.scala 226:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pret = i0_dp_jal & i0_pret_case; // @[dec_decode_ctl.scala 228:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_pja = i0_dp_jal & i0_pja_case; // @[dec_decode_ctl.scala 227:55]
  assign io_decode_exu_dec_i0_predict_p_d_bits_way = io_dec_i0_brp_bits_way; // @[dec_decode_ctl.scala 246:56]
  assign io_decode_exu_i0_predict_fghr_d = io_dec_i0_bp_fghr; // @[dec_decode_ctl.scala 245:56]
  assign io_decode_exu_i0_predict_index_d = io_dec_i0_bp_index; // @[dec_decode_ctl.scala 241:56]
  assign io_decode_exu_i0_predict_btag_d = io_dec_i0_bp_btag; // @[dec_decode_ctl.scala 242:56]
  assign io_decode_exu_dec_i0_rs1_en_d = i0_dp_rs1 & _T_772; // @[dec_decode_ctl.scala 680:35]
  assign io_decode_exu_dec_i0_rs2_en_d = i0_dp_rs2 & _T_774; // @[dec_decode_ctl.scala 681:35]
  assign io_decode_exu_dec_i0_immed_d = _T_902 | _T_899; // @[dec_decode_ctl.scala 693:32]
  assign io_decode_exu_dec_i0_select_pc_d = _T_79 ? 1'h0 : i0_dp_raw_pc; // @[dec_decode_ctl.scala 291:36]
  assign io_decode_exu_dec_i0_rs1_bypass_en_d = {_T_1247,_T_1246}; // @[dec_decode_ctl.scala 916:45]
  assign io_decode_exu_dec_i0_rs2_bypass_en_d = {_T_1262,_T_1261}; // @[dec_decode_ctl.scala 917:45]
  assign io_decode_exu_mul_p_valid = i0_exulegal_decode_d & i0_dp_mul; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 471:32]
  assign io_decode_exu_mul_p_bits_rs1_sign = _T_79 ? 1'h0 : i0_dp_raw_rs1_sign; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 472:37]
  assign io_decode_exu_mul_p_bits_rs2_sign = _T_79 ? 1'h0 : i0_dp_raw_rs2_sign; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 473:37]
  assign io_decode_exu_mul_p_bits_low = _T_79 ? 1'h0 : i0_dp_raw_low; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 474:37]
  assign io_decode_exu_mul_p_bits_bext = _T_79 ? 1'h0 : i0_dp_raw_bext; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 475:37]
  assign io_decode_exu_mul_p_bits_bdep = _T_79 ? 1'h0 : i0_dp_raw_bdep; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 476:37]
  assign io_decode_exu_mul_p_bits_clmul = _T_79 ? 1'h0 : i0_dp_raw_clmul; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 477:37]
  assign io_decode_exu_mul_p_bits_clmulh = _T_79 ? 1'h0 : i0_dp_raw_clmulh; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 478:37]
  assign io_decode_exu_mul_p_bits_clmulr = _T_79 ? 1'h0 : i0_dp_raw_clmulr; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 479:37]
  assign io_decode_exu_mul_p_bits_grev = _T_79 ? 1'h0 : i0_dp_raw_grev; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 480:37]
  assign io_decode_exu_mul_p_bits_gorc = _T_79 ? 1'h0 : i0_dp_raw_gorc; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 481:37]
  assign io_decode_exu_mul_p_bits_shfl = _T_79 ? 1'h0 : i0_dp_raw_shfl; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 482:37]
  assign io_decode_exu_mul_p_bits_unshfl = _T_79 ? 1'h0 : i0_dp_raw_unshfl; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 483:37]
  assign io_decode_exu_mul_p_bits_crc32_b = _T_79 ? 1'h0 : i0_dp_raw_crc32_b; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 484:37]
  assign io_decode_exu_mul_p_bits_crc32_h = _T_79 ? 1'h0 : i0_dp_raw_crc32_h; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 485:37]
  assign io_decode_exu_mul_p_bits_crc32_w = _T_79 ? 1'h0 : i0_dp_raw_crc32_w; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 486:37]
  assign io_decode_exu_mul_p_bits_crc32c_b = _T_79 ? 1'h0 : i0_dp_raw_crc32c_b; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 487:37]
  assign io_decode_exu_mul_p_bits_crc32c_h = _T_79 ? 1'h0 : i0_dp_raw_crc32c_h; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 488:37]
  assign io_decode_exu_mul_p_bits_crc32c_w = _T_79 ? 1'h0 : i0_dp_raw_crc32c_w; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 489:37]
  assign io_decode_exu_mul_p_bits_bfp = _T_79 ? 1'h0 : i0_dp_raw_bfp; // @[dec_decode_ctl.scala 117:25 dec_decode_ctl.scala 490:37]
  assign io_decode_exu_pred_correct_npc_x = temp_pred_correct_npc_x[31:1]; // @[dec_decode_ctl.scala 877:36]
  assign io_decode_exu_dec_extint_stall = _T_12; // @[dec_decode_ctl.scala 208:35]
  assign io_dec_alu_dec_i0_alu_decode_d = i0_exulegal_decode_d & i0_dp_alu; // @[dec_decode_ctl.scala 630:34]
  assign io_dec_alu_dec_csr_ren_d = i0_dp_csr_read & io_dec_ib0_valid_d; // @[dec_decode_ctl.scala 516:29]
  assign io_dec_alu_dec_i0_br_immed_d = _T_1060 ? i0_br_offset : _T_1073; // @[dec_decode_ctl.scala 823:32]
  assign io_dec_div_div_p_valid = i0_exulegal_decode_d & i0_dp_div; // @[dec_decode_ctl.scala 467:29]
  assign io_dec_div_div_p_bits_unsign = _T_79 ? 1'h0 : i0_dp_raw_unsign; // @[dec_decode_ctl.scala 468:34]
  assign io_dec_div_div_p_bits_rem = _T_79 ? 1'h0 : i0_dp_raw_rem; // @[dec_decode_ctl.scala 469:34]
  assign io_dec_div_dec_div_cancel = _T_1102 | _T_1107; // @[dec_decode_ctl.scala 842:37]
  assign io_dec_aln_dec_i0_decode_d = _T_584 & _T_562; // @[dec_decode_ctl.scala 611:30 dec_decode_ctl.scala 674:30]
  assign io_dec_i0_inst_wb = i0_inst_wb; // @[dec_decode_ctl.scala 868:21]
  assign io_dec_i0_pc_wb = i0_pc_wb; // @[dec_decode_ctl.scala 869:19]
  assign io_dec_i0_rs1_d = io_dec_i0_instr_d[19:15]; // @[dec_decode_ctl.scala 683:19]
  assign io_dec_i0_rs2_d = io_dec_i0_instr_d[24:20]; // @[dec_decode_ctl.scala 684:19]
  assign io_dec_i0_waddr_r = _T_1001[22:18]; // @[dec_decode_ctl.scala 805:27]
  assign io_dec_i0_wen_r = _T_1046 & _T_1047; // @[dec_decode_ctl.scala 807:32]
  assign io_dec_i0_wdata_r = _T_1056 ? io_lsu_result_corr_r : i0_result_r_raw; // @[dec_decode_ctl.scala 808:26]
  assign io_dec_i0_branch_d = _T_605 | i0_br_error_all; // @[dec_decode_ctl.scala 631:26]
  assign io_dec_i0_result_r = i0_result_r_raw; // @[dec_decode_ctl.scala 919:30]
  assign io_dec_qual_lsu_d = _T_79 ? 1'h0 : i0_dp_raw_lsu; // @[dec_decode_ctl.scala 636:21]
  assign io_lsu_p_valid = io_decode_exu_dec_extint_stall | lsu_decode_d; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 498:24 dec_decode_ctl.scala 502:35]
  assign io_lsu_p_bits_fast_int = io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 497:29]
  assign io_lsu_p_bits_stack = io_decode_exu_dec_extint_stall ? 1'h0 : _T_424; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 508:29]
  assign io_lsu_p_bits_by = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_by; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 505:40]
  assign io_lsu_p_bits_half = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_half; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 506:40]
  assign io_lsu_p_bits_word = io_decode_exu_dec_extint_stall | i0_dp_word; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 496:29 dec_decode_ctl.scala 507:40]
  assign io_lsu_p_bits_dword = 1'h0; // @[dec_decode_ctl.scala 493:12]
  assign io_lsu_p_bits_load = io_decode_exu_dec_extint_stall | i0_dp_load; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 495:29 dec_decode_ctl.scala 503:40]
  assign io_lsu_p_bits_store = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_store; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 504:40]
  assign io_lsu_p_bits_unsign = io_decode_exu_dec_extint_stall ? 1'h0 : i0_dp_unsign; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 512:40]
  assign io_lsu_p_bits_dma = 1'h0; // @[dec_decode_ctl.scala 493:12]
  assign io_lsu_p_bits_store_data_bypass_d = io_decode_exu_dec_extint_stall ? 1'h0 : store_data_bypass_d; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 510:40]
  assign io_lsu_p_bits_load_ldst_bypass_d = io_decode_exu_dec_extint_stall ? 1'h0 : load_ldst_bypass_d; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 509:40]
  assign io_lsu_p_bits_store_data_bypass_m = 1'h0; // @[dec_decode_ctl.scala 493:12 dec_decode_ctl.scala 511:40]
  assign io_div_waddr_wb = _T_1122; // @[dec_decode_ctl.scala 860:19]
  assign io_dec_lsu_valid_raw_d = _T_1269 | io_decode_exu_dec_extint_stall; // @[dec_decode_ctl.scala 921:26]
  assign io_dec_lsu_offset_d = _T_1283 | _T_1284; // @[dec_decode_ctl.scala 922:23]
  assign io_dec_csr_wen_unq_d = _T_435 & io_dec_ib0_valid_d; // @[dec_decode_ctl.scala 525:24]
  assign io_dec_csr_any_unq_d = any_csr_d & io_dec_ib0_valid_d; // @[dec_decode_ctl.scala 528:24]
  assign io_dec_csr_rdaddr_d = _T_439 & io_dec_i0_instr_d[31:20]; // @[dec_decode_ctl.scala 529:24]
  assign io_dec_csr_wen_r = _T_442 & _T_1043; // @[dec_decode_ctl.scala 534:20]
  assign io_dec_csr_wraddr_r = _T_444 & r_d_bits_csrwaddr; // @[dec_decode_ctl.scala 530:24]
  assign io_dec_csr_wrdata_r = _T_524 ? i0_result_corr_r : write_csr_data; // @[dec_decode_ctl.scala 574:24]
  assign io_dec_csr_stall_int_ff = _T_453 & _T_454; // @[dec_decode_ctl.scala 537:27]
  assign io_dec_tlu_i0_valid_r = r_d_valid & _T_1012; // @[dec_decode_ctl.scala 637:29]
  assign io_dec_tlu_packet_r_legal = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_legal; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_icaf = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_icaf; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_icaf_second = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_icaf_second; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_icaf_type = io_dec_tlu_flush_lower_wb ? 2'h0 : r_t_icaf_type; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_fence_i = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_fence_i; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_i0trigger = io_dec_tlu_flush_lower_wb ? 4'h0 : _T_759; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_pmu_i0_itype = io_dec_tlu_flush_lower_wb ? 4'h0 : r_t_pmu_i0_itype; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_pmu_i0_br_unpred = io_dec_tlu_flush_lower_wb ? 1'h0 : r_t_pmu_i0_br_unpred; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_packet_r_pmu_divide = r_d_bits_i0div & r_d_valid; // @[dec_decode_ctl.scala 669:39 dec_decode_ctl.scala 670:39]
  assign io_dec_tlu_packet_r_pmu_lsu_misaligned = io_dec_tlu_flush_lower_wb ? 1'h0 : lsu_pmu_misaligned_r; // @[dec_decode_ctl.scala 669:39]
  assign io_dec_tlu_i0_pc_r = {_T_1138,_T_1140}; // @[dec_decode_ctl.scala 872:27]
  assign io_dec_illegal_inst = _T_560; // @[dec_decode_ctl.scala 596:23]
  assign io_dec_fa_error_index = 9'h0; // @[dec_decode_ctl.scala 255:27]
  assign io_dec_pmu_instr_decoded = io_dec_aln_dec_i0_decode_d; // @[dec_decode_ctl.scala 616:28]
  assign io_dec_pmu_decode_stall = io_dec_ib0_valid_d & _T_592; // @[dec_decode_ctl.scala 617:27]
  assign io_dec_pmu_presync_stall = presync_stall & io_dec_ib0_valid_d; // @[dec_decode_ctl.scala 619:29]
  assign io_dec_pmu_postsync_stall = postsync_stall & io_dec_ib0_valid_d; // @[dec_decode_ctl.scala 618:29]
  assign io_dec_nonblock_load_wen = _T_278 & _T_279; // @[dec_decode_ctl.scala 399:28]
  assign io_dec_nonblock_load_waddr = _T_324 | _T_316; // @[dec_decode_ctl.scala 396:29 dec_decode_ctl.scala 406:29]
  assign io_dec_pause_state = pause_stall; // @[dec_decode_ctl.scala 560:22]
  assign io_dec_pause_state_cg = pause_stall & _T_514; // @[dec_decode_ctl.scala 562:25]
  assign io_dec_div_active = _T_42; // @[dec_decode_ctl.scala 217:35]
  assign rvclkhdr_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_io_en = |_T_2; // @[lib.scala 447:19]
  assign rvclkhdr_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_1_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_1_io_en = |_T_6; // @[lib.scala 447:19]
  assign rvclkhdr_1_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_2_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_2_io_en = |_T_10; // @[lib.scala 447:19]
  assign rvclkhdr_2_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_3_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_3_io_en = |_T_14; // @[lib.scala 447:19]
  assign rvclkhdr_3_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_4_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_4_io_en = |_T_18; // @[lib.scala 447:19]
  assign rvclkhdr_4_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_5_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_5_io_en = |_T_22; // @[lib.scala 447:19]
  assign rvclkhdr_5_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_6_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_6_io_en = |_T_26; // @[lib.scala 447:19]
  assign rvclkhdr_6_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_7_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_7_io_en = |_T_30; // @[lib.scala 447:19]
  assign rvclkhdr_7_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_8_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_8_io_en = |_T_33; // @[lib.scala 447:19]
  assign rvclkhdr_8_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_9_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_9_io_en = |_T_36; // @[lib.scala 447:19]
  assign rvclkhdr_9_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_10_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_10_io_en = |_T_40; // @[lib.scala 447:19]
  assign rvclkhdr_10_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_11_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_11_io_en = |_T_44; // @[lib.scala 447:19]
  assign rvclkhdr_11_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_12_io_clk = io_free_l2clk; // @[lib.scala 446:20]
  assign rvclkhdr_12_io_en = |_T_47; // @[lib.scala 447:19]
  assign rvclkhdr_12_io_scan_mode = io_scan_mode; // @[lib.scala 448:26]
  assign rvclkhdr_13_io_clk = clock; // @[lib.scala 470:20]
  assign rvclkhdr_13_io_en = _T_157 | _T_159; // @[lib.scala 471:19]
  assign rvclkhdr_13_io_scan_mode = io_scan_mode; // @[lib.scala 472:26]
  assign rvclkhdr_14_io_clk = clock; // @[lib.scala 470:20]
  assign rvclkhdr_14_io_en = _T_193 | _T_195; // @[lib.scala 471:19]
  assign rvclkhdr_14_io_scan_mode = io_scan_mode; // @[lib.scala 472:26]
  assign rvclkhdr_15_io_clk = clock; // @[lib.scala 470:20]
  assign rvclkhdr_15_io_en = _T_229 | _T_231; // @[lib.scala 471:19]
  assign rvclkhdr_15_io_scan_mode = io_scan_mode; // @[lib.scala 472:26]
  assign rvclkhdr_16_io_clk = clock; // @[lib.scala 470:20]
  assign rvclkhdr_16_io_en = _T_265 | _T_267; // @[lib.scala 471:19]
  assign rvclkhdr_16_io_scan_mode = io_scan_mode; // @[lib.scala 472:26]
  assign i0_dec_io_ins = io_dec_i0_instr_d; // @[dec_decode_ctl.scala 439:16]
  assign rvclkhdr_17_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_17_io_en = i0_pipe_en[3] | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_17_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_18_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_18_io_en = i0_pipe_en[3] | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_18_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_19_io_clk = io_free_l2clk; // @[lib.scala 394:18]
  assign rvclkhdr_19_io_en = _T_522 | pause_stall; // @[lib.scala 395:17]
  assign rvclkhdr_19_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_20_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_20_io_en = shift_illegal & _T_559; // @[lib.scala 395:17]
  assign rvclkhdr_20_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_21_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_21_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_21_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_22_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_22_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_22_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_23_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_23_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_23_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_24_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_24_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_24_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_25_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_25_io_en = _T_629 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_25_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_26_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_26_io_en = _T_635 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_26_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_27_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_27_io_en = _T_641 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_27_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_28_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_28_io_en = _T_647 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_28_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_29_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_29_io_en = _T_653 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_29_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_30_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_30_io_en = _T_659 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_30_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_31_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_31_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_31_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_32_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_32_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_32_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_33_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_33_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_33_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_34_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_34_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_34_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_35_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_35_io_en = _T_698 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_35_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_36_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_36_io_en = _T_704 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_36_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_37_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_37_io_en = _T_710 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_37_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_38_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_38_io_en = _T_716 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_38_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_39_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_39_io_en = _T_722 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_39_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_40_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_40_io_en = _T_728 & i0_x_ctl_en; // @[lib.scala 395:17]
  assign rvclkhdr_40_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_41_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_41_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_41_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_42_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_42_io_en = _T_933 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_42_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_43_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_43_io_en = _T_936 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_43_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_44_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_44_io_en = _T_936 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_44_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_45_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_45_io_en = _T_939 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_45_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_46_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_46_io_en = _T_939 | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_46_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_47_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_47_io_en = i0_r_data_en & _T_1050; // @[lib.scala 395:17]
  assign rvclkhdr_47_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_48_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_48_io_en = i0_pipe_en[3] | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_48_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_49_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_49_io_en = i0_legal_decode_d & i0_dp_div; // @[lib.scala 395:17]
  assign rvclkhdr_49_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_50_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_50_io_en = i0_x_data_en & trace_enable; // @[lib.scala 395:17]
  assign rvclkhdr_50_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_51_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_51_io_en = i0_r_data_en & trace_enable; // @[lib.scala 395:17]
  assign rvclkhdr_51_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_52_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_52_io_en = i0_wb_data_en & trace_enable; // @[lib.scala 395:17]
  assign rvclkhdr_52_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_53_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_53_io_en = i0_wb_data_en & trace_enable; // @[lib.scala 395:17]
  assign rvclkhdr_53_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_54_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_54_io_en = _T_1136 & i0_r_data_en; // @[lib.scala 395:17]
  assign rvclkhdr_54_io_scan_mode = 1'h0; // @[lib.scala 396:24]
  assign rvclkhdr_55_io_clk = clock; // @[lib.scala 394:18]
  assign rvclkhdr_55_io_en = i0_pipe_en[2] | io_clk_override; // @[lib.scala 395:17]
  assign rvclkhdr_55_io_scan_mode = 1'h0; // @[lib.scala 396:24]
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
  leak1_i1_stall = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  leak1_i0_stall = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  _T_12 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  pause_stall = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  write_csr_data = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  tlu_wr_pause_r1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  tlu_wr_pause_r2 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  illegal_lockout = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  flush_final_r = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  postsync_stall = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  _T_967 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  _T_966 = _RAND_11[22:0];
  _RAND_12 = {1{`RANDOM}};
  lsu_trigger_match_r = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  lsu_pmu_misaligned_r = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  _T_998 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  _T_997 = _RAND_15[22:0];
  _RAND_16 = {1{`RANDOM}};
  _T_42 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  debug_valid_x = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  cam_raw_0_bits_tag = _RAND_18[2:0];
  _RAND_19 = {1{`RANDOM}};
  cam_raw_0_valid = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  cam_raw_1_bits_tag = _RAND_20[2:0];
  _RAND_21 = {1{`RANDOM}};
  cam_raw_1_valid = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  cam_raw_2_bits_tag = _RAND_22[2:0];
  _RAND_23 = {1{`RANDOM}};
  cam_raw_2_valid = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  cam_raw_3_bits_tag = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  cam_raw_3_valid = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  _T_930 = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  nonblock_load_valid_m_delay = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  cam_raw_0_bits_rd = _RAND_28[4:0];
  _RAND_29 = {1{`RANDOM}};
  cam_raw_0_bits_wb = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  cam_raw_1_bits_rd = _RAND_30[4:0];
  _RAND_31 = {1{`RANDOM}};
  cam_raw_1_bits_wb = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  cam_raw_2_bits_rd = _RAND_32[4:0];
  _RAND_33 = {1{`RANDOM}};
  cam_raw_2_bits_wb = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  cam_raw_3_bits_rd = _RAND_34[4:0];
  _RAND_35 = {1{`RANDOM}};
  cam_raw_3_bits_wb = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  lsu_idle = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  i0_x_c_load = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  i0_r_c_load = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  csr_read_x = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  csr_clr_x = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  csr_set_x = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  csr_write_x = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  csr_imm_x = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  csrimm_x = _RAND_44[4:0];
  _RAND_45 = {1{`RANDOM}};
  csr_rddata_x = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  i0_result_r_raw = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  _T_1029 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  _T_1028 = _RAND_48[22:0];
  _RAND_49 = {1{`RANDOM}};
  _T_560 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  _T_624 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  _T_625 = _RAND_51[3:0];
  _RAND_52 = {1{`RANDOM}};
  _T_631 = _RAND_52[3:0];
  _RAND_53 = {1{`RANDOM}};
  _T_637 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  _T_643 = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  _T_649 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  _T_655 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  _T_661 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  _T_691 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  _T_692 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  _T_693 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  _T_694 = _RAND_61[3:0];
  _RAND_62 = {1{`RANDOM}};
  _T_700 = _RAND_62[3:0];
  _RAND_63 = {1{`RANDOM}};
  _T_706 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  _T_712 = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  _T_718 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  _T_724 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  _T_730 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  i0_x_c_mul = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  i0_x_c_alu = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  i0_r_c_mul = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  i0_r_c_alu = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  last_br_immed_x = _RAND_72[11:0];
  _RAND_73 = {1{`RANDOM}};
  _T_1122 = _RAND_73[4:0];
  _RAND_74 = {1{`RANDOM}};
  i0_inst_x = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  i0_inst_r = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  i0_inst_wb = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  i0_pc_wb = _RAND_77[30:0];
  _RAND_78 = {1{`RANDOM}};
  _T_1138 = _RAND_78[18:0];
  _RAND_79 = {1{`RANDOM}};
  _T_1140 = _RAND_79[11:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    leak1_i1_stall = 1'h0;
  end
  if (reset) begin
    leak1_i0_stall = 1'h0;
  end
  if (reset) begin
    _T_12 = 1'h0;
  end
  if (reset) begin
    pause_stall = 1'h0;
  end
  if (reset) begin
    write_csr_data = 32'h0;
  end
  if (reset) begin
    tlu_wr_pause_r1 = 1'h0;
  end
  if (reset) begin
    tlu_wr_pause_r2 = 1'h0;
  end
  if (reset) begin
    illegal_lockout = 1'h0;
  end
  if (reset) begin
    flush_final_r = 1'h0;
  end
  if (reset) begin
    postsync_stall = 1'h0;
  end
  if (reset) begin
    _T_967 = 1'h0;
  end
  if (reset) begin
    _T_966 = 23'h0;
  end
  if (reset) begin
    lsu_trigger_match_r = 4'h0;
  end
  if (reset) begin
    lsu_pmu_misaligned_r = 1'h0;
  end
  if (reset) begin
    _T_998 = 1'h0;
  end
  if (reset) begin
    _T_997 = 23'h0;
  end
  if (reset) begin
    _T_42 = 1'h0;
  end
  if (reset) begin
    debug_valid_x = 1'h0;
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
    _T_930 = 3'h0;
  end
  if (reset) begin
    nonblock_load_valid_m_delay = 1'h0;
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
    i0_x_c_load = 1'h0;
  end
  if (reset) begin
    i0_r_c_load = 1'h0;
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
    i0_result_r_raw = 32'h0;
  end
  if (reset) begin
    _T_1029 = 1'h0;
  end
  if (reset) begin
    _T_1028 = 23'h0;
  end
  if (reset) begin
    _T_560 = 32'h0;
  end
  if (reset) begin
    _T_624 = 1'h0;
  end
  if (reset) begin
    _T_625 = 4'h0;
  end
  if (reset) begin
    _T_631 = 4'h0;
  end
  if (reset) begin
    _T_637 = 1'h0;
  end
  if (reset) begin
    _T_643 = 2'h0;
  end
  if (reset) begin
    _T_649 = 1'h0;
  end
  if (reset) begin
    _T_655 = 1'h0;
  end
  if (reset) begin
    _T_661 = 1'h0;
  end
  if (reset) begin
    _T_691 = 1'h0;
  end
  if (reset) begin
    _T_692 = 1'h0;
  end
  if (reset) begin
    _T_693 = 1'h0;
  end
  if (reset) begin
    _T_694 = 4'h0;
  end
  if (reset) begin
    _T_700 = 4'h0;
  end
  if (reset) begin
    _T_706 = 1'h0;
  end
  if (reset) begin
    _T_712 = 2'h0;
  end
  if (reset) begin
    _T_718 = 1'h0;
  end
  if (reset) begin
    _T_724 = 1'h0;
  end
  if (reset) begin
    _T_730 = 1'h0;
  end
  if (reset) begin
    i0_x_c_mul = 1'h0;
  end
  if (reset) begin
    i0_x_c_alu = 1'h0;
  end
  if (reset) begin
    i0_r_c_mul = 1'h0;
  end
  if (reset) begin
    i0_r_c_alu = 1'h0;
  end
  if (reset) begin
    last_br_immed_x = 12'h0;
  end
  if (reset) begin
    _T_1122 = 5'h0;
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
    i0_pc_wb = 31'h0;
  end
  if (reset) begin
    _T_1138 = 19'h0;
  end
  if (reset) begin
    _T_1140 = 12'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge rvclkhdr_io_l1clk or posedge reset) begin
    if (reset) begin
      leak1_i1_stall <= 1'h0;
    end else begin
      leak1_i1_stall <= io_dec_tlu_flush_leak_one_r | _T_367;
    end
  end
  always @(posedge rvclkhdr_1_io_l1clk or posedge reset) begin
    if (reset) begin
      leak1_i0_stall <= 1'h0;
    end else begin
      leak1_i0_stall <= _T_369 | _T_371;
    end
  end
  always @(posedge rvclkhdr_2_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_12 <= 1'h0;
    end else begin
      _T_12 <= io_dec_tlu_flush_extint;
    end
  end
  always @(posedge rvclkhdr_3_io_l1clk or posedge reset) begin
    if (reset) begin
      pause_stall <= 1'h0;
    end else begin
      pause_stall <= _T_509 & _T_510;
    end
  end
  always @(posedge rvclkhdr_19_io_l1clk or posedge reset) begin
    if (reset) begin
      write_csr_data <= 32'h0;
    end else if (pause_stall) begin
      write_csr_data <= _T_517;
    end else if (io_dec_tlu_wr_pause_r) begin
      write_csr_data <= io_dec_csr_wrdata_r;
    end else begin
      write_csr_data <= write_csr_data_x;
    end
  end
  always @(posedge rvclkhdr_4_io_l1clk or posedge reset) begin
    if (reset) begin
      tlu_wr_pause_r1 <= 1'h0;
    end else begin
      tlu_wr_pause_r1 <= io_dec_tlu_wr_pause_r;
    end
  end
  always @(posedge rvclkhdr_5_io_l1clk or posedge reset) begin
    if (reset) begin
      tlu_wr_pause_r2 <= 1'h0;
    end else begin
      tlu_wr_pause_r2 <= tlu_wr_pause_r1;
    end
  end
  always @(posedge rvclkhdr_6_io_l1clk or posedge reset) begin
    if (reset) begin
      illegal_lockout <= 1'h0;
    end else begin
      illegal_lockout <= _T_561 & _T_562;
    end
  end
  always @(posedge rvclkhdr_11_io_l1clk or posedge reset) begin
    if (reset) begin
      flush_final_r <= 1'h0;
    end else begin
      flush_final_r <= io_exu_flush_final;
    end
  end
  always @(posedge rvclkhdr_7_io_l1clk or posedge reset) begin
    if (reset) begin
      postsync_stall <= 1'h0;
    end else begin
      postsync_stall <= _T_601 | _T_602;
    end
  end
  always @(posedge rvclkhdr_42_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_967 <= 1'h0;
    end else begin
      _T_967 <= io_dec_aln_dec_i0_decode_d;
    end
  end
  always @(posedge rvclkhdr_41_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_966 <= 23'h0;
    end else begin
      _T_966 <= {_T_964,_T_961};
    end
  end
  always @(posedge rvclkhdr_8_io_l1clk or posedge reset) begin
    if (reset) begin
      lsu_trigger_match_r <= 4'h0;
    end else begin
      lsu_trigger_match_r <= io_lsu_trigger_match_m;
    end
  end
  always @(posedge rvclkhdr_9_io_l1clk or posedge reset) begin
    if (reset) begin
      lsu_pmu_misaligned_r <= 1'h0;
    end else begin
      lsu_pmu_misaligned_r <= io_lsu_pmu_misaligned_m;
    end
  end
  always @(posedge rvclkhdr_44_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_998 <= 1'h0;
    end else begin
      _T_998 <= _T_986 & _T_366;
    end
  end
  always @(posedge rvclkhdr_43_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_997 <= 23'h0;
    end else begin
      _T_997 <= {_T_995,_T_992};
    end
  end
  always @(posedge rvclkhdr_10_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_42 <= 1'h0;
    end else begin
      _T_42 <= i0_div_decode_d | _T_1112;
    end
  end
  always @(posedge rvclkhdr_12_io_l1clk or posedge reset) begin
    if (reset) begin
      debug_valid_x <= 1'h0;
    end else begin
      debug_valid_x <= io_dec_debug_valid_d;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_bits_tag <= 3'h0;
    end else if (cam_wen[0]) begin
      cam_raw_0_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_145) begin
      cam_raw_0_bits_tag <= 3'h0;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_0_valid <= 1'h0;
    end else begin
      cam_raw_0_valid <= _GEN_101;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_bits_tag <= 3'h0;
    end else if (cam_wen[1]) begin
      cam_raw_1_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_181) begin
      cam_raw_1_bits_tag <= 3'h0;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_1_valid <= 1'h0;
    end else begin
      cam_raw_1_valid <= _GEN_112;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_bits_tag <= 3'h0;
    end else if (cam_wen[2]) begin
      cam_raw_2_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_217) begin
      cam_raw_2_bits_tag <= 3'h0;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_2_valid <= 1'h0;
    end else begin
      cam_raw_2_valid <= _GEN_123;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_bits_tag <= 3'h0;
    end else if (cam_wen[3]) begin
      cam_raw_3_bits_tag <= {{1'd0}, io_dctl_busbuff_lsu_nonblock_load_tag_m};
    end else if (_T_253) begin
      cam_raw_3_bits_tag <= 3'h0;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_valid <= 1'h0;
    end else if (io_dec_tlu_force_halt) begin
      cam_raw_3_valid <= 1'h0;
    end else begin
      cam_raw_3_valid <= _GEN_134;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      _T_930 <= 3'h0;
    end else begin
      _T_930 <= i0_pipe_en[3:1];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      nonblock_load_valid_m_delay <= 1'h0;
    end else if (i0_r_ctl_en) begin
      nonblock_load_valid_m_delay <= io_dctl_busbuff_lsu_nonblock_load_valid_m;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_bits_rd <= 5'h0;
    end else if (cam_wen[0]) begin
      if (x_d_bits_i0load) begin
        cam_raw_0_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_0_bits_rd <= 5'h0;
      end
    end else if (_T_145) begin
      cam_raw_0_bits_rd <= 5'h0;
    end
  end
  always @(posedge rvclkhdr_13_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_0_bits_wb <= 1'h0;
    end else begin
      cam_raw_0_bits_wb <= _T_150 | _GEN_102;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_bits_rd <= 5'h0;
    end else if (cam_wen[1]) begin
      if (x_d_bits_i0load) begin
        cam_raw_1_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_1_bits_rd <= 5'h0;
      end
    end else if (_T_181) begin
      cam_raw_1_bits_rd <= 5'h0;
    end
  end
  always @(posedge rvclkhdr_14_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_1_bits_wb <= 1'h0;
    end else begin
      cam_raw_1_bits_wb <= _T_186 | _GEN_113;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_bits_rd <= 5'h0;
    end else if (cam_wen[2]) begin
      if (x_d_bits_i0load) begin
        cam_raw_2_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_2_bits_rd <= 5'h0;
      end
    end else if (_T_217) begin
      cam_raw_2_bits_rd <= 5'h0;
    end
  end
  always @(posedge rvclkhdr_15_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_2_bits_wb <= 1'h0;
    end else begin
      cam_raw_2_bits_wb <= _T_222 | _GEN_124;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_bits_rd <= 5'h0;
    end else if (cam_wen[3]) begin
      if (x_d_bits_i0load) begin
        cam_raw_3_bits_rd <= x_d_bits_i0rd;
      end else begin
        cam_raw_3_bits_rd <= 5'h0;
      end
    end else if (_T_253) begin
      cam_raw_3_bits_rd <= 5'h0;
    end
  end
  always @(posedge rvclkhdr_16_io_l1clk or posedge reset) begin
    if (reset) begin
      cam_raw_3_bits_wb <= 1'h0;
    end else begin
      cam_raw_3_bits_wb <= _T_258 | _GEN_135;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      lsu_idle <= 1'h0;
    end else begin
      lsu_idle <= io_lsu_idle_any;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      i0_x_c_load <= 1'h0;
    end else if (i0_x_ctl_en) begin
      i0_x_c_load <= i0_d_c_load;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      i0_r_c_load <= 1'h0;
    end else if (i0_r_ctl_en) begin
      i0_r_c_load <= i0_x_c_load;
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
    end else if (_T_79) begin
      csr_imm_x <= 1'h0;
    end else begin
      csr_imm_x <= i0_dp_raw_csr_imm;
    end
  end
  always @(posedge rvclkhdr_17_io_l1clk or posedge reset) begin
    if (reset) begin
      csrimm_x <= 5'h0;
    end else begin
      csrimm_x <= io_dec_i0_instr_d[19:15];
    end
  end
  always @(posedge rvclkhdr_18_io_l1clk or posedge reset) begin
    if (reset) begin
      csr_rddata_x <= 32'h0;
    end else begin
      csr_rddata_x <= io_dec_csr_rddata_d;
    end
  end
  always @(posedge rvclkhdr_47_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_result_r_raw <= 32'h0;
    end else if (_T_1053) begin
      i0_result_r_raw <= io_lsu_result_m;
    end else begin
      i0_result_r_raw <= io_decode_exu_exu_i0_result_x;
    end
  end
  always @(posedge rvclkhdr_46_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1029 <= 1'h0;
    end else begin
      _T_1029 <= r_d_valid & _T_1012;
    end
  end
  always @(posedge rvclkhdr_45_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1028 <= 23'h0;
    end else begin
      _T_1028 <= {_T_1026,_T_1023};
    end
  end
  always @(posedge rvclkhdr_20_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_560 <= 32'h0;
    end else if (io_dec_i0_pc4_d) begin
      _T_560 <= io_dec_i0_instr_d;
    end else begin
      _T_560 <= _T_557;
    end
  end
  always @(posedge rvclkhdr_23_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_624 <= 1'h0;
    end else begin
      _T_624 <= i0_dp_jal & _T_331;
    end
  end
  always @(posedge rvclkhdr_24_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_625 <= 4'h0;
    end else begin
      _T_625 <= _T_333 & _T_363;
    end
  end
  always @(posedge rvclkhdr_25_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_631 <= 4'h0;
    end else begin
      _T_631 <= io_dec_i0_trigger_match_d & _T_619;
    end
  end
  always @(posedge rvclkhdr_26_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_637 <= 1'h0;
    end else begin
      _T_637 <= _T_614 & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_27_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_643 <= 2'h0;
    end else begin
      _T_643 <= io_dec_i0_icaf_type_d;
    end
  end
  always @(posedge rvclkhdr_28_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_649 <= 1'h0;
    end else begin
      _T_649 <= io_dec_i0_icaf_second_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_29_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_655 <= 1'h0;
    end else begin
      _T_655 <= i0_icaf_d & i0_legal_decode_d;
    end
  end
  always @(posedge rvclkhdr_30_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_661 <= 1'h0;
    end else begin
      _T_661 <= io_dec_aln_dec_i0_decode_d & i0_legal;
    end
  end
  always @(posedge rvclkhdr_31_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_691 <= 1'h0;
    end else begin
      _T_691 <= _T_672[0];
    end
  end
  always @(posedge rvclkhdr_32_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_692 <= 1'h0;
    end else begin
      _T_692 <= _T_672[1];
    end
  end
  always @(posedge rvclkhdr_33_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_693 <= 1'h0;
    end else begin
      _T_693 <= _T_672[2];
    end
  end
  always @(posedge rvclkhdr_34_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_694 <= 4'h0;
    end else begin
      _T_694 <= _T_672[6:3];
    end
  end
  always @(posedge rvclkhdr_35_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_700 <= 4'h0;
    end else begin
      _T_700 <= x_t_i0trigger & _T_688;
    end
  end
  always @(posedge rvclkhdr_36_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_706 <= 1'h0;
    end else begin
      _T_706 <= _T_672[11];
    end
  end
  always @(posedge rvclkhdr_37_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_712 <= 2'h0;
    end else begin
      _T_712 <= _T_672[13:12];
    end
  end
  always @(posedge rvclkhdr_38_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_718 <= 1'h0;
    end else begin
      _T_718 <= _T_672[14];
    end
  end
  always @(posedge rvclkhdr_39_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_724 <= 1'h0;
    end else begin
      _T_724 <= _T_672[15];
    end
  end
  always @(posedge rvclkhdr_40_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_730 <= 1'h0;
    end else begin
      _T_730 <= _T_672[16];
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      i0_x_c_mul <= 1'h0;
    end else if (i0_x_ctl_en) begin
      i0_x_c_mul <= i0_d_c_mul;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      i0_x_c_alu <= 1'h0;
    end else if (i0_x_ctl_en) begin
      i0_x_c_alu <= i0_d_c_alu;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      i0_r_c_mul <= 1'h0;
    end else if (i0_r_ctl_en) begin
      i0_r_c_mul <= i0_x_c_mul;
    end
  end
  always @(posedge io_active_clk or posedge reset) begin
    if (reset) begin
      i0_r_c_alu <= 1'h0;
    end else if (i0_r_ctl_en) begin
      i0_r_c_alu <= i0_x_c_alu;
    end
  end
  always @(posedge rvclkhdr_48_io_l1clk or posedge reset) begin
    if (reset) begin
      last_br_immed_x <= 12'h0;
    end else if (io_decode_exu_i0_ap_predict_nt) begin
      last_br_immed_x <= _T_1073;
    end else if (_T_398) begin
      last_br_immed_x <= i0_pcall_imm[11:0];
    end else begin
      last_br_immed_x <= _T_407;
    end
  end
  always @(posedge rvclkhdr_49_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1122 <= 5'h0;
    end else begin
      _T_1122 <= io_dec_i0_instr_d[11:7];
    end
  end
  always @(posedge rvclkhdr_50_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_inst_x <= 32'h0;
    end else if (io_dec_i0_pc4_d) begin
      i0_inst_x <= io_dec_i0_instr_d;
    end else begin
      i0_inst_x <= _T_557;
    end
  end
  always @(posedge rvclkhdr_51_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_inst_r <= 32'h0;
    end else begin
      i0_inst_r <= i0_inst_x;
    end
  end
  always @(posedge rvclkhdr_52_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_inst_wb <= 32'h0;
    end else begin
      i0_inst_wb <= i0_inst_r;
    end
  end
  always @(posedge rvclkhdr_53_io_l1clk or posedge reset) begin
    if (reset) begin
      i0_pc_wb <= 31'h0;
    end else begin
      i0_pc_wb <= io_dec_tlu_i0_pc_r;
    end
  end
  always @(posedge rvclkhdr_54_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1138 <= 19'h0;
    end else begin
      _T_1138 <= io_dec_alu_exu_i0_pc_x[30:12];
    end
  end
  always @(posedge rvclkhdr_55_io_l1clk or posedge reset) begin
    if (reset) begin
      _T_1140 <= 12'h0;
    end else begin
      _T_1140 <= io_dec_alu_exu_i0_pc_x[11:0];
    end
  end
endmodule
