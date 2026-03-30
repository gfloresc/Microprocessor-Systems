#include <stdio.h>

int main() {
    // Step 1: Declare an integer variable
    int num = 10;

    // Step 2: Declare a pointer to store the address of num
    int *ptr = &num;

    // Step 3: Print variable value, address, and pointer details
    printf("Original value of num: %d\n", num);
    printf("Memory address of num: %p\n", &num);
    printf("Pointer value (address stored in ptr): %p\n", ptr);
    printf("Value accessed via pointer: %d\n", *ptr);

    // Step 4: Modify num using the pointer
    *ptr = 20;

    // Step 5: Print the updated value of num
    printf("Updated value of num: %d\n", num);

    return 0;
}
