module instruction_decoder (
    input wire [15:0] instruction,
    output reg [3:0] opcode,
    output reg [2:0] rd,
    output reg [2:0] rs1,
    output reg [2:0] rs2,
    output reg [5:0] immediate,
    output reg [2:0] funct3
);

    always @(*) begin
        opcode = instruction[1:0];
        case (opcode)
            2'b00: begin // CR-type
                rd = instruction[11:9];
                rs1 = instruction[11:9];
                rs2 = instruction[6:4];
                funct3 = instruction[15:13];
                immediate = 6'b0;
            end
            2'b01: begin // CI-type
                rd = instruction[11:9];
                rs1 = instruction[11:9];
                immediate = {instruction[12], instruction[6:2]};
                funct3 = instruction[15:13];
                rs2 = 3'b0;
            end
            2'b10: begin // CSS-type
                rs2 = instruction[6:4];
                immediate = instruction[12:7];
                funct3 = instruction[15:13];
                rd = 3'b0;
                rs1 = 3'b0;
            end
            2'b11: begin // CIW-type
                rd = instruction[4:2];
                immediate = instruction[12:5];
                funct3 = instruction[15:13];
                rs1 = 3'b0;
                rs2 = 3'b0;
            end
        endcase
    end

endmodule