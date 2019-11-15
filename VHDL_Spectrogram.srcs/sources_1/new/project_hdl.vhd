----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2019 10:45:08
-- Design Name: 
-- Module Name: project_hdl - Behavioral
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

entity project_hdl is
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
        sdata_out: out std_logic
	);
end project_hdl;

architecture Behavioral of project_hdl is

	component audio_if
		port(
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
        sdata_out: out std_logic
		);
		end component;

	signal sig_sample_l, sig_sample_r : std_logic_vector(23 downto 0);
	signal sig_sample_l_in, sig_sample_r_in : std_logic_vector(23 downto 0);

begin

	audio_if_inst : audio_if
		port map(
			clk_100M_in => clk_100M_in,
			
			m_clk => m_clk,
			lr_clk => lr_clk,
			b_clk => b_clk,
			sdata => sdata,
			sda => sda,
			scl => scl,
			i2c_addr => i2c_addr,
			
			sample_clk => sample_clk,
			sample_l => sig_sample_l,
			sample_r => sig_sample_r,
			sample_l_in => sig_sample_l_in,
			sample_r_in => sig_sample_r_in,
			sdata_out => sdata_out			
		);
		
	sig_sample_l <= sig_sample_l_in;
	sig_sample_r <= sig_sample_r_in;

end Behavioral;
