# frozen_string_literal: true

class PassengerCar < Car
  attr_reader :number
  attr_reader :occupied

  def initialize(number:, seats:)
    super(type: :pass, number: number, places: seats)
  end

  def take_seat
    take(val: 1, msg: 'Мест нет')
  end

  def to_s
    "Пассажирский вагон N: #{number}. Мест: #{places}, занято: #{occupied}"
  end
end
