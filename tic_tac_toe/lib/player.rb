class Player
	attr_reader :char
	attr_reader :name
  def initialize(name, char)
  	@name = name
  	@char = char
  end
end