class CargoTrain < Train
  include InstanceCounter

  def initialize(number:)
    super(number: number, type: :cargo)

    inc_count
  end
end
