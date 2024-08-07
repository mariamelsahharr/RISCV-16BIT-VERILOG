module register_file (
    input wire clk,
    input wire reset,
    input wire [2:0] rs1,
    input wire [2:0] rs2,
    input wire [2:0] rd,
    input wire we,
    input wire [15:0] write_data,
    output wire [15:0] read_data1,
    output wire [15:0] read_data2
);

    reg [15:0] registers [7:1]; // x1 to x7, x0 is hardwired to 0

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 1; i < 8; i = i + 1) begin
                registers[i] <= 16'b0;
            end
        end else if (we && rd != 3'b000) begin
            registers[rd] <= write_data;
        end
    end

    assign read_data1 = (rs1 == 3'b000) ? 16'b0 : registers[rs1];
    assign read_data2 = (rs2 == 3'b000) ? 16'b0 : registers[rs2];

endmodule 