`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 14:15:00
// Design Name: 
// Module Name: decoder
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


module decoder(
    input [4:0] iData,
    input iEna,
    output reg [31:0] oData
);
    always@(*) begin
        oData = 0;
        if(iEna)
            oData[iData]=1;
        else
            oData[iData]=0;
    end
    
endmodule
