//Basic modifications:
//Add an enable signal to allow for stalling.
//Implement branching and jumping functionality.
//Ensure the PC increments by 2 (since RVC instructions are 16 bits).
//Add a jump target input for direct jumps.



// Define the program counter module with its inputs and outputs
`include "rvc_params.v"

module program_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire branch,
    input wire jump,
    input wire [`WORD_SIZE-1:0] branch_target,
    input wire [`WORD_SIZE-1:0] jump_target,
    output reg [`PC_WIDTH-1:0] pc
);

// Define the program counter logic

// Calculate the next sequential PC value (current PC + 2)
// We add 2 because each instruction is 16 bits (2 bytes) wide
wire [`PC_WIDTH-1:0] pc_plus_2 = pc + 16'd2;
//16'd2 is a 16-bit decimal value 2

// Determine the next PC value based on control signals
// Priority: Jump > Branch > Sequential
wire [`PC_WIDTH-1:0]  next_pc = jump ? jump_target :    // If jump, use jump target
                      branch ? branch_target : // Else if branch, use branch target
                      pc_plus_2;               // Else use next sequential address

// Sequential always block to update the PC value on rising edge
// Sequential logic to update the PC on each clock cycle
always @(posedge clk or posedge reset) begin // senstivity list -> rising edge of clk signal or of reset signal
    if (reset)
        pc <= {`PC_WIDTH{1'b0}};  // On reset, set PC to 0
    else if (enable)
        pc <= next_pc;  // If enabled, update PC to the calculated next PC
    // If not enabled, PC keeps its current value (implicit in Verilog)
end

endmodule


