require_relative 'null_piece'
require 'singleton'

class Piece

    SYMBOLS = {
        white: {
            King: "\u{2654}",
            Queen: "\u{2655}",
            Rook: "\u{2656}",
            Bishop: "\u{2657}",
            Knight: "\u{2658}",
            Pawn: "\u{2659}"
        },
        black: {
            King: "\u{265A}",
            Queen: "\u{265B}",
            Rook: "\u{265C}",
            Bishop: "\u{265D}",
            Knight: "\u{265E}",
            Pawn: "\u{265F}"
        }
    }

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
        valid = {}
        if self.is_a?(Pawn)
            
        else # Pawn
            moves.each { |move| valid[move] = true }
        end
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
            moves << end_pos
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

    def horizantal_dirs
        HORIZANTAL_DIRS
    end

    def diaganol_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves = []
        if self.is_a?(Rook)
            horizantal_dirs.each do |dir|
                moves << grow_unblocked_moves_in_dir(dir[0], dir[1])  
            end
        else
            diaganol_dirs.each  do |dir|
                moves << grow_unblocked_moves_in_dir(dir[0], dir[1]) 
            end
        end
        moves
    end

    private
    def grow_unblocked_moves_in_dir(dx,dy)
        while @board[@pos + dx].is_a?(NullPiece) && @board[@pos + dy].is_a?(NullPiece)
            dx += 1
            dy += 1
        end
        new_x = @pos[0] + dx
        new_y = @pos[1] + dy
        [new_x, new_y]
    end
end


class Knight < Piece
    include Stepable

    def symbol
        super[:Knight]
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
        super[:King]
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
        SYMBOLS[@color][:Rook]
    end

    protected
    def move_dirs
        horizantal_dirs
    end
end

class Bishop < Piece
    include Slideable
    def symbol
        SYMBOLS[@color][:Bishop]
    end

    # protected
    def move_dirs
        diaganol_dirs
    end
end

class Queen < Piece
    include Slideable
    def symbol
        SYMBOLS[@color][:Queen]
    end

    protected
    def move_dirs
        move_dirs = []
        move_dirs << horizantal_dirs
        move_dirs << diaganol_dirs
        move_dirs
    end
end

class Pawn < Piece
    def symbol
        SYMBOLS[@color][:Pawn]
    end

    def move_dirs
        [
            [1,0],
            [2,0]
        ]
    end

    private
    def at_start_row?
        pos.first == 1
    end

    def forward_dir

    end

    def forward_steps

    end

    def side_attack

    end
end

class NullPiece < Piece
    include Singleton

    # attr_reader :color, :symbol

    def intialize
        # super
        # super nil :all
        # @symbol = "   "
        # @color = :none
    end

end