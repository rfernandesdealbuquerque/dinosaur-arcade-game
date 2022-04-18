module register_4(q, d, clk, en, clr);

    input [3:0] d;
    input clk, en, clr;
    wire clr;

    output [3:0] q;

    genvar i;
    
    // wired bus only for 32 dffe units. 
    generate
        for (i = 0; i < 4; i = i + 1) begin: loop1
   	        dffe_ref dffe_n(q[i], d[i], clk, en, clr);
        end
    endgenerate
endmodule