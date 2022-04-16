module decoder_32(out, in, enable);

input [4:0] in;
input enable;
output [31:0] out;
wire not_in4, not_in3, not_in2, not_in1, not_in0;
wire in4, in3, in2, in1, in0;
assign in4 = in[4];
assign in3 = in[3];
assign in2 = in[2];
assign in1 = in[1];
assign in0 = in[0];

not not0(not_in0, in[0]);
not not1(not_in1, in[1]);
not not2(not_in2, in[2]);
not not3(not_in3, in[3]);
not not4(not_in4, in[4]);

wire out0, out1, out2, out3, out4, out5, out6, out7;
wire out8, out9, out10, out11, out12, out13, out14, out15;
wire out16, out17, out18, out19, out20, out21, out22, out23;
wire out24, out25, out26, out27, out28, out29, out30, out31;


and and0 (out0, not_in4, not_in3, not_in2, not_in1, not_in0);
and and1 (out1, not_in4, not_in3, not_in2, not_in1, in0);
and and2 (out2, not_in4, not_in3, not_in2, in1, not_in0);
and and3 (out3, not_in4, not_in3, not_in2, in1, in0);
and and4 (out4, not_in4, not_in3, in2, not_in1, not_in0);
and and5 (out5, not_in4, not_in3, in2, not_in1, in0);
and and6 (out6, not_in4, not_in3, in2, in1, not_in0);
and and7 (out7, not_in4, not_in3, in2, in1, in0);

and and8 (out8, not_in4, in3, not_in2, not_in1, not_in0);
and and9 (out9, not_in4, in3, not_in2, not_in1, in0);
and and10 (out10, not_in4, in3, not_in2, in1, not_in0);
and and11 (out11, not_in4, in3, not_in2, in1, in0);
and and12 (out12, not_in4, in3, in2, not_in1, not_in0);
and and13 (out13, not_in4, in3, in2, not_in1, in0);
and and14 (out14, not_in4, in3, in2, in1, not_in0);
and and15 (out15, not_in4, in3, in2, in1, in0);

and and16 (out16, in4, not_in3, not_in2, not_in1, not_in0);
and and17 (out17, in4, not_in3, not_in2, not_in1, in0);
and and18 (out18, in4, not_in3, not_in2, in1, not_in0);
and and19 (out19, in4, not_in3, not_in2, in1, in0);
and and20 (out20, in4, not_in3, in2, not_in1, not_in0);
and and21 (out21, in4, not_in3, in2, not_in1, in0);
and and22 (out22, in4, not_in3, in2, in1, not_in0);
and and23 (out23, in4, not_in3, in2, in1, in0);

and and24 (out24, in4, in3, not_in2, not_in1, not_in0);
and and25 (out25, in4, in3, not_in2, not_in1, in0);
and and26 (out26, in4, in3, not_in2, in1, not_in0);
and and27 (out27, in4, in3, not_in2, in1, in0);
and and28 (out28, in4, in3, in2, not_in1, not_in0);
and and29 (out29, in4, in3, in2, not_in1, in0);
and and30 (out30, in4, in3, in2, in1, not_in0);
and and31 (out31, in4, in3, in2, in1, in0);

and anden0(out[0], out0, enable);
and anden1(out[1], out1, enable);
and anden2(out[2], out2, enable);
and anden3(out[3], out3, enable);
and anden4(out[4], out4, enable);
and anden5(out[5], out5, enable);
and anden6(out[6], out6, enable);
and anden7(out[7], out7, enable);

and anden8(out[8], out8, enable);
and anden9(out[9], out9, enable);
and anden10(out[10], out10, enable);
and anden11(out[11], out11, enable);
and anden12(out[12], out12, enable);
and anden13(out[13], out13, enable);
and anden14(out[14], out14, enable);
and anden15(out[15], out15, enable);

and anden16(out[16], out16, enable);
and anden17(out[17], out17, enable);
and anden18(out[18], out18, enable);
and anden19(out[19], out19, enable);
and anden20(out[20], out20, enable);
and anden21(out[21], out21, enable);
and anden22(out[22], out22, enable);
and anden23(out[23], out23, enable);

and anden24(out[24], out24, enable);
and anden25(out[25], out25, enable);
and anden26(out[26], out26, enable);
and anden27(out[27], out27, enable);
and anden28(out[28], out28, enable);
and anden29(out[29], out29, enable);
and anden30(out[30], out30, enable);
and anden31(out[31], out31, enable);


endmodule