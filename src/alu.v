module alu (
    input wire [3:0] alu_op,
    input wire [15:0] operand1,
    input wire [15:0] operand2,
    output reg [15:0] result,
    output wire zero
);

    always @(*) begin
        case (alu_op)
            4'b0000: result = operand1 + operand2;  // ADD
            4'b0001: result = operand1 - operand2;  // SUB
            4'b0010: result = operand1 & operand2;  // AND
            4'b0011: result = operand1 | operand2;  // OR
            4'b0100: result = operand1 ^ operand2;  // XOR
            4'b0101: result = operand1 << operand2[3:0];  // SLL
            4'b0110: result = operand1 >> operand2[3:0];  // SRL
            4'b0111: result = $signed(operand1) >>> operand2[3:0];  // SRA
            4'b1000: result = ($signed(operand1) < $signed(operand2)) ? 16'd1 : 16'd0;  // SLT
            4'b1001: result = (operand1 < operand2) ? 16'd1 : 16'd0;  // SLTU
            default: result = 16'b0;
        endcase
    end

    assign zero = (result == 16'b0);

endmodule
/* for eda playgorunds sim
`include "program_counter.v"
`include "instruction_decoder.v"
`include "control_unit.v"
`include "register_file.v"
`include "alu.v"
*/