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
			b_out : out STD_LOGIC_VECTOR (3 downto 0);
			
			RAM_addr_VGA : out integer range 0 to 262144;
			RAM_data_VGA : in integer range 0 to 15
		);
	end component;
	
	COMPONENT DUAL_PORT_RAM
	  PORT (
		clka : IN STD_LOGIC;
		wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clkb : IN STD_LOGIC;
		addrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal clk_VGA: std_logic := '0';
	signal RAM_addr_VGA: integer range 0 to 262144 := 0;
	signal RAM_data_VGA: integer range 0 to 15 := 0;

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
			b_out => VGA_b_out,
			
			RAM_addr_VGA => RAM_addr_VGA,
			RAM_data_VGA => RAM_data_VGA
		);

	DUAL_PORT_RAM_INST : DUAL_PORT_RAM
	  PORT MAP (
		--ports A: writing from FFT
		clka => sysclk,
		wea => '0',
		addra => open,
		dina => open,
		
		--ports B: reading from VGA
		clkb => clk_VGA,
		addrb => RAM_addr_VGA,
		doutb => RAM_data_VGA
	  );
	  
end Behavioral;
