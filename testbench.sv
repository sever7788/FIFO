module test
  #(parameter width = 4, length = 5)
  (output logic clk,
   output logic rstn,
   output logic push,
   output logic pop,
   output logic [width-1:0] data,
   input logic full,
   input logic empty,
   input logic [width-1:0] out,
   input logic [width-1:0] SRAM [length-1:0]
);
  timeunit 1ns/1ns;
  
  FIFO  #(.width(4), .length(5)) dut(.*);
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, test);
    clk = 0;
    rstn = 0;
    push = 0;
    pop = 0;
    data = 0;
	  #10 rstn = 1;
    push = 1;
   
    for(int i = 1; i < 7; i++ ) begin
      data = i;
      #10;
    end
    push = 0;
    #5;
    pop = 1;
    #60 push = 1;
    for(int i = 1; i < 7; i++ ) begin
      data = i;
      #10;
    end
    #200 $finish;
  end
 
endmodule: test




