module anode (
    input [1:0] refresh_counter, 
    output reg [3:0] AN = 0
);

always@ (refresh_counter) begin
    case (refresh_counter)
        2'd0: 
            AN = 4'b1110; // (LSB) - invert val
        2'd1: 
            AN = 4'b1101;
        2'd2: 
            AN = 4'b1011;
        2'd3: 
            AN = 4'b0111; // (MSB)
    endcase
end

endmodule
