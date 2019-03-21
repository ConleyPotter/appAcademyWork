require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
  end

  def initialize(cards = Deck.all_cards)
  end

  # Returns the number of cards in the deck.
  def count
  end

  def empty?
  end

  # Takes `n` cards from the top of the deck (front of the cards array).
  def take(n)
  end

  # Returns an array of cards to the bottom of the deck (back of the cards array).
  def return(new_cards)
  end
end
