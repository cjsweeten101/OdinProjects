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
	end
end

GameLogic.new