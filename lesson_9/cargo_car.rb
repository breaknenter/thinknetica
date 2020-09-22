# frozen_string_literal: true

class CargoCar < Car
  attr_reader :number
  attr_reader :occupied

  def initialize(number:, volume:)
    super(type: :cargo, number: number, places: volume)
  end

  def take_volume(val:)
    take(val: val, msg: 'Мест нет')
  end

  def to_s
    "Грузовой вагон N: #{number}. Мест: #{places}, занято: #{occupied}"
  end
end
