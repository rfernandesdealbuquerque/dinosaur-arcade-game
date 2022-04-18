// https://www.geeksforgeeks.org/carry-look-ahead-adder
module CLA_32(x, y, cin, sum, cout, overflow);
	input [31:0] x, y;
	input cin;
	output [31:0] sum;
	output cout, overflow;

	wire c8, c16, c24;
    wire c7, c15, c23, c31;

	wire [3:0] G;
	wire [3:0] P;

    wire P3G2, P3P2G1, P3P2P1G0;
    wire P2G1, P2P1G0;
	wire P1G0;
    wire P0cin, P1P0cin, P2P1P0cin, P3P2P1P0cin;

	and and_c8_1(P0cin, P[0], cin);
    or or_c8(c8, G[0], P0cin);

	and and_c16_1(P1G0, P[1], G[0]);
	and and_c16_2(P1P0cin, P[1], P0cin);
    or or_c16(c16, G[1], P1G0, P1P0cin);

	and and_c24_1(P2G1, P[2], G[1]);
	and and_c24_2(P2P1G0, P[2], P1G0);
	and and_c24_3(P2P1P0cin, P[2], P1P0cin);
    or or_c24(c24, G[2], P2G1, P2P1G0, P2P1P0cin);

	and and_c32_1(P3G2, P[3], G[2]);
	and and_c32_2(P3P2G1, P[3], P2G1);
	and and_c32_3(P3P2P1G0, P[3], P2P1G0);
	and and_c32_4(P3P2P1P0cin, P[3], P2P1P0cin);
    or or_c32(cout, G[3], P3G2, P3P2G1, P3P2P1G0, P3P2P1P0cin);
    	
	CLA_8 block_0(x[7:0], y[7:0], cin, sum[7:0], G[0], P[0], c7);
	CLA_8 block_1(x[15:8], y[15:8], c8, sum[15:8], G[1], P[1], c15);
	CLA_8 block_2(x[23:16], y[23:16], c16, sum[23:16], G[2], P[2], c23);
	CLA_8 block_3(x[31:24], y[31:24], c24, sum[31:24], G[3], P[3], c31);

	xor overflow_0(overflow, c31, cout);
	
endmodule