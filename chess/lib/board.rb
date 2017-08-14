require_relative "chess_pieces.rb"

class Board
	attr_reader :state

	def initialize
		@state = Array.new(8){Array.new(8)}
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
end