// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Oct 27 10:33:28 2019
// Host        : LAPTOP-69E4OMV9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {D:/Ing/Master
//               1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/ROM_Static_img/ROM_Static_img_stub.v}
// Design      : ROM_Static_img
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module ROM_Static_img(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[17:0],douta[3:0]" */;
  input clka;
  input [17:0]addra;
  output [3:0]douta;
endmodule
