class Hangman
	attr_reader :word, :hint, :correct, :incorrect 
  
  def initialize(file, shortest_word=5, longest_word=12)
  	@dictionary = read_dictionary(file, shortest_word, longest_word)
  	@word = choose_word.strip.downcase
  	@hint = ''.rjust(@word.length, '-')
  	@correct = []
  	@incorrect = []
  end

  def read_dictionary(file, shortest_word, longest_word)
  	File.readlines(file).select {|word| word.strip.length.between?(shortest_word-1,longest_word)}
  end

  def choose_word
  	word = @dictionary[rand(0..@dictionary.length)]
  	@dictionary = ''
  	word
  end

  def game_over?
  	@hint == @word
  end

  def make_guess(letter)
  	if @word.split('').include? letter
  		@correct << letter
  	else
  		@incorrect << letter
  	end
  	change_hint
  end

  def change_hint
  	@word.split('').each_with_index do |letter, i|
  	  @hint[i] = letter if @correct.include? letter
  	end
  end
end