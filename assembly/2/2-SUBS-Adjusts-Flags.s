.global _start

.section .text
_start:
    MOV R0, #3     @ Load 3 into R0

loop:
    SUBS R0, R0, #1  @ R0 = R0 - 1 and updates flags
    BNE loop         @ If R0 ≠ 0, repeat loop

end:
    B end            @ Stop execution
