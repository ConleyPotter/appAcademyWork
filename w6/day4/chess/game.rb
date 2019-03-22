require_relative "display"

class Game 
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @cursor = @display.cursor
    end

    def display_test
        while true
            # sleep 1
            # puts `clear`
            @display.render
            @cursor.get_input
        end
    end

    def move_knight_test
        @display.render
        @board.move_piece([7,1],[5,2])
        @display.render
        @board.move_piece([0,6],[2,5])
        @display.render
    end

    def move_pawn_test
        @display.render
        @board.move_piece([1,0], [3,0])
        @display.render
        # move the pawn out of the bishop's way
        @board.move_piece([1,1], [3,1])
        @display.render
    end

    def move_every_piece
        move_knight_test
        move_pawn_test
        # move rook
        @board.move_piece([0,0], [2,0])
        @display.render
        move_bishop

        # move blue knight
        @board.move_piece([0,1],[2,2])
        @display.render

        # move pawn out of Queen's way
        @board.move_piece([1,4],[3,4])
        @display.render

        # move Queen around
        @board.move_piece([0,4],[2,4])
        @display.render

        # move pawn out of King's way
        @board.move_piece([1,3],[3,3])
        @display.render

        # move king
        @board.move_piece([0,3],[1,3])
        @board.move_piece([1,3],[1,4])
        @display.render
    end


    def move_bishop
        @board.move_piece([0,2],[1,1])
        @display.render
    end

    def attack
        move_every_piece
        # knight takes pawn
        @board.move_piece([5,2],[3,1])
        @display.render

        # take the queen
        @board.move_piece([3,1], [2,3])
        @display.render
    end

    def check_checker
        attack
        # move the knight away
        @board.move_piece([2,3], [4,2])
        @display.render
        @board.in_check?(:black)

        # move king into check
        @board.move_piece([1,4], [2,3])
        @display.render

        @board.in_check?(:black)

    end
end

