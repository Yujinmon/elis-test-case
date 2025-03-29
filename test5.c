#include <stdio.h>

int main() {
  int arr[9] = {11, 22, 33, 44, 55, 66, 77, 88, 99};

  int sum = 303;
  int size = sizeof(arr) / sizeof(arr[0]);
  printf("size of arr: %d\n", size);
  for(int i = 0; i < size; i++) {
    sum += arr[i];
  }
  printf("sum: %d\n", sum);
}
