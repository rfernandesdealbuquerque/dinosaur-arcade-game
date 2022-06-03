module NOTEQUAL(diff_result, subtractor_cout, result);
	input [31:0] diff_result;
	input subtractor_cout;  

	output result;

	wire any_one, cout_bar;
	
	or check_one(any_one, 
    diff_result[0], diff_result[1], diff_result[2], diff_result[3], 
    diff_result[4], diff_result[5], diff_result[6], diff_result[7], 
    diff_result[8], diff_result[9], diff_result[10], diff_result[11], 
    diff_result[12], diff_result[13], diff_result[14], diff_result[15], 
    diff_result[16], diff_result[17], diff_result[18], diff_result[19], 
    diff_result[20], diff_result[21], diff_result[22], diff_result[23], 
    diff_result[24], diff_result[25], diff_result[26], diff_result[27], 
    diff_result[28], diff_result[29], diff_result[30], diff_result[31]);
	
    // not not_cout(cout_bar, subtractor_cout);
	// or not_equal(result, any_one, cout_bar); not equal: cout is 1 or any_one is 1
    // carryout must match carryin -- 1 

    // min is -2147483648, won't get overflow whatsoever since 2147483648 unavailable in 32-bit
    assign result = any_one;
	
endmodule
	 