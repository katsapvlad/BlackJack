# frozen_string_literal: true

require './deck'

# this class includes some information about my cards
class Player
  attr_accessor :name, :cards, :score

  def initialize(name)
    @name = name
  end

  def take_cards(deck)
    @score = 0
    @cards = []
    2.times do
      @cards << deck.cards[0]
      deck.cards.delete_at(0)
    end
    @cards.each { |card| @score += Card::RANKS[card.value] }
  end

  def continue(deck)
    @cards << deck.cards[0]
    deck.cards.delete_at(0)
    @score += Card::RANKS[@cards[-1].value]
  end
end
