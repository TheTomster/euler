import Data.Ratio

continuedAux 0 = 1 % 2
continuedAux n = 1 / (2 + continuedAux (n - 1))
continued n = 1 + continuedAux n

digitsAux 0 acc = acc
digitsAux n acc = digitsAux (n `div` 10) (acc + 1)
digits n = digitsAux n 0

numeratorLonger n = (digits $ numerator n) > (digits $ denominator n)

e57 = length $ filter numeratorLonger $ map continued [0..999]

main = putStrLn $ show $ e57
