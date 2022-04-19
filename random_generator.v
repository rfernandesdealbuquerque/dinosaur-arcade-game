module random_generator(q7, q6, q5, q4, clk, en, reset); //will vary bits 4 to 7 of output being 0000xxxx1111 - vary from 15 to 255

    input clk, en, reset;
    output q7, q6, q5, q4;

    wire f;

    xor XOR(f, q7, q4);
    register REG_7(.Q(q7), .D(f), .clk(clk), .WE(1'b1), .clear(reset));
    register REG_6(.Q(q6), .D(q7), .clk(clk), .WE(1'b1), .clear(reset));
    register REG_5(.Q(q5), .D(q6), .clk(clk), .WE(1'b1), .clear(reset));
    register REG_4(.Q(q4), .D(q5), .clk(clk), .WE(1'b1), .clear(reset));


endmodule