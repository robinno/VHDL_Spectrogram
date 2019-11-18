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
use IEEE.NUMERIC_STD.ALL;

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

	component Beeld is
		Port ( 
			VGA_clk: in std_logic;
		
			VGA_Vsync: out std_logic;
			VGA_Hsync: out std_logic;
			VGA_R: out std_logic_vector(3 downto 0);
			VGA_G: out std_logic_vector(3 downto 0);
			VGA_B: out std_logic_vector(3 downto 0);
			
			new_sample_entry: in std_logic --input of data: TODO
		);
	end component;
	
	
	signal VGA_clk: std_logic;
	signal VGA_grey: std_logic_vector(3 downto 0);
	
	
	signal new_fft_output_entry: std_logic; --TODO
begin
	
	
	clk_deler : clk_wiz_0
		port map ( 
			-- Clock out ports  
		   clk_out1 => open,
		   clk_out2 => VGA_clk,
		   -- Clock in ports
		   clk_in1 => sys_clk
		);

	Beeld_inst: Beeld
		port map(
			VGA_clk => VGA_clk,
		
			VGA_Vsync => VGA_Vsync,
			VGA_Hsync => VGA_Hsync,
			VGA_grey => VGA_grey,
			
			new_sample_entry => new_fft_output_entry--input of data: TODO
		);
	  
	VGA_r_out <= VGA_grey;
	VGA_g_out <= VGA_grey;
	VGA_b_out <= VGA_grey;
	
end Behavioral;
