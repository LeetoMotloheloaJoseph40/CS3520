.data
arr:
    .word 4, 7, 10, 13, 16, 21

n:
    .word 6

.text
.globl main

main:
    # Load array address
    la   t0, arr

    # Load n
    la   t1, n
    lw   t1, 0(t1)          # t1 = n

    # Initialise
    li   t2, 0              # t2 = index i
    li   t3, 0              # t3 = even count

loop:
    # if i >= n, finish
    bge  t2, t1, done

    # Calculate address of arr[i]
    slli t4, t2, 2          # t4 = i * 4
    add  t5, t0, t4         # t5 = &arr[i]

    # Load arr[i]
    lw   t6, 0(t5)

    # Bit test: isolate lowest bit
    andi t6, t6, 1

    # If lowest bit is 1 → odd → skip
    bne  t6, zero, not_even

    # Number is even → increment count
    addi t3, t3, 1

not_even:
    addi t2, t2, 1          # i++
    j    loop

done:
    # Print the even count
    mv   a0, t3             # a0 = even count
    li   a7, 1              # a7 = 1 -> PrintInt
    ecall

    # Exit
    li   a7, 10
    ecall
    