proc next_collatz(n : int) : int =
  if n mod 2 == 0:
    return n div 2
  else:
    return 3 * n + 1

proc collatz_count(n : int) : int =
  var n = n
  result = 1
  while true:
    if n <= 1:
      return
    else:
      result = result + 1
      n = next_collatz(n)

var mx = 0
for i in 1..1_000_000:
  var cc = collatz_count(i)
  if cc > mx:
    mx = cc
echo(mx)
