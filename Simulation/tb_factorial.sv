`timescale 1ns / 1ps

module tb_factorial;
    logic [30:0][31:0] out;
    
    factorial uut (.out(out));

    initial begin
        #10;
        $display("Test 1");   

     end
endmodule
