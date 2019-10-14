# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 2
set_param synth.incrementalSynthesisCache C:/Users/robin/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-9824-LAPTOP-69E4OMV9/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.cache/wt} [current_project]
set_property parent.project_path {D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property ip_output_repo {d:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/new/VGA_controller.vhd}
  {D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/new/VGA_driver.vhd}
  {D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/new/VGA.vhd}
  {D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/new/top.vhd}
}
read_ip -quiet {{D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}
set_property used_in_implementation false [get_files -all {{d:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{d:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}]
set_property used_in_implementation false [get_files -all {{d:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}]

read_ip -quiet {{D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/ROM_Static_img/ROM_Static_img.xci}}
set_property used_in_implementation false [get_files -all {{d:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/sources_1/ip/ROM_Static_img/ROM_Static_img_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/constrs_1/new/pinlayout.xdc}}
set_property used_in_implementation false [get_files {{D:/Ing/Master 1sem/Digitale/VHDL_Spectrogram/VHDL_Spectrogram.srcs/constrs_1/new/pinlayout.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7z020clg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
