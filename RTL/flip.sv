`timescale 1ns / 1ps

module flip(
    input logic[31:0] inputA,
    output logic [31:0] out
    );
    
    always_comb begin
        out = {~inputA[31], inputA[30:0]};
    end
endmodule
