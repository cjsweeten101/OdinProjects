class Board
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
	@board[row][col] == '' ? @board[row][col] = char : (raise StandardError)
  end

  private

  def create
  	@board = [['','',''],
  			  ['','',''],
  			  ['','','']]
  end

end