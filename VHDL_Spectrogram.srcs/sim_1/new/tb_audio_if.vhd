----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2019 12:58:32
-- Design Name: 
-- Module Name: tb_audio_if - Behavioral
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

entity tb_audio_if is
--  Port ( );
end tb_audio_if;

architecture Behavioral of tb_audio_if is

component audio_if
	Port (
		clk_100M_in : in std_logic;
		s_clk_12M288 : in std_logic;

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

signal tclk_100M_in, ts_clk_12M288, tm_clk, tlr_clk, tb_clk : std_logic;
signal tsdata, tsda, tscl : std_logic;
signal ti2c_addr :std_logic_vector(1 downto 0);
signal tsample_clk, tsdata_out : std_logic;
signal tsample_l, tsample_r, tsample_l_in, tsample_r_in : std_logic_vector(23 downto 0);

begin

tb_audioif : audio_if
port map(clk_100M_in => tclk_100M_in,
		 s_clk_12M288 => ts_clk_12M288,
		 m_clk => tm_clk,
		 lr_clk => tlr_clk,
		 b_clk => tb_clk,
		 sdata => tsdata,
		 sda => tsda,
		 scl => tscl,
		 i2c_addr => ti2c_addr,
		 sample_clk => tsample_clk,
		 sample_l => tsample_l,
		 sample_r => tsample_r,
		 sample_l_in => tsample_l_in,
		 sample_r_in => tsample_r_in,
		 sdata_out => tsdata_out);
		 
tsample_l <= tsample_l_in;
tsample_r <= tsample_r_in;

process
begin
	tclk_100M_in <= '0';
	wait for 100ns;
	tclk_100M_in <= '1';
	wait for 100ns;
end process;

process
begin
	ts_clk_12M288 <= '0';
	wait for 12ns;
	ts_clk_12M288 <= '1';
	wait for 12ns;
end process;

process
begin
	wait for 50ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '0';
	wait for 100ns;
	tsdata <= '1';
	wait for 100ns;
	tsdata <= '1';
	
end process;

end Behavioral;
