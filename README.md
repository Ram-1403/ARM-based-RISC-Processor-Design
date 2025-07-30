# ARM-Based 32-Bit RISC Processor (Single-Cycle)

A compact **ARM-style 32-bit RISC processor** designed and implemented in **Verilog HDL**.  The core executes **data-processing, memory, and branch instructions** in a *single clock cycle* (no pipelining) and cleanly separates **datapath** and **control** logic for clarity and future scalability.

---

## Key Features

* **32-bit ARM-like Instruction Set**  
  • Data-processing (ADD, SUB, AND, OR, etc.)  
  • Memory access (LDR, STR with 12-bit offsets)  
  • Control-flow (conditional & unconditional branch)
* **Single-Cycle Datapath** – every instruction completes in one cycle, easing debugging and timing analysis.
* **Modular Verilog Design** – self-contained, synthesizable modules with clear bus interfaces.
* **Condition Codes & Flag Logic** – supports ARM NZCV flags and conditional execution.
* **Synthesis-Friendly** – coded with FPGA implementation in mind (no `x` in synthesizable paths, byte-addressable memories, etc.).

---

## Repository Layout

| Path / File | Role |
|-------------|------|
| `src/top.v` | Top-level wrapper tying CPU, instruction memory, and data memory together │
| `src/CPU.v` | Instantiates **controller** and **datapath**; exposes memory & PC ports |
| **Datapath** |
| `src/data_path.v` | Full 32-bit datapath: PC logic, register file, ALU, extenders, muxes |
| `src/alu.v` | 32-bit ALU with ADD, SUB, AND, OR and flag generation |
| `src/adder.v` | Generic 32-bit adder used for PC + 4 / PC + 8 |
| `src/regfile.v` | 16-register (R0–R15) file with R15 mapped to PC + 8 |
| `src/mux2.v` | Parameterised 2-to-1 multiplexer |
| `src/extender.v` | Zero / sign extender & left-shifter for immediate fields |
| `src/flop.v` | 32-bit D-flip-flop for PC register |
| **Control Path** |
| `src/controller.v` | Top control module – glues `decoder` & `conditional_logic` |
| `src/decoder.v` | Decodes opcode / funct fields to generate control signals |
| `src/conditional_logic.v` | Evaluates condition codes, flag writes & enables |
| `src/ff_2bit` | Two-bit enabled flip-flop used for flag banking |
| **Memory** |
| `src/instr_mem.v` | 64×32 instruction ROM, hex-filled via `$readmemh` |
| `src/data_mem.v` | 64×32 data RAM with byte-addressable interface |

> **No pipeline**: The processor is intentionally kept single-cycle for simplicity; future work can introduce classic 3-stage or 5-stage pipelines.

---

## Architectural Overview

### 1. Datapath

1. **Program Counter (PC)** – Stored in a 32-bit D-FF (`flop.v`).  Two adders generate *PC + 4* (sequential) and *PC + 8* (link register value).
2. **Register File** – Fifteen general registers (R0–R14) plus R15 (PC).  Write-back is disabled when destination is R15, aligning with ARM conventions.
3. **ALU** – Performs logic and arithmetic operations selected by `alu_control[1:0]`; generates **N Z C V** flags.
4. **Immediate Extender** – Handles three immediate encodings: 8-bit (data-processing), 12-bit (load/store), and 24-bit (branch) with left-shift-2.
5. **Operand & Result Multiplexers** – Provide flexible source selection (register vs immediate, ALU vs memory) controlled by the control path.

### 2. Control Path

1. **Decoder** – Uses `op[1:0]` and `funct[5:0]` fields to derive micro-ops: ALU operation, memory write, register write, branch flag, etc.
2. **Conditional Logic** – Implements ARM conditional execution.  Flags are double-buffered via `ff_2bit` to allow selective updates.  `CondEx` gate masks *PCSrc*, *RegWrite*, and *MemWrite* based on the instruction’s condition field.
3. **Controller** – Combines the above, producing the complete set of control signals for the datapath in every cycle.

![Single-Cycle Block Diagram](docs/architecture.png)

---

## Instruction Support

| Category | Example Mnemonics | Verilog Behaviour |
|----------|------------------|-------------------|
| Data-Processing | `ADD Rd,Rn,Imm` `AND Rd,Rn,Rs` | ALU selected, flags optionally updated |
| Memory | `LDR Rd,[Rn,#Imm]` `STR Rd,[Rn,Rm]` | Generates address via ALU; uses `data_mem` |
| Branch | `B label` `BEQ label` | PC updated with sign-extended offset |

Full encoding details are in comments inside `decoder.v`.

---

## Simulation & Verification

1. **Assemble Test Program**  
   • Write ARM-style opcodes into `memfile.mem.txt` (hex).  
   • Example stimulus provided in `/sim` directory.
2. **Run Simulation** (e.g. with *Icarus Verilog*):

```bash
iverilog -g2012 -o cpu_tb.vvp sim/cpu_tb.v src/**/*.v
vvp cpu_tb.vvp
```

3. **View Waveforms** with GTKWave:

```bash
gtkwave sim.vcd
```

Key signals to inspect: `pc`, `instr`, `alu_result`, `mem_write`, `data_mem_RAM_21` (example output probe).

---

## Synthesis Notes

* Written to meet FPGA synthesis requirements (tested on Xilinx Vivado 2024.1).  
* Replace `instr_mem` with block RAM or initialize via bootloader for real hardware.  
* Timing meets 50 MHz on Artix-7 when synthesized with default constraints.

---

## Getting Started

```bash
git clone <repo-url>
cd arm32-singlecycle
make sim         # run default simulation
after make synth  # generate bitstream (Vivado required)
```

Modify `memfile.mem.txt` to change the program image.

---

## Limitations & Future Work

* **No pipelining** – CPI = 1 but lower max clock; adding a 5-stage pipeline would improve frequency.
* **Limited instruction subset** – Only core integer ops; no shifts, coprocessor, or thumb mode.
* **No hazard detection** – Unnecessary in single-cycle but required once pipelined.
* **Cache & MMU** – Not implemented.

Planned enhancements include pipeline stages, forwarding logic, branch prediction, and AXI bus interface.

---

## License

Released under the MIT License – see `LICENSE` for details.
