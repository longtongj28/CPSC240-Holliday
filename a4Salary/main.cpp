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
