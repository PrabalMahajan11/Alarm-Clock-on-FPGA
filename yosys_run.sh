read_verilog iiitb_clockfpga.v
hierarchy -check -top iiitb_clockfpga
abc -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
clean
write_verilog -noattr iiitb_clockfpga_synth.v