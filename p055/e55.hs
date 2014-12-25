reversedAux 0 acc = acc
reversedAux n acc = reversedAux (n `div` 10) (acc * 10 + (n `mod` 10))

reversed n = reversedAux n 0

lychrelStep n = n + reversed n

palindrome n = n == reversed n

lychrelSteps n = (n : rest)
    where rest = lychrelSteps $ lychrelStep n

lychrel50 n = any palindrome iterations
    where iterations = tail $ take 50 $ lychrelSteps n

e55 = length $ filter (\ n -> not $ lychrel50 n) [1..10000]

main = putStrLn $ show $ e55
