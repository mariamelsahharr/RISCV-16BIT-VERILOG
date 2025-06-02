`timescale 1ns/1ps
`include "rvc_params.v"

module tb_instruction_decoder;
    reg [`INSTR_SIZE-1:0] instruction;
    wire [`OPCODE_WIDTH-1:0] opcode;
    wire [`REG_ADDR_WIDTH-1:0] rd, rs1, rs2;
    wire [`IMM_WIDTH-1:0] immediate;
    wire [`FUNCT3_WIDTH-1:0] funct3;

    instruction_decoder dut (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .immediate(immediate),
        .funct3(funct3)
    );

    initial begin
        $display("Testing instruction_decoder...");

        // Test R-type instruction: opcode = 0000, rd = 001, rs1 = 010, rs2 = 100, funct3 = 001
        instruction = 16'b0000001100101001;
        #5;
        if (opcode != 4'b0000 || rd != 3'b001 || rs1 != 3'b010 || rs2 != 3'b100 || funct3 != 3'b001)
            $display("R-type decode failed.");

        // Test I-type instruction: opcode = 0001, rd = 001, rs1 = 010, imm = 100001
        instruction = 16'b0001001100100001;
        #5;
        if (opcode != 4'b0001 || rd != 3'b001 || rs1 != 3'b010 || immediate != 6'b100001)
            $display("I-type decode failed.");

        $display("instruction_decoder test completed.");
        $finish;
    end
endmodule
