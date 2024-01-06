`timescale 1ns / 1ps

module tb_tanh;
    logic [31:0] inputA, inputB;
    logic [31:0] out;
    
    shortreal tolerance = 0.1;
    shortreal A;
    shortreal B;
    shortreal expected;
    shortreal diff;
    logic passed;
    
    int numberOfTests;
    int numberOfSuccessfullTests;
    
    assign inputB = 32'b00000000000000000000000000000000;

    // Instantiate the multiply module
    tanh uut (.inputA(inputA), .inputB(inputB), .out(out));
    
    // Convert a floating-point number to its IEEE 754 representation
    function automatic [31:0] real_to_ieee(real value);
//        real_to_ieee = $shortrealtobits(value);
    endfunction
    
    function shortreal absolute(shortreal value);
        return (value < 0.0) ? -value : value;
    endfunction
    
    function shortreal random_shortreal();
        shortreal num;
        shortreal denum;
        num = shortreal($urandom_range(1, 10000));
        denum = shortreal($random);
//        $display("num ", num, " denum ", denum);
//        random_shortreal = num / denum;
    endfunction

    initial begin
        A = 32'b00111111000000000000000000000000;
        expected = 0.46211715726;
        inputA = A;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 1:= ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 32'b10111111000000000000000000000000;
        expected = -0.46211715726;
        inputA = A;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 2:= ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 32'b00111111100000000000000000000000;
        expected = 0.76159415595;
        inputA = A;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 3:= ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 32'b10111111100000000000000000000000;
        expected = -0.76159415595;
        inputA = A;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 4:= ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 32'b01000010110010000000000000000000;
        expected = 1;
        inputA = A;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 5:= ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
         A = 32'b00000000000000000000000000000000;
        expected = 0;
        inputA = A;
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA));
        $display("Test 6:= ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        $display("Passed ", numberOfSuccessfullTests, " out of ", numberOfTests, " tests");
        
        end
endmodule
