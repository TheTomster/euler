USING: kernel math sequences ;
IN: p001

: fizzbuzz ( n -- n ) dup 3 mod zero? [ 5 mod zero? ] dip or ;

: e1 ( -- n ) 1,000 iota [ fizzbuzz ] filter sum ;
