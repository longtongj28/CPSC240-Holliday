//****************************************************************************************************************************
//Program name: "Quadratic". This program takes in 3 float numbers as coefficients to determine whether or not they fit the
//criteria for a quadratic equation. It will calculate the discriminant and validate input to find roots or let the user know
//there is no root. Copyright (C) 2021 Johnson Tong.
//                                                                                                                           *
//This file is part of the software program "Quadratic".                                                                   *
//Quadratic is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//Quadratic is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Johnson Tong
//  Author email: jt28@csu.fullerton.edu
//
//Program information
//  Program name: Quadratic
//  Programming languages: One module in C, one module in X86, two modules in C++
//  Date program began: 2021 Feb 17
//  Date of last update: 2021 Feb 28
//  Date of reorganization of comments: 2021 Feb 28
//  Files in this program: quadratic.asm, second_degree.c, isFloat.cpp, quad.cpp, run.sh
//  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
//
//Purpose
//  This file is the driver file that calls the findRoots function, which will look for
//  the roots of a quadratic equation and display it for the user.
//
//This file
//   File name: second_degree.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c17
//   Link: g++ -m64 -no-pie -o finalQuadratic.out quadratic.o quad.o isFloat.o second_degree.o -std=c++17
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

//findRoots function defined in quadratic.asm
extern double findRoots();

int main(int argc, char*argv[]) {
  double root = 0.0;
  printf("Welcome to Root Calculator\n");
  printf("Programmed by Johnson Tong (a 240 student)\n");
  root = findRoots();
  printf("The main driver has received %.12lf and has decided to keep.\n", root);
  printf("Now 0 will be returned to the operating system. Have a nice day. Bye!\n");
  return 0;
}
