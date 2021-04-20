#!/bin/bash

#Program: Paramount Interviews
#Author: Johnson Tong

#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble interview.asm"
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo "compile main.c using gcc compiler standard 2017"
g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o interview.out main.o interview.o -std=c++17

echo "Run the Paramount Interviews Program:"
./interview.out

echo "Clean up"
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."
