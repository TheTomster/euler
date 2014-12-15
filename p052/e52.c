/*
 * #52
 *
 * It can be seen that the number, 125874, and its double, 251748, contain
 * exactly the same digits, but in a different order.
 *
 * Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
 * contain the same digits.
 */

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool samedigits(int a, int b)
{
    int adigits[10], bdigits[10], i;

    for (i = 0; i < 10; i++) {
        adigits[i] = 0;
        bdigits[i] = 0;
    }

    for (; a > 0; a /= 10)
        adigits[a % 10]++;
    for (; b > 0; b /= 10)
        bdigits[b % 10]++;

    for (i = 0; i < 10; i++)
        if (adigits[i] != bdigits[i])
            return false;
    return true;
}

int main(int argc, char **argv)
{
    int n, p, i;
    bool same;
    for (n = 1;; n++) {
        same = true;
        for (i = 0; i < 6; i++) {
            p = (i + 1) * n;
            same &= samedigits(p, n);
        }
        if (same) {
            printf("%d\n", n);
            return EXIT_SUCCESS;
        }
    }
    return EXIT_SUCCESS;
}
