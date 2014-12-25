digitSumAux 0 acc = acc
digitSumAux n acc = digitSumAux (div n 10) (acc + mod n 10)

digitSum n = digitSumAux n 0

e56 = foldl max 0 $ [digitSum (a^b) | a <- [1..100], b <- [1..100]]

main = putStrLn $ show $ e56
