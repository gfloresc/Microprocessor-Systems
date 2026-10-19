.global _start

.equ SEVENSEG, 0xFF200020  @ Seven-segment display base address

_start:
    LDR R1, =SEVENSEG       @ Load the base address of the seven-segment display
    MOV R2, #7              @ Load the number 7 (index)
    LDR R4, =segment_table  @ Load the address of the segment pattern table
    LDRB R5, [R4, R2]       @ Get the corresponding pattern for 7
    STR R5, [R1]            @ Store the pattern in the display register

_end:
    B _end                  @ Infinite loop to hold the display

segment_table:
    .byte 0x3F  @ Pattern for '0'
    .byte 0x06  @ Pattern for '1'
    .byte 0x5B  @ Pattern for '2'
    .byte 0x4F  @ Pattern for '3'
    .byte 0x66  @ Pattern for '4'
    .byte 0x6D  @ Pattern for '5'
    .byte 0x7D  @ Pattern for '6'
    .byte 0x07  @ Pattern for '7' (THIS IS THE CORRECT PATTERN)
    .byte 0x7F  @ Pattern for '8'
    .byte 0x6F  @ Pattern for '9'
