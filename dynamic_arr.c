#include <stdio.h>
#include <stdlib.h>

int main() {
  int n;
  n = 33;
  int* arr = (int*)malloc(n * sizeof(int));
  for(int i = 0; i < n; i++) {
    arr[i] = 11;
  } 

  for(int i = 0; i < 7; i++) {
    printf("arr i: %d, arr[i]: %d\n", i, arr[i]);
  }

  free(arr);

}
