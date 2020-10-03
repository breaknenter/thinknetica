# frozen_string_literal: true

require_relative "player"
require_relative "deck"

class Gamble
  ACE = :A

  attr_accessor :bet_bank

  def initialize
    @bet_bank = 0
  end

  def start
    name = ask("Введите имя: ")
    human = Player.new(name, 100)
    computer = Player.new("Dealer", 100)

    while true
      deck = Deck.new

      human.hand = deck.deal(2)
      computer.hand = deck.deal(2)

      self.bet_bank += human.place_a_bet(10)
      self.bet_bank += computer.place_a_bet(10)

      games ||= 1

      puts "-------------------------------"
      puts "♥ Играем! ♠ Партия N:#{games}"

      show_info(human)
      dealer_cards(computer)

      cmd = ask("\nВзять карту[1] пропустить[2] вскрыться[3] ")

      if cmd == "1"
        human.hand = deck.deal(1)
        computer.hand = deck.deal(1) if points(computer) < 17

        show_info(human)
        dealer_cards(computer)
        print "\n"
      elsif cmd == "2"
        computer.hand = deck.deal(1) if points(computer) < 17

        cmd = ask("\nЕщё карту? [y/n] ")

        if cmd == "y"
          human.hand = deck.deal(1)
          show_info(human)
        end
      end

      results(human, computer)

      cmd = ask("Играем дальше? [y/n] ")
      if cmd == "n"
        break
      elsif computer.bank.zero?
        puts "Ваш противник банкрот!"
        break
      elsif human.bank.zero?
        puts "Вы банкрот! Проваливайте!"
        break
      end

      games += 1
    end
  end

  private

  def results(player1, player2)
    puts "-------------------------------"
    puts "$$$ Итог $$$"
    show_info(player1)
    show_info(player2)

    eq = points(player1) <=> points(player2)

    if eq.positive?
      if points(player1) > 21
        puts "#{player1}, вы проиграли!"
        player2.get_a_bank = self.bet_bank
      else
        puts "#{player1}, вы выиграли!"
        player1.get_a_bank = self.bet_bank
      end
    elsif eq.negative?
      if points(player2) > 21
        puts "#{player1}, вы выиграли!"
        player1.get_a_bank = self.bet_bank
      else
        puts "#{player1}, вы проиграли!"
        player2.get_a_bank = self.bet_bank
      end
    else
      puts "У вас ничья!"
      player1.get_a_bank = 10
      player2.get_a_bank = 10
    end

    puts "Банк: #{player1} - #{player1.bank}, #{player2} - #{player2.bank}"

    self.bet_bank = 0
    player1.drop
    player2.drop
  end

  def show_info(player)
    print "#{player}, ваши карты: "
    player.cards.each { |card| print "[#{card}] " }
    puts "\nУ вас #{points(player)} очков"
  end

  def dealer_cards(player)
    hide = player.cards.size
    print "Карты дилера: "
    hide.times { print "[?]"}
  end

  def points(player)
    sum = 0
    ace = 0

    player.cards.each do |card|
      sum += card.value
      ace += 1 if card.face == ACE
    end

    while sum > 21 && ace.positive?
      ace -= 1
      sum -= 10
    end

    sum
  end

  def ask(msg)
    print msg
    gets.chomp
  end
end
