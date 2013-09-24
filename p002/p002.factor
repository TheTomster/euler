USING: kernel sequences math math.parser io ;
IN: p002

: next-fib ( seq -- n )
  reverse [ first ] [ second ] bi + ;

: add-fib ( seq -- seq! )
  dup next-fib suffix ;

: fib-start ( -- n )
  { 1 2 } clone ;

: fibs-below ( n -- seq )
  fib-start [ [ next-fib < ] 2keep ] [ add-fib ] until nip ;

: e2 ( n -- n )
  fibs-below [ even? ] filter sum ;

: e2-main ( -- )
  4,000,000 e2 number>string print ;

MAIN: e2-main
