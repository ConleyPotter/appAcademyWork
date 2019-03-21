require 'byebug'
require_relative "piece"

class Board

    attr_reader :rows
    def initialize
        @rows = Array.new(8, nil) { Array.new(8, nil) }
        starting_rows = [0,1,6,7]
        (0..7).each do |x|
            if starting_rows.include?(x)
                (0..7).each do |y|
                    if x == 0
                        case y
                        when 0
                            self[[x,y]] = Rook.new(:black, self, [x,y])
                        when 7
                            self[[x,y]] = Rook.new(:black, self, [x,y])
                        when 1
                            self[[x,y]] = Knight.new(:black, self, [x,y])
                        when 6
                            self[[x,y]] = Knight.new(:black, self, [x,y])
                        when 2
                            self[[x,y]] = Bishop.new(:black, self, [x,y])
                        when 5
                            self[[x,y]] = Bishop.new(:black, self, [x,y])
                        when 3
                            self[[x,y]] = Queen.new(:black, self, [x,y])
                        when 4
                            self[[x,y]] = King.new(:black, self, [x,y])
                        end
                    elsif x == 1
                        self[[x,y]] = Pawn.new(:black, self, [x,y])
                    elsif x == 7
                        case y
                        when 0
                            self[[x,y]] = Rook.new(:white, self, [x,y])
                        when 7
                            self[[x,y]] = Rook.new(:white, self, [x,y])
                        when 1
                            self[[x,y]] = Knight.new(:white, self, [x,y])
                        when 6
                            self[[x,y]] = Knight.new(:white, self, [x,y])
                        when 2
                            self[[x,y]] = Bishop.new(:white, self, [x,y])
                        when 5
                            self[[x,y]] = Bishop.new(:white, self, [x,y])
                        when 4
                            self[[x,y]] = Queen.new(:white, self, [x,y])
                        when 3
                            self[[x,y]] = King.new(:white, self, [x,y])
                        end
                    else
                        self[[x,y]] = Pawn.new(:white, self, [x,y])
                    end
                end
            else
                (0..7).each do |y|
                    self[[x,y]] = NullPiece.instance
                end
            end
        end
    end

    def [](position)
        x, y = position
        @rows[x][y]
    end

    def []=(position, value)
        x,y = position
        @rows[x][y] = value
    end

    # Move piece is a parent method, it calls a lot of other methods to make sure
    # that that the pieces at both the start and end positions are mutating
    # their pos instance variables, and to make sure the board updates where 
    # it is holding the piece

    def move_piece(start_pos, end_pos)
        raise "That position is out of bounds" if !end_pos[0].between?(0,7) || !end_pos[1].between?(0,7)
        # this calls the method valid_move below, not to be confused with
        # Piece's valid_moves method
        if valid_move?(start_pos, end_pos)
            start_pos_piece = self[start_pos]
            end_pos_piece = self[end_pos]
            if start_pos_piece.valid_moves.keys.include?(end_pos)
                self[start_pos] = end_pos_piece
                self[end_pos] = start_pos_piece
                start_pos_piece.pos = [end_pos]
                end_pos_piece.pos = [start_pos]
            else
                raise "That's not a valid move!"
            end
        else
            raise "That's not a valid move!"
        end
    end

    # valid move checks two things, if the move that is trying to be made
    # would bring the piece off the board, and if that piece is
    # trying to move to a position that already has a piece of its color
    def valid_move?(start_pos, end_pos)
        # debugger
        starting_x, starting_y = start_pos
        ending_x, ending_y = end_pos
        
        return false if !ending_x.between?(0,7) || !ending_y.between?(0,7)

        # return false if !@rows[ending_x][ending_y].is_a?(NullPiece)
        true
    end

    # def in_check?(color)
    #     king_pos = find_king
    #     remaining_opponent_pieces = []
    #     (0..7).each do |row|
    #         (0..7).each do |col|
    #             if !self[[row, col]].is_a?(NullPiece) self[[row,col]].color != color
    #                 remaining_opponent_pieces << self[[row,col]]
    #             end
    #         end
    #     end
    #     remaining_opponent_pieces.any? do |piece|
    #         piece.moves.each { |move| return true if move == king_pos }
    #     end
    # end

    # def find_king(color)
    #     (0..7).each do |row|
    #         (0..7).each do |col|
    #             if self[[row,col]].is_a?(King) && self[[row,col]].color == color
    #                 return [row,col]
    #             end
    #         end
    #     end
    # end

    # def pieces
        
    # end
end
