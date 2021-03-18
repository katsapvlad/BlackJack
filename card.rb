# frozen_string_literal: true

# this class includes some information about the card
class Card
  SUITS = %w[Club Diamond Heart Spade].freeze
  RANKS = %w[6 7 8 9 10 J Q K A].freeze

  attr_accessor :suit, :rank, :value

  def initialize(suit, rank)
    @suit = suit_cases(suit)
    @rank = rank
    @value = rank_cases(rank)
  end

  private

  def suit_cases(suit)
    case suit
    when 'Club' then "\u2667"
    when 'Diamond' then "\u2662"
    when 'Heart' then "\u2661"
    when 'Spade' then "\u2664"
    else 1
    end
  end

  def rank_cases(rank)
    case rank
    when 6..10 then rank
    when 'J' then 2
    when 'Q' then 3
    when 'K' then 4
    else 1
    end
  end
end
