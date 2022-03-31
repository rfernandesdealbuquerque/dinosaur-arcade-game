module pw(q_a, q_b, q_ir, q_run, d_a, d_b, d_ir, clk, en, result_ready, clr);

    input [31:0] d_a, d_b, d_ir;
    input clk, en, result_ready, clr;
    
    output [31:0] q_a, q_b, q_ir;
    output q_run;

    genvar i;

    // wired bus only for 32 dffe units. 
    generate
        for (i = 0; i < 32; i = i + 1) begin: loop1
            dffe_neg dffe_a(q_a[i], d_a[i], clk, en, clr);
            dffe_neg dffe_b(q_b[i], d_b[i], clk, en, clr);
            dffe_neg dffe_ir(q_ir[i], d_ir[i], clk, en, clr);
            // dffe_ref dffe_a(q_a[i], d_a[i], clk, en, clr);
            // dffe_ref dffe_b(q_b[i], d_b[i], clk, en, clr);
            // dffe_ref dffe_ir(q_ir[i], d_ir[i], clk, en, clr);
        end                
    endgenerate

    dffe_ref doing(q_run, 1'b1, clk, en, result_ready);
    // dffe_neg doing(q_run, 1'b1, clk, en, result_ready);


endmodule