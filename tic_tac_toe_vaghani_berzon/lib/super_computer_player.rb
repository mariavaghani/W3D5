require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    
    current_board_root = TicTacToeNode.new(game.board, mark)
    p mark
    possible_moves = current_board_root.children.select { |child_node| child_node.winning_node?(:x) }
    possible_moves[0]
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
