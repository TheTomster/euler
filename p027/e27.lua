function is_prime(n)
    if n < 1 then
        return false
    end
    for i = 2, math.sqrt(n) do
        if n % i == 0 then
            return false
        end
    end
    return true
end

function e27(s, e)
    local results = {0, nil, nil}
    for a = s, e do
        for b = s, e do
            local n = 0
            repeat
                local r = math.pow(n,2) + a * n + b
                n = n + 1
            until not is_prime(r)
            if n > results[1] then
                results[1] = n
                results[2] = a
                results[3] = b
            end
        end
    end
    local n = results[1]
    local a = results[2]
    local b = results[3]
    print(n .. ' is the longest sequence')
    print("a: " .. a .."\t" .. "b: " .. b)
    print("product of a and b is: " .. a * b)
end

e27(-1000, 1000)
