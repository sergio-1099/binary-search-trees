require 'pry-byebug'
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

class Tree
  def initialize(array)
    array = array.sort
    @root = self.build_tree(array)
  end

  def build_tree(array)
    root = nil
    if (array.size == 1)
      leaf = Node.new
      leaf.value = array[0]
      return leaf
    elsif (array == [])
      return nil
    else 
      root = Node.new
      root.value = array[(array.size)/2]
      root.left_node = self.build_tree(array[0..array.size/2-1])
      root.right_node = self.build_tree(array[array.size/2+1..array.size-1])
    end
    return root
  end
end