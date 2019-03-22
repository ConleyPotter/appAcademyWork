require 'singleton'

class Piece
    
    attr_accessor :pos
    attr_reader :color
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end
    
    def to_s
        
    end
    
    def empty?
        
    end
    
    
    
    def valid_moves
        valid = []
        if self.is_a?(Pawn)
            valid += move_dirs
        else
            self.moves.each { |move| valid << move }
        end
        debugger
        valid
    end
    
    def pos=(val)
        @pos = val
    end
    
    def symbol
        SYMBOLS[color]
    end
    
    private
    def move_into_check(end_pos)
        
    end
    
end


module Stepable
    def moves
        moves = []
        move_diffs.each do |diff| 
            end_pos = [(@pos[0] + diff[0]), (@pos[1] + diff[1])]
            next if !end_pos[0].between?(0, 7) || !end_pos[1].between?(0,7)
            moves << end_pos unless @board[end_pos].color == self.color
        end
        moves
    end
    
    private
    def move_diffs
        raise "You don't want to be here!"
    end
end

module Slideable
    HORIZANTAL_DIRS = [
                        [1,0],
                        [0,1],
                        [-1,0],
                        [0,-1]
                                ]

    DIAGONAL_DIRS =   [
                        [1,1],
                        [-1,1],
                        [1,-1],
                        [-1,-1]
                                ] 

    def moves
        moves = []
        move_dirs.each  do |dir|
            grown = grow_unblocked_moves_in_dir(dir[0], dir[1]) 
            moves << grown unless @board[grown].color == self.color
        end
        moves
    end

    private
    def grow_unblocked_moves_in_dir(dx, dy)
        # don't ever mutate dx or dy, they just tell which direction to go in!
        new_pos = [@pos[0] + dx, @pos[1] + dy]
        while @board[new_pos].is_a?(NullPiece)
            new_pos[0] += dx
            new_pos[1] += dy
        end
        new_pos[0] -= dx
        new_pos[1] -= dy
        new_pos
    end
end


class Knight < Piece
    include Stepable

    def symbol
        return @color == :white ? "♘".colorize(:color => :green) : "♞".colorize(:color => :blue)
    end
    
    protected
    def move_diffs
        [
            [2,1],
            [-2,1],
            [2,-1],
            [-2,-1],
            [1,2],
            [-1,2],
            [1,-2],
            [-1,-2]
        ]
    end
end

class King < Piece
    include Stepable
    
    def symbol
        return @color == :white ? "♔".colorize(:color => :green) : "♚".colorize(:color => :blue)
    end
    
    protected
    def move_diffs
        [
            [1,0],
            [0,1],
            [0,-1],
            [-1,0],
            [1,1],
            [-1,1],
            [-1,-1],
            [1,-1]
        ]
    end
end

class Rook < Piece
    include Slideable
    def symbol
        @color == :white ? "♖".colorize(:color => :green) : "♜".colorize(:color => :blue)
    end
    
    protected
    def move_dirs
        HORIZANTAL_DIRS
    end
end

class Bishop < Piece
    include Slideable
    def symbol
        @color == :white ? "♗".colorize(:color => :green) : "♝".colorize(:color => :blue)
    end
    
    # protected
    def move_dirs
        DIAGONAL_DIRS
    end
end

class Queen < Piece
    include Slideable
    def symbol
        @color == :white ? "♕".colorize(:color => :green) : "♛".colorize(:color => :blue)
    end
    
    protected
    def move_dirs
        HORIZANTAL_DIRS + DIAGONAL_DIRS
    end
end

class Pawn < Piece
    def symbol
        @color == :white ? "♙".colorize(:color => :green) : "♟".colorize(:color => :blue)    
    end
    
    def move_dirs
        moves = []
        if at_start_row?
            forward_steps.each do |step|
                moves << [(step[0] + @pos[0]), @pos[1]]
            end
        else
            moves << [forward_steps[0][0] + @pos[0], forward_steps[0][1] + @pos[1]]
        end
        moves.select { |move| @board.valid_move?(@pos, move) && @board[move].color != self.color }
    end

    private
    def at_start_row?
        self.color == :black ? pos.first == 1 : pos.first == 6
    end
    
    def forward_steps
        [
            [forward_dir,0],
            [forward_dir * 2,0]
        ]
    end

    def forward_dir
        self.color == :black ? 1 : -1
    end

    def side_attack

    end
end

class NullPiece < Piece
    include Singleton

    def initialize
        @color = :none
    end

end