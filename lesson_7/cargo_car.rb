class CargoCar < Car
  attr_reader :number
  attr_reader :occupied

  def initialize(number:, volume:)
    @number   = number
    @volume   = volume
    @occupied = 0
    super(type: :cargo)
  end

  def take_volume
    raise "Свободного места нет!" if free_volume.zero?
    @occupied += 1
  end

  def free_volume
    @volume - @occupied
  end

  def to_s
    "Грузовой вагон N: #{number}. Мест: #{@seats}, занято: #{@occupied}"
  end
end
