class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def parent=(parent_to_add)
    return nil unless parent_to_add
    @parent = parent_to_add
    @parent.children << self unless parent.children.include?(self) || parent == nil
  end
end