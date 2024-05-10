# ----------------------------------------------------------------------------
# OLED Display - Bank 13
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN U10  [get_ports {DC}];  # "OLED-DC"        data/command
set_property PACKAGE_PIN U9   [get_ports {RES}];  # "OLED-RES"      Power Reset for Controller and Driver
set_property PACKAGE_PIN AB12 [get_ports {SCLK}];  # "OLED-SCLK"    serial clock
set_property PACKAGE_PIN AA12 [get_ports {SDIN}];  # "OLED-SDIN"    serial data
set_property PACKAGE_PIN U11  [get_ports {VBAT}];  # "OLED-VBAT"    Power Supply for DC/DC Converter Circuit
set_property PACKAGE_PIN U12  [get_ports {VDD}];  # "OLED-VDD"      Power Supply for Logic
#CS pulldown
#set_property PACKAGE_PIN Y11  [get_ports {CS}];  # "JA1"

# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN Y9 [get_ports {CLK}];  # "GCLK"

# Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard. 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN P16 [get_ports {RST}];  # "BTNC"

# Set the bank voltage for IO Bank 34 to 1.8V by default.
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
