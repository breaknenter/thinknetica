puts "Введите коэффициент A:"
a = gets.chomp.to_f

puts "Введите коэффициент B:"
b = gets.chomp.to_f

puts "Введите коэффициент C:"
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d.positive?
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "Дискриминант: #{d}, корни: X1 = #{x1}, X2 = #{x2}"
elsif d.zero?
  x = -b / (2 * a)
  puts "Дискриминант: #{d}, корень: X = #{x}"
else # d < 0
  puts "Дискриминант: #{d}, корней нет"
end
