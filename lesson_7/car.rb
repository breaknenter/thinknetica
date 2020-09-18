require_relative "manufacturer"

class Car
  include Manufacturer

  def initialize(type:, number:, places:) # :pass :cargo
    @type     = type
    @number   = number
    @places   = places
    @occupied = 0
  end

  def take(val:, msg:)
    raise msg if full?(val)
    @occupied += val
  end

  def free
    @places - @occupied
  end

  def full?(val)
    places.to_i - occupied.to_i < val.to_i
  end

  protected

  attr_reader   :type
  attr_accessor :number
  attr_accessor :places
  attr_accessor :occupied
end
