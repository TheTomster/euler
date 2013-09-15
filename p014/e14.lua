function next_collatz(n)
	if n % 2 == 0 then
		return math.floor(n / 2)
	end
	return 3 * n + 1
end

function collatz_count(n)
	ct = 1
	while true do
		if n <= 1 then
			return ct
		else
			ct = ct + 1
			n = next_collatz(n)
		end
	end
end

function e14()
	max = 0
	for i=1,1000000 do
		cc = collatz_count(i)
		if cc > max then
			max = cc
		end
	end
	return max
end

print(e14())

