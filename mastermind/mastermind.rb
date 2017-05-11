class MasterMind
  
  require_relative 'board'
  require_relative 'computer'
  require_relative 'player'

  def initialize
  	@board = Board.new
  	@player = Player.new
  	@computer = Computer.new

  	startup_greeting
  end

  def startup_greeting
  	puts "Welcome to MasterMind! (Type q to quit anytime)"
  	question = "Would you like to be the code breaker? (Yes/No)"
  	expected_result = ['yes','no']

  	result = prompt_input(question, expected_result)
  	if result == 'yes'
  	  puts "Great! You're the code breaker!"
  	  code_breaker
  	else
  	  puts "Great! You're the code creator!"
  	  
  	  code_creator
  	end
  end

  def prompt_input(question, expected_result)
  	input = ''
  	until expected_result.include? input do
	  puts question
	  input = gets.chomp.downcase

	  exit if input == 'q'
  	end
  	input
  end

  def code_breaker
  	puts @computer.code.inspect
  	puts "Try to guess the computer's random code in 12 turns"
  	puts "Codes are entered with a 4 digit combination of numbers 1-6.  ->  2,4,5,6"

  	turn_count = 0

  	until turn_count == 12 do

  	  code = @player.guess
  	  @board.place_guess(code)
  	  hint = @computer.check_guess(code)
  	  @board.place_hint(hint)
  	  turn_count += 1
  	  puts @board.state + "Turn: #{turn_count}"
  	  if hint[:perfect] == 4
  		puts "Game Over! You won in #{turn_count} turns!"
  		exit
  	  end
  	end
  	puts "Game Over! You lost, the code was #{@computer.code}"
  end

  def code_creator
  	puts "Come up with a secret code!"
  	puts "Codes are entered with a 4 digit combination of numbers 1-6.  ->  2,4,5,6"

  	hint = nil
  	turn_count = 0
  	code = @player.guess
  	until turn_count == 1000 do
  	  guess = @computer.guess(hint) 
  	  @board.place_guess(guess)

  	  hint = @player.check_guess(guess)
  	  @board.place_hint(hint)

  	  turn_count += 1
  	  if hint[:perfect] == 4
  		puts @board.state
  		puts "Game Over! Computer won in #{turn_count} turns!"
  		exit
  	  end
  	end
  	puts @board.state
  	puts "Computer Didn't guess it!"
  end

end

MasterMind.new