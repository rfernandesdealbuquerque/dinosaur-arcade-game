module pc(q, d, clk, en, clr);

    input [31:0] d;
    input clk, en, clr;

    output [31:0] q;

    genvar i;
    
    // wired bus only for 32 dffe units. 
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop1
            dffe_neg dffe_n(q[i], d[i], clk, en, clr);
        end
    endgenerate

endmodule