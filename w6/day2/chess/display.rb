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
        rows = @board.rows
        # debugger
        display = ""
        rows.each.with_index do |row, row_idx|
            row.each.with_index do |col, col_idx|
                curr = rows[row_idx][col_idx]
                if @cursor.cursor_pos == [row_idx, col_idx]
                    if !curr.is_a?(NullPiece)
                        display << " ".colorize(:background => :white) + "\u{2654}" + " ".colorize(:background => :white)
                    end
                    display << "   ".colorize(:background => :purple)
                elsif !curr.is_a?(NullPiece)
                    display << " " + "\u{2654}" + " "
                elsif row_idx % 2 == 0
                    display << "   ".colorize(:background => :white)
                else
                    display << "   ".colorize(:background => :black)
                end

            end
            display += "\n"
        end
        # debugger
        print display
    end
end