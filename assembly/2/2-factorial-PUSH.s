.global _start

.section .text
_start:
    MOV R0, #4          @ n = 4 (input for factorial)
    BL factorial        @ Call factorial function
    B end_program       @ Infinite loop to stop

factorial:
    CMP R0, #1          @ Compare R0 with 1 (if n == 1, return 1)
    BEQ base_case       @ If R0 == 1, jump to base_case

    PUSH {LR, R0}       @ Save LR and n (R0) in stack
    SUB R0, R0, #1      @ n - 1
    BL factorial        @ Recursive call
    
	POP {R1, LR}        @ Restore n (R1) and LR (return address)
    MUL R0, R0, R1      @ R0 = factorial(n-1) * n
    BX LR               @ Return

base_case:
    MOV R0, #1          @ Base case: factorial(1) = 1
    BX LR               @ Return

end_program:
    B end_program       @ Stop execution
