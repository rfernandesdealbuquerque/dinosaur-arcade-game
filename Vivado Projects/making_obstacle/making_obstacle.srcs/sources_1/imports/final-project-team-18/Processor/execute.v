module execute(
    instruction, in_dataA, in_dataB, 
    pc_dx_out, 
    data_writeReg, 
    data_xm_outO, 
    mx_A_bypass, wx_A_bypass, mx_B_bypass, wx_B_bypass, 
    clock, 
    pc_plus_one, 
    instruction_multdiv, 
    multdiv_dataA, multdiv_dataB,

    out_dataO, out_dataB, 
    exception, 
    // is_ne, is_lt, 
    pc_next, jump_or_branch_taken,

    multdiv_output,
    multdiv_exception, multdiv_ready,
    ctrl_mult, ctrl_div,
    final_ALU_dataA, final_ALU_dataB
); 

	input [31:0] instruction, in_dataA, in_dataB; 
    input [31:0] pc_dx_out;
    input [31:0] data_writeReg; 
    input [31:0] data_xm_outO;
    input mx_A_bypass, wx_A_bypass, mx_B_bypass, wx_B_bypass;
    input clock;
    input [31:0] pc_plus_one;

    input [31:0] instruction_multdiv;
    input [31:0] multdiv_dataA, multdiv_dataB;

    output [31:0] out_dataO, out_dataB; // data_dx_outA, data_dx_outB
    output exception;
    // output is_ne, is_lt;

    output [31:0] pc_next;
    output jump_or_branch_taken;

    output [31:0] multdiv_output;
    output multdiv_exception, multdiv_ready;
    output ctrl_mult, ctrl_div; 
    output [31:0] final_ALU_dataA, final_ALU_dataB;

    wire [4:0] current_opcode, ALUopcode;
    wire [4:0] shamt;
    wire [16:0] N;

    assign current_opcode = instruction[31:27];
    assign N = instruction[16:0];
    
    assign ALUopcode = instruction[6:2];

    wire is_R, is_I, is_addi;
    wire is_branch;

    // Type
    wire is_bne, is_jal, is_blt, is_setx;
    type_control type1(
        .opcode(current_opcode), .ALUopcode(ALUopcode),
        .is_R(is_R), .is_I(is_I), 
        .is_addi(is_addi), .is_branch(is_branch), 
        .is_jal(is_jal), 
        .is_setx(is_setx),
        .ctrl_mult(ctrl_mult), .ctrl_div(ctrl_div) 

    );

    wire is_ne, is_lt;

    // ALU
    wire [31:0] signex_N;
    assign signex_N = {{15{N[16]}},N}; // sx 
    
    wire [31:0] final_ALU_dataA, final_ALU_dataB, ALU_output;

    // ALUinB & A bypassing 
    wire [1:0] A_bypass_select, B_bypass_select;
    assign A_bypass_select[1] = (!mx_A_bypass) && (!wx_A_bypass);
    assign A_bypass_select[0] = (!mx_A_bypass) && ( wx_A_bypass);
    assign B_bypass_select[1] = (!mx_B_bypass) && (!wx_B_bypass);
    assign B_bypass_select[0] = (!mx_B_bypass) &&  (wx_B_bypass);

    mux_4 alu_A_select(final_ALU_dataA, A_bypass_select, data_xm_outO, data_writeReg, in_dataA, 32'b0);
    // assign final_ALU_dataA = in_dataA;
    
    // assign out_dataB = in_dataB;
    mux_4 alu_B_select(out_dataB, B_bypass_select, data_xm_outO, data_writeReg, in_dataB, 32'b0);
    assign final_ALU_dataB = (is_branch || is_R)? out_dataB : signex_N; 

    wire [4:0] final_ALUopcode;
    assign final_ALUopcode = is_R? ALUopcode : (is_branch? 5'b00001 : 5'b00000); // TODO
    assign shamt = is_R? instruction[11:7] : 5'b00000;
    
    wire alu_ovf;
    alu alu1(
        .data_operandA(final_ALU_dataA), .data_operandB(final_ALU_dataB), .ctrl_ALUopcode(final_ALUopcode), 
        .ctrl_shiftamt(shamt), .data_result(ALU_output), .isNotEqual(is_ne), .isLessThan(is_lt), .overflow(alu_ovf)
    );

    // multdiv TODO: assert ready at the rising edge ...
    // data @ falling edge
    multdiv multdiv1(
        .data_operandA(multdiv_dataA), .data_operandB(multdiv_dataB), .ctrl_MULT(ctrl_mult), .ctrl_DIV(ctrl_div), .clock(clock),
        .data_result(multdiv_output), .data_exception(multdiv_exception), .data_resultRDY(multdiv_ready)
    );

    wire multdiv_ready_exception;
    assign multdiv_ready_exception = multdiv_exception && multdiv_ready;

    // handle overflow
    wire [31:0] Rstatus;

    wire [4:0] ovf_opcode, ovf_ALUopcode;
    wire [4:0] multdiv_opcode, multdiv_ALUopcode;
    assign multdiv_opcode    = instruction_multdiv[31:27];
    assign multdiv_ALUopcode = instruction_multdiv[6:2];

    assign ovf_opcode    = multdiv_ready? multdiv_opcode    : current_opcode;
    assign ovf_ALUopcode = multdiv_ready? multdiv_ALUopcode : final_ALUopcode;

    overflow_struct my_ovf(.current_opcode(ovf_opcode), .ALUopcode(ovf_ALUopcode), .rstatus(Rstatus));

    assign exception = alu_ovf | multdiv_ready_exception; 

    // output
    wire [26:0] T;
    assign T = instruction[26:0];
    
    wire [31:0] full_T;
    assign full_T[31:27] = 5'b00000;
    assign full_T[26:0] = T;

    //data_xm_inO = out_dataO
    tristate_32 tristate_alu  (ALU_output  , (!is_jal) && (!is_setx) && (!exception), out_dataO);
    tristate_32 tristate_ovf  (Rstatus     , (!is_jal) && (!is_setx) && ( exception), out_dataO);
    tristate_32 tristate_setx (full_T      , (!is_jal) && ( is_setx) && (!exception), out_dataO);
    tristate_32 tristate_jal  (pc_dx_out   , ( is_jal) && (!is_setx) && (!exception), out_dataO);

    // pc control
    pc_control control_loop(
        .instruction(instruction), 
        .pc_plus_one(pc_plus_one), .Rd_val(out_dataB), .pc_dx_out(pc_dx_out), 
        .Rstatus(out_dataO), 
        .is_ne(is_ne), .is_lt(is_lt), 
        .pc_next(pc_next), .jump_or_branch_taken(jump_or_branch_taken)
    );

endmodule