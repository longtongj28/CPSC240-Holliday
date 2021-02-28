
#!/bin/bash

#Program: Quadratic
#Author: Johnson Tong

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo "compile second_degree.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c17

echo "compile quad.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o quad.o quad.cpp

echo "compile isFloat.cpp using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o isFloat.o isFloat.cpp

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -o finalQuadratic.out quadratic.o quad.o isFloat.o second_degree.o -std=c++17

echo "Run the Quadratic Program:"
./finalQuadratic.out

echo "Script file has terminated."
