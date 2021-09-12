sim: simv_gen
	./output/simv -l ./output/sim.log +fsdb+all 

simv_gen: 
	vcs -assert svaext+checker -sverilog -licqueue '-timescale=1ns/1ns' '+vcs+flush+all' '+warn=all' '-debug_access+all' '-kdb' '-sv' -l ./output/compile.log +incdir+./tb +incdir+./rtl +incdir+./interface +incdir+./tests +incdir+./seq ./rtl/async_fifo.sv fifo_pkg.sv top.sv
	mv simv ./output
	mv simv.daidir ./output

clean: 
	rm -rf output/*

all: clean sim
	
