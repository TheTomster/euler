#include "stdio.h"
#include "stdlib.h"

#include <math.h>

/*
 * #51
 * By replacing the 1st digit of the 2-digit number *3, it turns
 * out that six of the nine possible values: 13, 23, 43, 53, 73,
 * and 83, are all prime.
 *
 * By replacing the 3rd and 4th digits of 56**3 with the same
 * digit, this 5-digit number is the first example having seven
 * primes among the ten generated numbers, yielding the family:
 * 56003, 56113, 56333, 56443, 56663, 56773, and 56993.
 * Consequently 56003, being the first member of this family, is
 * the smallest prime with this property.
 *
 * Find the smallest prime which, by replacing part of the number
 * (not necessarily adjacent digits) with the same digit, is part
 * of an eight prime value family.
 */

int prime(int n)
{
	int q;
	for (q = 2; q <= floor(sqrt(n)); q++)
		if (n % q == 0)
			return 0;
	return 1;
}

int nextprime(int n)
{
	for (n++; ! prime(n); n++);
	return n;
}

int replace(int mask, int n, int r)
{
	int ld;
	if (n == 0) return 0;
	ld = mask & 1 ? r : n % 10;
	return replace(mask >> 1, n / 10, r) * 10 + ld;
}

int digits(int n)
{
	int digits;
	for (digits = 0; n > 0; n /= 10) digits++;
	return digits;
}

int countto(int n)
{
	int ds, pow2;
	ds = digits(n);
	for (pow2 = 1; ds > 0; ds--) pow2 *= 2;
	return pow2;
}

void printperms(int n, int r)
{
	int m;
	for (m = 0; m < countto(n); m++)
		printf("%04d\n", replace(m, n, r));
}

int primefamily(int m, int n)
{
	int r, ps, replaced;
	ps = 0;
	for (r = 0; r < 10; r++) {
		replaced = replace(m, n, r);
		if (digits(replaced) != digits(n))
			continue;
		if (prime(replaced))
			ps++;
	}
	return ps;
}

int main(int argc, char **argv)
{
	int p, m, f, t;

	if (argc != 2) {
		fprintf(stderr, "usage: e51 familysize\n");
		return EXIT_FAILURE;
	}
	t = atoi(argv[1]);

	for (p = 13;; p = nextprime(p))
		for (m = 1; m < countto(p); m++) {
			f = primefamily(m, p);
			if (f >= t) {
				printf("%d\t0x%x\t%d\t%d\n", p, m, replace(m, p, 0), replace(m, p, 1));
				return EXIT_SUCCESS;
			}
		}
	return EXIT_SUCCESS;
}
