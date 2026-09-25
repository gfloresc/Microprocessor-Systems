.global _start

.section .text
_start:
    MOV R0, #1      @ Initialize counter (i = 1)
    MOV R1, #10     @ Set limit (10)
    MOV R2, #0      @ Initialize sum (sum = 0)

loop:
    CMP R0, R1      @ Compare i with 10
    BGT end_loop    @ If i > 10, exit loop

    ADD R2, R2, R0  @ sum = sum + i
    ADD R0, R0, #1  @ i = i + 1
    B loop          @ Repeat loop

end_loop:
    B end_loop      @ Stop execution (infinite loop)
