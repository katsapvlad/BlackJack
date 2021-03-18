# frozen_string_literal: true

require 'io/console'
require './my_cards'
# this class includes some information about the game process
class BlackJack
  def welcome
    system('reset')
    puts '  WELCOME TO BLACKJACK!  '.center(150, " \u2667  \u2662  \u2661  \u2664 ")
    puts "\n\n"
    sleep(2)
    introduction
    puts "Let's start! Press any button to start the game. Good Luck!".center(150)
    start_game if gets
  end

  def start_game
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
    hand = MyCards.new
    hand.my_cards.each do |card|
      show_cards(card)
    end
  end

  private

  def introduction
    puts "Before we start the game, let's get acquainted.".center(150)
    puts "What's your name?\n".center(150)
    name = $stdin.noecho(&:gets).strip.capitalize
    sleep(1)
    puts "Hello, #{name}! My name's Black Jack, and today I'm your opponent.".center(150)
    sleep(1)
  end

  def show_cards(card)
    puts "   --------\n" + "   |#{card.rank}     |\n" \
         "   | #{card.suit}    |\n" + "   |  #{card.suit}   |\n" + "   |   #{card.suit}  |\n" \
         "   |     #{card.rank}|\n" + "   --------\n"
  end
end
game = BlackJack.new
game.welcome
