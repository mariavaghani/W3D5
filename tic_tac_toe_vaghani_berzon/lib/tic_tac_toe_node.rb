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

require "byebug"
  def losing_node?(evaluator) 
    
    return true if board.over? && board.winner == next_mover_mark
    return false if board.over? && board.winner == evaluator
    return false if board.over? && board.tied?

    if evaluator == next_mover_mark
      children.all? { |child_node| child_node.losing_node?(evaluator) }
    else
      children.any? { |child_node| child_node.losing_node?(evaluator)}
    end
  end

   
  def winning_node?(evaluator)
    return true if board.over? && board.winner == evaluator
    return false if board.over? && board.winner == next_mover_mark
    return false if board.over? && board.tied? 

    if evaluator == next_mover_mark
      children.all? { |child_node| child_node.winning_node?(evaluator) }
    else
      children.any? { |child_node| child_node.winning_node?(evaluator)}
    end
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
  # b = Board.new
  # test = TicTacToeNode.new(b, :x, nil)
  # p test.children
  node = TicTacToeNode.new(Board.new, :x)
  node.board[[0, 0]] = :o
  node.board[[2, 2]] = :o
  node.board[[0, 2]] = :o
  p node.losing_node?(:x) # => true
  # p node.losing_node?(:o)  # => false



  # opponent = TicTacToeNode.new(Board.new, :o)
  # opponent.board[[0, 0]] = :x
  # opponent.board[[0, 1]] = :x
  # opponent.board[[0, 2]] = :o
  # opponent.board[[1, 1]] = :o
  # opponent.board[[1, 0]] = :x
  # p opponent.losing_node?(:x) # => true


  # cats_los = TicTacToeNode.new(Board.new, :o)
  # cats_los.board[[0, 0]] = :x
  # cats_los.board[[0, 1]] = :o
  # cats_los.board[[0, 2]] = :x
  # cats_los.board[[1, 0]] = :o
  # cats_los.board[[1, 1]] = :x
  # cats_los.board[[1, 2]] = :o
  # cats_los.board[[2, 0]] = :o
  # cats_los.board[[2, 1]] = :x
  # p cats_los.losing_node?(:o) # => false

  
end

   # recursive case when it is our turn
      # return children.all? do |child_node| 
      #   p child_node.board
      #   child_node.children.any? do |nested_node|
      #     nested_node.losing_node?(evaluator)
      #   end 
    # else
      # It is the opponent's turn, and one of the children nodes is a losing node
    #   #  for the player
    #   return children.none? do |child_node| 
    #     # p child_node.board
    #     child_node.losing_node?(next_mover_mark)
    #   end
    # end
  

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
