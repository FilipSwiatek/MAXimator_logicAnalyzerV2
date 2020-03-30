module drawer
(
	// Input Ports
	input disp_en,
	input clk,
	input [15:0] SAMPLES,
	input unsigned [10:0] X,
	input unsigned [10:0] Y,
	input unsigned [31:0] SAMPLING_FREQUENCY,
	input trig,

	// Output Ports
	
	output reg [2:0] RGB
);

initial
begin

RGB = 3'b000;
end

always@(posedge clk)
begin

RGB <= 3'b000;

end
endmodule
