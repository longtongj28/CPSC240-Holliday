/*;****************************************************************************************************************************
;Program name: "Paramount Interviews".  A funny program made in assembly/C++ that shows a unrealistic job interview.
;               Three text files are included to show the possible unique outputs.
; Copyright (C) 2021 Johnson Tong.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Interview".                                                                   *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Johnson Tong
;  Author email: jt28@csu.fullerton.edu
;
;Program information
;  Program name: Paramount Interviews
;  Programming languages: Assembly, C++, bash
;  Date program began: 2021 April 11
;  Date of last update: 2021 April 22
;  Date of reorganization of comments: 2021 April 22
;  Files in this program: interview.asm, main.cpp, r.sh, chris.txt, social.txt, csmajor.txt
;  Status: Finished.  The program was tested extensively with no errors in Tuffix 2020 Edition (Linux).
;
;This file
;   File name: main.cpp
;   Language: C++
;   Max page width: 132 columns
;   Compile: g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++17
;   Link: g++ -m64 -no-pie -o interview.out main.o interview.o -std=c++17
;   Purpose: The main driver that will make a call to an external function called interview, defined in
;            interview.asm. "Decides" the salary of the user of the program using the result returned from
;            the interview function.
;========================================================================================================*/
#include <iostream>

extern "C" double interview(char[], double);

int main()
{
  char name[50];
  double expected_salary = 0.0;
  double actual_salary = 0.0;

  std::cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n"
            << "Please enter your first and last names and press enter: \n";
  std::cin.getline(name, 50, '\n');

  std::cout << "Please enter your expected annual salary when employed at Paramount: \n";
  std::cin >> expected_salary;

  std::cout << "Your interview with Ms. Linda Fensterm Personnel Manager, will begin shortly.\n";

  actual_salary = interview(name, expected_salary);

  printf("Hello %s I am the receptionist.\n", name);

  if (actual_salary == 88000.88)
  {
    printf("This envelope contains your job offer with the starting salary $%.2lf. Please check back on Monday morning at 8am.\nBye.\n", actual_salary);
  }
  else if (actual_salary == 100000000.00) {
    printf("This envelope has your job offer starting at 1 million annual. Please start anytime you like. In the middle time our CTO wishes to have dinner with you.\nHave a very nice evening Mr. Sawyer.\n");
  }
  else {
    printf("We have an opening for you in the company cafeteria for $1200.12 annually.\nTake your time to let us know your decision.\nBye.\n");
  }

  return 0;
}
