/*
 * #53
 * There are exactly ten ways of selecting three from five, 12345:
 *
 *	123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
 *
 * In combinatorics, we use the notation, 5C3 = 10.
 *
 * In general,
 *	nCr =
 *		   n!
 *		--------
 *		r!(n−r)!
 * ,where r <= n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
 *
 * It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
 *
 * How many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are
 * greater than one-million?
 */

#include <gmp.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	unsigned long i, j;
	int tally;
	mpz_t n;

	mpz_init(n);
	tally = 0;
	for (i = 1; i <= 100; i++)
		for (j = 1; j <= i; j++) {
			mpz_bin_uiui(n, i, j);
			if (mpz_cmp_ui(n, 1000000) > 0)
				tally++;
		}
	printf("%d\n", tally);
	return EXIT_SUCCESS;
}
