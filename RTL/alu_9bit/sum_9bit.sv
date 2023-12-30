`timescale 1ns / 1ps

module sum_9bit(
    input logic [8:0] inputA, inputB,
    output logic [8:0] out
    );
    
    logic signA, signB;
    logic [7:0] valueA, valueB;
    
    logic outSign;
    logic [7:0] outValue;
    
    always_comb begin
        signA = inputA[8];
        signB = inputB[8];
        
        valueA = inputA[7:0];
        valueB = inputB[7:0];
    
        if(signA == signB) begin
            outValue = valueA + valueB;
            outSign = signA;
        end else begin
            if(valueA < valueB) begin
                outValue = valueB - valueA;
                outSign = signB;
            end else begin
                outValue = valueA - valueB;
                outSign = signA;
            end
        end
        
        out = {outSign, outValue};
     end
endmodule
