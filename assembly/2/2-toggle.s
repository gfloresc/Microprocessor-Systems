.global _start

.equ LEDS, 0xFF200000   @ LED memory address

_start:
    LDR R0, =LEDS   @ Load LED address
    MOV R1, #0      @ Initialize LED state (OFF)

loop:
    BL toggle_leds  @ Call subroutine to toggle LEDs
    B loop          @ Repeat loop indefinitely

toggle_leds:
    LDR R1, [R0]       @ Read current LED state
    EOR R1, R1, #0xFF  @ Toggle LED state (flip bits)
    STR R1, [R0]       @ Store new state to LEDs
    BX LR              @ Return from subroutine
