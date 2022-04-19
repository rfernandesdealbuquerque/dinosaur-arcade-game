module BCD(
    q, 
    // lcd_7, lcd_6, lcd_5,
    lcd_4, lcd_3, lcd_2, lcd_1, lcd_0, 

    clk, // scoring clock, debate whether to add 
    en, // end of life
    clr // end of life -- collision signal
);
    // output [6:0] lcd_7, lcd_6, lcd_5;
    output [6:0] lcd_4, lcd_3, lcd_2, lcd_1, lcd_0; // actual lcd display
    output [19:0] q; // 5 x 4 bits

    input clk, en, clr;  

    reg[3:0] q4, q3, q2, q1, q0; // 5 bits - 4 MSB, 0 LSB

    initial 
    begin
        q4 = 4'b1001;
        q3 = 4'b1001;
        q2 = 4'b0000;
        q1 = 4'b0000;
        q0 = 4'b0000;
    end 

    always @(posedge clk)
    begin
        if (clr) begin
            q4 <= 4'b0000;
            q3 <= 4'b0000;
            q2 <= 4'b0000;
            q1 <= 4'b0000;
            q0 <= 4'b0000;
        end
        else if (en) begin
            if (q0 < 9) begin 
                q0 <= q0 + 1;
            end
            else begin

                // q1
                if (q1 < 9) begin
                    q1 <= q1 + 1;
                end
                else begin

                    // q2
                    if (q2 < 9) begin
                        q2 <= q2 + 1;
                    end
                    else begin

                        // q3 
                        if (q3 < 9) begin
                            q3 <= q3 + 1;
                        end
                        else begin

                            // q4
                            if (q4 < 9) begin
                                q4 <= q4 + 1;
                            end
                            else begin
                                q4 <= 4'b0;
                            end
                            
                            q3 <= 4'b0;
                        end

                        q2 <= 4'b0;
                    end

                    q1 <= 4'b0;
                end

                q0 <= 4'b0;
            end
        end
        // q0 <= clr? 0 : ((q0 < 9)? q0 + 1 : 0);
        // q1 <= clr? 0 : ((q0 < 9)? q1 : ((q1 < 9) ? (q1 + 1) : 0));
    end

    assign q[19:16] = q4;
    assign q[15:12] = q3;
    assign q[11:8]  = q2;
    assign q[7:4]   = q1;
    assign q[3:0]   = q0;

    // DigitDisplay DD_7(.digit_bits(lcd_7), .d(4'b0000));
    // DigitDisplay DD_6(.digit_bits(lcd_6), .d(4'b0000));
    // DigitDisplay DD_5(.digit_bits(lcd_5), .d(4'b0000));

    DigitDisplay DD_4(.digit_bits(lcd_4), .d(q4));
    DigitDisplay DD_3(.digit_bits(lcd_3), .d(q3));
    DigitDisplay DD_2(.digit_bits(lcd_4), .d(q2));
    DigitDisplay DD_1(.digit_bits(lcd_4), .d(q1));
    DigitDisplay DD_0(.digit_bits(lcd_4), .d(q0));

endmodule 