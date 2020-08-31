months = {
  jan: 31,
  feb: 28,
  mar: 31, 
  apr: 30,
  may: 31,
  jun: 30,
  jul: 31,
  aug: 31,
  sep: 30,
  oct: 31,
  nov: 30,
  dec: 31 }

puts "Месяцы с 30 днями:"

months.each { |month, day| puts "месяц: #{month}, дней: #{day}" if day == 30 }
