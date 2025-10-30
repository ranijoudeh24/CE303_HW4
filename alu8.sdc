# alu8.sdc — 1 ns combinational timing target for alu8
# SDC is Tcl-based; tools consume constraints like create_clock/set_*_delay. 
# We use a "virtual" clock to bound max datapath delay through the block.

# 1) Virtual clock of 1.000 ns period (tight homework target)
create_clock -name VCLK -period 1.000

# 2) Zero input/output delays relative to VCLK
#    (meaning: entire 1 ns is available for the internal path)
set_input_delay  0.000 -clock VCLK [get_ports {a[*] b[*] F[*]}]
set_output_delay 0.000 -clock VCLK [get_ports {Q[*] Cout}]

# (Optional) be explicit about units if your flow doesn't default to ns
# set_units -time ns
