#include <stdio.h>

typedef struct {
    unsigned int portState;
} GPIO;

void setPin(GPIO *gpio, int pin) {
    gpio->portState |= (1 << pin);  // Set the bit at 'pin' position
    printf("Pin %d ON | GPIO State: 0x%X\n", pin, gpio->portState);
}

int main() {
    GPIO gpio1;
    gpio1.portState = 0x00;  // All pins OFF

    printf("Simulating Simple GPIO Activation...\n");
    
    // Activate pin 3
    setPin(&gpio1, 3);

    return 0;
}
