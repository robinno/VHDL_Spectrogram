----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2019 14:00:36
-- Design Name: 
-- Module Name: mem_interface_beeld - Behavioral
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

entity mem_interface_beeld is
	Port ( 
		VGA_clk: in std_logic;
	
		VGA_X: in integer range 0 to 800;
		VGA_Y: in integer range 0 to 525;
		active_video: in std_logic;
		grey_out: out std_logic_vector(3 downto 0);
		
		--TODO
		sample_clk: in std_logic;
		new_sample_entry: in std_logic_vector(3 downto 0)
		
	);
end mem_interface_beeld;

architecture Behavioral of mem_interface_beeld is
	
	COMPONENT DUAL_PORT_RAM
		PORT (
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			clkb : IN STD_LOGIC;
			addrb : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
			doutb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	
	signal LeesAdres: std_logic_vector(18 downto 0) := (others => '0');
	signal LeesData: std_logic_vector(3 downto 0) := (others => '0');
	
	--TODO
	signal wea: std_logic_vector(0 downto 0) := (others => '0');
	signal schrijfadres: std_logic_vector(18 downto 0) := (others => '0');
begin


	--READING signals
	process(VGA_clk)
	begin
		if rising_edge(VGA_clk) then
			if active_video = '1' then
				LeesAdres 	<= std_logic_vector(to_unsigned(VGA_Y * 640 + VGA_X, 19));
				grey_out 	<= leesData;
			else
				LeesAdres 	<= (others => '0');
				grey_out 	<= (others => '0');
			end if;
		end if;
	end process;

	DUAL_PORT_RAM_inst: DUAL_PORT_RAM
		port map(
			--TODO
			clka => sample_clk,
			wea => wea,
			addra => schrijfadres,
			dina => new_sample_entry,			
			
			clkb => VGA_clk,
			addrb => LeesAdres,
			doutb => LeesData
		);

end Behavioral;
