class KnightTravail

  Node = Struct.new(:value, :parent) 
  def initialize
  	@board = create_board
  	@root = nil
  	@created_nodes = []
  	@knight_moves = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]
  end

  public

  def move(start, stop)
  	result = bfs(start, stop)
  	count = 0
  	path = ''
  	result.each do |move|
  	  path += "#{move}\n"
  	  count += 1
  	end
  	puts "You made it in #{count} moves!  Here's your path:"
  	puts "#{start}"
  	puts "#{path}"
  end
  private

  def bfs(start, stop)
  	queue = []
  	node = Node.new(start, nil)
  	queue << node
  	until queue.length < 1 do
  	  return get_path(node) if node.value == stop
  	  children = get_children(node)
  	  children.each do |child|
  	  	queue << child
  	  end
  	  node = queue.shift
  	end
  end

  def get_children(parent)
  	result = []
  	next_coords = get_next_coords(parent.value)
  	next_coords.each do |coord|
  	  result << Node.new(coord, parent)
  	end
  	result
  end

  def get_path(node)
  	path = []
  	until node.parent.nil?
  	  path.unshift node.value
  	  node = node.parent
  	end
  	path
  end

  def get_next_coords(coord)
  	result =[]
  	@knight_moves.each do |move|
  	  new_coord = [coord[0]+move[0],coord[1]+move[1]]
  	  unless new_coord.any? {|x| x > 7 || x < 0} 
  	  	result << new_coord
  	  end
  	end
  	result
  end

  def create_board
  	Array.new(8) {Array.new(8) { |i|  0 }}
  end
end

testy = KnightTravail.new
testy.move([3,3],[7,7])