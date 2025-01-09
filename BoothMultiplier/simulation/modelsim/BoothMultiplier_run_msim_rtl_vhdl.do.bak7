transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Jayes/Desktop/PoLo/BoothMultiplier/BoothMultiplier.vhd}

vcom -93 -work work {C:/Users/Jayes/Desktop/PoLo/BoothMultiplier/TestBench_BoothMultiplier.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  TestBench_BoothMultiplier

add wave *
view structure
view signals
run -all
