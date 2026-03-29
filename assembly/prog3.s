.global _start      @ Define the program entry point

.section .data      @ Data section for variables
.align 4           @ Ensure word alignment
a: .word 1         @ Define variable 'a' with value 1
b: .word 2         @ Define variable 'b' with value 2
c: .word 0         @ Define variable 'c' initialized to 0

.section .text      @ Code section
.align 4           @ Ensure word alignment
_start:            @ Label marking the start of the program

    LDR r1, =a     @ Load the address of 'a' into r1
    LDR r2, [r1]   @ Load the value of 'a' into r2

    LDR r3, =b     @ Load the address of 'b' into r3
    LDR r4, [r3]   @ Load the value of 'b' into r4

    ADDS r5, r2, r4 @ r5 = r2 + r4 (c = a + b)

    LDR r6, =c     @ Load the address of 'c' into r6
    STR r5, [r6]   @ Store the result in 'c'

stop:
    B stop         @ Infinite loop to stop execution
