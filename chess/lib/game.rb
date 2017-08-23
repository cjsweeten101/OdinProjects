require_relative "board.rb"

class Game

	def initialize 
		@board = Board.new
		puts welcome_message
		game_loop
	end

	def welcome_message
		"Welcome to chess!"
	end
	def game_loop
		current_player = 'b'
		until @board.checkmate?(current_player) do
				puts @board.format
				puts "Check!" if @board.check?(current_player)
				puts "its #{current_player}'s turn"
				move = prompt_move(current_player)
				current_player == 'b' ? current_player = 'w' : current_player = 'b'

		end
		puts "checkmate!"
	end

	def prompt_move player_color
		placed = false
		until placed do
			result = '' 
			until result.length == 4  do 
				puts "Choose pieces to move in the form x,y to k,z (Board is 8x8)"
				result = gets.chomp.scan(/\b[1-8]{1}\b/)
			end
			placed = place_move(result, player_color)
		end 
	end

	def place_move move, player_color
		ending_coord = move[2..4].map {|v| v.to_i-1}
		starting_coord = move[0..1].map {|v| v.to_i-1}
		@board.move(player_color, starting_coord, ending_coord)
	end
end