require_relative "../lib/board.rb"

describe Board do
	let!(:board) {Board.new}

	describe "#display" do 
		it "formats the board into a string" do 
			expect(board.display).to be_a(String)
		end
	end

	describe "#update" do
		before do
			board.update(1, 1, 'X')
		end

		it "updates the board, if a space is available" do 
			expect{board.update(1,1,'X')}.to raise_error(IOError)
		end
	end

	describe "#game_over?" do
		context "when 3 in a row" do
			before do 
				3.times do |i|
					board.update(i, 1, 'X')
				end
			end

			it "returns true" do 
				expect(board.game_over?).to be true
			end
		end

		context "when board is full, but no 3 in a row" do 
			before do 
				3.times do |i|
					3.times do |j|
						board.update(i, j, ('A'..'Z').to_a.sample)
					end
				end
			end
			it "returns 0" do 
				expect(board.game_over?).to eq(0)
			end
		end

		context "when not 3 or full" do 
			it "returns false" do 
				expect(board.game_over?).to be false
			end
		end
	end
end