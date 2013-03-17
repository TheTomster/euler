# A perfect number is a number for which the sum of its proper divisors is
# exactly equal to the number. For example, the sum of the proper divisors of
# 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect
# number.

# A number n is called deficient if the sum of its proper divisors is less
# than n and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest
# number that can be written as the sum of two abundant numbers is 24. By
# mathematical analysis, it can be shown that all integers greater than 28123
# can be written as the sum of two abundant numbers. However, this upper limit
# cannot be reduced any further by analysis even though it is known that the
# greatest number that cannot be expressed as the sum of two abundant numbers
# is less than this limit.

# Find the sum of all the positive integers which cannot be written as the sum
# of two abundant numbers.

proc factors {n} {
    set factors [list]
    for {set i 1} {$i <= sqrt($n)} {incr i} {
        if {$n % $i == 0} {
            lappend factors $i
            lappend factors [expr $n / $i]
        }
    }
    return [lrange [lsort -unique -integer $factors] 0 end-1]
}

proc is_abundant {n} {
    set sum 0
    foreach f [factors $n] {
        incr sum $f
    }
    return [expr $sum > $n]
}

# Generates a list of all abundant numbers in range (0, n].
proc gen_abundants {n} {
    set abundants ""
    for {set i 0} {$i <= $n} {incr i} {
        if {[is_abundant $i]} {
            lappend abundants $i
        }
    }
    return $abundants
}

# Finds all numbers that can be written as the sum of two numbers in 'ns'
array set sums {}
proc gen_sums {ns} {
    variable sums
    array set sums {}
    foreach a $ns {
        foreach b $ns {
            set s [expr $a + $b]
            array set sums "$s 1"
        }
    }
    return ""
}

proc e23 {n} {
    variable sums
    set a [gen_abundants $n]
    gen_sums $a
    set sum 0
    for {set i 1} {$i < $n} {incr i} {
        if {[array get sums $i] == ""} {
            incr sum $i
        }
    }
    return $sum
}

puts [e23 28123]
# puts [e23 250]

