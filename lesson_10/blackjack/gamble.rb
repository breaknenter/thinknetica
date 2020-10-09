require_relative "interface"
require_relative "player"
require_relative "deck"

class Gamble
  include Interface

  BANK_SIZE = 100
  BET_SIZE  = 10
  BLACKJACK = 21
  HIT_17    = 17

  attr_accessor :bet_bank, :deck,  :played, :draws
  attr_reader   :player,   :dealer

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

  private

  def init_game
    welcome

    name = ask("Представьтесь:")

    @player = Player.new(name, BANK_SIZE)
    @dealer = Player.new("Дилер", BANK_SIZE)

    @bet_bank = 0
    @deck     = nil

    @played   = 0
    @draws    = 0
  end

  def round
    while true
      round_info

      place_bet(player, BET_SIZE)
      place_bet(dealer, BET_SIZE)

      self.deck = Deck.new

      2.times do
        add_card(player)
        add_card(dealer)
      end

      show_cards(player)
      dealer_cards(dealer)

      moves
      show_cards(dealer)
      result

      round_reset
      check_bank

      break unless play_more?
    end
  end

  def round_info
    self.played += 1
    puts "\nИграем! Партия: #{self.played}"
  end

  def place_bet(player, bet)
    self.bet_bank += player.place_bet(bet)
  end

  def give_bank(player, sum = nil)
    if sum
      self.bet_bank   -= sum
      player.take_bank = sum
    else
      player.take_bank = self.bet_bank
      self.bet_bank    = 0
    end
  end

  def add_card(player)
    player.hand = deck.deal
  end

  def moves
    return if blackjack?(player_score)

    choice = ask("\nВзять карту[1] пропустить[2] вскрыться[3]")

    if choice == "1"
      add_card(player)
      show_cards(player)

      if dealer_score < HIT_17
        puts "Ход Дилера"
        sleep(2)
        add_card(dealer)
        dealer_cards(dealer)
      end

      print "\n"
    elsif choice == "2"
      if dealer_score < HIT_17
        puts "Ход Дилера"
        sleep(2)
        add_card(dealer)
        dealer_cards(dealer)
      end

      choice = ask("\nЕщё карту? [y/n]")
      if choice == "y"
        add_card(player)
        show_cards(player)
      end
    end
  end

  def result
    if player_score == BLACKJACK
      puts "\nУ вас Bl♠ckj♠ck!"
      sleep(2)
      player_win!
    elsif player_score < BLACKJACK && dealer_score > BLACKJACK || player_score > dealer_score && player_score < BLACKJACK
      player_win!
    elsif player_score > BLACKJACK || dealer_score > player_score && dealer_score < BLACKJACK
      dealer_win!
    elsif player_score == dealer_score && player_score <= BLACKJACK
      draw!
    end
  end

  def show_cards(player)
    puts player
  end

  def dealer_cards(dealer)
    print "Дилер: "
    dealer.hand.each { |card| print "#{card.back} "}
  end

  def player_score
    player.points
  end

  def dealer_score
    dealer.points
  end

  def blackjack?(score)
    score == BLACKJACK
  end

  def player_win!
    puts "#{player.name}, вы выиграли!"

    player.win!
    dealer.lose!

    give_bank(player)
  end

  def dealer_win!
    puts "#{player.name}, вы проиграли!"

    dealer.win!
    player.lose!

    give_bank(dealer)
  end

  def draw!
    puts "Ничья!"

    self.draws += 1

    give_bank(player, BET_SIZE)
    give_bank(dealer, BET_SIZE)
  end

  def check_bank
    raise "#{player.name}, вы банкрот! Проваливайте!"   if player.bank.zero?
    raise "#{player.name}, весь банк ваш! Поздравляем!" if dealer.bank.zero?
  end

  def round_reset
    player.reset
    dealer.reset
  end
end
