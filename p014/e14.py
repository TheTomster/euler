from __future__ import division

def next_collatz(n):
    if n % 2 == 0:
        return n // 2
    return 3 * n + 1

def collatz_count(n):
    ct = 1
    while True:
        if n <= 1:
            return ct
        ct = ct + 1
        n = next_collatz(n)

def e14(n=1000000):
    return max([collatz_count(x) for x in range(n)])

if __name__ == '__main__':
    print(e14())
