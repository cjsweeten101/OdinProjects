class Array
    def swap!(a,b)
         self[a], self[b] = self[b], self[a]
    self
    end
end

class Computer
	attr_reader :code
	attr_reader :new_guess
  def initialize
  	@number_options = [1,2,3,4,5,6]
  	@code = generate_code
  	@new_guess = []
  end

  def generate_code
  	code = []
  	(1..4).each do 
	  code << rand(1..6)
	end
	code
  end

  def check_guess(code)
  	hint = {
  		perfect:  0,
  		imperfect:  0
  	}

  	code.each_with_index do |n,i|
  	  if @code[i] == n
  		hint[:perfect] += 1 
  	  elsif @code.include?(n)
  		hint[:imperfect] += 1
  	  end
  	end
  	hint
  end

  def guess(hint=nil)
  	if @new_guess.length == 0
  	  @new_guess = generate_code
  	  return @new_guess
 	end

  	perfect_count = hint[:perfect]
  	imperfect_count = hint[:imperfect]

  	new_numbers(4 - perfect_count)
  	swap_numbers(4 - imperfect_count)
  	@new_guess
  end
  

  def swap_numbers(count)
  	(0..count).each do
  	  index1 = 0
  	  index2 = 0
  	   while index1 == index2 && @new_guess[index1] != @new_guess[index2] do 
  	     index1 = rand(0..3)
  	 	 index2 = rand(0..3)
  	   end

  	@new_guess.swap!(index1, index2)
  	end
  end

  def new_numbers(count)
  	used_indexes = []
  	(0..count).each do
  	  if used_indexes.length < count
	    new_index = rand(0..3)
	    while used_indexes.include? new_index
	  	  new_index = rand(0..3)
	    end
	    used_indexes << new_index
	   @new_guess[new_index] = rand(1..6)
	  end
  	end
  	@new_guess
  end
end