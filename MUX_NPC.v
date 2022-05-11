`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 09:40:41
// Design Name: 
// Module Name: MUX_NPC
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


module MUX_NPC(
    input [31:0] PC,
    input [31:0] inst,
    input [31:0] exc_addr,
    input [31:0] rs ,
    input busy,
    input BEQ,ZF,BNE,BGEZ,SF,JAL,J,JR,JALR,SYSCALL,ERET,BREAK,TEQ,

    output [31:0]NPC_final
    );
        
    wire [15:0] immediate=inst[15:0];
    wire [31:0] NPC =    PC+4;
    wire [31:0] offset = ((BEQ&&ZF)||(BNE&&!ZF)||(BGEZ&&(ZF||!SF)))?
                        {{14{immediate[15]}}, immediate[15:0], 2'b0} : 32'bz;
    assign NPC_final =  ((BEQ&&ZF)||(BNE&&!ZF)||(BGEZ&&(ZF||!SF)))?
                        NPC+offset:(JAL||J)?
                        {PC[31:28],inst[25:0],2'b0}:(JR||JALR)?
                        rs:(SYSCALL||ERET||BREAK||TEQ)?exc_addr:
                        busy?PC:NPC;

endmodule