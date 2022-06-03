module pc_control(
    instruction, 
    pc_plus_one, Rd_val, pc_dx_out, 
    Rstatus, 
    is_ne, is_lt, 
    pc_next, 
    jump_or_branch_taken
);

    input [31:0] instruction;
    input [31:0] pc_plus_one, Rd_val, pc_dx_out;
    input [31:0] Rstatus;
    input is_ne, is_lt;

    output [31:0] pc_next;
    output jump_or_branch_taken;

    
    wire [31:0] full_T;
    assign full_T[31:27] = 5'b00000;
    assign full_T[26:0] = instruction[26:0];

    wire [4:0] current_opcode;
    assign current_opcode = instruction[31:27];

    wire is_bex;
    assign is_bex  = current_opcode[4] & ~current_opcode[3] &  current_opcode[2] &  current_opcode[1] & ~current_opcode[0]; // 10110

    wire [31:0] pc_branch, signex_N;
    wire cout1, ovf1;

    wire [16:0] N;
    assign N = instruction[16:0];
    assign signex_N = {{15{N[16]}},N}; // sx 
    CLA_32 adder1(.x(pc_dx_out), .y(signex_N), .cin(1'b0), .sum(pc_branch), .cout(cout1), .overflow(ovf1));

    wire [2:0] pc_select;
    assign pc_select = is_bex? 3'b000 : current_opcode[2:0];

    wire lt_taken; 
    assign lt_taken = is_ne? ~is_lt : 1'b0;

    wire [31:0] pc_bne, pc_blt, pc_addi;
    assign pc_bne  = is_ne?    pc_branch : pc_plus_one;
    assign pc_blt  = lt_taken? pc_branch : pc_plus_one;

    wire [31:0] pc_next_mux;
    mux_8 pc_exe_mux(
        pc_next_mux, 
        pc_select, 
        pc_plus_one, full_T, pc_bne, full_T, // normal or lw, j or bex, bne, jal
        Rd_val, pc_plus_one, pc_blt, pc_plus_one // jr, addi or setx, blt, sw or custom ... 
    ); //Rd --- mux_ALU_dataB

    wire bex_taken;
    assign bex_taken = (Rd_val != 0);
    
    assign pc_next = (is_bex && bex_taken)? full_T : pc_next_mux;
    assign jump_or_branch_taken = (pc_next != pc_plus_one);

endmodule