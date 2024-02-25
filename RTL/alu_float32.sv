`timescale 1ns / 1ps

module alu_float32(
    input logic [3:0] select,
    input logic [31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    logic [31:0] A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P;
    
    sum sum(.inputA(inputA), .inputB(inputB), .out(A));
    substract substract(.inputA(inputA), .inputB(inputB), .out(B));
    multiply multiply(.inputA(inputA), .inputB(inputB), .out(C));
    divide divide(.inputA(inputA), .inputB(inputB), .out(D));
    
    ln ln(.inputA(inputA), .inputB(inputB), .out(E));
    exponent exponent(.inputA(inputA), .inputB(inputB), .out(F));
    power power(.inputA(inputA), .inputB(inputB), .out(G));
    min min(.inputA(inputA), .inputB(inputB), .out(H));
    
    max max(.inputA(inputA), .inputB(inputB), .out(I));
    abs abs(.inputA(inputA), .inputB(inputB), .out(J));
    flip flip(.inputA(inputA), .inputB(inputB), .out(K));
    log log(.inputA(inputA), .inputB(inputB), .out(L));
    
    square_root(.inputA(inputA), .inputB(inputB), .out(M));
    root root(.inputA(inputA), .inputB(inputB), .out(N));
    sigmoid sigmoid(.inputA(inputA), .inputB(inputB), .out(O));
    tanh tanh(.inputA(inputA), .inputB(inputB), .out(P));
    
    mux_32bit mux(.select(select), .inputA(A), .inputB(B), .inputC(C), .inputD(D), .inputE(E), .inputF(F), .inputG(G), .inputH(H), .inputI(I), .inputJ(J), .inputK(K), .inputL(L), .inputM(M), .inputN(N), .inputO(O), .inputP(P), .out(out));
endmodule
