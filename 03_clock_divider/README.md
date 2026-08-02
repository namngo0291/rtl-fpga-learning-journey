# 03 Clock Enable Demo on EBAZ4205

This project demonstrates a reusable clock enable generator using Verilog and Vivado on the EBAZ4205 board with a HELLOFPGA expansion board.

The goal of this project is not to create a new slow clock, but to generate a one-clock-cycle enable pulse from the main 50 MHz clock.

## Why Clock Enable?

In FPGA design, it is usually better to keep logic running on the same main clock and use an enable signal to control when a block should update.

Instead of doing this:

```text
50 MHz clock → divided slow clock → logic
```

This project uses:

```text
50 MHz clock → clock enable pulse → logic update
```

## Hardware Setup

- FPGA board: EBAZ4205
- Expansion board: HELLOFPGA EBAZ4205 expansion board
- External oscillator: 50 MHz
- Clock input: N18
- Reset button: KEY1 / T19
- LED outputs: H18, K17, E19

## Pin Mapping

| Signal | FPGA Pin | Description |
|---|---|---|
| clk_50m_n18 | N18 | External 50 MHz oscillator input |
| rst_n_key1 | T19 | KEY1 active-low reset |
| led1 | H18 | LED1 output |
| led2 | K17 | LED2 output |
| led3 | E19 | LED3 output |

## Design Concept

```text
External 50 MHz Clock on N18
        ↓
clock_enable.v
        ↓
1-cycle enable pulse
        ↓
LED toggle logic
        ↓
LED outputs
```

## RTL Files

| File | Description |
|---|---|
| `rtl/clock_enable.v` | Reusable clock enable pulse generator |
| `rtl/top.v` | Top-level module for EBAZ4205 LED demo |

## Testbench

| File | Description |
|---|---|
| `tb/tb_top.v` | Behavioral simulation testbench |

## Constraints

| File | Description |
|---|---|
| `constraints/ebaz4205_clock_enable_demo.xdc` | Pin mapping for N18 clock, KEY1 reset, and LEDs |

## Expected Behavior

| LED | FPGA Pin | Enable Rate | Expected Effect |
|---|---|---|---|
| LED1 | H18 | 1 Hz enable | Toggles slowly |
| LED2 | K17 | 2 Hz enable | Toggles faster |
| LED3 | E19 | 0.5 Hz enable | Toggles slower |

## Simulation Notes

The testbench uses a reduced `CLK_FREQ_HZ` parameter to make enable pulses visible quickly in simulation.

Expected waveform behavior:

- `clk_50m_n18` toggles continuously.
- `rst_n_key1` starts low, then goes high.
- `en_1hz`, `en_2hz`, and `en_0p5hz` generate one-clock-cycle pulses.
- LED states only toggle when the corresponding enable pulse is high.
- When reset is active-low, LED states return to zero.

## Lessons Learned

- A clock enable pulse is different from a divided clock.
- Keeping logic on one main clock is cleaner for FPGA design.
- A reusable `clock_enable` module can be used in later projects.
- Simulation helps verify pulse timing before hardware implementation.
- The top module connects reusable RTL logic to real FPGA board pins.

## Status

In progress
