class Train
  attr_reader :number
  attr_reader :type
  attr_reader :cars
  attr_reader :speed

  def initialize(number, type, cars)
    @number = number
    @type   = type # :pass :freight
    @cars   = cars

    @speed  = 0
  end

  def speed_up(speed = 10)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def attach
    @cars += 1 if @speed.zero?
  end

  def detach
    @cars -=1 if @speed.zero? && @cars.positive?
  end

  def route(route)
    @route   = route
    @current = 0
  end

  def forth
    @current += 1 if last_station?
  end

  def back
    @current -= 1 if current.positive?
  end

  def current
    @route.route[@current]
  end

  def next_station
    @route.route[@current + 1] if last_station?
  end

  def prev_station
    @route.route[@current - 1] if @current.positive?
  end

  private

  def last_station?
    @current < @route.route.size
  end
end
