class Board

  attr_accessor :status

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
    7.times do |i|
      if @status[6 - i][col - 1].nil?
        @status[6 - i][col - 1] = char
        return true
      end 
    end
    false
  end

  def four_in_row?
    rows? || columns? || diagonals?
  end

  def columns?
    count = 0
    transposed_array = @status.transpose
    transposed_array.each_with_index do |row, i|
      count = 0

      row.each_with_index do |col, j|
        if !col.nil?
          current_item = col
          next_item = transposed_array[i][j + 1]
          count += 1 if current_item == next_item
        end
        return true if count == 3
      end
    end
    false
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

  def diagonals?
    result = false
    @status.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if !col.nil? && i < 4
          current_item = col
          result = check_left(col, i, j) || check_right(col, i, j)
        end
      end
    end
    result
  end

  def check_left(col, i, j)
    return false if j < 3
    next_item = @status[i+1][j-1]
    count = 0 
    depth = count + 1

    while col == next_item && (j - depth > 0) && (i + depth < 6) do
      count += 1
      depth = count + 1 
      next_item = @status[i + depth][j - depth]
    end
    return true if count == 2
  end

  def check_right(col, i, j)
    return false if j > 2
    next_item = @status[i+1][j+1]
    count = 0
    depth = count + 1

    while col == next_item && (j + depth < 5) && (i + depth < 6) do
      count += 1
      depth = count + 1
      next_item = @status[i + depth][j + depth]
    end
    return true if count == 2
  end

  def full?
    @status.each_with_index do |row, i|
      row.each_with_index do |col, j|
        return false if col.nil?
      end
    end
    return true
  end
end