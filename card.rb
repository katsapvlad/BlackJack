# frozen_string_literal: true

# this class includes some information about the card
class Card
  SUITS_MAP = { 'hearts' => "\u2661", 'clubs' => "\u2667", 'diamons' => "\u2662", 'spades' => "\u2664" }.freeze
  RANKS = { 6 => 6, 7 => 7, 8 => 8, 9 => 9, "\u2469" => 10, 'J' => 2, 'Q' => 3, 'K' => 4, 'A' => 11 }.freeze

  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def open
    "
    --------
    |#{@value}     |
    | #{@suit}    |
    |  #{@suit}   |
    |   #{@suit}  |
    |     #{@value}|
    --------
    "
  end

  def hide
    "
    --------
    |      |
    |      |
    |      |
    |      |
    |      |
    --------
    "
  end

  def self.display_hand(cards, message)
    puts message
    strings = cards.map { |c| c.open.each_line.to_a }
    display(strings)
  end

  def self.display_hidden_hand(cards, message)
    puts message
    strings = cards.map { |c| c.hide.each_line.to_a }
    display(strings)
  end

  def self.display(strings)
    first, *rest = *strings
    side_by_side = first.zip(*rest)
    side_by_side.each do |row|
      row.each { |s| print s.chomp }
      print "\n"
    end
  end
end
