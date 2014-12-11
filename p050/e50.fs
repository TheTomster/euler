(
#50
The prime 41, can be written as the sum of six consecutive primes:
    41 = 2 + 3 + 5 + 7 + 11 + 13

This is the longest sum of consecutive primes that adds to a prime below
one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime,
contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most
consecutive primes?
)

: isqrt ( d -- root ) s>f fsqrt f>s ;
: divides? ( s q -- ? ) mod 0= ;
: prime? ( n -- ? )
    dup isqrt 1+ 2 ?do
        dup i divides? if unloop drop false exit then
    loop drop true ;
: nextp ( n -- next ) begin 1+ dup prime? until ;

variable length
variable sum
0 length ! 0 sum !
: update ( n s -- )
    >r dup length @ > if length ! r> sum ! else drop rdrop then ;
: increment ( n p s -- n p s ) over + >r nextp >r 1+ r> r> ;
: 3dup ( a b c -- a b c a b c ) 2 pick 2 pick 2 pick ;
: 3drop ( a b c -- ) drop drop drop ;
: prime-update ( n p s -- ) dup prime? if nip update else 3drop then ;
100 value end
: inc-loop ( n p s -- )
    begin increment 3dup prime-update 2dup + end >= until 3drop ;
: start ( p -- n p s ) >r 0 r> 0 ;
: e50 ( -- s ) 2 begin dup start inc-loop nextp dup end >= until drop sum @ ;
