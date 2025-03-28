#include <stdio.h>

int main(void) {
    int arr[5];

    arr[0] = 11;
    arr[1] = 22;
    arr[2] = 33;
    arr[3] = 44;
    arr[4] = 55;

    printf("static allocation array: %d, %d, %d, %d, %d\n", arr[0], arr[1], arr[2], arr[3], arr[4]);
    return 0;
}

