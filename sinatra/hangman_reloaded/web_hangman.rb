require 'sinatra'
#require 'sinatra/reloader' if development?
require_relative 'lib/hangman.rb'

enable :sessions

before  do 
	session[:game] = Hangman.new('lib/5desk.txt') if session[:game].nil?
	session[:turns].nil? ? session[:turns] = 0 : session[:turns] += 1
end

max_turns = 10

get '/' do
	lost ||= true if max_turns == session[:turns]
	game = session[:game]
	turns_left = max_turns - session[:turns]
	puts game.word
	hint = game.hint
	incorrect_letters = game.incorrect
	guess = params['guess']

	if session[:turns] > 0
		legal_guess?(game, guess) ? game.make_guess(guess) : error = "Please try again"
	end

	victory ||= true if game.game_over?
	erb :index, :locals => {:hint => hint, :incorrect_letters => incorrect_letters, 
													:victory => victory, :error => error, :turns_left => turns_left,
													:lost=> lost}
end

post '/new_game' do 
	session[:game] = nil
	session[:turns] = nil
	redirect to('/')
end

def legal_guess?(game, guess)
	if guess.nil?
		false	
	elsif game.incorrect.include?(guess) || game.correct.include?(guess)
		false
	elsif guess !~ /[a-zA-Z]/
		false
	else
		true
	end
end