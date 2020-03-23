library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity drawer is

port    (
				SAMPLES: in std_logic_vector(7 downto 0); -- current sample (based on X)
            RST: in std_logic;
            CLK: in std_logic;
				X: in std_logic_vector(15 downto 0);
				Y: in std_logic_vector(15 downto 0);
				DISP_EN: in std_logic; -- informs when active region should be displayed
				RGB: out std_logic_vector(2 downto 0)
         );
end drawer;



architecture drawer_arch of drawer is
-- constants

constant H_SIZE_PXLS : integer := 720; -- vertical active pixels
constant V_SIZE_GRAPH_HEIGHT : integer := 70; -- single graph horizontal size
constant V_SIZE_GRAPH_DISTANCE : integer := 20; -- single graph horizontal distance

constant LINE_0_TRUE_CORD: std_logic_vector (15 downto 0) := conv_std_logic_vector(10, 16);
constant LINE_1_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 1 * V_SIZE_GRAPH_DISTANCE + 1 *	V_SIZE_GRAPH_HEIGHT ;
constant LINE_2_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 2 * V_SIZE_GRAPH_DISTANCE + 2 * V_SIZE_GRAPH_HEIGHT ;
constant LINE_3_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 3 * V_SIZE_GRAPH_DISTANCE + 3 * V_SIZE_GRAPH_HEIGHT ;
constant LINE_4_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 4 * V_SIZE_GRAPH_DISTANCE + 4 * V_SIZE_GRAPH_HEIGHT ;
constant LINE_5_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 5 * V_SIZE_GRAPH_DISTANCE + 5 * V_SIZE_GRAPH_HEIGHT ;
constant LINE_6_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 6 * V_SIZE_GRAPH_DISTANCE + 6 * V_SIZE_GRAPH_HEIGHT ;
constant LINE_7_TRUE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + 7 * V_SIZE_GRAPH_DISTANCE + 7 * V_SIZE_GRAPH_HEIGHT ;

constant LINE_0_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_0_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_1_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_1_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_2_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_2_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_3_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_3_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_4_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_4_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_5_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_5_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_6_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_6_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;
constant LINE_7_FALSE_CORD: std_logic_vector (15 downto 0) := LINE_7_TRUE_CORD + V_SIZE_GRAPH_HEIGHT;


constant BLACK			: std_logic_vector := "000";
constant LINE_0_COLOR: std_logic_vector := "001";
constant LINE_1_COLOR: std_logic_vector := "010";
constant LINE_2_COLOR: std_logic_vector := "011";
constant LINE_3_COLOR: std_logic_vector := "100";
constant LINE_4_COLOR: std_logic_vector := "101";
constant LINE_5_COLOR: std_logic_vector := "110";
constant LINE_6_COLOR: std_logic_vector := "001";
constant LINE_7_COLOR: std_logic_vector := "010";


-- internal signals forwarded directly to output

signal RGB_int: std_logic_vector(2 downto 0);


begin
process(DISP_EN, CLK, SAMPLES) -- poki co demo
begin
	if(rising_edge(CLK)) then
		if(DISP_EN = '1') then
			case Y is
				when LINE_0_TRUE_CORD =>
					if(SAMPLES(0) = '1') then
						RGB_int <= LINE_0_COLOR ;
					else
						RGB_int <= BLACK;
					end if;
				when LINE_0_FALSE_CORD =>
					if(SAMPLES(0) = '0') then
						RGB_int <= LINE_0_COLOR ;
					else
						RGB_int <= BLACK;
					end if;	
				when LINE_1_TRUE_CORD =>
					if(SAMPLES(1) = '1') then
						RGB_int <= LINE_1_COLOR ;
					else
						RGB_int <= BLACK;
					end if;
				when LINE_1_FALSE_CORD =>
					if(SAMPLES(1) = '0') then
						RGB_int <= LINE_1_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;		
				when LINE_2_TRUE_CORD =>
					if(SAMPLES(2) = '1') then
						RGB_int <= LINE_2_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;
				when LINE_2_FALSE_CORD =>
					if(SAMPLES(2) = '0') then
						RGB_int <= LINE_2_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;
				when LINE_3_TRUE_CORD =>
					if(SAMPLES(3) = '1') then
						RGB_int <= LINE_3_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;
				when LINE_3_FALSE_CORD =>
					if(SAMPLES(3) = '0') then
						RGB_int <= LINE_3_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;	
				when LINE_4_TRUE_CORD =>
					if(SAMPLES(4) = '1') then
						RGB_int <= LINE_4_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;	
				when LINE_4_FALSE_CORD =>
					if(SAMPLES(4) = '0') then
						RGB_int <= LINE_4_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;
				when LINE_5_TRUE_CORD =>
					if(SAMPLES(5) = '1') then
						RGB_int <= LINE_5_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;	
				when LINE_5_FALSE_CORD =>
					if(SAMPLES(5) = '0') then
						RGB_int <= LINE_5_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;
				when LINE_6_TRUE_CORD =>
					if(SAMPLES(6) = '1') then
						RGB_int <= LINE_6_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;	
				when LINE_6_FALSE_CORD =>
					if(SAMPLES(6) = '0') then
						RGB_int <= LINE_6_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;	
				when LINE_7_TRUE_CORD =>
					if(SAMPLES(7) = '1') then
						RGB_int <= LINE_7_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;	
				when LINE_7_FALSE_CORD =>
					if(SAMPLES(7) = '0') then
						RGB_int <= LINE_7_COLOR ;
					else
						RGB_int <= BLACK;	
					end if;		
				when others => RGB_int <= RGB_int  ;
			end case;
		else
			RGB_int <= "000";
		end if;
	end if;
end process;

RGB <= RGB_int;

end drawer_arch;