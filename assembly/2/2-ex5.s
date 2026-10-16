.global _start

.equ LEDS, 0xFF200000       @ Address for LEDs
.equ SWITCHES, 0xFF200040   @ Address for Switches

_start:
    LDR R0, =SWITCHES        @ Load address of switches
    LDR R1, =LEDS            @ Load address of LEDs

loop:
    LDR R2, [R0]             @ Read switches state into R2
    AND R2, R2, #1           @ Mask to check only SW0 (bit 0)
    CMP R2, #0               @ Compare R2 with 0 (SW0 is OFF)
    BEQ turn_off             @ If SW0 is OFF, jump to turn_off

    BL turn_on_leds          @ If SW0 is ON, call subroutine to turn on LEDs
    B loop

turn_off:
    BL turn_off_leds         @ Call subroutine to turn off LEDs
    B loop

turn_on_leds:
    PUSH {LR}
    LDR R3, =0xFF            @ Turn on all LEDs (0xFF)
    STR R3, [R1]
    POP {LR}
    BX LR

turn_off_leds:
    PUSH {LR}
    MOV R3, #0               @ Turn off all LEDs (0x00)
    STR R3, [R1]
    POP {LR}
    BX LR
