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

	def move player_color, initial_coord, ending_coord
		moving_piece = get_piece(initial_coord)
		if legal_move?(player_color, moving_piece, initial_coord, ending_coord)
			@pieces_hash[moving_piece] = ending_coord
			@state = update_state(@pieces_hash, @state)
			return true
		else
			return false
		end
	end

	def get_piece coord 
		@pieces_hash.key(coord)
	end

	def legal_move? (player_color, moving_piece, initial_coord, ending_coord)
		move = initial_coord.zip(ending_coord).map { |x, y| y - x }
		if moving_piece.nil? || moving_piece.color !=  player_color || ending_coord[0] > @state.length - 1 || ending_coord[1] > @state.length - 1 || !moving_piece.moveset.include?(move)
			return false
		elsif !moving_piece.is_a? Knight
			return not_blocked?(player_color, initial_coord, ending_coord, move)
		else
			return true		 	 
		end
	end

	def not_blocked? (player_color, initial_coord, ending_coord, move)
		move_slice = slice_2d(@state, initial_coord, ending_coord)
		move_slice.each_with_index do |space, idx|
			if (!space.nil?) && idx != 0
				return false
			end
		end
		true
	end

	def slice_2d(arr, initial_coord, ending_coord)
		result = []
		col_indexes = (initial_coord[1]..ending_coord[1]).to_a 
		col_tracker = 0
		row_slice = @state[initial_coord[0]..ending_coord[0]]
		row_slice.each_with_index do |row, idx|
			row.each_with_index do |space, idx|
				if idx == col_indexes[col_tracker]
					result << space
					col_tracker += 1  
				end
			end
		end
		result
	end
end
