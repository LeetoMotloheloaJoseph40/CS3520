# RISC-V Counted Loop Notes

## What the program does
The program reads `N` from memory and computes the sum of the first `N` integers:

`1 + 2 + ... + N`

For `N = 10`, the result is `55`.

## Register contents
| Register | Purpose |
|---|---|
| `t0` | Address of `N` |
| `t1` | Value of `N` |
| `t2` | Loop counter `i` |
| `t3` | Running sum |

The loop uses a branch to stop when `i > N`:

```asm
bgt t2, t1, done
```

Then it adds `i` to the sum and increments `i`.

## Harder than expected
The main tricky part was translating the C++ `for` loop into explicit assembly. In RISC-V, the loop condition, increment, and repetition must all be written manually. The result is left in `t3` for inspection in Ripes.
