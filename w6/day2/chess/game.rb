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
        @board.move_piece([0,1],[2,2])
        sleep 1
        @display.render
    end

end

game = Game.new
