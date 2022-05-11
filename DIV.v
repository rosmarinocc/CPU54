`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 07:48:57
// Design Name: 
// Module Name: DIV
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


module DIV(
    input [31:0] dividend,//被除数
    input [31:0] divisor,//除数
    input start,//启动除法运算
    input clock,
    input reset,
    output [31:0] q,//商
    output [31:0] r,//余数
    output reg busy //除法器忙标志位
    );
    reg [4:0] count;
    reg [31:0] reg_q;
    reg [31:0] reg_r;
    reg [31:0] reg_b;
    reg r_sign;
    //
    wire [32:0] sub_add = r_sign ? ( {reg_r,q[31]} + {1'b0,reg_b} ) : ( {reg_r,q[31]} - {1'b0,reg_b} );
    wire [31:0] reg_r0 = r_sign ? reg_r + reg_b : reg_r;
    assign r=dividend[31]?(~reg_r0+1):reg_r0;
    assign q=(divisor[31]^dividend[31])?(~reg_q+1):reg_q;
    always@(posedge clock or posedge reset)
    begin
         if(reset==1)
         begin
             count<=5'b0;
             busy<=0;            
         end
         else
         begin    
             if(start)
             begin
                 reg_r<=32'b0;
                 r_sign<=0;
                 reg_q<=dividend[31]?(~dividend+1):dividend;
                 reg_b<=divisor[31]?(~divisor+1):divisor;
                 count<=5'b0;
                 busy<=1'b1;
             end
             else if(busy)
             begin
                 reg_r<=sub_add[31:0];
                 r_sign<=sub_add[32];
                 reg_q<={reg_q[30:0],~sub_add[32]};
                 count<=count+5'b1;
                 if(count==5'b11111)
                 begin busy<=0; end
             end
         end
    end
endmodule
