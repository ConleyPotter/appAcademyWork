class Piece

    attr_accessor :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

end

class NullPiece < Piece

end