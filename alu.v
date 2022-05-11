`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 00:07:36
// Design Name: 
// Module Name: alu
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


module alu(a, b, aluc, r, zero/*, carry*/, negative, overflow);
    input [31 : 0]a;//32位输入，操作数1
    input [31 : 0]b;//32位输入，操作数2
    input [3 : 0]aluc;//4位输入，控制alu的操作
    output [31 : 0]r;//32位输出，由a、b经过aluc指定的操作生成
    output zero;//0标志位
    //output carry;//进位标志符
    output negative;//负数标志符
    output overflow;//溢出标志符
    
    reg [31:0]r;
    reg zero;
    reg carry;
    reg negative;
    reg overflow;
    reg signed [31 : 0]sa;
    reg signed [31 : 0]sb;
    reg signed [31 : 0]sr;
    always @ (a, b, aluc)
    begin
        sa = a;
        sb = b;
        casex(aluc)//alu控制的操作
            4'b0000://无符号，加法
                begin
                    r = a + b;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    //carry = ((a[31] == 1) || (b[31] == 1) && (r[31] == 0)) ? 1 : 0;//最高位存在1，且结果最高位为0
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b0010://有符号，加法
                begin
                    sr = sa + sb;
                    r = sr;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//负数，最高位为1，则置1
                    //overflow = ((a[31] == b[31]) && (a[31] != r[31])) ? 1 : 0;//同号相加符号变时，则置1
                    overflow = 1'b0;
                end
            4'b0001://无符号，减法
                begin
                    r = a - b;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    //carry = (a < b) ? 1 : 0;
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b0011://有符号，减法
                begin
                    sr = sa -sb;
                    r = sr;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//负数，最高位为1，则置1
                    //overflow = ((a[31] != b[31]) && (a[31] != r[31])) ? 1 : 0;//异号相减，结果符号变时，则置1
                    overflow = 1'b0;
                end
            4'b0100://与
                begin
                    r = a & b;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b0101://或
                begin
                    r = a | b;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b0110://异或
                begin
                    r = a ^ b;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b0111://或非
                begin
                    r = ~(a | b);
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b100x://置高位立即数
                begin
                    r = {b[15:0], 16'b0};
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b1011://有符号，比较
                begin
                    r = (sa < sb) ? 1 :0;
                    zero = (a == b) ? 1 : 0;//两者相等，则置1
                    negative = (sa < sb) ? 1 :0;
                    overflow=1'b0;
                end
            4'b1010://无符号，比较
                begin
                    r = (a < b) ? 1 : 0;
                    zero = (a == b) ? 1 : 0;//两者相等，则置1
                    //carry = (a < b) ? 1 : 0;
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b1100://算术右移
                begin
                    sr = sb >>> sa;
                    r = sr;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    //carry = b[a-1];//最后一个被移出的位
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b111x://算术、逻辑左移
                begin
                    r = b << a;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    carry = b[32-a];//最后一个被移出的位
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            4'b1101://逻辑右移
                begin
                    r = b >> a;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    //carry = b[a-1];//最后一个被移出的位
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
            default://默认无符号加法
                begin
                    r = a + b;
                    zero = (r == 32'b0) ? 1 : 0;//运算结果为0，则置1
                    //carry = ((a[31] == 1||b[31] ==1) && r[31] == 0) ? 1 : 0;//最高位存在1，且结果最高位为0
                    negative = (r[31] == 1) ? 1 : 0;//最高位为1，则置1
                    overflow=1'b0;
                end
        endcase
    end//of always
endmodule
