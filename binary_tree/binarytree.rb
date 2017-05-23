class BinaryTree
  require_relative 'node'

  def initialize arr
  	@tree = build_tree(arr)
  end

  def build_tree arr
  	if arr.length <= 1
  	  return Node.new(arr[0])
  	end
  	midpoint = arr.length/2
  	node = Node.new(arr[midpoint])
  	node.left = build_tree(arr[0..midpoint - 1])
  	node.right = build_tree(arr[midpoint + 1.. arr.length])
  	return node
  end

  def format tree
  	return if tree.nil?
  	puts tree.value
  	format tree.left
  	format tree.right
  end

  def to_s 
  	format @tree
  end
end

tree = BinaryTree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.to_s