# frozen_string_literal: true

require './deck'
require './my_cards'

# this class includes some information about my cards
class OpponentsCards < MyCards
  attr_accessor :opp_cards

  def initialize(deck)
    super
    @opp_cards = []
    2.times do
      @opp_cards << deck.cards[0]
      deck.cards.delete_at(0)
    end
  end

  def continue(deck, _opp_hand, _opp_total_value)
    @opp_cards << deck.cards[0]
    deck.cards.delete_at(0)
  end

  def show_empty_cards(hand)
    print ' ' * 10
    hand.size.times { print '--------     ' }
    5.times do
      print "\n#{' ' * 10}"
      1.upto(hand.size) { print '|      |     ' }
    end
    print "\n#{' ' * 10}"
    hand.size.times { print '--------     ' }
    puts ' '
  end
end
