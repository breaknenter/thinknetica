class Train
  attr_reader :number
  attr_reader :type

  def initialize(number:, type:) # type: :pass :cargo
    @number = number
    @type   = type
    @cars   = []
    @speed  = 0
  end

  def speed_up(speed: 10)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def route(route:)
    @route = route
    @current = 0
  end

  def next_station
    @current += 1 if @current < @route.way.size
  end

  def prev_station
    @current -= 1 if @current.positive?
  end

  def attach(car:)
    @cars << car if @speed.zero?
  end

  def detach!
    @cars.pop if @speed.zero? && !@cars.empty? # FIX empty?
  end

  def to_s
    "#{@number}"
  end
end
