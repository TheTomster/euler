# Project Euler problem 24

# A permutation is an ordered arrangement of objects. For example, 3124 is one
# possible permutation of the digits 1, 2, 3 and 4. If all of the permutations
# are listed numerically or alphabetically, we call it lexicographic order. The
# lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4,
# 5, 6, 7, 8 and 9?

# Thanks to some math, we know the first digit is a 2:
#   9! = 362,880
#     0|------------------------------------|1,000,000   <- target
#      |==== 0 ==== | ==== 1 ==== | ==== 2 ==== |        <- permutations start
#      |     9!     | <- each digit runs for 9! perms.      with this digit
#   1,000,000 / 9! = 2
#   digits[2] = 2
#   [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
#          ^
# The first digit is a 2

# We can apply the same logic for the next digit
#   2 * 9! = 725,760
#   1,000,000 - 725,760 = 274,240
#   8! = 40,320
#   274,240 / 40,320 = 6
#   digits[6] = 7
#   [0, 1, 3, 4, 5, 6, 7, 8, 9]
#                      ^
# So the next digit is 7

proc factorial {n {acc 1}} {
    if {$n < 2} {
        return $acc
    }
    return [factorial [expr $n - 1] [expr $n * $acc]]
}

proc e24 {target digits {perm ""}} {
    if {[llength $digits] == 0} {
        return $perm
    }
    set n [llength $digits]
    set f [factorial [expr $n - 1]]
    set idx [expr $target / $f]
    set digit [lindex $digits $idx]
    set new_digits [lreplace $digits $idx $idx]
    set new_target [expr $target - ($idx * $f)]
    lappend perm $digit
    return [e24 $new_target $new_digits $perm]
}

set target 999999
set digits "0 1 2 3 4 5 6 7 8 9"
# string map removes spaces from list
puts [string map {{ } {}} [e24 $target $digits]]

