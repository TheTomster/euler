-- Project Euler 1

divides x y =
  (mod y x) == 0

e1 = sum $ map (\ n -> if divides 3 n || divides 5 n then n else 0) [1..999]
