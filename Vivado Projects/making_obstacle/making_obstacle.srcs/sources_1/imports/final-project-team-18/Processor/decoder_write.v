module decoder_write(enable, select_bits, result);

    input enable;
    input [4:0] select_bits;

    output [31:0] result;

    wire [31:0] shift_1, shift_2, shift_4, shift_8, shift_16;
    wire [31:0] enable_pad;

    assign enable_pad = {31'b0000000000000000000000000000000, enable};

    // borrowed from my SLL shifter
    
    mux_2 one_bit(shift_1, select_bits[0], enable_pad, {enable_pad[30:0], 1'b0});
    mux_2 two_bit(shift_2, select_bits[1], shift_1, {shift_1[29:0], 2'b00});
    mux_2 four_bit(shift_4, select_bits[2], shift_2, {shift_2[27:0], 4'b0000});
    mux_2 eight_bit(shift_8, select_bits[3], shift_4, {shift_4[23:0], 8'b00000000});
    mux_2 sixteen_bit(shift_16, select_bits[4], shift_8, {shift_8[15:0], 16'b0000000000000000});

    assign result = shift_16; 

endmodule
