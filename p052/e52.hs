-- #52
--
-- It can be seen that the number, 125874, and its double, 251748, contain
-- exactly the same digits, but in a different order.
--
-- Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x,
-- contain the same digits.

import Data.List

digits 0 = []
digits n = last : rest
    where last = n `mod` 10
          rest = digits (div n 10)

sameDigits n m = (sort (digits n)) == (sort (digits m))

multIsPermutation n m = sameDigits n (n * m)

sixMatch n = all (multIsPermutation n) [1..6]

e52 = find sixMatch [1..]

main = putStrLn $ show $ e52
