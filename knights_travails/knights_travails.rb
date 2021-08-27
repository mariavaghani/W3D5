require_relative 'polytree'

class KnightPathFinder
  attr_reader :root_node
  
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
    return_moves = KnightPathFinder.valid_moves(pos).reject { |moves| @considered_positions.include?(moves)}
    @considered_positions += return_moves
    return_moves
  end

  def build_move_tree

    queue = [@root_node]

    until queue.empty?
      node = queue.shift
      new_moves_arr = new_move_positions(node.value)
      new_moves_arr.each { |move| node.add_child(PolyTreeNode.new(move)) }
      node.children.each { |child| queue << child }
    end


# queue = [self]
    # until queue.empty?
    #   node = queue.shift
    #   return node if node.value == target_value
    #   node.children.each { |child| queue << child } 
    # end

    
  end

end


if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
#   p KnightPathFinder.valid_moves([0,0])
  p kpf
  # p kpf.new_move_positions([0,0])

  kpf.build_move_tree
  p kpf.root_node.children[0].children[0]

end