#include <stdio.h>
#include <stdlib.h>  // Required for malloc and free

// Simulated delay function (~1 second)
void delay(unsigned int time) {
    for (volatile unsigned int i = 0; i < time * 100000; i++);
}

int main() {
    int *countdown = (int *) malloc(sizeof(int));  // Allocate memory for countdown variable

    if (countdown == NULL) {  // Check for allocation failure
        printf("Memory allocation failed!\n");
        return 1;
    }

    *countdown = 10;  // Initialize countdown

    printf("Countdown Timer Started!\n");

    while (*countdown > 0) {
        printf("Time remaining: %d seconds\n", *countdown);

        delay(5000);  // Simulated 1-second delay

        (*countdown)--;  // Decrement countdown using pointer
    }

    printf("Countdown Finished! Launching event...\n");

    free(countdown);  // Free allocated memory

    return 0;
}
