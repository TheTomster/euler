proc e29 {s e} {
    array set foo ""
    for {set a $s} {$a <= $e} {incr a} {
        for {set b $s} {$b <= $e} {incr b} {
            array set foo [list [expr $a**$b] 1]
        }
    }
    return [array size foo]
}

puts [e29 2 100]
