require_relative "../lib/game_logic.rb"

describe "The main game logic and loop" do 
	before do 
		@game = GameLogic.new
	end

	describe "#welcome_message" do 
		it "returns a welcome message" do 
			expect(@game.welcome_message).to be_a(String)
		end
	end

	describe "#board" do 
		it "is the current game's board" do 
			expect(@game.board).to be_a(Board)
		end
	end

	describe "#player1" do 
		it "is initialized as an 'X'" do 
			expect(@game.player1).to eq('X')
		end
	end

	describe "#player2" do 
		it "is initialized as an 'O'" do 
			expect(@game.player2).to eq('O')
		end
	end

	describe "current_player" do 
		it "starts as player1" do 
			expect(@game.current_player).to eq('X')
		end
	end
end