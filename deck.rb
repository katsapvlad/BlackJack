# frozen_string_literal: true

require './card'

# this class includes some information about the deck
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        card = Card.new(suit, rank)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
