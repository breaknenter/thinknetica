require "singleton"

class TrainYard
  include Singleton

  alias msg puts

  def run
    loop do
      menu

      key = ask

      break if key == "0"

      case key
      when "1" then add_station
      when "2" then add_train
      when "3" then add_route
      when "4" then assign_route
      when "5" then cars
      when "6" then dispatch
      when "7" then list
      end
    end
  end

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

  # Helpers
  def ask(msg = nil)
    print msg if msg
    gets.chomp.to_s
  end

  # def msg(txt); end # возможно понадобится вместо -> alias msg puts

  def add_station
    name = ask "Введите название станции: "

    raise "Станция #{name} уже есть" if Station.find(name: name)

    station = Station.new(name: name)

    rescue RuntimeError => err
      puts err.message
      retry
    else
      msg "Станция \"#{station}\" создана"
  end

  def add_train
    number = ask "Введите N поезда: "

    type = nil

    loop do
      type = ask "Укажите тип: [1]пассажирский [2]грузовой "
      break if type =~ /^(1|2)$/
    end

    type == "1" ? PassengerTrain.new(number: number) : CargoTrain.new(number: number)

    rescue RuntimeError => err
      puts err.message
      retry
    else
      msg "#{Train.find(number: number)} создан"
  end

  def add_route
    opt = nil

    loop do
      opt = ask "Создать маршрут [1] добавить пункт [2] "
      break if opt =~ /(1|2)/
    end

    if opt == "1"
      from = ask "Введите пункт отправления: "
      to   = ask "Введите пункт назначения: "

      raise "Пункт отправления не найден" unless Station.find(name: from)
      raise "Пункт назначения не найден"  unless Station.find(name: to)

      route = Route.new(from: from, to: to)

      msg "Маршрут \"#{route}\" создан"
    else
      from  = ask "Введите маршрут: "
      point = ask "Введите пункт: "

      route = Route.all.find { |route| from == route.way.first } # to_s!

      raise "Маршрут не найден" unless route

      route.add_station(point: point)
    end

  rescue RuntimeError => err
    puts err.message
    retry
  end

  def assign_route
    number = ask "Укажите N поезда: "
    train = Train.find(number: number)

    from  = ask "Введите маршрут: "
    route = Route.all.find { |route| from == route.way.first }

    raise "Маршрут не найден" unless route

    train.route(route: route)

    msg "Маршрут #{route} -> #{train}"

    rescue RuntimeError => err
      puts err.message
      retry
  end

  def cars
    opt = nil

    loop do
      opt = ask "Прицепить вагон [1] отцепить вагон[2] занять место[3]"
      break if opt =~ /(1|2|3)/
    end

    case opt
    when "1" then coupling
    when "2" then unhook
    when "3" then seat
    end
  end

  def coupling
    number = ask "Укажите N поезда: "
    train = Train.find(number: number)
    car_number = train.cars + 1

    if train.type == :pass
      seats = ask "Укажите кол-во мест в вагоне: "
      train.attach(car: PassengerCar.new(number: car_number, seats: seats))
    else
      volume = ask "Укажите объём вагона: "
      train.attach(car: CargoCar.new(number: car_number, volume: volume))
    end

    rescue RuntimeError => err
      puts err.message
  end

  def unhook
    number = ask "Укажите N поезда: "
    train = Train.find(number: number)
    train.detach!
    rescue RuntimeError => err
      puts err.message
  end

  def seat
    number = ask "Укажите N поезда: "
    train = Train.find(number: number)

    car_number = ask "Укажите N вагона: "
    car_number.to_i
    car = train.car(number: car_number)

    if train.type == :pass then car.take_seat
    else car.take_volume
    end

    rescue RuntimeError => err
      puts err.message
  end

  def dispatch
  end

  def list
    opt = nil

    loop do
      opt = ask "Вывести список: станций[1] поездов[2] вагонов[3] выйти[0] "
      break if opt =~ /^(1|2|3|0)$/
    end

    case opt
    when "1" then list_of_stations
    when "2" then list_of_trains
    when "3" then list_of_cars
    when "0" then return
    end

    rescue RuntimeError => err
      puts err.message
      retry
  end

  def list_of_stations
    raise "Список станций пуст" if Station.all.empty?

    msg "Список станций:"

    Station.all.each do |station|
      puts station
      begin
      station.each_trains { |train| puts train }
      rescue RuntimeError => err
        puts err.message
      end
    end
  end

  def list_of_trains
    raise "Нет поездов" if Train.all.empty?

    msg "Список поездов:"

    Train.all.each_value { |train| puts train }
  end

  def list_of_cars
    number = ask "Укажите N поезда: "

    train = Train.find(number: number)

    rescue RuntimeError => err
      msg err.message
      retry
    else
      msg "Список вагонов:"
      train.each_cars { |car| puts car }
  end
end
