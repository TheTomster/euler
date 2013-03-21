-- Problem 28
--
-- Starting with the number 1 and moving to the right in a clockwise direction
-- a 5 by 5 spiral is formed as follows:
--
-- 21 22 23 24 25
-- 20  7  8  9 10
-- 19  6  1  2 11
-- 18  5  4  3 12
-- 17 16 15 14 13
--
-- It can be verified that the sum of the numbers on the diagonals is 101.
--
-- What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
-- formed in the same way?

function e28(size)
    n = 1
    diag_sum = 1
    for i = 3, size, 2 do
        for j = 1, 4 do
            n = n + (i - 1)
            diag_sum = diag_sum + n
        end
    end
    print(diag_sum)
end

e28((arg and tonumber(arg[1])) or 1001)
