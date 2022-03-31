module SLL(x, shiftamt, result);

    input [31:0] x;
    input [4:0] shiftamt;

    output [31:0] result;

    wire [31:0] shift_1, shift_2, shift_4, shift_8, shift_16;

    // shift left 
    // 5 shift-left-by-x-or-0, 1, 2, 4, 8, 16

    mux_2 one_bit(shift_1, shiftamt[0], x, {x[30:0], 1'b0});
    mux_2 two_bit(shift_2, shiftamt[1], shift_1, {shift_1[29:0], 2'b00});
    mux_2 four_bit(shift_4, shiftamt[2], shift_2, {shift_2[27:0], 4'b0000});
    mux_2 eight_bit(shift_8, shiftamt[3], shift_4, {shift_4[23:0], 8'b00000000});
    mux_2 sixteen_bit(shift_16, shiftamt[4], shift_8, {shift_8[15:0], 16'b0000000000000000});

    assign result = shift_16; 

endmodule