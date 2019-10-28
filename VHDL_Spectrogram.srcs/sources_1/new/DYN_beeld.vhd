----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2019 11:00:10
-- Design Name: 
-- Module Name: DYN_beeld - Behavioral
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

entity DYN_beeld is
	Port ( 
		clk: in std_logic;
	
		X : in integer range 0 to 800;
		Y : in integer range 0 to 525;
		ENA: in std_logic;
		
		out_greyscale : out std_logic_vector(3 downto 0)
	);
end DYN_beeld;

architecture Behavioral of DYN_beeld is

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

begin
	--TODO
	out_greyscale <= 	"1001" when ENA = '1' else
						"0000";

	DUAL_PORT_RAM_INST : DUAL_PORT_RAM
	  PORT MAP (
		clka => clk,
		wea => '0',
		addra => open,
		dina => open,
		clkb => clk,
		addrb => addrb,
		doutb => doutb
	  );

end Behavioral;
