`timescale 1ns / 1ps

module max_9bit(
    input logic [8:0] inputA, inputB,
    output logic [8:0] out
    );
    
    always_comb begin
        if(inputA[8] == inputB[8]) begin
            if(inputA[8] == 1) begin
                if(inputA[7:0] > inputB[7:0]) begin
                    out = inputB;
                end else begin
                    out = inputA;
                end
            end else begin
                if(inputA[7:0] > inputB[7:0]) begin
                    out = inputA;
                end else begin
                    out = inputB;
                end
            end
        end else begin
            if(inputA[8] == 1) begin
                out = inputB;
            end else begin
                out = inputA;
            end
        end
    end
    
    always_comb begin
//        $display("Max. In A: %b", inputA, " Input B: %b", inputB, " output: %b", out);
    end
endmodule

