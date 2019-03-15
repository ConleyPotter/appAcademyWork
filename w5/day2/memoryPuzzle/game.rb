require_relative "board"

class Game

    attr_reader :board

    def initialize
        @board = Board.new()
        @board.populate
    end

    def play
        until @board.won?

          @board.render
          guess_1 = self.make_guess
          card_1 = @board[guess_1]
          @board.reveal(guess_1)
          @board.render
          guess_2 = self.make_guess
          card_2 = @board[guess_2]
          @board.reveal(guess_2)
          @board.render

          if card_1.face_value != card_2.face_value
            card_1.hide
            card_2.hide
          end
        end

        print "You won!"
    end

    def make_guess
        p "Please Enter the Position of the Card You Would Like to Flip (eg. 2,3): "
        guess = gets.chomp
        if self.valid_guess?(guess)
            return guess
        else
            puts "Invalid Guess, try again.. "
            self.make_guess
        end
    end

    def valid_guess?(guess)
        if @board[guess].hidden 
            return true
        end
        false
    end
end

game1 = Game.new()
game1.play
