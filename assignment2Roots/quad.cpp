#include <iostream>
#include <cstdio>

extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

void show_no_root()
{
  std::cout << "There is no possible root. You may rerun the program." << std::endl;
};

void show_one_root(double root)
{
  printf("The only root that was found is %.9lf.\n", root);
};

void show_two_root(double root1, double root2)
{
  printf("Two roots were found: %.9lf and %.9lf.\n", root1, root2);
};
