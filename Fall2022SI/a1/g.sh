
#!/bin/bash

#Program: Quadratic
#Author: Johnson Tong

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "compile driver.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp -g

echo "compile isFloat.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o isFloat.o isFloat.cpp -g

echo "Assemble compare.asm"
nasm -f elf64 -l compare.lis -o compare.o compare.asm -g -gdwarf

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o final.out compare.o driver.o isFloat.o -std=c++17 -g

echo "Run the Quadratic Program:"
gdb ./final.out
# gdb ./final.out < commands.txt

echo "Script file has terminated."

rm *.o
rm *.lis
rm *.out
