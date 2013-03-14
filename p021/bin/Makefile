CC=clang
CFLAGS=-Os -std=c99 -lm

all: euler21 euler21_opt

euler21: ../euler21.c
	$(CC) $(CFLAGS) -o euler21 ../euler21.c

euler21_opt: ../euler21.c
	$(CC) $(CFLAGS) -o euler21_opt ../o_e21.c

