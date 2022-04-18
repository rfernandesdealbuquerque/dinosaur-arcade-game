module register(Q, D, clk, WE, clear);

input [31:0] D;
input WE, clear, clk;
output [31:0] Q;

genvar i;
generate
    for(i=0; i<32; i=i+1) begin: loop1
        dffe_ref DFF(.q(Q[i]), .d(D[i]), .clk(clk), .en(WE), .clr(clear));
    end
endgenerate

endmodule