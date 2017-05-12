class PlayerInterface

  def initialize
  	display_greeting
  end

  require_relative 'hangman'

  def display_greeting
  	puts "Welcome!  Please Choose an option below!"
  	puts "1 => New Game"
  	puts "2 => Load Game"
  	puts "3 => Quit"
  	react_to_greeting(get_input(/[1|2|3]/))
  end

  def get_input(expected_result)
    result = 0
    count = 0
    until result =~ expected_result do
      puts "Sorry? I Didn't quite catch that." if count > 0 
      result = gets.chomp
      count += 1
    end
    result
  end

  def react_to_greeting(choice)
  	case choice
  	when '1'
  	  start_new_game
  	when '2'
  	  load_old_game
  	when '3'
  	  puts "Bye bye!"
  	  exit
  	end
  end

  def start_new_game
  	puts "Starting new game!"

  	game = Hangman.new('5desk.txt')
  	puts game.word
  end

  def load_old_game

  end

end

PlayerInterface.new