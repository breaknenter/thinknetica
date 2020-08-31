puts "Введите ваше имя:"
name = gets.chomp

puts "Введите ваш рост:"
height = gets.chomp.to_i

weight = (height - 110) * 1.15

puts weight.positive? ? ("#{name}, ваш идеальный вес: #{weight}") : ("#{name}, у вас оптимальный вес")
