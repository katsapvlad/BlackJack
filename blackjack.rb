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
    @player_score = 0
    @dealer_score = 0
  end

  def take_cards
    @player.take_cards(@deck)
    @dealer.take_cards(@deck)
  end

  def process_cards
    Card.display_hand(@player.cards, 'My cards:')
    Card.display_hidden_hand(@dealer.cards, 'Opponents cards:')
    @player.cards.each { |card| @player_score += Card::RANKS[card.value] }
    @dealer.cards.each { |card| @dealer_score += Card::RANKS[card.value] }
  end

  def continue_game
    puts "\nTotal value: #{@player_score}\nDo you want to take another card?: Yes(default) or No"
    if gets.strip.capitalize == 'No'
      answ_no
    else
      answ_yes
    end
  end

  def answ_no
    @dealer_score = dealer_score_calculating(0, 0)
    Card.display_hand(@player.cards, 'My cards:')
    Card.display_hand(@dealer.cards, 'Opponents cards:')
    result_calculating
    play_again
  end

  def dealer_score_calculating(var_a, var_b)
    loop do
      if @dealer_score < 17
        @dealer.continue(@deck)
        @dealer_score += Card::RANKS[@dealer.cards[-1].value]
      end
      var_a = @dealer_score
      break if var_a == var_b

      var_b = @dealer_score
    end
    @dealer_score
  end

  def answ_yes
    @player.continue(@deck)
    if @dealer_score < 17
      @dealer.continue(@deck)
      @dealer_score += Card::RANKS[@dealer.cards[-1].value]
    end
    Card.display_hand(@player.cards, 'My cards:')
    Card.display_hidden_hand(@dealer.cards, 'Opponents cards:')
    @player_score += Card::RANKS[@player.cards[-1].value]
    continue_game
  end

  def result_calculating
    if @player_score > 21 && @dealer_score > 21 then message('Nobody win!')
    elsif @player_score == @dealer_score then message('Nobody win!')
    elsif @player_score > @dealer_score && @player_score < 21 then message('You are winner!!!')
    elsif @player_score < @dealer_score && @player_score < 21 then message('You are loser...')
    elsif @player_score == 21 || @dealer_score > 21 then message('You are winner!!!')
    elsif @player_score > 21 || @dealer_score == 21 then message('You are loser...')
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
    puts "\n\n#{"Total value: #{@player_score}\n".center(150)}"
    puts "Opponents total value: #{@dealer_score}\n".center(150)
  end
end
game = BlackJack.new
game.start_game
