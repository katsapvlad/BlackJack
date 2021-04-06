# frozen_string_literal: true

require './card'

# this class includes some information about the deck
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS_MAP.values.each do |suit|
      Card::RANKS.keys.each do |value|
        card = Card.new(suit, value)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
