class Station
  attr_reader :name

  def initialize(name:)
    @name   = name
    @trains = []
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
