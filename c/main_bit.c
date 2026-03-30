#include <stdio.h>

int main() {
    unsigned int reg = 0x00; // Simulating an 8-bit register

    // Turn ON bit 2
    reg |= (1 << 2);
    printf("Register after setting bit 2: 0x%X\n", reg);

    // Turn OFF bit 2
    reg &= ~(1 << 2);
    printf("Register after clearing bit 2: 0x%X\n", reg);

    return 0;
}
