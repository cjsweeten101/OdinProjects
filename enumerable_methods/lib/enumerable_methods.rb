module Enumerable
  def my_each
  	i = 0 
  	while i < self.length do 
  	  yield(self[i])
  	  i += 1
  	end
  	self
  end

  def my_each_with_index 
  	i = 0 
  	while i < self.length do 
  	  yield(self[i], i)
  	  i += 1
  	end
  	self
  end

  def my_select 
  	result = []
  	self.my_each do |v| 
  	  result << v if (yield v)
  	end
  	result
  end

  def my_all?
  	result = true
  	if block_given?
  	  self.my_each do |v|
  	    result = false if !(yield v)
  	  end
  	else
  	  self.my_each do |v|
  	  	result = false if !v
  	  end
  	end
  	result
  end

  def my_any?
    
  end
end