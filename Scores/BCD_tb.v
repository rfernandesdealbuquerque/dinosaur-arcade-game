`timescale 1 ns / 100 ps
module BCD_tb;

    reg clk;
    
    wire [19:0] q;
    wire en, clr;

    assign en = 1'b1;
    assign clr = 1'b0;
        
    integer limit = 0;
    
    BCD fsm_machine(.q(q), .clk(clk), .en(en), .clr(clr));

    initial begin
        clk = 0;
        #20000;
        
        $finish;
    end
    
    always 
        #5 clk = ~clk;

    always @(posedge clk) begin
        #1;
        $display("Out : %b", q);
        // $display("Out : %d", q);
    end
    
endmodule 