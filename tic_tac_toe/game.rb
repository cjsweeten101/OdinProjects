class Game
  require_relative 'board'
  require_relative 'player'

  def initialize
  	@board = Board.new
  	puts "Player 1,"
  	@player1 = Player.new(get_player, 'X')
  	puts "Player 2,"
  	@player2 = Player.new(get_player, 'O')
  	game_loop
  end

  def get_player
  	puts "What's your name?"
  	while name = gets.chomp
  		name.length > 0 ? (return name) : (puts "Please enter a valid name")
  	end
  end

  def game_loop
  	puts "Welcome to Tic Tac Toe #{@player1.name} and #{@player2.name}!"
  	puts "Enter moves as a row, col coordinate => 2,3"

  	loop do 
  		begin
  		  puts @board.display
  		  make_move(@player1)
  		  puts @board.display
  		  make_move(@player2)

  		  puts "#{@player1.name} (#{@player1.char}s), what's your move?"
  		  move = get_move(@player1)
  		  @board.update(move[0]-1, move[1]-1, @player1.char)
  		  puts @board.display

  		  puts "#{@player2.name} (#{@player2.char}s), what's your move?"
  		  move = get_move(@player2)
  		  @board.update(move[0]-1, move[1]-1, @player2.char)
  		rescue StandardError
  			puts "Please input a valid move"
  			retry
  		end
  	end
  end

  def get_move(player)
  	begin
  	  move = gets.chomp.split(',')
  	  move.map! {|i| Integer(i)}
  	  if move.all? {|i|  i.is_a?(Integer) && (1..3).include?(i)} && move.length == 2
  	    return move
  	  else
  	  	raise InputError
  	  end
  	rescue StandardError, InputError
  	  puts "Enter moves as a row, col coordinate => 2,3" 
  	  retry
  	end
  end

  def game_over?(board)
  end

  def make_move(player)
  	
  end
end
