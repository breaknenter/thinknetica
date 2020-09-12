class PassengerTrain < Train
  include InstanceCounter

  def initialize(number:)
    super(number: number, type: :pass)

    inc_count
  end
end
