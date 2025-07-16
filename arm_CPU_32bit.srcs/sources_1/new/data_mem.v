`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 23:42:01
// Design Name: 
// Module Name: data_mem
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


module data_mem( input clk , enable_write,
input [31:0]address,write_data,
output [31:0] read_data
    );
    reg [31:0] RAM[63:0];
    always@(posedge clk)
    begin 
    if(enable_write)
     RAM[address[31:2]] <= write_data;    // 31:2 because memeory is byte addressable so for accessing 32 bit each tym we divide it by 4 i.e. right shift by 2.
    end 
    
    assign read_data = RAM[address[31:2]];
    
endmodule
