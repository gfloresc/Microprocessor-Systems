.global _start

.section .text
_start:
    MOV R0, #7
    MOV R1, #4
    BL first_function
    B _start

first_function:
    PUSH {LR}        // Save LR before calling another function
    BL second_function
    POP {LR}         // Restore LR before returning
    BX LR

second_function:
    ADD R0, R0, R1   // Add R0 and R1
    BX LR
