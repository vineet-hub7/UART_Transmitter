# UART Transmitter
I have Implemented a **UART Transmitter from scratch in Verilog** to understand serial communication at the hardware level.
The focus is on **correct timing, FSM based control, and simple RTL design**, rather than using prebuilt IPs.

---

## What’s implemented in this project
- It is a standard **UART 8N1** format which has 1 start bit,8 data bits, no parity
- It has a **baud_gen** module file which is used to generate baud_pulse which is derived from system clock
- It's a FSM based transmitter which transmits the data in frames and has mainly 4 states: (IDLE → START → DATA → STOP)
- It has shift register based serialization to make sure that **LSB** is transmitted first to simplify the hardware
- It has a transmit request to avoid missed transfers
- `tx_busy` signal for proper handshaking protocol
---

## UART Frame Design

- tx Line stays HIGH when it is in idle
- tx_busy line tells if the tx line is busy(1/0)
- The start bit signals beginning of transmission  

Each bit is held for exactly **one baud period**.

---

## Simulation
-It is simulated using **Vivado Behavioral Simulation**
- Clock: **100 MHz**
- Baud rate: **9600**
- Bit duration: ~104 µs
- Waveforms are verified for:
  - Correct start bit
  - Proper data bit order
  - Accurate timing
  - 
> Note: UART is slow by design — waveforms should be viewed at **microsecond/millisecond scale**.

---

## Why this project
This was built to:
- Understand UART timing practically
- Practice FSM based RTL design
- Learn how real serial protocols behave in hardware
---
<img width="1551" height="246" alt="image" src="https://github.com/user-attachments/assets/02f5e1f4-53ef-4d8e-92f9-b777bd398223" />

