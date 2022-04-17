module SRA(x, shiftamt, result);

    input [31:0] x;
    input [4:0] shiftamt;

    output [31:0] result;

    wire sign;
    wire [31:0] shift_0_1, shift_0_2, shift_0_4, shift_0_8, shift_0_16;
    wire [31:0] shift_1_1, shift_1_2, shift_1_4, shift_1_8, shift_1_16;

    assign sign = x[31]; 
    mux_2 one_bit_0(shift_0_1, shiftamt[0], x, {1'b0, x[31:1]});
    mux_2 two_bit_0(shift_0_2, shiftamt[1], shift_0_1, {2'b00, shift_0_1[31:2]});
    mux_2 four_bit_0(shift_0_4, shiftamt[2], shift_0_2, {4'b0000, shift_0_2[31:4]});
    mux_2 eight_bit_0(shift_0_8, shiftamt[3], shift_0_4, {8'b00000000, shift_0_4[31:8]});
    mux_2 sixteen_bit_0(shift_0_16, shiftamt[4], shift_0_8, {16'b0000000000000000, shift_0_8[31:16]});

    mux_2 one_bit_1(shift_1_1, shiftamt[0], x, {1'b1, x[31:1]});
    mux_2 two_bit_1(shift_1_2, shiftamt[1], shift_1_1, {2'b11, shift_1_1[31:2]});
    mux_2 four_bit_1(shift_1_4, shiftamt[2], shift_1_2, {4'b1111, shift_1_2[31:4]});
    mux_2 eight_bit_1(shift_1_8, shiftamt[3], shift_1_4, {8'b11111111, shift_1_4[31:8]});
    mux_2 sixteen_bit_1(shift_1_16, shiftamt[4], shift_1_8, {16'b1111111111111111, shift_1_8[31:16]});

    mux_2 final_result(result, sign, shift_0_16, shift_1_16);
    
endmodule