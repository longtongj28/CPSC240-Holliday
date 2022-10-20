#Johnson Tong
#CPSC 240-1 Test 1

rm *.o
rm *.out

echo "Assemble resistance.asm"
nasm -f elf64 -l resistance.lis -o resistance.o resistance.asm

echo "Assemble resistance.asm"
nasm -f elf64 -l compute.lis -o compute.o compute.asm

echo "Assemble fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm


echo "compile electricity.c using gcc compiler standard 2011"
g++ -c -Wall -m64 -no-pie -o electricity.o electricity.cc -std=c++11

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o finalElectricity.out resistance.o electricity.o compute.o fill.o -std=c++11

echo "Run the Electricity Program:"
./finalElectricity.out

echo "Script file terminated."