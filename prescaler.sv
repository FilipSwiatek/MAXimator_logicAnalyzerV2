module prescaler

#(
	// Parameter Declarations
	parameter settable = 1, // determines if prescaler is settable by program or has fixed factor
	parameter unsigned [28:0] PRESCALING_FACTOR = 1 // used if above is 0
)

(
	// Input Ports
	input rst,
	input clk,
	input unsigned [28:0] FACTOR,


	// Output Ports
	output reg ce
);

	reg unsigned[28:0] counter;
	reg unsigned [28:0] final_factor; 

	initial 
	begin
		ce = 0;
		counter = 0;	
	end
	
	
	
	
	
	always@(negedge clk)
	begin
		if(settable == 1) begin
			final_factor <= FACTOR;
		end	
		else begin
			final_factor <= PRESCALING_FACTOR;
		end
	
	
		if(rst == 1) begin
			counter <= 0;
		end
		else begin
			if(counter < final_factor-1) begin
				counter++;
				ce <= 0;
			end
			else begin
				ce <= 1;
				counter <= 0;
			end
		end
		
		
		
	end
	
	//assign ce = ce;
endmodule
