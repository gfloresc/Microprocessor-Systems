.global _start

.section .text
_start:
    B loop      @ Jump to "loop"

loop:
    B loop      @ Infinite loop (keeps jumping to itself)
