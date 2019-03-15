require_relative "board"
require_relative "player"

class Battleship

  attr_reader :board, :player

  def initialize(n)
    @player = Player.new
    @board = Board.new(n)
    @remaining_misses = @board.size / 2
  end

  def start_game
    @board.place_random_ships
    print @board.num_ships 
    print " ships on the board\n"
    @board.print
  end

  def lose?
    if @remaining_misses <= 0
      print 'you lose'
      return true
    end
    false
  end

  def win?
    num_ships_remaining = @board.num_ships
    if num_ships_remaining <= 0
      print 'you win'
      return true
    end
    false
  end

  def game_over?
    if self.win? || self.lose?
      return true
    end
    false
  end

  def turn
    move = @player.get_move
    success = @board.attack(move)
    if !success
      @remaining_misses -= 1
    end
    @board.print
    print @remaining_misses
    print " remaining incorrect guesses \n"
  end
end
