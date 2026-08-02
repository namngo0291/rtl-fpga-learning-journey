## =========================================================
## EBAZ4205 + HELLOFPGA Expansion Board
## Project: Clock Enable Demo
## Clock: N18 external 50 MHz oscillator
## Reset: KEY1 / T19
## LEDs: H18, K17, E19
## =========================================================

## External 50 MHz oscillator input
set_property PACKAGE_PIN N18 [get_ports clk_50m_n18]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50m_n18]
create_clock -period 20.000 -name clk_50m_n18 [get_ports clk_50m_n18]

## KEY1 active-low reset
set_property PACKAGE_PIN T19 [get_ports rst_n_key1]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n_key1]
set_property PULLUP true [get_ports rst_n_key1]

## LED outputs
set_property PACKAGE_PIN H18 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]

set_property PACKAGE_PIN K17 [get_ports led2]
set_property IOSTANDARD LVCMOS33 [get_ports led2]

set_property PACKAGE_PIN E19 [get_ports led3]
set_property IOSTANDARD LVCMOS33 [get_ports led3]
