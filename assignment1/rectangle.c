//****************************************************************************************************************************
//Program name: "Rectangle".  This program takes in the user input of height and width in float and calculates perimeter and
//average side length. Copyright (C) 2021 Johnson Tong.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Rectangle".                                                                   *
//Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Johnson Tong
//  Author email: tong.johnson.28@gmail.com
//
//Program information
//  Program name: Johnson Tong
//  Programming languages: One modules in C and one module in X86
//  Date program began: 2021 Feb 05
//  Date of last update: 2021 Feb 12
//  Files in this program: rectangle.c, perimeter.asm
//  Status: Finished.
//
//Purpose
//  Show how to input and output floating point (64-bit) numbers.
//
//This file
//   File name: rectangle.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o manage-floats.o manage-floats.c -std=c17
//   Link: gcc -m64 -no-pie -o three-numbers.out manage-floats.o float-input-output.o -std=c17
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

        extern double perimeter();

int main(int argc, char* argv[])
{
  double p = 0.0;
  printf("The main function rectangle.c has begun.\n");
  printf("The function perimeter will now be called.\n");
  p = perimeter();
  printf("The main function has received this number %.15lf and has decided to keep it.\n", p);
  printf("A 0 will be returned to the operating system.\n");
  printf("Have a nice day.\n");
  return 0;
}
