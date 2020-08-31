class Route
  def initialize(from, to)
    @route = [from, to]
  end

  def add_station(station)
    @route.insert(-2, station)
  end

  def del_station(station)
    @route.delete(station)
  end

  def stations
    @route
  end
end
