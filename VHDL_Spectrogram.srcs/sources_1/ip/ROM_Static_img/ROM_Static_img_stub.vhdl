-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Oct  7 10:54:56 2019
-- Host        : LAPTOP-69E4OMV9 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {d:/Ing/Master
--               1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/ROM_Static_img/ROM_Static_img_stub.vhdl}
-- Design      : ROM_Static_img
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROM_Static_img is
  Port ( 
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 17 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end ROM_Static_img;

architecture stub of ROM_Static_img is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,addra[17:0],douta[3:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_3,Vivado 2019.1";
begin
end;
