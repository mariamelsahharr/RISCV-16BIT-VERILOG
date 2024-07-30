module program_counter (
    input wire clk, //clk input
    input wire reset, // reset signal
    input wire enable, // enable signal
    input wire branch, // signal indicating a branch
    input wire jump, //  signal indicating a jump
    input wire [15:0] branch_target, // branch target address
    input wire [15:0] jump_target, // jump target address
    output reg [15:0] pc    // current program counter val (16 bits)
);


// 16-bit program counter
wire [15:0] pc_plus_2 = pc + 16'd2;
//calculate the next seq pc value (curr pc+2)
// add 2 bc each instruction is 16 bits wide aka 2 bytes

wire [15:0] next_pc = jump ? jump_target :
                      branch ? branch_target :
                      pc_plus_2;
// determine next pc val based on ctl signals
// priority: jump > branch > seq


// sequential always block to update pc val
//
always @(posedge clk or posedge reset) begin
    if (reset)
        pc <= 16'b0; //on reset, set pc to 0 (0000000000000000)
    else if (enable)
        pc <= next_pc;// If enabled, update PC to the calculated next PC
    // If not enabled, PC keeps its current value (implicit in Verilog)
end

endmodule