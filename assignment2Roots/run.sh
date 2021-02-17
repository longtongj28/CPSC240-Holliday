  
#!/bin/bash

#Program: Quadratic
#Author: Johnson Tong

#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo "compile rectangle.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o finalQuadratic.out quadratic.o second_degree.o -std=c11

echo "Run the Quadratic Program:"
./finalQuadratic.out

echo "Script file has terminated."