module clock_divider #(parameter CounterLimit = 4999)(
    input sysclk, 		// System Clock Input 100 Mhz
    output reg divided_clk = 0
);

    // updated clock_divider that is more flexible
    integer counter = 0;
    
    // assign CounterLimit = (sysclkfreq / (2 * divclkfreq)) - 1;
    always @(posedge sysclk) begin
        if(counter == CounterLimit) begin
            counter <= 0; // reset   
            divided_clk <= ~divided_clk;
        end 
        else begin
            counter <= counter + 1;
            divided_clk <= divided_clk;
        end
    end
    
endmodule