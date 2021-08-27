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
    valid_moves_arr.select { |move| move.all? { |ele| ele.between?(0,7) } }
    
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos).reject { |moves| @considered_positions.include?(moves)}
  end

  def build_move_tree
    new_moves_arr = self.new_move_positions(@root_node.value)

    # queue = [self]
    # until queue.empty?
    #   node = queue.shift
    #   return node if node.value == target_value
    #   node.children.each { |child| queue << child } 
    # end

    until new_moves_arr.empty?
      node = new_moves_arr.shift
      new_moves_arr.each { |move| node.add_child(PolyTreeNode.new(move)) }


    end
  end

end


if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
#   p KnightPathFinder.valid_moves([0,0])
  p kpf
  # p kpf.new_move_positions([0,0])

  kpf.build_move_tree
  p kpf

end