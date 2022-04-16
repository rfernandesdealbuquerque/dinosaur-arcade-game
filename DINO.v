module DINO(input clk,
            input button_press,

            // VGA input
            output hSync, 		// H Sync Signal
            output vSync, 		// Veritcal Sync Signal

            output[3:0] VGA_R,  // Red Signal Bits
            output[3:0] VGA_G,  // Green Signal Bits
            output[3:0] VGA_B,  // Blue Signal Bits

            inout ps2_clk,
            inout ps2_data);

    wire reset;
    assign reset = 1'b0;

    localparam MHz = 1000000;
    localparam SYSTEM_FREQ = 100*MHz; // System clock frequency
    localparam PROC_FREQ = 50*MHz;

    localparam GAME_FRAME_RT = 64'd60; // 60 fps

    wire frame_rate_clk, processor_clk;

    clock_divider frame_rate_clock_divider(.divclk(frame_rate_clk), .divclkfreq(GAME_FRAME_RT),
                                           .sysclk(clk), .sysclkfreq(SYSTEM_FREQ));

    clock_divider processor_clock_divider(.divclk(processor_clk), .divclkfreq(PROC_FREQ),
                                           .sysclk(clk), .sysclkfreq(SYSTEM_FREQ));

    wire screen_ready;

    wire [31:0] x_coor, y_coor, r20, r22;
    assign r20[31:3] = 28'd0;
    assign r20[2] = button_press;
    assign r20[1] = button_press;
    assign r20[0] = button_press;
	assign r22[31:3] = 28'd0;
    assign r22[2] = screen_ready;
    assign r22[1] = screen_ready;
    assign r22[0] = screen_ready;

    wire [31:0] q_reg20, q_reg22;

    ila_0 debugger(.clk(clk), .probe0(x_coor), .probe1(y_coor), .probe2(r20), .probe3(r22), .probe4(q_reg20), .probe5(q_reg22));

    Wrapper CPU(
        // OG ports    
        .clock(processor_clk), 
        .reset(reset), 

        .r20(r20), .r22(r22), 
        .r16(x_coor), .r17(y_coor),
        .button_signal(button_press),
        .screen_signal(screen_ready),
        .q_reg20(q_reg20),
        .q_reg22(q_reg22)
    );

// r16 = x-coordinate of dino center
// r17 = y-coordinate of dino bottom
// r18 = counts loop for jump
// r19 = holds dino total jump height
// r20 = button pressed status
// r21 = 1
// r22 = screen end status --> = 1 if ready for next frame

    VGAController display_control(     

        // OG ports
        .clk(clk), 			// 100 MHz System Clock
        .reset(reset), 		// Reset Signal
        
        .hSync(hSync), 		// H Sync Signal
        .vSync(vSync), 		// Veritcal Sync Signal
        .VGA_R(VGA_R),  // Red Signal Bits
        .VGA_G(VGA_G),  // Green Signal Bits
        .VGA_B(VGA_B),  // Blue Signal Bits
        .screen_ready(screen_ready),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data), 

        .x_coor(x_coor), 
        .y_coor(y_coor) 
    );

endmodule
