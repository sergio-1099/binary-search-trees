class Node
  include Comparable
  attr_accessor :value, :left_node, :right_node

  def <=>(other_node)
    self.value <=> other_node.value
  end

  def initialize
    @value = nil
    @left_node = nil
    @right_node = nil
  end
end