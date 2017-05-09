def substrings phrase, dictionary
	result_hash = {}
	phrase_arr = phrase.split(' ')
	phrase_arr.each do |word|
		clean_word = word.downcase.gsub(/\W/,'')
		dictionary.each do |item|
			if clean_word.include?(item)
				if result_hash.key?(item)
					result_hash[item] += 1
				else
					result_hash[item] = 1
				end
			end
		end
	end 
	return result_hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)