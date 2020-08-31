puts "Введите коэффициенты A, B, C:"

a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d.positive?
  sqr = Math.sqrt(d)
  x1 = (-b + sqr) / (2 * a)
  x2 = (-b - sqr) / (2 * a)
  puts "Дискриминант: #{d}, корни: X1 = #{x1}, X2 = #{x2}"
elsif d.zero?
  x = -b / (2 * a)
  puts "Дискриминант: #{d}, корень: X = #{x}"
else # d < 0
  puts "Дискриминант: #{d}, корней нет"
end
