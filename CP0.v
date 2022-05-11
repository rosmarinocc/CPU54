`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 08:40:46
// Design Name: 
// Module Name: CP0
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


module CP0( 
    input clk, 
    input rst, 
    input mfc0,            // CPU instruction is Mfc0 
    input mtc0,            // CPU instruction is Mtc0 
    input [31 : 0] pc, 
    input [4 : 0] Rd,          // Specifies Cp0 register 
    input [31 : 0] wdata,      // Data from GP register to replace CP0 register 
    input exception, 
    input eret,             // Instruction is ERET (Exception Return) 
    input [4 : 0] cause, 
    
    output [31 : 0] rdata,      // Data from CP0 register for GP register 
    //output [31 : 0] status, 
    
    output [31 : 0]exc_addr    // Address for PC at the beginning of an exception 
    ); 

    parameter    STATUS = 5'b01100, CAUSE = 5'b01101, EPC = 5'b01110;
    parameter    SYSCALL = 4'b1000, BREAK = 4'b1001, TEQ = 4'b1101, IE = 0;
    
    reg [31 : 0] CP0 [31 : 0];
    wire [31 : 0] status;
    assign status =  CP0[STATUS];
    
    assign exc_addr = eret ? CP0[EPC] : 32'h00400004;
    assign rdata = mfc0 ? CP0[Rd] : 0;

    always @(posedge clk or posedge rst)
    begin
        if(rst==1)
        begin        
            CP0[0] <= 32'b0; CP0[1] <= 32'b0; CP0[2] <= 32'b0; CP0[3] <= 32'b0;
            CP0[4] <= 32'b0; CP0[5] <= 32'b0; CP0[6] <= 32'b0; CP0[7] <= 32'b0;
            CP0[8] <= 32'b0; CP0[9] <= 32'b0; CP0[10] <= 32'b0; CP0[11] <= 32'b0;
            CP0[12] <= 32'b0; CP0[13] <= 32'b0; CP0[14] <= 32'b0; CP0[15] <= 32'b0;
            CP0[16] <= 32'b0; CP0[17] <= 32'b0; CP0[18] <= 32'b0; CP0[19] <= 32'b0; 
            CP0[20] <= 32'b0; CP0[21] <= 32'b0; CP0[22] <= 32'b0; CP0[23] <= 32'b0; 
            CP0[24] <= 32'b0; CP0[25] <= 32'b0; CP0[26] <= 32'b0; CP0[27] <= 32'b0;
            CP0[28] <= 32'b0; CP0[29] <= 32'b0; CP0[30] <= 32'b0; CP0[31] <= 32'b0;
        end              
        else 
        begin  
            if(mtc0)
                CP0[Rd] <= wdata;
            else if(exception)
                begin
                    CP0[EPC] <= pc;
                    CP0[STATUS] <= status << 5;
                    CP0[CAUSE]  <= {25'b0,cause,2'b0};
                end
            else if(eret)               
                CP0[STATUS] <= status>>5;
            else
                ;
        end
    end            
    
endmodule
