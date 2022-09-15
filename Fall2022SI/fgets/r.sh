#!/bin/bash

#Author: Daniel C
#Title: BASH compile for C++

rm *.o
rm *.lis
rm *.out

echo " " #Blank line

echo "This will compile the C++ and assemble the ASM file, then link the two."

echo "Assemble the X86 file."
nasm -f elf64 -l hello.lis -o hello.o hello.asm

echo "Compile the C++ file."
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o welcome.o welcome.cpp

echo "Link the 'O' files."
g++ -m64 -std=c++14 -fno-pie -no-pie -o welcome.out welcome.o hello.o

echo "Run the program hello.out"
./welcome.out

echo "This Bash script file will now terminate.  Bye."



