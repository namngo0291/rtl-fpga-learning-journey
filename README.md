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

# Featured Projects

## 1. Parameterized 4-bit Counter

**Status:** Verified in RTL simulation

**HDL:** SystemVerilog
**Simulation:** Icarus Verilog
**Waveform:** GTKWave

### Overview

A parameterized synchronous counter developed to practice fundamental RTL
design, sequential logic, reset behavior, enable control, self-checking
verification, and waveform analysis.

### Demonstrates

- Parameterized counter RTL
- Sequential logic design
- Active-low synchronous reset
- Enable-controlled counting
- Counter overflow / wrap-around
- Self-checking testbench
- Functional simulation
- Waveform analysis

### Verification

The testbench verifies:

- Reset behavior
- Counter increment
- Hold behavior when `enable = 0`
- Overflow / wrap-around
- Parameterized width behavior

### Project Structure

```text
01_verilog_basics/counter_4bit/
├── docs/
├── fpga/
├── README.md
├── rtl/
│   └── counter_4bit.sv
├── specification.md
├── tb/
│   └── tb_counter_4bit.sv
└── waveform/
    └── counter_4bit_simulation.png
```

The `fpga/` directory is reserved for future FPGA implementation.

📁 [View Project](./01_verilog_basics/counter_4bit)

---

## 2. Traffic Light Controller FSM

**Status:** Verified in RTL simulation and FPGA-wrapper simulation

**HDL:** SystemVerilog
**Simulation:** Icarus Verilog
**Waveform:** GTKWave
**FPGA Target:** EBAZ4205

### Overview

A three-state Moore finite state machine implementing a traffic light
controller with RED, GREEN, and YELLOW states.

### FSM Architecture

```text
              enable
        +----------------+
        |                |
        v                |
      +-----+         +-------+
      | RED | ------> | GREEN |
      +-----+         +-------+
        ^                 |
        |                 |
        |              enable
        |                 v
        |             +--------+
        +-------------| YELLOW |
              enable  +--------+
```

### Demonstrates

- Moore FSM architecture
- State encoding
- `typedef enum`
- `always_ff`
- `always_comb`
- Synchronous reset
- State transition logic
- One-hot output behavior
- Self-checking testbench
- Waveform debugging

### Verification

The RTL testbench verifies:

- Reset → RED
- RED → GREEN
- GREEN → YELLOW
- YELLOW → RED
- State hold when `enable = 0`
- Complete FSM cycle
- One-hot output behavior
- Repeated operation

The FPGA wrapper simulation additionally verifies the clock-enable
integration used for the EBAZ4205 target.

### Clock Enable

The FPGA wrapper uses a clock-enable pulse rather than creating a derived
slow clock:

```text
50 MHz Clock
     |
     v
Clock Enable Generator
     |
     | tick_1hz
     v
Traffic Light FSM
     |
     +----> RED LED
     +----> YELLOW LED
     +----> GREEN LED
```

### Current FPGA Status

The EBAZ4205 wrapper and constraints are being prepared for hardware
implementation.

The current repository evidence covers RTL simulation and FPGA-wrapper
simulation. Hardware validation will be documented after actual board
implementation.

📁 [View Project](./02_fsm/traffic_light)

---

# ASIC / VLSI Projects

## 3. ASIC RTL-to-GDS Flow Exploration

**Status:** In Progress

**Tools:** Yosys, OpenLane, Sky130, Magic, KLayout, ngspice

### Objective

Explore the ASIC implementation flow from synthesizable RTL to physical
layout and GDS generation using an open-source EDA toolchain.

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
```

### Topics

- RTL synthesis
- Standard-cell mapping
- Floorplanning
- Placement
- Clock Tree Synthesis
- Routing
- Static Timing Analysis
- Physical verification
- DRC
- LVS
- GDS generation

Only completed stages will be marked as completed in the project
documentation.

📁 [View Project](./13_asic_flow)

---

## 4. CMOS Standard-Cell Layout

**Status:** In Progress

**Tools:** Xschem, ngspice, Magic, Sky130

### Topics

- CMOS logic
- NMOS / PMOS
- Diffusion
- Poly
- Metal layers
- Contacts
- Vias
- Well structures
- Standard-cell layout
- DRC
- LVS

The project focuses on understanding the relationship between transistor-level
schematics, physical layout, and design-rule verification.

---

## 5. 6T SRAM Bitcell Design Study

**Status:** In Progress

**Tools:** Xschem, ngspice, Magic, Sky130

### Topics

- 6T SRAM architecture
- Read operation
- Write operation
- Word Line (WL)
- Bit Line (BL)
- Bit Line Bar (BLB)
- Storage nodes Q / QB
- CMOS transistor-level design
- Schematic / layout consistency
- DRC / LVS

The project focuses on understanding SRAM bitcell operation from schematic
to physical layout.

---

# Learning Roadmap

The following roadmap represents current and future learning areas.
Topics marked as learning or planned are not presented as completed
professional experience.

| Area | Status |
|---|---|
| Verilog Fundamentals | Completed / Practiced |
| Parameterized RTL | Completed / Practiced |
| Digital Logic | In Progress |
| FSM | Completed / Practiced |
| UART | Planned |
| FIFO | Planned |
| Memory | Planned |
| SystemVerilog | In Progress |
| RTL Verification | In Progress |
| APB | Planned |
| AXI4-Lite | Planned |
| RISC-V RV32I | Planned |
| RISC-V SoC | Planned |
| FPGA / EBAZ4205 | In Progress |
| ASIC RTL-to-GDS | In Progress |
| CMOS Layout | In Progress |
| 6T SRAM | In Progress |

---

# Repository Structure

```text
rtl-fpga-learning-journey/
│
├── 01_verilog_basics/
│   └── counter_4bit/
│
├── 02_fsm/
│   └── traffic_light/
│
├── 03_uart/
├── 04_fifo/
├── 05_memory/
├── 06_systemverilog/
├── 07_verification/
├── 08_apb/
├── 09_axi/
├── 10_riscv/
├── 11_riscv_soc/
├── 12_fpga_ebaz4205/
├── 13_asic_flow/
├── 14_biomedical_fpga/
│
├── docs/
├── .gitignore
├── LICENSE
└── README.md
```

The repository is organized as a progressive learning path from RTL
fundamentals toward FPGA, SoC, and ASIC design.

---

# Tools & Technologies

## RTL / Digital Design

- Verilog
- SystemVerilog
- RTL design
- FSM
- Sequential logic
- Combinational logic
- Parameterized RTL
- Synchronous reset
- Clock-enable methodology

## Verification

- Icarus Verilog
- GTKWave
- Self-checking testbenches
- Functional simulation
- Waveform analysis
- RTL debugging

## FPGA

- Xilinx Vivado
- EBAZ4205
- Xilinx 7-series FPGA
- XDC constraints
- FPGA synthesis
- FPGA implementation
- Bitstream generation

## ASIC / VLSI

- Yosys
- OpenLane
- Sky130 PDK
- Magic
- KLayout
- Xschem
- ngspice
- DRC
- LVS
- GDS

## Development Environment

- Ubuntu / Linux
- Git
- GitHub
- Tcl
- Command-line development

---

# Development Methodology

The projects in this repository follow a consistent engineering workflow:

```text
Specification
     ↓
RTL Design
     ↓
Testbench
     ↓
Simulation
     ↓
Waveform Analysis
     ↓
FPGA / ASIC Implementation
     ↓
Verification
     ↓
Documentation
```

Not every project requires every stage. FPGA and ASIC implementation stages
are added when appropriate to the project objective.

---

# Career Direction

My target career path is:

**RTL Design Engineer → IP / SoC Design → ASIC / SoC Development**

Long-term areas of interest include:

- RTL design
- IP design
- SoC design
- RTL integration
- Design verification
- FPGA prototyping
- ASIC development
- Hardware design methodology

---

# Portfolio Philosophy

This repository is intended to document an actual learning and engineering
process rather than simply list technologies.

For each completed project, the goal is to provide evidence such as:

- RTL source code
- Design specification
- Testbench
- Simulation results
- Waveform
- Implementation results
- Debugging notes
- Technical documentation

Projects are marked according to their actual implementation status.

Planned technologies are kept separate from completed hands-on work.

---

# Contact

**Ngô Nam**

- Email: [ngonam0291@gmail.com](mailto:ngonam0291@gmail.com)
- LinkedIn: [namngo-rtl-fpga](https://linkedin.com/in/namngo-rtl-fpga)
- GitHub: [namngo0291/rtl-fpga-learning-journey](https://github.com/namngo0291/rtl-fpga-learning-journey)

---

# Disclaimer

This repository represents my personal semiconductor learning journey,
hands-on practice, experiments, and portfolio projects.

The projects are developed for educational and engineering practice purposes.
Project status is documented according to the actual implementation stage.
