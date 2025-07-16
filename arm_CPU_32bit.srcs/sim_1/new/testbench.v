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
    //reg [31:0] WriteData, DataAdr;
    //reg MemWrite;

    // instantiate device to be tested
    top dut(Clk, reset);

    // initialize test
    initial begin
        reset <= 1;
        #10 reset <= 0;
        clk <= 1;
    end

    // generate clock to sequence tests
    always #5 clk = ~clk;

    initial begin
        #10000
        if (dut.data_mem.RAM[21] == 32'd7) begin
            $display("Test Passed: Memory[84] contains 7");
        end else begin
            $display("Test Failed: Memory[84] = %d, expected 7", dut.dmem.RAM[21]);
        end
        $finish;
    end
endmodule
