class KnightPathFinder
  def initialize(root)
    @root = root
    @considered_positions = [root.value]
  end

  def self.valid_moves(pos)
    possible_moves = []

    

    8.times do |move|
      possible_move = []
      possible_move << pos[0] + 1
      possible_move << pos[1] + 2
      possible_moves << possible_move
    end

  end

  def new_move_positions(pos)
    new_positions = valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end

end