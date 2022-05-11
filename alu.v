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
    input [31 : 0]a;//32λ���룬������1
    input [31 : 0]b;//32λ���룬������2
    input [3 : 0]aluc;//4λ���룬����alu�Ĳ���
    output [31 : 0]r;//32λ�������a��b����alucָ���Ĳ�������
    output zero;//0��־λ
    //output carry;//��λ��־��
    output negative;//������־��
    output overflow;//�����־��
    
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
        casex(aluc)//alu���ƵĲ���
            4'b0000://�޷��ţ��ӷ�
                begin
                    r = a + b;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    //carry = ((a[31] == 1) || (b[31] == 1) && (r[31] == 0)) ? 1 : 0;//���λ����1���ҽ�����λΪ0
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b0010://�з��ţ��ӷ�
                begin
                    sr = sa + sb;
                    r = sr;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���������λΪ1������1
                    //overflow = ((a[31] == b[31]) && (a[31] != r[31])) ? 1 : 0;//ͬ����ӷ��ű�ʱ������1
                    overflow = 1'b0;
                end
            4'b0001://�޷��ţ�����
                begin
                    r = a - b;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    //carry = (a < b) ? 1 : 0;
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b0011://�з��ţ�����
                begin
                    sr = sa -sb;
                    r = sr;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���������λΪ1������1
                    //overflow = ((a[31] != b[31]) && (a[31] != r[31])) ? 1 : 0;//��������������ű�ʱ������1
                    overflow = 1'b0;
                end
            4'b0100://��
                begin
                    r = a & b;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b0101://��
                begin
                    r = a | b;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b0110://���
                begin
                    r = a ^ b;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b0111://���
                begin
                    r = ~(a | b);
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b100x://�ø�λ������
                begin
                    r = {b[15:0], 16'b0};
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b1011://�з��ţ��Ƚ�
                begin
                    r = (sa < sb) ? 1 :0;
                    zero = (a == b) ? 1 : 0;//������ȣ�����1
                    negative = (sa < sb) ? 1 :0;
                    overflow=1'b0;
                end
            4'b1010://�޷��ţ��Ƚ�
                begin
                    r = (a < b) ? 1 : 0;
                    zero = (a == b) ? 1 : 0;//������ȣ�����1
                    //carry = (a < b) ? 1 : 0;
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b1100://��������
                begin
                    sr = sb >>> sa;
                    r = sr;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    //carry = b[a-1];//���һ�����Ƴ���λ
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b111x://�������߼�����
                begin
                    r = b << a;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    carry = b[32-a];//���һ�����Ƴ���λ
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            4'b1101://�߼�����
                begin
                    r = b >> a;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    //carry = b[a-1];//���һ�����Ƴ���λ
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
            default://Ĭ���޷��żӷ�
                begin
                    r = a + b;
                    zero = (r == 32'b0) ? 1 : 0;//������Ϊ0������1
                    //carry = ((a[31] == 1||b[31] ==1) && r[31] == 0) ? 1 : 0;//���λ����1���ҽ�����λΪ0
                    negative = (r[31] == 1) ? 1 : 0;//���λΪ1������1
                    overflow=1'b0;
                end
        endcase
    end//of always
endmodule
