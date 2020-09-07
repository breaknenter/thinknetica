class TrainYard
  def initialize
    @stations = []
    @routes   = []
    @trains   = []
  end

  def run
    loop do
      menu

      key = gets.to_i

      break if key.zero?

      case key
      when 1 then add_station
      when 2 then add_train
      when 3 then add_route
      when 4 then assign_route
      when 5 then coupling
      when 6 then dispatch
      when 7 then list
      end
    end
  end

  # все методы ниже используются только самим объектом
  # взаимодействие через public run
  private

  def menu
    puts <<~menu
              [1] добавить станцию
              [2] добавить поезд
              [3] добавить маршрут
              [4] назначить маршрут
              [5] вагоны
              [6] отправления
              [7] списки
              [0] выйти
            menu
  end

  def add_station
    print "Введите имя: "
    name = gets.chomp.to_s

    @stations << Station.new(name: name)
  end

  def add_train
    print "Укажите N: "
    number = gets.to_i

    print "Выберите тип: пассажирский[1] грузовой[2] "
    type = gets.to_i

    type == 1 ? @trains << PassengerTrain.new(number: number) : @trains << CargoTrain.new(number: number)
  end

  def add_route
    print "Пункт отправления: "
    from = gets.chomp.to_s

    print "Пункт назначения: "
    to = gets.chomp.to_s

    @routes << Route.new(from: from, to: to)
  end

  def assign_route
    print "Укажите N поезда: "
    number = gets.to_i

    print "Укажите маршрут: "
    from = gets.chomp.to_s

    @routes.each do |route|
      if route.way.first == from
        @trains.each do |train|
          train.route(route: route) if train.number == number
        end
      end
    end
  end

  def coupling
    print "Укажите N поезда: "
    number = gets.to_i

    print "Прицепить вагон[1] Отцепить вагон[2]"
    opt = gets.to_i

    if opt == 1
      @trains.each do |train|
        if train.number == number
          if train.type == :pass
            train.attach(car: car = PassengerCar.new)
          elsif train.type == :cargo          
            train.attach(car: car = CargoCar.new)
          end
        end
      end
    else
      @trains.each do |train|
        train.detach! if train.number == number
      end
    end
  end

  def dispatch
    print "Укажите N поезда: "
    number = gets.to_i

    train = nil

    @trains.each do |el|
      train = el if el.number == number
    end

    print "Отправляемся: следующая станция[1] предыдущая[2]"

    opt = gets.to_i

    if opt == 1
      train.next_station
    else
      train.prev_station
    end
  end

  def list
    print "Вывести список: станций[1] поездов[2]"

    opt = gets.to_i

    if opt == 1
      @stations.each_with_index do |station, number|
        puts "Станция N#{number + 1} - #{station}"
      end
    else
      @trains.each_with_index do |train, number|
        puts "\##{number + 1} Поезд N: #{train}"
      end
    end
  end
end
