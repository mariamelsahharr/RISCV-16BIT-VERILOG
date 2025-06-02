`timescale 1ns / 1ps

module rvc_cpu_tb;

    reg clk;
    reg reset;
    wire [15:0] pc;

    // Instantiate the CPU
    rvc_cpu uut (
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #10 reset = 0;

        // Add your test cases here
        // For example, you can monitor the PC value:
        #100 $display("PC value: %h", pc);
        // or you can set breakpoints to inspect internal signals:
        #100 $stop;
        // End simulation
        #1000 $finish;
    end

    // Optional: Waveform dump for viewing in a waveform viewer
    initial begin
        $dumpfile("rvc_cpu_tb.vcd");
        $dumpvars(0, rvc_cpu_tb);
    end

endmodule
