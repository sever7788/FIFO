module FIFO
  #(parameter width = 4, length = 4
   )
 (
   input logic clk,
   input logic rstn,
   input logic push,
   input logic pop,
   input logic [width-1:0] data,
   output logic [$clog2(length-1)-1:0] push_ptr,
   output logic full,
   output logic empty,
   output logic [width-1:0] out 
);
  logic [width-1:0][length-1:0] FIFO;
  logic [$clog2(length-1)-1:0] pop_ptr;
  //logic [$clog2(length-1)-1:0] push_ptr;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      FIFO     <= 16'b0;
      pop_ptr  <= '0;
      push_ptr <= '0;
    end else begin
      if(push && !full) begin
        FIFO[push_ptr] <= data;
        push_ptr <= push_ptr + 1;
      end
      if(pop && !empty) begin
        FIFO[pop_ptr] <= '0;
        pop_ptr <= pop_ptr + 1;
        out <= FIFO[pop_ptr];
      end
    end
  end
  assign full  = FIFO[push_ptr];
  assign empty = !FIFO[pop_ptr];
    
endmodule