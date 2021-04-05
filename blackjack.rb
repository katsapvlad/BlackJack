# frozen_string_literal: true

require 'io/console'
require './card'
require './player'
# this class includes some information about the game process
class BlackJack
  def start_game
    welcome
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
  end

  def game_process
    puts "Let's start! Press Enter to start the game. Good Luck!".center(150)
    return unless gets

    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
    deck = Deck.new
    player_1 = Player.new(deck)
    player_2 = Player.new(deck)
    total_value = 0
    opp_total_value = 0
    puts 'My cards:'
    player_1.cards.first.display_hand(player_1.cards)
    puts 'Opponents cards:'
    player_2.cards.first.display_hidden_hand(player_2.cards)
    player_1.cards.each { |card| total_value += Card::RANKS[card.value] } 
    player_2.cards.each { |card| opp_total_value += Card::RANKS[card.value] }
    ask_about_continued(total_value, deck, player_1, opp_total_value, player_2)
  end

  def ask_about_continued(total_value, deck, player_1, opp_total_value, player_2)
    puts "\nTotal value: #{total_value}\nDo you want to take another card?: Yes(default) or No"
    answ = gets.strip.capitalize
    if answ == 'No'
    a = 0
    b = 0
    loop do
      if opp_total_value < 17
        player_2.continue(deck, player_2)
        opp_total_value += player_2.cards[-1].value
      end
      a = opp_total_value
      break if a == b

      b = opp_total_value
    end
      puts 'My cards:'
      player_1.cards.first.display_hand(player_1.cards)
      puts 'Opponents cards:'
      player_2.cards.first.display_hand(player_2.cards)
      result_calculating(total_value, opp_total_value)
      play_again
    else
      player_1.continue(deck, player_1)
      if opp_total_value < 17
        player_2.continue(deck, player_2)
        opp_total_value += Card::RANKS[player_2.cards[-1].value]
      end
      puts 'My cards:'
      player_1.cards.first.display_hand(player_1.cards)
      puts 'Opponents cards:'
      player_2.cards.first.display_hidden_hand(player_2.cards)
      total_value += Card::RANKS[player_1.cards[-1].value]
      ask_about_continued(total_value, deck, player_1, opp_total_value, player_2)
    end
  end

  def result_calculating(total_value, opp_total_value)
    if total_value > 21 && opp_total_value > 21 then nobody_win_message(total_value, opp_total_value)
    elsif total_value == opp_total_value then nobody_win_message(total_value, opp_total_value)
    elsif total_value > opp_total_value && total_value < 21 then winer_message(total_value, opp_total_value)
    elsif total_value < opp_total_value && opp_total_value < 21 then loser_message(total_value, opp_total_value)
    elsif total_value == 21 || opp_total_value > 21 then winer_message(total_value, opp_total_value)
    elsif total_value > 21 || opp_total_value == 21 then loser_message(total_value, opp_total_value)
    end
  end

  def play_again
    puts "\n\nDo you wanna play again?: Yes(default) or No"
    answ = gets.strip.capitalize
    unless answ == 'No'
      system('reset')
      game_process
    end
  end

  def winer_message(total_value, opp_total_value)
    total_values(total_value, opp_total_value)
    puts 'You are winner!!!'.center(150)
  end

  def loser_message(total_value, opp_total_value)
    total_values(total_value, opp_total_value)
    puts 'You are loser...'.center(150)
  end

  def nobody_win_message(total_value, opp_total_value)
    total_values(total_value, opp_total_value)
    puts 'Nobody win!'.center(150)
  end

  def total_values(total_value, opp_total_value)
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
    puts "\n\n#{"Total value: #{total_value}\n".center(150)}"
    puts "Opponents total value: #{opp_total_value}\n".center(150)
  end
end
game = BlackJack.new
game.start_game
