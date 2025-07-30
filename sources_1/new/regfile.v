`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 12:43:39
// Design Name: 
// Module Name: regfile
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


module regfile( input clk , regWrite,
 input[3:0] ra1, ra2 ,wa3 ,
  input[31:0] wd3 , r15 ,
   output [31:0] rd1,rd2);

  // ra1, ra2 is for read operation and wa3 is for write 
  reg [31:0] reg_file [14:0]; 
  always@(posedge clk )begin 
   if (regWrite && wa3 != 4'b1111) reg_file[wa3] <= wd3;      // we make sure that wa3 is not 15 because we can't write to r15.
   
  end  
  assign rd1 = (ra1==4'b1111)? r15 : reg_file[ra1];
  assign rd2 = (ra2==4'b1111)? r15 : reg_file[ra2];
  
 
endmodule
