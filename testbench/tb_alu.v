`timescale 1ns/1ps
`include "rvc_params.v"

module tb_alu;
    reg [3:0] alu_op;
    reg [15:0] operand1, operand2;
    wire [15:0] result;
    wire zero;

    alu dut (
        .alu_op(alu_op),
        .operand1(operand1),
        .operand2(operand2),
        .result(result),
        .zero(zero)
    );

    initial begin
        $display("Testing ALU...");
        operand1 = 16'd10;
        operand2 = 16'd5;

        alu_op = `ALU_ADD; #10;
        if (result != 15) $display("ADD failed: %d", result);

        alu_op = `ALU_SUB; #10;
        if (result != 5) $display("SUB failed: %d", result);

        alu_op = `ALU_AND; #10;
        if (result != (10 & 5)) $display("AND failed");

        alu_op = `ALU_OR; #10;
        if (result != (10 | 5)) $display("OR failed");

        alu_op = `ALU_SLTU; #10;
        if (result != 0) $display("SLTU failed");

        alu_op = `ALU_MUL; #10;
        if (result != 50) $display("MUL failed");

        alu_op = `ALU_DIV; #10;
        if (result != 2) $display("DIV failed");

        $display("ALU test completed.");
        $finish;
    end
endmodule
