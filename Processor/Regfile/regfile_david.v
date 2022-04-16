module regfile_david (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB, 

	r20, r22, 
	r16, r17
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;

	input  [31:0] r20, r22;
	output [31:0] r16, r17;

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
	register register_1(registers[1], data_writeReg, clock, one_hot_write[1], ctrl_reset);
	register register_2(registers[2], data_writeReg, clock, one_hot_write[2], ctrl_reset);
	register register_3(registers[3], data_writeReg, clock, one_hot_write[3], ctrl_reset);
	register register_4(registers[4], data_writeReg, clock, one_hot_write[4], ctrl_reset);
	register register_5(registers[5], data_writeReg, clock, one_hot_write[5], ctrl_reset);
	register register_6(registers[6], data_writeReg, clock, one_hot_write[6], ctrl_reset);
	register register_7(registers[7], data_writeReg, clock, one_hot_write[7], ctrl_reset);
	register register_8(registers[8], data_writeReg, clock, one_hot_write[8], ctrl_reset);
	register register_9(registers[9], data_writeReg, clock, one_hot_write[9], ctrl_reset);
	register register_10(registers[10], data_writeReg, clock, one_hot_write[10], ctrl_reset);
	register register_11(registers[11], data_writeReg, clock, one_hot_write[11], ctrl_reset);
	register register_12(registers[12], data_writeReg, clock, one_hot_write[12], ctrl_reset);
	register register_13(registers[13], data_writeReg, clock, one_hot_write[13], ctrl_reset);
	register register_14(registers[14], data_writeReg, clock, one_hot_write[14], ctrl_reset);
	register register_15(registers[15], data_writeReg, clock, one_hot_write[15], ctrl_reset);
	register register_16(r16, data_writeReg, clock, one_hot_write[16], ctrl_reset);
	register register_17(r17, data_writeReg, clock, one_hot_write[17], ctrl_reset);
	register register_18(registers[18], data_writeReg, clock, one_hot_write[18], ctrl_reset);
	register register_19(registers[19], data_writeReg, clock, one_hot_write[19], ctrl_reset);
	// register register_20(registers[20], data_writeReg, clock, one_hot_write[20], ctrl_reset);
	register register_21(registers[21], data_writeReg, clock, one_hot_write[21], ctrl_reset);
	// register register_22(registers[22], data_writeReg, clock, one_hot_write[22], ctrl_reset);
	register register_23(registers[23], data_writeReg, clock, one_hot_write[23], ctrl_reset);
	register register_24(registers[24], data_writeReg, clock, one_hot_write[24], ctrl_reset);
	register register_25(registers[25], data_writeReg, clock, one_hot_write[25], ctrl_reset);
	register register_26(registers[26], data_writeReg, clock, one_hot_write[26], ctrl_reset);
	register register_27(registers[27], data_writeReg, clock, one_hot_write[27], ctrl_reset);
	register register_28(registers[28], data_writeReg, clock, one_hot_write[28], ctrl_reset);
	register register_29(registers[29], data_writeReg, clock, one_hot_write[29], ctrl_reset);
	register register_30(registers[30], data_writeReg, clock, one_hot_write[30], ctrl_reset);
	register register_31(registers[31], data_writeReg, clock, one_hot_write[31], ctrl_reset);
	
	register register_20(registers[20], r20          , clock, one_hot_write[20], ctrl_reset);
	register register_22(registers[22], r22          , clock, one_hot_write[22], ctrl_reset);

	// genvar k;
	// generate
    //     for (k = 1; k < 32; k = k + 1) begin: loop_write
   	//         register register_n(registers[k], data_writeReg, clock, one_hot_write[k], ctrl_reset);
    //     end
    // endgenerate

	// New Output
	//assign r16 = registers[16];
	//assign r17 = registers[17];


endmodule
