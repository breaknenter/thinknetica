puts "Введите основание:"
base = gets.chomp.to_i

puts "Введите высоту:"
height = gets.chomp.to_i

# Думаю вместо 1 / 2.to_f можно написать 0.5 и обойтись без приведения типа
area = 0.5 * base * height

puts "Площадь треугольника: #{area}"
