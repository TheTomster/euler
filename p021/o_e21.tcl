# Project Euler Problem 21
# Optimized Version
# 
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n
# which divide evenly into n).
#
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and
# each of a and b are called amicable numbers.
# 
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
# 71 and 142; so d(284) = 220.
# 
# Evaluate the sum of all the amicable numbers under 10000.

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

proc sum_divisors {n} {
    set sum 0
    foreach f [factors $n] {
        incr sum $f
    }
    return $sum
}

proc is_amicable {n} {
    set sd [sum_divisors $n]
    set sd2 [sum_divisors $sd]
    return [expr ($n == $sd2) && ($n != $sd)]
}

proc sum_amicables {n} {
    set sum 0
    for {set i $n} {$i > 0} {incr i -1} {
        if {[is_amicable $i]} {
            incr sum $i
        }
    }
    return $sum
}

puts [sum_amicables 10000]

