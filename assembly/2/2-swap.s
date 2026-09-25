.global _start

_start:
    MOV R0, #5      @ Load R0 with value 5
    MOV R1, #10     @ Load R1 with value 10

    BL swap         @ Call swap function

    B end           @ Infinite loop to stop execution

swap:
    MOV R2, R0      @ Store R0 in a temporary register R2
    MOV R0, R1      @ Move R1 into R0
    MOV R1, R2      @ Move R2 (original R0) into R1
    BX LR           @ Return to caller

end:
    B end           @ Infinite loop to halt execution
