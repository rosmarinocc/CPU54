`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 15:34:50
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input rst,
    input [31:0] inst,//IMEM获得的指令
    input [31:0] DM_out,//DMEM读到的数据
    
    output DM_ena,
    output  DM_we,
    output [31:0] DM_in,//写入DMEM的数据
    output [10:0] DM_waddr,//DMEM写入地址
    output [2:0] data_w,
    output [2:0] data_sign,
    output [31:0] IM_addr,
    output [31:0] PC//当前指令地址
    );
      wire [5:0] op     = inst[31:26];
      wire [4:0] ins_rs = inst[25:21];
      wire [4:0] ins_rt = inst[20:16];
      wire [4:0] ins_rd = inst[15:11];
      wire [4:0] shamt  = inst[10:6];
      wire [5:0] func   = inst[5:0];
      wire [15:0] immediate = inst[15:0];
      /*指令译码*/
    wire ADD,ADDU,SUB,SUBU,AND,OR,
        XOR,NOR,SLT,SLTU,SLL,SRL,
        SRA,SLLV,SRLV,SRAV,JR,ADDI,
        ADDIU,ANDI,ORI,XORI,LW,SW,
        BEQ,BNE,SLTI,SLTIU,LUI,J,
        JAL,CLZ,DIVU,ERET,JALR,LB,
        LBU,LHU,SB,SH,LH,MFC0,
        MFHI,MFLO,MTC0,MTHI,MTLO,MUL,
        MULTU,SYSCALL,TEQ,BGEZ,BREAK,DIV;
             
    INST_DECODER inst_decoder(
        op,
        func,
        inst_rs,
        ADD,ADDU,SUB,SUBU,AND,OR,
        XOR,NOR,SLT,SLTU,SLL,SRL,
        SRA,SLLV,SRLV,SRAV,JR,ADDI,
        ADDIU,ANDI,ORI,XORI,LW,SW,
        BEQ,BNE,SLTI,SLTIU,LUI,J,
        JAL,CLZ,DIVU,ERET,JALR,LB,
        LBU,LHU,SB,SH,LH,MFC0,
        MFHI,MFLO,MTC0,MTHI,MTLO,MUL,
        MULTU,SYSCALL,TEQ,BGEZ,BREAK,DIV
    );
    
    /*alu*/
     wire ZF, SF, OF;
     wire [3:0] ALUC;
     wire [31:0] rd, rs, rt, A, B, ALU_out;
     
     assign A = (SLL || SRL || SRA) ? shamt : rs;
     assign B = (ADDI || ADDIU || LW || SW || LB || LBU || SB || LH || LHU || SH || SLTI || SLTIU) ? {{16{immediate[15]}},immediate[15:0]} :
       (ANDI || ORI || XORI || LUI) ? immediate : BGEZ ? 32'b0 : rt;
     assign ALUC[0] = SUB || SUBU || OR || ORI || NOR || SLT || SLTI || SRL || SRLV || BEQ || BNE;
     assign ALUC[1] = ADD || ADDI || SUB || XOR || XORI || NOR || SLT || SLTI || SLTU || SLTIU || SLL || SLLV;
     assign ALUC[2] = AND || ANDI || OR || XOR || XORI || ORI || NOR || SLL || SLLV || SRL || SRLV || SRA || SRAV;
     assign ALUC[3] = LUI || SLT || SLTI ||SLTU || SLTIU || SRA || SRAV || SLL || SLLV || SRL || SRLV;

      alu alu_inst(
         .a(A),
         .b(B),
         .aluc(ALUC),
         
         .r(ALU_out),
         .zero(ZF),
         .negative(SF),
         .overflow(OF)
     );
     
     /*乘除法器*/
     wire [31:0] Hi_t;
     wire [31:0] mul_out;
     wire [31:0] Hi,Lo;
     wire [31:0] mul_Hi,div_Hi,divu_Hi;
     wire [31:0] mul_Lo,div_Lo,divu_Lo;
     wire [31:0] next_Hi,next_Lo;
     wire Lo_ena,Hi_ena;
     wire busy;
 
     pcreg lo(clk, rst, Lo_ena, next_Lo, Lo);
     pcreg hi(clk, rst, Hi_ena, next_Hi, Hi);
     MUL mul_inst(MUL, rst, rs, rt, {Hi_t, mul_out});
     MULTU multu_inst(rst, rs, rt, {mul_Hi, mul_Lo});
     DIV div_inst(.dividend(rs), .divisor(rt), .start(DIV & ~busy), .reset(rst), .q(div_Hi), .r(div_Lo), .busy(busy));   
     DIVU divu_inst(.dividend(rs), .divisor(rt), .start(DIVU & ~busy), .reset(rst), .q(divu_Hi), .r(divu_Lo), .busy(busy));
    
      assign next_Lo = MTLO ? rs : MULTU ? mul_Lo : DIV ? div_Lo : DIVU ? divu_Lo : 32'bz;
      assign next_Hi = MTHI ? rs : MULTU ? mul_Hi : DIV ? div_Hi : DIVU ? divu_Hi : 32'bz;
      assign Lo_ena = MTLO || MULTU || DIV || DIVU;
      assign Hi_ena = MTHI || MULTU || DIV || DIVU;
     
     /*clz*/
     wire [31:0] clz_out;
     CLZ clz_inst(
        .a(rs),
        .r(clz_out)
     );
     
     /*CP0*/
     wire [31:0] cp0_out, exc_addr;
     wire [4 :0] cause = SYSCALL ? 5'b01000 : BREAK ? 5'b01001 : TEQ ? 5'b01101 : 5'bx;
     wire exception = SYSCALL | BREAK | (TEQ && ZF);
     CP0 cp0_inst(
        .clk(clk), 
        .rst(rst), 
        .mfc0(MFC0), 
        .mtc0(MTC0), 
        .pc(PC), 
        .Rd(inst_rd), 
        .wdata(rt), 
        .exception(exception), 
        .eret(ERET), 
        .cause(cause), 
        .rdata(cp0_out), 
        .exc_addr(exc_addr)
    );
    
    /*PC*/
    wire [31:0]NPC_final;
    MUX_NPC mux_pc_inst(
     PC,inst,exc_addr,rs,busy,
     BEQ,ZF,BNE,BGEZ,SF,JAL,J,JR,JALR,SYSCALL,ERET,BREAK,TEQ,
     NPC_final
    );
    pcreg #(32'h0040_0000)program_counter(clk, rst,1'b1, NPC_final, PC);
    
    /*regfiles*/
    wire rf_wena = !(JR || SW || SB || SH || BEQ || BNE || J || DIVU || MTC0);
    wire [4:0] rd_addr;
    Regfiles cpu_ref(clk, rst, rf_wena, ins_rs, ins_rt, rd_addr, rd, rs, rt);
    assign rd_addr = JAL ? 5'h1f :
                    (ADDI || ADDIU || ANDI || ORI || XORI || LW || SW || LB || LBU || SB || LH || LHU || SH || SLTI || SLTIU || LUI || MFC0) ? ins_rt : ins_rd;
        
    assign rd = (JAL || JALR) ? PC + 4 :
                    (LW||LH||LHU||LB||LBU) ? DM_out : MUL ? mul_out : MFLO ? Lo : MFHI ? Hi : CLZ ? clz_out : MFC0 ? cp0_out : ALU_out;   
   
    /*IMEM*/
    assign IM_addr=PC-32'h0040_0000;
    
    /*DMEM*/
    assign DM_ena=LW||SW||LB||LBU||LH||LHU||SB||SH;
    assign DM_we=SW||SB||SH;
    assign DM_waddr=ALU_out-32'h1001_0000;
    assign DM_in=rt;
    assign data_w=(LW||SW)?4:(LH||LHU||SH)?2:1;
    assign data_sign=(LHU||LBU)?0:1;
     
        
endmodule
