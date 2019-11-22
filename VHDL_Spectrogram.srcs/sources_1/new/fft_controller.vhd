----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/07/2019 10:17:51 AM
-- Design Name: 
-- Module Name: fft_controller - Behavioral
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

entity fft_controller is
	generic(
		transform_length: integer := 2048;
		blk_exp_length : integer := 5;
		din_width : integer := 24;
		tdata_width : integer := 48
	);
	Port (
		clk : in STD_LOGIC;
		counter : in integer range 0 to transform_length-1;
		din : in STD_LOGIC_VECTOR(din_width-1 downto 0);
		din_valid : in STD_LOGIC;
		dout : out STD_LOGIC_VECTOR(din_width-1 downto 0);
		dout_valid : out STD_LOGIC; --Asserted when able to provide sample data
		dout_last : out STD_LOGIC; --Asserted on the last sample of the frame.
		blk_exp : out integer range 0 to (2**blk_exp_length - 1) --represents the total number of bits the data was scaled during the transform
	);
end fft_controller;

architecture Behavioral of fft_controller is

	COMPONENT fft_ip
	  PORT (
		aclk : IN STD_LOGIC;
		aresetn : IN STD_LOGIC;
		s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axis_config_tvalid : IN STD_LOGIC;
		s_axis_config_tready : OUT STD_LOGIC;
		s_axis_data_tdata : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
		s_axis_data_tvalid : IN STD_LOGIC;
		s_axis_data_tready : OUT STD_LOGIC;
		s_axis_data_tlast : IN STD_LOGIC;
		m_axis_data_tdata : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
		m_axis_data_tuser : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		m_axis_data_tvalid : OUT STD_LOGIC;
		m_axis_data_tlast : OUT STD_LOGIC;
		m_axis_status_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		m_axis_status_tvalid : OUT STD_LOGIC;
		event_frame_started : OUT STD_LOGIC;
		event_tlast_unexpected : OUT STD_LOGIC;
		event_tlast_missing : OUT STD_LOGIC;
		event_data_in_channel_halt : OUT STD_LOGIC
	  );
	END COMPONENT;

--	COMPONENT fft_ip
--	  PORT (
--		aclk : IN STD_LOGIC;
--		aresetn : IN STD_LOGIC;
--		s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --FWD_INV (bit0) '1' => forward fft
--		s_axis_config_tvalid : IN STD_LOGIC; --Asserted by the external master to signal that it is able to provide data.
--		s_axis_config_tready : OUT STD_LOGIC; --Asserted by the core to signal that it is able to accept data.
--		s_axis_data_tdata : IN STD_LOGIC_VECTOR(tdata_width-1 DOWNTO 0); --input data
--		s_axis_data_tvalid : IN STD_LOGIC;   --Asserted by the upstream master to signal it is able to provide data (redundant)
--		s_axis_data_tready : OUT STD_LOGIC; --Used by the core to signal that it is ready to accept data
--		s_axis_data_tlast : IN STD_LOGIC; --Asserted by the upstream master on the last sample of the frame
--		m_axis_data_tdata : OUT STD_LOGIC_VECTOR(tdata_width-1 DOWNTO 0);--output data
--		m_axis_data_tuser : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --BLk_EXP (bit 4 downto 0 type uint5)
--		m_axis_data_tvalid : OUT STD_LOGIC; --Asserted by the core to signal that it is able to provide sample data 
--		m_axis_data_tlast : OUT STD_LOGIC; --Asserted  by the core on the last sample of the frame 
--		m_axis_status_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);--BLk_EXP			(redundant)
--		m_axis_status_tvalid : OUT STD_LOGIC; --Asserted by the core to signal that it is able to provide status data
--		event_frame_started : OUT STD_LOGIC;
--		event_tlast_unexpected : OUT STD_LOGIC;
--		event_tlast_missing : OUT STD_LOGIC;
--		event_data_in_channel_halt : OUT STD_LOGIC
--	  );
--	END COMPONENT;
	
	--Signals for fft_ip
    signal s_aresetn :  STD_LOGIC := '1';
    signal s_s_axis_tvalid :  STD_LOGIC := '0'; --connected to 's_axis_config_tvalid' and 's_axis_data_tvalid'
    signal s_s_axis_tready :  STD_LOGIC; --connected to 's_axis_config_tready' and 's_s_axis_data_tready'
    --signal s_s_axis_data_tdata :  STD_LOGIC_VECTOR(47 DOWNTO 0);
    signal s_s_axis_data_tlast :  STD_LOGIC;
    --signal s_m_axis_data_tdata :  STD_LOGIC_VECTOR(47 DOWNTO 0);
    signal s_m_axis_data_tuser :  STD_LOGIC_VECTOR(7 downto 0);
    --signal s_m_axis_data_tvalid :  STD_LOGIC;
    --signal s_m_axis_data_tlast :  STD_LOGIC;
    --signal s_m_axis_status_tdata :  STD_LOGIC_VECTOR(7 DOWNTO 0);
    --signal s_m_axis_status_tvalid :  STD_LOGIC;
    --signal s_event_frame_started :  STD_LOGIC;
    signal s_event_tlast_unexpected :  STD_LOGIC;
    signal s_event_tlast_missing :  STD_LOGIC;
    signal s_event_data_in_channel_halt :  STD_LOGIC;
	
	--other signals and constants
	constant c_s_axis_config_tdata : STD_LOGIC_VECTOR(7 downto 0) := x"01";
	constant ZEROPADDING : STD_LOGIC_VECTOR(din_width-1 downto 0) := (others=>'0');
	signal s_dout : STD_LOGIC_VECTOR(tdata_width-1 downto 0);
	--states of state machine
	type state_type is (SOF, MOF, EOF, INIT, ERROR_1, ERROR_2);
	signal state: state_type := INIT;
	
begin
	INST_fft_ip : fft_ip
	  PORT MAP (
		aclk => clk,
		aresetn => s_aresetn,
		s_axis_config_tdata => c_s_axis_config_tdata,
		s_axis_config_tvalid => s_s_axis_tvalid,
		s_axis_config_tready => s_s_axis_tready,
		s_axis_data_tdata => ZEROPADDING & din, --padded with zeros
		s_axis_data_tvalid => s_s_axis_tvalid,
		s_axis_data_tready => open,
		s_axis_data_tlast => s_s_axis_data_tlast,
		m_axis_data_tdata => s_dout,
		m_axis_data_tuser => s_m_axis_data_tuser,
		m_axis_data_tvalid => dout_valid,
		m_axis_data_tlast => dout_last,
		m_axis_status_tdata => open,
		m_axis_status_tvalid => open,
		event_frame_started => open,
		event_tlast_unexpected => s_event_tlast_unexpected,
		event_tlast_missing => s_event_tlast_missing,
		event_data_in_channel_halt => s_event_data_in_channel_halt
	  );	
	
	blk_exp <= to_integer(unsigned(s_m_axis_data_tuser(blk_exp_length-1 downto 0) ));--leave unused bits open
	dout <= s_dout(dout'left downto 0); --leave imaginary part open
	  
	process(clk) --process for state transitions
	begin
		if(rising_edge(clk)) then
			case state is
				when INIT =>
					if(counter = transform_length -1 and s_s_axis_tready = '1' and din_valid = '1') then --core ready for data and next sample is a new frame
						state <= SOF;
					else
						state <= INIT;
					end if;
				when SOF =>
					if(s_event_tlast_missing = '0' and s_event_tlast_unexpected = '0' and s_event_data_in_channel_halt = '0' and din_valid = '1') then --no errors
						state <= MOF;
					else --some error happened so go back to INIT state
						state <= ERROR_1;
					end if;
				when MOF =>
					if(din_valid = '0' or s_event_tlast_unexpected = '1' or s_event_data_in_channel_halt = '1') then --error occured
						state <= ERROR_1;
					elsif(counter = transform_length - 2) then --next sample is last sample of the frame
						state <= EOF;
					else -- next sample is not the last sample
						state <= MOF;
					end if;
				when EOF =>
					if( din_valid = '0' or s_event_data_in_channel_halt = '1') then --error occured
						state <= ERROR_1;
					else --no error has occured
						state <= SOF;
					end if;
				when ERROR_1 => --first error clk cycle
					state <= ERROR_2;
				when ERROR_2 => --second error clk cycle
					state <= INIT;
				when others =>
					state <= ERROR_1;
			end case;
		end if;
	end process;
	
	process(state) --process for outputs according to state
	begin
		case state is
			when INIT =>
				s_s_axis_tvalid <= '0';
				s_s_axis_data_tlast <= '0';
				s_aresetn <= '1';
			when SOF =>
				s_s_axis_tvalid <= '1';
				s_s_axis_data_tlast <= '0';
				s_aresetn <= '1';
			when MOF =>
				s_s_axis_tvalid <= '1';
				s_s_axis_data_tlast <= '0';
				s_aresetn <= '1';
			when EOF =>
				s_s_axis_tvalid <= '1';
				s_s_axis_data_tlast <= '1';
				s_aresetn <= '1';
			when ERROR_1 => 
				s_s_axis_tvalid <= '0';
				s_s_axis_data_tlast <= '0';
				s_aresetn <= '0'; --reset requires 2 cycles. This is the first one.
			when ERROR_2 =>
				s_s_axis_tvalid <= '0';
				s_s_axis_data_tlast <= '0';
				s_aresetn <= '0'; --reset requires 2 cycles. This is the second one.
		end case;
	end process;
	


end Behavioral;
