module overflow_struct(current_opcode, ALUopcode, rstatus);
    output [31:0] rstatus;
    
    input [4:0] current_opcode, ALUopcode;

    // R & addi
    wire is_R, is_addi;
    assign is_R    = ~current_opcode[4] & ~current_opcode[3] & ~current_opcode[2] & ~current_opcode[1] & ~current_opcode[0]; // 00000 
    assign is_addi = ~current_opcode[4] & ~current_opcode[3] &  current_opcode[2] & ~current_opcode[1] &  current_opcode[0]; // 00101

    wire is_ALUadd, is_ALUsub;
    wire ctrl_mult, ctrl_div; 

    assign is_ALUadd = is_R & (~ALUopcode[4] & ~ALUopcode[3] & ~ALUopcode[2] & ~ALUopcode[1] & ~ALUopcode[0]);	// 00000
    assign is_ALUsub = is_R & (~ALUopcode[4] & ~ALUopcode[3] & ~ALUopcode[2] & ~ALUopcode[1] &  ALUopcode[0]);	// 00001
    
    assign ctrl_mult = is_R & (~ALUopcode[4] & ~ALUopcode[3] &  ALUopcode[2] &  ALUopcode[1] & ~ALUopcode[0]);	// 00110
    assign ctrl_div  = is_R & (~ALUopcode[4] & ~ALUopcode[3] &  ALUopcode[2] &  ALUopcode[1] &  ALUopcode[0]);	// 00111

    tristate_32 ovf_add (32'd1, is_ALUadd, rstatus);
    tristate_32 ovf_addi(32'd2, is_addi  , rstatus);
    tristate_32 sub_ovf (32'd3, is_ALUsub, rstatus);
    tristate_32 mult_ovf(32'd4, ctrl_mult, rstatus);
    tristate_32 div_ovf (32'd5, ctrl_div , rstatus);

endmodule