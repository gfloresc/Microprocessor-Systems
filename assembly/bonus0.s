.global _start

_start:

    LDR R0, =numbers     @ Pointer to array
    MOV R1, #4           @ Number of elements
    MOV R2, #0           @ Sum accumulator

loop:
    LDR R3, [R0]         @ Load current element
    ADD R2, R2, R3       @ sum = sum + value
    ADD R0, R0, #4       @ Move to next element
    SUBS R1, R1, #1      @ Decrement counter
    BNE loop             @ Repeat if not zero

stop:
    B stop               @ Infinite loop


numbers:
    .word 5, 10, 15, 20
