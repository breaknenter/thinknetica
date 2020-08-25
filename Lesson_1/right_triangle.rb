
puts "Введите 1 сторону:"
side_1 = gets.chomp.to_i

puts "Введите 2 сторону:"
side_2 = gets.chomp.to_i

puts "Введите 3 сторону:"
side_3 = gets.chomp.to_i

triangle = [side_1, side_2, side_3]

hypotenuse = triangle.sort![2]

if hypotenuse**2 == triangle[0]**2 + triangle[1]**2
  puts "Треугольник является прямоугольным"
elsif hypotenuse && triangle[0] == triangle[1]
  puts "Треугольник является равносторонним"
elsif hypotenuse == triangle[0] || hypotenuse == triangle[1] || triangle[0] == triangle[1]
    puts "Треугольник является равнобедренным"
else
  puts "Это разносторонний треугольник"
end
