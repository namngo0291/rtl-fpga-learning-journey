# Traffic Light Controller FSM

A simple 3-state Moore Finite State Machine (FSM) implemented in
SystemVerilog.

This project is part of my RTL/FPGA learning journey.

## 1. Project Overview

The design implements a basic traffic light controller with three states:

- RED
- GREEN
- YELLOW

Normal sequence:

```text
RED -> GREEN -> YELLOW -> RED
