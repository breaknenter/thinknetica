puts "Введите ваше имя:"
name = gets.chomp

puts "Введите ваш рост:"
height = gets.chomp.to_i

weight = (height - 110) * 1.15

weight.positive? ? puts("#{name}, ваш идеальный вес: #{weight}") : puts("У вас оптимальный вес")
