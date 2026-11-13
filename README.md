# UART-Transmitter-Receiver
Design and simulation of a UART transmitter and receiver using Verilog HDL and Xilinx Vivado, featuring baud rate generation and FSM-based serial communication

##Simulation Results

The UART transmitter and receiver were tested using behavioral simulation in Xilinx Vivado.

- Test data: "8'hA5"
- Observed receiver data: "8'hA5"
- Transmitter busy signal changes during operation.
- The "rx_done" completion signal has not yet been verified to assert successfully.

**Verification Status**: Partial — data matching was observed, but reception-completion signalling requires further debugging.

(uart_simulation.png)
