`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 15:23:46
// Design Name: 
// Module Name: uart_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_top_tb;
  reg clk;
  reg reset;
  reg tx_start;
  reg [7:0] tx_data;
  wire tx_busy;
  wire [7:0] rx_data;
  wire rx_done;
  uart_top DUT(
      .clk(clk),
      .reset(reset),
      .tx_start(tx_start),
      .tx_data(tx_data),
      .tx_busy(tx_busy),
      .rx_data(rx_data),
      .rx_done(rx_done)
);
always #5 clk = ~clk;
initial
begin
  clk=0;
  reset = 1;
  tx_start = 0;
  tx_data = 8'b00000000;
  #20;
  reset = 0;
  #20;
  tx_data = 8'hA5;
  tx_start = 1;
  #10;
  tx_start = 0;
  #3000;
  tx_data = 8'h3C;
  tx_start = 1;
  #10;
  tx_start = 0;
  #3000;
  $stop;
  end
  endmodule
  
    

