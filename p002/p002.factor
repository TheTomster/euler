USING: kernel sequences math ;
IN: p002

: next-fib ( seq -- n )
  reverse [ first ] [ second ] bi + ;

: add-fib ( seq -- seq! )
  dup next-fib suffix ;

: fib-start ( -- n )
  { 1 2 } clone ;

: fibs-below ( n -- seq )
  fib-start [ 2dup next-fib < ] [ add-fib ] until swap drop ;

: e2 ( n -- n )
  fibs-below [ even? ] filter sum ;
