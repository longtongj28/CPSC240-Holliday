#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <iostream>

extern "C" double manager();

int main(int argc, char *argv[])
{
    printf("Welcome to Harmonic Sum created by author Sam Fleece");
    double answer = manager();
    std::cout << answer << std::endl;
    return 0;
}

/*
harmonic.cpp
^
manager.asm
^
compute_sum.asm
^
outputoneline.c
*/