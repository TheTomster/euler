// Project Euler Problem 21

#include <stdio.h>

int sum_divisors(int n) {
    int sum = 0;
    for (int i = 1; i < n; ++i) {
        if (n % i == 0) {
            sum += i;
        }
    }
    return sum;
}

int is_amicable(int n) {
    int sd = sum_divisors(n);
    int sd2 = sum_divisors(sd);
    return (n == sd2) && (n != sd);
}

int sum_amicables(int n) {
    int sum = 0;
    for (int i = 1; i <= n; ++i) {
        if (is_amicable(i)) {
            sum += i;
        }
    }
    return sum;
}

int main(int argc, char **argv)
{
    int sum = sum_amicables(10000);
    printf("%u\n", sum);
}
