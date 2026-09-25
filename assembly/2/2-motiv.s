    .data
    t:  .word  0        @ Memory location to store the sum

    .text
    .global _start

_start:
    MOV R0, #1        @ Load first argument (1) into R0
    MOV R1, #2        @ Load second argument (2) into R1

    BL sum2           @ Call sum2 subroutine (result returned in R0)

    LDR R1, =t        @ Load the address of variable t into R1
    STR R0, [R1]      @ Store the result of sum in memory at address t

stop:
    B stop            @ Infinite loop to stop execution

sum2:
    @ Subroutine to add two numbers
    @ Input:  R0 (first argument), R1 (second argument)
    @ Output: R0 (sum of R0 and R1)
    
    ADD R0, R0, R1    @ Perform addition R0 = R0 + R1
    BX LR             @ Return to caller using LR (Link Register)

    .end
