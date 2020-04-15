module main_controller
(
	// Input Ports
	input wire faster,
	input wire slower,
	input wire chan_next,
	input wire chan_prev,
	input wire trig_toggle,
	input wire clk,
	
	// Output Ports
	output logic unsigned [15:0] PRESCALING_FACTOR = 1,
	output logic unsigned [31:0] SAMPLING_FREQUENCY, //  frequency 
	output logic [1:0] TRIGGER_KIND [15:0] = {0}
	
);

// TODO - do something with frequency presets. Base frequency is 400Mhz. Consider possible and considerable presets


//enum bit[1:0] {NONE = 2'b00, RISING = 2'b01 , FALLING = 2'b10, BOTH = 2'b11} trigger_type;
logic faster_prev, slower_prev, chan_next_prev, chan_prev_prev, trig_toggle_prev; 
logic unsigned [3:0] current_channel = 0;

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
		//TODO
	end else if(!slower && slower_prev) begin //  when slower button is pressed but previously wasn't
		//TODO
	end
end : timebase_select_process





	
endmodule



