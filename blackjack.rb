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
    @name = $stdin.noecho(&:gets).strip.capitalize
    puts "Hello, #{@name}! My name's Black Jack, and today I'm your opponent.".center(150)
    puts "Let's start! Press Enter to start the game. Good Luck!".center(150)
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
  end

  def game_process
    initialize_deck_and_players
    take_cards
    process_cards
    continue_game
  end

  def initialize_deck_and_players
    @deck = Deck.new
    @player = Player.new(@name)
    @dealer = Player.new('Dealer')
  end

  def take_cards
    2.times do
      @player.take_card(@deck)
      @dealer.take_card(@deck)
    end
  end

  def process_cards
    Card.display_hand(@player.cards, 'My cards:')
    Card.display_hidden_hand(@dealer.cards, 'Opponents cards:')
  end

  def continue_game
    puts "\nTotal value: #{@player.score}\nDo you want to take another card?: Yes(default) or No"
    if gets.strip.capitalize == 'No'
      answ_no
    else
      answ_yes
    end
  end

  def answ_no
    @dealer.score = dealer_score_calculating(0, 0)
    Card.display_hand(@player.cards, 'My cards:')
    Card.display_hand(@dealer.cards, 'Opponents cards:')
    result_calculating
    play_again
  end

  def dealer_score_calculating(var_a, var_b)
    loop do
      if @dealer.score < 17
        @dealer.take_card(@deck)
      end
      var_a = @dealer.score
      break if var_a == var_b

      var_b = @dealer.score
    end
    @dealer.score
  end

  def answ_yes
    @player.take_card(@deck)
    if @dealer.score < 17
      @dealer.take_card(@deck)
    end
    Card.display_hand(@player.cards, 'My cards:')
    Card.display_hidden_hand(@dealer.cards, 'Opponents cards:')
    continue_game
  end

  def result_calculating
    if @player.score > 21 && @dealer.score > 21 then message('Nobody win!')
    elsif @player.score == @dealer.score then message('Nobody win!')
    elsif @player.score > @dealer.score && @player.score < 21 then message('You are winner!!!')
    elsif @player.score < @dealer.score && @player.score < 21 then message('You are loser...')
    elsif @player.score == 21 || @dealer.score > 21 then message('You are winner!!!')
    elsif @player.score > 21 || @dealer.score == 21 then message('You are loser...')
    end
  end

  def play_again
    puts "\n\nDo you wanna play again?: Yes(default) or No"
    return if gets.strip.capitalize == 'No'

    system('reset')
    game_process
  end

  def message(message)
    total_values
    puts message.center(150)
  end

  def total_values
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
    puts "\n\n#{"Total value: #{@player.score}\n".center(150)}"
    puts "Opponents total value: #{@dealer.score}\n".center(150)
  end
end
game = BlackJack.new
game.start_game
