# Exercise 3 - Count Even Array Elements

## What the program does

The program loops through an array and counts how many elements are even

The array is:

[4, 7, 10, 13, 16, 21]

There are 3 even numbers.

## Registers

- t0: base address of the array
- t1: number of elements
- t2: array index
- t3: even-number count
- t4: byte offset for array indexing
- t5: address of the current array element
- t6: current array value / bit-test result

## Harder than expected

Array indexing is different in assembly because each integer is 4 bytes. Therefore, the index must be multiplied by 4.

The `andi` instruction tests the lowest bit. If the lowest bit is 0, the number is even.

The final count is stored in t3