# Project Euler #22

# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file
# containing over five-thousand first names, begin by sorting it into
# alphabetical order. Then working out the alphabetical value for each name,
# multiply this value by its alphabetical position in the list to obtain a
# name score.

# For example, when the list is sorted into alphabetical order, COLIN, which
# is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN
# would obtain a score of 938 × 53 = 49714.

# What is the total of all the name scores in the file?


set names ""
proc load_names {} {
    variable names
    set names ""
    set f [open names.txt]
    set names_quoted [split [read $f] ,]
    foreach name $names_quoted {
        lappend names [string map {\" {}} $name]
    }
    set names [lsort $names]
    close $f
}

# computes the "alphabetical value" of the string 's'
proc alpha_value {s} {
    set alphabet "a b c d e f g h i j k l m n o p q r s t u v w x y z"
    set score 0
    foreach l [split $s {}] {
        incr score [expr 1 + [lsearch -nocase -sorted $alphabet $l]]
    }
    return $score
}

proc e22 {} {
    variable names
    load_names
    set pos 1
    set total 0
    foreach name $names {
        set score [expr $pos * [alpha_value $name]]
        incr total $score
        incr pos
    }
    return $total
}

puts [e22]

