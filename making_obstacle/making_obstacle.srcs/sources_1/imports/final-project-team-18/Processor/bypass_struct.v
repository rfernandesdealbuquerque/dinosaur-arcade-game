module bypass_struct(
    instruction_dx_out, instruction_xm_out, instruction_mw_out, 
    exception_xm_out, exception_mw_out, 
    mx_A_bypass, wx_A_bypass, mx_B_bypass, wx_B_bypass, 
    wm_bypass
);

    input [31:0] instruction_dx_out, instruction_xm_out, instruction_mw_out;
    input exception_xm_out, exception_mw_out;
    
    output mx_A_bypass, wx_A_bypass, mx_B_bypass, wx_B_bypass, wm_bypass;

    wire [4:0] xm_opcode, mw_opcode;
    wire xm_sw, xm_bne, xm_blt, mw_sw, mw_bne, mw_blt;
    
    assign xm_opcode = instruction_xm_out[31:27];
    assign mw_opcode = instruction_mw_out[31:27];

    assign xm_sw = ~xm_opcode[4] & ~xm_opcode[3] & xm_opcode[2] & xm_opcode[1] & xm_opcode[0];
    assign mw_sw = ~mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & mw_opcode[1] & mw_opcode[0];

    assign xm_bne  = ~xm_opcode[4] & ~xm_opcode[3] & ~xm_opcode[2] & xm_opcode[1] & ~xm_opcode[0]; // 00010
    assign xm_blt  = ~xm_opcode[4] & ~xm_opcode[3] &  xm_opcode[2] & xm_opcode[1] & ~xm_opcode[0]; // 00110

    assign mw_bne  = ~mw_opcode[4] & ~mw_opcode[3] & ~mw_opcode[2] & mw_opcode[1] & ~mw_opcode[0]; // 00010
    assign mw_blt  = ~mw_opcode[4] & ~mw_opcode[3] &  mw_opcode[2] & mw_opcode[1] & ~mw_opcode[0]; // 00110

    wire xm_branch, mw_branch;
    assign xm_branch = xm_bne || xm_blt;
    assign mw_branch = mw_bne || mw_blt;

    wire xm_setx, mw_setx;
    assign xm_setx = xm_opcode[4] & ~xm_opcode[3] & xm_opcode[2] & ~xm_opcode[1] & xm_opcode[0];
    assign mw_setx = mw_opcode[4] & ~mw_opcode[3] & mw_opcode[2] & ~mw_opcode[1] & mw_opcode[0];

    wire [4:0] dx_opcode;
    assign dx_opcode = instruction_dx_out[31:27];

    wire dx_R, dx_bex;
    assign dx_R   = ~dx_opcode[4] & ~dx_opcode[3] & ~dx_opcode[2] & ~dx_opcode[1] & ~dx_opcode[0];
    assign dx_bex =  dx_opcode[4] & ~dx_opcode[3] &  dx_opcode[2] &  dx_opcode[1] & ~dx_opcode[0];

    // ALUinA, ALUinB bypassing
    wire [4:0] dx_A_Rs; 
    wire [4:0] dx_B, dx_B_Rd, dx_B_Rt; 
    

    assign dx_B_Rd = instruction_dx_out[26:22];
    assign dx_A_Rs = instruction_dx_out[21:17]; 
    assign dx_B_Rt = instruction_dx_out[16:12];

    wire [4:0] Rstatus;
    assign Rstatus = 5'd30; 

    assign dx_B = dx_R? dx_B_Rt : (dx_bex? Rstatus : dx_B_Rd);

    wire [4:0] real_xm_Rd, real_mw_Rd, xm_Rd, mw_Rd;

    assign real_xm_Rd = instruction_xm_out[26:22];
    assign real_mw_Rd = instruction_mw_out[26:22];

    // Rstatus if nonzero
    wire xm_has_Rstatus, mw_has_Rstatus;
    assign xm_has_Rstatus = (exception_xm_out | xm_setx);
    assign mw_has_Rstatus = (exception_mw_out | mw_setx);

    assign xm_Rd = xm_has_Rstatus? Rstatus : real_xm_Rd;
    assign mw_Rd = mw_has_Rstatus? Rstatus : real_mw_Rd;
    
    assign mx_A_bypass = (!xm_sw) && (!xm_branch) && (dx_A_Rs == xm_Rd) && (xm_Rd != 5'b0); 
    assign wx_A_bypass = (!mw_sw) && (!mw_branch) && (dx_A_Rs == mw_Rd) && (mw_Rd != 5'b0); 
    assign mx_B_bypass = (!xm_sw) && (!xm_branch) && (dx_B == xm_Rd) && (xm_Rd != 5'b0); 
    assign wx_B_bypass = (!mw_sw) && (!mw_branch) && (dx_B == mw_Rd) && (mw_Rd != 5'b0);

    assign wm_bypass = xm_sw && (real_xm_Rd == real_mw_Rd); 

endmodule