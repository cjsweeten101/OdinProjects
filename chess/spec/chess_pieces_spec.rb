require_relative "../lib/chess_pieces.rb"

describe "A Chess piece" do
		before do 
			@piece = Piece.new 'w'
		end

	it "can be white or black" do 
		expect(@piece.color).to eq("w")
	end

	describe "A Knight" do 
		before do 
			@knight = Knight.new
		end

		it "has a black default color" do 
			expect(@knight.color).to eq('b')
		end
		it "can move in an 'L' shape" do 
			expect(@knight.moveset).to include([2,1])
		end

		it "cannot move in a straight line" do 
			expect(@knight.moveset).not_to include([2,0])
		end
	end
end