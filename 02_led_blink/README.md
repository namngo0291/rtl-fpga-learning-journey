# 02 LED Blink on EBAZ4205

This project demonstrates a basic FPGA LED blink design using Verilog and Vivado on the EBAZ4205 board with a HELLOFPGA expansion board.

The design uses an external 50 MHz oscillator connected to FPGA pin N18, an active-low reset button, and three LED outputs on the expansion board.

## Hardware Setup

- FPGA board: EBAZ4205
- Expansion board: HELLOFPGA EBAZ4205 expansion board
- External oscillator: 50 MHz
- Clock input pin: N18
- Reset button: KEY1 / T19
- LED outputs: H18, K17, E19

## Pin Mapping

| Signal | FPGA Pin | Description |
|---|---|---|
| clk_50m_n18 | N18 | External 50 MHz oscillator clock input |
| rst_n_key1 | T19 | KEY1 active-low reset input |
| led1 | H18 | Expansion board LED1 |
| led2 | K17 | Expansion board LED2 |
| led3 | E19 | Expansion board LED3 |

## Design Concept

```text
External 50 MHz Oscillator on N18
        ↓
Top Module
        ↓
Counter / Clock Divider with Active-Low Reset
        ↓
LED Outputs on Expansion Board
```

## RTL Files

| File | Description |
|---|---|
| `rtl/led_blink.v` | Counter-based LED blink module with active-low reset |
| `rtl/top.v` | Top-level module for EBAZ4205 hardware implementation |

## Testbench

| File | Description |
|---|---|
| `tb/tb_top.v` | Top-level behavioral simulation testbench |

## Constraints

| File | Description |
|---|---|
| `constraints/ebaz4205_n18_led_blink_reset.xdc` | Pin mapping for N18 clock, KEY1 reset, and LED outputs |

## Clock and Reset

The external 50 MHz oscillator is connected to FPGA pin N18 and used as the main clock input for this design.

The reset signal uses KEY1 on pin T19 and is active-low.

| KEY1 State | rst_n_key1 | Design Behavior |
|---|---:|---|
| Pressed | 0 | Counter and LED states are reset |
| Released | 1 | LED blink logic runs normally |

## LED Blink Rates

| LED | FPGA Pin | Expected Blink Rate |
|---|---|---|
| LED1 | H18 | ~1 Hz |
| LED2 | K17 | ~2 Hz |
| LED3 | E19 | ~0.5 Hz |

## Simulation

The testbench uses a reduced `CLK_FREQ_HZ` parameter to make LED toggling visible faster in behavioral simulation.

In hardware, the design uses the actual 50 MHz oscillator.

Expected waveform behavior:

- `clk_50m_n18` toggles continuously.
- `rst_n_key1` starts low, then goes high.
- When `rst_n_key1 = 0`, all LED states reset.
- When `rst_n_key1 = 1`, LED outputs begin toggling.
- `led2` toggles faster than `led1`.
- `led3` toggles slower than `led1`.

## Hardware Result

Expected behavior after programming the FPGA:

| Action | Expected Result |
|---|---|
| Release KEY1 | LED1, LED2, and LED3 blink at different rates |
| Press KEY1 | LEDs reset to the initial state |
| Release KEY1 again | LEDs start blinking again |

## Lessons Learned

- A clock-capable FPGA pin can be used as an external oscillator input.
- A counter can divide a high-frequency clock into a visible LED blink signal.
- Active-low reset is commonly used in digital designs.
- A top module connects board-level signals to internal RTL modules.
- XDC constraints are critical because RTL port names must match physical FPGA pins.
- Behavioral simulation helps verify the logic before programming the FPGA.
- Hardware bring-up requires checking both RTL behavior and real board pin mapping.

## Status

In progress
