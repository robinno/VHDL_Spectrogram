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
		VGA_b_out : out STD_LOGIC_VECTOR (3 downto 0);
		
		--audiocodec
		i2c_addr : out std_logic_vector(1 downto 0);
		m_clk : out std_logic;
		b_clk : out std_logic;
		lr_clk : out std_logic;
		sdata : in std_logic;
		sdata_out : out std_logic;
		sda : out std_logic;
		scl : out std_logic;
		clk_in : in std_logic
	);
end top;

architecture Behavioral of top is

	component clk_wiz_0
		port
			(-- Clock in ports
			-- Clock out ports
			clk_out1          : out    std_logic;
			clk_out2          : out    std_logic;
			clk_12M288          : out    std_logic;
			-- Status and control signals
			reset             : in     std_logic;
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
	
	component audio_if is
		Port(
		clk_100M_in : in std_logic;

		-- adau1761 interface signals
		m_clk : out std_logic;
		lr_clk : out std_logic;
		b_clk : out std_logic;
		sdata : in std_logic;
		sda : out std_logic;
		scl : out std_logic;
		i2c_addr : out std_logic_vector(1 downto 0);


		-- audio output interface
		sample_clk : out std_logic;
		sample_l : out std_logic_vector(23 downto 0);
		sample_r : out std_logic_vector(23 downto 0);

        sample_l_in: in std_logic_vector (23 downto 0);
        sample_r_in: in std_logic_vector (23 downto 0);
        sdata_out: out std_logic);
	end component;
	
	
	signal VGA_clk: std_logic;
	signal VGA_grey: std_logic_vector(3 downto 0);
	
	signal sample_clk : std_logic;
	signal sample_l, sample_r, sample_l_in, sample_r_in : std_logic_vector(23 downto 0);
	
	signal new_fft_output_entry: std_logic; --TODO
begin
	
	
	clk_deler : clk_wiz_0
		port map ( 
			-- Clock out ports  
			clk_out1 => clk_out1,
			clk_out2 => clk_out2,
			clk_12M288 => clk_12M288,
			-- Status and control signals                
			reset => reset,
			-- Clock in ports
			clk_in1 => clk_in1
		);

	Beeld_inst: Beeld
		port map(
			VGA_clk => VGA_clk,
		
			VGA_Vsync => VGA_Vsync,
			VGA_Hsync => VGA_Hsync,
			VGA_grey => VGA_grey,
			
			new_sample_entry => new_fft_output_entry--input of data: TODO
		);
		
	Audio_inst: audio_if
		port map(
		clk_100M_in => clk_in,
		m_clk => m_clk,
		lr_clk => lr_clk,
		b_clk => b_clk,
		sdata => sdata,
		sda => sda,
		scl => scl,
		i2c_addr => i2c_addr,
		sample_clk => sample_clk,
		sample_l => sample_l,
		sample_r => sample_r,
		sample_l_in => sample_l,
		sample_r_in => sample_r,
		sdata_out => sdata_out);
	  
	VGA_r_out <= VGA_grey;
	VGA_g_out <= VGA_grey;
	VGA_b_out <= VGA_grey;
	
end Behavioral;
