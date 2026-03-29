.global _start     @ Define entry point

.section .text
_start:
    MOV R0, #5     @ Load number 5 into R0
    MOV R1, #3     @ Load number 3 into R1
    ADD R2, R0, R1 @ Add R0 + R1 and store in R2

    B .            @ Infinite loop (to prevent execution from stopping)
