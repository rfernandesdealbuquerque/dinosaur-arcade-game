module fetch(
	pc_out, 
	address_imem, pc_plus_one
); 	
	
	input [31:0] pc_out;
	output [31:0] address_imem;
	output [31:0] pc_plus_one;
	
    // assign address_imem[11:0] = pc_out[11:0];
	assign address_imem = pc_out;
	
	wire [31:0] pc_plus_one;

    wire cout1, ovf1;
    CLA_32 adder(.x(pc_out), .y(32'd1), .cin(1'b0), .sum(pc_plus_one), .cout(cout1), .overflow(ovf1));
	

endmodule