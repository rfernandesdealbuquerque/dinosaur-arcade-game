module LFSR_4bit(q7, q6, q5, q4, clk, en, reset); //will vary bits 4 to 7 of output being 0000xxxx1111 - vary from 15 to 255

    input clk, en, reset;
    output q7, q6, q5, q4;

    wire f;

    xor XOR(f, q7, q4);
    dffe_ref dff_7(.q(q7), .d(f), .clk(clk), .en(1'b1), .clr(reset));
    dffe_ref dff_6(.q(q6), .d(q7), .clk(clk), .en(1'b1), .clr(reset));
    dffe_ref dff_5(.q(q5), .d(q6), .clk(clk), .en(1'b1), .clr(reset));
    dffe_ref dff_4(.q(q4), .d(q5), .clk(clk), .en(1'b1), .clr(reset));


endmodule