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

		before do 
			@board.move('b', [1,1], [2,1])
		end 

		before do 
			@board.move_anywhere([6,1], [2,3])
		end

		it "allows pawns to capture pieces" do 
			expect(@board.move('w', [2,3], [1,2])).to eq(true)
		end
		it "moves a piece to an empty space on the board"  do
			expect(@board.state[2][1]).to be_a(Pawn)
		end

		it "returns false if a piece cannot make that move" do 
			expect(@board.move('b', [1,1], [1,6])).to eq(false)
			expect(@board.move('b', [0,3], [1,3])).to eq(false)
		end

		before do 
			@board.move('b', [0,2], [2,0])
			@board.move('b', [2,0], [6,4])
		end
		it "captures enemy pieces" do 
			expect(@board.state[6][4]).to be_a(Bishop)
		end
	end

	describe "#checkmate" do
		before do
			@board.move('b', [0,1], [2,2])
			@board.move('b', [2,2], [4,3])
			@board.move('b', [4,3], [5,5])
		end

		it "returns true if checkmate. . ." do 
			expect(@board.checkmate?('w')).to eq(true)
		end
	end
end