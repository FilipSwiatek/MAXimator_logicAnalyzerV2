library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity vga_controller is

port    (
            RST: in std_logic;
            CLK: in std_logic;
            H_SYNC: out std_logic;
            V_SYNC: out std_logic;
				X: out std_logic_vector(10 downto 0);
				Y: out std_logic_vector(10 downto 0);
				DISP_EN: out std_logic
         );
end vga_controller;



architecture vga_controller_arch of vga_controller is

-- variables defining screen parameters
constant H_SIZE_PXLS : integer := 1280; -- horizontal active pixels
constant H_FRONT_PORCH_PXLS : integer := 110;  -- horizontal front porch size
constant H_BACK_PORCH_PXLS : integer := 220; -- horizontal back porch size
constant H_SYNC_PXLS : integer := 40;   -- horizontal sync signal size
constant H_TOTAL_PXLS :integer := H_SIZE_PXLS + H_FRONT_PORCH_PXLS + H_BACK_PORCH_PXLS + H_SYNC_PXLS;
 			
constant V_SIZE_PXLS : integer := 720 ; -- vertical active lines
constant V_FRONT_PORCH_PXLS : integer := 5;  -- vertical front porch size
constant V_BACK_PORCH_PXLS : integer := 20; -- vertical back porch size
constant V_SYNC_PXLS : integer := 5;   -- vertical sync signal size
constant V_TOTAL_PXLS :integer := V_SIZE_PXLS + V_FRONT_PORCH_PXLS + V_BACK_PORCH_PXLS + V_SYNC_PXLS;

-- internal signals forwarded directly to output
signal H_SYNC_int : std_logic;
signal V_SYNC_int : std_logic; 
signal DISP_EN_int: std_logic;
signal X_int: std_logic_vector(10 downto 0);
signal Y_int: std_logic_vector(10 downto 0);

begin

	counters: process(CLK, RST) 
	begin
	
		if rising_edge(CLK) then
		
			if RST = '1' then
				X_int <= "00000000000";
				Y_int <= "00000000000";
			else			
				if X_int = H_TOTAL_PXLS - 1 then			
					X_int<= "00000000000";				
					if Y_int = V_TOTAL_PXLS - 1 then			
						Y_int <= "00000000000";					
					else				
						Y_int <= Y_int+1;					
					end if; --if Y_int = V_TOTAL_PXLS - 1				
				else				
				X_int <= X_int+1;						
				end if; --if X_int = H_TOTAL_PXLS - 1				
			end if; -- if rising_edge(RST)
		end if; -- if rising_edge(CLK)
	end process; -- counters
	
	-- asynchronous process
	HV_SYNC: process(X_int, Y_int)
	begin
	
	--HSYNC
	if X_int > H_SIZE_PXLS + H_FRONT_PORCH_PXLS - 1  and X_int < H_SIZE_PXLS + H_FRONT_PORCH_PXLS + H_SYNC_PXLS then
		H_SYNC_int <= '0';
	else
		H_SYNC_int <= '1';
	end if;
	
	--VSYNC
	if Y_int > V_SIZE_PXLS + V_FRONT_PORCH_PXLS - 1  and Y_int < V_SIZE_PXLS + V_FRONT_PORCH_PXLS + V_SYNC_PXLS then
		V_SYNC_int <= '0';
	else
		V_SYNC_int <= '1';
	end if;
	end process;
	
	--asynchronous process
	--enable to display stuff on displayed area only by DISP_EN
	blanking: process(X_int, Y_int)
	begin
	if (X_int < H_SIZE_PXLS or X_int = H_TOTAL_PXLS ) then
		if(Y_int < V_SIZE_PXLS or Y_int = V_TOTAL_PXLS ) then
			DISP_EN_int <= '1';
		else
			DISP_EN_int <= '0'; -- to avoid creating latch
		end if; -- if(Y-int < V_SIZE_PXLS or Y_int = V_TOTAL_PXLS)
	else 
		DISP_EN_int <= '0';
	end if; --if (X-int < H_SIZE_PXLS or X_int = H_TOTAL_PXLS)
	end process;
	
	--forwarding signals to output
	H_SYNC <= H_SYNC_int;
	V_SYNC <= V_SYNC_int;
	DISP_EN <= DISP_EN_int;
	X <= X_int;
	Y <= Y_int;

end vga_controller_arch;
