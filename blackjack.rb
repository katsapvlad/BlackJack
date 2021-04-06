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
    player = Player.new("Vlad")
    dealer = Player.new("Dealer")
    player.get_cards(deck)
    dealer.get_cards(deck)
    player_score = 0
    dealer_score = 0
    Card.display_hand(player.cards, 'My cards:')
    Card.display_hidden_hand(dealer.cards, 'Opponents cards:')
    player.cards.each { |card| player_score += Card::RANKS[card.value] }
    dealer.cards.each { |card| dealer_score += Card::RANKS[card.value] }
    ask_about_continued(player_score, deck, player, dealer_score, dealer)
  end

  def ask_about_continued(player_score, deck, player, dealer_score, dealer)
    puts "\nTotal value: #{player_score}\nDo you want to take another card?: Yes(default) or No"
    if gets.strip.capitalize == 'No'
      answ_no(player_score, deck, player, dealer_score, dealer)
    else
      answ_yes(player_score, deck, player, dealer_score, dealer)
    end
  end

  def answ_no(player_score, deck, player, dealer_score, dealer)
    dealer_score = dealer_score_calculating(0, 0, deck, dealer_score, dealer)
    Card.display_hand(player.cards, 'My cards:')
    Card.display_hand(dealer.cards, 'Opponents cards:')
    result_calculating(player_score, dealer_score)
    play_again
  end

  def dealer_score_calculating(var_a, var_b, deck, dealer_score, dealer)
    loop do
      if dealer_score < 17
        dealer.continue(deck, dealer)
        dealer_score += Card::RANKS[dealer.cards[-1].value]
      end
      var_a = dealer_score
      break if var_a == var_b

      var_b = dealer_score
    end
    dealer_score
  end

  def answ_yes(player_score, deck, player, dealer_score, dealer)
    player.continue(deck, player)
    if dealer_score < 17
      dealer.continue(deck, dealer)
      dealer_score += Card::RANKS[dealer.cards[-1].value]
    end
    Card.display_hand(player.cards, 'My cards:')
    Card.display_hidden_hand(dealer.cards, 'Opponents cards:')
    player_score += Card::RANKS[player.cards[-1].value]
    ask_about_continued(player_score, deck, player, dealer_score, dealer)
  end

  def result_calculating(player_score, dealer_score)
    if player_score > 21 && dealer_score > 21 then message(player_score, dealer_score, 'Nobody win!')
    elsif player_score == dealer_score then message(player_score, dealer_score, 'Nobody win!')
    elsif player_score > dealer_score && player_score < 21 then message(player_score, dealer_score, 'You are winner!!!')
    elsif player_score < dealer_score && player_score < 21 then message(player_score, dealer_score, 'You are loser...')
    elsif player_score == 21 || dealer_score > 21 then message(player_score, dealer_score, 'You are winner!!!')
    elsif player_score > 21 || dealer_score == 21 then message(player_score, dealer_score, 'You are loser...')
    end
  end

  def play_again
    puts "\n\nDo you wanna play again?: Yes(default) or No"
    return if gets.strip.capitalize == 'No'

    system('reset')
    game_process
  end

  def message(player_score, dealer_score, message)
    total_values(player_score, dealer_score)
    puts message.center(150)
  end

  def total_values(player_score, dealer_score)
    puts "\n\n#{" \u2667   \u2662   \u2661   \u2664 " * 10}\n\n"
    puts "\n\n#{"Total value: #{player_score}\n".center(150)}"
    puts "Opponents total value: #{dealer_score}\n".center(150)
  end
end
game = BlackJack.new
game.start_game
