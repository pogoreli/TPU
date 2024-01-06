`timescale 1ns / 1ps

module mux_32bit(
    input logic [3:0] select,
    input logic [31:0] inputA, inputB, inputC, inputD, inputE, inputF, inputG, inputH, inputI, inputJ, inputK, inputL, inputM, inputN, inputO, inputP,
    output logic [31:0] out
    );
    
    always_comb begin
        case (select)
            4'b0000: out = inputA;
            4'b0001: out = inputB;
            4'b0010: out = inputC;
            4'b0011: out = inputD;
            
            4'b0100: out = inputE;
            4'b0101: out = inputF;
            4'b0110: out = inputG;
            4'b0111: out = inputH;
            
            4'b1000: out = inputI;
            4'b1001: out = inputJ;
            4'b1010: out = inputK;
            4'b1011: out = inputL;
            
            4'b1100: out = inputM;
            4'b1101: out = inputN;
            4'b1110: out = inputO;
            4'b1111: out = inputP;
        endcase
    end
endmodule
