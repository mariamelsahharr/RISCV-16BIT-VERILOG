
# RVC CPU Project

## Overview

This project implements a 16-bit RISC-V Compressed (RVC) CPU core in Verilog. The design is based on a simplified version of the RISC-V ISA, focusing on the compressed instruction set to achieve a compact 16-bit architecture. The implementation is inspired by the RISC-V Compressed Instruction Set Manual, Version 1.7, which can be found at:

https://riscv.org/wp-content/uploads/2015/05/riscv-compressed-spec-v1.7.pdf

## Set up/How to view

### Option 1: Local Simulation

#### Prerequisites

- Verilog simulator (e.g., Icarus Verilog, Verilator)
- Waveform viewer (e.g., GTKWave)

#### Simulation

1. Compile the Verilog files:
   ```
   iverilog -o rvc_cpu_tb rvc_cpu_tb.v rvc_cpu.v program_counter.v instruction_decoder.v control_unit.v register_file.v alu.v parameters.v
   ```

2. Run the simulation:
   ```
   vvp rvc_cpu_tb
   ```

3. View the waveform:
   ```
   gtkwave rvc_cpu_tb.vcd
   ```

### Option 2: EDA Playground

1. Go to [This project](https://www.edaplayground.com/) on EDA Playgrounds.


## Features

- 16-bit instruction width
- 8 general-purpose registers (x0-x7), with x0 hardwired to 0
- Simplified RVC instruction set
- Basic arithmetic, logical, load/store, and control flow instructions
- Modular design for easy understanding and modification

## Project Structure

The project consists of the following Verilog modules:

- `rvc_cpu.v`: Top-level module that integrates all components
- `program_counter.v`: Manages the program counter
- `instruction_decoder.v`: Decodes 16-bit instructions
- `control_unit.v`: Generates control signals based on instruction type
- `register_file.v`: Implements the CPU's register file
- `alu.v`: Arithmetic Logic Unit for data processing
- `parameters.v`: Contains global parameters and constants used across the design
- `rvc_cpu_tb.v`: Testbench for the CPU

## Instruction Set

The CPU supports a subset of the RVC instruction set, including:

- Arithmetic and Logical: ADD, SUB, AND, OR, XOR, SLL, SRL, SRA
- Immediate Operations: ADDI, ANDI, ORI, XORI
- Load/Store: LW, SW
- Branches: BEQ, BNE, BLT, BGE
- Jumps: JAL, JALR

## Global Parameters

The `parameters.v` file contains important constants and parameters used throughout the design. These include:

- Instruction width
- Register file size
- ALU operation codes
- Opcode definitions

## Detailed Implementation

### Top-level Module (`rvc_cpu.v`)

The top-level module integrates all components of the CPU. It instantiates and connects the following sub-modules:

- Program Counter
- Instruction Decoder
- Control Unit
- Register File
- ALU

Key features:
- 16-bit data and address bus
- Single-cycle execution (no pipelining in this version)
- Modular design for easy extension and modification

### Program Counter (`program_counter.v`)

The program counter manages the current instruction address. 

Key features:
- 16-bit width to address the full 64KB instruction memory space
- Increments by 2 each cycle (since instructions are 16 bits)
- Supports branching and jumping through external control signals
- Can be stalled using an enable signal

### Instruction Decoder (`instruction_decoder.v`)

This module decodes the 16-bit RVC instructions into control signals and operands.

Key features:
- Supports four instruction formats: CR, CI, CSS, and CIW
- Extracts opcode, register addresses, immediate values, and function codes
- Uses a case statement to handle different instruction formats efficiently

### Control Unit (`control_unit.v`)

The control unit generates control signals based on the decoded instruction.

Key features:
- Determines ALU operation
- Controls register write enable
- Manages memory read/write signals
- Handles branching and jumping logic

### Register File (`register_file.v`)

Implements the CPU's register file, consisting of 8 16-bit registers.

Key features:
- 8 general-purpose registers (x0 to x7)
- x0 is hardwired to zero
- Supports two simultaneous read operations and one write operation per cycle
- Write operations are performed on the rising edge of the clock

### ALU (`alu.v`)

The Arithmetic Logic Unit performs all data processing operations.

Key features:
- Supports basic arithmetic operations: ADD, SUB
- Implements logical operations: AND, OR, XOR
- Includes shift operations: SLL (logical left), SRL (logical right), SRA (arithmetic right)
- Generates condition flags (e.g., zero flag) for branching operations

### Global Parameters (`parameters.v`)

This file defines constants and parameters used throughout the design.

Key definitions:
- Instruction width (16 bits)
- Register file size (8 registers)
- ALU operation codes
- Opcode and function code definitions

### Instruction Memory

In the current implementation, instruction memory is simulated within the testbench. It is currently a WIP.

### Data Memory

Similar to instruction memory, data memory operations are currently simulated in the testbench. Also a WIP.

## Future Enhancements

1. Pipelining: Implement a basic pipeline (e.g., Fetch, Decode, Execute, Memory, Writeback stages) to improve performance.

2. Memory Interface: Add proper instruction and data memory interfaces.

3. Interrupt Handling: Implement basic interrupt and exception handling mechanisms.

4. Extended Instruction Set: Gradually add support for more RVC instructions.

5. Optimizations: Explore optimizations like branch prediction or a small instruction cache.
