#include <stdio.h>
#include <stdlib.h>

struct Car {
    char brand[20];
    int year;
};

int main() {
    //struct Car *c1 = (struct Car *)malloc(sizeof(struct Car)); // Required in C++
    struct Car *c1 = malloc(sizeof(struct Car));  // Valid in C

    if (c1 == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Assign values using the pointer
    printf("Enter car brand: ");
    scanf("%s", c1->brand);
    printf("Enter manufacturing year: ");
    scanf("%d", &c1->year);

    printf("Car Details: %s - %d\n", c1->brand, c1->year);

    // Free allocated memory
    free(c1);

    return 0;
}
