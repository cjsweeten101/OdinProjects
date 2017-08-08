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
    cols_count = 0
    diag_count = 0 
    rows_count = 0

    @status.each_with_index do |row, i|
      rows_count = 0
      current_char = ''
      next_char = ''

      row.each_with_index do |col, j|
        if !col.nil?
          current_char = col
          next_row_char = @status[i][j + 1]

          if i < @status.length - 1
            next_col_char = @status[i + 1][j]
          else
            next_col_char = nil
          end

          rows_count += 1 if next_row_char == current_char
          cols_count +=1 if next_col_char == current_char
        end
      end
    end

    if cols_count == 3 || rows_count == 3 || diag_count == 3
      return true
    else
      return false
    end
  end
end