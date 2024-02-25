`timescale 1ns / 1ps

module min_9bit(
    input logic [8:0] inputA, inputB,
    output logic [8:0] out
    );
    
    always_comb begin
        if(inputA[8] == inputB[8]) begin
//            $display("SAME SIGN");
            if(inputA[8] == 1) begin
                if(inputA[7:0] >= inputB[7:0]) begin
                    out = inputA;
                end else begin
                    out = inputB;
                end
            end else begin
                if(inputA[7:0] >= inputB[7:0]) begin
                    out = inputB;
                end else begin
                    out = inputA;
                end
            end
        end else begin
//            $display("DIFFERENT SIGNS");
            if(inputA[8] == 1) begin
//                $display("A NEGATIVE");
                out = inputA;
            end else begin
//                $display("B NEGATIVE");
                out = inputB;
            end
        end
    end
    
    always_comb begin
//        $display("Min. In A: %b", inputA, " Input B: %b", inputB, " output: %b", out);
    end
endmodule
