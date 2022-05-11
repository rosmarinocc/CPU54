`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 00:32:54
// Design Name: 
// Module Name: pcreg
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


module pcreg #(parameter init_addr=32'h0)
(
        input clk,
        input rst,
        input ena,
        input [31:0] data_in,
        output reg [31:0] data_out
        );

    always @ (negedge clk, posedge rst) begin
        if (rst) begin
            data_out <= init_addr;
        end
        else if (ena) begin
            data_out <= data_in;
        end
    end
endmodule
