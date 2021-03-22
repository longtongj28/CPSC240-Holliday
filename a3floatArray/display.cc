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
//   File name: display.cc
//   Language: C++
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o display.o display.cc
//   Link: g++ -m64 -no-pie -o addFloatArray.out control.o fill.o main.o sum.o display.o -std=c++17
//   Purpose: The control module will call this function "Display" and give it the user defined array and
//            number of elements in that array. Then, the Display function will print out the contents to
//            the terminal.
//========================================================================================================
#include <iostream>

extern "C" void Display(double arr[], int arr_size);

//Prints the contents of the array, up to arr_size, determined by the fill asm module
void Display(double arr[], int arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.10lf\n", arr[i]);
  }
}
