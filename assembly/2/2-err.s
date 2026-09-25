.global _start

.section .text
_start:
    MOV R0, #5             @ Load test value into R0
    BL first_function      @ Call first function
    B end_program          @ End program

first_function:
    MOV R1, #10            @ Do something (dummy operation)
    BL second_function     @ Call another function (overwrites LR)
    @ At this point, LR is overwritten and cannot return correctly
    BX LR                  @ Return, but LR is now set by second_function

second_function:
    MOV R2, #20            @ Another dummy operation
    BX LR                  @ Return to first_function (but LR in first_function is lost)

end_program:
    B end_program          @ Infinite loop to stop the program
