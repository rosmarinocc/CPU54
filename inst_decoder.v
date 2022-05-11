`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 23:31:02
// Design Name: 
// Module Name: inst_decoder
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


module INST_DECODER(
    input [5:0] op,
    input [5:0] func,
    input [4:0] inst_rs,

    output ADD,ADDU,SUB,SUBU,AND,OR,
            XOR,NOR,SLT,SLTU,SLL,SRL,
            SRA,SLLV,SRLV,SRAV,JR,ADDI,
            ADDIU,ANDI,ORI,XORI,LW,SW,
            BEQ,BNE,SLTI,SLTIU,LUI,J,
            JAL,CLZ,DIVU,ERET,JALR,LB,
            LBU,LHU,SB,SH,LH,MFC0,
            MFHI,MFLO,MTC0,MTHI,MTLO,MUL,
            MULTU,SYSCALL,TEQ,BGEZ,BREAK,DIV
    );

            assign ADD   = op == 6'b0 && func == 6'b100000;
            assign ADDU  = op == 6'b0 && func == 6'b100001;
            assign SUB   = op == 6'b0 && func == 6'b100010;
            assign SUBU  = op == 6'b0 && func == 6'b100011;
            assign AND   = op == 6'b0 && func == 6'b100100;
            assign OR    = op == 6'b0 && func == 6'b100101;
             assign XOR   = op == 6'b0 && func == 6'b100110;
             assign NOR   = op == 6'b0 && func == 6'b100111;
             assign SLT   = op == 6'b0 && func == 6'b101010;
             assign SLTU  = op == 6'b0 && func == 6'b101011;
             assign SLL   = op == 6'b0 && func == 6'b000000;
             assign SRL   = op == 6'b0 && func == 6'b000010;
             assign SRA   = op == 6'b0 && func == 6'b000011;
             assign SLLV  = op == 6'b0 && func == 6'b000100;
             assign SRLV  = op == 6'b0 && func == 6'b000110;
             assign SRAV  = op == 6'b0 && func == 6'b000111;
             assign JR    = op == 6'b0 && func == 6'b001000;
             assign ADDI  = op == 6'b001000;
             assign ADDIU = op == 6'b001001;
             assign ANDI  = op == 6'b001100;
             assign ORI   = op == 6'b001101;
             assign XORI  = op == 6'b001110;
             assign LW    = op == 6'b100011;
             assign SW    = op == 6'b101011;
             assign BEQ   = op == 6'b000100;
             assign BNE   = op == 6'b000101;
             assign SLTI  = op == 6'b001010;
             assign SLTIU = op == 6'b001011;
             assign LUI   = op == 6'b001111;
             assign J     = op == 6'b000010;
             assign JAL   = op == 6'b000011;
             assign CLZ   = op == 6'b011100 && func == 6'b100000;
             assign DIVU  = op == 6'b0 && func == 6'b011011;
             assign ERET  = op == 6'b010000 && func == 6'b011000;
             assign JALR  = op == 6'b0 && func == 6'b001001;
             assign LB    = op == 6'b100000;
             assign LBU   = op == 6'b100100;
             assign LHU   = op == 6'b100101;
             assign SB    = op == 6'b101000;
             assign SH    = op == 6'b101001;
             assign LH    = op == 6'b100001;
             assign MFC0  = op == 6'b010000 && func == 6'b0 && inst_rs == 5'b0;
             assign MFHI  = op == 6'b0 && func == 6'b010000;
             assign MFLO  = op == 6'b0 && func == 6'b010010;
             assign MTC0  = op == 6'b010000 && func == 6'b0 && inst_rs == 5'b00100;
             assign MTHI  = op == 6'b0 && func == 6'b010001;
             assign MTLO  = op == 6'b0 && func == 6'b010011;
             assign MUL   = op == 6'b011100 && func == 6'b000010;
             assign MULTU = op == 6'b0 && func == 6'b011001;
             assign SYSCALL=op == 6'b0 && func == 6'b001100;
             assign TEQ   = op == 6'b0 && func == 6'b110100;
             assign BGEZ  = op == 6'b000001;
             assign BREAK = op == 6'b0 && func == 6'b001101;
             assign DIV   = op == 6'b0 && func == 6'b011010;
    
endmodule
