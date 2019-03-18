require_relative 'tic_tac_toe'

class TicTacToeNode
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    game_states = []
    @board.rows.each do |row|
      row.map { |el| el.empty? ? (:x && @prev_move_pos = el) : el }
      @next_mover_mark += 1 
    end
    game_states
  end

end
