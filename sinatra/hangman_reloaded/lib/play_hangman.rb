class PlayerInterface
  require 'yaml'
  require_relative 'hangman'

  def initialize
  	display_greeting
  	@hangman = ''
  end

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
      puts "Try again. . ." if count > 0 
      result = gets.chomp.downcase
      count += 1
   	  if result == 'quit'
   	  	exit
   	  elsif result == 'save'
   	  	save_game
   	  end
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
  	puts "At anytime type 'quit' to quit, or 'save' to save this game for later"
  	@hangman = Hangman.new('5desk.txt')
  	game_loop
  end

  def load_old_game
  	saves = []
  	Dir.foreach('saves/') do |item|
  	next if item == '.' or item == '..'
  	saves << item.strip
	end
	puts "Saved Games: #{saves.join(' ')}"
	choice = get_input(array_to_regex(saves))
	@hangman = YAML::load_file("saves/#{choice}")
	game_loop
  end

  def game_loop
    puts @hangman.word
    turns = 10
    until turns == 0 do
      puts "Hint: #{@hangman.hint} | Incorrect Letters: #{@hangman.incorrect.join(',')} | Turns Left: #{turns}" 
      victory?

      unguessed_chars = array_to_regex(('a'..'z').to_a - (@hangman.correct + @hangman.incorrect))
      guess = ''
      until guess.length == 1
      	guess = get_input(unguessed_chars)
      end
      
      @hangman.make_guess(guess)
      turns -= 1
    end
    victory?
    puts hangman.hint
    puts "You lost! The word was #{hangman.word}"
  end

  def array_to_regex(array)
  	regex = array.join('|')
  	/#{regex}/
  end

  def victory?
  	if @hangman.game_over?
      	puts "You win!"
 		exit
    end
  end

  def save_game
  	puts "What do you want to call your file?"
  	name = ''
  	while name.length < 1
  	  print 'Filename:'
  	  name = gets.chomp
  	end
	File.open("saves/#{name}.yaml", 'w') { |file| file.write @hangman.to_yaml }
	puts "#{name} saved!"
  	exit
  end
end

PlayerInterface.new