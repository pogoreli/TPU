`timescale 1ns / 1ps

module tb_root;
    logic [31:0] inputA, inputB;
    logic [31:0] out;
    
    shortreal tolerance = 0.001;
    shortreal A;
    shortreal B;
    shortreal expected;
    shortreal diff;
    logic passed;
    
    int numberOfTests;
    int numberOfSuccessfullTests;

    // Instantiate the multiply module
    root uut (.inputA(inputA), .inputB(inputB), .out(out));
    
    // Convert a floating-point number to its IEEE 754 representation
    function automatic [31:0] real_to_ieee(real value);
        real_to_ieee = $shortrealtobits(value);
    endfunction
    
    function shortreal absolute(shortreal value);
        return (value < 0.0) ? -value : value;
    endfunction
    
    function shortreal random_shortreal();
        shortreal num;
        shortreal denum;
        num = shortreal($urandom_range(1, 10000));
        denum = shortreal($random);
        $display("num ", num, " denum ", denum);
        random_shortreal = num / denum;
    endfunction

    initial begin
        // Test with both numbers positive
        A = 2;
        B = 4;
        expected = 2;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 1: ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with both numbers positive
        A = 3;
        B = 16;
        expected = 2.51984209979;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 2: ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with one number positive and one number negative
        A = 1.2;
        B = 3.5;
        expected = 2.84046;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 3: ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with one number positive and one number negative
        A = 0.3;
        B = 3;
        expected = 38.94073;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 4: ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        // Test with both numbers negative
        A = 5;
        B = 1;
        expected = 1;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 5: ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        $display("Passed ", numberOfSuccessfullTests, " out of ", numberOfTests, " tests");
        
        end

endmodule

