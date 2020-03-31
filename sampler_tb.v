
`timescale 1ns / 1ns
module sampler_tb  ; 
 
  wire    trigger   ; 
  wire    wren   ; 
  wire  [10 : 0]  addrq   ; 
  reg    ce   ; 
  reg  [15 : 0]  in   ; 
  wire  [15 : 0]  q   ; 
  reg    rst   ; 
  reg    clk   ; 
  reg  [31 : 0]  trig_kind   ; 
  integer i;
  sampler  
   DUT  ( 
       .TRIGGER (trigger ) ,
      .WREN (wren ) ,
      .ADDRQ (addrq ) ,
      .CE (ce ) ,
      .INPUT (in ) ,
      .Q (q ) ,
      .RST (rst ) ,
      .CLK (clk ) ,
      .TRIG_KIND (trig_kind ) ); 


// "Counter Pattern"(Binary-Up) : step = 1
// Start Time = 0 ns, End Time = 1 ms, Period = 50 ns
  initial
  begin
	repeat(2137)
	  begin
			for (i = 0; i < 16; i = i + 1)
			begin
					in  = 16'b0000000000000000;
				#4 in  = 16'b0000000000000001 << i;
				#4 in  = 16'b0000000000000000;
			end
	  end
	end


  initial
  begin
		rst  = 1'b0  ;
		ce = 1'b1;		
		trig_kind  = 32'd1 ;
		# 98
		rst  = 1'b1  ;
		trig_kind  = 32'd2 ;
		#2
		rst  = 1'b0;
		#40
		rst  = 1'b1  ;
		trig_kind  = 32'd4 ;
		#4
		rst  = 1'b0 ;
		#200
		rst  = 1'b1  ;
		trig_kind  = 32'd1 << 4 ;
		#4
		rst  = 1'b0 ;

  end


// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 1 sec, Period = 100 ns
  initial
  begin
	  clk = 1'b0;
  end
  
  always
  begin
  #2 clk <= ~clk;
  end
  
  always
  begin
  #8 ce <= ~ce;
  end

  initial
	#1000 $stop;
endmodule
