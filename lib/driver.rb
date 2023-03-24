require_relative('binary_search_tree')

array = (Array.new(15) { rand(1..100) })
tree = Tree.new(array)

tree.pretty_print
puts "That the tree is balanced is #{tree.balanced?}"

print "\nLevel Order: "
tree.level_order { |node| print "#{node.value} " }
print "\nPreorder: "
tree.preorder { |node| print "#{node.value} "}
print "\nPostorder: "
tree.postorder { |node | print "#{node.value} "}
print "\nInorder: "
tree.inorder { |node| print "#{node.value} " }

puts "\n\nUnbalancing..."
tree.insert(101)
tree.insert(200)
tree.insert(155)
tree.insert(132)

tree.pretty_print
puts "That the tree is balanced is #{tree.balanced?}"

puts "\nRebalancing..."
tree.rebalance!
tree.pretty_print

puts "That the tree is balanced is #{tree.balanced?}"

print "\nLevel Order: "
tree.level_order { |node| print "#{node.value} " }
print "\nPreorder: "
tree.preorder { |node| print "#{node.value} "}
print "\nPostorder: "
tree.postorder { |node | print "#{node.value} "}
print "\nInorder: "
tree.inorder { |node| print "#{node.value} " }
puts ""