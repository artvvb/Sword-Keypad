`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent
// Engineer: Arthur Brown
// 
// Create Date: 11/17/2017 11:59:14 AM
// Module Name: top
// Project Name: Sword Keypad
// Target Devices: Sword Board
// Tool Versions: Vivado 2016.4
// Description: implements a basic algorithm to read the state of the 25-button keypad of the sword board.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (clk_p, clk_n, col, row, led);
    input wire clk_p; // differential positive input clock
    input wire clk_n; // differential negative input clock
    input wire [4:0] col; // column state output from keypad
    output wire [4:0] row; // row input to keypad
    output reg [15:0] led = 0; // leds to display keypad button state
    
    wire clk; // 200 MHz single-ended clock
    clk_wiz_0 wiz (
        .clk_in1_p(clk_p),
        .clk_in1_n(clk_n),
        .clk_out1(clk)
    );
    
    localparam CLOCKS_PER_ROW = 200000;
    reg [2:0] rowcount = 0; // index of the row to check, 0-4, increment 1 per millisecond
    reg [17:0] count = 0; // counter to generate a 1kHz strobe
    reg [24:0] btn = 0; // last state of each button
    always@(posedge clk)
        if (count >= CLOCKS_PER_ROW-1) begin
            count <= 0;
            if (rowcount >= 4)
                rowcount <= 0;
            else
                rowcount <= rowcount + 1;
        end else begin
            count <= count + 1;
            if (count == CLOCKS_PER_ROW/2-1) // halfway through count period
                btn <= {btn[19:0], col}; // capture the state of each button in the indexed row
        end
    
    genvar i;
    generate for (i=0; i<5; i=i+1) begin : IDX
        assign row[i] = (rowcount == i) ? 0 : 1'bZ; // hold row pins that are not currently being tested high impedance to avoid short circuits
    end endgenerate
    
    // the output method could use some work to be able to display the status of the entire keypad, instead of only 16 buttons
    // at end of full capture of button state, output states of buttons R0C0:R0C4, R1C0:R1C4, R2C0:R2C4, R3C0
    always@(posedge clk)
        if (count >= 199999 && rowcount >= 4)
            led <= btn[15:0];
endmodule
