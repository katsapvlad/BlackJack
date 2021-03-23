# frozen_string_literal: true

# this class includes some information about the card
class Card
  SUITS = %w[Club Diamond Heart Spade].freeze
  RANKS = %w[6 7 8 9 10 J Q K A].freeze

  attr_accessor :suit, :rank, :value

  def initialize(suit, rank)
    @suit = suit_cases(suit)
    @rank = rank_cases(rank)
    @value = value_cases(rank)
  end

  def show_card(hand)
    puts hand.size
  end

  def my_ace_validation(card)
    return unless card.value == 1

    puts "\nYou have an Ace! Choose a value: 1(default) or 11"
    answ = gets.to_i
    card.value = 11 if answ == 11
  end

  def opp_ace_validation(card, opp_total_value)
    return unless card.value == 1

    card.value = 11 if opp_total_value < 11
  end

  private

  def suit_cases(suit)
    case suit
    when 'Club' then "\u2667"
    when 'Diamond' then "\u2662"
    when 'Heart' then "\u2661"
    when 'Spade' then "\u2664"
    end
  end

  def rank_cases(rank)
    if rank == '10'
      "\u2469"
    else
      rank
    end
  end

  def value_cases(rank)
    case rank
    when '6'..'10' then rank.to_i
    when 'J' then 2
    when 'Q' then 3
    when 'K' then 4
    else 1
    end
  end
end
