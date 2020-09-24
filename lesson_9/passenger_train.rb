# frozen_string_literal: true

class PassengerTrain < Train
  include InstanceCounter

  validate :number, :format, NUM_EXP

  def initialize(number:)
    super(number: number, type: :pass)

    register_instance
  end

  def to_s
    "Пассажирский поезд N #{number}, вагонов: #{cars}"
  end
end
