#include <algorithm>
#include <iostream>
#include <vector>

#include <unistd.h>

using namespace std;

vector<int> digits;

void print_digits()
{
    for (int i = 0; i < 10; ++i) {
        cout << digits[i];
    }
    cout << endl;
}

int main(int argc, const char **argv)
{
    int target = 1000000;

    for (int i = 0; i < 10; ++i) {
        digits.push_back(i);
    }

    for (int iteration = 1; iteration < target; ++iteration) {
        for (int i = 8; i >= 0; --i) {
            if (digits[i] < digits[i + 1]) {
                for (int j = 9; j >= 0; --j) {
                    if (digits[i] < digits[j]) {
                        swap(digits[i], digits[j]);
                        reverse(digits.begin() + i + 1, digits.end());
                        goto next;
                    }
                }
            }
        }
        next:;
    }
    print_digits();
}

