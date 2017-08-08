class Board

  attr_reader :status

  def initialize
    @rows = 7
    @cols = 6
    @status = Array.new(@rows){Array.new(@cols)}
  end

  def show
    result = ''
    @status.each do |row|
      row.each do |col|
        col.nil? ? result += "| |" : result += "|#{col}|"
      end
      result += "\n"
    end
    result
  end

  def place(char, col)
    @status.each_with_index do |row , i|
      if !row[col-1].nil?
        @status[i-1][col-1] = char
      elsif i == @rows - 1
        @status[6][col-1] = char
      end
    end
  end
end