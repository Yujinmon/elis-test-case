#include <stdio.h>

#define SIZE 10

void initializeArray(int arr[], int index) {
    if (index >= SIZE)
        return;
    arr[index] = index * index;
    initializeArray(arr, index + 1);
}

void printArray(const int arr[], int index) {
    if (index >= SIZE)
        return;
    printf("arr[%d] = %d\n", index, arr[index]);
    printArray(arr, index + 1);
}

int main(void) {
    int arr[SIZE];

    initializeArray(arr, 0);

    printArray(arr, 0);

    return 0;
}

