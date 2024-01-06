`timescale 1ns / 1ps

module tb_power;
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
    power uut (.inputA(inputA), .inputB(inputB), .out(out));
    
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
        A = 2;
        B = 2;
        expected = 4;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 1: = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 2;
        B = -2;
        expected = 0.25;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 2: = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;

        A = 3;
        B = 2.3;
        expected = 12.5135025328;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 3: = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 5;
        B = 0.5;
        expected = 2.2360679775;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 4: = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 2;
        B = 8;
        expected = 256;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 5: = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        A = 4;
        B = 0.5;
        expected = 2;
        inputA = real_to_ieee(A);
        inputB = real_to_ieee(B);
        #10;
        diff = absolute(($bitstoshortreal(out)) - expected);
        passed = diff < tolerance;
        $display("A value is ", $bitstoshortreal(inputA), " B value is ", $bitstoshortreal(inputB));
        $display("Test 6: = ", $bitstoshortreal(out), " Expected: ", expected, " Passed: ", passed);
        numberOfTests++;
        numberOfSuccessfullTests += passed;
        
        $display("Passed ", numberOfSuccessfullTests, " out of ", numberOfTests, " tests");
        
        end

endmodule