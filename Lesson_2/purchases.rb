purchases = {}

loop do
  print "Введите название товара: "
  product = gets.chomp
  break if product == "стоп"

  print "Введите цену товара: "
  price = gets.to_f

  print "Введите количество товара: "
  amount = gets.to_i

  purchases[product] = {price: price, amount: amount}
end

puts "Вы купили:"

total = 0

purchases.each do |product, val|
  sum = val[:amount] * val[:price]
  total += sum
  puts "#{product}: #{val[:amount]} ед. на сумму: #{sum} по: #{val[:price]} за ед."
end

puts "\nИтог: #{total}"
