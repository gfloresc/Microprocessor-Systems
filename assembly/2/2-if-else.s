.global _start

.section .text
_start:
    MOV R0, #5     @ Load 5 into R0
    MOV R1, #3     @ Load 3 into R1

    CMP R0, R1     @ Compare R0 and R1
    BEQ equal      @ If R0 == R1, jump to "equal"
    B not_equal    @ Otherwise, jump to "not_equal"

equal:
    MOV R2, #1     @ Set R2 = 1 if equal
    B end

not_equal:
    MOV R2, #0     @ Set R2 = 0 if not equal

end:
    B end          @ Infinite loop (end program)
