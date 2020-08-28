
module SET_DW01_inc_0 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2XL U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  INVXL U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module SET_DW01_add_0 ( A, B, CI, SUM, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [7:1] carry;

  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(n1), .CO(carry[3]), .S(SUM[2]) );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  AND2X2 U1 ( .A(A[1]), .B(n2), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  XOR2X1 U3 ( .A(A[7]), .B(carry[7]), .Y(SUM[7]) );
  XOR2X1 U4 ( .A(A[1]), .B(n2), .Y(SUM[1]) );
  AND2X2 U5 ( .A(B[0]), .B(A[0]), .Y(n2) );
endmodule


module SET ( clk, rst, en, central, radius, mode, busy, valid, candidate );
  input [23:0] central;
  input [11:0] radius;
  input [1:0] mode;
  output [7:0] candidate;
  input clk, rst, en;
  output busy, valid;
  wire   n330, n331, n332, n333, n334, n335, n336, n337, n338, n339, N93, N94,
         N95, N96, N97, N98, N99, N100, N189, N190, N191, N192, N193, N194,
         N195, N196, n21, n22, n23, n24, n25, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n37, n39, n42, n44, n46, n48, n49, n50, n53, n54, n55,
         n57, n59, n60, n62, n63, n64, n66, n67, n69, n70, n71, n73, n75, n76,
         n77, n80, n83, n84, n85, n86, n87, n88, n89, n92, n93, n95, n96, n97,
         n98, n100, n101, n102, n104, n105, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n186, n187, n188, n189, n190, n191,
         n192, n193, n195, n196, n197, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n220, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n266, n267, n268,
         n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279,
         n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290,
         n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301,
         n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312,
         n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323,
         n324, n325, n326, n327, n328, n329;
  wire   [3:0] a;
  wire   [7:0] multiplier;
  wire   [3:0] state;
  wire   [3:0] x;
  wire   [3:0] y;
  wire   [7:0] dis;

  SET_DW01_inc_0 r349 ( .A({candidate[7:1], n339}), .SUM({N196, N195, N194, 
        N193, N192, N191, N190, N189}) );
  SET_DW01_add_0 r343 ( .A(dis), .B({1'b0, multiplier[6:2], 1'b0, 
        multiplier[0]}), .CI(1'b0), .SUM({N100, N99, N98, N97, N96, N95, N94, 
        N93}) );
  DFFQX1 \dis_reg[7]  ( .D(n254), .CK(clk), .Q(dis[7]) );
  DFFQX1 \dis_reg[6]  ( .D(n295), .CK(clk), .Q(dis[6]) );
  DFFQX1 \dis_reg[2]  ( .D(n299), .CK(clk), .Q(dis[2]) );
  DFFQX1 \dis_reg[4]  ( .D(n297), .CK(clk), .Q(dis[4]) );
  DFFQX1 \dis_reg[3]  ( .D(n298), .CK(clk), .Q(dis[3]) );
  DFFQX1 \dis_reg[5]  ( .D(n296), .CK(clk), .Q(dis[5]) );
  DFFQX1 \dis_reg[0]  ( .D(n300), .CK(clk), .Q(dis[0]) );
  DFFQX1 \dis_reg[1]  ( .D(n253), .CK(clk), .Q(dis[1]) );
  DFFRX1 \y_reg[3]  ( .D(n251), .CK(clk), .RN(n271), .Q(y[3]), .QN(n268) );
  EDFFX1 \a_reg[0]  ( .D(n231), .E(n230), .CK(clk), .Q(multiplier[0]), .QN(
        n269) );
  DFFRX1 \candidate_reg[0]  ( .D(n238), .CK(clk), .RN(n271), .Q(n339), .QN(
        n204) );
  DFFRX1 \candidate_reg[7]  ( .D(n239), .CK(clk), .RN(n271), .Q(n332), .QN(
        n203) );
  DFFRX1 \candidate_reg[6]  ( .D(n232), .CK(clk), .RN(n271), .Q(n333), .QN(
        n210) );
  DFFRX1 \candidate_reg[5]  ( .D(n233), .CK(clk), .RN(n271), .Q(n334), .QN(
        n209) );
  DFFRX1 \candidate_reg[4]  ( .D(n234), .CK(clk), .RN(n271), .Q(n335), .QN(
        n208) );
  DFFRX1 \candidate_reg[3]  ( .D(n235), .CK(clk), .RN(n271), .Q(n336), .QN(
        n207) );
  DFFRX1 \candidate_reg[2]  ( .D(n236), .CK(clk), .RN(n271), .Q(n337), .QN(
        n206) );
  DFFRX1 valid_reg ( .D(n240), .CK(clk), .RN(n271), .Q(n331), .QN(n202) );
  DFFRX1 busy_reg ( .D(n241), .CK(clk), .RN(n301), .Q(n330), .QN(n200) );
  DFFRX1 \candidate_reg[1]  ( .D(n237), .CK(clk), .RN(n271), .Q(n338), .QN(
        n205) );
  DFFRX1 d_r2_reg ( .D(n213), .CK(clk), .RN(n301), .Q(n329), .QN(n211) );
  DFFRX1 d_r1_reg ( .D(n214), .CK(clk), .RN(n301), .Q(n328), .QN(n212) );
  DFFRX1 d_r3_reg ( .D(n218), .CK(clk), .RN(n301), .QN(n220) );
  DFFRX1 \y_reg[2]  ( .D(n229), .CK(clk), .RN(n301), .Q(y[2]), .QN(n327) );
  DFFRX1 \y_reg[0]  ( .D(n252), .CK(clk), .RN(n301), .Q(y[0]), .QN(n304) );
  DFFRX1 \x_reg[0]  ( .D(n246), .CK(clk), .RN(n301), .Q(x[0]), .QN(n323) );
  DFFRX1 \x_reg[2]  ( .D(n244), .CK(clk), .RN(n301), .Q(x[2]), .QN(n325) );
  DFFRX1 \x_reg[3]  ( .D(n243), .CK(clk), .RN(n301), .Q(n201) );
  DFFRX1 \state_reg[2]  ( .D(n247), .CK(clk), .RN(n301), .Q(state[2]), .QN(
        n320) );
  EDFFX1 \a_reg[1]  ( .D(n217), .E(n230), .CK(clk), .QN(n279) );
  EDFFX1 \a_reg[2]  ( .D(n216), .E(n230), .CK(clk), .Q(a[2]) );
  EDFFX1 \a_reg[3]  ( .D(n215), .E(n230), .CK(clk), .Q(a[3]), .QN(n276) );
  DFFRX2 \x_reg[1]  ( .D(n245), .CK(clk), .RN(n301), .Q(x[1]), .QN(n324) );
  DFFRX2 \state_reg[0]  ( .D(n250), .CK(clk), .RN(n301), .Q(state[0]), .QN(
        n314) );
  DFFRX2 \y_reg[1]  ( .D(n242), .CK(clk), .RN(n301), .Q(y[1]), .QN(n326) );
  DFFRX2 \state_reg[1]  ( .D(n248), .CK(clk), .RN(n301), .Q(state[1]), .QN(
        n321) );
  DFFRX2 \state_reg[3]  ( .D(n249), .CK(clk), .RN(n301), .Q(state[3]) );
  AO22X1 U223 ( .A0(dis[1]), .A1(n186), .B0(N94), .B1(n188), .Y(n253) );
  AO22X1 U224 ( .A0(dis[7]), .A1(n186), .B0(N100), .B1(n188), .Y(n254) );
  AOI21X1 U225 ( .A0(n269), .A1(dis[0]), .B0(dis[1]), .Y(n255) );
  OAI32XL U226 ( .A0(n73), .A1(x[1]), .A2(n323), .B0(n80), .B1(n324), .Y(n245)
         );
  NOR2XL U227 ( .A(n324), .B(n323), .Y(n76) );
  AND2X1 U228 ( .A(central[4]), .B(n323), .Y(n44) );
  AND3XL U229 ( .A(state[3]), .B(n314), .C(n321), .Y(n197) );
  INVX3 U230 ( .A(rst), .Y(n301) );
  BUFX12 U231 ( .A(n338), .Y(candidate[1]) );
  NOR3X2 U232 ( .A(n278), .B(n277), .C(n276), .Y(multiplier[6]) );
  OAI21X1 U233 ( .A0(n273), .A1(n272), .B0(n274), .Y(n278) );
  BUFX12 U234 ( .A(n330), .Y(busy) );
  BUFX12 U235 ( .A(n331), .Y(valid) );
  BUFX12 U236 ( .A(n337), .Y(candidate[2]) );
  BUFX12 U237 ( .A(n336), .Y(candidate[3]) );
  BUFX12 U238 ( .A(n335), .Y(candidate[4]) );
  BUFX12 U239 ( .A(n334), .Y(candidate[5]) );
  BUFX12 U240 ( .A(n333), .Y(candidate[6]) );
  BUFX12 U241 ( .A(n332), .Y(candidate[7]) );
  BUFX12 U242 ( .A(n339), .Y(candidate[0]) );
  NOR3BX1 U243 ( .AN(n177), .B(n314), .C(n321), .Y(n46) );
  CLKINVX1 U244 ( .A(n34), .Y(n317) );
  CLKINVX1 U245 ( .A(n31), .Y(n319) );
  CLKINVX1 U246 ( .A(n29), .Y(n310) );
  CLKINVX1 U247 ( .A(n54), .Y(n315) );
  NAND4X1 U248 ( .A(state[3]), .B(state[0]), .C(n321), .D(n320), .Y(n86) );
  NAND4X1 U249 ( .A(state[3]), .B(state[1]), .C(n314), .D(n320), .Y(n88) );
  AOI21X2 U250 ( .A0(n30), .A1(n92), .B0(n186), .Y(n187) );
  CLKINVX1 U251 ( .A(n83), .Y(n302) );
  CLKINVX1 U252 ( .A(multiplier[3]), .Y(n293) );
  INVX3 U253 ( .A(n30), .Y(n313) );
  NOR2X1 U254 ( .A(n319), .B(n310), .Y(n92) );
  CLKINVX1 U255 ( .A(n107), .Y(n305) );
  NOR2X1 U256 ( .A(n308), .B(n46), .Y(n84) );
  NAND2X1 U257 ( .A(n305), .B(n73), .Y(n77) );
  OA21XL U258 ( .A0(n76), .A1(n73), .B0(n77), .Y(n75) );
  INVX3 U259 ( .A(n32), .Y(n306) );
  CLKINVX1 U260 ( .A(n109), .Y(n311) );
  CLKINVX1 U261 ( .A(n76), .Y(n322) );
  AOI21X2 U262 ( .A0(n86), .A1(n84), .B0(n186), .Y(n188) );
  AOI222XL U263 ( .A0(n310), .A1(n170), .B0(n316), .B1(n171), .C0(n306), .C1(
        n172), .Y(n169) );
  XOR2X1 U264 ( .A(n39), .B(n178), .Y(n170) );
  XOR2X1 U265 ( .A(n25), .B(n176), .Y(n171) );
  XOR2X1 U266 ( .A(n37), .B(n173), .Y(n172) );
  NAND2X2 U267 ( .A(n271), .B(n196), .Y(n186) );
  NAND4X1 U268 ( .A(n92), .B(n84), .C(n30), .D(n86), .Y(n196) );
  AND2X2 U269 ( .A(n270), .B(n315), .Y(n50) );
  NAND3X1 U270 ( .A(n48), .B(n64), .C(n98), .Y(n83) );
  NOR3X1 U271 ( .A(n312), .B(n307), .C(n315), .Y(n98) );
  NOR3X1 U272 ( .A(n329), .B(n57), .C(n328), .Y(n59) );
  CLKBUFX3 U273 ( .A(n301), .Y(n271) );
  OAI211X1 U274 ( .A0(n320), .A1(n83), .B0(n84), .C0(n85), .Y(n247) );
  NOR3X1 U275 ( .A(n315), .B(n306), .C(n319), .Y(n85) );
  CLKINVX1 U276 ( .A(multiplier[5]), .Y(n292) );
  OAI22XL U277 ( .A0(n314), .A1(n83), .B0(n302), .B1(n95), .Y(n250) );
  NOR4X1 U278 ( .A(n96), .B(n77), .C(n310), .D(n313), .Y(n95) );
  NAND3X1 U279 ( .A(n32), .B(n87), .C(n88), .Y(n96) );
  OAI31X1 U280 ( .A0(n104), .A1(n66), .A2(n97), .B0(n109), .Y(n107) );
  NAND2X1 U281 ( .A(n197), .B(n320), .Y(n30) );
  CLKINVX1 U282 ( .A(n87), .Y(n308) );
  AND4X1 U283 ( .A(n84), .B(n33), .C(n92), .D(n100), .Y(n48) );
  NOR4X1 U284 ( .A(n318), .B(n317), .C(n306), .D(n313), .Y(n100) );
  NAND2X2 U285 ( .A(n312), .B(n97), .Y(n73) );
  CLKINVX1 U286 ( .A(n86), .Y(n318) );
  NAND3X1 U287 ( .A(n314), .B(n321), .C(n175), .Y(n32) );
  CLKINVX1 U288 ( .A(n104), .Y(n312) );
  OAI22XL U289 ( .A0(n304), .A1(n107), .B0(n305), .B1(n108), .Y(n252) );
  NOR2X1 U290 ( .A(n311), .B(n304), .Y(n108) );
  CLKINVX1 U291 ( .A(n33), .Y(n316) );
  CLKINVX1 U292 ( .A(n88), .Y(n307) );
  NAND3X1 U293 ( .A(n314), .B(n321), .C(n177), .Y(n109) );
  NAND2X1 U294 ( .A(n312), .B(n66), .Y(n62) );
  XOR2X1 U295 ( .A(n122), .B(n123), .Y(n121) );
  XNOR2X1 U296 ( .A(n201), .B(central[15]), .Y(n123) );
  OAI21XL U297 ( .A0(central[14]), .A1(n124), .B0(n125), .Y(n122) );
  AO21X1 U298 ( .A0(n124), .A1(central[14]), .B0(n325), .Y(n125) );
  OAI2BB1X1 U299 ( .A0N(n37), .A1N(central[13]), .B0(n155), .Y(n124) );
  OAI21XL U300 ( .A0(n37), .A1(central[13]), .B0(n324), .Y(n155) );
  AND2X2 U301 ( .A(central[12]), .B(n323), .Y(n37) );
  NAND3X1 U302 ( .A(n110), .B(n111), .C(n112), .Y(n215) );
  AOI22X1 U303 ( .A0(n319), .A1(n134), .B0(n313), .B1(n135), .Y(n110) );
  AOI221XL U304 ( .A0(n317), .A1(n113), .B0(radius[3]), .B1(n318), .C0(n114), 
        .Y(n112) );
  AOI222XL U305 ( .A0(n310), .A1(n119), .B0(n316), .B1(n120), .C0(n306), .C1(
        n121), .Y(n111) );
  CLKINVX1 U306 ( .A(n189), .Y(n295) );
  AOI222XL U307 ( .A0(dis[6]), .A1(n186), .B0(multiplier[6]), .B1(n187), .C0(
        N99), .C1(n188), .Y(n189) );
  CLKINVX1 U308 ( .A(n192), .Y(n298) );
  AOI222XL U309 ( .A0(dis[3]), .A1(n186), .B0(multiplier[3]), .B1(n187), .C0(
        N96), .C1(n188), .Y(n192) );
  AOI222XL U310 ( .A0(n25), .A1(n316), .B0(x[0]), .B1(n27), .C0(y[0]), .C1(n28), .Y(n24) );
  OAI222XL U311 ( .A0(central[12]), .A1(n32), .B0(central[20]), .B1(n33), .C0(
        central[4]), .C1(n34), .Y(n27) );
  OAI222XL U312 ( .A0(central[16]), .A1(n29), .B0(central[0]), .B1(n30), .C0(
        central[8]), .C1(n31), .Y(n28) );
  NAND4X1 U313 ( .A(n86), .B(n87), .C(n88), .D(n89), .Y(n248) );
  AOI211X1 U314 ( .A0(n302), .A1(state[1]), .B0(n309), .C0(n316), .Y(n89) );
  CLKINVX1 U315 ( .A(n92), .Y(n309) );
  XOR2X1 U316 ( .A(n140), .B(n141), .Y(n134) );
  XNOR2X1 U317 ( .A(y[3]), .B(central[11]), .Y(n141) );
  OAI21XL U318 ( .A0(central[10]), .A1(n142), .B0(n143), .Y(n140) );
  AO21X1 U319 ( .A0(n142), .A1(central[10]), .B0(n327), .Y(n143) );
  XOR2X1 U320 ( .A(n35), .B(n182), .Y(n179) );
  XNOR2X1 U321 ( .A(n326), .B(central[9]), .Y(n182) );
  XOR2X1 U322 ( .A(n44), .B(n184), .Y(n183) );
  XNOR2X1 U323 ( .A(n324), .B(central[5]), .Y(n184) );
  XOR2X1 U324 ( .A(n136), .B(n137), .Y(n135) );
  XNOR2X1 U325 ( .A(y[3]), .B(central[3]), .Y(n137) );
  OAI21XL U326 ( .A0(central[2]), .A1(n138), .B0(n139), .Y(n136) );
  AO21X1 U327 ( .A0(n138), .A1(central[2]), .B0(n327), .Y(n139) );
  XNOR2X1 U328 ( .A(n164), .B(n142), .Y(n160) );
  XNOR2X1 U329 ( .A(central[10]), .B(y[2]), .Y(n164) );
  XNOR2X1 U330 ( .A(n162), .B(n138), .Y(n161) );
  XNOR2X1 U331 ( .A(central[2]), .B(y[2]), .Y(n162) );
  XNOR2X1 U332 ( .A(n324), .B(central[13]), .Y(n173) );
  XNOR2X1 U333 ( .A(n324), .B(central[21]), .Y(n176) );
  XNOR2X1 U334 ( .A(n326), .B(central[17]), .Y(n178) );
  XOR2X1 U335 ( .A(n42), .B(n181), .Y(n180) );
  XNOR2X1 U336 ( .A(n326), .B(central[1]), .Y(n181) );
  XOR2X1 U337 ( .A(n115), .B(n116), .Y(n113) );
  XNOR2X1 U338 ( .A(n201), .B(central[7]), .Y(n116) );
  OAI21XL U339 ( .A0(central[6]), .A1(n117), .B0(n118), .Y(n115) );
  AO21X1 U340 ( .A0(n117), .A1(central[6]), .B0(n325), .Y(n118) );
  XOR2X1 U341 ( .A(n126), .B(n127), .Y(n120) );
  XNOR2X1 U342 ( .A(n201), .B(central[23]), .Y(n127) );
  OAI21XL U343 ( .A0(central[22]), .A1(n128), .B0(n129), .Y(n126) );
  AO21X1 U344 ( .A0(n128), .A1(central[22]), .B0(n325), .Y(n129) );
  XNOR2X1 U345 ( .A(n158), .B(n132), .Y(n151) );
  XNOR2X1 U346 ( .A(central[18]), .B(y[2]), .Y(n158) );
  XNOR2X1 U347 ( .A(n156), .B(n128), .Y(n152) );
  XNOR2X1 U348 ( .A(central[22]), .B(x[2]), .Y(n156) );
  XNOR2X1 U349 ( .A(n154), .B(n124), .Y(n153) );
  XNOR2X1 U350 ( .A(central[14]), .B(x[2]), .Y(n154) );
  XNOR2X1 U351 ( .A(n149), .B(n117), .Y(n147) );
  XNOR2X1 U352 ( .A(central[6]), .B(x[2]), .Y(n149) );
  OAI2BB1X1 U353 ( .A0N(n25), .A1N(central[21]), .B0(n157), .Y(n128) );
  OAI21XL U354 ( .A0(n25), .A1(central[21]), .B0(n324), .Y(n157) );
  OAI2BB1X1 U355 ( .A0N(n39), .A1N(central[17]), .B0(n159), .Y(n132) );
  OAI21XL U356 ( .A0(n39), .A1(central[17]), .B0(n326), .Y(n159) );
  OAI2BB1X1 U357 ( .A0N(n44), .A1N(central[5]), .B0(n150), .Y(n117) );
  OAI21XL U358 ( .A0(n44), .A1(central[5]), .B0(n324), .Y(n150) );
  OAI2BB1X1 U359 ( .A0N(n42), .A1N(central[1]), .B0(n163), .Y(n138) );
  OAI21XL U360 ( .A0(n42), .A1(central[1]), .B0(n326), .Y(n163) );
  OAI2BB1X1 U361 ( .A0N(n35), .A1N(central[9]), .B0(n165), .Y(n142) );
  OAI21XL U362 ( .A0(n35), .A1(central[9]), .B0(n326), .Y(n165) );
  NAND2X1 U363 ( .A(en), .B(n311), .Y(n64) );
  NAND2X1 U364 ( .A(mode[1]), .B(n60), .Y(n57) );
  NAND4X1 U365 ( .A(n34), .B(n86), .C(n88), .D(n93), .Y(n249) );
  AOI211X1 U366 ( .A0(n302), .A1(state[3]), .B0(n313), .C0(n315), .Y(n93) );
  XOR2X1 U367 ( .A(n130), .B(n131), .Y(n119) );
  XNOR2X1 U368 ( .A(y[3]), .B(central[19]), .Y(n131) );
  OAI21XL U369 ( .A0(central[18]), .A1(n132), .B0(n133), .Y(n130) );
  AO21X1 U370 ( .A0(n132), .A1(central[18]), .B0(n327), .Y(n133) );
  NAND2BX1 U371 ( .AN(n220), .B(mode[0]), .Y(n60) );
  NAND4X1 U372 ( .A(n21), .B(n22), .C(n23), .D(n24), .Y(n231) );
  AOI22X1 U373 ( .A0(radius[8]), .A1(n46), .B0(radius[4]), .B1(n308), .Y(n21)
         );
  AOI222XL U374 ( .A0(radius[0]), .A1(n318), .B0(n42), .B1(n313), .C0(n44), 
        .C1(n317), .Y(n22) );
  AOI222XL U375 ( .A0(n35), .A1(n319), .B0(n37), .B1(n306), .C0(n39), .C1(n310), .Y(n23) );
  OAI2BB2XL U376 ( .B0(n210), .B1(n270), .A0N(N195), .A1N(n50), .Y(n232) );
  OAI2BB2XL U377 ( .B0(n209), .B1(n270), .A0N(N194), .A1N(n50), .Y(n233) );
  OAI2BB2XL U378 ( .B0(n208), .B1(n270), .A0N(N193), .A1N(n50), .Y(n234) );
  OAI2BB2XL U379 ( .B0(n207), .B1(n270), .A0N(N192), .A1N(n50), .Y(n235) );
  OAI2BB2XL U380 ( .B0(n206), .B1(n270), .A0N(N191), .A1N(n50), .Y(n236) );
  OAI2BB2XL U381 ( .B0(n205), .B1(n270), .A0N(N190), .A1N(n50), .Y(n237) );
  OAI2BB2XL U382 ( .B0(n204), .B1(n270), .A0N(N189), .A1N(n50), .Y(n238) );
  OAI2BB2XL U383 ( .B0(n203), .B1(n270), .A0N(N196), .A1N(n50), .Y(n239) );
  NAND4X1 U384 ( .A(n166), .B(n167), .C(n168), .D(n169), .Y(n217) );
  AOI22X1 U385 ( .A0(radius[9]), .A1(n46), .B0(radius[5]), .B1(n308), .Y(n166)
         );
  AOI22X1 U386 ( .A0(n317), .A1(n183), .B0(radius[1]), .B1(n318), .Y(n167) );
  AOI22X1 U387 ( .A0(n319), .A1(n179), .B0(n313), .B1(n180), .Y(n168) );
  AND2X2 U388 ( .A(central[20]), .B(n323), .Y(n25) );
  NAND3X1 U389 ( .A(n144), .B(n145), .C(n146), .Y(n216) );
  AOI22X1 U390 ( .A0(n160), .A1(n319), .B0(n161), .B1(n313), .Y(n144) );
  AOI221XL U391 ( .A0(n147), .A1(n317), .B0(radius[2]), .B1(n318), .C0(n148), 
        .Y(n146) );
  AOI222XL U392 ( .A0(n151), .A1(n310), .B0(n152), .B1(n316), .C0(n153), .C1(
        n306), .Y(n145) );
  AND2X2 U393 ( .A(central[8]), .B(n304), .Y(n35) );
  AND2X2 U394 ( .A(central[0]), .B(n304), .Y(n42) );
  AND2X2 U395 ( .A(central[16]), .B(n304), .Y(n39) );
  CLKINVX1 U396 ( .A(n191), .Y(n297) );
  AOI222XL U397 ( .A0(dis[4]), .A1(n186), .B0(multiplier[4]), .B1(n187), .C0(
        N97), .C1(n188), .Y(n191) );
  CLKINVX1 U398 ( .A(n193), .Y(n299) );
  AOI222XL U399 ( .A0(dis[2]), .A1(n186), .B0(multiplier[2]), .B1(n187), .C0(
        N95), .C1(n188), .Y(n193) );
  CLKINVX1 U400 ( .A(n190), .Y(n296) );
  AOI222XL U401 ( .A0(dis[5]), .A1(n186), .B0(multiplier[5]), .B1(n187), .C0(
        N98), .C1(n188), .Y(n190) );
  CLKINVX1 U402 ( .A(n195), .Y(n300) );
  AOI222XL U403 ( .A0(dis[0]), .A1(n186), .B0(multiplier[0]), .B1(n187), .C0(
        N93), .C1(n188), .Y(n195) );
  CLKBUFX3 U404 ( .A(n49), .Y(n270) );
  OA22X1 U405 ( .A0(n311), .A1(n315), .B0(n53), .B1(n54), .Y(n49) );
  AOI221XL U406 ( .A0(n55), .A1(n329), .B0(n57), .B1(n328), .C0(n59), .Y(n53)
         );
  OAI211X1 U407 ( .A0(mode[1]), .A1(n303), .B0(n60), .C0(n212), .Y(n55) );
  AO22X1 U408 ( .A0(radius[7]), .A1(n308), .B0(radius[11]), .B1(n46), .Y(n114)
         );
  AO22X1 U409 ( .A0(radius[6]), .A1(n308), .B0(radius[10]), .B1(n46), .Y(n148)
         );
  CLKINVX1 U410 ( .A(mode[0]), .Y(n303) );
  NOR2X1 U411 ( .A(rst), .B(n48), .Y(n230) );
  OAI22XL U412 ( .A0(n266), .A1(n32), .B0(n212), .B1(n306), .Y(n214) );
  OAI22XL U413 ( .A0(n266), .A1(n34), .B0(n211), .B1(n317), .Y(n213) );
  OAI22XL U414 ( .A0(n266), .A1(n88), .B0(n220), .B1(n307), .Y(n218) );
  AOI21X1 U415 ( .A0(n291), .A1(n290), .B0(dis[7]), .Y(n266) );
  OAI2BB2XL U416 ( .B0(n200), .B1(n63), .A0N(n63), .A1N(n311), .Y(n241) );
  NAND2X1 U417 ( .A(n64), .B(n62), .Y(n63) );
  NOR2X1 U418 ( .A(n320), .B(state[3]), .Y(n175) );
  OAI32X1 U419 ( .A0(n73), .A1(x[2]), .A2(n322), .B0(n75), .B1(n325), .Y(n244)
         );
  NOR2X1 U420 ( .A(state[3]), .B(state[2]), .Y(n177) );
  NAND2X1 U421 ( .A(n197), .B(state[2]), .Y(n104) );
  NAND4X1 U422 ( .A(n201), .B(n323), .C(n324), .D(n325), .Y(n97) );
  NAND3X1 U423 ( .A(n175), .B(n314), .C(state[1]), .Y(n87) );
  NAND3X1 U424 ( .A(state[0]), .B(n321), .C(n175), .Y(n31) );
  NAND3X1 U425 ( .A(n177), .B(n314), .C(state[1]), .Y(n29) );
  NOR3X1 U426 ( .A(n97), .B(n267), .C(n268), .Y(n66) );
  OR3X2 U427 ( .A(y[0]), .B(y[2]), .C(y[1]), .Y(n267) );
  OAI2BB1X1 U428 ( .A0N(n201), .A1N(n70), .B0(n71), .Y(n243) );
  OR4X1 U429 ( .A(n325), .B(n73), .C(n322), .D(n201), .Y(n71) );
  OAI21XL U430 ( .A0(x[2]), .A1(n73), .B0(n75), .Y(n70) );
  OA21XL U431 ( .A0(x[0]), .A1(n73), .B0(n77), .Y(n80) );
  OAI32X1 U432 ( .A0(n326), .A1(y[2]), .A2(n69), .B0(n105), .B1(n327), .Y(n229) );
  OAI221XL U433 ( .A0(n323), .A1(n77), .B0(x[0]), .B1(n73), .C0(n305), .Y(n246) );
  NAND3X1 U434 ( .A(y[0]), .B(n107), .C(n312), .Y(n69) );
  NAND3X1 U435 ( .A(n175), .B(state[0]), .C(state[1]), .Y(n34) );
  NAND4X1 U436 ( .A(state[3]), .B(state[1]), .C(state[0]), .D(n320), .Y(n54)
         );
  OAI22XL U437 ( .A0(n67), .A1(n326), .B0(y[1]), .B1(n69), .Y(n242) );
  NAND3X1 U438 ( .A(n177), .B(n321), .C(state[0]), .Y(n33) );
  OAI21XL U439 ( .A0(n311), .A1(n202), .B0(n62), .Y(n240) );
  OA21XL U440 ( .A0(y[0]), .A1(n104), .B0(n107), .Y(n67) );
  OA21XL U441 ( .A0(y[1]), .A1(n104), .B0(n67), .Y(n105) );
  OAI2BB1X1 U442 ( .A0N(y[3]), .A1N(n101), .B0(n102), .Y(n251) );
  OR4X1 U443 ( .A(n69), .B(n327), .C(n326), .D(y[3]), .Y(n102) );
  OAI21XL U444 ( .A0(y[2]), .A1(n104), .B0(n105), .Y(n101) );
  CLKINVX1 U445 ( .A(dis[6]), .Y(n294) );
  AND2X1 U446 ( .A(multiplier[0]), .B(a[2]), .Y(n273) );
  NOR2BX1 U447 ( .AN(multiplier[0]), .B(n279), .Y(n280) );
  NAND2X1 U448 ( .A(a[2]), .B(n279), .Y(n274) );
  NOR2X1 U449 ( .A(n279), .B(n276), .Y(n277) );
  XOR2X1 U450 ( .A(n280), .B(n273), .Y(multiplier[3]) );
  XOR2X1 U451 ( .A(n272), .B(n275), .Y(multiplier[4]) );
  NAND2X1 U452 ( .A(multiplier[0]), .B(a[3]), .Y(n272) );
  NOR2BX1 U453 ( .AN(n274), .B(n273), .Y(n275) );
  XOR3X1 U454 ( .A(a[2]), .B(n278), .C(n277), .Y(multiplier[5]) );
  NOR2X1 U455 ( .A(n280), .B(n279), .Y(multiplier[2]) );
  NAND2BX1 U456 ( .AN(dis[4]), .B(multiplier[4]), .Y(n281) );
  OAI222XL U457 ( .A0(dis[5]), .A1(n292), .B0(dis[5]), .B1(n281), .C0(n292), 
        .C1(n281), .Y(n282) );
  OAI222XL U458 ( .A0(multiplier[6]), .A1(n282), .B0(n294), .B1(n282), .C0(
        multiplier[6]), .C1(n294), .Y(n291) );
  NOR2BX1 U459 ( .AN(dis[4]), .B(multiplier[4]), .Y(n283) );
  OAI22XL U460 ( .A0(n283), .A1(n292), .B0(dis[5]), .B1(n283), .Y(n289) );
  NAND2BX1 U461 ( .AN(dis[2]), .B(multiplier[2]), .Y(n287) );
  NOR2BX1 U462 ( .AN(dis[2]), .B(multiplier[2]), .Y(n284) );
  OAI22XL U463 ( .A0(n284), .A1(n293), .B0(dis[3]), .B1(n284), .Y(n285) );
  AOI2BB2X1 U464 ( .B0(n255), .B1(n285), .A0N(n287), .A1N(n293), .Y(n286) );
  OAI221XL U465 ( .A0(dis[3]), .A1(n287), .B0(dis[3]), .B1(n293), .C0(n286), 
        .Y(n288) );
  OAI211X1 U466 ( .A0(multiplier[6]), .A1(n294), .B0(n289), .C0(n288), .Y(n290) );
endmodule

