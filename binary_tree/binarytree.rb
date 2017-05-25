class BinaryTree
  require_relative 'node'

  def initialize arr
  	@root = nil
  	build_tree_unsorted(arr)
  end

  def build_tree_sorted arr
  	if arr.length == 1
  	  return Node.new(arr[0])
  	elsif arr.length < 1
  	  return 
  	end	
  	midpoint = arr.length/2
  	node = Node.new(arr[midpoint])
  	node.left = build_tree_sorted(arr[0..midpoint - 1])
  	node.right = build_tree_sorted(arr[midpoint + 1.. arr.length])
  	return node
  end

  def build_tree_unsorted arr
  	arr.shuffle!
  	arr.each do |item|
  	  add_node(Node.new(item))
  	end
  	
  end

  def add_node node
  	if @root.nil?
  	  @root= node
  	  return
  	end
    @root = insert_node(@root, node)
  end

  def insert_node(tree, node)
    if tree.left.nil? && tree.value > node.value
      tree.left = node
      node.parent = tree
      return get_root(node)
    elsif tree.right.nil? && tree.value < node.value 
      tree.right = node
      node.parent = tree
      return get_root(node)
    end
    tree.value > node.value ? insert_node(tree.left, node) : insert_node(tree.right, node)
  end

  def get_root(node)
    if node.parent.nil?
      return node
    end
    get_root(node.parent)
  end
  #Depth-First-Traversal technically. . .
  def format tree
  	return if tree.nil?
  	puts tree.value
  	format tree.left
  	format tree.right
  end

  def to_s 
  	format @root
  end
end

tree = BinaryTree.new([1, 11, 4, 23, 8, 9, 10, 3, 5, 7, 2, 67, 6345, 324])
tree.to_s