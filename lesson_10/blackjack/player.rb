# frozen_string_literal: true

class Player
  NATURAL = 21

  attr_accessor :wins, :losses
  attr_reader   :name, :hand, :bank

  def initialize(name, bank)
    @name   = name
    @bank   = bank
    @hand   = []
    @wins   = 0
    @losses = 0
  end

  def hand=(card)
    self.hand << card
  end

  def cards
    self.hand.size
  end

  def points
    sum  = 0
    aces = 0

    hand.each do |card|
      sum  += card.value
      aces += 1 if card.ace?
    end

    aces.times { sum -= 10 if sum > NATURAL }

    sum
  end

  def place_bet(bet)
    self.bank -= bet
    bet
  end

  def take_bank=(sum)
    self.bank += sum
  end

  def win!
    self.wins += 1
  end

  def lose!
    self.losses += 1
  end

  def reset
    self.hand.clear
  end

  def stat
    "побед/поражений: #{self.wins}/#{self.losses} банк: #{self.bank}"
  end

  def to_s
    str = "Игрок: #{name} >"
    hand.each { |card| str += " #{card}" }
    str += " очков: #{self.points} банк: #{self.bank}"
  end

  private

  attr_writer :bank
end
