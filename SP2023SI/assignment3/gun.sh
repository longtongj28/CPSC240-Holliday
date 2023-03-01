#!/bin/bash

#Program: Rectangle
#Author: Johnson Tong

#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm -g -gdwarf

echo "compile rectangle.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.c -std=c11 -g

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o final-perimeter.out perimeter.o rectangle.o -std=c11 -g

echo "Run the Rectange Program:"
gdb ./final-perimeter.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."
