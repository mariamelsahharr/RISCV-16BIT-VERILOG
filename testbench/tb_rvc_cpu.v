`timescale 1ns/1ps
`include "rvc_params.v"

module tb_rvc_cpu;
    reg clk, reset;
    wire [`PC_WIDTH-1:0] pc;

    rvc_cpu dut (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Testing rvc_cpu top-level...");
        reset = 1;
        #10 reset = 0;
        #50;

        $display("PC value: %d", pc);
        $display("rvc_cpu top-level test completed.");
        $finish;
    end
endmodule
