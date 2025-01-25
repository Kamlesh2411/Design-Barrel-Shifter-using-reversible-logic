

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2024 10:47:14
// Design Name: 
// Module Name: Rmux
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

module Rmux(A,B,C,P,Q,R);
input A,B,C;
output P,Q,R;

	assign P = A;
	assign Q = (~A)&B | A&C;
	assign R = (~A)&C | A&(~B);

endmodule 

module Barrel_Shifter(X,Y,Z);

input [7:0] X;
input [2:0] Y;
output [7:0] Z;
wire [7:0] N,M;
wire [47:0] G;

//  STAGE 1;

    Rmux R1(Y[0],X[0],0,G[0],N[0],G[1]);
    Rmux R2(Y[0],X[1],X[0],G[2],N[1],G[3]);
    Rmux R3(Y[0],X[2],X[1],G[4],N[2],G[5]);
    Rmux R4(Y[0],X[3],X[2],G[6],N[3],G[7]);
    Rmux R5(Y[0],X[4],X[3],G[8],N[4],G[9]);
    Rmux R6(Y[0],X[5],X[4],G[10],N[5],G[11]);
    Rmux R7(Y[0],X[6],X[5],G[12],N[6],G[13]);
    Rmux R8(Y[0],X[7],X[6],G[14],N[7],G[15]);

// STAGE 2 

    Rmux Q1(Y[1],N[0],0,G[16],M[0],G[17]);
    Rmux Q2(Y[1],N[1],0,G[18],M[1],G[19]);
    Rmux Q3(Y[1],N[2],N[0],G[20],M[2],G[21]);
    Rmux Q4(Y[1],N[3],N[1],G[22],M[3],G[23]);
    Rmux Q5(Y[1],N[4],N[2],G[24],M[4],G[25]);
    Rmux Q6(Y[1],N[5],N[3],G[26],M[5],G[27]);
    Rmux Q7(Y[1],N[6],N[4],G[28],M[6],G[29]);
    Rmux Q8(Y[1],N[7],N[5],G[30],M[7],G[31]);

// STAGE 3

    Rmux P1(Y[2],M[0],0,G[32],Z[0],G[33]);
    Rmux P2(Y[2],M[1],0,G[34],Z[1],G[35]);
    Rmux P3(Y[2],M[2],0,G[36],Z[2],G[37]);
    Rmux P4(Y[2],M[3],0,G[38],Z[3],G[39]);
    Rmux P5(Y[2],M[4],M[0],G[40],Z[4],G[41]);
    Rmux P6(Y[2],M[5],M[1],G[42],Z[5],G[43]);
    Rmux P7(Y[2],M[6],M[2],G[44],Z[6],G[45]);
    Rmux P8(Y[2],M[7],M[3],G[46],Z[7],G[47]);

endmodule

module Shiftertb;                 //Testbench Start 
reg [7:0]X;
reg [2:0]Y;
wire[7:0]Z;

    Barrel_Shifter uut(.X(X),.Y(Y),.Z(Z));
    initial begin 
    $display(" Time = %0t, X = %b, Y = %b, Z = %b", $time, X, Y, Z);
    end
    initial begin 
    
    X= 8'b11111111;
    Y=3'b111;
    #10
    
    X= 8'b10101010;
    Y=3'b110;
    #10
    
    X= 8'b01010101;
    Y=3'b101;
    #10
    
    X= 8'b11110000;
    Y=3'b100;
    #10
    
    X= 8'b00001111;
    Y=3'b011;
    #10
    
    $finish;
    end
 
 

endmodule
