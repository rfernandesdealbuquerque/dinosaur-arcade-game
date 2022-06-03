module writeback(
    instruction_mw_out, in_dataO, in_dataD, mw_exception_out,
    
    instruction_multdiv, multdiv_output, 
    multdiv_ready, multdiv_exception,

    data_writeReg, ctrl_writeReg, ctrl_writeEnable
);

    input [31:0] instruction_mw_out, in_dataO, in_dataD;
    input mw_exception_out;

    input [31:0] instruction_multdiv, multdiv_output;
    input multdiv_ready, multdiv_exception;

    output [31:0] data_writeReg;
    output [4:0] ctrl_writeReg;
    output ctrl_writeEnable;

    wire [4:0] Rd, Rstatus_addr, return_addr, multdiv_Rd;
    assign Rd           = instruction_mw_out[26:22];
    assign Rstatus_addr = 5'd30;
    assign return_addr  = 5'd31;
    assign multdiv_Rd   = instruction_multdiv[26:22];

    wire [4:0] current_opcode;
    assign current_opcode = instruction_mw_out[31:27];
    
    // TODO: lw, jal, setx, r_type, addi

    wire is_R, is_addi, is_lw, is_jal, is_setx;

    // R 
    assign is_R    = ~current_opcode[4] & ~current_opcode[3] & ~current_opcode[2] & ~current_opcode[1] & ~current_opcode[0]; // 00000 
    
    // addi
    assign is_addi = ~current_opcode[4] & ~current_opcode[3] &  current_opcode[2] & ~current_opcode[1] &  current_opcode[0]; // 00101

    // lw:
    assign is_lw   = ~current_opcode[4] &  current_opcode[3] & ~current_opcode[2] & ~current_opcode[1] & ~current_opcode[0]; // 01000

    // jal:
    assign is_jal  = ~current_opcode[4] & ~current_opcode[3] & ~current_opcode[2] &  current_opcode[1] &  current_opcode[0]; // 00011

    // setx:
	assign is_setx =  current_opcode[4] & ~current_opcode[3] &  current_opcode[2] & ~current_opcode[1] &  current_opcode[0]; // 10101

    // output

    wire multdiv_ready_out;
    assign multdiv_ready_out = multdiv_ready && (!multdiv_exception);

    wire has_Rstatus;
    assign has_Rstatus = mw_exception_out || is_setx;

    assign data_writeReg = is_lw? in_dataD : (multdiv_ready_out? multdiv_output : in_dataO);

    tristate_5 ctrl_normal (Rd          , (!is_jal) && (!has_Rstatus) && (!multdiv_ready_out), ctrl_writeReg);
    tristate_5 ctrl_jal    (return_addr , ( is_jal) && (!has_Rstatus) && (!multdiv_ready_out), ctrl_writeReg);
    tristate_5 ctrl_status (Rstatus_addr, (!is_jal) &&   has_Rstatus  && (!multdiv_ready_out), ctrl_writeReg);
    tristate_5 ctrl_multdiv(multdiv_Rd  , (!is_jal) && (!has_Rstatus) && ( multdiv_ready_out), ctrl_writeReg);

    // assign ctrl_writeReg = is_jal? return_addr : (has_Rstatus? Rstatus_addr : Rd);

    assign ctrl_writeEnable = is_R | is_addi | is_lw | is_jal | is_setx | multdiv_ready_out; 

endmodule