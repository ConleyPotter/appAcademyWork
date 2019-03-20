require 'byebug'
require_relative "piece"

class NoPieceToMoveError < RuntimeError
end

class CannotMoveToPositionError < RuntimeError
end

class Board

    attr_reader :rows
    def initialize
        null = NullPiece.new(nil, nil, nil)
        @rows = Array.new(10, nil) { Array.new(10, nil) }
        starting_rows = [0,1,8,9]
        @rows.each.with_index do |x, idx_x|
            # debugger
            if starting_rows.include?(idx_x)
                x.each.with_index do |y, idx_y|
                    if idx_x == 0 || idx_x == 1
                        @rows[idx_x][idx_y] = Piece.new(:black, nil, [idx_x,idx_y])
                    else
                        @rows[idx_x][idx_y] = Piece.new(:white, nil, [idx_x,idx_y])
                    end
                end
            else
                x.each.with_index do |y, idx_y|
                    @rows[idx_x][idx_y] = NullPiece.new(nil, nil, [idx_x, idx_y])
                end
            end
        end
    end

    def move_piece(start_pos, end_pos)
        starting_x, starting_y = start_pos
        raise "That position is out of bounds" if !starting_x.between?(0,7) || !starting_y.between?(0,7)

        ending_x, ending_y = end_pos
        raise "That position is out of bounds" if !ending_x.between?(0,7) || !ending_y.between?(0,7)
        
        if valid_move?(start_pos, end_pos)
            piece_being_moved = @rows[starting_x][starting_y]
            @rows[starting_x][starting_y] = NullPiece.new(nil,nil,nil)
            @rows[ending_x][ending_y] = piece_being_moved
            piece_being_moved.pos = [ending_x, ending_y]
        else
            raise "That's not a valid move!"
        end
    end

    def valid_move?(start_pos, end_pos)
        # debugger
        starting_x, starting_y = start_pos
        ending_x, ending_y = end_pos
        
        return false if !starting_x.between?(0,7) || !starting_y.between?(0,7)
        return false if !ending_x.between?(0,7) || !ending_y.between?(0,7)
        # return false if @rows[starting_x][starting_y].is_a?(NullPiece)
        # return false if !@rows[ending_x][ending_y].is_a?(NullPiece)
        true
    end
end
