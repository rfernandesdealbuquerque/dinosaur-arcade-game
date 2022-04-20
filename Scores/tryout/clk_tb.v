`timescale 1 ns / 100 ps
module clk_tb;

    reg clk = 0;
    
    wire divided_clk; 

    clock_divider #(4999999) refresh(
        .sysclk(clk), 
        .divided_clk(divided_clk)
    );
    
    always 
        #5 clk = ~clk; // 10ns --- 100MHz 
    
endmodule 