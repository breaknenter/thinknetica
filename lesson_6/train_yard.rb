require "singleton"

class TrainYard
  include Singleton

  alias msg puts

  @@type_of_train = {"1" => "Пассажирский", "2" => "Грузовой"}

  def initialize
    @stations = []
    @routes   = []
    @trains   = []
  end

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
      when "5" then coupling
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
  end

  def add_train
    begin
    number = ask "Введите N поезда: "

    type = nil

    loop do
      type = ask "Укажите тип: [1]пассажирский [2]грузовой "
      break if type =~ /^(1|2)$/
    end

    type == "1" ? @trains << PassengerTrain.new(number: number) : @trains << CargoTrain.new(number: number)

    rescue
      msg "Неправильный формат номера. Попробуем ещё раз."
      retry
    end

    msg "#{@@type_of_train[type]} поезд N:#{number} создан"
  end

  def add_route
  end

  def assign_route
  end

  def coupling
  end

  def dispatch
  end

  def list
  end
end
