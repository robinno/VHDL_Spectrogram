----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 11:20:29
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
	Port ( 
		sys_clk: in std_logic;
		
		VGA_Hsync : out STD_LOGIC;
		VGA_Vsync : out STD_LOGIC;
		VGA_r_out : out STD_LOGIC_VECTOR (3 downto 0);
		VGA_g_out : out STD_LOGIC_VECTOR (3 downto 0);
		VGA_b_out : out STD_LOGIC_VECTOR (3 downto 0)
		
	);
end top;

architecture Behavioral of top is

	component clk_wiz_0
		port(
			clk_out1          : out    std_logic;
			clk_out2          : out    std_logic;
			clk_in1           : in     std_logic
		);
	end component;
	
	component VGA is
		Port ( 
			clk: in std_logic;
		
			Hsync : out STD_LOGIC;
			Vsync : out STD_LOGIC;
			r_out : out STD_LOGIC_VECTOR (3 downto 0);
			g_out : out STD_LOGIC_VECTOR (3 downto 0);
			b_out : out STD_LOGIC_VECTOR (3 downto 0)
		);
	end component;
	
	signal clk_VGA: std_logic := '0';

begin

	clk_deler: clk_wiz_0
		port map(
			clk_in1 => sys_clk,
			clk_out1 => open,
			clk_out2 => clk_VGA
		);
	
	VGA_inst: VGA
		port map( 
			clk => clk_VGA,
		
			Hsync => VGA_Hsync,
			Vsync => VGA_Vsync,
			r_out => VGA_r_out,
			g_out => VGA_g_out,
			b_out => VGA_b_out
		);

end Behavioral;
