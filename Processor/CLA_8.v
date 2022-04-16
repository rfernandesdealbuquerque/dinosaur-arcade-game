module CLA_8(x, y, cin, sum, G, P, cout);

	input [7:0] x,y;
	input cin;

	output [7:0] sum;
	output G, P, cout;

	wire [7:0] p;
    wire [7:0] g;

	wire p7g6, p7p6g5, p7p6p5g4, p7p6p5p4g3, p7p6p5p4p3g2, p7p6p5p4p3p2g1, p7p6p5p4p3p2p1g0;
    wire p6g5, p6p5g4, p6p5p4g3, p6p5p4p3g2, p6p5p4p3p2g1, p6p5p4p3p2p1g0; 
	wire p5g4, p5p4g3, p5p4p3g2, p5p4p3p2g1, p5p4p3p2p1g0;
	wire p4g3, p4p3g2, p4p3p2g1, p4p3p2p1g0;
    wire p3g2, p3p2g1, p3p2p1g0;
    wire p2g1, p2p1g0;
	wire p1g0;
    wire p0cin, p1p0cin, p2p1p0cin, p3p2p1p0cin, p4p3p2p1p0cin, p5p4p3p2p1p0cin, p6p5p4p3p2p1p0cin;
	wire [7:0] c; //more compatible with for loops in the future

    assign c[0] = cin;
    	
	and and_g0(g[0], x[0], y[0]);
	and and_g1(g[1], x[1], y[1]);
	and and_g2(g[2], x[2], y[2]);
	and and_g3(g[3], x[3], y[3]);
	and and_g4(g[4], x[4], y[4]);
	and and_g5(g[5], x[5], y[5]);
	and and_g6(g[6], x[6], y[6]);
	and and_g7(g[7], x[7], y[7]);
	
	or or_p0(p[0], x[0], y[0]);
	or or_p1(p[1], x[1], y[1]);
	or or_p2(p[2], x[2], y[2]);
	or or_p3(p[3], x[3], y[3]);
	or or_p4(p[4], x[4], y[4]);
	or or_p5(p[5], x[5], y[5]);
	or or_p6(p[6], x[6], y[6]);
	or or_p7(p[7], x[7], y[7]);
	
	and and_G0_term_2(p7g6, p[7], g[6]);
	and and_G0_term_3(p7p6g5, p[7], p[6], g[5]);
	and and_G0_term_4(p7p6p5g4,p[7], p[6], p[5], g[4]);
	and and_G0_term_5(p7p6p5p4g3,p[7], p[6], p[5], p[4], g[3]);
	and and_G0_term_6(p7p6p5p4p3g2,p[7], p[6], p[5], p[4], p[3], g[2]);
	and and_G0_term_7(p7p6p5p4p3p2g1,p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
	and and_G0_term_8(p7p6p5p4p3p2p1g0,p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
	
    // output P, G
    and and_P(P,p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0]);
	or or_G(G, g[7], p7g6, p7p6g5, p7p6p5g4, p7p6p5p4g3, p7p6p5p4p3g2, p7p6p5p4p3p2g1, p7p6p5p4p3p2p1g0);
		
	and and_c1_1(p0cin, p[0], cin);
    or or_c1 (c[1], g[0], p0cin);
	
	and and_c2_1(p1g0, p[1], g[0]);
	and and_c2_2(p1p0cin, p[1], p0cin);
    or or_c2(c[2], g[1], p1g0, p1p0cin);

	and and_c3_1(p2g1, p[2], g[1]);
	and and_c3_2(p2p1g0, p[2], p1g0);
	and and_c3_3(p2p1p0cin, p[2], p1p0cin);
    or or_c3(c[3], g[2], p2g1, p2p1g0, p2p1p0cin);

	and and_c4_1(p3g2, p[3], g[2]);
	and and_c4_2(p3p2g1, p[3], p2g1);
	and and_c4_3(p3p2p1g0, p[3], p2p1g0);
	and and_c4_4(p3p2p1p0cin, p[3], p2p1p0cin);
    or or_c4(c[4], g[3], p3g2, p3p2g1, p3p2p1g0, p3p2p1p0cin);

	and and_c5_1(p4g3, p[4], g[3]);
	and and_c5_2(p4p3g2, p[4], p3g2);
	and and_c5_3(p4p3p2g1, p[4], p3p2g1);
	and and_c5_4(p4p3p2p1g0, p[4], p3p2p1g0);
	and and_c5_5(p4p3p2p1p0cin, p[4], p3p2p1p0cin);
    or or_c5(c[5], g[4], p4g3, p4p3g2, p4p3p2g1, p4p3p2p1g0, p4p3p2p1p0cin);

	and and_c6_1(p5g4, p[5], g[4]);
	and and_c6_2(p5p4g3, p[5], p4g3);
	and and_c6_3(p5p4p3g2, p[5], p4p3g2);
	and and_c6_4(p5p4p3p2g1, p[5], p4p3p2g1);
	and and_c6_5(p5p4p3p2p1g0, p[5], p4p3p2p1g0);
	and and_c6_6(p5p4p3p2p1p0cin, p[5], p4p3p2p1p0cin);
    or or_c6(c[6], g[5], p5g4, p5p4g3, p5p4p3g2, p5p4p3p2g1, p5p4p3p2p1g0, p5p4p3p2p1p0cin);

	and and_c7_1(p6g5, p[6], g[5]);
	and and_c7_2(p6p5g4, p[6], p5g4);
	and and_c7_3(p6p5p4g3, p[6], p5p4g3);
	and and_c7_4(p6p5p4p3g2, p[6], p5p4p3g2);
	and and_c7_5(p6p5p4p3p2g1, p[6], p5p4p3p2g1);
	and and_c7_6(p6p5p4p3p2p1g0, p[6], p5p4p3p2p1g0);
	and and_c7_7(p6p5p4p3p2p1p0cin, p[6], p5p4p3p2p1p0cin);
    // output as well!

    or or_c7(c[7], g[6], p6g5, p6p5g4, p6p5p4g3, p6p5p4p3g2, p6p5p4p3p2g1, p6p5p4p3p2p1g0, p6p5p4p3p2p1p0cin);
	assign cout = c[7];

    //calculate sum
	CLA_1 adder_0(x[0], y[0], c[0], sum[0]);
	CLA_1 adder_1(x[1], y[1], c[1], sum[1]);
	CLA_1 adder_2(x[2], y[2], c[2], sum[2]);
	CLA_1 adder_3(x[3], y[3], c[3], sum[3]);
	CLA_1 adder_4(x[4], y[4], c[4], sum[4]);
	CLA_1 adder_5(x[5], y[5], c[5], sum[5]);
	CLA_1 adder_6(x[6], y[6], c[6], sum[6]);
	CLA_1 adder_7(x[7], y[7], c[7], sum[7]);

endmodule