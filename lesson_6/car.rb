require_relative "manufacturer"

class Car
  include Manufacturer

  def initialize(type:) # :pass :cargo
    @type = type
  end
end
