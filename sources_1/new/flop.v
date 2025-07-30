`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 14:20:58
// Design Name: 
// Module Name: flop
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


module flop( 
input clk, reset,
input [31:0] d,
output reg  [31:0] q
    );
    always@(posedge clk or posedge reset)
    begin 
    if (reset) q<=32'b0;
    else q<=d;
    
    end 
endmodule
