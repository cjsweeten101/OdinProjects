require_relative "chess_pieces.rb"

class Board
	attr_reader :state
	attr_accessor :player

	def initialize
		@state = Array.new(8){Array.new(8)}
		@pieces_hash = create_pieces_hash
		@state = update_state(@pieces_hash) 
		@player ='b'
		@turns = 0
	end

	#For testing purposes
	def move_anywhere(start_coord, end_coord)
		piece = @pieces_hash.key(start_coord)
		@pieces_hash[piece] = end_coord
		@state = update_state(@pieces_hash)
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
		move = initial_coord.zip(ending_coord).map { |x, y| y - x }
		board_before_move = @state
		hash_before_move = @pieces_hash
		moving_piece = get_piece(initial_coord)
		result = false
		if moving_piece.is_a?(Pawn) 
			if can_pawn_move?(moving_piece, initial_coord, ending_coord)
				@pieces_hash.delete(@pieces_hash.key(ending_coord)) if !@pieces_hash.key(ending_coord).nil? 
      	@pieces_hash[moving_piece] = ending_coord
      	@state = update_state(@pieces_hash)
      	set_en_passant_able(moving_piece,move)
      	moving_piece.first_move = false
      	moving_piece.moved = true
      	result = true
      else
      	result = false
    	end
		elsif legal_move?(player_color, moving_piece, initial_coord, ending_coord)
			@pieces_hash.delete(@pieces_hash.key(ending_coord)) 
			@pieces_hash[moving_piece] = ending_coord
			@state = update_state(@pieces_hash)
			moving_piece.moved = true
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

	def castle(king_coord, rook_coord)
		king = get_piece(king_coord)
		rook = get_piece(rook_coord)
		ending_coord = []
		hash_before = @pieces_hash
		@pieces_hash[rook][1]+1 > 7 ? ending_coord = [@pieces_hash[rook][0], 6] : ending_coord = [@pieces_hash[rook][0], 2]
		if castle_able?(king, rook, king_coord, ending_coord)
			@pieces_hash[king] = ending_coord
			rook_ending_coord = []
			@pieces_hash[king] == [ending_coord[0], 6] ? rook_ending_coord = [ending_coord[0], 5] : rook_ending_coord = [ending_coord[0], 3]
			@pieces_hash[rook] = rook_ending_coord
			@state = update_state(@pieces_hash)
			if check?(king.color)
				@pieces_hash = hash_before
				@state = update_state(@pieces_hash)
				return false
			end
			return true
		end
		return false
	end

	def castle_able?(king, rook, initial_coord, ending_coord)
		return false if check?(king.color)
		if king.is_a?(King) && rook.is_a?(Rook) && king.moved == false && rook.moved == false
			move = initial_coord.zip(ending_coord).map { |x, y| y - x }
			if clear_path?(king.color, initial_coord, ending_coord, move) && no_attacked_squares(king.color, initial_coord, ending_coord, move)

				return true
			else
				return false
			end
		end
	end

	def no_attacked_squares(player_color, initial_coord, ending_coord, move)
		result = false
		enemies_hash = @pieces_hash.select { |k, v| k.color != player_color }
		rows = (initial_coord[0]..ending_coord[0]).to_a
		cols = (initial_coord[1]..ending_coord[1]).to_a
		cols = initial_coord[1].downto(ending_coord[1]).to_a if cols.length == 0
		spaces = rows.zip(cols)
		spaces.each do |coord|
			enemies_hash.each do |k,v|
				result = piece_can_traverse?(k, coord)
			end
		end
		result == false ? (return true) : (return false)
	end

	def en_passant?(pawn, end_coord)
		behind_coord = []
		pawn.color == 'b' ? behind_coord = [end_coord[0]-1, end_coord[1]] : behind_coord = [end_coord[1]+1, end_coord[1]]
		behind_piece = @pieces_hash.key(behind_coord)
		if !behind_piece.nil? && behind_piece.is_a?(Pawn) && behind_piece.color != pawn.color  && behind_piece.passant_able_turn == @turns
			@pieces_hash.delete(behind_piece)
			@state = update_state(@pieces_hash)
			return true
		end
			return false
	end
	def set_en_passant_able(pawn, move) 
		if move.include?(2) || move.include?(-2) 
			pawn.passant_able_turn = @turns + 1
		end
	end

	def switch_player
		@player == 'b' ? @player = 'w' : @player = 'b'
		@turns+=1
	end
		

	def pawn_upgrade?
		pawns_hash = @pieces_hash.select{|k,v| k.is_a?(Pawn)}
		pawns_hash.each do |p,v|
			if v[0] == 0 || v[0] == 7
				return true
			end
		end
		return false
	end

	def upgrade_pawn(coord, choice)
		pawn = get_piece(coord)
		@pieces_hash.delete(pawn)
		case choice
			when 'b'
				@pieces_hash[Bishop.new] = coord
			when 'r'
				@pieces_hash[Rook.new] = coord
			when 'q'
				@pieces_hash[Queen.new] = coord
			when 'k'
				@pieces_hash[Knight.new] = coord
		end
		@state = update_state(@pieces_hash)
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
		move_slice = slice_2d(initial_coord, ending_coord, move)
		move_slice.each_with_index do |space, idx|
			if !space.nil? && idx != 0
				return false if space.color == player_color || idx != move_slice.length-1
			end
		end
		return true
	end

	def slice_2d(initial_coord, ending_coord, move)
		result = []
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
        get_piece(ending_coord).nil? ? can_move  = true : can_move = false
		  else
			  get_piece(ending_coord).nil? ? can_move = false : can_move = true
			  can_move = true if en_passant?(pawn, ending_coord)
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
