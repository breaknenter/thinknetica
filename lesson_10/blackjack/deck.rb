# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = []

    suits  = %i[♥ ♦ ♠ ♣]
    faces  = %i[A K Q J 10 9 8 7 6 5 4 3 2]
    values = [11, 10, 10, 10, 10, 9, 8, 7, 6, 5, 4, 3, 2]

    card = Struct.new(:suit, :face, :value) do
      def to_s
        "#{self.suit}#{self.face}"
      end
    end

    suits.each { |suit|
      faces.each_with_index { |face, this| @cards << card.new(suit, face, values[this]) }
    }

    @cards.shuffle!
  end

  def deal(num_of)
    self.cards.shift(num_of)
  end
end
