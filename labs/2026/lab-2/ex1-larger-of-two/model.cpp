#include <iostream>

// Simulated .data section values
int num1 = 42;
int num2 = 18;

int main() {
    int larger = (num1 > num2) ? num1 : num2;
    std::cout << "Larger number: " << larger << std::endl;
    return 0;
}
