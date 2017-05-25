class BinaryTree
  require_relative 'node'

  def initialize arr
    @dfs_rec_result = nil
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
  def format_sorted tree
  	return if tree.nil?
  	format_sorted tree.left
    puts tree.value
  	format_sorted tree.right
  end

  def display_sorted 
  	format_sorted @root
  end

  def breadth_first_search(target)
    queue = []
    node = @root
    loop do
      return node if node.value == target 
      queue << node.left if !node.left.nil?
      queue << node.right if !node.right.nil?
      queue.length == 0 ?  (break) : node = queue.shift
    end
    0
  end

  def depth_first_search(target)
    stack = []
    stack << @root
    while stack.length > 0
      node = stack.pop
      return node if node.value == target
      stack << node.left if !node.left.nil?
      stack << node.right if !node.right.nil?
    end
  end

  def dfs_rec(target, node=@root)
    return node if node.value == target
    left = dfs_rec(target, node.left) if node.left
    right = dfs_rec(target, node.right) if node.right
    left or right
  end
end