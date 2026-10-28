# Exercise 4 - Factorial Procedure

## What the program does

Computes N! for N = 5 in a separate procedure, using a loop. `main`
loads N into `a0`, calls `factorial`, and prints the result returned
in `a0`.

For N = 5:  5! = 5 × 4 × 3 × 2 × 1 = 120

## C++ model ↔ assembly

The C++ model uses an ascending loop `for (i = 1; i <= n; i++)`.
The assembly mirrors this exactly: `i` is held in `t1`, initialised
to 1, incremented by 1 each pass, and the loop exits when `i > n`.

## Registers

| Register | Role |
|---|---|
| `a0`     | In: N; Out: N! |
| `ra`     | Return address set by `jal` |
| `t0`     | Accumulator (result) |
| `t1`     | Loop counter `i` |
| `a7`     | Syscall selector (1 = PrintInt, 10 = Exit) |
| `t0` (main) | Address of `N` in `.data` |

## Stack

`factorial` is a **leaf procedure** — it calls nothing, uses only
`t`-registers, and never overwrites `ra`. Therefore **no stack frame
is required**: `ra` set by the caller's `jal` is still valid on
return, and there are no callee-saved registers to preserve.

A stack frame would only be needed if the procedure were recursive,
because each recursive `jal` would overwrite `ra` and the previous
`n` would need to be restored after the recursive call returned.

## Returning

Return uses the `ret` pseudo-instruction (Ripes rejects the
`jalr zero, 0(ra)` form):

    ret       # expands to: jalr x0, 0(x1)

Equivalents that Ripes also accepts:

    jalr ra, 0(ra)
    jalr zero, ra, 0

## Harder than expected

- Getting the calling convention right: argument in `a0` before the
  `jal`, return value placed back in `a0` before the `ret`.
- Ripes' pseudo-instruction subset is stricter than RARS — the
  two-operand `jalr zero, 0(ra)` was rejected, so `ret` was used.
- Deciding whether a stack frame was needed; realising a leaf
  procedure does not need one avoids unnecessary memory traffic.