# 3-bit Counter Hardware Demo

This folder documents the hardware demo result for the 3-bit up/down counter project on the EBAZ4205 FPGA board.

## Board Setup

- FPGA board: EBAZ4205
- Expansion board: HELLOFPGA EBAZ4205 expansion board
- External oscillator: 50 MHz
- Clock input: N18
- Reset button: KEY1 / T19
- Direction button: KEY2 / P19
- Pause button: KEY3 / U20
- LED outputs: H18, K17, E19

## Demo Purpose

The purpose of this demo is to verify that the 3-bit counter works correctly on real FPGA hardware.

The design should demonstrate:

- Active-low reset behavior
- 1 Hz clock enable pulse
- Up counting
- Down counting
- Pause control
- Binary count display using three LEDs

## Expected Hardware Behavior

| Action | Expected Result |
|---|---|
| Release KEY1 | Counter runs normally |
| Press KEY1 | Counter resets to `000` |
| Release KEY2 | Counter counts up |
| Press KEY2 | Counter counts down |
| Release KEY3 | Counter is enabled |
| Press KEY3 | Counter pauses |
| Release KEY3 again | Counter resumes counting |

## LED Binary Mapping

The three LEDs display the 3-bit counter value.

| Counter Bit | LED | FPGA Pin |
|---|---|---|
| count[0] | LED1 | H18 |
| count[1] | LED2 | K17 |
| count[2] | LED3 | E19 |

## Expected LED Sequence

When counting up:

| Decimal | Binary | LED3 | LED2 | LED1 |
|---|---|---|---|---|
| 0 | 000 | 0 | 0 | 0 |
| 1 | 001 | 0 | 0 | 1 |
| 2 | 010 | 0 | 1 | 0 |
| 3 | 011 | 0 | 1 | 1 |
| 4 | 100 | 1 | 0 | 0 |
| 5 | 101 | 1 | 0 | 1 |
| 6 | 110 | 1 | 1 | 0 |
| 7 | 111 | 1 | 1 | 1 |

When counting down:

| Decimal | Binary | LED3 | LED2 | LED1 |
|---|---|---|---|---|
| 7 | 111 | 1 | 1 | 1 |
| 6 | 110 | 1 | 1 | 0 |
| 5 | 101 | 1 | 0 | 1 |
| 4 | 100 | 1 | 0 | 0 |
| 3 | 011 | 0 | 1 | 1 |
| 2 | 010 | 0 | 1 | 0 |
| 1 | 001 | 0 | 0 | 1 |
| 0 | 000 | 0 | 0 | 0 |

## Demo Checklist

Before recording the demo video:

- [ ] Bitstream generated successfully
- [ ] FPGA programmed successfully
- [ ] KEY1 reset tested
- [ ] KEY2 direction control tested
- [ ] KEY3 pause control tested
- [ ] LED binary sequence verified
- [ ] GitHub README updated
- [ ] Simulation waveform captured

## Suggested Demo Video Flow

Recommended video length: 10–20 seconds.

Suggested scenes:

1. Show the EBAZ4205 board and expansion board.
2. Show LED outputs counting up.
3. Press KEY2 to demonstrate counting down.
4. Press KEY3 to pause the counter.
5. Release KEY3 to resume counting.
6. Press KEY1 to reset the counter to `000`.

## Demo Evidence

Add demo evidence here:

- Demo video link:
https://drive.google.com/file/d/1ElKv2Q8IRFtTF1cwfZtNyGXsQSKtPVPs/view?usp=drive_link

## Notes

The demo uses a 1 Hz clock enable pulse generated from the external 50 MHz oscillator.  
The design keeps all logic synchronous to the main clock and updates the counter only when the enable pulse is active.

## Status

In progress
