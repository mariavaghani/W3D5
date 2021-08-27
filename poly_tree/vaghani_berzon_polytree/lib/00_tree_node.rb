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








end