#include <iostream>
#include <cmath>
#include <cstdlib>
// Declare the external ASM function using the "C" directive to pass parameters in the CCC standard
extern "C" double cosine(double test);
extern "C" double stringtof(const char* test);

int main (int argc, char* argv[]) {
    std::cout << "Correct library cos answer = " << cos(15) << std::endl;
    std::cout << "Custom Cosine answer = " << cosine(15) << std::endl;
    std::string num = "15.2";
    std::cout << "The number in string is " << num << std::endl;
    std::cout << "The number as a float is " << atof(num.c_str()) << std::endl;

    std::cout << "Custom converter atof gives: " << stringtof(num.c_str()) << std::endl;
    return 0;
}