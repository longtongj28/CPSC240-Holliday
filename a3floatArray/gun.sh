
#!/bin/bash

#Program: Adding Float Array
#Author: Johnson Tong

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm -g -gdwarf

echo "compile fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm -g -gdwarf

echo "compile sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm -g -gdwarf

echo "compile display.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display.o display.cpp -g

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17 -g

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o addFloatArray.out control.o fill.o main.o sum.o display.o -std=c++17 -g

echo "Run the Quadratic Program:"
gdb ./addFloatArray.out

echo "Script file has terminated."
