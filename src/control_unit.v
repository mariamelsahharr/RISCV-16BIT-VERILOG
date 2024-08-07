module control_unit (
    input wire [3:0] opcode,
    input wire [2:0] funct3,
    output reg [3:0] alu_op,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg jump
);

    always @(*) begin
        case (opcode)
            4'b0000: begin // R-type
                alu_op = {1'b0, funct3};
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
            4'b0001: begin // I-type
                alu_op = {1'b0, funct3};
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
            4'b0010: begin // Load
                alu_op = 4'b0000; // ADD for address calculation
                reg_write = 1'b1;
                mem_read = 1'b1;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
            4'b0011: begin // Store
                alu_op = 4'b0000; // ADD for address calculation
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b1;
                branch = 1'b0;
                jump = 1'b0;
            end
            4'b0100: begin // Branch
                alu_op = 4'b0001; // SUB for comparison
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b1;
                jump = 1'b0;
            end
            4'b0101: begin // JAL
                alu_op = 4'b0000; // ADD for PC + 2
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b1;
            end
            default: begin
                alu_op = 4'b0000;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                jump = 1'b0;
            end
        endcase
    end

endmodule