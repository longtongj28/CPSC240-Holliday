
#!/bin/bash

#Program: Adding Float Array
#Author: Johnson Tong

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm

echo "compile fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo "compile sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "compile append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "compile display.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display.o display.cc

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o addFloatArray.out control.o isfloat.o fill.o main.o sum.o append.o display.o -std=c++17

echo "Run the Add Float Array Program:"
./addFloatArray.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
