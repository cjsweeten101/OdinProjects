require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/hangman.rb'


get '/' do 
	current_game = Hangman.new("lib/5desk.txt")
	word = current_game.word
	erb :index, :locals => {:word => word}
end