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
  	puts "Try to guess the computer's random code in 12 turns"
  	puts "Codes are entered with a 4 digit combination of numbers 1-6.  ->  2,4,5,6"

  	prompt_code()

  end

  def prompt_code
  	input = ''
  	result = []
  	until result.all? {|n| n.is_a? Integer} && result.length == 4
  		print "Guess:"
  		result = gets.chomp.split(',')
  		result.map! {|n| n.to_i}

  		exit if input == 'q'
  	end
  	result
  end

  def code_creator
  end

end

MasterMind.new