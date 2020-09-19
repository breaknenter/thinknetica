# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'

class Train
  include Manufacturer

  NUM_EXP = / # ^[a-z|\d]{3}-?([a-z]{2}|\d{2})$
    ^[a-z|\d]{3}      # 3 буквы или цифры в любом порядке
    -?                # необязательный дефис
    ([a-z]{2}|\d{2})$ # 2 буквы или цифры после дефиса
  /x.freeze

  attr_reader :number
  attr_reader :type

  @@trains = {}

  class << self
    def all
      @@trains
    end

    def find(number:)
      train = @@trains[number]
      raise "Поезд N: #{number} не найден!" unless train

      train
    end
  end

  def initialize(number:, type:)
    @number = number
    validate!
    @type   = type
    @cars   = []
    @speed  = 0

    @@trains[number] = self
  end

  def speed_up(speed: 10)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def route(route:)
    @route   = route
    @current = 0
  end

  def next_station
    raise 'Конечная, приехали' if @current == @route.way.size

    @current += 1
  end

  def prev_station
    raise 'Вы находитесь на первой станции маршрута' if @current.zero?

    @current -= 1
  end

  def attach(car:)
    raise 'Поезд движется' unless stopped?

    @cars << car
  end

  def detach!
    raise 'Поезд движется' unless stopped?
    raise 'Отцеплять нечего' if cars.zero?

    @cars.pop
  end

  def car(number:)
    car = @cars.find { |c| number == c.number.to_s }
    raise "Вагон N #{number} не найден" unless car

    car
  end

  def cars
    @cars.size
  end

  def each_cars
    raise 'Нет прицепленных вагонов' if cars.zero?

    @cars.each { |car| yield car }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Неправильный формат номера' if number !~ NUM_EXP
  end

  def stopped?
    @speed.zero?
  end
end
