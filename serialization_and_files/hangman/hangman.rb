class Hangman
	attr_reader :word
  
  def initialize(file, shortest_word=5, longest_word=12)
  	@dictionary = read_dictionary(file, shortest_word, longest_word)
  	@word = choose_word
  end

  def game_loop
  end

  def read_dictionary(file, shortest_word, longest_word)
  	File.readlines(file).select {|word| word.strip.length.between?(shortest_word-1,longest_word)}
  end

  def choose_word
  	@dictionary[rand(0..@dictionary.length)]
  end

end