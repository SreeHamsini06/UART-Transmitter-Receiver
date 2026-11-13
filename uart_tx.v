module uart_tx(
    input clk,
    input reset,
    input tx_start,
    input baud_tick,
    input [7:0] tx_data,
    output reg tx,
    output reg tx_busy
 );
 parameter IDLE = 2'b00;
 parameter START = 2'b01;
 parameter DATA = 2'b10;
 parameter STOP = 2'b11;
 reg [1:0] state;
 reg [7:0] next_state;
 reg [2:0] bit_count;
 always @(posedge clk or posedge reset)
 begin
   if(reset)
      bit_count <= 0;
   else if(state == DATA)
   begin
      if(bit_count == 7)
         bit_count <= 0;
      else
        bit_count <= bit_count +1;
   end
   else
     bit_count <= 0;
 end
 always @(posedge clk or posedge reset)
 begin
   if(reset)
       state <= IDLE;
   else
      state <= next_state;
 end
 always @(*)
 begin
     case(state)
        IDLE:
          if(tx_start)
              next_state = START;
          else
            next_state = IDLE;
        START:
           if(baud_tick)
               next_state = DATA;
           else
              next_state = START;
        DATA:
           if(bit_count == 7 && baud_tick)
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
        begin
           tx = 1'b1;
           tx_busy = 1'b0;
        end
        START:
        begin
            tx = 1'b0;
            tx_busy = 1'b1;
        end
        DATA:
        begin
           tx=tx_data[bit_count];
           tx_busy = 1'b1;
        end
        STOP:
        begin
            tx = 1'b1;
            tx_busy = 1'b1;
        end
        default:
        begin
           tx = 1'b1;
           tx_busy = 1'b0;
        end
     endcase
  end
  endmodule
        
              
 
   