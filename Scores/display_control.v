// Reference https://www.youtube.com/watch?v=s4lPOQ1VAkU
module display_control (
    input [2:0] refresh_counter, 
    input [3:0] digit_7,
    input [3:0] digit_6,
    input [3:0] digit_5,
    input [3:0] digit_4,
    input [3:0] digit_3,
    input [3:0] digit_2,
    input [3:0] digit_1,
    input [3:0] digit_0,

    output reg [3:0] displayed_digit = 0,
    output reg [7:0] AN = 0
);

// really similar to a mux, but not gonna risk it because it's reg vars, AN: one-hot
always@ (refresh_counter) begin
    case (refresh_counter)
        3'd0: begin
            displayed_digit <= digit_0; // (LSB) - invert val
            AN <= 8'b11111110; // (LSB) - invert val
        end 
        3'd1: begin
            displayed_digit <= digit_1;
            AN <= 8'b11111101;
        end 
        3'd2: begin
            displayed_digit <= digit_2;
            AN <= 8'b11111011;
        end 
        3'd3: begin
            displayed_digit <= digit_3; 
            AN <= 8'b11110111; 
        end 
        3'd4: begin
            displayed_digit <= digit_4; 
            AN <= 8'b11101111; 
        end 
        3'd5: begin
            displayed_digit <= digit_5;
            AN <= 8'b11011111;
        end 
        3'd6: begin
            displayed_digit <= digit_6;
            AN <= 8'b10111111;
        end 
        3'd7: begin
            displayed_digit <= digit_7; // (MSB)
            AN <= 8'b01111111; // (MSB)
        end 
    endcase
end

endmodule
