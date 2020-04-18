
`timescale 1ps / 1ps
module prescaler_tb;

	reg rst, clk, ce1, ce2;
	reg unsigned [28:0] FACTOR;
	
 
  prescaler prescaler_inst1  (.rst(rst), .clk(clk), .FACTOR(FACTOR), .ce(ce1)); 
  prescaler #(0, 2) prescaler_inst2 (.rst(rst), .clk(clk), .FACTOR(FACTOR), .ce(ce2)); 


  
	initial
	begin
		rst = 0;
		clk = 0;
		FACTOR = 3;
	end
  
  
	always
	begin
	#1 clk = ~clk;
	end
  
  
  
  
  initial
	#2000 $stop;
	
	
	
	

endmodule
