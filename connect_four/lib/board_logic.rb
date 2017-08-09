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
    6.times do |i|
      if @status[6 - i][col - 1].nil?
        @status[6 - i][col - 1] = char
        return true
      end 
    end
    false
  end

  def four_in_row?
    rows? || columns? || rows?
  end

  def columns?
    count = 0
    @status.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if !col.nil? && i < 4 
          current_item = col
          next_item = @status[i + 1][j]
          count = 0
          while current_item == next_item && (count + 1 + i) < @status.length - 1 do 
            count += 1
            next_item = @status[i + 1 + count][j]
          end
        end
      end
    end
    count == 2 ? (return true) : (return false)
  end

  def rows?
    count = 0 
    @status.each_with_index do |row, i|
      count = 0

      row.each_with_index do |col, j|      
        if !col.nil?
          current_item = col
          next_item = @status[i][j + 1] 
          count += 1 if current_item == next_item 
        end
      end
    end
    count == 3 ? (return true) : (return false)
  end

  def diagonals

  end
end