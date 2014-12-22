-- #53
-- There are exactly ten ways of selecting three from five, 12345:
--
--      123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
--
-- In combinatorics, we use the notation, 5C3 = 10.
--
-- In general,
--      nCr =
--          n!
--          over
--          r!(n−r)!
-- ,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
--
-- It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
--
-- How many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are
-- greater than one-million?

fact :: (Integral a) => a -> a
fact 0 = 1
fact x
  | x < 0     = 1
  | otherwise = x * fact (x - 1)

choose :: (Integral a) => a -> a -> a
choose n r = fact n `div` (fact r * fact (n - r))

e53 = length $ [(x, y) | x <- [1..100], y <- [1..x], x `choose` y > 1000000]

main = putStrLn $ show $ e53
