require_relative "../lib/board.rb"

describe "The game board" do
	before do 
		@board = Board.new
	end

	it "has a state represented by an 8x8 array" do 
		expect(@board.state.length).to eq(8)
		expect(@board.state[0].length).to eq(8)
	end

	describe "#format" do 
		it "returns a string, for printing the game board" do 
			expect(@board.format).to be_a(String)
		end
	end 

end