\ Project Euler #54
\ Read a file with 1,000 poker hands and tell how many times
\ player 1 wins.

\ Ranking lookups
\ We'll have a lookup table mapping characters to their numeric
\ ranks.
create crank 128 allot
crank 128 erase
: setcrank ( val ch -- ) crank + c! ;
: setncrank ( n -- ) dup 48 + setcrank ;
: setncranks ( -- ) 10 2 do i setncrank loop ;
setncranks
10 char T setcrank
11 char J setcrank
12 char Q setcrank
13 char K setcrank
14 char A setcrank
\ subtract 2 to get 0..13 ranks, which we can use as indices
\ into the counts array
: getcrank ( ch -- n ) crank + c@ 2 - ;

\ Suit lookups
create suits 128 allot
suits 128 erase
: setsuit ( val ch -- ) suits + c! ;
0 char D setsuit \ Diamonds
1 char S setsuit \ Spades
2 char H setsuit \ Hearts
3 char C setsuit \ Clubs
: getsuit ( ch -- n ) suits + c@ ;

\ Hand accounting
\ Track # of each rank encountered, max / min ranks, and suit
\ counts. From this we can determine how good the hand is.
create rcounts 13 allot
create scounts 4 allot
variable lowrank
variable highrank
: reset-counts ( -- )
	rcounts 13 erase 999 lowrank ! -1 highrank ! scounts 4 erase ;
: 1+c! ( add -- ) dup @ 1 + swap c! ;
: update-rcount ( c -- ) c@ getcrank rcounts + 1+c! ;
: lowrank! ( n -- ) dup lowrank @ < if lowrank ! else drop then ;
: highrank! ( n -- ) dup highrank @ > if highrank ! else drop then ;
: update-spread ( -- )
	13 0 do rcounts i + c@ 0 > if i lowrank! i highrank! then loop ;
: update-scount ( c -- ) 1+ c@ getsuit scounts + 1+c! ;
: count ( c -- ) dup update-rcount update-scount ;
: counthand ( c u -- )
	reset-counts
	drop 5 0 do dup i 3 * + count loop drop
	update-spread ;

\ Scoring
: high-card ( -- n ) highrank @ ;
: best-npair ( r -- n )
	>r -1 13 0 do rcounts i + c@ j =
		if drop i then
	loop rdrop ;
\ score-it takes a rank ( or -1 ), a factor, and the next word. If the rank is
\ -1, we assume no match and try the next word. Otherwise we use the factor and
\ rank to make a score. Hands with a higher factor are worth more than any hand
\ of a lower factor. Within the same factor, hands of a higher rank score
\ better.
: score-it ( r f n -- n )
	rot dup -1 <> if nip swap 13 * + else drop nip execute then ;
: pair ( -- n )
	2 best-npair
	2 ['] high-card score-it ;
: have-two ( -- ? )
	0 13 0 do rcounts i + c@ 2 = if 1+ then loop 2 = ;
: 2pair ( -- n ) have-two if 2 best-npair 3 ['] pair score-it else pair then ;
: 3ofkind ( -- n )
	3 best-npair
	4 ['] 2pair score-it ;
: no-pair ( -- ? ) 2 best-npair -1 = ;
: spread ( -- n ) highrank @ lowrank @ - ;
: have-straight ( -- n ) no-pair spread 4 = and ;
: straight-rank ( -- n ) have-straight if highrank @ else -1 then ;
: straight ( -- n ) straight-rank 5 ['] 3ofkind score-it ;
: have-flush ( -- ? ) 13 0 do scounts i + c@ 5 = if true unloop exit then loop false ;
: flush ( -- n ) have-flush if high-card else -1 then 6 ['] straight score-it ;
: have-house ( -- ? ) 3 best-npair -1 <> 2 best-npair -1 <> and ;
: full-house ( -- ) have-house if 3 best-npair else -1 then 7 ['] flush score-it ;
: 4ofkind ( -- n ) 4 best-npair 8 ['] full-house score-it ;
: straight-flush ( -- n )
	have-straight have-flush and if high-card else -1 then
	9 ['] 4ofkind score-it ;
: score ( c u -- s )
	counthand straight-flush ;

\ Reading hands from file
variable hands-fh
: open-hands ( -- ) s" p054_poker.txt" r/o open-file throw hands-fh ! ;
: close-hands ( -- ) hands-fh @ close-file throw ;
create gamebuf 30 allot
: read-game ( -- ) gamebuf 30 hands-fh @ read-file throw drop ;
: read-one ( -- ) open-hands read-game close-hands ;

\ Player hands
gamebuf value player1
gamebuf 15 + value player2
: card ( p n -- c u ) 3 * + 2 ;
: hand ( p -- c u ) 14 ;

variable wins
: e54 ( -- n )
	0 wins !
	open-hands
	1000 0 do
		read-game
		player1 hand score player2 hand score
		> if 1 wins +! then
	loop
	wins @ ;
