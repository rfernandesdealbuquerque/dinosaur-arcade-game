/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */

    wire stall;

    // wires
    wire [31:0] instruction_fd_in, instruction_fd_out, instruction_dx_in, instruction_dx_out, instruction_xm_in, instruction_multdiv, instruction_xm_out, instruction_mw_in, instruction_mw_out;
    wire [31:0] pc_out, pc_next, pc_plus_one, pc_fd_out, pc_dx_out;
    wire [31:0] pc_dx_in;

    wire [31:0] data_dx_outA, data_dx_outB, data_xm_outO, data_xm_outB, data_mw_outO, data_mw_outD;
    wire [31:0] data_dx_inA, data_dx_inB, data_xm_inO, data_xm_inB, data_mw_inO, data_mw_inD; 
    
    wire [31:0] final_ALU_dataA, final_ALU_dataB;
    wire [31:0] multdiv_dataA, multdiv_dataB;
    
    wire [31:0] execute_o_out, execute_b_out;
    wire [31:0] memory_o_out, memory_d_out;

    wire [11:0] real_address_imem, real_address_dmem;
    
    wire exception_xm_in, exception_xm_out, exception_mw_in, exception_mw_out;
    wire execute_exception_out, writeback_exception_in;
    wire jump_or_branch_taken;

    wire [31:0] multdiv_output;
    wire multdiv_exception, multdiv_ready;
    wire ongoing;
    wire en_multdiv;
    wire ctrl_mult, ctrl_div;
    
    // bypass wire
    wire mx_A_bypass, wx_A_bypass, mx_B_bypass, wx_B_bypass;

    // pc pc_out == current pc
    pc my_pc(.q(pc_out), .d(pc_next), .clk(~clock), .en(~stall), .clr(reset)); 
    
    // ########################################## fetch ##################################################

    fetch fetch_stage(
        .pc_out(pc_out), 
        .address_imem(address_imem), 
        .pc_plus_one(pc_plus_one)
    ); 

    // ########################################## fd #####################################################
    assign instruction_fd_in = (jump_or_branch_taken)? 32'b00000000000000000000000000000000 : q_imem;
    fd my_fd(
        .q_pc(pc_fd_out), .q_ir(instruction_fd_out), 
        .d_pc(pc_out), .d_ir(instruction_fd_in), 
        .clk(~clock), .en(~stall), .clr(reset)
    );

    // ########################################## decode #################################################
    
    decode decode_stage(
        .instruction(instruction_fd_out), 
        .ctrl_readRegA(ctrl_readRegA), .ctrl_readRegB(ctrl_readRegB)
    );

    // ########################################## dx #####################################################
    assign pc_dx_in = pc_fd_out;
    assign data_dx_inA = data_readRegA;
    assign data_dx_inB = data_readRegB;
    assign instruction_dx_in = (jump_or_branch_taken | stall)? 32'b00000000000000000000000000000000 : instruction_fd_out;
    dx my_dx(
        .q_pc(pc_dx_out), .q_a(data_dx_outA), .q_b(data_dx_outB), .q_ir(instruction_dx_out), 
        .d_pc(pc_dx_in), .d_a(data_dx_inA), .d_b(data_dx_inB), .d_ir(instruction_dx_in), 
        .clk(~clock), .en(1'b1), .clr(reset)
    );

    // ########################################## execute ################################################
    wire is_ne, is_lt;

    // multdiv --- a register to hold values --- falling edges same as other latches 
    // rising --- memory 
    execute execute_stage(
        .instruction(instruction_dx_out), .in_dataA(data_dx_outA), .in_dataB(data_dx_outB), 
        .pc_dx_out(pc_dx_out), 
        .data_writeReg(data_writeReg), 
        .data_xm_outO(data_xm_outO), 
        .mx_A_bypass(mx_A_bypass), .wx_A_bypass(wx_A_bypass), .mx_B_bypass(mx_B_bypass), .wx_B_bypass(wx_B_bypass),   

        .clock(~clock), 
        .pc_plus_one(pc_plus_one),
        .instruction_multdiv(instruction_multdiv),
        .multdiv_dataA(multdiv_dataA), .multdiv_dataB(multdiv_dataB),

        .out_dataO(execute_o_out), .out_dataB(execute_b_out), 
        .exception(execute_exception_out),
        // .is_ne(is_ne), .is_lt(is_lt),
        .pc_next(pc_next), .jump_or_branch_taken(jump_or_branch_taken),

        .multdiv_output(multdiv_output),
        .multdiv_exception(multdiv_exception), .multdiv_ready(multdiv_ready),
        .ctrl_mult(ctrl_mult), .ctrl_div(ctrl_div),
        .final_ALU_dataA(final_ALU_dataA), .final_ALU_dataB(final_ALU_dataB)
    );

    // ########################################## pw #####################################################

    assign en_multdiv = ctrl_mult | ctrl_div;

    pw my_pw(
        .q_a(multdiv_dataA), .q_b(multdiv_dataB), .q_ir(instruction_multdiv), .q_run(ongoing), 
        .d_a(final_ALU_dataA), .d_b(final_ALU_dataB), .d_ir(instruction_dx_out), .clk(~clock), 
        .en(en_multdiv), .result_ready(multdiv_ready), .clr(reset)
    );

    // ########################################## xm #####################################################
    assign data_xm_inO = execute_o_out;
    assign data_xm_inB = execute_b_out;
    assign exception_xm_in = execute_exception_out;
    assign instruction_xm_in = instruction_dx_out;

    xm my_xm(
        .q_o(data_xm_outO), .q_b(data_xm_outB), .q_ir(instruction_xm_out), .q_ovf(exception_xm_out), 
        .d_o(data_xm_inO), .d_b(data_xm_inB), .d_ir(instruction_xm_in), .d_ovf(exception_xm_in), 
        .clk(~clock), .en(1'b1), .clr(reset)
    );

    // ########################################## memory #################################################

    wire [31:0] d_dmem;
    memory memory_stage(
        .instruction_xm_out(instruction_xm_out), .q_dmem(q_dmem), .in_dataO(data_xm_outO), .in_dataB(data_xm_outB), 
        .out_dataO(memory_o_out), .out_dataD(memory_d_out), .d_dmem(d_dmem), .address_dmem(address_dmem), .DMwe(wren)
    );
    
    assign data = wm_bypass? data_writeReg : data_xm_outB; // data_xm_outB = d_dmem
    
    // ########################################## mw #####################################################
    assign data_mw_inO = memory_o_out; // data_xm_outO = memory_o_out
    assign data_mw_inD = memory_d_out;
    assign instruction_mw_in = instruction_xm_out;
    assign exception_mw_in = exception_xm_out;

    mw my_mw(
        .q_o(data_mw_outO), .q_d(data_mw_outD), .q_ir(instruction_mw_out), .q_ovf(exception_mw_out), 
        .d_o(data_xm_outO), .d_d(q_dmem), .d_ir(instruction_mw_in), .d_ovf(exception_mw_in), 
        .clk(~clock), .en(1'b1), .clr(reset)
    );

    // ########################################## writeback ##############################################

    assign writeback_exception_in = exception_mw_out;
    writeback writeback_stage(
        .instruction_mw_out(instruction_mw_out), .in_dataO(data_mw_outO), .in_dataD(data_mw_outD), .mw_exception_out(writeback_exception_in),
        .data_writeReg(data_writeReg), .ctrl_writeReg(ctrl_writeReg), .ctrl_writeEnable(ctrl_writeEnable), 

        .instruction_multdiv(instruction_multdiv), .multdiv_output(multdiv_output), 
        .multdiv_ready(multdiv_ready), .multdiv_exception(multdiv_exception)

    );

	// ########################################## bypass ##############################################

    bypass_struct bypass_check(
        .instruction_dx_out(instruction_dx_out), 
        .instruction_xm_out(instruction_xm_out), .instruction_mw_out(instruction_mw_out), 
        .exception_xm_out(exception_xm_out), .exception_mw_out(exception_mw_out), 
        .mx_A_bypass(mx_A_bypass), .wx_A_bypass(wx_A_bypass), .mx_B_bypass(mx_B_bypass), .wx_B_bypass(wx_B_bypass), 
        .wm_bypass(wm_bypass)
    );

	// ########################################## stall ##############################################

    // could be refactored
    wire [4:0] fd_opcode;
    wire [4:0] fd_Rs, fd_Rt;
    assign fd_opcode = instruction_fd_out[31:27];
    assign fd_Rs     = instruction_fd_out[21:17];
    assign fd_Rt     = instruction_fd_out[16:12]; 

    wire fd_sw;
    assign fd_sw   = ~fd_opcode[4] & ~fd_opcode[3] &  fd_opcode[2] &  fd_opcode[1] &  fd_opcode[0]; // 00111

    wire [4:0] dx_opcode;
    wire [4:0] dx_Rd; 
    assign dx_opcode = instruction_dx_out[31:27]; 
    assign dx_Rd     = instruction_dx_out[26:22];

    wire dx_R, dx_lw;
    assign dx_R    = ~dx_opcode[4] & ~dx_opcode[3] & ~dx_opcode[2] & ~dx_opcode[1] & ~dx_opcode[0]; // 00000 
    assign dx_lw   = ~dx_opcode[4] &  dx_opcode[3] & ~dx_opcode[2] & ~dx_opcode[1] & ~dx_opcode[0]; // 01000

    wire [4:0] dx_ALUopcode; 
    assign dx_ALUopcode = instruction_dx_out[6:2]; 

    wire old_stall;
    assign old_stall  = (dx_lw) && 
                        ((fd_Rs == dx_Rd) ||
                        ((fd_Rt == dx_Rd) && (!fd_sw)));

    assign stall = old_stall || (ongoing || en_multdiv);
	/* END CODE */

endmodule
