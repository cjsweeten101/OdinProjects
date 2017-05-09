def picker prices_arr
	max_profit = 0
	best_days = []
	prices_arr.each_with_index do |price, index|
		profit, sell_price = max_profit(price, prices_arr[index..-1])
		if profit > max_profit
			max_profit = profit
			best_days = [prices_arr.find_index(price), prices_arr.find_index(sell_price)]
		end
	end
	return best_days
end

def max_profit day, prices_arr
	max_profit = 0
	sell_price = 0
	prices_arr.each do |price|
		current_proffit = price - day
		if current_proffit > max_profit
			max_profit = current_proffit
			sell_price = price
		end
	end
	return max_profit, sell_price
end

puts picker([17,3,6,9,15,8,6,1])