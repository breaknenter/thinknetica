=begin

# реализация циклом:

arr = []

val = 10

loop do
  arr << val
  val += 5
  break if val > 100
end
 
puts arr

=end

# после прочтения глав о массивах и диапазонах,
# мы укладываемся в одну строку:
puts arr = [*(10..100).step(5)]
