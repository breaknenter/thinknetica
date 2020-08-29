=begin

# вариант с циклом:

fib = []
fib << 0

prv = 0
nxt = 1

while prv + nxt < 100
  fib << prv + nxt
  prv, nxt = nxt, prv + nxt # swap
end

puts fib

=end

fib = [0, 1]

# ужимал как мог, негодные варианты закомментировал:
# loop { (fib.last(2).sum < 100) && fib << fib.last(2).sum || break }
# loop { (fib << fib.last(2).sum)[-1] < 89 || break }

loop { fib.last(2).sum < 100 ? fib << fib.last(2).sum : break }

puts fib
