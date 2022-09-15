#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <iostream>

extern "C" double compare();

int main(int argc, char *argv[])
{
    char * test = "hello";

    int * a = new int(15);
    printf("Welcome to Floating Points Numbers programmed by Leslie Silverman.\n"
           "Ms Silverman has been working for the Longstreet Software Company for the last two years.\n");
    double answer = 0.0;
    answer = compare();
    std::cout << "Answer that was returned to driver " << answer << std::endl;
    return 0;
}
