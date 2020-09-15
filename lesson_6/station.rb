require_relative "instance_counter"
require_relative "validator"

class Station
  include Validator
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
    raise unless valid?(val: name, exp: NAME_EXP)

    @name   = name
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
end
