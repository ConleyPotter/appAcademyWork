require_relative "display"

class Game 
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @cursor = @display.cursor
    end

    def test
        while true
            @display.render
            @cursor.get_input
        end
    end
end