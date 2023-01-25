#include <iostream>
#include <cmath>
#include <cstdlib>
#include <algorithm>

// Declare the external ASM function using the "C" directive to pass parameters in the CCC standard
extern "C" double cosine(double test);
extern "C" double stringtof(const char* test);

int main (int argc, char* argv[]) {
    std::cout << "Correct library cos answer = " << cos(15) << std::endl;
    std::cout << "Custom Cosine answer = " << cosine(15) << std::endl;

    char num[50] = "12.5222656";
    double stuff[20] = {12.0, 265.3, 21.3};


    int * ptr = new int(15);

    std::cout << "The number in string is " << num << std::endl;
    std::cout << "The number as a float is " << atof(num) << std::endl;

    float test = stringtof(num);

    std::cout << "Custom converter atof gives: " << test << std::endl;
    return 0;
}