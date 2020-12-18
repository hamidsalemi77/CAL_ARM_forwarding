`timescale 1ns/1ns
module tb();
  
  logic rst,clk, is_forwarding;  
  
  TopModule uut(clk, rst, is_forwarding);
  
  initial begin
    clk = 1;
  end
  
  always
    #10 clk = !clk;
  

  initial begin
   rst =  1;
   is_forwarding = 1;
   #50
   rst = 0;

   
  end
endmodule

