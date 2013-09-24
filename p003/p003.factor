USING: kernel math.primes math.functions math.ranges math
       sequences sequences.deep math.parser io combinators ;
IN: p003

<PRIVATE

: candidates ( n -- seq )
  dup sqrt >integer swap [a,b) ;

PRIVATE>

: factor ( n -- seq )
  {
    { [ dup prime? ] [ V{ } 1sequence ] }
    [
      dup candidates [ over swap mod zero? ] find nip
      [ / ] keep
      V{ } 2sequence
    ]
  } cond ;

<PRIVATE

: (prime-factors) ( seq -- seq )
  {
    { [ dup [ prime? ] all? ] [ ] }
    [ [ factor ] map flatten (prime-factors) ]
  } cond ;

PRIVATE>

: prime-factors ( n -- seq )
  V{ } 1sequence (prime-factors) ;

: e3 ( n -- n )
  prime-factors supremum ;

: e3-main ( -- )
  600,851,475,143 e3 number>string print ;
