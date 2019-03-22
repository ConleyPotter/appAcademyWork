require_relative "cursor"
require "colorize"

class Display

    attr_reader :board
    attr_accessor :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        display = ""
        colors = [:black, :white]
        position_color = colors[0]
        display += "   0  1  2  3  4  5  6  7\n"
        counter = 0
        (0..7).each do |row|
            display << counter.to_s + " "
            (0..7).each do |col|
                position_color = colors[(row + col) % 2]
                position = [row,col]
                piece_in_position = @board[position]
                if @cursor.cursor_pos == position
                    if !piece_in_position.is_a?(NullPiece)
                        display << (" " + piece_in_position.symbol + " ").colorize(:background => :red)
                    else
                        display << "   ".colorize(:background => :red)
                    end
                elsif !piece_in_position.is_a?(NullPiece)
                    display << (" " + piece_in_position.symbol + " ").colorize(:background => position_color)
                else
                    display << "   ".colorize(:background => position_color)
                end 
            end
            counter += 1
            display += "\n"
        end
        print display
    end
end