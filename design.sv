module FIFO
  #(parameter width = 4, length = 4
   )
 (
   input logic clk,
   input logic rstn,
   input logic push,
   input logic pop,
   input logic [width-1:0] data,
   output logic full,
   output logic empty,
   output logic [length-1:0] SRAM [width-1:0],
   output logic [width-1:0] out 
);
  `define max_ptr length
  `define ptr_len $clog2(length) - 1
  
  //logic [length-1:0] SRAM [width-1:0];
  logic [`ptr_len:0] pop_ptr;
  logic [`ptr_len:0] push_ptr;
  logic [`ptr_len + 1:0] cnt;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      for(int i = 0; i < length; i++)
        SRAM[i] <= '0;
        cnt      <= '0;
        pop_ptr  <= '0;
        push_ptr <= '0;
    end else begin
      if(push && !full) begin
        SRAM[push_ptr] <= data;
        push_ptr <= push_ptr + 1;
        cnt <= cnt + 1;
      end
      if(pop && !empty) begin
        pop_ptr <= pop_ptr + 1;
        cnt <= cnt - 1;
      end
    end
  end
  
  assign full  = cnt == `max_ptr;
  assign empty = ~|cnt;
  assign out = SRAM[pop_ptr];
  //assign out = (empty || !pop) ? 'Z : SRAM[pop_ptr];
  
    
endmodule