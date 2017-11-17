`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2017 11:59:14 AM
// Design Name: 
// Module Name: top
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


module top (clk_p, clk_n, col, row, led);
    input wire clk_p;
    input wire clk_n;
    input wire [4:0] col;
    output wire [4:0] row;
    output reg [15:0] led;
    reg [2:0] rowcount = 0;
    reg [17:0] count = 0;
    reg [24:0] btn = 0;
    wire clk;
    clk_wiz_0 wiz (.clk_in1_p(clk_p), .clk_in1_n(clk_n), .clk_out1(clk));
    always@(posedge clk)
        if (count == 199999) begin
            count <= 0;
            if (rowcount >= 4) begin
                rowcount <= 0;
                led <= btn[15:0];
            end else
                rowcount <= rowcount + 1;
        end else begin
            count <= count + 1;
            if (count == 99999)
                btn <= {btn[19:0], col};
        end
    genvar i;
    generate for (i=0; i<5; i=i+1) begin : IDX
        assign row[i] = (rowcount == i) ? 0 : 1'bZ;
    end endgenerate
endmodule
