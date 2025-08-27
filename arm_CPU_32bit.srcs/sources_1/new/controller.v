`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 22:27:10
// Design Name: 
// Module Name: controller
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


 module controller(input clk, reset,
 input [31:0] instr,
 input [3:0]alu_flag,
 output pc_src,mem_to_reg,reg_write,alu_src,mem_write,
 output [1:0]reg_src,alu_control,imm_src
    );
   wire regW,memW,pcs;
   wire[1:0] flagW;
   decoder deccoder(instr[27:26] ,instr[25:20] ,instr[15:12], regW,memW,mem_to_reg,alu_src,imm_src,
    reg_src,alu_control,flagW, pcs);
    conditional_logic cond_logic(clk,reset, instr[31:28],alu_flag,flagW, regW,memW,pcs,pc_src,reg_write,mem_write);
    
    
endmodule
