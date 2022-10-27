#!/bin/bash

#Program: Compare Floats
#Author: Timothy Vu

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

#echo "compile driver.cpp using the g++ compiler standard 2017"

nasm -f elf64 -l _start.lis -o _start.o _start.asm -g -gdwarf
nasm -f elf64 -l strlen.lis -o strlen.o strlen.asm
nasm -f elf64 -l cosine.lis -o cosine.o cosine.asm
nasm -f elf64 -l itoa.lis -o itoa.o itoa.asm
nasm -f elf64 -o stringtof.o -l stringtof.lis stringtof.asm -g -gdwarf
nasm -f elf64 -l _math.lis -o _math.o _math.asm
nasm -f elf64 -l ftoa.lis -o ftoa.o ftoa.asm

#echo "Link object files using the gcc Linker standard 2017"
ld -o gfinal.out _start.o strlen.o cosine.o itoa.o _math.o ftoa.o stringtof.o -g

#echo "Run the driver Program:" 
gdb ./gfinal.out

#echo "Script file has terminated."

rm *.o
rm *.lis
rm *.out
