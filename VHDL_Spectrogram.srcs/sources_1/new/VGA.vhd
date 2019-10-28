----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 11:10:23
-- Design Name: 
-- Module Name: VGA - Behavioral
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

entity VGA is
    Port ( clk: in std_logic;
	
		   Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           r_out : out STD_LOGIC_VECTOR (3 downto 0);
           g_out : out STD_LOGIC_VECTOR (3 downto 0);
           b_out : out STD_LOGIC_VECTOR (3 downto 0);
			
		   RAM_addr_VGA : out integer range 0 to 262143;
		   RAM_data_VGA : in integer range 0 to 15
		   );
end VGA;

architecture Behavioral of VGA is

	component VGA_controller is
		Port (	clk: in std_logic;
		
				Y: in integer RANGE 0 TO 525; --positions on screen;
				X: in integer RANGE 0 TO 800;
				Active_video: in std_logic;
			
				RAM_addr_VGA : out integer range 0 to 262143;
				RAM_data_VGA : in integer range 0 to 15;
			
				output_greyscale: out STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component VGA_driver is --gekozen voor 640 x 400
		Port (	clk : in STD_LOGIC;

				Flag_Active_Video: out STD_LOGIC;
				LineCount: out integer range 0 to 525; 	--verticale positie
				PixelCount: out integer range 0 to 800;	--horizontale positie
				
				Vsync : out STD_LOGIC;
				Hsync : out STD_LOGIC);
	end component;

	signal s_Flag_Active_Video: std_logic := '0';
	signal s_X : integer range 0 to 800 := 0;
	signal s_Y : integer range 0 to 525 := 0;
	
	signal grey_out: std_logic_vector(3 downto 0) := "0000";

begin

	VGA_driver_inst: VGA_driver
		port map (
			clk => clk,

			Flag_Active_Video => s_Flag_Active_Video,
			LineCount => s_Y, 	--verticale positie
			PixelCount => s_X,	--horizontale positie
			
			Vsync => Vsync,
			Hsync => Hsync
		);
		
	VGA_controller_inst: VGA_controller
		port map(
			clk => clk,
	
			Y => s_Y, --positions on screen;
			X => s_X,
			Active_video => s_Flag_Active_Video,
			
			RAM_addr_VGA => RAM_addr_VGA,
			RAM_data_VGA => RAM_data_VGA,
		
			output_greyscale => grey_out
		);
	
	r_out <= grey_out;
	g_out <= grey_out;
	b_out <= grey_out;

end Behavioral;
