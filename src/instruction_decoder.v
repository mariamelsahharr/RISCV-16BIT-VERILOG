`include "rvc_params.v"

module instruction_decoder (
    input wire [`INSTR_SIZE-1:0] instruction,
    output reg [`OPCODE_WIDTH-1:0] opcode,
    output reg [`REG_ADDR_WIDTH-1:0] rd,
    output reg [`REG_ADDR_WIDTH-1:0] rs1,
    output reg [`REG_ADDR_WIDTH-1:0] rs2,
    output reg [`IMM_WIDTH-1:0] immediate,
    output reg [`FUNCT3_WIDTH-1:0] funct3
);

    always @(*) begin
        opcode = instruction[`OPCODE_FIELD];
        case (opcode)
            `OPCODE_R_TYPE: begin
                rd = instruction[`RD_FIELD];
                rs1 = instruction[`RS1_FIELD];
                rs2 = instruction[`RS2_FIELD];
                funct3 = instruction[`FUNCT3_FIELD];
                immediate = {`IMM_WIDTH{1'b0}};
            end
            `OPCODE_I_TYPE: begin
                rd = instruction[`RD_FIELD];
                rs1 = instruction[`RS1_FIELD];
                immediate = instruction[`IMM_FIELD];
                funct3 = instruction[`FUNCT3_FIELD];
                rs2 = {`REG_ADDR_WIDTH{1'b0}};
            end
            `OPCODE_LOAD, `OPCODE_STORE: begin
                rd = instruction[`RD_FIELD];
                rs1 = instruction[`RS1_FIELD];
                immediate = instruction[`IMM_FIELD];
                funct3 = instruction[`FUNCT3_FIELD];
                rs2 = {`REG_ADDR_WIDTH{1'b0}};
            end
            `OPCODE_BRANCH: begin
                rs1 = instruction[`RS1_FIELD];
                rs2 = instruction[`RS2_FIELD];
                immediate = instruction[`IMM_FIELD];
                funct3 = instruction[`FUNCT3_FIELD];
                rd = {`REG_ADDR_WIDTH{1'b0}};
            end
            `OPCODE_JAL: begin
                rd = instruction[`RD_FIELD];
                immediate = instruction[`IMM_FIELD];
                funct3 = instruction[`FUNCT3_FIELD];
                rs1 = {`REG_ADDR_WIDTH{1'b0}};
                rs2 = {`REG_ADDR_WIDTH{1'b0}};
            end
            default: begin
                rd = {`REG_ADDR_WIDTH{1'b0}};
                rs1 = {`REG_ADDR_WIDTH{1'b0}};
                rs2 = {`REG_ADDR_WIDTH{1'b0}};
                immediate = {`IMM_WIDTH{1'b0}};
                funct3 = {`FUNCT3_WIDTH{1'b0}};
            end
        endcase
    end

endmodule