----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2019 10:45:51
-- Design Name: 
-- Module Name: VGA_controller - Behavioral
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

entity VGA_controller is

	Port (	
		clk: in std_logic;
	
		Y: in integer RANGE 0 TO 525; --positions on screen;
		X: in integer RANGE 0 TO 800;
		Active_video: in std_logic;
		
		RAM_addr_VGA : out integer range 0 to 262144;
		RAM_data_VGA : in integer range 0 to 15;
	
		output_greyscale: out STD_LOGIC_VECTOR (3 downto 0)
	);
			
end VGA_controller;

architecture Behavioral of VGA_controller is
	
	component DYN_beeld is
		Port ( 
			clk: in std_logic;
		
			X : in integer range 0 to 800;
			Y : in integer range 0 to 525;
			ENA: in std_logic;
			
			out_greyscale : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component STAT_beeld is
		Port ( 
			clk: in std_logic;
		
			X : in integer range 0 to 800;
			Y : in integer range 0 to 525;
			ENA: in std_logic;
			
			out_greyscale : out std_logic_vector(3 downto 0)
		);
	end component;
	
	constant dyn_beeld_start_X: integer RANGE 0 to 640 := 48;
	constant dyn_beeld_einde_X: integer RANGE 0 to 640 := 526;
	constant dyn_beeld_start_Y: integer RANGE 0 to 480 := 69;
	constant dyn_beeld_einde_Y: integer RANGE 0 to 480 := 411;
	
	signal ENA_dyn_beeld : std_logic := '0';
	signal ENA_stat_beeld : std_logic := '0';
	signal s_stat_out : std_logic_vector(3 downto 0) := (others => '0');
	signal s_dyn_out : std_logic_vector(3 downto 0) := (others => '0');
begin
	
	--static beeld = de randen (blijven hetzelfde altijd)
	--dynamic beeld = het centrum: verandert (naar de hand van output van de FFT)
	
	--select welk beeld:
	ENA_dyn_beeld <= 	'1' when(	X > dyn_beeld_start_X AND
									X < dyn_beeld_einde_X AND
									Y > dyn_beeld_start_Y AND
									Y < dyn_beeld_einde_Y	)
							else
						'0';
						
	ENA_stat_beeld <= 	'1' when(	Active_video = '1' 	AND
									ENA_dyn_beeld = '0'	)
							else
						'0';
	
	
	DYN_beeld_INST : DYN_beeld
		port map(
			clk => clk,
		
			X => X,
			Y => Y,
			ENA => s_ENA_dyn_beeld,
			
			out_greyscale => s_dyn_out
		);
	
	STAT_beeld_INST : STAT_beeld
		port map(
			clk => clk,
		
			X => X,
			Y => Y,
			ENA => s_ENA_stat_beeld,
			
			out_greyscale => s_stat_out
		);
		
		
	--eigen output mux:
	output_greyscale <= s_stat_out 	when s_ENA_stat_beeld = '1' else
						s_dyn_out 	when s_ENA_dyn_beeld = '1' else
						"0000";
	
	-- process(clk)
	-- begin
		-- IF rising_edge(clk) THEN
			-- IF  Active_video = '1' THEN
				-- -- nu in actief gebied van het scherm
				-- case X is
					-- when 0 to dyn_beeld_start_X - 1 => 
						-- s_output_greyscale <= "0001";	
					-- when dyn_beeld_start_X to dyn_beeld_einde_X=> 
						-- case Y is
							-- when 0 to dyn_beeld_start_Y - 1 => 
								-- s_output_greyscale <= "1111";	
							-- when dyn_beeld_start_Y to dyn_beeld_einde_Y=>
							
							
								-- -- nu in dynamisch beeld gedeelte: TODO
								-- s_output_greyscale <= "0000";
							
							
							
							-- when dyn_beeld_einde_Y + 1 to 480 => 
								-- s_output_greyscale <= "1111";	
							-- when 481 to 525 =>
								-- s_output_greyscale <= "0000";
						-- end case;
					-- when dyn_beeld_einde_X + 1 to 640 => 
						-- s_output_greyscale <= "1000";	
					-- when 641 to 800 =>
						-- s_output_greyscale <= "0000";
				-- end case;
			
			-- else
				-- s_output_greyscale <= "0000";				
			-- end if;
		-- end if;
	-- end process;

	-- output_greyscale <= s_output_greyscale;


end Behavioral;
