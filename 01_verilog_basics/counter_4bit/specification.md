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

---

## 3. Inputs

| Signal | Width | Description |
|---|---:|---|
| clk | 1 | Rising-edge clock |
| rst_n | 1 | Synchronous active-low reset |
| enable | 1 | Counter enable |

---

## 4. Output

| Signal | Width | Description |
|---|---:|---|
| count | WIDTH | Current counter value |

---

## 5. Reset Behavior

The reset signal is **active-low**.

When:

```text
rst_n = 0
