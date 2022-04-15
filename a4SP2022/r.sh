
#!/bin/bash

#Program: Adding Float Array
#Author: Johnson Tong

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "compile compute_sum.asm"
nasm -f elf64 -l compute_sum.lis -o compute_sum.o compute_sum.asm

echo "compile harmonic.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o harmonic.o harmonic.cpp

echo "compile outputoneline.c using gcc compiler standard 2017"
g++ -c -Wall -m64 -no-pie -o outputoneline.o outputoneline.c -std=c++17

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out manager.o harmonic.o outputoneline.o compute_sum.o -std=c++17

echo "Run the Add Float Array Program:"
./final.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
