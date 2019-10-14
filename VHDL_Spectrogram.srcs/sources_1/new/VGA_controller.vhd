----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2019 10:45:51
-- Design Name: 
-- Module Name: VGA_controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_controller is

	Port (	clk: in std_logic;
	
			Y: in integer RANGE 0 TO 525; --positions on screen;
			X: in integer RANGE 0 TO 800;
			Active_video: in std_logic;
		
			output_greyscale: out STD_LOGIC_VECTOR (3 downto 0));
			
end VGA_controller;

architecture Behavioral of VGA_controller is

	SIGNAL s_output_greyscale : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
	
	
	
	--these constants is so we know where the "dynamic" portion of the image starts
	--dynamic ? => the part of the image that is determined by the FFT 
	
	constant dyn_beeld_start_X: integer RANGE 0 to 640 := 46;
	constant dyn_beeld_einde_X: integer RANGE 0 to 640 := 524;
	constant dyn_beeld_start_Y: integer RANGE 0 to 480 := 69;
	constant dyn_beeld_einde_Y: integer RANGE 0 to 480 := 411;

begin

	process(clk)
	begin
		IF rising_edge(clk) THEN
			IF  Active_video = '1' THEN
				--nu in actief gebied van het scherm
				case X is
					when 0 to dyn_beeld_start_X - 1 => 
						s_output_greyscale <= "1000";	
					when dyn_beeld_start_X to dyn_beeld_einde_X=> 
						case Y is
							when 0 to dyn_beeld_start_Y - 1 => 
								s_output_greyscale <= "1111";	
							when dyn_beeld_start_Y to dyn_beeld_einde_Y=>
							
							
								--nu in dynamisch beeld gedeelte: TODO
								s_output_greyscale <= "0000";
							
							
							
							when dyn_beeld_einde_Y + 1 to 480 => 
								s_output_greyscale <= "1111";	
							when 481 to 525 =>
								s_output_greyscale <= "0000";
						end case;
					when dyn_beeld_einde_X + 1 to 640 => 
						s_output_greyscale <= "1000";	
					when 641 to 800 =>
						s_output_greyscale <= "0000";
				end case;
			
			else
				s_output_greyscale <= "0000";				
			end if;
		end if;
	end process;

	output_greyscale <= s_output_greyscale;

end Behavioral;
