`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 13:34:34
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
   input clk,
   input reset,
   input rx,
   input baud_tick,
   output reg[7:0] rx_data,
   output reg rx_done
);
parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter DATA = 3'b010;
parameter STOP = 3'b011;
parameter DONE = 3'b100;
reg [2:0] state;
reg [2:0] next_state;

reg [2:0] bit_count;
always @(posedge clk or posedge reset)
begin
    if(reset)
          rx_data <= 8'b0;
    else if(state==DATA)
          rx_data[bit_count] <=rx;
end
always @(posedge clk or posedge reset)
begin
    if (reset)
          bit_count <= 3'b000;
    else if(state==DATA)
    begin
        if(bit_count == 3'd7)
             bit_count <= 3'b000;
        else
             bit_count <= bit_count+1'b1;
    end
    else
       bit_count <= 3'b000;
    end
always @(posedge clk or posedge reset)
begin
    if (reset)
          state <= IDLE;
    else
        state <= next_state;
end
always @(*)
begin
    case(state)
         IDLE:
           if(rx==1'b0)
                next_state = START;
           else
               next_state = IDLE;
         START:
           if(baud_tick)
                next_state = DATA;
           else
               next_state = START;
         DATA:
           if(bit_count==7 && baud_tick)
                next_state = STOP;
           else
              next_state = DATA;
         STOP:
           if(baud_tick)
               next_state = IDLE;
           else
              next_state = STOP;
         default:
            next_state = IDLE;
        endcase
 end
 always @(*)
 begin
      case(state)
        IDLE:
           rx_done = 1'b0;
        START:
           rx_done = 1'b0;
        DATA:
           rx_done = 1'b0;
        STOP:
           rx_done = 1'b0;
        DONE:
           rx_done = 1'b0;
        default:
           rx_done = 1'b0;
      endcase
 end
         

    
endmodule
