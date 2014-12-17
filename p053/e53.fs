variable n
variable r
: mult ( n -- n ) n @ swap - ;
: denom ( n -- n ) 1+ ;
: iterations ( -- n ) n @ r @ - ;
: choose ( n r -- ncr ) r ! n ! 1. iterations 0 ?do i mult i denom m*/ loop ;
variable millions
: countit? ( n -- ) 1000000. d> if 1 millions +! then ;
: e53 ( -- ) 0 millions ! 101 1 ?do i 1 ?do j i choose countit? loop loop millions @ ;
