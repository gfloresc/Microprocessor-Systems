.global _start

.equ DELAY_COUNT, 0x00FFFFFF  @ Define delay count

_start:
    BL delay      @ Call delay function
    B _start      @ Repeat indefinitely

delay:
    PUSH {LR}       @ Save return address
    LDR R2, =DELAY_COUNT  @ Load delay counter
delay_loop:
    SUBS R2, R2, #1  @ Decrement counter
    BNE delay_loop   @ Repeat until counter is zero
    POP {LR}         @ Restore return address
    BX LR            @ Return from subroutine
