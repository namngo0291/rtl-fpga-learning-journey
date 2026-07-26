## =========================================================
## EBAZ4205 + HELLOFPGA Expansion Board
## Project: LED Blink with external 50 MHz oscillator and reset
## Clock: N18
## Reset: KEY1 / T19
## LEDs: H18, K17, E19
## =========================================================


## 50 MHz external oscillator input on N18
set_property PACKAGE_PIN N18 [get_ports clk_50m_n18]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50m_n18]
create_clock -period 20.000 -name clk_50m_n18 [get_ports clk_50m_n18]


## KEY1 reset input on T19
## Active-low reset: not pressed = 1, pressed = 0
set_property PACKAGE_PIN T19 [get_ports rst_n_key1]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n_key1]

## Optional internal pull-up
## Keep this line if the reset input is unstable when the button is not pressed
set_property PULLUP true [get_ports rst_n_key1]


## Expansion board LEDs
set_property PACKAGE_PIN H18 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]

set_property PACKAGE_PIN K17 [get_ports led2]
set_property IOSTANDARD LVCMOS33 [get_ports led2]

set_property PACKAGE_PIN E19 [get_ports led3]
set_property IOSTANDARD LVCMOS33 [get_ports led3]
