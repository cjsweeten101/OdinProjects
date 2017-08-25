require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/caesar_cipher.rb'

get '/' do
	result = ''
	phrase = params['phrase']
	shift = params['shift'].to_i
	if !shift.nil? && !phrase.nil?
		params['submit'] == "Encode" ? result = cipher(phrase, shift) : result = cipher(phrase, -1*shift) 
	end
	erb :index, :locals => {:result => result}
end