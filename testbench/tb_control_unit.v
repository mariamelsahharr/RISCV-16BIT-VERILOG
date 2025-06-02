`timescale 1ns/1ps
`include "rvc_params.v"

module tb_control_unit;
    reg [`OPCODE_WIDTH-1:0] opcode;
    reg [`FUNCT3_WIDTH-1:0] funct3;
    wire [`ALU_OP_WIDTH-1:0] alu_op;
    wire reg_write, mem_read, mem_write, branch, jump;

    control_unit dut (
        .opcode(opcode),
        .funct3(funct3),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump)
    );

    initial begin
        $display("Testing control_unit...");

        opcode = `OPCODE_R_TYPE; funct3 = 3'b010; #5;
        if (alu_op != 4'b0010 || !reg_write || mem_read || mem_write || branch || jump)
            $display("R-type control failed.");

        opcode = `OPCODE_LOAD; #5;
        if (!mem_read || !reg_write || alu_op != `ALU_ADD)
            $display("LOAD control failed.");

        opcode = `OPCODE_STORE; #5;
        if (!mem_write || reg_write || alu_op != `ALU_ADD)
            $display("STORE control failed.");

        opcode = `OPCODE_BRANCH; #5;
        if (!branch || alu_op != `ALU_SUB)
            $display("BRANCH control failed.");

        opcode = `OPCODE_JAL; #5;
        if (!jump || !reg_write || alu_op != `ALU_ADD)
            $display("JAL control failed.");

        $display("control_unit test completed.");
        $finish;
    end
endmodule
