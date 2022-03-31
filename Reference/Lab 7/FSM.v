module FSM(
    out, q, 
    digit_bits, 
    clk, in
);
    output [6:0] digit_bits;
    
    output out; 
    output [2:0] q;
    
    input clk;
    input in;
    
    wire en, clr;
//    assign in = 1'b1;
    assign en = 1'b1;
    assign clr = 1'b0;
    
//    wire [2:0] q;  
    wire [2:0] d;

    assign d[2] = (q[1] & q[0] & in) | (q[2] & ~q[0] & ~in);
    assign d[1] = (q[1] & ~q[0]) | (q[1] & ~in) | (~q[1] & q[0] & in);
    assign d[0] = (~q[2] & ~q[0] & in) | (~q[2] & q[0] & ~in);
    assign out  = q[2] & ~q[1] & ~q[0] & in; // 100
    
//    bit_reg register_1(.q(q), .d(d), .clk(clk), .en(en), .clr(clr));
    dffe_ref dffe_2(q[2], d[2], clk, en, clr);
    dffe_ref dffe_1(q[1], d[1], clk, en, clr);
    dffe_ref dffe_0(q[0], d[0], clk, en, clr);
    
    assign digit_bits[6] = ~((~q[2] & ~q[0]) | (~q[2] & q[1] & q[0]));
    assign digit_bits[5] = 1'b0;
    assign digit_bits[4] = (~q[2] & q[1] & ~q[0]);
    assign digit_bits[3] = ~((~q[2] & ~q[0]) | (~q[2] & q[1] & q[0]));
    assign digit_bits[2] = ~(~q[2] & ~q[0]);
    assign digit_bits[1] = ~(~q[1] & ~q[0]);
    assign digit_bits[0] = ~((~q[2] & q[1]) | (q[2] & ~q[1] & ~q[0]));

endmodule 