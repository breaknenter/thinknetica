# frozen_string_literal: true

class CargoTrain < Train
  include InstanceCounter

  def initialize(number:)
    super(number: number, type: :cargo)

    register_instance
  end

  def to_s
    "Грузовой поезд N #{number}, вагонов: #{cars}"
  end
end
