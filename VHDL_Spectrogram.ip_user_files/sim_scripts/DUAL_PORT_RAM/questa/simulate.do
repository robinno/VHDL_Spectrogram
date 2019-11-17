onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DUAL_PORT_RAM_opt

do {wave.do}

view wave
view structure
view signals

do {DUAL_PORT_RAM.udo}

run -all

quit -force
