module BIT_AND(x, y, result);

    input [31:0] x;
    input [31:0] y;

    output [31:0] result;

    and and_bit_0(result[0], x[0], y[0]);
    and and_bit_1(result[1], x[1], y[1]);
    and and_bit_2(result[2], x[2], y[2]);
    and and_bit_3(result[3], x[3], y[3]);
    and and_bit_4(result[4], x[4], y[4]);
    and and_bit_5(result[5], x[5], y[5]);
    and and_bit_6(result[6], x[6], y[6]);
    and and_bit_7(result[7], x[7], y[7]);
    and and_bit_8(result[8], x[8], y[8]);
    and and_bit_9(result[9], x[9], y[9]);
    and and_bit_10(result[10], x[10], y[10]);
    and and_bit_11(result[11], x[11], y[11]);
    and and_bit_12(result[12], x[12], y[12]);
    and and_bit_13(result[13], x[13], y[13]);
    and and_bit_14(result[14], x[14], y[14]);
    and and_bit_15(result[15], x[15], y[15]);
    and and_bit_16(result[16], x[16], y[16]);
    and and_bit_17(result[17], x[17], y[17]);
    and and_bit_18(result[18], x[18], y[18]);
    and and_bit_19(result[19], x[19], y[19]);
    and and_bit_20(result[20], x[20], y[20]);
    and and_bit_21(result[21], x[21], y[21]);
    and and_bit_22(result[22], x[22], y[22]);
    and and_bit_23(result[23], x[23], y[23]);
    and and_bit_24(result[24], x[24], y[24]);
    and and_bit_25(result[25], x[25], y[25]);
    and and_bit_26(result[26], x[26], y[26]);
    and and_bit_27(result[27], x[27], y[27]);
    and and_bit_28(result[28], x[28], y[28]);
    and and_bit_29(result[29], x[29], y[29]);
    and and_bit_30(result[30], x[30], y[30]);
    and and_bit_31(result[31], x[31], y[31]);

endmodule