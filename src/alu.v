module alu (
    input wire [3:0] alu_op,
    input wire [15:0] operand1,
    input wire [15:0] operand2,
    output reg [15:0] result,
    output wire zero
);

    always @(*) begin
        case (alu_op)
            `ALU_ADD: result = operand1 + operand2;  // ADD
            `ALU_SUB: result = operand1 - operand2;  // SUB
            `ALU_AND: result = operand1 & operand2;  // AND
            `ALU_OR: result = operand1 | operand2;  // OR
            `ALU_XOR: result = operand1 ^ operand2;  // XOR
            `ALU_SLL:  result = operand1 << operand2[`REG_ADDR_WIDTH-1:0];
            `ALU_SRL:  result = operand1 >> operand2[`REG_ADDR_WIDTH-1:0];
            `ALU_SRA:  result = $signed(operand1) >>> operand2[`REG_ADDR_WIDTH-1:0];
            //4'b1000: result = ($signed(operand1) < $signed(operand2)) ? 16'd1 : 16'd0;  // SLT
         //   4'b1001: result = (operand1 < operand2) ? 16'd1 : 16'd0;  // SLTU
         
            `ALU_SLT:  result = ($signed(operand1) < $signed(operand2)) ? {{`WORD_SIZE-1{1'b0}}, 1'b1} : {`WORD_SIZE{1'b0}};
            `ALU_SLTU: result = (operand1 < operand2) ? {{`WORD_SIZE-1{1'b0}}, 1'b1} : {`WORD_SIZE{1'b0}};
            `ALU_MUL:  result = operand1 * operand2;
            `ALU_DIV:  result = operand1 / operand2;
            `ALU_ADD1: result = operand1 + 1;
            default: result = 16'b0;
        endcase
    end

    assign zero = (result == 16'b0);

endmodule
