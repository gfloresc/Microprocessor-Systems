.global _start
_start:

    LDR R0, =flash_data      @ Pointer to Flash (constants)
    LDR R1, =sram_buffer     @ Pointer to SRAM (runtime data)
    MOV R2, #5               @ Number of elements
    MOV R3, #0               @ Sum accumulator

loop:
	LDR R4, [R0], #4     	 @ Post-increment load (R4 = [R0], and updates R0 = R0 + 4)
    STR R4, [R1], #4     	 @ Write value to SRAM and move to next location --> MEM[R1] = R4, and R1 = R1 + 4
	ADD  R3, R3, R4     	 @ R3 = R3 + R4   (accumulate sum)
	SUBS R2, R2, #1     	 @ R2 = R2 - 1    (decrement counter, update flags)

    BNE loop

stop:
    B stop                   @ Infinite loop (halt)


@ ---------- Simulated FLASH ----------
flash_data:
    .word 1, 2, 3, 4, 5


@ ---------- Simulated SRAM ----------
sram_buffer:
    .space 20                @ Reserve 20 bytes (space for 5 integers or 5 words). Allocate memory space for runtime data (not initialized)
