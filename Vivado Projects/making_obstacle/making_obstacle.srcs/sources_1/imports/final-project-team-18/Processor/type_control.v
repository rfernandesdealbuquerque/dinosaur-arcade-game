module type_control(
    opcode, ALUopcode,
    is_R, is_I, 
    is_addi, is_branch, 
    is_jal, 
    is_setx, 
    ctrl_mult, ctrl_div
);

    output is_R, is_I;
    output is_addi, is_branch;
    output is_jal, is_setx; 
    output ctrl_mult, ctrl_div; 

    input [4:0] opcode, ALUopcode;


    // JI
    wire is_JI, is_j;
    // wire is_jal;
    wire is_bex;
    // wire is_bex, is_setx;

    // I
    wire is_sw, is_lw;
    wire is_bne, is_blt;
    
    // JII
    wire is_jr; 

    wire is_branch;

    assign is_R    = ~opcode[4] & ~opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0]; // 00000 

    assign is_j    = ~opcode[4] & ~opcode[3] & ~opcode[2] & ~opcode[1] &  opcode[0]; // 00001 
    assign is_bne  = ~opcode[4] & ~opcode[3] & ~opcode[2] &  opcode[1] & ~opcode[0]; // 00010
    assign is_jal  = ~opcode[4] & ~opcode[3] & ~opcode[2] &  opcode[1] &  opcode[0]; // 00011
    assign is_jr   = ~opcode[4] & ~opcode[3] &  opcode[2] & ~opcode[1] & ~opcode[0]; // 00100

    assign is_addi = ~opcode[4] & ~opcode[3] &  opcode[2] & ~opcode[1] &  opcode[0]; // 00101

    assign is_blt  = ~opcode[4] & ~opcode[3] &  opcode[2] &  opcode[1] & ~opcode[0]; // 00110

    assign is_sw   = ~opcode[4] & ~opcode[3] &  opcode[2] &  opcode[1] &  opcode[0]; // 00111
    assign is_lw   = ~opcode[4] &  opcode[3] & ~opcode[2] & ~opcode[1] & ~opcode[0]; // 01000
	
	assign is_setx =  opcode[4] & ~opcode[3] &  opcode[2] & ~opcode[1] &  opcode[0]; // 10101
    assign is_bex  =  opcode[4] & ~opcode[3] &  opcode[2] &  opcode[1] & ~opcode[0]; // 10110
    // assign custom  = 

    assign is_I =  is_addi || is_sw || is_lw;

    assign is_branch = is_bne || is_blt;
    
    // ALU computation
    wire is_ALUadd, is_ALUsub, is_ALUand, is_ALUor, is_ALUsll, is_ALUsra;

    assign is_ALUadd = is_R & (~ALUopcode[4] & ~ALUopcode[3] & ~ALUopcode[2] & ~ALUopcode[1] & ~ALUopcode[0]);	// 00000
    assign is_ALUsub = is_R & (~ALUopcode[4] & ~ALUopcode[3] & ~ALUopcode[2] & ~ALUopcode[1] &  ALUopcode[0]);	// 00001
    assign is_ALUand = is_R & (~ALUopcode[4] & ~ALUopcode[3] & ~ALUopcode[2] &  ALUopcode[1] & ~ALUopcode[0]);	// 00010
    assign is_ALUor  = is_R & (~ALUopcode[4] & ~ALUopcode[3] & ~ALUopcode[2] &  ALUopcode[1] &  ALUopcode[0]);	// 00011
    assign is_ALUsll = is_R & (~ALUopcode[4] & ~ALUopcode[3] &  ALUopcode[2] & ~ALUopcode[1] & ~ALUopcode[0]);	// 00100
    assign is_ALUsra = is_R & (~ALUopcode[4] & ~ALUopcode[3] &  ALUopcode[2] & ~ALUopcode[1] &  ALUopcode[0]);	// 00101
    
    // wire ctrl_mult, ctrl_div; 
    assign ctrl_mult = is_R & (~ALUopcode[4] & ~ALUopcode[3] &  ALUopcode[2] &  ALUopcode[1] & ~ALUopcode[0]);	// 00110
    assign ctrl_div  = is_R & (~ALUopcode[4] & ~ALUopcode[3] &  ALUopcode[2] &  ALUopcode[1] &  ALUopcode[0]);	// 00111
    // assign custom_r = 01001

endmodule