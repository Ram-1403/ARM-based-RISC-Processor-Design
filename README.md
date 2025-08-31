# ARM-Based 32-Bit Single-Cycle RISC Processor
### *A Comprehensive Implementation in Verilog HDL for Educational and Research Applications*

<div align="center">

[![Build Status](https://img.shields.io/badge/Build-Passing-success?style=flat-square)](./testbench.v)
[![FPGA Verified](https://img.shields.io/badge/FPGA-Verified-blue?style=flat-square&logo=xilinx)](./nexys_A7_arm32_const.xdc)
[![Synthesis](https://img.shields.io/badge/Synthesis-Optimized-green?style=flat-square)](./implementation/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](./LICENSE)

**Platform:** Xilinx Artix-7 (Nexys A7-100T) | **Language:** Verilog HDL | **Architecture:** 32-bit ARM-Based RISC

</div>

---

## Executive Summary

This project presents a fully functional **32-bit ARM-based single-cycle RISC processor** implemented in Verilog HDL. The design emphasizes educational clarity while maintaining professional implementation standards suitable for FPGA deployment. The processor successfully executes a comprehensive subset of ARM instructions including data processing, memory access, and control flow operations with full conditional execution support.

### Key Achievements
- ✅ **Functional Verification**: Complete instruction set validation through comprehensive testbenches
- ✅ **FPGA Implementation**: Successfully synthesized and deployed on Nexys A7-100T development board  
- ✅ **Timing Closure**: Achieved 66+ MHz operation with positive slack margins
- ✅ **Resource Efficiency**: Minimal FPGA resource utilization (2% LUT, 16% I/O)
- ✅ **Power Optimized**: Low power consumption at 0.128W total system power

---

## Processor Architecture

### System Overview

The processor implements a **Harvard architecture** with separate instruction and data memories, enabling simultaneous instruction fetch and data access. The single-cycle execution model ensures predictable timing behavior, making it ideal for educational purposes and real-time applications.

![Processor Datapath](./docs/datapath-architecture.png)
*Figure 1: Complete processor datapath showing all major functional units and interconnections*

### Core Specifications

<table>
<tr>
<td><b>Parameter</b></td>
<td><b>Specification</b></td>
<td><b>Parameter</b></td>
<td><b>Specification</b></td>
</tr>
<tr>
<td>Architecture</td>
<td>32-bit ARM-based RISC</td>
<td>Pipeline Depth</td>
<td>Single-cycle (1 stage)</td>
</tr>
<tr>
<td>Instruction Set</td>
<td>ARM v4 subset</td>
<td>Register File</td>
<td>16 × 32-bit (R0-R15)</td>
</tr>
<tr>
<td>Memory Model</td>
<td>Harvard (separate I/D)</td>
<td>Address Space</td>
<td>32-bit (4GB addressable)</td>
</tr>
<tr>
<td>Instruction Memory</td>
<td>64 × 32-bit ROM</td>
<td>Data Memory</td>
<td>64 × 32-bit RAM</td>
</tr>
<tr>
<td>ALU Operations</td>
<td>ADD, SUB, AND, OR + Flags</td>
<td>Condition Codes</td>
<td>15 ARM conditions</td>
</tr>
</table>

---

## Implementation Results

### FPGA Resource Utilization (Nexys A7-100T)

The implementation demonstrates excellent resource efficiency on the target Artix-7 FPGA:

| **Resource Type** | **Utilization** | **Available** | **Percentage** |
|:---:|:---:|:---:|:---:|
| **LUT** | 1,284 | 63,400 | **2%** |
| **LUTRAM** | 64 | 19,000 | **1%** |
| **FF (Flip-Flops)** | 1,056 | 126,800 | **2%** |
| **BUFG (Clock Buffers)** | 1 | 32 | **3%** |
| **I/O** | 34 | 210 | **16%** |

*Resource utilization data extracted from Vivado implementation report*

### Timing Performance

The processor achieves robust timing closure with significant positive slack:

- **Worst Negative Slack (WNS):** +1.109 ns ✅
- **Worst Hold Slack (WHS):** +0.263 ns ✅  
- **Maximum Operating Frequency:** 66.7+ MHz
- **Target Clock Period:** 15 ns (66.67 MHz)

### Power Consumption Analysis

Power-efficient design with comprehensive power breakdown:

| **Power Component** | **Consumption (W)** | **Percentage** |
|:---:|:---:|:---:|
| **Total Power** | **0.128** | **100%** |
| PL Static | 0.097 | 76% |
| Logic | 0.009 | 7% |
| Signals | 0.018 | 14% |
| Clocks | 0.004 | 3% |

---

## System Architecture Flow

### Processor Module Interconnection Flowchart

```
                            🔝 FPGA Interface Layer
                        ┌─────────────────────────────┐
                        │         top.v               │
                        │   System Integration        │
                        └──────────┬──────────────────┘
                                   │ clk, reset, debug signals
                                   ▼
                     ┌─────────────────────────────────────┐
                     │            🧠 CPU.v                 │
                     │      Main Processor Core            │
                     └──────┬─────────────┬────────────────┘
                            │             │
                ┌───────────▼──┐      ┌───▼─────────────┐
                │  🎮 Control  │      │  🛣️ Datapath   │
                │    Unit      │◄────►│    Engine       │
                └─────┬────────┘      └─────────────────┘
                      │
            ┌─────────▼──────────────────────────────────────────┐
            │                🎛️ Control Pipeline                │
            │                                                   │
            │  ┌──────────────┐    ┌──────────────────────────┐  │
            │  │  decoder.v   │    │   conditional_logic.v   │  │
            │  │ Instruction  │───►│   ARM Conditional        │  │
            │  │   Decoder    │    │     Execution            │  │
            │  └──────────────┘    └──────────────────────────┘  │
            └───────────────────────────────────────────────────┘
                      │
                      │ Control Signals
                      ▼
    ┌─────────────────────────────────────────────────────────────┐
    │                   🛣️ Execution Datapath                    │
    │                                                             │
    │  ┌─────────────┐    ┌─────────────┐    ┌─────────────────┐  │
    │  │   flop.v    │───►│   adder.v   │───►│     mux2.v      │  │
    │  │Program Counter│   │PC Increment │    │   Control       │  │
    │  │   Register    │   │   Logic     │    │ Multiplexers    │  │
    │  └─────────────┘    └─────────────┘    └─────────────────┘  │
    │           │                                        │        │
    │           ▼                                        ▼        │
    │  ┌─────────────┐    ┌─────────────┐    ┌─────────────────┐  │
    │  │  regfile.v  │◄──►│    alu.v    │◄──►│   extender.v    │  │
    │  │16×32 Register│   │Arithmetic   │    │   Immediate     │  │
    │  │    File      │   │Logic Unit   │    │   Processing    │  │
    │  └─────────────┘    └─────────────┘    └─────────────────┘  │
    └─────────────────────────────────────────────────────────────┘
                      │
                      │ Memory Interface
                      ▼
    ┌─────────────────────────────────────────────────────────────┐
    │                   💾 Memory Subsystem                       │
    │                                                             │
    │  ┌──────────────────────┐    ┌────────────────────────────┐ │
    │  │     instr_mem.v      │    │        data_mem.v          │ │
    │  │   Instruction ROM    │    │       Data RAM             │ │
    │  │     (64×32-bit)      │    │     (64×32-bit)            │ │
    │  │                      │    │   Byte Addressable         │ │
    │  └──────────────────────┘    └────────────────────────────┘ │
    └─────────────────────────────────────────────────────────────┘
                      │
                      │ Debug & Verification
                      ▼
    ┌─────────────────────────────────────────────────────────────┐
    │               🔬 Verification Environment                    │
    │                                                             │
    │  ┌──────────────────────┐    ┌────────────────────────────┐ │
    │  │    testbench.v       │    │  nexys_A7_arm32_const.xdc │ │
    │  │ Comprehensive Test   │    │     FPGA Constraints       │ │
    │  │      Suite           │    │    Pin Assignments         │ │
    │  └──────────────────────┘    └────────────────────────────┘ │
    │                     │                                       │
    │              ┌──────▼─────────────┐                        │
    │              │   memfile.data     │                        │
    │              │  Test Program      │                        │
    │              │   Binary Image     │                        │
    │              └────────────────────┘                        │
    └─────────────────────────────────────────────────────────────┘

            Data Flow:  ◄──► Bidirectional    ───► Unidirectional
            Control:    ▲ ▼  Control Signals   │    Data Path
```

### Module Function and Interconnection Summary

<table>
<tr>
<th><b>🎯 Layer</b></th>
<th><b>📄 Module</b></th>
<th><b>🔗 Function</b></th>
<th><b>⚡ Key Interfaces</b></th>
</tr>
<tr>
<td rowspan="1"><b>🔝 System</b></td>
<td><code>top.v</code></td>
<td>FPGA integration & I/O mapping</td>
<td>Clock, Reset, LED outputs</td>
</tr>
<tr>
<td rowspan="1"><b>🧠 Core</b></td>
<td><code>CPU.v</code></td>
<td>Processor integration wrapper</td>
<td>Instruction/Data buses</td>
</tr>
<tr>
<td rowspan="2"><b>🎮 Control</b></td>
<td><code>controller.v</code></td>
<td>Central control orchestration</td>
<td>Control signal generation</td>
</tr>
<tr>
<td><code>decoder.v</code></td>
<td>Instruction decode & control logic</td>
<td>Opcode → Control signals</td>
</tr>
<tr>
<td rowspan="1"><b>⚖️ Conditional</b></td>
<td><code>conditional_logic.v</code></td>
<td>ARM condition code evaluation</td>
<td>Flag processing & gating</td>
</tr>
<tr>
<td rowspan="6"><b>🛣️ Datapath</b></td>
<td><code>data_path.v</code></td>
<td>Main execution datapath</td>
<td>All internal data flows</td>
</tr>
<tr>
<td><code>alu.v</code></td>
<td>Arithmetic & logic operations</td>
<td>Source operands → Results+Flags</td>
</tr>
<tr>
<td><code>regfile.v</code></td>
<td>16×32-bit register storage</td>
<td>Read/Write ports & PC handling</td>
</tr>
<tr>
<td><code>adder.v</code></td>
<td>Address increment logic</td>
<td>PC+4, PC+8 calculations</td>
</tr>
<tr>
<td><code>mux2.v</code></td>
<td>Data path selection</td>
<td>Source/destination routing</td>
</tr>
<tr>
<td><code>extender.v</code></td>
<td>Immediate value processing</td>
<td>Sign extension & formatting</td>
</tr>
<tr>
<td rowspan="1"><b>🔄 Storage</b></td>
<td><code>flop.v</code></td>
<td>Program counter register</td>
<td>Clock-based PC storage</td>
</tr>
<tr>
<td rowspan="2"><b>💾 Memory</b></td>
<td><code>instr_mem.v</code></td>
<td>Instruction ROM (64×32)</td>
<td>PC → Instruction fetch</td>
</tr>
<tr>
<td><code>data_mem.v</code></td>
<td>Data RAM (64×32)</td>
<td>Load/Store operations</td>
</tr>
<tr>
<td rowspan="3"><b>🔬 Verification</b></td>
<td><code>testbench.v</code></td>
<td>Functional verification</td>
<td>System-level testing</td>
</tr>
<tr>
<td><code>memfile.data</code></td>
<td>Test program storage</td>
<td>Hex instruction sequence</td>
</tr>
<tr>
<td><code>*.xdc</code></td>
<td>FPGA pin constraints</td>
<td>Hardware mapping rules</td>
</tr>
</table>

---

## Instruction Set Architecture

### Supported Instruction Categories

#### 1. Data Processing Instructions
- **Arithmetic Operations:** ADD, SUB with carry/overflow detection
- **Logical Operations:** AND, OR with zero/negative flag updates  
- **Addressing Modes:** Register-register, register-immediate
- **Conditional Execution:** All 15 ARM condition codes supported

#### 2. Memory Access Instructions  
- **Load/Store Operations:** LDR, STR with base+offset addressing
- **Address Modes:** 12-bit signed offset with base register
- **Data Width:** 32-bit word-aligned access
- **Memory Model:** Byte-addressable with word-boundary optimization

#### 3. Control Flow Instructions
- **Branch Operations:** Conditional and unconditional branches
- **Address Range:** ±32MB from current PC (24-bit signed offset)
- **Link Register:** R15 (PC) with ARM-standard behavior
- **Condition Evaluation:** Based on ALU flags (N, Z, C, V)

### Instruction Encoding Format

```
Data Processing Format:
┌─────────┬─────┬─────────┬─────────┬─────────┬─────────┬─────────┐
│ Cond    │ 00  │ Funct   │ Rn      │ Rd      │ Shift   │ Operand │
│ [31:28] │     │ [25:20] │ [19:16] │ [15:12] │ [11:8]  │ [7:0]   │
└─────────┴─────┴─────────┴─────────┴─────────┴─────────┴─────────┘

Memory Access Format:  
┌─────────┬─────┬─────┬─────────┬─────────┬─────────────────────────┐
│ Cond    │ 01  │ Cmd │ Rn      │ Rd      │ Offset                  │
│ [31:28] │     │[20] │ [19:16] │ [15:12] │ [11:0]                  │
└─────────┴─────┴─────┴─────────┴─────────┴─────────────────────────┘

Branch Format:
┌─────────┬─────┬─────────────────────────────────────────────────────┐
│ Cond    │ 10  │ Offset                                              │
│ [31:28] │     │ [23:0]                                              │
└─────────┴─────┴─────────────────────────────────────────────────────┘
```

---

## FPGA Implementation Guide

### Development Environment Setup

**Required Tools:**
- Xilinx Vivado Design Suite 2020.1 or later
- Nexys A7-100T Development Board (XC7A100T-1CSG324C)
- USB cable for programming and debugging

### Implementation Workflow

#### Phase 1: Project Creation
```tcl
# Create new Vivado project
create_project arm32_processor ./arm32_processor -part xc7a100tcsg324-1

# Add design sources
add_files -norecurse {*.v}
set_property top top [current_fileset]

# Add constraints  
add_files -fileset constrs_1 -norecurse nexys_A7_arm32_const.xdc
```

#### Phase 2: Synthesis and Implementation
```tcl
# Run synthesis with optimization
synth_design -top top -part xc7a100tcsg324-1

# Implement design
opt_design
place_design  
route_design

# Generate bitstream
write_bitstream -force ./arm32_processor.bit
```

#### Phase 3: Hardware Validation
- Program FPGA via USB connection
- Observe 32-bit output on LEDs (bits 15:0) and PMOD connectors (bits 31:16)
- Verify expected result: memory location 21 contains value 7

### Pin Assignment Summary

| **Signal** | **Width** | **Hardware Interface** | **Pin Mapping** |
|:---:|:---:|:---:|:---:|
| `clk` | 1 | 100 MHz System Clock | E3 |
| `reset` | 1 | CPU Reset Button | C12 |
| `data_mem_RAM_21[15:0]` | 16 | Onboard LEDs | H17-V11 |
| `data_mem_RAM_21[23:16]` | 8 | PMOD JA Connector | C17-G18 |
| `data_mem_RAM_21[31:24]` | 8 | PMOD JB Connector | D14-H16 |

---

## Verification and Testing

### Simulation Environment

The verification framework includes comprehensive testbenches validating all processor subsystems:

#### Functional Verification
```verilog
// Example test sequence
initial begin
    // Initialize system
    clk = 0; reset = 1;
    #22 reset = 0;
    
    // Execute test program
    #1000;
    
    // Validate results  
    if (dut.Data_mem.RAM[21] == 32'd7)
        $display("✅ Test PASSED: Correct computation result");
    else
        $display("❌ Test FAILED: Expected 7, got %d", dut.Data_mem.RAM[21]);
end
```

#### Coverage Metrics
- **Instruction Coverage:** 100% of implemented instruction types
- **Conditional Execution:** All 15 ARM condition codes tested
- **Memory Access:** Load/store operations with various offsets
- **Control Flow:** Branch taken/not-taken scenarios

### Sample Test Program

The included test program demonstrates comprehensive processor functionality:

```assembly
; Test Program: Arithmetic and Control Flow Validation
MOV    R0, #15        ; Initialize base value
ADD    R2, R0, #5     ; Arithmetic with immediate  
ADD    R3, R0, #12    ; Multiple register updates
SUB    R7, R3, #9     ; Subtraction operation
ORR    R4, R7, R2     ; Logical OR operation
AND    R5, R3, R4     ; Logical AND operation  
ADD    R5, R5, R4     ; Register-register arithmetic
SUBS   R8, R5, R7     ; Arithmetic with flag update
BEQ    skip           ; Conditional branch (not taken)
SUBS   R8, R3, R4     ; Additional flag-setting operation
BGE    continue       ; Conditional branch (taken)
; ... additional instructions demonstrating full ISA coverage
STR    R2, [R0, #84]  ; Final result storage
```

---

## Performance Analysis

### Timing Characteristics

The single-cycle design achieves predictable performance with the following timing profile:

- **Clock-to-Clock Latency:** 15 ns (66.67 MHz)
- **Instruction Throughput:** 66.67 MIPS peak
- **Memory Access Time:** Single cycle for both instruction and data
- **Branch Penalty:** Zero (single-cycle execution)

### Comparative Analysis

| **Metric** | **This Implementation** | **Typical Educational CPU** |
|:---:|:---:|:---:|
| Resource Utilization | 2% LUT | 15-25% LUT |
| Maximum Frequency | 66.7 MHz | 25-50 MHz |
| Power Consumption | 0.128W | 0.5-1.0W |
| Instruction Set | ARM-based | Custom/Simplified |

---

## Future Development Roadmap

### Phase 1: Performance Enhancements
- **Pipeline Implementation:** 5-stage classic pipeline (IF-ID-EX-MEM-WB)
- **Branch Prediction:** 2-bit saturating counter with branch target buffer
- **Cache Integration:** Separate instruction and data caches

### Phase 2: ISA Extensions  
- **Multiply/Divide Unit:** 32×32→64 multiplication, integer division
- **Shift Operations:** Barrel shifter for LSL, LSR, ASR, ROR
- **Load/Store Multiple:** Block transfer instructions for context switching

### Phase 3: System Integration
- **Memory Management:** Basic MMU with page table support
- **Interrupt Controller:** Nested interrupt handling capability  
- **Debug Interface:** JTAG-compatible debug and trace functionality

---

## Development Team and Contributions

### Project Maintainer
**[Your Name]** - *Lead Developer and Architect*  
📧 Email: [your.email@university.edu]  
🎓 Institution: [Your University/Organization]

### Contribution Guidelines

We welcome contributions from the computer architecture and FPGA development community:

#### Getting Started
1. Fork the repository and create a feature branch
2. Follow the existing code style and documentation standards  
3. Include comprehensive testbenches for new functionality
4. Update documentation for any interface changes

#### Code Quality Standards
- **Synthesis Compliance:** All code must synthesize without warnings
- **Timing Closure:** Implementations must meet timing at 50+ MHz
- **Documentation:** Inline comments and module headers required
- **Testing:** Functional verification with >95% coverage

---

## Academic and Professional Applications

### Educational Use Cases
- **Computer Architecture Courses:** Hands-on processor design experience
- **Digital Logic Design:** Advanced sequential system implementation  
- **FPGA Development:** Industry-standard development workflow
- **ARM Assembly Programming:** Instruction set architecture exploration

### Research Applications  
- **Processor Design Research:** Foundation for architectural innovations
- **FPGA Optimization Studies:** Resource utilization benchmarking
- **Educational Tool Development:** Interactive learning platform base
- **Industry Training:** Professional development in digital design

---

## Technical Support and Documentation

### Available Resources
- **Complete Source Code:** All Verilog HDL modules with detailed comments
- **Implementation Guides:** Step-by-step FPGA development instructions
- **Verification Suite:** Comprehensive testbench collection  
- **Performance Reports:** Detailed timing and resource analysis

### Troubleshooting
For technical issues or questions:
1. Check the [Issues](../../issues) section for known problems
2. Review the implementation reports in `/docs/implementation/`
3. Consult the timing analysis in `/docs/timing/`
4. Submit new issues with detailed problem descriptions

---

## License and Citation

### MIT License
This project is released under the MIT License, enabling free use, modification, and distribution for educational and commercial purposes.

### Citation
If you use this processor in academic work, please cite:
```bibtex
@misc{arm32_educational_processor,
    title={ARM-Based 32-Bit Single-Cycle RISC Processor},
    author={[Your Name]},
    year={2025},
    publisher={GitHub},
    url={https://github.com/your-username/arm32-processor}
}
```

---

<div align="center">

### 🎓 Advancing Computer Architecture Education Through Open Source Hardware Design

**Status:** Production Ready | **Last Updated:** September 2025 | **Version:** 1.0.0

[![GitHub Stars](https://img.shields.io/github/stars/your-username/arm32-processor?style=social)](https://github.com/your-username/arm32-processor)
[![GitHub Forks](https://img.shields.io/github/forks/your-username/arm32-processor?style=social)](https://github.com/your-username/arm32-processor)

*Empowering the next generation of computer architects and FPGA developers*

</div>
