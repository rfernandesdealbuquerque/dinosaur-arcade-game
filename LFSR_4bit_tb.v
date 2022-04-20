`timescale 1 ns / 100 ps
module LFSR_4bit_tb;

    reg clk;
    
    wire  q7, q6, q5, q4;
    wire en, reset;
    wire [3:0] out;

    assign en = 1'b1;
    assign clr = 1'b0;
        
    
    LFSR_4bit lfsr(.q7(q7), .q6(q6), .q5(q5), .q4(q4), .clk(clk), .en(en), .reset(clr));

    assign out[0] = q4;
    assign out[1] = q5;
    assign out[2] = q6;
    assign out[3] = q7;

    initial begin
        clk = 0;
        #20000;
        
        $finish;
    end
    
    always 
        #5 clk = ~clk;

    always @(posedge clk) begin
        #1;
        $display("Out: %b", out);
        // $display("Out : %d", q);
    end
    
endmodule 