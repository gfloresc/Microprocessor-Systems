.global _start

.section .data
X:      .word -2          @ Input x
Y:      .word 0          @ Neural network output

.section .text
_start:

        LDR r0, =X
        LDR r0, [r0]     @ r0 = x

        @ -----------------------------
        @ h1 = ReLU(x + 2)
        @ -----------------------------
        ADD r1, r0, #2
        CMP r1, #0
        BGE h1_ok
        MOV r1, #0

h1_ok:

        @ -----------------------------
        @ h2 = ReLU(x + 1)
        @ -----------------------------
        ADD r2, r0, #1
        CMP r2, #0
        BGE h2_ok
        MOV r2, #0

h2_ok:

        @ -----------------------------
        @ h3 = ReLU(x)
        @ -----------------------------
        MOV r3, r0
        CMP r3, #0
        BGE h3_ok
        MOV r3, #0

h3_ok:

        @ -----------------------------
        @ h4 = ReLU(x - 1)
        @ -----------------------------
        SUB r4, r0, #1
        CMP r4, #0
        BGE h4_ok
        MOV r4, #0

h4_ok:

        @ -----------------------------
        @ y = 4 - 3*h1
        @       + 2*h2
        @       + 2*h3
        @       + 2*h4
        @ -----------------------------

        MOV r5, #4        @ r5 = y

        MOV r6, #3
        MUL r7, r1, r6    @ r7 = 3*h1
        SUB r5, r5, r7

        MOV r6, #2
        MUL r7, r2, r6    @ r7 = 2*h2
        ADD r5, r5, r7

        MOV r6, #2
        MUL r7, r3, r6    @ r7 = 2*h3
        ADD r5, r5, r7

        MOV r6, #2
        MUL r7, r4, r6    @ r7 = 2*h4
        ADD r5, r5, r7

        @ Store output in memory
        LDR r6, =Y
        STR r5, [r6]

stop:
        B stop