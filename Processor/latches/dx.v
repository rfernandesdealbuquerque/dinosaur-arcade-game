module dx(q_pc, q_a, q_b, q_ir, d_pc, d_a, d_b, d_ir, clk, en, clr);

    input [31:0] d_pc, d_a, d_b, d_ir;
    input clk, en, clr;

    output [31:0] q_pc, q_a, q_b, q_ir;

    genvar i;
    
    // wired bus only for 32 dffe units. 
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop1
            dffe_ref dffe_pc(q_pc[i], d_pc[i], clk, en, clr);
            dffe_ref dffe_a(q_a[i], d_a[i], clk, en, clr);
            dffe_ref dffe_b(q_b[i], d_b[i], clk, en, clr);
            dffe_ref dffe_ir(q_ir[i], d_ir[i], clk, en, clr);
        end

    endgenerate

endmodule