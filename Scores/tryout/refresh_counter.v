module refresh_counter(
    input clk,
    output reg [2:0] counter = 0
);

always@ (posedge clk) begin
    counter <= counter + 1;
end

endmodule