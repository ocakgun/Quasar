module el2_ifu_compress_ctl(
  input         clock,
  input         reset,
  input  [31:0] io_din,
  output [31:0] io_dout_bits,
  output [4:0]  io_dout_rd,
  output [4:0]  io_dout_rs1,
  output [4:0]  io_dout_rs2,
  output [4:0]  io_dout_rs3
);
  wire  _T_3 = |io_din[12:5]; // @[el2_ifu_compress_ctl.scala 257:29]
  wire [6:0] _T_4 = _T_3 ? 7'h13 : 7'h1f; // @[el2_ifu_compress_ctl.scala 257:20]
  wire [4:0] _T_14 = {2'h1,io_din[4:2]}; // @[Cat.scala 29:58]
  wire [29:0] _T_18 = {io_din[10:7],io_din[12:11],io_din[5],io_din[6],2'h0,5'h2,3'h0,2'h1,io_din[4:2],_T_4}; // @[Cat.scala 29:58]
  wire [7:0] _T_28 = {io_din[6:5],io_din[12:10],3'h0}; // @[Cat.scala 29:58]
  wire [4:0] _T_30 = {2'h1,io_din[9:7]}; // @[Cat.scala 29:58]
  wire [27:0] _T_36 = {io_din[6:5],io_din[12:10],3'h0,2'h1,io_din[9:7],3'h3,2'h1,io_din[4:2],7'h7}; // @[Cat.scala 29:58]
  wire [6:0] _T_50 = {io_din[5],io_din[12:10],io_din[6],2'h0}; // @[Cat.scala 29:58]
  wire [26:0] _T_58 = {io_din[5],io_din[12:10],io_din[6],2'h0,2'h1,io_din[9:7],3'h2,2'h1,io_din[4:2],7'h3}; // @[Cat.scala 29:58]
  wire [26:0] _T_80 = {io_din[5],io_din[12:10],io_din[6],2'h0,2'h1,io_din[9:7],3'h2,2'h1,io_din[4:2],7'h7}; // @[Cat.scala 29:58]
  wire [26:0] _T_111 = {_T_50[6:5],2'h1,io_din[4:2],2'h1,io_din[9:7],3'h2,_T_50[4:0],7'h3f}; // @[Cat.scala 29:58]
  wire [27:0] _T_138 = {_T_28[7:5],2'h1,io_din[4:2],2'h1,io_din[9:7],3'h3,_T_28[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [26:0] _T_169 = {_T_50[6:5],2'h1,io_din[4:2],2'h1,io_din[9:7],3'h2,_T_50[4:0],7'h23}; // @[Cat.scala 29:58]
  wire [26:0] _T_200 = {_T_50[6:5],2'h1,io_din[4:2],2'h1,io_din[9:7],3'h2,_T_50[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [6:0] _T_211 = io_din[12] ? 7'h7f : 7'h0; // @[Bitwise.scala 72:12]
  wire [11:0] _T_213 = {_T_211,io_din[6:2]}; // @[Cat.scala 29:58]
  wire [31:0] _T_219 = {_T_211,io_din[6:2],io_din[11:7],3'h0,io_din[11:7],7'h13}; // @[Cat.scala 29:58]
  wire [9:0] _T_228 = io_din[12] ? 10'h3ff : 10'h0; // @[Bitwise.scala 72:12]
  wire [20:0] _T_243 = {_T_228,io_din[8],io_din[10:9],io_din[6],io_din[7],io_din[2],io_din[11],io_din[5:3],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_306 = {_T_243[20],_T_243[10:1],_T_243[11],_T_243[19:12],5'h1,7'h6f}; // @[Cat.scala 29:58]
  wire [31:0] _T_321 = {_T_211,io_din[6:2],5'h0,3'h0,io_din[11:7],7'h13}; // @[Cat.scala 29:58]
  wire  _T_332 = |_T_213; // @[el2_ifu_compress_ctl.scala 294:29]
  wire [6:0] _T_333 = _T_332 ? 7'h37 : 7'h3f; // @[el2_ifu_compress_ctl.scala 294:20]
  wire [14:0] _T_336 = io_din[12] ? 15'h7fff : 15'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_339 = {_T_336,io_din[6:2],12'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_343 = {_T_339[31:12],io_din[11:7],_T_333}; // @[Cat.scala 29:58]
  wire  _T_351 = io_din[11:7] == 5'h0; // @[el2_ifu_compress_ctl.scala 296:14]
  wire  _T_353 = io_din[11:7] == 5'h2; // @[el2_ifu_compress_ctl.scala 296:27]
  wire  _T_354 = _T_351 | _T_353; // @[el2_ifu_compress_ctl.scala 296:21]
  wire [6:0] _T_361 = _T_332 ? 7'h13 : 7'h1f; // @[el2_ifu_compress_ctl.scala 290:20]
  wire [2:0] _T_364 = io_din[12] ? 3'h7 : 3'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_379 = {_T_364,io_din[4:3],io_din[5],io_din[2],io_din[6],4'h0,io_din[11:7],3'h0,io_din[11:7],_T_361}; // @[Cat.scala 29:58]
  wire [31:0] _T_386_bits = _T_354 ? _T_379 : _T_343; // @[el2_ifu_compress_ctl.scala 296:10]
  wire [4:0] _T_386_rd = _T_354 ? io_din[11:7] : io_din[11:7]; // @[el2_ifu_compress_ctl.scala 296:10]
  wire [4:0] _T_386_rs2 = _T_354 ? _T_14 : _T_14; // @[el2_ifu_compress_ctl.scala 296:10]
  wire [4:0] _T_386_rs3 = _T_354 ? io_din[31:27] : io_din[31:27]; // @[el2_ifu_compress_ctl.scala 296:10]
  wire [25:0] _T_397 = {io_din[12],io_din[6:2],2'h1,io_din[9:7],3'h5,2'h1,io_din[9:7],7'h13}; // @[Cat.scala 29:58]
  wire [30:0] _GEN_184 = {{5'd0}, _T_397}; // @[el2_ifu_compress_ctl.scala 303:23]
  wire [30:0] _T_409 = _GEN_184 | 31'h40000000; // @[el2_ifu_compress_ctl.scala 303:23]
  wire [31:0] _T_422 = {_T_211,io_din[6:2],2'h1,io_din[9:7],3'h7,2'h1,io_din[9:7],7'h13}; // @[Cat.scala 29:58]
  wire [2:0] _T_426 = {io_din[12],io_din[6:5]}; // @[Cat.scala 29:58]
  wire  _T_428 = io_din[6:5] == 2'h0; // @[el2_ifu_compress_ctl.scala 307:30]
  wire [30:0] _T_429 = _T_428 ? 31'h40000000 : 31'h0; // @[el2_ifu_compress_ctl.scala 307:22]
  wire [6:0] _T_431 = io_din[12] ? 7'h3b : 7'h33; // @[el2_ifu_compress_ctl.scala 308:22]
  wire [2:0] _GEN_1 = 3'h1 == _T_426 ? 3'h4 : 3'h0; // @[Cat.scala 29:58]
  wire [2:0] _GEN_2 = 3'h2 == _T_426 ? 3'h6 : _GEN_1; // @[Cat.scala 29:58]
  wire [2:0] _GEN_3 = 3'h3 == _T_426 ? 3'h7 : _GEN_2; // @[Cat.scala 29:58]
  wire [2:0] _GEN_4 = 3'h4 == _T_426 ? 3'h0 : _GEN_3; // @[Cat.scala 29:58]
  wire [2:0] _GEN_5 = 3'h5 == _T_426 ? 3'h0 : _GEN_4; // @[Cat.scala 29:58]
  wire [2:0] _GEN_6 = 3'h6 == _T_426 ? 3'h2 : _GEN_5; // @[Cat.scala 29:58]
  wire [2:0] _GEN_7 = 3'h7 == _T_426 ? 3'h3 : _GEN_6; // @[Cat.scala 29:58]
  wire [24:0] _T_441 = {2'h1,io_din[4:2],2'h1,io_din[9:7],_GEN_7,2'h1,io_din[9:7],_T_431}; // @[Cat.scala 29:58]
  wire [30:0] _GEN_185 = {{6'd0}, _T_441}; // @[el2_ifu_compress_ctl.scala 309:43]
  wire [30:0] _T_442 = _GEN_185 | _T_429; // @[el2_ifu_compress_ctl.scala 309:43]
  wire [31:0] _T_443_0 = {{6'd0}, _T_397}; // @[el2_ifu_compress_ctl.scala 311:19 el2_ifu_compress_ctl.scala 311:19]
  wire [31:0] _T_443_1 = {{1'd0}, _T_409}; // @[el2_ifu_compress_ctl.scala 311:19 el2_ifu_compress_ctl.scala 311:19]
  wire [31:0] _GEN_9 = 2'h1 == io_din[11:10] ? _T_443_1 : _T_443_0; // @[el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_10 = 2'h2 == io_din[11:10] ? _T_422 : _GEN_9; // @[el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_443_3 = {{1'd0}, _T_442}; // @[el2_ifu_compress_ctl.scala 311:19 el2_ifu_compress_ctl.scala 311:19]
  wire [31:0] _GEN_11 = 2'h3 == io_din[11:10] ? _T_443_3 : _GEN_10; // @[el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_533 = {_T_243[20],_T_243[10:1],_T_243[11],_T_243[19:12],5'h0,7'h6f}; // @[Cat.scala 29:58]
  wire [4:0] _T_542 = io_din[12] ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [12:0] _T_551 = {_T_542,io_din[6:5],io_din[2],io_din[11:10],io_din[4:3],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_600 = {_T_551[12],_T_551[10:5],5'h0,2'h1,io_din[9:7],3'h0,_T_551[4:1],_T_551[11],7'h63}; // @[Cat.scala 29:58]
  wire [31:0] _T_667 = {_T_551[12],_T_551[10:5],5'h0,2'h1,io_din[9:7],3'h1,_T_551[4:1],_T_551[11],7'h63}; // @[Cat.scala 29:58]
  wire  _T_673 = |io_din[11:7]; // @[el2_ifu_compress_ctl.scala 317:27]
  wire [6:0] _T_674 = _T_673 ? 7'h3 : 7'h1f; // @[el2_ifu_compress_ctl.scala 317:23]
  wire [25:0] _T_683 = {io_din[12],io_din[6:2],io_din[11:7],3'h1,io_din[11:7],7'h13}; // @[Cat.scala 29:58]
  wire [28:0] _T_699 = {io_din[4:2],io_din[12],io_din[6:5],3'h0,5'h2,3'h3,io_din[11:7],7'h7}; // @[Cat.scala 29:58]
  wire [27:0] _T_714 = {io_din[3:2],io_din[12],io_din[6:4],2'h0,5'h2,3'h2,io_din[11:7],_T_674}; // @[Cat.scala 29:58]
  wire [27:0] _T_729 = {io_din[3:2],io_din[12],io_din[6:4],2'h0,5'h2,3'h2,io_din[11:7],7'h7}; // @[Cat.scala 29:58]
  wire [24:0] _T_739 = {io_din[6:2],5'h0,3'h0,io_din[11:7],7'h33}; // @[Cat.scala 29:58]
  wire [24:0] _T_750 = {io_din[6:2],io_din[11:7],3'h0,io_din[11:7],7'h33}; // @[Cat.scala 29:58]
  wire [24:0] _T_761 = {io_din[6:2],io_din[11:7],3'h0,12'h67}; // @[Cat.scala 29:58]
  wire [24:0] _T_763 = {_T_761[24:7],7'h1f}; // @[Cat.scala 29:58]
  wire [24:0] _T_766 = _T_673 ? _T_761 : _T_763; // @[el2_ifu_compress_ctl.scala 338:33]
  wire  _T_772 = |io_din[6:2]; // @[el2_ifu_compress_ctl.scala 339:27]
  wire [31:0] _T_743_bits = {{7'd0}, _T_739}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_770_bits = {{7'd0}, _T_766}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_773_bits = _T_772 ? _T_743_bits : _T_770_bits; // @[el2_ifu_compress_ctl.scala 339:22]
  wire [4:0] _T_773_rd = _T_772 ? io_din[11:7] : 5'h0; // @[el2_ifu_compress_ctl.scala 339:22]
  wire [4:0] _T_773_rs1 = _T_772 ? 5'h0 : io_din[11:7]; // @[el2_ifu_compress_ctl.scala 339:22]
  wire [4:0] _T_773_rs2 = _T_772 ? io_din[6:2] : io_din[6:2]; // @[el2_ifu_compress_ctl.scala 339:22]
  wire [4:0] _T_773_rs3 = _T_772 ? io_din[31:27] : io_din[31:27]; // @[el2_ifu_compress_ctl.scala 339:22]
  wire [24:0] _T_779 = {io_din[6:2],io_din[11:7],3'h0,12'he7}; // @[Cat.scala 29:58]
  wire [24:0] _T_781 = {_T_761[24:7],7'h73}; // @[Cat.scala 29:58]
  wire [24:0] _T_782 = _T_781 | 25'h100000; // @[el2_ifu_compress_ctl.scala 341:46]
  wire [24:0] _T_785 = _T_673 ? _T_779 : _T_782; // @[el2_ifu_compress_ctl.scala 342:33]
  wire [31:0] _T_755_bits = {{7'd0}, _T_750}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_789_bits = {{7'd0}, _T_785}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_792_bits = _T_772 ? _T_755_bits : _T_789_bits; // @[el2_ifu_compress_ctl.scala 343:25]
  wire [4:0] _T_792_rd = _T_772 ? io_din[11:7] : 5'h1; // @[el2_ifu_compress_ctl.scala 343:25]
  wire [4:0] _T_792_rs1 = _T_772 ? io_din[11:7] : io_din[11:7]; // @[el2_ifu_compress_ctl.scala 343:25]
  wire [31:0] _T_794_bits = io_din[12] ? _T_792_bits : _T_773_bits; // @[el2_ifu_compress_ctl.scala 344:10]
  wire [4:0] _T_794_rd = io_din[12] ? _T_792_rd : _T_773_rd; // @[el2_ifu_compress_ctl.scala 344:10]
  wire [4:0] _T_794_rs1 = io_din[12] ? _T_792_rs1 : _T_773_rs1; // @[el2_ifu_compress_ctl.scala 344:10]
  wire [4:0] _T_794_rs2 = io_din[12] ? _T_773_rs2 : _T_773_rs2; // @[el2_ifu_compress_ctl.scala 344:10]
  wire [4:0] _T_794_rs3 = io_din[12] ? _T_773_rs3 : _T_773_rs3; // @[el2_ifu_compress_ctl.scala 344:10]
  wire [8:0] _T_798 = {io_din[9:7],io_din[12:10],3'h0}; // @[Cat.scala 29:58]
  wire [28:0] _T_810 = {_T_798[8:5],io_din[6:2],5'h2,3'h3,_T_798[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [7:0] _T_818 = {io_din[8:7],io_din[12:9],2'h0}; // @[Cat.scala 29:58]
  wire [27:0] _T_830 = {_T_818[7:5],io_din[6:2],5'h2,3'h2,_T_818[4:0],7'h23}; // @[Cat.scala 29:58]
  wire [27:0] _T_850 = {_T_818[7:5],io_din[6:2],5'h2,3'h2,_T_818[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [4:0] _T_898 = {io_din[1:0],io_din[15:13]}; // @[Cat.scala 29:58]
  wire [31:0] _T_921_bits = {{2'd0}, _T_18}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _T_941_bits = {{4'd0}, _T_36}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_29 = 5'h1 == _T_898 ? _T_941_bits : _T_921_bits; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_30 = 5'h1 == _T_898 ? _T_14 : _T_14; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_31 = 5'h1 == _T_898 ? _T_30 : 5'h2; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_33 = 5'h1 == _T_898 ? io_din[31:27] : io_din[31:27]; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_963_bits = {{5'd0}, _T_58}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_34 = 5'h2 == _T_898 ? _T_963_bits : _GEN_29; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_35 = 5'h2 == _T_898 ? _T_14 : _GEN_30; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_36 = 5'h2 == _T_898 ? _T_30 : _GEN_31; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_38 = 5'h2 == _T_898 ? io_din[31:27] : _GEN_33; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_985_bits = {{5'd0}, _T_80}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_39 = 5'h3 == _T_898 ? _T_985_bits : _GEN_34; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_40 = 5'h3 == _T_898 ? _T_14 : _GEN_35; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_41 = 5'h3 == _T_898 ? _T_30 : _GEN_36; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_43 = 5'h3 == _T_898 ? io_din[31:27] : _GEN_38; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1016_bits = {{5'd0}, _T_111}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_44 = 5'h4 == _T_898 ? _T_1016_bits : _GEN_39; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_45 = 5'h4 == _T_898 ? _T_14 : _GEN_40; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_46 = 5'h4 == _T_898 ? _T_30 : _GEN_41; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_48 = 5'h4 == _T_898 ? io_din[31:27] : _GEN_43; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1043_bits = {{4'd0}, _T_138}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_49 = 5'h5 == _T_898 ? _T_1043_bits : _GEN_44; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_50 = 5'h5 == _T_898 ? _T_14 : _GEN_45; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_51 = 5'h5 == _T_898 ? _T_30 : _GEN_46; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_53 = 5'h5 == _T_898 ? io_din[31:27] : _GEN_48; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1074_bits = {{5'd0}, _T_169}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_54 = 5'h6 == _T_898 ? _T_1074_bits : _GEN_49; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_55 = 5'h6 == _T_898 ? _T_14 : _GEN_50; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_56 = 5'h6 == _T_898 ? _T_30 : _GEN_51; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_58 = 5'h6 == _T_898 ? io_din[31:27] : _GEN_53; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1105_bits = {{5'd0}, _T_200}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_59 = 5'h7 == _T_898 ? _T_1105_bits : _GEN_54; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_60 = 5'h7 == _T_898 ? _T_14 : _GEN_55; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_61 = 5'h7 == _T_898 ? _T_30 : _GEN_56; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_63 = 5'h7 == _T_898 ? io_din[31:27] : _GEN_58; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_64 = 5'h8 == _T_898 ? _T_219 : _GEN_59; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_65 = 5'h8 == _T_898 ? io_din[11:7] : _GEN_60; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_66 = 5'h8 == _T_898 ? io_din[11:7] : _GEN_61; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_67 = 5'h8 == _T_898 ? _T_14 : _GEN_60; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_68 = 5'h8 == _T_898 ? io_din[31:27] : _GEN_63; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_69 = 5'h9 == _T_898 ? _T_306 : _GEN_64; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_70 = 5'h9 == _T_898 ? 5'h1 : _GEN_65; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_71 = 5'h9 == _T_898 ? io_din[11:7] : _GEN_66; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_72 = 5'h9 == _T_898 ? _T_14 : _GEN_67; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_73 = 5'h9 == _T_898 ? io_din[31:27] : _GEN_68; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_74 = 5'ha == _T_898 ? _T_321 : _GEN_69; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_75 = 5'ha == _T_898 ? io_din[11:7] : _GEN_70; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_76 = 5'ha == _T_898 ? 5'h0 : _GEN_71; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_77 = 5'ha == _T_898 ? _T_14 : _GEN_72; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_78 = 5'ha == _T_898 ? io_din[31:27] : _GEN_73; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_79 = 5'hb == _T_898 ? _T_386_bits : _GEN_74; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_80 = 5'hb == _T_898 ? _T_386_rd : _GEN_75; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_81 = 5'hb == _T_898 ? _T_386_rd : _GEN_76; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_82 = 5'hb == _T_898 ? _T_386_rs2 : _GEN_77; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_83 = 5'hb == _T_898 ? _T_386_rs3 : _GEN_78; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_84 = 5'hc == _T_898 ? _GEN_11 : _GEN_79; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_85 = 5'hc == _T_898 ? _T_30 : _GEN_80; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_86 = 5'hc == _T_898 ? _T_30 : _GEN_81; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_87 = 5'hc == _T_898 ? _T_14 : _GEN_82; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_88 = 5'hc == _T_898 ? io_din[31:27] : _GEN_83; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_89 = 5'hd == _T_898 ? _T_533 : _GEN_84; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_90 = 5'hd == _T_898 ? 5'h0 : _GEN_85; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_91 = 5'hd == _T_898 ? _T_30 : _GEN_86; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_92 = 5'hd == _T_898 ? _T_14 : _GEN_87; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_93 = 5'hd == _T_898 ? io_din[31:27] : _GEN_88; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_94 = 5'he == _T_898 ? _T_600 : _GEN_89; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_95 = 5'he == _T_898 ? _T_30 : _GEN_90; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_96 = 5'he == _T_898 ? _T_30 : _GEN_91; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_97 = 5'he == _T_898 ? 5'h0 : _GEN_92; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_98 = 5'he == _T_898 ? io_din[31:27] : _GEN_93; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_99 = 5'hf == _T_898 ? _T_667 : _GEN_94; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_100 = 5'hf == _T_898 ? 5'h0 : _GEN_95; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_101 = 5'hf == _T_898 ? _T_30 : _GEN_96; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_102 = 5'hf == _T_898 ? 5'h0 : _GEN_97; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_103 = 5'hf == _T_898 ? io_din[31:27] : _GEN_98; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1585_bits = {{6'd0}, _T_683}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_104 = 5'h10 == _T_898 ? _T_1585_bits : _GEN_99; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_105 = 5'h10 == _T_898 ? io_din[11:7] : _GEN_100; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_106 = 5'h10 == _T_898 ? io_din[11:7] : _GEN_101; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_107 = 5'h10 == _T_898 ? io_din[6:2] : _GEN_102; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_108 = 5'h10 == _T_898 ? io_din[31:27] : _GEN_103; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1600_bits = {{3'd0}, _T_699}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_109 = 5'h11 == _T_898 ? _T_1600_bits : _GEN_104; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_110 = 5'h11 == _T_898 ? io_din[11:7] : _GEN_105; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_111 = 5'h11 == _T_898 ? 5'h2 : _GEN_106; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_112 = 5'h11 == _T_898 ? io_din[6:2] : _GEN_107; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_113 = 5'h11 == _T_898 ? io_din[31:27] : _GEN_108; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1615_bits = {{4'd0}, _T_714}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_114 = 5'h12 == _T_898 ? _T_1615_bits : _GEN_109; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_115 = 5'h12 == _T_898 ? io_din[11:7] : _GEN_110; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_116 = 5'h12 == _T_898 ? 5'h2 : _GEN_111; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_117 = 5'h12 == _T_898 ? io_din[6:2] : _GEN_112; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_118 = 5'h12 == _T_898 ? io_din[31:27] : _GEN_113; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1630_bits = {{4'd0}, _T_729}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_119 = 5'h13 == _T_898 ? _T_1630_bits : _GEN_114; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_120 = 5'h13 == _T_898 ? io_din[11:7] : _GEN_115; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_121 = 5'h13 == _T_898 ? 5'h2 : _GEN_116; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_122 = 5'h13 == _T_898 ? io_din[6:2] : _GEN_117; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_123 = 5'h13 == _T_898 ? io_din[31:27] : _GEN_118; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_124 = 5'h14 == _T_898 ? _T_794_bits : _GEN_119; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_125 = 5'h14 == _T_898 ? _T_794_rd : _GEN_120; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_126 = 5'h14 == _T_898 ? _T_794_rs1 : _GEN_121; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_127 = 5'h14 == _T_898 ? _T_794_rs2 : _GEN_122; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_128 = 5'h14 == _T_898 ? _T_794_rs3 : _GEN_123; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1711_bits = {{3'd0}, _T_810}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_129 = 5'h15 == _T_898 ? _T_1711_bits : _GEN_124; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_130 = 5'h15 == _T_898 ? io_din[11:7] : _GEN_125; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_131 = 5'h15 == _T_898 ? 5'h2 : _GEN_126; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_132 = 5'h15 == _T_898 ? io_din[6:2] : _GEN_127; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_133 = 5'h15 == _T_898 ? io_din[31:27] : _GEN_128; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1731_bits = {{4'd0}, _T_830}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_134 = 5'h16 == _T_898 ? _T_1731_bits : _GEN_129; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_135 = 5'h16 == _T_898 ? io_din[11:7] : _GEN_130; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_136 = 5'h16 == _T_898 ? 5'h2 : _GEN_131; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_137 = 5'h16 == _T_898 ? io_din[6:2] : _GEN_132; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_138 = 5'h16 == _T_898 ? io_din[31:27] : _GEN_133; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _T_1751_bits = {{4'd0}, _T_850}; // @[el2_ifu_compress_ctl.scala 225:19 el2_ifu_compress_ctl.scala 226:14]
  wire [31:0] _GEN_139 = 5'h17 == _T_898 ? _T_1751_bits : _GEN_134; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_140 = 5'h17 == _T_898 ? io_din[11:7] : _GEN_135; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_141 = 5'h17 == _T_898 ? 5'h2 : _GEN_136; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_142 = 5'h17 == _T_898 ? io_din[6:2] : _GEN_137; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_143 = 5'h17 == _T_898 ? io_din[31:27] : _GEN_138; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_144 = 5'h18 == _T_898 ? io_din : _GEN_139; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_145 = 5'h18 == _T_898 ? io_din[11:7] : _GEN_140; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_146 = 5'h18 == _T_898 ? io_din[19:15] : _GEN_141; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_147 = 5'h18 == _T_898 ? io_din[24:20] : _GEN_142; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_148 = 5'h18 == _T_898 ? io_din[31:27] : _GEN_143; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_149 = 5'h19 == _T_898 ? io_din : _GEN_144; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_150 = 5'h19 == _T_898 ? io_din[11:7] : _GEN_145; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_151 = 5'h19 == _T_898 ? io_din[19:15] : _GEN_146; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_152 = 5'h19 == _T_898 ? io_din[24:20] : _GEN_147; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_153 = 5'h19 == _T_898 ? io_din[31:27] : _GEN_148; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_154 = 5'h1a == _T_898 ? io_din : _GEN_149; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_155 = 5'h1a == _T_898 ? io_din[11:7] : _GEN_150; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_156 = 5'h1a == _T_898 ? io_din[19:15] : _GEN_151; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_157 = 5'h1a == _T_898 ? io_din[24:20] : _GEN_152; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_158 = 5'h1a == _T_898 ? io_din[31:27] : _GEN_153; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_159 = 5'h1b == _T_898 ? io_din : _GEN_154; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_160 = 5'h1b == _T_898 ? io_din[11:7] : _GEN_155; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_161 = 5'h1b == _T_898 ? io_din[19:15] : _GEN_156; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_162 = 5'h1b == _T_898 ? io_din[24:20] : _GEN_157; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_163 = 5'h1b == _T_898 ? io_din[31:27] : _GEN_158; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_164 = 5'h1c == _T_898 ? io_din : _GEN_159; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_165 = 5'h1c == _T_898 ? io_din[11:7] : _GEN_160; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_166 = 5'h1c == _T_898 ? io_din[19:15] : _GEN_161; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_167 = 5'h1c == _T_898 ? io_din[24:20] : _GEN_162; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_168 = 5'h1c == _T_898 ? io_din[31:27] : _GEN_163; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_169 = 5'h1d == _T_898 ? io_din : _GEN_164; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_170 = 5'h1d == _T_898 ? io_din[11:7] : _GEN_165; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_171 = 5'h1d == _T_898 ? io_din[19:15] : _GEN_166; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_172 = 5'h1d == _T_898 ? io_din[24:20] : _GEN_167; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_173 = 5'h1d == _T_898 ? io_din[31:27] : _GEN_168; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [31:0] _GEN_174 = 5'h1e == _T_898 ? io_din : _GEN_169; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_175 = 5'h1e == _T_898 ? io_din[11:7] : _GEN_170; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_176 = 5'h1e == _T_898 ? io_din[19:15] : _GEN_171; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_177 = 5'h1e == _T_898 ? io_din[24:20] : _GEN_172; // @[el2_ifu_compress_ctl.scala 404:13]
  wire [4:0] _GEN_178 = 5'h1e == _T_898 ? io_din[31:27] : _GEN_173; // @[el2_ifu_compress_ctl.scala 404:13]
  assign io_dout_bits = 5'h1f == _T_898 ? io_din : _GEN_174; // @[el2_ifu_compress_ctl.scala 404:13]
  assign io_dout_rd = 5'h1f == _T_898 ? io_din[11:7] : _GEN_175; // @[el2_ifu_compress_ctl.scala 404:13]
  assign io_dout_rs1 = 5'h1f == _T_898 ? io_din[19:15] : _GEN_176; // @[el2_ifu_compress_ctl.scala 404:13]
  assign io_dout_rs2 = 5'h1f == _T_898 ? io_din[24:20] : _GEN_177; // @[el2_ifu_compress_ctl.scala 404:13]
  assign io_dout_rs3 = 5'h1f == _T_898 ? io_din[31:27] : _GEN_178; // @[el2_ifu_compress_ctl.scala 404:13]
endmodule
