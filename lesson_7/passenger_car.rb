class PassengerCar < Car
  attr_reader :number
  attr_reader :occupied

  def initialize(number:, seats:)
    @number   = number
    @seats    = seats
    @occupied = 0
    super(type: :pass)
  end

  def take_seat
    raise "Свободных мест нет!" if free_seats.zero?
    @occupied += 1
  end

  def free_seats
    @seats.to_i - @occupied.to_i
  end

  def to_s
    "Пассажирский вагон N: #{number}. Мест: #{@seats}, занято: #{@occupied}"
  end
end
