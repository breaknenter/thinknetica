class Route
  attr_reader :route
  def initialize(from, to)
    @route = [from, to]
  end

  def add_station(station)
    @route.insert(-2, station)
  end

  def del_station(station)
    @route.delete(station)
  end
end
