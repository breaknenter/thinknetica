class Route
  attr_reader :way

  def initialize(from:, to:)
    @way = [from, to]
  end

  def add_station(point:)
    @way.insert(-2, point)
  end

  def del_station(point:)
    @way.delete(point)
  end
end
