.global _start

.equ LEDS, 0xFF200000     @ Address for LEDs

_start:
    LDR R0, =LEDS          @ Load LED base address
    MOV R1, #0             @ Initialize counter (0)

counter_loop:
    STR R1, [R0]           @ Display R1 value on LEDs

    BL delay               @ Call delay subroutine

    ADD R1, R1, #1         @ Increment counter
    AND R1, R1, #0xFF      @ Keep it within 8-bit range (0 to 255)

    B counter_loop          @ Repeat indefinitely

delay:
    PUSH {LR}              @ Save return address

    LDR R2, =0x00FFFFF     @ Load delay count (adjustable)
delay_loop:
    SUBS R2, R2, #1        @ Decrement counter
    BNE delay_loop         @ Continue until R2 == 0

    POP {LR}               @ Restore return address
    BX LR                  @ Return
