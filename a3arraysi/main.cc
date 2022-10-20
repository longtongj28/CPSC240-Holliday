//****************************************************************************************************************************
//Program name: "Add Float Array".
// This program will allow a user to input float numbers in an array of size 6, and display the contents. It will also add
// them together and display the result.
// Copyright (C) 2021 Johnson Tong.                                                                           *
//                                                                                                                           *
//This file is part of the software program "Add Float Array".
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY// without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Johnson Tong
//  Author email: jt28@csu.fullerton.edu
//
//Program information
//  Program name: Add Float Array
//  Programming languages: Assembly, C++, C, bash
//  Date program began: 2021 March 10
//  Date of last update: 2021 March 21
//  Date of reorganization of comments: 2021 March 21
//  Files in this program: control.asm, main.c, display.cc, sum.asm, fill.asm, run.sh
//  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition.
//
//This file
//   File name: main.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17
//   Link: g++ -m64 -no-pie -o addFloatArray.out control.o fill.o main.o sum.o display.o -std=c++17
//   Purpose: This is the driver module that will call control() to initialize the array operations.
//========================================================================================================
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern "C" double control();  // assembly module that will direct calls to other functions
                          // that will fill an array and add its contents

int main(int argc, char *argv[])
{
  double * d_ptr = new double(15.0);
  double * d_ptr_arr = new double[15];
  d_ptr_arr[5] = 20.0;
// Show the ascii value of each of the first 8 bytes of the array. [3]

  printf("Welcome to High Speed Array Summation by Johnson Tong.\n"
         "Software Licensed by GNU GPL 3.0\n"
         "Version 1.0 released as of 03-17-2021.\n");
  double answer = control();  // the control module will return the sum of the array contents
  printf("The main has received this number %.10lf and will keep it.\n", answer);
  printf("Thank you for using High Speed Array Software.\n"
          "A zero will be returned to the operating system.\n"
          "Have a good day!\n");
}
