
puts "Введите 3 стороны:"

s1, s2, s3 = [gets.to_i, gets.to_i, gets.to_i].sort

if s3**2 == s1**2 + s2**2
  puts "Треугольник является прямоугольным"
elsif s3 && s1 == s2
  puts "Треугольник является равносторонним"
elsif s3 == s1 || s3 == s2
    puts "Треугольник является равнобедренным"
else
  puts "Это разносторонний треугольник"
end
