require_relative "instance_counter"

class Route
  include InstanceCounter

  attr_reader :way

  def initialize(from:, to:)
    @way = [from, to]

    inc_count
  end

  def add_station(point:)
    @way.insert(-2, point)
  end

  def del_station(point:)
    @way.delete(point)
  end
end
