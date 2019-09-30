----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2019 10:13:12
-- Design Name: 
-- Module Name: VGA_driver - Behavioral
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

entity VGA_driver is --gekozen voor 640 x 400
    Port (	clk : in STD_LOGIC;

			Flag_Active_Video: out STD_LOGIC;
			LineCount: out integer range 0 to 525; 	--verticale positie
			PixelCount: out integer range 0 to 800;	--horizontale positie
			
			Vsync : out STD_LOGIC;
			Hsync : out STD_LOGIC);
end VGA_driver;

architecture Behavioral of VGA_driver is

begin

	process(clk)
		variable HTeller : integer range 0 to 800 := 0; 		--horizontale positie
		variable VTeller : integer range 0 to 525 := 0; 		--vericale positie
	begin
		
		if(rising_edge(clk)) then
			
			--update HTeller & VTeller
			
			HTeller := HTeller + 1;
			
			if(HTeller >= 800) then
				HTeller := 0;
				VTeller := VTeller + 1;
			end if;
			
			if(VTeller >= 525) then
				VTeller := 0;
			end if;
			
			
			--genereren signalen:
			
			case Hteller is 
				when 656 to 751 => 	Hsync <= '0'; --case: hij neemt de bovenste grens ook mee 
				when others => 		Hsync <= '1';
			end case;
			
			case Vteller is 
				when 490 to 491 => 	Vsync <= '0';
				when others  => 	Vsync <= '1';
			end case;

			--active video?
			if ( HTeller < 640 and VTeller < 480 ) then
				Flag_Active_Video <= '1';
			else
				Flag_Active_Video <= '0';
			end if;

		end if;
		
		PixelCount <= HTeller;
		LineCount <= VTeller;
	end process;

end Behavioral;
