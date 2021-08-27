class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(parent_to_add)
    @parent.children.delete_if { |child| child == self} if parent
    @parent = parent_to_add
    if parent != nil
      @parent.children << self unless parent.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
    @children << child_node unless children.include?(child_node)
  end

  def remove_child(child_node)
    raise "child is not a node" unless children.include?(child_node)
    child_node.parent = nil 
  end


  def dfs(target_value)
    return self if target_value == value
    return nil if children.empty?
    
    children.each do |child|
      child_dfs = child.dfs(target_value)
      
      return child_dfs if child_dfs != nil
    end
    nil
  end

  def bfs(target_value)

    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each { |child| queue << child } 
    end

  end

  def inspect
    { value: value, 
      children: children.map(&:value)
    }.inspect # calls it on a hash
  end
end