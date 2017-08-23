require_relative "board.rb"
require 'yaml'

class Game

	def initialize 
		@board = Board.new
		welcome_message
	end

	def welcome_message
		puts "Welcome to chess!\nChoose an option below:\n1=> New Game\n2=> Load Game\n3=>Quit"
		react_to_welcome(get_input(/[1|2|3]/))
	end

	def react_to_welcome(choice)
		case choice
  	when '1'
  	  game_loop
  	when '2'
  	  load_game
  	when '3'
  	  puts "Bye bye!"
  	  exit
  	end
	end

	def get_input(expected_result)
		result = 0
    count = 0
    until result =~ expected_result do
      puts "Try again. . ." if count > 0 
      result = gets.chomp.downcase
      count += 1
    end
    result
	end

	def prompt_move player_color
		placed = false
		until placed do
			result = '' 
			until result.length == 4  do 
				puts "Choose pieces to move in the form x,y to k,z (Board is 8x8)"
				result = gets.chomp
				if result.downcase == 'quit'
					exit
				elsif result.downcase == 'save'
					save_game
				else		
					result = result.scan(/\b[1-8]{1}\b/)
				end
			end
			placed = place_move(result, player_color)
		end 
	end

	def save_game
		puts "What do you want to call your file?"
  	name = ''
  	while name.length < 1
  	  print 'Filename:'
  	  name = gets.chomp
  	end
		File.open("saves/#{name}.yaml", 'w') { |file| file.write @board.to_yaml }
		puts "#{name} saved!"
  	exit
	end

	def load_game
		saves = []
  	Dir.foreach('saves/') do |item|
  	next if item == '.' or item == '..'
  		saves << item.strip
		end
		puts "Saved Games: #{saves.join(' ')}"
		choice = get_input(array_to_regex(saves))
		@board = YAML::load_file("saves/#{choice}")
		game_loop
	end

	def array_to_regex(array)
  	regex = array.join('|')
  	/#{regex}/
  end

	def game_loop
		puts "Welcome! Type quit to quit and save to save current game"
		current_player = @board.player
		until @board.checkmate?(@board.player) do
				puts @board.format
				puts "Check!" if @board.check?(@board.player)
				puts "its #{@board.player}'s turn"
				move = prompt_move(current_player)
				@board.player == 'b' ? @board.player = 'w' : @board.player = 'b'

		end
		puts "checkmate!"
	end

	def place_move move, player_color
		ending_coord = move[2..4].map {|v| v.to_i-1}
		starting_coord = move[0..1].map {|v| v.to_i-1}
		@board.move(player_color, starting_coord, ending_coord)
	end
end