class Board
  attr_reader :current_guess, :state
  def initialize
  	@state = "Guess History:\n"
  	@current_guess = []
  end

  def place_guess(code)
    @current_guess = code

    code.each do |n|
      @state +=  "#{n} "
    end
  end

  def place_hint(hint)
  	  @state += "Perfect: #{hint[:perfect]}, Imperfect: #{hint[:imperfect]}\n"
  end
end