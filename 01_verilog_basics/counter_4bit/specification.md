# Parameterized Counter Specification

## 1. Overview

A synchronous parameterized binary counter implemented using
SystemVerilog RTL.

The counter increments on every rising edge of the clock when
`enable` is asserted.

The design uses an active-low synchronous reset.

---

## 2. Parameters

| Parameter | Default | Description |
|---|---:|---|
| WIDTH | 4 | Counter width in bits |

The counter supports configurable widths through the `WIDTH` parameter.

---

## 3. Inputs

| Signal | Width | Description |
|---|---:|---|
| `clk` | 1 | Rising-edge clock |
| `rst_n` | 1 | Synchronous active-low reset |
| `enable` | 1 | Counter enable |

---

## 4. Output

| Signal | Width | Description |
|---|---:|---|
| `count` | WIDTH | Current counter value |

---

## 5. Reset Behavior

The reset signal is **active-low and synchronous**.

When:

```text
rst_n = 0
```

the counter is reset to zero on the next rising edge of `clk`.

The counter does not reset immediately when `rst_n` changes between
clock edges.

Expected behavior:

```text
rst_n = 0
       |
       v
next rising edge
       |
       v
count = 0
```

---

## 6. Counting Behavior

When reset is inactive:

```text
rst_n = 1
```

and counting is enabled:

```text
enable = 1
```

the counter increments by one on every rising edge of `clk`.

Example for a 4-bit counter:

```text
0 → 1 → 2 → 3 → 4 → ... → 14 → 15
```

---

## 7. Hold Behavior

When:

```text
rst_n = 1
enable = 0
```

the counter holds its current value.

Example:

```text
count = 5
enable = 0

5 → 5 → 5 → 5
```

The counter resumes counting when `enable` becomes `1`.

---

## 8. Overflow / Wrap-Around

The counter uses fixed-width binary arithmetic.

For a 4-bit counter, the maximum value is:

```text
1111 = 15
```

When the counter reaches the maximum value and `enable = 1`, the next
clock cycle wraps the counter back to zero.

Example:

```text
14 → 15 → 0 → 1 → 2
```

For a parameterized counter with width `WIDTH`, the maximum value is:

```text
2^WIDTH - 1
```

and the next increment wraps to:

```text
0
```

---

## 9. Timing Model

The counter is updated only on the rising edge of `clk`.

Behavioral priority:

```text
                    +----------------+
                    | Rising edge clk |
                    +--------+-------+
                             |
                             v
                       rst_n == 0?
                       /          \
                     Yes           No
                      |             |
                      v             v
                  count = 0     enable == 1?
                                /          \
                              Yes           No
                               |             |
                               v             v
                         count = count + 1  Hold
```

---

## 10. Verification Requirements

The testbench shall verify:

1. Synchronous active-low reset
2. Counter increment when `enable = 1`
3. Counter hold when `enable = 0`
4. Counter resume after `enable` is reasserted
5. Overflow / wrap-around behavior
6. Parameterized counter width

---

## 11. Verification Environment

Simulation tool:

**Icarus Verilog**

Waveform viewer:

**GTKWave**

Testbench:

```text
tb/tb_counter_4bit.sv
```

Waveform:

```text
waveform/counter_4bit_simulation.png
```

---

## 12. Expected Behavior

| `rst_n` | `enable` | Expected behavior |
|---:|---:|---|
| 0 | X | Reset to `0` on next rising edge |
| 1 | 0 | Hold current count |
| 1 | 1 | Increment count on rising edge |

For `WIDTH = 4`:

```text
Reset:
count = 0

Counting:
0 → 1 → 2 → 3 → ... → 15

Overflow:
15 → 0
```

---

## 13. Design Constraints

The design shall:

- Use synthesizable SystemVerilog RTL
- Use synchronous active-low reset
- Use rising-edge triggered sequential logic
- Support configurable counter width
- Avoid inferred latches
- Use non-blocking assignments for sequential logic

---

## 14. Project Goal

The purpose of this project is to establish fundamental RTL design and
verification practices:

```text
Specification
     ↓
RTL Design
     ↓
Self-Checking Testbench
     ↓
Simulation
     ↓
Waveform Analysis
```

These practices will be reused in later projects involving FSMs, UART,
FIFO, FPGA implementation, verification, and ASIC design flow.
