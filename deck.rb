# frozen_string_literal: true

require './card'

# this class includes some information about the deck
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS_MAP.each_value do |suit|
      Card::RANKS.each_key do |value|
        card = Card.new(suit, value)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
