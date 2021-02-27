#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double findRoots();

int main(int argc, char*argv[]) {
  double root = 0.0;
  printf("Welcome to Root Calculator\n");
  printf("Programmed by Johnson Tong (a 240 student)\n");
  root = findRoots();
  printf("The main driver has received %.12lf and has decided to keep.\n", root);
  printf("Now 0 will be returned to the operating system. Have a nice day. Bye!\n");
  return 0;
}
