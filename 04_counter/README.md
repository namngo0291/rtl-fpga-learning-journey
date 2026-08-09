# 04 3-bit Counter Demo on EBAZ4205

This project demonstrates a 3-bit up/down counter using Verilog and Vivado on the EBAZ4205 board with a HELLOFPGA expansion board.

The counter uses a reusable clock enable generator from the previous clock divider project.

## Hardware Setup

- FPGA board: EBAZ4205
- Expansion board: HELLOFPGA EBAZ4205 expansion board
- External oscillator: 50 MHz
- Clock input: N18
- Reset button: KEY1 / T19
- Direction button: KEY2 / P19
- Pause button: KEY3 / U20
- LED outputs: H18, K17, E19

## Pin Mapping

| Signal | FPGA Pin | Description |
|---|---|---|
| clk_50m_n18 | N18 | External 50 MHz oscillator input |
| rst_n_key1 | T19 | KEY1 active-low reset |
| dir_key2_n | P19 | KEY2 direction control |
| pause_key3_n | U20 | KEY3 pause control |
| led1 | H18 | Counter bit 0 |
| led2 | K17 | Counter bit 1 |
| led3 | E19 | Counter bit 2 |

## Design Concept

```text
External 50 MHz Clock on N18
        ↓
clock_enable.v
        ↓
1 Hz enable pulse
        ↓
counter_3bit.v
        ↓
LED binary output
```

## Control Behavior

| Input | Behavior |
|---|---|
| KEY1 pressed | Reset counter to 000 |
| KEY1 released | Counter can run |
| KEY2 released | Count up |
| KEY2 pressed | Count down |
| KEY3 released | Counter enabled |
| KEY3 pressed | Counter paused |

## RTL Files

| File | Description |
|---|---|
| `rtl/clock_enable.v` | Reusable 1-cycle enable pulse generator |
| `rtl/counter_3bit.v` | 3-bit up/down counter |
| `rtl/top.v` | Top-level module for EBAZ4205 implementation |

## Testbench

| File | Description |
|---|---|
| `tb/tb_top.v` | Behavioral simulation testbench |

## Constraints

| File | Description |
|---|---|
| `constraints/ebaz4205_counter_demo.xdc` | Pin mapping for clock, buttons, and LEDs |

## Expected LED Output

The LEDs display the 3-bit counter value in binary.

| Counter Value | LED3 | LED2 | LED1 |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 1 |
| 2 | 0 | 1 | 0 |
| 3 | 0 | 1 | 1 |
| 4 | 1 | 0 | 0 |
| 5 | 1 | 0 | 1 |
| 6 | 1 | 1 | 0 |
| 7 | 1 | 1 | 1 |

## Simulation Notes

The testbench uses a reduced `CLK_FREQ_HZ` parameter to make the counter transitions visible faster in simulation.

Expected waveform behavior:

- `tick_1hz` generates a one-clock-cycle enable pulse.
- The counter increments when `dir_key2_n = 1`.
- The counter decrements when `dir_key2_n = 0`.
- The counter pauses when `pause_key3_n = 0`.
- The counter resets to `000` when `rst_n_key1 = 0`.

## Lessons Learned

- A clock enable pulse can control when a counter updates.
- A counter can be designed with reset, enable, and direction control.
- FPGA logic should remain synchronous to the main clock.
- A top module connects board-level inputs and outputs to reusable RTL modules.
- Simulation helps verify counter behavior before hardware testing.

## Status

In progress
