.global _start

.equ LEDS, 0xFF200000     @ Address for LEDs

_start:
    LDR R0, =LEDS          @ Load LED base address into R0
    MOV R1, #0             @ Initialize LED state (OFF)

loop:
    BL toggle_leds         @ Call subroutine to toggle LEDs
    BL delay               @ Call subroutine for delay
    B loop                 @ Repeat loop indefinitely

toggle_leds:
    @PUSH {LR}              @ Save return address

    EOR R1, R1, #0xFF      @ Toggle R1 (flip bits, 0 → FF, FF → 0)
    STR R1, [R0]           @ Write new state to LEDs

    @POP {LR}               @ Restore return address
    BX LR                  @ Return from subroutine

delay:
    @PUSH {LR}              @ Save return address

    LDR R2, =0x00FFFFF     @ Load delay counter
delay_loop:
    SUBS R2, R2, #1        @ Decrement counter
    BNE delay_loop         @ Repeat until counter is 0

    @POP {LR}               @ Restore return address
    BX LR                  @ Return from subroutine
