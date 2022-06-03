module SUBTRACT(x, y, sum, cout, overflow);
    input [31:0] x, y;

    output [31:0] sum;
    output cout;
    output overflow;

	wire [31:0] y_flipped;
	
    // prolly better with for loop here
    not not_0(y_flipped[0], y[0]);
    not not_1(y_flipped[1], y[1]);
    not not_2(y_flipped[2], y[2]);
    not not_3(y_flipped[3], y[3]);
    not not_4(y_flipped[4], y[4]);
    not not_5(y_flipped[5], y[5]);
    not not_6(y_flipped[6], y[6]);
    not not_7(y_flipped[7], y[7]);
    not not_8(y_flipped[8], y[8]);
    not not_9(y_flipped[9], y[9]);
    not not_10(y_flipped[10], y[10]);
    not not_11(y_flipped[11], y[11]);
    not not_12(y_flipped[12], y[12]);
    not not_13(y_flipped[13], y[13]);
    not not_14(y_flipped[14], y[14]);
    not not_15(y_flipped[15], y[15]);
    not not_16(y_flipped[16], y[16]);
    not not_17(y_flipped[17], y[17]);
    not not_18(y_flipped[18], y[18]);
    not not_19(y_flipped[19], y[19]);
    not not_20(y_flipped[20], y[20]);
    not not_21(y_flipped[21], y[21]);
    not not_22(y_flipped[22], y[22]);
    not not_23(y_flipped[23], y[23]);
    not not_24(y_flipped[24], y[24]);
    not not_25(y_flipped[25], y[25]);
    not not_26(y_flipped[26], y[26]);
    not not_27(y_flipped[27], y[27]);
    not not_28(y_flipped[28], y[28]);
    not not_29(y_flipped[29], y[29]);
    not not_30(y_flipped[30], y[30]);
    not not_31(y_flipped[31], y[31]);
	
	CLA_32 subtractor(x, y_flipped, 1'b1, sum, cout, overflow);

endmodule