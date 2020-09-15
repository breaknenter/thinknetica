require_relative "instance_counter"
require_relative "manufacturer"
require_relative "validator"

class Train
  include Manufacturer

  NUM_EXP = / # ^[a-z|\d]{3}-?([a-z]{2}|\d{2})$
    ^[a-z|\d]{3}      # 3 буквы или цифры в любом порядке
    -?                # необязательный дефис
    ([a-z]{2}|\d{2})$ # 2 буквы или цифры после дефиса
  /x

  attr_reader :number
  attr_reader :type

  @@trains = {}

  def self.find(number:)
    @@trains[number]
  end

  def initialize(number:, type:) # type: :pass :cargo
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise if number !~ NUM_EXP
  end

  def stopped?
    @speed.zero?
  end
end
