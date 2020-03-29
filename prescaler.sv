module prescaler

#(
	// Parameter Declarations
	parameter settable = 1, // determines if prescaler is settable by program or has fixed factor
	parameter unsigned [15:0] PRESCALING_FACTOR = 1 // used if above is 0
)

(
	// Input Ports
	input rst,
	input clk,
	input unsigned [15:0] FACTOR,


	// Output Ports
	output ce
);

	// Module Item(s)

endmodule
