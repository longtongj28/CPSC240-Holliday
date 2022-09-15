/*
Copyright 2021 Daniel Cazarez
This program is free software, you can redistribute it and or modify it
under the terms of the GNU General Public License version 3
A copy of the GNU General Public License version 3 is available here: https://www.gnu.org/licenses/

Author Name: Daniel Cazarez
Author Email: danielcaz2200@csu.fullerton.edu

Program name: Assembly Welcome Program, v2.0
Files in program: welcome.cpp, hello.asm, r.sh
System requirements: Linux on an x86 machine
Programming languages: x86 Assembly, C++ and BASH
Date program development began: Aug 20, 2021
Date finished: Sept 1, 2021
Status: No known errors

Purpose: This program prompts the user for input and then repeats the input back to the user
This program will return the user's name back to the C++ driver program. String I/O testing.

File name: welcome.cpp
Language: C++
This module takes data passed from the ASM module and outputs it

Translation information
Compile this file: g++ -c -m64 -Wall -std=c++14 -fno-pie -no-pie -o welcome.o welcome.cpp
Link the two files: g++ -m64 -fno-pie -no-pie -std=c++17 -o good.out good_morning.o hello.o 
./good.out is the executable
*/

/* Code area */

// Include std::cout
#include <iostream>

// Declare the external ASM function using the "C" directive to pass parameters in the CCC standard
extern "C" char* hello();

int main (int argc, char* argv[]) {

    // Greet the user
    std::cout << "Welcome to this greeting program by Daniel C.\n";

    // Return a string into the char pointer name from ASM
    const char* name = hello();

    // Output the name proviced by the user back to the console
    std::cout << "Stay away from viruses " << name << "!" << std::endl;

    std::cout << "The program will now exit with exit code 0.\n";
    
    return 0;
}