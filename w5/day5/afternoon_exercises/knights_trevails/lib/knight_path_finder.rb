require 'byebug'

require_relative '00_tree_node'

class KnightPathFinder
  def initialize(root)
    @root = root
    @considered_positions = [root.value]
  end
  
  MOVES = [
    [1, 2], 
    [-1, -2], 
    [-1, 2], 
    [1, -2], 
    [2, 1], 
    [-2, -1], 
    [-2, 1], 
    [2, -1]
  ]  
  
  def self.valid_moves(pos)
    possible_moves = []
    
    current_x, current_y = pos
    MOVES.each do |move|
      new_x, new_y = move
      new_pos = [current_x + new_x, current_y + new_y]
      possible_moves << new_pos
    end
    
    possible_moves.uniq.select { |move| KnightPathFinder.on_board?(move) } 
    #inside of this method, self is the Class. So we could also write self.on_board?
  end
  
  def self.on_board?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end
  
  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end

  def build_move_tree #takes starting pos of a Knight & creates children/parent connections
    que = []
    starting_pos = @root
    que << starting_pos
    until que.empty?
      debugger
      shifted_node = que.shift
      child_positions = self.new_move_positions(shifted_node.value)
      child_positions.each do |position| 
        child_node = PolyTreeNode.new(position)
        que << child_node
        shifted_node.add_child(child_node)
        debugger
      end
    end
  end
end
# possible_move = [pos[0] + 1, pos[1] + 2]
# possible_move = [pos[0] - 1, pos[1] - 2]
# possible_move = [pos[0] - 1, pos[1] + 2]
# possible_move = [pos[0] + 1, pos[1] - 2]
# possible_move = [pos[0] + 2, pos[1] + 1]
# possible_move = [pos[0] - 2, pos[1] - 1]
# possible_move = [pos[0] - 2, pos[1] + 1]
# possible_move = [pos[0] + 2, pos[1] - 1]

node = PolyTreeNode.new([1,1])
kpf = KnightPathFinder.new()
kpf.build_move_tree