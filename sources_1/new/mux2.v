`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 13:10:06
// Design Name: 
// Module Name: mux2
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


module mux2 #(parameter width=32)(          // default parameter i.e. here 32 must be given otherwise error occur.
input [width-1 : 0]in0 , in1,
input sel,
output [width-1 : 0]out
    );
    assign out = (sel) ?  in1 : in0;
    
endmodule
