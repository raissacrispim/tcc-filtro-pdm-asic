`timescale 1ns/1ps
module tb;
  reg a; wire [1:0] y; wire z;
  mini dut (.a(a), .y(y), .z(z));
  initial begin a = 0; #10 a = 1; #10 $finish; end
  always @(y or z) $display("t=%0.3f ns  y=%b z=%b", $realtime, y, z);
endmodule
