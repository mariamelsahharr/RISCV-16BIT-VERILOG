`ifndef RVC_PARAMS_V
`define RVC_PARAMS_V

// Word size
`define WORD_SIZE 16

// Instruction size
`define INSTR_SIZE 16

// Register file
`define REG_WIDTH 16
`define REG_ADDR_WIDTH 3
`define NUM_REGISTERS 8

// Opcode
`define OPCODE_WIDTH 4

// ALU
`define ALU_OP_WIDTH 4

// Immediate
`define IMM_WIDTH 6

// Function 3 field
`define FUNCT3_WIDTH 3

// Program Counter
`define PC_WIDTH 16

// Memory
`define MEM_ADDR_WIDTH 16
`define MEM_DATA_WIDTH 16

// Instruction fields
`define OPCODE_FIELD 15:12
`define RD_FIELD 11:9
`define RS1_FIELD 8:6
`define RS2_FIELD 5:3
`define FUNCT3_FIELD 2:0
`define IMM_FIELD 5:0

// Instruction types
`define OPCODE_R_TYPE 4'b0000
`define OPCODE_I_TYPE 4'b0001
`define OPCODE_LOAD   4'b0010
`define OPCODE_STORE  4'b0011
`define OPCODE_BRANCH 4'b0100
`define OPCODE_JAL    4'b0101

// ALU operations
`define ALU_ADD  4'b0000
`define ALU_SUB  4'b0001
`define ALU_AND  4'b0010
`define ALU_OR   4'b0011
`define ALU_XOR  4'b0100
`define ALU_SLL  4'b0101
`define ALU_SRL  4'b0110
`define ALU_SRA  4'b0111
`define ALU_SLT  4'b1000
`define ALU_SLTU 4'b1001
`define ALU_MUL  4'b1010
`define ALU_DIV  4'b1011
`define ALU_ADD1 4'b1100

`endif // RVC_PARAMS_V