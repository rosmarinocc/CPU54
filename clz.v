`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 08:37:46
// Design Name: 
// Module Name: clz
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


module CLZ(
    input [31 : 0] a,//from rs
    output [31 : 0] r 
    );
    reg [31 : 0] tmp;
    assign r = tmp;
    
    always @ (*) 
    begin
          if(a[31])
          tmp = 0;
          else if(a[30])
          tmp = 1;
          else if(a[29])
          tmp = 2;
          else if(a[28])
          tmp = 3;
          else if(a[27])
          tmp = 4;
          else if(a[26])
          tmp = 5;
          else if(a[25])
          tmp = 6;
          else if(a[24])
          tmp = 7;
          else if(a[23])
          tmp = 8;
          else if(a[22])
          tmp = 9;
          else if(a[21])
          tmp = 10;
          else if(a[20])
          tmp = 11;
          else if(a[19])
          tmp = 12;
          else if(a[18])
          tmp = 13;
          else if(a[17])
          tmp = 14;
          else if(a[16])
          tmp = 15;
          else if(a[15])
          tmp = 16;
          else if(a[14])
          tmp = 17;
          else if(a[13])
          tmp = 18;
          else if(a[12])
          tmp = 19;
          else if(a[11])
          tmp = 20;
          else if(a[10])
          tmp = 21;
          else if(a[9])
          tmp = 22;
          else if(a[8])
          tmp = 23;
          else if(a[7])
          tmp = 24;
          else if(a[6])
          tmp = 25;
          else if(a[5])
          tmp = 26;
          else if(a[4])
          tmp = 27;
          else if(a[3])
          tmp = 28;
          else if(a[2])
          tmp = 29;
          else if(a[1])
          tmp = 30;
          else if(a[0])
          tmp = 31;
          else
          tmp = 32;
        end
        
endmodule

