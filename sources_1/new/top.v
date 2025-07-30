`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 00:36:26
// Design Name: 
// Module Name: top
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


module top(input clk , reset ,output [31:0]data_mem_RAM_21
    );
    wire [31:0]instr,pc,write_data,read_data,alu_result;
    wire mem_write;
    CPU cpu( clk , reset ,instr , read_data,pc, alu_result,write_data, mem_write);
    data_mem Data_mem(clk , mem_write,alu_result,write_data, read_data);
    instr_mem Instr_mem(pc, instr);
     assign data_mem_RAM_21 = Data_mem.RAM[21];
endmodule
