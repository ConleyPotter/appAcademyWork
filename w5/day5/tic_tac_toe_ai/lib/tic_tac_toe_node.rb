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
    @board.rows.each.with_index do |row, row_counter|
      row.each.with_index do |col, col_counter|
        curr_board = @board[row_counter][col_counter]
        if curr_board.empty?
          board_with_next_move = @board.dup
          new_next_mover_mark = [row_counter, col_counter]
          
          if prev_move_pos.nil?
            
          end
          curr_board = TicTacToeNode.new(board_with_next_move, nil,nil )
        end
      end
    end
  end
end
