----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2019 11:00:10
-- Design Name: 
-- Module Name: STAT_beeld - Behavioral
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

entity STAT_beeld is
	Port ( 
		clk: in std_logic;
	
		X : in integer range 0 to 800;
		Y : in integer range 0 to 525;
		ENA: in std_logic;
		
		out_greyscale : out std_logic_vector(3 downto 0)
	);
end STAT_beeld;

architecture Behavioral of STAT_beeld is

	COMPONENT ROM_Static_img
	  PORT (
		clka : IN STD_LOGIC;
		addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
		douta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal s_addr : std_logic_vector(18 downto 0) := (others => '0'); 
	
begin

	s_addr <= 	std_logic_vector(to_unsigned(Y * 640 + X, 19)) WHEN	ENA = '1' 	ELSE
				(others => '0');

	ROM_Static_img_INST: ROM_Static_img
		PORT MAP (
			clka => clk,
			addra => s_addr,
			douta => out_greyscale
		);

end Behavioral;
