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

  def delete(value, root = @root)
    if (value < root.value)
      root.left_node = delete(value, root.left_node)
      return root
    elsif (value > root.value)
      root.right_node = delete(value, root.right_node)
      return root
    end

    if (root.right_node.nil? && root.left_node.nil?)
      return nil
    elsif (!(root.right_node.nil?) && root.left_node.nil?)
      return root.right_node
    elsif (root.right_node.nil? && !(root.left_node.nil?))
      return root.left_node
    elsif (!(root.right_node.nil?) && !(root.left_node.nil?))
      successor = minRoot(root.right_node)
      temp_right = delete(successor.value, root.right_node)
      successor.left_node = root.left_node
      successor.right_node = temp_right

      # Check just in case removing root of entire tree
      if (@root.value == value)
        @root = successor
        return
      end

      return successor
    end
  end

  def minRoot(root = @root)
    if (root.left_node.nil?)
      return root
    else
      minRoot(root.left_node)
    end
  end

  def minValue(root = @root)
    if (root.left_node.nil?)
      return root.value
    else
      minValue(root.left_node)
    end
  end

  def maxValue(root = @root)
    if (root.right_node.nil?)
      return root.value
    else
      maxValue(root.right_node)
    end
  end

  def left_child?(node)
    if (node.left_node.nil?)
      return false
    else  
      return true
    end
  end

  def right_child?(node)
    if (node.right_node.nil?)
      return false
    else 
      return true
    end
  end

  def find(value, root = @root)
    # Traverses tree using recursion to return node with value specified
    if (value < root.value)
      if (!root.left_node.nil?)
        find(value, root.left_node)
      else 
        return "Value: #{value} does not exist in the tree"
      end
    elsif (value > root.value)
      if (!root.right_node.nil?)
        find(value, root.right_node)
      else
        return "Value: #{value} does not exist in the tree"
      end
    elsif (value == root.value)
      return root
    end
  end

  def level_order(queue = [@root])
    # Code if no block given, traverse and return array of values
    if (!block_given?)
      opt_array = []
      while (queue != [])
        current_node = queue.shift
        if !current_node.left_node.nil?
          queue << current_node.left_node
        end
        if !current_node.right_node.nil?
          queue << current_node.right_node
        end
        opt_array << current_node.value
      end
      return opt_array
    end

    # If block is given, traverse and yield each node in level order to block
    while (queue != [])
      current_node = queue.shift
      if !current_node.left_node.nil?
        queue << current_node.left_node
      end
      if !current_node.right_node.nil?
        queue << current_node.right_node
      end
      yield(current_node)
    end
  end

  def inorder(current_node = @root, array = [], &block)
    if (block_given?)
      if (left_child?(current_node))
        left_node = inorder(current_node.left_node, [], &block)
      end
      yield(current_node)
      if (right_child?(current_node))
        right_node = inorder(current_node.right_node, [], &block)
      end
    else
      if (left_child?(current_node))
        left_node = inorder(current_node.left_node, array, &block)
      end
      array << current_node.value
      if (right_child?(current_node))
        right_node = inorder(current_node.right_node, array, &block)
      end
      return array
    end
  end

  def preorder(current_node = @root, array = [], &block)
    if (block_given?)
      yield(current_node)
      if (left_child?(current_node))
        left_node = preorder(current_node.left_node, [], &block)
      end
      if (right_child?(current_node))
        right_node = preorder(current_node.right_node, [], &block)
      end
    else
      array << current_node.value
      if (left_child?(current_node))
        left_node = preorder(current_node.left_node, array, &block)
      end
      if (right_child?(current_node))
        right_node = preorder(current_node.right_node, array, &block)
      end
      return array
    end
  end

  def postorder(current_node = @root, array = [], &block)
    if (block_given?)
      if (left_child?(current_node))
        left_node = postorder(current_node.left_node, [], &block)
      end
      if (right_child?(current_node))
        right_node = postorder(current_node.right_node, [], &block)
      end
      yield(current_node)
    else
      if (left_child?(current_node))
        left_node = postorder(current_node.left_node, array, &block)
      end
      if (right_child?(current_node))
        right_node = postorder(current_node.right_node, array, &block)
      end
      array << current_node.value
      return array
    end
  end

  def height(node = @root)
    left_height = 0
    right_height = 0
    if (left_child?(node))
      left_height = height(node.left_node)
      left_height += 1
    end
    if (right_child?(node))
      right_height = height(node.right_node)
      right_height += 1
    end
    if (left_height > right_height)
      return left_height
    else
      return right_height
    end
  end

  def depth(node = @root, current_node = @root)
    depth = 0
    while (node.value != current_node.value)
      if (node.value < current_node.value)
        current_node = current_node.left_node
        depth += 1
      elsif (node.value > current_node.value)
        current_node = current_node.right_node
        depth += 1
      end
    end
    return depth
  end

  def balanced?
    left_height = height(@root.left_node)
    right_height = height(@root.right_node)

    if (left_height - right_height >= -1 && left_height - right_height <= 1)
      return true
    else
      return false
    end
  end

  def rebalance!
    if (!balanced?)
      return self.initialize(self.inorder)
    else
      puts "Tree is already balanced!"
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end