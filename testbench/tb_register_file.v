`timescale 1ns/1ps
`include "rvc_params.v"

module tb_register_file;
    reg clk, reset, we;
    reg [`REG_ADDR_WIDTH-1:0] rs1, rs2, rd;
    reg [`WORD_SIZE-1:0] write_data;
    wire [`WORD_SIZE-1:0] read_data1, read_data2;

    register_file dut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .we(we),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $display("Testing register_file...");
        reset = 1; we = 0; rd = 3'd1; write_data = 16'hABCD;
        #10 reset = 0; we = 1;
        #10;
        rs1 = 3'd1;
        #5;
        if (read_data1 != 16'hABCD) $display("Failed: Expected 0xABCD, got %h", read_data1);
        $display("register_file test completed.");
        $finish;
    end
endmodule
