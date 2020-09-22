# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :way

  @@routes = []

  class << self
    def all
      @@routes
    end

    def find(route:)
      @@routes.find { |i| route == i }
    end
  end

  def initialize(from:, to:)
    @way = [from, to]

    @@routes << self

    register_instance
  end

  def add_station(point:)
    @way.insert(-2, point)
  end

  def del_station(point:)
    @way.delete(point)
  end

  def to_s
    "#{@way.first} > #{@way.last}"
  end
end
