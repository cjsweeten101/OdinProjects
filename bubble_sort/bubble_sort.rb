def bubble_sort(arr)
	switch = 1
	while switch != 0
		switch, arr = one_pass_sort(arr)
	end
	arr 
end

def one_pass_sort(arr)
	switch_count = 0
	arr.each_with_index do |item, idx|
		next_item = arr[idx+1]
		if next_item.nil?
			break
		end
		if item > next_item
			arr[idx] = next_item
			arr[idx+1] = item
			switch_count += 1
		end
	end
	return switch_count, arr
end

def bubble_sort_by(arr)
	arr.each_with_index do |item, idx|
		next_item = arr[idx+1]
		if next_item.nil?
			break
		end
		block_result = yield(item, next_item)
		if block_result > 0
			arr[idx] = next_item
			arr[idx+1] = item
		end
	end
	arr
end


result =  bubble_sort_by(["hi","hello","hey"]) do |left,right|
    		left.length - right.length
    	end

puts result

puts bubble_sort([4,3,78,2,0,2])