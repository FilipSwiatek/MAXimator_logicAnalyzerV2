module main_controller(

	// Input Ports
	input wire faster,
	input wire slower,
	input wire chan_next,
	input wire chan_prev,
	input wire trig_toggle,
	input wire clk,
	
	// Output Ports
	output logic unsigned [28:0] PRESCALING_FACTOR = 1,
	output logic unsigned [28:0] SAMPLING_FREQUENCY, //  frequency 
	output logic [1:0] TRIGGER_KIND [15:0] = {0}
);
	
	//enum bit[1:0] {NONE = 2'b00, RISING = 2'b01 , FALLING = 2'b10, BOTH = 2'b11} trigger_type;
	logic faster_prev, slower_prev, chan_next_prev, chan_prev_prev, trig_toggle_prev; 
	logic unsigned [3:0] current_channel = 0;
	logic unsigned [4:0]	current_frequency_preset = 0;
	
	// A E S T H E T I C presets
	const logic[28:0] frequency_presets[32]				= '{400000000, 200000000, 100000000, 50000000,
																			25000000, 20000000, 12500000, 10000000,
																			5000000, 2500000, 2000000, 1000000, 
																			500000, 250000, 200000,100000,
																			50000, 25000, 20000, 10000,
																			5000, 2500, 2000, 1000,
																			500, 250, 200, 100,
																			50, 25, 20, 10};
	
	
	const logic[28:0] prescalingFactor_presets[32]	= '{1, 2, 4, 8,
																			16, 20, 32, 40,
																			80, 160, 200, 400,
																			800, 1600, 2000, 4000,
																			8000, 16000, 20000, 40000,
																			80000, 160000, 200000, 400000,
																			800000, 1600000, 2000000, 4000000,
																			8000000, 16000000, 20000000, 40000000};
	
	// saving previous button state (for single reaction at several clock cycles when button pressed once)
	always_ff @(posedge clk) begin : button_prev_state_proc 
		faster_prev 		<= faster;
		slower_prev 		<= slower;
		chan_next_prev		<= chan_next;
		chan_prev_prev		<= chan_prev;
		trig_toggle_prev	<= trig_toggle;
		trig_toggle_prev	<= trig_toggle;
	end : button_prev_state_proc
	
	// changing trigger type on currently chosen channel
	always_ff @(posedge clk) begin : trigger_kind_proc 
		if(!trig_toggle && trig_toggle_prev) begin //  when trig_toggle button is pressed but previously wasn't
			TRIGGER_KIND[current_channel]++;
		end
	end : trigger_kind_proc
	
	// channel select process (chan_next button has higher priority)
	always_ff @(posedge clk) begin : channel_select_process 
		if(!chan_next && chan_next_prev) begin //  when chan_next button is pressed but previously wasn't
			current_channel++;
		end else if(!chan_prev && chan_prev_prev) begin //  when chan_prev button is pressed but previously wasn't
			current_channel--;
		end
	end : channel_select_process
	
	// selecting frequency presets and coresponding prescaling factor
	always_ff @(posedge clk) begin : timebase_select_process 
		if(!faster && faster_prev) begin //  when faster button is pressed but previously wasn't
			if(current_frequency_preset != 5'b11111) begin
				current_frequency_preset++;
			end
		end else if(!slower && slower_prev) begin //  when slower button is pressed but previously wasn't
			if(current_frequency_preset != 5'b00000) begin
				current_frequency_preset--;
			end
		end
	end : timebase_select_process
	
	// setting output depending on prescaler presets and current setup
	always_comb begin : output_vars_setup
		PRESCALING_FACTOR	= prescalingFactor_presets[current_frequency_preset];
		SAMPLING_FREQUENCY = frequency_presets[current_frequency_preset];
	end : output_vars_setup
	
endmodule



