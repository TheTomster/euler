puts "Project Euler Problem 18"

proc read_tree {fn} {
    global n_tree
    unset -nocomplain n_tree
    set f [open $fn]
    while {1} {
        set line [gets $f]
        if {[eof $f]} {
            close $f
            break
        }
        lappend n_tree $line
    }
    return $n_tree
}

proc score {r c} {
    global n_tree
    set n [lindex [lindex $n_tree $r] $c]
    set left_c $c
    set right_c [expr {$c + 1}]
    set next_r [expr {$r + 1}]
    if {$next_r >= [llength $n_tree]} {
        return $n
    }
    return [expr {$n + max([score $next_r $left_c], [score $next_r $right_c])}]
}

read_tree big.txt
puts [score 0 0]
