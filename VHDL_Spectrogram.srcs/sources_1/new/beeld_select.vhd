----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2019 11:00:10
-- Design Name: 
-- Module Name: beeld_select - Behavioral
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

entity beeld_select is
	Port ( 	
		X : in integer range 0 to 800;
		Y : in integer range 0 to 525;
		Active_video: in std_logic;
		
		ENA_dyn_beeld: out std_logic;
		ENA_stat_beeld: out std_logic
	);
end beeld_select;

architecture Behavioral of beeld_select is
	
	--these constants is so we know where the "dynamic" portion of the image starts
	--dynamic ? => the part of the image that is determined by the FFT 
	
	constant dyn_beeld_start_X: integer RANGE 0 to 640 := 46;
	constant dyn_beeld_einde_X: integer RANGE 0 to 640 := 524;
	constant dyn_beeld_start_Y: integer RANGE 0 to 480 := 69;
	constant dyn_beeld_einde_Y: integer RANGE 0 to 480 := 411;
	
	signal s_ENA_dyn_beeld: std_logic := '0';

begin

	s_ENA_dyn_beeld <= 	'1' when(	X > dyn_beeld_start_X AND
									X < dyn_beeld_einde_X AND
									Y > dyn_beeld_start_Y AND
									Y < dyn_beeld_einde_Y	)
							else
						'0';
						
	ENA_dyn_beeld <= s_ENA_dyn_beeld;
						
	ENA_stat_beeld <= 	'1' when(	Active_video = '1' 	AND
									s_ENA_dyn_beeld = '0'	)
							else
						'0';

end Behavioral;
