`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 17:14:05
// Design Name: 
// Module Name: decoder
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

// x may cause problem in synthesis while implementing on fpga board.
module decoder(input [1:0]op ,
 input[5:0]funct ,
 input [3:0]rd,
 output reg regW,memW,mem_to_reg,alu_src,
 output  reg[1:0]imm_src,reg_src,alu_control,flagW,
 output pcs

    );
    reg branch,alu_op;
    reg[9:0]control;
    always@(*)begin 
    casex(op)
    2'b00:
    begin 
    if(funct[5])control = 10'b0011001x01;
    else control = 10'b0000xx1001;
    end
    2'b01: 
    begin
    if(funct[0]) control = 10'b0101011x00;
    else control = 10'b0x11010100;
    end
    2'b10: begin
    control = 10'b1001100x10;
    branch=1'b1;
    end
    default: control = 10'bx;
    endcase
    {branch,mem_to_reg,memW,alu_src,imm_src,regW,reg_src,alu_op} = control;
 
    
    
    end 
       // pcs block
    assign pcs =((rd==4'b1111) & regW) | branch;
    
    always@(*)
    begin
    if(alu_op)
    begin 
    casex(funct[4:1])
    4'b0100: alu_control=2'b00;  //add
    4'b0010: alu_control=2'b01;  //sub
    4'b0000: alu_control=2'b10;  //and
    4'b1100: alu_control=2'b11;    //or
    default: alu_control = 2'bx;
    endcase
    
    flagW[1] =funct[0];
    flagW[0] = funct[0] &(alu_control==2'b00 | alu_control ==2'b01);
    end 
    else begin 
    alu_control = 2'b00;
    flagW = 2'b00;
    end 
    
    
    end 
    
    
endmodule
