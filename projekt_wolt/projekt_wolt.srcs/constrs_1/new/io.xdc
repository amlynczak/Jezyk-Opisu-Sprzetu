set_property PACKAGE_PIN W12 [get_ports {CS}];  # "JB1"
set_property PACKAGE_PIN W11 [get_ports {sdi}];  # "JB2"
set_property PACKAGE_PIN V10 [get_ports {sdi2}];  # "JB3"
set_property PACKAGE_PIN W8 [get_ports {sclk}];  # "JB4"

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];