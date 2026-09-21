# Traffic Light Controller FSM Specification

## 1. Overview

This project implements a simple traffic light controller using a
Finite State Machine (FSM) in SystemVerilog.

The controller uses three states:

- RED
- GREEN
- YELLOW

The normal traffic light sequence is:

RED -> GREEN -> YELLOW -> RED

The design is implemented as a Moore FSM.

---

## 2. Design Objectives

The design shall:

- Implement a 3-state Moore FSM.
- Use a synchronous active-low reset.
- Provide an enable input to control state transitions.
- Generate one-hot traffic light outputs.
- Hold the current state when enable is low.
- Return to RED state when reset is asserted.

---

## 3. Interface

### Inputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | System clock |
| `rst_n` | Input | 1 | Active-low synchronous reset |
| `enable` | Input | 1 | Enables FSM state transitions |

### Outputs

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `red` | Output | 1 | Red traffic light |
| `yellow` | Output | 1 | Yellow traffic light |
| `green` | Output | 1 | Green traffic light |

---

## 4. Reset Behavior

The reset is active-low and synchronous.

When:

```text
rst_n = 0
