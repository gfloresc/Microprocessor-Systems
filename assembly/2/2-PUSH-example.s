.global _start

.section .text
_start:
    MOV R0, #0x10       @ Load 0x10 into R0
    MOV R1, #0x20       @ Load 0x20 into R1

    PUSH {R0, R1}       @ Push R0 and R1 onto the stack

    MOV R0, #0x00       @ Clear R0
    MOV R1, #0x00       @ Clear R1

    POP {R0, R1}        @ Pop values back into R0 and R1

end_program:
    B end_program       @ Infinite loop to stop
