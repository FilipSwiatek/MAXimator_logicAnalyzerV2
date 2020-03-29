module main_controller

(
	// Input Ports
	input faster,
	input slower,
	input chan_next,
	input chan_prev,
	input trig_toggle,
	
	// Output Ports
	output reg unsigned [15:0] PRESCALING_FACTOR,
	output reg signed [31:0] SAMPLING_FREQUENCY //  frequency 
	
);

	
endmodule


