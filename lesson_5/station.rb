require_relative "instance_counter"

class Station
  include InstanceCounter

  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name:)
    @name   = name
    @trains = []

    @@stations << self

    inc_count
  end

  def arrival(train:)
    @trains << train
  end

  def depart(train:)
    @trains.delete(train)
  end

  def to_s
    "#{@name}"
  end
end
