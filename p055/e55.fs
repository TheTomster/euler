: rev ( n -- n )
0 begin over 0 > while >r 10 /mod swap r> 10 * + repeat nip ;

: pal? ( n -- ? ) dup rev = ;

: lychrel? ( n -- ? )
50 0 do
	dup rev + dup pal? if drop true unloop exit then
loop drop false ;

: e55 ( -- n )
0 10000 0 do i lychrel? invert if 1+ then loop ;
