#include <stdio.h>
#include <stdlib.h>  // For malloc and free

// Simulated delay function (~1 second)
void delay(unsigned int time) {
    for (volatile unsigned int i = 0; i < time * 50000; i++);
}

// Structure to represent a GPIO port
typedef struct {
    unsigned int portState;  // 32-bit register (simulated GPIO)
} GPIO;

// Function to set a specific bit (turn ON a GPIO pin)
void setPin(GPIO *gpio, int pin) {
    gpio->portState |= (1 << pin);  // Set the bit
    printf("Pin %d ON | GPIO State: 0x%X\n", pin, gpio->portState);
}

// Function to clear a specific bit (turn OFF a GPIO pin)
void clearPin(GPIO *gpio, int pin) {
    gpio->portState &= ~(1 << pin);  // Clear the bit
    printf("Pin %d OFF | GPIO State: 0x%X\n", pin, gpio->portState);
}

int main() {
    // Allocate memory for GPIO structure
    GPIO *gpio1 = (GPIO *)malloc(sizeof(GPIO));

    if (gpio1 == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    gpio1->portState = 0x00;  // Initialize all pins OFF

    printf("Simulating GPIO Control...\n");

    // Toggle GPIO pins with delays
    for (int i = 0; i < 3; i++) {
        setPin(gpio1, 2);  // Turn ON pin 2
        delay(10);
        clearPin(gpio1, 2);  // Turn OFF pin 2
        delay(10);
    }

    printf("GPIO Simulation Finished.\n");

    free(gpio1);  // Free allocated memory

    return 0;
}
