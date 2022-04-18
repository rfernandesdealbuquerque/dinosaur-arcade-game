module ADD(x, y, sum, cout, overflow);
        
    input [31:0] x, y;

    output [31:0] sum;
    output cout;
    output overflow;

    CLA_32 adder(x, y, 1'b0, sum, cout, overflow);

endmodule