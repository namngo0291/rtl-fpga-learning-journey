# 02 LED Blink on EBAZ4205

This project demonstrates a basic FPGA LED blink design using Verilog and Vivado on the EBAZ4205 board with a HELLOFPGA expansion board.

## Hardware Setup

- FPGA board: EBAZ4205
- Expansion board: HELLOFPGA EBAZ4205 expansion board
- External oscillator: 50 MHz
- Clock input pin: N18
- Reset button: KEY1 / T19
- LED outputs: H18, K17, R18

## Pin Mapping

| Signal | FPGA Pin | Description |
|---|---|---|
| clk_50m_n18 | N18 | External 50 MHz oscillator clock input |
| rst_n_key1 | T19 | KEY1 active-low reset input |
| led1 | H18 | Expansion board LED1 |
| led2 | K17 | Expansion board LED2 |
| led3 | R18 | Expansion board LED3 |

## Design Concept

```text
External 50 MHz Oscillator on N18
        ↓
Top Module
        ↓
Counter / Clock Divider with Reset
        ↓
LED Outputs on Expansion Board
