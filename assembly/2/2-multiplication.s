.global _start      @ Define the global entry point

.section .text
_start:
    MOV R0, #6      @ First number (example: 6)
    MOV R1, #7      @ Second number (example: 7)
    BL multiply     @ Call the multiply subroutine

    B stop          @ Stop execution

@ Subroutine to multiply two numbers
multiply:
    MUL R0, R0, R1  @ R0 = R0 * R1 (multiplication result)
    BX LR           @ Return to the caller

stop: 
    B stop          @ Infinite loop to stop execution
