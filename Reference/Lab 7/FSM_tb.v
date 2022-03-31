`timescale 1 ns / 100 ps
module FSM_tb;

    reg clk;
    
    wire out;
    
    wire in, en, clr;
    assign in = 1'b1;
    assign en = 1'b1;
    assign clr = 1'b0;
    
    FSM fsm_machine(.out(out), .in(in), .clk(clk), .en(en), .clr(clr));

    initial begin
        clk = 0;
        
        
        #200;
        
        $finish;
    end
    
    always 
        #10 clk = ~clk;
        
    always @(clk) begin
    
        #1;
        $display("Out: %b", out);
    end
    
endmodule 