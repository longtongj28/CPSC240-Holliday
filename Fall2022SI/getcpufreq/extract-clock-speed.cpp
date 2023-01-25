//**********************************************************************************************************************
//Program name: "Get Frequency".  This program demonstrates how to extract the published frequency of the processor    *
//executing this program.  Copyright (C) 2021 Floyd Holliday                                                           *
//                                                                                                                     *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public    *
//License version 3 as published by the Free Software Foundation.                                                      *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied   *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more        *
//details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.            *
//**********************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2
//
//Author information
//Author name: Floyd Holliday
//Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Get Frequency
//  Programming languages: One module in C++ and one module in X86.
//  Date program began: 2020-Sep-02
//  Date of last update: 2020-Sep-02
//  Date of reorganization of comments: 2020-Sep-03
//  Second reorganization of comments: 2021-Nov-12
//  Files in this program: extract-clock-speed.cpp, getfrequency.asm
//  Status: Beta -- Available for public comment.
//
//Purpose
//  This program is intended to serve as a teaching tool for students learning X86 assembly programming.
//
//This file
//   File name: extract-clock-speed.cpp
//   Language: C++
//   Max page width: 120 columns
//   Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o drive.o validate-driver.cpp -std=c++2a
//   Link: g++ -m64 -fno-pie -no-pie -o code.out -std=c++17 scan.o valid.o drive.o

//===== Begin code area ===============================================================================================

// asm {
/*
 mov rax, 0
 ....
*/
// }



#include <iostream>

extern "C" double getfreq();

int main(int argc, char* argv[])
{printf("The name of this program is \"Get Frequency\".\n"); 
 printf("The advertised highest frequency of the processor in this computer will be displayed here.\n");
 printf("Next the getfreq function will be called from this C++ main function.\n");
 double speed = getfreq();
 printf("The CPU speed is %3.5lf GHz.\n",speed);
 printf("End of the demonstration.\n");
 printf("Check for accuracy by entering the bash command \"lscpu\" in the terminal window.\n");
 printf("The values for frequency obtained from the two sources should match.\n"); 
 return 0;
}





/////Notes to students enrolled in CPSC 240/////////

//The program comprises two files.  The entire program as a set of two files is licened by GPL3.0.  The one 
//function getfreq is a library function, and it is, therefore, licensed by LGPL3.0.  LGPL gives the programmer
//the freedom to reuse the library function in other programs with the requirement to re-license the entire
//as GPL.

//One reference to LGPL among dozens: https://softwareengineering.stackexchange.com/questions/86142/
//Another explanation of LGPL: https://softwareengineering.stackexchange.com/questions/86142/

//The problem of extracting the instaneous clock frequency is difficult programming problem.  In one of the 
//programming guides available at the Intel website is a software solution to that problem.  Even that is 
//very difficult to understand.

//There must be a way to create software that will extract the max, the min, the current frequency of the clock.
//We know it is possible because "lscpu" is able to do it, and so there has to be a way to do it.

//An early version of getfreq was published online for public use a couple semester ago.  A significant number 
//those students emailed to the author claiming that getfreq was return wrong values.  If this happens to you
//then email the author with evidence.  You will win a few extra credit points.

