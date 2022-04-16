module decoder_read(select_bits, result);

    input [4:0] select_bits;

    output [31:0] result;

    wire [31:0] shift_1, shift_2, shift_4, shift_8, shift_16;

    // borrowed from my SLL shifter
    
    // when shift 0, actually enable at 1. 
    // when shift 1, actually enable at 10. 
    mux_2 one_bit(shift_1, select_bits[0], 32'b00000000000000000000000000000001, 32'b00000000000000000000000000000010);
    mux_2 two_bit(shift_2, select_bits[1], shift_1, {shift_1[29:0], 2'b00});
    mux_2 four_bit(shift_4, select_bits[2], shift_2, {shift_2[27:0], 4'b0000});
    mux_2 eight_bit(shift_8, select_bits[3], shift_4, {shift_4[23:0], 8'b00000000});
    mux_2 sixteen_bit(shift_16, select_bits[4], shift_8, {shift_8[15:0], 16'b0000000000000000});

    assign result = shift_16; 

endmodule