\ The cube, 41063625 (345^3), can be permuted to produce two
\ other cubes: 56623104 (384^3) and 66430125 (405^3). In fact,
\ 41063625 is the smallest cube which has exactly three
\ permutations of its digits which are also cube.
\
\ Find the smallest cube for which exactly five permutations of
\ its digits are cube.

16384 constant cubes-to-eval

: cube ( n -- ) dup dup * * ;

\ We can count how many of each digit there is and pack it into
\ one number. `encode` adds the digit d into the count in a.
\ This will give us a fast equality check to see if the
\ permutations are the same.
: 100pow ( n -- 10^n ) 1 swap 0 ?do 100 * loop ;
: encode ( a d -- a' ) 100pow + ;
: lastdigit ( n -- n ) 10 mod ;
\ Use this to encode a number
: encoden ( n -- p )
	0
	begin over 0<> while
		over lastdigit encode
		>r 10 / r>
	repeat nip ;

\ Permutations we've seen are stored with their encoded counts.
create permutations cubes-to-eval 2 * cells allot
variable end-permutations
: reset ( -- ) permutations end-permutations ! ;
: inc-endp ( -- ) 2 cells end-permutations +! ;
: end? ( a -- ? ) end-permutations @ = ;
: matches? ( p a -- ? ) @ = ;
: 0! ( a -- ) 0 swap ! ;
: new-slot ( p a -- ) dup 1 cells + 0! ! inc-endp ;
: find-slot ( p -- a )
	permutations
	begin
		dup end? if dup >r new-slot r> exit then
		2dup matches? if nip exit then
		2 cells +
	again ;
: add-count ( a -- ) 1 cells + 1 swap +! ;
\ Use these to mark a permutation as seen and check the count
: saw ( p -- ) find-slot add-count ;
: count ( p -- ) find-slot 1 cells + @ ;

: find-lowest ( n -- )
	cubes-to-eval 0 do
		i cube encoden count over =
		if drop i cube unloop exit then
	loop ;
: e62 ( n -- )
	reset
	cubes-to-eval 0 do
		i cube encoden dup saw
		count over = if find-lowest unloop exit then
	loop drop -1 ;
