`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2025 14:09:27
// Design Name: 
// Module Name: data_path_
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

//15:12 destination reg
module data_path_(input clk,reset ,
input [1:0]reg_src,
input pc_src,mem_to_reg,reg_write,alu_src,
input [1:0]imm_src,alu_control,
input[31:0]instr,read_data,
output [31:0]pc,alu_result,write_data,
output [3:0] alu_flag);

wire [31:0]pc_plus4, pc_plus8,pc_next,srcA,srcB,alu_result, result,ExtImm;
wire [3:0]ra1,ra2;
 
 
 //pc logic 
 mux2 #(32) pc_mux(pc_plus4,result,pc_src,pc_next);
 flop ff(clk ,reset,pc_next,pc);
 adder plus4(pc,32'b100,pc_plus4);
 adder plus8(pc_plus4 ,32'b100,pc_plus8);
 
 // reg logic 
 mux2 #(4) ra1_mux(instr[19:16],4'b1111,reg_src[0],ra1);
 mux2 #(4) ra2_mux(instr[3:0],instr[15:12],reg_src[1],ra2);
 regfile reg_bank(clk,reg_write,ra1,ra2,instr[15:12],result ,pc_plus8,srcA,write_data);
 extender extend(instr[23:0],imm_src,ExtImm);
   
// alu logic 
mux2 #(32) srcB_mux(write_data,ExtImm,alu_src,srcB);
alu ALU_(srcA,srcB,alu_control,alu_result,alu_flag);
mux2 #(32) mem_reg_mux(alu_result,read_data,mem_to_reg,result);

endmodule
