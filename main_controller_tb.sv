
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
	#3 faster = 1;
	#70 faster = 0;
	slower = 1;
	#70 slower = 0;
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
