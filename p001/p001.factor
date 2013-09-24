USING: kernel math sequences ;
IN: p001

: fizzbuzz ( n -- ? ) [ 3 mod zero? ] [ 5 mod zero? ] bi or ;

: e1 ( -- n ) 1,000 iota [ fizzbuzz ] filter sum ;
