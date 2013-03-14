CC=gcc
CFLAGS=-march=native -Os -std=c99

all: euler21 euler21_opt time

euler21: ../euler21.c
	$(CC) $(CFLAGS) -o euler21 ../euler21.c

euler21_opt: ../o_e21.c
	$(CC) $(CFLAGS) -o euler21_opt ../o_e21.c -lm

time: euler21.timing euler21_opt.timing
	@echo Unoptimized code time:
	@cat euler21.timing
	@echo Optimized code time:
	@cat euler21_opt.timing

euler21.timing: euler21
	@echo timing unoptimized '(100 runs)'
	@time -f %U bash -c 'for i in `seq 100`; do ./euler21 >/dev/null; done' 2>euler21.timing
	@perl -n -e '$$_ /= 100; print "$$_\n";' euler21.timing >euler21.timing_tmp
	@mv euler21.timing_tmp euler21.timing

euler21_opt.timing: euler21_opt
	@echo timing optimized '(100 runs)'
	@time -f %U bash -c 'for i in `seq 100`; do ./euler21_opt >/dev/null; done' 2>euler21_opt.timing
	@perl -n -e '$$_ /= 100; print "$$_\n";' euler21_opt.timing >euler21_opt.timing_tmp
	@mv euler21_opt.timing_tmp euler21_opt.timing

