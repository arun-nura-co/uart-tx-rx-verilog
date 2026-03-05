# uart-tx-rx-verilog
UART Transmitter and Receiver implemented in Verilog HDL with configurable baud rate and verified through Vivado simulation.
# UART Transmitter and Receiver (Verilog)

## Overview
This project implements a UART (Universal Asynchronous Receiver Transmitter) using Verilog HDL.  
It includes both transmitter and receiver modules and demonstrates serial communication through loopback testing.

## Features
- UART Transmitter (TX)
- UART Receiver (RX)
- Configurable clock frequency and baud rate
- Serial data transmission and reception
- Simulation verification

## Modules
- `uart_tx.v` – UART transmitter module
- `uart_rx.v` – UART receiver module
- `uart_top.v` – Top module connecting transmitter and receiver
- `uart_tb.v` – Testbench for simulation

## Tools Used
- Vivado
- Verilog HDL

## Simulation
Example test case:

Input Data : 01010101(85)
Received Data : 01010101(85)
The simulation confirms correct UART transmission and reception.

## Project Structure
uart-tx-rx-verilog │ ├── uart_tx.v ├── uart_rx.v ├── uart_top.v ├── uart_tb.v └── README.md
## Author
Arunthathe
