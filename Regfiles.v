`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 10:35:15
// Design Name: 
// Module Name: Regfiles
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
module Regfiles(
    input clk, 
    input rst, 
    input we, 
    input [4:0] raddr1, 
    input [4:0] raddr2, 
    input [4:0] waddr, 
    input [31:0] wdata, 
    output reg [31:0] rdata1, 
    output reg [31:0] rdata2 
);

    wire [31:0] array_reg [31:0];

    wire [31:0] pos;
    decoder decoder_inst(.iData(waddr), .iEna(we), .oData(pos));

    assign array_reg[0] = 32'b0;
    genvar i;
    generate 
        for(i=1; i<32; i=i+1)
        begin:p_
            pcreg reg_unit_inst(.clk(~clk), .rst(rst), .ena(pos[i]), .data_in(wdata), .data_out(array_reg[i]));
        end
    endgenerate

    always@(*) 
    begin
        /*if (we && waddr == raddr1) begin
            if(~clk)
                rdata1 = array_reg[raddr1];
            else
                rdata2 = array_reg[raddr2];;
        end
        else if (we && waddr == raddr2) begin
            if(~clk)
                rdata2 = array_reg[raddr2];
            else
                rdata1 = array_reg[raddr1];;
        end
        else*/ 
        if (~clk) begin
            rdata1 = array_reg[raddr1];
            rdata2 = array_reg[raddr2];
        end
    end

endmodule

