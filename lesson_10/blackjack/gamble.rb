require_relative "interface"
require_relative "player"
require_relative "deck"

class Gamble
  include Interface

  def initialize
    init_game
  end

  def start
    round
  rescue RuntimeError => err
    puts err.message
  ensure
    farewell
    stats
  end
end
