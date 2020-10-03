# frozen_string_literal: true

class Player
  attr_reader   :name
  attr_accessor :cards, :bank

  def initialize(name, bank)
    @name  = name
    @bank  = bank
    @cards = []
  end

  def hand=(cards)
    self.cards += cards
  end

  def drop
    self.cards.clear
  end

  def place_a_bet(sum)
    self.bank -= sum
    sum
  end

  def get_a_bank=(sum)
    self.bank += sum
  end

  def to_s
    self.name
  end
end
