require 'pry-byebug'
class Node
  include Comparable
  attr_accessor :value, :left_node, :right_node

  def <=>(other_node)
    self.value <=> other_node.value
  end

  def initialize(value = nil)
    @value = value
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

  def insert(value)
    new_node = Node.new(value)
    tree_node = @root
    inserted = false

    # while the node is not inserted
    while (!inserted)
      if (new_node > tree_node)
        # if right_node is empty, insert node
        if (tree_node.right_node.nil?)
          tree_node.right_node = new_node
          inserted = true
        # else, traverse tree further
        else
          tree_node = tree_node.right_node
        end
      elsif (new_node < tree_node)
        # left_node is empty, insert node
        if (tree_node.left_node.nil?)
          tree_node.left_node = new_node
          inserted = true
        # else, traverse tree further
        else
          tree_node = tree_node.left_node
        end
      end
    end
  end

  def minValue(root = @root)
    if (root.left_node.nil?)
      return root
    else
      min = minValue(root.left_node)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end