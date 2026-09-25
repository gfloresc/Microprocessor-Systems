.global _start

.section .text
_start:
    MOV R0, #5     @ Load counter (R0 = 5)

loop:
    CMP R0, #0     @ Compare R0 with 0
    BEQ end_loop   @ If R0 == 0, exit loop

    SUBS R0, R0, #1  @ Decrement counter
    B loop         @ Repeat loop

end_loop:
    B end_loop     @ Stop execution
