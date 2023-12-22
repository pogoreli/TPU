`timescale 1ns / 1ps

module multiply(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    logic signA, signB;
    logic [7:0]  exponentA, exponentB;
    logic [23:0] mantissaA, mantissaB;
    
    logic signOut;
    logic [7:0] exponentOut;
    logic [22:0] mantissaOut;
    
    logic [7:0] exponentNotNormalized;
    logic [47:0] mantissaNotNormalized; //24bit*24bit=48
    
//    logic [5:0] shiftBy;
    logic [7:0] shiftBy;
    logic [6:0] bias = 7'd127;
    
    always_comb begin
        signA = inputA[31];
        signB = inputB[31];
        
        exponentA = inputA[30:23] - bias;
        exponentB = inputB[30:23] - bias;
        
        mantissaA = {1'b1, inputA[22:0]};
        mantissaB = {1'b1, inputB[22:0]};
        
        $display("Mantissa A %b ", mantissaA, " Exponent A %b ", exponentA, " Sign A %b ", signA);
        $display("Mantissa B %b ", mantissaB, " Exponent B %b ", exponentB, " Sign B %b ", signB);
        
        signOut = signA ^ signB;
        
        exponentNotNormalized = exponentA + exponentB;
        mantissaNotNormalized = mantissaA * mantissaB;
        
        $display("Mantissa not normalized %b ", mantissaNotNormalized, " Exponent not normalized %b ", exponentNotNormalized, " Sign out %b ", signOut);
        
        shiftBy = 0;
        
        if (mantissaNotNormalized[47] == 1) begin
            exponentNotNormalized = exponentNotNormalized + 1;
        end else begin
            for(int i = 0; i < 48; i++) begin
                if(mantissaNotNormalized[47] == 0) begin
                    mantissaNotNormalized = mantissaNotNormalized<<1;
                    exponentOut = exponentOut + 1;
                end
            end
        end
        
        mantissaOut = mantissaNotNormalized[46:24];
        exponentOut = exponentNotNormalized + shiftBy + bias;
        $display("Shift by %b ", shiftBy);
        $display("Mantissa out %b ", mantissaOut, " Exponent out %b ", exponentOut, " Sign out %b ", signOut);
        
        out = {signOut, exponentOut[7:0], mantissaOut};
    end
endmodule