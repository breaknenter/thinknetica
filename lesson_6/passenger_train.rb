class PassengerTrain < Train
  include InstanceCounter

  def initialize(number:)
    super(number: number, type: :pass)

    register_instance
  end
end
