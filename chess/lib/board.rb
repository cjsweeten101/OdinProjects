require_relative "chess_pieces.rb"

class Board
	attr_reader :state

	def initialize
		@state = Array.new(8){Array.new(8)}
		@pieces_hash = create_pieces_hash
		@state = update_state(@pieces_hash, @state) 
	end

	def format
		result = ""
		@state.each do |row|
			result += "\n"
			row.each do |piece|
				#Dependency on 'piece' responding to 'symbol'
				piece.nil? ? result += "| |" : result += "|#{piece.symbol}|"
			end
		end
		result
	end

	def create_pieces_hash
		result = Hash.new
		result = add_pawns result
		result = add_non_pawns result
	end
	
	def add_pawns pieces_hash
		color = 'b'
		row = 1	
		2.times do
			@state.length.times do |i|
				pieces_hash[Pawn.new color] = [row, i]
			end
			color = 'w'
			row = 6
		end
		pieces_hash
	end

	def add_non_pawns pieces_hash
		color = 'b'
		row = 0
		new_hash = Hash.new

		2.times do 
			
				new_hash[Rook.new(color)] = [row, 0]
				new_hash[Rook.new(color)] = [row, 7]
				new_hash[Knight.new(color)] = [row, 1]
				new_hash[Knight.new(color)] = [row, 6]
				new_hash[Bishop.new(color)] = [row, 2]
				new_hash[Bishop.new(color)] = [row, 5]
				new_hash[Queen.new(color)] = [row, 3]
				new_hash[King.new(color)] = [row, 4]
			
			color = 'w'
			row = 7
		end
		new_hash.merge(pieces_hash)
	end

	def update_state piece_hash, current_state
		piece_hash.each do |piece, pos|
			current_state[pos[0]][pos[1]] = piece
		end
		current_state
	end
end