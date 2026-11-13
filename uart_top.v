module uart_top(
    input clk,
    input reset,
    input tx_start,
    input [7:0] tx_data,
    output tx_busy,
    output [7:0] rx_data,
    output rx_done
);
wire baud_tick;
wire serial_line;
baud_generator BG(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick)
);
uart_tx TX(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(serial_line),
    .tx_busy(tx_busy)
);
uart_rx RX(
   .clk(clk),
   .reset(reset),
   .baud_tick(baud_tick),
   .rx(serial_line),
   .rx_data(rx_data),
   .rx_done(rx_done)
);
endmodule