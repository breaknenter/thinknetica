# frozen_string_literal: true

module Interface
  def welcome
    puts <<~'ART'
       ____  _            _       _            _
      | __ )| | __ _  ___| | __  | | __ _  ___| | __
      |  _ \| |/ _` |/ __| |/ /  | |/ _` |/ __| |/ /
      | |_) | | (_| | (__|   < |_| | (_| | (__|   <
      |____/|_|\__,_|\___|_|\_\___/ \__,_|\___|_|\_\

    ART
    puts <<-'GREET'
         - Добро пожаловать в игру! -

    GREET
  end

  def ask(msg)
    print "#{msg} "
    gets.chomp
  end

  def play_more?
    ask("Играем ещё? [y/n]") == "y" ? true : false
  end

  def farewell
    puts "\nИгра окончена!\n"
  end

  def stats
    puts "==============="
    puts "Статистика:"
    print "Игрок: #{player.name}, ", player.stat
    puts ""
    print "Игрок: #{dealer.name}, ", dealer.stat
    puts ""
    puts "Сыграно партий: #{self.played}, ничьих: #{self.draws}"
  end
end
