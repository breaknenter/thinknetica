class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive(train)
    @trains << train
  end

  def dispatch(number)
    @trains.each { |train| @trains.delete_at(train) if @trains[train].number == number }
  end

  def trains_by_type(type) # :pass :freight
    @trains.each.with_object([]) { |el, trains| trains << @trains[train] if @trains[train] == type }
  end
end
