# frozen_string_literal: true

require './deck'

# this class includes some information about my cards
class MyCards
  attr_accessor :my_cards

  def initialize
    $deck = Deck.new
    @my_cards = []
    2.times do
      @my_cards << $deck.cards[0]
      $deck.cards.delete_at(0)
    end
  end
end
