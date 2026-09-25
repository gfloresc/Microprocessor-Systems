.global _start

.section .text
_start:
    MOV R0, #5      @ Number to calculate factorial (5!)
    BL factorial    @ Call the factorial function

    B stop          @ Stop execution

@ Iterative factorial function
factorial:
    MOV R1, #1      @ R1 will hold the factorial result (initialize to 1)
    
loop:
    CMP R0, #1      @ If R0 <= 1, we're done
    BLE done        @ If R0 == 1, jump to done
    MUL R1, R1, R0  @ R1 = R1 * R0
    SUB R0, R0, #1  @ Decrement R0
    B loop          @ Repeat until R0 == 1

done:
    MOV R0, R1      @ Move result to R0 (return value)
    BX LR           @ Return

stop:
    B stop          @ Infinite loop to stop execution
