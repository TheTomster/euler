proc e29 {s e} {
    array set foo ""
    set f [open tcl_tossed_ps.txt w]
    for {set a $s} {$a <= $e} {incr a} {
        for {set b $s} {$b <= $e} {incr b} {
            if {[array get foo [expr $a**$b]] ne ""} {
                puts $f "$a\t$b"
            }
            array set foo [list [expr $a**$b] 1]
        }
    }
    close $f
    return [array size foo]
}

puts [e29 2 100]
