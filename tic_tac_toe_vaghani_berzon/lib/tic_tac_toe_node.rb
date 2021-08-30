require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :next_mover_pos 
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
  end


  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    
    board.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        if board.empty?(row_idx, col_idx)
          copy = board.dup
          copy[[row_idx, col_idx]] = next_mover_mark
          @children << TicTacToeNode.new(copy, next_mover_mark)
        end
      end
    end
  end
end
