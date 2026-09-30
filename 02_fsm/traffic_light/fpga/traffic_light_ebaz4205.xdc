# ============================================================
# EBAZ4205 - Traffic Light FSM
# 50 MHz external oscillator
# ============================================================

# ------------------------------------------------------------
# Clock
# ------------------------------------------------------------
set_property PACKAGE_PIN N18 [get_ports clk_50m]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50m]

create_clock -period 20.000 \
    -name clk_50m \
    [get_ports clk_50m]


# ------------------------------------------------------------
# Reset - KEY1
# ------------------------------------------------------------
set_property PACKAGE_PIN T19 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]


# ------------------------------------------------------------
# Traffic Light LEDs
# ------------------------------------------------------------

# LED1 -> RED
set_property PACKAGE_PIN H18 [get_ports led_red]
set_property IOSTANDARD LVCMOS33 [get_ports led_red]

# LED2 -> YELLOW
set_property PACKAGE_PIN K17 [get_ports led_yellow]
set_property IOSTANDARD LVCMOS33 [get_ports led_yellow]

# LED3 -> GREEN
set_property PACKAGE_PIN E19 [get_ports led_green]
set_property IOSTANDARD LVCMOS33 [get_ports led_green]
