`timescale 1ns / 1ps

module tb_sum_9bit;
    logic [8:0] inputA, inputB;
    logic [8:0] out;

    logic [8:0] A;
    logic [8:0] B;
    logic [8:0] expected;
    
    sum_9bit uut (.inputA(inputA), .inputB(inputB), .out(out));
    
    initial begin
        A = 9'd3;
        B = 9'd2;
        expected = 9'd5;
        inputA = A;
        inputB = B;
        #10;
        $display("A value is %d", inputA, " B value is %d", inputB);
        $display("Test 1: 3 + 2 = %d", out, " Expected %d: ", expected);
        
        A = 9'b000000011;
        B = 9'b100000010;
        expected = 9'b000000001;
        inputA = A;
        inputB = B;
        #10;
        $display("A value is %d", inputA, " B value is %d", inputB);
        $display("Test 2: 3 + -2 = %d", out, " Expected %d: ", expected);
        
        A = 9'b100000011;
        B = 9'b000000010;
        expected = 9'b100000001;
        inputA = A;
        inputB = B;
        #10;
        $display("A value is %d", inputA, " B value is %d", inputB);
        $display("Test 3: -3 + 2 = %d", out, " Expected %d: ", expected);
        
        A = 9'b100000011;
        B = 9'b100000010;
        expected = 9'b100000101;
        inputA = A;
        inputB = B;
        #10;
        $display("A value is %d", inputA, " B value is %d", inputB);
        $display("Test 1: -3 + -2 = %d", out, " Expected %d: ", expected);
    end
endmodule
