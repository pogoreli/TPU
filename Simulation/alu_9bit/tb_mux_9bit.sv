`timescale 1ns / 1ps

module tb_mux_9bit;
    logic [1:0] select;
    logic [8:0] out;

    logic [8:0] A;
    logic [8:0] B;
    logic [8:0] C;
    logic [8:0] D;
    logic [8:0] expected;
    
    mux_9bit uut (.select(select), .inputA(A), .inputB(B), .inputC(C), .inputD(D), .out(out));
    
    initial begin
        select = 2'b00;
        A = 9'b000000001;
        B = 9'b000000010;
        C = 9'b000000011;
        D = 9'b000000100;
        expected = 9'b000000001;
        #10;
        $display("A value is %d", A, " B value is %d", B, " C value is %d", C, " D value is %d", D);
        $display("Test 1 %d", out, " Expected %d: ", expected);
        
        select = 2'b01;
        A = 9'b000000001;
        B = 9'b000000010;
        C = 9'b000000011;
        D = 9'b000000100;
        expected = 9'b000000010;
        #10;
        $display("A value is %d", A, " B value is %d", B, " C value is %d", C, " D value is %d", D);
        $display("Test 2: %d", out, " Expected %d: ", expected);
        
        select = 2'b10;
        A = 9'b000000001;
        B = 9'b000000010;
        C = 9'b000000011;
        D = 9'b000000100;
        expected = 9'b000000011;
        #10;
        $display("A value is %d", A, " B value is %d", B, " C value is %d", C, " D value is %d", D);
        $display("Test 2: %d", out, " Expected %d: ", expected);
        
        select = 2'b11;
        A = 9'b000000001;
        B = 9'b000000010;
        C = 9'b000000011;
        D = 9'b000000100;
        expected = 9'b000000100;
        #10;
        $display("A value is %d", A, " B value is %d", B, " C value is %d", C, " D value is %d", D);
        $display("Test 2: %d", out, " Expected %d: ", expected);
    end
endmodule
