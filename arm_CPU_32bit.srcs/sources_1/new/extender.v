`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 12:16:29
// Design Name: 
// Module Name: extender
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


module extender(input [23:0]instr , input [1:0]ImmSrc,output reg [31:0]ExtImm
    );
    always@(*) begin 
    case(ImmSrc)
    2'b00: ExtImm = {24'b0 ,instr[7:0]};     //this is bit extention in case of data processing .
    2'b01 : ExtImm = {20'b0 , instr[11:0]};        // this for memory instr , extention of 12 bit offset.
    2'b10 : ExtImm = {{6{instr[23]}}, instr[23:0] ,2'b00};   // sign extention in case of branch , and left shift of offset.
    default : ExtImm = 32'bx;
    endcase
    end 
    
endmodule
 