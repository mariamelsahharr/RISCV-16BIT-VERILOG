module instruction_memory (
    input wire [15:0] address,
    output wire [15:0] instruction
);

parameter INSTR_MEM_SIZE = 256;
reg [15:0] instr_mem [0:INSTR_MEM_SIZE-1];

initial begin
    integer i;
    for (i = 0; i < INSTR_MEM_SIZE; i = i + 1) begin
        instr_mem[i] = 16'h0001; // Default to NOP instruction
    end
    
end

assign instruction = instr_mem[address[7:1]]; // Assuming PC increments by 2

endmodule