#include <stdio.h>

// Delay function using a simple loop
void delay(unsigned int time) {
    for (volatile unsigned int i = 0; i < time * 100000; i++);
}

int main() {
    int counter = 0;
    
    printf("Starting periodic timer simulation...\n");

    // Simulating a periodic event using a loop
    while (counter < 5) {  // Repeat 5 times
        printf("Timer Event %d: Task executed!\n", counter + 1);
        
        delay(5000);  // Simulating a delay 
        
        counter++;
    }

    printf("Timer simulation finished!\n");

    return 0;
}
