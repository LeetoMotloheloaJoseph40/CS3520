.data
num1: .word 42
num2: .word 18

.text
.globl main

main:
    # Load num1
    la   t0, num1
    lw   t1, 0(t0)       # t1 = 42

    # Load num2
    la   t0, num2
    lw   t2, 0(t0)       # t2 = 18

    # Compare num1 and num2
    blt  t2, t1, num1_larger

    # num2 is larger
    mv   t3, t2
    j    done

num1_larger:
    # num1 is larger
    mv   t3, t1

done:
    # t3 contains the larger number
    # t3 = 42

    nop