//Johnson Tong
//CPSC 240-1 Test 1

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double resistance();

int main(int argc, char* argv[])
{
  double totalResistance = 0.0;
  printf("Welcome to the Electric Resistance Calculator programmed by Johnson Tong.\n");

  totalResistance = resistance();
  printf("The Electricity module received this number %.15lf and will keep it.\n", totalResistance);
  printf("Have a very nice evening. Electricity will now return 0 to the operating system. Bye.\n");
  return 0;
}