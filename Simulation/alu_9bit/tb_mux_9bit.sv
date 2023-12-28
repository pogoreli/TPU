`timescale 1ns / 1ps

module tb_mux_9bit;
    logic select;
    logic [8:0] inputA, inputB;
    logic [8:0] out;

    logic [8:0] A;
    logic [8:0] B;
    logic [8:0] expected;
    
    mux_9bit uut (.select(select), .inputA(inputA), .inputB(inputB), .out(out));
    
    initial begin
        select = 1'b0;
        A = 9'b000000001;
        B = 9'b000000010;
        expected = 9'b000000001;
        inputA = A;
        inputB = B;
        #10;
        $display("A value is %d", inputA, " B value is %d", inputB);
        $display("Test 1: 3 + 2 = %d", out, " Expected %d: ", expected);
        
        select = 1'b1;
        A = 9'b000000001;
        B = 9'b000000010;
        expected = 9'b000000010;
        inputA = A;
        inputB = B;
        #10;
        $display("A value is %d", inputA, " B value is %d", inputB);
        $display("Test 2: 3 + -2 = %d", out, " Expected %d: ", expected);
    end
endmodule