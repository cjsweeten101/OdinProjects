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

  	winner = ''

  	loop do 

  		  puts @board.display
  		  make_move(@player1)
  		  if game_over?(@board)
  		  	winner = @player1
  		  	break
  		  end

  		  puts @board.display
  		  make_move(@player2)
  		  if game_over?(@board)
  		  	winner = @player2
  		  	break
  		  end

  	end
  	puts "Game Over! #{winner.name} wins!"
  	puts @board.display
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
  	board.game_over?
  end

  def make_move(player)
  	begin
  	  puts "#{player.name} (#{player.char}s), what's your move?"
  	  move = get_move(player)
  	  @board.update(move[0]-1, move[1]-1, player.char)
  	rescue IOError
  	  puts "Enter a valid move"
  	  retry
  	end
  end
end
