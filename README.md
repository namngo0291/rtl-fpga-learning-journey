# RTL / FPGA / ASIC Design Portfolio

> Hands-on portfolio in RTL design, FPGA implementation, verification, and ASIC design flow.

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![SystemVerilog](https://img.shields.io/badge/HDL-SystemVerilog-blue)
![FPGA](https://img.shields.io/badge/FPGA-EBAZ4205-orange)
![ASIC](https://img.shields.io/badge/ASIC-Sky130-green)
![Tools](https://img.shields.io/badge/Tools-Vivado%20%7C%20Yosys%20%7C%20OpenLane-lightgrey)
![Linux](https://img.shields.io/badge/OS-Linux-yellow)
![GitHub](https://img.shields.io/badge/Version%20Control-GitHub-black)

---

## About

I am a Semiconductor Chip Design student at FPT Jetking with a background in
Electronics and Telecommunications Engineering from VNU-HCM University of Science.

This repository documents my hands-on learning and implementation work in:

- RTL design
- Digital design
- RTL simulation
- Testbench development
- FPGA implementation
- ASIC design flow
- CMOS layout
- SRAM design

My current learning direction is:

**RTL Design → FPGA → SoC / ASIC**

---

## Target Role

**RTL Design Engineer (Fresher)**

Areas of interest:

- RTL design
- IP design
- SoC design
- RTL integration
- Design verification
- FPGA prototyping
- ASIC implementation flow

---

# Selected Projects

## 1. RTL Counter & Clock Divider — EBAZ4205

**Status:** Hands-on

**HDL:** Verilog / SystemVerilog
**FPGA:** EBAZ4205
**Tool:** Xilinx Vivado

### Overview

A fundamental RTL project demonstrating sequential logic, counter design,
clock management, reset behavior, simulation, and FPGA implementation.

### Demonstrates

- Parameterized counter RTL
- Sequential logic design
- Clock divider
- Clock-enable methodology
- Reset logic
- RTL simulation
- Self-checking testbench
- Waveform analysis
- FPGA implementation

### Verification

- Functional simulation
- Reset verification
- Counter transition verification
- Overflow behavior
- Waveform inspection

📁 [View project](./01_verilog_basics/counter_4bit)

---

## 2. ASIC RTL-to-GDS Flow Exploration

**Status:** In Progress

**Tools:** Yosys, OpenLane, Sky130, Magic, KLayout

### Objective

Explore the ASIC implementation flow from synthesizable RTL
to physical layout and GDS generation.

### Flow

```text
RTL
 ↓
RTL Simulation
 ↓
Synthesis
 ↓
Floorplanning
 ↓
Placement
 ↓
Clock Tree Synthesis
 ↓
Routing
 ↓
Static Timing Analysis
 ↓
DRC
 ↓
LVS
 ↓
GDS
