class Station
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

  def trains
    @trains
  end

  def trains_by_type(type) # :pass :freight
    trains = []
    @trains.each { |train| trains << @trains[train] if @trains[train] == type }
    trains
  end
end
