require_relative "board_logic.rb"

class GameLogic

	attr_reader :board, :welcome_message, :player1, :player2, :current_player
	
	def initialize
		@welcome_message = "Welcome to connect four!"
		@board = Board.new
		@player1 = 'X'
		@player2 = 'O'
		@current_player = player1
		
		game_loop
	end 

	def game_loop
		puts @welcome_message
		puts @board.show
		until @board.four_in_row? || @board.full? do 
			puts "its #{current_player}'s turn place pieces by typing 1-6"
			make_move(current_player)
			puts @board.show

			@current_player == 'X' ? @current_player = 'O' : @current_player = 'X'
		end
		puts "game over"
	end

	def make_move(current_player)
		begin
			move = gets.chomp.to_i
			if move == 0 || move > 6
				raise StandardError
			end

		rescue StandardError
			puts "try again"
			retry
		end
		@board.place(current_player, move)
	end
end

GameLogic.new