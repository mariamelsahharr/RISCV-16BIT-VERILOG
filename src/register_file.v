`include "rvc_params.v"

module register_file (
    input wire clk,
    input wire reset,
    input wire [`REG_ADDR_WIDTH-1:0] rs1,
    input wire [`REG_ADDR_WIDTH-1:0] rs2,
    input wire [`REG_ADDR_WIDTH-1:0] rd,
    input wire we,
    input wire [`WORD_SIZE-1:0] write_data,
    output wire [`WORD_SIZE-1:0] read_data1,
    output wire [`WORD_SIZE-1:0] read_data2
);

    reg [`WORD_SIZE-1:0] registers [`NUM_REGISTERS-1:1]; // x1 to x7, x0 is hardwired to 0

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 1; i < `NUM_REGISTERS; i = i + 1) begin
                registers[i] <= {`WORD_SIZE{1'b0}};
            end
        end else if (we && rd != {`REG_ADDR_WIDTH{1'b0}}) begin
            registers[rd] <= write_data;
        end
    end

    assign read_data1 = (rs1 == {`REG_ADDR_WIDTH{1'b0}}) ? {`WORD_SIZE{1'b0}} : registers[rs1];
    assign read_data2 = (rs2 == {`REG_ADDR_WIDTH{1'b0}}) ? {`WORD_SIZE{1'b0}} : registers[rs2];

endmodule
