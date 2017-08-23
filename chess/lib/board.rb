require_relative "chess_pieces.rb"

class Board
	attr_reader :state
	attr_accessor :player

	def initialize
		@state = Array.new(8){Array.new(8)}
		@pieces_hash = create_pieces_hash
		@state = update_state(@pieces_hash) 
		@player ='b'
	end

	def format
		result = ""
		@state.each do |row|
			result += "\n"
			row.each do |piece|
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
		board_before_move = @state
		hash_before_move = @pieces_hash
		moving_piece = get_piece(initial_coord)
		result = false
		if moving_piece.is_a?(Pawn) 
			if can_pawn_move?(moving_piece, initial_coord, ending_coord)
				@pieces_hash.delete(@pieces_hash.key(ending_coord)) if !@pieces_hash.key(ending_coord).nil? 
      	@pieces_hash[moving_piece] = ending_coord
      	@state = update_state(@pieces_hash)
      	moving_piece.first_move = false
      	result = true
      else 
      	result = false
    	end

		elsif legal_move?(player_color, moving_piece, initial_coord, ending_coord)
			@pieces_hash.delete(@pieces_hash.key(ending_coord)) 
			@pieces_hash[moving_piece] = ending_coord
			@state = update_state(@pieces_hash)
			result = true
		else
			result = false
		end
		if check?(player_color)
			@state = board_before_move
			@pieces_hash = hash_before_move
			result = false
		end
		result
	end

	def get_piece coord 
		@pieces_hash.key(coord)
	end

	def castle

	end

	def pawn_upgrade

	end

	def stalemate?
		result = true
		@pieces_hash.each do |k,v|
			result = false if !k.is_a?(King) 
		end 
		result
	end

	def legal_move? (player_color, moving_piece, initial_coord, ending_coord)
		move = initial_coord.zip(ending_coord).map { |x, y| y - x }
		if moving_piece.nil? || moving_piece.color !=  player_color || ending_coord[0] > @state.length - 1 || ending_coord[1] > @state.length - 1 || !moving_piece.moveset.include?(move) || ending_coord[0] < 0 || ending_coord[1] < 0
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
		move = initial_coord.zip(ending_coord).map { |x, y| y - x }
		if move[0] == 0
			indexes = (initial_coord[1]..ending_coord[1]).to_a
			indexes = (initial_coord[1].downto(ending_coord[1])).to_a if indexes.length == 0
			indexes.each do |idx|
				result << @pieces_hash.key([ending_coord[0],idx])
			end
		elsif move[1] == 0
			indexes = (initial_coord[0]..ending_coord[0]).to_a
			indexes = (initial_coord[0].downto(ending_coord[0])).to_a if indexes.length == 0
			indexes.each do |idx|
				result << @pieces_hash.key([idx,ending_coord[1]])
			end
		else
			row_indexes = (initial_coord[0]..ending_coord[0]).to_a
			row_indexes = (initial_coord[0].downto(ending_coord[0])).to_a if row_indexes.length == 0

			col_indexes = (initial_coord[1]..ending_coord[1]).to_a
			col_indexes = (initial_coord[1].downto(ending_coord[1])).to_a if col_indexes.length == 0

			indexes = row_indexes.zip(col_indexes)
			indexes.each do |coord|
				result << @pieces_hash.key(coord)
			end
		end
		result			
	end

	def checkmate? player_color
		if check? player_color
			result = true
			king = @pieces_hash.keys.select{ |k| k.is_a?(King) && k.color == player_color }[0]
			kings_coord = @pieces_hash[king]
			king.moveset.each do |i,j|
				ending_coord = [kings_coord[0]+i, kings_coord[1]+j]
				result = false if legal_move?(player_color, king, kings_coord, ending_coord)
			end 
			return result
		end
		false
	end

	def check? player_color
		result = false
		king_coord = @pieces_hash.select{ |k,v| k.is_a?(King) && k.color == player_color }.first[1]
		enemy_pieces = @pieces_hash.select{ |k,v| k.color != player_color }
		enemy_pieces.each do |k,v|
			result = true if piece_can_traverse?(k, king_coord)
		end 
		result
	end

	def can_pawn_move?(pawn, initial_coord, ending_coord)
		move = initial_coord.zip(ending_coord).map { |x, y| y - x }
		can_move = false
    if pawn.moveset.include?(move)
		  if move.include?(0)
        @pieces_hash.key(ending_coord).nil? ? can_move  = true : can_move = false
		  else
			  @pieces_hash.key(ending_coord).nil? ? can_move = false : can_move = true
		  end
		end
		can_move ? (return true) : (return false)
	end

	def piece_can_traverse?(piece, ending_coord)
		result = false
		if piece.is_a?(Pawn)
			return can_pawn_move?(piece, @pieces_hash[piece], ending_coord)
		end
		legal_move?(piece.color, piece, @pieces_hash[piece], ending_coord)
	end
end
