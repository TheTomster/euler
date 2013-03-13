puts "Project Euler Problem 20"

proc fact {n} {
    if {$n == 0} {
        return 1
    } else {
        return [expr $n * [fact [expr $n - 1]]]
    }
}

proc sumdigits {n} {
    set last_digit [expr $n % 10]
    set next_n [expr $n / 10]
    if {$next_n  == 0} {
        return $last_digit
    } else {
        return [expr $last_digit + [sumdigits $next_n]]
    }
}

puts [sumdigits [fact 100]]

