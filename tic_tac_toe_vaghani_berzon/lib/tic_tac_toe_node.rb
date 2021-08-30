require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
    
  end

  def inspect
    { board: @board, 
      children: @children.map(&:board)
    }.inspect
     # calls it on a hash
  end


  def losing_node?(evaluator) #evaluator == you
    return true if board.winner == next_mover_mark
    return false if board.winner == evaluator
    if evaluator != next_mover_mark
      return children.all? do |child_node| 
        child_node.children.any? do |nested_node|
          nested_node.losing_node?(nested_node.next_mover_mark)
        end 
      end
    else
      children.any? do |child_node| 
        child_node.losing_node?
    end
  end

    # return true if @board.winner != evaluator
    # return true if @children.none? { |child_node| child_node.board.winner == evaluator}
    # return true if board.winner != evaluator && board.won?
    # if evaluator != next_mover_mark
    #   return true if @children.all? do |child_node| 
    #     child_node.children.any? do |nested_child_node|
    #       nested_child_node.board.winner == next_mover_mark 
    #     end
    #   end
    # # else
    # #   return false if @children.all? do |child_node| 
    # #     child_node.children.any? do |nested_child_node|
    # #       nested_child_node.board.winner != next_mover_mark 
    # #     end
    #   # end
    # end  

    # false

    # if evaluator == next_mover_mark
    #   return false if @children.all? { |child_node| child_node.board.winner == evaluator}
    # end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # children = []
    
    board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        if board.empty?([row_idx, col_idx])
          copy = board.dup
          copy[[row_idx, col_idx]] = next_mover_mark
          next_next_mover_mark = next_mover_mark == :x ? :o : :x
          @children << TicTacToeNode.new(copy, next_next_mover_mark, prev_move_pos = [row_idx, col_idx] )
        end
      end 
    end
    @children
  end

end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  test = TicTacToeNode.new(b, :x, nil)
  p test.children

end