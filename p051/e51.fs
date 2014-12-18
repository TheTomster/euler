\ #51
\ By replacing the 1st digit of the 2-digit number *3, it turns
\ out that six of the nine possible values: 13, 23, 43, 53, 73,
\ and 83, are all prime.
\
\ By replacing the 3rd and 4th digits of 56**3 with the same
\ digit, this 5-digit number is the first example having seven
\ primes among the ten generated numbers, yielding the family:
\ 56003, 56113, 56333, 56443, 56663, 56773, and 56993.
\ Consequently 56003, being the first member of this family, is
\ the smallest prime with this property.
\
\ Find the smallest prime which, by replacing part of the number
\ (not necessarily adjacent digits) with the same digit, is part
\ of an eight prime value family.

\ Prime numbers
: isqrt ( d -- root ) s>f fsqrt f>s ;
: divides? ( s q -- ? ) mod 0= ;
: prime? ( n -- ? )
    dup isqrt 1+ 2 ?do
        dup i divides? if unloop drop false exit then
    loop drop true ;
: nextp ( n -- next ) begin 1+ dup prime? until ;

\ Replacing digits based on a mask
variable mask
variable replacement
variable acc
variable mult
: lastdigit ( n -- l ) mask @ 1 and if drop replacement @ else 10 mod then ;
: shiftmask ( -- ) mask @ 2/ mask ! ;
: +mult ( -- ) mult @ 10 * mult ! ;
: nextn ( n -- n' ) 10 / ;
: next ( n -- n ) shiftmask +mult nextn ;
: accdigit ( n -- ) lastdigit mult @ * acc +! ;
: replaced ( n -- n' )
	0 acc ! 1 mult !
	begin dup accdigit next dup 0= until
	drop acc @ ;

\ Counting the primes in the family
: rmask! ( r m -- ) mask ! replacement ! ;
variable primes
: digits ( n -- ds ) 0 swap begin dup 0<> while 10 / >r 1+ r> repeat drop ;
: valid? ( p r -- ) dup prime? >r digits >r digits r> = r> and ;
: primefamily ( n m -- ps )
	0 primes ! >r
	10 0 do i j rmask! dup dup replaced valid? if 1 primes +! then loop
	rdrop drop primes @ ;

\ Checking each prime with each mask
: maskmax ( n -- m ) 1 begin over 0<> while 2* >r 10 / r> repeat nip ;
: e51 ( -- n )
	2 begin
		dup maskmax 1 do
			dup i primefamily 8 >= if 1 i rmask! replaced . unloop exit then
		loop
		nextp
	again ;
