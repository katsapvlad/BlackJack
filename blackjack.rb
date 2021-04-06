# frozen_string_literal: true

require 'io/console'
require './card'
require './player'
# this class includes some information about the game process
class BlackJack
  def start_game
    welcome
    return unless gets

    game_process
  end

  private

  def welcome
    system('reset')
    puts 'WELCOME TO BLACKJACK!'.center(150, " \u2667  \u2662  \u2661  \u2664 ")
    introduction
  end

  def introduction
    puts "\n\n"
    puts "Before we start the game, let's get acquainted.".center(150)
    puts "What's your name?\n".center(150)
    name = $stdin.noecho(&:gets).strip.capitalize
    puts "Hello, #{name}! My name's Black Jack, and today I'm your opponent.".center(150)
    puts "Let's start! Press Enter to start the game. Good Luck!".center(150)
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
  end

  def game_process
    deck = Deck.new
    player1 = Player.new(deck)
    player2 = Player.new(deck)
    total1 = 0
    total2 = 0
    player1.cards.first.display_hand(player1.cards, 'My cards:')
    player2.cards.first.display_hidden_hand(player2.cards, 'Opponents cards:')
    player1.cards.each { |card| total1 += Card::RANKS[card.value] }
    player2.cards.each { |card| total2 += Card::RANKS[card.value] }
    ask_about_continued(total1, deck, player1, total2, player2)
  end

  def ask_about_continued(total1, deck, player1, total2, player2)
    puts "\nTotal value: #{total1}\nDo you want to take another card?: Yes(default) or No"
    if gets.strip.capitalize == 'No'
      answ_no(total1, deck, player1, total2, player2)
    else
      answ_yes(total1, deck, player1, total2, player2)
    end
  end

  def answ_no(total1, deck, player1, total2, player2)
    total2_calculating(0, 0, deck, total2, player2)
    player1.cards.first.display_hand(player1.cards, 'My cards:')
    player2.cards.first.display_hand(player2.cards, 'Opponents cards:')
    result_calculating(total1, total2)
    play_again
  end

  def total2_calculating(var_a, var_b, deck, total2, player2)
    loop do
      if total2 < 17
        player2.continue(deck, player2)
        total2 += Card::RANKS[player2.cards[-1].value]
      end
      var_a = total2
      break if var_a == var_b

      var_b = total2
    end
    total2
  end

  def answ_yes(total1, deck, player1, total2, player2)
    player1.continue(deck, player1)
    if total2 < 17
      player2.continue(deck, player2)
      total2 += Card::RANKS[player2.cards[-1].value]
    end
    player1.cards.first.display_hand(player1.cards, 'My cards:')
    player2.cards.first.display_hidden_hand(player2.cards, 'Opponents cards:')
    total1 += Card::RANKS[player1.cards[-1].value]
    ask_about_continued(total1, deck, player1, total2, player2)
  end

  def result_calculating(total1, total2)
    if total1 > 21 && total2 > 21 then message(total1, total2, 'Nobody win!')
    elsif total1 == total2 then message(total1, total2, 'Nobody win!')
    elsif total1 > total2 && total1 < 21 then message(total1, total2, 'You are winner!!!')
    elsif total1 < total2 && total1 < 21 then message(total1, total2, 'You are loser...')
    elsif total1 == 21 || total2 > 21 then message(total1, total2, 'You are winner!!!')
    elsif total1 > 21 || total2 == 21 then message(total1, total2, 'You are loser...')
    end
  end

  def play_again
    puts "\n\nDo you wanna play again?: Yes(default) or No"
    return if gets.strip.capitalize == 'No'

    system('reset')
    game_process
  end

  def message(total1, total2, message)
    total_values(total1, total2)
    puts message.center(150)
  end

  def total_values(total1, total2)
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
    puts "\n\n#{"Total value: #{total1}\n".center(150)}"
    puts "Opponents total value: #{total2}\n".center(150)
  end
end
game = BlackJack.new
game.start_game
