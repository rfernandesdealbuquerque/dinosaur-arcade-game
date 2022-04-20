module LED_segments(
    input refresh_clock, 
    input  [31:0] BCD_bits,
    output [7:0]  AN,
    output [6:0]  CAT
);

    wire refresh_clock;

    wire [2:0] refresh_counter;
    wire [3:0] displayed_digit;

    refresh_counter refresh_count(
        .clk(refresh_clock),
        .counter(refresh_counter)
    );

    display_control display_pins(
        .refresh_counter(refresh_counter),
        .digit_7(BCD_bits[31:28]),
        .digit_6(BCD_bits[27:24]),
        .digit_5(BCD_bits[23:20]),
        .digit_4(BCD_bits[19:16]),
        .digit_3(BCD_bits[15:12]),
        .digit_2(BCD_bits[11:8]),
        .digit_1(BCD_bits[7:4]),
        .digit_0(BCD_bits[3:0]),
        .displayed_digit(displayed_digit),
        .AN(AN)
    );

    cathode_control cathode_pins(
        .displayed_digit(displayed_digit),
        .cathode(CAT)
    );

endmodule

