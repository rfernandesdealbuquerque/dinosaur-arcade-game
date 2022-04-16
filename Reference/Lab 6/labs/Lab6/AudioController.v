module AudioController(
    input        clk, 		// System Clock Input 100 Mhz
    input        micData,	// Microphone Output
    input[3:0]   switches,	// Tone control switches
    input        audioEnable,
    output       micClk, 	// Mic clock 
    output       chSel,		// Channel select; 0 for rising edge, 1 for falling edge
    output       audioOut,	// PWM signal to the audio jack	
    output       audioEn);	// Audio Enable

	localparam MHz = 1000000;
	localparam SYSTEM_FREQ = 100*MHz; // System clock frequency

	assign chSel   = 1'b0;  // Collect Mic Data on the rising edge 
	assign audioEn = audioEnable;  // Enable Audio Output

	// Initialize the frequency array. FREQs[0] = 261
	reg[10:0] FREQs[0:15];
	initial begin
		$readmemh("FREQs.mem", FREQs);
	end
	
	////////////////////
	// Your Code Here //
	////////////////////
	
	reg [17:0] CounterLimit;
	reg[6:0] duty_cycle;
	wire[6:0] duty_cycle_mic;
	wire[6:0] duty_cycle_node;
	
	reg clkNode = 0;
	reg [17:0] counter = 0;
	always @(posedge clk) begin
		CounterLimit <= 50*MHz/FREQs[switches];
	   if(counter < CounterLimit)
	       counter <= counter + 1;
	   else begin
	       counter <= 0;
	       clkNode <= ~clkNode;
	   end
    end
    
    assign duty_cycle_node = clkNode ? 75:25;
    
    reg clk1MHz = 0;
	reg [6:0] counter1MHz = 0;
	always @(posedge clk) begin
	    duty_cycle <= (duty_cycle_mic+duty_cycle_node)/2;
	   if(counter1MHz < 2'd50)
	       counter1MHz <= counter1MHz + 1;
	   else begin
	       counter1MHz <= 0;
	       clk1MHz <= ~clk1MHz;
	   end
    end
    
    assign micClk = clk1MHz;

	//PWMDeserializer myDeserializer(.clk(clk), .reset(1'b0), .signal(micData), .duty_cycle(duty_cycle_mic));
	PWMSerializer mySerializer(.clk(clk), .reset(1'b0), .duty_cycle(duty_cycle), .signal(audioOut));
//	  input clk,              // System Clock
//    input reset,            // Reset the counter
//    input[6:0] duty_cycle,       // Duty Cycle of the Wave, between 0 and 99
//    output reg signal = 0   // Output PWM signal

endmodule