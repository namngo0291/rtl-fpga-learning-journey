## =========================================================
## EBAZ4205 + HELLOFPGA Expansion Board
## Project: 3-bit Up/Down Counter Demo
## Clock: N18 external 50 MHz oscillator
## Reset: KEY1 / T19
## Direction: KEY2 / P19
## Pause: KEY3 / U20
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

## KEY2 direction control
set_property PACKAGE_PIN P19 [get_ports dir_key2_n]
set_property IOSTANDARD LVCMOS33 [get_ports dir_key2_n]
set_property PULLUP true [get_ports dir_key2_n]

## KEY3 pause control
set_property PACKAGE_PIN U20 [get_ports pause_key3_n]
set_property IOSTANDARD LVCMOS33 [get_ports pause_key3_n]
set_property PULLUP true [get_ports pause_key3_n]

## LED outputs
set_property PACKAGE_PIN H18 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]

set_property PACKAGE_PIN K17 [get_ports led2]
set_property IOSTANDARD LVCMOS33 [get_ports led2]

set_property PACKAGE_PIN E19 [get_ports led3]
set_property IOSTANDARD LVCMOS33 [get_ports led3]
