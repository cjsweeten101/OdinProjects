def merge_sort(arr)
	return arr if arr.length < 2
	split_1 = merge_sort(arr[0..arr.length/2-1])
	split_2 = merge_sort(arr[arr.length/2..arr.length])
	merge(split_1, split_2)
end

def merge(arr1, arr2)
  result = []
  	until arr2.length < 1 || arr1.length < 1 do
  	  if arr1.first < arr2.first
  		result << arr1.first
  		arr1.shift
  	  else
  		result << arr2.first
  		arr2.shift
  	  end
  end
  result << arr1 unless arr1.length < 1
  result << arr2 unless arr2.length < 1
  result.flatten
end