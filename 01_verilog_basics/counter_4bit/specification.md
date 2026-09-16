# Parameterized Counter Specification

## 1. Overview

A synchronous parameterized binary counter implemented using
SystemVerilog RTL.

The counter increments on every rising edge of the clock when
`enable` is asserted.

## 2. Parameters

| Parameter | Default | Description |
|---|---:|---|
| WIDTH | 4 | Counter width in bits |

## 3. Inputs

| Signal | Width | Description |
|---|---:|---|
| clk | 1 | Clock |
| rst | 1 | Synchronous active-high reset |
| enable | 1 | Counter enable |

## 4. Output

| Signal | Width | Description |
|---|---:|---|
| count | WIDTH | Current counter value |

## 5. Functional Behavior

### Reset

When `rst = 1`, the counter is synchronously reset to zero
at the next rising edge of `clk`.

### Enable

When `rst = 0` and `enable = 1`, the counter increments by one
at every rising edge of `clk`.

### Hold

When `rst = 0` and `enable = 0`, the counter retains its current
value.

### Overflow

When the counter reaches its maximum value, the next increment
wraps around to zero.

For WIDTH = 4:

15 → 0

## 6. Timing

All state transitions occur on the rising edge of `clk`.

## 7. Design Requirements

- Synthesizable SystemVerilog
- Parameterized counter width
- Synchronous reset
- Enable control
- No inferred latch
- No combinational feedback
