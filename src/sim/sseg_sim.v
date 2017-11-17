`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2017 09:46:58 AM
// Design Name: 
// Module Name: sseg_sim
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


module sseg_sim;
    reg clk = 1;
    always #1 clk = ~clk;
    wire ss_dout, ss_clk, ss_en;
    top #("TRUE") sseg (clk, 8'h01234567, ss_dout, ss_clk, ss_en);
    reg [63:0] shift = 0, data = 0;
    always@(posedge ss_clk)
        shift <= {shift[62:0], ss_dout};
    always@(posedge ss_en)
        if (ss_en)
            data <= shift;
endmodule
