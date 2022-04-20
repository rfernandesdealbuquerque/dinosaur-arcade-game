module DINO(input clk,
            input button_press,
            input reset,
            input pause_switch,

            // VGA input
            output hSync, 		// H Sync Signal
            output vSync, 		// Veritcal Sync Signal

            output[3:0] VGA_R,  // Red Signal Bits
            output[3:0] VGA_G,  // Green Signal Bits
            output[3:0] VGA_B,  // Blue Signal Bits

            output [6:0] CAT,
            output [7:0] AN,

            output life0, life1, life2,

            inout ps2_clk,
            inout ps2_data);
    

    localparam MHz = 1000000;
    localparam SYSTEM_FREQ = 100*MHz; // System clock frequency
    localparam PROC_FREQ = 50*MHz;

    localparam GAME_FRAME_RT = 64'd3; // 3 fps

    wire frame_rate_clk, processor_clk;

    clock_divider_DINO frame_rate_clock_divider(.divclk(frame_rate_clk), .divclkfreq(GAME_FRAME_RT),
                                           .sysclk(clk), .sysclkfreq(SYSTEM_FREQ));

    clock_divider_DINO processor_clock_divider(.divclk(processor_clk), .divclkfreq(PROC_FREQ),
                                           .sysclk(clk), .sysclkfreq(SYSTEM_FREQ));

    wire screen_ready, collision_detected;

    wire [31:0] x_coor, y_coor, x_coor_obstacle, y_coor_obstacle; 
    wire [31:0] r20, r22, r24, r25, r26, r28;
    assign r20[31:3] = 28'd0;
    assign r20[2] = button_press;
    assign r20[1] = button_press;
    assign r20[0] = button_press;
	assign r22[31:3] = 28'd0;
    assign r22[2] = screen_ready;
    assign r22[1] = screen_ready;
    assign r22[0] = screen_ready;
    assign r24[31:3] = 28'd0;
    assign r24[2] = collision_detected;
    assign r24[1] = collision_detected;
    assign r24[0] = collision_detected;
    assign r26[31:3] = 28'd0;
    assign r26[2] = pause_switch;
    assign r26[1] = pause_switch;
    assign r26[0] = pause_switch;

    assign life0 = r28[1] || r28[0];
    assign life1 = r28[1];
    assign life2 = r28[1] && r28[0];
  
    wire [31:0] q_reg20, q_reg22;
    wire [11:0] obstacle_height;

    //ila_0 debugger(.clk(clk), .probe0(x_coor), .probe1(y_coor), .probe2(r20), .probe3(r22), .probe4(r25), .probe5(obstacle_height));

    Wrapper CPU(
        // OG ports    
        .clock(processor_clk), 
        .reset(reset), 

        .r20(r20), .r22(r22), .r24(r24), .r26(r26),
        .r16(x_coor), .r17(y_coor),
        .r14(x_coor_obstacle), .r15(y_coor_obstacle), .r25(r25), .r28(r28),
        .button_signal(button_press),
        .screen_signal(screen_ready),
        .collision_signal(collision_detected),
        .pause_signal(pause_switch),
        .q_reg20(q_reg20),
        .q_reg22(q_reg22)
    );

//r14 = x-coordinate of obstacle center
//r15 = y-coordinate of obstacle bottom
// r16 = x-coordinate of dino center
// r17 = y-coordinate of dino bottom
// r18 = counts loop for jump
// r19 = holds dino total jump height
// r20 = button pressed status
// r21 = 1
// r22 = screen end status --> = 1 if ready for next frame

    wire game_over;
    assign game_over = (~r28[1]) && (~r28[0]); //r28 = 00 then game_over

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
        .collision_detected(collision_detected),
        .random_generator_clk(r25[1:0]),
        .obstacle_height(obstacle_height),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data), 

        .x_coor(x_coor), 
        .y_coor(y_coor),
        .x_coor_obstacle(x_coor_obstacle),
        .y_coor_obstacle(y_coor_obstacle),
        .pause(pause_switch),
        .game_over(game_over)
    );

    wire enable_score;
    assign enable_score = (pause_switch || game_over) ? 1'b0 : 1'b1;

    score_tracking Score_Display(.clk(clk), .en(enable_score), .clr(reset), .AN(AN), .CAT(CAT));

endmodule
