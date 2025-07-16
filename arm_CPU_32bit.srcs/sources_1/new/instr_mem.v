`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 23:53:08
// Design Name: 
// Module Name: instr_mem
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


module instr_mem( input [31:0] address,
output [31:0] read_data
    );
    reg [31:0] ROM[63:0];   // 64 block of each 32 bit 
    assign read_data = ROM[address[31:2]];
    initial begin 
    $readmemh("data.xdc", ROM);
    end 
    
endmodule
