#include <stdio.h>

int main() {
  int a = 55;
  int b = 22;
  int c = a + b;
  
  int d = 33;
  int e = a + d;

  int arr1[c];
  int arr2[e];

  arr1[71] = 710;
  arr2[81] = 810;
  printf("arr1: %d arr2: %d\n", arr1[71], arr2[81]);
}
