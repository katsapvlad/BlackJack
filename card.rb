# frozen_string_literal: true

# this class includes some information about the card
class Card
  SUITS_MAP = { 'hearts' => "\u2661", 'clubs' => "\u2667", 'diamons' => "\u2662", 'spades' => "\u2664" }.freeze
  RANKS = { 6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10, 'J' => 2, 'Q' => 3, 'K' => 4, 'A' => 11 }.freeze

  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    """
    +------+
    |#{@value}     |
    | #{@suit}    |
    |  #{@suit}   |
    |   #{@suit}  |
    |     #{@value}|
    +------+
    """
  end

def display_hand(cards)
  strings = cards.map { |c| c.to_s.each_line.to_a }
  first, *rest = *strings
  side_by_side = first.zip *rest
  side_by_side.each do |row|
    row.each { |s| print s.chomp }
    print "\n"
  end
end
end
