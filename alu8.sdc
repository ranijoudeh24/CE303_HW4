create_clock -name VCLK -period 1.000
set_input_delay  0.000 -clock VCLK [get_ports {a[*] b[*] F[*]}]
set_output_delay 0.000 -clock VCLK [get_ports {Q[*] Cout}]
