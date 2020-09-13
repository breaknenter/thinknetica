require_relative "instance_counter"
require_relative "manufacturer"

class Train
  include Manufacturer

  attr_reader :number
  attr_reader :type

  @@trains = {}

  def self.find(number:)
    @@trains[number]
  end

  def initialize(number:, type:) # type: :pass :cargo
    @number = number
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
    @current += 1 if @current < @route.way.size
  end

  def prev_station
    @current -= 1 if @current.positive?
  end

  def attach(car:)
    @cars << car if stopped?
  end

  def detach!
    @cars.pop if stopped? && !@cars.empty?
  end

  def to_s
    "#{@number}"
  end

  private

  def stopped?
    @speed.zero?
  end
end
