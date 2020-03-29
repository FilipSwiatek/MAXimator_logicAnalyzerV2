library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity sampler is

port    (
				INPUT: in std_logic_vector(15 downto 0); -- sampled 16-bit vector
            RST: in std_logic; 
            CLK: in std_logic; -- global clock
            CE: in std_logic;  -- clock enable from prescaler (for sampler only - read clock is not prescaled)
				Q: out std_logic_vector(15 downto 0); -- output made to connect with data in from memory
				ADDRQ: out std_logic_vector (10 downto 0); -- sample address to show on output
				WREN: out std_logic;
				TRIG: out std_logic
         );
end sampler;

architecture sampler_arch of sampler is

constant SAMPLES_num : integer := 1280; -- number of samples

signal INPUT_first: std_logic_vector(15 downto 0);
signal Q_int: std_logic_vector(15 downto 0);
signal ADDRQ_int: std_logic_vector(10 downto 0);
signal TRIGGER: std_logic;
signal WREN_int: std_logic;
signal CLEARING_MEMORY_ONGOING: std_logic := '0';

begin

sampling:process(CLK, RST, CLEARING_MEMORY_ONGOING, ADDRQ_int)
begin

if rising_edge(CLK) then
	if (RST = '1' and CLEARING_MEMORY_ONGOING = '0') then
		ADDRQ_int <= "00000000000";
		INPUT_first <= INPUT;
		TRIGGER <= '0';
		WREN_int <= '1';
		CLEARING_MEMORY_ONGOING <= '1';
	elsif (CLEARING_MEMORY_ONGOING = '1') then -- when in memory clearing state
		if(ADDRQ_int < SAMPLES_num) then
			WREN_int <= '1';
			Q_int <= "0000000000000000"; 
			ADDRQ_int <= ADDRQ_int+1;
		else 
			CLEARING_MEMORY_ONGOING <= '0';	
		end if; -- (ADDRQ_int < SAMPLES_num)
	else
		if(CE = '1') then
			if(TRIGGER = '1' or ((INPUT_first xor INPUT) /= "0000000000000000")) then
				if(ADDRQ_int /=  SAMPLES_num - 1) then -- save input state to buffer
					if(TRIGGER = '1') then
						ADDRQ_int <= ADDRQ_int + 1;
					end if;
					TRIGGER <= '1';
					WREN_int <= '1';
					Q_int <= INPUT;
				else
					WREN_int <= '0';
				end if;
			end if; -- if(TRIGGER)
	
		end if; --if(CE = '1')
	end if; -- if RST = '1'
	

	
	
	
	
end if; --if rising_edge(CLK)

end process;
TRIG <= TRIGGER;
WREN <= WREN_int; 
ADDRQ <= ADDRQ_int;
Q <= Q_int;
end sampler_arch;