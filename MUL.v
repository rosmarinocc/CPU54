`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/09 00:52:25
// Design Name: 
// Module Name: MUL
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
module MUL(
    input clk,
    input reset,
    input [31:0] a,
    input [31:0] b, 
    output [63:0] z
);
    integer i,j;
    reg [31:0] c[31:0];
    wire [31:0]u=32'hffffffff;
    wire [63:0] sum1,carry1,sum2,carry2,sum3,carry3,sum4,carry4,sum5,carry5,sum6,carry6,sum7,carry7,sum8,carry8,sum9,carry9,sum10,carry10,
    sum11,carry11,sum12,carry12,sum13,carry13,sum14,carry14,sum15,carry15,sum16,carry16,sum17,carry17,sum18,carry18,sum19,carry19,sum20,carry20,
    sum21,carry21,sum22,carry22,sum23,carry23,sum24,carry24,sum25,carry25,sum26,carry26,sum27,carry27,sum28,carry28,sum29,carry29,sum30,carry30;

        carry_save_adder csa1(({c[0][31]?u[31:0]:32'b0,c[0]}),({c[1][31]?u[30:0]:31'b0,c[1],1'b0}),({c[2][31]?u[29:0]:30'b0,c[2],2'b0}),sum1,carry1);
        carry_save_adder csa2(({c[3][31]?u[28:0]:29'b0,c[3],3'b0}),({c[4][31]?u[27:0]:28'b0,c[4],4'b0}),({c[5][31]?u[26:0]:27'b0,c[5],5'b0}),sum2,carry2);
        carry_save_adder csa3(({c[6][31]?u[25:0]:26'b0,c[6],6'b0}),({c[7][31]?u[24:0]:25'b0,c[7],7'b0}),({c[8][31]?u[23:0]:24'b0,c[8],8'b0}),sum3,carry3);
        carry_save_adder csa4(({c[9][31]?u[22:0]:23'b0,c[9],9'b0}),({c[10][31]?u[21:0]:22'b0,c[10],10'b0}),({c[11][31]?u[20:0]:21'b0,c[11],11'b0}),sum4,carry4);
        carry_save_adder csa5(({c[12][31]?u[19:0]:20'b0,c[12],12'b0}),({c[13][31]?u[18:0]:19'b0,c[13],13'b0}),({c[14][31]?u[17:0]:18'b0,c[14],14'b0}),sum5,carry5);
        carry_save_adder csa6(({c[15][31]?u[16:0]:17'b0,c[15],15'b0}),({c[16][31]?u[15:0]:16'b0,c[16],16'b0}),({c[17][31]?u[14:0]:15'b0,c[17],17'b0}),sum6,carry6);
        carry_save_adder csa7(({c[18][31]?u[13:0]:14'b0,c[18],18'b0}),({c[19][31]?u[12:0]:13'b0,c[19],19'b0}),({c[20][31]?u[11:0]:12'b0,c[20],20'b0}),sum7,carry7);
        carry_save_adder csa8(({c[21][31]?u[10:0]:11'b0,c[21],21'b0}),({c[22][31]?u[9:0]:10'b0,c[22],22'b0}),({c[23][31]?u[8:0]:9'b0,c[23],23'b0}),sum8,carry8);
        carry_save_adder csa9(({c[24][31]?u[7:0]:8'b0,c[24],24'b0}),({c[25][31]?u[6:0]:7'b0,c[25],25'b0}),({c[26][31]?u[5:0]:6'b0,c[26],26'b0}),sum9,carry9);
        carry_save_adder csa10(({c[27][31]?u[4:0]:5'b0,c[27],27'b0}),({c[28][31]?u[3:0]:4'b0,c[28],28'b0}),({c[29][31]?u[2:0]:3'b0,c[29],29'b0}),sum10,carry10);
    //30 31
        carry_save_adder csa11(sum1,carry1<<1,sum2,sum11,carry11);
        carry_save_adder csa12(carry2<<1,sum3,carry3<<1,sum12,carry12);
        carry_save_adder csa13(sum4,carry4<<1,sum5,sum13,carry13);
        carry_save_adder csa14(carry5<<1,sum6,carry6<<1,sum14,carry14);
        carry_save_adder csa15(sum7,carry7<<1,sum8,sum15,carry15);
        carry_save_adder csa16(carry8<<1,sum9,carry9<<1,sum16,carry16);
        carry_save_adder csa17(sum10,carry10<<1,({c[30][31]?u[1:0]:2'b0,c[30],30'b0}),sum17,carry17);
    //31
        carry_save_adder csa18(sum11,carry11<<1,sum12,sum18,carry18);
        carry_save_adder csa19(carry12<<1,sum13,carry13<<1,sum19,carry19);
        carry_save_adder csa20(sum14,carry14<<1,sum15,sum20,carry20);
        carry_save_adder csa21(carry15<<1,sum16,carry16<<1,sum21,carry21);
        carry_save_adder csa22(sum17,carry17<<1,({(b[31]&&a)?~a[31]:1'b0,c[31],31'b0}),sum22,carry22);
    
        carry_save_adder csa23(sum18,carry18<<1,sum19,sum23,carry23);
        carry_save_adder csa24(carry19<<1,sum20,carry20<<1,sum24,carry24);
        carry_save_adder csa25(sum21,carry21<<1,sum22,sum25,carry25);
    //carry22
        carry_save_adder csa26(sum23,carry23<<1,sum24,sum26,carry26);
        carry_save_adder csa27(carry24<<1,sum25,carry25<<1,sum27,carry27);
    //carry22
        carry_save_adder csa28(sum26,carry26<<1,sum27,sum28,carry28);
    //carry27 carry22
        carry_save_adder csa29(carry28<<1,sum28,carry27<<1,sum29,carry29);
    //carry22   
        carry_save_adder csa30(carry29<<1,sum29,carry22<<1,sum30,carry30); 
    assign z = reset?64'b0:(sum30 + (carry30<<1));

always @(*)begin
    for(i=0;i<31;i=i+1)begin
      for(j=0;j<32;j=j+1)begin
          c[i][j]<=b[i]&a[j];
      end
    end
    c[31]<=b[31]?(~a+1):32'b0;
end
endmodule
    
module carry_save_adder#(parameter DATA_WIDTH=64)(
    input [DATA_WIDTH-1:0]num1,
    input [DATA_WIDTH-1:0]num2,
    input [DATA_WIDTH-1:0]num3,
    output [DATA_WIDTH-1:0] sum,
    output [DATA_WIDTH-1:0]carry_out
    );
    genvar index;
    generate
        for(index=0;index<DATA_WIDTH;index=index+1'b1)
            begin:id_
                assign {carry_out[index], sum[index]} = num1[index]+num2[index]+num3[index];
            end
    endgenerate
endmodule
