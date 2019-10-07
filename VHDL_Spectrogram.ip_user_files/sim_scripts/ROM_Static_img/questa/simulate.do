onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ROM_Static_img_opt

do {wave.do}

view wave
view structure
view signals

do {ROM_Static_img.udo}

run -all

quit -force
