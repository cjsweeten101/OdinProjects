class Piece
	attr_reader :moveset, :symbol, :color
	attr_accessor :moved

	def initialize color = 'b'
		@moved = false
		@color = color
		@moveset = [1,0]
		@symbol = 'X'
	end
end