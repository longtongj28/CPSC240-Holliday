#!/bin/bash

#Program: Validate Integer Input
#Author: F. Holliday

#Delete some un-needed files
rm *.o
rm *.out

echo "Bash: The script file for Validate Integer Input has begun"

nasm -f elf64 -o freq.o getfrequency.asm

echo "Bash: Compile extract-clock-speed.c"
g++ -c -m64 -Wall -fno-pie -no-pie -o driver.o extract-clock-speed.cpp -std=c++2a
#"c++2a" indicates a preliminary compiler for C++ under the standard of 2020.
#"c++2a" should be replaced by "c++20" when the standard compiler becomes available.

echo "Bash: Link the object files"
g++ -m64 -fno-pie -no-pie -o code.out -std=c++2a driver.o freq.o 

echo "Bash: Run the program Validate Integer Input:"
./code.out

echo "The script file will terminate"




#Summary
#The module arithmetic.asm contains PIC non-compliant code.  The assembler outputs a non-compliant object file.

#The C compiler is directed to create a non-compliant object file.

#The linker received a parameter telling the linker to expect non-compliant object files, and to output a non-compliant executable.

#The program runs successfully.
