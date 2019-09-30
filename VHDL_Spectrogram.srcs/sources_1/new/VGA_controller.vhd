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

begin

	process(clk)
	begin
		IF rising_edge(clk) THEN
			IF  Active_video = '1' THEN
				--nu in actief gebied van het scherm
			
				
			
			else
				s_output_greyscale <= "0000";				
			end if;
		end if;
	end process;

	output_greyscale <= s_output_greyscale;

end Behavioral;
