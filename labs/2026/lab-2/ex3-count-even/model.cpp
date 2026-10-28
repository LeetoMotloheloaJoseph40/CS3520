#include <iostream>

int arr[] = {4, 7, 10, 13, 16, 21};
int n = 6;

int main() {
    int count = 0;

    for (int i = 0; i < n; i++) {
        if ((arr[i] & 1) == 0) {
            count++;
        }
    }

    std::cout << "Even count = " << count << std::endl;

    return 0;
}