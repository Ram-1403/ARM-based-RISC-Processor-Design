`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2025 18:41:32
// Design Name: 
// Module Name: conditional_logic
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

module conditional_logic( input clk,reset,
input [3:0]cond,
input [3:0]alu_flag,
input [1:0]flagW,
input regW,memW,pcs,
output pc_src,reg_write,mem_write
    );
    wire [1:0]flag_write;
    wire [3:0] alu_flag_check;
    wire condex;
 ff_2bit ff1( clk , reset,flag_write[1],alu_flag[3:2],alu_flag_check[3:2]);
 ff_2bit ff2( clk , reset,flag_write[0],alu_flag[1:0],alu_flag_check[1:0]);
 cond_checker cond_check(cond,alu_flag_check,condex);
 assign flag_write = flagW & {2{condex}};
 assign mem_write = memW & condex;
 assign  reg_write= regW & condex;
 assign pc_src = pcs & condex;
endmodule


module cond_checker(
input [3:0]cond,
input [3:0] alu_flag_check,
output reg CondEx
);
reg neg , zero ,carry, overflow;

always@(*)
begin 
{neg,zero,carry,overflow} = alu_flag_check;
case(cond)
      4'b0000: CondEx = zero; // EQ
      4'b0001: CondEx = ~zero; // NE
      4'b0010: CondEx = carry; // CS
      4'b0011: CondEx = ~carry; // CC
      4'b0100: CondEx = neg; // MI
      4'b0101: CondEx = ~neg; // PL
      4'b0110: CondEx = overflow; // VS
      4'b0111: CondEx = ~overflow; // VC
      4'b1000: CondEx = carry & ~zero; // HI
      4'b1001: CondEx = ~(carry & ~zero); // LS
      4'b1010: CondEx = ~(neg ^overflow); // GE
      4'b1011: CondEx = (neg ^overflow); // LT
      4'b1100: CondEx = ~zero & ~(neg ^overflow); // GT
      4'b1101: CondEx = zero & (neg ^overflow);  // LE
      4'b1110: CondEx = 1'b1; // Always
      default: CondEx = 1'bx; 
    endcase
end 

endmodule

module ff_2bit(input clk,reset,enable,
input [1:0] d,
output reg [1:0]q);
always@(posedge clk)
begin 
if(reset) q<=2'b00;
else if(enable) q<=d;

end 
endmodule 
