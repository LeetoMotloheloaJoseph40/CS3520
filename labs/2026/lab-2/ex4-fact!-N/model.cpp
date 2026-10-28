#include <iostream>

int factorial(int n) {
    int result = 1;

    for (int i = 1; i <= n; i++) {
        result *= i;
    }

    return result;
}

int main() {
    int N = 5;

    int result = factorial(N);

    std::cout << "Factorial = " << result << std::endl;

    return 0;
}