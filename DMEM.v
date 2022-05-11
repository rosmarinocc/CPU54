`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 18:21:23
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input        clk,
    input        ena,//ʹ���ź�
    input        we,//��д�ź�,�ߵ�ƽ����Ч
    input [10:0] DM_addr,
    input [31:0] DM_wdata,
    input [2:0]  data_w,//���ݿ��
    input        data_sign,//�Ƿ�Ϊ�з�����
    output[31:0] DM_rdata
    );
    
    reg [7:0] mem [1023:0];//8bit-1�ֽ�
    //д-������
    always@(posedge clk) begin
        if(ena && we) begin//д
            if(data_w == 1)begin
                mem[DM_addr]<=DM_wdata[7:0];
            end
            else if(data_w == 2)begin
                mem[DM_addr + 1]<=  DM_wdata[15:8];
                mem[DM_addr]    <=  DM_wdata[7:0];
            end
            else if(data_w == 4)begin
                mem[DM_addr + 3]<=  DM_wdata[31:24];
                mem[DM_addr + 2]<=  DM_wdata[23:16];
                mem[DM_addr + 1]<=  DM_wdata[15:8];
                mem[DM_addr]    <=  DM_wdata[7:0];
            end
        end
    end
    //��-�κ�ʱ��
    wire [31:0]rdata4_t;
    wire [31:0]rdata2_t;
    wire [31:0]rdata1_t;
    
    assign rdata4_t={mem[DM_addr+3],mem[DM_addr+2],mem[DM_addr+1],mem[DM_addr]};
    assign rdata2_t=data_sign?   {{16{mem[DM_addr+1][7]}}, mem[DM_addr+1], mem[DM_addr]}:
                                 {16'b0, mem[DM_addr+1], mem[DM_addr]};
    assign rdata1_t=data_sign?  {{24{mem[DM_addr][7]}},mem[DM_addr]}:
                                {24'b0,mem[DM_addr]};


            
    assign DM_rdata=(ena&&~we)?
    (data_w==1)?rdata1_t:
    (data_w==2)?rdata2_t:rdata4_t:
    32'bz;
    
    
endmodule
