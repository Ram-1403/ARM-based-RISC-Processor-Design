`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2025 00:57:06
// Design Name: 
// Module Name: testbench
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




module testbench();
    reg clk;
    reg reset;
    wire [31:0]data_mem_RAM_21;
    //reg [31:0] WriteData, DataAdr;
    //reg MemWrite;
    
    //to debug 
    wire[31:0] pc;
    wire [31:0]instr;
    wire [31:0]R0,R2,R3,R4,R7;
    assign pc = dut.cpu.Data__path.pc;
    assign instr=dut.cpu.Data__path.instr;
    assign R0=dut.cpu.Data__path.reg_bank.reg_file[4'b0000];
    //assign R1=dut.cpu.Data__path.reg_bank.reg_file[1];
    assign R2=dut.cpu.Data__path.reg_bank.reg_file[2];
    assign R3=dut.cpu.Data__path.reg_bank.reg_file[3];
    assign R4=dut.cpu.Data__path.reg_bank.reg_file[4];
    assign R7=dut.cpu.Data__path.reg_bank.reg_file[7];

    // instantiate device to be tested
    top dut(clk, reset ,data_mem_RAM_21
);

    // initialize test
    initial begin
        clk <=0;
        reset <= 1;
        #22 reset <= 0;
        
    end

    // generate clock to sequence tests
    always #5 clk = ~clk;

    initial begin
        #1000
        if (dut.Data_mem.RAM[21] == 32'd7) begin
            $display("Test Passed: Memory[84] contains 7");
        end else begin
            $display("Test Failed: Memory[84] = %d, expected 7", dut.Data_mem.RAM[21]);
        end
        $finish;
    end
endmodule
