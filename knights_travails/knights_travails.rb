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

  end


  def find_path(end_pos)
    @root_node.dfs(end_pos)
  end

  # def trace_path_back(node)
  #   path = []
  #   until node.parent
  #     path += node.parent
  #     node = node.parent
  #   end
  # end

end


if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
#   p KnightPathFinder.valid_moves([0,0])
  p kpf
  # p kpf.new_move_positions([0,0])

  kpf.build_move_tree
  # p kpf.root_node.children[0].children[0]

  p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
  p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

end