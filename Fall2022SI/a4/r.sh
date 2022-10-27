#!/bin/bash

#Author: Daniel C
#Title: BASH compile for C++

rm *.o
rm *.lis
rm *.out

echo " " #Blank line

echo "This will compile the C++ and assemble the ASM file, then link the two."

echo "Assemble the X86 file."
nasm -f elf64 -l cosine.lis -o cosine.o cosine.asm
nasm -f elf64 -l stringtof.lis -o stringtof.o stringtof.asm
nasm -f elf64 -l strlen.lis -o strlen.o strlen.asm

echo "Compile the C++ file."
g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o driver.o driver.cpp

echo "Link the 'O' files."
g++ -m64 -std=c++14 -fno-pie -no-pie -o final.out strlen.o stringtof.o driver.o cosine.o

echo "Run the program hello.out"
./final.out

echo "This Bash script file will now terminate.  Bye."

rm *.o
rm *.lis
rm *.out

