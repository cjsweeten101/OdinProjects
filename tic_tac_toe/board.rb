class Board
  WINNING_LINES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  def initialize
  	create
  end

  def display
  	result = ''

  	@board.each_with_index do |row, idx|
  		result += "-----\n" if idx != 0 

  		row.each_with_index do |char, indx|
  			result += "|" if indx != 0
  			char.length > 0 ? result += char : result += ' '
		end

  		result += "\n"
  	end
  	result
  end

  def update(row, col, char)
	@board[row][col] == '' ? @board[row][col] = char : (raise IOError)
  end

  def game_over?
  	if full?
  		return 0
  	elsif three_in_row?
  		return true
  	else
  		return false
  	end
  end

  private

  def full?
  	count = 0
  	@board.each do |row|
  		row.each do |item|
  			if item.length == 0
  				count += 1
  			end
  		end
  	end
  	if count == 0
  		return true
  	else
  		return false
  	end
  end

  def three_in_row?
  	flat_board = @board.flatten
  	x_matches = flat_board.each_index.select {|i| flat_board[i] == 'X'}
  	o_matches = flat_board.each_index.select {|i| flat_board[i] == 'O'}

  	WINNING_LINES.each do |line|
  	  if (line - x_matches).empty?
  		  return true

  	  elsif (line - o_matches).empty?
  		  return true

  	  end  	
  	end
  	return false
  end

  def create
  	@board = [['','',''],
  			  ['','',''],
  			  ['','','']]
  end
end