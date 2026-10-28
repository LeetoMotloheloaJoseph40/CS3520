    .data
larger_msg: .string "Larger: "

    .text
    .globl main
main:
    li   t0, 15          # first integer
    li   t1, 27          # second integer

    # Compare: if t0 >= t1, t0 is larger (or equal); else t1 is larger
    bge  t0, t1, t0_bigger
    mv   a0, t1          # t1 is larger
    j    print

t0_bigger:
    mv   a0, t0          # t0 is larger

print:
    # Print "Larger: "
    li   a7, 4           # syscall: print string
    la   a0, larger_msg
    ecall

    # Print the larger integer
    li   a7, 1           # syscall: print integer
    ecall                # a0 still holds the larger value

    # Exit
    li   a7, 10          # syscall: exit
    ecall