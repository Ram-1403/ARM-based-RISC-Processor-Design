`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 00:15:33
// Design Name: 
// Module Name: CPU
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


module CPU(input clk , reset ,
input [31:0]instr , read_data,
output[31:0] pc, alu_result,write_data,    //change in pc width
output mem_write
    );
    wire [1:0] reg_src, imm_src,alu_control;
    wire  pc_src,mem_to_reg,reg_write,alu_src;
    wire [3:0]alu_flag;
    
    data_path_ Data__path(clk,reset ,reg_src, pc_src,mem_to_reg,reg_write,alu_src,
imm_src,alu_control,instr,read_data,pc,alu_result,write_data,
 alu_flag);
 
 controller controler( clk, reset,
  instr,alu_flag, pc_src,mem_to_reg,reg_write,alu_src,mem_write,
reg_src,alu_control,imm_src);
    
endmodule
