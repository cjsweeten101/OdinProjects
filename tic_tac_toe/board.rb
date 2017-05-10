class Board
  LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
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
  	result = full? || three_in_row?
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
  	
  end

  def create
  	@board = [['','',''],
  			  ['','',''],
  			  ['','','']]
  end
end