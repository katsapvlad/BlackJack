# frozen_string_literal: true

require './deck'

# this class includes some information about my cards
class Player
  attr_accessor :name, :cards, :score

  def initialize(name)
    @name = name
    @score = 0
    @cards = []
  end

  def take_card(deck)
    @cards << deck.cards[0]
    deck.cards.delete_at(0)
    @score += Card::RANKS[@cards[-1].value]
  end
end
