# frozen_string_literal: true

class Deck
  def initialize
    @cards = create
  end

  def create
    suits  = %i[♥ ♠ ♦ ♣]
    ranks  = %i[2 3 4 5 6 7 8 9 10 J Q K A]
    values = [*(2..10), 10, 10, 10, 11]

    card = Struct.new(:rank, :suit, :value) do
      def ace?
        self.rank == :A
      end

      def back
        "[?]"
      end

      def to_s
        "#{self.rank}#{self.suit}"
      end
    end

    suits.each_with_object([]) { |suit, cards|
      ranks.each_with_index { |rank, this| cards << card.new(rank, suit, values[this]) }
    }.shuffle!
  end

  def deal
    cards.pop
  end

  private

  attr_reader :cards
end
