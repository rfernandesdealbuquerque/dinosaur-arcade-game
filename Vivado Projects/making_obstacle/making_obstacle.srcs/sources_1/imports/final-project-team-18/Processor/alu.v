module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    // add your code here:
    wire [31:0] sum_result;
    wire adder_cout, adder_overflow;

    wire [31:0] diff_result; 
    wire subtractor_cout, subtractor_overflow;

    wire [31:0] bit_and_result, bit_or_result;
    wire [31:0] sll_result, sra_result;

    wire is_less_than; 
    wire is_not_equal;
    
    ADD adder_0(data_operandA, data_operandB, sum_result, adder_cout, adder_overflow);
    SUBTRACT subtractor_0(data_operandA, data_operandB, diff_result, subtractor_cout, subtractor_overflow);

    BIT_AND and_comparator(data_operandA, data_operandB, bit_and_result);
    BIT_OR or_comparator(data_operandA, data_operandB, bit_or_result);

    SLL left_shift(data_operandA, ctrl_shiftamt, sll_result);
    SRA right_shift(data_operandA, ctrl_shiftamt, sra_result);

    // if x < y: x - y < 0 --- 
    // sign 1 in 31:
    //  if x > 0, y < 0 --- x > y, overflow
    //  if x > 0, y > 0 --- x < y, as intended --- same sign (needed)
    //  if x < 0, y > 0 --- x < y, as intended (needed)
    //  if x < 0, y < 0 --- x < y, as intended --- same sign (needed)
    // sign 0 in 31: 
    //  if x > 0, y < 0 --- x > y, as intended
    //  if x > 0, y > 0 --- x > y, as intended --- same sign
    //  if x < 0, y > 0 --- x < y, overflow --- (needed)
    //  if x < 0, y < 0 --- x > y, as intended --- same sign

    // sign | overflow | out
    //  0   |    0     |  >=
    //  0   |    1     |  <
    //  1   |    0     |  <
    //  1   |    1     |  >

    xor A_less_B(is_less_than, diff_result[31], subtractor_overflow);
    NOTEQUAL A_not_equal_B(diff_result, subtractor_cout, is_not_equal);
    
    mux_8 mux_result(data_result, ctrl_ALUopcode[2:0], sum_result, diff_result, bit_and_result, bit_or_result, sll_result, sra_result, 32'bz, 32'bz);
    mux_8_one_bit mux_equal(isNotEqual, ctrl_ALUopcode[2:0], 1'b0, is_not_equal, 1'b0, 1'b0, 1'b0, 1'b0, 1'bz, 1'bz);
    mux_8_one_bit mux_less(isLessThan, ctrl_ALUopcode[2:0], 1'b0, is_less_than, 1'b0, 1'b0, 1'b0, 1'b0, 1'bz, 1'bz);
    mux_8_one_bit mux_overflow(overflow, ctrl_ALUopcode[2:0], adder_overflow, subtractor_overflow, 1'b0, 1'b0, 1'b0, 1'b0, 1'bz, 1'bz);

endmodule