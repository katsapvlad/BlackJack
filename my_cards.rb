# frozen_string_literal: true

require './deck'

# this class includes some information about my cards
class MyCards
  attr_accessor :my_cards

  def initialize(deck)
    @my_cards = []
    2.times do
      @my_cards << deck.cards[0]
      deck.cards.delete_at(0)
    end
  end

  def continue(deck, hand)
    @my_cards << deck.cards[0]
    deck.cards.delete_at(0)
    puts 'My cards:'
    show_cards(hand.my_cards)
  end

  def show_cards(hand)
    print ' ' * 10
    hand.size.times { print '--------     ' }
    card(hand)
    print "\n#{' ' * 10}"
    hand.size.times { print '--------     ' }
    puts ' '
  end

  private

  def card(hand)
    print "\n#{' ' * 10}"
    1.upto(hand.size) { |i| print "|#{hand[i - 1].value}     |     " }
    print "\n#{' ' * 10}"
    1.upto(hand.size) { |i| print "| #{hand[i - 1].suit}    |     " }
    print "\n#{' ' * 10}"
    1.upto(hand.size) { |i| print "|  #{hand[i - 1].suit}   |     " }
    print "\n#{' ' * 10}"
    1.upto(hand.size) { |i| print "|   #{hand[i - 1].suit}  |     " }
    print "\n#{' ' * 10}"
    1.upto(hand.size) { |i| print "|     #{hand[i - 1].value}|     " }
  end
end
