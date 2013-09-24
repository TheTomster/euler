USING: combinators io kernel math math.functions math.parser
math.ranges sequences sequences.deep ;
IN: p004

: divmod ( n -- n n )
    [ 10 / floor ] [ 10 mod ] bi ;

: number>array ( n -- seq )
    dup {
        { [ 0 = ] [ drop { } clone ] }
        [ divmod
          [ number>array ] dip
          suffix
        ]
    } cond ;

GENERIC: palindrome? ( seq -- ? )

M: sequence palindrome? ( seq -- ? )
    dup reverse equal? ;

M: integer palindrome? ( n -- ? )
    number>array palindrome? ;

: n-digits ( n -- seq )
    [ 1 - 10 swap ^ ] [ 10 swap ^ ] bi [a,b) ;

: e4 ( n -- n )
    n-digits dup
    [ * ] cartesian-map flatten
    [ palindrome? ] filter supremum ;

: e4-main ( -- )
    3 e4 number>string print ;
