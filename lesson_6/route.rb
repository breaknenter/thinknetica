require_relative "instance_counter"
require_relative "validator"

class Route
  include Validator
  include InstanceCounter

  WAY_EXP = /
    ^[А-ЯЁ][а-яё]{2,15}$ # Название населённого пункта с заглавной буквы (3..16 букв)
  /x

  attr_reader :way

  def initialize(from:, to:)
    raise unless valid?(val: from, exp: WAY_EXP) && valid?(val: to, exp: WAY_EXP)

    @way = [from, to]

    register_instance
  end

  def add_station(point:)
    @way.insert(-2, point)
  end

  def del_station(point:)
    @way.delete(point)
  end
end
