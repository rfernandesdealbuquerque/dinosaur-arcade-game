module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB, 

	r0, r16, r17, r18, r19, r20, r21, r22
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;

	output [31:0] r0, r16, r17, r18, r19, r20, r21, r22;

	// add your code here

	wire [31:0] registers[31:0];

	wire [31:0] one_hot_write;
	decoder_write decoding(ctrl_writeEnable, ctrl_writeReg, one_hot_write);

	wire [31:0] one_hot_A;
	decoder_read decoding_A(ctrl_readRegA, one_hot_A);

	wire [31:0] one_hot_B;
	decoder_read decoding_B(ctrl_readRegB, one_hot_B);

	genvar i; 
	generate
        for (i = 0; i < 32; i = i + 1) begin: loop_read_A
   	        tristate_32 tristate_A_n(registers[i], one_hot_A[i], data_readRegA);
        end
    endgenerate

	genvar j; 
	generate
        for (j = 0; j < 32; j = j + 1) begin: loop_read_B
   	        tristate_32 tristate_B_n(registers[j], one_hot_B[j], data_readRegB);
        end
    endgenerate
	
	// @ register 0
	register register_0(registers[0], 32'b0000000000000000000000000000000, clock, one_hot_write[0], ctrl_reset);
    genvar k;
	generate
        for (k = 1; k < 32; k = k + 1) begin: loop_write
   	        register register_n(registers[k], data_writeReg, clock, one_hot_write[k], ctrl_reset);
        end
    endgenerate

	// New Output
	assign r0 = registers[0];
	assign r16 = registers[16];
	assign f17 = registers[17];
	assign r18 = registers[18];
	assign r19 = registers[19];
	assign r20 = registers[20];
	assign r21 = registers[21];
	assign r22 = registers[22];

endmodule
