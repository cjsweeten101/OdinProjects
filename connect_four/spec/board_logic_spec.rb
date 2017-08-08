require_relative "../lib/board_logic.rb"

describe "The connect four game board" do 

	before do 
		@board = Board.new
	end

	describe "#status" do 
		it "returns the current status as an array" do 
			expect(@board.status).to be_a(Array)
		end
	end

	describe "#show" do
		it "returns the current status of the board as a string" do 
			expect(@board.show).to be_a(String)
		end
	end

	describe "#place" do 
		before do 
			@board.place('X', 1)
			@board.place('O', 1)
		end

		it "takes a char as a parameter and places in the designated col, stacking if needed" do
			expect(@board.status[5][0]).to eq('O')
		end 
	end

	describe "#four_in_row?" do 
		it "checks for four in a row on columns"

		it "checks for four in a row on rows"

		it "checks for four in a row on diagonals"
	end

	describe "#full?" do 
		it "checks if the whole board is full, resulting in a tie"
	end
end