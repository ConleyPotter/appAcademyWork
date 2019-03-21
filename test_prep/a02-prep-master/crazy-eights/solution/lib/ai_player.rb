# Represents a computer Crazy Eights player.
class AIPlayer
  attr_reader :cards

  # Creates a new player and deals them a hand of eight cards.
  def self.deal_player_in(deck)
    AIPlayer.new(deck.take(8))
  end

  def initialize(cards)
    @cards = cards
  end

  # Returns the suit the player has the most of; this is the suit to
  # switch to if player gains control via eight.
  def favorite_suit
    suit_counts = Hash.new(0)
    cards.each { |card| suit_counts[card.suit] += 1 }
    favorite_suit, _ = suit_counts.max_by { |k, v| v }
    favorite_suit
  end

  # Plays a card from hand to the pile, removing it from the hand. Use
  # the pile's `#play` and `#play_eight` methods.
  def play_card(pile, card)
    fail 'cannot play card outside your hand' unless cards.include?(card)

    if card.value == :eight
      pile.play_eight(card, favorite_suit)
    else
      pile.play(card)
    end

    cards.delete(card)
  end

  # Draw a card from the deck into player's hand.
  def draw_from(deck)
    cards.concat(deck.take(1))
  end

  # Choose any valid card from the player's hand to play; prefer
  # non-eights to eights (save those!). Return nil if no possible
  # play. Use `Pile#valid_play?` here; do not repeat the Crazy Eight
  # rules written in the `Pile`.
  def choose_card(pile)
    cards.find { |card| card.value != :eight && pile.valid_play?(card) } ||
      cards.find { |card| card.value == :eight }
  end

  # Try to choose a card; if AI has a valid play, play the card. Else,
  # draw from the deck and try again until there is a valid play.
  # If deck is empty, pass.
  def play_turn(pile, deck)
    chosen_card = choose_card(pile)

    until chosen_card || deck.empty?
      draw_from(deck)
      chosen_card = choose_card(pile)
    end

    play_card(pile, chosen_card) if chosen_card
  end
end
