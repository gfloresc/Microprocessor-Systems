.global _start

.section .text
_start:
    MOV R0, #5      @ Load first number (R0 = 5)
    MOV R1, #5      @ Load second number (R1 = 5)

    CMP R0, R1      @ Compare R0 and R1
    BEQ equal       @ If R0 == R1, jump to "equal"
    
    MOV R2, #0      @ Else, store 0 in R2
    B end_program   @ Skip "equal" section

equal:
    MOV R2, #1      @ Store 1 in R2 if equal

end_program:
    B end_program   @ Infinite loop (stop execution)
