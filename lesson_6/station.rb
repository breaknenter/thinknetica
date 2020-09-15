require_relative "instance_counter"

class Station
  include InstanceCounter

  NAME_EXP = /
    ^[А-ЯЁ][а-яё]{2,15}$ # Название населённого пункта с заглавной буквы (3..16 букв)
  /x

  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name:)
    @name   = name
    valid!
    @trains = []

    @@stations << self

    register_instance
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def valid!
    raise if name !~ NAME_EXP
  end
end
