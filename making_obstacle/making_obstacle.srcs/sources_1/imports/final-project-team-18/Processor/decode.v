module decode(instruction, ctrl_readRegA, ctrl_readRegB);
	
	input [31:0] instruction;
	
	output [4:0] ctrl_readRegA, ctrl_readRegB;
	
    wire [4:0] current_opcode, Rs, Rt, Rd, Rstatus_addr;
    wire is_R, is_bex;

    
    assign current_opcode = instruction[31:27];
    
    assign Rd = instruction[26:22];
    assign Rs = instruction[21:17];
    assign Rt = instruction[16:12];

    // r type
    assign is_R   = ~current_opcode[4] & ~current_opcode[3] & ~current_opcode[2] & ~current_opcode[1] & ~current_opcode[0]; // 00000 

    assign is_bex =  current_opcode[4] & ~current_opcode[3] &  current_opcode[2] &  current_opcode[1] & ~current_opcode[0]; // 10110
    
    assign Rstatus_addr = 5'd30;

    // assign ctrl_readRegA = is_bex? Rstatus_addr : Rs; // read val from rstatus
    assign ctrl_readRegA = Rs; // read val from rstatus
    assign ctrl_readRegB = is_R? Rt : (is_bex? Rstatus_addr : Rd); //if r type: read from Rt, else read from Rd for I/JII or rstatus for bex

endmodule