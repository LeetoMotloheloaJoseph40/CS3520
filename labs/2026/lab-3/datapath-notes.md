# CS3520 Lab 3 datapath notes

## Step 2: third write-back choice

The write-back mux selects among the ALU result, data-memory output, and PC+4. The third input is PC+4, used to save the return address for link instructions such as `jal` and `jalr`.

## Step 4 questions

1. `lui` and `auipc` share the U-format immediate, but choose different first ALU operands. `lui` uses zero and places the shifted immediate in the destination. `auipc` uses the current PC and adds the shifted immediate.
2. `sw` uses `RegWrite=0` and `MemWrite=1`. The register write-back mux may still have some input selected, but the register file write enable is off, so no register is modified.
3. The branch comparator checks the two register values. Its result (`branch`) is combined with the branch control signal at `br_and`. That result is combined with the jump control at `controlflow_or`, which drives `pc_src`. For `beq`, the comparator result is 0 because 12 and 5 are not equal, so the PC continues to `0x2C`. For `bne`, the condition is true and `pc_src.select` is 1, so the PC goes to `0x34`.
4. `jal` and `jalr` save PC+4 through the third write-back mux input. The ALU is used to form the jump target, and data memory contains no return-address value, so neither supplies the link result.

## Step 6: implementation differences and trade-offs

### A. Branch target calculation reuses the ALU

There is no separate branch-target adder in the design I looked at. The ALU adds the PC and branch offset, while the comparator checks the register values. Sharing the ALU saves hardware. A separate adder could calculate the target at the same time as the comparison, but it would use more hardware.

### B. Branch comparison is separate from the ALU Zero output

The branch unit checks the register values separately instead of using the ALU Zero output. It can check all six RV32I branch conditions: `beq`, `bne`, `blt`, `bge`, `bltu`, and `bgeu`. This needs an extra comparator, but it keeps branch checking separate from the ALU calculation.

### C. Write-back has three inputs

The mux can select the ALU result, memory data, or PC+4. `jal` and `jalr` need PC+4 as the return address. Having the third input supports these instructions, but makes the mux wider than a two-input version.

## Step 5: single-cycle performance

Ripes listed 18 instructions for `trace-classes.s`. Seventeen executed because the taken branch skipped `addi a2, zero, 99`. The single-cycle statistics were 17 cycles, 17 retired instructions, CPI 1.00, and IPC 1.00. The clock rate shown by Ripes was 2.69 Hz on my run; that is the simulator's run speed, not the processor's designed clock frequency. Each instruction still takes the full clock cycle, which has to be long enough for the slowest instruction, `lw`.

The Week 7 worked example gives a single-cycle period of `30 + 2(250) + 150 + 200 + 25 + 20 = 925 ps`. If those same delays are split into five stages, the slowest stage is IF at about `30 + 250 = 280 ps` (ignoring pipeline-register overhead). So the single-cycle period is about `925 / 280 = 3.3` times longer. In the example, 10 million instructions at CPI 1 take `10,000,000 × 925 ps = 9.25 ms`.

## Ripes pipeline observations

- `hazard-raw.s`: forwarding supplies the `t0` values to the nearby consumers in the observed run.
- `hazard-loaduse.s`: the load-use pair causes one bubble because load data becomes available after the consumer's EX need; the dependent instruction is held in ID at cycle 6.
- `hazard-control.s`: the branch resolves taken in EX; the two younger sequential instructions are flushed, and the target starts IF at cycle 7.
- `pipeline-basic.s`: the independent instructions overlap without a data-dependency stall.

These cycle counts are from my Ripes runs. The ecall timing varied between programs, so I used the count shown for each run.
