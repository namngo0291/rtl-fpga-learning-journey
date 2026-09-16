# Parameterized 4-bit Counter

A simple parameterized synchronous binary counter written in SystemVerilog.

This project is part of my RTL/FPGA learning journey.

## Project Overview

The counter increments on every rising edge of `clk` when `enable` is high.

The design uses an active-low synchronous reset.

## Features

- Parameterized counter width
- Default width: 4 bits
- Active-low synchronous reset
- Enable control
- Binary counting
- Automatic wrap-around on overflow
- Self-checking SystemVerilog testbench
- VCD waveform generation
- GTKWave waveform verification

## RTL Interface

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | Clock |
| `rst_n` | Input | Active-low synchronous reset |
| `enable` | Input | Enable counting |
| `count` | Output | Counter value |

## Reset Behavior

The reset is active-low and synchronous.

When:

```text
rst_n = 0
