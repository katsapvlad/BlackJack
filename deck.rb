# frozen_string_literal: true

require './card'

# this class includes some information about the deck
class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS_MAP.each do |suit_key, suit_value|
      Card::RANKS.each do |rank_key, rank_value|
        card = Card.new(suit_value, rank_key)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
