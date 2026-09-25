.global _start

.section .text
_start:
    MOV R0, #5     @ Load 5 into R0
    MOV R1, #5     @ Load 5 into R1

    CMP R0, R1     @ Compare R0 and R1 (5 - 5 = 0)
    BEQ equal      @ If result is 0, jump to "equal"

    B end_program

equal:
    MOV R2, #1     @ If R0 == R1, store 1 in R2

end_program:
    B end_program  @ Infinite loop
