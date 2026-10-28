# RISC-V Program Notes

## What the program does
The program stores two integers, `42` and `18`, in memory. It loads both values into registers, compares them, and stores the larger value in `t3`.

For this program:
- `num1 = 42`
- `num2 = 18`
- `larger = 42`

## Register contents
| Register | Purpose |
|---|---|
| `t0` | Temporary address register used to access `num1` and `num2` |
| `t1` | Holds `num1` (`42`) |
| `t2` | Holds `num2` (`18`) |
| `t3` | Holds the larger number (`42`) |

## Harder than expected
The comparison was slightly tricky because RISC-V uses `blt` (branch if less than). Instead of writing `num1 > num2`, the program checks:

```asm
blt t2, t1, num1_larger
```

This is equivalent to `t1 > t2`. Also, Ripes does not use RARS-style `ecall` printing in the same way, so the Ripes version leaves the result in `t3` for inspection.
