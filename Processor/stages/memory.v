module memory(
    instruction_xm_out, q_dmem, in_dataO, in_dataB, 
    out_dataO, out_dataD, d_dmem, address_dmem, DMwe
);

    input [31:0] instruction_xm_out, q_dmem, in_dataO, in_dataB;
    
    output [31:0] out_dataO, out_dataD, d_dmem;
    output [31:0] address_dmem;
    output DMwe;

    assign out_dataO = in_dataO;
    assign out_dataD = q_dmem;
    assign d_dmem = in_dataB; // in_dataB = data_xm_outB

    // assign address_dmem[11:0] = in_dataO[11:0];
    assign address_dmem = in_dataO; // in_dataO = data_xm_outO

    wire [4:0] current_opcode;
    assign current_opcode = instruction_xm_out[31:27];

    assign DMwe = ~current_opcode[4] & ~current_opcode[3] & current_opcode[2] & current_opcode[1] & current_opcode[0]; // 00111 for sw TODO

endmodule