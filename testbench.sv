
module test
  #(parameter width = 4, length = 4)
  (output logic clk,
   output logic rstn,
   output logic push,
   output logic pop,
   output logic [width-1:0] data,
   input logic full,
   input logic empty,
   input logic [width-1:0] out 
);
  timeunit 1ns/1ns;
  
  FIFO  #(.width(4), .length(4)) dut(.*);
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, test);
    clk = 0;
    rstn = 0;
    push = 0;
    pop = 0;
    data = 0;
	#15 rstn = 1;
    push = 1;
    for(int i = 0; i < 5; i++ ) begin
      #15 data = i;
    end
    push = 0;
    pop = 1;
    #100 $finish;
  end
 
endmodule: test




