class Node
  attr_accessor :value, :parent, :left, :right

  def initialize value
  	@value = value
  	@parent = nil
  	@left = nil
  	@right = nil
  end
end