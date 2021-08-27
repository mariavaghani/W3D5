require_relative 'polytree'

class KnightPathFinder
  
  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
  end

  def self.valid_moves(pos)
    x, y = pos
    valid_moves_arr = [
    [x + 2, y + 1],
    [x + 2, y - 1],

    [x - 2, y + 1],
    [x - 2, y - 1],

    [x + 1, y + 2],
    [x - 1, y + 2],

    [x + 1, y - 2],
    [x - 1, y - 2]
    ]
    valid_moves_arr.select! { |move| move.all? { |ele| ele.between?(0,7) } }
    
  end



  def build_move_tree
    
  end
end


if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  p KnightPathFinder.valid_moves([0,0])
  p KnightPathFinder.valid_moves([3,5])

end