# 01 Verilog Basics

This folder contains my first Verilog HDL practice modules as part of my RTL/FPGA learning journey.

## Objectives

- Practice basic Verilog syntax
- Understand combinational and sequential logic
- Write simple RTL modules
- Create basic testbenches
- Run behavioral simulation
- Analyze waveform results

## Modules

| Module | Type | Description |
|---|---|---|
| mux2_1 | Combinational | 2-to-1 multiplexer |
| decoder2_4 | Combinational | 2-to-4 decoder |
| half_adder | Combinational | Basic half adder |
| d_ff | Sequential | D flip-flop with active-low reset |
| counter_4bit | Sequential | 4-bit up counter |

## Simulation

Testbenches included:

- `tb_mux2_1.v`
- `tb_counter_4bit.v`

## Lessons Learned

- Combinational logic can be described using `assign` or `always @(*)`.
- Sequential logic should be triggered by a clock edge.
- Reset behavior is important for predictable hardware design.
- A testbench helps verify the design before FPGA implementation.

## Status

In progress
