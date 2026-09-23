    .data
numbers:
    .word 10, 11   @ Two numbers stored in memory: 10 and 11

    .text
    .global _start
_start:
    ldr r0, =numbers   @ Load the base address of 'numbers' into r0
    ldr r1, [r0]       @ Load the first number into r1
    ldr r2, [r0, #4]!  @ Load the second number into r2 (r0 is updated)

    cmp r1, r2         @ Compare r1 and r2
    beq equal          @ If r1 == r2, jump to 'equal'
    bgt greater        @ If r1 > r2, jump to 'greater'
    blt less           @ If r1 < r2, jump to 'less'

equal:
    mov r3, #0         @ Store 0 in r3 if r1 == r2
    b end

greater:
    mov r3, #1         @ Store 1 in r3 if r1 > r2
    b end

less:
    mov r3, #2         @ Store 2 in r3 if r1 < r2

end:
    b end              @ Infinite loop to halt execution
