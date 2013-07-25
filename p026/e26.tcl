# Euler 26

# naive regex version
# proc period {n} {
#     set f [expr (10**1200) / $n]
#     set res [regexp {\d*(\d+?)\1+} $f match cap]
#     if {$res == 0} {
#         error "possible overflow"
#     }
#     if {$cap eq 0} {
#         return 0
#     }
#     return [string length $cap]
# }

proc period {n} {
    set f [expr (10**3000) / $n]
    set last_index [expr [string length $f] - 1]
    set half_index [expr [string length $f] / 2]
    for {set i 1} {$i <= $half_index} {incr i} {
        set pivot [expr $last_index - $i]
        set front [expr $last_index - (2 * $i + 1)]
        set s1 [string range $f $front [expr $pivot - 1]]
        set s2 [string range $f $pivot $last_index]
        if {$s1 eq $s2} {
            if {$s1 == 0} {
                return 0
            }
            return [string length $s1]
        }
    }
    return 0
}

proc e26 {n} {
    for {set i 1} {$i <= $n} {incr i} {
        set f [period $i]
        lappend results [list $f $i]
    }
    set max_list [lindex [lsort -integer -decreasing -index 0 $results] 0]
    puts "Longest is [lindex $max_list 1] with period [lindex $max_list 0]"
}

e26 1000

