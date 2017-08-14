class Piece
	attr_reader :moveset, :symbol, :color

	def initialize color = 'b'
		#Place holder moveset, technically a pawn [row, col]
		@color = color
		@moveset = [1,0]
		@symbol = 'X'
	end
end