.global _start
_start:

    LDR R0, =data          @ R0 points to the first value
    LDR R1, =buffer        @ R1 points to SRAM buffer

    LDR R2, [R0], #4       @ Load MEM[R0] into R2, then R0 = R0 + 4
    STR R2, [R1], #4       @ Store R2 into MEM[R1], then R1 = R1 + 4

stop:
    B stop                 @ Infinite loop


data:
    .word 10, 20           @ Two 32-bit values

buffer:
    .space 8               @ Space for two 32-bit values