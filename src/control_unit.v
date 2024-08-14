`include "rvc_params.v"

module control_unit (
    input wire [`OPCODE_WIDTH-1:0] opcode,
    input wire [`FUNCT3_WIDTH-1:0] funct3,
    output reg [`ALU_OP_WIDTH-1:0] alu_op,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg jump
);

    always @(*) begin
        case (opcode)
            `OPCODE_R_TYPE: begin
                alu_op = {1'b0, funct3};
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
            `OPCODE_I_TYPE: begin
                alu_op = {1'b0, funct3};
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
            `OPCODE_LOAD: begin
                alu_op = `ALU_ADD;
                reg_write = 1'b1;
                mem_read = 1'b1;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
            `OPCODE_STORE: begin
                alu_op = `ALU_ADD;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b1;
                branch = 1'b0;
                jump = 1'b0;
            end
            `OPCODE_BRANCH: begin
                alu_op = `ALU_SUB;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b1;
                jump = 1'b0;
            end
            `OPCODE_JAL: begin
                alu_op = `ALU_ADD;
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b1;
            end
            default: begin
                alu_op = `ALU_ADD;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
        endcase
    end

endmodule