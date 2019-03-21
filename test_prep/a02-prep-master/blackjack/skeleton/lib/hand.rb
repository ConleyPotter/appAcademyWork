require_relative "deck"

class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    deal = deck.take(2)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = Hand.deal_from(cards)
  end

  def points
  end

  def busted?
  end

  def hit(deck)
  end

  def beats?(other_hand)
  end

  def return_cards(deck)
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
