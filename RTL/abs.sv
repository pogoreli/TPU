`timescale 1ns / 1ps

module abs(
    input logic[31:0] inputA, inputB,
    output logic [31:0] out
    );
    
    always_comb begin
        out = {1'b0, inputA[30:0]};
    end
endmodule