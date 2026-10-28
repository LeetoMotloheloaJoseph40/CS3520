.data
N:      .word 10

.text
.globl main

main:
    la   t0, N
    lw   t1, 0(t0)       # t1 = N

    li   t2, 1           # t2 = i
    li   t3, 0           # t3 = sum

loop:
    bgt  t2, t1, done    # if i > N, exit loop
    add  t3, t3, t2      # sum = sum + i
    addi t2, t2, 1       # i = i + 1
    j    loop

done:
    # t3 contains the sum
    # For N = 10, t3 = 55
    nop
