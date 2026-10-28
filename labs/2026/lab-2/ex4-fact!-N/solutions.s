.data
N:
    .word 5

.text
.globl main

main:
    #factorial (N) 
    la   t0, N
    lw   a0, 0(t0)          # a0 = N  (argument register)

    jal  ra, factorial      # call the procedure

                         # a0 now holds N!
    mv   a1, a0             # keep result for printing
    mv   a0, a1
    li   a7, 1              # PrintInt
    ecall

    li   a7, 10             # exit
    ecall

# factorial: a0 = n  →  a0 = n!
# Uses a loop, no recursion
factorial:

    li   t0, 1              # t0 = result = 1
    mv   t1, a0             # t1 = counter = n

floop:
    blez t1, fdone          # while counter > 0
    mul  t0, t0, t1         # result *= counter
    addi t1, t1, -1         # counter--
    j    floop

fdone:                      #return to caller
    mv   a0, t0   
    ret