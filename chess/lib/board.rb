require_relative "chess_pieces.rb"

class Board
	attr_reader :state

	def initialize
		@state = Array.new(8){Array.new(8)}
		@pieces_hash = create_pieces_hash
		@state = update_state(@pieces_hash) 
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

	def update_state piece_hash
		new_state = Array.new(8){Array.new(8)}
		piece_hash.each do |piece, pos|
			new_state[pos[0]][pos[1]] = piece
		end
		new_state
	end

	def move player_color, initial_coord, ending_coord
		moving_piece = get_piece(initial_coord)
		if moving_piece.is_a?(Pawn) 
			return move_pawn(moving_piece, initial_coord, ending_coord)

		elsif legal_move?(player_color, moving_piece, initial_coord, ending_coord)
			@pieces_hash.delete(@pieces_hash.key(ending_coord)) 
			@pieces_hash[moving_piece] = ending_coord
			@state = update_state(@pieces_hash)
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
			return clear_path?(player_color, initial_coord, ending_coord, move)
		else
			return true		 	 
		end
	end

	def clear_path? (player_color, initial_coord, ending_coord, move)
		move_slice = slice_2d(@state, initial_coord, ending_coord)
		move_slice.each_with_index do |space, idx|
			if !space.nil? && idx != 0
				return false if space.color == player_color || idx != move_slice.length-1
			end
		end
		return true
	end

	def slice_2d(arr, initial_coord, ending_coord)
		result = []
		col_indexes = (initial_coord[1]..ending_coord[1]).to_a 
		col_tracker = 0
		row_slice = @state[initial_coord[0]..ending_coord[0]]
		row_slice.each_with_index do |row, idx|
			found_in_row = false
			row.each_with_index do |space, idx|
				if idx == col_indexes[col_tracker] && !found_in_row
					result << space
					col_tracker += 1 if col_indexes.length > 1
					found_in_row = true  
				end
				next if found_in_row
			end
		end
		result
	end

	def checkmate?
		false
	end

	def check?
		false 
	end

	def move_pawn(pawn, initial_coord, ending_coord)
		move = initial_coord.zip(ending_coord).map { |x, y| y - x }
		can_move = false
    if pawn.moveset.include?(move)
		  if move.include?(0)
        @pieces_hash.key(ending_coord).nil? ? can_move  = true : can_move = false
		  else
			  @pieces_hash.key(ending_coord).nil? ? can_move = false : can_move = true
		  end
    else
      return false
    end
		if can_move
      @pieces_hash.delete(@pieces_hash.key(ending_coord)) if !@pieces_hash.key(ending_coord).nil? 
      @pieces_hash[pawn] = ending_coord
      @state = update_state(@pieces_hash)
      pawn.first_move = false
      return true
		else
			return false
    end
	end
end
