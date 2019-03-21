require_relative 'card'

# Represents a deck of playing cards.
class Deck

  # Returns an array of all 52 playing cards.
  def self.all_cards
    face_values = [:king, :queen, :jack, :ten, :nine, :eight,
                   :seven, :six, :five, :four, :three, :deuce, :ace]
    all_cards = []
    face_values.each do |el|
      all_cards << Card.new(:spades, el)
      all_cards << Card.new(:clubs, el)
      all_cards << Card.new(:hearts, el)
      all_cards << Card.new(:diamonds, el)
    end
    all_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if count - n < 0
    taken = []
    while n > 0
      taken << @cards.shift
      n -= 1
    end
    taken
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards.concat(cards)
  end
end
