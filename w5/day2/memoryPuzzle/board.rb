require 'byebug'
require_relative 'card'

class Board

  attr_reader :grid

  def initialize
    @cards = []
    self.create_card_pairs
    @cards.shuffle!
    @grid = Array.new(4) { [] }
  end

  def create_card_pairs
    unique_cards = 0
    while unique_cards < 8
        possible_card = Card.new()
        if @cards.none? { |card| card == possible_card.face_value }
            @cards << possible_card
            @cards << possible_card.dup
            unique_cards += 1
        end
    end
  end

  def populate
    card_counter = 0

    while card_counter < 16  

      @grid.each.with_index do |ele, idx|
        4.times do |column_position|
          @grid[idx] [column_position] = @cards[column_position + card_counter]
        end
        card_counter += 4
      end

      
    end
  end

  def render
    puts "  0 1 2 3" 
    @grid.each.with_index do |row, idx|
        print idx.to_s + " "
        row.each do |el|
            print el.to_s + " "
        end
        puts "\n"
    end
  end

  def won?
    @cards.none? { |card| card.hidden }
  end

  def reveal(guess_position)
    grid_element = self[guess_position]

    if grid_element.hidden
        grid_element.reveal
        grid_element.face_value
    end
  end

  def [](position)
    row_position = position[0].to_i
    column_position = position[2].to_i
    @grid[row_position] [column_position]
  end

end




# cards = ["A", "A", "C", "C"]

# grid = [ 
#   ["A", "C"], 
#   ["C", "A"] 
# ]

# grid.length # => 5

# board = Board.new()
# board.populate()
# board.render
# board.reveal("1,2")
# board.render
# board.reveal("2,2")
# board.render
# board.reveal("3,2")
# board.render