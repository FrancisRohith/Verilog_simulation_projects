`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2025 16:54:23
// Design Name: 
// Module Name: BOOTH
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


module invert(
    output ib, 
    input b);
    assign ib = ~b;
endmodule

module and2(
    input i0, i1, 
    output o);
    assign o = i0 & i1;
endmodule

module or2(
    input i0, i1, 
    output o);
    assign o = i0 | i1;
endmodule

module xor2(
    input i0, i1, 
    output o);
    assign o = i0 ^ i1;
endmodule

module nand2(
    input i0, i1, 
    output o);
    wire t;
    and2 and2_0 (i0, i1, t);
    invert invert_0 (o, t);
endmodule

module nor2(
    input i0, i1, 
    output o);
    wire t;
    or2 or2_0 (i0, i1, t);
    invert invert_0 (o, t);
endmodule

module xnor2(
    input i0, i1, 
    output o);
    wire t;
    xor2 xor2_0 (i0, i1, t);
    invert invert_0 (o, t);
endmodule

module and3(
    input i0, i1, i2,
    output o);
    wire t;
    and2 and2_0(i0, i1, t);
    and2 and2_1(t, i2, o);
endmodule

module or3(
    input i0, i1, i2,
    output o);
    wire t;
    or2 or2_0(i0, i1, t);
    or2 or2_1(t, i2, o);
endmodule

module nor3(
    input i0, i1, i2,
    output o);
    wire t;
    or2 or2_0(i0, i1, t);
    nor2 nor2_0(t, i2, o);
endmodule

module nand3(
    input i0, i1, i2,
    output o);
    wire t;
    and2 and2_0(i0, i1, t);
    nand2 nand2_0(t, i2, o);
endmodule

module xor3(
    input i0, i1, i2,
    output o);
    wire t;
    xor2 xor2_0(i0, i1, t);
    xor2 xor2_1(t, i2, o);
endmodule

module xnor3(
    input i0, i1, i2,
    output o);
    wire t;
    xor2 xor2_0(i0, i1, t);
    xnor2 xnor2_0(t, i2, o);
endmodule

module fa(
    input i0, i1, cin,
    output sum, cout);
    wire t0, t1, t2;
    xor3 _i0(i0, i1, cin, sum);
    and2 _i1(i0, i1, t0);
    and2 _i2(i1, cin, t1);
    and2 _i3(cin, i0, t2);
    or3 _i4(t0, t1, t2, cout);
endmodule

module Adder(
    input [7:0] a, b, 
    output [7:0] sum);
    
    wire cout;
    wire [7:0] q;
    fa fa1(a[0], b[0], 1'b0, sum[0], q[0]);
    fa fa2(a[1], b[1], q[0], sum[1], q[1]);
    fa fa3(a[2], b[2], q[1], sum[2], q[2]);
    fa fa4(a[3], b[3], q[2], sum[3], q[3]);
    fa fa5(a[4], b[4], q[3], sum[4], q[4]);
    fa fa6(a[5], b[5], q[4], sum[5], q[5]);
    fa fa7(a[6], b[6], q[5], sum[6], q[6]);
    fa fa8(a[7], b[7], q[6], sum[7], cout);
endmodule

module subractor(
    input [7:0] a, b,
    output [7:0] sum);
    
        wire [7:0] ib, q;
        wire cout;
        invert b1(ib[0], b[0]);
        invert b2(ib[1], b[1]);
        invert b3(ib[2], b[2]);
        invert b4(ib[3], b[3]);
        invert b5(ib[4], b[4]);
        invert b6(ib[5], b[5]);
        invert b7(ib[6], b[6]);
        invert b8(ib[7], b[7]);
        
        fa fa1(a[0], ib[0], 1'b1, sum[0], q[0]);
        fa fa2(a[1], ib[1], q[0], sum[1], q[1]);
        fa fa3(a[2], ib[2], q[1], sum[2], q[2]);
        fa fa4(a[3], ib[3], q[2], sum[3], q[3]);
        fa fa5(a[4], ib[4], q[3], sum[4], q[4]);
        fa fa6(a[5], ib[5], q[4], sum[5], q[5]);
        fa fa7(a[6], ib[6], q[5], sum[6], q[6]);
        fa fa8(a[7], ib[7], q[6], sum[7], cout);
endmodule

module booth_step(
    input signed [7:0] a, Q, m,
    input signed q0,
    output reg signed [7:0] f8, l8,
    output reg cq0);
    
        wire [7:0] add_am, sub_am;
        Adder add(a, m, add_am);
        subractor sub(a, m, sub_am);
        always @* begin
            if(Q[0] == q0) begin
                cq0 = Q[0];
                l8 = Q>>1;
                l8[7] = a[0];
                f8 = a>>1;
                if(a[7] == 1)
                    f8[7] = 1;
                end
                
            else if(Q[0] == 1 && q0 == 0) begin 
                cq0 = Q[0];
                l8 = Q>>1;
                l8[7] = sub_am[0];
                f8 = sub_am>>1;
                if(sub_am[7] == 1)
                    f8[7] = 1;
                end
                
            else begin 
                cq0 = Q[0];
                l8 = Q>>1;
                l8[7] = add_am[0];
                f8 = add_am>>1;
                if(add_am[7] == 1)
                    f8[7] = 1;
                end
           end
endmodule

module BOOTH(
    input signed [7:0] a, b,
    output signed [15:0] c
    );
    wire signed[7:0] Q1, Q2 ,Q3, Q4, Q5, Q6, Q7, m, A0, A1, A2, A3, A4, A5, A6, A7, q0;
    wire qout;
    
    booth_step s1(8'b00000000, a, b, 1'b0, A1, Q1, q0[1]);
    booth_step s2(A1, Q1, b, q0[1], A2, Q2, q0[2]);
    booth_step s3(A2, Q2, b, q0[2], A3, Q3, q0[3]);
    booth_step s4(A3, Q3, b, q0[3], A4, Q4, q0[4]);
    booth_step s5(A4, Q4, b, q0[4], A5, Q5, q0[5]);
    booth_step s6(A5, Q5, b, q0[5], A6, Q6, q0[6]);
    booth_step s7(A6, Q6, b, q0[6], A7, Q7, q0[7]);
    booth_step s8(A7, Q7, b, q0[7], c[15:8], c[7:0], qout);
     
endmodule
