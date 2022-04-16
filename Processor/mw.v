module mw(q_o, q_d, q_ir, q_ovf, d_o, d_d, d_ir, d_ovf, clk, en, clr);

    input [31:0] d_o, d_d, d_ir;
    input d_ovf;
    input clk, en, clr;

    output [31:0] q_o, q_d, q_ir;
    output q_ovf;

    genvar i;
    
    // wired bus only for 32 dffe units. 
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop1
            dffe_ref dffe_o(q_o[i], d_o[i], clk, en, clr);
            dffe_ref dffe_d(q_d[i], d_d[i], clk, en, clr);
            dffe_ref dffe_ir(q_ir[i], d_ir[i], clk, en, clr);
        end
    endgenerate
    
    dffe_ref dffe_ovf(q_ovf, d_ovf, clk, en, clr);

endmodule