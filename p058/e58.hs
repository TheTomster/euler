-- Starting with 1 and spiralling anticlockwise in the following way, a square
-- spiral with side length 7 is formed.
--
--     37 36 35 34 33 32 31
--     38 17 16 15 14 13 30
--     39 18  5  4  3 12 29
--     40 19  6  1  2 11 28
--     41 20  7  8  9 10 27
--     42 21 22 23 24 25 26
--     43 44 45 46 47 48 49
--
-- It is interesting to note that the odd squares lie along the bottom right
-- diagonal, but what is more interesting is that 8 out of the 13 numbers lying
-- along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
--
-- If one complete new layer is wrapped around the spiral above, a square spiral
-- with side length 9 will be formed. If this process is continued, what is the
-- side length of the square spiral for which the ratio of primes along both
-- diagonals first falls below 10%?

import Data.List

isPrime :: (Integral a) => a -> Bool
isPrime n = aux n 2
    where aux n m
              | m > r     = True
              | otherwise = if n `mod` m == 0 then False else aux n (m + 1)
          r = ceiling $ sqrt $ fromIntegral n

data E58 = E58 {
    step :: Int,
    nDiags :: Int,
    nPrimes :: Int,
    currentDiag :: Int
} deriving Show

nextStep :: E58 -> Int
nextStep (E58 s n _ _) = if n `mod` 4 == 0 then s + 2 else s

nextDiag :: E58 -> E58
nextDiag diags = E58 (nextStep diags) (n + 1) (if isPrime (d + s) then p + 1 else p) (d + s)
    where (E58 s n p d) = diags

fourStep e58 = iterate nextDiag e58 !! 4

initial = fourStep $ E58 2 1 0 1

ratio (E58 _ n p _) = (p * 100) `div` n

e58 = find (\ e -> ratio e < 10) $ iterate fourStep initial

main = putStrLn $ result e58
    where result (Just (E58 _ _ _ d)) = show $ truncate $ sqrt $ fromIntegral d
          result Nothing = "No result"
