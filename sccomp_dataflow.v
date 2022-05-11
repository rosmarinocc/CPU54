`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 14:39:11
// Design Name: 
// Module Name: sccomp_dataflow
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
module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0]inst,//从指令寄存器中取得的指令码
    output [31:0]pc//当前指令地址
    );

    wire DM_ena;
    wire DM_we;//dmem读写
    wire [10:0] DM_addr;
    wire [2:0] data_w;
    wire data_sign;
    wire [31:0] DM_in;
    wire [31:0] DM_out; 
    wire [31:0] IM_addr;
        
    cpu sccpu(
    .clk(clk_in),
    .rst(reset),
    .inst(inst),
    .DM_out(DM_out),
    
    .DM_ena(DM_ena),
    .DM_we(DM_we),
    .DM_in(DM_in),
    .DM_waddr(DM_addr),
    .data_w(data_w),
    .data_sign(data_sign),
    .IM_addr(IM_addr),
    .PC(pc)
    );
    
    
    DMEM  dmem(
    .clk(clk_in),
    .ena(DM_ena),
    .we(DM_we),
    .DM_addr(DM_addr),
    .data_w(data_w),
    .data_sign(data_sign),
    .DM_wdata(DM_in),
    
    .DM_rdata(DM_out)
    );
    
    

    
    IMEM imem(
    .addr(IM_addr[12:2]),
    .inst(inst)
    );


    
    
    
endmodule
