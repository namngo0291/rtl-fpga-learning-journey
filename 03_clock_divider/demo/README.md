# Clock Enable Hardware Demo

## Board

- EBAZ4205 FPGA board
- HELLOFPGA EBAZ4205 expansion board
- External 50 MHz oscillator connected to N18
- KEY1 active-low reset connected to T19
- LED outputs connected to H18, K17, and E19

## Expected Hardware Result

| Action | Expected Result |
|---|---|
| Release KEY1 | LED1, LED2, and LED3 toggle at different rates |
| Press KEY1 | LED states reset |
| Release KEY1 again | LED toggling resumes |

## Demo Evidence
https://drive.google.com/file/d/1OIu1iUghyqo6b7mGgiRsTPmgC2wKFB_Y/view?usp=drive_link
