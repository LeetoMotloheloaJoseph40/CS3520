# Exercise 5 - Greatest Common Divisor (GCD)

## What the program does

The program calculates the greatest common divisor (GCD) of two integers, `48` and `18`, using Euclid's algorithm. It repeatedly calculates the remainder until the second number becomes zero. The final result is **6**.

## Register contents

* `a0`: First number and final GCD result.
* `a1`: Second number, updated with each remainder.
* `t0`: Temporary register holding the remainder.
* `t1`: Not used.
* `ra`: Return address for the `gcd` procedure.
* `a7`: Selects the system call for printing and exiting in RARS-style environments.

## Harder than expected

The challenging part was updating the numbers in the correct order and returning the GCD through `a0`. The `rem` instruction calculates the remainder and requires the RISC-V M extension. Printing with `ecall` depends on the simulator; in Ripes, the result can be checked in register `a0` if console printing is unsupported.
