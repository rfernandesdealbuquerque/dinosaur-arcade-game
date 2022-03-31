module tristate_5(in, oe, out);
    input [4:0] in;
    input oe;
    output [4:0] out;

    assign out = oe ? in : 5'bz;
endmodule