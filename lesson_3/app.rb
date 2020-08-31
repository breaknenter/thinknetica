require_relative "station"
require_relative "route"
require_relative "train"

puts "Отправляется пассажирский поезд N7 с десятью вагонами"
train = Train.new(7, :pass, 10)

puts "По маршруту \"Биробиджан > Владивосток\""
route = Route.new("Биробиджан", "Владивосток")

puts "Промежуточная остановка \"Хабаровск\""
route.add_station("Хабаровск")

puts "Список всех станций:"
puts route.stations

puts "Задаём маршрут поезду N: #{train.number}"
train.route(route)

puts "Текущая станция: #{train.current}"
puts "Следующая станция: #{train.next_station}"

puts "Поехали! Разгоняемся: #{train.speed_up} km/h"

puts "Подкинем уголька - текущая скорость: #{train.speed_up(60)} km/h"

puts "Следующая станция: #{train.next_station}"
train.forth

puts "Останавливаемся"
train.stop

puts "Текущая станция: #{train.current}"
puts "Предыдущая станция: #{train.prev_station}"
puts "Следующая станция: #{train.next_station}"

puts "Отцепляем вагон"
train.detach

puts "Осталось вагонов: #{train.cars}"

puts "Прицепляем вагон"
train.attach

puts "Теперь у нас #{train.cars} вагонов"

puts "Едем дальше,следующая станция: #{train.next_station}, скорость: #{train.speed_up(50)} km/h"
train.forth

puts "Конечная, приехали"
train.stop

puts "Предыдущая станция: #{train.prev_station}"
