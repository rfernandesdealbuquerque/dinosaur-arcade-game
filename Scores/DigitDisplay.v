module DigitDisplay(
    digit_bits, 
    d
);

    // largest possible number = 00000000000000011000011010011111 = 99999
    output [6:0] digit_bits;
    
    input [3:0] d; // binary version
    
    // 7-segment display
    assign digit_bits[6] = (~d[3] & ~d[2] & ~d[1] &  d[0]) | (~d[3] &  d[2] & ~d[1] & ~d[0]); // A = 0001 + 0100
    assign digit_bits[5] = (~d[3] &  d[2] & ~d[1] &  d[0]) | (~d[3] &  d[2] &  d[1] & ~d[0]); // B = 0101 + 0110
    assign digit_bits[4] = (~d[3] & ~d[2] &  d[1] & ~d[0]); // C = 0010
    assign digit_bits[3] = (~d[3] & ~d[2] & ~d[1] &  d[0]) | (~d[3] &  d[2] &  d[1] &  d[0]); // D = 0001 + 0111
    assign digit_bits[2] = (~d[2] & ~d[1] &  d[0]) | (~d[3] &  d[2] & ~d[1]) | (~d[3] & d[0]); // E = x001 + 010x + 0xx1
    assign digit_bits[1] = (~d[3] & ~d[2] &  d[0]) | (~d[3] & ~d[2] &  d[1]) | (~d[3] & d[1] & d[0]); // F = 00x1 + 001x + 0x11
    assign digit_bits[0] = (~d[3] & ~d[2] & ~d[1]) | (~d[3] &  d[2] &  d[1] &  d[0]); // G = 000x + 0111

    // TODO: or behavioral code works too

endmodule 