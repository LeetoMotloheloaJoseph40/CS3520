.data
A:
    .word 48

B:
    .word 18

.text
.globl main

main:
    # Load first number
    la   t0, A
    lw   a0, 0(t0)          # a0 = 48

    # Load second number
    la   t0, B
    lw   a1, 0(t0)          # a1 = 18

    # Call gcd(a, b)
    jal  ra, gcd

    # Result is returned in a0
    # For 48 and 18: a0 = 6

done:
    nop


# ------------------------------------------------
# gcd
#
# Input:
#   a0 = a
#   a1 = b
#
# Output:
#   a0 = gcd(a,b)
# ------------------------------------------------

gcd:
    # Save return address
    addi sp, sp, -4
    sw   ra, 0(sp)

gcd_loop:
    # If b == 0, a is the GCD
    beq  a1, zero, gcd_done

    # Calculate a % b
    rem  t0, a0, a1

    # a = b
    mv   a0, a1

    # b = remainder
    mv   a1, t0

    # Repeat
    j    gcd_loop

gcd_done:
    # a0 already contains the GCD

    # Restore return address
    lw   ra, 0(sp)

    # Restore stack
    addi sp, sp, 4

    # Return
    mv   a0, t0   
    ret