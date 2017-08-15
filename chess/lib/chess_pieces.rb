require_relative "piece.rb"

class Knight < Piece

	def initialize color='b'
		@color = color
		colorfy
		@moveset = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
	end

	def colorfy
		@color == 'b' ? @symbol = "\u265E" : @symbol = "\u2658"
	end
end 

class Pawn < Piece
	def initialize color='b'
		@color = color
		colorfy
		@color == 'b' ? @moveset = [[1,0],[1,1],[1,-1]] : @moveset = [[-1,0],[-1,1][-1,-1]]
	end

	def colorfy
		@color == 'b' ? @symbol = "\u265F" : @symbol = "\u2659"
	end
end

class Bishop < Piece
	def initialize color='b'
		@color = color
		colorfy
		@moveset = [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],
								[-1,-1],[-2,-2],[-3,-3],[-4,-4],[-5,-5],[-6,-6],[-7,-7],
								[1,-1],[2,-2],[3,-3],[4,-4],[5,-5],[6,-6],[7,-7],
								[-1,1],[-2,2],[-3,3],[-4,4],[-5,5],[-6,6],[-7,7]]
	end

	def colorfy
		@color == 'b' ? @symbol = "\u265D" : @symbol = "\u2657"
	end
end

class Rook < Piece
	def initialize color='b'
		@color = color
		colorfy
		@moveset = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],
							  [0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],
								[-1,0],[-2,0],[-3,0],[-4,0],[-5,0],[-6,0],[-7,0],
								[0,-1],[0,-2],[0,-3],[0,-4],[0,-5],[0,-6],[0,-7]]
	end

	def colorfy
		@color == 'b' ? @symbol = "\u265C" : @symbol = "\u2656"
	end
end

class King < Piece
	def initialize color='b'
		@color = color
		colorfy
		@moveset = [[1,0],[1,1],[0,1],[-1,1],[0,-1],[-1,-1],[-1,0],[1,-1]]
	end

	def colorfy
		@color == 'b' ? @symbol = "\u265A" : @symbol = "\u2654"
	end
end

class Queen < Piece
	def initialize color ='b'
		@color = color
		colorfy
		generate_moveset
	end

	def generate_moveset
		rook = Rook.new
		bishop = Bishop.new
		@moveset = rook.moveset + bishop.moveset
	end

	def colorfy
		@color == 'b' ? @symbol = "\u265B" : @symbol = "\u2655"
	end
end