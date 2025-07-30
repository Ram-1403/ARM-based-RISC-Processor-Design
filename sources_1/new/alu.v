`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 13:20:05
// Design Name: 
// Module Name: alu
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


module alu( 
input [31:0]srcA , srcB,
input [1:0]alu_control,
output reg  [31:0]alu_result ,
output reg negative,
output zero,
output reg  carry,overflow
    );
    always@(*)begin 
    case(alu_control)
    2'b00: begin   //AND OPERATION
    alu_result = srcA & srcB ;
    carry=0;
    overflow=0;
    end 
    
    2'b01: begin    // OR opertion 
    alu_result = srcA | srcB ;
    carry = 0;
    overflow =0;
    end 
    
    2'b10: begin    // ADD 
    {carry,alu_result} = srcA +srcB;
    overflow=carry;
    end 
    
    2'b11: begin  //SUB
    {carry,alu_result} = srcA -srcB;
    overflow=carry;
    end
    
    default: begin 
    alu_result =32'b0;
    overflow=0;
    carry=0;
    end 
    endcase
    end 
    assign zero =(alu_result==32'b0)? 1'b1 : 1'b0;  // different from given (result) and no negative handled here .
    
    // also overflow is not same as carry overflow if for signed number exceeding 32 bit .
endmodule
