def cipher phrase, shift
	result = ''
	words = phrase.split(' ')
	words.each do |word|
		cipher_word = ''
		letters = word.split('')
		letters.each do |letter|
			cipher_word += shift(letter, shift)
		end
		result += ' ' + cipher_word
	end
	result.strip
end

def shift letter, shift
	new_letter = ''
	caps_range = ('A'.ord..'Z'.ord)
	lowers_range = ('a'.ord..'z'.ord) 
	ord_letter = letter.ord
	if caps_range.include?(ord_letter)
		new_ord = ord_letter+shift
		if !caps_range.include?(new_ord)
			new_ord = new_ord - 'Z'.ord + 'A'.ord - 1
		end
		new_letter = new_ord.chr
	elsif lowers_range.include?(ord_letter)
		new_ord = ord_letter+shift
		if !lowers_range.include?(new_ord)
			new_ord = new_ord - 'z'.ord + 'a'.ord - 1
		end
		new_letter = new_ord.chr
	else
		new_letter = letter 
	end
	new_letter
end

puts cipher("I aM a StRiNgZ!", 1)