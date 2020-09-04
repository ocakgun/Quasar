module RVCExpander(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  output [31:0] io_out_bits,
  output [4:0]  io_out_rd,
  output [4:0]  io_out_rs1,
  output [4:0]  io_out_rs2,
  output [4:0]  io_out_rs3,
  output        io_rvc,
  output        io_legal
);
  wire  _T_3 = |io_in[12:5]; // @[RVC.scala 58:29]
  wire [6:0] _T_4 = _T_3 ? 7'h13 : 7'h1f; // @[RVC.scala 58:20]
  wire [4:0] _T_14 = {2'h1,io_in[4:2]}; // @[Cat.scala 29:58]
  wire [29:0] _T_18 = {io_in[10:7],io_in[12:11],io_in[5],io_in[6],2'h0,5'h2,3'h0,2'h1,io_in[4:2],_T_4}; // @[Cat.scala 29:58]
  wire [7:0] _T_28 = {io_in[6:5],io_in[12:10],3'h0}; // @[Cat.scala 29:58]
  wire [4:0] _T_30 = {2'h1,io_in[9:7]}; // @[Cat.scala 29:58]
  wire [27:0] _T_36 = {io_in[6:5],io_in[12:10],3'h0,2'h1,io_in[9:7],3'h3,2'h1,io_in[4:2],7'h7}; // @[Cat.scala 29:58]
  wire [6:0] _T_50 = {io_in[5],io_in[12:10],io_in[6],2'h0}; // @[Cat.scala 29:58]
  wire [26:0] _T_58 = {io_in[5],io_in[12:10],io_in[6],2'h0,2'h1,io_in[9:7],3'h2,2'h1,io_in[4:2],7'h3}; // @[Cat.scala 29:58]
  wire [26:0] _T_80 = {io_in[5],io_in[12:10],io_in[6],2'h0,2'h1,io_in[9:7],3'h2,2'h1,io_in[4:2],7'h7}; // @[Cat.scala 29:58]
  wire [26:0] _T_111 = {_T_50[6:5],2'h1,io_in[4:2],2'h1,io_in[9:7],3'h2,_T_50[4:0],7'h3f}; // @[Cat.scala 29:58]
  wire [27:0] _T_138 = {_T_28[7:5],2'h1,io_in[4:2],2'h1,io_in[9:7],3'h3,_T_28[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [26:0] _T_169 = {_T_50[6:5],2'h1,io_in[4:2],2'h1,io_in[9:7],3'h2,_T_50[4:0],7'h23}; // @[Cat.scala 29:58]
  wire [26:0] _T_200 = {_T_50[6:5],2'h1,io_in[4:2],2'h1,io_in[9:7],3'h2,_T_50[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [6:0] _T_211 = io_in[12] ? 7'h7f : 7'h0; // @[Bitwise.scala 72:12]
  wire [11:0] _T_213 = {_T_211,io_in[6:2]}; // @[Cat.scala 29:58]
  wire [31:0] _T_219 = {_T_211,io_in[6:2],io_in[11:7],3'h0,io_in[11:7],7'h13}; // @[Cat.scala 29:58]
  wire [9:0] _T_228 = io_in[12] ? 10'h3ff : 10'h0; // @[Bitwise.scala 72:12]
  wire [20:0] _T_243 = {_T_228,io_in[8],io_in[10:9],io_in[6],io_in[7],io_in[2],io_in[11],io_in[5:3],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_306 = {_T_243[20],_T_243[10:1],_T_243[11],_T_243[19:12],5'h1,7'h6f}; // @[Cat.scala 29:58]
  wire [31:0] _T_321 = {_T_211,io_in[6:2],5'h0,3'h0,io_in[11:7],7'h13}; // @[Cat.scala 29:58]
  wire  _T_332 = |_T_213; // @[RVC.scala 95:29]
  wire [6:0] _T_333 = _T_332 ? 7'h37 : 7'h3f; // @[RVC.scala 95:20]
  wire [14:0] _T_336 = io_in[12] ? 15'h7fff : 15'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_339 = {_T_336,io_in[6:2],12'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_343 = {_T_339[31:12],io_in[11:7],_T_333}; // @[Cat.scala 29:58]
  wire  _T_351 = io_in[11:7] == 5'h0; // @[RVC.scala 97:14]
  wire  _T_353 = io_in[11:7] == 5'h2; // @[RVC.scala 97:27]
  wire  _T_354 = _T_351 | _T_353; // @[RVC.scala 97:21]
  wire [6:0] _T_361 = _T_332 ? 7'h13 : 7'h1f; // @[RVC.scala 91:20]
  wire [2:0] _T_364 = io_in[12] ? 3'h7 : 3'h0; // @[Bitwise.scala 72:12]
  wire [31:0] _T_379 = {_T_364,io_in[4:3],io_in[5],io_in[2],io_in[6],4'h0,io_in[11:7],3'h0,io_in[11:7],_T_361}; // @[Cat.scala 29:58]
  wire [31:0] _T_386_bits = _T_354 ? _T_379 : _T_343; // @[RVC.scala 97:10]
  wire [4:0] _T_386_rd = _T_354 ? io_in[11:7] : io_in[11:7]; // @[RVC.scala 97:10]
  wire [4:0] _T_386_rs2 = _T_354 ? _T_14 : _T_14; // @[RVC.scala 97:10]
  wire [4:0] _T_386_rs3 = _T_354 ? io_in[31:27] : io_in[31:27]; // @[RVC.scala 97:10]
  wire [25:0] _T_397 = {io_in[12],io_in[6:2],2'h1,io_in[9:7],3'h5,2'h1,io_in[9:7],7'h13}; // @[Cat.scala 29:58]
  wire [30:0] _GEN_172 = {{5'd0}, _T_397}; // @[RVC.scala 104:23]
  wire [30:0] _T_409 = _GEN_172 | 31'h40000000; // @[RVC.scala 104:23]
  wire [31:0] _T_422 = {_T_211,io_in[6:2],2'h1,io_in[9:7],3'h7,2'h1,io_in[9:7],7'h13}; // @[Cat.scala 29:58]
  wire [2:0] _T_426 = {io_in[12],io_in[6:5]}; // @[Cat.scala 29:58]
  wire  _T_428 = io_in[6:5] == 2'h0; // @[RVC.scala 108:30]
  wire [30:0] _T_429 = _T_428 ? 31'h40000000 : 31'h0; // @[RVC.scala 108:22]
  wire [6:0] _T_431 = io_in[12] ? 7'h3b : 7'h33; // @[RVC.scala 109:22]
  wire [2:0] _GEN_1 = 3'h1 == _T_426 ? 3'h4 : 3'h0; // @[Cat.scala 29:58]
  wire [2:0] _GEN_2 = 3'h2 == _T_426 ? 3'h6 : _GEN_1; // @[Cat.scala 29:58]
  wire [2:0] _GEN_3 = 3'h3 == _T_426 ? 3'h7 : _GEN_2; // @[Cat.scala 29:58]
  wire [2:0] _GEN_4 = 3'h4 == _T_426 ? 3'h0 : _GEN_3; // @[Cat.scala 29:58]
  wire [2:0] _GEN_5 = 3'h5 == _T_426 ? 3'h0 : _GEN_4; // @[Cat.scala 29:58]
  wire [2:0] _GEN_6 = 3'h6 == _T_426 ? 3'h2 : _GEN_5; // @[Cat.scala 29:58]
  wire [2:0] _GEN_7 = 3'h7 == _T_426 ? 3'h3 : _GEN_6; // @[Cat.scala 29:58]
  wire [24:0] _T_441 = {2'h1,io_in[4:2],2'h1,io_in[9:7],_GEN_7,2'h1,io_in[9:7],_T_431}; // @[Cat.scala 29:58]
  wire [30:0] _GEN_173 = {{6'd0}, _T_441}; // @[RVC.scala 110:43]
  wire [30:0] _T_442 = _GEN_173 | _T_429; // @[RVC.scala 110:43]
  wire [31:0] _T_443_0 = {{6'd0}, _T_397}; // @[RVC.scala 112:19 RVC.scala 112:19]
  wire [31:0] _T_443_1 = {{1'd0}, _T_409}; // @[RVC.scala 112:19 RVC.scala 112:19]
  wire [31:0] _GEN_9 = 2'h1 == io_in[11:10] ? _T_443_1 : _T_443_0; // @[RVC.scala 27:14]
  wire [31:0] _GEN_10 = 2'h2 == io_in[11:10] ? _T_422 : _GEN_9; // @[RVC.scala 27:14]
  wire [31:0] _T_443_3 = {{1'd0}, _T_442}; // @[RVC.scala 112:19 RVC.scala 112:19]
  wire [31:0] _GEN_11 = 2'h3 == io_in[11:10] ? _T_443_3 : _GEN_10; // @[RVC.scala 27:14]
  wire [31:0] _T_533 = {_T_243[20],_T_243[10:1],_T_243[11],_T_243[19:12],5'h0,7'h6f}; // @[Cat.scala 29:58]
  wire [4:0] _T_542 = io_in[12] ? 5'h1f : 5'h0; // @[Bitwise.scala 72:12]
  wire [12:0] _T_551 = {_T_542,io_in[6:5],io_in[2],io_in[11:10],io_in[4:3],1'h0}; // @[Cat.scala 29:58]
  wire [31:0] _T_600 = {_T_551[12],_T_551[10:5],5'h0,2'h1,io_in[9:7],3'h0,_T_551[4:1],_T_551[11],7'h63}; // @[Cat.scala 29:58]
  wire [31:0] _T_667 = {_T_551[12],_T_551[10:5],5'h0,2'h1,io_in[9:7],3'h1,_T_551[4:1],_T_551[11],7'h63}; // @[Cat.scala 29:58]
  wire  _T_673 = |io_in[11:7]; // @[RVC.scala 118:27]
  wire [6:0] _T_674 = _T_673 ? 7'h3 : 7'h1f; // @[RVC.scala 118:23]
  wire [25:0] _T_683 = {io_in[12],io_in[6:2],io_in[11:7],3'h1,io_in[11:7],7'h13}; // @[Cat.scala 29:58]
  wire [28:0] _T_699 = {io_in[4:2],io_in[12],io_in[6:5],3'h0,5'h2,3'h3,io_in[11:7],7'h7}; // @[Cat.scala 29:58]
  wire [27:0] _T_714 = {io_in[3:2],io_in[12],io_in[6:4],2'h0,5'h2,3'h2,io_in[11:7],_T_674}; // @[Cat.scala 29:58]
  wire [27:0] _T_729 = {io_in[3:2],io_in[12],io_in[6:4],2'h0,5'h2,3'h2,io_in[11:7],7'h7}; // @[Cat.scala 29:58]
  wire [24:0] _T_739 = {io_in[6:2],5'h0,3'h0,io_in[11:7],7'h33}; // @[Cat.scala 29:58]
  wire [24:0] _T_750 = {io_in[6:2],io_in[11:7],3'h0,io_in[11:7],7'h33}; // @[Cat.scala 29:58]
  wire [24:0] _T_761 = {io_in[6:2],io_in[11:7],3'h0,12'h67}; // @[Cat.scala 29:58]
  wire [24:0] _T_763 = {_T_761[24:7],7'h1f}; // @[Cat.scala 29:58]
  wire [24:0] _T_766 = _T_673 ? _T_761 : _T_763; // @[RVC.scala 139:33]
  wire  _T_772 = |io_in[6:2]; // @[RVC.scala 140:27]
  wire [31:0] _T_743_bits = {{7'd0}, _T_739}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _T_770_bits = {{7'd0}, _T_766}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _T_773_bits = _T_772 ? _T_743_bits : _T_770_bits; // @[RVC.scala 140:22]
  wire [4:0] _T_773_rd = _T_772 ? io_in[11:7] : 5'h0; // @[RVC.scala 140:22]
  wire [4:0] _T_773_rs1 = _T_772 ? 5'h0 : io_in[11:7]; // @[RVC.scala 140:22]
  wire [4:0] _T_773_rs2 = _T_772 ? io_in[6:2] : io_in[6:2]; // @[RVC.scala 140:22]
  wire [4:0] _T_773_rs3 = _T_772 ? io_in[31:27] : io_in[31:27]; // @[RVC.scala 140:22]
  wire [24:0] _T_779 = {io_in[6:2],io_in[11:7],3'h0,12'he7}; // @[Cat.scala 29:58]
  wire [24:0] _T_781 = {_T_761[24:7],7'h73}; // @[Cat.scala 29:58]
  wire [24:0] _T_782 = _T_781 | 25'h100000; // @[RVC.scala 142:46]
  wire [24:0] _T_785 = _T_673 ? _T_779 : _T_782; // @[RVC.scala 143:33]
  wire [31:0] _T_755_bits = {{7'd0}, _T_750}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _T_789_bits = {{7'd0}, _T_785}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _T_792_bits = _T_772 ? _T_755_bits : _T_789_bits; // @[RVC.scala 144:25]
  wire [4:0] _T_792_rd = _T_772 ? io_in[11:7] : 5'h1; // @[RVC.scala 144:25]
  wire [4:0] _T_792_rs1 = _T_772 ? io_in[11:7] : io_in[11:7]; // @[RVC.scala 144:25]
  wire [31:0] _T_794_bits = io_in[12] ? _T_792_bits : _T_773_bits; // @[RVC.scala 145:10]
  wire [4:0] _T_794_rd = io_in[12] ? _T_792_rd : _T_773_rd; // @[RVC.scala 145:10]
  wire [4:0] _T_794_rs1 = io_in[12] ? _T_792_rs1 : _T_773_rs1; // @[RVC.scala 145:10]
  wire [4:0] _T_794_rs2 = io_in[12] ? _T_773_rs2 : _T_773_rs2; // @[RVC.scala 145:10]
  wire [4:0] _T_794_rs3 = io_in[12] ? _T_773_rs3 : _T_773_rs3; // @[RVC.scala 145:10]
  wire [8:0] _T_798 = {io_in[9:7],io_in[12:10],3'h0}; // @[Cat.scala 29:58]
  wire [28:0] _T_810 = {_T_798[8:5],io_in[6:2],5'h2,3'h3,_T_798[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [7:0] _T_818 = {io_in[8:7],io_in[12:9],2'h0}; // @[Cat.scala 29:58]
  wire [27:0] _T_830 = {_T_818[7:5],io_in[6:2],5'h2,3'h2,_T_818[4:0],7'h23}; // @[Cat.scala 29:58]
  wire [27:0] _T_850 = {_T_818[7:5],io_in[6:2],5'h2,3'h2,_T_818[4:0],7'h27}; // @[Cat.scala 29:58]
  wire [4:0] _T_898 = {io_in[1:0],io_in[15:13]}; // @[Cat.scala 29:58]
  wire [31:0] _T_24_bits = {{2'd0}, _T_18}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _T_44_bits = {{4'd0}, _T_36}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_17 = 5'h1 == _T_898 ? _T_44_bits : _T_24_bits; // @[RVC.scala 203:12]
  wire [4:0] _GEN_18 = 5'h1 == _T_898 ? _T_14 : _T_14; // @[RVC.scala 203:12]
  wire [4:0] _GEN_19 = 5'h1 == _T_898 ? _T_30 : 5'h2; // @[RVC.scala 203:12]
  wire [4:0] _GEN_21 = 5'h1 == _T_898 ? io_in[31:27] : io_in[31:27]; // @[RVC.scala 203:12]
  wire [31:0] _T_66_bits = {{5'd0}, _T_58}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_22 = 5'h2 == _T_898 ? _T_66_bits : _GEN_17; // @[RVC.scala 203:12]
  wire [4:0] _GEN_23 = 5'h2 == _T_898 ? _T_14 : _GEN_18; // @[RVC.scala 203:12]
  wire [4:0] _GEN_24 = 5'h2 == _T_898 ? _T_30 : _GEN_19; // @[RVC.scala 203:12]
  wire [4:0] _GEN_26 = 5'h2 == _T_898 ? io_in[31:27] : _GEN_21; // @[RVC.scala 203:12]
  wire [31:0] _T_88_bits = {{5'd0}, _T_80}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_27 = 5'h3 == _T_898 ? _T_88_bits : _GEN_22; // @[RVC.scala 203:12]
  wire [4:0] _GEN_28 = 5'h3 == _T_898 ? _T_14 : _GEN_23; // @[RVC.scala 203:12]
  wire [4:0] _GEN_29 = 5'h3 == _T_898 ? _T_30 : _GEN_24; // @[RVC.scala 203:12]
  wire [4:0] _GEN_31 = 5'h3 == _T_898 ? io_in[31:27] : _GEN_26; // @[RVC.scala 203:12]
  wire [31:0] _T_119_bits = {{5'd0}, _T_111}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_32 = 5'h4 == _T_898 ? _T_119_bits : _GEN_27; // @[RVC.scala 203:12]
  wire [4:0] _GEN_33 = 5'h4 == _T_898 ? _T_14 : _GEN_28; // @[RVC.scala 203:12]
  wire [4:0] _GEN_34 = 5'h4 == _T_898 ? _T_30 : _GEN_29; // @[RVC.scala 203:12]
  wire [4:0] _GEN_36 = 5'h4 == _T_898 ? io_in[31:27] : _GEN_31; // @[RVC.scala 203:12]
  wire [31:0] _T_146_bits = {{4'd0}, _T_138}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_37 = 5'h5 == _T_898 ? _T_146_bits : _GEN_32; // @[RVC.scala 203:12]
  wire [4:0] _GEN_38 = 5'h5 == _T_898 ? _T_14 : _GEN_33; // @[RVC.scala 203:12]
  wire [4:0] _GEN_39 = 5'h5 == _T_898 ? _T_30 : _GEN_34; // @[RVC.scala 203:12]
  wire [4:0] _GEN_41 = 5'h5 == _T_898 ? io_in[31:27] : _GEN_36; // @[RVC.scala 203:12]
  wire [31:0] _T_177_bits = {{5'd0}, _T_169}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_42 = 5'h6 == _T_898 ? _T_177_bits : _GEN_37; // @[RVC.scala 203:12]
  wire [4:0] _GEN_43 = 5'h6 == _T_898 ? _T_14 : _GEN_38; // @[RVC.scala 203:12]
  wire [4:0] _GEN_44 = 5'h6 == _T_898 ? _T_30 : _GEN_39; // @[RVC.scala 203:12]
  wire [4:0] _GEN_46 = 5'h6 == _T_898 ? io_in[31:27] : _GEN_41; // @[RVC.scala 203:12]
  wire [31:0] _T_208_bits = {{5'd0}, _T_200}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_47 = 5'h7 == _T_898 ? _T_208_bits : _GEN_42; // @[RVC.scala 203:12]
  wire [4:0] _GEN_48 = 5'h7 == _T_898 ? _T_14 : _GEN_43; // @[RVC.scala 203:12]
  wire [4:0] _GEN_49 = 5'h7 == _T_898 ? _T_30 : _GEN_44; // @[RVC.scala 203:12]
  wire [4:0] _GEN_51 = 5'h7 == _T_898 ? io_in[31:27] : _GEN_46; // @[RVC.scala 203:12]
  wire [31:0] _GEN_52 = 5'h8 == _T_898 ? _T_219 : _GEN_47; // @[RVC.scala 203:12]
  wire [4:0] _GEN_53 = 5'h8 == _T_898 ? io_in[11:7] : _GEN_48; // @[RVC.scala 203:12]
  wire [4:0] _GEN_54 = 5'h8 == _T_898 ? io_in[11:7] : _GEN_49; // @[RVC.scala 203:12]
  wire [4:0] _GEN_55 = 5'h8 == _T_898 ? _T_14 : _GEN_48; // @[RVC.scala 203:12]
  wire [4:0] _GEN_56 = 5'h8 == _T_898 ? io_in[31:27] : _GEN_51; // @[RVC.scala 203:12]
  wire [31:0] _GEN_57 = 5'h9 == _T_898 ? _T_306 : _GEN_52; // @[RVC.scala 203:12]
  wire [4:0] _GEN_58 = 5'h9 == _T_898 ? 5'h1 : _GEN_53; // @[RVC.scala 203:12]
  wire [4:0] _GEN_59 = 5'h9 == _T_898 ? io_in[11:7] : _GEN_54; // @[RVC.scala 203:12]
  wire [4:0] _GEN_60 = 5'h9 == _T_898 ? _T_14 : _GEN_55; // @[RVC.scala 203:12]
  wire [4:0] _GEN_61 = 5'h9 == _T_898 ? io_in[31:27] : _GEN_56; // @[RVC.scala 203:12]
  wire [31:0] _GEN_62 = 5'ha == _T_898 ? _T_321 : _GEN_57; // @[RVC.scala 203:12]
  wire [4:0] _GEN_63 = 5'ha == _T_898 ? io_in[11:7] : _GEN_58; // @[RVC.scala 203:12]
  wire [4:0] _GEN_64 = 5'ha == _T_898 ? 5'h0 : _GEN_59; // @[RVC.scala 203:12]
  wire [4:0] _GEN_65 = 5'ha == _T_898 ? _T_14 : _GEN_60; // @[RVC.scala 203:12]
  wire [4:0] _GEN_66 = 5'ha == _T_898 ? io_in[31:27] : _GEN_61; // @[RVC.scala 203:12]
  wire [31:0] _GEN_67 = 5'hb == _T_898 ? _T_386_bits : _GEN_62; // @[RVC.scala 203:12]
  wire [4:0] _GEN_68 = 5'hb == _T_898 ? _T_386_rd : _GEN_63; // @[RVC.scala 203:12]
  wire [4:0] _GEN_69 = 5'hb == _T_898 ? _T_386_rd : _GEN_64; // @[RVC.scala 203:12]
  wire [4:0] _GEN_70 = 5'hb == _T_898 ? _T_386_rs2 : _GEN_65; // @[RVC.scala 203:12]
  wire [4:0] _GEN_71 = 5'hb == _T_898 ? _T_386_rs3 : _GEN_66; // @[RVC.scala 203:12]
  wire [31:0] _GEN_72 = 5'hc == _T_898 ? _GEN_11 : _GEN_67; // @[RVC.scala 203:12]
  wire [4:0] _GEN_73 = 5'hc == _T_898 ? _T_30 : _GEN_68; // @[RVC.scala 203:12]
  wire [4:0] _GEN_74 = 5'hc == _T_898 ? _T_30 : _GEN_69; // @[RVC.scala 203:12]
  wire [4:0] _GEN_75 = 5'hc == _T_898 ? _T_14 : _GEN_70; // @[RVC.scala 203:12]
  wire [4:0] _GEN_76 = 5'hc == _T_898 ? io_in[31:27] : _GEN_71; // @[RVC.scala 203:12]
  wire [31:0] _GEN_77 = 5'hd == _T_898 ? _T_533 : _GEN_72; // @[RVC.scala 203:12]
  wire [4:0] _GEN_78 = 5'hd == _T_898 ? 5'h0 : _GEN_73; // @[RVC.scala 203:12]
  wire [4:0] _GEN_79 = 5'hd == _T_898 ? _T_30 : _GEN_74; // @[RVC.scala 203:12]
  wire [4:0] _GEN_80 = 5'hd == _T_898 ? _T_14 : _GEN_75; // @[RVC.scala 203:12]
  wire [4:0] _GEN_81 = 5'hd == _T_898 ? io_in[31:27] : _GEN_76; // @[RVC.scala 203:12]
  wire [31:0] _GEN_82 = 5'he == _T_898 ? _T_600 : _GEN_77; // @[RVC.scala 203:12]
  wire [4:0] _GEN_83 = 5'he == _T_898 ? _T_30 : _GEN_78; // @[RVC.scala 203:12]
  wire [4:0] _GEN_84 = 5'he == _T_898 ? _T_30 : _GEN_79; // @[RVC.scala 203:12]
  wire [4:0] _GEN_85 = 5'he == _T_898 ? 5'h0 : _GEN_80; // @[RVC.scala 203:12]
  wire [4:0] _GEN_86 = 5'he == _T_898 ? io_in[31:27] : _GEN_81; // @[RVC.scala 203:12]
  wire [31:0] _GEN_87 = 5'hf == _T_898 ? _T_667 : _GEN_82; // @[RVC.scala 203:12]
  wire [4:0] _GEN_88 = 5'hf == _T_898 ? 5'h0 : _GEN_83; // @[RVC.scala 203:12]
  wire [4:0] _GEN_89 = 5'hf == _T_898 ? _T_30 : _GEN_84; // @[RVC.scala 203:12]
  wire [4:0] _GEN_90 = 5'hf == _T_898 ? 5'h0 : _GEN_85; // @[RVC.scala 203:12]
  wire [4:0] _GEN_91 = 5'hf == _T_898 ? io_in[31:27] : _GEN_86; // @[RVC.scala 203:12]
  wire [31:0] _T_688_bits = {{6'd0}, _T_683}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_92 = 5'h10 == _T_898 ? _T_688_bits : _GEN_87; // @[RVC.scala 203:12]
  wire [4:0] _GEN_93 = 5'h10 == _T_898 ? io_in[11:7] : _GEN_88; // @[RVC.scala 203:12]
  wire [4:0] _GEN_94 = 5'h10 == _T_898 ? io_in[11:7] : _GEN_89; // @[RVC.scala 203:12]
  wire [4:0] _GEN_95 = 5'h10 == _T_898 ? io_in[6:2] : _GEN_90; // @[RVC.scala 203:12]
  wire [4:0] _GEN_96 = 5'h10 == _T_898 ? io_in[31:27] : _GEN_91; // @[RVC.scala 203:12]
  wire [31:0] _T_703_bits = {{3'd0}, _T_699}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_97 = 5'h11 == _T_898 ? _T_703_bits : _GEN_92; // @[RVC.scala 203:12]
  wire [4:0] _GEN_98 = 5'h11 == _T_898 ? io_in[11:7] : _GEN_93; // @[RVC.scala 203:12]
  wire [4:0] _GEN_99 = 5'h11 == _T_898 ? 5'h2 : _GEN_94; // @[RVC.scala 203:12]
  wire [4:0] _GEN_100 = 5'h11 == _T_898 ? io_in[6:2] : _GEN_95; // @[RVC.scala 203:12]
  wire [4:0] _GEN_101 = 5'h11 == _T_898 ? io_in[31:27] : _GEN_96; // @[RVC.scala 203:12]
  wire [31:0] _T_718_bits = {{4'd0}, _T_714}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_102 = 5'h12 == _T_898 ? _T_718_bits : _GEN_97; // @[RVC.scala 203:12]
  wire [4:0] _GEN_103 = 5'h12 == _T_898 ? io_in[11:7] : _GEN_98; // @[RVC.scala 203:12]
  wire [4:0] _GEN_104 = 5'h12 == _T_898 ? 5'h2 : _GEN_99; // @[RVC.scala 203:12]
  wire [4:0] _GEN_105 = 5'h12 == _T_898 ? io_in[6:2] : _GEN_100; // @[RVC.scala 203:12]
  wire [4:0] _GEN_106 = 5'h12 == _T_898 ? io_in[31:27] : _GEN_101; // @[RVC.scala 203:12]
  wire [31:0] _T_733_bits = {{4'd0}, _T_729}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_107 = 5'h13 == _T_898 ? _T_733_bits : _GEN_102; // @[RVC.scala 203:12]
  wire [4:0] _GEN_108 = 5'h13 == _T_898 ? io_in[11:7] : _GEN_103; // @[RVC.scala 203:12]
  wire [4:0] _GEN_109 = 5'h13 == _T_898 ? 5'h2 : _GEN_104; // @[RVC.scala 203:12]
  wire [4:0] _GEN_110 = 5'h13 == _T_898 ? io_in[6:2] : _GEN_105; // @[RVC.scala 203:12]
  wire [4:0] _GEN_111 = 5'h13 == _T_898 ? io_in[31:27] : _GEN_106; // @[RVC.scala 203:12]
  wire [31:0] _GEN_112 = 5'h14 == _T_898 ? _T_794_bits : _GEN_107; // @[RVC.scala 203:12]
  wire [4:0] _GEN_113 = 5'h14 == _T_898 ? _T_794_rd : _GEN_108; // @[RVC.scala 203:12]
  wire [4:0] _GEN_114 = 5'h14 == _T_898 ? _T_794_rs1 : _GEN_109; // @[RVC.scala 203:12]
  wire [4:0] _GEN_115 = 5'h14 == _T_898 ? _T_794_rs2 : _GEN_110; // @[RVC.scala 203:12]
  wire [4:0] _GEN_116 = 5'h14 == _T_898 ? _T_794_rs3 : _GEN_111; // @[RVC.scala 203:12]
  wire [31:0] _T_814_bits = {{3'd0}, _T_810}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_117 = 5'h15 == _T_898 ? _T_814_bits : _GEN_112; // @[RVC.scala 203:12]
  wire [4:0] _GEN_118 = 5'h15 == _T_898 ? io_in[11:7] : _GEN_113; // @[RVC.scala 203:12]
  wire [4:0] _GEN_119 = 5'h15 == _T_898 ? 5'h2 : _GEN_114; // @[RVC.scala 203:12]
  wire [4:0] _GEN_120 = 5'h15 == _T_898 ? io_in[6:2] : _GEN_115; // @[RVC.scala 203:12]
  wire [4:0] _GEN_121 = 5'h15 == _T_898 ? io_in[31:27] : _GEN_116; // @[RVC.scala 203:12]
  wire [31:0] _T_834_bits = {{4'd0}, _T_830}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_122 = 5'h16 == _T_898 ? _T_834_bits : _GEN_117; // @[RVC.scala 203:12]
  wire [4:0] _GEN_123 = 5'h16 == _T_898 ? io_in[11:7] : _GEN_118; // @[RVC.scala 203:12]
  wire [4:0] _GEN_124 = 5'h16 == _T_898 ? 5'h2 : _GEN_119; // @[RVC.scala 203:12]
  wire [4:0] _GEN_125 = 5'h16 == _T_898 ? io_in[6:2] : _GEN_120; // @[RVC.scala 203:12]
  wire [4:0] _GEN_126 = 5'h16 == _T_898 ? io_in[31:27] : _GEN_121; // @[RVC.scala 203:12]
  wire [31:0] _T_854_bits = {{4'd0}, _T_850}; // @[RVC.scala 26:19 RVC.scala 27:14]
  wire [31:0] _GEN_127 = 5'h17 == _T_898 ? _T_854_bits : _GEN_122; // @[RVC.scala 203:12]
  wire [4:0] _GEN_128 = 5'h17 == _T_898 ? io_in[11:7] : _GEN_123; // @[RVC.scala 203:12]
  wire [4:0] _GEN_129 = 5'h17 == _T_898 ? 5'h2 : _GEN_124; // @[RVC.scala 203:12]
  wire [4:0] _GEN_130 = 5'h17 == _T_898 ? io_in[6:2] : _GEN_125; // @[RVC.scala 203:12]
  wire [4:0] _GEN_131 = 5'h17 == _T_898 ? io_in[31:27] : _GEN_126; // @[RVC.scala 203:12]
  wire [31:0] _GEN_132 = 5'h18 == _T_898 ? io_in : _GEN_127; // @[RVC.scala 203:12]
  wire [4:0] _GEN_133 = 5'h18 == _T_898 ? io_in[11:7] : _GEN_128; // @[RVC.scala 203:12]
  wire [4:0] _GEN_134 = 5'h18 == _T_898 ? io_in[19:15] : _GEN_129; // @[RVC.scala 203:12]
  wire [4:0] _GEN_135 = 5'h18 == _T_898 ? io_in[24:20] : _GEN_130; // @[RVC.scala 203:12]
  wire [4:0] _GEN_136 = 5'h18 == _T_898 ? io_in[31:27] : _GEN_131; // @[RVC.scala 203:12]
  wire [31:0] _GEN_137 = 5'h19 == _T_898 ? io_in : _GEN_132; // @[RVC.scala 203:12]
  wire [4:0] _GEN_138 = 5'h19 == _T_898 ? io_in[11:7] : _GEN_133; // @[RVC.scala 203:12]
  wire [4:0] _GEN_139 = 5'h19 == _T_898 ? io_in[19:15] : _GEN_134; // @[RVC.scala 203:12]
  wire [4:0] _GEN_140 = 5'h19 == _T_898 ? io_in[24:20] : _GEN_135; // @[RVC.scala 203:12]
  wire [4:0] _GEN_141 = 5'h19 == _T_898 ? io_in[31:27] : _GEN_136; // @[RVC.scala 203:12]
  wire [31:0] _GEN_142 = 5'h1a == _T_898 ? io_in : _GEN_137; // @[RVC.scala 203:12]
  wire [4:0] _GEN_143 = 5'h1a == _T_898 ? io_in[11:7] : _GEN_138; // @[RVC.scala 203:12]
  wire [4:0] _GEN_144 = 5'h1a == _T_898 ? io_in[19:15] : _GEN_139; // @[RVC.scala 203:12]
  wire [4:0] _GEN_145 = 5'h1a == _T_898 ? io_in[24:20] : _GEN_140; // @[RVC.scala 203:12]
  wire [4:0] _GEN_146 = 5'h1a == _T_898 ? io_in[31:27] : _GEN_141; // @[RVC.scala 203:12]
  wire [31:0] _GEN_147 = 5'h1b == _T_898 ? io_in : _GEN_142; // @[RVC.scala 203:12]
  wire [4:0] _GEN_148 = 5'h1b == _T_898 ? io_in[11:7] : _GEN_143; // @[RVC.scala 203:12]
  wire [4:0] _GEN_149 = 5'h1b == _T_898 ? io_in[19:15] : _GEN_144; // @[RVC.scala 203:12]
  wire [4:0] _GEN_150 = 5'h1b == _T_898 ? io_in[24:20] : _GEN_145; // @[RVC.scala 203:12]
  wire [4:0] _GEN_151 = 5'h1b == _T_898 ? io_in[31:27] : _GEN_146; // @[RVC.scala 203:12]
  wire [31:0] _GEN_152 = 5'h1c == _T_898 ? io_in : _GEN_147; // @[RVC.scala 203:12]
  wire [4:0] _GEN_153 = 5'h1c == _T_898 ? io_in[11:7] : _GEN_148; // @[RVC.scala 203:12]
  wire [4:0] _GEN_154 = 5'h1c == _T_898 ? io_in[19:15] : _GEN_149; // @[RVC.scala 203:12]
  wire [4:0] _GEN_155 = 5'h1c == _T_898 ? io_in[24:20] : _GEN_150; // @[RVC.scala 203:12]
  wire [4:0] _GEN_156 = 5'h1c == _T_898 ? io_in[31:27] : _GEN_151; // @[RVC.scala 203:12]
  wire [31:0] _GEN_157 = 5'h1d == _T_898 ? io_in : _GEN_152; // @[RVC.scala 203:12]
  wire [4:0] _GEN_158 = 5'h1d == _T_898 ? io_in[11:7] : _GEN_153; // @[RVC.scala 203:12]
  wire [4:0] _GEN_159 = 5'h1d == _T_898 ? io_in[19:15] : _GEN_154; // @[RVC.scala 203:12]
  wire [4:0] _GEN_160 = 5'h1d == _T_898 ? io_in[24:20] : _GEN_155; // @[RVC.scala 203:12]
  wire [4:0] _GEN_161 = 5'h1d == _T_898 ? io_in[31:27] : _GEN_156; // @[RVC.scala 203:12]
  wire [31:0] _GEN_162 = 5'h1e == _T_898 ? io_in : _GEN_157; // @[RVC.scala 203:12]
  wire [4:0] _GEN_163 = 5'h1e == _T_898 ? io_in[11:7] : _GEN_158; // @[RVC.scala 203:12]
  wire [4:0] _GEN_164 = 5'h1e == _T_898 ? io_in[19:15] : _GEN_159; // @[RVC.scala 203:12]
  wire [4:0] _GEN_165 = 5'h1e == _T_898 ? io_in[24:20] : _GEN_160; // @[RVC.scala 203:12]
  wire [4:0] _GEN_166 = 5'h1e == _T_898 ? io_in[31:27] : _GEN_161; // @[RVC.scala 203:12]
  wire  _T_900 = ~io_in[13]; // @[RVC.scala 204:18]
  wire  _T_902 = ~io_in[12]; // @[RVC.scala 204:31]
  wire  _T_903 = _T_900 & _T_902; // @[RVC.scala 204:29]
  wire  _T_905 = _T_903 & io_in[11]; // @[RVC.scala 204:42]
  wire  _T_907 = _T_905 & io_in[1]; // @[RVC.scala 204:54]
  wire  _T_909 = ~io_in[0]; // @[RVC.scala 204:65]
  wire  _T_910 = _T_907 & _T_909; // @[RVC.scala 204:63]
  wire  _T_917 = _T_903 & io_in[6]; // @[RVC.scala 205:32]
  wire  _T_919 = _T_917 & io_in[1]; // @[RVC.scala 205:43]
  wire  _T_922 = _T_919 & _T_909; // @[RVC.scala 205:52]
  wire  _T_923 = _T_910 | _T_922; // @[RVC.scala 204:76]
  wire  _T_925 = ~io_in[15]; // @[RVC.scala 206:8]
  wire  _T_928 = _T_925 & _T_900; // @[RVC.scala 206:19]
  wire  _T_931 = ~io_in[1]; // @[RVC.scala 206:43]
  wire  _T_932 = io_in[11] >> _T_931; // @[RVC.scala 206:42]
  wire  _T_934 = _T_928 & _T_932; // @[RVC.scala 206:32]
  wire  _T_935 = _T_923 | _T_934; // @[RVC.scala 205:65]
  wire  _T_942 = _T_903 & io_in[5]; // @[RVC.scala 207:32]
  wire  _T_944 = _T_942 & io_in[1]; // @[RVC.scala 207:41]
  wire  _T_947 = _T_944 & _T_909; // @[RVC.scala 207:50]
  wire  _T_948 = _T_935 | _T_947; // @[RVC.scala 206:54]
  wire  _T_955 = _T_903 & io_in[10]; // @[RVC.scala 208:32]
  wire  _T_958 = _T_955 & _T_931; // @[RVC.scala 208:42]
  wire  _T_960 = _T_958 & io_in[0]; // @[RVC.scala 208:54]
  wire  _T_961 = _T_948 | _T_960; // @[RVC.scala 207:63]
  wire  _T_968 = _T_928 & io_in[6]; // @[RVC.scala 209:32]
  wire  _T_971 = _T_968 & _T_931; // @[RVC.scala 209:41]
  wire  _T_972 = _T_961 | _T_971; // @[RVC.scala 208:64]
  wire  _T_976 = io_in[15] & _T_902; // @[RVC.scala 209:65]
  wire  _T_979 = _T_976 & _T_931; // @[RVC.scala 209:78]
  wire  _T_981 = _T_979 & io_in[0]; // @[RVC.scala 209:90]
  wire  _T_982 = _T_972 | _T_981; // @[RVC.scala 209:54]
  wire  _T_989 = _T_903 & io_in[9]; // @[RVC.scala 210:32]
  wire  _T_991 = _T_989 & io_in[1]; // @[RVC.scala 210:41]
  wire  _T_994 = _T_991 & _T_909; // @[RVC.scala 210:50]
  wire  _T_995 = _T_982 | _T_994; // @[RVC.scala 209:100]
  wire  _T_999 = _T_902 & io_in[6]; // @[RVC.scala 211:19]
  wire  _T_1002 = _T_999 & _T_931; // @[RVC.scala 211:28]
  wire  _T_1004 = _T_1002 & io_in[0]; // @[RVC.scala 211:40]
  wire  _T_1005 = _T_995 | _T_1004; // @[RVC.scala 210:63]
  wire  _T_1012 = _T_928 & io_in[5]; // @[RVC.scala 212:32]
  wire  _T_1015 = _T_1012 & _T_931; // @[RVC.scala 212:41]
  wire  _T_1016 = _T_1005 | _T_1015; // @[RVC.scala 211:50]
  wire  _T_1023 = _T_903 & io_in[8]; // @[RVC.scala 213:32]
  wire  _T_1025 = _T_1023 & io_in[1]; // @[RVC.scala 213:41]
  wire  _T_1028 = _T_1025 & _T_909; // @[RVC.scala 213:50]
  wire  _T_1029 = _T_1016 | _T_1028; // @[RVC.scala 212:54]
  wire  _T_1033 = _T_902 & io_in[5]; // @[RVC.scala 214:19]
  wire  _T_1036 = _T_1033 & _T_931; // @[RVC.scala 214:28]
  wire  _T_1038 = _T_1036 & io_in[0]; // @[RVC.scala 214:40]
  wire  _T_1039 = _T_1029 | _T_1038; // @[RVC.scala 213:63]
  wire  _T_1046 = _T_928 & io_in[10]; // @[RVC.scala 215:32]
  wire  _T_1049 = _T_1046 & _T_931; // @[RVC.scala 215:42]
  wire  _T_1050 = _T_1039 | _T_1049; // @[RVC.scala 214:50]
  wire  _T_1057 = _T_903 & io_in[7]; // @[RVC.scala 215:82]
  wire  _T_1059 = _T_1057 & io_in[1]; // @[RVC.scala 215:91]
  wire  _T_1062 = _T_1059 & _T_909; // @[RVC.scala 215:100]
  wire  _T_1063 = _T_1050 | _T_1062; // @[RVC.scala 215:55]
  wire  _T_1066 = io_in[12] & io_in[11]; // @[RVC.scala 216:16]
  wire  _T_1068 = ~io_in[10]; // @[RVC.scala 216:28]
  wire  _T_1069 = _T_1066 & _T_1068; // @[RVC.scala 216:26]
  wire  _T_1072 = _T_1069 & _T_931; // @[RVC.scala 216:39]
  wire  _T_1074 = _T_1072 & io_in[0]; // @[RVC.scala 216:51]
  wire  _T_1075 = _T_1063 | _T_1074; // @[RVC.scala 215:113]
  wire  _T_1082 = _T_928 & io_in[9]; // @[RVC.scala 216:88]
  wire  _T_1085 = _T_1082 & _T_931; // @[RVC.scala 216:97]
  wire  _T_1086 = _T_1075 | _T_1085; // @[RVC.scala 216:61]
  wire  _T_1093 = _T_903 & io_in[4]; // @[RVC.scala 217:32]
  wire  _T_1095 = _T_1093 & io_in[1]; // @[RVC.scala 217:41]
  wire  _T_1098 = _T_1095 & _T_909; // @[RVC.scala 217:50]
  wire  _T_1099 = _T_1086 | _T_1098; // @[RVC.scala 216:110]
  wire  _T_1102 = io_in[13] & io_in[12]; // @[RVC.scala 217:74]
  wire  _T_1105 = _T_1102 & _T_931; // @[RVC.scala 217:84]
  wire  _T_1107 = _T_1105 & io_in[0]; // @[RVC.scala 217:96]
  wire  _T_1108 = _T_1099 | _T_1107; // @[RVC.scala 217:63]
  wire  _T_1115 = _T_928 & io_in[8]; // @[RVC.scala 218:32]
  wire  _T_1118 = _T_1115 & _T_931; // @[RVC.scala 218:41]
  wire  _T_1119 = _T_1108 | _T_1118; // @[RVC.scala 217:106]
  wire  _T_1126 = _T_903 & io_in[3]; // @[RVC.scala 218:81]
  wire  _T_1128 = _T_1126 & io_in[1]; // @[RVC.scala 218:90]
  wire  _T_1131 = _T_1128 & _T_909; // @[RVC.scala 218:99]
  wire  _T_1132 = _T_1119 | _T_1131; // @[RVC.scala 218:54]
  wire  _T_1135 = io_in[13] & io_in[4]; // @[RVC.scala 219:16]
  wire  _T_1138 = _T_1135 & _T_931; // @[RVC.scala 219:25]
  wire  _T_1140 = _T_1138 & io_in[0]; // @[RVC.scala 219:37]
  wire  _T_1141 = _T_1132 | _T_1140; // @[RVC.scala 218:112]
  wire  _T_1148 = _T_903 & io_in[2]; // @[RVC.scala 219:74]
  wire  _T_1150 = _T_1148 & io_in[1]; // @[RVC.scala 219:83]
  wire  _T_1153 = _T_1150 & _T_909; // @[RVC.scala 219:92]
  wire  _T_1154 = _T_1141 | _T_1153; // @[RVC.scala 219:47]
  wire  _T_1161 = _T_928 & io_in[7]; // @[RVC.scala 220:32]
  wire  _T_1164 = _T_1161 & _T_931; // @[RVC.scala 220:41]
  wire  _T_1165 = _T_1154 | _T_1164; // @[RVC.scala 219:105]
  wire  _T_1168 = io_in[13] & io_in[3]; // @[RVC.scala 220:65]
  wire  _T_1171 = _T_1168 & _T_931; // @[RVC.scala 220:74]
  wire  _T_1173 = _T_1171 & io_in[0]; // @[RVC.scala 220:86]
  wire  _T_1174 = _T_1165 | _T_1173; // @[RVC.scala 220:54]
  wire  _T_1177 = io_in[13] & io_in[2]; // @[RVC.scala 221:16]
  wire  _T_1180 = _T_1177 & _T_931; // @[RVC.scala 221:25]
  wire  _T_1182 = _T_1180 & io_in[0]; // @[RVC.scala 221:37]
  wire  _T_1183 = _T_1174 | _T_1182; // @[RVC.scala 220:96]
  wire  _T_1187 = io_in[14] & _T_900; // @[RVC.scala 221:58]
  wire  _T_1190 = _T_1187 & _T_931; // @[RVC.scala 221:71]
  wire  _T_1191 = _T_1183 | _T_1190; // @[RVC.scala 221:47]
  wire  _T_1193 = ~io_in[14]; // @[RVC.scala 222:8]
  wire  _T_1196 = _T_1193 & _T_902; // @[RVC.scala 222:19]
  wire  _T_1199 = _T_1196 & _T_931; // @[RVC.scala 222:32]
  wire  _T_1201 = _T_1199 & io_in[0]; // @[RVC.scala 222:44]
  wire  _T_1202 = _T_1191 | _T_1201; // @[RVC.scala 221:84]
  wire  _T_1206 = io_in[15] & _T_900; // @[RVC.scala 222:65]
  wire  _T_1208 = _T_1206 & io_in[12]; // @[RVC.scala 222:78]
  wire  _T_1210 = _T_1208 & io_in[1]; // @[RVC.scala 222:88]
  wire  _T_1213 = _T_1210 & _T_909; // @[RVC.scala 222:97]
  wire  _T_1214 = _T_1202 | _T_1213; // @[RVC.scala 222:54]
  wire  _T_1222 = _T_928 & _T_902; // @[RVC.scala 223:32]
  wire  _T_1224 = _T_1222 & io_in[1]; // @[RVC.scala 223:45]
  wire  _T_1227 = _T_1224 & _T_909; // @[RVC.scala 223:54]
  wire  _T_1228 = _T_1214 | _T_1227; // @[RVC.scala 222:110]
  wire  _T_1235 = _T_928 & io_in[12]; // @[RVC.scala 223:94]
  wire  _T_1238 = _T_1235 & _T_931; // @[RVC.scala 223:104]
  wire  _T_1239 = _T_1228 | _T_1238; // @[RVC.scala 223:67]
  wire  _T_1246 = _T_1187 & _T_909; // @[RVC.scala 224:29]
  assign io_out_bits = 5'h1f == _T_898 ? io_in : _GEN_162; // @[RVC.scala 203:12]
  assign io_out_rd = 5'h1f == _T_898 ? io_in[11:7] : _GEN_163; // @[RVC.scala 203:12]
  assign io_out_rs1 = 5'h1f == _T_898 ? io_in[19:15] : _GEN_164; // @[RVC.scala 203:12]
  assign io_out_rs2 = 5'h1f == _T_898 ? io_in[24:20] : _GEN_165; // @[RVC.scala 203:12]
  assign io_out_rs3 = 5'h1f == _T_898 ? io_in[31:27] : _GEN_166; // @[RVC.scala 203:12]
  assign io_rvc = io_in[1:0] != 2'h3; // @[RVC.scala 201:12]
  assign io_legal = _T_1239 | _T_1246; // @[RVC.scala 204:14]
endmodule
