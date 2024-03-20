set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK"

set_property PACKAGE_PIN P16 [get_ports {start}];  # "BTNC"
set_property PACKAGE_PIN R16 [get_ports {rst}];  # "BTND"

set_property PACKAGE_PIN T22 [get_ports {leds[0]}];  # "leds[]0"
set_property PACKAGE_PIN T21 [get_ports {leds[1]}];  # "leds[]1"
set_property PACKAGE_PIN U22 [get_ports {leds[2]}];  # "leds[]2"
set_property PACKAGE_PIN U21 [get_ports {leds[3]}];  # "leds[]3"
set_property PACKAGE_PIN V22 [get_ports {leds[4]}];  # "leds[]4"
set_property PACKAGE_PIN W22 [get_ports {leds[5]}];  # "leds[]5"
set_property PACKAGE_PIN U19 [get_ports {leds[6]}];  # "leds[]6"
set_property PACKAGE_PIN U14 [get_ports {leds[7]}];  # "leds[]7"

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];

set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];