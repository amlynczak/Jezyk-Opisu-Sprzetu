set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK"

set_property PACKAGE_PIN P16 [get_ports {rst}];  # "BTNC"

set_property PACKAGE_PIN Y10  [get_ports {tx}];  # "JA3"
set_property PACKAGE_PIN AA9  [get_ports {rx}];  # "JA4"

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];