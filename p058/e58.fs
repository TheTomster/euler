\ Starting with 1 and spiralling anticlockwise in the following way, a square
\ spiral with side length 7 is formed.
\
\     37 36 35 34 33 32 31
\     38 17 16 15 14 13 30
\     39 18  5  4  3 12 29
\     40 19  6  1  2 11 28
\     41 20  7  8  9 10 27
\     42 21 22 23 24 25 26
\     43 44 45 46 47 48 49
\
\ It is interesting to note that the odd squares lie along the bottom right
\ diagonal, but what is more interesting is that 8 out of the 13 numbers lying
\ along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
\
\ If one complete new layer is wrapped around the spiral above, a square spiral
\ with side length 9 will be formed. If this process is continued, what is the
\ side length of the square spiral for which the ratio of primes along both
\ diagonals first falls below 10%?

\ Prime numbers
: isqrt ( d -- root ) s>f fsqrt f>s ;
: divides? ( s q -- ? ) mod 0= ;
: prime? ( n -- ? )
    dup isqrt 1+ 2 ?do
        dup i divides? if unloop drop false exit then
    loop drop true ;
: nextp ( n -- next ) begin 1+ dup prime? until ;

\ Generating diagonal numbers
variable step
2 step !
variable diags
1 diags !
variable d
1 d !
: nextstep ( -- ) 1 diags +! diags @ 4 mod 1 = if 2 step +! then ;
: nextd ( -- ) step @ d +! nextstep ;

\ e58
variable primes
0 primes !
: 4step ( -- ) 4 0 do nextd d @ prime? if 1 primes +! then loop ;
: ratio ( -- n ) primes @ 100 diags @ */ ;
: squaresize ( -- n ) d @ isqrt ;
: e58 ( -- n ) begin 4step ratio 10 < if squaresize exit then again ;
