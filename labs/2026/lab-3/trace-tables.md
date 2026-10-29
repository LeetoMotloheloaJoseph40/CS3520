# CS3520 Lab 3 trace tables

I used the Ripes screenshots to fill in the values below. Hex values are written with eight digits where appropriate.

## Step 3: `add t2, t0, t1` at PC `0x00000008`

| Element | Port / signal | Value |
|---|---|---|
| `pc_reg` | out | `0x00000008` |
| `pc_4` | out | `0x0000000C` |
| `instr_mem` | data_out | `0x006283B3` |
| `decode` | rs1 / rs2 | x5 / x6 (`t0` / `t1`) |
| `decode` | rd | x7 (`t2`) |
| `control` | reg_do_write_ctrl | 1 |
| `control` | alu_op2_ctrl | register operand (`rs2`) |
| `registerFile` | r1_out / r2_out | 12 / 5 |
| `alu_op1_src` | out | 12 |
| `alu_op2_src` | out | 5 |
| `alu` | res | 17 (`0x00000011`) |
| `data_mem` | wr_en | 0 |
| `reg_wr_src` | select / out | ALU / 17 |
| `pc_src` | select / out | sequential / `0x0000000C` |

The ALU result is also present at `data_mem.addr` even though the instruction is not a load or store. The disabled write enable makes it harmless.

## Step 4: instruction classes

Mux descriptions name the selected values or sources. Branch/jump next-PC values are the values observed in this program's execution.

| Instruction | Format | Immediate | ALU input 1 | ALU input 2 | `alu.res` | Write-back / next PC |
|---|---|---:|---|---|---:|---|
| `addi t0, zero, 12` | I | 12 | 0 | 12 | 12 | ALU = 12 / `0x04` |
| `add t2, t0, t1` | R | 0 | 12 | 5 | 17 | ALU = 17 / `0x0C` |
| `lui t4, 0x2B` | U | `0x0002B000` (176128) | 0 | immediate | 176128 | ALU = 176128 / `0x14` |
| `auipc t5, 0` | U | 0 | PC (`0x14`) | immediate | 20 | ALU = 20 / `0x18` |
| `lw a1, 0(a0)` | I | 0 | `0x10000000` | 0 | `0x10000000` | memory = 42 / `0x24` |
| `sw t2, 4(a0)` | S | 4 | `0x10000000` | 4 | `0x10000004` | no register write / `0x28` |
| `beq t0, t1, skip` | B | 8 | 12 | 5 | 7 (comparison is separate) | not taken; `pc_src=0`, next=`0x2C` |
| `bne t0, t1, target` | B | 8 | 12 | 5 | 7 (comparison is separate) | taken; `pc_src=1`, next=`0x34` |
| `jal ra, report` | J | 12 | PC (`0x34`) | 4 | link value `0x38` | PC+4 to `ra`; next=`0x40` |
| `jalr zero, ra, 0` | I | 0 | `ra` (`0x38`) | 0 | target `0x38` | PC+4 is discarded at x0; next=`0x38` |

## Ripes pipeline measurements

| Program | Cycles | Retired | CPI | Confirmed observation |
|---|---:|---:|---:|---|
| `pipeline-basic.s` | 15 | 10 | 1.50 | No data stall in the independent instruction stream. |
| `hazard-raw.s` | 15 | 9 | 1.67 | Forwarding supplies the `t0` dependencies in the observed sequence. |
| `hazard-loaduse.s` | 14 | 9 | 1.56 | Dependent `addi` held in ID; EX bubble at cycle 6. |
| `hazard-control.s` | 18 | 10 | 1.80 | Two wrong-path instructions flushed; target enters IF at cycle 7. |

The ecall timing was not the same in every run, so I recorded the cycle count shown for each program separately.
