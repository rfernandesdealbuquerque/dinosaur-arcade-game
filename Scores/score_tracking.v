module score_tracking(
    input clk,
    input en,
    input clr, 
    output [7:0]  AN,
    output [6:0]  CAT
);

    wire refresh_clock;
    wire update_clock;
    
    wire [31:0] BCD_bits;
    
    // high frequency so that people don't feel dizzy
    clock_divider #(4999) refresh(
        .sysclk(clk), 
        .divided_clk(refresh_clock)
    );
    
    // actual score update speed
    clock_divider #(4999999) update(
        .sysclk(clk), 
        .divided_clk(update_clock)
    );

    LED_segments seven_segments(
        .refresh_clock(refresh_clock), 
        .BCD_bits(BCD_bits),
        .AN(AN),
        .CAT(CAT)
    );

    BCD BCD_counter(
        .q(BCD_bits), 
    
        .clk(update_clock), // scoring clock, debate whether to add 
        .en(en), // end of life
        .clr(clr) // end of life -- collision signal
    );

endmodule