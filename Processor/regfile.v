module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB,
	
	r16, r17, r20, r22, r24, button_signal_reg, screen_signal_reg, collision_signal_reg, q_reg20, q_reg22,
	r14, r15
);
    input [31:0] r20, r22, r24; 
	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;
    
	input button_signal_reg, screen_signal_reg, collision_signal_reg;

    output [31:0] r16, r17;
	output [31:0] r14, r15;
	output [31:0] data_readRegA, data_readRegB;
	output [31:0] q_reg20, q_reg22;


	assign r14 = Q_reg14;
	assign r15 = Q_reg15;
    assign r16 = Q_reg16;
    assign r17 = Q_reg17;

	wire [31:0] Q_reg0, Q_reg1, Q_reg2, Q_reg3, Q_reg4, Q_reg5, Q_reg6, Q_reg7;
	wire [31:0] Q_reg8, Q_reg9, Q_reg10, Q_reg11, Q_reg12, Q_reg13, Q_reg14, Q_reg15;
	wire [31:0] Q_reg16, Q_reg17, Q_reg18, Q_reg19, Q_reg20, Q_reg21, Q_reg22, Q_reg23;
	wire [31:0] Q_reg24, Q_reg25, Q_reg26, Q_reg27, Q_reg28, Q_reg29, Q_reg30, Q_reg31;
	wire [31:0] out_decoder_W;
	wire [31:0] out_decoder_RA;
	wire [31:0] out_decoder_RB;
	

decoder_32 decoder_W(.out(out_decoder_W), .in(ctrl_writeReg), .enable(ctrl_writeEnable));
decoder_32 decoder_RA(.out(out_decoder_RA), .in(ctrl_readRegA), .enable(1'b1));
decoder_32 decoder_RB(.out(out_decoder_RB), .in(ctrl_readRegB), .enable(1'b1));

register reg0(.Q(Q_reg0), .D(32'd0), .clk(clock), .WE(out_decoder_W[0]), .clear(ctrl_reset));
register reg1(.Q(Q_reg1), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[1]), .clear(ctrl_reset));
register reg2(.Q(Q_reg2), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[2]), .clear(ctrl_reset));
register reg3(.Q(Q_reg3), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[3]), .clear(ctrl_reset));
register reg4(.Q(Q_reg4), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[4]), .clear(ctrl_reset));
register reg5(.Q(Q_reg5), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[5]), .clear(ctrl_reset));
register reg6(.Q(Q_reg6), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[6]), .clear(ctrl_reset));
register reg7(.Q(Q_reg7), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[7]), .clear(ctrl_reset));

register reg8(.Q(Q_reg8), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[8]), .clear(ctrl_reset));
register reg9(.Q(Q_reg9), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[9]), .clear(ctrl_reset));
register reg10(.Q(Q_reg10), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[10]), .clear(ctrl_reset));
register reg11(.Q(Q_reg11), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[11]), .clear(ctrl_reset));
register reg12(.Q(Q_reg12), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[12]), .clear(ctrl_reset));
register reg13(.Q(Q_reg13), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[13]), .clear(ctrl_reset));
register reg14(.Q(Q_reg14), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[14]), .clear(ctrl_reset));
register reg15(.Q(Q_reg15), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[15]), .clear(ctrl_reset));
register reg16(.Q(Q_reg16), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[16]), .clear(ctrl_reset));
register reg17(.Q(Q_reg17), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[17]), .clear(ctrl_reset));
register reg18(.Q(Q_reg18), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[18]), .clear(ctrl_reset));
register reg19(.Q(Q_reg19), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[19]), .clear(ctrl_reset));

register reg20(.Q(Q_reg20), .D(r20), .clk(clock), .WE(button_signal_reg || out_decoder_W[20]), .clear(ctrl_reset)); 
register reg22(.Q(Q_reg22), .D(r22), .clk(clock), .WE(screen_signal_reg || out_decoder_W[22]), .clear(ctrl_reset));
register reg24(.Q(Q_reg24), .D(r24), .clk(clock), .WE(collision_signal_reg || out_decoder_W[24]), .clear(ctrl_reset));

register reg21(.Q(Q_reg21), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[21]), .clear(ctrl_reset));
register reg23(.Q(Q_reg23), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[23]), .clear(ctrl_reset));
register reg25(.Q(Q_reg25), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[25]), .clear(ctrl_reset));
register reg26(.Q(Q_reg26), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[26]), .clear(ctrl_reset));
register reg27(.Q(Q_reg27), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[27]), .clear(ctrl_reset));
register reg28(.Q(Q_reg28), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[28]), .clear(ctrl_reset));
register reg29(.Q(Q_reg29), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[29]), .clear(ctrl_reset));
register reg30(.Q(Q_reg30), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[30]), .clear(ctrl_reset));
register reg31(.Q(Q_reg31), .D(data_writeReg), .clk(clock), .WE(out_decoder_W[31]), .clear(ctrl_reset));

tri_32 tri_0(.out(data_readRegA), .oe(out_decoder_RA[0]), .in(Q_reg0));
tri_32 tri_1(.out(data_readRegA), .oe(out_decoder_RA[1]), .in(Q_reg1));
tri_32 tri2(.out(data_readRegA), .oe(out_decoder_RA[2]), .in(Q_reg2));
tri_32 tri3(.out(data_readRegA), .oe(out_decoder_RA[3]), .in(Q_reg3));
tri_32 tri4(.out(data_readRegA), .oe(out_decoder_RA[4]), .in(Q_reg4));
tri_32 tri5(.out(data_readRegA), .oe(out_decoder_RA[5]), .in(Q_reg5));
tri_32 tri6(.out(data_readRegA), .oe(out_decoder_RA[6]), .in(Q_reg6));
tri_32 tri7(.out(data_readRegA), .oe(out_decoder_RA[7]), .in(Q_reg7));

tri_32 tri8(.out(data_readRegA), .oe(out_decoder_RA[8]), .in(Q_reg8));
tri_32 tri9(.out(data_readRegA), .oe(out_decoder_RA[9]), .in(Q_reg9));
tri_32 tri10(.out(data_readRegA), .oe(out_decoder_RA[10]), .in(Q_reg10));
tri_32 tri11(.out(data_readRegA), .oe(out_decoder_RA[11]), .in(Q_reg11));
tri_32 tri12(.out(data_readRegA), .oe(out_decoder_RA[12]), .in(Q_reg12));
tri_32 tri13(.out(data_readRegA), .oe(out_decoder_RA[13]), .in(Q_reg13));
tri_32 tri14(.out(data_readRegA), .oe(out_decoder_RA[14]), .in(Q_reg14));
tri_32 tri15(.out(data_readRegA), .oe(out_decoder_RA[15]), .in(Q_reg15));

tri_32 tri16(.out(data_readRegA), .oe(out_decoder_RA[16]), .in(Q_reg16));
tri_32 tri17(.out(data_readRegA), .oe(out_decoder_RA[17]), .in(Q_reg17));
tri_32 tri18(.out(data_readRegA), .oe(out_decoder_RA[18]), .in(Q_reg18));
tri_32 tri19(.out(data_readRegA), .oe(out_decoder_RA[19]), .in(Q_reg19));
tri_32 tri20(.out(data_readRegA), .oe(out_decoder_RA[20]), .in(Q_reg20));
tri_32 tri21(.out(data_readRegA), .oe(out_decoder_RA[21]), .in(Q_reg21));
tri_32 tri22(.out(data_readRegA), .oe(out_decoder_RA[22]), .in(Q_reg22));
tri_32 tri23(.out(data_readRegA), .oe(out_decoder_RA[23]), .in(Q_reg23));

tri_32 tri24(.out(data_readRegA), .oe(out_decoder_RA[24]), .in(Q_reg24));
tri_32 tri25(.out(data_readRegA), .oe(out_decoder_RA[25]), .in(Q_reg25));
tri_32 tri26(.out(data_readRegA), .oe(out_decoder_RA[26]), .in(Q_reg26));
tri_32 tri27(.out(data_readRegA), .oe(out_decoder_RA[27]), .in(Q_reg27));
tri_32 tri28(.out(data_readRegA), .oe(out_decoder_RA[28]), .in(Q_reg28));
tri_32 tri29(.out(data_readRegA), .oe(out_decoder_RA[29]), .in(Q_reg29));
tri_32 tri30(.out(data_readRegA), .oe(out_decoder_RA[30]), .in(Q_reg30));
tri_32 tri31(.out(data_readRegA), .oe(out_decoder_RA[31]), .in(Q_reg31));

tri_32 tri32(.out(data_readRegB), .oe(out_decoder_RB[0]), .in(Q_reg0));
tri_32 tri33(.out(data_readRegB), .oe(out_decoder_RB[1]), .in(Q_reg1));
tri_32 tri34(.out(data_readRegB), .oe(out_decoder_RB[2]), .in(Q_reg2));
tri_32 tri35(.out(data_readRegB), .oe(out_decoder_RB[3]), .in(Q_reg3));
tri_32 tri36(.out(data_readRegB), .oe(out_decoder_RB[4]), .in(Q_reg4));
tri_32 tri37(.out(data_readRegB), .oe(out_decoder_RB[5]), .in(Q_reg5));
tri_32 tri38(.out(data_readRegB), .oe(out_decoder_RB[6]), .in(Q_reg6));
tri_32 tri39(.out(data_readRegB), .oe(out_decoder_RB[7]), .in(Q_reg7));

tri_32 tri40(.out(data_readRegB), .oe(out_decoder_RB[8]), .in(Q_reg8));
tri_32 tri41(.out(data_readRegB), .oe(out_decoder_RB[9]), .in(Q_reg9));
tri_32 tri42(.out(data_readRegB), .oe(out_decoder_RB[10]), .in(Q_reg10));
tri_32 tri43(.out(data_readRegB), .oe(out_decoder_RB[11]), .in(Q_reg11));
tri_32 tri44(.out(data_readRegB), .oe(out_decoder_RB[12]), .in(Q_reg12));
tri_32 tri45(.out(data_readRegB), .oe(out_decoder_RB[13]), .in(Q_reg13));
tri_32 tri46(.out(data_readRegB), .oe(out_decoder_RB[14]), .in(Q_reg14));
tri_32 tri47(.out(data_readRegB), .oe(out_decoder_RB[15]), .in(Q_reg15));

tri_32 tri48(.out(data_readRegB), .oe(out_decoder_RB[16]), .in(Q_reg16));
tri_32 tri49(.out(data_readRegB), .oe(out_decoder_RB[17]), .in(Q_reg17));
tri_32 tri50(.out(data_readRegB), .oe(out_decoder_RB[18]), .in(Q_reg18));
tri_32 tri51(.out(data_readRegB), .oe(out_decoder_RB[19]), .in(Q_reg19));
tri_32 tri52(.out(data_readRegB), .oe(out_decoder_RB[20]), .in(Q_reg20));
tri_32 tri53(.out(data_readRegB), .oe(out_decoder_RB[21]), .in(Q_reg21));
tri_32 tri54(.out(data_readRegB), .oe(out_decoder_RB[22]), .in(Q_reg22));
tri_32 tri55(.out(data_readRegB), .oe(out_decoder_RB[23]), .in(Q_reg23));

tri_32 tri56(.out(data_readRegB), .oe(out_decoder_RB[24]), .in(Q_reg24));
tri_32 tri57(.out(data_readRegB), .oe(out_decoder_RB[25]), .in(Q_reg25));
tri_32 tri58(.out(data_readRegB), .oe(out_decoder_RB[26]), .in(Q_reg26));
tri_32 tri59(.out(data_readRegB), .oe(out_decoder_RB[27]), .in(Q_reg27));
tri_32 tri60(.out(data_readRegB), .oe(out_decoder_RB[28]), .in(Q_reg28));
tri_32 tri61(.out(data_readRegB), .oe(out_decoder_RB[29]), .in(Q_reg29));
tri_32 tri62(.out(data_readRegB), .oe(out_decoder_RB[30]), .in(Q_reg30));
tri_32 tri63(.out(data_readRegB), .oe(out_decoder_RB[31]), .in(Q_reg31));


endmodule
