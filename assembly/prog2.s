.global _start   // Entry point

_start:
    MOV R1, #10   // Load 10 into R1 (counter)
    MOV R2, #0    // Initialize sum in R2

loop:
    ADD R2, R2, R1   // Sum R2 = R2 + R1
    SUBS R1, R1, #1  // Decrement counter
    BNE loop         // If R1 is not zero, repeat loop [Branch if Not Equal]

    MOV R3, R2   // Store final result in R3

stop:
    B stop   // Infinite loop (halts execution)
