`timescale 1ns/1ps
`include "rvc_params.v"

module tb_program_counter;
    reg clk, reset, enable, branch, jump;
    reg [`WORD_SIZE-1:0] branch_target, jump_target;
    wire [`PC_WIDTH-1:0] pc;

    program_counter dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .branch(branch),
        .jump(jump),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .pc(pc)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Testing program_counter...");
        reset = 1; enable = 0; branch = 0; jump = 0; branch_target = 16'd20; jump_target = 16'd100;
        #10 reset = 0; enable = 1;
        #10;
        if (pc != 16'd2) $display("Failed: PC should be 2, got %d", pc);
        jump = 1;
        #10;
        if (pc != 16'd100) $display("Failed: PC should be jump_target 100, got %d", pc);
        jump = 0; branch = 1;
        #10;
        if (pc != 16'd20) $display("Failed: PC should be branch_target 20, got %d", pc);
        $display("program_counter test completed.");
        $finish;
    end
endmodule
