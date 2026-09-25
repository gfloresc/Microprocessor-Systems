.global _start

.section .text
_start:
    MOV R0, #5      // Load first number into R0
    MOV R1, #3      // Load second number into R1
    BL add_numbers  // Call function (saves return address in LR)
    B _start        // Infinite loop after function call

add_numbers:
    ADD R0, R0, R1  // Perform addition: R0 = R0 + R1
    BX LR           // Return to the caller (uses value in LR)
