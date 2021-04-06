# frozen_string_literal: true

require './deck'

# this class includes some information about my cards
class Player
  attr_accessor :cards

  def initialize(deck)
    @cards = []
    2.times do
      @cards << deck.cards[0]
      deck.cards.delete_at(0)
    end
  end

  def continue(deck, _hand)
    @cards << deck.cards[0]
    deck.cards.delete_at(0)
  end
end
