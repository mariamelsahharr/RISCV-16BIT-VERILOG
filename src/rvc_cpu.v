module rvc_cpu (
    input wire clk,
    input wire reset,
    output wire  [`PC_WIDTH-1:0] pc
);

    // Internal signals
    wire [`INSTR_SIZE-1:0] instruction;
    wire [`OPCODE_WIDTH-1:0] opcode;
    wire [`REG_ADDR_WIDTH-1:0] rd, rs1, rs2;
    wire [`FUNCT3_WIDTH-1:0] funct3;
    wire [`IMM_WIDTH-1:0] immediate;
    wire [`WORD_SIZE-1:0] reg_write_data, reg_read_data1, reg_read_data2;
    wire [`WORD_SIZE-1:0] alu_result;
    wire [`WORD_SIZE-1:0] mem_read_data;
    wire [`ALU_OP_WIDTH-1:0] alu_op;
    wire reg_write, mem_read, mem_write, branch, jump, zero;
    wire [`WORD_SIZE-1:0] branch_target, jump_target;

    // Program Counter
    program_counter pc_module (
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .branch(branch & zero),
        .jump(jump),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .pc(pc)
    );

    // Instruction Memory (placeholder - replace with actual memory)
    assign instruction = {`INSTR_SIZE{1'b0}}; // Replace with actual instruction fetch

    // Instruction Decoder
    instruction_decoder id (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .immediate(immediate),
        .funct3(funct3)
    );

    // Control Unit
    control_unit cu (
        .opcode(opcode),
        .funct3(funct3),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump)
    );

    // Register File
    register_file rf (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .we(reg_write),
        .write_data(reg_write_data),
        .read_data1(reg_read_data1),
        .read_data2(reg_read_data2)
    );

    // ALU
    alu alu_module (
        .alu_op(alu_op),
        .operand1(reg_read_data1),
        .operand2(reg_read_data2),
        .result(alu_result),
        .zero(zero)
    );

    // Data Memory (placeholder - replace with actual memory)
    assign mem_read_data ={`WORD_SIZE{1'b0}} // Replace with actual memory read

    // Write-back logic
    assign reg_write_data = mem_read ? mem_read_data : alu_result;

    // Branch and jump target calculation
    assign branch_target = pc + {{(`PC_WIDTH-`IMM_WIDTH){immediate[`IMM_WIDTH-1]}}, immediate};
    assign jump_target = pc + {{(`PC_WIDTH-`IMM_WIDTH){immediate[`IMM_WIDTH-1]}}, immediate};
    
endmodule

/* for eda playgorunds sim
`include "program_counter.v"
`include "instruction_decoder.v"
`include "control_unit.v"
`include "register_file.v"
`include "alu.v"
`include "rvc_params.v"
*/