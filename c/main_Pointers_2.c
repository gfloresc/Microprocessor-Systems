#include <stdio.h>
#include <string.h>

struct Person {
    char name[20];
    int age;
};

int main() {
    struct Person p1 = {"Alice", 25};
    struct Person *ptr = &p1;  // Pointer to struct

    printf("Before modification: %s is %d years old\n", ptr->name, ptr->age);

    // Modify struct using pointer
    ptr->age = 30;
    strcpy(ptr->name, "Bob");

    printf("After modification: %s is %d years old\n", ptr->name, ptr->age);

    return 0;
}
