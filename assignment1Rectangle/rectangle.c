#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double rectangle();

int main(int argc, char* argv[])
{
  double average = 0.0;
  printf("The main function rectangle.c has begun.\n");
  printf("The function rectange will now be called.\n");
  average = rectangle();
  printf("The function rectangle has returned this value %.3lf. Goodbye!", average);
  return 0;
}
