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
	
		VGA_X: in integer range 0 to 1056;
		VGA_Y: in integer range 0 to 628;
		active_video: in std_logic;
		VGA_R: out std_logic_vector(3 downto 0);
		VGA_G: out std_logic_vector(3 downto 0);
		VGA_B: out std_logic_vector(3 downto 0);
		
		new_sample_entry: in std_logic --TODO
	);
end mem_interface_beeld;

architecture Behavioral of mem_interface_beeld is
	
	COMPONENT DUAL_PORT_RAM
		PORT (
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
			clkb : IN STD_LOGIC;
			addrb : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
			doutb : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;
	
	--array voor vertaling kleur in geheugen naar effectief kleur:
	type kleurArray_type is array (0 to 75) of std_logic_vector(11 downto 0);
	signal kleurArray : kleurArray_type := (0x"000",
											0x"001",
											0x"002",
											0x"003",
											0x"004",
											0x"005",
											0x"006",
											0x"007",
											0x"008",
											0x"009",
											0x"00a",
											0x"00b",
											0x"00c",
											0x"00d",
											0x"00e",
											0x"00f",
											0x"10f",
											0x"20f",
											0x"30f",
											0x"40f",
											0x"50f",
											0x"60f",
											0x"70f",
											0x"80f",
											0x"90f",
											0x"a0f",
											0x"b0f",
											0x"c0f",
											0x"d0f",
											0x"e0f",
											0x"f0f",
											0x"f0e",
											0x"f0d",
											0x"f0c",
											0x"f0b",
											0x"f0a",
											0x"f09",
											0x"f08",
											0x"f07",
											0x"f06",
											0x"f05",
											0x"f04",
											0x"f03",
											0x"f02",
											0x"f01",
											0x"f00",
											0x"f10",
											0x"f20",
											0x"f30",
											0x"f40",
											0x"f50",
											0x"f60",
											0x"f70",
											0x"f80",
											0x"f90",
											0x"fa0",
											0x"fb0",
											0x"fc0",
											0x"fd0",
											0x"fe0",
											0x"ff0",
											0x"ff1",
											0x"ff2",
											0x"ff3",
											0x"ff4",
											0x"ff5",
											0x"ff6",
											0x"ff7",
											0x"ff8",
											0x"ff9",
											0x"ffa",
											0x"ffb",
											0x"ffc",
											0x"ffd",
											0x"ffe",
											0x"fff");
	
	signal LeesAdres: std_logic_vector(18 downto 0) := (others => '0');
	signal LeesData: std_logic_vector(6 downto 0) := (others => '0');
	
	signal RGB: std_logic_vector(11 downto 0) := (others => '0');
begin

	LeesAdres <= 	std_logic_vector(to_unsigned(VGA_Y * 800 + VGA_X, 19)) when active_video = '1' else
					(others => '0');
					
	RGB <= 			kleurArray(LeesData) when active_video = '1' else
					(others => '0');
					
	VGA_R <= RGB(11 downto 8);
	VGA_G <= RGB(7 downto 4);
	VGA_B <= RGB(3 downto 0);


	-- DUAL_PORT_RAM_inst: DUAL_PORT_RAM
		-- port map(
			-- --TODO
			-- clka : IN STD_LOGIC;
			-- wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			-- addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
			-- dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			-- clkb => VGA_clk,
			-- addrb => LeesAdres,
			-- doutb => LeesData
		-- );

end Behavioral;
