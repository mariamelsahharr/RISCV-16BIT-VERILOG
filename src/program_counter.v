//Basic modifications:
//Add an enable signal to allow for stalling.
//Implement branching and jumping functionality.
//Ensure the PC increments by 2 (since RVC instructions are 16 bits).
//Add a jump target input for direct jumps.



// Define the program counter module with its inputs and outputs
module program_counter (
    input wire clk,          // Clock input
    input wire reset,        // Reset signal
    input wire enable,       // Enable signal to allow stalling
    input wire branch,       // Signal indicating a branch should be taken
    input wire jump,         // Signal indicating a jump should be taken
    input wire [15:0] branch_target,  // Target address for branch instructions
    input wire [15:0] jump_target,    // Target address for jump instructions
    output reg [15:0] pc     // Current program counter value (16 bits wide)
);

// Define the program counter logic

// Calculate the next sequential PC value (current PC + 2)
// We add 2 because each instruction is 16 bits (2 bytes) wide
wire [15:0] pc_plus_2 = pc + 16'd2;
//16'd2 is a 16-bit decimal value 2

// Determine the next PC value based on control signals
// Priority: Jump > Branch > Sequential
wire [15:0] next_pc = jump ? jump_target :    // If jump, use jump target
                      branch ? branch_target : // Else if branch, use branch target
                      pc_plus_2;               // Else use next sequential address

// Sequential always block to update the PC value on rising edge
// Sequential logic to update the PC on each clock cycle
always @(posedge clk or posedge reset) begin // senstivity list -> rising edge of clk signal or of reset signal
    if (reset)
        pc <= 16'b0;  // On reset, set PC to 0
    else if (enable)
        pc <= next_pc;  // If enabled, update PC to the calculated next PC
    // If not enabled, PC keeps its current value (implicit in Verilog)
end

endmodule


