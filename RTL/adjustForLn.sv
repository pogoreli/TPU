`timescale 1ns / 1ps

module adjustForLn(
    input logic [31:0] inputA,
    output logic [31:0] n, x
    );
    
    logic [30:0][31:0] count, division, minNum;
    logic [31:0] one, two;
    
    assign count[0] = 32'b00000000000000000000000000000000;
    assign division[0] = inputA;
    assign one = 32'b00111111100000000000000000000000;
    assign two = 32'b01000000000000000000000000000000;
    
    genvar i;
    generate
        for (i = 1; i <= 30; i++) begin
            divide divideByTwo(.inputA(division[i-1]), .inputB(two), .out(division[i]));
            sum count(.inputA(count[i-1]), .inputB(one), .out(count[i]));
        end
    endgenerate
    
    genvar j;
    generate
        for (j = 0; j <= 30; j++) begin
            min minNumber(.inputA(division[j]), .inputB(two), .out(minNum[j]));
        end
    endgenerate
    
    logic numberFound;
    
    always_comb begin
        numberFound = 1'b0;
        
        for(int i = 0; i <= 30; i++) begin
            if(minNum[i] != two && !numberFound) begin
                numberFound = 1'b1;
                n = count[i];
                x = division[i];
            end
        end
        
        if(x  == one) begin
            x = 32'b00111111100000000000000000000001;
        end
    end
endmodule
