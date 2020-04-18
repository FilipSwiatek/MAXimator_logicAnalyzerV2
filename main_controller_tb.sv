
`timescale 1ps / 1ps
module main_controller_tb();

logic clk = 0;
logic faster = 0;
logic slower = 0;
logic chan_next = 0;
logic chan_prev = 0;
logic trig_toggle = 0;

logic unsigned [28:0] PRESCALING_FACTOR;
logic unsigned [28:0] SAMPLING_FREQUENCY;
logic [1:0] TRIGGER_KIND [15:0];

always
	#1 clk = ~clk;
	
initial begin
	// checking if faster and slower events work correctly
	for (int i = 0; i < 34; i++) begin 
		#2 faster = 1;
		#2 faster = 0;
	end
	for (int i = 0; i < 34; i++) begin 
		#2 slower = 1;
		#2 slower = 0;
	end
	// checking if channel trigger setup is set correctly
	for (int k = 0; k < 17; k++) begin
		for (int i = 0; i < 4; i++) begin 
			#2 trig_toggle = 1;
			#2 trig_toggle = 0;
		end
		#2 chan_next = 1;
		#2 chan_next = 0;
	end
	for (int k = 0; k < 17; k++) begin
		for (int i = 0; i < 4; i++) begin 
			#2 trig_toggle = 1;
			#2 trig_toggle = 0;
		end
		#2 chan_prev = 1;
		#2 chan_prev = 0;
	end
	
end

main_controller  UUT(
	.faster(faster),
	.slower(slower),
	.chan_next(chan_next),
	.chan_prev(chan_prev),
	.trig_toggle(trig_toggle),
	.clk(clk),
	.PRESCALING_FACTOR(PRESCALING_FACTOR),
	.SAMPLING_FREQUENCY(SAMPLING_FREQUENCY),
	.TRIGGER_KIND(TRIGGER_KIND)
); 

initial begin
	#2000 $stop;
end
	
endmodule
