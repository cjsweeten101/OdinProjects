require_relative "../lib/board.rb"

describe "The game board" do
	before do 
		@board = Board.new
	end

	it "has a state represented by an 8x8 array" do 
		expect(@board.state.length).to eq(8)
		expect(@board.state[0].length).to eq(8)
	end

	it "is initialized with a state containing pieces for black/white" do 
		expect(@board.state[0][4]).to be_a(King)
		expect(@board.state[6][4]).to be_a(Pawn)
	end

	describe "#format" do 
		it "returns a string, for printing the game board" do 
			expect(@board.format).to be_a(String)
		end
	end 

	describe "#move" do 
		it "moves a piece to an empty space on the board" 

		it "returns an error if a piece cannot make that move"

		it "captures enemy pieces"

end