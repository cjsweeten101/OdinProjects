class Player
	attr_reader :code
  def initialize
  	@code = []
  end

  def guess
  	@code = prompt_code
  end

  def prompt_code
  	input = ''
  	result = []
  	until result.all? {|n| n.is_a? Integer} && result.length == 4 && result.all? {|n| n > 0 && n <=6 }
  	  print "Code:"
  	  result = gets.chomp
	  exit if result == 'q'

	  result = result.split(',')
  	  result.map! {|n| n.to_i}
  	end
  	result
  end

  def check_guess(guess)
  	hint = {
  		perfect:  0,
  		imperfect:  0
  	}

  	guess.each_with_index do |n,i|
  	  if @code[i] == n
  		hint[:perfect] += 1 
  	  elsif @code.include?(n)
  		hint[:imperfect] += 1
  	  end
  	end
  	hint
  end
end